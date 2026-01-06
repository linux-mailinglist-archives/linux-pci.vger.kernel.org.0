Return-Path: <linux-pci+bounces-44080-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E93EECF6B00
	for <lists+linux-pci@lfdr.de>; Tue, 06 Jan 2026 05:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0FD8302E071
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jan 2026 04:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D90275B15;
	Tue,  6 Jan 2026 04:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7UGpNKv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0E11DA55
	for <linux-pci@vger.kernel.org>; Tue,  6 Jan 2026 04:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767674837; cv=none; b=I4uK6+4iuDpEm+sr/yK7RjHclQ0j4Fzkkq8c0VZReNjvqzY2xoiy6IHFOehO6k0BcUkgjSPHUCGuEKS6VcHCdIVxoIIRDdB3V21oDtNGjyqQ326RtVeo0rZdQz0o6LfAjKu23L26AKIjkwyXhDoeq5zpH4HKqvIbwu3RPCNi3Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767674837; c=relaxed/simple;
	bh=WSGw182YnbraoeH/1fIX+u8DCAUmBd49J36SbqssRYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a3VXfk9V9xqIeno5bkf86Wsi1q0yGJS3S5upEb5fK5guVuqA9/pelSqtwGcrsjK+N1gU6yjuY33smvDVAlb6fnjRWgGxFNWlgSFP5zk0M060dGF4L4g4eKf/msePLJQuN7uazmNx8q2eaBFevdqZIcwgnen4iebRUG+6ge1OmKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7UGpNKv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7EF6C116C6;
	Tue,  6 Jan 2026 04:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767674836;
	bh=WSGw182YnbraoeH/1fIX+u8DCAUmBd49J36SbqssRYE=;
	h=From:To:Cc:Subject:Date:From;
	b=g7UGpNKvTnrb0ZMey/l+a5VuZbN3uaXuMcggVOJd6wW4rB0Z3G49VKevm4Ntx36if
	 krNAl5S82H48O6Vhbzxd7BDcsYsDNyGW3ihMmjpxPFpoTYHZq5iBPhtov0TD86TMSY
	 Md78AVno3Ussf1n2Z8YUbCSd9E1uybpDOqj+dTBBUu2INvpa8Z7+DtW7IY9oLti5ej
	 igE9ZiBjfwi7RiySI+Ynw+0KCUdZ2fyCiYbb5AtBgegyakgr2BAbj7GJW39CrnPfsw
	 tg4KlKR/8CG+qDQXhVuVF/+A6GxOsphHGE4sUMT7RRMsAgaE6UWL4Bt+agUoqG7uva
	 uBs4zOTXx2rFQ==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM)
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>,
	Aaron Erhardt <aer@tuxedocomputers.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	"Luke D . Jones" <luke@ljones.dev>
Subject: [PATCH v2 RESEND] PCI/VGA: Don't assume the only VGA device on a system is `boot_vga`
Date: Mon,  5 Jan 2026 22:46:38 -0600
Message-ID: <20260106044638.52906-1-superm1@kernel.org>
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
This was probably lost in the holiday shuffle, so resend it.
v2: https://lore.kernel.org/linux-pci/20251214183602.150412-1-superm1@kernel.org/
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


