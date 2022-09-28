Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FEC5ED8FF
	for <lists+linux-pci@lfdr.de>; Wed, 28 Sep 2022 11:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbiI1Jbw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Sep 2022 05:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbiI1Jbb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Sep 2022 05:31:31 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B47D33EE;
        Wed, 28 Sep 2022 02:31:29 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 28S9VEo9115810;
        Wed, 28 Sep 2022 04:31:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1664357474;
        bh=bamV10jgSCholN4PmlvQuQ/l4nJvgo3gp0ydKye83mQ=;
        h=From:To:CC:Subject:Date;
        b=saYZB4wbOeT8hn7A/mGHXvDCYMooWyRu4C7WjW3bCXQyO/nsenqpLLLGQH159AY5S
         XQ2J027m7FQpeSKAs8Kg5l9ZUIsK50HW707pe15NnjRNYMMEU4o07p5YetPdqNpU3w
         AoeAX7qxwgrRZCLCffj4dKkBGa8csl6jDuKYd+mE=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 28S9VELk064227
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Sep 2022 04:31:14 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Wed, 28
 Sep 2022 04:31:13 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Wed, 28 Sep 2022 04:31:13 -0500
Received: from a0393678ub.dal.design.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 28S9VAei045260;
        Wed, 28 Sep 2022 04:31:10 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2] MAINTAINERS: Add Vignesh Raghavendra as maintainer of TI DRA7XX/J721E PCI driver
Date:   Wed, 28 Sep 2022 15:01:05 +0530
Message-ID: <20220928093105.23073-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add Vignesh Raghavendra as maintainer of TI DRA7XX/J721E PCI driver.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
Change from v1:
Added "PCI" in the subject and commit log.

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index aef4632f4e87..ffad3f1dfe9c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15667,7 +15667,7 @@ F:	Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
 F:	drivers/pci/controller/dwc/*designware*
 
 PCI DRIVER FOR TI DRA7XX/J721E
-M:	Kishon Vijay Abraham I <kishon@ti.com>
+M:	Vignesh Raghavendra <vigneshr@ti.com>
 L:	linux-omap@vger.kernel.org
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.17.1

