Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BED5FE11F
	for <lists+linux-pci@lfdr.de>; Thu, 13 Oct 2022 20:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbiJMS0C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Oct 2022 14:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbiJMSZf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Oct 2022 14:25:35 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20622.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::622])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B22BC60D;
        Thu, 13 Oct 2022 11:20:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fN167mHGzTILW1AqvNq+/pYk4rGckIW0DsjtFZFhGFyDtT7GjwCyBzlXaM2z0+HfObn7h6IOO/DNg2M0CqSob929Hq1GUOpAUbUFG1MasvcaiuG851iFPuKMmlGN6seGkaNELirH1aQCq31xT4zbhIJKILvK7ERPW6Vu+GFiPVgc4vRNxeSoveXq3zyoglCQaHgfZz/zWH87N33QTV7w38Y/mwy/zjDnz5+NWCu3faba9VVhgTKsgkwHjQt6XNh8e4NHldenju6qapDbtjn7b11KlnBKfAiOz27nyQpSYNmOrHaLqhahYio3DYngW1OVXaTm9r3a0gyZN6dlNc3MfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8RCBMImUbu57RwVzJxz+QL/TLIHkFPMcizQMJVRBo8=;
 b=RFD5/lwVUsER+2o3CNwYLKgph0hz6YQcsVut/eX6yG/5sA4oph76bSAPEp2MIpMcTHiC0V6QLZOjTMB8v6ktS7ElnISjBZWBCFC+DVjNY0vp7v/mU6tguaG2I7aLfIrQ5S7LAErMnl4nl5Us9NEZRujCzRXRbhwqSUAUOvaDPE8Z70Kz9ru5ZananRXpsSJ5RyabqcyUxLvlvfytrJn5B2JYjY6N7fNxYawinv88Q5MVJUVLXxsDXXuAHrxcVpw8CwUhdyEeoe9o1uTZHeJQadgtb0R6KuBhy0M6Z/gSbE9BnInyAnj+STeVA6tvpYl5A9L4smduPazF8nFsEPHySA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8RCBMImUbu57RwVzJxz+QL/TLIHkFPMcizQMJVRBo8=;
 b=ZeKGLJKgZM9Vw8PkK9AdEUO0fmyY0wd9K5yaPEuHLnOzmHO7pvjLnNcWJi0fQwMy2ym+berS1BHHVNy0zXz9dH/SLc0jGE9zvNMd9Vn1aNFoP5hrjX77I5h25vr6ZN2cSM29iS4/E2pDYQ5ULejIfs6tN0B/Ml6Dbd9ya11H4y6iARteDm3W52PrnuICCopC6mwpX+qgg47ln562Hx9Oe0zz2fFP71gCVvQTrRiirbzO8/zBUdzRfkO0OZeTHHYr+xWbr2RitKP1lRg3tM49tXbG0iFiJZG3Qhc+uDIVL2aIG81g1A1SZfm9qbj7guqd5jE2VfIkumrQ8N5i3ZRhwQ==
Received: from BN9P223CA0006.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::11)
 by DS7PR12MB6094.namprd12.prod.outlook.com (2603:10b6:8:9d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.22; Thu, 13 Oct
 2022 18:18:56 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::30) by BN9P223CA0006.outlook.office365.com
 (2603:10b6:408:10b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26 via Frontend
 Transport; Thu, 13 Oct 2022 18:18:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Thu, 13 Oct 2022 18:18:56 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 13 Oct
 2022 11:18:45 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 13 Oct
 2022 11:18:44 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 13 Oct 2022 11:18:40 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <mani@kernel.org>, <kishon@ti.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V2 4/4] PCI: endpoint: Add deinit in epf test driver
Date:   Thu, 13 Oct 2022 23:48:15 +0530
Message-ID: <20221013181815.2133-5-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221013181815.2133-1-vidyas@nvidia.com>
References: <20221013181815.2133-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT067:EE_|DS7PR12MB6094:EE_
X-MS-Office365-Filtering-Correlation-Id: aff33bd5-fcb5-40ee-e84a-08daad476488
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dY+keJHieQEgB7A31rw5JS2Fq8JeL7GxvhEh4pciiAPMLfa44qbMUDP7JcCo1jy0UKVHwHewwY8ib8aDdvPtCpAR5+yrrlEiIV7SpB1xkpyNEZ4K6jwl82AJxhJBrf1jpT8ldjPxeT2WmmUFko1DD5AJNP8gu23lueMJ4OClPr/d35DdSSfNc1tVZqGDGjiees6oy9TiThwC3Pzr1JLP7o+F0sLB5VYv0zZgRQOjbTLeADpUqWiqp9B3Pmm5KQsUtLjLjEX7X5wOb5H0A2IMYwj/R66Ub38k6gVQr7oE4AFjoLm5baDmVFOEdy5QtOSgcepj11vfOpQ19uH0ba5dGJYEsJVRWI6PLl3v+LFKeLPBbY8qeIRTgxzrPywwFzHsXMq8V9mOBFzuJ9r/CYRN9w9iaqxWwQHbcGErqlQ9DV7Ovctxnoj6B5JNQOZOoWWrvE9fzb07uVcfGraLw66s98AKXf0fUyElk02cQP7BckiGnSDafo4+20uyqAXztXCJayfm7o2gWnvOTTE2wcvB03Q905Hn/GjbAtSGW4L3BbPP5Ogw+xuXHJ+KslZpFFvxlYV6W6YPtYAGbtlotikbiVDMduV+7MxLbo3dlYEZP99qIsbEKJhWaFJ1wPspVNxb2UBhi8Wo164w7cWZtwPD5miDUuF70EslR3s3TR3HnAuN2b67LG7976YqoULU7eRPvML0qpKr/GgnmYtUkVBS6BM6i1mDIxaZXrIk9CkGMPdPiU1pDTqrhpyHV8lCAq5XGy0xWVCHkR+5dNCCrg5d8g==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(478600001)(86362001)(36860700001)(54906003)(8936002)(47076005)(40480700001)(110136005)(316002)(426003)(82740400003)(70586007)(70206006)(82310400005)(40460700003)(41300700001)(356005)(36756003)(336012)(7696005)(186003)(7636003)(7416002)(1076003)(26005)(2906002)(2616005)(6666004)(8676002)(4326008)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 18:18:56.5136
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aff33bd5-fcb5-40ee-e84a-08daad476488
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6094
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for clearing the BAR info during the deinitialization phase of
the epf test driver.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V2:
* This is a new patch in this series

 drivers/pci/endpoint/functions/pci-epf-test.c | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 136470019a24..25ac3d161fac 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -826,6 +826,35 @@ static int pci_epf_test_core_init(struct pci_epf *epf)
 	return 0;
 }
 
+static int pci_epf_test_clear_bar(struct pci_epf *epf)
+{
+	int bar, add;
+	struct pci_epf_bar *epf_bar;
+	struct pci_epc *epc = epf->epc;
+	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
+	const struct pci_epc_features *epc_features;
+
+	epc_features = epf_test->epc_features;
+
+	for (bar = 0; bar < PCI_STD_NUM_BARS; bar += add) {
+		epf_bar = &epf->bar[bar];
+		add = (epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64) ? 2 : 1;
+
+		if (!!(epc_features->reserved_bar & (1 << bar)))
+			continue;
+
+		pci_epc_clear_bar(epc, epf->func_no, epf->vfunc_no, epf_bar);
+	}
+
+	return 0;
+}
+
+static int pci_epf_test_core_deinit(struct pci_epf *epf)
+{
+	pci_epf_test_clear_bar(epf);
+	return 0;
+}
+
 int pci_epf_test_link_up(struct pci_epf *epf)
 {
 	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
@@ -839,6 +868,7 @@ int pci_epf_test_link_up(struct pci_epf *epf)
 static const struct pci_epc_event_ops pci_epf_test_event_ops = {
 	.core_init = pci_epf_test_core_init,
 	.link_up = pci_epf_test_link_up,
+	.core_deinit = pci_epf_test_core_deinit,
 };
 
 static int pci_epf_test_alloc_space(struct pci_epf *epf)
-- 
2.17.1

