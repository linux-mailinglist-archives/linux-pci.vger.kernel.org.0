Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12045FE125
	for <lists+linux-pci@lfdr.de>; Thu, 13 Oct 2022 20:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbiJMS05 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Oct 2022 14:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbiJMS0h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Oct 2022 14:26:37 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061e.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::61e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA75E1911E7;
        Thu, 13 Oct 2022 11:22:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCG+/zRb29oxa8O83NxK4QeyXEhFBnGFrLwXCIMn8+Bvf6ugsOoJ9fclFVGuesNYegK07AQuRWzBpW2bathwL7eKBckS5Yv9APAYb/cmGybdGrv5IaGD/r4CFZySNZVxnUdy+ZzFmE4eCyJN5EGtgK4mWMUIeTSdUhtJ2vWe1evxHnGGqSKAm4TZFj1jjwu6XpBRj3ggvlmOuVYTZd5A58+RUbIueXpebEmT2gBZTFxnMHASZlvLB9nSuT1u1C5Nrl3yEiP4EPecKZTaZmfcbULjLK8OpPfl3Vh6HlkHS9J6qLmbSi/JzNd/kjmR5K6C5FW/Y5obYiR1D5GIMhNIHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5feri6YkamJmIEH1jzL6zd6yHlJlKpI7WApsvrqNihA=;
 b=ge21OhL0H1sPuYbYmkdbBxQD7uFnnFwBzmfmecqaRiBMvkka08WYM3jcYwjNUbJp1GWct+cbQfKu9VE+SPtKZYtFf/ed6XjpE6gQUIZ2Gkh9libRzjjIEPTHKzl+2dOoOsuGcjxRkwZ8XQsHZ3tLM6Wvaf7isQRWDRIylh2W8lhP2kKLBNDUO6IC2hh4JkRigiBrx+Dd6k7TwMu+sKCe/zWMNSlMNPQZAf0DQEiz6YzS1Xm9u4fWjarGjFdEbgNIcxj2i+C7swrfM8NEy79ZHRkClnLcN4RSmnlEW+dnfqX9KDw6QK169CNjzAMeTDVJ3MMB5NlJeHFpbopsSdCwQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5feri6YkamJmIEH1jzL6zd6yHlJlKpI7WApsvrqNihA=;
 b=uQNhdGJAf20tdL6P6+u7pSpMWA/PoSQOl1kOslVsyJgJctPttKdGVpropjwvCb234Y2iF8Wd/AqXx1uUZAxLHVnK2o5ZAThmAw6QWQqMwWWaDo1+cwVpBYBplJMh0YqauTIatUnXXCM2Dx9KPpEr7Mbjqfei9MBJOiqupq4lLmyjFLiLYe1qAZi8t6rFGrXK7B1Y8xxgZn2zWh/3LDuwPPc0sIP9xjNEnOKbGS2eJyOtwOVtc3BIHURHka+Ln+bfDckZLHmYVQVLfytOhUCYW1UNgrDomXVLW2PC5fLaO+lw5dVcAwZgpHXyEjohmlr/kPSEgweIcvcPLve0SvFRTQ==
Received: from BN9PR03CA0410.namprd03.prod.outlook.com (2603:10b6:408:111::25)
 by PH8PR12MB6770.namprd12.prod.outlook.com (2603:10b6:510:1c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.22; Thu, 13 Oct
 2022 18:18:55 +0000
Received: from BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::33) by BN9PR03CA0410.outlook.office365.com
 (2603:10b6:408:111::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26 via Frontend
 Transport; Thu, 13 Oct 2022 18:18:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT075.mail.protection.outlook.com (10.13.176.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Thu, 13 Oct 2022 18:18:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 13 Oct
 2022 11:18:39 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 13 Oct
 2022 11:18:38 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 13 Oct 2022 11:18:34 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <mani@kernel.org>, <kishon@ti.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V2 3/4] PCI: endpoint: Delete list entry before freeing
Date:   Thu, 13 Oct 2022 23:48:14 +0530
Message-ID: <20221013181815.2133-4-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221013181815.2133-1-vidyas@nvidia.com>
References: <20221013181815.2133-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT075:EE_|PH8PR12MB6770:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eade0b4-9761-4f96-eda1-08daad476351
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jB9YtQLgNpirn3xF45mL/axsRelsk+NXgCORsLowHaGGnDngLl791WQkFhh1lA3zBKAx7SBH7TmHG1/8yBkYR8349pvwaqoCbyeeGRt3awGPDZxIrEu1DKkOxFLEFCPEdOJ/Mu3SxAJLRbzRnyqN8HvTYqSukRUflueQsdIeO5MEy/ChhAktivAJUPzDZPhPawB/zSMCUKCIrS5dsosm9bNlNfglv4b7JsfpjdIL8KZpKtFJNJr3T0DHOOu6lfmYkrLR5Gso7rLL5FLgled9pA6fhNVULbXxmLWh8pCUa7v+D/Wo+7R1Xt3WCx2eNCJ8ckmqM6+T8CPDszaG2sMWJf/wearBnqC4/pLCXrGoilQ+FTFMUE1GjFS6GP7Gon5Bxs7ZgIJS9efiYJcEwoRJ2yG+r701gk+En0wlsej6ldk0tJazlLwlr9O2pjOfUEGYpn7uiXBcKZvfcFJrCz+TigrcZlMT+sw9htcZVyCM5nQ/ENh3S5deWNgI/77d8Ham8Mz4Tlpi3CCIpAhKqM3A2hTPvNLidbjxZq7u26uYHXzKIz5sfAlMhWjmdYxzaTK2sFWCsh+8s6jv2K0JqTsw0rCBNVOymeL9rGLPAcSN9qaBjVfSjSJd9dR2VkC6rd3y6ivLa8zyY1SebCOUTQ9EuDEfksNp1TjTyEcEl56mAewxUDnWdfcnHhoLB/JyUJ1JuZOKqqiDh36ATfxyOjUN3Vg3tILr1TS8xhI69riisy2Uwr6xfLg66LSPtBCAr789ILdMqlC3Xt00fru9fAiAug==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199015)(46966006)(36840700001)(40470700004)(36756003)(36860700001)(356005)(82740400003)(5660300002)(2906002)(7416002)(336012)(186003)(1076003)(2616005)(83380400001)(86362001)(7636003)(47076005)(426003)(7696005)(41300700001)(8676002)(110136005)(316002)(6666004)(54906003)(70206006)(70586007)(4326008)(478600001)(40480700001)(82310400005)(26005)(8936002)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 18:18:54.5068
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eade0b4-9761-4f96-eda1-08daad476351
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6770
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently, epf_group list is traversed, and each group entry is freed and
epf_group list head is deleted in the end. Deleting the list head is
corrupting the data in the group entries that are already freed, leading to
random crashes. To fix this issue, delete each group entry and then free
it, and don't delete epf_group list head.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V2:
* Reworded the commit message

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

