Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984D05EA64A
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 14:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbiIZMiV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 08:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235302AbiIZMhz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 08:37:55 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2061d.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8d::61d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BEA32DB6;
        Mon, 26 Sep 2022 04:15:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/VMHTsGwqAaMcTjImEyoCY6R2Hmvo3uXu8Rxtu1Of6vA+Bpboi58UwhVhCshHTuNbILENhB+QnkdN6oSxqq19tU/RtLOdJ6ewNryHs2dRxXmWDKq9KsXzFf/2Rg6c0cE6duzlQi3xUo46O2pvj7M16aeD/cOl1/mlPwf8mT66LXe32ClCn98vbeLXaJPmkxNzRo+ZipxL1CKqAYoNUcIvi2MXGK6U5BJ67h8a8CDDx37Q94WHDvqGUlrHbiOnwg5B7ya7FEAVL6CEvDeeEzBoSeTfP5GOlwpyMg3v0j6IWMxR+HmLBfLcSvoVJfhhR/SzX7LCCF7t1XlTdmoWLl9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZ824R/L515PyMyCu9jiGsTp8KWo5cgvBBHgJjcUxNk=;
 b=TjL1KEUrduzSGFFQGVPXJP+k/ZMcf214VPDTPOf9yu2ngfePWyq5gBf0sAXQZ7yTfe/2xNvHtyBvLjm8X1A0wwWjhxAt/AYQwhcN1Efdxz+TFCtfOEXCWDc3Ay8JnG/FqRASeJ0EsfXO6WiyyXKoXPQieioTqEX05t/WWdqArTN/3HUd9aMUrca6bQNqpuPg/RTfba80trr1yWpv46XAs+SwZmIYscB1h8nf2tM2vMJNc2gmPhLaiFRP4ejuhbtTrgXkP0aOGGnzV+QPIKpaqX7xt8hq5a9bHBTkOD43hK8SwS6SB4N/EQohQQT8bp0F4tmc0DLgk1pOp4mUeca+Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZ824R/L515PyMyCu9jiGsTp8KWo5cgvBBHgJjcUxNk=;
 b=ez1EdpLLjyo9k/R5YCgoB9U53VKrwXhrRwdKFiy6ghoNmv1rPiYPNazdqA3Nuy+0oUwJOQb8++nSZFY8v0Wds3o4Gmi+A9MuJzo4OQ6yZmNtEAwyfGTDiG4+4UOJMgaQPVzDh7iAHom+Ouzq2uEjGQJn3rEmBFW9XhgyDi1DUrP/rbGMJwhfycF4FkqIEZ0x1ExKCRYBIwEGx2ZgLW9HOYhxODn9pOqXMnRiJIn3yLXWc7bHRVjqzeb1qcvdBpe03gNveQMP/X8G58yF3zXR5YzVq3ZKb8k2BmvDx1OKqy+5J2MvFPsmxm3zK9BYe7SlJu1btxggW1MtLTKGdfv8mg==
Received: from MW4P223CA0024.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::29)
 by IA1PR12MB6283.namprd12.prod.outlook.com (2603:10b6:208:3e5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Mon, 26 Sep
 2022 11:10:47 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::98) by MW4P223CA0024.outlook.office365.com
 (2603:10b6:303:80::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18 via Frontend
 Transport; Mon, 26 Sep 2022 11:10:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 11:10:47 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 26 Sep
 2022 04:10:34 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 26 Sep
 2022 04:10:34 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 26 Sep 2022 04:10:31 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V2 2/2] PCI: designware-ep: Disable PTM capabilities for EP mode
Date:   Mon, 26 Sep 2022 16:40:17 +0530
Message-ID: <20220926111017.12655-3-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220926111017.12655-1-vidyas@nvidia.com>
References: <20220926111017.12655-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT030:EE_|IA1PR12MB6283:EE_
X-MS-Office365-Filtering-Correlation-Id: abe554fb-581a-49ee-fdaa-08da9fafc389
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wh/+RFBfyz9HqEJEpSiGVQVWOTkw2XNka/ftf5v0r0o+2hk2SIRBIv5YAC+06h+q7E2uayy6WP9lxpPJwdd+EBBlqU5io0OEhw5ytIr3CTw2zT9p8HS+uaqHhVV5tI0b2gX21hDVg7rUpU7ftoBOOuH6CYHwxMOdo//Ej9DHOBI2IYntDclvnM6Tk5RF04ZrwH3k/h5nA6A3Zq+oH+VEyar5m6cMa/spgnsuAbOsLFXN/EAUc25KGKEb7QvnIUadMF7IFx1deAWdHpYcc/gQyp0lun3vrk86N3O8LJEvbUVl3GGDMD5YI2tDmEyMwXUq2lUh6VvhDoVTBe7aN3nI3wrPUcjl+GcsTiy6j8lHOZkc2brua4QLENLANswQhuMJ27T9RHJtb6kQtgyAGYxaDWW/PXfeQyhyOl2A3hA5DyXBNhep8WHEbjHivc2+eBQJU91RWCxRu4tLAicLfEN1nBHoxtQXtu7+lCEd+lpaWh7Y/GSDk7TWBo6NDE33Ny4Ay20ccUl2sYKKZLDysw1cca9BKo6MLIkjcG4Pu/dfiNnUaLdXb+RGCBmjR/JJ20+8txz7E2pv+X5r7vaGzya52VRQuwq+B9hM/srs2mrdN6RbUzdIVQQvaWbBkMOBPy0GY7sIVLGFppaSNBluwegrqYvGP7oxShyjmU5Bq1VWAMIXM7v6lPPkT2Doj//QFIXv1KpKtpEZp6wOQcamhK3xloObnZuhz5Hq8bv/6M+1IDEBK/fHQ3K0Lwcb5SnaUQK166YAa10LZVxDasi8utdBcQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199015)(46966006)(36840700001)(40470700004)(40460700003)(8676002)(41300700001)(82740400003)(2906002)(6666004)(478600001)(7696005)(36860700001)(36756003)(26005)(5660300002)(336012)(2616005)(8936002)(186003)(1076003)(316002)(47076005)(356005)(426003)(7636003)(86362001)(82310400005)(70206006)(70586007)(110136005)(4326008)(83380400001)(54906003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 11:10:47.3946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abe554fb-581a-49ee-fdaa-08da9fafc389
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6283
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
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
Reviewed-by: Jingoo Han <jingoohan1@gmail.com>
---
V2:
* Addressed review comment from Jingoo Han
* Added "Reviewed-by: Jingoo Han <jingoohan1@gmail.com>"

 .../pci/controller/dwc/pcie-designware-ep.c    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 095fb0291ec9..b88b6597194a 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -638,6 +638,7 @@ static int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
 	struct dw_pcie_ep_func *ep_func;
 	struct device *dev = pci->dev;
 	struct pci_epc *epc = ep->epc;
+	unsigned int ptm_cap_base;
 	unsigned int offset;
 	unsigned int nbars;
 	u8 hdr_type;
@@ -690,6 +691,7 @@ static int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
 	}
 
 	offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
+	ptm_cap_base = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_PTM);
 
 	dw_pcie_dbi_ro_wr_en(pci);
 
@@ -702,6 +704,22 @@ static int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
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

