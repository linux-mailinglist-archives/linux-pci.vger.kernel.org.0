Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0439921D6BC
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 15:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbgGMNXW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 09:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729823AbgGMNXQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jul 2020 09:23:16 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C045C061755;
        Mon, 13 Jul 2020 06:23:16 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a1so17115940ejg.12;
        Mon, 13 Jul 2020 06:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YiKDPZAVuj+rtPOroUOUnVyZ3NsBlXSRcAAbZr+8SRY=;
        b=EsL54MmMG5SKKbH2KJWklYr+4ydgltbH++lpIXGVgNk3o2Gr/fY/xHlMLqeOYI1TPC
         AhzlkDrjyXlGb0RZt/xzlbvT9zA5c01f7xEVckHCBfzd25ATATYZlSmqbkr/jsjE5wbT
         ksRTZHNvu56sQikovfx6CVTOTC3R5e9toRNZDZHj/6LjgCjdo0E7DzhhANuKsncnPG20
         jj0IB2cMoUhkoqyR4xz2QGOTHX5Jn1/SuQ7PfO2t0JGd5FiOmJxrG8/9TyPj1vqv9iXx
         H7CkjHoihlyzRvDqZ5SziWw+/IQ5d9s5V2jZ2gTe7q6Dz91m6wv/o8iwJPN4e9fHbSWJ
         GGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YiKDPZAVuj+rtPOroUOUnVyZ3NsBlXSRcAAbZr+8SRY=;
        b=bvl+5rtNuAUhJ5uvm+PzxSvGjYp6oPWgbtwRDEku324XJCtkGd8sMtoLuwE9OOgzvM
         fzszkqLQIQ2AJqHAfJxIn574bwyVPkZOAZsByVb6oA2PzE0IyZHKemyRtzepT7Relsh3
         ArkaPfFs1PWTAjf0bxeV1B4RbnWbNUi7CZDZsCvWivJbDS6+GMbsDF8n198sYLQwdd0p
         HnDWDWXLejfHftZAZ+5HySD3CZBzTRo1bPZ/sYt39G2lwOCVuRc4LICPmdsxwNXhIO09
         OriVVH9lSmHe6uYZya+oVFPTZaYazcDGLPw+yQn2vDHD3B/XFD1ZuH/gnGzYv0+/XzbG
         T09A==
X-Gm-Message-State: AOAM532C14ugYNMwTm16XWZYK5VHVSrxxakjlUzQukKCL5ZiHToaghjp
        J1W0QYj1aNb2P6xAVc6EgBE=
X-Google-Smtp-Source: ABdhPJx3AUAer2LIsCC7nq7+b17seDuCuh1+OsfEExyvO32+SViQChXeHjbL2QdmJveTzdL1nRP1LQ==
X-Received: by 2002:a17:907:2058:: with SMTP id pg24mr77914815ejb.79.1594646594813;
        Mon, 13 Jul 2020 06:23:14 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
        by smtp.gmail.com with ESMTPSA id n9sm11806540edr.46.2020.07.13.06.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 06:23:14 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org, Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [RFC PATCH 28/35] mips: Change PCIBIOS_SUCCESSFUL to 0
Date:   Mon, 13 Jul 2020 14:22:40 +0200
Message-Id: <20200713122247.10985-29-refactormyself@gmail.com>
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
 arch/mips/pci/fixup-ath79.c      |  2 +-
 arch/mips/pci/ops-bcm63xx.c      | 14 +++++++-------
 arch/mips/pci/ops-bonito64.c     |  4 ++--
 arch/mips/pci/ops-gt64xxx_pci0.c |  4 ++--
 arch/mips/pci/ops-lantiq.c       |  4 ++--
 arch/mips/pci/ops-loongson2.c    |  4 ++--
 arch/mips/pci/ops-mace.c         |  4 ++--
 arch/mips/pci/ops-msc.c          |  4 ++--
 arch/mips/pci/ops-rc32434.c      |  6 +++---
 arch/mips/pci/ops-sni.c          |  4 ++--
 arch/mips/pci/ops-tx3927.c       |  2 +-
 arch/mips/pci/ops-tx4927.c       |  2 +-
 arch/mips/pci/ops-vr41xx.c       |  4 ++--
 arch/mips/pci/pci-alchemy.c      |  6 +++---
 arch/mips/pci/pci-ar2315.c       |  4 ++--
 arch/mips/pci/pci-ar71xx.c       |  4 ++--
 arch/mips/pci/pci-ar724x.c       |  6 +++---
 arch/mips/pci/pci-bcm1480.c      |  4 ++--
 arch/mips/pci/pci-bcm1480ht.c    |  4 ++--
 arch/mips/pci/pci-mt7620.c       |  4 ++--
 arch/mips/pci/pci-octeon.c       | 12 ++++++------
 arch/mips/pci/pci-rt2880.c       |  4 ++--
 arch/mips/pci/pci-rt3883.c       |  4 ++--
 arch/mips/pci/pci-sb1250.c       |  4 ++--
 arch/mips/pci/pci-virtio-guest.c |  4 ++--
 arch/mips/pci/pci-xlp.c          |  4 ++--
 arch/mips/pci/pci-xlr.c          |  4 ++--
 arch/mips/pci/pci-xtalk-bridge.c | 14 +++++++-------
 arch/mips/pci/pcie-octeon.c      |  4 ++--
 arch/mips/txx9/generic/pci.c     |  4 ++--
 30 files changed, 74 insertions(+), 74 deletions(-)

diff --git a/arch/mips/pci/fixup-ath79.c b/arch/mips/pci/fixup-ath79.c
index 09a4ce53424f..6a6c4f58f7f4 100644
--- a/arch/mips/pci/fixup-ath79.c
+++ b/arch/mips/pci/fixup-ath79.c
@@ -9,7 +9,7 @@
 
 int pcibios_plat_dev_init(struct pci_dev *dev)
 {
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
diff --git a/arch/mips/pci/ops-bcm63xx.c b/arch/mips/pci/ops-bcm63xx.c
index dc6dc2741272..3e88e4869f37 100644
--- a/arch/mips/pci/ops-bcm63xx.c
+++ b/arch/mips/pci/ops-bcm63xx.c
@@ -115,7 +115,7 @@ static int bcm63xx_do_cfg_read(int type, unsigned int busn,
 
 	*val = postprocess_read(data, where, size);
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int bcm63xx_do_cfg_write(int type, unsigned int busn,
@@ -141,7 +141,7 @@ static int bcm63xx_do_cfg_write(int type, unsigned int busn,
 	/* restore IO space normal behaviour */
 	bcm_mpi_writel(0, MPI_L2PCFG_REG);
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int bcm63xx_pci_read(struct pci_bus *bus, unsigned int devfn,
@@ -282,7 +282,7 @@ static int fake_cb_bridge_read(int where, int size, u32 *val)
 	}
 
 	*val = postprocess_read(data, where, size);
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 /*
@@ -295,7 +295,7 @@ static int fake_cb_bridge_write(int where, int size, u32 val)
 	int ret;
 
 	ret = fake_cb_bridge_read((where & ~0x3), 4, &data);
-	if (ret != PCIBIOS_SUCCESSFUL)
+	if (ret != 0)
 		return ret;
 
 	data = preprocess_write(data, val, where, size);
@@ -356,7 +356,7 @@ static int fake_cb_bridge_write(int where, int size, u32 val)
 		break;
 	}
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int bcm63xx_cb_read(struct pci_bus *bus, unsigned int devfn,
@@ -496,7 +496,7 @@ static int bcm63xx_pcie_read(struct pci_bus *bus, unsigned int devfn,
 
 	*val = postprocess_read(data, where, size);
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 
 }
 
@@ -518,7 +518,7 @@ static int bcm63xx_pcie_write(struct pci_bus *bus, unsigned int devfn,
 	data = preprocess_write(data, val, where, size);
 	bcm_pcie_writel(data, reg);
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 
diff --git a/arch/mips/pci/ops-bonito64.c b/arch/mips/pci/ops-bonito64.c
index 4d5fe614f55e..0d0a5d52dee6 100644
--- a/arch/mips/pci/ops-bonito64.c
+++ b/arch/mips/pci/ops-bonito64.c
@@ -107,7 +107,7 @@ static int bonito64_pcibios_read(struct pci_bus *bus, unsigned int devfn,
 	else
 		*val = data;
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int bonito64_pcibios_write(struct pci_bus *bus, unsigned int devfn,
@@ -139,7 +139,7 @@ static int bonito64_pcibios_write(struct pci_bus *bus, unsigned int devfn,
 				       &data))
 		return -1;
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 struct pci_ops bonito64_pci_ops = {
diff --git a/arch/mips/pci/ops-gt64xxx_pci0.c b/arch/mips/pci/ops-gt64xxx_pci0.c
index 501dcdf5a18c..d50a0ac0848d 100644
--- a/arch/mips/pci/ops-gt64xxx_pci0.c
+++ b/arch/mips/pci/ops-gt64xxx_pci0.c
@@ -104,7 +104,7 @@ static int gt64xxx_pci0_pcibios_read(struct pci_bus *bus, unsigned int devfn,
 	else
 		*val = data;
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int gt64xxx_pci0_pcibios_write(struct pci_bus *bus, unsigned int devfn,
@@ -131,7 +131,7 @@ static int gt64xxx_pci0_pcibios_write(struct pci_bus *bus, unsigned int devfn,
 					       where, &data))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 struct pci_ops gt64xxx_pci0_ops = {
diff --git a/arch/mips/pci/ops-lantiq.c b/arch/mips/pci/ops-lantiq.c
index 7d71355394a6..9e9fd1c01199 100644
--- a/arch/mips/pci/ops-lantiq.c
+++ b/arch/mips/pci/ops-lantiq.c
@@ -83,7 +83,7 @@ int ltq_pci_read_config_dword(struct pci_bus *bus, unsigned int devfn,
 	else
 		*val = data;
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 int ltq_pci_write_config_dword(struct pci_bus *bus, unsigned int devfn,
@@ -109,5 +109,5 @@ int ltq_pci_write_config_dword(struct pci_bus *bus, unsigned int devfn,
 	if (ltq_pci_config_access(PCI_ACCESS_WRITE, bus, devfn, where, &data))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
diff --git a/arch/mips/pci/ops-loongson2.c b/arch/mips/pci/ops-loongson2.c
index 0d1b36ba1c21..79d7ad3aa19f 100644
--- a/arch/mips/pci/ops-loongson2.c
+++ b/arch/mips/pci/ops-loongson2.c
@@ -136,7 +136,7 @@ static int loongson_pcibios_read(struct pci_bus *bus, unsigned int devfn,
 	else
 		*val = data;
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int loongson_pcibios_write(struct pci_bus *bus, unsigned int devfn,
@@ -168,7 +168,7 @@ static int loongson_pcibios_write(struct pci_bus *bus, unsigned int devfn,
 				       &data))
 		return -1;
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 struct pci_ops loongson_pci_ops = {
diff --git a/arch/mips/pci/ops-mace.c b/arch/mips/pci/ops-mace.c
index 951d8070fb48..1593514d71f8 100644
--- a/arch/mips/pci/ops-mace.c
+++ b/arch/mips/pci/ops-mace.c
@@ -69,7 +69,7 @@ mace_pci_read_config(struct pci_bus *bus, unsigned int devfn,
 
 	DPRINTK("read%d: reg=%08x,val=%02x\n", size * 8, reg, *val);
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int
@@ -91,7 +91,7 @@ mace_pci_write_config(struct pci_bus *bus, unsigned int devfn,
 
 	DPRINTK("write%d: reg=%08x,val=%02x\n", size * 8, reg, val);
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 struct pci_ops mace_pci_ops = {
diff --git a/arch/mips/pci/ops-msc.c b/arch/mips/pci/ops-msc.c
index 1f438baaf907..722a7992d7b5 100644
--- a/arch/mips/pci/ops-msc.c
+++ b/arch/mips/pci/ops-msc.c
@@ -93,7 +93,7 @@ static int msc_pcibios_read(struct pci_bus *bus, unsigned int devfn,
 	else
 		*val = data;
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int msc_pcibios_write(struct pci_bus *bus, unsigned int devfn,
@@ -125,7 +125,7 @@ static int msc_pcibios_write(struct pci_bus *bus, unsigned int devfn,
 				       &data))
 		return -1;
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 struct pci_ops msc_pci_ops = {
diff --git a/arch/mips/pci/ops-rc32434.c b/arch/mips/pci/ops-rc32434.c
index 874ed6df9768..52714e58572d 100644
--- a/arch/mips/pci/ops-rc32434.c
+++ b/arch/mips/pci/ops-rc32434.c
@@ -140,7 +140,7 @@ write_config_byte(struct pci_bus *bus, unsigned int devfn, int where,
 	if (config_access(PCI_ACCESS_WRITE, bus, devfn, where, &data))
 		return -1;
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 
@@ -160,7 +160,7 @@ write_config_word(struct pci_bus *bus, unsigned int devfn, int where,
 		return -1;
 
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 
@@ -171,7 +171,7 @@ write_config_dword(struct pci_bus *bus, unsigned int devfn, int where,
 	if (config_access(PCI_ACCESS_WRITE, bus, devfn, where, &val))
 		return -1;
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int pci_config_read(struct pci_bus *bus, unsigned int devfn,
diff --git a/arch/mips/pci/ops-sni.c b/arch/mips/pci/ops-sni.c
index 35daa7fe6571..27468a603470 100644
--- a/arch/mips/pci/ops-sni.c
+++ b/arch/mips/pci/ops-sni.c
@@ -34,7 +34,7 @@ static int set_config_address(unsigned int busno, unsigned int devfn, int reg)
 		 ((devfn    & 0xff) <<	8) |
 		  (reg	    & 0xfc);
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int pcimt_read(struct pci_bus *bus, unsigned int devfn, int reg,
@@ -94,7 +94,7 @@ static int pcit_set_config_address(unsigned int busno, unsigned int devfn, int r
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
 	outl((1 << 31) | ((busno & 0xff) << 16) | ((devfn & 0xff) << 8) | (reg & 0xfc), 0xcf8);
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int pcit_read(struct pci_bus *bus, unsigned int devfn, int reg,
diff --git a/arch/mips/pci/ops-tx3927.c b/arch/mips/pci/ops-tx3927.c
index d35dc9c9ab9d..7fe187879897 100644
--- a/arch/mips/pci/ops-tx3927.c
+++ b/arch/mips/pci/ops-tx3927.c
@@ -70,7 +70,7 @@ static inline int check_abort(void)
 		iob();
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int tx3927_pci_read_config(struct pci_bus *bus, unsigned int devfn,
diff --git a/arch/mips/pci/ops-tx4927.c b/arch/mips/pci/ops-tx4927.c
index f7802f100401..1b3cea631448 100644
--- a/arch/mips/pci/ops-tx4927.c
+++ b/arch/mips/pci/ops-tx4927.c
@@ -74,7 +74,7 @@ static int mkaddr(struct pci_bus *bus, unsigned int devfn, int where,
 
 static int check_abort(struct tx4927_pcic_reg __iomem *pcicptr)
 {
-	int code = PCIBIOS_SUCCESSFUL;
+	int code = 0;
 
 	/* wait write cycle completion before checking error status */
 	while (__raw_readl(&pcicptr->pcicstatus) & TX4927_PCIC_PCICSTATUS_IWB)
diff --git a/arch/mips/pci/ops-vr41xx.c b/arch/mips/pci/ops-vr41xx.c
index 7b7709aa14c7..f54cb555c743 100644
--- a/arch/mips/pci/ops-vr41xx.c
+++ b/arch/mips/pci/ops-vr41xx.c
@@ -70,7 +70,7 @@ static int pci_config_read(struct pci_bus *bus, unsigned int devfn, int where,
 		return PCIBIOS_FUNC_NOT_SUPPORTED;
 	}
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int pci_config_write(struct pci_bus *bus, unsigned int devfn, int where,
@@ -104,7 +104,7 @@ static int pci_config_write(struct pci_bus *bus, unsigned int devfn, int where,
 
 	writel(data, PCICONFDREG);
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 struct pci_ops vr41xx_pci_ops = {
diff --git a/arch/mips/pci/pci-alchemy.c b/arch/mips/pci/pci-alchemy.c
index 7285b5667568..937f912fba20 100644
--- a/arch/mips/pci/pci-alchemy.c
+++ b/arch/mips/pci/pci-alchemy.c
@@ -103,7 +103,7 @@ static int config_access(unsigned char access_type, struct pci_bus *bus,
 	unsigned int device = PCI_SLOT(dev_fn);
 	unsigned int function = PCI_FUNC(dev_fn);
 	unsigned long offset, status, cfg_base, flags, entryLo0, entryLo1, r;
-	int error = PCIBIOS_SUCCESSFUL;
+	int error = 0;
 
 	if (device > 19) {
 		*data = 0xffffffff;
@@ -231,7 +231,7 @@ static int write_config_byte(struct pci_bus *bus, unsigned int devfn,
 	if (config_access(PCI_ACCESS_WRITE, bus, devfn, where, &data))
 		return -1;
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int write_config_word(struct pci_bus *bus, unsigned int devfn,
@@ -248,7 +248,7 @@ static int write_config_word(struct pci_bus *bus, unsigned int devfn,
 	if (config_access(PCI_ACCESS_WRITE, bus, devfn, where, &data))
 		return -1;
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int write_config_dword(struct pci_bus *bus, unsigned int devfn,
diff --git a/arch/mips/pci/pci-ar2315.c b/arch/mips/pci/pci-ar2315.c
index 490953f51528..2268b63d20e8 100644
--- a/arch/mips/pci/pci-ar2315.c
+++ b/arch/mips/pci/pci-ar2315.c
@@ -260,7 +260,7 @@ static int ar2315_pci_cfg_access(struct ar2315_pci_ctrl *apc, unsigned devfn,
 			    0);
 
 	return isr & AR2315_PCI_INT_ABORT ? PCIBIOS_DEVICE_NOT_FOUND :
-					    PCIBIOS_SUCCESSFUL;
+					    0;
 }
 
 static inline int ar2315_pci_local_cfg_rd(struct ar2315_pci_ctrl *apc,
@@ -311,7 +311,7 @@ static int ar2315_pci_host_setup(struct ar2315_pci_ctrl *apc)
 	u32 id;
 
 	res = ar2315_pci_local_cfg_rd(apc, devfn, PCI_VENDOR_ID, &id);
-	if (res != PCIBIOS_SUCCESSFUL || id != AR2315_PCI_HOST_DEVID)
+	if (res != 0 || id != AR2315_PCI_HOST_DEVID)
 		return -ENODEV;
 
 	/* Program MBARs */
diff --git a/arch/mips/pci/pci-ar71xx.c b/arch/mips/pci/pci-ar71xx.c
index a9f8e7c881bd..4216162858b1 100644
--- a/arch/mips/pci/pci-ar71xx.c
+++ b/arch/mips/pci/pci-ar71xx.c
@@ -182,7 +182,7 @@ static int ar71xx_pci_read_config(struct pci_bus *bus, unsigned int devfn,
 	int err;
 	int ret;
 
-	ret = PCIBIOS_SUCCESSFUL;
+	ret = 0;
 	data = ~0;
 
 	err = ar71xx_pci_set_cfgaddr(bus, devfn, where, size,
@@ -206,7 +206,7 @@ static int ar71xx_pci_write_config(struct pci_bus *bus, unsigned int devfn,
 	int ret;
 
 	value = value << (8 * (where & 3));
-	ret = PCIBIOS_SUCCESSFUL;
+	ret = 0;
 
 	err = ar71xx_pci_set_cfgaddr(bus, devfn, where, size,
 				     AR71XX_PCI_CFG_CMD_WRITE);
diff --git a/arch/mips/pci/pci-ar724x.c b/arch/mips/pci/pci-ar724x.c
index 869d5c9a2f8d..09c607b82cfc 100644
--- a/arch/mips/pci/pci-ar724x.c
+++ b/arch/mips/pci/pci-ar724x.c
@@ -107,7 +107,7 @@ static int ar724x_pci_local_write(struct ar724x_pci_controller *apc,
 	/* flush write */
 	__raw_readl(base + (where & ~3));
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int ar724x_pci_read(struct pci_bus *bus, unsigned int devfn, int where,
@@ -154,7 +154,7 @@ static int ar724x_pci_read(struct pci_bus *bus, unsigned int devfn, int where,
 		*value = data;
 	}
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int ar724x_pci_write(struct pci_bus *bus, unsigned int devfn, int where,
@@ -218,7 +218,7 @@ static int ar724x_pci_write(struct pci_bus *bus, unsigned int devfn, int where,
 	/* flush write */
 	__raw_readl(base + (where & ~3));
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static struct pci_ops ar724x_pci_ops = {
diff --git a/arch/mips/pci/pci-bcm1480.c b/arch/mips/pci/pci-bcm1480.c
index db0d4d22d46f..614f82cb42d2 100644
--- a/arch/mips/pci/pci-bcm1480.c
+++ b/arch/mips/pci/pci-bcm1480.c
@@ -126,7 +126,7 @@ static int bcm1480_pcibios_read(struct pci_bus *bus, unsigned int devfn,
 	else
 		*val = data;
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int bcm1480_pcibios_write(struct pci_bus *bus, unsigned int devfn,
@@ -156,7 +156,7 @@ static int bcm1480_pcibios_write(struct pci_bus *bus, unsigned int devfn,
 
 	WRITECFG32(cfgaddr, data);
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 struct pci_ops bcm1480_pci_ops = {
diff --git a/arch/mips/pci/pci-bcm1480ht.c b/arch/mips/pci/pci-bcm1480ht.c
index 3d996acd294c..249b54c499b4 100644
--- a/arch/mips/pci/pci-bcm1480ht.c
+++ b/arch/mips/pci/pci-bcm1480ht.c
@@ -115,7 +115,7 @@ static int bcm1480ht_pcibios_read(struct pci_bus *bus, unsigned int devfn,
 	else
 		*val = data;
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int bcm1480ht_pcibios_write(struct pci_bus *bus, unsigned int devfn,
@@ -145,7 +145,7 @@ static int bcm1480ht_pcibios_write(struct pci_bus *bus, unsigned int devfn,
 
 	WRITECFG32(cfgaddr, data);
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int bcm1480ht_pcibios_get_busno(void)
diff --git a/arch/mips/pci/pci-mt7620.c b/arch/mips/pci/pci-mt7620.c
index d36061603752..669347689d84 100644
--- a/arch/mips/pci/pci-mt7620.c
+++ b/arch/mips/pci/pci-mt7620.c
@@ -162,7 +162,7 @@ static int pci_config_read(struct pci_bus *bus, unsigned int devfn, int where,
 		break;
 	}
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int pci_config_write(struct pci_bus *bus, unsigned int devfn, int where,
@@ -198,7 +198,7 @@ static int pci_config_write(struct pci_bus *bus, unsigned int devfn, int where,
 
 	bridge_w32(data, RALINK_PCI_CONFIG_DATA_VIRT_REG);
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 struct pci_ops mt7620_pci_ops = {
diff --git a/arch/mips/pci/pci-octeon.c b/arch/mips/pci/pci-octeon.c
index fc29b85cfa92..be6d0bf3aca4 100644
--- a/arch/mips/pci/pci-octeon.c
+++ b/arch/mips/pci/pci-octeon.c
@@ -273,13 +273,13 @@ static int octeon_read_config(struct pci_bus *bus, unsigned int devfn,
 	switch (size) {
 	case 4:
 		*val = le32_to_cpu(cvmx_read64_uint32(pci_addr.u64));
-		return PCIBIOS_SUCCESSFUL;
+		return 0;
 	case 2:
 		*val = le16_to_cpu(cvmx_read64_uint16(pci_addr.u64));
-		return PCIBIOS_SUCCESSFUL;
+		return 0;
 	case 1:
 		*val = cvmx_read64_uint8(pci_addr.u64);
-		return PCIBIOS_SUCCESSFUL;
+		return 0;
 	}
 	return PCIBIOS_FUNC_NOT_SUPPORTED;
 }
@@ -307,13 +307,13 @@ static int octeon_write_config(struct pci_bus *bus, unsigned int devfn,
 	switch (size) {
 	case 4:
 		cvmx_write64_uint32(pci_addr.u64, cpu_to_le32(val));
-		return PCIBIOS_SUCCESSFUL;
+		return 0;
 	case 2:
 		cvmx_write64_uint16(pci_addr.u64, cpu_to_le16(val));
-		return PCIBIOS_SUCCESSFUL;
+		return 0;
 	case 1:
 		cvmx_write64_uint8(pci_addr.u64, val);
-		return PCIBIOS_SUCCESSFUL;
+		return 0;
 	}
 	return PCIBIOS_FUNC_NOT_SUPPORTED;
 }
diff --git a/arch/mips/pci/pci-rt2880.c b/arch/mips/pci/pci-rt2880.c
index e1f12e398136..4f4774c2c777 100644
--- a/arch/mips/pci/pci-rt2880.c
+++ b/arch/mips/pci/pci-rt2880.c
@@ -87,7 +87,7 @@ static int rt2880_pci_config_read(struct pci_bus *bus, unsigned int devfn,
 		break;
 	}
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int rt2880_pci_config_write(struct pci_bus *bus, unsigned int devfn,
@@ -121,7 +121,7 @@ static int rt2880_pci_config_write(struct pci_bus *bus, unsigned int devfn,
 	rt2880_pci_reg_write(data, RT2880_PCI_REG_CONFIG_DATA);
 	spin_unlock_irqrestore(&rt2880_pci_lock, flags);
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static struct pci_ops rt2880_pci_ops = {
diff --git a/arch/mips/pci/pci-rt3883.c b/arch/mips/pci/pci-rt3883.c
index 0ac6346026d0..cb160ba7480f 100644
--- a/arch/mips/pci/pci-rt3883.c
+++ b/arch/mips/pci/pci-rt3883.c
@@ -256,7 +256,7 @@ static int rt3883_pci_config_read(struct pci_bus *bus, unsigned int devfn,
 		break;
 	}
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int rt3883_pci_config_write(struct pci_bus *bus, unsigned int devfn,
@@ -294,7 +294,7 @@ static int rt3883_pci_config_write(struct pci_bus *bus, unsigned int devfn,
 
 	rt3883_pci_w32(rpc, data, RT3883_PCI_REG_CFGDATA);
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static struct pci_ops rt3883_pci_ops = {
diff --git a/arch/mips/pci/pci-sb1250.c b/arch/mips/pci/pci-sb1250.c
index c3f82b280484..7f0fd484ef85 100644
--- a/arch/mips/pci/pci-sb1250.c
+++ b/arch/mips/pci/pci-sb1250.c
@@ -135,7 +135,7 @@ static int sb1250_pcibios_read(struct pci_bus *bus, unsigned int devfn,
 	else
 		*val = data;
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int sb1250_pcibios_write(struct pci_bus *bus, unsigned int devfn,
@@ -165,7 +165,7 @@ static int sb1250_pcibios_write(struct pci_bus *bus, unsigned int devfn,
 
 	WRITECFG32(cfgaddr, data);
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 struct pci_ops sb1250_pci_ops = {
diff --git a/arch/mips/pci/pci-virtio-guest.c b/arch/mips/pci/pci-virtio-guest.c
index 40a078bc4617..fb67b009b2cb 100644
--- a/arch/mips/pci/pci-virtio-guest.c
+++ b/arch/mips/pci/pci-virtio-guest.c
@@ -70,7 +70,7 @@ static int pci_virtio_guest_write_config(struct pci_bus *bus,
 		break;
 	}
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int pci_virtio_guest_read_config(struct pci_bus *bus, unsigned int devfn,
@@ -89,7 +89,7 @@ static int pci_virtio_guest_read_config(struct pci_bus *bus, unsigned int devfn,
 		*val = inl(PCI_CONFIG_DATA);
 		break;
 	}
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static struct pci_ops pci_virtio_guest_ops = {
diff --git a/arch/mips/pci/pci-xlp.c b/arch/mips/pci/pci-xlp.c
index 9eff9137f78e..75ea7d85913c 100644
--- a/arch/mips/pci/pci-xlp.c
+++ b/arch/mips/pci/pci-xlp.c
@@ -118,7 +118,7 @@ static int nlm_pcibios_read(struct pci_bus *bus, unsigned int devfn,
 	else
 		*val = data;
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 
@@ -145,7 +145,7 @@ static int nlm_pcibios_write(struct pci_bus *bus, unsigned int devfn,
 
 	pci_cfg_write_32bit(bus, devfn, where, data);
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 struct pci_ops nlm_pci_ops = {
diff --git a/arch/mips/pci/pci-xlr.c b/arch/mips/pci/pci-xlr.c
index 2a1c81a129ba..b6c72ac170d9 100644
--- a/arch/mips/pci/pci-xlr.c
+++ b/arch/mips/pci/pci-xlr.c
@@ -100,7 +100,7 @@ static int nlm_pcibios_read(struct pci_bus *bus, unsigned int devfn,
 	else
 		*val = data;
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 
@@ -127,7 +127,7 @@ static int nlm_pcibios_write(struct pci_bus *bus, unsigned int devfn,
 
 	pci_cfg_write_32bit(bus, devfn, where, data);
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 struct pci_ops nlm_pci_ops = {
diff --git a/arch/mips/pci/pci-xtalk-bridge.c b/arch/mips/pci/pci-xtalk-bridge.c
index 3b2552fb7735..101b18cd8817 100644
--- a/arch/mips/pci/pci-xtalk-bridge.c
+++ b/arch/mips/pci/pci-xtalk-bridge.c
@@ -67,7 +67,7 @@ static int ioc3_cfg_rd(void *addr, int where, int size, u32 *value, u32 sid)
 	mask = 0xffffffffU >> ((4 - size) << 3);
 	*value = (cf >> shift) & mask;
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int ioc3_cfg_wr(void *addr, int where, int size, u32 value)
@@ -75,7 +75,7 @@ static int ioc3_cfg_wr(void *addr, int where, int size, u32 value)
 	u32 cf, shift, mask, smask;
 
 	if ((where >= 0x14 && where < 0x40) || (where >= 0x48))
-		return PCIBIOS_SUCCESSFUL;
+		return 0;
 
 	if (get_dbe(cf, (u32 *)addr))
 		return PCIBIOS_DEVICE_NOT_FOUND;
@@ -88,7 +88,7 @@ static int ioc3_cfg_wr(void *addr, int where, int size, u32 value)
 	if (put_dbe(cf, (u32 *)addr))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static void bridge_disable_swapping(struct pci_dev *dev)
@@ -149,7 +149,7 @@ static int pci_conf0_read_config(struct pci_bus *bus, unsigned int devfn,
 	else
 		res = get_dbe(*value, (u32 *)addr);
 
-	return res ? PCIBIOS_DEVICE_NOT_FOUND : PCIBIOS_SUCCESSFUL;
+	return res ? PCIBIOS_DEVICE_NOT_FOUND : 0;
 }
 
 static int pci_conf1_read_config(struct pci_bus *bus, unsigned int devfn,
@@ -188,7 +188,7 @@ static int pci_conf1_read_config(struct pci_bus *bus, unsigned int devfn,
 	else
 		res = get_dbe(*value, (u32 *)addr);
 
-	return res ? PCIBIOS_DEVICE_NOT_FOUND : PCIBIOS_SUCCESSFUL;
+	return res ? PCIBIOS_DEVICE_NOT_FOUND : 0;
 }
 
 static int pci_read_config(struct pci_bus *bus, unsigned int devfn,
@@ -236,7 +236,7 @@ static int pci_conf0_write_config(struct pci_bus *bus, unsigned int devfn,
 	if (res)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int pci_conf1_write_config(struct pci_bus *bus, unsigned int devfn,
@@ -277,7 +277,7 @@ static int pci_conf1_write_config(struct pci_bus *bus, unsigned int devfn,
 	if (res)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int pci_write_config(struct pci_bus *bus, unsigned int devfn,
diff --git a/arch/mips/pci/pcie-octeon.c b/arch/mips/pci/pcie-octeon.c
index d919a0d813a1..11e9ed38ca2b 100644
--- a/arch/mips/pci/pcie-octeon.c
+++ b/arch/mips/pci/pcie-octeon.c
@@ -1703,7 +1703,7 @@ static int octeon_pcie_read_config(unsigned int pcie_port, struct pci_bus *bus,
 	if (OCTEON_IS_MODEL(OCTEON_CN56XX_PASS1) ||
 	    OCTEON_IS_MODEL(OCTEON_CN56XX_PASS1_1))
 		write_c0_cvmmemctl(cvmmemctl_save.u64);
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int octeon_pcie0_read_config(struct pci_bus *bus, unsigned int devfn,
@@ -1759,7 +1759,7 @@ static int octeon_pcie_write_config(unsigned int pcie_port, struct pci_bus *bus,
 	default:
 		return PCIBIOS_FUNC_NOT_SUPPORTED;
 	}
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int octeon_pcie0_write_config(struct pci_bus *bus, unsigned int devfn,
diff --git a/arch/mips/txx9/generic/pci.c b/arch/mips/txx9/generic/pci.c
index fb998726bd5d..bdff45b6b57d 100644
--- a/arch/mips/txx9/generic/pci.c
+++ b/arch/mips/txx9/generic/pci.c
@@ -62,7 +62,7 @@ int __init txx9_pci66_check(struct pci_controller *hose, int top_bus,
 			continue;
 		if (early_read_config_word(hose, top_bus, current_bus,
 					   pci_devfn, PCI_VENDOR_ID, &vid) !=
-		    PCIBIOS_SUCCESSFUL)
+		    0)
 			continue;
 		if (vid == 0xffff)
 			continue;
@@ -346,7 +346,7 @@ static void final_fixup(struct pci_dev *dev)
 	unsigned char bist;
 
 	/* Do build-in self test */
-	if (pci_read_config_byte(dev, PCI_BIST, &bist) == PCIBIOS_SUCCESSFUL &&
+	if (pci_read_config_byte(dev, PCI_BIST, &bist) == 0 &&
 	    (bist & PCI_BIST_CAPABLE)) {
 		unsigned long timeout;
 		pci_set_power_state(dev, PCI_D0);
-- 
2.18.2

