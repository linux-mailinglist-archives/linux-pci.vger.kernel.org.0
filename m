Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491C070195B
	for <lists+linux-pci@lfdr.de>; Sat, 13 May 2023 20:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbjEMSqn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 13 May 2023 14:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbjEMSqm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 13 May 2023 14:46:42 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F55F1FE7;
        Sat, 13 May 2023 11:46:41 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34DIkL9a020730;
        Sat, 13 May 2023 13:46:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684003581;
        bh=FoD2T3LojdIzEds4W1JZPhABIQecZl+CEOroidmMWKs=;
        h=From:To:CC:Subject:Date;
        b=uz8a3RiY9TyGP5pnTVrhaZ8sq+IvG+inSf9WoNqT+VzghcDbKgsClSKBLbk3NVt//
         ZxJC6x/RZFODa/mPJ3P5EaBXk3VQJXl/NjTMQXL/2/kE8hxKJtjRtDhQBDCGY8olj9
         dADVj6t0l6/Am0IH01DvQy5YxvkODCDadd+2lADg=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34DIkLYp011316
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 13 May 2023 13:46:21 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 13
 May 2023 13:46:21 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 13 May 2023 13:46:21 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34DIkKun128428;
        Sat, 13 May 2023 13:46:21 -0500
From:   Achal Verma <a-verma1@ti.com>
To:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, Milind Parab <mparab@cadence.com>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, Achal Verma <a-verma1@ti.com>
Subject: [PATCH 0/2] Add support to build pci-j721e as a kernel module
Date:   Sun, 14 May 2023 00:16:18 +0530
Message-ID: <20230513184620.2200916-1-a-verma1@ti.com>
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

Changes from v1:
* Reword subject line to use PCI in place of PCIe to maintain consistency
with older commit messages.
* Fix word wrapping in commit message to 75 columns and add newline
between paragraphs.
* Drop PATCH 3 (defconfig changes) from v1 and will repost it
separately.

Achal Verma (1):
  PCI: j721e: Add support to build pci-j721e as a kernel module

Kishon Vijay Abraham I (1):
  PCI: cadence: Add support to build pcie-cadence library as a kernel
    module.

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
 10 files changed, 466 insertions(+), 335 deletions(-)
 create mode 100644 drivers/pci/controller/cadence/pci-j721e-ep.c
 create mode 100644 drivers/pci/controller/cadence/pci-j721e-host.c
 create mode 100644 drivers/pci/controller/cadence/pci-j721e.h

-- 
2.25.1

