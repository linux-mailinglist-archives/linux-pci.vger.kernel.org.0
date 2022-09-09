Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C0E5B4065
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 22:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbiIIUQd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 16:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiIIUQc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 16:16:32 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA4F1116D7
        for <linux-pci@vger.kernel.org>; Fri,  9 Sep 2022 13:16:31 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 289KGQYr077202;
        Fri, 9 Sep 2022 15:16:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1662754586;
        bh=uagfZ7ld/ZxMyUZzuqYbVfc4XscqXBW0Tr7aYfikGiQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=DY2+jhBf5B/vtpZw8MovuuwY7/Dt0uldtSB2OPKjwZ4aA2ySB7bbLPfmlzgnDCvh/
         PkRFyYDF4RqwQfPwCAthWSTqUWQ8xPGqhH8USTGZxp5H/UbDjrGueyP61Yuq+T0rU/
         pcLa4SgoNKZ7syI/PeXzOpRliUVWJj31l367I7Xk=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 289KGQxC088274
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 9 Sep 2022 15:16:26 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 9 Sep
 2022 15:16:25 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 9 Sep 2022 15:16:25 -0500
Received: from ubuntu.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 289KGDp2071511;
        Fri, 9 Sep 2022 15:16:20 -0500
From:   Matt Ranostay <mranostay@ti.com>
To:     <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     <tjoseph@cadence.com>, <vigneshr@ti.com>, <kishon@ti.com>,
        Matt Ranostay <mranostay@ti.com>
Subject: [PATCH 1/3] PCI: j721e: Add PCIe 4x lane selection support
Date:   Fri, 9 Sep 2022 13:16:05 -0700
Message-ID: <20220909201607.3835-2-mranostay@ti.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220909201607.3835-1-mranostay@ti.com>
References: <20220909201607.3835-1-mranostay@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Increase LANE_COUNT_MASK to two-bit field that allows selection of
4x lane PCIe which was previously limited to 2x lane support.

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Matt Ranostay <mranostay@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/pci/controller/cadence/pci-j721e.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index a82f845cc4b5..62c2c70256b8 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -43,7 +43,7 @@ enum link_status {
 };
 
 #define J721E_MODE_RC			BIT(7)
-#define LANE_COUNT_MASK			BIT(8)
+#define LANE_COUNT_MASK			GENMASK(9, 8)
 #define LANE_COUNT(n)			((n) << 8)
 
 #define GENERATION_SEL_MASK		GENMASK(1, 0)
-- 
2.37.2

