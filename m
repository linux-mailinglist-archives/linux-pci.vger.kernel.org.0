Return-Path: <linux-pci+bounces-13859-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BA0990E3C
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 21:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 840C92845C6
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 19:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F971DE3C9;
	Fri,  4 Oct 2024 18:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEjcqE1M"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8561DE3BF;
	Fri,  4 Oct 2024 18:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066571; cv=none; b=I2PtT+j5VZDpt45xV3pE22TXYF2CTKC5mJ8jdcl52+I0oasBW8X6RIVRb60Gqy0YbX66uVN2t2gGaFbDEBv6b4cOC+OaqyoQ6lPsD27i0V/Dq5eQpeb8m8XYsMckAonc4kYFCzHChTksY3F7pOIuAYdEfOuvbUcjT7ODKQTMEMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066571; c=relaxed/simple;
	bh=2LtfAKH0dDbBh2ZgnhNv/xXfHcrgEhxInqY8B59SDhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n4sjlBajeV6befg3A2abi0wPLZsRoWkvwUKHVPm6YrJqVfQg7R0HGujFJBD9F+sZKDYSwx4Vx0wPLzjmreMft3Rv0ZKPLNwqy1AeRuRUfCyIGSRDKqAdUCxjUtinrfLGHz+sCFp5r1AxbChTPDmeM5K0apMqGe8KAh0KANwYKyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEjcqE1M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5775C4CECD;
	Fri,  4 Oct 2024 18:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066571;
	bh=2LtfAKH0dDbBh2ZgnhNv/xXfHcrgEhxInqY8B59SDhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DEjcqE1M75T1emlF/l3gHUKmkiEYr6mjQk07FfzfVHNQzk0lEvhQF56CRhx8/5dwF
	 H7Hb0pV0Z5C/+U1wYj5n5KYyP7hbVa2gSYk/djQNb8xrG3Ds7VWHv+uD5Uk9ehdn3Q
	 D5Em0NcxoxwzS5GubnRiyM6IOQAbuJuPs+0ZdQd5wDx3nBr2Z5iOzDVstW/YJIbah1
	 sgFy1fMR9PYDbxmwoBSF28GUo/idNREgwkGaqEbhUxs9UxytEqZhnkSoyIJxsIauvP
	 jiGr6tOe4+5zITTeVS79rADbraSTI+UuxrCH/DWNRMaFbRbrbm1Jw4egd2As6qkG1B
	 GRVD+ClN+Ak0g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kaixin Wang <kxwang23@m.fudan.edu.cn>,
	Logan Gunthorpe <logang@deltatee.com>,
	Jon Mason <jdmason@kudzu.us>,
	Sasha Levin <sashal@kernel.org>,
	kurt.schwemmer@microsemi.com,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	linux-pci@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 20/31] ntb: ntb_hw_switchtec: Fix use after free vulnerability in switchtec_ntb_remove due to race condition
Date: Fri,  4 Oct 2024 14:28:28 -0400
Message-ID: <20241004182854.3674661-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182854.3674661-1-sashal@kernel.org>
References: <20241004182854.3674661-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.167
Content-Transfer-Encoding: 8bit

From: Kaixin Wang <kxwang23@m.fudan.edu.cn>

[ Upstream commit e51aded92d42784313ba16c12f4f88cc4f973bbb ]

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
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index ec9cb6c81edae..759248415b5c2 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -1556,6 +1556,7 @@ static void switchtec_ntb_remove(struct device *dev,
 	switchtec_ntb_deinit_db_msg_irq(sndev);
 	switchtec_ntb_deinit_shared_mw(sndev);
 	switchtec_ntb_deinit_crosslink(sndev);
+	cancel_work_sync(&sndev->check_link_status_work);
 	kfree(sndev);
 	dev_info(dev, "ntb device unregistered\n");
 }
-- 
2.43.0


