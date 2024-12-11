Return-Path: <linux-pci+bounces-18192-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7929EDBD0
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 00:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32240166C1D
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 23:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA89C1C3F27;
	Wed, 11 Dec 2024 23:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="c7NMiuCr"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2086.outbound.protection.outlook.com [40.107.101.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5078A17838C;
	Wed, 11 Dec 2024 23:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733960414; cv=fail; b=AH+OJY2ldCodOgPfk3PuKq6k7fUUZ8MFtmL69dkFaaWI4IrrvEtLMKrXMA185vijWnhE5ucPodxVSvu+2Pda4BWaHZIa305i8hmew5xGflddFnKj8U/cMjtjBua8pSkAgLIjJT0v3tZmlCK+CMwRSro7SN/jTKkBJrFszGyIR+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733960414; c=relaxed/simple;
	bh=gUeQTRPxyJwDfejPuJI2Kdnjt+kaD4vjyiLU78pziWE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ruhus3IH/HKaDyz97qXyHisq0T6XcJDQg0JNdgpUpXEvNrEVsMk5AfZg5NJKFNS8u3o99O9UV2GbCmrxsDvrcE1qAIalJ2DRbPyXiikUPCZkhWTIjwOE7Tb6td4uzZ2hMqgalYxY1ldoI+XyOQlJyYYkltBLz5jdVTq2zg+SaNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=c7NMiuCr; arc=fail smtp.client-ip=40.107.101.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mqSGTXidYe5LWjsq0GYeXjv3and+Qf4aTaOR0dPUYnUNoR7zgLVT58VFwjHXDwyMgUtFTivEW8z3aoIjW1G+DnDowyv0S4fqbGTYpjIK4QAowBaoCmiJQufrwuSQbos5dsRgfKzDCFfU3KRAVKETwy/RwNUjceCtY7IqVhk8bP8cmB35iRZ+s4m1VBzgZrxqg3e+UiHDLTKUWomG63D0zr7swOx0gS8oazzA+DN4ClLkRVArpDeA6N7aWtY+ITmd9x7g76aosXleCl5Ic+RFySgiWa1xW78mPf/jc7szq2fHFvr/kq2mgf+RQq4ob+Lk9hwvt8xvz6hhVCkqXhXBHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OISo9dodIMz8sW7VAQrqDdCaCbR7RTc/U3mOuUgMHnI=;
 b=yNtADZJ7HBa9xEZmzlur9FEP0NtGaGA88PZvPjyGPebgoquUwof80z5fET/XeAaWG1uZNaP9q9P9Lq59HHiIYVsgvnG5ny/kOwST6Ru2MqtIhIZIw34VCbHGcejAIN8qm21YCcDiwlXzCXdvEKbVnwzHEZNbKfhYrd/giPiJh2B1M3psb51SdQCo0kMl0cr5sNQXCiFArtqyLZhIq8UNocLaWMKsy3RPdPIA1ynMF3FtT5Ivn2ATyaO/eGQNVzu8u3DSJCnXJ9PUxNHDBCStpbnjZrHZtP6yZT2Br+xjM8DE4iYgTF+zmw2hIelyvaLC2TGXDcmJysYcTYDRV0ZMhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OISo9dodIMz8sW7VAQrqDdCaCbR7RTc/U3mOuUgMHnI=;
 b=c7NMiuCrHdgtXWqNDeO0jGfkWL+XMbzoh8ZcggHD+oUPwGtKpxDZIp7KEwALqzKN0Nt17jtxFF84htaiFpMK9uwzau9Fv84ymaGWS+Oe8EC+IaseaMvui8YechxmAAfTCAuSxHxnwa03c/qiZhjjtatrN9cL9ioBl4xoP0/QHbs=
Received: from BN9PR03CA0771.namprd03.prod.outlook.com (2603:10b6:408:13a::26)
 by CH3PR12MB9251.namprd12.prod.outlook.com (2603:10b6:610:1bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 23:40:09 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:13a:cafe::cf) by BN9PR03CA0771.outlook.office365.com
 (2603:10b6:408:13a::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Wed,
 11 Dec 2024 23:40:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 23:40:08 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 17:40:07 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <ming4.li@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>,
	<PradeepVineshReddy.Kodamati@amd.com>
Subject: [PATCH v4 0/15] Enable CXL PCIe Port protocol error handling and logging
Date: Wed, 11 Dec 2024 17:39:47 -0600
Message-ID: <20241211234002.3728674-1-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|CH3PR12MB9251:EE_
X-MS-Office365-Filtering-Correlation-Id: 0445121b-b4ae-427f-0f34-08dd1a3d25e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iX0EBy1YT6l2qbpeQalq29S+YF2PbrDCIyLAVseRceCzOSZ+FpwZbpdwBEFN?=
 =?us-ascii?Q?o8cGEbuF6Xb9G9rTwWwoai2Tiw3ZoxdgqW5WEqux1Wjqu6x+MVvsJ3y7CIqr?=
 =?us-ascii?Q?r3xM6FoIRI4Fr9DBPrj+OyeSe3AgbMRzeH8Te42EdkjUSOBRu0HpEHgtLERy?=
 =?us-ascii?Q?JWL4RcNlqLJsFL4qXw22iAseKoseOf6rXFMl8TgUn9DzlXE5ih91YHH8f2bG?=
 =?us-ascii?Q?/RmtLL0vxnpe3/SPMD/PNlDrhbFVMQK9TUfB1NRFsRUm3zQbiSmTDbwuuQBN?=
 =?us-ascii?Q?u+VTPwpU+kLCHzNiEAB2E7NfAMdOYJNzDxk4ZACJuqOS8OvACsRePAHVgWKK?=
 =?us-ascii?Q?VtsvQi56N/LJ01dHTGCht2CikuFN9Pf1yxYXRDsEtI25kml4+qOVFx5rhgx+?=
 =?us-ascii?Q?quZUN3Eriq/7B4/uv7qzIji0d8po5Ne7sJF/DSmlkrC7NcQnYj8TzVLoBxGH?=
 =?us-ascii?Q?oDe+oc7DNVDNKTOAbaVLV0n+2axLugxNmF8G6lqkc2977RIM8jDTlx/Uyvjf?=
 =?us-ascii?Q?1OP7gBFA5qkDeUUIvRue4uIMDe2XiW4sDndz1lnGbakcE4y6YCYi5t967pwC?=
 =?us-ascii?Q?eZIeESr+vm+Vw5v1Yj6P4jEgPchg5msSWMvMfxEoDBU/jQSvz+v5tVfBs29i?=
 =?us-ascii?Q?f68to+9CSCJCrMJpZ3uxFu2zdzXKrSbyxIBEwClTZVQxGnbdBtAc95HJpbv7?=
 =?us-ascii?Q?YaQrDH341a1yPDZP/4mFslLKelVy5WvILRcAidbvfQn2SiHv2TVHbV4HMUf8?=
 =?us-ascii?Q?sHtd69fPf3c9amd+WTSPCpiA36tfplt3rXIy5HHRocRUyJ9TbdI5FbYYXWrn?=
 =?us-ascii?Q?7Qb6GB8EdvZQawwWG4/nv2cnl2R7Q+KVdG4JbY0RqtffNm0VYZ6WqFSpIZVJ?=
 =?us-ascii?Q?Eoyu3OY/tmaTyOXT0YoeaVnPAk/vzj9irQ0X1yiBYG/36mZgE3InYMr51X7O?=
 =?us-ascii?Q?aconfMDmTIebFQRtBW6twV4o90ZQxtRCICCRTxk6DVhMGS8gzHpMd+2klUR3?=
 =?us-ascii?Q?XGtutfWYg1oNOpejA2rqWWg41ER0YDLAKffLiqmt03Qp/e9NvLVTQkxyvnnS?=
 =?us-ascii?Q?OMfGwcKiz+fKAyGKG7MGEu0XReSynwKwS+TVoAsAtN8IQ3GuTNWG1AqLFBOh?=
 =?us-ascii?Q?qMupP5aMwt+QaBE9mcegAOpi61rH2NZronhl5tbEfHRtrAf6GUx8NWO2osJ7?=
 =?us-ascii?Q?/BMuDsYyqfJ0lW2jOl4KZ5O02fyDPswxIWekYNM130DwnMN/OoTbCQRRMBaw?=
 =?us-ascii?Q?bU6h3UqP0+n/d5buW1yF5D/1D1f1rYD5gOYXj/WnMlT28rbWsgisLD/jyInb?=
 =?us-ascii?Q?HjgvMxd24HU6BIMXqXOuSdRfYexABWegJ8U3hjTTu0u+pO5uYhC3D0ctQn4J?=
 =?us-ascii?Q?ArOj3MuRStVx0ry+g3dZHJBz8cmKsvZUGH1bGImiMSiGgq/PoGAnRurAGtFq?=
 =?us-ascii?Q?5JmtjLbx3u1MDwv+47Y4ehLoMtAkLN8eTBL2gH/K4ZijatDBF4dUQw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 23:40:08.7080
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0445121b-b4ae-427f-0f34-08dd1a3d25e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9251

This is a continuation of the CXL Port error handling RFC from earlier.[1]
The RFC resulted in the decision to add CXL PCIe Port error handling to
the existing RCH Downstream Port handling in the AER service driver. This
patchset adds the CXL PCIe Port protocol error handling and logging.

The first 7 patches update the existing AER service driver to support CXL
PCIe Port protocol error handling and reporting. This includes AER service
driver changes for adding correctable and uncorrectable error support, CXL
specific recovery handling, and addition of CXL driver callback handlers.

The following 8 patches address CXL driver support for CXL PCIe Port
protocol errors. This includes the following changes to the CXL drivers:
mapping CXL Port and Downstream Port RAS registers, interface updates for
common Restricted CXL Host mode (RCH) and Virtual Hierarchy mode (VH),
adding Port specific error handlers, and protocol error logging.

Note, this patchset does not address CXL1.1/RCH-RCD error handling. The
plan is to update CXL1.1 handling in a separate following patchset. Future
CXL1.1 changes will be needed to reuse the CXL Port changes introduced
here. The changes in this patchset will not regress behavior or
functionality.

@Bjorn, can you please help take a look at patch#7 ('Add CXL PCIe Port
uncorrectable error recovery...')? This introduces cxl_walk_bridge()
because pci_walk_bridge() doesn't evaluate RP or DSP errors when passed as
the 'dev' parameter. Should pci_walk_bridge() be updated to evaluate RP and
DSP errors as done in cxl_walk_bridge()?

[1] - https://lore.kernel.org/linux-cxl/20240617200411.1426554-1-terry.bowman@amd.com/

Testing
=======
Below are test results for this patchset using Qemu with CXL Root
Port(0c:00.0), CXL Upstream Switchport(0d:00.0), CXL Downstream
Switchport(0e:00.0). 

This was tested using aer-inject updated to support CE and UCE internal
error injection. CXL RAS was set using a test patch (not upstreamed but can
provide if needed).

 == Root Port Correctable Error ==
 root@tbowman-cxl:~/aer-inject# ./root-ce-inject.sh
 pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0c:00.0
 pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0c:00.0
 pcieport 0000:0c:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
 pcieport 0000:0c:00.0:   device [8086:7075] error status/mask=00004000/0000a000
 pcieport 0000:0c:00.0:    [14] CorrIntErr
 aer_event: 0000:0c:00.0 CXL Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
 cxl_port_aer_correctable_error: device=0000:0c:00.0 host=pci0000:0c status='Received Error From Physical Layer'

 == Root Port UnCorrectable Error ==
 root@tbowman-cxl:~/aer-inject# ./root-uce-inject.sh
 pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0c:00.0
 pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0c:00.0
 pcieport 0000:0c:00.0: CXL Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
 pcieport 0000:0c:00.0:   device [8086:7075] error status/mask=00400000/02000000
 pcieport 0000:0c:00.0:    [22] UncorrIntErr
 aer_event: 0000:0c:00.0 CXL Bus Error: severity=Fatal, Uncorrectable Internal Error, TLP Header=Not available
 cxl_port_aer_uncorrectable_error: device=0000:0c:00.0 host=pci0000:0c status: 'Memory Address Parity Error' first_error: 'Memory Address Parity Error'
 Kernel panic - not syncing: CXL cachemem error.
 CPU: 10 UID: 0 PID: 148 Comm: irq/24-aerdrv Tainted: G            E      6.12.0-rc7-cxl-port-err-00016-g7ce90d33afcd #4727
 Tainted: [E]=UNSIGNED_MODULE
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
 Call Trace:
  <TASK>
  dump_stack_lvl+0x27/0x90
  dump_stack+0x10/0x20
  panic+0x33e/0x380
  cxl_do_recovery+0x122/0x130
  ? srso_return_thunk+0x5/0x5f
  aer_isr+0x64f/0x700
  ? free_cpumask_var+0x9/0x10
  ? kfree+0x259/0x2e0
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
 Kernel Offset: 0x33600000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
 ---[ end Kernel panic - not syncing: CXL cachemem error. ]---

 == Upstream Port Correctable Error ==
 root@tbowman-cxl:~/aer-inject# ./us-ce-inject.sh
 pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0d:00.0
 pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0d:00.0
 pcieport 0000:0d:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
 pcieport 0000:0d:00.0:   device [19e5:a128] error status/mask=00004000/0000a000
 pcieport 0000:0d:00.0:    [14] CorrIntErr
 aer_event: 0000:0d:00.0 CXL Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
 cxl_port_aer_correctable_error: device=0000:0d:00.0 host=0000:0c:00.0 status='Received Error From Physical Layer'

 == Upstream Port UnCorrectable Error ==
 root@tbowman-cxl:~/aer-inject# ./us-uce-inject.sh
 pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0d:00.0
 pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0d:00.0
 pcieport 0000:0d:00.0: CXL Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
 pcieport 0000:0d:00.0:   device [19e5:a128] error status/mask=00400000/02000000
 pcieport 0000:0d:00.0:    [22] UncorrIntErr
 aer_event: 0000:0d:00.0 CXL Bus Error: severity=Fatal, Uncorrectable Internal Error, TLP Header=Not available
 cxl_port_aer_uncorrectable_error: device=0000:0d:00.0 host=0000:0c:00.0 status: 'Memory Address Parity Error' first_error: 'Memory Address Parity Error'
 Kernel panic - not syncing: CXL cachemem error.
 CPU: 10 UID: 0 PID: 150 Comm: irq/24-aerdrv Tainted: G            E      6.12.0-rc7-cxl-port-err-00016-g7ce90d33afcd #4727
 Tainted: [E]=UNSIGNED_MODULE
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
 Call Trace:
  <TASK>
  dump_stack_lvl+0x27/0x90
  dump_stack+0x10/0x20
  panic+0x33e/0x380
  cxl_do_recovery+0x122/0x130
  ? srso_return_thunk+0x5/0x5f
  aer_isr+0x64f/0x700
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
 Kernel Offset: 0x2c400000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
 ---[ end Kernel panic - not syncing: CXL cachemem error. ]---

 == Downstream Port Correctable Error ==
 root@tbowman-cxl:~/aer-inject# ./ds-ce-inject.sh
 pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0e:00.0
 pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0e:00.0
 pcieport 0000:0e:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
 pcieport 0000:0e:00.0:   device [19e5:a129] error status/mask=00004000/0000a000
 pcieport 0000:0e:00.0:    [14] CorrIntErr
 aer_event: 0000:0e:00.0 CXL Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
 cxl_port_aer_correctable_error: device=0000:0e:00.0 host=0000:0d:00.0 status='Received Error From Physical Layer'

 == Downstream Port UnCorrectable Error ==
 root@tbowman-cxl:~/aer-inject# ./ds-uce-inject.sh
 pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0e:00.0
 pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0e:00.0
 pcieport 0000:0e:00.0: CXL Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
 pcieport 0000:0e:00.0:   device [19e5:a129] error status/mask=00400000/02000000
 pcieport 0000:0e:00.0:    [22] UncorrIntErr
 aer_event: 0000:0e:00.0 CXL Bus Error: severity=Fatal, Uncorrectable Internal Error, TLP Header=Not available
 cxl_port_aer_uncorrectable_error: device=0000:0e:00.0 host=0000:0d:00.0 status: 'Memory Address Parity Error' first_error: 'Memory Address Parity Error'
 Kernel panic - not syncing: CXL cachemem error.
 CPU: 10 UID: 0 PID: 148 Comm: irq/24-aerdrv Tainted: G            E      6.12.0-rc7-cxl-port-err-00016-g7ce90d33afcd #4727
 Tainted: [E]=UNSIGNED_MODULE
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
 Call Trace:
  <TASK>
  dump_stack_lvl+0x27/0x90
  dump_stack+0x10/0x20
  panic+0x33e/0x380
  cxl_do_recovery+0x122/0x130
  ? srso_return_thunk+0x5/0x5f
  aer_isr+0x64f/0x700
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
 Kernel Offset: 0x5800000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
 ---[ end Kernel panic - not syncing: CXL cachemem error. ]---

 Changes
 =======
 Changes in v3 -> v4
 [Lukas] Capitalize PCIe and CXL device names as in specifications
 [Lukas] Move call to pcie_is_cxl() into cxl_port_devsec()
 [Lukas] Correct namespace spelling
 [Lukas] Removed export from pcie_is_cxl_port()
 [Lukas] Simplify 'if' blocks in cxl_handle_error()
 [Lukas] Change panic message to remove redundant 'panic' text
 [Ming] Update to call cxl_dport_init_ras_reporting() in RCH case
 [lkp@intel] 'host' parameter is already removed. Remove parameter description too.
 [Terry] Added field description for cxl_err_handlers in pci.h comment block

 Changes in v2 -> v3
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
 [Jonathan] Change to use 2 cxl_port declarations in cxl_pci_port_ras()
 [Jonathan] Fix spacing in 'struct cxl_error_handlers' declaration.
 
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
  PCI/AER: Rename AER driver's interfaces to also indicate CXL PCIe Port
    support
  cxl/pci: Introduce PCIe helper functions pcie_is_cxl() and
    pcie_is_cxl_port()
  PCI/AER: Modify AER driver logging to report CXL or PCIe bus error
    type
  PCI/AER: Add CXL PCIe Port correctable error support in AER service
    driver
  PCI/AER: Change AER driver to read UCE fatal status for all CXL PCIe
    Port devices
  PCI/AER: Add CXL PCIe Port Uncorrectable Error recovery in AER service
    driver
  cxl/pci: Map CXL PCIe Root Port and Downstream Switch Port RAS
    registers
  cxl/pci: Map CXL PCIe Upstream Switch Port RAS registers
  cxl/pci: Update RAS handler interfaces to also support CXL PCIe Ports
  cxl/pci: Change find_cxl_port() to non-static
  cxl/pci: Add error handler for CXL PCIe Port RAS errors
  cxl/pci: Add trace logging for CXL PCIe Port RAS errors
  cxl/pci: Add support to assign and clear pci_driver::cxl_err_handlers
  PCI/AER: Enable internal errors for CXL Upstream and Downstream Switch
    Ports

 drivers/cxl/core/core.h       |   3 +
 drivers/cxl/core/pci.c        | 186 +++++++++++++++++++++++++++-------
 drivers/cxl/core/port.c       |   4 +-
 drivers/cxl/core/trace.h      |  47 +++++++++
 drivers/cxl/cxl.h             |  10 +-
 drivers/cxl/mem.c             |  39 ++++++-
 drivers/pci/pci.c             |  13 +++
 drivers/pci/pci.h             |   3 +
 drivers/pci/pcie/aer.c        | 107 +++++++++++--------
 drivers/pci/pcie/err.c        |  54 ++++++++++
 drivers/pci/probe.c           |  10 ++
 include/linux/aer.h           |   1 +
 include/linux/pci.h           |  14 +++
 include/ras/ras_event.h       |   9 +-
 include/uapi/linux/pci_regs.h |   3 +-
 15 files changed, 417 insertions(+), 86 deletions(-)


base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
-- 
2.34.1


