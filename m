Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04EE6BE226
	for <lists+linux-pci@lfdr.de>; Fri, 17 Mar 2023 08:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjCQHvk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Mar 2023 03:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjCQHvj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Mar 2023 03:51:39 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E535394A67;
        Fri, 17 Mar 2023 00:51:36 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32H7pMD5070589;
        Fri, 17 Mar 2023 02:51:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679039482;
        bh=c1MQpw5nb+wXiRbHyQfP13b2Ssci8QiAkLF+AXXLE+E=;
        h=From:To:CC:Subject:Date;
        b=C/msVYrsBqN0yl+PLCxhOoTe52wKRqPsw1MXXNK+2bzm26S3wuh1Iu9XoVT7769Fd
         wrCUUyZAfr5QjE6AlAg6l3gG3Lh/4MP164DwumnID7NSWan8hqytOdGlzXtodqJlt3
         trS8or4++QOJFfx4zVPKGyxkCuSx3IdwJWUjSL10=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32H7pMJr004708
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Mar 2023 02:51:22 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 17
 Mar 2023 02:51:21 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 17 Mar 2023 02:51:22 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32H7pKL9100645;
        Fri, 17 Mar 2023 02:51:21 -0500
From:   Achal Verma <a-verma1@ti.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Dhananjay Vilasrao Kangude <dkangude@cadence.com>,
        Anindita Das <dasa@cadence.com>,
        Yuan Zhao <yuanzhao@cadence.com>,
        Milind Parab <mparab@cadence.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Achal Verma <a-verma1@ti.com>
Subject: [PATCH v11 0/5] PCI: add 4x lane support for pci-j721e controllers
Date:   Fri, 17 Mar 2023 13:21:15 +0530
Message-ID: <20230317075120.506267-1-a-verma1@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

Changes from v10:
* Rebase on next-20230317

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

