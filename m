Return-Path: <linux-pci+bounces-13863-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1C1990E9E
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 21:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9287028109A
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 19:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A86D228B27;
	Fri,  4 Oct 2024 18:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oqpf81/0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F446228B23;
	Fri,  4 Oct 2024 18:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066638; cv=none; b=M0mTn0J6vz4f2T3R5+dR4V6mbT4ZhYHjjrxUOlMrGVmM35VSusPM3kUtzbMOUnqeZkdFvKIJUi8honuUkgNW5SthOXNADf+VbHavt36rvrRw7af9iVLECDd/YaPr5zmk6oWxY5hKPBxOjkRwKeZqwMU9v2Xgj+g1hLv/o0lSUp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066638; c=relaxed/simple;
	bh=IoiKVtKpLwjUIwn3kU48+A7z58Di4HgMpWqRhItVb+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kqb1yV8TJ2L1tt98JuinhuTU8P8BDHcExv/oQ7CNjx+tEG7VNLlbIqlf5/la1XmOyhbhkqsbmuf2aZkIWgk7hnKOVoZlihDNDZR4jlonuXUzzPI2S/u5J3b5tZiHTTFZq1pXWRE9tmwQKfjsJvXtKVouA0h7KTNEq74P5AXQzPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oqpf81/0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB5FC4CED0;
	Fri,  4 Oct 2024 18:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066638;
	bh=IoiKVtKpLwjUIwn3kU48+A7z58Di4HgMpWqRhItVb+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oqpf81/0A6UJajHGKbT5ZNtFQ2hoK9pFimh67ywV5/1LUma9WLp+k+s3hMVmG5Rzb
	 eb+NrYnaRyGvyk+5NqvPzZ1L+aUYHhwqWDJIEIv7itjceCodY7ysk2eInfnk/4dE3L
	 bQ7s/JWMcZsFwaYzLKDv+40RJM4AB/cwSoM7Rd9Lf+kRvRSCo7Dfr1OZrLNFfTPQT5
	 H3a5kL9r6SZWRGAm8C69PiK/ZQPxSU8PHcrlYPtNVN/Za5yhZ5StC33Vs88RS9Wwvz
	 z/W7mtzGz2MglIySVeJevOiczi83UUFqQtQOvZO3DqGLtWKLgvv7jjuKDouNZHoNq1
	 mEkXtIltmVuzg==
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
Subject: [PATCH AUTOSEL 5.10 17/26] ntb: ntb_hw_switchtec: Fix use after free vulnerability in switchtec_ntb_remove due to race condition
Date: Fri,  4 Oct 2024 14:29:43 -0400
Message-ID: <20241004183005.3675332-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004183005.3675332-1-sashal@kernel.org>
References: <20241004183005.3675332-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.226
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
index 4c6eb61a6ac62..ad09946100b56 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -1558,6 +1558,7 @@ static void switchtec_ntb_remove(struct device *dev,
 	switchtec_ntb_deinit_db_msg_irq(sndev);
 	switchtec_ntb_deinit_shared_mw(sndev);
 	switchtec_ntb_deinit_crosslink(sndev);
+	cancel_work_sync(&sndev->check_link_status_work);
 	kfree(sndev);
 	dev_info(dev, "ntb device unregistered\n");
 }
-- 
2.43.0


