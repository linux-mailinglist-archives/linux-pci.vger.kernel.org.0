Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC35E7A26BA
	for <lists+linux-pci@lfdr.de>; Fri, 15 Sep 2023 21:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbjIOS7p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Sep 2023 14:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236652AbjIOS7R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Sep 2023 14:59:17 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2074.outbound.protection.outlook.com [40.107.102.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89E1AF;
        Fri, 15 Sep 2023 11:59:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jpVoEKcxpwiuzKcMbtoMhAq/5sEcEBrwLLR0DkD7jGZk9KXyXMimdIbfLQ7EfznxkG0ilyUE9E/P0AjJ2xrj0kXMQOTnWa1Zjqct3S+xBq/Ajlc7ETfpwyKrf5sE2uRrYiWlEMlDRDfGw6AycXYIuxjH2IlDd3GoURV28XrF3rrWB2gJ5vkvNP5Y2fA3DvCaGnT32ypfxeo/RLNV5JGo4hX6GItzjvM+wsrDz9rEADN3RP1Cf3OUbo7V5CvrEfab08TulpVqXI4wmnlPZIGDap4yj0C/K/mydpQUOYqfO0LNXB7+svVjnvgAVAJ2nJ76QhCLZlTgU1zc5rtkY7gvSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nM6ZWZakbe+IBI1miklYz4jGu8Gbpl9xf2mO7nvcpH0=;
 b=ZDjbu/qySScK8yNrOTl14z4mCJGXNsA0lzfyihH0t159xdOXo/qWYaldzZgwPk8Kn9e+CA9ziFOwNFgC1geXI4Pf64F2aF9bjzbkUAozv5DjEka+MA/g6mbPOZg83J8uR4mLM8cU1eY6ZMkqJSXiFG+/0b2w1jx9PEAyTLY2qKi7mIEMIbd3cMDrqRjembkezxIVRaGpnxPHHpslyPXVOlyP79o0iHcOangcT5ioMtjaKjBQQs6x7VWZGTJiIoFNjSz8xA4NQSG8c9Up09fqFlHofjVKq7gMWDl0cFglBmYUKxNzclWqxjVaBTPoTECS/Y6pQDfgbm7gND4yCgRMAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nM6ZWZakbe+IBI1miklYz4jGu8Gbpl9xf2mO7nvcpH0=;
 b=nPCuxiBUdewwJAVkIR6R4+vmHvgrbZaBbjsETge6qg2vOeG1khS5MQDBUjN8fdf1w7ChFiFX9p1kf4uMVUiyVsl5MppbyMGXubYdBmvcYWDRoY/p0nCywNxl2qO+/xegjUvdEvSbsENQCkMQ2vn79bFvxrNEVrdXZYXzMRWMO6w=
Received: from BL1PR13CA0178.namprd13.prod.outlook.com (2603:10b6:208:2bd::33)
 by BN9PR12MB5381.namprd12.prod.outlook.com (2603:10b6:408:102::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 18:59:09 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:2bd:cafe::ac) by BL1PR13CA0178.outlook.office365.com
 (2603:10b6:208:2bd::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 18:59:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Fri, 15 Sep 2023 18:59:09 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Sep
 2023 13:59:09 -0500
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 15 Sep 2023 13:59:08 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <herve.codina@bootlin.com>,
        <Jonathan.Cameron@Huawei.com>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <bhelgaas@google.com>,
        <robh@kernel.org>
Subject: [PATCH 2/2] PCI: of_property: Fix uninitialized variable when of_irq_parse_raw() failed
Date:   Fri, 15 Sep 2023 11:08:07 -0700
Message-ID: <1694801287-17217-2-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1694801287-17217-1-git-send-email-lizhi.hou@amd.com>
References: <1694801287-17217-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|BN9PR12MB5381:EE_
X-MS-Office365-Filtering-Correlation-Id: e65c5161-bd34-4747-0543-08dbb61dd812
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nNvggFL68bNTYVWHSPdxZdudNoxKDmhsjIWOkQCIGhD7ZaS3EEPO+L4A46J+e47l+jO1epGwgKwZ9qDxUG2KBJoMBTbk6VFUOxoSW955SKaeyxYuiADbXEy+d9zTdlT5MWcPsKFu27u3yZG/A4BMv4rsYOnmoTG8j4I6BtPvdX8qCZXvEyUkqxFdyPdKcGXBJnlnRxyx+IJsck3QGG1L2bF3Hi0WJiTamjBe62ONg08N+0qKbMEmmrnP5YLhhrv40jwpKxTgao3r39XIz6JFU7yYnBEbwu+jGvK+aVEfH2r2t0pQ7ZD0qLVnx3jALRiITR6nNkneX42aMKgrm1LSacOe/KiI8n5HJrJHgmszy0mgVd4wNwHZdd1j+RqwVdGbtiuyOA6dUdZFoDmtDdl1jA5cJhlSzTEPBh5STr22KmpcLxq3+IlcEhAOFAqURwqJk0WJvg66nlyazv7CZtyxafVEOVPawUrW3yGlefo1t51WZxT99sSfm9lEVd8v7Q7tegQsl23G231KQcJjkAZWBt/rPJYu1nvTN4LVJs2yay/XSV3D2IBX+M7tVNejK38OOQn6OvYidW3a5H1xy295oewCWBbd++Q7OQIBzWYeQLe81lxxPe5k26SoyvtPWGwpAmlF2ArSw540rAUmTG947xWPm1Wa0tM0QhbM16ooh4AnagboOMmMp06XIytMGlDJKtW5XsrONQtsl27nWfHJlFtLo20f+svrxJu8e7hOWgw02M/FuWTrcWdvJmRV66acySdK/DJ2+Kd6XsKLOuD5Ng==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(82310400011)(451199024)(1800799009)(186009)(36840700001)(40470700004)(46966006)(336012)(40480700001)(2906002)(426003)(83380400001)(2616005)(478600001)(966005)(26005)(86362001)(40460700003)(356005)(36860700001)(70206006)(36756003)(70586007)(82740400003)(81166007)(47076005)(5660300002)(54906003)(316002)(41300700001)(110136005)(44832011)(4326008)(8676002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 18:59:09.8111
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e65c5161-bd34-4747-0543-08dbb61dd812
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5381
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

