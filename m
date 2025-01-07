Return-Path: <linux-pci+bounces-19463-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B685DA04C38
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 23:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A14DA166439
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 22:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6041E0499;
	Tue,  7 Jan 2025 22:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ccBSGncQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2080.outbound.protection.outlook.com [40.107.101.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A1E1B532F;
	Tue,  7 Jan 2025 22:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736288945; cv=fail; b=Blkg6dSWgmDHbY3DKoEtAHWJhCC7N8HF0Z2sCUOEDLU1gm8VN47eKVlNStXvvfu0iiR2XEja0bChAJcRuylUfYrtA67GaY6tIiuFLUxHLJsCB/kKlWLUM0h/Y2QJ5hqNYMZxa7Z8enJ0+OI89wlZlLx1d9ELcEVK6fSSobulBwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736288945; c=relaxed/simple;
	bh=KlFb3T4iHGcqNYNybljoCHqq7LWLDOKVmq3zJ6Tfi5s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QAFCq0iiDxN6ZOTM89yz5Iw3F27WDUEzuL4ZumOF/8mdJQFPj386/dylXdJ3PfXAwvk8QQqtThh54ksixBi0TNRNG5SN8ETSEK3PwU57uszjagMT6cZ6rxdn5otBJt/JHs9T8Lk5jJh4EdKFhgsMnv4S/EJyg0zec9/AprDOJ80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ccBSGncQ; arc=fail smtp.client-ip=40.107.101.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ah9hmmwSnQ72gkEUS0zDQrC0aDhQ97e309wxnsJ/H7nRJ4ZpUersdouMvSfKzsU1N6Qpxpqa894+dl6/jUVOr7Kcrt+iFbvOFhwhq+guXI2O6XcnBfeD8+yJOwEac6Gvz7AKzrWagwOaDCuTAvdQYdLboW8wgKOw2Y5RngstS8nShg4RjFZ2FPEFuevmqevmYr9tvdEmMQ5dP5at1CqaDhJtcjTeJdLJGqgmBL8iBwVsiA3F2/PeA9SvgcW0xfK443gPnwqpgixls6wty1eeJWgLFu00kEoalSol2KOusECl+imzuOgJH1kF38R7G2TEiQQ8KkE6N/F4WKZ562oTGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6dJF1/Af8VE7ztbYXFF7ZsnwAB1bw0Ia8lvPnm6sUdk=;
 b=HbWMDbYs8vR6mh4gBpfnCw/4VelCXInCeF8dWi6i12e3Q7vcwoPzmTzrCxPDoZYpoyjQJbWoNvjRIN+cFUfa13UspUqwGvpIY1TKlsKKiqcC9x4zZFzqN00mJxNZKxX+1pfOiZjy2/Ji85z4ONK0kHCly7zp/h3uPCz4V40siHQu0theJzXxP7MoQdLZ7Gjn3e+lNoPWPskfL5Gp4EXwBanG1OsFs3VVCPNAIpkq0CH456IWXrGT+YqeDTxZnjSL8mmVG9ptEMrhyciqSuE0rFWI63Fs5PVcQNEudQA7av5IAJM8r5yQ9TW+CATG/ICwBSMWBk0cdvcVGMj2V4RCuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dJF1/Af8VE7ztbYXFF7ZsnwAB1bw0Ia8lvPnm6sUdk=;
 b=ccBSGncQQUCMsfhBWSdIKCvUD4dhWlzNcp5D3k9lv1KcMjnK7Rfuv0oKC/1mhNMNL9OpvLT+13Jneu0Qh64QO9Al3f8723Ysz36BwAg5bk7b1xIROP40EZFmYxuoUb2LXSB4xd2Ykzpcfdbk2GxZLdP3jdJUloIMro0PODTIr/g=
Received: from SJ0PR13CA0238.namprd13.prod.outlook.com (2603:10b6:a03:2c1::33)
 by DM6PR12MB4330.namprd12.prod.outlook.com (2603:10b6:5:21d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Tue, 7 Jan
 2025 22:29:01 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::7a) by SJ0PR13CA0238.outlook.office365.com
 (2603:10b6:a03:2c1::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.7 via Frontend Transport; Tue, 7
 Jan 2025 22:29:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 22:29:00 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 16:28:58 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <yazen.ghannam@amd.com>, <x86@kernel.org>, Tony Luck
	<tony.luck@intel.com>, Mario Limonciello <mario.limonciello@amd.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, Jean Delvare <jdelvare@suse.com>, "Guenter
 Roeck" <linux@roeck-us.net>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	"Hans de Goede" <hdegoede@redhat.com>, =?UTF-8?q?Ilpo=20J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, Naveen Krishna Chatradhi
	<naveenkrishna.chatradhi@amd.com>, Suma Hegde <suma.hegde@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
	<platform-driver-x86@vger.kernel.org>
Subject: [PATCH v3 00/12] AMD NB and SMN rework
Date: Tue, 7 Jan 2025 22:28:35 +0000
Message-ID: <20250107222847.3300430-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|DM6PR12MB4330:EE_
X-MS-Office365-Filtering-Correlation-Id: 13575215-abf9-4d52-fc89-08dd2f6aaf1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFREVFFBVlZGQXoxZGZmbzF1aGtxbWtwN3BRZlFDZHpwOGo3WDc5QlZtOEs4?=
 =?utf-8?B?ZzA0cU1qYzhmdDkwNGpIK1VRMTZPekx2cEVRM2RBRjU2aDVtcnBOMnRRb0t2?=
 =?utf-8?B?aWNtQ05wZ3FKTjY2S0NvckR3QmprWmhDQ2F5QzhucEdINGRZL09UOW9HZ2th?=
 =?utf-8?B?bU9MNHBlMGFPSTlBOVZmckYxMUJQc24xMStzQ2tpSlZTTmdkeEFDaDBNVFYw?=
 =?utf-8?B?WmI4WmlnanJ0TDJJNzFmTUdhaDhZa0RPeHdYbk1hMjRvTmFIM3o3dUJRMHpj?=
 =?utf-8?B?QWd4cWxwWXhLLzVCT2psZDVlZVVyUTJjc2thTk01eTBxYS9FWjI4OTNYOU9Q?=
 =?utf-8?B?WDcrRW1uamZzaWpORWtLZmxjQzJUdEF3QTRyTElPdndTSERUT0xxb2EzcWNx?=
 =?utf-8?B?S3lLWnluOXdYRWtHODRUalQ3MHN2K1h2L1Y4VS8wN1lhRFIyQmJ6RVhiYlE2?=
 =?utf-8?B?QUxoQ2M0UGdpbG0wOWRFVXFUZ3YwcE1vRkdjdHExbE5QZFhWN3BjNFlSSGZv?=
 =?utf-8?B?dWZ1S0xiZ0NxWUMycU1ucjkzK0laRzJ2aVIxaVBsQ0ZtejdaMk5iMnFydElG?=
 =?utf-8?B?S0ZvekhFNnM0bW91aDFGc25DWXZpYVVpS3pqR1FLWFBsN1JwdkpHWUxyZm9p?=
 =?utf-8?B?dDV1TGZRNi9CTWN4OGc2VEZIOW5MNkkxcWRiRVFJaFRnTnRzNkJMR3BtMi80?=
 =?utf-8?B?RVpQM0VrU0hFOTJMblQ5bTlwdS91M0ppNVpEdWFnbkNkQVBaRmpOQWRZWXVB?=
 =?utf-8?B?dnp4Yklvd0RMK0puYXN3STl6L0NUQi9qMldZWVFyYTh1OHU0S3psRlZHd2Nk?=
 =?utf-8?B?a2xMaVBwSllOZWlPM3VsQ0hVV3drZjRFTTc5Y2hvakNMc2U0MytnQU5ZUkZW?=
 =?utf-8?B?S1FnRUNRRFk4OGRnak1TUGxyS3hsK1NZWmNrQ2wyeDZXRWlGcHU2TGNCaEJn?=
 =?utf-8?B?ODVNSXFEWGM5TVN5c3E3ZVAvbXJHd1BSckQxZ0luZFdONUc2QW5YVXFjdWt4?=
 =?utf-8?B?bkcyQ2NXK0xIUGEyQlpVdFZqNjdnR0FCU3ZEaUhKdklYSWw0di9Jcmx0cmk0?=
 =?utf-8?B?cW4zMzQzTlEwc1VzRm5Fd0pteGI1MlVkclN0UEpRbVgzMGxlOXR3MmVJdzZK?=
 =?utf-8?B?djBBd0JmdTJpV3lIenY1Q0xBRitqVHVuV3VGR2hNRTJJRzI5RXJhZ3hyd3dJ?=
 =?utf-8?B?NkJMMGdsakxBV3BMMkhrMHBnTHhVaFNTaFRnK0NRVGQ1RVM0MlJ2Vk9NM2Nl?=
 =?utf-8?B?WEhLeFZnSTBrdVJzVlpOMkxVZ245T1VUSHJTY3RMWXRuenFNS1NTUEF4Rzh6?=
 =?utf-8?B?SElvekJpSEt1bVlsSU5QaWpMaUQ4RmNTeXlTeVk1Q2RPYU5sbHpJRklpTmJG?=
 =?utf-8?B?ZTRibFBWOGwxeGo4NkhSVFM3VXJnaks2aUoyamtnTVJIYVNMUjVLeVpjSDFL?=
 =?utf-8?B?NUFpN05oMFI2REtHaktnRXlRSzMxVWtnVUJoRGJFSnROb05DTmExNjFkQzIy?=
 =?utf-8?B?cm9MSktwaHpMQzlNVHBUZkQ2Ti92YWgwaXJ5RnY5aWtUVU5IZWx4WnFLTDRQ?=
 =?utf-8?B?VWIrYkpLS0RJYUdCckE2RmIxaU9SK0NKY0VHOXp4T24xdlMwa3JTNEVMR1Zt?=
 =?utf-8?B?SFBKY1NqWUhJUUxLTi9JYnRhTGZKeHU1UEsvdG5SZFRFbFFLN0NRekVVMlZl?=
 =?utf-8?B?L0o3d1dIaFFiVVFEN0xVZ3dCeU9zdkQ2Ris2cG9iL1JVOXJ1TWpCYzRKUDly?=
 =?utf-8?B?SDJZellpTHZQRzJWYnM3NktSajNUWkpDRWNYSWt1cXJPZWhtdExDd2RNRXB6?=
 =?utf-8?B?ZVJwMU9rT21jVnBVY0V2Ri9UVzJZd2JKMkQ1K3p3cjBjMzZDTjlrRVdMMTdp?=
 =?utf-8?B?S2FXS2pxVzdac3ZzSHR2NlhwM3ZKSHV1N0MwWDh0aXhUSE4xVnBkdGkwWG43?=
 =?utf-8?B?K0dTK3drbWdmdEpGRVZ1UkFmVW9Kd1hYeTBNWGZQR0xBZGJKY09kTHRmckJY?=
 =?utf-8?B?ZGhZL0RHUnNOMjVrNnEvOU1rdTNYdXB3M1JMUzdLaHgzenF3YllvVmwxTGZ1?=
 =?utf-8?Q?Ct5ban?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 22:29:00.5736
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13575215-abf9-4d52-fc89-08dd2f6aaf1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4330

Hi all,

This revision is based the following branch:
https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=tip-x86-misc

The only major change from the branch is in patch 6.
	("x86/amd_nb: Use topology info to get AMD node count")

A check is added to verify that all nodes have a 'misc' device. This is
to catch any unexpected system configurations including running inside a
virtual guest where the node devices aren't exposed. The commit message
is also updated.

Thanks,
Yazen

Link:
https://lore.kernel.org/r/20241206161210.163701-1-yazen.ghannam@amd.com

Major changes
v2->v3:
* Based on public branch from Boris.
* Add check for not finding any 'misc' devices during init.

v1->v2:
* Rebase HSMP changes on latest upstream rework.
* Keep Node and SMN code together.

Mario Limonciello (2):
  x86/amd_nb, hwmon: (k10temp): Simplify amd_pci_dev_to_node_id()
  x86/amd_nb: Move SMN access code to a new amd_node driver

Yazen Ghannam (10):
  x86/amd_nb: Restrict init function to AMD-based systems
  x86/amd_nb: Clean up early_is_amd_nb()
  x86: Start moving AMD node functionality out of AMD_NB
  x86/amd_nb: Simplify function 4 search
  x86/amd_nb: Simplify root device search
  x86/amd_nb: Use topology info to get AMD node count
  x86/amd_nb: Simplify function 3 search
  x86/amd_node: Update __amd_smn_rw() error paths
  x86/amd_node: Remove dependency on AMD_NB
  x86/amd_node: Use defines for SMN register offsets

 MAINTAINERS                          |   8 +
 arch/x86/Kconfig                     |   4 +
 arch/x86/include/asm/amd_nb.h        |  22 +-
 arch/x86/include/asm/amd_node.h      |  36 ++++
 arch/x86/kernel/Makefile             |   1 +
 arch/x86/kernel/amd_nb.c             | 300 ++-------------------------
 arch/x86/kernel/amd_node.c           | 215 +++++++++++++++++++
 arch/x86/pci/fixup.c                 |   4 +-
 drivers/edac/Kconfig                 |   1 +
 drivers/edac/amd64_edac.c            |   1 +
 drivers/hwmon/Kconfig                |   2 +-
 drivers/hwmon/k10temp.c              |   7 +-
 drivers/platform/x86/amd/pmc/Kconfig |   2 +-
 drivers/platform/x86/amd/pmc/pmc.c   |   3 +-
 drivers/platform/x86/amd/pmf/Kconfig |   2 +-
 drivers/platform/x86/amd/pmf/core.c  |   2 +-
 drivers/ras/amd/atl/Kconfig          |   1 +
 drivers/ras/amd/atl/internal.h       |   1 +
 18 files changed, 304 insertions(+), 308 deletions(-)
 create mode 100644 arch/x86/include/asm/amd_node.h
 create mode 100644 arch/x86/kernel/amd_node.c

-- 
2.43.0


