Return-Path: <linux-pci+bounces-44656-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 200A8D1AA6C
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 18:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A9A03012CE3
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 17:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1832A334C1F;
	Tue, 13 Jan 2026 17:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6Z+xc5m"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A13329C74
	for <linux-pci@vger.kernel.org>; Tue, 13 Jan 2026 17:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768325644; cv=none; b=jszIvrlxlu9eo6vCYJ3i4CX3AXBESNkLipcfkqyLpDt4/2jcHjTcAcZrSzkBrrbYcQttRYvo1kOjoL25rFUlwv2VOGjo+h39Ij8zw/rBLZbxDaL/nai4DNaxfcReg6qiT7GhExsYlEmB7aqHtOapNc+kgyCiIGGan13TWhyWvBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768325644; c=relaxed/simple;
	bh=eSn6OwD3SrFNXw5tP/h9H/Ii7V8Im22C2P69wloFwSM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jZfVR5C/o1iWctX3jlgr+b43x1FrpgF9xfzOtHFcEY4sQtfnwA6bPdEYpktmQyaqeWCLquKUzsoWgBbfQjd+LdtCj0uUXdqPJE1+h0yj1q8Mcqt5gp1qh5czbQHXMt1MWsw5prKpnhHAEezdYFykMU2acBocEMzcHrpk4/JCDbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6Z+xc5m; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-81e98a1f55eso2083714b3a.3
        for <linux-pci@vger.kernel.org>; Tue, 13 Jan 2026 09:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768325641; x=1768930441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o9AYRVJbls5kMz4af/phakvFWuIaNCCibN2SZ7D9nuU=;
        b=X6Z+xc5mtXg0NqS0JuUbt1276ipKGNu0R4ckTAgVXUlKTUMiBwO5lSK2x1UTTsCLDD
         /QIv8UUd46Dk4FI7bKy0ArpNtGt9/v4UYFj//SRFAZa7iJxZxYVXLIc1/GmFFbT3PNDK
         Ph9N9Z6jzPIOymVNTKo7AkHkpKN4UWa739o1NArSz3RA+r4bkLo5tpwsw7xRxPgAYEYh
         /AAj4H8ro7dYitL2oQJTKqd/16r6B25ymhHrrOs0hugGI7QVS0fl+qoytta50+WrkHjG
         za/cEWO9sds43hlDIoCealBxoDEb+3L9q33ao+CfHkoMSEL005lg5FLzTQZGEubYJ6Fg
         /hLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768325641; x=1768930441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o9AYRVJbls5kMz4af/phakvFWuIaNCCibN2SZ7D9nuU=;
        b=SNxm186iunL10+2WN7pqBOgxP7vOo7rtuRSUFjrMEYJxvoKBlZ8rAboy2mQ3AS5/8/
         xDKuftxKNzIRKp268Xu7dmT4FiEc7zY8Gm5StfT1QwJX41/93gyvo6Pl7g5lTO3zYSTP
         fRlbFhHYwQhyb2Pq55NMAmqWe1HieZTOr53Ns1jHX6WvpH/HQ3hOAZqaNJ3ftWuUEy1K
         MCPMQw0618Ug6lsJ1HlMmsf66iPofY/adsbOhB9LHr4le/BjmSx+TRLEEE3J4ZNvGBrF
         CXzYG2gBCQxMIOxPXRegqmyWa6zojxX3ROHlx37nPo2+O+5Cra7iJ7/YaFsgHb8LR5TY
         DWPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPzY/6vrZupwp4EBIUcH5ZFSCRjdABkPp86ETaMDosWTt4VgaqzVaiJfJ+nvxbWcJAWUOY8Q9DZnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIayyvZC0NKNhmIVVpEhM+JZyQElex/olMPOAlwqTyNQgthOxE
	90Shk+R2Pc3hSApOlYy9RohZTrcqFz9r9cQXUcBvQ8Rby61xWPQsa08=
X-Gm-Gg: AY/fxX7K1TNArWWBZuBmPFE0kfZxEPbee+UtXT5QFH+groCACPEK6VMONCLF1WZk27K
	2rHn7a4beUyFHKD1AWL9y5etcWZ/G258Jj1NbDsCNYRbAkOsK4A/4VXVrvzxIumDShs/HG8/Dj9
	4UyPwNKv//DNAFq5XbwhjCk1Ahn2xy2P9G/kCSMDhFETMzhg1bNy8N8eSfzJLtL23DN7JFhJE+z
	2G67d2l1FLb8MBiwU7wDKSa8vUKoV4IoQ9z8QbJUh/SRN2E0ZN2I/uX8psP9PPS+QsOYTCRTKO0
	y+ptW5VeM+31pdDFbGGsn4PBr9NrklzEhTS7aU4AAgKTFNSeFy/Io2HoXyfA3tqAMuK/7ZOpPnZ
	5IzKJMqfcCV7lp1xfIWjMt1A3HCGH8NARPvER3BSEjew46hFC3viouiz9zL0V+Tcexjm/Phk6C7
	i+fNuxSYVgtcOBvif2Kw==
X-Google-Smtp-Source: AGHT+IFVIOA0i/RAZfOle5Rnk5OR3hAeebkOKtj4cj5B/mfjbUzBpEhX9pRkYTvlm8gfa3/cjIZpdw==
X-Received: by 2002:a05:6a20:2450:b0:361:3bdb:26df with SMTP id adf61e73a8af0-3898f889453mr21192202637.5.1768325640779;
        Tue, 13 Jan 2026 09:34:00 -0800 (PST)
Received: from at.. ([171.61.166.29])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81f66f9cf38sm4568854b3a.53.2026.01.13.09.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 09:34:00 -0800 (PST)
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
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-usb@vger.kernel.org
Subject: [PATCH RESEND v6] PCI/portdev: Disable AER for Titan Ridge 4C 2018
Date: Tue, 13 Jan 2026 17:33:41 +0000
Message-ID: <20260113173351.1417-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
Changes since v5:
- Used the correct name for DMI check
- Used DECLARE_PCI_FIXUP_EARLY instead of DECLARE_PCI_FIXUP_FINAL
  to disable aer, before the aer init function
Changes since v4:
- Used lowercase hex letters
- Used DMI_BOARD_VENDOR instead of DMI_SYS_VENDOR
Chnages since v3:
- Fixed Grammer mistakes
Changes since v2:
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
index 25076a5acd96..402387e41450 100644
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
+	if (dmi_match(DMI_BOARD_VENDOR, "Apple Inc."))
+		pdev->no_aer = 1;
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x15ea, quirk_disable_aer);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x15eb, quirk_disable_aer);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x15ec, quirk_disable_aer);
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


