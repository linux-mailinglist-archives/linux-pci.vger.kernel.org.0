Return-Path: <linux-pci+bounces-13855-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B10B990DC5
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 21:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53EE428739C
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 19:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3E8212634;
	Fri,  4 Oct 2024 18:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUjijG5X"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6C5212630;
	Fri,  4 Oct 2024 18:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066480; cv=none; b=E0bCeCz3MuSJShomZlR/IJwJ0v1KE/3l3JLtTFTvEFTcrEIpOR0vOHQX04BnSXijuOG6ZhDlCXYEvmrWMknW0hvaqsePiZXcFC+HfQnL+7xOVSvLgjYybGXO3MUXaGpI6FIEBStkLcu6ipMtCu81qcuapBgpL1ZXhCdkNRi6BHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066480; c=relaxed/simple;
	bh=rV+EmJf9DS9RZJGdGgdAczfirivS4bc7E4GvARfWjfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oE3JrovTq8ny4Fd5IVrcSUmoNg4o+ny/z+taWAJQ9mbc6kCFfn6NRv+S1t5li6PtHMX7yT5T8LoNATLj8ieWGnqYjQ2hunHso6X9SrqOLT23FmtaaORl3OYklaQbWglUOVq71WK9TIxW/etpyzCOnv1v7M2HU3LTsNN9LaXYGzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUjijG5X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBCAEC4CECC;
	Fri,  4 Oct 2024 18:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066480;
	bh=rV+EmJf9DS9RZJGdGgdAczfirivS4bc7E4GvARfWjfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gUjijG5Xk2ZXCcUpnTbwwid3Wi2gj+OXzuIe6qeOoULFNCOzs+KNv6UR+oyOLsRQu
	 OaLsCOwynXQmvjx3CaZH6F8fwE42YUAWm7iN8hpMAQYhZ4IPVDw1r5o6K2rzlpZPlW
	 A7nT3vTKcGOpVbRmrv6WKScYLEyGiQGn7VpqfwrmjYyMoeIAqv8qwiSFZldzUpd4YC
	 k6fmZWpecySl79xQQXRgTPdguxms8+OwrEtS34/AgWN7VxiltM5WXG0lFTPeWM5fQn
	 Zdb2BLAyfw+D0jopfKcOtFYMHuvxJywMbjC/7ZzDmOqN9umR+VMmoeBRQQFuscjWIv
	 aFI5oAa45sZAg==
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
Subject: [PATCH AUTOSEL 6.1 23/42] ntb: ntb_hw_switchtec: Fix use after free vulnerability in switchtec_ntb_remove due to race condition
Date: Fri,  4 Oct 2024 14:26:34 -0400
Message-ID: <20241004182718.3673735-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182718.3673735-1-sashal@kernel.org>
References: <20241004182718.3673735-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.112
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
index 88ae18b0efa8d..7ce65a00db56b 100644
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


