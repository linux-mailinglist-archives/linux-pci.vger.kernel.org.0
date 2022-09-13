Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF39E5B75CF
	for <lists+linux-pci@lfdr.de>; Tue, 13 Sep 2022 17:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236205AbiIMP4R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Sep 2022 11:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234249AbiIMPzr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2022 11:55:47 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20600.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1586C8F94E
        for <linux-pci@vger.kernel.org>; Tue, 13 Sep 2022 07:55:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=URs9lQHM7t140BAbTmQZNtda9eqwGEHQOeJWqGahJZEG9YVwzoRs/NeJmb0L7F2uWeEyNVAvrUa+GUMlVaXHVB9qQc1Kx5YyAnAgRp0GVIKlNMss0hLspl6FYkxkrKN94/9ZJ0TJpi1McSkENELrcRVrvPV8lRQ+BrjkHVcuMGPV58FlxVz7QGaoig0uFp0cLlJL2kA22rs9VdVudGr/BIlMW9I6nZxm3Uu7H+3iGnB9JGbMkid2zEstb9JdvVjUPL3Sj0yfQfXmOfIIKxH6c1uBqqwpCCYyQvzLpM3PZtecjyBdLog2MMKYe565HD2He5QI851cknVijqTtsj55yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=caHXh5ebz8/bO+pvzbOAcLayiN7VPGsV298vKkwXYq8=;
 b=I6ihOC62pd/e8A9xOuq4OVSw35LnDcSpR2IVr6tGbGTr0OrTee/6PvXxgqV/4sQePUcwnWe7g+JLNSxw2WvREp1cf2oko1x5t6WnUxsEizljrxu176883zB/inf10RKRSyh/j/UOlBfUp3wlOAyTUNvXL/lScKO724va1NvpL/KxtcsZ7crBRLufKvgPwlS0OvWcqRWhh2PVBSLmi8BbH4nHn+wjs7MfwH1ynqCD7+4ytwTIyFvvxBwcA7MAGiyZs6L3ojq6WC1MWko0FFAt5WO2SHTTgjho0dB06OPwvFq0n0nNjyB4SUFoNn1TfQ9MoNfkpCmrPGrCG5bfunONhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caHXh5ebz8/bO+pvzbOAcLayiN7VPGsV298vKkwXYq8=;
 b=B10u2HHyRt1z/MtDkY0sT7bG/GuDbbj1Xgh9E+CUjYv1VbZ8DBf6kXSWoPxbuH6OhcjiKIXwmmqEOIodm/YwgVDKQrTx8FrZpGSQ+gc5t52H0zAF3fNLnGg4UN3GW2RDALguPp0irDC+L2J3zNX5WAyj+ouSNQ3lz2mW9Qz6XXk=
Received: from CY5PR17CA0032.namprd17.prod.outlook.com (2603:10b6:930:12::28)
 by DM6PR12MB4450.namprd12.prod.outlook.com (2603:10b6:5:28e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Tue, 13 Sep
 2022 14:48:47 +0000
Received: from CY4PEPF0000B8EC.namprd05.prod.outlook.com
 (2603:10b6:930:12:cafe::5f) by CY5PR17CA0032.outlook.office365.com
 (2603:10b6:930:12::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22 via Frontend
 Transport; Tue, 13 Sep 2022 14:48:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8EC.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.12 via Frontend Transport; Tue, 13 Sep 2022 14:48:47 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 09:48:45 -0500
From:   Alex Deucher <alexander.deucher@amd.com>
To:     <amd-gfx@lists.freedesktop.org>, <helgaas@kernel.org>
CC:     <regressions@lists.linux.dev>, <airlied@linux.ie>,
        <linux-pci@vger.kernel.org>, <tseewald@gmail.com>,
        <kai.heng.feng@canonical.com>, <daniel@ffwll.ch>, <sr@denx.de>,
        <m.seyfarth@gmail.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: move nbio ih_doorbell_range() into ih code for vega
Date:   Tue, 13 Sep 2022 10:48:30 -0400
Message-ID: <20220913144832.2784012-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220913144832.2784012-1-alexander.deucher@amd.com>
References: <20220913144832.2784012-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8EC:EE_|DM6PR12MB4450:EE_
X-MS-Office365-Filtering-Correlation-Id: 059a3f69-1dc1-4165-7b69-08da95971041
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: il172b3+KZg+SJI5PEqDAiulW4za58+XwwkdPsHtQ4P4VUabOk4f8sEUluwfUT2TmCTx48p2x6wuXNiObtzCdHeXTbbuaJzJFG7tymYkOiYpCW4qFOEOtD69sXd7E5Zuvs8dpkQtDLW3z/JKV9NSFBS5ih/rsuzypVueNwLDzaJmzs3jX1dQa9iyxSpCpzM6vND05ckqf247l6xenMg9mTeWCN/v8D7M488vqx/uDkOqvU/IoLW4R1plnyU8byZgsgXxgZO5+lU87aKfr4461wO9SpxU+QaQ3QZgxDEmYiC7ozG/S9Am6dvfjfnqYD6CwxNRTGDvbRwdWLiCLBKqf2rSuOmacIF76GVN2fwkhuD8pm/owd2lp7WXfSd9ouSLtt4YAVxSUBHI6+KscHZJ/M92zfBlIh85U7JCuVlMN84o/V3FiIigTO1hHc22aqPM14cWNQjy9tulHL8JMBML5c8DCgpwRXrXCzHa8bFRhWp8++91eMieIhyOcSxQ4PoYWaVK93u6yN+JlrTPPBCYjvB/fH3q5JaIWpWkDeEq/JMpA6KWptF5FjwVkxJjuzbquDq2sag1/BF7fJMWVVfh3yImco5bLVFgH92Is5F9dG7VN9FDCJpiplv8tdENS7xbFDPxfg2FA++bV6rLOyXCM5D9S2fEY6yKaYketGvby0fcA/2ItBwEhlJY2hSUul4wBiAbnfLrT/E7JUXaPy6SOS4Y/M3OFt7FlfSnTRluSJCh2phmWG0Xt4N+BYRookoOWQw6KaUD/8FpxUp5GCXykUhr8Uv9Q4OooZ/99lWpTIn1EoelVm/tGrsJ5TlHGXKl3Q2+4hMUzpL+Ullzu05i3A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199015)(46966006)(40470700004)(36840700001)(356005)(1076003)(186003)(26005)(83380400001)(6666004)(16526019)(336012)(8936002)(426003)(36860700001)(41300700001)(81166007)(86362001)(966005)(478600001)(40460700003)(8676002)(7696005)(2906002)(2616005)(36756003)(47076005)(5660300002)(54906003)(110136005)(7416002)(316002)(82740400003)(4326008)(70586007)(82310400005)(70206006)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 14:48:47.0423
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 059a3f69-1dc1-4165-7b69-08da95971041
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4450
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

This fixes the Unsupported Request error reported through
AER during driver load. The error happens as a write happens
to the remap offset before real remapping is done.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216373

The error was unnoticed before and got visible because of the commit
referenced below. This doesn't fix anything in the commit below, rather
fixes the issue in amdgpu exposed by the commit. The reference is only
to associate this commit with below one so that both go together.

Fixes: 8795e182b02d ("PCI/portdrv: Don't disable AER reporting in get_port_device_capability()")

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c     | 3 ---
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c | 4 ++++
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 5188da87428d..e6a4002fa67d 100644
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

