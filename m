Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61F5622544
	for <lists+linux-pci@lfdr.de>; Wed,  9 Nov 2022 09:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiKII0T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Nov 2022 03:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiKII0S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Nov 2022 03:26:18 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5569013D33
        for <linux-pci@vger.kernel.org>; Wed,  9 Nov 2022 00:26:17 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A98Q1tP052743;
        Wed, 9 Nov 2022 02:26:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667982361;
        bh=mo5PdU3cTV74KFAnDyxjJPzU2AfRa0t29F94To7rIac=;
        h=From:To:CC:Subject:Date;
        b=k+xjjFoha8h35yW79n3e1JvSiNer5SUlQF6hbcwGnUQHU5wbwefLwYzijeCgQR9X9
         rr092HlC0NvjwEaIqKlQGfvpGmLA/j+8dU0skDFH921zIp0PvOlJw+k5IKG6R3Eir3
         57LpsDygUhoP2XsVpaTYkV4UoygoSdUFDy/caXYc=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A98Q1ux007564
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Nov 2022 02:26:01 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Wed, 9 Nov
 2022 02:26:00 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Wed, 9 Nov 2022 02:26:00 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A98PvR3106309;
        Wed, 9 Nov 2022 02:25:59 -0600
From:   Matt Ranostay <mranostay@ti.com>
To:     <vigneshr@ti.com>, <lpieralisi@kernel.org>, <robh@kernel.org>,
        <kw@linux.com>, <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Matt Ranostay <mranostay@ti.com>
Subject: [PATCH v5 0/4] PCI: add 4x lane support for pci-j721e controllers
Date:   Wed, 9 Nov 2022 00:25:52 -0800
Message-ID: <20221109082556.29265-1-mranostay@ti.com>
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

Matt Ranostay (4):
  PCI: j721e: Add per platform maximum lane settings
  PCI: j721e: Add PCIe 4x lane selection support
  PCI: j721e: add j784s4 PCIe configuration
  PCI: j721e: Add warnings on num-lanes misconfiguration

 drivers/pci/controller/cadence/pci-j721e.c | 51 +++++++++++++++++++---
 1 file changed, 46 insertions(+), 5 deletions(-)

-- 
2.38.GIT

