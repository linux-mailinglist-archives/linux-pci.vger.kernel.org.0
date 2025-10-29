Return-Path: <linux-pci+bounces-39720-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 340BFC1CDBE
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 20:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FBCC1A21EC3
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 19:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3D0357A47;
	Wed, 29 Oct 2025 18:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTvSWYP/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B705B19A288
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 18:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761764389; cv=none; b=mKQxgGXmf5xMD6lHXWXEXDEEyB6q9mnbwJh+IA75fbSaGrOBtxcFPJr8GbqxhaX4rK/JUvt1pwASVi+hjjgpCZ+F/5ywzsj8qAgD+6CYbVAOWTHogRWz/XraDiNSDgUKbuzdOL9CilIrTiB40IOSKzVRJo7P21OjdplzPw62XlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761764389; c=relaxed/simple;
	bh=g4sZS8ASR2a2506904Nfo76ybbo7yBC5yFIB2MtHpRo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NqffyMd9Lt8pJXCIm6ZHTfxNDPBsSrod4D7LTKoXTpnTxZ2MQS9vxEPOgAP23V0O1/E2VICn1sXSJp9Ny6UIl+8/CVnEbFS31C0WwInHQVCQGm6JLIdgb0BEUPcMhlP5PHT7pN6TqaBx2Lr8oyTvijc5W/fx25vve86zjmMenvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTvSWYP/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8BCC4CEF7;
	Wed, 29 Oct 2025 18:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761764389;
	bh=g4sZS8ASR2a2506904Nfo76ybbo7yBC5yFIB2MtHpRo=;
	h=From:To:Cc:Subject:Date:From;
	b=XTvSWYP/muoRrKNTteerJHaJgbKaTZB8wJj+8yimYPQwV6jDfoMQl3yomeqt9pKEh
	 ZwyRrVyVGaQ10LIrf4Keo0QIKWHb1LnDSoNGPQfUlkoOnWOJ4tg4w77vYE3fDSgDhv
	 ihWc5RqLWgihyfzIBJOof0mj0VGJLMaw3fnP9PXEhmAahGUDZbO0Qtl1S/ne3tbWxi
	 ORY0SX9ADKhmkDWxltXtiFsIm6xGrc9HpJ3wIzfkLGYHTy6yNtXVLfTbcWvuK2XT0C
	 ufmdORo/64IpSYfj2VCLoiyU0uKhCwbbgxIpVKZQwVmFXcnWSmy9XruEfN6gKIcLP3
	 6EPCaH+PrD4Pw==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: mario.limonciello@amd.com,
	bhelgaas@google.com
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>,
	Aaron Erhardt <aer@tuxedocomputers.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH] PCI/VGA: Don't assume the only VGA device on a system is `boot_vga`
Date: Wed, 29 Oct 2025 13:59:33 -0500
Message-ID: <20251029185940.2499129-1-superm1@kernel.org>
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
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
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


