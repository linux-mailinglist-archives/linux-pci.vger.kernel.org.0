Return-Path: <linux-pci+bounces-19425-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3729BA042BC
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 15:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A0051882AEA
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 14:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D28A1EE035;
	Tue,  7 Jan 2025 14:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hSXA92Os"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBD51D958E;
	Tue,  7 Jan 2025 14:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736260747; cv=fail; b=UiMV40zdu7gRLMq3KzsPDSxzkD1yBXayoK/rYeFk2nA9nqsArNPgEY4VWpXNXIcLtKJLYJAYDsJjov4gPYZe9usqbYLI+lQHLfHtVQyfhD+HHMMMWJhcqqgvszMkyROS19VYK6E2bEd90CkFjXj7YGLwRKaDSF2Cq7o+8oJO5m4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736260747; c=relaxed/simple;
	bh=9GAdFifx2MChB3eC7x07ZV114NPf7dd6b0FKjAETQLQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KzInoABxDqPVNgmeiszhuOByxKICGj8u7KIqnKXSsEfqIbPrJOKD5ApoWBcG+61d7gVnMkbTi72sV5VCNBnlGR4wCYpqLxEOI00RRhwOO+xF/UA8rMixyv4uTOyqSruDeO6fHXycdrurksSa19k5bWv9KXHoSZAV9DWWeo0ZKd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hSXA92Os; arc=fail smtp.client-ip=40.107.93.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qSeI8fXoLugkEvecK+Cdz/RW0Lm3NhGRr39jEXCrWb1+MlhpuNPC5nIxCnaOdW+AVcP20hXzSOX7SkrHtWZ8Pp9VXJx4Y+qRizkgV/MqC6aFjfqvMcNobFzYjqv3/yb9FJdvFJSBj+rStJo11ovshUOhjeH8TTBt28Fu6xbI4KDr/q2H1swED0DWX7X67iNjjCgCLkQpWdJf6wTIFbx6e20oNDdA840uIEdkwlzV43XB57G1dTNLutzlCodLfmHAE1yL0gm+XNB6uqMpMYqA9mvdVO5ZGOkROKPjq9pBJoAWtf96eoUWN3s0Kc8eX9TgNpHutRHBF975ZiSZnFlVTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83A4Ab2kHW+7L6zjIN3UQY1HiWlUxb8uRUdWbfi7AhI=;
 b=sbupxMZbSXxougjOUFD8Jp9EUUCXBnQOSpowZjODo7+rv3m6hCMmG7m9ioTpxkpZ5V5sshs8THRT0ksAFtpBrvlSDPZnykBzbHPlN0ljlRRrqxonqKMPlwUGHBG9mOJS2MCpVs3tJeqrPTzxOE1TPDCdOSoOJDkqVAGd5E+z/YMkDMZGfDowcKUL9pHn4LZF8uB+13yWpVR7eepkVHlApgixBkJA2gjLcxn5ZhH4wLC1Z2/WDyY8hIKcF9RmjQbdCf/r+hSkQaa3XszkyqOROOW0+Res0Q/0zaUdvg8kDl4E1VsbX8ga8QeAF21J2DT8zAXK4Ry1UJKup+37bCaynw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83A4Ab2kHW+7L6zjIN3UQY1HiWlUxb8uRUdWbfi7AhI=;
 b=hSXA92Osj3ITX9UJquY4Gr1unVr/5Tht+wOPWdzsyMQebDSGcUgOEKKY+YyFgjAUIDBcFdJIQbGgXSdmuINAwb7wvwyvAHlLtLugjxSfw+sS9ZbfI2GEcm6Mk0VOYgrNsnyTS2YOWQqfke/Ac27LoCYIP7sj4L9boZVM6tC5+vc=
Received: from MN2PR08CA0019.namprd08.prod.outlook.com (2603:10b6:208:239::24)
 by CH2PR12MB4261.namprd12.prod.outlook.com (2603:10b6:610:a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Tue, 7 Jan
 2025 14:38:59 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:208:239:cafe::ea) by MN2PR08CA0019.outlook.office365.com
 (2603:10b6:208:239::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.17 via Frontend Transport; Tue,
 7 Jan 2025 14:38:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.0 via Frontend Transport; Tue, 7 Jan 2025 14:38:58 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 08:38:57 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>,
	<ming.li@zohomail.com>, <PradeepVineshReddy.Kodamati@amd.com>,
	<alucerop@amd.com>
Subject: [PATCH v5 0/16] Enable CXL PCIe port protocol error handling and logging
Date: Tue, 7 Jan 2025 08:38:36 -0600
Message-ID: <20250107143852.3692571-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|CH2PR12MB4261:EE_
X-MS-Office365-Filtering-Correlation-Id: f0eb3809-d838-4fbf-25f9-08dd2f29056c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fUnkfsvRVBJdDgAvDrLkxM9+QThp+83tU0HGpQy/f/yv/RY2PLWtuJl5H2tA?=
 =?us-ascii?Q?3gXygvOxUmrLMbc0nVVzPPpkYOreITSJd9BK1EGR2w70sPgqoFn6bYcWlCGu?=
 =?us-ascii?Q?4ocMDxNWk7ILmBTHBkI86rQNsNj+gtEAJvUZHppnoj6sFZITyr0RBlTLAsPT?=
 =?us-ascii?Q?fvLrrcyzcbA8Gxc4OUlwv5ez5fMMTp+PI7Rq+l3Ou0O+REJbJFTZ49MrgpKL?=
 =?us-ascii?Q?xkux/Kyyu3zQLtXuKYYGPUWDTEjqR2dSX1MRPyNhrtTAy3pRVKsOqfDHf2M7?=
 =?us-ascii?Q?uwEFkDByRANc2SwA33DK8WItHnpKdTxNvHi+ZBs5JZ/+rWlHpJeh/EEzlWAU?=
 =?us-ascii?Q?kaca5PN4bmXlv2MGe71ENV5FLaEBaAq4J9BfTBXAXtbaBWHJpRKODBRM3jpS?=
 =?us-ascii?Q?LVWoBKLpwKMhZ4PYX7uaUZ5BzTC4crKh5yKOF5hYL85gGFgIWKeXWfH+trTm?=
 =?us-ascii?Q?fyFSIn5tdOiIdYhk5JAYyOI4fT8VGcp5rTAlAl0q8bL0f+1tEyPtsE+sPYRM?=
 =?us-ascii?Q?lJ+i575u8WH2r9jn4M/92p2wrx8GYni70ikgBkO2nLMoKauG4avmWSmSNH65?=
 =?us-ascii?Q?pO34RYlhgkRwdUhn2gCgnpze9+LaxKgxEpmXyc9jddfp180IWlJAigiE0zoH?=
 =?us-ascii?Q?hmt1H4zHO6FSAGyWWdh8LWyjvz3S7ynKkEJ5G7gMAiPRIHODXKwBYuFbvcsX?=
 =?us-ascii?Q?zMfVZmbIt9VY4d1jQAhAADyGty9oJLzlDfpOuY//L6G6e9/tAQ2YNSdXN+cq?=
 =?us-ascii?Q?xBKyeVVR1GHGte/s/QW9IZtXnLMuleBFy+IikBNYnB/CrgGklbnQfOwXqaJL?=
 =?us-ascii?Q?+7FyZmgQD+59SsaFt3IwV/KMdhYZDmPmi/iu7OMRfxd4gNKnZaSu9zFvAeBn?=
 =?us-ascii?Q?xevXptCY4nVkyvBgSkHr8+na7rUC7uhA0D3eJsG/z7s73kwQNw/MlivmW9rO?=
 =?us-ascii?Q?ZWgdobP2ByOOKntqAXziawUmxJMcIVEi0ikB+dyxcVpQKQjJcp9eYYbebJXS?=
 =?us-ascii?Q?z1bkt4fgvBuqdAuJXIYSuYICXJRwb6+wXQSBsuFZ0akGqmGC8DKEQl4wyq1a?=
 =?us-ascii?Q?N8pXzYIzHzRXvVMxJvUY9igU/q1TiV3NKEIFtbQHN4MRuSwUpsBVON/vnzE/?=
 =?us-ascii?Q?VHLVrST+gKnordXF/A2ITJFQCq6N9D8AqGO937XP+GC9OkEIrLsMgDVTzBaX?=
 =?us-ascii?Q?mgF0n/5SaTTMyXaWUVuc4+Vjm3AMorOYKOSZte2CVTSZIrFF5qQ7M0DiWFEV?=
 =?us-ascii?Q?v5Zq7aAMsfVcpOco5y3L1IFzKLHEyJxuck0tgAlMc65cM0/z72LeBWSEeIPI?=
 =?us-ascii?Q?l3qdNcAnohfHhUMlKhAHmLtasyObZnOtX842jetvhd3HMIig5Jfb/7xwSNaR?=
 =?us-ascii?Q?SJHQ/hIkodJELmyr6krg5a4sOUNwJcXFaYb+w7nT1D1akQp+89H/WT160bvn?=
 =?us-ascii?Q?9IRTzYbcN2EB3jyCk9Q2HR1U8HmCUQdE/ma9aHOr/p04Ph1Rbz0VrdtMaNNS?=
 =?us-ascii?Q?FQNS9kOgZeXSGKNtXjRg/IdERW7VUzn2ig/h?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 14:38:58.6991
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0eb3809-d838-4fbf-25f9-08dd2f29056c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4261

This is a continuation of the CXL Port error handling RFC from earlier.[1]
The RFC resulted in the decision to add CXL PCIe Port Protocol Error
handling to the existing RCH Downstream Port handling in the AER service
driver. This patchset adds the CXL PCIe Port Protocol Error handling and
logging.

The first 7 patches update the existing AER service driver to support CXL
PCIe Port Protocol Error handling and reporting. This includes AER service
driver changes for adding correctable and uncorrectable error support, CXL
specific recovery handling, and addition of CXL driver callback handlers.

The following 9 patches address CXL driver support for CXL PCIe Port
Protocol Errors. This includes the following changes to the CXL drivers:
mapping CXL Port and Downstream Port RAS registers, interface updates for
common CXL Restricted host (RCH) and virtual hierarchy (VH) modes,
adding CXL Port Protocol Error handlers, and Protocol Error logging.

Note, this patchset does not completely refactor RCH Protocol Error
handling. The plan is to update the RCH handling in the future to use the
same handling path introduced here. 

[1] - https://lore.kernel.org/linux-cxl/20240617200411.1426554-1-terry.bowman@amd.com/

Testing:
========
Below are test results for this patchset using QEMU with CXL Root
Port(RP, 0C:00.0), CXL Upstream Switch Port(USP, 0D:00.0), and CXL
Downstream Switch Port(DSP, 0E:00.0). 

The topology is:
                   ---------------------
		   | CXL RP - 0C:00.0  |
                   ---------------------
                             |
                   ---------------------
		   | CXL USP - 0D:00.0 |
                   ---------------------
                             |
                   ---------------------
		   | CXL DSP - 0E:00.0 |
                   ---------------------
                             |
                   ---------------------
		   | CXL EP - 0F:00.0  |	
                   ---------------------

root@tbowman-cxl:~# lspci -t
-+-[0000:00]-+-00.0
 |           +-01.0
 |           +-02.0
 |           +-03.0
 |           +-1f.0
 |           +-1f.2
 |           \-1f.3
 \-[0000:0c]---00.0-[0d-0f]----00.0-[0e-0f]----00.0-[0f]----00.0

The topology was created with:
 ${qemu} -boot menu=on \
            -cpu host \
            -nographic \
            -monitor telnet:127.0.0.1:1234,server,nowait \
            -M virt,cxl=on \
            -chardev stdio,id=s1,signal=off,mux=on -serial none \
            -device isa-serial,chardev=s1 -mon chardev=s1,mode=readline \
            -machine q35,cxl=on \
            -m 16G,maxmem=24G,slots=8 \
            -cpu EPYC-v3 \
            -smp 16 \
            -accel kvm \
            -drive file=${img},format=raw,index=0,media=disk \
            -device e1000,netdev=user.0 \
            -netdev user,id=user.0,hostfwd=tcp::5555-:22 \
            -object memory-backend-file,id=cxl-mem0,share=on,mem-path=/tmp/cxltest.raw,size=256M \
            -object memory-backend-file,id=cxl-lsa0,share=on,mem-path=/tmp/lsa0.raw,size=256M \
            -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
            -device cxl-rp,port=0,bus=cxl.1,id=root_port0,chassis=0,slot=0 \
            -device cxl-upstream,bus=root_port0,id=us0 \
            -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
            -device cxl-type3,bus=swport0,volatile-memdev=cxl-mem0,lsa=cxl-lsa0,id=cxl-vmem0 \
            -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k

 This was tested using the aer-inject tool updated to support CE and UCE
 internal Protocol Error injection. CXL port RAS was set using a test patch (not
 upstreamed but can provide if needed).

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
 Kernel panic - not syncing: CXL cachemem error.
 CPU: 10 UID: 0 PID: 149 Comm: irq/24-aerdrv Tainted: G            E      6.13.0-rc2-cxl-port-err-g0161162f683c #4833
 Tainted: [E]=UNSIGNED_MODULE
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
 Call Trace:
  <TASK>
  dump_stack_lvl+0x27/0x90
  dump_stack+0x10/0x20
  panic+0x33e/0x380
  ? srso_return_thunk+0x5/0x5f
  cxl_do_recovery+0x117/0x120
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
 Kernel Offset: 0x19c00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
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
 systemd-journald[483]: Sent WATCHDOG=1 notification.
 cxl_port_aer_uncorrectable_error: device=0000:0d:00.0 host=0000:0c:00.0 status: 'Memory Address Parity Error' first_error: 'Memory Address Parity Error'
 Kernel panic - not syncing: CXL cachemem error.
 CPU: 10 UID: 0 PID: 147 Comm: irq/24-aerdrv Tainted: G            E      6.13.0-rc2-cxl-port-err-g0161162f683c #4833
 Tainted: [E]=UNSIGNED_MODULE
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
 Call Trace:
  <TASK>
  dump_stack_lvl+0x27/0x90
  dump_stack+0x10/0x20
  panic+0x33e/0x380
  cxl_do_recovery+0x117/0x120
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
 Kernel Offset: 0x13e00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
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
 CPU: 10 UID: 0 PID: 148 Comm: irq/24-aerdrv Tainted: G            E      6.13.0-rc2-cxl-port-err-g0161162f683c #4833
 Tainted: [E]=UNSIGNED_MODULE
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
 Call Trace:
  <TASK>
  dump_stack_lvl+0x27/0x90
  dump_stack+0x10/0x20
  panic+0x33e/0x380
  cxl_do_recovery+0x117/0x120
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
 Kernel Offset: 0x1bc00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
 ---[ end Kernel panic - not syncing: CXL cachemem error. ]---

 Changes
 =======
 Changes in v4 -> v5:
 [Alejandro] Refactor cxl_walk_bridge to simplify 'status' usage
 [Alejandro] Add WARN_ONCE() in __cxl_handle_ras() and cxl_handle_cor_ras()
 [Ming] Remove unnecessary NULL check in cxl_pci_port_ras()
 [Terry] Add failure check for call to to_cxl_port() in cxl_pci_port_ras()
 [Ming] Use port->dev for call to devm_add_action_or_reset() in
 cxl_dport_init_ras_reporting() and cxl_uport_init_ras_reporting()
 [Jonathan] Use get_device()/put_device() to prevent race condition in
 cxl_clear_port_error_handlers() and cxl_clear_port_error_handlers()
 [Terry] Update commit messages with uppercasing CXL and PCI terms
 
 Changes in v3 -> v4:
 [Lukas] Capitalize PCIe and CXL device names as in specifications
 [Lukas] Move call to pcie_is_cxl() into cxl_port_devsec()
 [Lukas] Correct namespace spelling
 [Lukas] Removed export from pcie_is_cxl_port()
 [Lukas] Simplify 'if' blocks in cxl_handle_error()
 [Lukas] Change panic message to remove redundant 'panic' text
 [Ming] Update to call cxl_dport_init_ras_reporting() in RCH case
 [lkp@intel] 'host' parameter is already removed. Remove parameter description too.
 [Terry] Added field description for cxl_err_handlers in pci.h comment block

 Changes in v2 -> v3:
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
 
 Changes in v1 -> v2:
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

Terry Bowman (16):
  PCI/AER: Introduce 'struct cxl_err_handlers' and add to 'struct
    pci_driver'
  PCI/AER: Rename AER driver's interfaces to also indicate CXL PCIe Port
    support
  CXL/PCI: Introduce PCIe helper functions pcie_is_cxl() and
    pcie_is_cxl_port()
  PCI/AER: Modify AER driver logging to report CXL or PCIe bus error
    type
  PCI/AER: Add CXL PCIe Port correctable error support in AER service
    driver
  PCI/AER: Change AER driver to read UCE fatal status for all CXL PCIe
    Port devices
  PCI/AER: Add CXL PCIe Port uncorrectable error recovery in AER service
    driver
  cxl/pci: Map CXL PCIe Root Port and Downstream Switch Port RAS
    registers
  cxl/pci: Map CXL PCIe Upstream Switch Port RAS registers
  cxl/pci: Update RAS handler interfaces to also support CXL PCIe Ports
  cxl/pci: Add log message for umnapped registers in existing RAS
    handlers
  cxl/pci: Change find_cxl_port() to non-static
  cxl/pci: Add error handler for CXL PCIe Port RAS errors
  cxl/pci: Add trace logging for CXL PCIe Port RAS errors
  cxl/pci: Add support to assign and clear pci_driver::cxl_err_handlers
  PCI/AER: Enable internal errors for CXL Upstream and Downstream Switch
    Ports

 drivers/cxl/core/core.h       |   3 +
 drivers/cxl/core/pci.c        | 206 ++++++++++++++++++++++++++++------
 drivers/cxl/core/port.c       |   4 +-
 drivers/cxl/core/trace.h      |  47 ++++++++
 drivers/cxl/cxl.h             |  10 +-
 drivers/cxl/mem.c             |  39 ++++++-
 drivers/pci/pci.c             |  13 +++
 drivers/pci/pci.h             |   3 +
 drivers/pci/pcie/aer.c        | 107 +++++++++++-------
 drivers/pci/pcie/err.c        |  54 +++++++++
 drivers/pci/probe.c           |  10 ++
 include/linux/aer.h           |   1 +
 include/linux/pci.h           |  14 +++
 include/ras/ras_event.h       |   9 +-
 include/uapi/linux/pci_regs.h |   3 +-
 15 files changed, 435 insertions(+), 88 deletions(-)


base-commit: 2f84d072bdcb7d6ec66cc4d0de9f37a3dc394cd2
-- 
2.34.1


