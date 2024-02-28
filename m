Return-Path: <linux-pci+bounces-4171-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A4686A94C
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 08:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E85728A1F6
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 07:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F0C25614;
	Wed, 28 Feb 2024 07:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="tM4WWze4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CADD2262B
	for <linux-pci@vger.kernel.org>; Wed, 28 Feb 2024 07:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709106804; cv=none; b=la/pbt2Ts/vUJnc2qozY9adPorWUhmd6LL6SLW6t1WPkQCo5TAqjQJ6IPr3TZBgJsex5nuJ8DW57qiV/cGe3aEf5ggCTgAZznuHAuVk3UfDJxuyXVdPp61g/7Z4B7KM0tQ//i2OCMbCP3eh0SvD5uvorEXxJCIBojXYr0jrywIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709106804; c=relaxed/simple;
	bh=A4ahDC3K/7VxYDp1KcCi8IyKxrIOOQY26srrHVeCdhk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YteRUfy0//bGVtj3SHQrSqorGNiIzzAIURcWBTYaiv5IDM/EICYDmz5LLMHTdxyCJ94G9M3Gkz2Gc1WO0XoUWjso09eOWe7G6e3jMBLUXltqQWMqIMcWOz9PhoEiQF2ncMfRd5b4quVfS91LADYvJ/h7PZEshfCJyiv6C68UAQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=tM4WWze4; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3f6aed454dso143458466b.1
        for <linux-pci@vger.kernel.org>; Tue, 27 Feb 2024 23:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1709106799; x=1709711599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BwZREp7Ok6on7duMSE+fGHGMVh8R/XQyRm504JpLDwM=;
        b=tM4WWze44F4UnC7DuIHIGPdg4aXWZvQD21aS8FZ5CMspMiB/nxJrJv5NaxXnrs3lgi
         OriQerQ7ECHtCq+gRAD2DYv+br28UiXM/7MeCcnnp8fJNEspHzmlYf3LpOL/BciHbGfH
         Boe91TLkE7F1QbiUtGdMGi7hkvxYwLL9YscMZqsNgQ/I7+NQR9FIaMvpPjaVxHHx1eQ6
         DSPJ+rQnLUtSG94UbVsHqtKyy/lbfzCzGcxtZHfGp+u0yAsE7IRdbbKjIPb2P1XI001f
         ytaIlK/z+l0MCy0fzyk41TTs29EEj2sgzppbxMBEMDIACK/vEVCjuBJhlFHekcRtnueY
         XIZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709106799; x=1709711599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BwZREp7Ok6on7duMSE+fGHGMVh8R/XQyRm504JpLDwM=;
        b=klTlBfXgzXKO27Y3m+6kQVJKwukAkfsymweXhRArWorv7rhYR76KVxAUfBEuirsndC
         11Fsa2KP9NSK7kUQbmBQJwCWGl3X/vcEfbXXMlnYp25s6AecXfuLpFA04X0hsPKpgE1l
         gtPRxYyXbgs6FmDKltrOK0NO58wxV5kHMgfe2RltC2OJYUO61YbngxH4F3SAgFFXq0Jt
         kasUHt8g8WoSIJfEcs3BdfFWbO6PSNETJm1Kg5nHZpG7lMIXGjXv+KTuVXXPlntG3hn3
         /QryBUf36z7JKL52ZAPCUebss2erUp0f9Su0zFkPT8VUyBYyYcVCPgWyI2WKrVQrhQoo
         wCMw==
X-Forwarded-Encrypted: i=1; AJvYcCX+6fGgx+z/7wKKPWLvQKNHuaf4DCVTcxzvl34J5CHFAmbab4cgp1qXlo83oyCGeJcYKNWkmauFt0/0Bise+ncX2bj1On//kbZy
X-Gm-Message-State: AOJu0Yxyr20eTBBsrNojQhVgjZuZeT66IWmDiMXIXtD0TIuDW8khth89
	kc6hbXbDVpsWLQi7QNeqGM00C7krDRKBaW6W16htkBcc0LvDztkfr5V+O361lqE=
X-Google-Smtp-Source: AGHT+IEU1AQ9oBom/2JlJ30ca16bCJQGIQC+tTO7c+8eORuCVnWfa2ZS4TotZGGzAS3huEsQi9uf7g==
X-Received: by 2002:a17:906:3caa:b0:a3f:161b:cc13 with SMTP id b10-20020a1709063caa00b00a3f161bcc13mr6082057ejh.7.1709106799382;
        Tue, 27 Feb 2024 23:53:19 -0800 (PST)
Received: from limbo.local ([2a00:1bb8:11f:a33a:d002:9fcd:70bf:4f2a])
        by smtp.gmail.com with ESMTPSA id o14-20020a17090608ce00b00a4396e930bdsm1561581eje.79.2024.02.27.23.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 23:53:18 -0800 (PST)
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
	linux@endlessos.org,
	Jian-Hong Pan <jhp@endlessos.org>
Subject: [PATCH v3 1/2] PCI: Disable D3cold on Asus B1400 PCI-NVMe bridge
Date: Wed, 28 Feb 2024 08:53:15 +0100
Message-ID: <20240228075316.7404-1-drake@endlessos.org>
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

This appears to be an untested D3cold transition by the vendor; Intel
socwatch shows that Windows leaves the NVMe device and parent bridge in D0
during suspend, even though these firmware versions have StorageD3Enable=1.

The NVMe device and parent PCI bridge both share the same "PXP" ACPI power
resource, which gets turned off as both devices are put into D3cold
during suspend. The _OFF() method calls DL23() which sets a L23E
bit at offset 0xe2 into the PCI configuration space for this root port.
This is the specific write that the _ON() routine is unable to recover
from. This register is not documented in the public chipset datasheet.

Disallow D3cold on the PCI bridge to enable successful suspend/resume.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=215742
Acked-by: Jian-Hong Pan <jhp@endlessos.org>
Signed-off-by: Daniel Drake <drake@endlessos.org>
---
 arch/x86/pci/fixup.c | 48 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

v3:
Adjust comment and commit message based on feedback, and more detailed
investigation (on bugzilla) which indicates the problem may be more
attributable to the (lack of?) power management on the NVMe device port
rather than the parent bridge. There's no difference practically though
- both ACPI devices share the same power resource which is the one powered
down in D3cold...

v2:
Match only specific BIOS versions where this quirk is required.
Add subsequent patch to this series to revert the original S3 workaround
now that s2idle is usable again.

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index f347c20247d30..859a32fba8a96 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -907,6 +907,54 @@ static void chromeos_fixup_apl_pci_l1ss_capability(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x5ad6, chromeos_save_apl_pci_l1ss_capability);
 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL, 0x5ad6, chromeos_fixup_apl_pci_l1ss_capability);
 
+/*
+ * Disable D3cold on Asus B1400 NVMe-NCIe bridge
+ *
+ * On this platform with VMD off, the NVMe device cannot successfully power
+ * back on from D3cold. This appears to be an untested transition by the
+ * vendor: Windows leaves the NVMe and parent bridge in D0 during suspend.
+ *
+ * We disable D3cold on the parent bridge for simplicity, and the fact that
+ * both parent bridge and NVMe device share the same power resource.
+ *
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
2.39.2


