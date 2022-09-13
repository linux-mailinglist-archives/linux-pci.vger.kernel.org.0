Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD325B75D1
	for <lists+linux-pci@lfdr.de>; Tue, 13 Sep 2022 17:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbiIMP4Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Sep 2022 11:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234004AbiIMPzz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2022 11:55:55 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20600.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8C08F96D
        for <linux-pci@vger.kernel.org>; Tue, 13 Sep 2022 07:55:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ldpvt2fOj7Q3RkIgu7QjL4XV+AtazUN+BlJCYhWy5jwtV02+X8IOHCq/85smATtSnPcgj1R4KCyb/LpU3RSkY/SMIzCHLp9ZEF2T89d4R/6n9g0J/BbR6WhCjeEE7FXfNGqafMoeQ8kcVyX4KAVz9K5CwtrTToxck7bLilG5WVBFmyFXNEwQBqmsDi+Xn5zEDLh7TF9EtgSwX7D+6yzO9amG18okAtsUPQvq6mu/e33t0z4S0Ee1RNLsDNjDfGRnfRm/sbcnDzIjbi1lFOumB7QI620S75hlwnhBcrUOfoKJHI5yG8kAdRwrUMI5uoHdLgt48oz+thWBbXCYBD+avA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+aOJ5fsxzKsK1fwilkXlSKKVhrW7JIav/BFrOJFaT4g=;
 b=j82D4vF5rY7NWfdV87aGKTl8IsLwOiJtVaIFlSuYQx2szjWniR8e+FzmzzLUqFI460y5vG0yXcdZ0IOH50Ul7hS4M28tBFmRPuSL0Zia8RsxVV0U6lTJepa36IjZI3yWAQaSQ+josx8YRLVhNkuoYPYbYuhKNGjsNtShLyAHQv/XBPRsWu5HHcnJa/f9EDG+YAZZDqiExiFpkGZUk/ei729SvNNe5yx9R7sw4oMnGRrK46SjDL7MEeTUtu3CVP4uviMPWghWbTDo+H5NyilTIxHPes30+AXpb4XMJl6BW3EVYkf/UW7/JoXjHZH2UuACbdhfjnpjabOuetlwpB56jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+aOJ5fsxzKsK1fwilkXlSKKVhrW7JIav/BFrOJFaT4g=;
 b=TktlHIswYjmx1/LKRrkVwVG1Ujtw3i25voHblSaAD4XB7p4PT3uzc9A5UIloOzc8tWezTfNewKiFPUCq8nqlqcgJ1/OEB4t/lftZD+B+yVQGLNGpRv98itxEv9Hw0BrywPm2B05lE6adqYNHVNGLmH2WNgfI+l2+Btk0VvJ10G4=
Received: from CY5PR17CA0032.namprd17.prod.outlook.com (2603:10b6:930:12::28)
 by PH7PR12MB6720.namprd12.prod.outlook.com (2603:10b6:510:1b3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 13 Sep
 2022 14:48:46 +0000
Received: from CY4PEPF0000B8EC.namprd05.prod.outlook.com
 (2603:10b6:930:12:cafe::5f) by CY5PR17CA0032.outlook.office365.com
 (2603:10b6:930:12::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22 via Frontend
 Transport; Tue, 13 Sep 2022 14:48:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8EC.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.12 via Frontend Transport; Tue, 13 Sep 2022 14:48:46 +0000
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
Subject: [PATCH v3 0/3] fix PCI AER issues
Date:   Tue, 13 Sep 2022 10:48:29 -0400
Message-ID: <20220913144832.2784012-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8EC:EE_|PH7PR12MB6720:EE_
X-MS-Office365-Filtering-Correlation-Id: 933c1708-64f1-46be-f3bb-08da95970fda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: alCtVlx6JL4MJKYDgu3uu5++8gwccD1thmJ8a8QyQ+C0x4hVEAdvL/CAnlEXmvHiB1SsdkGtYZXiC1xhOqXMwt6ld08X7nwqRjkxz2z9GAZicb6zJ1W9lfmilM4eN9QxOA6SHCcLbZBy/Ze2INfzPyMCu+CQAvcjeBjy7EjoR0lgw9VqKza1rIHEkGVWvp84oEbM5mShW4X0wvNZd8kz9fqGbu2QyvCWaRAd1wRgcqQ3gZLDPU2ACfEiG7+GLV8pJEkR1vwydkKpYQX0TghMQVi25wvUYTTD/TyC+G73JAIcmFgVmdpFLaYg0XbYXej1swpL7BQXsf42vHGNk3mEQJ1DcUjoBvmk2XQq89WR9hU7Ho6uOJsAiN28kL9vZuK7fCUN2ib5HLDCTreLI/UTJoqh71hLaVtxx1H6rqsqbavrr9Ltq1wl0TOXyHVqKr1LWycMyNPOzYW9k6d6SKkF3Rd7SxIQKvICBOsUwKxv2ZmSEJiphLScWV7Ben8YTb6hVrwPhIAPdt7R5p2J3bzDv8Wh367pvi5LKwKWCeR86a54WYwNrf5JRHIg9/p8Vt9Qa432PhxfGNdYfC4rvQ1DWTa28tOhcLWnHpjUhv12iciwu+bxi2jLgjZiBp/hZBE7JQAUSo3aJWgciKTJP72jok5kA687SSpCTC1i4OG9KGnWVrf5leJWl+VQsMkQ675tmWMNinL5hIrDQHsaS9QVNGlC8kBfiXSR1hcz8hNWEOSVmhVD5JPyR8sJ76p5hwhnYJD2V6pOX3CabSJU+tf00p6Pxth9jIYI6lHl8lWQgibhekXQ+0UNMEA4xcPgJDaX
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(4326008)(336012)(2906002)(36860700001)(36756003)(47076005)(110136005)(40480700001)(478600001)(70206006)(86362001)(83380400001)(40460700003)(7696005)(4744005)(82740400003)(26005)(6666004)(54906003)(316002)(1076003)(82310400005)(41300700001)(186003)(81166007)(5660300002)(356005)(7416002)(8676002)(16526019)(426003)(70586007)(8936002)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 14:48:46.3704
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 933c1708-64f1-46be-f3bb-08da95970fda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6720
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The first two patches fix ordering issues with the doorbells so
that the doorbell structures are initialized before the we program
them.  The last patch fixes the PCI AER errors by moving common hw
init before GMC hw init so that the HDP register is remapped before
it is used preventing a write to a non-existent register.

Drop the HDP remap in GMC init patches as per discussions with Lijo.

Alex Deucher (3):
  drm/amdgpu: move nbio ih_doorbell_range() into ih code for vega
  drm/amdgpu: move nbio sdma_doorbell_range() into sdma code for vega
  drm/amdgpu: make sure to init common IP before gmc

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 14 +++++++++---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c     |  5 +++++
 drivers/gpu/drm/amd/amdgpu/soc15.c         | 25 ----------------------
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c     |  4 ++++
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c     |  4 ++++
 5 files changed, 24 insertions(+), 28 deletions(-)

-- 
2.37.2

