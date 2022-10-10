Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F505F9D7C
	for <lists+linux-pci@lfdr.de>; Mon, 10 Oct 2022 13:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbiJJLVF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Oct 2022 07:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbiJJLVE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Oct 2022 07:21:04 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE5066A7F;
        Mon, 10 Oct 2022 04:20:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V9P8xpBNq1o1yUkMVzDurEiOm0IRqZKcwfIXIiGmzgrwUT/A07BzuynRbu6vasvjT0+q9KF3i1OZh23FJeEbwek77PbWN4/O3SDhCYrMQGv/OVQg7K76tL55MlvoUQXw3nBc56lr03JIh2jcMiX6NRX1aqEaN4yGLF5wNr236PrE1h8yh1qvlnshLo+zzFJMoU5FGWjVVUY7amo/g00Hay8bq0xpg2AyHyybTpi2faFPpDj+jH2pAZr65YPHKsHZzuW6Bn1dFGUITCqAoq3R8iUhjM5AxgU9VIHEAFfAPHkMELkhT7N3CZr5qFUk9Sbw9Eio7N0eOgQRuarAZGYx+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sO+h+hA8R/EsIuJBHB5bYN20abLljjN0ZwtDp9TlAI=;
 b=fC/qBAkXlgTA/AoG8XqWh6fh4uTI9rvN0eaWxONaVJoKeWNPoYlGhFhNAOr7s4l740cGg/WZgtwZlGTY09ljQc91uNxfO3cfMc/3ajSaNmiK7ecch2gSxEEMC2sTFzeFukUE162q93j50ChWEWEafw9zAt+CYPkRC3kQc6xoU/MnDoonMkSOGlDlRtLglJ+9sICyGM99xOtr43QqovOhJBS6CInxBFkTbJfL6A5ni1uLGp6bA/eRUMclHbUsVZMj6sU+L1GO+8h7Tiz+dpKWecSLwh4UF+Zsp/0QekubcYkg3eRlTH3rIYh7kpl2Gq2wYnJ/Tq37TpCQfEdjRky8Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sO+h+hA8R/EsIuJBHB5bYN20abLljjN0ZwtDp9TlAI=;
 b=oNPgbTBbp7MDEtuTxwUoXGoKdDlNoyfrQ17E2qTC6GJB4qK8SrcLz2aIl5eqbGf/Z2bsKASt11HMYLQNcA7KcRaD4n4fRUMyr/SJpPHGbrQlThCj+KpWxRIMURgJQVni2lbWfkodzT9QPVR9oCeIZv3PWyJ4VZJREPlIu8TyWaKPcTmppkpzi3gtnHUfdu+5dS33+Ps3/Qj96hu/V/OXPeP2+iCUsl8zh/MomYxLPtGLarIRTyi776uyEGtQSJ6HqdeZ+95pKFzpEhMXLVedBg9FIvLrKe5GvV7E1I0Rd18Gt/FYcTNH/sZ6Vpdd1xSwn/XeR4TwQ8mD8dsU5XXPUQ==
Received: from MW4PR03CA0180.namprd03.prod.outlook.com (2603:10b6:303:8d::35)
 by MW4PR12MB7216.namprd12.prod.outlook.com (2603:10b6:303:226::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Mon, 10 Oct
 2022 11:20:56 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::aa) by MW4PR03CA0180.outlook.office365.com
 (2603:10b6:303:8d::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Mon, 10 Oct 2022 11:20:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Mon, 10 Oct 2022 11:20:56 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 10 Oct
 2022 04:20:42 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 10 Oct
 2022 04:20:39 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 10 Oct 2022 04:20:35 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <mani@kernel.org>, <kishon@ti.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V1 3/3] PCI: endpoint: Delete list entry before freeing
Date:   Mon, 10 Oct 2022 16:49:53 +0530
Message-ID: <20221010111953.5422-4-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221010111953.5422-1-vidyas@nvidia.com>
References: <20221010111953.5422-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT036:EE_|MW4PR12MB7216:EE_
X-MS-Office365-Filtering-Correlation-Id: 1caa1dcf-eaef-4009-d746-08daaab18087
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P5UQlgX3NPmXvnUTJIx870ymARFOkvB7sJie8vOtnClZVlQgXeY+4AtPmIbQ+oEnTB2NCdCvXqvV9CA/kFTAdW+/mgfQsPSeN4eEVvXGNSmjmBkee/B6kxhWjgizVyM96qhn+8dJQK2AK9cUh/j8r2+NGtknPSlPeyF4fZpCdlMD98LOOZGEHJTrD3WBnEXHmX9r3wty3f/ufC+fmZUMB2DLjtrXPf8RV2v0gs1FCpyS2rxuwu6AzLOyCLvmniSu6gGPd7GTzenu9o0dA0vCEp/UeK89pSuyio6tzImJQjwUcIIo0777n5fkH3G8Fn04sNSfjbm0vHN1X5Vu+8hn+WmRirIYCYOQkGWAF8oHvcdkXSTtd/6clpTUk0srwwt2bACiDLqrLegzy132pCaipIL1xvSeqVhGgVzwrd0a3S3vt5U+72xd55iwkC1DWvmsyJKfDITvOB66LQLLym2e3U4TkWc091k6Qyds7TBNXQKbLmHjFE88kuYobKxvnd609KOAL6F6RTpz+8rgzGfjQj7hD8DFWS82iX8wySqWZqD7upyaXm3JNT97XUi27f40pYjZXMSPyEllphWwkVhU2PNhWAeI6vJ+SeuWGxeCJExDsuDqSJUBfkwz6MFlUCt5BvuNrwBYx4rdf6klxDf+PpUJUQQuXFiD5JKKp5PSDXVCSZD3boMLxqoymIe733baJRsOz/cIrJFxZabTjsD900bAAuLHqPk/Zwpv77pZca3qw5wZ/4RxDKTUtpB5QkhKOwYs+8Dt0e5NVpH13E7S/w==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199015)(40470700004)(36840700001)(46966006)(8936002)(186003)(426003)(2616005)(40480700001)(478600001)(83380400001)(41300700001)(336012)(7696005)(36756003)(26005)(2906002)(7416002)(110136005)(5660300002)(1076003)(36860700001)(82740400003)(7636003)(4744005)(6666004)(47076005)(82310400005)(356005)(8676002)(4326008)(54906003)(316002)(86362001)(70586007)(40460700003)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 11:20:56.7884
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1caa1dcf-eaef-4009-d746-08daaab18087
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7216
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently epf_group list head is deleted without first deleting entries
pointed by the list head. This patch fixes that by first deleting each
entry from the list.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/endpoint/pci-epf-core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 9ed556936f48..a7f4ae33905d 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -340,9 +340,10 @@ static void pci_epf_remove_cfs(struct pci_epf_driver *driver)
 		return;
 
 	mutex_lock(&pci_epf_mutex);
-	list_for_each_entry_safe(group, tmp, &driver->epf_group, group_entry)
+	list_for_each_entry_safe(group, tmp, &driver->epf_group, group_entry) {
+		list_del(&group->group_entry);
 		pci_ep_cfs_remove_epf_group(group);
-	list_del(&driver->epf_group);
+	}
 	mutex_unlock(&pci_epf_mutex);
 }
 
-- 
2.17.1

