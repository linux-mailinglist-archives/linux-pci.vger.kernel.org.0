Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44CBD629CE8
	for <lists+linux-pci@lfdr.de>; Tue, 15 Nov 2022 16:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiKOPEe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Nov 2022 10:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbiKOPEY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2022 10:04:24 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077442A979
        for <linux-pci@vger.kernel.org>; Tue, 15 Nov 2022 07:04:23 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AFF3eHM053364;
        Tue, 15 Nov 2022 09:03:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1668524620;
        bh=QZDPlnaVNc4u9j6ZbxoN1qd/EaOnUupP78tgGX2bqnI=;
        h=From:To:CC:Subject:Date;
        b=I1X1SC0vgTUBYaKCYNB/5r9mdxT1HX7aGss6S1heyEdCHAGyVMnswCcRpdXfv/T0K
         dSXNwI1BlQoXwM8kNGbGjSH8NNVEkIVSHx6QtjYFP/p2R8NFcLwTIqt5efg52j3WVL
         1u3Y/0nJkIo6JOTL+4nryiq+5pGbH2QdZoxrRYfI=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AFF3ew9017276
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Nov 2022 09:03:40 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 15
 Nov 2022 09:03:40 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 15 Nov 2022 09:03:40 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AFF3aBk049373;
        Tue, 15 Nov 2022 09:03:38 -0600
From:   Matt Ranostay <mranostay@ti.com>
To:     <vigneshr@ti.com>, <lpieralisi@kernel.org>, <robh@kernel.org>,
        <kw@linux.com>, <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Matt Ranostay <mranostay@ti.com>
Subject: [PATCH v6 0/5] PCI: add 4x lane support for pci-j721e controllers
Date:   Tue, 15 Nov 2022 07:03:30 -0800
Message-ID: <20221115150335.501502-1-mranostay@ti.com>
X-Mailer: git-send-email 2.38.GIT
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

Adding of dditional support to Cadence PCIe controller (i.e. pci-j721e.c)
for up to 4x lanes, and reworking of driver to define maximum lanes per
board configuration.

Changes from v1:
* Reworked 'PCI: j721e: Add PCIe 4x lane selection support' to not cause
  regressions on 1-2x lane platforms

Changes from v2:
* Correct dev_warn format string from %d to %u since lane count is a unsigned
  integer
* Update CC list

Changes from v3:
* Use the max_lanes setting per chip for the mask size required since bootloader
  could have set num_lanes to a higher value that the device tree which would leave
  in an undefined state
* Reorder patches do the previous change to not break bisect
* Remove line breaking for dev_warn to allow better grepping and since no strict
  80 columns anymore

Changes from v4:
* Correct invalid settings for j7200 PCIe RC + EP
* Add j784s4 configuration for selection of 4x lanes

Changes from v5:
* Dropped 'PCI: j721e: Add warnings on num-lanes misconfiguration' patch from series  
* Reworded 'PCI: j721e: Add per platform maximum lane settings' commit message
* Added yaml documentation and schema checks for ti,j721e-pci-* lane checking

Matt Ranostay (5):
  dt-bindings: PCI: ti,j721e-pci-*: add checks for num-lanes
  PCI: j721e: Add per platform maximum lane settings
  PCI: j721e: Add PCIe 4x lane selection support
  dt-bindings: PCI: ti,j721e-pci-*: add j784s4-pci-* compatible strings
  PCI: j721e: add j784s4 PCIe configuration

 .../bindings/pci/ti,j721e-pci-ep.yaml         | 40 +++++++++++++++--
 .../bindings/pci/ti,j721e-pci-host.yaml       | 42 ++++++++++++++++--
 drivers/pci/controller/cadence/pci-j721e.c    | 44 ++++++++++++++++---
 3 files changed, 115 insertions(+), 11 deletions(-)

-- 
2.38.GIT

