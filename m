Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD1324CBB0
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 05:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgHUDy1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Aug 2020 23:54:27 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39107 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbgHUDy0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2020 23:54:26 -0400
Received: by mail-io1-f68.google.com with SMTP id z17so470442ioi.6;
        Thu, 20 Aug 2020 20:54:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3xQSyuidDHE000cQW3ruY29YdVzjzemLhdUCUqMHH4g=;
        b=uoec5P7k+QAy4T9/nm7pq0b8CZje786rS41068pS6CuvKKElqVH0zc86wKhU1rkXSe
         ge4AYyvkGT10QcwxPl5s4FNn3zXyEh88p3p7pnatrqZhv+8a0fAED8IrnyN0dOuA0dP3
         FoJu6YDc31iTC92MApZVcmxVDWZMOXpghYkKpthOhc5K6RqEKpd4hPOY76gUymCZH13d
         ADQ4fUteyv4DoXI3X+A6sOndgAcxHQdQar6paKB5HJNIkWA7rPzYxpLn+Gyxuayc5Eeq
         2Ug4CDQwa90FUQtT0CiLaNF8vHAlG96DLJDiHRO8Pv0SM6bnnDFX27RUyoJkpf04SbF9
         Wzxg==
X-Gm-Message-State: AOAM5328FtueSOGCteuIevaPKX7ePcTf/Z+LVefPGpw5+H6RkW6wmSme
        yR4WJssPaXKPcUZ+tWasnA==
X-Google-Smtp-Source: ABdhPJwWDZ2uF1UR52gyVwJrVKI7xgxX5Bug8MFl6x6tEW09K4V+Q0/1o3ijFf216rQPvCw1DGjTMQ==
X-Received: by 2002:a6b:e70d:: with SMTP id b13mr795565ioh.141.1597982065025;
        Thu, 20 Aug 2020 20:54:25 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id 79sm413923ilc.9.2020.08.20.20.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 20:54:24 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dilip Kota <eswara.kota@linux.intel.com>,
        Fabio Estevam <festevam@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Yue Wang <yue.wang@Amlogic.com>, Marc Zyngier <maz@kernel.org>,
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v2 00/40] PCI: dwc: Driver clean-ups
Date:   Thu, 20 Aug 2020 21:53:40 -0600
Message-Id: <20200821035420.380495-1-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is a series of clean-ups for the Designware PCI driver. The series
initially reworks the config space accessors to use the existing pci_ops
struct. Then there's removal of various private data that's also present
in the pci_host_bridge struct. There's also some duplicated common (PCI
and DWC) register defines which I converted to use the common defines.
Finally, the initialization for speed/gen, number of lanes, and N_FTS
are all moved to the common DWC code.

This is compile tested only as I don't have any DWC based h/w, so any
testing would be helpful. A branch is here[1].

Rob

[1] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git pci-dw-cleanups

Rob Herring (40):
  PCI: Allow root and child buses to have different pci_ops
  PCI: dwc: Use DBI accessors instead of own config accessors
  PCI: dwc: Allow overriding bridge pci_ops
  PCI: dwc: Add a default pci_ops.map_bus for root port
  PCI: dwc: al: Use pci_ops for child config space accessors
  PCI: dwc: keystone: Use pci_ops for config space accessors
  PCI: dwc: tegra: Use pci_ops for root config space accessors
  PCI: dwc: meson: Use pci_ops for root config space accessors
  PCI: dwc: kirin: Use pci_ops for root config space accessors
  PCI: dwc: exynos: Use pci_ops for root config space accessors
  PCI: dwc: histb: Use pci_ops for root config space accessors
  PCI: dwc: Remove dwc specific config accessor ops
  PCI: dwc: Use generic config accessors
  PCI: Also call .add_bus() callback for root bus
  PCI: dwc: keystone: Convert .scan_bus() callback to use add_bus
  PCI: dwc: Convert to use pci_host_probe()
  PCI: dwc: Remove root_bus pointer
  PCI: dwc: Remove storing of PCI resources
  PCI: dwc: Simplify config space handling
  PCI: dwc/keystone: Drop duplicated 'num-viewport'
  PCI: dwc: Check CONFIG_PCI_MSI inside dw_pcie_msi_init()
  PCI: dwc/imx6: Remove duplicate define PCIE_LINK_WIDTH_SPEED_CONTROL
  PCI: dwc: Add a 'num_lanes' field to struct dw_pcie
  PCI: dwc: Ensure FAST_LINK_MODE is cleared
  PCI: dwc/meson: Drop the duplicate number of lanes setup
  PCI: dwc/meson: Drop unnecessary RC config space initialization
  PCI: dwc/meson: Rework PCI config and DW port logic register accesses
  PCI: dwc/imx6: Use common PCI register definitions
  PCI: dwc/qcom: Use common PCI register definitions
  PCI: dwc: Remove hardcoded PCI_CAP_ID_EXP offset
  PCI: dwc/tegra: Use common Designware port logic register definitions
  PCI: dwc: Remove read_dbi2 code
  PCI: dwc: Make ATU accessors private
  PCI: dwc: Centralize link gen setting
  PCI: dwc: Set PORT_LINK_DLL_LINK_EN in common setup code
  PCI: dwc/intel-gw: Drop unnecessary checking of DT 'device_type'
    property
  PCI: dwc/intel-gw: Move getting PCI_CAP_ID_EXP offset to
    intel_pcie_link_setup()
  PCI: dwc/intel-gw: Drop unused max_width
  PCI: dwc: Move N_FTS setup to common setup
  PCI: dwc: Use DBI accessors

 drivers/pci/controller/dwc/pci-dra7xx.c       |  29 +-
 drivers/pci/controller/dwc/pci-exynos.c       |  45 +--
 drivers/pci/controller/dwc/pci-imx6.c         |  52 +--
 drivers/pci/controller/dwc/pci-keystone.c     | 126 ++-----
 drivers/pci/controller/dwc/pci-meson.c        | 156 ++-------
 drivers/pci/controller/dwc/pcie-al.c          |  70 +---
 drivers/pci/controller/dwc/pcie-artpec6.c     |  48 +--
 .../pci/controller/dwc/pcie-designware-ep.c   |  11 +-
 .../pci/controller/dwc/pcie-designware-host.c | 319 ++++++------------
 .../pci/controller/dwc/pcie-designware-plat.c |   4 +-
 drivers/pci/controller/dwc/pcie-designware.c  | 104 +++---
 drivers/pci/controller/dwc/pcie-designware.h  |  54 +--
 drivers/pci/controller/dwc/pcie-histb.c       |  45 +--
 drivers/pci/controller/dwc/pcie-intel-gw.c    |  65 +---
 drivers/pci/controller/dwc/pcie-kirin.c       |  43 +--
 drivers/pci/controller/dwc/pcie-qcom.c        |  33 +-
 drivers/pci/controller/dwc/pcie-spear13xx.c   |  39 +--
 drivers/pci/controller/dwc/pcie-tegra194.c    | 120 ++-----
 drivers/pci/controller/dwc/pcie-uniphier.c    |   3 +-
 drivers/pci/probe.c                           |  14 +-
 include/linux/pci.h                           |   1 +
 21 files changed, 443 insertions(+), 938 deletions(-)

--
2.25.1
