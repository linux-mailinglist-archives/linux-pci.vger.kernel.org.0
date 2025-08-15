Return-Path: <linux-pci+bounces-34112-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9301B283BE
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 18:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 314C15E6256
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 16:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A689E307AF6;
	Fri, 15 Aug 2025 16:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4EkODuO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DE7227B9F;
	Fri, 15 Aug 2025 16:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755274857; cv=none; b=TtuPNMy24RcmFCeRCkgc9JMGH6D1QtlDztYsxRMk4+bcjZa9TyjUeCkuAy7nCJao6zXgifQ4Rjq4eWl6fBEFsFYQcNV+hzkXXYj2IV9+UQGzxvAHYMt04t7RSnNve4Xxvm9hoxVBz0DE7XOu2FRXHi6o2Bi2L8/68Hranipbo5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755274857; c=relaxed/simple;
	bh=Ng3sXb2yfvZl6MY+mAE7exWsp6v6mCBwNyDHnlupf90=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PjYoU0RKzRE2AcFL1MqvWQSFoTJOIHJR+/AYZQCPe5Rn+DWaUR1v8IPNoBzdQJZgBe10vzue7c3TPa6bdUIYOxxXmosfiPL3ldg4GjmDjGmG1NOfeUtKwEAFvDKVT0jtpmq/HnQaWyFo0w+g6AJo2LWZKY5KVt2wTJ/B0rCNXcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4EkODuO; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-76e2e613e90so1640165b3a.0;
        Fri, 15 Aug 2025 09:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755274855; x=1755879655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j5YsQmEiBcbOe3A5Lut4xZB9ClhcGcuY3Y3QfkEhers=;
        b=B4EkODuO803G7zag+EKFS5SgjBP460a7tQBWHMTrnkBiIezXYTidxcPpZ0EEkhnlvG
         uP89MdCLjGUXzt0PJB/oaJ3mKRaBHE8zhGtmDtE1b/ZmQztSZ52bhsYkrvr+KDUIRdhK
         Kf8XaZpLiRNkbTQ9CQXqaPuOO5tCCVkr5TLmGzUEhPx9B+33PORZzPbuc9sZkeJRNMh7
         wkhWORhMjyzjoqmVSOGIHu5CzO/ArtO3XREbfPIGWkFVw0s2QQRJ1tLTjqWcIIKAxuvJ
         rybEHyPVmytxANlqcBlQqNAPGj4k0q9AFN3//ujzao8wIFH9fmCqTaqmN9ScIU+yosv3
         8zAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755274855; x=1755879655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j5YsQmEiBcbOe3A5Lut4xZB9ClhcGcuY3Y3QfkEhers=;
        b=UAIVxoMcf9x/h5YSOFeGymMYmBukKEshKdVM8iW6ZXpqxTPfiK5RpQvAe0iQJ5arMt
         FaMTmJEhLRSp/7huxjBnBveJ/k11jlmL7OuF9fhvRZJiczPVEHVfgsM4O/7Bafi/lJOV
         gqiZDrsi0jYelfA7C+vq9Rlse0Z3JQVbG1efM4FM2qKkNoLx7+bwAZ0RoRzcqwtP8q+a
         vmlLfoaUZSmKwJXNth2Pan+fsrBBukh1PfrcSzu5mca/NUW/vEtNG3V5QMVwiaBT7NvX
         sKWx5AzfSo5AKH1pQ4TzB792A2uzQrk1LeMchrw3CVzC49uKeeKvkVjjKm2Vl+SYVWfd
         QSPw==
X-Forwarded-Encrypted: i=1; AJvYcCUV/9MwoDSzrB27kc05Awmue+FPYxjO7aPvNYcO9YE7qeZdV6cqWT+xC8RNCjjoleYeLr5/K4gfIf85@vger.kernel.org, AJvYcCX6vniduUft/ErIEHCkDsADGJEP4+FNXxJ7s3DIDoY+H82iijS7wKbk4hzq3OLzNP3Kzdm7wrmQbUF3BsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5CE5lgdacVmhPeGdl7xImOIIY9vVA8Q/VzHKTFUegDWu17hwF
	MwI+btNv/2JQLT3WyO1yFVgKedT67SphPE/FJyHKZgpHsRh43JY+B9c=
X-Gm-Gg: ASbGncs9SPtiE2QkN7RbDI4ZybzaQksmvRDwRwnsgA1DK8yQFY3ZvFfwpv2HLJ7XQNu
	jGHoUPvcBUdmNAX6EifdIYebDEQhzZuD1tBE9GW+FE2VWCRL/Gwta9GlKr9Tjp4k8QvhyLDCzut
	Bq4yPiMqTzJ6GGbPO9LPBP08wTUUTiq756dQsRjqHkRkG7xI4A8y+lFSOI2L4299w7BmGc7uj9N
	nKs1/NkYvfHrH/T300qoCups506+ntYHYyEWlfERp4uLCpXAWFEwM8r6NVj42UT3EVkq7AA+Asd
	vPMHHr/KpBdIkR+uwDJwSrpVN3z4nEgOBhBGMa0yRmZcTdk7ghvvbznuo5ZAdTEG6b4TUNmZlmt
	ZE5qU2n2v/qt980s7RX5wBLmayw+j/wrHwe20uKgIDJG3J+B6kybIqnCOA5GOgQ==
X-Google-Smtp-Source: AGHT+IHW/jfSo8c3d52V36DbZYQ7G/wUNhOEV7mSGJNCIHXMB4gT6vZhUcZ2XhA4XcsjVJOToKX/zw==
X-Received: by 2002:a05:6a20:3ca8:b0:23f:f493:7667 with SMTP id adf61e73a8af0-240d2d816b3mr4599082637.3.1755274855293;
        Fri, 15 Aug 2025 09:20:55 -0700 (PDT)
Received: from git-send-email.moeko.lan ([139.227.17.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e452663cbsm1428263b3a.15.2025.08.15.09.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 09:20:54 -0700 (PDT)
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
Subject: [PATCH RESEND] x86/pci: Check signature before assigning shadow ROM
Date: Sat, 16 Aug 2025 00:20:41 +0800
Message-ID: <20250815162041.14826-1-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modern platforms without VBIOS or UEFI CSM support do not contain
VGA ROM at 0xC0000, this is observed on Intel Ice Lake and later
systems. Check whether the VGA ROM region is a valid PCI option ROM
with 0xAA55 signature before assigning the shadow ROM to device.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
Note:
This patch was originally sent on 2025/04/06, but did not receive any
feedback. Resending in case it was missed. The commit message is updated
in this version.

 arch/x86/pci/fixup.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index e7e71490bd25..362afaaf9874 100644
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
2.50.1


