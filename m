Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7E0BD477
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2019 23:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731571AbfIXVqe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Sep 2019 17:46:34 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44544 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728813AbfIXVqe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Sep 2019 17:46:34 -0400
Received: by mail-ot1-f66.google.com with SMTP id 21so2887760otj.11;
        Tue, 24 Sep 2019 14:46:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1EA8rb2xQcb5dg7rm6kSLl37zgnf6FJeYhc+aCc8i8Q=;
        b=I4MqBB7D6G9IB9eikhptdpigVqlB8E9B8nERW92DNAswHz6a2HOiKOJePj2mCM2FRG
         zuAZcwKAhv3MZAJfDrA3be+UOOxcmubtSCsRsQSr2FsO8pPerpLb6eRWuemoIueeedFX
         HELYdLwi92qDWLEzaZ2LdyslJcErcCSXDDkliHf26Zs7vb1YhnsKdgcPVy6Kh3Pcbn2y
         ESz/rUOkt/d6xm5qvwNNrlcaS0rOO9zniKFoIIr5NIbXE2jYO4gB/PimMrpQfGyMseFO
         BKtv5wp1Vyp2qtLdX53p10yQFgZg7JOV0aE5wTBDxTVxigAPmTjb/NiS9zAdAZ8dhQcl
         lnDg==
X-Gm-Message-State: APjAAAWRamie8QhgtCuN6iYbc8U6TWmxN47+dM4yrOk0tEQC/tS5nPO9
        AY/5PkKfypDgsbimKO2l0H2d9U0=
X-Google-Smtp-Source: APXvYqyfVq4l/5/hBZkfgpAi1Pc1khFxc5Y5xwdvEOTzeXf8zarYTh54eCs4NscjomBDZ62d4/y0HA==
X-Received: by 2002:a05:6830:16da:: with SMTP id l26mr3762822otr.339.1569361592670;
        Tue, 24 Sep 2019 14:46:32 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id s66sm976787otb.65.2019.09.24.14.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 14:46:31 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Ley Foon Tan <lftan@altera.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Ray Jui <rjui@broadcom.com>, rfi@lists.rocketboards.org,
        Ryder Lee <ryder.lee@mediatek.com>,
        Scott Branden <sbranden@broadcom.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Horman <horms@verge.net.au>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Toan Le <toan@os.amperecomputing.com>,
        Tom Joseph <tjoseph@cadence.com>, Will Deacon <will@kernel.org>
Subject: [PATCH 00/11] PCI dma-ranges parsing consolidation
Date:   Tue, 24 Sep 2019 16:46:19 -0500
Message-Id: <20190924214630.12817-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series moves the DT 'dma-ranges' parsing into common helpers
utilizing a resource list. In the process of doing this, I noticed
several cases where pci_parse_request_of_pci_ranges() could be used so
I converted those drivers first. The last 5 patches make the actual
change to use the common 'dma_ranges' resource list. There's no
(intended) functional change in this series though I'm also working on
a separate series to improve the handling of 'dma-ranges' and dma
masks.

pci-rcar-gen2 is the only remaining driver doing its own dma-ranges
handling as it is still using the old ARM PCI functions. Looks like it
is the last one (in drivers/pci/).

Compile tested only.

Rob

Rob Herring (11):
  PCI: aardvark: Use pci_parse_request_of_pci_ranges()
  PCI: altera: Use pci_parse_request_of_pci_ranges()
  PCI: mediatek: Use pci_parse_request_of_pci_ranges()
  PCI: versatile: Enable COMPILE_TEST
  PCI: versatile: Use pci_parse_request_of_pci_ranges()
  PCI: of: Add inbound resource parsing to helpers
  PCI: ftpci100: Use inbound resources for setup
  PCI: v3-semi: Use inbound resources for setup
  PCI: xgene: Use inbound resources for setup
  PCI: iproc: Use inbound resources for setup
  PCI: rcar: Use inbound resources for setup

 drivers/pci/controller/Kconfig                |  2 +-
 .../pci/controller/dwc/pcie-designware-host.c |  3 +-
 drivers/pci/controller/pci-aardvark.c         | 58 ++---------------
 drivers/pci/controller/pci-ftpci100.c         | 29 ++++-----
 drivers/pci/controller/pci-host-common.c      |  2 +-
 drivers/pci/controller/pci-v3-semi.c          | 40 +++++-------
 drivers/pci/controller/pci-versatile.c        | 62 ++++--------------
 drivers/pci/controller/pci-xgene.c            | 33 ++++------
 drivers/pci/controller/pcie-altera.c          | 38 +----------
 drivers/pci/controller/pcie-cadence-host.c    |  2 +-
 drivers/pci/controller/pcie-iproc-platform.c  |  1 +
 drivers/pci/controller/pcie-iproc.c           | 63 +++----------------
 drivers/pci/controller/pcie-mediatek.c        | 47 +++++---------
 drivers/pci/controller/pcie-mobiveil.c        |  4 +-
 drivers/pci/controller/pcie-rcar.c            | 48 ++++++--------
 drivers/pci/controller/pcie-rockchip-host.c   |  3 +-
 drivers/pci/controller/pcie-xilinx-nwl.c      |  2 +-
 drivers/pci/controller/pcie-xilinx.c          |  2 +-
 drivers/pci/of.c                              | 44 ++++++++++++-
 drivers/pci/pci.h                             |  8 ++-
 include/linux/pci.h                           |  2 +
 21 files changed, 162 insertions(+), 331 deletions(-)

--
2.20.1
