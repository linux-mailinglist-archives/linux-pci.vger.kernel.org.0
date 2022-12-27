Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE3E656980
	for <lists+linux-pci@lfdr.de>; Tue, 27 Dec 2022 11:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbiL0KmQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Dec 2022 05:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiL0KmP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Dec 2022 05:42:15 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D0BB48;
        Tue, 27 Dec 2022 02:42:14 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2BRAft7d043724;
        Tue, 27 Dec 2022 04:41:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1672137715;
        bh=JWWpzXmF8yVxfJa2Xvl74KW2ZsRgqAWGSljSsgMpi2M=;
        h=From:To:CC:Subject:Date;
        b=tmr2iiAfGtNC/tp1E6xNqIhHicysgJ44DboAJUnKwRjQ4tQrAnh2kxHs7kiG+Jd2U
         n1RNXsiq6w2cY21GGKMX7/RgGfg3g44bBpReAzLhSujAW/BBQ8+zNG64n6pUC85KxH
         vVl25PftfcDXp3jJrbKNCAOY/i4ZRCoiVZtmhfgQ=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2BRAftpw130711
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Dec 2022 04:41:55 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 27
 Dec 2022 04:41:55 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 27 Dec 2022 04:41:55 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2BRAfsJl024201;
        Tue, 27 Dec 2022 04:41:55 -0600
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
Subject: [PATCH 0/2] Add support to build pci-j721e as a module.
Date:   Tue, 27 Dec 2022 16:11:52 +0530
Message-ID: <20221227104154.1022426-1-a-verma1@ti.com>
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

Achal Verma (2):
  PCI: cadence: Add support to build pcie-cadence library as module.
  PCI: j721e: Add support to build pci-j721e as module.

 drivers/pci/controller/cadence/Kconfig             | 12 ++++++------
 drivers/pci/controller/cadence/pci-j721e.c         |  6 +++++-
 drivers/pci/controller/cadence/pcie-cadence-ep.c   |  4 ++++
 drivers/pci/controller/cadence/pcie-cadence-host.c |  5 +++++
 drivers/pci/controller/cadence/pcie-cadence.c      |  9 +++++++++
 drivers/pci/controller/cadence/pcie-cadence.h      |  4 ++--
 6 files changed, 31 insertions(+), 9 deletions(-)

-- 
2.25.1

