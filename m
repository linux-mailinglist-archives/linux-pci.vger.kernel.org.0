Return-Path: <linux-pci+bounces-44263-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2ACD01AC8
	for <lists+linux-pci@lfdr.de>; Thu, 08 Jan 2026 09:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A919340967A
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jan 2026 08:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5A4389448;
	Thu,  8 Jan 2026 08:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mu+m6rYJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FAA364E98
	for <linux-pci@vger.kernel.org>; Thu,  8 Jan 2026 08:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767860383; cv=none; b=ogw33JBJLS5ThXi3YkEDCpHGl2KRO1zqORhX5lcvcMLRxuRuzzXj8j7l8R5Vwk5ypHqidy77rRdwQBfW87NQ0vekWMaaoDdlnaeAg10o7Su30QaIo1iAmmYO/9bBDAKsuxaHp9KRHQkSJKR24cZGSCXRtCjAt9qSvCYrr93j9RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767860383; c=relaxed/simple;
	bh=ZqmOf0gGy6Ui7/SWJdII1LH9oZpSkCVX842PERXe3X4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=atP6qn6oP7sxtuA3rG0CTAll0KxQ45S85UEWZhnNBWtBh7ril+CwE3xC8hjTqy8QUGApnfBfI1WVJGdT3AEGE02VspkiJM0GLRxU+3IzdUQP4dkdnG2HStA10VpG2B6dr2f/DyJz8RkRSRiXDU9dHsdJNCUHJMuw9dHACGbUSVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mu+m6rYJ; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34c3cb504efso2379753a91.2
        for <linux-pci@vger.kernel.org>; Thu, 08 Jan 2026 00:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767860372; x=1768465172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fHAmKcdoN135Asq9ijVI3O1LODaST52jtA9RClzYjcQ=;
        b=Mu+m6rYJif3CKKWodxrZjtUHYfu7+RksKV1fiLl+HFWLSys58vVNHXieOeOi0deWz4
         3+eOfGNQ4GGnQtQ3hqsampxlb3o5aNnJtct/o8MSiqKaD6vAcjF822N5/MKF1cwjL8kl
         HIqKm0W0Mk+Uz1GvWCRjqzWOgKYit7sY9GaoEFEK8bG2OF0f8nmEeFlQdLYwGi3NHOm2
         F+yWKlMYXhuFiCsNqXM2dxmP1FfxFwyJG52EP3bGwxoOWx8s2TFXHZGx8TkMI1rViX9W
         DmKzdeQQdMxokPr5WxyX5GU7HnfBor4wkk0NSgFB+6biazEzj87oLbYtOENHaYQNdlmd
         dOdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767860372; x=1768465172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHAmKcdoN135Asq9ijVI3O1LODaST52jtA9RClzYjcQ=;
        b=YfCZFbz7lHIvNkrWO++wEsYCqmS+fsN3XKXoYupeUHMuz6Q23PD69BRB/3LEAVy5Jm
         lnsJl43xqwbCdqzqO65ZINNt6H7KElqN9VwyTCk4qgFpxV2zblR2VLyFgbigfBxNTQlJ
         5KFKP54ZgLD4rAx+2Bp34OwlDSNstdLLDsFiCuOxUAM4huujJeRLvOvK8VtAl/NBpWPU
         XSavzF1rvVCLX6yi66wrUAsKWZxHj8Zux4Jmaf5GyzxBFrWHcjoHQmGFcpf0rMLVe3FV
         Pge4BXA5PQn9LhfckXAc407iQ4unydOiV3WVonouyUoqGSWbHhpLJJfxoOJ9WxD9kPO/
         Ux5Q==
X-Forwarded-Encrypted: i=1; AJvYcCV+FLGKMaCIts7qyakDK888k0dFp9wJxeAMpoC9bvy80D1LBnSGohzIx58qH5PXG2IGIsr3gkyootM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnSRYxyzsTd52edkVlCRAwJZLXRAsOvf+qM6mGbcSLqLhfrlIf
	AQdlO2TdQoVfH0YA5IuZ6S478a+uKS+M5DUEcBSpj0MvuRSMofO3epg=
X-Gm-Gg: AY/fxX5Zp+HMRh7VS566i4IPv6s4BgkP25j4fsv0kwc9yasfwVRxgEkIu0rgNM/n3FX
	r/0qAHiknNu02/4TdvXHpBlUqO834SN1maucJ6yTgOkrAoIpC/TCAFS4bc9OS2qfTahMvvqhWSe
	S8cl0tYqh9S1hIkJN/VOzqidOKFAAj+nl7iLc3OP3KYp/0KLb+sLAgFgG5xqlyQlblXUytRwlPo
	U1scuUvySelJtl4B/PBmh7gC8v+64aF62syZ1QC9ns4KUp92J0Jo2NtCNAsmOVJiKk2FzdPY4RG
	vKqiPtT05EzohXQ6znXQHEwU95UN+cbb7GHRA+XbQ7oO829xvLTiBO/IX2G/HMu6b+kLgYL9ZiZ
	7LSOPI/vKJu/7yxpRseZuYCR7DGTiOlVS4ZYUiGONKWOdlz4EF7AxiKAjbjiLQKR99oe8QLlnun
	7OM3JvCckU25wp3So=
X-Google-Smtp-Source: AGHT+IFDK5YD6a2Lz09PpXPJx2QnY/5/782hB7zl/Zgtvf8GF5ogkiCdodmnp0MwEz339uVRHb9Okw==
X-Received: by 2002:a17:90b:4c11:b0:338:3d07:5174 with SMTP id 98e67ed59e1d1-34f68c7a647mr5191292a91.5.1767860371991;
        Thu, 08 Jan 2026 00:19:31 -0800 (PST)
Received: from at.. ([171.61.166.195])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5f7b19ebsm6979077a91.3.2026.01.08.00.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 00:19:31 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Lukas Wunner <lukas@wunner.de>,
	Dave Jiang <dave.jiang@intel.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-usb@vger.kernel.org
Subject: [PATCH v3] PCI/portdev: Disable AER for Titan Ridge 4C 2018
Date: Thu,  8 Jan 2026 08:18:53 +0000
Message-ID: <20260108081904.2881-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes since v1:
	Transferred log

Disable AER for Intel Titan Ridge 4C 2018
(used in T2 iMacs, where the warnings appear)
that generate continuous pcieport warnings. such as:

pcieport 0000:00:1c.4: AER: Correctable error message received from 0000:07:00.0
pcieport 0000:07:00.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Receiver ID)
pcieport 0000:07:00.0:   device [8086:15ea] error status/mask=00000080/00002000
pcieport 0000:07:00.0:    [ 7] BadDLLP

macOS also disables AER for Thunderbolt devices and controllers in their drivers.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220651
Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

---
Changes in v2:
- Transferred logic to arch/x86/pci/fixup.c to only target x86
- Added DMI quirk to only target Apple Systems
Changes since v1:
- Transferred logic to drivers/pci/quicks.c
---
---
 arch/x86/pci/fixup.c       | 12 ++++++++++++
 drivers/pci/pcie/aer.c     |  3 +++
 drivers/pci/pcie/portdrv.c |  2 +-
 include/linux/pci.h        |  1 +
 4 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index 25076a5acd96..bd72f7cf5db9 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -1081,3 +1081,15 @@ static void quirk_tuxeo_rp_d3(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1502, quirk_tuxeo_rp_d3);
 #endif /* CONFIG_SUSPEND */
+
+#ifdef CONFIG_PCIEAER
+
+static void quirk_disable_aer(struct pci_dev *pdev)
+{
+	if (dmi_match(DMI_SYS_VENDOR, "Apple"))
+		pdev->no_aer = 1;
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x15EA, quirk_disable_aer);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x15EB, quirk_disable_aer);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x15EC, quirk_disable_aer);
+#endif /* CONFIG_PCIEAER */
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index e0bcaa896803..45604564ce6f 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -389,6 +389,9 @@ void pci_aer_init(struct pci_dev *dev)
 {
 	int n;
 
+	if (dev->no_aer)
+		return;
+
 	dev->aer_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
 	if (!dev->aer_cap)
 		return;
diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 38a41ccf79b9..ab904a224296 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -240,7 +240,7 @@ static int get_port_device_capability(struct pci_dev *dev)
 	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
              pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
 	    dev->aer_cap && pci_aer_available() &&
-	    (pcie_ports_native || host->native_aer))
+	    (pcie_ports_native || host->native_aer) && !dev->no_aer)
 		services |= PCIE_PORT_SERVICE_AER;
 #endif
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 864775651c6f..f447f86c6bdf 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -440,6 +440,7 @@ struct pci_dev {
 	unsigned int	multifunction:1;	/* Multi-function device */
 
 	unsigned int	is_busmaster:1;		/* Is busmaster */
+	unsigned int	no_aer:1;		/* May not use AER */
 	unsigned int	no_msi:1;		/* May not use MSI */
 	unsigned int	no_64bit_msi:1;		/* May only use 32-bit MSIs */
 	unsigned int	block_cfg_access:1;	/* Config space access blocked */
-- 
2.43.0


