Return-Path: <linux-pci+bounces-13838-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10318990B5B
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 20:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0F6D282D7C
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 18:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD731ADFFD;
	Fri,  4 Oct 2024 18:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tWz4oqBw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F4C1ADFF8;
	Fri,  4 Oct 2024 18:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065967; cv=none; b=tfGhkLa3bNhLPKiJYk/l0cKn3E+eAZ8x3d6s8mOuRKGk6kGTqeRcyXax2018UZxn0GiW8uGxHoA55ZVkLJLaxE+Rks/vTB/q9/UKe060eErOnSGwsRo0H6n8nK3zvyUXxbp/JmDobA6gD1B+HlSH01C9CTUMl+FQ2TqleUFCHbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065967; c=relaxed/simple;
	bh=xczGj8LAk1ZXCAUD6H5JCP/mF914IU5/eMqAFX5PpOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=btOic+6JnlT/z5SS/GnxA3On/LAdC4BzD5CmFvbpwClmo3PXPqFGW00VdUctO/c6XsaO4GDxkWGrMqBS/E35lLXwvhdP69sX9J+uqvL0tHzG1m5Tl7e1sb/Mz9+L4/YNbvpPrO5tAvtQ+z6MnJQDhigkv1gAVDnUsOutruAiDKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tWz4oqBw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90BBDC4CECE;
	Fri,  4 Oct 2024 18:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728065966;
	bh=xczGj8LAk1ZXCAUD6H5JCP/mF914IU5/eMqAFX5PpOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tWz4oqBw3CjJQBekmez16IiqG3NrWJtLgaiDo9iKcrV3zL8hPp3asaZbS8obcbh5F
	 +HTOy5/bJU5IMlZihMYbbf4Zq15sXhOfylVpRgzgUCRg4IQTJJyX6t9F19MzM6p/WV
	 IRuju1DiK6joYYcJuZ+hQR9lPF+nNu3pVjjROhBKsrPzkxrtqRc63vgpgWMb+mYiI+
	 WJ9STM+XksHcj8ZlaKj/PRoYsLTgqs+QtKIa4Nsp4EuABaFTbA0xRb4yTNhBII6Ta9
	 x4TA1JJhcQ4gVSFcH9jQmUWWHswYVrXPgjEu8uS7sOxdjjNNRDXp4+8Ca/0dDGC5uI
	 mQTUb2rEWBx0A==
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
Subject: [PATCH AUTOSEL 6.11 33/76] ntb: ntb_hw_switchtec: Fix use after free vulnerability in switchtec_ntb_remove due to race condition
Date: Fri,  4 Oct 2024 14:16:50 -0400
Message-ID: <20241004181828.3669209-33-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004181828.3669209-1-sashal@kernel.org>
References: <20241004181828.3669209-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.2
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
index 31946387badf0..ad1786be2554b 100644
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


