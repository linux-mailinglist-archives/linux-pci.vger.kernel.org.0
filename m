Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D6B605587
	for <lists+linux-pci@lfdr.de>; Thu, 20 Oct 2022 04:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiJTCar (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Oct 2022 22:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbiJTCaq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Oct 2022 22:30:46 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33CA1799B2
        for <linux-pci@vger.kernel.org>; Wed, 19 Oct 2022 19:30:45 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29K1TGVm055708;
        Wed, 19 Oct 2022 20:29:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666229356;
        bh=jdBmBMAKAfCyULrXDEeWBmIWq3z+FL5IUe7zL433q18=;
        h=From:To:CC:Subject:Date;
        b=iP26jX28xjW/SB/V+Flvs/Uw1Y+dkw463SCJR2zNZxxVGQY6KUEYRL8sNhVIZGBUX
         AoGUOFa27ceaixFr5Nhur7e6efhR9zXjfmPQZ7Bf/MVyNCiItLu9FFWKfHraGm3aKQ
         mIuQ0lNekfV19VBVe9IGHNbtUAv61rk2ZxSQN+cA=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29K1TGDF051317
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Oct 2022 20:29:16 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Wed, 19
 Oct 2022 20:29:15 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Wed, 19 Oct 2022 20:29:15 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29K1TCDJ063951;
        Wed, 19 Oct 2022 20:29:14 -0500
From:   Matt Ranostay <mranostay@ti.com>
To:     <robh@kernel.org>, <tjoseph@cadence.com>, <nm@ti.com>,
        <a-verma1@ti.com>, <vigneshr@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, Matt Ranostay <mranostay@ti.com>
Subject: [PATCH v3 0/3] PCI: add 4x lane support for pci-j721e controllers
Date:   Wed, 19 Oct 2022 18:29:08 -0700
Message-ID: <20221020012911.305139-1-mranostay@ti.com>
X-Mailer: git-send-email 2.38.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

Matt Ranostay (3):
  PCI: j721e: Add PCIe 4x lane selection support
  PCI: j721e: Add per platform maximum lane settings
  PCI: j721e: Add warnings on num-lanes misconfiguration

 drivers/pci/controller/cadence/pci-j721e.c | 27 ++++++++++++++++++----
 1 file changed, 22 insertions(+), 5 deletions(-)

-- 
2.38.GIT

