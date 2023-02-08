Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B91B68EDAA
	for <lists+linux-pci@lfdr.de>; Wed,  8 Feb 2023 12:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjBHLTX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Feb 2023 06:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjBHLS3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Feb 2023 06:18:29 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on20618.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::618])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11D1EFAD;
        Wed,  8 Feb 2023 03:17:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9PhfqrdOBGtp+M7dXPbcxzic2Jdwg7q+yy46IfzW7H/vq7x9UmpM1o62vC6Kkyd1ukZjW0vbmwjp5BkqewL+kV/hOqDILvkDQSqgJCvuX/jDZD83l5LQBRSS3/DXUgDDI2az1kamD8zzWKpzlQ2slh9Le2TRtkBFVVFsIqeeTPSC+8CcwB6Hy73yLd1NLyCRO0x4BKeUGNZG76W6wtZQO9e6QUNoBfOC306/ud/n5ubmAlDixbG6xs3kdX/Yb2neU0llZQwfBt6+OOABNXWEh0mkYLPl7cxuU6LW+ZWgQ1o5lCEuDCDs8ZnGwwmviaIGf9co7WI46tyJ/uPM+ktYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZAUMVkexY8e8tpIUPhxUFjFshADWTnT3tonlCqFWF5M=;
 b=GTjfEpxNl3AOMZew9+flRdLgcHdfLNJn0p+rus3HCKE7eIuHj0s/OWCUXgCs5SwEjqzF6X9hK7khPKyUOwz39PPu17FeuAr61i+ADQKhWCFd10v4WiHPxh1wkVZHBn8i95JlFOYi7/umESNYQk+CkMk1P3KVuiWjCd81s5ueUBYtXPJCk9w378vsWi5IhGDxvfqvLDHX1Zr3M3Epm7MdxMbnWoTBZpQs/y1v+am6m/V7ZMAKq8/m35opylJ7gGQpDYKnw/a9B6ZZ0/a15+sLbHXpcgy0nn9IoED0oG0KIRQ/eQ7aM7gGVA59BPH6QjCINzVRTiJzOnAWPZyMLjSAvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAUMVkexY8e8tpIUPhxUFjFshADWTnT3tonlCqFWF5M=;
 b=r/o16C2i0w79v7jb7q1OWIC6XzScK4/esmgDxzOkAbLCjaPeOSUEl43CqzFaM2xnVDFjPf9NF/Lo4VbIRWXjYicVK6OQWBX8pCGNAV+40ReqZ2hXF7Z11jzCk85JZYMDkzD/Y+lEXPLbYjViha8FeeMjkUwzduP2vdFdabA57RRcLDCcRA2BTphcs+Z+bR2u409Zjd9Nr2a1PveUzMApeRtAG0CcpTrnr5lrufz004SxjO9/TI7RiwDYMMB9olzERE5kld3SGVYa4CfboDKyqjFFTPsh8jb+a/deDkoPtLwLvnOc/k95bHA3o0q1jdV26U3T1jaJqjKXpY20toUxww==
Received: from MW4PR04CA0210.namprd04.prod.outlook.com (2603:10b6:303:86::35)
 by DM4PR12MB5962.namprd12.prod.outlook.com (2603:10b6:8:69::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.34; Wed, 8 Feb 2023 11:17:31 +0000
Received: from CO1NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::d5) by MW4PR04CA0210.outlook.office365.com
 (2603:10b6:303:86::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17 via Frontend
 Transport; Wed, 8 Feb 2023 11:17:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT102.mail.protection.outlook.com (10.13.175.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.17 via Frontend Transport; Wed, 8 Feb 2023 11:17:30 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 8 Feb 2023
 03:17:23 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 8 Feb 2023
 03:17:22 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Wed, 8 Feb 2023 03:17:15 -0800
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <petlozup@nvidia.com>, <rafael.j.wysocki@intel.com>,
        <lpieralisi@kernel.org>, <robh@kernel.org>,
        <jeffy.chen@rock-chips.com>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <jonathanh@nvidia.com>,
        <dmitry.osipenko@collabora.com>, <viresh.kumar@linaro.org>,
        <gregkh@linuxfoundation.org>, <steven.price@arm.com>,
        <kw@linux.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <vidyas@nvidia.com>, Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [RFC,v14 2/5] of/irq: Adjust of_pci_irq parsing for multiple interrupts
Date:   Wed, 8 Feb 2023 16:46:42 +0530
Message-ID: <20230208111645.3863534-3-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230208111645.3863534-1-mmaddireddy@nvidia.com>
References: <20230208111645.3863534-1-mmaddireddy@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT102:EE_|DM4PR12MB5962:EE_
X-MS-Office365-Filtering-Correlation-Id: e99e9885-9c41-4aec-3964-08db09c611bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rmOsbTB/osFSD4NwXm0sQJCh/UAmfPSmOhIPBXNbt3fl31VweK/8u/y/uuULbHyQq8mNNfPwpDqx/wJ1VnXSJmg3YpFfl/RDd6cKjWZNyw36V4mgoF9TtELb6+dtOQrF00vHRBfZFi65yx6pu3WxkwWsxS02AnRcuAR4MfpANq8IMsP1ihaEXeh8jGg1OTevb/PqBdn8Fn+n36EYL0R6hw4MggyjdRvYWgf4oPQbpq7rYQOGFVXbHDWrhYcauHto5eKIMoPvb+aRWlt+/cgtt09v45wybL2S1pYAMLiAnR6iKYyO9K9hEKvZeHNPf6hKH8GPiCdvWCU0pmNMVhmWWd+rFMj/At/FPfwgSgQyzpu52YxVniSbwDnUmNz3OIaF0mEO16KOrA8WB28eRBxxmdFi611KJYovyc5PUg5F8EoXaDpQoKtQpdQOrH2GcdDDQuCR/u4SlnF0tY3cvPMFegdfJkiisG+IscI3yvG9OaQfdgVvBr94uCtOkMzbCWqGgAxVhUKOKYpUJb4U/zG4FCwc7jELv8inNFI+hAPTYalJVlWOTL+OUlhtzAzj6jm42Lg2szxf1Qi3Er9UA+5hWTcnZwK68ah0al0i/DefcwZGFSeM8HVKQrAFa5dtUdaw3bCerMa6uccmfe0Yy/gPReNcr098RzhOKkObXhp+CfXUTyoyhQvUzRZdkgsRCc7GWzqZ/PmfmBdIe/C5xjBTPQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199018)(36840700001)(46966006)(40470700004)(40460700003)(70586007)(54906003)(316002)(83380400001)(70206006)(5660300002)(8936002)(110136005)(4326008)(8676002)(107886003)(6666004)(41300700001)(478600001)(1076003)(426003)(26005)(186003)(7416002)(47076005)(336012)(7696005)(2616005)(356005)(36756003)(40480700001)(82310400005)(86362001)(2906002)(36860700001)(82740400003)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 11:17:30.7776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e99e9885-9c41-4aec-3964-08db09c611bb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5962
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jeffy Chen <jeffy.chen@rock-chips.com>

Currently we are considering the first irq as the PCI interrupt pin,
but a PCI device may have multiple interrupts(e.g. PCIe WAKE# pin).

Only parse the PCI interrupt pin when the irq is unnamed or named as
"pci".

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---

Changes in v14:
Address Rob's comment on using of_property_match_string().

Changes in v13: None
Changes in v12: None
Changes in v11:
Address Brian's comments.

Changes in v10: None
Changes in v9: None
Changes in v8: None
Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v3: None
Changes in v2: None

 drivers/pci/of.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 196834ed44fe..ff897c40ed71 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -429,9 +429,17 @@ static int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *
 	 */
 	dn = pci_device_to_OF_node(pdev);
 	if (dn) {
-		rc = of_irq_parse_one(dn, 0, out_irq);
-		if (!rc)
-			return rc;
+		int index = 0;
+
+		index = of_property_match_string(dn, "interrupt-names", "pci");
+		if (index == -EINVAL)	/* Property doesn't exist */
+			index = 0;
+
+		if (index >= 0) {
+			rc = of_irq_parse_one(dn, index, out_irq);
+			if (!rc)
+				return rc;
+		}
 	}
 
 	/*
-- 
2.25.1

