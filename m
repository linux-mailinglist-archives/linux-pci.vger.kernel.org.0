Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33875BCEF8
	for <lists+linux-pci@lfdr.de>; Mon, 19 Sep 2022 16:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiISOeX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Sep 2022 10:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiISOeT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Sep 2022 10:34:19 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFA42B612;
        Mon, 19 Sep 2022 07:34:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JchFvzWPt9vq/tnn95CoCU+//pXuc5oYm5J5n1BbEKPm1MRPle2FITyjy+SdBL6OSnn+Ztfv2M0UiVFEpM2xkXDK7oR3OcnSIUfGDKuriYKYwQn8/WWWsA2nLLP4bV734txiLV6wLFSrqR+Yredb5ss8QWXIQ/RLMe7pVh/K7k8404ef/AYwodBWRlZ9jjYiAdRNyOUCPO4Oq60wI+wc3BWuZrbNmkkhYtwynHPeBzCrK1aPlR6/6ggDRNzkHKnLDGr3B2q3wKS9m9AN13vONIEo0VOfS8h9S1DGxW9i3nMXJHZO0B5+RWtw409vmugiPmvv+G8OvKEssEAWwwHcSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e14I0IJOS7WZ8nfnI/dcCcm1AB7VWxitBoi7in/acmk=;
 b=Ra+xr0bfFFCnAFfTUNSgbBhxAsieXoh8OkIK7Ca2HMYkKufAqv7poImVoGElkKTtYgz/1hw6sef+qyvXlVvG592+3Q/nkh2KXE8zuajjdsvR0MB+6+7tgALzqxzwQlu+T3f6EG2r/kgTMv9Ff3cF6VK8xlIiQ2HwUHS+6uTae81TVsHmXN9sAIQ83W7WraIMfiUC6UnkB/9JNP57jFcQxWaTmglRsfwpWZAlLdFZyv0TyvlbtHKIxJXzEprg7j3smQS6Ulk3xJHJ7pqkNoGoVJQi5HhiDl849I0ALjeqJi5kwZ+5tovJ62q1hVzAjvLj2XQg+avPtk2/KceJUJ5BiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e14I0IJOS7WZ8nfnI/dcCcm1AB7VWxitBoi7in/acmk=;
 b=hBmyLDJRBrB4OPyMPUnW9uwXjp7JV0oMfLHJX2caDYFS5vyK7rF66C2Mv7hsPx3jjhaii4J+IVZwO0ByzgxmM/wMqv4bctdwxizj3wFPY9oMYKrogfeQe+3Z90Rbt5ai9vIHyY6QejN35Fn6f/XL8B/Ne0uPEnJiMZ2gaTZJLJk0trzS6DRYRL8id6YwZh0ojtfMVn0hGDkvH7PcqMXe0elzYflCxTJLnm6/3ls4suopJY8HygSmVvCFGyuuDYtFDZOE/zwlgWACudCG91CLerfkNbVJ32J8SKnq/yjerOtZA+dezhOqrmhnGfbdQXqjcBYJeRI23BawZJDuUzXPyA==
Received: from BN9PR03CA0189.namprd03.prod.outlook.com (2603:10b6:408:f9::14)
 by DM4PR12MB5328.namprd12.prod.outlook.com (2603:10b6:5:39f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 14:34:14 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::34) by BN9PR03CA0189.outlook.office365.com
 (2603:10b6:408:f9::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Mon, 19 Sep 2022 14:34:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Mon, 19 Sep 2022 14:34:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 19 Sep
 2022 07:34:00 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 19 Sep
 2022 07:33:59 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 19 Sep 2022 07:33:56 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V1 2/2] PCI: designware-ep: Disable PTM capabilities for EP mode
Date:   Mon, 19 Sep 2022 20:03:40 +0530
Message-ID: <20220919143340.4527-3-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220919143340.4527-1-vidyas@nvidia.com>
References: <20220919143340.4527-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT014:EE_|DM4PR12MB5328:EE_
X-MS-Office365-Filtering-Correlation-Id: b2a0d93c-2d4a-4f4e-f4bd-08da9a4c06b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xuKuXAj1GpPGw28lTaePiJ56zXgyln0nEZshAKQ1agG11proUZc+EJrTmKfmET+2pQpgmUmcXDHxmR3wRcDHB5d/4hIh+wIlv5DJafsWKAXCkezQAfiY6Ib4fL9yiQccHLv0eCZ6Npla4LaoqXETFh/2t2beA/UKEjennRUVS/uKwzxq9v75plGbk66QBs9AS9WhT8L0k5UgCkJx3yAAyvP/E1iVfF+lJrrv/Z7uDlwcg92Vw5Qtukdbl8BbHygFMOw6cJxqOlAdONcbpfFgtstk1Lv8vbmHDNjiB+Q/fXjOLVIxXAwtMBhtXA0EKSN6Z7AlsVoBze3cCxdqHDW66v8/hk6jENLwWIdtdvYeDeZrxXwCnx6JeSbjZz13pxvjMbKBtEUnPiHSjVVXHqRzOnFOwy9wskcm0BslFnJ8+uHJEMdYUFwePRVFvwjgtAbKUnDOeTRSAxPl7B1zr3vOhFy3bBlT1CNHM2/oUO9dhYHH+srje22MWaYv6pBG0R/vQhrUe4frvVMNYa3IBW1mUuPhiRMnYimiK4uGAIfDothD79B6IaRTAipfvm7igAKylPQH0C9oxD9fvf5cIcDBZ7RQc7LiJ2rWRkBYcyL3HPs2CBmMXsXnHS9CL8VhZ7RCHV9JawGl7nLfDy0kWiWrIAJm0ytEYk1gdZYUccySA6coFWxutDl00fkSp4Gql/HwAvasY63pLYissgr3ftG1LF7sp55iVnHkbcJqPyVAA2ONes1U0F6xsJF+AZR+pGxvwauPSLrcyBL4nwOp6iQsEA==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199015)(46966006)(40470700004)(36840700001)(2906002)(82310400005)(40480700001)(36756003)(316002)(36860700001)(426003)(47076005)(82740400003)(4326008)(8676002)(5660300002)(70586007)(70206006)(54906003)(8936002)(110136005)(86362001)(336012)(1076003)(186003)(478600001)(7636003)(2616005)(26005)(356005)(41300700001)(83380400001)(40460700003)(6666004)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 14:34:14.5226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a0d93c-2d4a-4f4e-f4bd-08da9a4c06b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5328
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Dual mode DesignWare PCIe IP has PTM capability enabled (if supported) even
in the EP mode. The PCIe compliance for the EP mode expects PTM
capabilities (ROOT_CAPABLE, RES_CAPABLE, CLK_GRAN) be disabled.
Hence disable PTM for the EP mode.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 7e9529ae3824..dc3057b18f36 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -646,7 +646,7 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
 	struct dw_pcie_ep_func *ep_func;
 	struct device *dev = pci->dev;
 	struct pci_epc *epc = ep->epc;
-	unsigned int offset;
+	unsigned int offset, ptm_cap_base;
 	unsigned int nbars;
 	u8 hdr_type;
 	u8 func_no;
@@ -698,6 +698,7 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
 	}
 
 	offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
+	ptm_cap_base = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_PTM);
 
 	dw_pcie_dbi_ro_wr_en(pci);
 
@@ -710,6 +711,22 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
 			dw_pcie_writel_dbi(pci, offset + PCI_REBAR_CAP, 0x0);
 	}
 
+	/*
+	 * PTM responder capability can be disabled only after disabling
+	 * PTM root capability.
+	 */
+	if (ptm_cap_base) {
+		dw_pcie_dbi_ro_wr_en(pci);
+		reg = dw_pcie_readl_dbi(pci, ptm_cap_base + PCI_PTM_CAP);
+		reg &= ~PCI_PTM_CAP_ROOT;
+		dw_pcie_writel_dbi(pci, ptm_cap_base + PCI_PTM_CAP, reg);
+
+		reg = dw_pcie_readl_dbi(pci, ptm_cap_base + PCI_PTM_CAP);
+		reg &= ~(PCI_PTM_CAP_RES | PCI_PTM_GRANULARITY_MASK);
+		dw_pcie_writel_dbi(pci, ptm_cap_base + PCI_PTM_CAP, reg);
+		dw_pcie_dbi_ro_wr_dis(pci);
+	}
+
 	dw_pcie_setup(pci);
 	dw_pcie_dbi_ro_wr_dis(pci);
 
-- 
2.17.1

