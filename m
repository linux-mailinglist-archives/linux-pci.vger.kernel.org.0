Return-Path: <linux-pci+bounces-30848-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D87DAEA9C4
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 00:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9478E3B6177
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 22:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1CC22173F;
	Thu, 26 Jun 2025 22:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K1BrnR4q"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E6420487E;
	Thu, 26 Jun 2025 22:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750977784; cv=fail; b=LRoYGKtFzw5X/4Z701CI5IKxzYKFVnWiK5/igFsbnwXDQpjLJOH3Swvz4hYQb37qUyLkwpH1dnGOsomLpxy8akztEJwkKFRf2syotxzvjxDRZoMhMmloVr3wx9fdhbUekoME21csPHQuSCEXjb8aTyIg2Tk5VH1mj34P0ecy4lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750977784; c=relaxed/simple;
	bh=Jtsgm1KC4wenO6KcfSGxliFL6idYc+2kAJ28QSLXEDk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PRVy9hLO5vOTL2V9CpCRE+oYldX49J89PTdluRL5mpyhh5Aa7oY8+t8l/SxyLLqv0XZzbGFsYKuETDsEvxr5yvqdOU3wbVh/miI3EwPdGjSMxZSmE2aLmbfPPTBy5jKl1VsweCX3/2PUzt+LYwgC2GJ5I/cnq4g+xYhc8n0ZiFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=K1BrnR4q; arc=fail smtp.client-ip=40.107.92.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WkesOEjzgG8hM/r0VBzr5b8Bg+x7ycl/F38fi+/rcF0d3/LhM38J/UyDzX1pTnfTm+Za+qiph8RFJTPmQcY28wD2A96qmgpM8ifEWWPad9HIGxl8DXSJIWWMqSrI0Uq/jvz+qOlxh6ZkS9NS+UCiaWfEbBUhP0JgNCAtJ0aatV1T9qLkAakinGsOlHEBaYpayJ5UPZaZhB4xo8Ny+W7GFtU2LU8ZbQJ6+LiTcQHZIDWhDa/5pSAWB6uQQ2SM4MEpHfNfO2L3LJwglWqSao0RAwBh34zBKIrn4+zE3DgXr1UkOSnBbRLsZ1LhhRQ2zFGbd4O9GSSzj9VyUzzVtbOrsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYZjNn38dq7L5eqwlLjqVLCAJFfSsIFbVCTsTpA62qI=;
 b=x4neBr1+25wq0Lxjgb7eqP712L5IvWNPBXoc3tvfmE8uHtstAsx9Y+5VcBJQBnC5gnUgFicWLoi8Tn3m/dHO1jbD/L78ILzRx1VTTUuoxMnHFVDAE5MuR90P7Cu+CAHQBlLJz82b9kb2LSL341NGAxQwpgIcWFeaSt9q1sHMoe/SFR+kWVnUzVluCmV+skjjhmvAEVLKQEEQxFpQMxsx0OZHuqnHbsQxvwncm5/CwAQih5QKeDTU3k6UK0MOGLvZ4hvrmWAtGwdRtZeKiXiu/LFumoMlTNKElggFw3Px+bEgQT5tReBRkgDu3V1jOCpGkxPvXpBTiVYgwq4cCAFylA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYZjNn38dq7L5eqwlLjqVLCAJFfSsIFbVCTsTpA62qI=;
 b=K1BrnR4qJSKAdMfgy94KPOrZNxVg9wSaJNEzjUlO4E++SEkHSKelTTm25rQnOfiyvufuQ+JPgEump9xEWlOcxXG4AoWK7glDQrDQsdCXAUmG3U+HY7teLgzhdDNNWWj169lURdX0rgIB81M9XK1+qzQzHKoCOXaX3gF6NA1xt3o=
Received: from DM6PR10CA0027.namprd10.prod.outlook.com (2603:10b6:5:60::40) by
 DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.21; Thu, 26 Jun 2025 22:42:59 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:5:60:cafe::bb) by DM6PR10CA0027.outlook.office365.com
 (2603:10b6:5:60::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.21 via Frontend Transport; Thu,
 26 Jun 2025 22:42:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 22:42:59 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 17:42:57 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<terry.bowman@amd.com>, <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v10 00/17] Enable CXL PCIe Port Protocol Error handling and logging
Date: Thu, 26 Jun 2025 17:42:35 -0500
Message-ID: <20250626224252.1415009-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|DM6PR12MB4340:EE_
X-MS-Office365-Filtering-Correlation-Id: c41a7365-9517-4fed-763b-08ddb502cd15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RliyjHBMHsF/F0NdxyK6bVolxZpQ6/wQz/Jn1L4HQBEJF5TPuJrmOwEU/ARV?=
 =?us-ascii?Q?No4WTPiPkBMV9MfQ85zboSySG2tgsSTVkQaocs6kf4t58ZNzac8aPueDXunM?=
 =?us-ascii?Q?9f8EyFKYlDB0RUcMHqdaxW3vplSyhe1mOp4TpbzrJ6s2O3cvWfp/N21ah6GS?=
 =?us-ascii?Q?Cx3R8zp5IMbsOsquD1wxi1ubvHNCvN0ql5T2FYiwepxqMe59URWYIv2il1lR?=
 =?us-ascii?Q?xerKICdkLls5ovUGJX5QP1Umgduox6SEOJaSj5mviOY6dPmwtw9MJ5Tr3AIu?=
 =?us-ascii?Q?L24uAk+qiqJuEOpnKSoLQwAdq4GYwnCAQcIIm0+4poHj2vzgsaUM+VojytM+?=
 =?us-ascii?Q?xMg6m0rmre8d6Pwa8owYRAiw1OPFPAvMyf6pj9dMXNweRvPLC6oDAndCUeUl?=
 =?us-ascii?Q?igQgPrlSKYXrtt0TantuxjOgtDOvg5bSUQI5TXwB51BL0Tvz9RiEmiGAZbR8?=
 =?us-ascii?Q?GSMcpxPvWxCF53s90HES1qlq1iq1Oe8zu2D528zywkfSrI70ge6kdqiL4Y5e?=
 =?us-ascii?Q?Fgpn2uymEb6qYjkZY+sBIYeDjpSePtHgBTPinOloPdnQMLStAvtkkBWovRUC?=
 =?us-ascii?Q?KPskgvmsonz9EG1tK/YZXrkAV6of+9pv7nat7pqhuVGh3fdeNuszhnVgoW9X?=
 =?us-ascii?Q?1s+1f3OgUPM16I+8K1jCaWl3Ous4VD6udFebTH/PcVuwU3xNzTJ3lNbEvZ0z?=
 =?us-ascii?Q?vFkeknKhEWPNxcJass4+fWC+Yx95irL7gWZPFLVmdXyMgKGgZwbUiaUKqvZw?=
 =?us-ascii?Q?0OR+nCekqZWLrm+OzdbRhrSHSe7Dr57rZhzZrwVSJXMC9YJwHZIFXA+k1Sow?=
 =?us-ascii?Q?fjdxx5rpTBwt93cZUHPSm5oZzVE9mXx40PCU2kVfHXnI7wNFK8AjPm8tREUh?=
 =?us-ascii?Q?pC2+RiY/mj/Alak7MnzAvD2mkoYHtHcGvrVoDn/vE+74LzsaSxdPjoHKKxmM?=
 =?us-ascii?Q?bdsRT6emTn0rsdRWORlaI2FISnYAlDZHtIQu4hRGaLEQKeeL3C4fCRv4FYJo?=
 =?us-ascii?Q?T3SEUfAVmi4Rz/feLj6luFJaa7GXcT8T6/fqZqHBUgludgyK3NAru+PFovfS?=
 =?us-ascii?Q?8XBAes7WdVAA1i3Yeov0/BGBhvjv7yRMC58mDkYMIj7R5Q+x2Piu+5rNg8Ds?=
 =?us-ascii?Q?IgjUjnQAorK0hCVQaZbye7cFa/qNxzv4o1nRAD8ZsbJudRdWdJyqU/ww3ikF?=
 =?us-ascii?Q?Ec4dEN7Ws4l5tseEY/wHwKZSsHNrUKYhNNxkJ172HMOmOLHvxljVUQGA4U8t?=
 =?us-ascii?Q?bvhkcUIajHV/Ma9GuTqXPATO/gIfZ3nJkoXwQ5Ybwp/O6H6GFr88fNgXvVMY?=
 =?us-ascii?Q?nafsnNVM1Wox5e6RUkuuLZs9djARSvmLw3ZUvxanhnotvpnDdcwWqPbwrdbX?=
 =?us-ascii?Q?Cg9YirVvMfeXhpmlBg12aeQpA15hyYb4cNk6g0UdwuOIEk/ncod5UYsKIxUh?=
 =?us-ascii?Q?zNJD0tU+E/CA3pHi+x+hsZ5usXFJZZw6vJ3Dsg+cVwmXCDt0XiMBNHdMUP1c?=
 =?us-ascii?Q?06nLHyyLP0eN6gHNGyv2mpT2SRUyU8hES/UbzkMfGtLfWy/0Okx85uYH0g?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 22:42:59.0979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c41a7365-9517-4fed-763b-08ddb502cd15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4340

This patchset updates CXL Protocol Error handling for CXL Ports and CXL
Endpoints (EP). The reach of this patchset grew from CXL Ports to include
EPs as well.

This patchset is a continuation of v9 found here:
https://lore.kernel.org/linux-cxl/20250603172239.159260-1-terry.bowman@amd.com/

The first patch is a small cleanup change to reduce amount of code. 

The next 2 patches introduce pci_dev::is_cxl, aer_info::is_cxl, and add
bus string to AER log tracing. aer_info::is_cxl will be used to indicate a
CXL or PCI error and will be used to direct the error handling flow in
later patches.

The next patch introduces a new driver file, pci/pcie/cxl_aer.c, to move
the existing CXL AER logic into.

The next 3 patches update the AER driver and CXL driver to use a kfifo. 
The kfifo is added to offload CXL-AER protocol error work to the CXL
driver. These patches provide the kfifo work add and work remove. 

The next 5 patches prepare the CXL driver for adding the updated protocol
error handlers. This includes adding CXL Port RAS mapping and updating
interfaces for common support.

The final 5 patches add the CXL error handlers for CXL EPs and CXL Ports.
CXL EPs keep the PCIe error handler for cases the EP error is interpreted
as a PCIe error. These patches also add logic to unmask CXL Protocol Errors
during port probing, and mask CXL Protocol Errors during port device
cleanup.

== Testing ==
Testing results below shows the Upstream Switch Port UCE and EP UCE errors
are handled as PCI errors. This is because aer_get_device_error_info() does
not populate the AER error severity and status in the case of FATAL UCE on
Upstream Ports and Endpoints. This is intended because the USP link to
access the device can be compromised. The check for is_cxl_error() and
is_internal_error() fail as a result and then processes the error as a PCI
error. Also, the AER event logging is missing the PCIe AER status.

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

== Root Port ==
root@tbowman-cxl:~/aer-inject# ./root-ce-inject.sh
pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0c:00.0
pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0c:00.0
aer_event: 0000:0c:00.0 CXL Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
pcieport 0000:0c:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
pcieport 0000:0c:00.0:   device [8086:7075] error status/mask=00004000/0000a000
pcieport 0000:0c:00.0:    [14] CorrIntErr    
cxl_aer_correctable_error: memdev=0000:0c:00.0 host=pci0000:0c serial=0 status='CRC Threshold Hit'

root@tbowman-cxl:~/aer-inject# ./root-uce-inject.sh
pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0c:00.0
pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0c:00.0
aer_event: 0000:0c:00.0 CXL Bus Error: severity=Fatal, Uncorrectable Internal Error, TLP Header=Not available
pcieport 0000:0c:00.0: CXL Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
pcieport 0000:0c:00.0:   device [8086:7075] error status/mask=00400000/02000000
pcieport 0000:0c:00.0:    [22] UncorrIntErr          
cxl_aer_uncorrectable_error: memdev=mem3 host=0000:0f:00.0 serial=0 status='Cache Byte Enable Parity Error' first_error='Cache Byte Enable Pari'
Kernel panic - not syncing: CXL cachemem error.
CPU: 10 UID: 0 PID: 214 Comm: kworker/10:1 Tainted: G            E       6.16.0-rc1-gec6a70ce29c1-dirty #423 PREEMPT(voluntary) 
Tainted: [E]=UNSIGNED_MODULE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
Workqueue: events cxl_proto_err_work_fn
Call Trace:
 <TASK>
 panic+0x364/0x3d0
 ? __pfx_cxl_report_error_detected+0x10/0x10
 cxl_do_recovery+0xa3/0xb0
 cxl_proto_err_work_fn+0xf5/0x180
 process_scheduled_works+0xa8/0x420
 ? __pfx_worker_thread+0x10/0x10
 worker_thread+0x11c/0x260
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xfe/0x210
 ? __pfx_kthread+0x10/0x10
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x84/0xf0
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>
Kernel Offset: 0xc000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
---[ end Kernel panic - not syncing: CXL cachemem error. ]---

== Upstream Port ==
root@tbowman-cxl:~/aer-inject# ./us-ce-inject.sh
pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0d:00.0
pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0d:00.0
aer_event: 0000:0d:00.0 CXL Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
pcieport 0000:0d:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
pcieport 0000:0d:00.0:   device [19e5:a128] error status/mask=00004000/0000a000
pcieport 0000:0d:00.0:    [14] CorrIntErr            
cxl_aer_correctable_error: memdev=0000:0d:00.0 host=0000:0c:00.0 serial=0 status='CRC Threshold Hit'

root@tbowman-cxl:~/aer-inject# ./us-uce-inject.sh
pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0d:00.0
pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0d:00.0
AER: aer_print_error():850: status=0, mask=0
aer_event: 0000:0d:00.0 CXL Bus Error: severity=Fatal, , TLP Header=Not available
pcieport 0000:0d:00.0: AER: CXL Bus Error: severity=Uncorrectable (Fatal), type=Inaccessible, (Unregistered Agent ID)
cxl_aer_uncorrectable_error: memdev=mem0 host=0000:0f:00.0 serial=0 status='Cache Byte Enable Parity Error' first_error='Cache Byte Enable Pari'
Kernel panic - not syncing: CXL cachemem error.
CPU: 10 UID: 0 PID: 146 Comm: irq/24-aerdrv Tainted: G            E       6.16.0-rc1-gec6a70ce29c1-dirty #427 PREEMPT(voluntary) 
Tainted: [E]=UNSIGNED_MODULE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 panic+0x364/0x3d0
 ? __pfx_aer_root_reset+0x10/0x10
 pci_error_detected+0x2b/0x30
 report_error_detected+0xf7/0x170
 ? __pfx_report_frozen_detected+0x10/0x10
 __pci_walk_bus+0x4c/0x70
 ? __pfx_report_frozen_detected+0x10/0x10
 __pci_walk_bus+0x34/0x70
 ? __pfx_report_frozen_detected+0x10/0x10
 __pci_walk_bus+0x34/0x70
 ? __pfx_report_frozen_detected+0x10/0x10
 pci_walk_bus+0x31/0x50
 pcie_do_recovery+0x163/0x2b0
 aer_isr_one_error_type+0x1e8/0x380
 ? __pfx_irq_thread_fn+0x10/0x10
 aer_isr_one_error+0x11d/0x140
 aer_isr+0x4c/0x80
 irq_thread_fn+0x24/0x70
 irq_thread+0x188/0x280
 ? __pfx_irq_thread_dtor+0x10/0x10
 ? __pfx_irq_thread+0x10/0x10
 kthread+0xfe/0x210
 ? __pfx_kthread+0x10/0x10
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x84/0xf0
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>
Kernel Offset: 0x12400000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
---[ end Kernel panic - not syncing: CXL cachemem error. ]---

== Downstream Port ==
root@tbowman-cxl:~/aer-inject# ./ds-ce-inject.sh
pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0e:00.0
pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0e:00.0
aer_event: 0000:0e:00.0 CXL Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
pcieport 0000:0e:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
pcieport 0000:0e:00.0:   device [19e5:a129] error status/mask=00004000/0000a000
pcieport 0000:0e:00.0:    [14] CorrIntErr            
cxl_aer_correctable_error: memdev=0000:0e:00.0 host=0000:0d:00.0 serial=0 status='CRC Threshold Hit'

root@tbowman-cxl:~/aer-inject# ./ds-uce-inject.sh
pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0e:00.0
pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0e:00.0
AER: aer_print_error():850: status=400000, mask=2000000
aer_event: 0000:0e:00.0 CXL Bus Error: severity=Fatal, Uncorrectable Internal Error, TLP Header=Not available
pcieport 0000:0e:00.0: CXL Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
pcieport 0000:0e:00.0:   device [19e5:a129] error status/mask=00400000/02000000
pcieport 0000:0e:00.0:    [22] UncorrIntErr          
cxl_aer_uncorrectable_error: memdev=0000:0e:00.0 host=0000:0d:00.0 serial=0 status='Cache Byte Enable Parity Error' first_error='Cache Byte Ena'
cxl_aer_uncorrectable_error: memdev=mem3 host=0000:0f:00.0 serial=0 status='Cache Byte Enable Parity Error' first_error='Cache Byte Enable Pari'
Kernel panic - not syncing: CXL cachemem error.
CPU: 10 UID: 0 PID: 218 Comm: kworker/10:1 Tainted: G            E       6.16.0-rc1-gec6a70ce29c1-dirty #428 PREEMPT(voluntary) 
Tainted: [E]=UNSIGNED_MODULE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
Workqueue: events cxl_proto_err_work_fn
Call Trace:
 <TASK>
 panic+0x364/0x3d0
 cxl_do_recovery+0xa3/0xb0
 cxl_proto_err_work_fn+0xf5/0x180
 process_scheduled_works+0xa8/0x420
 ? __pfx_worker_thread+0x10/0x10
 worker_thread+0x11c/0x260
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xfe/0x210
 ? __pfx_kthread+0x10/0x10
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x84/0xf0
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>
Kernel Offset: 0x3b400000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
---[ end Kernel panic - not syncing: CXL cachemem error. ]---

== Endpoint ==
root@tbowman-cxl:~/aer-inject# ./ep-ce-inject.sh
pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0f:00.0
pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0f:00.0
aer_event: 0000:0f:00.0 CXL Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not avaie
cxl_pci 0000:0f:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
cxl_pci 0000:0f:00.0:   device [8086:0d93] error status/mask=00004000/00000000
cxl_pci 0000:0f:00.0:    [14] CorrIntErr            
cxl_aer_correctable_error: memdev=mem3 host=0000:0f:00.0 serial=0 status='CRC Threshold Hit'

root@tbowman-cxl:~/aer-inject# ./ep-uce-inject.sh
pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0f:00.0
pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0f:00.0
aer_event: 0000:0f:00.0 CXL Bus Error: severity=Fatal, , TLP Header=Not available
cxl_pci 0000:0f:00.0: AER: CXL Bus Error: severity=Uncorrectable (Fatal), type=Inaccessible, (Unregistered Agent ID)
cxl_aer_uncorrectable_error: memdev=mem1 host=0000:0f:00.0 serial=0 status='Cache Byte Enable Parity Error' first_error='Cache Byte Enable Pari'
Kernel panic - not syncing: CXL cachemem error.
CPU: 10 UID: 0 PID: 147 Comm: irq/24-aerdrv Tainted: G            E       6.16.0-rc1-gec6a70ce29c1-dirty #423 PREEMPT(voluntary) 
Tainted: [E]=UNSIGNED_MODULE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 panic+0x364/0x3d0
 ? __pfx_aer_root_reset+0x10/0x10
 pci_error_detected+0x2b/0x30
 report_error_detected+0xf7/0x170
 ? __pfx_report_frozen_detected+0x10/0x10
 __pci_walk_bus+0x4c/0x70
 ? __pfx_report_frozen_detected+0x10/0x10
 pci_walk_bus+0x31/0x50
 pcie_do_recovery+0x163/0x2b0
 aer_isr_one_error_type+0x1e8/0x380
 ? __pfx_irq_thread_fn+0x10/0x10
 aer_isr_one_error+0x11d/0x140
 aer_isr+0x4c/0x80
 irq_thread_fn+0x24/0x70
 irq_thread+0x188/0x280
 ? __pfx_irq_thread_dtor+0x10/0x10
 ? __pfx_irq_thread+0x10/0x10
 kthread+0xfe/0x210
 ? __pfx_kthread+0x10/0x10
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x84/0xf0
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>
Kernel Offset: 0x2b200000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
---[ end Kernel panic - not syncing: CXL cachemem error. ]---

Changes
=======

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
 
Terry Bowman (17):
  cxl/pci: Remove unnecessary CXL Endpoint handling helper functions
  PCI/CXL: Add pcie_is_cxl()
  PCI/AER: Report CXL or PCIe bus error type in trace logging
  CXL/AER: Introduce CXL specific AER driver file
  CXL/AER: Introduce kfifo for forwarding CXL errors
  PCI/AER: Dequeue forwarded CXL error
  CXL/PCI: Introduce CXL uncorrectable protocol error recovery
  cxl/pci: Move RAS initialization to cxl_port driver
  cxl/pci: Map CXL Endpoint Port and CXL Switch Port RAS registers
  cxl/pci: Update RAS handler interfaces to also support CXL Ports
  cxl/pci: Log message if RAS registers are unmapped
  cxl/pci: Unify CXL trace logging for CXL Endpoints and CXL Ports
  cxl/pci: Update cxl_handle_cor_ras() to return early if no RAS errors
  cxl/pci: Introduce CXL Endpoint protocol error handlers
  CXL/PCI: Introduce CXL Port protocol error handlers
  CXL/PCI: Enable CXL protocol errors during CXL Port probe
  CXL/PCI: Disable CXL protocol error interrupts during CXL Port cleanup

 drivers/cxl/Kconfig           |  14 +++
 drivers/cxl/core/Makefile     |   1 +
 drivers/cxl/core/core.h       |  10 ++
 drivers/cxl/core/native_ras.c | 231 ++++++++++++++++++++++++++++++++++
 drivers/cxl/core/pci.c        | 231 ++++++++++++++++------------------
 drivers/cxl/core/port.c       |  12 +-
 drivers/cxl/core/ras.c        |  15 ++-
 drivers/cxl/core/regs.c       |   2 +
 drivers/cxl/core/trace.h      |  84 +++----------
 drivers/cxl/cxl.h             |  20 +++
 drivers/cxl/cxlpci.h          |   8 +-
 drivers/cxl/mem.c             |   3 +-
 drivers/cxl/pci.c             |  14 ++-
 drivers/cxl/port.c            | 159 +++++++++++++++++++++++
 drivers/pci/pci.c             |   1 +
 drivers/pci/pci.h             |  25 ++--
 drivers/pci/pcie/Makefile     |   1 +
 drivers/pci/pcie/aer.c        | 167 ++++--------------------
 drivers/pci/pcie/cxl_aer.c    | 179 ++++++++++++++++++++++++++
 drivers/pci/pcie/err.c        |   8 +-
 drivers/pci/pcie/rcec.c       |   1 +
 drivers/pci/probe.c           |  10 ++
 include/linux/aer.h           |  46 +++++++
 include/linux/pci.h           |  19 +++
 include/linux/pci_ids.h       |   2 +
 include/ras/ras_event.h       |   9 +-
 include/uapi/linux/pci_regs.h |   8 +-
 27 files changed, 916 insertions(+), 364 deletions(-)
 create mode 100644 drivers/cxl/core/native_ras.c
 create mode 100644 drivers/pci/pcie/cxl_aer.c


base-commit: 716ba3023561ccacfaa28f988d26717535b8fed1
-- 
2.34.1


