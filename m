Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801F37BA720
	for <lists+linux-pci@lfdr.de>; Thu,  5 Oct 2023 18:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjJEQum (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Oct 2023 12:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbjJEQtY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Oct 2023 12:49:24 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9B01FE3;
        Thu,  5 Oct 2023 09:42:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AkbgIy1AlsVPGa33BXORZjnVO6+SJ8RVtXjbZ9UWeq6vFGpxExVrWm2SmQHluflds1JkAtBW56WLGWrve39zUVrFOTnB5TvOKNChqiRpzxGqYhDFxMk5GV5fGYfloyBG9vEeETjsusK9fb4rr9+dTZvqKxurUq7Mr6BSzNS80jD5R9AFZDH3KiLFGaLWNqOBG/2e6qXF5MMy2FzoeTvcR+oYCj/OE95isOCK0vB8t1/rIY50JUpGqe1kThJSECd5vow9PGio69UJiik/4L6Xw/oGT0YA0LB00+tW9s4T2+yIkE65ZOS+xHKpZE+oc2P68k5H9QEH/T9pkyIDwsHK2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBJZOK/3Sd/hkz9852w+GyNxaltQ9eMs0gDMLPobpgA=;
 b=nJHSqq2TdFEkEz/7JTo7YS8I8N60c2hRjah8CR6QZx/w1ZSiNXuwPuGQAtpeu4C/bXaSGwP79xCjec1KJA2tfcWqnNqKAhw6wliUTUtK/JbxN4roTopwu0nSx/krQA6zQkD+0OxetQJvgMpZkRZBSVJk+FkMmfDNt1ErAUabn4Yws2QRcMt4RQe5aUaJJ241cHtqQQDo3O25G9/YRAU+gEwbQuSMZ6WexYCAWTEo2B6eGOGjzVKZ3osAgHmOqRejHD4CkmGHvWNAoryam5Wvu3Z8pfYQfaayMGa4cuuuzyyAZtyUB5EMcffh4hOv7eo09/gaMXVzScBwALR5z8Vy6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBJZOK/3Sd/hkz9852w+GyNxaltQ9eMs0gDMLPobpgA=;
 b=p2GpoHoAUWk0VOrFCmGm6xWabUtXbCjTQFlie0ap3CkUJrZkL3DrUcArsex3BMhrmwWjnxmsJ7Kl4xDihp0TBe6U8Xuvgu6BCyKJSl2RKE4orfkTXC7bBW7Ax7q+TaVpyKobAzg3TetI6TFJHdkoqHc4A8t168t0jU8ecqe0SkE=
Received: from CH0PR04CA0109.namprd04.prod.outlook.com (2603:10b6:610:75::24)
 by IA1PR12MB7566.namprd12.prod.outlook.com (2603:10b6:208:42e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.24; Thu, 5 Oct
 2023 16:42:08 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:610:75:cafe::39) by CH0PR04CA0109.outlook.office365.com
 (2603:10b6:610:75::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.29 via Frontend
 Transport; Thu, 5 Oct 2023 16:42:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.76) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 5 Oct 2023 16:42:07 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 5 Oct
 2023 11:42:07 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 5 Oct
 2023 09:42:06 -0700
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 5 Oct 2023 11:42:03 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <michal.simek@amd.com>,
        <bharat.kumar.gogada@amd.com>,
        Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Subject: [PATCH v5 RESEND 4/4] PCI: xilinx-nwl: Increase ECAM size to accommodate 256 buses
Date:   Thu, 5 Oct 2023 22:10:51 +0530
Message-ID: <20231005164051.984254-5-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231005164051.984254-1-thippeswamy.havalige@amd.com>
References: <20231005164051.984254-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|IA1PR12MB7566:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c90cb71-aaed-4b09-56b7-08dbc5c203cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9or5TypMO1/wkJGnRZopMkM4ubMavyraMdKunyT4VCs0jMZa1+r19CUhq77IkTBg4xcFKLT8bCLOnPSLbCj6IJPMcdnR7XylOLAfx2f/pPHOVm7RFNJxBVLfG5CGJi/5t5kYYU1NiHDOisXAbQ/X2ioqfcx832u5SgV6ELJi0lmCU0iiKdqi1BAfv8waXyTZnL0FpcuW1thKu2noxQzxHLURern9qTzuPl7dS4N+q/JVKVYw6xf5m2fgTWrbKPPEHp99XT1DP5yR73kmSaM2n6qbvyns6D4+Gh2VjBAlGarmPkU0SLCn5pGTEkPCGLbbFW9Xma43SmSIz1JprPfX9OTSPrjj8EXV+teYjD4H3ub6nczLMk/4p2PoTkUkHi48XWj2D8G4GDY7FHJdxtxA3U6rj5wYluVogjLFpRFWQTFicTj+1wIxo7ODBPrxS79cf/shi1+Qh/CHwPsMzkRtuUFQcigJhC7PPBBodkdpBueTDgXnMXFviMnqac9N5+xVitEfwoTMuN03y1fJC9FyoEzlqEqqG6gWIIHpRIvpBQUfQ1FJCCRtzw1pF3y1OX9LrENZL6JZ5pcKE7S7Q8puX8P47jk75wbt3+JI3SMfsexc0aX209ik6ApNOOB7ca/afWwhiMBejGchocGDOICMIxdBiLAje/ooHTHaijpkaHP/aBS7VYGlMo25vIQa1KV3EPJkGWNY5GlXN0SgcFGeSPoFV5dVAzOhv3knz6YnEOQTta86EdbfbvUBFqNsgmCXdNeB644MloLnBppfe6rqHfb+XY3dTuLIJuNIEmwXJL0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(1800799009)(186009)(451199024)(82310400011)(64100799003)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(2906002)(316002)(26005)(54906003)(426003)(83380400001)(44832011)(7416002)(1076003)(478600001)(336012)(2616005)(5660300002)(4326008)(70206006)(8676002)(6666004)(110136005)(47076005)(70586007)(8936002)(356005)(36860700001)(86362001)(4744005)(81166007)(41300700001)(36756003)(82740400003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 16:42:07.9429
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c90cb71-aaed-4b09-56b7-08dbc5c203cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7566
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Our controller is expecting ECAM size to be programmed by software. By
programming "NWL_ECAM_VALUE_DEFAULT  12" controller can access up to 16MB
ECAM region which is used to detect 16 buses, so by updating
"NWL_ECAM_VALUE_DEFAULT" to 16 so that controller can access up to 256MB
ECAM region to detect 256 buses.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
---
changes in v5:
None.
---
 drivers/pci/controller/pcie-xilinx-nwl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index 8fe0e8a325b0..e307aceba5c9 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -126,7 +126,7 @@
 #define E_ECAM_CR_ENABLE		BIT(0)
 #define E_ECAM_SIZE_LOC			GENMASK(20, 16)
 #define E_ECAM_SIZE_SHIFT		16
-#define NWL_ECAM_MAX_SIZE		12
+#define NWL_ECAM_MAX_SIZE		16
 
 #define CFG_DMA_REG_BAR			GENMASK(2, 0)
 #define CFG_PCIE_CACHE			GENMASK(7, 0)
-- 
2.25.1

