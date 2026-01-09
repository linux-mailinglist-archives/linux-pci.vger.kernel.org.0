Return-Path: <linux-pci+bounces-44337-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6663AD079F0
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 08:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 84BF53008F74
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 07:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C562F0661;
	Fri,  9 Jan 2026 07:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNKBu+zt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265DD2EFD81
	for <linux-pci@vger.kernel.org>; Fri,  9 Jan 2026 07:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767944564; cv=none; b=KANGWMkkyyzhw66Ut9BdgBJCv77DLZ2F47MyKzCXQ3zkoVc7qj8i+Zp0JkMx77MG8zu7Wb8MXLu1hAgSDzW6es5cRmysi5tRoiI3qqiSB+YkBgLthwxDrxflOoFcGOPyiQXCdMJvn5++DDb0YVbLdS1FR5UOexBxmJOhJDK6/NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767944564; c=relaxed/simple;
	bh=eSn6OwD3SrFNXw5tP/h9H/Ii7V8Im22C2P69wloFwSM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WYpbZgY5//zZLvMe0623ai6FosdMliwtbm9N0xqUSm/11PqwrNbN8Lx/tEXWkw5bMKTvJ3Vf1ZVpnPe7yjhMTWMfKeaGxIbRlSrvf5ECg71jXtxqQiQ+j0u7wWLHQw29rNhwObr33WZZ9GOPRfqxwLrBSYn0KGfKzgzY8/jCeBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNKBu+zt; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c227206e6dcso2593059a12.2
        for <linux-pci@vger.kernel.org>; Thu, 08 Jan 2026 23:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767944562; x=1768549362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o9AYRVJbls5kMz4af/phakvFWuIaNCCibN2SZ7D9nuU=;
        b=XNKBu+ztV19Ia0ght1UHkOTunpMrvdVHurrb+9xjDr78fERdwAlqih6chUBZG1vZ6f
         IBb6z3815BytyMPQtBmUlWXleVc6ADWBn5aJNFxGzdPFRUNDVhwf7Y09EzwOgaYt6lxv
         K8Bs/CzhQqhn8ENEimMkEwy5Rtsd2fQM6AzM+gRDK+E8vx7CSRYVlYgWrzv+EiCXqhUJ
         uQVdUer1oD1O2F5C1DYg8Xnwk+Yl6KDHuQ0ZStnyu+BhpmeudKdX6/ESAjP5UkYV1DsL
         gATNZNzoaLuno6CWeFmWvSDIcSsxYkRZTbn+FsluYw0Qlo6oxptGp2IzeQhC/Mf7tPeV
         oJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767944562; x=1768549362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o9AYRVJbls5kMz4af/phakvFWuIaNCCibN2SZ7D9nuU=;
        b=HWPrdEafZuvYtZg46aGS3PkG5iOV7X2HsPEqcWJT9gN/ToxAEB6zNQIvpJB+j6//iB
         a6pwX4QDADlVFv61FJ3K7f9HkLEMR403u3fm4v2NrcDQeNywKMHiyYQ45mURIUJnFo76
         t/Ql3w3cYrC5iGWS/e/XB1Yr5Mg1duCxH4FIsrCroxZQpCYKoRaPEkz0Pwyh7dILOCok
         vD1zrfo/B5mGXZ7gcpUBnUfCCbmvCcRO463LQhRLugWnLOW6hHA/XEDHSPRf3ITqGtih
         T8L5yFQL4OrPF6sa+gzeP+1TeJ+0TCmdeIjwtmVP81f5FPRAOTxYhhm38ZClIbyVUzjZ
         UVwA==
X-Forwarded-Encrypted: i=1; AJvYcCUGNcDDbHtf24fGA/C+E8dMz/3QPnClZyhZtL5cR+63V5ao8jL9g/YiWaDY29WQMXapT0EAijmSpbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKsgWpVbnmhch95u9rNg131DbrWMw2B4w3JTPJ1y87YTVpPEog
	rF6LvB+USOq2w79CRzZuQCjQT2FrtGgytxqWyowtJBGJkxQkNGlXm6E=
X-Gm-Gg: AY/fxX6V6sC4i7wVhcfCUX79NV5sDnWprtalzqXlD5nBt7HG9uDJ8r5RJOQzXjQbnDZ
	dbEU0dmOytrs5Phqq6W+2LP4vjc0n5OdGxynI8hBN5zf5gCGduF4YljZ8uyzprCQOjeNuT/9Eui
	4pJUhTiIuTbOTnwXvlxatCz8At4xYxI3O34+rfpGI4SiJk7I2GcviHeMyn8mZQQ+3tpfVjWPCVI
	/AskU+TIIMAppR+GNPhS8Q60Yfpi5qew0zkFNdRHuaLWkEut0e6DVJgGqB0Es2GzykZks2E8kvx
	Pmj//AYD1iSHVzzBb5NjTVF7xbuT1j+zUNM+M2W9+27qKJfWcLj/xCe5r8rKqxPlzpO2dLJXhAJ
	Lk6LIgPIs1SpswW9PtIw4nwkf/iT1IaaYlQfk5lrGOffmB7t10F36Z6+BzqLk91GncbAr9UD1hD
	71lA/6ODAInA+ONdI=
X-Google-Smtp-Source: AGHT+IHJ/rsYu1MTPilthw7eQlciakMyESsgvffAUTB6sGttF8HsOFwXFQjB3kokh4VKOvwm/Db7+Q==
X-Received: by 2002:a05:6a20:a10e:b0:33c:2154:d4f4 with SMTP id adf61e73a8af0-3898f9975b1mr8593154637.49.1767944562266;
        Thu, 08 Jan 2026 23:42:42 -0800 (PST)
Received: from at.. ([171.61.163.202])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cbf28fa85sm9756036a12.5.2026.01.08.23.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 23:42:41 -0800 (PST)
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
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-usb@vger.kernel.org
Subject: [PATCH v6] PCI/portdev: Disable AER for Titan Ridge 4C 2018
Date: Fri,  9 Jan 2026 07:42:24 +0000
Message-ID: <20260109074232.2545-1-atharvatiwarilinuxdev@gmail.com>
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


