Return-Path: <linux-pci+bounces-25339-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94349A7CD65
	for <lists+linux-pci@lfdr.de>; Sun,  6 Apr 2025 11:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 425013A8F66
	for <lists+linux-pci@lfdr.de>; Sun,  6 Apr 2025 09:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E5F14B08C;
	Sun,  6 Apr 2025 09:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JliAhiMl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D126319D07C;
	Sun,  6 Apr 2025 09:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743930537; cv=none; b=so5YIa9TlkvcdcJJIA7Z9NrhHFBx3UoYzhY65LaRGuPOJiEBX2g553WYMxXFDZTLb0sGRGxgNMXtXF9msn8acLnkKMrRLfwOjbWptrcZRViYiqepf9rPUSEN3l4PaMKHjana3Taq25MECDNpZw6ig3lVhlxYr9ffATmRjly88m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743930537; c=relaxed/simple;
	bh=SzoCK8uTEbEoC4J8gPsTOWxyFf85tq5CnyJPJwV2p/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cz0Z+IEtkcT7nT7zKxIEQ3OgcesvRzbdu4K+8FNVBiSRAdunn/1ceno/A+t2SWeqQkWmV8md7/b3jJCLzkQJz1UBFCjAbaRQJArMALpXXpgUeH4lrjJY9084g4ZxZWXMbcNDderCaKTP1wCDsI8pUv10BFrUiYVJrCYGBnHeJp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JliAhiMl; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-7376dd56eccso3659406b3a.0;
        Sun, 06 Apr 2025 02:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743930535; x=1744535335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4UGKRwJioPxy+lp/bM0MgZCwB2oOxusUsTVwfHCoqAI=;
        b=JliAhiMlfuv3kehlDZRth3pCVgT0Obpyl0HSFfnyC0s+l9QmXLCSyFK8mH6yTuWBdw
         zkyv07kBOFODQ2NcL2CNXD9i7+YHNsoC2Qj2ulvq/KAmCvY/KhFM9uncTwH3BWLI+NJk
         rJTkB8+xGewbORU5Ylfhm+cmsd4IhiEWOL2rgH3A5gAf4edCvqaUf7NfygsqNhv3KEQM
         8lbz5SK7ZHEqIzUDZo1gfosfBgS+DGvslsE0L6lqTPtama4Czw2AXTS/LyvBuE7RXMdZ
         QP+h/2iqcDbtXubqviLyn7C+Lm7i4du/5CPaoH8HQAm4fQSqqYWgjcBqQElq/yqljnNS
         iE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743930535; x=1744535335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4UGKRwJioPxy+lp/bM0MgZCwB2oOxusUsTVwfHCoqAI=;
        b=RFmGol2dTVJNjzqeK/wAE4+HAg/nMjVW+0RqKV4khsLFjEFU6YPR1ZoQvflAgOKv7Z
         ZO06DAj0FlMRsC6NnA5DiG0jB0isM9Bu4m3e3QD+LhKrtTahH6L2EP5fyGS8kEojpZz3
         9dV0HjdfsINLYIoSIqHOlm2hc93XG8ts40UUQO5wCjws+rJSXpQLMzyYakuA3RHdBcyO
         2MqNG6JhiaxIsSzqkdQXGnSj031pDBMQuKuksmlaZe5inlzFB7YYnq3WjWriFX0beqTZ
         GZ8UZOQcYipsokumZuJiY6PFBbnqUxsi5posAK8Qvnctx7B3kYiRbGmvUq3w8DCBgXzH
         xq2A==
X-Forwarded-Encrypted: i=1; AJvYcCUAJ92VtqWLCxtC7F9ZSdfSLU7RMCWzkKk6MBT/JLoQ4mTX82niHMAKC6QzRoGWj9JQLJmQcvLM5+dfN04=@vger.kernel.org, AJvYcCX4256v2HY0M6cDtHdrq99t1l52fzTWA/Juj/NTGjGp0y31nUOG9gs7EogK+MMHQ+44G6mCE0P+7o1P@vger.kernel.org
X-Gm-Message-State: AOJu0YzDyIBlIaYtQndTW3UCfrC3oR/Ln15KbHk32u7GZNV1aOf53SAx
	ZhpERzWr2mUiU0kLtJ8i3Cnc1eG5fbFAE/r83lQZT0dK6MvTZYo=
X-Gm-Gg: ASbGncval1zrxUOOaR1Xyb9Y3b3Eg8AwnVwcHwepY+y2d6bKYFW6iyEE89x3xeLjKcW
	V6R1EzWeKUPGmPKSMpHxZju6nTKvHXHiTW3WEX7aMvzMrRfZnqKSluz+UKKMQp8tXAuDZuugw2o
	tktB5sHHjuNNEuXppPX35uu90fPqIGKrR+1K45ePcPMDN1G66RuZMEtufT+8gbQfiXuKyKS0wgy
	VrcOAljjSa0wwMv138RgkR8kYVC0i7EKoL1aIqAtOS9unTFbFKjZhLv9+ydLTsJG+uR9QRJadwZ
	tgRiZPW5zDvaLejswvTCbr/wwIktS2JnxbAKsXMkXeKBwRnvSELQlq/ukDCWMhQsvFc=
X-Google-Smtp-Source: AGHT+IGx3mo4nQMC3y9JnPjB4iYOcrizjmsZJi15Y+a2ajNjUpR+hn/ORK2/xlZO5qXYUMxj7FK8iQ==
X-Received: by 2002:a05:6a00:4606:b0:736:592e:795f with SMTP id d2e1a72fcca58-739e6ff6b02mr10889859b3a.9.1743930534978;
        Sun, 06 Apr 2025 02:08:54 -0700 (PDT)
Received: from localhost.localdomain ([139.227.17.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d97d1c5asm6396850b3a.2.2025.04.06.02.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 02:08:54 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Tomita Moeko <tomitamoeko@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86/pci: Check signature before assigning shadow ROM
Date: Sun,  6 Apr 2025 17:08:34 +0800
Message-ID: <20250406090835.7721-1-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent IGD platforms without VBIOS or UEFI CSM support do not contain
VGA ROM at 0xC0000. Check whether the VGA ROM region is a valid PCI
option ROM with 0xAA55 signature before assigning the shadow ROM.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 arch/x86/pci/fixup.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index efefeb82ab61..da9fb86c2ea0 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -317,6 +317,7 @@ static void pci_fixup_video(struct pci_dev *pdev)
 	struct pci_bus *bus;
 	u16 config;
 	struct resource *res;
+	void __iomem *rom;
 
 	/* Is VGA routed to us? */
 	bus = pdev->bus;
@@ -338,9 +339,12 @@ static void pci_fixup_video(struct pci_dev *pdev)
 		}
 		bus = bus->parent;
 	}
-	if (!vga_default_device() || pdev == vga_default_device()) {
+
+	rom = ioremap(0xC0000, 0x20000);
+	if (rom && (!vga_default_device() || pdev == vga_default_device())) {
 		pci_read_config_word(pdev, PCI_COMMAND, &config);
-		if (config & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) {
+		if ((config & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) &&
+		    (readw(rom) == 0xAA55)) {
 			res = &pdev->resource[PCI_ROM_RESOURCE];
 
 			pci_disable_rom(pdev);
@@ -354,6 +358,7 @@ static void pci_fixup_video(struct pci_dev *pdev)
 			dev_info(&pdev->dev, "Video device with shadowed ROM at %pR\n",
 				 res);
 		}
+		iounmap(rom);
 	}
 }
 DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_ANY_ID, PCI_ANY_ID,
-- 
2.47.2


