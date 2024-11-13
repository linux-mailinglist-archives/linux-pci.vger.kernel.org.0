Return-Path: <linux-pci+bounces-16698-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FE89C7DE5
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 22:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5150A283F14
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 21:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D4218B499;
	Wed, 13 Nov 2024 21:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CtOxzKyi"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE6617DFE9;
	Wed, 13 Nov 2024 21:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731534885; cv=fail; b=W9xfQDCGXuCPRPsaEStC7bTwC2NxAg1uHMT1BJ8h2owD7PXj4WfRn84OIWK5dBmkLUVTb3YmTMNR0fr7+z76GOB2Y03j1hvgn4dxHiCRZ5M1+k/B1SLLy98kzIZHLZ0CPM9KJGzqVEBWlV0ZrxJs7Eb1Gilk+I2OV0R/2DXrsxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731534885; c=relaxed/simple;
	bh=eel6oGL1MVoTjmX3vw8EA6t/MqOybd9Zqvnl05DvjnQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nDcFJXvEZu8IZZ/7F3XpRy2GP/RPMjwD4FVKHz/pb8jeNkAezKRExERLOcTLa8mP2XuGORVuMUxxOUOhTb27b+7h3GuR0pKxC/0VjYltQ0zIHnE8t3byzLKGNQZAquFQ/YFifYq8Rf7AarjfGFwcLGUyvs2KLMB1tHRi4KMKUz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CtOxzKyi; arc=fail smtp.client-ip=40.107.92.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hwNdO/zhZNPpq7Oq3BBmq0SyuttInKEbxt708Yoft1eQUhTm+4OCyhs+VaoL7UAiqW+iY37NQLUnF4oIHtRFDur9KzwcHUvxd0fOyfSTl9NDTlJbFkpuwcjDEUMqcPexAt6xFUCZ2MjDPYisB9S4HPcwuY7rqXrDrHnr1Tkx//bun7yqvFZR+FoqHpFPeDZJEpoq/2riZChM3muz2x2xXr65X4nrJrgCcPRI3Dlmog88mIpv4IDxg7Huo57PxUhdWlaTwjzqiKZzau2PbqqKVHxjT0XtYGfNEi92xwfr91D1usE52lm5ov4m6gaI8306pBVxL8CVXKwlphVJWtoF5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHyjOuyRf7N8knCVhEWXOckgUlUf+Br8pvnLQKUxYbQ=;
 b=uBUclwH3QODFD2Ydzvr7glTOKI1Us+5fHSyLvo3xqOGHOZIa9F9zCuK9MjH/5a+UHJ8DG0OczmAjXB7kJGiqd2XUvfxcl8Ao0bknMltPviRpbN8+Ca4lLYfGypwVHVb82N0bOeMEFTprcLqEbAbgFXvuVKnkbUVI/6ttGfAj2/oaIUwdneJUqlAocriIK7DOV8S/VCdYzgt9Faa3PJ0Gc8Va9x/Sh3dR5uu7qFhdIkBQd0jRzL2msWiXPci4oacDX+S0aftNV88sRupG3K3PtFrj8bYY7IEI3ABue7YBxmuUHaxbSsUpyv7fc8tm9iX+lCGBxJDGYDpSDzWmNYaffQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHyjOuyRf7N8knCVhEWXOckgUlUf+Br8pvnLQKUxYbQ=;
 b=CtOxzKyifpFxx/wFBVradU7+svINB0Nc+j1jKXVex4hrAUTmkRWsGeHFaKy5ns+T/bUlOKqiNMFfQodeqslLXSiyQtQSVBxFHWrudQLdCGtDzLpUINa2yaLSwhjBuQLbnxHTw9x5+dTJfcFmy8ijApzBWl2Aqvyns4SrcX/bhik=
Received: from DS7PR07CA0010.namprd07.prod.outlook.com (2603:10b6:5:3af::29)
 by IA1PR12MB7760.namprd12.prod.outlook.com (2603:10b6:208:418::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Wed, 13 Nov
 2024 21:54:37 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:3af:cafe::43) by DS7PR07CA0010.outlook.office365.com
 (2603:10b6:5:3af::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Wed, 13 Nov 2024 21:54:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 21:54:37 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 15:54:35 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <ming4.li@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>
Subject: [PATCH v3 0/15] Enable CXL PCIe port protocol error handling and logging
Date: Wed, 13 Nov 2024 15:54:14 -0600
Message-ID: <20241113215429.3177981-1-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|IA1PR12MB7760:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bce6dcb-c9d2-494e-ce65-08dd042dc480
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hrzge+hUwHfW/QnHSFYZF4W1k6U+t3qfjU+xDAPgykMFuYRYOGZrIHMkd0a2?=
 =?us-ascii?Q?Y2tHQW+atOWu9kik0vSn1brdin6cVsNi+rYcI/pRXBI0HWqqEPnadkOQE4Yc?=
 =?us-ascii?Q?vl2lNnoy4rtMVD1hTgjnV4n4RFrEJie2zUD+vzEubmFG5GrMvneMbv1h8HZI?=
 =?us-ascii?Q?qrtRvo/WBUBhTdtU7WTwiHNO2z6Yd+6O65/2rMCLW3wNXF2K3N+6bP3HofYR?=
 =?us-ascii?Q?IihJRD9Tu344DP0PQGyctJdgp1iCnPs0sYgTjUgkeIDfsordFU+6RFjJXLKc?=
 =?us-ascii?Q?PinryF4AEx/oEkfuZLuHKx93BmgIobqBE7SRO8MzJWGF5GLn889GsQsocEOC?=
 =?us-ascii?Q?OarDQposdCThmk+1ynjMdPfQ1F38TyuRZx9qgmVSKEVHgKarsOY4xKeWJK9o?=
 =?us-ascii?Q?H5jABveOeP+IWvktla66W9d0Q5z3KN9mbB4Ulfo8mxuAiEISk51se27QohFW?=
 =?us-ascii?Q?NbolrCT0y+D0C82zPBQlQH6Jpg4SwF6GkhpJVK7G5mqG1H6LuS4nFIYJtjES?=
 =?us-ascii?Q?XmW57Po83GmqR09g5t4RlXuD7ogrySipvCHTBkj38QDWu0WejB7OhRaQaKhl?=
 =?us-ascii?Q?6PkLkJiHlUNtZZum+nOIDtiKVyqbW6OQHDSGISye22Evq5Ft1jdKYZiseUhj?=
 =?us-ascii?Q?yjPc2OKBsQbgaIRAMTW5uN8lDJtzm+HqD5lSFTc3cJgJuvmv3xy01Hn4+F4x?=
 =?us-ascii?Q?2JuZr/17GJo0rMEKfE6eOUsihSYA0etkbj6iwWyCQclbjhsEDnsczLq+LXut?=
 =?us-ascii?Q?uEHtPSISOV8Zz+XBmJdH6JeYJ07ugXgaL+bcKYQUiNQ+SflB697qIq02yFoZ?=
 =?us-ascii?Q?7KLj1BjRzhyNIWKLpPyL1P+4USIgFlSy2xxhb7Ga/MN1I7g8GvLXT/yIZrPU?=
 =?us-ascii?Q?FD7e4jc9i6k1hfuVW0Jd3IOwQ6qA91D7nqkCLTQ0z7TPe8suhGZceNWx6KP/?=
 =?us-ascii?Q?QXewTpl3uoljThSSrHBJ6ZZsktxIW3k2V6FltGDKa3jtTKw0tH4NT+hsoqKJ?=
 =?us-ascii?Q?yYBwi2UIEZ6jcJQAehzdSa1Sf0/K1FpuBiTywqQfrzBb+HjzbG7jUcvPWFQP?=
 =?us-ascii?Q?0czBqLVjSylBK8A4YD0+XpDDS0ZO4OUwFDTvVORSho/jL5pbsZrAgVNx4v3z?=
 =?us-ascii?Q?0d19FP03jQqK8m3rB/vJKfRRrrIB5DuxlLsTDRLPTTDaFzk6Kc/KX4qM86v/?=
 =?us-ascii?Q?za+VLvebpUJmee3NmyPRF39Bf7EsccKpXeIM7Q3iGv4mnACjpQy5vTZq53WQ?=
 =?us-ascii?Q?73Kk7t+FNKFUChkxNI3D1Naos8MDfIysvUpSs/Da6yAvoQoV7Lf/QnIDAaBD?=
 =?us-ascii?Q?JYYZFPGY29L7QNQhBwDEnOyLNQ/SFAscnXttWT+Ip73lLDCKRceieXVE4U1c?=
 =?us-ascii?Q?gzKqsAhpRTgNyPus1ruJ5RY4NiL3Q1ntb+LUL3NDIJ8RV5AKdhBG+763NqmA?=
 =?us-ascii?Q?RvOrR7Uqw8Q=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 21:54:37.0793
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bce6dcb-c9d2-494e-ce65-08dd042dc480
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7760

CXL protocol error handling support exists for CXL endpoint devices and CXL
restricted host downstream port devices. This patchset adds the same
support for CXL PCIe port devices including: CXL root ports, CXL upstream
switch ports, and CXL downstream switch ports.[1]

This implementation separates PCIe protocol error handling and CXL protocol
error handling. This is necessary because of the different requirements for
PCIe and CXL device recovery, specifically uncorrectable error (UCE)
handling. PCIe AER handling attempts recovery and uses a device disconnect
if recovery fails. CXL devices must use a kernel panic in the case of an
uncorrectable errors (UCE). CXL recovery is not attempted because the
procedure could corrupt memory while indicating successful recovery.

The first 7 patches update the existing AER service driver to support CXL
PCIe port protocol error handling and reporting. This includes AER service
driver changes for adding correctable and uncorrectable error support, CXL
specific recovery handling, and support for CXL driver callback handlers.

The following 8 patches address CXL driver support for CXL PCIe port
protocol errors. This includes the following changes to the CXL drivers:
mapping CXL port and downstream port RAS registers, interface updates for
common restricted CXL host mode (RCH) and virtual hierarchy mode (VH),
adding port specific error handlers, error logging, and UIE/CIE enablement.

[1] - CXL 3.1 specification, 12.0 Reliability, Availability, and Serviceability

Testing:

Below are test results for this patchset using Qemu with CXL root
port(0c:00.0), CXL upstream switchport(0d:00.0), CXL downstream
switchport(0e:00.0). The endpoint CE and UCE injection logs are also
added.

This was tested using aer-inject updated to support CE and UCE internal
error injection. CXL RAS was set using a test patch (not upstreamed but can
provide if needed).

 - Root Port Correctable Error 
 root@tbowman-cxl:~/aer-inject# ./root-ce-inject.sh
 pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0c:00.0
 pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0c:00.0
 pcieport 0000:0c:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
 pcieport 0000:0c:00.0:   device [8086:7075] error status/mask=00004000/0000a000
 pcieport 0000:0c:00.0:    [14] CorrIntErr
 aer_event: 0000:0c:00.0 CXL Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
 cxl_port_aer_correctable_error: device=0000:0c:00.0 host=pci0000:0c status='Received Error From Physical Layer'

 - Root Port UnCorrectable Error 
 root@tbowman-cxl:~/aer-inject# ./root-uce-inject.sh
 pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0c:00.0
 pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0c:00.0
 pcieport 0000:0c:00.0: CXL Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
 pcieport 0000:0c:00.0:   device [8086:7075] error status/mask=00400000/02000000
 pcieport 0000:0c:00.0:    [22] UncorrIntErr
 systemd-journald[482]: Sent WATCHDOG=1 notification.
 aer_event: 0000:0c:00.0 CXL Bus Error: severity=Fatal, Uncorrectable Internal Error, TLP Header=Not available
 cxl_port_aer_uncorrectable_error: device=0000:0c:00.0 host=pci0000:0c status: 'Memory Address Parity Error' first_error: 'Memory Address Parity Error'
 Kernel panic - not syncing: CXL cachemem error. Invoking panic
 CPU: 10 UID: 0 PID: 150 Comm: irq/24-aerdrv Tainted: G            E      6.12.0-rc6test-gb0cd92ab89ad #4507
 Tainted: [E]=UNSIGNED_MODULE
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
 Call Trace:
  <TASK>
  dump_stack_lvl+0x27/0x90
  dump_stack+0x10/0x20
  panic+0x33e/0x380
  cxl_do_recovery+0x122/0x130
  ? srso_return_thunk+0x5/0x5f
  aer_isr+0x3e0/0x710
  irq_thread_fn+0x28/0x70
  irq_thread+0x179/0x240
  ? srso_return_thunk+0x5/0x5f
  ? __pfx_irq_thread_fn+0x10/0x10
  ? __pfx_irq_thread_dtor+0x10/0x10
  ? __pfx_irq_thread+0x10/0x10
  kthread+0xf5/0x130
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x3c/0x60
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>
 Kernel Offset: 0x1800000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
 ---[ end Kernel panic - not syncing: CXL cachemem error. Invoking panic ]---

 - Upstream Port Correctable Error
 root@tbowman-cxl:~/aer-inject# ./us-ce-inject.sh
 pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0d:00.0
 pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0d:00.0
 pcieport 0000:0d:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
 pcieport 0000:0d:00.0:   device [19e5:a128] error status/mask=00004000/0000a000
 pcieport 0000:0d:00.0:    [14] CorrIntErr
 aer_event: 0000:0d:00.0 CXL Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
 cxl_port_aer_correctable_error: device=0000:0d:00.0 host=0000:0c:00.0 status='Received Error From Physical Layer'

 - Upstream Port UnCorrectable Error 
 root@tbowman-cxl:~/aer-inject# ./root-uce-inject.sh
 pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0c:00.0
 pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0c:00.0
 pcieport 0000:0c:00.0: CXL Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
 pcieport 0000:0c:00.0:   device [8086:7075] error status/mask=00400000/02000000
 pcieport 0000:0c:00.0:    [22] UncorrIntErr
 systemd-journald[482]: Sent WATCHDOG=1 notification.
 aer_event: 0000:0c:00.0 CXL Bus Error: severity=Fatal, Uncorrectable Internal Error, TLP Header=Not available
 cxl_port_aer_uncorrectable_error: device=0000:0c:00.0 host=pci0000:0c status: 'Memory Address Parity Error' first_error: 'Memory Address Parity Error'
 Kernel panic - not syncing: CXL cachemem error. Invoking panic
 CPU: 10 UID: 0 PID: 150 Comm: irq/24-aerdrv Tainted: G            E      6.12.0-rc6test-gb0cd92ab89ad #4507
 Tainted: [E]=UNSIGNED_MODULE
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
 Call Trace:
  <TASK>
  dump_stack_lvl+0x27/0x90
  dump_stack+0x10/0x20
  panic+0x33e/0x380
  cxl_do_recovery+0x122/0x130
  ? srso_return_thunk+0x5/0x5f
  aer_isr+0x3e0/0x710
  irq_thread_fn+0x28/0x70
  irq_thread+0x179/0x240
  ? srso_return_thunk+0x5/0x5f
  ? __pfx_irq_thread_fn+0x10/0x10
  ? __pfx_irq_thread_dtor+0x10/0x10
  ? __pfx_irq_thread+0x10/0x10
  kthread+0xf5/0x130
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x3c/0x60
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>
 Kernel Offset: 0x1800000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
 ---[ end Kernel panic - not syncing: CXL cachemem error. Invoking panic ]---

 - Downstream Port Correctable Error
 root@tbowman-cxl:~/aer-inject# ./ds-ce-inject.sh
 pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0e:00.0
 pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0e:00.0
 pcieport 0000:0e:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
 pcieport 0000:0e:00.0:   device [19e5:a129] error status/mask=00004000/0000a000
 pcieport 0000:0e:00.0:    [14] CorrIntErr
 aer_event: 0000:0e:00.0 CXL Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
 cxl_port_aer_correctable_error: device=0000:0e:00.0 host=0000:0d:00.0 status='Received Error From Physical Layer'

 - Downstream Port UnCorrectable Error 
 root@tbowman-cxl:~/aer-inject# ./ds-uce-inject.sh
 pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0e:00.0
 pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0e:00.0
 pcieport 0000:0e:00.0: CXL Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
 pcieport 0000:0e:00.0:   device [19e5:a129] error status/mask=00400000/02000000
 pcieport 0000:0e:00.0:    [22] UncorrIntErr
 aer_event: 0000:0e:00.0 CXL Bus Error: severity=Fatal, Uncorrectable Internal Error, TLP Header=Not available
 cxl_port_aer_uncorrectable_error: device=0000:0e:00.0 host=0000:0d:00.0 status: 'Memory Address Parity Error' first_error: 'Memory Address Parity Error'
 Kernel panic - not syncing: CXL cachemem error. Invoking panic
 CPU: 10 UID: 0 PID: 146 Comm: irq/24-aerdrv Tainted: G            E      6.12.0-rc6test-gb0cd92ab89ad #4507
 Tainted: [E]=UNSIGNED_MODULE
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
 Call Trace:
  <TASK>
  dump_stack_lvl+0x27/0x90
  dump_stack+0x10/0x20
  panic+0x33e/0x380
  cxl_do_recovery+0x122/0x130
  ? srso_return_thunk+0x5/0x5f
  aer_isr+0x3e0/0x710
  irq_thread_fn+0x28/0x70
  irq_thread+0x179/0x240
  ? srso_return_thunk+0x5/0x5f
  ? __pfx_irq_thread_fn+0x10/0x10
  ? __pfx_irq_thread_dtor+0x10/0x10
  ? __pfx_irq_thread+0x10/0x10
  kthread+0xf5/0x130
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x3c/0x60
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>
 Kernel Offset: 0x1ac00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
 ---[ end Kernel panic - not syncing: CXL cachemem error. Invoking panic ]---

 - Endpoint Correctable Error
 root@tbowman-cxl:~/aer-inject# ./ep-ce-inject.sh
 pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000040/00000000 into device 0000:0f:00.0
 pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0f:00.0
 cxl_pci 0000:0f:00.0: CXL Bus Error: severity=Correctable, type=Data Link Layer, (Receiver ID)
 cxl_pci 0000:0f:00.0:   device [8086:0d93] error status/mask=00000040/0000e000
 systemd-journald[482]: Sent WATCHDOG=1 notification.
 cxl_pci 0000:0f:00.0:    [ 6] BadTLP
 aer_event: 0000:0f:00.0 CXL Bus Error: severity=Corrected, Bad TLP, TLP Header=Not available

 - Endpoint UnCorrectable Error
 root@tbowman-cxl:~/aer-inject# ./ep-uce-inject.sh
 pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00040000 into device 0000:0f:00.0
 pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0f:00.0
 cxl_pci 0000:0f:00.0: AER: CXL Bus Error: severity=Uncorrectable (Fatal), type=Inaccessible, (Unregistered Agent ID)
 aer_event: 0000:0f:00.0 CXL Bus Error: severity=Fatal, , TLP Header=Not available
 cxl_pci 0000:0f:00.0: mem3: frozen state error detected, disable CXL.mem
 cxl_detach_ep: cxl_mem mem3: disconnect mem3 from port2
 cxl_detach_ep: cxl_mem mem3: disconnect mem3 from port1
 pcieport 0000:0e:00.0: unlocked secondary bus reset via: pciehp_reset_slot+0xac/0x160
 pcieport 0000:0e:00.0: AER: Downstream Port link has been reset (0)
 cxl_pci 0000:0f:00.0: mem3: restart CXL.mem after slot reset
 devm_cxl_enumerate_ports: cxl_mem mem3: scan: iter: mem3 dport_dev: 0000:0e:00.0 parent: 0000:0d:00.0
 devm_cxl_enumerate_ports: cxl_mem mem3: found already registered port port2:0000:0d:00.0
 devm_cxl_enumerate_ports: cxl_mem mem3: scan: iter: 0000:0e:00.0 dport_dev: 0000:0c:00.0 parent: pci0000:0c
 devm_cxl_enumerate_ports: cxl_mem mem3: found already registered port port1:pci0000:0c
 cxl_port_alloc: cxl_mem mem3: host-bridge: pci0000:0c
 cxl_cdat_get_length: cxl_port endpoint6: CDAT length 160
 cxl_port_perf_data_calculate: cxl_port endpoint6: Failed to retrieve ep perf coordinates.
 cxl_endpoint_parse_cdat: cxl_port endpoint6: Failed to do perf coord calculations.
 init_hdm_decoder: cxl_port endpoint6: decoder6.0: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
 add_hdm_decoder: cxl decoder6.0: Added to port endpoint6
 init_hdm_decoder: cxl_port endpoint6: decoder6.1: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
 add_hdm_decoder: cxl decoder6.1: Added to port endpoint6
 init_hdm_decoder: cxl_port endpoint6: decoder6.2: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
 add_hdm_decoder: cxl decoder6.2: Added to port endpoint6
 init_hdm_decoder: cxl_port endpoint6: decoder6.3: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
 add_hdm_decoder: cxl decoder6.3: Added to port endpoint6
 cxl_bus_probe: cxl_port endpoint6: probe: 0
 devm_cxl_add_port: cxl_mem mem3: endpoint6 added to port2
 cxl_bus_probe: cxl_mem mem3: probe: 0
 cxl_pci 0000:0f:00.0: mem3: error resume successful
 pcieport 0000:0e:00.0: AER: device recovery successful

 Changes in v2 -> v3
 [Terry] Rebase to 6.12-rc7
 [Terry] Add UIE/CIE port enablement patch. Needed because only RP are  enabled by AER driver.
 [DaveJ] Isolate reading upstream port's AER info to only the CXL path
 [Jonathan, Dan] Add details about separate handling paths for CXL & PCIe
 [Jonathan] Add details to existing comment in devm_cxl_add_endpoint()
 about call to cxl_init_ep_ports_aer()
 [Jonathan] Updated cxl_init_ep_ports_aer() w/ checks for NULL;
 [Jonathan] Move find_cxl_port() patch immediately before patch to create handlers
 [Jonathan] Patch title fix: find_cxl_ports() -> find_cxl_port()
 [Jonathan] Remove 2 unnecessary dev_warns() in cxl_dport_init_ras_reporting() and
 cxl_uport_init_ras_reporting().
 [Jonathan] Remove unnecessary filter on PCIe port devices in dev_is_cxl_pci()
 [Jonathan] Remove cleanup declarations in cxl_pci_port_ras()
 [Jonathan] Fix spacing in 'struct cxl_error_handlers' declaration.
 [Jonathan] Remove unnecessary check for PCI device in __cxl_handle_ras() & __cxl_handle_cor_ras()
 
 Changes in v1 -> v2
 [Jonathan] Remove extra NULL check and cleanup in cxl_pci_port_ras()
 [Jonathan] Update description to DSP map patch description
 [Jonathan] Update cxl_pci_port_ras() to check for NULL port
 [Jonathan] Dont call handler before handler port changes are present (patch order)
 [Bjorn] Fix linebreak in cover sheet URL
 [Bjorn] Remove timestamps from test logs in cover sheet
 [Bjorn] Retitle AER commits to use "PCI/AER:"
 [Bjorn] Retitle patch#3 to use renaming instead of refactoring
 [Bjorn] Fix base commit-id on cover sheet
 [Bjorn] Add VH spec reference/citation
 [Terry] Removed last 2 patches to enable internal errors. Is not needed
 because internal errors are enabled in AER driver.
 [Dan] Create cxl_do_recovery() and pci_driver::cxl_err_handlers.
 [Dan] Use kernel panic in CXL recovery
 [Dan] cxl_port_hndlrs -> cxl_port_error_handlers
 [Dan] Move cxl_port_error_handlers to pci_driver. Remove module (un)registration.
 [Terry] Add patch w/ qcxl_assign_port_error_handlers() and cxl_clear_port_error_handlers()
 [Terry] Removed PCI_ERS_RESULT_PANIC patch. Is no longer needed because the result type parameter
 is not used in the CXL_err_handlers callbacks.

 Changes in RFC -> v1:
 [Dan] Rename cxl_rch_handle_error() becomes cxl_handle_error()
 [Dan] Add cxl_do_recovery()
 [Jonathan] Flatten cxl_setup_parent_uport()
 [Jonathan] Use cxl_component_regs instead of struct cxl_regs regs
 [Jonathan] Rename cxl_dev_is_pci_type()
 [Ming] bus_find_device(&cxl_bus_type, NULL, &pdev->dev, match_uport) can
 replace these find_cxl_port() and device_find_child().
 [Jonathan] Compact call to cxl_port_map_regs() in cxl_setup_parent_uport()
 [Ming] Dont use endpoint as host to cxl_map_component_regs()
 [Bjorn] Use "PCIe UIR/CIE" instesad of "AER UI/CIE"
 [Bjorn] Dont use Kconfig to enable/disable a CXL external interface

Terry Bowman (15):
  PCI/AER: Introduce 'struct cxl_err_handlers' and add to 'struct
    pci_driver'
  PCI/AER: Rename AER driver's interfaces to also indicate CXL PCIe port
    support
  cxl/pci: Introduce PCIe helper functions pcie_is_cxl() and
    pcie_is_cxl_port()
  PCI/AER: Modify AER driver logging to report CXL or PCIe bus error
    type
  PCI/AER: Add CXL PCIe port correctable error support in AER service
    driver
  PCI/AER: Change AER driver to read UCE fatal status for all CXL PCIe
    port devices
  PCI/AER: Add CXL PCIe port uncorrectable error recovery in AER service
    driver
  cxl/pci: Map CXL PCIe root port and downstream switch port RAS
    registers
  cxl/pci: Map CXL PCIe upstream switch port RAS registers
  cxl/pci: Update RAS handler interfaces to also support CXL PCIe ports
  cxl/pci: Change find_cxl_port() to non-static
  cxl/pci: Add error handler for CXL PCIe port RAS errors
  cxl/pci: Add trace logging for CXL PCIe port RAS errors
  cxl/pci: Add support to assign and clear pci_driver::cxl_err_handlers
  PCI/AER: Enable internal errors for CXL upstream and downstream switch
    ports

 drivers/cxl/core/core.h       |   3 +
 drivers/cxl/core/pci.c        | 183 ++++++++++++++++++++++++++++------
 drivers/cxl/core/port.c       |   4 +-
 drivers/cxl/core/trace.h      |  47 +++++++++
 drivers/cxl/cxl.h             |  10 +-
 drivers/cxl/mem.c             |  36 ++++++-
 drivers/pci/pci.c             |  14 +++
 drivers/pci/pci.h             |   3 +
 drivers/pci/pcie/aer.c        | 104 +++++++++++--------
 drivers/pci/pcie/err.c        |  54 ++++++++++
 drivers/pci/probe.c           |  10 ++
 include/linux/aer.h           |   1 +
 include/linux/pci.h           |  13 +++
 include/ras/ras_event.h       |   9 +-
 include/uapi/linux/pci_regs.h |   3 +-
 15 files changed, 410 insertions(+), 84 deletions(-)


base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
-- 
2.34.1


