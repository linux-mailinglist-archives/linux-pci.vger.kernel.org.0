Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA0D5BCED6
	for <lists+linux-pci@lfdr.de>; Mon, 19 Sep 2022 16:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiISObu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Sep 2022 10:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiISObp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Sep 2022 10:31:45 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BAC101F8;
        Mon, 19 Sep 2022 07:31:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lggiuye/Q5dVKLD1V5hgxuA4c6PR01CWv+n1VQah3CIJ9uIQC48YNKvgM6ihK5gS8nChimIJDw3cc3bnyJ9CwE5lqA45+PqiBckWdbtkfv1c5YsaksuOqV4elgtTVnoy8y27kOGjb1Vp6yMhCqrp8GiGeFvuYp83xybwp0Puk0JwdhJgq5LXD59iSEZLlF9/mD6BuYbpQydGTnSFrzlDpoWsyrogWWCYJu9+o+eu0cE1hr6D+o+ypl3WZ25d0eRGrFavgIzbX1jGMO4P/jSKf1M9U4yhkCfR7+M4RHLZM7k/BEUznFDFg9iK9y8z+HrueITuDovAYPzqKRUXGBcEsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HgXiiXMjgYRxp1LMpSx9JFVvARiFQtlphvSqXrsauW8=;
 b=eZDdrHv0pG59Mw5hadKI+WNgsN6OPtmQzbVuhb6ntzRuF9jNt5Px9HXwcjoTTUxNrIO6aFT0bc6XdhriNXCcwdCbo7WYAsXL9o5ry3aN87tKeyTXhYvTFTbbSDvfqjuCCQSU/CQpn5ZxeUA5MqtEXrxmnUjg6eL3U6GfwIPRrW16E4g5lYTtx5psFSLntrxdBBbHIRRd79iCn8x0ew7t5ZI9EEwR33BtXmMbSyZePFGcTzi3SXOBrQdc/vjsCw8ytIA+BJpuCxNT0sJERcWK85v3OshX7NW6bqdmHyzQn1KTRPgS7/vqIlpEbYBhhdS8eupJIsisLmZzad89CvIurQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgXiiXMjgYRxp1LMpSx9JFVvARiFQtlphvSqXrsauW8=;
 b=RQWYYBgz2C1yqKmPRusqfAUDeCxJlsRZKK8y9YOMXBD+3UES4GLTHTvw9KBcIZSMBfsWB//WUelozWG6QJJ1kVmUh5ZpE9po/FZyezYHkD8Bq8W8b6pWInTI1G41JuIBp6GGPpi7Kf55wP0P6cU7BNMtVi7nSAsabvK8KS6uFj+mBLfc+xi1EQ2Ks6iRdBTIUfcC51jMHzqraGyEJzms1WtjUua+qHdi2bwoqxTvWpes05vLSgnyrpsafYTnqjXX/uu7iM7EiF6UhEWgC8uf19shAYmiNdUEbB5ZbV6YBy3cqwI30cOCkM4Xhl3gfuaKFZDDQHDjcB4472CUbIbZOQ==
Received: from MW4PR03CA0006.namprd03.prod.outlook.com (2603:10b6:303:8f::11)
 by IA0PR12MB7626.namprd12.prod.outlook.com (2603:10b6:208:438::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 14:31:43 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::4f) by MW4PR03CA0006.outlook.office365.com
 (2603:10b6:303:8f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Mon, 19 Sep 2022 14:31:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Mon, 19 Sep 2022 14:31:42 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 19 Sep
 2022 07:31:29 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 19 Sep
 2022 07:31:29 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 19 Sep 2022 07:31:26 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V1] PCI: dwc: Fixes N_FTS setup
Date:   Mon, 19 Sep 2022 20:01:23 +0530
Message-ID: <20220919143123.28250-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT008:EE_|IA0PR12MB7626:EE_
X-MS-Office365-Filtering-Correlation-Id: 80ba127a-596b-4493-c947-08da9a4bac15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rmb1D6NyNqWU9A7XsjeqKKG7dGv3e51qHE0kwq0VDIdYGUILeYWZmFpvm2AkxEjGiqnGb+DJ8pVqDTn5hLPpRMpGK3re/VHfTvqUuqRhTeQqgsVePC/mMuGc8fb+ZU/Kc1FsriQ4vhS76xlBvfKOuRqGqBPibHXRHBnjnx88nQxERMimnHgg5VtK11wZs4asbKVKZaXJxSQ+Tr6rOuKkUMVfke/WN9h2kp1a9ahSSEoPDuECpLJt61Mv9nJG+Kc7Yt8GIHUq4kjVppiaFqzAkE7gFE699Tku5qg3u55IwF8C9UUdYyx9rApPK4hxvujG3eKBNyRetuWP7+CES43kMbE5KQh3JtZz5k4+SKiDdCPUrqcrFMlI3lyymTH9789hD1LHTg8eEbfy9JqmWLKlnzDf/EKUsSTOZ/oBtw2j6BjY7r9PqZzWL9BcUZomjT5nzroeb/7L3K1v3wymHWWPAEPQCh6UeUwZgKejj2pUjZrn9nzjqliMjSNxGhsXxptgYEQSUQaRVw2lzrADN1JHnCwSOLbQ8og/1l5XS0/B4AQmjoU5VdEJN8Nd9qSQfuVDWjBtyp7C5ktUlE1t+cTKR2O0T+73DiKP7P6OFkgMF+WfbXCGZrToIw2dn25sl3tqJYCUVUqtatLh3pfiwcCzZOkrN1DtThyjWDgsLCLCU4OBgWhaRfIyDzEicdabzU6gV58r7Dmv6RRQVbvq/703rqr37l6y+l4pNUvxbucupV0ogAEZ8lnTz4hpnYViTHbKTrw1pdKf3YSdoPfx3bEG7Q==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199015)(46966006)(40470700004)(36840700001)(2906002)(8936002)(5660300002)(8676002)(70206006)(70586007)(4326008)(336012)(36860700001)(82740400003)(86362001)(83380400001)(54906003)(110136005)(40460700003)(316002)(82310400005)(356005)(47076005)(426003)(478600001)(1076003)(186003)(36756003)(7636003)(26005)(41300700001)(7696005)(2616005)(40480700001)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 14:31:42.5742
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ba127a-596b-4493-c947-08da9a4bac15
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7626
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

commit aeaa0bfe89654 ("PCI: dwc: Move N_FTS setup to common setup")
unnecessarily uses pci->link_gen in deriving the index to the
n_fts[] array also introducing the issue of accessing beyond the
boundaries of array for greater than Gen-2 speeds. This change fixes
that issue.

Fixes: aeaa0bfe8965 ("PCI: dwc: Move N_FTS setup to common setup")
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index c6725c519a47..9e4d96e5a3f5 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -641,7 +641,7 @@ void dw_pcie_setup(struct dw_pcie *pci)
 	if (pci->n_fts[1]) {
 		val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
 		val &= ~PORT_LOGIC_N_FTS_MASK;
-		val |= pci->n_fts[pci->link_gen - 1];
+		val |= pci->n_fts[1];
 		dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
 	}
 
-- 
2.17.1

