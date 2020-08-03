Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA21E23AED0
	for <lists+linux-pci@lfdr.de>; Mon,  3 Aug 2020 23:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbgHCVBV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Aug 2020 17:01:21 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:44953 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728889AbgHCVBU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Aug 2020 17:01:20 -0400
Received: by mail-io1-f46.google.com with SMTP id v6so24749093iow.11;
        Mon, 03 Aug 2020 14:01:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=caU68Vks0Qq0qRNr1RcbbJo83bu5SQyVcphbC7uR/pw=;
        b=eLf7LczPFnRjHgztRiF/SzIF4maOualtTBucdu4jKPARDpvweRK/8Ikey/hZ9uKHmW
         q3ulkz9TB+0gsZyhMRRGV+RT0JScLW6eiRuVdy0h6Cs9wI3YAXyt530hyDYwClmvIrnF
         PBSgvTeMUe4FM2Ri+r6Cu8rwmmPGbQ5HmLOvi3dURAioxjNXCSC6As/uyiRkpax9kg+I
         MwVRonkBibAPH3Vqigm4NoLUZj9BsEoJF8P8u54s07kI5vpFnti4NApiVsjTXwetrzfw
         Q7LbHWkLqRJaqwsn0wJl+urSidxjXe6DKTZ4jczt8GbdHlu8z0UQK1m9LWCB9sRnQUv+
         icrQ==
X-Gm-Message-State: AOAM530Wwp4vl3i/+A3lSiRwqAzCAJpP9Q+vPMGfTU/d18C2iXNGfuqi
        1l7FTE3qx6SK7JIOdqNsdg==
X-Google-Smtp-Source: ABdhPJwLvkQ8nLiW6KyvJ0FE/ZZBxba/47A0nMcMogCK9MlyD6FPHyseUZgrOPhESgV+UWpEU2XPBA==
X-Received: by 2002:a5d:9b96:: with SMTP id r22mr1872679iom.66.1596488479389;
        Mon, 03 Aug 2020 14:01:19 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id r6sm9292280iod.7.2020.08.03.14.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 14:01:18 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Yue Wang <yue.wang@Amlogic.com>
Subject: [RFC 00/27] PCI: dwc: Driver clean-ups
Date:   Mon,  3 Aug 2020 15:00:49 -0600
Message-Id: <20200803210116.3132633-1-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is a series of clean-ups for the Designware PCI driver. The series
primarily reworks the config space accessors to use the existing pci_ops
struct and removes various private data that's also present in the
pci_host_bridge struct. There's also some duplicated common (PCI and
DWC) register defines which I converted to use the common defines.

This is compile tested only as I don't have any DWC based h/w, so any
testing would be helpful. This is an RFC as it will need to be rebased
on 5.9-rc1 and my previous clean-up series.

Rob


Rob Herring (27):
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
  PCI: dwc/meson: Drop unnecessary RC config space initialization
  PCI: dwc/meson: Rework PCI config and DW port logic register accesses
  PCI: dwc/qcom: Use common PCI register definitions
  PCI: dwc: Remove hardcoded PCI_CAP_ID_EXP offset
  PCI: dwc/tegra: Use common Designware port logic register definitions

 drivers/pci/controller/dwc/pci-dra7xx.c       |   4 +-
 drivers/pci/controller/dwc/pci-exynos.c       |  45 +--
 drivers/pci/controller/dwc/pci-imx6.c         |   6 +-
 drivers/pci/controller/dwc/pci-keystone.c     |  90 +++--
 drivers/pci/controller/dwc/pci-meson.c        | 164 +++------
 drivers/pci/controller/dwc/pcie-al.c          |  70 +---
 drivers/pci/controller/dwc/pcie-artpec6.c     |  11 +-
 .../pci/controller/dwc/pcie-designware-host.c | 319 ++++++------------
 .../pci/controller/dwc/pcie-designware-plat.c |   4 +-
 drivers/pci/controller/dwc/pcie-designware.h  |  28 +-
 drivers/pci/controller/dwc/pcie-histb.c       |  45 +--
 drivers/pci/controller/dwc/pcie-kirin.c       |  43 +--
 drivers/pci/controller/dwc/pcie-qcom.c        |  31 +-
 drivers/pci/controller/dwc/pcie-spear13xx.c   |   4 +-
 drivers/pci/controller/dwc/pcie-tegra194.c    |  90 +++--
 drivers/pci/controller/dwc/pcie-uniphier.c    |   3 +-
 drivers/pci/probe.c                           |  14 +-
 include/linux/pci.h                           |   1 +
 18 files changed, 368 insertions(+), 604 deletions(-)

--
2.25.1
