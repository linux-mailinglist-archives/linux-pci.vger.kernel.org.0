Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFEF173BCA
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2020 16:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgB1Plt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Feb 2020 10:41:49 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35959 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbgB1Pls (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Feb 2020 10:41:48 -0500
Received: by mail-wm1-f68.google.com with SMTP id g83so1485220wme.1;
        Fri, 28 Feb 2020 07:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qV1Dck8tf+GcyTrLNUFv75tqg7dyBtWtpnslHitmGrc=;
        b=B/LKxeBkYdD8AlPBawzSn+XJuEJ/6FPxXgF3H+qlt4997pZuGrjwWleEgpqG0mxVPV
         lJUtH2yNsZ+TJ9R072OTTLlW2/c3MZqJT2DEBvJwgfKnxRKOFVLWHDKmUO00YjaKoYJq
         nY36FAdNcY8hUC52VjdK43b9ERek8BnTghCV6H0c6wvkW4UPzxoN1YdOqCMcEmEe/Ibz
         an8EM9eYCrFyXIuRul8vvJy7QvMXQKvdwJVL6iVlP6wh7nhJgypoDgmAMQcOMYgQ3OcS
         5oh8ENTlr0Xxk+BtD/GrLaMWtrkSvGcyOfvXS0XJZZMhjnA8za2hfj9dyQ4K2lgkVuc4
         bzvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qV1Dck8tf+GcyTrLNUFv75tqg7dyBtWtpnslHitmGrc=;
        b=hON5MsFphJ9X7Kmr7se5Xd9Oktr5wC7OzoSshbLB6ZTf8UI9Ut/VCpMFK0Re6Xw24U
         F0gTBdQkmsheDf0/AClYecsBhhHDr09BX9eNB82vF4yjYIqczL8ZJvgX6pbdQ1wIGFeM
         MTasL9br0EFszxKF5BnymlOq5OG3S3UvOwrqKMFbYmOWjkurHUff92j2SCvRxZoBVtJ2
         6ZcGfkk3Ssas8BkPLJ4kz4U0m/v2SsWzeVVW6Yvz8xeRqeft9LzmN6dmbNly0MAcUIvA
         gKmEzTT4uj/nbQeERSoIn6qpMA4SPSWhSRypnES8nc1pJmpcXkp9l6d4Fw88CEgk816r
         NkzQ==
X-Gm-Message-State: APjAAAWO9FVMdrRiCO1a1yFGj00RJi3wRKTzY+wEnkVsEjq58guYqXyO
        XZUVUAqTQnlCVw6QuGq5qsE=
X-Google-Smtp-Source: APXvYqz3F/pP/wL0WjwZGAnvHP2QFXDDU7ivUZcycl72fUq26geJ9QKLeqLousrNZp999DpUHB/UnQ==
X-Received: by 2002:a7b:ce8b:: with SMTP id q11mr5567459wmj.100.1582904505349;
        Fri, 28 Feb 2020 07:41:45 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2510:d000:3855:fd13:6b76:a11b])
        by smtp.gmail.com with ESMTPSA id k16sm13355349wrd.17.2020.02.28.07.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 07:41:44 -0800 (PST)
From:   Lad Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Andrew Murray <andrew.murray@arm.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v5 1/7] PCI: rcar: Rename pcie-rcar.c to pcie-rcar-host.c
Date:   Fri, 28 Feb 2020 15:41:16 +0000
Message-Id: <20200228154122.14164-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228154122.14164-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20200228154122.14164-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This commit renames pcie-rcar.c to pcie-rcar-host.c in preparation for
adding support for endpoint mode. CONFIG_PCIE_RCAR is also renamed to
CONFIG_PCIE_RCAR_HOST to match the driver name accordingly.

In addition to this defconfig file has also been updated to match the new
config option.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/configs/defconfig                             | 2 +-
 drivers/pci/controller/Kconfig                           | 7 ++++---
 drivers/pci/controller/Makefile                          | 2 +-
 drivers/pci/controller/{pcie-rcar.c => pcie-rcar-host.c} | 0
 4 files changed, 6 insertions(+), 5 deletions(-)
 rename drivers/pci/controller/{pcie-rcar.c => pcie-rcar-host.c} (100%)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0f21288..7a34fce 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -185,7 +185,7 @@ CONFIG_HOTPLUG_PCI=y
 CONFIG_HOTPLUG_PCI_ACPI=y
 CONFIG_PCI_AARDVARK=y
 CONFIG_PCI_TEGRA=y
-CONFIG_PCIE_RCAR=y
+CONFIG_PCIE_RCAR_HOST=y
 CONFIG_PCI_HOST_GENERIC=y
 CONFIG_PCI_XGENE=y
 CONFIG_PCIE_ALTERA=y
diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index f84e5ff..37e0ea7 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -54,12 +54,13 @@ config PCI_RCAR_GEN2
 	  There are 3 internal PCI controllers available with a single
 	  built-in EHCI/OHCI host controller present on each one.
 
-config PCIE_RCAR
-	bool "Renesas R-Car PCIe controller"
+config PCIE_RCAR_HOST
+	bool "Renesas R-Car PCIe host controller"
 	depends on ARCH_RENESAS || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	help
-	  Say Y here if you want PCIe controller support on R-Car SoCs.
+	  Say Y here if you want PCIe controller support on R-Car SoCs in host
+	  mode.
 
 config PCI_HOST_COMMON
 	bool
diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
index 01b2502..4ca2da6 100644
--- a/drivers/pci/controller/Makefile
+++ b/drivers/pci/controller/Makefile
@@ -7,7 +7,7 @@ obj-$(CONFIG_PCI_MVEBU) += pci-mvebu.o
 obj-$(CONFIG_PCI_AARDVARK) += pci-aardvark.o
 obj-$(CONFIG_PCI_TEGRA) += pci-tegra.o
 obj-$(CONFIG_PCI_RCAR_GEN2) += pci-rcar-gen2.o
-obj-$(CONFIG_PCIE_RCAR) += pcie-rcar.o
+obj-$(CONFIG_PCIE_RCAR_HOST) += pcie-rcar-host.o
 obj-$(CONFIG_PCI_HOST_COMMON) += pci-host-common.o
 obj-$(CONFIG_PCI_HOST_GENERIC) += pci-host-generic.o
 obj-$(CONFIG_PCIE_XILINX) += pcie-xilinx.o
diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar-host.c
similarity index 100%
rename from drivers/pci/controller/pcie-rcar.c
rename to drivers/pci/controller/pcie-rcar-host.c
-- 
2.7.4

