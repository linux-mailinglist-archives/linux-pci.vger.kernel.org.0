Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9304013FBB1
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2020 22:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbgAPVrp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jan 2020 16:47:45 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36045 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729878AbgAPVro (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jan 2020 16:47:44 -0500
Received: by mail-pf1-f194.google.com with SMTP id x184so10894217pfb.3
        for <linux-pci@vger.kernel.org>; Thu, 16 Jan 2020 13:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:thread-topic:thread-index:date:message-id
         :accept-language:content-language:content-transfer-encoding
         :mime-version;
        bh=loJq2BFCJDLuMqoHpzHxiOl0dPxBfdfBELyXwXbZ4gY=;
        b=lMgymSfx9ehbmnV2Ct9wOLxj5LFEUXp8WhcYhCP83DNe0KdLDgxm3H15/+dH5HySIK
         i9K6Uj6QXtXsi4aQxr9CxagQBfFhAofZ1JZrCI0MyNVeapu2GmJ3ehtBGw7qEtf0YV6g
         FXtMZDm3fyVQCw9DhFzyb+CUo7FAgSt+WbZpzSs4oNVUZtJ2B24MQ06PHJsL3FELbEE1
         HIgpJ68TInl8oN2c03pzge7KUhsUCvx2OGSrOc1yTFWlbcm0hgjUGMQmtuO+N/ZZPg9q
         rGzZs1q9lajjrwmpUWrWEnW8NiHHCjXrNQMXQ8hy2cnzC/mtm+rbSKPtWWY4E8FJmMbK
         /h9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:thread-topic:thread-index
         :date:message-id:accept-language:content-language
         :content-transfer-encoding:mime-version;
        bh=loJq2BFCJDLuMqoHpzHxiOl0dPxBfdfBELyXwXbZ4gY=;
        b=m1xtEder2vkbxsF7MyVjHijG1cNWIOhaDSooye6e+A3FzTPsP0P/zhgnSGAIt1i3j2
         OqytoXcEWvqhwe1ZWb8gvfUHTyonrCv3GSXl8BMNViragLnI24QJCVNjYreNEjhtY7AH
         EREC79fqPDVkk29BBuIvjjrb63kFsKBJi1fC2lxU735bI5VnGBGfPPSoNwx0tfnwrfCX
         YTaABpyzfNibcwdtIiOXOgsAiymUkuGwe/9FG7XVY46roXCrhFaqGMWwvd11NM6ykrAr
         g/bK2MWEgVBJzQ5rTKAfzhrDz2qo48Ils/LejdPPERHdQOTGfDhB7GJRgXDQTyxdTyIY
         TVrA==
X-Gm-Message-State: APjAAAUT2dOzTNR5muyHZ9bL9r1wroaI2ssYzHOcDBIqylLHfM3t4GN2
        Y+BmAh6lyyVfpuT3DxtKiJA=
X-Google-Smtp-Source: APXvYqy/7OXl7eu9xAJEno5HK7zw219qsj7jBndTjsHZAqsVGkIzd94ObVFMPVzTRe7uYhROMEth7g==
X-Received: by 2002:a63:1346:: with SMTP id 6mr42244463pgt.111.1579211263558;
        Thu, 16 Jan 2020 13:47:43 -0800 (PST)
Received: from SL2P216MB0105.KORP216.PROD.OUTLOOK.COM ([2603:1046:100:22::5])
        by smtp.gmail.com with ESMTPSA id n1sm27699809pfd.47.2020.01.16.13.47.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Jan 2020 13:47:42 -0800 (PST)
From:   Jingoo Han <jingoohan1@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Han Jingoo <jingoohan1@gmail.com>
Subject: [PATCH] PCI: dwc: Makefile/Kconfig: sort alphabetically
Thread-Topic: [PATCH] PCI: dwc: Makefile/Kconfig: sort alphabetically
Thread-Index: AQHVzLaRd//I5YntB0GSFszSnX4h4w==
X-MS-Exchange-MessageSentRepresentingType: 1
Date:   Thu, 16 Jan 2020 21:47:38 +0000
Message-ID: <SL2P216MB010521AC91184B715AFA197FAA360@SL2P216MB0105.KORP216.PROD.OUTLOOK.COM>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The order in dwc directory is PCIE_DW, PCI_*, and PCIE_* as below.

1. Common Frameworks:
    These options are used by other controller drivers.
    e.g., PCIE_DW, PCIE_DW_HOST, PCIE_DW_EP.

2. PCI_* controller drivers:
    PCI_* was used earlier than PCIE_*. If a chip vendor's controllers prov=
ide
    both conventional PCI and PCI Express, or only conventional PCI, PCI_* =
can
    be used.

3. PCIE_* controller drivers:
    If a controller can support only PCI Express, not conventional PCI,
    PCIE_* is the proper naming.

Then, within PCI_* or PCIE_* categories, each controller option should be
in an alphabetical order for the readability.

Signed-off-by: Jingoo Han <jingoohan1@gmail.com>
---
Based on 'dwc' branch

 drivers/pci/controller/dwc/Kconfig  | 148 ++++++++++++++--------------
 drivers/pci/controller/dwc/Makefile |   8 +-
 2 files changed, 78 insertions(+), 78 deletions(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dw=
c/Kconfig
index 0830dfcfa43a..377323d01ee3 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -16,6 +16,38 @@ config PCIE_DW_EP
 	depends on PCI_ENDPOINT
 	select PCIE_DW
=20
+config PCIE_DW_PLAT
+	bool
+
+config PCIE_DW_PLAT_HOST
+	bool "Platform bus based DesignWare PCIe Controller - Host mode"
+	depends on PCI && PCI_MSI_IRQ_DOMAIN
+	select PCIE_DW_HOST
+	select PCIE_DW_PLAT
+	help
+	  Enables support for the PCIe controller in the Designware IP to
+	  work in host mode. There are two instances of PCIe controller in
+	  Designware IP.
+	  This controller can work either as EP or RC. In order to enable
+	  host-specific features PCIE_DW_PLAT_HOST must be selected and in
+	  order to enable device-specific features PCI_DW_PLAT_EP must be
+	  selected.
+
+config PCIE_DW_PLAT_EP
+	bool "Platform bus based DesignWare PCIe Controller - Endpoint mode"
+	depends on PCI && PCI_MSI_IRQ_DOMAIN
+	depends on PCI_ENDPOINT
+	select PCIE_DW_EP
+	select PCIE_DW_PLAT
+	help
+	  Enables support for the PCIe controller in the Designware IP to
+	  work in endpoint mode. There are two instances of PCIe controller
+	  in Designware IP.
+	  This controller can work either as EP or RC. In order to enable
+	  host-specific features PCIE_DW_PLAT_HOST must be selected and in
+	  order to enable device-specific features PCI_DW_PLAT_EP must be
+	  selected.
+
 config PCI_DRA7XX
 	bool
=20
@@ -50,57 +82,27 @@ config PCI_DRA7XX_EP
 	  to enable device-specific features PCI_DRA7XX_EP must be selected.
 	  This uses the DesignWare core.
=20
-config PCIE_DW_PLAT
-	bool
-
-config PCIE_DW_PLAT_HOST
-	bool "Platform bus based DesignWare PCIe Controller - Host mode"
-	depends on PCI && PCI_MSI_IRQ_DOMAIN
-	select PCIE_DW_HOST
-	select PCIE_DW_PLAT
-	help
-	  Enables support for the PCIe controller in the Designware IP to
-	  work in host mode. There are two instances of PCIe controller in
-	  Designware IP.
-	  This controller can work either as EP or RC. In order to enable
-	  host-specific features PCIE_DW_PLAT_HOST must be selected and in
-	  order to enable device-specific features PCI_DW_PLAT_EP must be
-	  selected.
-
-config PCIE_DW_PLAT_EP
-	bool "Platform bus based DesignWare PCIe Controller - Endpoint mode"
-	depends on PCI && PCI_MSI_IRQ_DOMAIN
-	depends on PCI_ENDPOINT
-	select PCIE_DW_EP
-	select PCIE_DW_PLAT
-	help
-	  Enables support for the PCIe controller in the Designware IP to
-	  work in endpoint mode. There are two instances of PCIe controller
-	  in Designware IP.
-	  This controller can work either as EP or RC. In order to enable
-	  host-specific features PCIE_DW_PLAT_HOST must be selected and in
-	  order to enable device-specific features PCI_DW_PLAT_EP must be
-	  selected.
-
 config PCI_EXYNOS
 	bool "Samsung Exynos PCIe controller"
 	depends on SOC_EXYNOS5440 || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
=20
-config PCI_IMX6
-	bool "Freescale i.MX6/7/8 PCIe controller"
-	depends on ARCH_MXC || COMPILE_TEST
+config PCI_HISI
+	depends on OF && (ARM64 || COMPILE_TEST)
+	bool "HiSilicon Hip05 and Hip06 SoCs PCIe controllers"
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
+	select PCI_HOST_COMMON
+	help
+	  Say Y here if you want PCIe controller support on HiSilicon
+	  Hip05 and Hip06 SoCs
=20
-config PCIE_SPEAR13XX
-	bool "STMicroelectronics SPEAr PCIe controller"
-	depends on ARCH_SPEAR13XX || COMPILE_TEST
+config PCI_IMX6
+	bool "Freescale i.MX6/7/8 PCIe controller"
+	depends on ARCH_MXC || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
-	help
-	  Say Y here if you want PCIe support on SPEAr13XX SoCs.
=20
 config PCI_KEYSTONE
 	bool
@@ -155,25 +157,27 @@ config PCI_LAYERSCAPE_EP
 	  determines which PCIe controller works in EP mode and which PCIe
 	  controller works in RC mode.
=20
-config PCI_HISI
-	depends on OF && (ARM64 || COMPILE_TEST)
-	bool "HiSilicon Hip05 and Hip06 SoCs PCIe controllers"
+config PCI_MESON
+	bool "MESON PCIe controller"
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
-	select PCI_HOST_COMMON
 	help
-	  Say Y here if you want PCIe controller support on HiSilicon
-	  Hip05 and Hip06 SoCs
+	  Say Y here if you want to enable PCI controller support on Amlogic
+	  SoCs. The PCI controller on Amlogic is based on DesignWare hardware
+	  and therefore the driver re-uses the DesignWare core functions to
+	  implement the driver.
=20
-config PCIE_QCOM
-	bool "Qualcomm PCIe controller"
-	depends on OF && (ARCH_QCOM || COMPILE_TEST)
+config PCIE_AL
+	bool "Amazon Annapurna Labs PCIe controller"
+	depends on OF && (ARM64 || COMPILE_TEST)
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
 	help
-	  Say Y here to enable PCIe controller support on Qualcomm SoCs. The
-	  PCIe controller uses the DesignWare core plus Qualcomm-specific
-	  hardware wrappers.
+	  Say Y here to enable support of the Amazon's Annapurna Labs PCIe
+	  controller IP on Amazon SoCs. The PCIe controller uses the DesignWare
+	  core plus Annapurna Labs proprietary hardware wrappers. This is
+	  required only for DT-based platforms. ACPI platforms with the
+	  Annapurna Labs PCIe controller don't need to enable this.
=20
 config PCIE_ARMADA_8K
 	bool "Marvell Armada-8K PCIe controller"
@@ -209,6 +213,14 @@ config PCIE_ARTPEC6_EP
 	  Enables support for the PCIe controller in the ARTPEC-6 SoC to work in
 	  endpoint mode. This uses the DesignWare core.
=20
+config PCIE_HISI_STB
+	bool "HiSilicon STB SoCs PCIe controllers"
+	depends on ARCH_HISI || COMPILE_TEST
+	depends on PCI_MSI_IRQ_DOMAIN
+	select PCIE_DW_HOST
+	help
+	  Say Y here if you want PCIe controller support on HiSilicon STB SoCs
+
 config PCIE_INTEL_GW
 	bool "Intel Gateway PCIe host controller support"
 	depends on OF && (X86 || COMPILE_TEST)
@@ -229,23 +241,23 @@ config PCIE_KIRIN
 	  Say Y here if you want PCIe controller support
 	  on HiSilicon Kirin series SoCs.
=20
-config PCIE_HISI_STB
-	bool "HiSilicon STB SoCs PCIe controllers"
-	depends on ARCH_HISI || COMPILE_TEST
+config PCIE_QCOM
+	bool "Qualcomm PCIe controller"
+	depends on OF && (ARCH_QCOM || COMPILE_TEST)
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
 	help
-	  Say Y here if you want PCIe controller support on HiSilicon STB SoCs
+	  Say Y here to enable PCIe controller support on Qualcomm SoCs. The
+	  PCIe controller uses the DesignWare core plus Qualcomm-specific
+	  hardware wrappers.
=20
-config PCI_MESON
-	bool "MESON PCIe controller"
+config PCIE_SPEAR13XX
+	bool "STMicroelectronics SPEAr PCIe controller"
+	depends on ARCH_SPEAR13XX || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
 	help
-	  Say Y here if you want to enable PCI controller support on Amlogic
-	  SoCs. The PCI controller on Amlogic is based on DesignWare hardware
-	  and therefore the driver re-uses the DesignWare core functions to
-	  implement the driver.
+	  Say Y here if you want PCIe support on SPEAr13XX SoCs.
=20
 config PCIE_TEGRA194
 	tristate "NVIDIA Tegra194 (and later) PCIe controller"
@@ -267,16 +279,4 @@ config PCIE_UNIPHIER
 	  Say Y here if you want PCIe controller support on UniPhier SoCs.
 	  This driver supports LD20 and PXs3 SoCs.
=20
-config PCIE_AL
-	bool "Amazon Annapurna Labs PCIe controller"
-	depends on OF && (ARM64 || COMPILE_TEST)
-	depends on PCI_MSI_IRQ_DOMAIN
-	select PCIE_DW_HOST
-	help
-	  Say Y here to enable support of the Amazon's Annapurna Labs PCIe
-	  controller IP on Amazon SoCs. The PCIe controller uses the DesignWare
-	  core plus Annapurna Labs proprietary hardware wrappers. This is
-	  required only for DT-based platforms. ACPI platforms with the
-	  Annapurna Labs PCIe controller don't need to enable this.
-
 endmenu
diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/d=
wc/Makefile
index 8a637cfcf6e9..53d25b4e5206 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -6,17 +6,17 @@ obj-$(CONFIG_PCIE_DW_PLAT) +=3D pcie-designware-plat.o
 obj-$(CONFIG_PCI_DRA7XX) +=3D pci-dra7xx.o
 obj-$(CONFIG_PCI_EXYNOS) +=3D pci-exynos.o
 obj-$(CONFIG_PCI_IMX6) +=3D pci-imx6.o
-obj-$(CONFIG_PCIE_SPEAR13XX) +=3D pcie-spear13xx.o
 obj-$(CONFIG_PCI_KEYSTONE) +=3D pci-keystone.o
 obj-$(CONFIG_PCI_LAYERSCAPE) +=3D pci-layerscape.o
 obj-$(CONFIG_PCI_LAYERSCAPE_EP) +=3D pci-layerscape-ep.o
-obj-$(CONFIG_PCIE_QCOM) +=3D pcie-qcom.o
+obj-$(CONFIG_PCI_MESON) +=3D pci-meson.o
 obj-$(CONFIG_PCIE_ARMADA_8K) +=3D pcie-armada8k.o
 obj-$(CONFIG_PCIE_ARTPEC6) +=3D pcie-artpec6.o
+obj-$(CONFIG_PCIE_HISI_STB) +=3D pcie-histb.o
 obj-$(CONFIG_PCIE_INTEL_GW) +=3D pcie-intel-gw.o
 obj-$(CONFIG_PCIE_KIRIN) +=3D pcie-kirin.o
-obj-$(CONFIG_PCIE_HISI_STB) +=3D pcie-histb.o
-obj-$(CONFIG_PCI_MESON) +=3D pci-meson.o
+obj-$(CONFIG_PCIE_QCOM) +=3D pcie-qcom.o
+obj-$(CONFIG_PCIE_SPEAR13XX) +=3D pcie-spear13xx.o
 obj-$(CONFIG_PCIE_TEGRA194) +=3D pcie-tegra194.o
 obj-$(CONFIG_PCIE_UNIPHIER) +=3D pcie-uniphier.o
=20
--=20
2.17.1

