Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62DC77F60C
	for <lists+linux-pci@lfdr.de>; Thu, 17 Aug 2023 14:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239242AbjHQMJB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Aug 2023 08:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350655AbjHQMIi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Aug 2023 08:08:38 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DA02727;
        Thu, 17 Aug 2023 05:08:36 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37HC8Oll076675;
        Thu, 17 Aug 2023 07:08:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1692274104;
        bh=v2w3PtpvpeBzi4+5Dp62j/KXIWRJIJkrU2tz8eBNJ10=;
        h=From:To:CC:Subject:Date;
        b=IZA7jAF6pw9gknwzb642apS4p9yw/IUKVFsA2diOmHY/JIAI7p59j6CW+D/+TXRmI
         5JW7KtO0SLCThZiArXJNOADoUEQeTIWDDJBUPBhHHGLWsM2ilmarRch7KsfadcLiVR
         mK7qcKJtBUFwLR150BLqIlH5aZHLQaOaqHwSN9lM=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37HC8OLs016719
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Aug 2023 07:08:24 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 17
 Aug 2023 07:08:24 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 17 Aug 2023 07:08:24 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37HC8Ni5025391;
        Thu, 17 Aug 2023 07:08:23 -0500
From:   Achal Verma <a-verma1@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Achal Verma <a-verma1@ti.com>
Subject: [RFC PATCH 0/2] Add support to build pci-j721e as a kernel module
Date:   Thu, 17 Aug 2023 17:38:21 +0530
Message-ID: <20230817120823.1158766-1-a-verma1@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci-j721e driver is not required during linux boot, thus it should be
build as a loadable kernel module. This series add support to build
pci-j721e driver and pcie-cadence library as lodable modules.

Last posted: https://lore.kernel.org/all/20230513184620.2200916-1-a-verma1@ti.com/#t

Achal Verma (1):
  PCI: j721e: Add support to build pci-j721e as a kernel module

Kishon Vijay Abraham I (1):
  PCI: cadence: Add support to build pcie-cadence library as a kernel
    module

 drivers/pci/controller/cadence/Kconfig        |  12 +-
 drivers/pci/controller/cadence/Makefile       |   2 +
 drivers/pci/controller/cadence/pci-j721e-ep.c | 130 ++++++
 .../pci/controller/cadence/pci-j721e-host.c   | 208 ++++++++++
 drivers/pci/controller/cadence/pci-j721e.c    | 382 +++---------------
 drivers/pci/controller/cadence/pci-j721e.h    |  96 +++++
 .../pci/controller/cadence/pcie-cadence-ep.c  |   4 +
 .../controller/cadence/pcie-cadence-host.c    |  27 ++
 drivers/pci/controller/cadence/pcie-cadence.c |  21 +
 drivers/pci/controller/cadence/pcie-cadence.h |  11 +-
 10 files changed, 553 insertions(+), 340 deletions(-)
 create mode 100644 drivers/pci/controller/cadence/pci-j721e-ep.c
 create mode 100644 drivers/pci/controller/cadence/pci-j721e-host.c
 create mode 100644 drivers/pci/controller/cadence/pci-j721e.h

-- 
2.25.1

