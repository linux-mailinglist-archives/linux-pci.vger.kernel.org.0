Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E993060F2F4
	for <lists+linux-pci@lfdr.de>; Thu, 27 Oct 2022 10:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235101AbiJ0I5j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Oct 2022 04:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234173AbiJ0I5i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Oct 2022 04:57:38 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB2E159A0B;
        Thu, 27 Oct 2022 01:57:37 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29R8vK5P054058;
        Thu, 27 Oct 2022 03:57:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666861040;
        bh=Awevj19YTqJDXvTjsPtw7D4zHpBiZJxzCr+c7G9q6NA=;
        h=From:To:CC:Subject:Date;
        b=gpyp/0Jm4Ws5Ca4Xke/X+mazm6Ai/0vwb2t9ve75Byervueg9Nd/rLg+Fz63wrFPX
         /O0Q5R3JV4aFLOoc+zy9JsFS77goz15opk2JzhNCQb/+X8N2X/2mRAwl/LlIs7DwUz
         q0+N7EJEdzswFDxT63HFHWheW2ZxYVhfF03h/blA=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29R8vKDL122957
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Oct 2022 03:57:20 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 27
 Oct 2022 03:57:19 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 27 Oct 2022 03:57:19 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29R8vIFS082141;
        Thu, 27 Oct 2022 03:57:19 -0500
From:   Achal Verma <a-verma1@ti.com>
To:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Achal Verma <a-verma1@ti.com>,
        Milind Parab <mparab@cadence.com>
Subject: [PATCH 0/2] Add support to build pci-j721e as a module.
Date:   Thu, 27 Oct 2022 14:27:16 +0530
Message-ID: <20221027085718.291510-1-a-verma1@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Patch series add support to build pci-j721e as module (requires
pcie-cadence library to be built as module).

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
2.17.1

