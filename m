Return-Path: <linux-pci+bounces-3992-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3488669D1
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 07:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF0FC1C20983
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 06:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676231A5AC;
	Mon, 26 Feb 2024 06:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jVvIOnzl"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA9D18EA8
	for <linux-pci@vger.kernel.org>; Mon, 26 Feb 2024 06:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708927340; cv=fail; b=LivSdKIpZXs7pE5bC5vl92RTUPBM/dfh3LXC+kPZtJJS28WZQ5LklK0BMFm0p5IqnE44Pi7uQ1Y0ObNDqvuOx3ZPY7Q5V8HK8oLjH4ZkB+9ghoUpxH4FXGqXZrr1LxZvUdmCmOj5Y/ERHoSQq9RuQ30W/SqELxAlShYNLYmB4aY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708927340; c=relaxed/simple;
	bh=NpQrevm11IzQh7mw4U86BxNA7Rg673wGP49hh2lMY9E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=um3cltpSXmOlnf6Hf02L54TOAY19QGXjOH5EXimlNTLlNnQbqJVyXcG0OF/tkwb2m69KRuUKyqf2zdQdbQRkb2XuQ99baYftUTXXITBmL3FKb9A7URK19xcaKxWCsZfzZF/OANKVOWoAVmId7kO56bdEpN1/5lNrAoytJBUAv4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jVvIOnzl; arc=fail smtp.client-ip=40.107.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bm5oCSXfNbKIF6udy5UN3r5XxbgJUmOSwejFF76GjD0XDdgT7yh0umAmBPB99/eQpC9yLimPh8K6AtTR7zQ/7TworMzSNtX69s2WPPY5YCl23gGIxXrxtYCHbHYAe8HdduLk5kBNW4mxIyvrCKC1mP2M6cpf1p8AGnFUIVtaeWvygUXgD15BZ1x/czB+BY5dpX3Zb4+LFw0eUF5bFTomUcFo4MI4sA+nJiBWiqXs4CCofsJJZjUBdYTJ7XV82lBJ3aI+IZMSCvMg5tpMH0k7Ppo+xMzHW5KHlsjQ4EnJjwdcByj8SIVepJHR5U090CzGmik39u9Ggkst9bocEq5h4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0N2aDEcIgmu9GNSOp8zHO6bxjnTKVU9gKWrNTOs9JI4=;
 b=Z25KfCavwcplkjHOKAQwjTl6M7Cvg99c83+VrAV4E8oVQeB4eS+DwQ64+/Qsr6PDXyjNwR304v6tIXMNGX0NV251Da5G1/y/0wk1LcXj4gwoo+M/PxQGGgU6R/ndKMRIE0VaFeQyEkDzQrg6kL3Oq1/zhvwYickOHsBe4Ms8s5OZo7f/rbcURmZL22eJQSToptHBjv5J9Pxic+Dr7CQ4FqfqH0+Kn9NVJaD52MO0ltWz2Qop/XpaHj/41KYqNlr3pdBVDod/wDnFuWXkRjqxMOyt5T3HjX6xdoljLcbLEfuNM5TPvrSg2t/ySah6nuWNLFcYBCyaWGoyU/b+qlqgOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0N2aDEcIgmu9GNSOp8zHO6bxjnTKVU9gKWrNTOs9JI4=;
 b=jVvIOnzleSxQBuevlpQtUJ9Cg5qrFSExRHgP5OoF4QFoudP5YhsHc8i+k2wlJuJ2O3jd5VYncK1pKjOg4e0t/yjRjC/eU0tT+zhUhF+AQLuon96hF/mUnproOBObtXbqucvK7iH3l/oELYNaB9z3eFsu22nZ/ypYQvV+GmpnLJE=
Received: from DS7PR05CA0107.namprd05.prod.outlook.com (2603:10b6:8:56::25) by
 DM6PR12MB4331.namprd12.prod.outlook.com (2603:10b6:5:21a::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.34; Mon, 26 Feb 2024 06:02:15 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:8:56:cafe::e1) by DS7PR05CA0107.outlook.office365.com
 (2603:10b6:8:56::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.24 via Frontend
 Transport; Mon, 26 Feb 2024 06:02:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.79) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Mon, 26 Feb 2024 06:02:15 +0000
Received: from aiemdee.2.ozlabs.ru (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 26 Feb
 2024 00:02:13 -0600
From: Alexey Kardashevskiy <aik@amd.com>
To: <linux-pci@vger.kernel.org>
CC: =?UTF-8?q?Martin=20Mare=C5=A1?= <mj@ucw.cz>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Alexey Kardashevskiy <aik@amd.com>
Subject: [PATCH pciutils v2 2/2] lspci: Add TEE-IO extended capability bit
Date: Mon, 26 Feb 2024 17:01:35 +1100
Message-ID: <20240226060135.3252162-3-aik@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240226060135.3252162-1-aik@amd.com>
References: <20240226060135.3252162-1-aik@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|DM6PR12MB4331:EE_
X-MS-Office365-Filtering-Correlation-Id: e895ce99-eeda-451f-7864-08dc36907b71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2T67YICmCd+3+6ZLOAo8DG5oJG4+BPSavVlQ6BXKov67ZwnsfAnHFNPJ0pbCl11tL9Ul/5w60ptWOlKHh8+3TC9c7P+0hY8OPEYnVo+45y6goQZt1Sx/Ywb1/9eK70kaFEXDsjloQOmJXCMkTHUeqCyW4qSP+00fqUU6Uet7k6mhMC9NVH1mxkSqBdB0r2+3uR2OOvDansk9ho5GXWigJVvr15b8dOIeHjQxYGoZstC8biG+q+RfkiaiPXUNlK/4HLTrpwjclS4bvYrkSoLMIeG1eIY0JzDnUfcQaPhXvHxORxOo5G4HowiDgU4HaHtW1ZR0Pkut5vHSydwjRBercZE/7iYQoyWB4DSUa8QRxz8w1m4VGIqSDqp8UagkU5k0wspkdDpr9EZ8PowgmCkxNm2r13yklNjLQdP7iChnHehyuTfis1mnprzlG0/2zFm0lyBNQT4u57llIFxH2QHAzLdF1S9/yn+QLS1WfPlYlHO+af4tOgTHiApBTD7O63e1Z4zBIOKQo/bTjheAspbkca/VLmoxBT4yfKYW5LKsHi6k36EP0zQkYduxL6c3IXeYf/A4KV0gkO+hDg9aVmT6a4nWt/SsD2ILS6ZY22zh0zEg24vCFkpCO4qnwMrTYdS71OnXTHSvvkMfm3VR8hJ/EC3qfbq99HPPUyVKwsuRVPbxqgc7u4rq1BULHN/0mziDHxlfZj5e8yI3UP8rxwtXtcHAcK4HdrJ6U3F41ItvjjRpeog9G0++B8ka0P2znQG7
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 06:02:15.2898
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e895ce99-eeda-451f-7864-08dc36907b71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4331

PCIe r6.1, sec 7.5.3.3 defines "TEE-IO Supported" in the PCI Express Device
Capabilities Register which indicates that the function implements
the TEE-IO functionality as described by the TEE Device Interface Security
Protocol (TDISP, PCIe r6.1, chapter 11).

tests/cap-ide is an example of such device.

Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
---
Changes:
v2:
* added the section number to the commit log
---
 lib/header.h | 1 +
 ls-caps.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/lib/header.h b/lib/header.h
index 68cb3c1..0b0ed9a 100644
--- a/lib/header.h
+++ b/lib/header.h
@@ -777,6 +777,7 @@
 #define  PCI_EXP_DEVCAP_PWR_VAL	0x3fc0000 /* Slot Power Limit Value */
 #define  PCI_EXP_DEVCAP_PWR_SCL	0xc000000 /* Slot Power Limit Scale */
 #define  PCI_EXP_DEVCAP_FLRESET	0x10000000 /* Function-Level Reset */
+#define  PCI_EXP_DEVCAP_TEE_IO  0x40000000 /* TEE-IO Supported (TDISP) */
 #define PCI_EXP_DEVCTL		0x8	/* Device Control */
 #define  PCI_EXP_DEVCTL_CERE	0x0001	/* Correctable Error Reporting En. */
 #define  PCI_EXP_DEVCTL_NFERE	0x0002	/* Non-Fatal Error Reporting Enable */
diff --git a/ls-caps.c b/ls-caps.c
index 2c99812..65e92e6 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -717,6 +717,7 @@ static void cap_express_dev(struct device *d, int where, int type)
       printf(" SlotPowerLimit ");
       show_power_limit((t & PCI_EXP_DEVCAP_PWR_VAL) >> 18, (t & PCI_EXP_DEVCAP_PWR_SCL) >> 26);
     }
+  printf(" TEE-IO%c", FLAG(t, PCI_EXP_DEVCAP_TEE_IO));
   printf("\n");
 
   w = get_conf_word(d, where + PCI_EXP_DEVCTL);
-- 
2.41.0


