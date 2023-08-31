Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4BC78F277
	for <lists+linux-pci@lfdr.de>; Thu, 31 Aug 2023 20:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346953AbjHaSU4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Aug 2023 14:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346889AbjHaSU4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Aug 2023 14:20:56 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95ED910CA;
        Thu, 31 Aug 2023 11:20:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lirBYTiE4u7GTTNhVgmnt/AWWJTpJ7WlndS7YGNnPUNMq9WXEafvfNzTajJLU3jXTcWGTAiOfC1Hz4yg0rwAb7+P5+KCWQJbGqqOWt8qutNLZxmHfz0Qzm3lvS8FLP9UTlvrk45gM8Qb5Klbk2qmj1sDYGWwikkmpxGnQ4FhKxeIOScnHZcgd9UHgUxRDReXf2qmX06fMQl6ry9i0/+rTdIxTLnR4Fr3/bb8P8O3iry/CgJnz7ZDe3zOuJAITLiJhkDHNPT458VHXiqt5y56glee/i5gQFuGc9R7AtvnJP2EsK77VmmPzJrPYLMupGf8kAYcAfPETlWgH6W+7Y2m9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1x8wDm5DEd6z3A9E50K3HPDixJVjeCChlfCgpmUn/6A=;
 b=NdOVqPsefkRBvQsJF1PJiyp1fwbFayc19yAlE1yPx7WD5h1FrhcAJAZTrgXra2QewgYXb+q+wa4y5hLlCqyGddPxGtcrgk5mZGRtlB51fbLHv2uGGEaWljXdN4qpIYhiGz/8G6iQh6tDgRNWi8OGtLt94wYpOyzJdBTBQp6O+/h45EeATN+nVyK7L6UCBEOH7SOU1ahOm8CTmbxN3ejijj2z/THO8LGTk79zQzuwcXipa0IE/7hbIgxU8hsQBO5jpHfPl+/SMsnsqDEPDPmpoSmjDEfTx5fEScXtjRLL4y4wig6X9hFKQG80m+KgOSZwhUNZvxfZkluZGg5A53jIZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1x8wDm5DEd6z3A9E50K3HPDixJVjeCChlfCgpmUn/6A=;
 b=ylU68RQ9AamBkH1tMvjjZOOLqGDnAjOt7ma0/nrx6ojudNeIFvqM7pZ8kYxu5ar6TKDe3jjA7yFjQzBfb+4hTt+8x5/BnziXc0Em/9cZRQoQ1rM+TYQPstfn8ZeLr/FTK/koITJLZ8/iQwsfVBVmxVV9qZ8DFuSYR4iV6d2Q9gY=
Received: from DM6PR13CA0045.namprd13.prod.outlook.com (2603:10b6:5:134::22)
 by DM3PR12MB9352.namprd12.prod.outlook.com (2603:10b6:0:4a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Thu, 31 Aug
 2023 18:20:36 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:134:cafe::2d) by DM6PR13CA0045.outlook.office365.com
 (2603:10b6:5:134::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.12 via Frontend
 Transport; Thu, 31 Aug 2023 18:20:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.20 via Frontend Transport; Thu, 31 Aug 2023 18:20:36 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 13:20:22 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 13:20:22 -0500
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 31 Aug 2023 13:20:22 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <groeck7@gmail.com>, <robh@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: [PATCH] PCI: Fix CONFIG_PCI_DYNAMIC_OF_NODES kconfig dependencies
Date:   Thu, 31 Aug 2023 11:19:07 -0700
Message-ID: <1693505947-29786-1-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|DM3PR12MB9352:EE_
X-MS-Office365-Filtering-Correlation-Id: e049d826-470f-4104-9e58-08dbaa4ef8f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +N1HTOgd2wXPaKzk8bm61OFITjg0sZu9bXtc1hlPzaSmzOjwHx/5JupHr4ERMlz0Vp5jr8eKtc/NtyKcQ3AMH6dHGufwdMkMXZSGM0MGKY6lnZE3lxFT8nzzOk0TVJPBgDEYPp9DEoLZn6qIzPTAsOBEAhXJqQUe1kA2p9+TrUEqNjkwgS1+iH0nsJ5ISBbEEHRli/UIYOnq31f61SN6Id70AOvhlx2xUT4JXL1B46kNAozekU9GTAZj5W57Q7WM6KXoJcHXOTZpsTa79dsFI2deYQnu9jPV5bznmVR8d1NLIhrXUROLXCap/wgLqiQLxhKyeFigWc/FNLf6ujhyRlG8/nMg8zYistH6nZtDfj67iZcbXQxAyAf4u78xR8mHGo6ZICCkXTWiBWh5sgr5fY2wtOTwcsW93xuJiAjJPLVreyLnD+hUyZmjygNCjfxcXAbKvNWBWG0rjoSQO/zzsTX1b5VQ5yzKsnFVEOktYKVLDVqYanKwYncu4I5Wzi0WFm2RkrvyJyHKlCuhonTamXOdHmWJD/uk4/8Vgw6gnBt89TyGOAsK/nvvc5+T5hKpUPoX98p2wYW2msCY84axvCgvvN5WrY1hj9BXOTo4Uu+Xrp5zidxAt5OOsZDHdH8IyeQsK/Fob3TFeDONL7wcMmQ61ifRfwIZlXGYeVo8QE3tFVVlLI0Z3uJ49T2rqVbfTamj8pM4Xpbs4+imNSeGP7sFuvVDCSdXxAgVKvV2YQqM0TEFQp1y92RitUb3xY52JL75T23/vrsxhGdnbVMX2A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(39860400002)(376002)(186009)(82310400011)(1800799009)(451199024)(40470700004)(36840700001)(46966006)(966005)(41300700001)(336012)(2616005)(6666004)(81166007)(40460700003)(82740400003)(478600001)(47076005)(356005)(86362001)(36860700001)(26005)(426003)(4744005)(40480700001)(70206006)(70586007)(36756003)(110136005)(54906003)(316002)(2906002)(5660300002)(83380400001)(4326008)(8676002)(8936002)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 18:20:36.3031
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e049d826-470f-4104-9e58-08dbaa4ef8f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9352
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Generating interrupt-map property depends on of_irq_parse_raw() which
is enabled by CONFIG_OF_IRQ. Change CONFIG_PCI_DYNAMIC_OF_NODES
dependency from CONFIG_OF to CONFIG_OF_IRQ.

Reported-by: Guenter Roeck <groeck7@gmail.com>
Closes: https://lore.kernel.org/linux-devicetree/2187619d-55bc-41bb-bbb4-6059399db997@roeck-us.net/
Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/pci/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 49bd09c7dd0a..e9ae66cc4189 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -196,7 +196,7 @@ config PCI_HYPERV
 
 config PCI_DYNAMIC_OF_NODES
 	bool "Create Device tree nodes for PCI devices"
-	depends on OF
+	depends on OF_IRQ
 	select OF_DYNAMIC
 	help
 	  This option enables support for generating device tree nodes for some
-- 
2.34.1

