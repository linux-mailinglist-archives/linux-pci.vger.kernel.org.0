Return-Path: <linux-pci+bounces-13851-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B57990D33
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 21:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FDE31C22A9B
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 19:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD3620678C;
	Fri,  4 Oct 2024 18:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/KZPikc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006E6206786;
	Fri,  4 Oct 2024 18:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066357; cv=none; b=Y8j4+r6p1Z9e4xBoxz7MWJ32Pw10cY6XM8yGtDqbepwc0mipcDX0aEN2jmv7h7YykQL3Qna4dlSHcYYaiGCOEdXwB6G2FLsC8zSInV+AoU1vDTmejFgv0bLovlkaE1CjbqRyhbDLG09Y64GfftQzy/xmTEyZWXSUkpTPqQoFHso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066357; c=relaxed/simple;
	bh=7biog2O1wtlDY/U3f/tEE7P320v8j07FtsbL4Do3tIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JXcFSYLG/TGdp7pph9CzY5py45dwmJyruTEePpAjgiT6Nl2Oj3Ga7OmwiOmZsHoO7q+H3jFLunfd7YdTH4UWNJZ+2+FR/UgSw65zv7zoQpvTI3CDMq/HI8Ip3JM59SmS5g3L/3XzhOuFs5bghd8EH72tR1pd6r431ok3bAsk5fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/KZPikc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F984C4CEC6;
	Fri,  4 Oct 2024 18:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066356;
	bh=7biog2O1wtlDY/U3f/tEE7P320v8j07FtsbL4Do3tIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l/KZPikc/SXIKaT5RxNL2laVUEUyvRB9n6dIjjTR3mTc+FU4exPOakOZ+g9Zgj1J1
	 38G37PM/FJobY3NQPwa685fIug0aucMobOlStC+GhiP0svIRPzc8jql3dl+6zjPSnz
	 fJ89s6a/NCwKSV41J6Y80H2rutQFToawpUHmPL3zQoLqlcdU7OguHlb7k1YIhBt5f+
	 yRBBIyNH93G+qpr0iemBt+lkbbB48oWeUB8D0mlYtC7fJgRTF+TP/CUv57mSZOeZS+
	 rfceY8PuWe5vZ6NdAK2XGdWRvI06zAlhQkjoo51SfXGu2NXQH3suJD6c7BvXbOcsFF
	 rEaIKpAYTYcsw==
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
Subject: [PATCH AUTOSEL 6.6 30/58] ntb: ntb_hw_switchtec: Fix use after free vulnerability in switchtec_ntb_remove due to race condition
Date: Fri,  4 Oct 2024 14:24:03 -0400
Message-ID: <20241004182503.3672477-30-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182503.3672477-1-sashal@kernel.org>
References: <20241004182503.3672477-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.54
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
index d6bbcc7b5b90d..0a94c634ddc27 100644
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
2.43.0


