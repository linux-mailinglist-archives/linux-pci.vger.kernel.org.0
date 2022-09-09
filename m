Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62DE5B3D6E
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 18:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbiIIQtN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 12:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbiIIQsr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 12:48:47 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2084.outbound.protection.outlook.com [40.107.101.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E796A1475F1
        for <linux-pci@vger.kernel.org>; Fri,  9 Sep 2022 09:48:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zga4wUq08CsccFgbvsVPsbYxejOuszCX/RceTTuSpkWSg61DywjUIE40IlApABBd1LjEZwRz4YNLXx/d+DJL46UNUQGpKxnto6N4TKx4ZGj3FSj3xEOYjOrEY/YWLwOd/VPBacUEfZulpyupcvAGSqQhqbeOd6WV3GoOk9PSrFMH7FUR01l5qpDCIWDhxVjHGJj2aSsH0eTcgleUHHT8GvaNnsdbu48VTRSZhjNhxEzxt/QsT6fpf6aLJxYBJpB0aZTUqphMM9Jqrt0VO6FNMNvCo6X8PdhpPg6h0P5YtcVqt9qwGuev6XOL6+pN9ykHCikyNJtaF4Nq8RXs2ZlOGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oM5C4SO6ywgn0Fb/mEw2bOtQFiLTCLD7BCTHIBtSpq8=;
 b=L7ImBjSA2OhP+7Udi6/VpIfhVXmRntTYaFyCp3ZXibvBM5uCNdOUIgppXrDwDFJzEh3ZzN9MgOblXr/GkDWwIh6C+zszp1IciUb6vYnBnFLUfAJPyerzJFrDHDcHdJWo6ZjjmPXu6c6x+KfeyAfq/nAs9RMhv4rKQXc4m3+qumPfaGAiOILhcUQxGEI8mHFhr/IZOzqENQ6jV3/lGCn592XNKEwozqHBjLrU4JtCAsh63vuQcLR0wS/d3zZiuwNSl9c/MENZened+8HpXyMR/EeobOBKvOXe7VTauixQw9ufhHOcfM5/T1AV18lYMz/sn6QdbnEIFE+PCUP825+dFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oM5C4SO6ywgn0Fb/mEw2bOtQFiLTCLD7BCTHIBtSpq8=;
 b=zHbVj4SBtPvfqOA0ydewFl9MP0PeEAX5qP1mSMoeLazG7dXKB7iaImcIP+j0ZXlZlZ7ElRcRTo9Srv81ThgjR9QjbipQo4PPC4V/8FLaodmh3A3ts1Kk7Hn/LnUVpnogpCc/dBEk6mG+WToIj9aGdDNERDSmF60YxzuhoU+XdbU=
Received: from BN9PR03CA0138.namprd03.prod.outlook.com (2603:10b6:408:fe::23)
 by SA0PR12MB4365.namprd12.prod.outlook.com (2603:10b6:806:96::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Fri, 9 Sep
 2022 16:48:16 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::bf) by BN9PR03CA0138.outlook.office365.com
 (2603:10b6:408:fe::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19 via Frontend
 Transport; Fri, 9 Sep 2022 16:48:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Fri, 9 Sep 2022 16:48:16 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 9 Sep
 2022 11:48:15 -0500
From:   Alex Deucher <alexander.deucher@amd.com>
To:     <amd-gfx@lists.freedesktop.org>, <helgaas@kernel.org>
CC:     <regressions@lists.linux.dev>, <airlied@linux.ie>,
        <linux-pci@vger.kernel.org>, <tseewald@gmail.com>,
        <kai.heng.feng@canonical.com>, <daniel@ffwll.ch>, <sr@denx.de>,
        <m.seyfarth@gmail.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5/7] drm/amdgpu: move nbio ih_doorbell_range() into ih code for vega
Date:   Fri, 9 Sep 2022 12:47:56 -0400
Message-ID: <20220909164758.5632-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220909164758.5632-1-alexander.deucher@amd.com>
References: <20220909164758.5632-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT056:EE_|SA0PR12MB4365:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a3ab4de-6992-485d-eafc-08da92831811
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TGgxaku6pXHfsyfwktUhdXSuhKcDWzB5qHS5uejLxKZz7O0E9ZnFa65zpj0m1aa7Gjfqhtlj7mViDFxGm8GiApFlDorbgH1oUy9pG6EMUk7XUHn4FjSkmMImmwHkrKvXat+pRRkw7EbttxVCkDndT9cGKDM2zBau7p4myVypZFSkQEL7bKYU61ivmSyJza3gAcx0oQDWpDuwPQ8/0WMbwahpFsNiWDWHPCPxz//ZtTtARBoK6WW6bd1Id3p5GYSuJvuwFi9xZSEPQV9pS3jLLmDsAATue92KoMLcBmb2XGZkeGSXkgceEnfUxcvpVfVZ7P1SZxIRSBZ+/nHIlFVerW62DbTt0yDHdeQ5cdYg5OQaqrfP0rBygXCXbVQoLIDwRYMEym4j7XqUQlA25o7FL75CL7MzcjdmpVfV4x6RuZApgI+M+lhkqMSaYpQRi6og16udH88TW2x3FBB3q3bgVh3gs6ee6t7/oW95S7ydKIbqzeVmBkGUJjouUnnW5ik3OIXoPF3DI8MxkKKynJ1bRi+RbtKXPRlm9RYj+R8YcWM3mhImj+b2A/JW6boG30cmWtFlwT++sy8F+AJFp6ekS9RX+sxK9Ar2ySGAKVEnX7O80n2LNMpGXgdJhH3my9j5Oh8I9zbOWTDHHLiB070T9tr3y+nU0+nQKznDz65fa2KVxC7QMY5J72i5amDpGf8KJ8rHJtsk2a3y1fR/YxYclzK3bvJBMERCH9f3PpZrq9+vPZNMLcsQe043UkDRFqbV1L2fw/KIuyqQkDv1Oi4I+xo7a5n4WuiDjM8ZXEJ/pR8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(396003)(39860400002)(346002)(40470700004)(36840700001)(46966006)(7696005)(6666004)(478600001)(41300700001)(83380400001)(2616005)(426003)(47076005)(26005)(2906002)(16526019)(336012)(1076003)(7416002)(5660300002)(8936002)(316002)(40460700003)(82310400005)(110136005)(186003)(40480700001)(54906003)(4326008)(70586007)(70206006)(8676002)(86362001)(82740400003)(356005)(81166007)(36860700001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 16:48:16.7763
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a3ab4de-6992-485d-eafc-08da92831811
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4365
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This mirrors what we do for other asics and this way we are
sure the ih doorbell range is properly initialized.

There is a comment about the way doorbells on gfx9 work that
requires that they are initialized for other IPs before GFX
is initialized.  In this case IH is initialized before GFX,
so there should be no issue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c     | 3 ---
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c | 4 ++++
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 39c3c6d65aef..1dbb2a3ac4c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1224,9 +1224,6 @@ static void soc15_doorbell_range_init(struct amdgpu_device *adev)
 				ring->use_doorbell, ring->doorbell_index,
 				adev->doorbell_index.sdma_doorbell_range);
 		}
-
-		adev->nbio.funcs->ih_doorbell_range(adev, adev->irq.ih.use_doorbell,
-						adev->irq.ih.doorbell_index);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
index 03b7066471f9..1e83db0c5438 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
@@ -289,6 +289,10 @@ static int vega10_ih_irq_init(struct amdgpu_device *adev)
 		}
 	}
 
+	if (!amdgpu_sriov_vf(adev))
+		adev->nbio.funcs->ih_doorbell_range(adev, adev->irq.ih.use_doorbell,
+						    adev->irq.ih.doorbell_index);
+
 	pci_set_master(adev->pdev);
 
 	/* enable interrupts */
diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index 2022ffbb8dba..59dfca093155 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -340,6 +340,10 @@ static int vega20_ih_irq_init(struct amdgpu_device *adev)
 		}
 	}
 
+	if (!amdgpu_sriov_vf(adev))
+		adev->nbio.funcs->ih_doorbell_range(adev, adev->irq.ih.use_doorbell,
+						    adev->irq.ih.doorbell_index);
+
 	pci_set_master(adev->pdev);
 
 	/* enable interrupts */
-- 
2.37.2

