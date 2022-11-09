Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA94E622546
	for <lists+linux-pci@lfdr.de>; Wed,  9 Nov 2022 09:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiKII01 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Nov 2022 03:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiKII0Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Nov 2022 03:26:25 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC271C90D
        for <linux-pci@vger.kernel.org>; Wed,  9 Nov 2022 00:26:23 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A98QFnK114737;
        Wed, 9 Nov 2022 02:26:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667982375;
        bh=5ZlAY8ts28/UA0TeHdRhIaPWxIjinl+puEaqQc+L5Ho=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=OsDPme+dL4gPId7v6YNyNU4k+z03LmV8ugvsXqGobA+USVKWIU7p05mlJY/3F3gA4
         Kah/xcoOuBxTO5OOkEn9F1Qzw8YULRu6WtMO3wyEbj2lWvFLExzkuUrrAy1L/c+YPc
         qiX9MBXZsXY0LEc+1mmB3nNmQPm7+V9qSTJrJEes=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A98QF0U039216
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Nov 2022 02:26:15 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Wed, 9 Nov
 2022 02:26:15 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Wed, 9 Nov 2022 02:26:15 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A98QCO7039374;
        Wed, 9 Nov 2022 02:26:14 -0600
From:   Matt Ranostay <mranostay@ti.com>
To:     <vigneshr@ti.com>, <lpieralisi@kernel.org>, <robh@kernel.org>,
        <kw@linux.com>, <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Matt Ranostay <mranostay@ti.com>, Achal Verma <a-verma1@ti.com>
Subject: [PATCH v5 3/4] PCI: j721e: add j784s4 PCIe configuration
Date:   Wed, 9 Nov 2022 00:25:55 -0800
Message-ID: <20221109082556.29265-4-mranostay@ti.com>
X-Mailer: git-send-email 2.38.GIT
In-Reply-To: <20221109082556.29265-1-mranostay@ti.com>
References: <20221109082556.29265-1-mranostay@ti.com>
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

Add PCIe configuration for j784s4 platform which has 4x lane support.

Tested-by: Achal Verma <a-verma1@ti.com>
Signed-off-by: Matt Ranostay <mranostay@ti.com>
---
 drivers/pci/controller/cadence/pci-j721e.c | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index efd065bc0104..83b8100afaff 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -331,6 +331,21 @@ static const struct j721e_pcie_data am64_pcie_ep_data = {
 	.max_lanes = 1,
 };
 
+static const struct j721e_pcie_data j784s4_pcie_rc_data = {
+	.mode = PCI_MODE_RC,
+	.quirk_retrain_flag = true,
+	.is_intc_v1 = true,
+	.byte_access_allowed = false,
+	.linkdown_irq_regfield = LINK_DOWN,
+	.max_lanes = 4,
+};
+
+static const struct j721e_pcie_data j784s4_pcie_ep_data = {
+	.mode = PCI_MODE_EP,
+	.linkdown_irq_regfield = LINK_DOWN,
+	.max_lanes = 4,
+};
+
 static const struct of_device_id of_j721e_pcie_match[] = {
 	{
 		.compatible = "ti,j721e-pcie-host",
@@ -356,6 +371,14 @@ static const struct of_device_id of_j721e_pcie_match[] = {
 		.compatible = "ti,am64-pcie-ep",
 		.data = &am64_pcie_ep_data,
 	},
+	{
+		.compatible = "ti,j784s4-pcie-host",
+		.data = &j784s4_pcie_rc_data,
+	},
+	{
+		.compatible = "ti,j784s4-pcie-ep",
+		.data = &j784s4_pcie_ep_data,
+	},
 	{},
 };
 
-- 
2.38.GIT

