Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536D629D4D1
	for <lists+linux-pci@lfdr.de>; Wed, 28 Oct 2020 22:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbgJ1Vys (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Oct 2020 17:54:48 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:42979 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728500AbgJ1Vwt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Oct 2020 17:52:49 -0400
Received: by mail-ua1-f68.google.com with SMTP id f15so140852uaq.9;
        Wed, 28 Oct 2020 14:52:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fkYpsqioT7Tb7YApRr6kOuIOqhvTBzDRVXioLFVYRRs=;
        b=k2jYjlcMKpMD2XLjyWigYvkY87yVovtG4wl8FuzmK1dE1jE5i1BrpDypzG1v6Q0mst
         cQbM+EW8kQbhvEfDQXqd7hc4PiVZJdoSWqHGyS9Fkgk0tfocLRRBgEcjXpUIwXRmpY0S
         zy0ePDgsJyJL34Zz0JP4BBcX9LbXdkOIas1QciWmqnMqA4NcO+3Z2ybeUsU1FPCSCfwm
         KZLJmmA+ZPu3+wRvWhJxy4eh6mBDEeK/dtcI2SFRoVoAkQ+odXzcuv2jf7OrMUjbBzOU
         4KuxNmskXgIPYIN/hh/0Rin/wzGry06MM2MQKtUVtR7wSBVeh9qS80WMtf4LwJIb+w0D
         ap2w==
X-Gm-Message-State: AOAM533tu8csPmSwVwbN6+ajQuF8Fb7ZkuCUfnQipkHLzaoRNi//d9yy
        igsRWRqrNaPLufw3srQNLLmbcQ/2Pw==
X-Google-Smtp-Source: ABdhPJzUHZm4YYIM4XMiwc5sacukMJ5Sdrdk/i+veAcVoB9ovA+Vih+j4WmB8WVNzg3/epAFFNC3mg==
X-Received: by 2002:a05:6830:1694:: with SMTP id k20mr912314otr.100.1603918009773;
        Wed, 28 Oct 2020 13:46:49 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id t17sm116123oor.3.2020.10.28.13.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 13:46:49 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, Andy Gross <agross@kernel.org>,
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
        Yue Wang <yue.wang@Amlogic.com>
Subject: [PATCH 00/13] PCI: dwc: Another round of clean-ups
Date:   Wed, 28 Oct 2020 15:46:33 -0500
Message-Id: <20201028204646.356535-1-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Here's another batch of DWC PCI host refactoring. This series primarily
moves more of the MSI, link up, and resource handling to the core
code.

No doubt I've probably broken something. Please test. A git branch is
here[1].

Rob

[1] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git pci-more-dwc-cleanup

Rob Herring (13):
  PCI: dwc/imx6: Drop setting PCI_MSI_FLAGS_ENABLE
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

 drivers/pci/controller/dwc/pci-dra7xx.c       | 141 +-----------------
 drivers/pci/controller/dwc/pci-exynos.c       |  50 ++-----
 drivers/pci/controller/dwc/pci-imx6.c         |  51 +------
 drivers/pci/controller/dwc/pci-keystone.c     |  68 +--------
 .../pci/controller/dwc/pci-layerscape-ep.c    |  37 +----
 drivers/pci/controller/dwc/pci-layerscape.c   |  67 +--------
 drivers/pci/controller/dwc/pci-meson.c        |  53 ++-----
 drivers/pci/controller/dwc/pcie-al.c          |  29 +---
 drivers/pci/controller/dwc/pcie-armada8k.c    |  37 ++---
 drivers/pci/controller/dwc/pcie-artpec6.c     |  76 +---------
 .../pci/controller/dwc/pcie-designware-ep.c   |  29 +++-
 .../pci/controller/dwc/pcie-designware-host.c |  80 ++++++----
 .../pci/controller/dwc/pcie-designware-plat.c |  70 +--------
 drivers/pci/controller/dwc/pcie-designware.h  |  12 +-
 drivers/pci/controller/dwc/pcie-histb.c       |  37 ++---
 drivers/pci/controller/dwc/pcie-intel-gw.c    |  59 ++------
 drivers/pci/controller/dwc/pcie-kirin.c       |  62 +-------
 drivers/pci/controller/dwc/pcie-qcom.c        |  38 +----
 drivers/pci/controller/dwc/pcie-spear13xx.c   |  62 +++-----
 drivers/pci/controller/dwc/pcie-tegra194.c    |  40 +----
 drivers/pci/controller/dwc/pcie-uniphier-ep.c |  38 +----
 drivers/pci/controller/dwc/pcie-uniphier.c    |  51 +------
 22 files changed, 217 insertions(+), 970 deletions(-)

--
2.25.1
