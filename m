Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7C0781393
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 21:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379674AbjHRTlZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Aug 2023 15:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379715AbjHRTk5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2023 15:40:57 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2048.outbound.protection.outlook.com [40.107.96.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EB2422D;
        Fri, 18 Aug 2023 12:40:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iOMQkXLck4fNyRH7oQ2P4f2Y/wCLMkCu5x817uCQgXllyDfYhcZfIkf2fBUC1PtPlm1GIF5oAMmpmMCUQOFJ5Up9kqkSwsswnynmGmCdNUVbYC9iVsEQGO1oEGa38HkC0RqmsKZtBkYvUMWnqOPT5Mw84LbXAwjybUXBPCt0lskFSyGQLWZc/2Recgc8ZyFMt3Qp7tpnNPuppqyItRDDXpfYHVQASct5xCYu7iLMkJXH/piTIah/2SYUQ7JU5leaka+SjAcriEib+5Uh+qJK1v+FLlh3hNZLk7dP4B/JKAwJXOaAja842WXGxEAmzzMq3/mBf4Irv9PTKAFZCj2MAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xP1wTgpPJf7qJnybftam8oEE8r2YVxmONvPjAQc+B84=;
 b=hkAFHSodnz9PUILYQxS941vEw53kvCIp7lm5/SH8rFBS5eSumEtLDRWO22eE3tQmAtA6a9XhueY13i8QqxS3VIDVbNnNr/nJTjSiXySa99k3s2vHOpixUUunCk/sYLtHqkmrldajuAWWt/FmPz3N067CIKveXEwYde6Hjck+qSbh2QSRULYh5wjO4jHXwAeMfJKCD/s2NsLLhz/T4yOymqyZ21I1GvnOaUwvzZuTmgf+h8+j5i4yyI3U8cCY6PJgQ3Wbj4Q5/Q360/ek3wNHt9kzYf+Rcv3sXmrr3kn90hS+S0mG44aTtoo6CfkLrzOH+ago1/mY+uZCB3D4bm7KoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xP1wTgpPJf7qJnybftam8oEE8r2YVxmONvPjAQc+B84=;
 b=gpqTuY7EnW4CH28aEojeWy4CJ16otyHZT6N0TmFzVr+neV6EefXq27x5/Vmp1fc+i3nWCvM8FLOoAUXUbE95IVRs+3ESKXERZKr54Ls+YfzFSGPi2OoXRjFf7EihyCZSRRzKZO5sQx47W+zpIWw4jcfqnvtJK2eX/HvMUdPm1vk=
Received: from MW4PR03CA0166.namprd03.prod.outlook.com (2603:10b6:303:8d::21)
 by SJ1PR12MB6147.namprd12.prod.outlook.com (2603:10b6:a03:45a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 19:40:48 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:303:8d:cafe::f7) by MW4PR03CA0166.outlook.office365.com
 (2603:10b6:303:8d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Fri, 18 Aug 2023 19:40:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Fri, 18 Aug 2023 19:40:48 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 18 Aug
 2023 14:40:45 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, Iain Lane <iain@orangesquash.org.uk>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v14.c 2/4] PCI: ACPI: Consider non-hotplug bridges for D3 in acpi_pci_bridge_d3()
Date:   Fri, 18 Aug 2023 14:40:25 -0500
Message-ID: <20230818194027.27559-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230818194027.27559-1-mario.limonciello@amd.com>
References: <20230818194027.27559-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|SJ1PR12MB6147:EE_
X-MS-Office365-Filtering-Correlation-Id: dcc04af6-962f-48fb-15cd-08dba02305b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m8EA87LngqI6NHKGztj818Jb90f7lYgxPum+0okHfJWdec0ucwF/UabIIfsTDfZlcuGSiMIsXuDCd2cfdX1rC+jM1+KEs52cmkLVBFBTH5/WlrXfgQMNUf/Ag5va5zWaj9bPjgpRTrebM23PH8VjR/PTQ/eARiI8Xvs7zitYhO4BWATKZoZnt+5urN6OrYjLIccW6T+17YDu35vFFQnDoEEqOc6xcEUjMX6ZVA1YHO6VkUIm8teI4rcfiUlbPc2tcoCclDwkvTSB/r0po5sFs7ivIWXO/8/6NNtvwZ9PrOo6ykmBZxlKvaoquNFAdeHs+Rbj8krzL+H3xoWPrg9t+u1PDPhIrwigzMOFi0ELspHNG9LeRj8maWY44A+xTvX3Ga0qQP68kivWmnKbJHerxu69SI85ZjYPqv3rjh3b77mTYRa+LtqMGtWMAGyVrHf+FVhT4pg59612IKEcbUFapbzaVh27hGwrLzn+QP8gc5IQhHAf8DZNv8jOnfRCD+FIsmD/771zeG50hYiYq8yuS6mf0hMCx0fJojFLtRzhX+Od6NiH49BjB+LU/LfLICxcZoNjvY7Ec+YzuolbV87InRLUmBREoZA1hXjQXiVVwodSPlvC+4UqiZ+vaeLoV0r9gw2RSoI5VMc6w8gzUpoOKcxanOiU01XiIJaSWh1TCw+GI6SK1Wi2Feh05N7YMmiAI/SUMr7zbtEs84zY13s8iExx68k5SUtTLbq0F3fzhg+jDAlA8cCGCFB45zXf63iFfOg5bLjWKcga716jwv01Pg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199024)(186009)(82310400011)(1800799009)(40470700004)(36840700001)(46966006)(36756003)(86362001)(40460700003)(5660300002)(40480700001)(83380400001)(8936002)(8676002)(4326008)(2906002)(41300700001)(26005)(336012)(6666004)(7696005)(36860700001)(16526019)(47076005)(1076003)(44832011)(2616005)(426003)(110136005)(478600001)(81166007)(356005)(70206006)(70586007)(316002)(54906003)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 19:40:48.1416
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc04af6-962f-48fb-15cd-08dba02305b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6147
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

acpi_pci_bridge_d3() only runs on hotplug bridges. Two checks are made
for _S0W and for whether a device is power manageable contingent upon
an ACPI companion being present.

These checks also make sense for non-hotplug bridges, so move the
check for hotplug bridge after the acpi companion checks.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pci/pci-acpi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index b5b65cdfa3b8b..64e6ada024235 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1017,7 +1017,7 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
 	struct acpi_device *adev, *rpadev;
 	const union acpi_object *obj;
 
-	if (acpi_pci_disabled || !dev->is_hotplug_bridge)
+	if (acpi_pci_disabled)
 		return false;
 
 	adev = ACPI_COMPANION(&dev->dev);
@@ -1039,6 +1039,9 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
 			return true;
 	}
 
+	if (!dev->is_hotplug_bridge)
+		return false;
+
 	rpdev = pcie_find_root_port(dev);
 	if (!rpdev)
 		return false;
-- 
2.34.1

