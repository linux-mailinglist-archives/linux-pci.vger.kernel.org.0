Return-Path: <linux-pci+bounces-892-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85540811C5F
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 19:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9674C1C20C31
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 18:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE6859547;
	Wed, 13 Dec 2023 18:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L7Tgag+V"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2073.outbound.protection.outlook.com [40.107.96.73])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A74A7;
	Wed, 13 Dec 2023 10:27:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ShD3zbI9PpZyLKMeUzfzVD+ZwwfoW9HsgK2AklxtypCNNqYCrslJq2JHp8nhOv7iUWnVQ9cXfjRmG4DgDGpC+eBqywWuBOCrVFQMm+ATaDl+F0xsmYQpGYYu+5bbApbRUpm6g+q1H/tKojr39Bm/xWH07gopPbyJS9nfRsO6aZ0sHXVfMz5ZhJ2JvaSvvnfkzvr5G0lecQ8SMecLUxHLoX/IGW9vBqp1hBxp4KzNMLl/5BQGXUJ8OwPcH1R7noKfRxm2buJvIOS8ePRj+fs5XWpkDFageSuz6eK/kfLC+QME4jUbPesyVOr7WJTXvfWH4ZqKJlZ53V5obGaxF+VK0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=edUbeuuX5BsjxuAwGF3ufN/ANXoiMaNzF9x8579BmJw=;
 b=ZxT+i5tp1diUylp0Dg/YKZXs0F1z7mk6pp9sU5+dJ0IPid16ThfF8pQjkCtEU/Hs0eo4mhmRPh9681yHldcDdKrKAdpzpdBQHLwE58S0ag4ee8+ftSi3ytVhF98nUUdyB38CBOgkAY5Yzc9UNaRfhfJszaHTR3B1eFacpnsTQ+6J3qq5qFnmtPxZWvjCPNR7XadR1Eyn7QzAAVRyKWrQpHZZwJh86Q1X9oEjfdpMgsYiQqRT0ISeXh8/sXqAeHDLL0L+INdAHjEAsmZ9MUPWmsvpoTWiodvqrFQ6qos7Lf3sSzaCeqNpMiJITkhj2ZP925GsXwFsRtZqKTY6GNAt0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edUbeuuX5BsjxuAwGF3ufN/ANXoiMaNzF9x8579BmJw=;
 b=L7Tgag+VfzgEm5g+ku9X0YKaVOQOBLEVuwwdO13Hsy5zfEBvSNApHwYgYGS47cwxtWih+UssbqgnGnCgayBIYUCeDOuY+eJM6kteoKXxED9mjaqPA26+qgQdr4ZPCraFlfF2tgB4U7yPGhUTqh7xqa/D7CiKmssrfcPRyjDq3UM=
Received: from BYAPR01CA0011.prod.exchangelabs.com (2603:10b6:a02:80::24) by
 SN7PR12MB7936.namprd12.prod.outlook.com (2603:10b6:806:347::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 18:27:17 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:a02:80:cafe::a) by BYAPR01CA0011.outlook.office365.com
 (2603:10b6:a02:80::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 18:27:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 18:27:17 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 12:27:15 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>, "Rafael J . Wysocki"
	<rjw@rjwysocki.net>
CC: <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>, <mpearson-lenovo@squebb.ca>
Subject: [PATCH 1/2] PCI: Avoid runtime resuming devices if system is shutting down
Date: Wed, 13 Dec 2023 12:26:55 -0600
Message-ID: <20231213182656.6165-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213182656.6165-1-mario.limonciello@amd.com>
References: <20231213182656.6165-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|SN7PR12MB7936:EE_
X-MS-Office365-Filtering-Correlation-Id: cf4fa19b-9f3e-4fc2-38de-08dbfc0922dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	267UzojrTvQd+L4B8HuF6zUmxDEBK5QwYa/TqdrNZvCvMUJt/FVQ1wsU5b9JoOVStyiFAtcjn1duUAOmK2MQwdgtvBVEXfMVSitZUdUJs0AY0enpn2NS2lVP77ZF127Bj1TRpyjeCAFd7qOPaR2abI/tuTh0kdesNgnXh3mowF6r7MW48c1632AgK0Y3lPvDS97tzG7PdlLg4n6Y2WWmYg/0VnOGyGiblP8vlSOKFPrcjIPA2u/kFJkttQB4VTdj/RN2VXQAggWnAb6oRh+fzyWyEGuafig3jfefep2yOgt/Wt+0SO1Say8JGwI83yHIcuRpdZfWazcRws9F+EGpz4Zd1/WUYy2ZyCvGwWbp3F4Vg8ZVKmXpVZuEFQ9mXaim1vhUEQB/twC2DS3Qm51/DkJjIq3gjOBbN86Mod3893QBtIHBDNQJR5v/CvBlI/LR56NMK3WBWUDHBoyXXfL8G16jB+rIvFlSZHINRfqwKTbdXkJV4wU+ytGrKx5+devirLESfiFhQcDBUohnOI9HSA0u+fNCiRZwmUt6FrrT3mLdD9NXj9Fgy1SH4fHjpG08ioHehTZZnKtYrBQK0zTDILnN5qGT3kZnApvtpHhqJ27G1kENFAoDF73UYtbI6VbDVZlbF8CjGXwbG/qig8zwZOTN+256Sd28xY73DVKCTvZ37qdsWSBx+upxvC83Rl8in6LEiozoTiuEqYsSU+XuOMreCzpLBuXQ6tC9uzQ9LYgfZYFVIctts3lx4cOcXpthHEzlnwjG8+DniyGl7zWMOA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(82310400011)(64100799003)(40470700004)(46966006)(36840700001)(83380400001)(2906002)(7696005)(81166007)(41300700001)(356005)(86362001)(478600001)(4744005)(54906003)(426003)(40480700001)(70206006)(82740400003)(70586007)(110136005)(316002)(6666004)(8676002)(8936002)(4326008)(40460700003)(44832011)(36756003)(1076003)(5660300002)(47076005)(36860700001)(16526019)(336012)(2616005)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 18:27:17.1323
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf4fa19b-9f3e-4fc2-38de-08dbfc0922dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7936

When the system is going to S5 resuming devices is unnecessary at
best and may cause problems for power consumption at S5 at worst.

Check the target `system_state` in the pci driver shutdown() callback
and skip the runtime resume step if the system is being powered off.

Cc: mpearson-lenovo@squebb.ca
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pci/pci-driver.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 51ec9e7e784f..5a6f7a786952 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -507,7 +507,9 @@ static void pci_device_shutdown(struct device *dev)
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct pci_driver *drv = pci_dev->driver;
 
-	pm_runtime_resume(dev);
+	/* If system will go to S5, don't wake up PCI devices for shutdown */
+	if (system_state != SYSTEM_POWER_OFF)
+		pm_runtime_resume(dev);
 
 	if (drv && drv->shutdown)
 		drv->shutdown(pci_dev);
-- 
2.34.1


