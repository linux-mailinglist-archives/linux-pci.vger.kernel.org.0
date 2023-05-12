Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876B9700117
	for <lists+linux-pci@lfdr.de>; Fri, 12 May 2023 09:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240225AbjELHKO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 May 2023 03:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240224AbjELHJU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 May 2023 03:09:20 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A45D2680;
        Fri, 12 May 2023 00:06:45 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34C75BZ9122235;
        Fri, 12 May 2023 02:05:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683875111;
        bh=nAEYrJXhG8c2IqsEipikz1ePtIEvbDs0B+ioU9XH3HQ=;
        h=From:To:CC:Subject:Date;
        b=lq1dp/5Cx6GS2mEFARS4JiYLlnGrrgqGy9Ps+GU2mx6GpHiN2g8+Y3BtRlIq7zd99
         3m5OTQ3gQ0OFKzFv08vsYoxSZkOU8NVGW9SNXcepCclJ3oevPrVljZf5t33z+k9T81
         nyRXOacDitqv/vKIO5cS8DHxSdfddWwwtBPyxYxw=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34C75Bp0011997
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 May 2023 02:05:11 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 12
 May 2023 02:05:11 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 12 May 2023 02:05:11 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34C75ABO085066;
        Fri, 12 May 2023 02:05:11 -0500
From:   Achal Verma <a-verma1@ti.com>
To:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "N_colas F . R . A . Prado" <nfraprado@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        Rafa_ Mi_ecki <rafal@milecki.pl>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, Milind Parab <mparab@cadence.com>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, Achal Verma <a-verma1@ti.com>
Subject: [PATCH 0/3] Add support to build pci-j721e as a kernel module
Date:   Fri, 12 May 2023 12:35:07 +0530
Message-ID: <20230512070510.1873171-1-a-verma1@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

J721e PCie driver is not required during linux boot, thus it should be
build as a loadable kernel module. This series add support to build pci-j721e
driver and pcie-cadence library as lodable modules.

Achal Verma (2):
  PCIE: j721e: Add support to build pci-j721e as a kernel module
  arm64: defconfig: enable PCIe controller on TI platforms

Kishon Vijay Abraham I (1):
  PCI: cadence: Add support to build pcie-cadence library as a kernel
    module.

 arch/arm64/configs/defconfig                  |   7 +
 drivers/pci/controller/cadence/Kconfig        |  12 +-
 drivers/pci/controller/cadence/Makefile       |   2 +
 drivers/pci/controller/cadence/pci-j721e-ep.c | 130 +++++++
 .../pci/controller/cadence/pci-j721e-host.c   | 204 +++++++++++
 drivers/pci/controller/cadence/pci-j721e.c    | 343 +-----------------
 drivers/pci/controller/cadence/pci-j721e.h    |  88 +++++
 .../pci/controller/cadence/pcie-cadence-ep.c  |   4 +
 .../controller/cadence/pcie-cadence-host.c    |   5 +
 drivers/pci/controller/cadence/pcie-cadence.c |   9 +
 drivers/pci/controller/cadence/pcie-cadence.h |   4 +-
 11 files changed, 473 insertions(+), 335 deletions(-)
 create mode 100644 drivers/pci/controller/cadence/pci-j721e-ep.c
 create mode 100644 drivers/pci/controller/cadence/pci-j721e-host.c
 create mode 100644 drivers/pci/controller/cadence/pci-j721e.h

-- 
2.25.1

