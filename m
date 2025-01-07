Return-Path: <linux-pci+bounces-19467-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24367A04C49
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 23:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1026A166479
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 22:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0671F758A;
	Tue,  7 Jan 2025 22:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1/Cb+ZxP"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2063.outbound.protection.outlook.com [40.107.95.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED42D1F37C0;
	Tue,  7 Jan 2025 22:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736288951; cv=fail; b=kn6Po07hzd2/wnGtBQJTooSQsC+T27Et7jbdb1Q8JVqu5yP1tAP68LWZgfKiVoIOsjl+UAfXN79M1mWGTn2ERH0aiE4Af14lHpZXpvk7U3FKgBkcU3F/Hr3TYKeSrjX/hwtzpkFF/HsX9Ixdj3weTJuPAepAx+FF9ydoPgix+DI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736288951; c=relaxed/simple;
	bh=ZbQryK5/Ioqo6M/0BYGy5sdTNWM/fiiA26DnpwzsqH4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SheBTocnIB/PzBv+8KDxMXLCBbI2VlwviIkBL/TXHXeqVFR8XfjKBnsX/eXS3OJ9fHoxqDirbLhOFeqdcxCBtJ5K7rmPzqKLBxQLizapysYjZ0bXtHM/PucoxmV/SSNiQzbYk0L/DEhMsU/IBb8QX81PUscu1lMyMSxHmIeEXGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1/Cb+ZxP; arc=fail smtp.client-ip=40.107.95.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hJYKTPpzF9jm98/cw4wYExqgaNoMvwCdTLU74iz63Th81bZb26Ss0zTfehzEMfZYmAMgUSmvHhKNVjXNoIN7ZAL3TfJ/ii20zNZUDGRyATtuLLjumE8ZDbmXFD5kEs9DqAm3KpKRdxf3QtD7xSQUK/hLCBl5iK8b+J1vIR1ehdjxryXu+Tr0zaA9+ysif4XgLNVyIMlMQsiuuAJySKfEoHFw7vhC3WjrOi9H/GVT7KaqxQji2DakLduLHe0Borg2LA/6lylQMY4fkQ1+kG9xSSM2kJ0U7dEI2reuKl8lcGoiXCyYb/AfWVcoqdKYkPPyolhY3tnDTe04A0RWVoB4mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dFvfpH2y3JSzEkXloA4he+iAvyAfIZFH54cehBAUVCw=;
 b=Z8pymcMCq8K/vRbIcbOirm1gxSog1JK4ydWudxIaz3C1ad6Con3t+8warwA2v8guU1qx/sWYsdxY4CqiLhmdR4d5/HWKFu/VImGDAgUG8bDNN93PjsWH6D4fOxhb11NlAYyH+7Y1D67R8NSA44y6c+tY6krM34ojcZHI/VMxxeDUOCETe5yblz9Mx5tiKgwr/9GkREXmaWK2iln99QDRiaTuY4BQuDYQlzockDUoGDID9xX/K6Myw7MX6VZV68rMKmI4A6CL6Kdff0tbDe4b7ZOMorCFyauSiFKV6PHFMzjnb/RtfNt+pKGpbjF1ILho/lr6XuM3v+1FsruxOdzHuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFvfpH2y3JSzEkXloA4he+iAvyAfIZFH54cehBAUVCw=;
 b=1/Cb+ZxPzm/AgDvu2ybPe8Teg/pjOzvhcK4xS+rf2VuTxfZx9rnrEuamEeseNDa9pr2g3XhgUwDMhrs8Nwngm9/vOQfSG8Ppk2cjNdX3rs2XULHtfUu7iDF2Im+qMiOeSunUhfZwyY0pXZAaQjDf7K7w0BBTMjt31+kW+XTsaxI=
Received: from SJ0PR13CA0229.namprd13.prod.outlook.com (2603:10b6:a03:2c1::24)
 by SJ2PR12MB7917.namprd12.prod.outlook.com (2603:10b6:a03:4c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 22:29:01 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::e5) by SJ0PR13CA0229.outlook.office365.com
 (2603:10b6:a03:2c1::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 22:29:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 22:29:01 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 16:28:59 -0600
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
Subject: [PATCH v3 01/12] x86/amd_nb: Restrict init function to AMD-based systems
Date: Tue, 7 Jan 2025 22:28:36 +0000
Message-ID: <20250107222847.3300430-2-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107222847.3300430-1-yazen.ghannam@amd.com>
References: <20250107222847.3300430-1-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|SJ2PR12MB7917:EE_
X-MS-Office365-Filtering-Correlation-Id: 466f7ee7-3c7d-4486-d018-08dd2f6aaf8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5afi7Z8J4CKi9WMYSIC8x+lteMqKN87jM/mrEf6l8GnPPikpTcQcjkWMZLKk?=
 =?us-ascii?Q?1ARHBGkjMWH0GlNtmOsyNMvDSMJ2FCJtlkelPz7Zqlx3GR24BRP5jhO896lv?=
 =?us-ascii?Q?QXrWJ1IDuszthX1u+pFN2rFe+uWffC0poztRwzO7ljPbriy5sIPfvSoIMOiG?=
 =?us-ascii?Q?tT12RV7vvAVfhevH+UHliCVUxMAqcgg03T7uN1tyKBnZa7oBdHyRslGD5TmW?=
 =?us-ascii?Q?cU1YhtaxWSoLcS4kpsZqZ5EhSHBTjFn7sbZvxOQ6gVGn+QIpeybN2sEM7upJ?=
 =?us-ascii?Q?uBg3yu8maAfzG3PaKCDA+tNgl1O5HSGxLGVwdICh1zMGK+SJYbz7VCKGS6Vp?=
 =?us-ascii?Q?Y0/QWSxd6NzkJji26HGii3y9V3sklX7bzg+7H6zquPq92CM7VqfC8WVBLCFE?=
 =?us-ascii?Q?pL7b1n3PP55vQu8X9QftHnxNVg2K6bB6qQzT1u7FX4jAckxo0yo5XY1fcUvI?=
 =?us-ascii?Q?4yCqctGIU1mpliz6iX6GLXjwfrU+fnXhDA9mXGDUTv+HpDlVJSyymg54fmbp?=
 =?us-ascii?Q?oo08EZorZXgybbefqJyyOMmFEPbDHeqcN+zvYY1jYaNxu7BF4s0LRnps26D7?=
 =?us-ascii?Q?9PkVbUMTvN5GCh21FnQY+ZcziGe3ONF7ALeEiCGdwUWKeI6ey2G6b4/J+XW3?=
 =?us-ascii?Q?cXCNASYIhIJJKE6QNTHaBpHhDePY6rs4EL2CJA4E/suxyiSkLWOYKJqT/GHk?=
 =?us-ascii?Q?k+kSCpm4aJ88thyjYn11YYrkOI4p4XzebT7g5Uwlgnmr6LU6EyxdUBuycvZI?=
 =?us-ascii?Q?QJcclibF5UN/P3lKRj/m/WEbuAGDcibcZDXgQWoFkEPQY4yCb+gNo8cauoVz?=
 =?us-ascii?Q?sn/YciluHGnAo5C4MK7sKhHltKkvw+byKRq2aZ0aLkfzPAVStYYuBzQzipuC?=
 =?us-ascii?Q?6KJmoPOS55BfNr/OyS2wGIhpg/D7AAj05kIi53CrZIFk0jRfR4dWYeldu1y8?=
 =?us-ascii?Q?zToW6hkqzuvvKz4eVODGtjsskRj7JZ51koJidGOlKNuIQAJT9OEWDdS1Zgjd?=
 =?us-ascii?Q?uNnYsbuA8I9YkXAxRsHboxBd8rsB5WkKVp7k+k+9zwnjbBuBd/8+s/W3bppo?=
 =?us-ascii?Q?QopEMkpDSz7ISCLGvSpPLxQu80zSQJAYQG8TaCjrZ9kLi6JuNbvVXldtaqt4?=
 =?us-ascii?Q?Hwl06cESUOJ6Pbv6XaDGZjD3tSktvMpNZWw1D6BqMEqKvaCtGpHz1Exk5//x?=
 =?us-ascii?Q?cT5JtgU6LInhOjo7mbIKd3PmJAvXKWjwe5nZkVMlNSy2hifuL0vUyFbLU4eH?=
 =?us-ascii?Q?qpHN81HhIl+DLYMmN0j4So8J9Y4GOZJFa9PNmFFIzkMijB/4b+y2GVgk/Lzg?=
 =?us-ascii?Q?9Pmf6AjKNyHA1qr+8m6N+7PQJEUnrM9O+0Lix9ISPaTpgu3sKLQ9mf2ROZK9?=
 =?us-ascii?Q?4m/dOx8fTu4Q5NCSQfQJ74GkdWFP40zfEHEO6UuXDddPwq54GuAaUMi8tZPi?=
 =?us-ascii?Q?TPK92FQtgGHJfE8ouQSUNjJG/CZMOMjvOMq2sK692gkKnTyLTOTtmHMtoYDn?=
 =?us-ascii?Q?qBGsLIUyZ0nLDAmfpGQGQ/vdCUwVqAmcCjJe?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 22:29:01.3392
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 466f7ee7-3c7d-4486-d018-08dd2f6aaf8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7917

The code implicitly operates on AMD-based systems by matching on PCI
IDs. However, the use of these IDs is going away.

Add an explicit CPU vendor check instead of relying on PCI IDs.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20241206161210.163701-3-yazen.ghannam@amd.com
---
 arch/x86/kernel/amd_nb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 9fe9972d2071..37b8244899d8 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -582,6 +582,10 @@ static __init void fix_erratum_688(void)
 
 static __init int init_amd_nbs(void)
 {
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
+		return 0;
+
 	amd_cache_northbridges();
 	amd_cache_gart();
 
-- 
2.43.0


