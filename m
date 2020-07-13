Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3994021D6D0
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 15:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730099AbgGMNXw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 09:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730022AbgGMNXV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jul 2020 09:23:21 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A1FC08C5DD;
        Mon, 13 Jul 2020 06:23:21 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id f12so17133187eja.9;
        Mon, 13 Jul 2020 06:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oKjzi2ECxC66M2cq5pSDhTnWy5R7cPGASuD1MUUpNKk=;
        b=m0hv7peUSoEu1HaED1ilH8q2Yvulbgnr8sEk5ujyQpvD2p2giyiLRwEFXl2DmoMR1L
         XpcpPwScY6D58mgiZ/Ioslm2LleFhnPHY4LNRAaYlXM0gQLIXclEPx8E9LZTylNuIdoi
         gppHKD9BY4vUbMYQ1S5C5e/enekD0lYTju5DkXO12ZsDuacG6qrYtX33osQMsQPPi1xL
         fSx/AgLZCj+tZr81MFm0dlzvtuPxHL6e69BGtQkAgmNfQx7rYukjqvgrlWhLTejMylPX
         DDluL/N8T+pb9MgV1jSM43ngBwL9/AwqgSSU9XHNcC10szF7x10BAZe3IB9lZmNTYc2a
         17kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oKjzi2ECxC66M2cq5pSDhTnWy5R7cPGASuD1MUUpNKk=;
        b=lcf0aVSgIrXyiOgXi3g4yA2kDKbUc2uLxSWvkoCQN6Iu047JTPtyUWsPx8h7ZkU505
         MEWWw1byOrD0UWhoUHEssWz1h4IXqn2SGiK55Bv11TzB62BaK3gcGS6yObkwevetCQ8N
         0PkqaY0mSln2eaKOAgaF9N4NtyM+1xWbc0GBHN+HQi3caP+CBlbCbWtP5Rlw6pK5pCfD
         W1Gm24EsBAXDjdey1RYcmGt7wj3AD2+Egj50q1MbacFyxjhvn7XyZtLJkrnTN2tEMsKv
         gCa13O9ndFd5MoxLWfnvhdi4QKFK8sWk+2zR1cOAKpCyWXHDUi8MxTURKhajYHlNFay3
         5jAQ==
X-Gm-Message-State: AOAM531Xu9i8TLrU+7iTLDg/2q2rJfP4kUHGp09GNZE7pwbyu5clw2QE
        7mLQChRamk1BW9t3vEYR6W0=
X-Google-Smtp-Source: ABdhPJw9vhhuR0dTOcWCGfHHtV7ehKWAbkfQuFQnlHmgFmQHxUAxscgm05NwJQ/bOktQDl+dNWLj/A==
X-Received: by 2002:a17:906:1756:: with SMTP id d22mr7116853eje.29.1594646599804;
        Mon, 13 Jul 2020 06:23:19 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
        by smtp.gmail.com with ESMTPSA id n9sm11806540edr.46.2020.07.13.06.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 06:23:19 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org, Russell King <linux@armlinux.org.uk>
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 32/35] arm/PCI: Change PCIBIOS_SUCCESSFUL to 0
Date:   Mon, 13 Jul 2020 14:22:44 +0200
Message-Id: <20200713122247.10985-33-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200713122247.10985-1-refactormyself@gmail.com>
References: <20200713122247.10985-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In reference to the PCI spec (Chapter 2), PCIBIOS* is an x86 concept.
Their scope should be limited within arch/x86.

Change all PCIBIOS_SUCCESSFUL to 0

Signed-off-by: "Saheed O. Bolarinwa" <refactormyself@gmail.com>
---
 arch/arm/common/it8152.c           | 4 ++--
 arch/arm/mach-cns3xxx/pcie.c       | 2 +-
 arch/arm/mach-footbridge/dc21285.c | 4 ++--
 arch/arm/mach-iop32x/pci.c         | 6 +++---
 arch/arm/mach-ixp4xx/common-pci.c  | 8 ++++----
 arch/arm/mach-orion5x/pci.c        | 4 ++--
 arch/arm/plat-orion/pcie.c         | 8 ++++----
 7 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm/common/it8152.c b/arch/arm/common/it8152.c
index 9ec740cac469..331911b627c4 100644
--- a/arch/arm/common/it8152.c
+++ b/arch/arm/common/it8152.c
@@ -186,7 +186,7 @@ static int it8152_pci_read_config(struct pci_bus *bus,
 
 	*value = v;
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int it8152_pci_write_config(struct pci_bus *bus,
@@ -216,7 +216,7 @@ static int it8152_pci_write_config(struct pci_bus *bus,
 	__raw_writel((addr + where), IT8152_PCI_CFG_ADDR);
 	__raw_writel((v | vtemp), IT8152_PCI_CFG_DATA);
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 struct pci_ops it8152_ops = {
diff --git a/arch/arm/mach-cns3xxx/pcie.c b/arch/arm/mach-cns3xxx/pcie.c
index e92fbd679dfb..7020071a2dc5 100644
--- a/arch/arm/mach-cns3xxx/pcie.c
+++ b/arch/arm/mach-cns3xxx/pcie.c
@@ -92,7 +92,7 @@ static int cns3xxx_pci_read_config(struct pci_bus *bus, unsigned int devfn,
 
 	ret = pci_generic_config_read(bus, devfn, where, size, val);
 
-	if (ret == PCIBIOS_SUCCESSFUL && !bus->number && !devfn &&
+	if (ret == 0 && !bus->number && !devfn &&
 	    (where & 0xffc) == PCI_CLASS_REVISION)
 		/*
 		 * RC's class is 0xb, but Linux PCI driver needs 0x604
diff --git a/arch/arm/mach-footbridge/dc21285.c b/arch/arm/mach-footbridge/dc21285.c
index 416462e3f5d6..5ad78b38c659 100644
--- a/arch/arm/mach-footbridge/dc21285.c
+++ b/arch/arm/mach-footbridge/dc21285.c
@@ -86,7 +86,7 @@ dc21285_read_config(struct pci_bus *bus, unsigned int devfn, int where,
 		return -1;
 	}
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int
@@ -121,7 +121,7 @@ dc21285_write_config(struct pci_bus *bus, unsigned int devfn, int where,
 		return -1;
 	}
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 struct pci_ops dc21285_ops = {
diff --git a/arch/arm/mach-iop32x/pci.c b/arch/arm/mach-iop32x/pci.c
index ab0010dc3145..a29d33ce20c8 100644
--- a/arch/arm/mach-iop32x/pci.c
+++ b/arch/arm/mach-iop32x/pci.c
@@ -118,7 +118,7 @@ iop3xx_read_config(struct pci_bus *bus, unsigned int devfn, int where,
 
 	*value = val;
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int
@@ -131,7 +131,7 @@ iop3xx_write_config(struct pci_bus *bus, unsigned int devfn, int where,
 	if (size != 4) {
 		val = iop3xx_read(addr);
 		if (iop3xx_pci_status())
-			return PCIBIOS_SUCCESSFUL;
+			return 0;
 
 		where = (where & 3) * 8;
 
@@ -154,7 +154,7 @@ iop3xx_write_config(struct pci_bus *bus, unsigned int devfn, int where,
 			  "r" (IOP3XX_OCCAR), "r" (IOP3XX_OCCDR));
 	}
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 struct pci_ops iop3xx_ops = {
diff --git a/arch/arm/mach-ixp4xx/common-pci.c b/arch/arm/mach-ixp4xx/common-pci.c
index 893c19c254e3..f7cd535d4971 100644
--- a/arch/arm/mach-ixp4xx/common-pci.c
+++ b/arch/arm/mach-ixp4xx/common-pci.c
@@ -208,7 +208,7 @@ static int local_read_config(int where, int size, u32 *value)
 	crp_read(where & ~3, &data);
 	*value = (data >> (8*n)) & bytemask[size];
 	pr_debug("local_read_config read %#x\n", *value);
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int local_write_config(int where, int size, u32 value)
@@ -221,7 +221,7 @@ static int local_write_config(int where, int size, u32 value)
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 	data = value << (8*n);
 	crp_write((where & ~3) | byte_enables, data);
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static u32 byte_lane_enable_bits(u32 n, int size)
@@ -255,7 +255,7 @@ static int ixp4xx_pci_read_config(struct pci_bus *bus, unsigned int devfn, int w
 
 	*value = (data >> (8*n)) & bytemask[size];
 	pr_debug("read_config_byte read %#x\n", *value);
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int ixp4xx_pci_write_config(struct pci_bus *bus,  unsigned int devfn, int where, int size, u32 value)
@@ -276,7 +276,7 @@ static int ixp4xx_pci_write_config(struct pci_bus *bus,  unsigned int devfn, int
 	if (ixp4xx_pci_write(addr, byte_enables | NP_CMD_CONFIGWRITE, data))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 struct pci_ops ixp4xx_ops = {
diff --git a/arch/arm/mach-orion5x/pci.c b/arch/arm/mach-orion5x/pci.c
index 76951bfbacf5..2b587225e244 100644
--- a/arch/arm/mach-orion5x/pci.c
+++ b/arch/arm/mach-orion5x/pci.c
@@ -289,14 +289,14 @@ static int orion5x_pci_hw_rd_conf(int bus, int dev, u32 func,
 
 	spin_unlock_irqrestore(&orion5x_pci_lock, flags);
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int orion5x_pci_hw_wr_conf(int bus, int dev, u32 func,
 					u32 where, u32 size, u32 val)
 {
 	unsigned long flags;
-	int ret = PCIBIOS_SUCCESSFUL;
+	int ret = 0;
 
 	spin_lock_irqsave(&orion5x_pci_lock, flags);
 
diff --git a/arch/arm/plat-orion/pcie.c b/arch/arm/plat-orion/pcie.c
index 8b8c06d2e9c4..6fb142f893ac 100644
--- a/arch/arm/plat-orion/pcie.c
+++ b/arch/arm/plat-orion/pcie.c
@@ -221,7 +221,7 @@ int orion_pcie_rd_conf(void __iomem *base, struct pci_bus *bus,
 	else if (size == 2)
 		*val = (*val >> (8 * (where & 3))) & 0xffff;
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 int orion_pcie_rd_conf_tlp(void __iomem *base, struct pci_bus *bus,
@@ -244,7 +244,7 @@ int orion_pcie_rd_conf_tlp(void __iomem *base, struct pci_bus *bus,
 	else if (size == 2)
 		*val = (*val >> (8 * (where & 3))) & 0xffff;
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 int orion_pcie_rd_conf_wa(void __iomem *wa_base, struct pci_bus *bus,
@@ -260,13 +260,13 @@ int orion_pcie_rd_conf_wa(void __iomem *wa_base, struct pci_bus *bus,
 	else if (size == 2)
 		*val = (*val >> (8 * (where & 3))) & 0xffff;
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 int orion_pcie_wr_conf(void __iomem *base, struct pci_bus *bus,
 		       u32 devfn, int where, int size, u32 val)
 {
-	int ret = PCIBIOS_SUCCESSFUL;
+	int ret = 0;
 
 	writel(PCIE_CONF_BUS(bus->number) |
 		PCIE_CONF_DEV(PCI_SLOT(devfn)) |
-- 
2.18.2

