Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502202A8891
	for <lists+linux-pci@lfdr.de>; Thu,  5 Nov 2020 22:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730973AbgKEVME (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Nov 2020 16:12:04 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37072 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgKEVME (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Nov 2020 16:12:04 -0500
Received: by mail-ot1-f66.google.com with SMTP id l36so2784555ota.4;
        Thu, 05 Nov 2020 13:12:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6kX9EfPGIe+vgEipGeuVSOOPuy47rKZgDC38PEky6/I=;
        b=CrRfm9C5yK84aNS9TNuLdEnYRU0jVjTMmVteuSPDoRqnawZbMBmL2GwfLVFggx2p5f
         3HV1iTZgxGbna50RyNsTwPQTPaTns0NK6EOQ4Gs12Y9RiduJvGNp72W1omqfnlmlWjdC
         PBxAU9Mnjangp50Lb6y/XTaNYgQI+GN1na+Ep6sZnSoun0wsUG+sad5y31N9/6o7nrrQ
         B2YrWxWbe68wbslxqHJibKXOAilgKlD7zHtSAl2egXJv4HfFg6ZcOIirkplgaYlPtda3
         rV4RKHAf73aLI2pWBFCuETcqCmY3hEPe+k4n3hWqYr1QG+x7qncx5ATNuHLumdy488A8
         gpZQ==
X-Gm-Message-State: AOAM533JSSiLT+yYKOUVl1Kfv4Ie0Q5mqoDMNmZR+fo2v6qpMVAlYum2
        P4ffGjTvK3tSNWticWi7fw==
X-Google-Smtp-Source: ABdhPJxfRm6a7WlZFra36M/W0cF8B4tklW/+2/U/J4e/fwp/StQ3JtLqn3HUrYnVIqGDvSo8N+eI0w==
X-Received: by 2002:a05:6830:22c9:: with SMTP id q9mr3230515otc.48.1604610722735;
        Thu, 05 Nov 2020 13:12:02 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id z19sm622549ooi.32.2020.11.05.13.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 13:12:01 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Andy Gross <agross@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
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
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Roy Zang <roy.zang@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Yue Wang <yue.wang@Amlogic.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Vidya Sagar <vidyas@nvidia.com>
Subject: [PATCH v2 00/16] PCI: dwc: Another round of clean-ups
Date:   Thu,  5 Nov 2020 15:11:43 -0600
Message-Id: <20201105211159.1814485-1-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Here's another batch of DWC PCI host refactoring. This series primarily
moves more of the MSI, link up, and resource handling to the core
code. Beyond a couple of minor fixes, new in this version is runtime
detection of iATU regions instead of using DT properties.

No doubt I've probably broken something. Please test. I've run this thru
kernelci and checked boards with DWC PCI which currently is just
Layerscape boards (hint: add boards and/or enable PCI). A git branch is
here[1].

This is dependent on "PCI: dwc: Restore ATU memory resource setup to use
last entry" which will be in v5.10-rc3.

Rob

[1] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git pci-more-dwc-cleanup

Rob Herring (16):
  PCI: dwc: Support multiple ATU memory regions
  PCI: dwc/intel-gw: Move ATU offset out of driver match data
  PCI: dwc: Move "dbi", "dbi2", and "addr_space" resource setup into
    common code
  PCI: dwc/intel-gw: Remove some unneeded function wrappers
  PCI: dwc: Ensure all outbound ATU windows are reset
  PCI: dwc/dra7xx: Use the common MSI irq_chip
  PCI: dwc: Drop the .set_num_vectors() host op
  PCI: dwc: Move MSI interrupt setup into DWC common code
  PCI: dwc: Rework MSI initialization
  PCI: dwc: Move link handling into common code
  PCI: dwc: Move dw_pcie_msi_init() into core
  PCI: dwc: Move dw_pcie_setup_rc() to DWC common code
  PCI: dwc: Remove unnecessary wrappers around dw_pcie_host_init()
  Revert "PCI: dwc/keystone: Drop duplicated 'num-viewport'"
  PCI: dwc: Move inbound and outbound windows to common struct
  PCI: dwc: Detect number of iATU windows

 drivers/pci/controller/dwc/pci-dra7xx.c       | 141 +-----------------
 drivers/pci/controller/dwc/pci-exynos.c       |  50 ++-----
 drivers/pci/controller/dwc/pci-imx6.c         |  39 +----
 drivers/pci/controller/dwc/pci-keystone.c     |  79 ++--------
 .../pci/controller/dwc/pci-layerscape-ep.c    |  37 +----
 drivers/pci/controller/dwc/pci-layerscape.c   |  67 +--------
 drivers/pci/controller/dwc/pci-meson.c        |  53 ++-----
 drivers/pci/controller/dwc/pcie-al.c          |  29 +---
 drivers/pci/controller/dwc/pcie-armada8k.c    |  37 ++---
 drivers/pci/controller/dwc/pcie-artpec6.c     |  76 +---------
 .../pci/controller/dwc/pcie-designware-ep.c   |  58 +++----
 .../pci/controller/dwc/pcie-designware-host.c | 139 ++++++++++-------
 .../pci/controller/dwc/pcie-designware-plat.c |  70 +--------
 drivers/pci/controller/dwc/pcie-designware.c  |  93 +++++++++++-
 drivers/pci/controller/dwc/pcie-designware.h  |  24 +--
 drivers/pci/controller/dwc/pcie-histb.c       |  37 ++---
 drivers/pci/controller/dwc/pcie-intel-gw.c    |  67 ++-------
 drivers/pci/controller/dwc/pcie-kirin.c       |  62 +-------
 drivers/pci/controller/dwc/pcie-qcom.c        |  38 +----
 drivers/pci/controller/dwc/pcie-spear13xx.c   |  62 +++-----
 drivers/pci/controller/dwc/pcie-tegra194.c    |  41 +----
 drivers/pci/controller/dwc/pcie-uniphier-ep.c |  38 +----
 drivers/pci/controller/dwc/pcie-uniphier.c    |  51 +------
 23 files changed, 356 insertions(+), 1032 deletions(-)

--
2.25.1
