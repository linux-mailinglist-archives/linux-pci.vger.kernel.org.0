Return-Path: <linux-pci+bounces-396-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE80802B97
	for <lists+linux-pci@lfdr.de>; Mon,  4 Dec 2023 07:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9645E280CBF
	for <lists+linux-pci@lfdr.de>; Mon,  4 Dec 2023 06:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156969469;
	Mon,  4 Dec 2023 06:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R0NULRZ7"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD7F9D;
	Sun,  3 Dec 2023 22:07:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZhbgJ2AT0tVmZou03nfjSA8KU9AV8tHQ7n76DbqTZxy8Twu+3njPR0iGpYNKRvc3itWorEme10snRIpgd6F69bvHrTdAmNhl2adJyaIKYopZU01eAyPRB/4tlOVzDopGFyAJK+l0e/LA+9iQ/1Mv8pibMjd3ZC9FahqtCmizSmKVHiq8em6czx9dowS1dwDm7CnA1NpXQPSkvtdglRUFThMa/1zMl869Wb3c2sP4ArjGfF3d47csZIo43FUA2IVdbxDBJjUfQulgcukW5EPqbbQhD5LkFpxQp3HdmAuOWybIzS847lVbnoOZ4eF39b1UiXXJ6Wq8bv9KqHM0ZP1xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aMjSSbupzvoxjDig1dmQa569JQeqhDQqP3CXEyZFiSA=;
 b=KG1MYCpWr0xTKMnTMAyYZLbQeWxJK4IDwb6opm4woKvbjDn9+O0F+OJ7bgV2OVcexHP4LOHXRhCtkKbLqKgBr4ik/MLkNYW1SGZHbyKeQ3frkPCeA1iK9Ruekiek+RvBIZOaThSdg0nrrH7tqE0SqSZGkwY1w447dzGNT06NEzLdoHOqQnwID1J6AzUQ4GGD++goXbmZ4VDI0yVUp+aQL/PY2kV/zJM8j46OFynaxMbZ8MWZlPY+7696zXLVyxxiJGOr0y0dmfGBI7h4vb+CUThpIH1MDNDi9sRneJBVEGxMdoysw2FoL76Zli8OHr+1jMQQdP5/KsAJ8uLVEljI5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMjSSbupzvoxjDig1dmQa569JQeqhDQqP3CXEyZFiSA=;
 b=R0NULRZ7pv682EsnQswNpva74VDv9nVuuio+vdSa2S9UmyL8AxqN4b4+x2znKBBPRUA4H4fqiL9gI203U9WjJvaEl2wvE7IsbG3/UmBOjvHHXOm9wbwTN/I8fxt4/w4zaQuWsyZeUdAcxWVsxxEdv8eZREghMOtMoLvm9whV+mw=
Received: from SJ0PR03CA0347.namprd03.prod.outlook.com (2603:10b6:a03:39c::22)
 by IA0PR12MB7697.namprd12.prod.outlook.com (2603:10b6:208:433::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 06:06:59 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:39c:cafe::83) by SJ0PR03CA0347.outlook.office365.com
 (2603:10b6:a03:39c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33 via Frontend
 Transport; Mon, 4 Dec 2023 06:06:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Mon, 4 Dec 2023 06:06:58 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 4 Dec
 2023 00:06:20 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Hans de Goede
	<hdegoede@redhat.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, "open
 list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, "open list:X86 PLATFORM
 DRIVERS" <platform-driver-x86@vger.kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, "Lukas
 Wunner" <lukas@wunner.de>, Kai-Heng Feng <kai.heng.feng@canonical.com>,
	<linux-acpi@vger.kernel.org>, <linux-pm@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v2 3/4] ACPI: x86: s2idle: Export symbol for fetching constraints for module use
Date: Sat, 2 Dec 2023 22:10:45 -0600
Message-ID: <20231203041046.38655-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231203041046.38655-1-mario.limonciello@amd.com>
References: <20231203041046.38655-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|IA0PR12MB7697:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e724774-8ed4-464e-10d3-08dbf48f39ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FmWIkH+7/Nrg5GD3LFThSYml4shtbgmYo2ppzg488KQDnUCcwUdfyAwNiReOg6WYzes8OHBTz1Rcd57m+tZdrpemGd6JlMrwn6xGODg41LycpuWanIyUZkvybjZsC5pHyQdmjA7tyZ0my1ZuV8wu1t3LYI8t+kpsGqlyg599Xzl2IQ2gRRYLB/BeTyMSWP4MI9Q0aiPqYKxaL4LInnnK3XC6GUfXgD29+sT135dlKNo4mh93py5PpXPUahMq8m6qdQrtJ1gHg0/G9vGNX/irkSsYzviWY4Tkjc0I4BrMIWr/XWeaNdXzYLoZg2UUEHJsRAH2TauN88wgwu/Lo4Cu+749s6K75tnAGHDeCiSj39iK0T36igobcM7zVwapDhmTC6BV+m0Gt6Ex49bdcQBPsuGi9h/XjEbCsPSJIHO9CztFTRx7ozMpBFBBwuHQ6eyGKjnDEaxqrPzjXK0FHWBBdLzLAWfzS/llIqRbNUX/ZzCkYTfYK3Y9vEWQFH6Kq0O+HIPipC8uFDH49gtmfn2xi8gjmLgDW54PDTSjbPqDlKII1gQbNgmDNSu8/fLQ/KF2fwlY9UxUcsM6sgSjTT8D0HHAqMgwKesd/dvoAjfKQkO7EDTI6IQKDstGAAVgUPs+2geLMfP0p27Xd/4RRgs/DhafZQMOug3pbUnhOqpDQ2rbJYzzyIusnSuAJDqXCMIig+Y3G+eiyQOP0mSsIe/s5li6MuKyn5sDmUeLfaq7ULb/BVjMcd/MMRpgESaqdYdswiqy1ckyO+4vFPfgtoEeYQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(396003)(376002)(230922051799003)(1800799012)(64100799003)(82310400011)(186009)(451199024)(40470700004)(46966006)(36840700001)(54906003)(6916009)(70586007)(70206006)(4326008)(8676002)(8936002)(316002)(478600001)(40460700003)(6666004)(7416002)(4744005)(5660300002)(36756003)(41300700001)(2906002)(86362001)(44832011)(40480700001)(81166007)(47076005)(356005)(82740400003)(426003)(83380400001)(16526019)(2616005)(26005)(336012)(1076003)(36860700001)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 06:06:58.8695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e724774-8ed4-464e-10d3-08dbf48f39ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7697
X-Spam-Level: *

The amd-pmc driver will be fetching constraints to make decisions at
suspend time. This driver can be compiled as a module, so export the
symbol for when it is a module.

Acked-by: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/x86/s2idle.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 7d64e655f1b8..427d5a8fb694 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -322,6 +322,7 @@ int acpi_get_lps0_constraint(struct acpi_device *adev)
 
 	return ACPI_STATE_UNKNOWN;
 }
+EXPORT_SYMBOL_GPL(acpi_get_lps0_constraint);
 
 static void lpi_check_constraints(void)
 {
-- 
2.34.1


