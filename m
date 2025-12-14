Return-Path: <linux-pci+bounces-43024-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C78BCBBEDB
	for <lists+linux-pci@lfdr.de>; Sun, 14 Dec 2025 19:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5A6E30054BA
	for <lists+linux-pci@lfdr.de>; Sun, 14 Dec 2025 18:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C43156CA;
	Sun, 14 Dec 2025 18:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/aJ2ynk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC41F513
	for <linux-pci@vger.kernel.org>; Sun, 14 Dec 2025 18:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765737375; cv=none; b=eYLPwzNe9BQH+fYtaH5T4BjYc4xToK4iBVxFeqXLMaVfD+XUyTRKYzMom6BtzIdNaiyg2KNjDbFWXht70tVmgBE+XNyndtTxgVhfu/LtA2dWjvui+0OxHwF3hcak1m/N3RLqtRw4XeJxdo+eSfoaOfAw1wdvpF9USqy8n598GgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765737375; c=relaxed/simple;
	bh=mnr4dkhbpZMbKpNu5iYCQzJCxuvHuB2oCHTSPewC4s4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nk5cVCF5EGmk+hxMLuctyfYNQnBBCw2vJv8S2QqFdhgahgqG4nEgQ6Fz69X2B/iH8R7DWK/bLU2JD1Q0DQ9QnzMJJlhjZ2cLfgOpRvmeOJ20zl+1wDF9eIJonyW0M0clsxOtoGOaF4FHWIojGaJzAM6Oy4+1l2qRyq1VMMe5wQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/aJ2ynk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE836C4CEF1;
	Sun, 14 Dec 2025 18:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765737372;
	bh=mnr4dkhbpZMbKpNu5iYCQzJCxuvHuB2oCHTSPewC4s4=;
	h=From:To:Cc:Subject:Date:From;
	b=V/aJ2ynke4m4cZSAnEx0lWom1xsilp/mQo0TZOUGKr2/O7oddRyUeQnh9uglz4xWf
	 OVkCJUi0FrNxoMn0Wv4/uYy6fB4p22pyNfPxsKVI6Uzx1CPS//20L7axkwdzT1ZcPg
	 Itg55ajTbPvdQyDUlTGUiHnnTNpq/Z/+6bBibMFMZOYdG/OfnagRz/7bD2u2RsvNmn
	 7yWXVNX/hdCz/flNXcptdxrnAstrxPq9FKxDiJ2Fa+/yQN59IZL8VdRlnmSV8qQLwj
	 /5Wlxk5rtlI2jwyX8HBvpDMmdRlVZ43p4X77q5FZysKTd1LTW7FJyc7eYRfqOmWYWK
	 jnUhcQoyk42Bw==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: mario.limonciello@amd.com,
	bhelgaas@google.com,
	superm1@kernel.org,
	tzimmermann@suse.de
Cc: Aaron Erhardt <aer@tuxedocomputers.com>,
	"Luke D . Jones" <luke@ljones.dev>,
	linux-pci@vger.kernel.org
Subject: [PATCH v2] PCI/VGA: Don't assume the only VGA device on a system is `boot_vga`
Date: Sun, 14 Dec 2025 12:35:26 -0600
Message-ID: <20251214183602.150412-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some systems ship with multiple display class devices but not all
of them are VGA devices. If the "only" VGA device on the system is not
used for displaying the image on the screen marking it as `boot_vga`
because nothing was found is totally wrong.

This behavior actually leads to mistakes of the wrong device being
advertised to userspace and then userspace can make incorrect decisions.

As there is an accurate `boot_display` sysfs file stop lying about
`boot_vga` by assuming if nothing is found it's the right device.

Reported-by: Aaron Erhardt <aer@tuxedocomputers.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220712
Tested-by: Aaron Erhardt <aer@tuxedocomputers.com>
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: ad90860bd10ee ("fbcon: Use screen info to find primary device")
Tested-by: Luke D. Jones <luke@ljones.dev>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
v2:
 * Add tags
 * Rebase on v6.19-rc1
 * v1: https://lore.kernel.org/linux-pci/20251029185940.2499129-1-superm1@kernel.org/
---
 drivers/pci/vgaarb.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index 436fa7f4c3873..baa242b140993 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -652,13 +652,6 @@ static bool vga_is_boot_device(struct vga_device *vgadev)
 		return true;
 	}
 
-	/*
-	 * Vgadev has neither IO nor MEM enabled.  If we haven't found any
-	 * other VGA devices, it is the best candidate so far.
-	 */
-	if (!boot_vga)
-		return true;
-
 	return false;
 }
 
-- 
2.43.0


