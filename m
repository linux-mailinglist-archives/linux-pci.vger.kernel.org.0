Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8A36466208
	for <lists+linux-pci@lfdr.de>; Thu,  2 Dec 2021 12:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346379AbhLBLJx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Dec 2021 06:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237400AbhLBLJw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Dec 2021 06:09:52 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461CCC06174A;
        Thu,  2 Dec 2021 03:06:30 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id l16so58790365wrp.11;
        Thu, 02 Dec 2021 03:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X3b5gwmkQkjg3Q2cuUUH5fKER5AKTpSIcyrJaupXHSQ=;
        b=MdY7KcODUz9xM8AsJjOF/yy9lYbv3fF/6o95+xvpkuEVnvu8EdN3qDGemdCfmMW60O
         e8l0dP5BpT0KerJRuEGKw0KUF06vF4xX1wjnTLiQqwRtJAH1qBuMirfelhK+C5j7Isv8
         4N76+EzGShuaS9BemBeIgV11iuLA0CChJlC7WLdsrQgPdAKmEyQvCv+vy5egRkXmGTqJ
         U0o9jPrEoKHGX4yFeqCKM4K6OJhMIGhHw58rVX2lbARGtoqGXgGTgH9ZZVYSg1oEwTvU
         Arb8Mp1E1+d7wwj1RJWGDVAVlMIUcqy4JLk4ErdIcDXcepnT2evRX98qJjCeRiA2236D
         IseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X3b5gwmkQkjg3Q2cuUUH5fKER5AKTpSIcyrJaupXHSQ=;
        b=aOG4kPVSkRfjFCbY7OelR6HBtzWolC975HAXpss/wFcGJBEbT5yFk/jz2og5vHzlz+
         fNx/oGtpjVF8YDgGsP5olKKVQWTM6Iv/jCvWIoo4ObwKdPlrJ8c0RxPeNIYdbu2kPkG7
         t0qVsbmg++YVL7Qo5/6HI6uavlpC44X5GlOdRpS8AI2yb37GnvtuO5fQK8XgZIr3/szW
         UENH3/+WhD0mN5Tw73qYRc8pe7GyGzGQKBd5Pt5ZaTR7G2XZuUmAuK8YvmB5fcxEYtaF
         Rc0WZU97jOvskAnYuG29koot/Pk7VIEc5CA7qZK3DJds/ZWi4KJgr3ziAJoR0TOFHVe2
         l42Q==
X-Gm-Message-State: AOAM533P9Wrw1TH8zK34dy+MFhSkVVdJIBqWP10ugKb5QABFreQKgPGn
        KARzPlpWTlR6aL6NXuNcC3kmWPtStqCsLFUN
X-Google-Smtp-Source: ABdhPJyp19NE4Gnt2+s/WeXWJ3F5xmlVRqUgvj0TDYU0XuXg4H5tSQvz50UB1sW/zqppiCNCR2p7fQ==
X-Received: by 2002:a5d:4008:: with SMTP id n8mr13593492wrp.489.1638443188652;
        Thu, 02 Dec 2021 03:06:28 -0800 (PST)
Received: from claire-ThinkPad-T470.localdomain (dynamic-2a01-0c22-7ac0-1200-83fc-d61e-7bf5-612e.c22.pool.telefonica.de. [2a01:c22:7ac0:1200:83fc:d61e:7bf5:612e])
        by smtp.gmail.com with ESMTPSA id m20sm1993753wmq.11.2021.12.02.03.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 03:06:28 -0800 (PST)
From:   Fan Fei <ffclaire1224@gmail.com>
To:     helgaas@kernel.org, bjorn@helgaas.com
Cc:     bhelgaas@google.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        pratyush.anand@gmail.com, robh@kernel.org,
        thomas.petazzoni@bootlin.com, Fan Fei <ffclaire1224@gmail.com>
Subject: [PATCH] PCI: Improve compile-test coverage
Date:   Thu,  2 Dec 2021 12:06:24 +0100
Message-Id: <20211202110624.143028-1-ffclaire1224@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201005215817.GA3063223@bjorn-Precision-5520>
References: <20201005215817.GA3063223@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove the "depends on OF" in Kconfig of PCI controllers. These drivers
depends on CONFIG_OF because they use interface in of.h file, e.g.
"of_match_ptr()". But these interface are defined as stub if CONFIG_OF is
not set. Thus we can compile them without CONFIG_OF, instead just with
COMPILE_TEST.

Signed-off-by: Fan Fei <ffclaire1224@gmail.com>
---
Hi, Bjorn,

I just did as what you suggested, remove the "depends on OF" in Konfig, and 
compile it. It seems to work well. On the thread 
https://lore.kernel.org/all/20201005215817.GA3063223@bjorn-Precision-5520/ 
mentioned by the task excel, there are some replacement of "of_match_ptr()", 
but this function seems to be defined even CONFIG_OF is not set. Is it 
correct to reply in this thread or shall I send it to mail list directly?

Kind regards
Fan

 drivers/pci/controller/Kconfig | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 93b141110537..6e988420f900 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -8,13 +8,11 @@ config PCI_MVEBU
 	depends on ARCH_MVEBU || ARCH_DOVE || COMPILE_TEST
 	depends on MVEBU_MBUS
 	depends on ARM
-	depends on OF
 	select PCI_BRIDGE_EMUL
 
 config PCI_AARDVARK
 	tristate "Aardvark PCIe controller"
 	depends on (ARCH_MVEBU && ARM64) || COMPILE_TEST
-	depends on OF
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCI_BRIDGE_EMUL
 	help
@@ -34,12 +32,11 @@ config PCIE_XILINX_NWL
 
 config PCI_FTPCI100
 	bool "Faraday Technology FTPCI100 PCI controller"
-	depends on OF
 	default ARCH_GEMINI
 
 config PCI_IXP4XX
 	bool "Intel IXP4xx PCI controller"
-	depends on ARM && OF
+	depends on ARM
 	depends on ARCH_IXP4XX || COMPILE_TEST
 	default ARCH_IXP4XX
 	help
@@ -85,7 +82,6 @@ config PCI_HOST_COMMON
 
 config PCI_HOST_GENERIC
 	tristate "Generic PCI host controller"
-	depends on OF
 	select PCI_HOST_COMMON
 	select IRQ_DOMAIN
 	help
@@ -94,7 +90,7 @@ config PCI_HOST_GENERIC
 
 config PCIE_XILINX
 	bool "Xilinx AXI PCIe host bridge support"
-	depends on OF || COMPILE_TEST
+	depends on COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	help
 	  Say 'Y' here if you want kernel to support the Xilinx AXI PCIe
@@ -111,7 +107,7 @@ config PCIE_XILINX_CPM
 config PCI_XGENE
 	bool "X-Gene PCIe controller"
 	depends on ARM64 || COMPILE_TEST
-	depends on OF || (ACPI && PCI_QUIRKS)
+	depends on ACPI && PCI_QUIRKS
 	help
 	  Say Y here if you want internal PCI support on APM X-Gene SoC.
 	  There are 5 internal PCIe ports available. Each port is GEN3 capable
@@ -128,7 +124,6 @@ config PCI_XGENE_MSI
 
 config PCI_V3_SEMI
 	bool "V3 Semiconductor PCI controller"
-	depends on OF
 	depends on ARM || COMPILE_TEST
 	default ARCH_INTEGRATOR_AP
 
@@ -146,7 +141,6 @@ config PCIE_IPROC
 config PCIE_IPROC_PLATFORM
 	tristate "Broadcom iProc PCIe platform bus driver"
 	depends on ARCH_BCM_IPROC || (ARM && COMPILE_TEST)
-	depends on OF
 	select PCIE_IPROC
 	default ARCH_BCM_IPROC
 	help
@@ -190,7 +184,7 @@ config PCIE_ALTERA_MSI
 config PCI_HOST_THUNDER_PEM
 	bool "Cavium Thunder PCIe controller to off-chip devices"
 	depends on ARM64 || COMPILE_TEST
-	depends on OF || (ACPI && PCI_QUIRKS)
+	depends on ACPI && PCI_QUIRKS
 	select PCI_HOST_COMMON
 	help
 	  Say Y here if you want PCIe support for CN88XX Cavium Thunder SoCs.
@@ -198,7 +192,7 @@ config PCI_HOST_THUNDER_PEM
 config PCI_HOST_THUNDER_ECAM
 	bool "Cavium Thunder ECAM controller to on-chip devices on pass-1.x silicon"
 	depends on ARM64 || COMPILE_TEST
-	depends on OF || (ACPI && PCI_QUIRKS)
+	depends on ACPI && PCI_QUIRKS
 	select PCI_HOST_COMMON
 	help
 	  Say Y here if you want ECAM support for CN88XX-Pass-1.x Cavium Thunder SoCs.
@@ -210,7 +204,6 @@ config PCIE_ROCKCHIP
 config PCIE_ROCKCHIP_HOST
 	tristate "Rockchip PCIe host controller"
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
-	depends on OF
 	depends on PCI_MSI_IRQ_DOMAIN
 	select MFD_SYSCON
 	select PCIE_ROCKCHIP
@@ -222,7 +215,6 @@ config PCIE_ROCKCHIP_HOST
 config PCIE_ROCKCHIP_EP
 	bool "Rockchip PCIe endpoint controller"
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
-	depends on OF
 	depends on PCI_ENDPOINT
 	select MFD_SYSCON
 	select PCIE_ROCKCHIP
@@ -234,7 +226,6 @@ config PCIE_ROCKCHIP_EP
 config PCIE_MEDIATEK
 	tristate "MediaTek PCIe controller"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
-	depends on OF
 	depends on PCI_MSI_IRQ_DOMAIN
 	help
 	  Say Y here if you want to enable PCIe controller support on
@@ -272,7 +263,6 @@ config PCIE_BRCMSTB
 	tristate "Broadcom Brcmstb PCIe host controller"
 	depends on ARCH_BRCMSTB || ARCH_BCM2835 || ARCH_BCM4908 || \
 		   BMIPS_GENERIC || COMPILE_TEST
-	depends on OF
 	depends on PCI_MSI_IRQ_DOMAIN
 	default ARCH_BRCMSTB
 	help
@@ -289,7 +279,6 @@ config PCI_HYPERV_INTERFACE
 config PCI_LOONGSON
 	bool "LOONGSON PCI Controller"
 	depends on MACH_LOONGSON64 || COMPILE_TEST
-	depends on OF
 	depends on PCI_QUIRKS
 	default MACH_LOONGSON64
 	help
@@ -298,7 +287,7 @@ config PCI_LOONGSON
 
 config PCIE_MICROCHIP_HOST
 	bool "Microchip AXI PCIe host bridge support"
-	depends on PCI_MSI && OF
+	depends on PCI_MSI
 	select PCI_MSI_IRQ_DOMAIN
 	select GENERIC_MSI_IRQ_DOMAIN
 	select PCI_HOST_COMMON
@@ -321,7 +310,6 @@ config PCIE_APPLE_MSI_DOORBELL_ADDR
 config PCIE_APPLE
 	tristate "Apple PCIe controller"
 	depends on ARCH_APPLE || COMPILE_TEST
-	depends on OF
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCI_HOST_COMMON
 	help
-- 
2.25.1

