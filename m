Return-Path: <linux-pci+bounces-3196-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DFD84C94B
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 12:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C25441F2786E
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 11:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CB817BDD;
	Wed,  7 Feb 2024 11:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="UYLBu0of"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B591802E
	for <linux-pci@vger.kernel.org>; Wed,  7 Feb 2024 11:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707304435; cv=none; b=XRqZZM8c3wAklH7VF8D04YjCsWpZmd4SekJeHYVb+F9zEKO9bU23h/EMCbRubFjydnjHQ1D/X9MyRi/KkYFa8Pyjpvrn/zAtaLXDfa0REFwnJcByL08Otl6hd3dBzvq+/cPBrb78i2ShnZlaC56b+HxPT4Sh4T7V8mvFIZDZ43s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707304435; c=relaxed/simple;
	bh=tro8ragEiatxrzVyhM2KBl3dAfGGbhXMHer3p8yIa1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bUQHyxGBipiB31eHdHML837pDP6Y1qLEyv54yCOSlrLWfgugrX88Pcw4PZt9TK/iRxdjsCJ8kFuD3J/bSWBZNrln6GEME7rTk4u2otwn9/EnuajvU5hnmhGvDSjstkt5NNUZ8Phi2X4yoZc3B/j/z5fjQUadwp7NJolvC3TIDBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=UYLBu0of; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d70b0e521eso4046235ad.1
        for <linux-pci@vger.kernel.org>; Wed, 07 Feb 2024 03:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1707304433; x=1707909233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4bOqg2l6/pVQQK6oz5sCjnvNtEXfm6tGtms7+YNZ0l8=;
        b=UYLBu0ofnkihM/tICzvmGXejcLPPm2D+MmmQw8XrahA6J8ewk8GhVppWDgdwfClJW8
         olYMwNuS7M6w7ZJki2Id4ISlUXtz7xXX/J2/D2seZWZphrFsJPeWcxDU8KrRERJASrZk
         qH1gyxpuAl8OXCbGn/We/UNvjew2botuDgLgEvdFe06pbWprMdqbzbzC6+eF3F67y1R5
         sKEMBBUAnMmQ1Ra+Q9iQim5PDU9xSEiQhTMCmqHEcPKVahxeY/HkBrzidWH3GnrlnNuG
         Kpxkc/77bPH1WFjmvjJv2I3E3g57FyjwlKwgOa87NQv35EWt2YEEJDCTRoTku/ImOh1V
         eeSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707304433; x=1707909233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4bOqg2l6/pVQQK6oz5sCjnvNtEXfm6tGtms7+YNZ0l8=;
        b=CamwcuIDVhZGlOMl0d/u7GUDfrtLfz6V1lu+6dGwEIrWHILXFwlPQFQZ7EJRR3/Mrz
         8Z96zuPgAvULcqMn6t6mRno2TArJhIOwzy+OzAjKNRBv48Vqz06k1tQ+5qCgYATwbVvJ
         nzpA1V/zsPBZq/1xyh+toiwJlSPI3jO4DIxsvhIVk0YJTaUORfG/+YdoOjn9Oe9gRPMq
         jYo17AwM1konk2SmaiZ66Ny81Ls6F/XXSJbJ5ucUe1+bGSV2BVsgjzUxigHtysZKKtrg
         qGzUcZ4jAq0Y36Yx8i0um5fZ5JiUZ2bifAJ48aBLsFFT0euKOuV7byHPR9Xg93hMcKs/
         cmuQ==
X-Gm-Message-State: AOJu0Ywoa30L4GDxa6heSyYNcqyuh9wN+pQW3z2Dkm08zp0iD+42qaL4
	XVIXI1HHDYMs8WrwJjuMoxhAUE/MQl5G+EaUuXYz5oEvJK4RlqMiBZprs9Thy1s=
X-Google-Smtp-Source: AGHT+IEMM33I1mRf3qbVJCVIjvQWYDJtRxsXJDDEil45HxeXjK8i5H0rpNmzDJEgjoSgP1/Q05BGvg==
X-Received: by 2002:a17:903:1108:b0:1d9:6c3:e24f with SMTP id n8-20020a170903110800b001d906c3e24fmr5075235plh.38.1707304433286;
        Wed, 07 Feb 2024 03:13:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUg/yi/uJnxEcXcmd+ClMWaL8fo5FJp0E7pxLW4vkdPZBq2tQuH3k264ISX7sYs/6PkEusBcLp0t8vxUU1nEdwp6+GcqrFv2vXIkJxrTB0JJcPoty+/55pKqExpwVbHzkGNCCg58NY/f/RUoZkCSr26jNWoAL+rGGxWBlA0WC4WnH0DaRpuZ0qfTjDsi7dpnN0MLDSSdzC91W1zuXT+KeUNea3scWS60so7bDtfaDhLjy5x872vL7GDVkg0i0YF80Va8OlQATzjAoqy76EzUDm0965k0HbemZgpZsZ7nIJaQcWYP5Wwv/THKdoKcCvm/uK/QMjiiIcVXYZG42O4O0KTui/0hYj9Or4+XymP7PtrCROpQIBNDjY=
Received: from starnight.endlessm-sf.com ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id jv12-20020a170903058c00b001d9602f3dbesm1176957plb.24.2024.02.07.03.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 03:13:52 -0800 (PST)
From: Jian-Hong Pan <jhp@endlessos.org>
To: Bjorn Helgaas <helgaas@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	David Box <david.e.box@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@endlessos.org,
	Jian-Hong Pan <jhp@endlessos.org>
Subject: [PATCH v3 1/3] PCI: vmd: Enable PCI PM's L1 substates of remapped PCIe Root Port and NVMe
Date: Wed,  7 Feb 2024 19:08:43 +0800
Message-ID: <20240207110842.576091-2-jhp@endlessos.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The remapped PCIe Root Port and NVMe have PCI PM L1 substates capability,
but they are disabled originally.

Here is a failed example on ASUS B1400CEAE:

Capabilities: [900 v1] L1 PM Substates
        L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_Substates+
                  PortCommonModeRestoreTime=32us PortTPowerOnTime=10us
        L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
                   T_CommonMode=0us LTR1.2_Threshold=0ns
        L1SubCtl2: T_PwrOn=10us

Power on all of the VMD remapped PCI devices before enable PCI-PM L1 PM
Substates by following PCI Express Base Specification Revision 6.0, section
5.5.4.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=218394
Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
---
v2:
- Power on the VMD remapped devices with pci_set_power_state_locked()
- Prepare the PCIe LTR parameters before enable L1 Substates
- Add note into the comments of both pci_enable_link_state() and
  pci_enable_link_state_locked() for kernel-doc.
- The original patch set can be split as individual patches.

v3:
- Re-send for the missed version information.
- Split drivers/pci/pcie/aspm.c modification into following patches.
- Fix the comment for enasuring the PCI devices in D0.

 drivers/pci/controller/vmd.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 87b7856f375a..6aca3f77724c 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -751,11 +751,9 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
 	if (!(features & VMD_FEAT_BIOS_PM_QUIRK))
 		return 0;
 
-	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
-
 	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_LTR);
 	if (!pos)
-		return 0;
+		goto out_enable_link_state;
 
 	/*
 	 * Skip if the max snoop LTR is non-zero, indicating BIOS has set it
@@ -763,7 +761,7 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
 	 */
 	pci_read_config_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, &ltr_reg);
 	if (!!(ltr_reg & (PCI_LTR_VALUE_MASK | PCI_LTR_SCALE_MASK)))
-		return 0;
+		goto out_enable_link_state;
 
 	/*
 	 * Set the default values to the maximum required by the platform to
@@ -775,6 +773,13 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
 	pci_write_config_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, ltr_reg);
 	pci_info(pdev, "VMD: Default LTR value set by driver\n");
 
+out_enable_link_state:
+	/*
+	 * Ensure devices are in D0 before enabling PCI-PM L1 PM Substates, per
+	 * PCIe r6.0, sec 5.5.4.
+	 */
+	pci_set_power_state_locked(pdev, PCI_D0);
+	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
 	return 0;
 }
 
-- 
2.43.0


