Return-Path: <linux-pci+bounces-40156-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3740BC2E84B
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 01:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB1764E10AE
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 00:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E3F21348;
	Tue,  4 Nov 2025 00:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V8dHheF0"
X-Original-To: linux-pci@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010047.outbound.protection.outlook.com [52.101.46.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CA717993;
	Tue,  4 Nov 2025 00:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762215016; cv=fail; b=J/XFbRHgS0h2e0Ofe+0L1H840NikgRi5UvcQemu8gjvEDT0WBcxRNDwBpvH77iqb4ISLXD5uDOMlX3QrGjoOzRYQMn7d4fiSd8iJplfAT4gcoJE46Cf7678QfS8nfub6iSkynq70wRf6NSm3hs/8QiZqQsEz5h8GrUTiQh7cLLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762215016; c=relaxed/simple;
	bh=JdwXXCpWNODHley8WpqAvSKxgzMyjBn1CyE4N1aoVF8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Xd6JabVcfeDQGpOSDk++y8FGrsBx/oEkfowKZ0pc6g5md5sKlC3CIAV8u4dQxolLwZErR6gNTrCSSXDUCih4GxiKNxtvCDa1wVcgPikf9i9bzoDdl+0GYyVUXANBS1Y7UwL6dWN+EnK7TkMU/f42ZuKS8Tb3eZg1mBES2oqyDn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V8dHheF0; arc=fail smtp.client-ip=52.101.46.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KuB1KV9J3dvWiCqneRcZf+9sctSoaXARyIR+14lNEo+dZDP6f1m86mmHtE9L3sLlmqTt2Qn7p0mipWBsKw28MemoP2VwI0GwRmUSCwkNG2y56TbrakHgYcXkIM5LcbIZUefYIh0qlkkUyvhh0Wa7vAHh1rZUsz+78te+DS+s0zZaka7DdQm2+LYLAK4o1ZdZ+kR3ocS0Dt2LycHkcf3bQlmOBQw67KdXcTycXujfnSuLpaUzDlc/HiIwNPQ6hrZ4fv5UivAVmO4xsSUuJlyPS/K8mvy0IGDqcz8kXF8HM7pvKZg4gMJ42zT3cnAEzwNgJ1aA+Dp/ygIMKAA+AfhuRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+c5JzoR8XmVOV13Lkngs/hcXe1CSwsRz/K2moMLIsw=;
 b=TA1Rv77jockRCh3W4wVr6oWoOvEQprd96TGqbgYgkSg+4q8VssXDH2ZVkl9/MfpqDTranPKG1k5H/GHYZqEWJCkdygxY077RntA1whXSJZI6HXfudIShO7SWBOBV+ZcxpzTLQx4bA9MhzM6Y8tGyaddh+K0jGIJOFktBcsAqhkVDBRM3VdIFTXCqsNzvO3EIWzaKYR3Kk5UbRUFkELVHY2y5ztjuzlzgxfZkqBg3Qazy2F4SUV1sR1d9PNoazn0JJOzzQhEzgkR+B3Uk8Ti33MiNTTtklKPEoJl8Lp3lFFM7nNzcPCkSOEAWhkksg8Yu/U3pJ0MsDz2cIy7GbwE0Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+c5JzoR8XmVOV13Lkngs/hcXe1CSwsRz/K2moMLIsw=;
 b=V8dHheF0lMuZr/MdEv2B1TrU08MGsfRUkNvOP265f2RTIr4Hhqd2yeZ9retqWOHjmblZ3RUsaKiiwDanfkxT4OSdGp7xUzkU7pZdR9IMiVbkjZS8vVLkSopv24LXJAoyaAcENewd2N37WE4YKbJMIMXrkWG3QB3E98KnWq3FblA=
Received: from CH0PR13CA0009.namprd13.prod.outlook.com (2603:10b6:610:b1::14)
 by DM4PR12MB6088.namprd12.prod.outlook.com (2603:10b6:8:af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Tue, 4 Nov
 2025 00:10:08 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::8c) by CH0PR13CA0009.outlook.office365.com
 (2603:10b6:610:b1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 00:10:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 00:10:07 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 3 Nov
 2025 16:10:06 -0800
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [PATCH v13 00/25] Enable CXL PCIe Port Protocol Error handling and logging
Date: Mon, 3 Nov 2025 18:09:36 -0600
Message-ID: <20251104001001.3833651-1-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|DM4PR12MB6088:EE_
X-MS-Office365-Filtering-Correlation-Id: 512d4d06-2ba2-41e4-f0ef-08de1b36836d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGFBWGxoY1hYV1NnZUVZOFFkRVV6SmpmWmJkWWZRYnVmQXBjMlZMS01MQkJv?=
 =?utf-8?B?d0NEdzhvRmRnKzd2M2hySVlQbU5VTmlZT3hTMHpqVWdzWldGZFUrME9oekhu?=
 =?utf-8?B?djM5eDQ5a0Fzd1IxcEV5WFFIZndtUXdDdDFOOU5TN05UTWlWNnRHOC9CM3hh?=
 =?utf-8?B?K0wvdmtoNjlQOE4rdU83eXhLaWVhNDIyNjA2T2tMSTB0OXJvcTExRjgzc1Z1?=
 =?utf-8?B?cCtLbEllbGpiMGszSXFlTWxhS2hTSmpQZUowNDQ0ZlpUdzNnZllxMlFvblE5?=
 =?utf-8?B?dWRVaXhZU2RDcDRCQy9HakgwbzhjNDg4VjE3SXp3UnZ5Y2FmS2ZrSmhMSGlD?=
 =?utf-8?B?NFZSdVliclF5UVB4K0w1dmhoMS94UTBwN1NvbTBZeVQ3aWN0Uk5kbXlmVndT?=
 =?utf-8?B?SmlEL0pwNFZxTVVoUUdNa1JLcDd6NVM3SFlEOXE1UElabXFhNHhjc0o2VWwx?=
 =?utf-8?B?dkJTb25lQjJxdFRreklsUG5hY0F1QS9mclBzZzhpTm5NbEM4eU5ON0Y5enFV?=
 =?utf-8?B?OVluN3dEQ0FiWWVadGNBeUFFRVBZY0wrbWxkaFNIRklkVTNUeTVQM05YTGJh?=
 =?utf-8?B?MkN0Y0FCTlpTSkNKQno0YkhsRzZqYks5S2NBNDl3K1AwSStGeUNxbG1oVDRB?=
 =?utf-8?B?dExLenRnSWxhT0xmSnEyaUpCMmFFczhKdk9MSmpvUC9odzloNHJac2dCejNK?=
 =?utf-8?B?ZDJIbDE2dUxWYUl1aklmZzIrUmFTeU5DUGlMSmQyZHJ1TXFFMmdZU1RwZWFu?=
 =?utf-8?B?Y3pRQkRLdHBnam82ZG01VkQwQm5SWWVQdEhvWDFLSVB5eFJWQzRQOXAyWWVS?=
 =?utf-8?B?Ukt0dDhDaVgyeUpvVXMzS2F4V1dCVGcvWEZ1eU9yaG5GTVQ1QUVId3ZYZGJl?=
 =?utf-8?B?bUZyeENZU0VTdDE4bUM3VXBjbkRCS0NkK0NmNks3NFk5TVFldW0vVlpudkNU?=
 =?utf-8?B?aFNlZS85ckJKNmRuQThoekpnTHh4RTdKQmFmK2tkcVBkNmw3dWNMQmo4RURk?=
 =?utf-8?B?RDhMOVQ0RSt2d2FmUUgvSzhXWmRkZEdSeXBHUU9lakw3RFR1Um51TXIvTWZX?=
 =?utf-8?B?bjh5cjJJVkt3MzB0blJEcFovSUtxcGp6S3BlL3g0MEhrdzFUb2l2ajRnOUsx?=
 =?utf-8?B?cDZnUUVweXpidW5rUS9UVkF4OWQrMkl4enNRNG1BNTBXK3kxaFFyVVU4MHh3?=
 =?utf-8?B?bWVsMDR6SUUxTUZoc2M2NGh5bHFQUTFaaDYyeXBoSFZhaVphUDk4QXY4NFNi?=
 =?utf-8?B?YVlDY2F0NUhXcnRrbE0wbE43RFl3TW5LaFl1QVU3Z3FpMVZHWnVqd2hBQ2I0?=
 =?utf-8?B?VVBCTHZDVmo4TW1hQWFzMElJWkswSGh2a1Zhd3JrMjl5eUZ3UHZGR21Kdm5q?=
 =?utf-8?B?WGIvRzZEa2RPaHBYZnhPOWVGekpVZWxMR0YyRGhEdjYzUzI2a1JUOFh5ODNH?=
 =?utf-8?B?VVc0TWNieEpIa2FHV2dTVEZNa3hka1o2Ris5TUtPamxKLzJ2K3I5b2t6YmJI?=
 =?utf-8?B?T3JYNkhSaXhGd2NILzdNOTFpOXFkRFlQZVdGeDRrVDZ6Vjh1Rm0yYTMwNkJm?=
 =?utf-8?B?Z2hrYVZxTGZMYzM5Sk96V0dMOVdOWjhrYkU4bnNzcE1VMVBPZ3RJWUN6Uk1L?=
 =?utf-8?B?cXZWSFFES3FiU1dxd1pFWHJyQm5pVitmMTRzeXo3TGVNQkEwaGNjak92TEpB?=
 =?utf-8?B?TDVETGxQdm5mMXVPdTBhL254OGI0VUN1dmI5aEVBck1wVTM5N2dDQ1FFNEhZ?=
 =?utf-8?B?VVBzaWgrQU5YYTZTVjlWUStoeGMvUU5DV0lDdlZBbEJxT2MwNHovMnlqUmhX?=
 =?utf-8?B?NUFWbW1LRXV0VXNGeE9HdEFtNzZRVGhpWm9nQStpR2FoTTFhZk5HTjMySkRu?=
 =?utf-8?B?K2lrZG5GdEFaL0JtbW1rNnFTUHBjcXJWTG5iOEtMQUd5aHVZR1JVdW9FSjV4?=
 =?utf-8?B?bUd0V1p0V3pwZFpReWJWQW0vOGpEQU5iSlM1a2o3NWNyczNEZVo5dC83T2Za?=
 =?utf-8?B?RDV5cEJmR0FIcnpzbVJIUXlZMHNUMEZZZ21DV1MrSEtidmVBeTZSN0ZMeXd1?=
 =?utf-8?B?Y25hZzRSYkg2d04vN1RuSHhkODd1czBzQlVUVUNxZ01OWUZtdDllLzVob3NU?=
 =?utf-8?Q?naYeYnfH+q96k5vvfus1qjSXx?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 00:10:07.9862
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 512d4d06-2ba2-41e4-f0ef-08de1b36836d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6088

This patchset updates CXL Protocol Error handling for CXL Ports and CXL
Endpoints (EP). Previous versions of this series can be found here:
https://lore.kernel.org/linux-cxl/20250925223440.3539069-1-terry.bowman@amd.com/

The first 2 patches were moved to the front this revision. This is the pcie_is_cxl()
patch and the DVSEC definition patch. They were moved to front in case Alejandro needs for
his Type2 series.

The next 6 patches prepare and move files. This includes Dave Jiang's patch
moving CXL RAS related code from cxl/core/pci.c to cxl/core/ras.c. Restricted
CXL host (RCH) related RAS code is moved to cxl/core/ras_rch.c. AER driver
related RCH code is moved within the AER driver from pci/pcie/aer.c
pci/pcie/aer_cxl_rch.c.

Patches 9-15 are mostly fixups in preparation for following protocol
handling changes. This includes introducing the new PCI_ERS_RESULT_PANIC
result type, improvements to AER logging for bus type (CXL or PCI), function
handler interface updates supporting both Endpoints and CXL Port devices,
logging a message if RAS is NULL. The patch "CXL/AER: Update PCI class code
check to use FIELD_GET()" was removed from this group per Lukas's request.

Patches 16-17 move more code. The AER driver's virtual hierarchy (VH) RAS
related code is moved to pci/pcie/aer_cxl_vh.c in patch 17. Patch 18 introduces
cxl_pci_drv_bound() to identify if an EP is using the CXL EP driver. This
is to support cases where the CXL driver is not used (eg. VFIO). Accessing
cxl_pci_drv_bound() in cxl/pci.c from cxl_core fails with circular build
dependencies. This requires moving cxl/pci.c (containing cxl_pci_drv_bound())
to cxl/core/pci_drv.c.

Patches 18-20 create CXL Endpoint error handlers alongside the existing CXL
PCI error handlers. Both CXL and PCI error handlers are added for CXL Port devices.

Patches 21-23 implement the kernel kfifo dequeue and logic for calling the
correctable or uncorrectable handlers. Signifcant changes were made in the
unrecoverable patch for the following.
 - Updated locking. The endpoint and port devices lock the following:
   EP - pdev->dev (same as cxlds->dev) and cxlmd->dev
   RP/USP/DSP - pdev->dev and parent cxl_port
 - Move locking out of handlers and into cxl_handle_proto_error() and
   report_error_detected(). Lock as soon as possible after kfifo dequeue.
 - Device's reporting UCEs, are locked after kfifo dequeue. Must make condition
   check to prevent from locking the reporting device during iteration in
   do_recovery().

Patches 24-25 enable/disable protocol error interrupt masks.


== Testing ===
Below are the testing results while using QEMU. The QEMU testing uses a CXL Root
Port, CXL Upstream Switch Port, CXL Downstream Switch Port and CXL Endpoint as
given below. I've attached the QEMU startup commandline used. This testing uses
protocol error injection at all the devices.

The sub-topology for the QEMU testing is:
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
 -+-[0000:00]- -00.0
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


=== Root Port ===
root@tbowman-cxl:~/aer-inject# ./root-ce-inject.sh
pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0c:00.0
pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0c:00.0
pcieport 0000:0c:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
pcieport 0000:0c:00.0:   device [8086:7075] error status/mask=00004000/0000a000
pcieport 0000:0c:00.0:    [14] CorrIntErr
cxl_aer_correctable_error: memdev=0000:0c:00.0 host=pci0000:0c serial=0: status: 'CRC Threshold Hit'

root@tbowman-cxl:~/aer-inject# ./root-uce-inject.sh
pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0c:00.0
pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0c:00.0
aer_event: 0000:0c:00.0 CXL Bus Error: severity=Fatal, Uncorrectable Internal Error, TLP Header=Not available
pcieport 0000:0c:00.0: CXL Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
pcieport 0000:0c:00.0:   device [8086:7075] error status/mask=00400000/02000000
pcieport 0000:0c:00.0:    [22] UncorrIntErr
cxl_aer_uncorrectable_error: memdev=0000:0c:00.0 host=pci0000:0c serial=0: status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
cxl_aer_uncorrectable_error: memdev=0000:0d:00.0 host=0000:0c:00.0 serial=0: status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
cxl_aer_uncorrectable_error: memdev=0000:0e:03.0 host=0000:0d:00.0 serial=0: status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
cxl_aer_uncorrectable_error: memdev=mem3 host=0000:12:00.0 serial=0: status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
cxl_aer_uncorrectable_error: memdev=0000:0e:02.0 host=0000:0d:00.0 serial=0: status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
cxl_aer_uncorrectable_error: memdev=mem2 host=0000:11:00.0 serial=0: status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
cxl_aer_uncorrectable_error: memdev=0000:0e:01.0 host=0000:0d:00.0 serial=0: status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
cxl_aer_uncorrectable_error: memdev=mem0 host=0000:10:00.0 serial=0: status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
cxl_aer_uncorrectable_error: memdev=0000:0e:00.0 host=0000:0d:00.0 serial=0: status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
cxl_aer_uncorrectable_error: memdev=mem1 host=0000:0f:00.0 serial=0: status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
Kernel panic - not syncing: CXL cachemem error.
CPU: 10 UID: 0 PID: 150 Comm: kworker/10:1 Tainted: G            E       6.18.0-rc2-00029-g7d4bdf85dccf #3518 PREEMPT(voluntary)
Tainted: [E]=UNSIGNED_MODULE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
Workqueue: events cxl_proto_err_work_fn [cxl_core]
Call Trace:
 <TASK>
 vpanic+0x3a0/0x410
 panic+0x5b/0x60
 ? xa_find_after+0x134/0x250
 ? xa_find_after+0x86/0x250
 cxl_proto_err_work_fn+0x316/0x320 [cxl_core]
 ? lock_release+0x1e4/0x3f0
 process_one_work+0x22c/0x650
 worker_thread+0x188/0x330
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x102/0x210
 ? __pfx_kthread+0x10/0x10
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x278/0x2e0
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>
Kernel Offset: disabled
---[ end Kernel panic - not syncing: CXL cachemem error. ]---


=== Upstream Port ===
root@tbowman-cxl:~/aer-inject# ./us-ce-inject.sh
pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0d:00.0
pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0d:00.0
pcieport 0000:0d:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
pcieport 0000:0d:00.0:   device [19e5:a128] error status/mask=00004000/0000a000
pcieport 0000:0d:00.0:    [14] CorrIntErr
cxl_aer_correctable_error: memdev=0000:0d:00.0 host=0000:0c:00.0 serial=0: status: 'CRC Threshold Hit'

root@tbowman-cxl:~/aer-inject# ./us-uce-inject.sh
pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0d:00.0
pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0d:00.0
aer_event: 0000:0d:00.0 CXL Bus Error: severity=Fatal, , TLP Header=Not available
pcieport 0000:0d:00.0: AER: CXL Bus Error: severity=Uncorrectable (Fatal), type=Inaccessible, (Unregistered Agent ID)
cxl_aer_uncorrectable_error: memdev=mem1 host=0000:0f:00.0 serial=0: status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
Kernel panic - not syncing: CXL cachemem error.
CPU: 10 UID: 0 PID: 159 Comm: irq/24-aerdrv Tainted: G            E       6.18.0-rc2-00029-g7d4bdf85dccf #3518 PREEMPT(voluntary)
Tainted: [E]=UNSIGNED_MODULE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 vpanic+0x3a0/0x410
 panic+0x5b/0x60
 pci_error_detected+0xb4/0xc0 [cxl_core]
 report_error_detected+0xbf/0x190
 ? __pfx_report_frozen_detected+0x10/0x10
 __pci_walk_bus+0x4c/0x70
 ? __pfx_report_frozen_detected+0x10/0x10
 __pci_walk_bus+0x34/0x70
 ? __pfx_report_frozen_detected+0x10/0x10
 __pci_walk_bus+0x34/0x70
 ? __pfx_report_frozen_detected+0x10/0x10
 pci_walk_bus+0x31/0x50
 pcie_do_recovery+0x300/0x430
 aer_isr_one_error_type+0x20f/0x3c0
 aer_isr_one_error+0x117/0x140
 aer_isr+0x4c/0x80
 irq_thread_fn+0x24/0x60
 irq_thread+0x1a0/0x2b0
 ? __pfx_irq_thread_fn+0x10/0x10
 ? __pfx_irq_thread_dtor+0x10/0x10
 ? __pfx_irq_thread+0x10/0x10
 kthread+0x102/0x210
 ? __pfx_kthread+0x10/0x10
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x278/0x2e0
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>
Kernel Offset: disabled
---[ end Kernel panic - not syncing: CXL cachemem error. ]---

=== Downstream Port ===
root@tbowman-cxl:~/aer-inject# ./ds-ce-inject.sh
pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0e:00.0
pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0e:00.0
aer_event: 0000:0e:00.0 CXL Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
pcieport 0000:0e:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
pcieport 0000:0e:00.0:   device [19e5:a129] error status/mask=00004000/0000a000
pcieport 0000:0e:00.0:    [14] CorrIntErr
cxl_aer_correctable_error: memdev=0000:0e:00.0 host=0000:0d:00.0 serial=0: status: 'CRC Threshold Hit'

root@tbowman-cxl:~/aer-inject# ./ds-uce-inject.sh
pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0e:00.0
pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0e:00.0
aer_event: 0000:0e:00.0 CXL Bus Error: severity=Fatal, Uncorrectable Internal Error, TLP Header=Not available
pcieport 0000:0e:00.0: CXL Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
pcieport 0000:0e:00.0:   device [19e5:a129] error status/mask=00400000/02000000
pcieport 0000:0e:00.0:    [22] UncorrIntErr
cxl_aer_uncorrectable_error: memdev=0000:0d:00.0 host=0000:0c:00.0 serial=0: status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
cxl_aer_uncorrectable_error: memdev=0000:0e:00.0 host=0000:0d:00.0 serial=0: status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
cxl_aer_uncorrectable_error: memdev=mem0 host=0000:0f:00.0 serial=0: status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
cxl_aer_uncorrectable_error: memdev=0000:0e:01.0 host=0000:0d:00.0 serial=0: status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
cxl_aer_uncorrectable_error: memdev=mem1 host=0000:10:00.0 serial=0: status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
cxl_aer_uncorrectable_error: memdev=0000:0e:03.0 host=0000:0d:00.0 serial=0: status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
cxl_aer_uncorrectable_error: memdev=mem2 host=0000:12:00.0 serial=0: status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
cxl_aer_uncorrectable_error: memdev=0000:0e:02.0 host=0000:0d:00.0 serial=0: status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
cxl_aer_uncorrectable_error: memdev=mem3 host=0000:11:00.0 serial=0: status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
Kernel panic - not syncing: CXL cachemem error.
CPU: 10 UID: 0 PID: 683 Comm: kworker/10:2 Tainted: G            E       6.18.0-rc2-00029-g2e23f5f37fac #3552 PREEMPT(voluntary)
Tainted: [E]=UNSIGNED_MODULE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
Workqueue: events cxl_proto_err_work_fn [cxl_core]
Call Trace:
 <TASK>
 vpanic+0x3a0/0x410
 panic+0x5b/0x60
 ? xa_find_after+0x134/0x250
 ? xa_find_after+0x86/0x250
 cxl_proto_err_work_fn+0x352/0x360 [cxl_core]
 ? lock_release+0x1e4/0x3f0
 process_one_work+0x22c/0x650
 worker_thread+0x188/0x330
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x102/0x210
 ? __pfx_kthread+0x10/0x10
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x278/0x2e0
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>
Kernel Offset: disabled
---[ end Kernel panic - not syncing: CXL cachemem error. ]---


=== Endpoint ===
root@tbowman-cxl:~/aer-inject# ./ep-ce-inject.sh
pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0f:00.0
pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0f:00.0
aer_event: 0000:0f:00.0 CXL Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
cxl_core 0000:0f:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
cxl_core 0000:0f:00.0:   device [8086:0d93] error status/mask=00004000/00000000
cxl_core 0000:0f:00.0:    [14] CorrIntErr
cxl_aer_correctable_error: memdev=mem3 host=0000:0f:00.0 serial=0: status: 'CRC Threshold Hit'

root@tbowman-cxl:~/aer-inject# ./ep-uce-inject.sh
pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0f:00.0
pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0f:00.0
aer_event: 0000:0f:00.0 CXL Bus Error: severity=Fatal, , TLP Header=Not available
cxl_core 0000:0f:00.0: AER: CXL Bus Error: severity=Uncorrectable (Fatal), type=Inaccessible, (Unregistered Agent ID)
cxl_aer_uncorrectable_error: memdev=mem1 host=0000:0f:00.0 serial=0: status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
Kernel panic - not syncing: CXL cachemem error.
CPU: 10 UID: 0 PID: 159 Comm: irq/24-aerdrv Tainted: G            E       6.18.0-rc2-00029-g7d4bdf85dccf #3518 PREEMPT(voluntary)
Tainted: [E]=UNSIGNED_MODULE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 vpanic+0x3a0/0x410
 panic+0x5b/0x60
 pci_error_detected+0xb4/0xc0 [cxl_core]
 report_error_detected+0xbf/0x190
 ? __pfx_report_frozen_detected+0x10/0x10
 __pci_walk_bus+0x4c/0x70
 ? __pfx_report_frozen_detected+0x10/0x10
 pci_walk_bus+0x31/0x50
 pcie_do_recovery+0x300/0x430
 aer_isr_one_error_type+0x20f/0x3c0
 aer_isr_one_error+0x117/0x140
 aer_isr+0x4c/0x80
 irq_thread_fn+0x24/0x60
 irq_thread+0x1a0/0x2b0
 ? __pfx_irq_thread_fn+0x10/0x10
 ? __pfx_irq_thread_dtor+0x10/0x10
 ? __pfx_irq_thread+0x10/0x10
 kthread+0x102/0x210
 ? __pfx_kthread+0x10/0x10
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x278/0x2e0
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>
Kernel Offset: disabled
---[ end Kernel panic - not syncing: CXL cachemem error. ]---

== Changes ==

 Changes in v12->v13:
 CXL/PCI: Move CXL DVSEC definitions into uapi/linux/pci_regs.h
 - Add Dave Jiang's reviewed-by
 - Remove changes to existing PCI_DVSEC_CXL_PORT* defines. Update commit
   message. (Jonathan)
 PCI/CXL: Introduce pcie_is_cxl()
 - Add Ben's "reviewed-by"
 cxl/pci: Remove unnecessary CXL Endpoint handling helper functions
 - None
 cxl/pci: Remove unnecessary CXL RCH handling helper functions
 - None
 cxl: Remove CXL VH handling in CONFIG_PCIEAER_CXL conditional blocks from core
 - None
 cxl: Move CXL driver's RCH error handling into core/ras_rch.c
 - None
 CXL/AER: Replace device_lock() in cxl_rch_handle_error_iter() with guard() lock
 - New patch
 CXL/AER: Move AER drivers RCH error handling into pcie/aer_cxl_rch.c
 - Add forward declararation of 'struct aer_err_info' in pci/pci.h (Terry)
 - Changed copyright date from 2025 to 2023 (Jonathan)
 - Add David Jiang's, Jonathan's, and Ben's review-by
 - Readd 'struct aer_err_info' (Bot)
 PCI/AER: Report CXL or PCIe bus error type in trace logging
 - Remove duplicated aer_err_info inline comments. Is already in the
   kernel-doc header (Ben)
 cxl/pci: Update RAS handler interfaces to also support CXL Ports
 - None
 cxl/pci: Log message if RAS registers are unmapped
 - Added Bens review-by
 cxl/pci: Unify CXL trace logging for CXL Endpoints and CXL Ports
 - Added Dave Jiang's review-by
 cxl/pci: Update cxl_handle_cor_ras() to return early if no RAS errors
 - Add Ben's review-by
 cxl/pci: Map CXL Endpoint Port and CXL Switch Port RAS registers
 - Change as result of dport delay fix. No longer need switchport and
 endport approach. Refactor. (Terry)
 CXL/PCI: Introduce PCI_ERS_RESULT_PANIC
 - Add Dave Jiang's, Jonathan's, Ben's review-by
 - Typo fix (Ben)
 CXL/AER: Introduce pcie/aer_cxl_vh.c in AER driver for forwarding CXL errors
 - Add Dave Jiang's review-by
 - Update error message (Ben)
 cxl: Introduce cxl_pci_drv_bound() to check for bound driver
 - Add Dave Jiang's review-by.
 cxl: Change CXL handlers to use guard() instead of scoped_guard()
 - New patch
cxl/pci: Introduce CXL protocol error handlers for endpoints
 - Updated all the implemetnation and commit message. (Terry)
 - Refactored cxl_cor_error_detected()/cxl_error_detected() to remove
   pdev (Dave Jiang)
CXL/PCI: Introduce CXL Port protocol error handlers
 - Move get_pci_cxl_host_dev() and cxl_handle_proto_error() to Dequeue
   patch (Terry)
 - Remove EP case in cxl_get_ras_base(), not used. (Terry)
 - Remove check for dport->dport_dev (Dave)
 - Remove whitespace (Terry)
PCI/AER: Dequeue forwarded CXL error
 - Rewrite cxl_handle_proto_error() and cxl_proto_err_work_fn() (Terry)
 - Rename get_cxl_host dev() to be get_cxl_port() (Terry)
 - Remove exporting of unused function, pci_aer_clear_fatal_status() (Dave Jiang)
 - Change pr_err() calls to ratelimited. (Terry)
 - Update commit message. (Terry)
 - Remove namespace qualifier from pcie_clear_device_status()
   export (Dave Jiang)
 - Move locks into cxl_proto_err_work_fn() (Dave)
 - Update log messages in cxl_forward_error() (Ben)
CXL/PCI: Export and rename merge_result() to pci_ers_merge_result()
 - Renamed pci_ers_merge_result() to pcie_ers_merge_result().
   pci_ers_merge_result() is already used in eeh driver. (Bot)
CXL/PCI: Introduce CXL uncorrectable protocol error recovery
 - Rewrite report_error_detected() and cxl_walk_port (Terry)
 - Add guard() before calling cxl_pci_drv_bound() (Dave Jiang)
 - Add guard() calls for EP (cxlds->cxlmd->dev & pdev->dev) and ports
   (pdev->dev & parent cxl_port) in cxl_report_error_detected() and
   cxl_handle_proto_error() (Terry)
 - Remove unnecessary check for endpoint port. (Dave Jiang)
 - Remove check for RCIEP EP in cxl_report_error_detected() (Terry)
CXL/PCI: Enable CXL protocol errors during CXL Port probe
 - Add dev and dev_is_pci() NULL checks in cxl_unmask_proto_interrupts() (Terry)
 - Add Dave Jiang's and Ben's review-by
CXL/PCI: Disable CXL protocol error interrupts during CXL Port cleanup
 - Added dev and dev_is_pci() checks in cxl_mask_proto_interrupts() (Terry)

Changes in v11 -> v12:
cxl/pci: Remove unnecessary CXL Endpoint handling helper functions
 - Added Dave Jiang's review by
 - Moved to front of series
cxl/pci: Remove unnecessary CXL RCH handling helper functions
 - Add reviewed-by for Alejandro & Dave Jiang
 - Moved to front of series
cxl: Remove ifdef blocks of CONFIG_PCIEAER_CXL from core/pci.c
 - Update CONFIG_CXL_RAS in CXL Kconfig to have CXL_PCI dependency (Terry)
CXL/AER: Remove CONFIG_PCIEAER_CXL and replace with CONFIG_CXL_RAS 
 - Added review-by for Sathyanarayanan
 - Changed Kconfig dependency from PCIEAER_CXL to PCIEAER. Moved
   this backwards into this patch.
cxl: Move CXL driver RCH error handling into CONFIG_CXL_RCH_RAS conditio
 - Moved CXL_RCH_RAS Kconfig definition here from following commit
CXL/AER: Introduce aer_cxl_rch.c into AER driver for handling CXL RCH errors
 - Rename drivers/pci/pcie/cxl_rch.c to drivers/pci/pcie/aer_cxl_rch.c (Lukas)
 - Removed forward declararation of 'struct aer_err_info' in pci/pci.h (Terry)
CXL/PCI: Move CXL DVSEC definitions into uapi/linux/pci_regs.h
 - Change formatting to be same as existing definitions
 - Change GENMASK() -> __GENMASK() and BIT() to _BITUL()
PCI/CXL: Introduce pcie_is_cxl()
 - Add review-by for Alejandro
 - Add comment in set_pcie_cxl() explaining why updating parent status.
PCI/AER: Report CXL or PCIe bus error type in trace logging
 - Change aer_err_info::is_cxl to be bool a bitfield. Update structure padding. (Lukas)
 - Add kernel-doc for 'struct aer_err_info' (Lukas)
cxl/pci: Unify CXL trace logging for CXL Endpoints and CXL Ports 
 - Correct parameters to call trace_cxl_aer_correctable_error() (Shiju)
 - Add reviewed-by for Jonathan and Shiju
cxl/pci: Map CXL Endpoint Port and CXL Switch Port RAS registers
 - Add check for dport_parent->rch before calling cxl_dport_init_ras_reporting().
 - RCH dports are initialized from cxl_dport_init_ras_reporting cxl_mem_probe().  
CXL/PCI: Introduce PCI_ERS_RESULT_PANIC 
 - Documentation requested by (Lukas)
CXL/AER: Introduce aer_cxl_vh.c in AER driver for forwarding CXL errors
 - Rename drivers/pci/pcie/cxl_aer.c to drivers/pci/pcie/aer_cxl_vh.c (Lukas)
cxl: Introduce cxl_pci_drv_bound() to check for bound driver
 - New patch
PCI/AER: Dequeue forwarded CXL error
 - Add guard for CE case in cxl_handle_proto_error() (Dave)
 - Updated commit message (Terry)
CXL/PCI: Introduce CXL Port protocol error handlers
 - Add call to cxl_pci_drv_bound() in cxl_handle_proto_error() and
   pci_to_cxl_dev() (Lukas)
 - Change cxl_error_detected() -> cxl_cor_error_detected() (Terry)
 - Remove NULL variable assignments (Jonathan)
 - Replace bus_find_device() with find_cxl_port_by_uport() for upstream
   port searches. (Dave)
CXL/PCI: Export and rename merge_result() to pci_ers_merge_result()
 - Remove static inline pci_ers_merge_result() definition for !CONFIG_PCIEAER.
   Is not needed. (Lukas)
CXL/PCI: Introduce CXL uncorrectable protocol error recovery
 - Clean up port discovery in cxl_do_recovery() (Dave)
 - Add PCI_EXP_TYPE_RC_END to type check in cxl_report_error_detected()

Changes in v10 -> v11:
 cxl: Remove ifdef blocks of CONFIG_PCIEAER_CXL from core/pci.c
 - New patch
 CXL/AER: Remove CONFIG_PCIEAER_CXL and replace with CONFIG_CXL_RAS
 - New patch
 cxl/pci: Remove unnecessary CXL RCH handling helper functions
 - New patch
 cxl: Move CXL driver RCH error handling into CONFIG_CXL_RCH_RAS conditional block
 - New patch
 CXL/AER: Introduce rch_aer.c into AER driver for handling CXL RCH errors
 - Remove changes in code-split and move to earlier, new patch
 - Add #include <linux/bitfield.h> to cxl_ras.c
 - Move cxl_rch_handle_error() & cxl_rch_enable_rcec() declarations from pci.h
   to aer.h, more localized.
 - Introduce CONFIG_CXL_RCH_RAS, includes Makefile changes, ras.c ifdef changes
 CXL/PCI: Move CXL DVSEC definitions into uapi/linux/pci_regs.h
 - New patch
 PCI/CXL: Introduce pcie_is_cxl()
 - Amended set_pcie_cxl() to check for Upstream Port's and EP's parent
   downstream port by calling set_pcie_cxl(). (Dan)
 - Retitle patch: 'Add' -> 'Introduce'
 - Add check for CXL.mem and CXL.cache (Alejandro, Dan)
 PCI/AER: Report CXL or PCIe bus error type in trace logging
 - Remove duplicate call to trace_aer_event() (Shiju)
 - Added Dan William's and Dave Jiang's reviewed-by
 CXL/AER: Update PCI class code check to use FIELD_GET()
 - Add #include <linux/bitfield.h> to cxl_ras.c (Terry)
 - Removed line wrapping at "(CXL 3.2, 8.1.12.1)". (Jonathan)
 cxl/pci: Log message if RAS registers are unmapped
 - Added Dave Jiang's review-by (Terry)
 cxl/pci: Unify CXL trace logging for CXL Endpoints and CXL Ports
 - Updated CE and UCE trace routines to maintian consistent TP_Struct ABI
   and unchanged TP_printk() logging. (Shiju, Alison)
 cxl/pci: Update cxl_handle_cor_ras() to return early if no RAS errors
 - Added Dave Jiang and Jonathan Cameron's review-by
 - Changes moved to core/ras.c
 cxl/pci: Map CXL Endpoint Port and CXL Switch Port RAS registers
 - Use local pointer for readability in cxl_switch_port_init_ras() (Jonathan Cameron)
 - Rename port to be ep in cxl_endpoint_port_init_ras() (Dave Jiang)
 - Rename dport to be parent_dport in cxl_endpoint_port_init_ras()
   and cxl_switch_port_init_ras() (Dave Jiang)
 - Port helper changes were in cxl/port.c, now in core/ras.c (Dave Jiang)
 cxl/pci: Introduce CXL Endpoint protocol error handlers
 - cxl_error_detected() - Change handlers' scoped_guard() to guard() (Jonathan)
 - cxl_error_detected() - Remove extra line (Shiju)
 - Changes moved to core/ras.c (Terry)
 - cxl_error_detected(), remove 'ue' and return with function call. (Jonathan)
 - Remove extra space in documentation for PCI_ERS_RESULT_PANIC definition
 - Move #include "pci.h from cxl.h to core.h (Terry)
 - Remove unnecessary includes of cxl.h and core.h in mem.c (Terry)   
 CXL/AER: Introduce cxl_aer.c into AER driver for forwarding CXL errors
 - Move RCH implementation to cxl_rch.c and RCH declarations to pci/pci.h. (Terry)
 - Introduce 'struct cxl_proto_err_kfifo' containing semaphore, fifo,
   and work struct. (Dan)
 - Remove embedded struct from cxl_proto_err_work (Dan)
 - Make 'struct work_struct *cxl_proto_err_work' definition static (Jonathan)
 - Add check for NULL cxl_proto_err_kfifo to determine if CXL driver is
   not registered for workqueue. (Dan)
 PCI/AER: Dequeue forwarded CXL error
 - Reword patch commit message to remove RCiEP details (Jonathan)
 - Add #include <linux/bitfield.h> (Terry)
 - is_cxl_rcd() - Fix short comment message wrap  (Jonathan)
 - is_cxl_rcd() - Combine return calls into 1  (Jonathan)
 - cxl_handle_proto_error() - Move comment earlier  (Jonathan)
 - Usse FIELD_GET() in discovering class code (Jonathan)
 - Remove BDF from cxl_proto_err_work_data. Use 'struct pci_dev *' (Dan)
 CXL/PCI: Introduce CXL Port protocol error handlers
 - Removed check for PCI_EXP_TYPE_RC_END in cxl_report_error_detected() (Terry)
 - Update is_cxl_error() to check for acceptable PCI EP and port types
 CXL/PCI: Export and rename merge_result() to pci_ers_merge_result()
 - pci_ers_merge_result() - Change export to non-namespace and rename
   to be pci_ers_merge_result() (Jonathan)
 - Move pci_ers_merge_result() definition to pci.h. Needs pci_ers_result (Terry)
 CXL/PCI: Introduce CXL uncorrectable protocol error recovery
 - pci_ers_merge_results() - Move to earlier patch
 CXL/PCI: Disable CXL protocol error interrupts during CXL Port cleanup
 - Remove guard() in cxl_mask_proto_interrupts(). Observed device lockup/block
   during testing. (Terry)
  
 Changes in v9 -> v10:
 - Add drivers/pci/pcie/cxl_aer.c
 - Add drivers/cxl/core/native_ras.c
 - Change cxl_register_prot_err_work()/cxl_unregister_prot_err_work to return void
 - Check for pcie_ports_native in cxl_do_recovery()
 - Remove debug logging in cxl_do_recovery()
 - Update PCI_ERS_RESULT_PANIC definition to indicate is CXL specific
 - Revert trace logging changes: name,parent -> memdev,host.
 - Use FIELD_GET() to check for EP class code (cxl_aer.c & native_ras.c).
 - Change _prot_ to _proto_ everywhere
 - cxl_rch_handle_error_iter(), check if driver is cxl_pci_driver
 - Remove cxl_create_prot_error_info(). Move logic into forward_cxl_error()
 - Remove sbdf_to_pci() and move logic into cxl_handle_proto_error()
 - Simplify/refactor get_pci_cxl_host_dev()
 - Simplify/refactor cxl_get_ras_base()
 - Move patch 'Remove unnecessary CXL Endpoint handling helper functions' to front
 - Update description for 'CXL/PCI: Introduce CXL Port protocol error
   handlers' with why state is not used to determine handling
 - Introduce cxl_pci_drv_bound() and call from cxl_rch_handle_error_iter()

 Changes in v8 -> v9:
 - Updated reference counting to use pci_get_device()/pci_put_device() in
   cxl_disable_prot_errors()/cxl_enable_prot_errors
 - Refactored cxl_create_prot_err_info() to fix reference counting
 - Removed 'struct cxl_port' driver changes for error handler. Instead
   check for CXL device type (EP or Port device) and call handler
 - Make pcie_is_cxl() static inline in include/linux/linux.h
 - Remove NULL check in create_prot_err_info()
 - Change success return in cxl_ras_init() to use hardcoded 0
 - Changed 'struct work_struct cxl_prot_err_work' declaration to static
 - Change to use rate limited log with dev anchor in forward_cxl_error()
 - Refactored forward-cxl_error() to remove severity auto variable
 - Changed pci_aer_clear_nonfatal_status() to be static inline for
   !(CONFIG_PCIEAER)
 - Renamed merge_result() to be cxl_merge_result()
 - Removed 'ue' condition in cxl_error_detected()
 - Updated 2nd parameter in call to __cxl_handle_cor_ras()/__cxl_handle_ras()
   in unify patch
 - Added log message for failure while assigning interrupt disable callback
 - Updated pci_aer_mask_internal_errors() to use pci_clear_and_set_config_dword()
 - Simplified patch titles for clarity
 - Moved CXL error interrupt disabling into cxl/core/port.c with CXL Port
 teardown
 - Updated 'struct cxl_port_err_info' to only contain sbdf and severity
 Removed everything else.
 - Added pdev and CXL device get_device()/put_device() before calling handlers
 
 Changes in v7 -> v8:
 [Dan] Use kfifo. Move handling to CXL driver. AER forwards error to CXL
 driver
 [Dan] Add device reference incrementors where needed throughout
 [Dan] Initiate CXL Port RAS init from Switch Port and Endpoint Port init 
 [Dan] Combine CXL Port and CXL Endpoint trace routine
 [Dan] Introduce aer_info::is_cxl. Use to indicate CXL or PCI errors
 [Jonathan] Add serial number for all devices in trace
 [DaveJ] Move find_cxl_port() change into patch using it
 [Terry] Move CXL Port RAS init into cxl/port.c
 [Terry] Moved kfifo functions into cxl/core/ras.c 
 
 Changes in v6 -> v7:
 [Terry] Move updated trace routine call to later patch. Was causing build
 error.
 
 Changes in v5 -> v6:
 [Ira] Move pcie_is_cxl(dev) define to a inline function
 [Ira] Update returning value from pcie_is_cxl_port() to bool w/o cast
 [Ira] Change cxl_report_error_detected() cleanup to return correct bool
 [Ira] Introduce and use PCI_ERS_RESULT_PANIC
 [Ira] Reuse comment for PCIe and CXL recovery paths
 [Jonathan] Add type check in for cxl_handle_cor_ras() and cxl_handle_ras()
 [Jonathan] cxl_uport/dport_init_ras_reporting(), added a mutex.
 [Jonathan] Add logging example to patches updating trace output
 [Jonathan] Make parameter 'const' to eliminate for cast in match_uport()
 [Jonathan] Use __free() in cxl_pci_port_ras()
 [Terry] Add patch to log the PCIe SBDF along with CXL device name
 [Terry] Add patch to handle CXL endpoint and RCH DP errors as CXL errors
 [Terry] Remove patch w USP UCE fatal support @ aer_get_device_error_info()
 [Terry] Rebase to cxl/next commit 5585e342e8d3 ("cxl/memdev: Remove unused partition values")
 [Gregory] Pre-initialize pointer to NULL in cxl_pci_port_ras()
 [Gregory] Move AER driver bus name detection to a static function

 Changes in v4 -> v5:
 [Alejandro] Refactor cxl_walk_bridge to simplify 'status' variable usage
 [Alejandro] Add WARN_ONCE() in __cxl_handle_ras() and cxl_handle_cor_ras()
 [Ming] Remove unnecessary NULL check in cxl_pci_port_ras()
 [Terry] Add failure check for call to to_cxl_port() in cxl_pci_port_ras()
 [Ming] Use port->dev for call to devm_add_action_or_reset() in
 cxl_dport_init_ras_reporting() and cxl_uport_init_ras_reporting()
 [Jonathan] Use get_device()/put_device() to prevent race condition in
 cxl_clear_port_error_handlers() and cxl_clear_port_error_handlers()
 [Terry] Commit message cleanup. Capitalize keywords from CXL and PCI
 specifications

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
Dave Jiang (1):
  cxl: Remove CXL VH handling in CONFIG_PCIEAER_CXL conditional blocks
    from core/pci.c

Terry Bowman (24):
  CXL/PCI: Move CXL DVSEC definitions into uapi/linux/pci_regs.h
  PCI/CXL: Introduce pcie_is_cxl()
  cxl/pci: Remove unnecessary CXL Endpoint handling helper functions
  cxl/pci: Remove unnecessary CXL RCH handling helper functions
  cxl: Move CXL driver's RCH error handling into core/ras_rch.c
  CXL/AER: Replace device_lock() in cxl_rch_handle_error_iter() with
    guard() lock
  CXL/AER: Move AER drivers RCH error handling into pcie/aer_cxl_rch.c
  PCI/AER: Report CXL or PCIe bus error type in trace logging
  cxl/pci: Update RAS handler interfaces to also support CXL Ports
  cxl/pci: Log message if RAS registers are unmapped
  cxl/pci: Unify CXL trace logging for CXL Endpoints and CXL Ports
  cxl/pci: Update cxl_handle_cor_ras() to return early if no RAS errors
  cxl/pci: Map CXL Endpoint Port and CXL Switch Port RAS registers
  CXL/PCI: Introduce PCI_ERS_RESULT_PANIC
  CXL/AER: Introduce pcie/aer_cxl_vh.c in AER driver for forwarding CXL
    errors
  cxl: Introduce cxl_pci_drv_bound() to check for bound driver
  cxl: Change CXL handlers to use guard() instead of scoped_guard()
  cxl/pci: Introduce CXL protocol error handlers for Endpoints
  CXL/PCI: Introduce CXL Port protocol error handlers
  PCI/AER: Dequeue forwarded CXL error
  CXL/PCI: Export and rename merge_result() to pci_ers_merge_result()
  CXL/PCI: Introduce CXL uncorrectable protocol error recovery
  CXL/PCI: Enable CXL protocol errors during CXL Port probe
  CXL/PCI: Disable CXL protocol error interrupts during CXL Port cleanup

 Documentation/PCI/pci-error-recovery.rst |   6 +
 drivers/cxl/Kconfig                      |  17 +-
 drivers/cxl/Makefile                     |   2 -
 drivers/cxl/core/Makefile                |   4 +-
 drivers/cxl/core/core.h                  |  66 +++
 drivers/cxl/core/pci.c                   | 380 ++-------------
 drivers/cxl/{pci.c => core/pci_drv.c}    |  32 +-
 drivers/cxl/core/port.c                  |  28 +-
 drivers/cxl/core/ras.c                   | 572 ++++++++++++++++++++++-
 drivers/cxl/core/ras_rch.c               | 120 +++++
 drivers/cxl/core/regs.c                  |  12 +-
 drivers/cxl/core/trace.h                 |  68 +--
 drivers/cxl/cxl.h                        |  10 +-
 drivers/cxl/cxlpci.h                     |  68 +--
 drivers/cxl/mem.c                        |   3 +-
 drivers/pci/pci.c                        |   5 +-
 drivers/pci/pci.h                        |  59 ++-
 drivers/pci/pcie/Makefile                |   2 +
 drivers/pci/pcie/aer.c                   | 155 ++----
 drivers/pci/pcie/aer_cxl_rch.c           |  96 ++++
 drivers/pci/pcie/aer_cxl_vh.c            |  98 ++++
 drivers/pci/pcie/err.c                   |  14 +-
 drivers/pci/probe.c                      |  29 ++
 include/linux/aer.h                      |  29 ++
 include/linux/pci.h                      |  18 +
 include/ras/ras_event.h                  |   9 +-
 include/uapi/linux/pci_regs.h            |  63 ++-
 tools/testing/cxl/Kbuild                 |   4 +-
 28 files changed, 1320 insertions(+), 649 deletions(-)
 rename drivers/cxl/{pci.c => core/pci_drv.c} (98%)
 create mode 100644 drivers/cxl/core/ras_rch.c
 create mode 100644 drivers/pci/pcie/aer_cxl_rch.c
 create mode 100644 drivers/pci/pcie/aer_cxl_vh.c


base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
-- 
2.34.1


