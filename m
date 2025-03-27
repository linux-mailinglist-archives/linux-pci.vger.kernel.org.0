Return-Path: <linux-pci+bounces-24800-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C740CA72840
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 02:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04A02189C853
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 01:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BA178F4B;
	Thu, 27 Mar 2025 01:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FKJYM7vP"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9511537C6;
	Thu, 27 Mar 2025 01:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743040054; cv=fail; b=FPUm4oqnL+1RfDQcGgNTLKpykNdtYNxQedF9EV2L5K1nReS12putjw/+oUPSCTZ3hoWarvliId4WLlqT8cPq6kLFG/OZFlOLdENPKtGpm0e0Zt+XAjISN5k9XqLgrZdlOMwczZ26UuNZg8Zmcljx87WhBD0cKHeEyzV8wXzP3cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743040054; c=relaxed/simple;
	bh=wHFR2Vugv84lAkUKTNVCFBzB0afDsuamqHMaNYjtrm8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g1tuZrfU/0rGq92UktgShL4YF3yGzR/MnezxcLPVUqMiPat1/XzcoNRxJkZN2m7XH1zOOnWMFVMf4qbl7dxL7ScV6BsPLc/Da3pxxAsCszEVKv6r25xKQuFHdLes7mOhsnHtn4w3XXaF/0zKAXNjdwNH0pYzFQAhIJQ+z1gK3Vo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FKJYM7vP; arc=fail smtp.client-ip=40.107.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=awmspoKVSg5f8uUOpNpysWWyxHBp7wrNLLAHF4NumHBdU5OaIoSagvUXKZG0vINDfW1MaylKvq7H78mMdio5Xvdzi9sNiwImarArUxorFDwnEtSuKnKQCXJLx1m78DaRfWBrq4gScQ2BjcKYutya7LU+SJBlUAetf+m8kGpvg7Zyl7ukQ9X27UZ7kD4TSlq9Nzhh+dpJbkX/lQNTNcPnKgF5RSKPwwPpIrL3W86e8uBZZadC3/7AfF5voezp8v6sVUV+M12hbjsV/p/PEtXHRl2GJX1AI6YefHMGeyo2BQyY0eYWSo1tcbCeFFNKZ4vaNjP6Y6Sa0HQxMYe6pli5dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2i0S2UO0/15FBt5tgvOT2CAxVb2ltXfWMlY/qWmDlA=;
 b=hKiCtsGbOytI1ilktCGF9qqK2PRWbjdF6vPOUV7Y+SN7rObEh0fx/6tyuZImoEUwDsb8IrfBEsNns4NrGcPlPrVDZvBI8SuewBx2GKtPWxL3elf0XYyVu+o8b8fILCZ1/VmSwQJdaqhUVYrstd/ogicI2xsu8qrL/R7wje3wukLkOOE2ouEV4aVFvuDm1Ly7giGrjSVJKMU2zTYqV4CIW7WB/19spR6NhwQ0hmFH7xy5zcyLU73aTUiC6GlUKFWd0l3kH41UYcnDotCdndrLeMYy6icV7bhy9wmXa/c5OZWyI/KAbdNPUOPjAmMbxln/FkNezjBJ7DTaZf3E9Qvbcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2i0S2UO0/15FBt5tgvOT2CAxVb2ltXfWMlY/qWmDlA=;
 b=FKJYM7vPyXICongIH9rICkhtLeYj9j23sK6HY2/Bk4Aiq7PIjrP0eC/89YXTaZHw1SSdIFNwPryRQwCoHci80VrQUB6P0IiFpsmEdC6YbYuGc7XGZCMu30OHum9IaeTnqY+4OlDNnX52qG7TRrkrUfpBSkANr3tP48sqwFq4hUc=
Received: from BN0PR04CA0009.namprd04.prod.outlook.com (2603:10b6:408:ee::14)
 by SA0PR12MB4413.namprd12.prod.outlook.com (2603:10b6:806:9e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 01:47:24 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:408:ee:cafe::cf) by BN0PR04CA0009.outlook.office365.com
 (2603:10b6:408:ee::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.43 via Frontend Transport; Thu,
 27 Mar 2025 01:47:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 27 Mar 2025 01:47:24 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 20:47:23 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>,
	<ming.li@zohomail.com>, <PradeepVineshReddy.Kodamati@amd.com>
Subject: [PATCH v8 00/16] Enable CXL PCIe port protocol error handling and logging 
Date: Wed, 26 Mar 2025 20:47:01 -0500
Message-ID: <20250327014717.2988633-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|SA0PR12MB4413:EE_
X-MS-Office365-Filtering-Correlation-Id: c8b1256a-970c-4ae0-1ff6-08dd6cd15282
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?56e/hEgaIJ6PcGY5zlLUyt/hMzUobnwz7IFzJNKh3bzUJNma9Qv+0AAQ+Els?=
 =?us-ascii?Q?zYsOPdRZpzxGPmIDSIzJ9+X0umdIgrzJU9cPm3smYNzSDY1jdZVppLL9kD+T?=
 =?us-ascii?Q?zHxxxA2XGGjaFYIqE5r84S3Oi1sxlS9LMcX7ElhrQonyB/P67Xz2UQv41gTy?=
 =?us-ascii?Q?HpAByFBvKT19rXaX4tFqZRqsEJompndzF8xNgJBERPeb6tVJ99H/uSfKAK9y?=
 =?us-ascii?Q?/corWShKE0u8SmtvwLkfTlwRczf35eyBj9fzHEMEP39VrJp2byA8euS3umNC?=
 =?us-ascii?Q?Zr9yDIlOq9/INEbNbwzXZz6VVZodg8iTH42i8WvduWbRMnF/PesyU4p+dkb8?=
 =?us-ascii?Q?GVEdR0O2wWUY4xQ/upPNDBL+3jacQTua/6IsK+8mQWdl7zqQJk+hMrWJ+Em7?=
 =?us-ascii?Q?YKyHGsD3kUYFd6rb4JAUhMzRaffSy++L7BoieyK4c/bKMB12EszTVkm5Ez7d?=
 =?us-ascii?Q?3NogNW5RdGiLnm0ig2Gcpd3A+lDzo4oDv1U9rHop3EDIrMg30c/oPwlMSfru?=
 =?us-ascii?Q?pCxz9H2ZfOSlN15N+zmw8F1nKjwg1qfrortHVwfZNYcyQ+AyBsOd8Laby4vh?=
 =?us-ascii?Q?m7WYJvtp4dlZy0UXQmhrrfUbXOcy5SLDbTlWByWQwV5ShFAKZOXhp7HjEjoU?=
 =?us-ascii?Q?ZWCL0RWFCJ14Ej2rj4nEMdmbxxKx+42Jgr03GfjjDwnwyljDE7jKGWVzzrgd?=
 =?us-ascii?Q?x1A0Ia3Gmw9HxxRyBCGR/ekqomtBn33TAfc0BFQF8jWJoAl3Jh6tsp3kkmnc?=
 =?us-ascii?Q?3eMniVZSXOflKns6zxnL1fTHcVT4OrzYVeS/J3VEcxQ6S7eHWiiUwZgZhVbW?=
 =?us-ascii?Q?NGvkI+t08ecNTW54CPk2BlZRA4/ISv1vu8iTMlN5Cb3PTVlmnaAYgBn6RXjA?=
 =?us-ascii?Q?kGQVHIgTfpkbcBC8h+4I1N6IVm/D8/xqpXni/PwrvytXy3cBoVPk9JalHqdU?=
 =?us-ascii?Q?XX16OjIcmv7TNplfUBDFdvAC9AQFPvNI0f1vPkHqMV2TdF6hgPQqP8Zj1Ogx?=
 =?us-ascii?Q?7GwoXG7phxULpq/MZ5Q9p0nm+xfKbFDx2aqxZ6c3o1WS1yW+9OzLTBVEJd7A?=
 =?us-ascii?Q?+kj/+a0ACJ7zCW068pZ48sHL4whZ2AiZEoSkANvsAo8ygG7AdliXkZqrikhz?=
 =?us-ascii?Q?E1XWSGy5H04MqjkXL3G4p+p7x8Z00NndSuw14kYVuzSgZGEZo32N7V4r4RNV?=
 =?us-ascii?Q?wVzYynYmWjh3Kd1ABgcPb24fv0ydXJ8jYu8k8gaG1Wd74Bp02f2kU303gA1r?=
 =?us-ascii?Q?HZQY2VFstRImgTo31GAbk5up3Wj7mG34MFwQFQjKx3EBYjo7iQIcFjzLTVsb?=
 =?us-ascii?Q?1S8AYl1t7K4qXjUOKzUXID3G+so/SfYnYOtp2RsyTOwHwmlBBcFgkkyeJqXC?=
 =?us-ascii?Q?+LzXH0T/TdB80oogP7zetBzn26c/SBbTNX2eo4KsZwEboyaA2+v0W9Ht3olw?=
 =?us-ascii?Q?ogS++Be4xjarh3RDkaMg9J1v6hGv02nosmwiOuR007fl01R1UXgxkw+ZjiQt?=
 =?us-ascii?Q?ZsVx41ZwJuiF5+Z3swz9ftvl9P8RIGDIOP2z?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 01:47:24.4233
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8b1256a-970c-4ae0-1ff6-08dd6cd15282
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4413

This patchset updates CXL Protocol Error handling for CXL Ports and CXL
Endpoints (EP). The reach of this patchset grew from CXL Ports to include
EPs as well because updating the handling for all devices is preferable
over supporting multiple handling paths.

This patchset is a continuation of v7 and can be found here:
https://lore.kernel.org/linux-cxl/20250211192444.2292833-1-terry.bowman@amd.com/

The difference between v7 and v8 includes a significant refactor of the CXL
error handling. v8 further defines the difference between CXL errors and
PCIe errors by moving the CXL error handling to the CXL driver. The intent
is to isolate the CXL error handling from the AER driver as much as
possible.  The AER driver will continue to handle AER interrupts but will
now forward an error to the CXL driver if it's a CXL error. If an error is
not a CXL error then the existing PCIe flow is used to handle the error.

Another change from v7->v8 is the error handlers themselves. v8 introduces
the error handlers as 'struct cxl_driver::err_handler' instead of as
'struct pci_dev::cxl_err_handlers' done in v7. 

Most of the review acks and reviewed-by's had to be taken down because of
changes.

= Patch Descriptions =
The first 2 patches introduce pci_dev::is_cxl, aer_info::is_cxl, and add
bus string to AER log tracing. aer_info::is_cxl will be used to indicate a
CXL or PCI error and will affect the error handling flow in later patches.

The next 6 patches add a kfifo for forwarding CXL errors to the CXL driver.
These patches also move the CXL handling from the AER service driver into
the CXL driver and add the necessary plumbing. This subset of patches also
introduces CXL UCE handling never present in the AER service driver. 

The next 3 patches add the CXL Port RAS mapping and interface updates to
support addition of CXL error handlers.

The final 5 patches add the CXL error handlers for CXL EPs and CXL Ports.
CXL EPs keep the PCIe error handler for cases the EP error is interpreted as
a PCIe error (please see USP and EP UCE testing below). These patches also
add logic to assign the CXL error handlers to a CXL device, unmask CXL
Protocol Errors during port probing, and mask CXL Protocol Errors during
port device cleanup. 

= Testing =
 Below are test results for this patchset using QEMU with CXL Root
 Port(RP, 0C:00.0), CXL Upstream Switch Port(USP, 0D:00.0), and CXL
 Downstream Switch Port(DSP, 0E:00.0), and Endpoint (EP, 0F:00.0).

 The sub-topology for testing is:
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

 NOTE: The USP and EP below include a UCE injection that is handled as a
 PCIe error instead of a CXL error. The stack trace shows handling from
 pcie_do_recovery() instead of cxl_do_redcovery(). This is because the AER
 info is not read from EP's or USP's due to the UCE error is AER_FATAL. As
 a result, the CXL RAS is not logged. But, panic is called when the PCIe
 report_error_detected() calls CXL EP PCIe error handler, containing the panic().
 
== CXL Root Port ==
root@tbowman-cxl:~/aer-inject# ./root-ce-inject.sh
pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0c:00.0
pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0c:00.0
pcieport 0000:0c:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
pcieport 0000:0c:00.0:   device [8086:7075] error status/mask=00004000/0000a000
pcieport 0000:0c:00.0:    [14] CorrIntErr            
aer_event: 0000:0c:00.0 CXL Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
cxl_aer_correctable_error: device=port1 (0000:0c:00.0) parent=root0 (pci0000:0c) serieal=0 status='CRC Threshold Hit'

root@tbowman-cxl:~/aer-inject# ./root-uce-inject.sh
pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0c:00.0
pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0c:00.0
pcieport 0000:0c:00.0: CXL Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
pcieport 0000:0c:00.0:   device [8086:7075] error status/mask=00400000/02000000
pcieport 0000:0c:00.0:    [22] UncorrIntErr      
aer_event: 0000:0c:00.0 CXL Bus Error: severity=Fatal, Uncorrectable Internal Error, TLP Header=Not available
cxl_aer_uncorrectable_error: device=port1 (0000:0c:00.0) parent=root0 (pci0000:0c) serial: 0 status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
Kernel panic - not syncing: CXL cachemem error.
CPU: 10 UID: 0 PID: 287 Comm: kworker/10:1 Tainted: G            E      6.14.0-rc1-hp-debug+ #199
Tainted: [E]=UNSIGNED_MODULE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
Workqueue: events cxl_prot_err_work_fn [cxl_core]
Call Trace:
 <TASK>
 dump_stack_lvl+0x27/0x90
 dump_stack+0x10/0x20
 panic+0x33e/0x380
 ? preempt_count_add+0x4b/0xc0
 cxl_do_recovery+0xc9/0xd0 [cxl_core]
 cxl_prot_err_work_fn+0x74/0x190 [cxl_core]
 process_scheduled_works+0xa6/0x420
 worker_thread+0x121/0x260
 kthread+0x10b/0x220
 ? __pfx_worker_thread+0x10/0x10
 ? _raw_spin_unlock_irq+0x1f/0x40
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x3c/0x60
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>
Kernel Offset: 0x4a00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
---[ end Kernel panic - not syncing: CXL cachemem error. ]---

== CXL Upstream Switch Port ==
root@tbowman-cxl:~/aer-inject# ./us-ce-inject.sh
pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0d:00.0
pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0d:00.0
pcieport 0000:0d:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
pcieport 0000:0d:00.0:   device [19e5:a128] error status/mask=00004000/0000a000
pcieport 0000:0d:00.0:    [14] CorrIntErr            
aer_event: 0000:0d:00.0 CXL Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
cxl_aer_correctable_error: device=port2 (0000:0d:00.0) parent=port1 (0000:0c:00.0) serieal=0 status='CRC Threshold Hit'

root@tbowman-cxl:~/aer-inject# ./us-uce-inject.sh
pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0d:00.0
pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0d:00.0
pcieport 0000:0d:00.0: AER: CXL Bus Error: severity=Uncorrectable (Fatal), type=Inaccessible, (Unregistered Agent ID)
aer_event: 0000:0d:00.0 CXL Bus Error: severity=Fatal, , TLP Header=Not available
Kernel panic - not syncing: CXL cachemem error.
CPU: 10 UID: 0 PID: 147 Comm: irq/24-aerdrv Tainted: G            E      6.14.0-rc1-hp-debug+ #200
Tainted: [E]=UNSIGNED_MODULE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x27/0x90
 dump_stack+0x10/0x20
 panic+0x33e/0x380
 ? __pfx_report_frozen_detected+0x10/0x10
 pci_error_detected+0x6d/0x70 [cxl_core]
 report_error_detected+0xc2/0x180
 ? __pm_runtime_resume+0x60/0x90
 ? __pfx_report_frozen_detected+0x10/0x10
 report_frozen_detected+0x16/0x20
 __pci_walk_bus+0x50/0x70
 ? __pfx_report_frozen_detected+0x10/0x10
 __pci_walk_bus+0x39/0x70
 ? __pfx_report_frozen_detected+0x10/0x10
 __pci_walk_bus+0x39/0x70
 ? __pfx_report_frozen_detected+0x10/0x10
 pci_walk_bus+0x32/0x50
 pci_walk_bridge+0x1d/0x40
 pcie_do_recovery+0x175/0x2b0
 ? __pfx_aer_root_reset+0x10/0x10
 aer_isr_one_error.isra.0+0x656/0x720
 ? srso_return_thunk+0x5/0x5f
 ? _raw_spin_unlock+0x19/0x40
 ? srso_return_thunk+0x5/0x5f
 ? __switch_to+0x115/0x420
 ? srso_return_thunk+0x5/0x5f
 ? __schedule+0x4d1/0x1190
 aer_isr+0x4d/0x80
 irq_thread_fn+0x28/0x70
 irq_thread+0x179/0x240
 ? srso_return_thunk+0x5/0x5f
 ? __pfx_irq_thread_fn+0x10/0x10
 ? __pfx_irq_thread_dtor+0x10/0x10
 kthread+0x10b/0x220
 ? __pfx_irq_thread+0x10/0x10
 ? _raw_spin_unlock_irq+0x1f/0x40
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x3c/0x60
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>
Kernel Offset: 0x6e00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
---[ end Kernel panic - not syncing: CXL cachemem error. ]---

== CXL Downstream Port == 
root@tbowman-cxl:~/aer-inject# ./ds-ce-inject.sh
pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0e:00.0
pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0e:00.0
pcieport 0000:0e:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
pcieport 0000:0e:00.0:   device [19e5:a129] error status/mask=00004000/0000a000
pcieport 0000:0e:00.0:    [14] CorrIntErr            
aer_event: 0000:0e:00.0 CXL Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
cxl_aer_correctable_error: device=port2 (0000:0e:00.0) parent=port1 (0000:0d:00.0) serieal=0 status='CRC Threshold Hit'

root@tbowman-cxl:~/aer-inject# ./ds-uce-inject.sh
pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0e:00.0
pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0e:00.0
pcieport 0000:0e:00.0: CXL Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
pcieport 0000:0e:00.0:   device [19e5:a129] error status/mask=00400000/02000000
pcieport 0000:0e:00.0:    [22] UncorrIntErr          
aer_event: 0000:0e:00.0 CXL Bus Error: severity=Fatal, Uncorrectable Internal Error, TLP Header=Not available
cxl_aer_uncorrectable_error: device=port2 (0000:0e:00.0) parent=port1 (0000:0d:00.0) serial: 0 status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enabl'
Kernel panic - not syncing: CXL cachemem error.
CPU: 10 UID: 0 PID: 81 Comm: kworker/10:0 Tainted: G            E      6.14.0-rc1-hp-debug+ #201
Tainted: [E]=UNSIGNED_MODULE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
Workqueue: events cxl_prot_err_work_fn [cxl_core]
Call Trace:
 <TASK>
 dump_stack_lvl+0x27/0x90
 dump_stack+0x10/0x20
 panic+0x33e/0x380
 ? preempt_count_add+0x4b/0xc0
 cxl_do_recovery+0xc9/0xd0 [cxl_core]
 cxl_prot_err_work_fn+0x74/0x190 [cxl_core]
 process_scheduled_works+0xa6/0x420
 worker_thread+0x121/0x260
 kthread+0x10b/0x220
 ? __pfx_worker_thread+0x10/0x10
 ? _raw_spin_unlock_irq+0x1f/0x40
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x3c/0x60
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>
Kernel Offset: 0x29c00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
---[ end Kernel panic - not syncing: CXL cachemem error. ]---

== CXL Endpoint ==
root@tbowman-cxl:~/aer-inject# ./ep-ce-inject.sh
 pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0f:00.0
 pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0f:00.0
 cxl_pci 0000:0f:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
 cxl_pci 0000:0f:00.0:   device [8086:0d93] error status/mask=00004000/00000000
 cxl_pci 0000:0f:00.0:    [14] CorrIntErr            
 aer_event: 0000:0f:00.0 CXL Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available 
 cxl_aer_correctable_error: device=mem3 (0000:0f:00.0) parent=0000:0f:00.0 (0000:0e:00.0) serieal=0 status='CRC Threshold Hit'

root@tbowman-cxl:~/aer-inject# ./ep-uce-inject.sh
pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0f:00.0
pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0f:00.0
cxl_pci 0000:0f:00.0: AER: CXL Bus Error: severity=Uncorrectable (Fatal), type=Inaccessible, (Unregistered Agent ID)
aer_event: 0000:0f:00.0 CXL Bus Error: severity=Fatal, , TLP Header=Not available
cxl_aer_uncorrectable_error: device=mem3 (0000:0f:00.0) parent=0000:0f:00.0 (0000:0e:00.0) serial: 0 status: 'Cache Byte Enable Parity '
Kernel panic - not syncing: CXL cachemem error.
CPU: 10 UID: 0 PID: 146 Comm: irq/24-aerdrv Tainted: G            E      6.14.0-rc1-hp-debug+ #203
Tainted: [E]=UNSIGNED_MODULE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x27/0x90
 dump_stack+0x10/0x20
 panic+0x33e/0x380
 pci_error_detected+0x6d/0x70 [cxl_core]
 report_error_detected+0xc2/0x180
 ? __pm_runtime_resume+0x60/0x90
 ? __pfx_report_frozen_detected+0x10/0x10
 report_frozen_detected+0x16/0x20
 __pci_walk_bus+0x50/0x70
 ? __pfx_report_frozen_detected+0x10/0x10
 pci_walk_bus+0x32/0x50
 pci_walk_bridge+0x1d/0x40
 pcie_do_recovery+0x175/0x2b0
 ? __pfx_aer_root_reset+0x10/0x10
 aer_isr_one_error.isra.0+0x656/0x720
 ? srso_return_thunk+0x5/0x5f
 ? _raw_spin_unlock+0x19/0x40
 ? srso_return_thunk+0x5/0x5f
 ? __switch_to+0x115/0x420
 ? srso_return_thunk+0x5/0x5f
 ? __schedule+0x4d1/0x1190
 aer_isr+0x4d/0x80
 irq_thread_fn+0x28/0x70
 irq_thread+0x179/0x240
 ? srso_return_thunk+0x5/0x5f
 ? __pfx_irq_thread_fn+0x10/0x10
 ? __pfx_irq_thread_dtor+0x10/0x10
 kthread+0x10b/0x220
 ? __pfx_irq_thread+0x10/0x10
 ? _raw_spin_unlock_irq+0x1f/0x40
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x3c/0x60
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>
Kernel Offset: 0x32200000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
---[ end Kernel panic - not syncing: CXL cachemem error. ]---

Changes
=======
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

Terry Bowman (16):
  PCI/CXL: Introduce PCIe helper function pcie_is_cxl()
  PCI/AER: Modify AER driver logging to report CXL or PCIe bus error
    type
  CXL/AER: Introduce Kfifo for forwarding CXL errors
  cxl/aer: AER service driver forwards CXL error to CXL driver
  PCI/AER: CXL driver dequeues CXL error forwarded from AER service
    driver
  CXL/PCI: Introduce CXL uncorrectable protocol error 'recovery'
  cxl/pci: Move existing CXL RAS initialization to CXL's cxl_port driver
  cxl/pci: Map CXL Endpoint Port and CXL Switch Port RAS registers
  cxl/pci: Update RAS handler interfaces to also support CXL PCIe Ports
  cxl/pci: Add log message if RAS registers are not mapped
  cxl/pci: Unifi CXL trace logging for CXL Endpoints and CXL Ports
  cxl/pci: Assign CXL Port protocol error handlers
  cxl/pci: Assign CXL Endpoint protocol error handlers
  cxl/pci: Remove unnecessary CXL Endpoint handling helper functions
  CXL/PCI: Enable CXL protocol errors during CXL Port probe
  CXL/PCI: Disable CXL protocol errors during CXL Port cleanup

 drivers/cxl/core/core.h       |   2 +
 drivers/cxl/core/pci.c        | 195 +++++++++-------------
 drivers/cxl/core/port.c       |   4 +-
 drivers/cxl/core/ras.c        | 304 +++++++++++++++++++++++++++++++++-
 drivers/cxl/core/regs.c       |   2 +
 drivers/cxl/core/trace.h      | 100 ++++-------
 drivers/cxl/cxl.h             |  37 +++++
 drivers/cxl/cxlpci.h          |   7 +-
 drivers/cxl/mem.c             |   3 +-
 drivers/cxl/pci.c             |   8 +-
 drivers/cxl/port.c            | 202 ++++++++++++++++++++++
 drivers/pci/pci.c             |   6 +
 drivers/pci/pci.h             |  14 +-
 drivers/pci/pcie/aer.c        | 180 ++++++++++++++------
 drivers/pci/pcie/rcec.c       |   1 +
 drivers/pci/probe.c           |  10 ++
 include/linux/aer.h           |  41 +++++
 include/linux/pci.h           |  18 ++
 include/ras/ras_event.h       |   9 +-
 include/uapi/linux/pci_regs.h |   8 +-
 20 files changed, 886 insertions(+), 265 deletions(-)


base-commit: aae0594a7053c60b82621136257c8b648c67b512
-- 
2.34.1


