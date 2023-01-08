Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2908266165C
	for <lists+linux-pci@lfdr.de>; Sun,  8 Jan 2023 16:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjAHP6W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 8 Jan 2023 10:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjAHP6V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 8 Jan 2023 10:58:21 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EE6BCB5;
        Sun,  8 Jan 2023 07:58:20 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 308FvutR077257;
        Sun, 8 Jan 2023 09:57:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1673193476;
        bh=4RpCFnnGJ3Or8AcQasz5O0BD+9DLwxSIyjJFxPI0xFA=;
        h=From:To:CC:Subject:Date;
        b=TAOwjiFk2qjVFqPWSt1sB+Bhth2mVEtFei5gNMyGq3bG8EjKbtU/O/rQwCGrzLBn1
         PWMPbFuw5IoVj2767+FStbduYXV30zN9eHoc7Gfh8VijZfOugZze+tmAnuuSNgTPDW
         uQ/P3xSEhI/efqseNoGS67ZUOcFUWc6QR6IxOHuI=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 308Fvufb041755
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 8 Jan 2023 09:57:56 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Sun, 8
 Jan 2023 09:57:56 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Sun, 8 Jan 2023 09:57:56 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 308Fvtgr113997;
        Sun, 8 Jan 2023 09:57:55 -0600
From:   Achal Verma <a-verma1@ti.com>
To:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Achal Verma <a-verma1@ti.com>,
        Milind Parab <mparab@cadence.com>
Subject: [PATCH v2 0/2] Add support to build pci-j721e as a module.
Date:   Sun, 8 Jan 2023 21:27:53 +0530
Message-ID: <20230108155755.2614147-1-a-verma1@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Patch series to add support to build pci-j721e as module.
It requires pcie-cadence library to be built as a module too.

Changes from v1 to v2:
*)Resolve build failure of pci-j721e.o module because of its dependency 
  on pcie-cadence-host.o in following configuration as 
  Reported-by: kernel test robot <lkp@intel.com>

  CONFIG_PCIE_CADENCE=y
  CONFIG_PCIE_CADENCE_HOST=m
  CONFIG_PCIE_CADENCE_EP=y
  CONFIG_PCIE_CADENCE_PLAT=y
  CONFIG_PCIE_CADENCE_PLAT_EP=y
  CONFIG_PCI_J721E=y
  CONFIG_PCI_J721E_HOST=m
  CONFIG_PCI_J721E_EP=y

Achal Verma (2):
  PCI: cadence: Add support to build pcie-cadence library as module.
  PCI: j721e: Add support to build pci-j721e as module.

 drivers/pci/controller/cadence/Kconfig           | 16 ++++++++--------
 drivers/pci/controller/cadence/pci-j721e.c       |  6 +++++-
 drivers/pci/controller/cadence/pcie-cadence-ep.c |  4 ++++
 .../pci/controller/cadence/pcie-cadence-host.c   |  5 +++++
 drivers/pci/controller/cadence/pcie-cadence.c    |  9 +++++++++
 drivers/pci/controller/cadence/pcie-cadence.h    |  4 ++--
 6 files changed, 33 insertions(+), 11 deletions(-)

-- 
2.25.1

