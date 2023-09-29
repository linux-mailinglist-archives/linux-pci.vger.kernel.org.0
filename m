Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3F47B3863
	for <lists+linux-pci@lfdr.de>; Fri, 29 Sep 2023 19:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbjI2RK6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Sep 2023 13:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbjI2RK5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Sep 2023 13:10:57 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2068.outbound.protection.outlook.com [40.107.95.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E65193;
        Fri, 29 Sep 2023 10:10:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MgbcvSo0KA0DVOEGQsgWffmcrMfPHb+0BYgWn3v1R+lthj+3ssYYQk7Km6TXyIOQ4kDJHRa2eWSooKAcjeNY3ZUX1VKb0YaQ/cn2stYZ0SQBOSkc3KXIE72ZSWfinHe2m/nKC8GNFNXjnt3liqPZnRoxR5tOcLYnLbYvSojp5NH1ThUOuVah5txvfSIEvT8GZSIgMDmDu0rOrX5oWpnhVXJaOwsG5FogKiUF35S2olkB5YjN7qOdvNqMG6HfiAFkmymTankuXQi3sdK6N2qtkZpRSjzkMKKapwfr+XT/IzKrQPf+IEQozyQf47NbE5SrhlzbReCMYNAMTdO+/sX3mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MTKcwFawS1LXaUnHCj41gj17QWmGa5EYrJPB+u+eq7s=;
 b=V3O0/CeoZ9RQmm21ZGY3IMLUNJPebIIjYFASu8ww7m10VSEMJZLYZngwxOZ0MiSCn8hphVjyr64LWOmRGHHY+G8asy1liUFuetTZTU9r18IQBHJ0jHBD2wVGBn+dLlkWGRYYn3MfmQ6nr7UujxQ7XVVGWo0753VR5OC4XaO9ogpT9nz1laQgslkPEmpV7xE1DC6kRp6f+TebOF2jm5s4t9TbGLyyIjJ9+3V5L9eQqnI99v51mqN+WdKCsEjJYOfkt80dvxk7RcdTLlNmM2dT2LKWnlzmCGi/9AuQT/A16vD4MV+czwVKC/O06XBmj/Nex4QXd8zMLpVjq5e/1W3UqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTKcwFawS1LXaUnHCj41gj17QWmGa5EYrJPB+u+eq7s=;
 b=cMMkOGbkJxnP7alK1fXR7i6lB8ogIWPd8hxqYEfA5G4C2a7OxkapqdgQFaZTJz/+8VeMgJYWcDhgZX1dT8uSeKjkQGcNtvj4fX21/XvM9DK3VmFZZgpqlKJJGNFo+IaLM6o51FJXZfIfSRc2JKV/Ys6C3pL7oy2tc+Y3/5NmfzA=
Received: from CH0PR13CA0043.namprd13.prod.outlook.com (2603:10b6:610:b2::18)
 by SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Fri, 29 Sep
 2023 17:10:52 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::bb) by CH0PR13CA0043.outlook.office365.com
 (2603:10b6:610:b2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.15 via Frontend
 Transport; Fri, 29 Sep 2023 17:10:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 29 Sep 2023 17:10:52 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 29 Sep
 2023 12:10:51 -0500
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 29 Sep 2023 12:10:50 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <herve.codina@bootlin.com>,
        <Jonathan.Cameron@Huawei.com>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <bhelgaas@google.com>,
        <robh@kernel.org>
Subject: [PATCH v3] PCI: of_property: Fix uninitialized variable when of_irq_parse_raw() failed
Date:   Fri, 29 Sep 2023 10:10:48 -0700
Message-ID: <1696007448-42127-1-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|SA0PR12MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dfd1ba6-20db-4f37-3a2e-08dbc10f0912
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0u7JXTonbkFfiSBTA6VbFlJY2jww201usveLscSduj7z50HF4UZOa2evaU977m4Y3aW64eMc3W5L3N2x/2zmsjrz6/zLmH1KDQLTeFlpfrnKL/PDUtFZcc6fa+dlM5NyVusVdWa3785SvJK6P6Eq+KZsxpypQ4BGtRk3e0n5nherffOvoZivRl61piB85ACiAioaYSkWT98fLCRaicuWGi+Ew6me38RGQxNqw/UMPs1nP4NZ7g3J44iSRPe5hOugWdFP48AgsiR+XOtphkykKbtWrs97//T0nnyzhWRChYkAGCIFGSrArnOu2PUNtmIy2uFR+e6gZRO1pV+whHiczUy4N4uTSBhncFpuVPu/gefSkeNvfLoyrdK+79eZbBo5lKNHiPWrwoxnX90CMNamS5FRNVwvAiSjkwCrzqwrTbV0gabMYr1KSEnQDw+NH+AI82RlK7cH/Dy9WtU+2ibpmL2Oz1c/NXoTjTCx4joSGXpxbm7b6JSwU+FBPjMqMdHzbcs50lIa5yOt7SbeuTewvfwpOcG79TISBJqXvTihGUA93yyselBQx1cq98hYeabs+4zP0LTETFs1N5sT/YOhhGrnWX82T8ZeiLTtrbPeYJ6Ht9Bfk+xg5otBEY485To6Ybm1VZNfiohEF9UyNL1J3HZkBdigEkEvkIZ5MsFjnqebm29CVTSw8vUMVD4mdyqFPVSIIN22krK8a2wy9w442zIsAFW65m1G6SM8aGwszGEuvXNVhVDTx1l38F2PaoNENN8uUdleK1DU7QmIzgmRhg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(186009)(1800799009)(451199024)(82310400011)(64100799003)(36840700001)(46966006)(40470700004)(82740400003)(81166007)(356005)(86362001)(36756003)(40480700001)(26005)(40460700003)(70586007)(4326008)(8936002)(478600001)(5660300002)(316002)(426003)(966005)(41300700001)(8676002)(2906002)(36860700001)(83380400001)(336012)(110136005)(70206006)(47076005)(44832011)(54906003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 17:10:52.3135
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dfd1ba6-20db-4f37-3a2e-08dbc10f0912
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7091
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

