Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD2E5EA674
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 14:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236643AbiIZMqr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 08:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235594AbiIZMq1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 08:46:27 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on20602.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e83::602])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F83312C1E7;
        Mon, 26 Sep 2022 04:22:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZ646eksIQ55R0Q2n4hC3OjcyWhl+wZXAUIJCJErBoQtCGjbtO0fRWwZJmiMaJiwE10gklAEX+gHYAcAkB1lKShu26u/8gHhhEmYF3IlZEMSeRduuM/aOXj7BlEDlqMsqXxKGGlmOF1eF/FJ4TWElZVewCjEDEn3saH8LSeqWUX7TUqMa0Hzeyh4YOV93z48hg4wF9XKGeUTbdgj840KbagPuVR2BnWr6fDALjRo8F84ZZriWiHqAXx2O8J55QJK76VnB/ROtBCUltSI4IM51zRKiJUEdd7e3G5jhYJviAvkOeTn5xXKGV/St46Oslg5hAeSkrBMLhG1jcVvIHU06A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4aIetMs+MwwAxyYeVs8PJrfVcFCyU5mV12z4iXx9oWU=;
 b=Zi+ynmy4+EzfVuDjh89xIGEsEu6UkVqLpD4N1LYaMXhSBCYqHPcG1PrlFM55kQ9rD/x/Nw9fZVyxNKoHWYM+mhpu5cgTcJNfCHE+aTYhibmGSvhY+flNSqZD1mwLAiCTnNHPpbeuX37R8cw+9Hh/QDcksNZQuXxWaDvrM76LpuDHaFimyuGR87rC4acED+RaOs60eZAnJnWVGTr0Y6ffCdgPYnorX35nRH3NzE0LpwZOzlZ8cpZGr46r5WFCVs4LSECL+lR5ikCOJbb0ldYK1/HZHq6WL5bjY5JUoZDCUQ8G+bIt+bgx1FVd02ibAbPXKNSdAeDI76Rza/SP2mQV5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4aIetMs+MwwAxyYeVs8PJrfVcFCyU5mV12z4iXx9oWU=;
 b=c7xclNqgEFtbjbao7yVysUyrcPvPUZlvO5l1ehYGuVPDbeGzNxwIiW38oViw58hgY67HJGkCsGs6QBJn9IDFw/L3ukYjQMoNtlQa4BwLb7r8flWi9hGRXF11ToJc0vJ5PuVHHfEdPjf38V47WyjioFFZLFPYq3/npsjzFDfUTDs2UAJtv4wkYZSUUC2O+N2J1ghq4MNktb0zk2RTHbCmRQfK40Nrq0MCax87wtTAkPNnnpvU8JCFLx2R1/AmItyMPdcrzjm1sjPQP2o758yuDVGTb21fU7uCM1c6M7LEfrRrgBWHj6avnXlxgVaO4FAzLVgq9ywoAZk9ISPtkWq8EA==
Received: from DM6PR21CA0010.namprd21.prod.outlook.com (2603:10b6:5:174::20)
 by MW4PR12MB7215.namprd12.prod.outlook.com (2603:10b6:303:228::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Mon, 26 Sep
 2022 11:19:40 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::bb) by DM6PR21CA0010.outlook.office365.com
 (2603:10b6:5:174::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.0 via Frontend
 Transport; Mon, 26 Sep 2022 11:19:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 11:19:40 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 26 Sep
 2022 04:19:31 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 26 Sep 2022 04:19:30 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 26 Sep 2022 04:19:30 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 26 Sep 2022 04:19:27 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V2] PCI: dwc: Fix n_fts[] array overrun
Date:   Mon, 26 Sep 2022 16:49:23 +0530
Message-ID: <20220926111923.22487-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220919143123.28250-1-vidyas@nvidia.com>
References: <20220919143123.28250-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT025:EE_|MW4PR12MB7215:EE_
X-MS-Office365-Filtering-Correlation-Id: eba42414-1336-4ea2-39bc-08da9fb10127
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zRo4WH1vMli67WQsskTeACu12y3NIOBXjbfKL5JsI/fKSWPbge2D8oWeBXF2FHZBmdaxwq4TvAt8NkViACxBkOOfb6HtVpueQHHoDy10efwkaS+DTZecb8pHPicqG4yy8D2U/c77TKMh0tnaGqI4g1mXI+3m6qL4aDTJXEOOrqmY/cNl9kXyNSwwGFDc4DeaOrcmacl+38KgERS9zsqgAS/yTNOGfYh9/vheWh1X0raql+yKEf8z/s3Fw9mPSbaOI1APguZiZg5KvCWgIEbgJdO70OqEGVbFqofCQu7oFL3ww58PYwUWOVohQRV9hMKcdxpYccvSTb0IyWnLi8u6a9wJfeuYXERzfAkqOYZy4gIezi1jkBgPtjcs4hRffoP100YY6HQzdiCAXs21HGlbkEiYHhi/Q7rBoO3SRF8IHzX0WPE8qP4SYpTN0bupHJjWzIvVUUXSCBY8/NjWcpzBufqSrmIX09GfyFWH+Zkqz4ziG8RXnxMdsZZTol6eUK3guFPgchvsJ4cPQt9G7/H4m94qL47pu2pCVDoSZmAOBcX+VuZRps61admwiVWGhCFXX6l2HhMmhmT5NOUNksRhvaoWXjsq5u3M2HfL/NuF96H49JUiHqqjrLAgG9jANACb39aGBX61d9EVbWuyx6/paBzPQ+D1AVOZFNM+XjFtwou6vWwo0trbqmvgyZj+yq1SCDOvSVtpJZmiCJtmL4w2NRA0qtdbNqz/fIboPvNUCR3ARIBJbhCQOnAhso9rcxjCE39rDbd0lXNNqTrhS1yePQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199015)(46966006)(36840700001)(40470700004)(26005)(40480700001)(5660300002)(1076003)(8936002)(7696005)(6666004)(110136005)(336012)(54906003)(2616005)(186003)(426003)(8676002)(40460700003)(70206006)(70586007)(2906002)(86362001)(4326008)(316002)(41300700001)(36860700001)(83380400001)(82310400005)(47076005)(478600001)(36756003)(356005)(7636003)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 11:19:40.2159
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eba42414-1336-4ea2-39bc-08da9fb10127
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7215
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

commit aeaa0bfe89654 ("PCI: dwc: Move N_FTS setup to common setup")
incorrectly uses pci->link_gen in deriving the index to the
n_fts[] array also introducing the issue of accessing beyond the
boundaries of array for greater than Gen-2 speeds. This change fixes
that issue.

Fixes: aeaa0bfe8965 ("PCI: dwc: Move N_FTS setup to common setup")
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Acked-by: Jingoo Han <jingoohan1@gmail.com>
---
V2:
* Addressed review comments from Bjorn
* Added "Acked-by: Jingoo Han <jingoohan1@gmail.com>"

 drivers/pci/controller/dwc/pcie-designware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 650a7f22f9d0..3df687667f27 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -649,7 +649,7 @@ void dw_pcie_setup(struct dw_pcie *pci)
 	if (pci->n_fts[1]) {
 		val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
 		val &= ~PORT_LOGIC_N_FTS_MASK;
-		val |= pci->n_fts[pci->link_gen - 1];
+		val |= pci->n_fts[1];
 		dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
 	}
 
-- 
2.17.1

