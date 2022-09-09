Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2275B3D6D
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 18:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbiIIQtD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 12:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbiIIQsi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 12:48:38 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DBC1473B3
        for <linux-pci@vger.kernel.org>; Fri,  9 Sep 2022 09:48:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/SH0sOKWeJOsqfI6n3/0xSDW0mf0pLKTeC9B6f/tCTXoYG2/bMiL1sYhfVnOgP/NdO/EqlssvJT2GZDfEJHEhjXwrYjSiE7gbX5eqLMNLAH/X5jIxtfahxHmsGzi3ml/80Q1FTeTy8wLPjnE5Z9M5L7oKb8C7D76LtQSX/SA0VIdz/AoJtqeUZv8+0hcxyIOpcHQ+J4FN2EWUwMeDMuwelH3ZusZdmtCwXdAvVotaLTWustUAtW5F4NWz7XKTUefkTyN7BPQvRzYqNdBst6TG51AambRxjjwvZdNjC8TxPldIvSyzha7B6siGqObIak6N6xLVFh5wqRsZBO1D/1aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gPUbCP85Jihh116YQLuMOnXfaJRfFnRrpx2C2G6HTgk=;
 b=EMyzxWhubmAYB3HPn4l6rLv52LzuO8bregvvkeBVqmsjelpQqxrIFQ87otxOUdjmbTgKJYxGld31Qm05N/IDNJcMYfPRRf75tpKw8yTvQHuNM84R/2Dp30niYxVytrkGw9Smc06wTEJTaJgjXFa04gXCPFTD63vjoLVuF//GbpAiT1VoIt9/d5LyvoE/2YmicexxNZKYUrhvrcN8MdZsKOdt1r/Up5SWaehD9mff9D4RzXIWclcGzT5nuv/hsg/ovgpEjeS44oJCMSNCJTvO6pPxM+WbZYJf7bVWQxS0ocK5yQXgx9O648ovvEEXk5HDW0rd4SKvJezaPpzjp01VTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPUbCP85Jihh116YQLuMOnXfaJRfFnRrpx2C2G6HTgk=;
 b=4csT5sLMQ5O6SMSs1ET0riMB1mo1kAWcYNutMHOZtEDf6Fk1NXN/o6fmRAGpwsjfzxlML7L2uk5SqeS28qOLkf9dRDVJsF5/pNJmbAPg+n/o35gV3JeGnUP14vJ6jgns/Tl4rLLpLmPsL90CbHsa8a2Sih7utkX94tdaAIo9h9Y=
Received: from BN9PR03CA0123.namprd03.prod.outlook.com (2603:10b6:408:fe::8)
 by BN9PR12MB5116.namprd12.prod.outlook.com (2603:10b6:408:119::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Fri, 9 Sep
 2022 16:48:15 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::b2) by BN9PR03CA0123.outlook.office365.com
 (2603:10b6:408:fe::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.15 via Frontend
 Transport; Fri, 9 Sep 2022 16:48:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Fri, 9 Sep 2022 16:48:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 9 Sep
 2022 11:48:13 -0500
From:   Alex Deucher <alexander.deucher@amd.com>
To:     <amd-gfx@lists.freedesktop.org>, <helgaas@kernel.org>
CC:     <regressions@lists.linux.dev>, <airlied@linux.ie>,
        <linux-pci@vger.kernel.org>, <tseewald@gmail.com>,
        <kai.heng.feng@canonical.com>, <daniel@ffwll.ch>, <sr@denx.de>,
        <m.seyfarth@gmail.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/7] drm/amdgpu: move nbio remap_hdp_registers() to gmc11 code
Date:   Fri, 9 Sep 2022 12:47:54 -0400
Message-ID: <20220909164758.5632-4-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT056:EE_|BN9PR12MB5116:EE_
X-MS-Office365-Filtering-Correlation-Id: af39a629-b4a8-4b59-f196-08da928316ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +q3avOmJFxUkSEWWqv5euylhS1KeEnurIde8Sy/A7V/PRtU4RM9Qf8QxMKkXYRyE1WvyMp2N/mo4bvBbxTN90mjT6OUCaPdjLWYMs5V2tTvfI2WhHnojlMgjZxedvQZmp+du5U/yquKIxqSmxcVlGFx0STOEAfEFJRj48DLJjBtni0o7fcNzRO9TbJYwo2Pp0m5h5dUgU0o/s7mDzBf2P40tIlwQbTcw9Tig0ZZ/9cVYAkKW6lN1pKu50wXgIHvYBUPA0lhT1wlXoyZ8klBOyqJuIApAkF14xR1YpzAjJOHMh8BkajyRSxVg+vHTy1ZtTsdNVbw/57zoHqE+NL9qCJg/0ANyCNSfPIFqidi72yc/D4CCtDhBvPrLZl6V0RyoMpgrq8OYCckIESv9L8VaZVcoE2mtAZQ2psrnGMdHq+W4p1rnR8+agxkSS9GWs6rRrVkX55waNgap2ot97SKW+J9R/dqvtKWlolyB+LH7bLjDcRwFB6F9G0/OE5mfOaQvpOFBD4NJXJkZzlPzVcR98fBhbQR99vU3Lrgqt3pdzF7tV6EIiiNOsxwMnwW4pLvp1KCaqMGvxkvqN+wfuv66WttCsFdFWC6YtXpwu7/TQqTD6PCX+OzabjiEcA+opFLL+H3VxMoahIvA4LsPNWwpV7KN3e6evWYNBomEspPJepxlXq7g99cAAAahgRbKqWFAi6JWFs9se2cO5u9ggpX2gVZ90EQMxKN+NAaP6ybKcFZdcL+RTWFiJsFc25uWZMGJu2hzaSJz7L6XHAddGmNnfpIDBv4O77GPwFcaGdu/b66+zm1UKyaM1uG76AXIu/H1MQvxcqleS8LHNcj9FqQxTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(396003)(39860400002)(346002)(36840700001)(40470700004)(46966006)(36756003)(82740400003)(4326008)(8676002)(70206006)(70586007)(36860700001)(81166007)(86362001)(356005)(16526019)(83380400001)(47076005)(426003)(26005)(7696005)(6666004)(966005)(41300700001)(2616005)(478600001)(40480700001)(82310400005)(316002)(54906003)(40460700003)(110136005)(2906002)(1076003)(336012)(5660300002)(186003)(8936002)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 16:48:14.8694
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af39a629-b4a8-4b59-f196-08da928316ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5116
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is where it is used, so move it into gmc init so
that it will always be initialized in the right order.
We already do this for other nbio and hdp callbacks so
it's consistent with what we do on other IPs.

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
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/soc21.c     | 6 ------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 846ccb6cf07d..b0df27fea648 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -891,6 +891,13 @@ static int gmc_v11_0_hw_init(void *handle)
 	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	/* remap HDP registers to a hole in mmio space,
+	 * for the purpose of expose those registers
+	 * to process space
+	 */
+	if (adev->nbio.funcs->remap_hdp_registers)
+		adev->nbio.funcs->remap_hdp_registers(adev);
+
 	/* The sequence of these two function calls matters.*/
 	gmc_v11_0_init_golden_registers(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index a26c5723c46e..4dbcc2b4fda0 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -677,12 +677,6 @@ static int soc21_common_hw_init(void *handle)
 	soc21_program_aspm(adev);
 	/* setup nbio registers */
 	adev->nbio.funcs->init_registers(adev);
-	/* remap HDP registers to a hole in mmio space,
-	 * for the purpose of expose those registers
-	 * to process space
-	 */
-	if (adev->nbio.funcs->remap_hdp_registers)
-		adev->nbio.funcs->remap_hdp_registers(adev);
 	/* enable the doorbell aperture */
 	soc21_enable_doorbell_aperture(adev, true);
 
-- 
2.37.2

