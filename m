Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360887B22BB
	for <lists+linux-pci@lfdr.de>; Thu, 28 Sep 2023 18:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjI1QsH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Sep 2023 12:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjI1QsG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Sep 2023 12:48:06 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2045.outbound.protection.outlook.com [40.107.100.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCFC1AC;
        Thu, 28 Sep 2023 09:48:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NxDNUnTj++l42s8Dq9cPDZVu0+5SPXtr3VsVXeHuAzdeI1FcNKjvJCTTfwTMbHTAi3D2rBxcY6+dUqMhTII1m7wVx8L0nwi8MyAKSEzt0PQQ4o7gW41SQcIDZRRCNXEd0T1BBAthDiVxcnM2bnxcDF6FOZ/e73vzSnYKM+f/ODZ6loxLMvK//+lQmNF3vhci+RfeNvj1Y8EiEKxRrqsD0NxYxND06B3o/tx/gjxbfXIBtMwpjEtFmIEWQHN4tgKttNHgkHA749EFKymP0syjqqdzuw+okP5ed95XaEo5zs/qaBVBHH8VTtWuFfnXJZ0VBVLLJ/NF5rNYF8iE1RNj7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MTKcwFawS1LXaUnHCj41gj17QWmGa5EYrJPB+u+eq7s=;
 b=d6xKmQ5CjHu+/j3/DyDH++eOq7KA9/zZvDGF/AlskWVhcKAPVaz2UeUaeDbdC30Svv2aSg8Egd/vjsdBD18JlNTeUcwK3Yj4UwyzoMfbEhWgAnpSaDsseEKX46s2Kh/6fmVUTwBav6+LhUw0uaqLjz+wO96TG4rEutbAgTo8d+quIk1bnelMBGA9msweX3EHSM1QZMF4uH3iRagcYbQRuCy37ZocBdbBB9KC8mXPEoHr7AB/L+tCh2i2X4x+IcvyRS4zoqtIVuQE/lo+2VFdLkJua00IXgv/K6eXdbXRs/eIRiieJYs6jIB8aM0P365Nmu4uxRChNa7OQLpFxrEUQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTKcwFawS1LXaUnHCj41gj17QWmGa5EYrJPB+u+eq7s=;
 b=QAF7VLVC9eBaTll1PDaIa9Z67KY1opkGH6CFPyn+lC4B4jjg4yGCgG7U4Islfy0epTQgib3zN3g+10e8HpY7nZKMBsqE8kw8OXSmi9lua3P5ug6h4HyfrUe3jD4WTeEgEvqHJVS7xhje2+C4a4cqJPym/SWNcwDJCGPQ+FnSPC4=
Received: from BLAPR03CA0120.namprd03.prod.outlook.com (2603:10b6:208:32a::35)
 by PH7PR12MB8777.namprd12.prod.outlook.com (2603:10b6:510:26b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 16:48:03 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:32a:cafe::7b) by BLAPR03CA0120.outlook.office365.com
 (2603:10b6:208:32a::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25 via Frontend
 Transport; Thu, 28 Sep 2023 16:48:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Thu, 28 Sep 2023 16:48:02 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 28 Sep
 2023 11:48:02 -0500
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 28 Sep 2023 11:48:01 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <herve.codina@bootlin.com>,
        <Jonathan.Cameron@Huawei.com>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <bhelgaas@google.com>,
        <robh@kernel.org>
Subject: [PATCH v1 2/2] PCI: of_property: Fix uninitialized variable when of_irq_parse_raw() failed
Date:   Thu, 28 Sep 2023 09:47:11 -0700
Message-ID: <1695919631-7661-2-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1695919631-7661-1-git-send-email-lizhi.hou@amd.com>
References: <1695919631-7661-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|PH7PR12MB8777:EE_
X-MS-Office365-Filtering-Correlation-Id: d13cbf3b-479f-4803-6b80-08dbc042ae57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XQNnr3KKhg6DkLvseXbDlFOjI2I0+kDe2nYJ4JGkiPNsOLmLqq5RFBPnrqgKR4prBLhrq5F0gYBiDXw4gBBCNJwvxD6yIlNyi8OQ0IGFF84PqD1/97egA0VCL/09VrIPwfOBNwGKd4EaIS2vMjJLL+8GObja5B9y7GXgRuOwoM8tdu2c3h4hpLmtrML+ypvLuBUK1y9trA/TBBlDh+sAZUVnOxWFDgQU9teF0opKNJ6nJ61taNrfyZLQW82r04xQvR8CzbK0xfWUtUKR787X9VX+V09UBWnAmXMBtsD3EhP/E07xGD1FjkYY57Kcn70cfuw2OFVOWemxi3H1iGu+0EUY0yxPpUPxoLn0mML0rYOLCCFdvnLgPfU2BKKee1fb0bJJMyTqBN+gm6lN1tsP5ZbTVx/tfR1e/UBYE0uIam672d3aFwJ2wBa5ZJvFySrPRHyELlB0GZRmnPMqsnMnkXMia/JBlgWfYDPUPaFY+S82PEWbP2i9am2Gvd5VtfCS9J40axA2niEghIDuYEh0nN4IB8PQIXnXaxMALFqFC0g02v8hZnM4z6Q/tehEqWnlPB7UByHVAwjMET+hvQhMwI8+wNgWYzIPl+Tj/AG6SnlBsR69j/sponD5NSTyL3mjNMX6jWUSGUPjIgZ36XbNmg9lf95eH6DJLcI812FxY/7KUYooUqWZSiYfDBWQW+mEWg2QIaOFXBNh8oaH085mf0mQenhK6tKuK/rLHTPQ7HcEqWq9vtTksGSEbn3ijRE0+Nvysf4WWlOa6cqDagN7UA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(82310400011)(1800799009)(64100799003)(186009)(451199024)(36840700001)(46966006)(40470700004)(40480700001)(6666004)(81166007)(70586007)(2906002)(356005)(83380400001)(36860700001)(82740400003)(70206006)(110136005)(966005)(26005)(5660300002)(336012)(41300700001)(4326008)(44832011)(47076005)(478600001)(8676002)(54906003)(426003)(8936002)(2616005)(316002)(36756003)(86362001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 16:48:02.7927
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d13cbf3b-479f-4803-6b80-08dbc042ae57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8777
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In function of_pci_prop_intr_map(), addr_sz[i] will be uninitialized if
of_irq_parse_raw() returns failure. Add addr_sz array initialization. And
when parsing irq failed, skip generating interrupt-map pair for the pin.

Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
Reported-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Closes: https://lore.kernel.org/all/20230911154856.000076c3@Huawei.com/
Reviewed-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/pci/of_property.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
index 710ec35ba4a1..c2c7334152bc 100644
--- a/drivers/pci/of_property.c
+++ b/drivers/pci/of_property.c
@@ -186,8 +186,8 @@ static int of_pci_prop_interrupts(struct pci_dev *pdev,
 static int of_pci_prop_intr_map(struct pci_dev *pdev, struct of_changeset *ocs,
 				struct device_node *np)
 {
+	u32 i, addr_sz[OF_PCI_MAX_INT_PIN] = { 0 }, map_sz = 0;
 	struct of_phandle_args out_irq[OF_PCI_MAX_INT_PIN];
-	u32 i, addr_sz[OF_PCI_MAX_INT_PIN], map_sz = 0;
 	__be32 laddr[OF_PCI_ADDRESS_CELLS] = { 0 };
 	u32 int_map_mask[] = { 0xffff00, 0, 0, 7 };
 	struct device_node *pnode;
@@ -213,33 +213,44 @@ static int of_pci_prop_intr_map(struct pci_dev *pdev, struct of_changeset *ocs,
 		out_irq[i].args[0] = pin;
 		ret = of_irq_parse_raw(laddr, &out_irq[i]);
 		if (ret) {
-			pci_err(pdev, "parse irq %d failed, ret %d", pin, ret);
+			out_irq[i].np = NULL;
+			pci_dbg(pdev, "parse irq %d failed, ret %d", pin, ret);
 			continue;
 		}
-		ret = of_property_read_u32(out_irq[i].np, "#address-cells",
-					   &addr_sz[i]);
-		if (ret)
-			addr_sz[i] = 0;
+		of_property_read_u32(out_irq[i].np, "#address-cells",
+				     &addr_sz[i]);
 	}
 
 	list_for_each_entry(child, &pdev->subordinate->devices, bus_list) {
 		for (pin = 1; pin <= OF_PCI_MAX_INT_PIN; pin++) {
 			i = pci_swizzle_interrupt_pin(child, pin) - 1;
+			if (!out_irq[i].np)
+				continue;
 			map_sz += 5 + addr_sz[i] + out_irq[i].args_count;
 		}
 	}
 
+	/*
+	 * Parsing interrupt failed for all pins. In this case, it does not
+	 * need to generate interrupt-map property.
+	 */
+	if (!map_sz)
+		return 0;
+
 	int_map = kcalloc(map_sz, sizeof(u32), GFP_KERNEL);
 	mapp = int_map;
 
 	list_for_each_entry(child, &pdev->subordinate->devices, bus_list) {
 		for (pin = 1; pin <= OF_PCI_MAX_INT_PIN; pin++) {
+			i = pci_swizzle_interrupt_pin(child, pin) - 1;
+			if (!out_irq[i].np)
+				continue;
+
 			*mapp = (child->bus->number << 16) |
 				(child->devfn << 8);
 			mapp += OF_PCI_ADDRESS_CELLS;
 			*mapp = pin;
 			mapp++;
-			i = pci_swizzle_interrupt_pin(child, pin) - 1;
 			*mapp = out_irq[i].np->phandle;
 			mapp++;
 			if (addr_sz[i]) {
-- 
2.34.1

