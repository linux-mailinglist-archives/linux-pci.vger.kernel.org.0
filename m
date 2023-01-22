Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E647676CD6
	for <lists+linux-pci@lfdr.de>; Sun, 22 Jan 2023 13:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjAVMVm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 22 Jan 2023 07:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjAVMVk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 22 Jan 2023 07:21:40 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B164ECF;
        Sun, 22 Jan 2023 04:21:39 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30MCLNtB078561;
        Sun, 22 Jan 2023 06:21:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1674390084;
        bh=vRtiqaH2cZhvkH918KNFvAw1BTARHwz0aD7sKDLAmPo=;
        h=From:To:CC:Subject:Date;
        b=Qj2kZiwRLv9uADNVQWbqMjUlxE0qbsu6tjH3bXp6XMrQ1XOkdgdExnMMAA8lHPpFF
         TQ4s/Nyj2qVeZwtB0vlKIelKnNGySKaNB6mk/HaXHz5EjMhD3zSYUUmep28OuUQ5aK
         ivB+fXgHLUBL8Wi0hYMowBuOIv3rI/I6Dvu4SlnQ=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30MCLNDi066521
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 22 Jan 2023 06:21:23 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Sun, 22
 Jan 2023 06:21:23 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Sun, 22 Jan 2023 06:21:23 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30MCLM6T090032;
        Sun, 22 Jan 2023 06:21:22 -0600
From:   Achal Verma <a-verma1@ti.com>
To:     <mranostay@ti.com>, <rogerq@kernel.org>, <lpieralisi@kernel.org>,
        <robh@kernel.org>, <kw@linux.com>, <bhelgaas@google.com>,
        <krzysztof.kozlowski@linaro.org>, <vigneshr@ti.com>,
        <tjoseph@cadence.com>, <sergio.paracuellos@gmail.com>,
        <pthombar@cadence.com>, <linux-pci@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 0/5] PCI: add 4x lane support for pci-j721e controllers
Date:   Sun, 22 Jan 2023 17:51:16 +0530
Message-ID: <20230122122121.3552375-1-a-verma1@ti.com>
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

