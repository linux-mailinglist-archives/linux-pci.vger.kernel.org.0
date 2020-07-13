Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2DB21D705
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 15:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729893AbgGMNWq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 09:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729873AbgGMNWp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jul 2020 09:22:45 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40D5C061755;
        Mon, 13 Jul 2020 06:22:44 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id w6so17134671ejq.6;
        Mon, 13 Jul 2020 06:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U+4fgAl092jtpf8p0sVznNDqJH6s4jt37g7dyTJMbT4=;
        b=GeKR1wwQG/K1n4qF9XFSlFSzkaVyPMkd8BinPHhutRMJlF6usPHfpDeFKpKWpdFEHC
         0h95NiN2S2AmTQBzH80M78PHSIahI/tcCflBsQZpyaYkOuVh2yVYZ+UixlUJuMt+hPO6
         na8XFN6usT0qNDW1S5C+z2EdEshbJVZKxMUpAMKkl0GucN4BQFdfgRt9KavWcs5Bug+j
         9lc+xWBOwCBLZjjodCWx/Zx9F0a0UYWYivLHs1F2MMcYS/BALXoLjEZZHNdFO8AEOfOk
         x5jdjVAZYgPCY6D+ou6VAowrzYM4w1KwTh5T10OeLJdUZ6Zvcsen6kZWsgTyGnK5Gxi6
         e/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U+4fgAl092jtpf8p0sVznNDqJH6s4jt37g7dyTJMbT4=;
        b=djfq2/0U+OysOuaURNQtkVB9YKp2i/6FVAcn1+gniVEiSORcZ2K8S+BLr9vCBJSiTA
         OQtHfAwmjr8ZJPI8BtjHbpZRdJpC3eGv9U+H1ogua/7U9LnSzf5xLBrawd6JpvNre633
         TuTg59zN541mMvPLY7atAFSulHl5JYNFEukLjjam+H01c3fjijuIIw86GlnSU3tVXHZ0
         6XmDNNvZCvq8mMky+meWEetJRPxEaFNGD11Ta5KZ1YWCkjmVu5Fx71HeFs7KER95h9Xu
         tU48IBWMdvbqJL5Yd1Z/EhInIXfBBQPLPay3sgiFQ1qgSUFpxVHt+fdZZmbeSX5jxfsd
         AkpQ==
X-Gm-Message-State: AOAM531tteCnu6q/4p+Dq40ANN5Yx/ldZ7soxrbmAQuGslWSMuUN56ug
        94sTGvKJWHbkw3+9ICyJj6czNTJSxJRWdA==
X-Google-Smtp-Source: ABdhPJztyeurCQmHlxNniEhwD0qLqlX0SG+kgarnE5HX7VAl7vYbh07uZ079fvI7dqpSfYl6niKNmg==
X-Received: by 2002:a17:906:9387:: with SMTP id l7mr70960800ejx.274.1594646563415;
        Mon, 13 Jul 2020 06:22:43 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
        by smtp.gmail.com with ESMTPSA id n9sm11806540edr.46.2020.07.13.06.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 06:22:42 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org, Yue Wang <yue.wang@Amlogic.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Toan Le <toan@os.amperecomputing.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, rfi@lists.rocketboards.org,
        linux-renesas-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 05/35] PCI: Change PCIBIOS_SUCCESSFUL to 0
Date:   Mon, 13 Jul 2020 14:22:17 +0200
Message-Id: <20200713122247.10985-6-refactormyself@gmail.com>
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
 drivers/pci/controller/dwc/pci-meson.c        |  4 +--
 .../pci/controller/dwc/pcie-designware-host.c |  2 +-
 drivers/pci/controller/dwc/pcie-designware.c  |  4 +--
 drivers/pci/controller/dwc/pcie-hisi.c        |  4 +--
 drivers/pci/controller/dwc/pcie-tegra194.c    |  4 +--
 .../pci/controller/mobiveil/pcie-mobiveil.c   |  4 +--
 drivers/pci/controller/pci-aardvark.c         |  4 +--
 drivers/pci/controller/pci-ftpci100.c         |  4 +--
 drivers/pci/controller/pci-hyperv.c           |  8 ++---
 drivers/pci/controller/pci-mvebu.c            |  4 +--
 drivers/pci/controller/pci-thunder-ecam.c     | 36 +++++++++----------
 drivers/pci/controller/pci-thunder-pem.c      |  4 +--
 drivers/pci/controller/pci-xgene.c            |  4 +--
 drivers/pci/controller/pcie-altera.c          | 16 ++++-----
 drivers/pci/controller/pcie-iproc.c           | 10 +++---
 drivers/pci/controller/pcie-mediatek.c        |  4 +--
 drivers/pci/controller/pcie-rcar-host.c       |  8 ++---
 drivers/pci/controller/pcie-rockchip-host.c   | 10 +++---
 18 files changed, 67 insertions(+), 67 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index ca59ba9e0ecd..58142f03d300 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -390,7 +390,7 @@ static int meson_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
 	int ret;
 
 	ret = dw_pcie_read(pci->dbi_base + where, size, val);
-	if (ret != PCIBIOS_SUCCESSFUL)
+	if (ret != 0)
 		return ret;
 
 	/*
@@ -407,7 +407,7 @@ static int meson_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
 	else if (where == PCI_CLASS_DEVICE + 1 && size == 1)
 		*val = (PCI_CLASS_BRIDGE_PCI >> 8) & 0xff;
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int meson_pcie_wr_own_conf(struct pcie_port *pp, int where,
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 0a4a5aa6fe46..7c97c54f787c 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -459,7 +459,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	}
 
 	ret = dw_pcie_rd_own_conf(pp, PCI_HEADER_TYPE, 1, &hdr_type);
-	if (ret != PCIBIOS_SUCCESSFUL) {
+	if (ret != 0) {
 		dev_err(pci->dev, "Failed reading PCI_HEADER_TYPE cfg space reg (ret: 0x%x)\n",
 			ret);
 		ret = pcibios_err_to_errno(ret);
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index c92496e36fd5..2494e1be1f96 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -113,7 +113,7 @@ int dw_pcie_read(void __iomem *addr, int size, u32 *val)
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 	}
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(dw_pcie_read);
 
@@ -131,7 +131,7 @@ int dw_pcie_write(void __iomem *addr, int size, u32 val)
 	else
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(dw_pcie_write);
 
diff --git a/drivers/pci/controller/dwc/pcie-hisi.c b/drivers/pci/controller/dwc/pcie-hisi.c
index 0ad4e07dd4c2..10a46aded227 100644
--- a/drivers/pci/controller/dwc/pcie-hisi.c
+++ b/drivers/pci/controller/dwc/pcie-hisi.c
@@ -163,7 +163,7 @@ static int hisi_pcie_cfg_read(struct pcie_port *pp, int where, int size,
 	else
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 /* HipXX PCIe host only supports 32-bit config access */
@@ -190,7 +190,7 @@ static int hisi_pcie_cfg_write(struct pcie_port *pp, int where, int  size,
 	} else
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int hisi_pcie_link_up_hip05(struct hisi_pcie *hisi_pcie)
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 92b77f7d8354..34fe0084a4d1 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -581,7 +581,7 @@ static int tegra_pcie_dw_rd_own_conf(struct pcie_port *pp, int where, int size,
 	 */
 	if (where == PORT_LOGIC_MSIX_DOORBELL) {
 		*val = 0x00000000;
-		return PCIBIOS_SUCCESSFUL;
+		return 0;
 	}
 
 	return dw_pcie_read(pci->dbi_base + where, size, val);
@@ -599,7 +599,7 @@ static int tegra_pcie_dw_wr_own_conf(struct pcie_port *pp, int where, int size,
 	 * So skip accessing it altogether
 	 */
 	if (where == PORT_LOGIC_MSIX_DOORBELL)
-		return PCIBIOS_SUCCESSFUL;
+		return 0;
 
 	return dw_pcie_write(pci->dbi_base + where, size, val);
 }
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.c b/drivers/pci/controller/mobiveil/pcie-mobiveil.c
index 62ecbaeb0a60..f9f03b022d0e 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.c
@@ -71,7 +71,7 @@ static int mobiveil_pcie_read(void __iomem *addr, int size, u32 *val)
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 	}
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int mobiveil_pcie_write(void __iomem *addr, int size, u32 val)
@@ -93,7 +93,7 @@ static int mobiveil_pcie_write(void __iomem *addr, int size, u32 val)
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 	}
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 u32 mobiveil_csr_read(struct mobiveil_pcie *pcie, u32 off, size_t size)
diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 90ff291c24f0..b9a2d3359317 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -700,7 +700,7 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
 	else if (size == 2)
 		*val = (*val >> (8 * (where & 3))) & 0xffff;
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int advk_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
@@ -760,7 +760,7 @@ static int advk_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 
 	advk_pcie_check_pio_status(pcie);
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static struct pci_ops advk_pcie_ops = {
diff --git a/drivers/pci/controller/pci-ftpci100.c b/drivers/pci/controller/pci-ftpci100.c
index 1b67564de7af..449187e8c298 100644
--- a/drivers/pci/controller/pci-ftpci100.c
+++ b/drivers/pci/controller/pci-ftpci100.c
@@ -204,7 +204,7 @@ static int faraday_raw_pci_read_config(struct faraday_pci *p, int bus_number,
 	else if (size == 2)
 		*value = (*value >> (8 * (config & 3))) & 0xFFFF;
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int faraday_pci_read_config(struct pci_bus *bus, unsigned int fn,
@@ -223,7 +223,7 @@ static int faraday_raw_pci_write_config(struct faraday_pci *p, int bus_number,
 					 unsigned int fn, int config, int size,
 					 u32 value)
 {
-	int ret = PCIBIOS_SUCCESSFUL;
+	int ret = 0;
 
 	writel(PCI_CONF_BUS(bus_number) |
 			PCI_CONF_DEVICE(PCI_SLOT(fn)) |
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index bf40ff09c99d..b1552394e2d6 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -807,7 +807,7 @@ static void _hv_pcifront_write_config(struct hv_pci_dev *hpdev, int where,
  * @size: Byte/word/dword
  * @val: Value to be read
  *
- * Return: PCIBIOS_SUCCESSFUL on success
+ * Return: 0 on success
  *	   PCIBIOS_DEVICE_NOT_FOUND on failure
  */
 static int hv_pcifront_read_config(struct pci_bus *bus, unsigned int devfn,
@@ -824,7 +824,7 @@ static int hv_pcifront_read_config(struct pci_bus *bus, unsigned int devfn,
 	_hv_pcifront_read_config(hpdev, where, size, val);
 
 	put_pcichild(hpdev);
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 /**
@@ -835,7 +835,7 @@ static int hv_pcifront_read_config(struct pci_bus *bus, unsigned int devfn,
  * @size: Byte/word/dword
  * @val: Value to be written to device
  *
- * Return: PCIBIOS_SUCCESSFUL on success
+ * Return: 0 on success
  *	   PCIBIOS_DEVICE_NOT_FOUND on failure
  */
 static int hv_pcifront_write_config(struct pci_bus *bus, unsigned int devfn,
@@ -852,7 +852,7 @@ static int hv_pcifront_write_config(struct pci_bus *bus, unsigned int devfn,
 	_hv_pcifront_write_config(hpdev, where, size, val);
 
 	put_pcichild(hpdev);
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 /* PCIe operations */
diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 153a64676bc9..30ef5ece4a3b 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -246,7 +246,7 @@ static int mvebu_pcie_hw_rd_conf(struct mvebu_pcie_port *port,
 		break;
 	}
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int mvebu_pcie_hw_wr_conf(struct mvebu_pcie_port *port,
@@ -272,7 +272,7 @@ static int mvebu_pcie_hw_wr_conf(struct mvebu_pcie_port *port,
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 	}
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 /*
diff --git a/drivers/pci/controller/pci-thunder-ecam.c b/drivers/pci/controller/pci-thunder-ecam.c
index 7e8835fee5f7..8e30e1f9622e 100644
--- a/drivers/pci/controller/pci-thunder-ecam.c
+++ b/drivers/pci/controller/pci-thunder-ecam.c
@@ -37,7 +37,7 @@ static int handle_ea_bar(u32 e0, int bar, struct pci_bus *bus,
 
 	if (where_a == 0) {
 		set_val(e0, where, size, val);
-		return PCIBIOS_SUCCESSFUL;
+		return 0;
 	}
 	if (where_a == 0x4) {
 		addr = bus->ops->map_bus(bus, devfn, bar); /* BAR 0 */
@@ -49,7 +49,7 @@ static int handle_ea_bar(u32 e0, int bar, struct pci_bus *bus,
 		v &= ~0xf;
 		v |= 2; /* EA entry-1. Base-L */
 		set_val(v, where, size, val);
-		return PCIBIOS_SUCCESSFUL;
+		return 0;
 	}
 	if (where_a == 0x8) {
 		u32 barl_orig;
@@ -68,7 +68,7 @@ static int handle_ea_bar(u32 e0, int bar, struct pci_bus *bus,
 		v = ~barl_rb & ~3;
 		v |= 0xc; /* EA entry-2. Offset-L */
 		set_val(v, where, size, val);
-		return PCIBIOS_SUCCESSFUL;
+		return 0;
 	}
 	if (where_a == 0xc) {
 		addr = bus->ops->map_bus(bus, devfn, bar + 4); /* BAR 1 */
@@ -78,7 +78,7 @@ static int handle_ea_bar(u32 e0, int bar, struct pci_bus *bus,
 		}
 		v = readl(addr); /* EA entry-3. Base-H */
 		set_val(v, where, size, val);
-		return PCIBIOS_SUCCESSFUL;
+		return 0;
 	}
 	return PCIBIOS_DEVICE_NOT_FOUND;
 }
@@ -121,7 +121,7 @@ static int thunder_ecam_p2_config_read(struct pci_bus *bus, unsigned int devfn,
 	v |= node_bits;
 	set_val(v, where, size, val);
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int thunder_ecam_config_read(struct pci_bus *bus, unsigned int devfn,
@@ -172,7 +172,7 @@ static int thunder_ecam_config_read(struct pci_bus *bus, unsigned int devfn,
 	     (where >= 0x1a4 && where < 0x1bc))) {
 		/* BAR or SR-IOV BAR */
 		*val = 0;
-		return PCIBIOS_SUCCESSFUL;
+		return 0;
 	}
 
 	addr = bus->ops->map_bus(bus, devfn, 0);
@@ -207,7 +207,7 @@ static int thunder_ecam_config_read(struct pci_bus *bus, unsigned int devfn,
 		if (!has_msix && where_a == 0x70) {
 			v |= 0xbc00; /* next capability is EA at 0xbc */
 			set_val(v, where, size, val);
-			return PCIBIOS_SUCCESSFUL;
+			return 0;
 		}
 		if (where_a == 0xb0) {
 			addr = bus->ops->map_bus(bus, devfn, where_a);
@@ -220,7 +220,7 @@ static int thunder_ecam_config_read(struct pci_bus *bus, unsigned int devfn,
 				pr_err("Bad MSIX cap header: %08x\n", v);
 			v |= 0xbc00; /* next capability is EA at 0xbc */
 			set_val(v, where, size, val);
-			return PCIBIOS_SUCCESSFUL;
+			return 0;
 		}
 		if (where_a == 0xbc) {
 			if (is_nic)
@@ -232,7 +232,7 @@ static int thunder_ecam_config_read(struct pci_bus *bus, unsigned int devfn,
 			else
 				v = 0x10014; /* EA last in chain, 1 entry */
 			set_val(v, where, size, val);
-			return PCIBIOS_SUCCESSFUL;
+			return 0;
 		}
 		if (where_a >= 0xc0 && where_a < 0xd0)
 			/* EA entry-0. PP=0, BAR0 Size:3 */
@@ -277,7 +277,7 @@ static int thunder_ecam_config_read(struct pci_bus *bus, unsigned int devfn,
 				pr_err("Bad PCIe cap header: %08x\n", v);
 			v |= 0xbc00; /* next capability is EA at 0xbc */
 			set_val(v, where, size, val);
-			return PCIBIOS_SUCCESSFUL;
+			return 0;
 		}
 		if (where_a == 0xbc) {
 			if (is_nic_bridge)
@@ -285,7 +285,7 @@ static int thunder_ecam_config_read(struct pci_bus *bus, unsigned int devfn,
 			else
 				v = 0x00014; /* EA last in chain, no entries */
 			set_val(v, where, size, val);
-			return PCIBIOS_SUCCESSFUL;
+			return 0;
 		}
 		if (where_a == 0xc0) {
 			if (is_rsl_bridge || is_nic_bridge)
@@ -297,33 +297,33 @@ static int thunder_ecam_config_read(struct pci_bus *bus, unsigned int devfn,
 			else if (is_dfa_bridge)
 				v = 0x0404; /* subordinate:secondary = 4:4 */
 			set_val(v, where, size, val);
-			return PCIBIOS_SUCCESSFUL;
+			return 0;
 		}
 		if (where_a == 0xc4 && is_nic_bridge) {
 			/* Enabled, not-Write, SP=ff, PP=05, BEI=6, ES=4 */
 			v = 0x80ff0564;
 			set_val(v, where, size, val);
-			return PCIBIOS_SUCCESSFUL;
+			return 0;
 		}
 		if (where_a == 0xc8 && is_nic_bridge) {
 			v = 0x00000002; /* Base-L 64-bit */
 			set_val(v, where, size, val);
-			return PCIBIOS_SUCCESSFUL;
+			return 0;
 		}
 		if (where_a == 0xcc && is_nic_bridge) {
 			v = 0xfffffffe; /* MaxOffset-L 64-bit */
 			set_val(v, where, size, val);
-			return PCIBIOS_SUCCESSFUL;
+			return 0;
 		}
 		if (where_a == 0xd0 && is_nic_bridge) {
 			v = 0x00008430; /* NIC Base-H */
 			set_val(v, where, size, val);
-			return PCIBIOS_SUCCESSFUL;
+			return 0;
 		}
 		if (where_a == 0xd4 && is_nic_bridge) {
 			v = 0x0000000f; /* MaxOffset-H */
 			set_val(v, where, size, val);
-			return PCIBIOS_SUCCESSFUL;
+			return 0;
 		}
 	}
 no_emulation:
@@ -340,7 +340,7 @@ static int thunder_ecam_config_write(struct pci_bus *bus, unsigned int devfn,
 	if ((where >= 0x10 && where < 0x2c) ||
 	    (where >= 0x1a4 && where < 0x1bc))
 		/* BAR or SR-IOV BAR */
-		return PCIBIOS_SUCCESSFUL;
+		return 0;
 
 	return pci_generic_config_write(bus, devfn, where, size, val);
 }
diff --git a/drivers/pci/controller/pci-thunder-pem.c b/drivers/pci/controller/pci-thunder-pem.c
index 3f847969143e..ae747d203514 100644
--- a/drivers/pci/controller/pci-thunder-pem.c
+++ b/drivers/pci/controller/pci-thunder-pem.c
@@ -123,7 +123,7 @@ static int thunder_pem_bridge_read(struct pci_bus *bus, unsigned int devfn,
 		break;
 	}
 	*val = read_val;
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int thunder_pem_config_read(struct pci_bus *bus, unsigned int devfn,
@@ -272,7 +272,7 @@ static int thunder_pem_bridge_write(struct pci_bus *bus, unsigned int devfn,
 	 */
 	write_val = (((u64)val) << 32) | where_aligned;
 	writeq(write_val, pem_pci->pem_reg_base + PEM_CFG_WR);
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int thunder_pem_config_write(struct pci_bus *bus, unsigned int devfn,
diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
index d1efa8ffbae1..bf74f0a8b451 100644
--- a/drivers/pci/controller/pci-xgene.c
+++ b/drivers/pci/controller/pci-xgene.c
@@ -168,7 +168,7 @@ static int xgene_pcie_config_read32(struct pci_bus *bus, unsigned int devfn,
 	struct xgene_pcie_port *port = pcie_bus_to_port(bus);
 
 	if (pci_generic_config_read32(bus, devfn, where & ~0x3, 4, val) !=
-	    PCIBIOS_SUCCESSFUL)
+	    0)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	/*
@@ -187,7 +187,7 @@ static int xgene_pcie_config_read32(struct pci_bus *bus, unsigned int devfn,
 	if (size <= 2)
 		*val = (*val >> (8 * (where & 3))) & ((1 << (size * 8)) - 1);
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 #endif
 
diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index 24cb1c331058..96f5bda32b58 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -226,7 +226,7 @@ static int tlp_read_packet(struct altera_pcie *pcie, u32 *value)
 				if (value)
 					*value = reg0;
 
-				return PCIBIOS_SUCCESSFUL;
+				return 0;
 			}
 		}
 		udelay(5);
@@ -273,7 +273,7 @@ static int s10_tlp_read_packet(struct altera_pcie *pcie, u32 *value)
 			    count == 4)
 				*value = dw[3];
 
-			return PCIBIOS_SUCCESSFUL;
+			return 0;
 		}
 	}
 
@@ -367,7 +367,7 @@ static int tlp_cfg_dword_write(struct altera_pcie *pcie, u8 bus, u32 devfn,
 						    value, false);
 
 	ret = pcie->pcie_data->ops->tlp_read_pkt(pcie, NULL);
-	if (ret != PCIBIOS_SUCCESSFUL)
+	if (ret != 0)
 		return ret;
 
 	/*
@@ -377,7 +377,7 @@ static int tlp_cfg_dword_write(struct altera_pcie *pcie, u8 bus, u32 devfn,
 	if ((bus == pcie->root_bus_nr) && (where == PCI_PRIMARY_BUS))
 		pcie->root_bus_nr = (u8)(value);
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int s10_rp_read_cfg(struct altera_pcie *pcie, int where,
@@ -397,7 +397,7 @@ static int s10_rp_read_cfg(struct altera_pcie *pcie, int where,
 		break;
 	}
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int s10_rp_write_cfg(struct altera_pcie *pcie, u8 busno,
@@ -424,7 +424,7 @@ static int s10_rp_write_cfg(struct altera_pcie *pcie, u8 busno,
 	if (busno == pcie->root_bus_nr && where == PCI_PRIMARY_BUS)
 		pcie->root_bus_nr = value & 0xff;
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int _altera_pcie_cfg_read(struct altera_pcie *pcie, u8 busno,
@@ -453,7 +453,7 @@ static int _altera_pcie_cfg_read(struct altera_pcie *pcie, u8 busno,
 
 	ret = tlp_cfg_dword_read(pcie, busno, devfn,
 				 (where & ~DWORD_MASK), byte_en, &data);
-	if (ret != PCIBIOS_SUCCESSFUL)
+	if (ret != 0)
 		return ret;
 
 	switch (size) {
@@ -468,7 +468,7 @@ static int _altera_pcie_cfg_read(struct altera_pcie *pcie, u8 busno,
 		break;
 	}
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int _altera_pcie_cfg_write(struct altera_pcie *pcie, u8 busno,
diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index 8c7f875acf7f..dac9352c0cb2 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -584,7 +584,7 @@ static int iproc_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
 	/* root complex access */
 	if (busno == 0) {
 		ret = pci_generic_config_read32(bus, devfn, where, size, val);
-		if (ret == PCIBIOS_SUCCESSFUL)
+		if (ret == 0)
 			iproc_pcie_fix_cap(pcie, where, val);
 
 		return ret;
@@ -620,7 +620,7 @@ static int iproc_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
 		    (PCI_DEVICE_ID_NX2_57810 << DEVICE_ID_SHIFT))
 			return PCIBIOS_FUNC_NOT_SUPPORTED;
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 /**
@@ -677,7 +677,7 @@ static int iproc_pci_raw_config_read32(struct iproc_pcie *pcie,
 	if (size <= 2)
 		*val = (*val >> (8 * (where & 3))) & ((1 << (size * 8)) - 1);
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int iproc_pci_raw_config_write32(struct iproc_pcie *pcie,
@@ -693,7 +693,7 @@ static int iproc_pci_raw_config_write32(struct iproc_pcie *pcie,
 
 	if (size == 4) {
 		writel(val, addr);
-		return PCIBIOS_SUCCESSFUL;
+		return 0;
 	}
 
 	mask = ~(((1 << (size * 8)) - 1) << ((where & 0x3) * 8));
@@ -701,7 +701,7 @@ static int iproc_pci_raw_config_write32(struct iproc_pcie *pcie,
 	tmp |= val << ((where & 0x3) * 8);
 	writel(tmp, addr);
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int iproc_pcie_config_read32(struct pci_bus *bus, unsigned int devfn,
diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index ebfa7d5a4e2d..9e8adec04ac2 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -274,7 +274,7 @@ static int mtk_pcie_check_cfg_cpld(struct mtk_pcie_port *port)
 	if (readl(port->base + PCIE_APP_TLP_REQ) & APP_CPL_STATUS)
 		return PCIBIOS_SET_FAILED;
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int mtk_pcie_hw_rd_cfg(struct mtk_pcie_port *port, u32 bus, u32 devfn,
@@ -306,7 +306,7 @@ static int mtk_pcie_hw_rd_cfg(struct mtk_pcie_port *port, u32 bus, u32 devfn,
 	else if (size == 2)
 		*val = (*val >> (8 * (where & 3))) & 0xffff;
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int mtk_pcie_hw_wr_cfg(struct mtk_pcie_port *port, u32 bus, u32 devfn,
diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index d210a36561be..363a8630de28 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -110,7 +110,7 @@ static int rcar_pcie_config_access(struct rcar_pcie_host *host,
 			rcar_pci_write_reg(pcie, *data, PCICONF(index));
 		}
 
-		return PCIBIOS_SUCCESSFUL;
+		return 0;
 	}
 
 	if (host->root_bus_nr < 0)
@@ -146,7 +146,7 @@ static int rcar_pcie_config_access(struct rcar_pcie_host *host,
 	/* Disable the configuration access */
 	rcar_pci_write_reg(pcie, 0, PCIECCTLR);
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int rcar_pcie_read_conf(struct pci_bus *bus, unsigned int devfn,
@@ -157,7 +157,7 @@ static int rcar_pcie_read_conf(struct pci_bus *bus, unsigned int devfn,
 
 	ret = rcar_pcie_config_access(host, RCAR_PCI_ACCESS_READ,
 				      bus, devfn, where, val);
-	if (ret != PCIBIOS_SUCCESSFUL) {
+	if (ret != 0) {
 		*val = 0xffffffff;
 		return ret;
 	}
@@ -184,7 +184,7 @@ static int rcar_pcie_write_conf(struct pci_bus *bus, unsigned int devfn,
 
 	ret = rcar_pcie_config_access(host, RCAR_PCI_ACCESS_READ,
 				      bus, devfn, where, &data);
-	if (ret != PCIBIOS_SUCCESSFUL)
+	if (ret != 0)
 		return ret;
 
 	dev_dbg(&bus->dev, "pcie-config-write: bus=%3d devfn=0x%04x where=0x%04x size=%d val=0x%08x\n",
diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 94af6f5828a3..6455f48d4e9c 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -125,7 +125,7 @@ static int rockchip_pcie_rd_own_conf(struct rockchip_pcie *rockchip,
 		*val = 0;
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 	}
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int rockchip_pcie_wr_own_conf(struct rockchip_pcie *rockchip,
@@ -139,7 +139,7 @@ static int rockchip_pcie_wr_own_conf(struct rockchip_pcie *rockchip,
 
 	if (size == 4) {
 		writel(val, addr);
-		return PCIBIOS_SUCCESSFUL;
+		return 0;
 	}
 
 	mask = ~(((1 << (size * 8)) - 1) << ((where & 0x3) * 8));
@@ -153,7 +153,7 @@ static int rockchip_pcie_wr_own_conf(struct rockchip_pcie *rockchip,
 	tmp |= val << ((where & 0x3) * 8);
 	writel(tmp, addr);
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int rockchip_pcie_rd_other_conf(struct rockchip_pcie *rockchip,
@@ -187,7 +187,7 @@ static int rockchip_pcie_rd_other_conf(struct rockchip_pcie *rockchip,
 		*val = 0;
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 	}
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int rockchip_pcie_wr_other_conf(struct rockchip_pcie *rockchip,
@@ -217,7 +217,7 @@ static int rockchip_pcie_wr_other_conf(struct rockchip_pcie *rockchip,
 	else
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int rockchip_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
-- 
2.18.2

