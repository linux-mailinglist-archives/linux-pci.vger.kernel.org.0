Return-Path: <linux-pci+bounces-3188-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6C584C685
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 09:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BFF2B2615F
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 08:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C95F208D5;
	Wed,  7 Feb 2024 08:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="vSAAENbS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63463208CB
	for <linux-pci@vger.kernel.org>; Wed,  7 Feb 2024 08:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707295500; cv=none; b=THAHVyxTA5aDHY3U2p6CWWsKmAhAjgNODeLCMwMloXICi0lrNR2+zhHwNKPjPqW3OWy33AqzYc1G0tf6PEyWbRRORGstWggULb/Olm+cqTF5aktqwJMmW3+H3rwSLGIzymbi28meDAvA8NJ/xUgGjovleFjcqyOs5a2kBzJnGU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707295500; c=relaxed/simple;
	bh=H2Xrmgvl+SM8bD81WrtzhSJbxFmN+3cpc89YY2RXfaY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kRCMbBfrIB3v/ASsvp58Nf86JhwmuZIxWjNdNumTcNkGXRI0MLPKU4Ya7FsGF0MAtWrCn9ar3EDoXZOhoPOF0jGdKShXf22m/Ac15PnVMJ7TUE4J2VhtJo7wJouXiwelhEfAKUX8RJZxiQNnW4GiG+qAtnqtxf+XkJnt+Y1o0nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=vSAAENbS; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a27e7b70152so15442766b.0
        for <linux-pci@vger.kernel.org>; Wed, 07 Feb 2024 00:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1707295497; x=1707900297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NAeXDExjFp8LIE+XwnvVYSsXych5ypTHEBtl908GHMU=;
        b=vSAAENbS7Ku2Cqif8kivUKMCOsd2sJ6WRog0B7TL9tw14zwYyeGsdJiioa9HcpxjYH
         yFYKzcUmiOgF3shyP8ydFwJdundQFs+w7cg1WHkh/v3EsFa1j0I7J7fR8FFixarJakIM
         e/TmlquDXXR+gW75yxBoqmayaaM8FZLxWZM4iXxTf+Et2HOgCgwRMfYx51U61re5lgLk
         68lBmBqWHaxRyWxOTpcVz7zv1ApCIglTkaK1ymGvDeudkwFlpYZqITNQH3tLXzGjBx3j
         SKsTEMZ8BLClFY9A60YrZzZ197omQAHirIw3gnjnjVDJO+l3si1m9O1FbMYmkmyVxAyL
         rosw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707295497; x=1707900297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NAeXDExjFp8LIE+XwnvVYSsXych5ypTHEBtl908GHMU=;
        b=sOqzM8SG0b+EctvU7r2pCwDldg9nL0eTtsNZQAP+FjzdX/WxW1EEBXajFPIXoH18l9
         /m9SGLu35Tx+MjbRFXF8zeQfg64yrRq5hhfpTPaqxxxcqH025et7WvB7/NUySxC9cuJq
         aAZSBrXr0AfF2DnFwJR7QZFygWxfqmBAT1PQTBjKToeuRYgHV4qSAXDEcbgGV6wu8aBP
         Wr/aZTXnZFQrMb1WGGQNXGvXkWJCxkY0keD3y5djhOsxxp+c9Ra2dzFgnEWXmCBYoAaU
         K0GtVIbw/7OKGyzo+uYPdZuSz7fybaq39epmdQY1DNlNDUIs/OyYcK8jCLRdOvUXG2vK
         hAQw==
X-Forwarded-Encrypted: i=1; AJvYcCWaZ2xD7xy3F6VMxG58mEhWcqV4L5vTHYq3YJ0r26nUf0CNBQmm2PPrXWvvj/8J2zM9wt7yA8K4dwxDCEfQZlAJV62c7K1zW1AJ
X-Gm-Message-State: AOJu0YzlkUcOX0U3qle0m+J+/yaSWhaYI01V5kiXwV9D0Wh+aeGi5KD2
	6IE1I2hjVS9FZfMJHihbIroTcKwktPytPh7C0WVgA6iKdSFf1b8gYUsQf3/7rAA=
X-Google-Smtp-Source: AGHT+IHJH5b5XooA6vxYl/ux0hGtgIEdFNhaZyz2JiJVHAJXfPzU9wQ/SBYAIGJZBWwVpFZM4e6MpA==
X-Received: by 2002:a17:907:7e9b:b0:a38:4eae:b129 with SMTP id qb27-20020a1709077e9b00b00a384eaeb129mr2455655ejc.3.1707295496181;
        Wed, 07 Feb 2024 00:44:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXD4y+Ezus4AOUzHyJWgh6A6hXrLCrVZBKoWkE0W3oEF/JTD27sbTQK6xQyoJWrBnAUfEZWhID+7mlpMNEKd0kkmQ8o77b4Y4bmYcPaw/sBKUTPNwC+HeAFtFCLPfQ1Xopv4i9LgSzYqZym2Mh9140t6KoFQ0PyOxXiph2KN2ByJAQxH6tvOwNzJMJ5Xkg7LVrG1z7K+HI7sicNl2P0uvx85Xi8vsUDv4Q+m7Ub+TQIEY2rXUtq+PIDrqGbLrq60Gf1xTCtKlwncMj3Cwlnfn8tA4jqgSPeuRjIvvB1eMhsJ1jisXpgeRm+z6/C2DftlpuYaNrrv6M2qY0q4k3L67RYdQRoyu1blHhC+8GDzTLMUyBhe68ONUhSjwSvWaFWt4cDJZplbpJgFCPDfY2Fb/XgSa5RGwSlY9sXuaDwH9Swb69jpyiYR8Fn5exbH1LCzPMw47UFUas=
Received: from limbo.local ([2a00:1bb8:11e:cb8d:24dc:94bb:6d8:7d12])
        by smtp.gmail.com with ESMTPSA id u25-20020a1709060b1900b00a370a76d3a0sm493921ejg.123.2024.02.07.00.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 00:44:55 -0800 (PST)
From: Daniel Drake <drake@endlessos.org>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org
Cc: hpa@zytor.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bhelgaas@google.com,
	david.e.box@linux.intel.com,
	mario.limonciello@amd.com,
	rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux@endlessos.org
Subject: [PATCH v2 1/2] PCI: Disable D3cold on Asus B1400 PCI-NVMe bridge
Date: Wed,  7 Feb 2024 09:44:51 +0100
Message-ID: <20240207084452.9597-1-drake@endlessos.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Asus B1400 with original shipped firmware versions and VMD disabled
cannot resume from suspend: the NVMe device becomes unresponsive and
inaccessible.

This is because the NVMe device and parent PCI bridge get put into D3cold
during suspend, and this PCI bridge cannot be recovered from D3cold mode:

  echo "0000:01:00.0" > /sys/bus/pci/drivers/nvme/unbind
  echo "0000:00:06.0" > /sys/bus/pci/drivers/pcieport/unbind
  setpci -s 00:06.0 CAP_PM+4.b=03 # D3hot
  acpidbg -b "execute \_SB.PC00.PEG0.PXP._OFF"
  acpidbg -b "execute \_SB.PC00.PEG0.PXP._ON"
  setpci -s 00:06.0 CAP_PM+4.b=0 # D0
  echo "0000:00:06.0" > /sys/bus/pci/drivers/pcieport/bind
  echo "0000:01:00.0" > /sys/bus/pci/drivers/nvme/bind
  # NVMe probe fails here with -ENODEV

This appears to be an untested D3cold transition by the vendor; Intel
socwatch shows that Windows leaves the NVMe device and parent bridge in D0
during suspend, even though these firmware versions have StorageD3Enable=1.

Experimenting with the DSDT, the _OFF method calls DL23() which sets a L23E
bit at offset 0xe2 into the PCI configuration space for this root port.
This is the specific write that the _ON routine is unable to recover from.
This register is not documented in the public chipset datasheet.

Disallow D3cold on the PCI bridge to enable successful suspend/resume.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=215742
Signed-off-by: Daniel Drake <drake@endlessos.org>
---
 arch/x86/pci/fixup.c | 45 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

v2:
Match only specific BIOS versions where this quirk is required.
Add subsequent patch to this series to revert the original S3 workaround
now that s2idle is usable again.

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index f347c20247d30..6b0b341178e4f 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -907,6 +907,51 @@ static void chromeos_fixup_apl_pci_l1ss_capability(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x5ad6, chromeos_save_apl_pci_l1ss_capability);
 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL, 0x5ad6, chromeos_fixup_apl_pci_l1ss_capability);
 
+/*
+ * Disable D3cold on Asus B1400 PCIe bridge at 00:06.0.
+ *
+ * On this platform with VMD off, the NVMe's parent PCI bridge cannot
+ * successfully power back on from D3cold, resulting in unresponsive NVMe on
+ * resume. This appears to be an untested transition by the vendor: Windows
+ * leaves the NVMe and parent bridge in D0 during suspend.
+ * This is only needed on BIOS versions before 308; the newer versions flip
+ * StorageD3Enable from 1 to 0.
+ */
+static const struct dmi_system_id asus_nvme_broken_d3cold_table[] = {
+	{
+		.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+				DMI_MATCH(DMI_BIOS_VERSION, "B1400CEAE.304"),
+		},
+	},
+	{
+		.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+				DMI_MATCH(DMI_BIOS_VERSION, "B1400CEAE.305"),
+		},
+	},
+	{
+		.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+				DMI_MATCH(DMI_BIOS_VERSION, "B1400CEAE.306"),
+		},
+	},
+	{
+		.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+				DMI_MATCH(DMI_BIOS_VERSION, "B1400CEAE.307"),
+		},
+	},
+	{}
+};
+
+static void asus_disable_nvme_d3cold(struct pci_dev *pdev)
+{
+	if (dmi_check_system(asus_nvme_broken_d3cold_table) > 0)
+		pci_d3cold_disable(pdev);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x9a09, asus_disable_nvme_d3cold);
+
 #ifdef CONFIG_SUSPEND
 /*
  * Root Ports on some AMD SoCs advertise PME_Support for D3hot and D3cold, but
-- 
2.43.0


