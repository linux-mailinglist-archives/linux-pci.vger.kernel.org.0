Return-Path: <linux-pci+bounces-12961-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC7F972056
	for <lists+linux-pci@lfdr.de>; Mon,  9 Sep 2024 19:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D11A2834F5
	for <lists+linux-pci@lfdr.de>; Mon,  9 Sep 2024 17:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060F616DC12;
	Mon,  9 Sep 2024 17:22:09 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.197.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8830116BE0D;
	Mon,  9 Sep 2024 17:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.154.197.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902528; cv=none; b=JIT6azr6NH7A5c8Kwigv+tqnlqx/vEQFkYyBhSCedG/z9zwFknv0BCmffjDcNfp/36unNz9jf2xjqjSf0eUeZavTc64Np92r71Z9jvMq13vztKHKIMNiNq+OLdXgQONVb1LzPLoDgpxhJ5KyiixfSk2Fo2KndEdR8TapY/mZBSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902528; c=relaxed/simple;
	bh=DzTpytYGvgdN0PHH7Y9LUIfnfmObdHK1eIzDaF1+Mk0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e5WRXIgxgcJbYOitfPcKN+8AKWNmP+WMW9BjinA15hKYvBkrNh0MNoTLfbQjWDlbn8ehoHoul1+akX3py2RDkOI1/uy4HDdyvD/Al82Fzr80d4FlJpsROu0L9NPBFKuifQiC/hLs6AWGU5L9xzaQphDxQiG6SMTdWL7wtDqtDJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; arc=none smtp.client-ip=43.154.197.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
X-QQ-mid: bizesmtpsz3t1725902448twab10l
X-QQ-Originating-IP: +5iLoBII1Ivhz94e4UdgQWic1w1egFqCbuPe+rQNgVM=
Received: from localhost.localdomain ( [183.193.124.18])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 10 Sep 2024 01:20:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16883648514648128508
From: Kaixin Wang <kxwang23@m.fudan.edu.cn>
To: logang@deltatee.com
Cc: 21302010073@m.fudan.edu.cn,
	21210240012@m.fudan.edu.cn,
	dave.jiang@intel.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kurt.schwemmer@microsemi.com,
	bhelgaas@google.com,
	Kaixin Wang <kxwang23@m.fudan.edu.cn>
Subject: [PATCH] ntb: ntb_hw_switchtec: Fix use after free vulnerability in switchtec_ntb_remove due to race condition
Date: Tue, 10 Sep 2024 01:20:07 +0800
Message-Id: <20240909172007.1863-1-kxwang23@m.fudan.edu.cn>
X-Mailer: git-send-email 2.39.1.windows.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:m.fudan.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0

In the switchtec_ntb_add function, it can call switchtec_ntb_init_sndev
function, then &sndev->check_link_status_work is bound with
check_link_status_work. switchtec_ntb_link_notification may be called
to start the work.

If we remove the module which will call switchtec_ntb_remove to make
cleanup, it will free sndev through kfree(sndev), while the work
mentioned above will be used. The sequence of operations that may lead
to a UAF bug is as follows:

CPU0                                 CPU1

                        | check_link_status_work
switchtec_ntb_remove    |
kfree(sndev);           |
                        | if (sndev->link_force_down)
                        | // use sndev

Fix it by ensuring that the work is canceled before proceeding with
the cleanup in switchtec_ntb_remove.

Signed-off-by: Kaixin Wang <kxwang23@m.fudan.edu.cn>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index 31946387badf..ad1786be2554 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -1554,6 +1554,7 @@ static void switchtec_ntb_remove(struct device *dev)
 	switchtec_ntb_deinit_db_msg_irq(sndev);
 	switchtec_ntb_deinit_shared_mw(sndev);
 	switchtec_ntb_deinit_crosslink(sndev);
+	cancel_work_sync(&sndev->check_link_status_work);
 	kfree(sndev);
 	dev_info(dev, "ntb device unregistered\n");
 }
-- 
2.39.1.windows.1


