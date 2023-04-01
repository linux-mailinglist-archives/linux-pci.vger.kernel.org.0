Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC51D6D302B
	for <lists+linux-pci@lfdr.de>; Sat,  1 Apr 2023 13:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjDAL1c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 1 Apr 2023 07:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjDAL11 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 1 Apr 2023 07:27:27 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D7425457;
        Sat,  1 Apr 2023 04:27:02 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 331BQYQh094885;
        Sat, 1 Apr 2023 06:26:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680348394;
        bh=W+MXFnEfkopbtJFIpkBc7tUZLZW+yMtB+YrUMRSQcG0=;
        h=From:To:CC:Subject:Date;
        b=mgRPcQv+q/e6yxTsEJg7RYwmg32/ILnRg+5mj3jFCuz+Y4FCiZymV5fJyfydZs+8v
         qT8dBL3/NCFMZxcXMrx519S/AiAGFpEtynCaGmLFOW3YYq+7aBsQJVLB6i8XHwGoWZ
         9lC1vYCY2ZUvT0woMZhY5mSbyUiMyzJiAS2QBNb4=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 331BQYdj120059
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 1 Apr 2023 06:26:34 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Sat, 1
 Apr 2023 06:26:34 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Sat, 1 Apr 2023 06:26:34 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 331BQXkn005537;
        Sat, 1 Apr 2023 06:26:34 -0500
From:   Achal Verma <a-verma1@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
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
Subject: [PATCH v12 0/5] PCI: add 4x lane support for pci-j721e controllers
Date:   Sat, 1 Apr 2023 16:56:28 +0530
Message-ID: <20230401112633.2406604-1-a-verma1@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
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

Changes from v12:
* Rebase on next-20230331

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

