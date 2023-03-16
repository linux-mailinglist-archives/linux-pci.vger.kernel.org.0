Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912926BC6B7
	for <lists+linux-pci@lfdr.de>; Thu, 16 Mar 2023 08:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjCPHOR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Mar 2023 03:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjCPHOL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Mar 2023 03:14:11 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FC61E5DB;
        Thu, 16 Mar 2023 00:13:46 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32G7CeHD018055;
        Thu, 16 Mar 2023 02:12:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678950760;
        bh=qTGGdmEfncUObPnKwYt/s+1ApXFC0ELn3QBSi31t74Q=;
        h=From:To:CC:Subject:Date;
        b=dKYb8T0EFXDUStn/SHMHBb6DlyYV5l4TuaPU8TbyWvSgaW7MQlsBa7KfCOLfS6ZrZ
         XbTFl+ngllssM8XIf5H/l96zQzpi9S8idEzEjp7e+oHu1No6tftzNIIAPawVpM3R8K
         E1OBAve+B0mj45d6FfQfKm3l7vBdVrvFjfLrWbjY=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32G7CeM5005141
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Mar 2023 02:12:40 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 16
 Mar 2023 02:12:39 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 16 Mar 2023 02:12:39 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32G7Ccnq126695;
        Thu, 16 Mar 2023 02:12:39 -0500
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
        Milind Parab <mparab@cadence.com>,
        <wojciech.jasko-EXT@continental-corporation.com>
Subject: [PATCH v10 0/5] PCI: add 4x lane support for pci-j721e controllers
Date:   Thu, 16 Mar 2023 12:42:33 +0530
Message-ID: <20230316071238.200992-1-a-verma1@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Adding of additional support to Cadence PCIe controller (i.e. pci-j721e.c)
for up to 4x lanes, and reworking of driver to define maximum lanes per
board configuration.

Changes from v1:
* Reworked 'PCI: j721e: Add PCIe 4x lane selection support' to not cause
  regressions on 1-2x lane platforms

Changes from v2:
* Correct dev_warn format string from %d to %u since lane count is a
  unsigned integer
* Update CC list

Changes from v3:
* Use the max_lanes setting per chip for the mask size required since
  bootloader could have set num_lanes to a higher value that the
  device tree which would leave in an undefined state
* Reorder patches do the previous change to not break bisect
* Remove line breaking for dev_warn to allow better grepping and since
  no strict 80 columns anymore

Changes from v4:
* Correct invalid settings for j7200 PCIe RC + EP
* Add j784s4 configuration for selection of 4x lanes

Changes from v5:
* Dropped 'PCI: j721e: Add warnings on num-lanes misconfiguration' patch
  from series
* Reworded 'PCI: j721e: Add per platform maximum lane settings' commit
  message
* Added yaml documentation and schema checks for ti,j721e-pci-* lane
  checking

Changes from v6:
* Fix wordwrapping in commit messages from ~65 columns to correct 75
  columns
* Re-ran get_maintainers.pl to add missing maintainers in CC

Changes from v7:
* Addressed review comments in ti,j721e-pci-ep.yaml and
  ti,j721e-pci-host.yaml from v6
* Added warn message if num-lanes property value is invalid.
* Addressed build issue reported in
  https://lore.kernel.org/all/202211260346.4JvNnDdc-lkp@intel.com/

Changes from v8:
* Use "const: 1" in ti,j721e-pci-ep.yaml and ti,j721e-pci-host.yaml
  when num-lanes min and max values are equal.

Changes from v9:
* Rebase on next-20230315

Matt Ranostay (5):
  dt-bindings: PCI: ti,j721e-pci-*: add checks for num-lanes
  PCI: j721e: Add per platform maximum lane settings
  PCI: j721e: Add PCIe 4x lane selection support
  dt-bindings: PCI: ti,j721e-pci-*: add j784s4-pci-* compatible strings
  PCI: j721e: add j784s4 PCIe configuration

 .../bindings/pci/ti,j721e-pci-ep.yaml         | 39 ++++++++++++++--
 .../bindings/pci/ti,j721e-pci-host.yaml       | 39 ++++++++++++++--
 drivers/pci/controller/cadence/pci-j721e.c    | 45 ++++++++++++++++---
 3 files changed, 112 insertions(+), 11 deletions(-)

-- 
2.25.1

