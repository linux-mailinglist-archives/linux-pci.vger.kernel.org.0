Return-Path: <linux-pci+bounces-44793-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD19D20C5F
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 19:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 878973032CC9
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 18:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD33335098;
	Wed, 14 Jan 2026 18:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mbn0WfWo"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010026.outbound.protection.outlook.com [40.93.198.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9B933508B;
	Wed, 14 Jan 2026 18:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768414885; cv=fail; b=SsMRYazdGgEfHwf8vsM96XIUNAieEykgmPDkAt2L1MusC0rfi3q2w6SF9XnrumXljd1JoVqhquPwqFfem10otmqVxeBagF+I/H3bKo7BHCu8hTdrQx8+xS4AKNK1hMVwmzT8TsDR46OIN/b3Y8iMTmOWpxR235WnLqir7zylcbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768414885; c=relaxed/simple;
	bh=+IegmSjSdsItnywn/UuXzSLbdNpssmkRgjdeiAiq4ZI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=knW6myKVELqg0NRGDSPIBsDxU20WKWdS/eUI+FsV6W3sFxbIbTVYc5GJUk/beGdNNRvsx5yRrtFz8ObBrxciaZNMjPB8G2rdqXa92iLWj3m9PtC6RcjTVDDO6X70Sg6NZEtZdIwTO/YpJFo5o8ynUhIY6KKJw/InY3uO6zms4CU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mbn0WfWo; arc=fail smtp.client-ip=40.93.198.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oMMjHVjdsxgz7mnaHfj6bjZYqyXEjMyTu8NDIWHx9on1psCLwyWYTbRUwhcjmFXbD9FiTQE+6Fis/CItKK2R1IfeXkRWZGeGVeGEHCN9c9saNIKF/tnHXMgmzV8o5epoL1lWOP5/eoks2jUIlJrA2RhXQovtycahO/T5fGJHoEvwT7HH/xzclb2FtWfngBPrMpkct/rFBzSZ+oGlYNVytFBamDXEMvI2AeYSqoyd6TJIXbRYYRRxx5Qrgz2h0QdiQmLEszVCMYZiSmmAq27Upxwhmf0qxmPqJoBsoKAMEeTcGGLenjmFdQQBotZVgkEFo/3OQjy/2Iso6Zc1cqcW/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCO3GMr+oxE9/GOWrjyNef50XRw/VwZOVkKUbS4uLtc=;
 b=As7/nOsqbWf1jVjfgyYBbBKpWWn8diRVDTwacb5jUqFVGe996atvQNt2SIdMGsSYFjI5qP3k4SycTDg/uMNOorOlLpiHVoskGq/VTzweotB8/jCfNbkNBgROBoxFBqRasYt7LqKel3YGEm0cUqvNlOavOVYIjl7FHsQ4CBhBnlpOoPTWs2e65eI/VrCMPr0GEyDX5v/dpQdI2oLq2NonK5KZVjO3r02+eQ7eLTi3qLwLZFoA0ifWEZyYF+AIZH2x8/mVZE5x4GwwIsGve+c5as3zzT9SbRaRma36afmFMLaOYxV0wGzOJ+Eg/JyE4mM0iWFTdhO1wexoz4BoTJV9kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCO3GMr+oxE9/GOWrjyNef50XRw/VwZOVkKUbS4uLtc=;
 b=mbn0WfWoc28+aU/8RyEBjHMb6YmVRa52lXnhYA+TWsAWXZzxY08A1iuLO2MRAkMVqHToK+4YaZ099987tYTkkmHmSf8ZQq6RV9zCHgZSqAm/pVo4+LykSdkz5KJ3G5XdG9OchkOymXaNL8sn7k0U5zN3vaR1jeM1QAR81o67Zjg=
Received: from PH8P223CA0004.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::29)
 by CY8PR12MB7515.namprd12.prod.outlook.com (2603:10b6:930:93::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 18:21:03 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:510:2db:cafe::be) by PH8P223CA0004.outlook.office365.com
 (2603:10b6:510:2db::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Wed,
 14 Jan 2026 18:21:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 18:21:02 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 12:21:01 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [PATCH v14 00/34] Enable CXL PCIe Port Protocol Error handling and logging
Date: Wed, 14 Jan 2026 12:20:21 -0600
Message-ID: <20260114182055.46029-1-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|CY8PR12MB7515:EE_
X-MS-Office365-Filtering-Correlation-Id: 72202926-be71-43a7-7f37-08de5399acc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m3ovf4ENMj4gGZ0XErxVOOaipDg0A4DNmLqyM2OKZpoM1j4F7QiNIaLIl8fw?=
 =?us-ascii?Q?W6jMh56PiXz0huOkA/YBgfZSJV79heE/NZ+kjM56rnx5Y4N/YkuqzEaKwaoJ?=
 =?us-ascii?Q?rnclg6ocDBj6dHcb1ntmL2RCTBcKAbiSz5aDQbSREvobom+8IiK6E2DlgZaj?=
 =?us-ascii?Q?NKK/DwTOwjUyqRUzWaVF7AJy/rtffS9t3Scf4jUYn/fqRJNjDhvpbt+pnI5L?=
 =?us-ascii?Q?LZ/bytK9ywz3CeocxDEkRGCfOR5c6LKhgILKzPFyM+MBcqm3b+GsV0cRteuC?=
 =?us-ascii?Q?4AYvVfECULzYtI+ogZtD/5WGz46VtdmjlolH0jbemP4+LPryEyfSQvOJX7j6?=
 =?us-ascii?Q?39VHQOiqKFIkyJ/eou9nj4sQWCPOj44B09IXnEIIYPlOdLLT2NMRTWPJoNtS?=
 =?us-ascii?Q?vYuDyflPIdDylFj49XpIc4EK8G5ysAGnohIC6b+Sf6bXO31GhW30HIyZ6jHj?=
 =?us-ascii?Q?KC8rZTDDv6WeWpmXMbyPiJg+VJMUBLYCCt66Qhmx/CbHZdFTomYZVQpilqxE?=
 =?us-ascii?Q?jP7wvcq2DXsPtlNASDBBdjCoyq1Xih/AmoBxyArQncUCWAiJvOelOceSRLfh?=
 =?us-ascii?Q?80JZLrhhVWYmO7uwi6J4VT+iTg7QTFoB2bq5xtZXhwqRLPhuQJSHKByUWhpy?=
 =?us-ascii?Q?ntrr/7wW8BaFPUuUH8osYXz8sX/M5K5gK1wbo+jJhMQWS9P9cftklNdXE+FD?=
 =?us-ascii?Q?yXuZvOxt/MufPs9q7HueKoc7K9k6K7zLL+W2fVUHTWF6bTEkVqNdyDTMKaHY?=
 =?us-ascii?Q?HEiagZzaJOSE2f1BhD0kS1qcpv+SlFUUESpx+duo9TSAeByUXWQehUCPT+7y?=
 =?us-ascii?Q?a6hwvVxtjN1o+IOVfDZn2SYcHvS9R9E4d5DCEHSy59tJ3fKbmnVbk/uXRRIi?=
 =?us-ascii?Q?OO2IGKmC34kSfW8lee7jeqtBxo5nHj7qxQJKi4ueQxvPs0jYgiyU+H71vn+I?=
 =?us-ascii?Q?sakzi1q77M5UKiYJPxSwlNHPCrG4XwoZvwbKu5pRGaPKZHSz8guuAH6wK2Es?=
 =?us-ascii?Q?1I6ulRwTysae6wjayd5uir9/Dsr7tjHSA904EZCkdomc8ImyDCNpoTgExfa1?=
 =?us-ascii?Q?gFk4sYoO/aEwuI6E6bL/wRLq3FV+K3juNHiG6Kuw74PraYsemejOGx+AlNFN?=
 =?us-ascii?Q?YO+ZkCq/xvrRT+56kq6l3xdShKkUdRydgdt75sEI3hySYEUMK3pY2/izuteJ?=
 =?us-ascii?Q?ZV5BVwxIae/bNZVI1QW4Oo/bN3iknT+6+iMxYuS/Q0SpWJMeUmsLKqEXJ7ao?=
 =?us-ascii?Q?XS7Sj3rTPkruJap8rdkn3gyDejLNUEzsqix/Iz7VFdNxQGszKJeinVZx6fMZ?=
 =?us-ascii?Q?d2FGLHHi6u4+lL5G8rAGDLd/rs9Q00CCPJMKePBUFpGloXkhN5+rGuZsUYHx?=
 =?us-ascii?Q?C4Y0/w9vYq6vpoSJIWPuu8HZjiTXtt9l+J6ix6ZITMhP2iAkMt+e/JAV/dtc?=
 =?us-ascii?Q?fOjil/Z/CcQbZyBnGBoS17Zcg9mclP3Njan1mFQ66dRPZpiRwdZGW+/dpBGS?=
 =?us-ascii?Q?1g4IBR5t/ayxHLV5A0zp7tv5+0IIJkR4aKyOpMA2lBo/eANa9KKl23a+GyV2?=
 =?us-ascii?Q?dnSj8MiCNLN9uOHxcxCCPrBS1Xu0hrbt9koKBlARlnMS0SkC/6GaDVjyNH/l?=
 =?us-ascii?Q?bgs4CdnQGUsAFx1wjXchPqluAdZlPHpTm8Xm0RN25NkOV82ObEmLFeUY5Lh/?=
 =?us-ascii?Q?P5bc2lKXiBys8SZh/GvOjDsXXOI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 18:21:02.5917
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72202926-be71-43a7-7f37-08de5399acc3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7515

This patchset updates CXL Protocol Error handling for CXL Ports and CXL
Endpoints(EP). Previous version of this series can be found here:
https://lore.kernel.org/linux-cxl/20251104170305.4163840-1-terry.bowman@amd.com/

Patches 1-3 introduce pcie_is_cxl(). This includes moving the DVSEC
definitions to uapi/linux/pci_regs.h and then updating formating to match
existing definitions.

Patches 4-12 improve maintainability by separating CXL RAS logic from AER
and CXL PCI logic. 3 new files are created as a result. CXL RCH code in the
AER driver is moved to new file, pci/pcie/aer_cxl_rch.c. The CXL driver's
RAS related code is moved to cxl/core/ras.c, also a new file.
cxl/core/ras_rch.c is introduced to holf the CXL drivers RCH logic. These
moves allow the existing #ifdef conditional compilation to be removed.

Patches 13-18 are general changes needed for CXL handling. These replace
locks with guard(), add bus type to AER logging, add AER documentation, and
replace kernel config CONFIG_PCIEAER_CXL for CONFIG_CXL_RAS.

Patches 19-29 update the CXL Port and Downstream Port discovery. This set
of patches moves Endpoint RAS registers to the parent CXL Endpoint Port,
updates find_cxl_port_by_uport() to work with EP's, and moves dport RAS
setup to EP Port initialization. This subset of patches also moves the AER
driver's remaining CXL logic into pci/pcie/aer_cxl_vh.c.

Patches 30-34 introduce AER-CXL kfifo dequeue logic and add CXL Port
protocol handlers for CXL Ports and EPs. CXL EPs will also include PCI
protocol error handlers. Recent changes in this patch subset include only
logging and handling the the error source device instead of recursing
children devices.

@Bjorn - The patches requiring PCI approval use a "PCI" prefixed title.

== Testing ==
Below are the testing results while using QEMU. The QEMU testing uses a
CXL Root Port, CXL Upstream Switch Port, CXL Downstream Switch Port and CXL
Endpoint as given below. I've attached the QEMU startup commandline used.
This testing uses protocol error injection at all the devices.

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
            -smp 32 \
            -accel kvm \
            -drive file=${img},format=raw,index=0,media=disk \
            -device e1000,netdev=user.0 \
            -netdev user,id=user.0,hostfwd=tcp::5555-:22 \
            -object memory-backend-file,id=cxl-mem0,share=on,mem-path=/tmp/cxltest.raw,size=256M \
            -object memory-backend-file,id=cxl-mem1,share=on,mem-path=/tmp/cxltest1.raw,size=256M \
            -object memory-backend-file,id=cxl-mem2,share=on,mem-path=/tmp/cxltest2.raw,size=256M \
            -object memory-backend-file,id=cxl-mem3,share=on,mem-path=/tmp/cxltest3.raw,size=256M \
            -object memory-backend-file,id=cxl-lsa0,share=on,mem-path=/tmp/lsa0.raw,size=256M \
            -object memory-backend-file,id=cxl-lsa1,share=on,mem-path=/tmp/lsa1.raw,size=256M \
            -object memory-backend-file,id=cxl-lsa2,share=on,mem-path=/tmp/lsa2.raw,size=256M \
            -object memory-backend-file,id=cxl-lsa3,share=on,mem-path=/tmp/lsa3.raw,size=256M \
            -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
            -device cxl-rp,port=0,bus=cxl.1,id=root_port0,chassis=0,slot=0 \
            -device cxl-upstream,bus=root_port0,id=us0 \
            -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
            -device cxl-type3,bus=swport0,volatile-memdev=cxl-mem0,lsa=cxl-lsa0,id=cxl-vmem0 \
            -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
            -device cxl-type3,bus=swport1,volatile-memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-vmem1 \
            -device cxl-downstream,port=2,bus=us0,id=swport2,chassis=0,slot=6 \
            -device cxl-type3,bus=swport2,volatile-memdev=cxl-mem2,lsa=cxl-lsa2,id=cxl-vmem2 \
            -device cxl-downstream,port=3,bus=us0,id=swport3,chassis=0,slot=7 \
            -device cxl-type3,bus=swport3,volatile-memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-vmem3 \
            -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k


=== Root Port ===
root@tbowman-cxl:~/aer-inject# ./root-ce-inject.sh
pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0c:00.0
pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0c:00.0
aer_event: 0000:0c:00.0 CXL Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
pcieport 0000:0c:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
pcieport 0000:0c:00.0:   device [8086:7075] error status/mask=00004000/0000a000
pcieport 0000:0c:00.0:    [14] CorrIntErr
cxl_port_aer_correctable_error: device=0000:0c:00.0 host=pci0000:0c status='CRC Threshold Hit'

root@tbowman-cxl:~/aer-inject# ./root-uce-inject.sh
pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0c:00.0
pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0c:00.0
aer_event: 0000:0c:00.0 CXL Bus Error: severity=Fatal, Uncorrectable Internal Error, TLP Header=Not available
pcieport 0000:0c:00.0: CXL Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
pcieport 0000:0c:00.0:   device [8086:7075] error status/mask=00400000/02000000
pcieport 0000:0c:00.0:    [22] UncorrIntErr
cxl_port_aer_uncorrectable_error: device=0000:0c:00.0 host=pci0000:0c status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
Kernel panic - not syncing: CXL cachemem error.
CPU: 26 UID: 0 PID: 176 Comm: kworker/26:0 Tainted: G            E       6.19.0-rc4-gd2320443c4cf #222 PREEMPT(voluntary)
Tainted: [E]=UNSIGNED_MODULE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
Workqueue: events cxl_proto_err_work_fn [cxl_core]
Call Trace:
 <TASK>
 dump_stack_lvl+0x26/0xc0
 dump_stack+0x10/0x20
 vpanic+0x35e/0x3b0
 panic+0x57/0x60
 cxl_proto_err_work_fn+0x1fc/0x210 [cxl_core]
 process_one_work+0x22b/0x600
 worker_thread+0x195/0x350
 kthread+0x119/0x230
 ? __pfx_worker_thread+0x10/0x10
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x261/0x2e0
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>
Kernel Offset: disabled
---[ end Kernel panic - not syncing: CXL cachemem error. ]---

=== Upstream Port ===
root@tbowman-cxl:~/aer-inject# ./us-ce-inject.sh
pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0d:00.0
pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0d:00.0
aer_event: 0000:0d:00.0 CXL Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
pcieport 0000:0d:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
pcieport 0000:0d:00.0:   device [19e5:a128] error status/mask=00004000/0000a000
pcieport 0000:0d:00.0:    [14] CorrIntErr
cxl_port_aer_correctable_error: device=0000:0d:00.0 host=0000:0c:00.0 status='CRC Threshold Hit'

root@tbowman-cxl:~/aer-inject# ./us-uce-inject.sh
pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0d:00.0
pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0d:00.0
aer_event: 0000:0d:00.0 CXL Bus Error: severity=Fatal, , TLP Header=Not available
pcieport 0000:0d:00.0: AER: CXL Bus Error: severity=Uncorrectable (Fatal), type=Inaccessible, (Unregistered Agent ID)
cxl_port_aer_uncorrectable_error: device=0000:0f:00.0 host=0000:0e:00.0 status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
Kernel panic - not syncing: CXL cachemem error.
CPU: 26 UID: 0 PID: 247 Comm: irq/24-aerdrv Tainted: G            E       6.19.0-rc4-gd2320443c4cf #222 PREEMPT(voluntary)
Tainted: [E]=UNSIGNED_MODULE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x26/0xc0
 dump_stack+0x10/0x20
 vpanic+0x35e/0x3b0
 panic+0x57/0x60
 cxl_pci_error_detected+0xbb/0xc0 [cxl_core]
 report_error_detected+0xda/0x1d0
 ? __pfx_report_frozen_detected+0x10/0x10
 __pci_walk_bus+0x51/0x80
 ? __pfx_report_frozen_detected+0x10/0x10
 __pci_walk_bus+0x39/0x80
 ? __pfx_report_frozen_detected+0x10/0x10
 __pci_walk_bus+0x39/0x80
 ? __pfx_report_frozen_detected+0x10/0x10
 pci_walk_bus+0x32/0x50
 pcie_do_recovery+0x302/0x450
 ? __pfx_aer_root_reset+0x10/0x10
 aer_isr_one_error_type+0x18e/0x330
 aer_isr_one_error+0x124/0x150
 aer_isr+0x4c/0x80
 irq_thread_fn+0x28/0x70
 irq_thread+0x19a/0x2a0
 ? __pfx_irq_thread_fn+0x10/0x10
 ? __pfx_irq_thread_dtor+0x10/0x10
 kthread+0x119/0x230
 ? __pfx_irq_thread+0x10/0x10
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x261/0x2e0
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
cxl_port_aer_correctable_error: device=0000:0e:00.0 host=0000:0d:00.0 status='CRC Threshold Hit'

root@tbowman-cxl:~/aer-inject# ./ds-uce-inject.sh
pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0e:00.0
pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0e:00.0
aer_event: 0000:0e:00.0 CXL Bus Error: severity=Fatal, Uncorrectable Internal Error, TLP Header=Not available
pcieport 0000:0e:00.0: CXL Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
pcieport 0000:0e:00.0:   device [19e5:a129] error status/mask=00400000/02000000
pcieport 0000:0e:00.0:    [22] UncorrIntErr
cxl_port_aer_uncorrectable_error: device=0000:0e:00.0 host=0000:0d:00.0 status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
Kernel panic - not syncing: CXL cachemem error.
CPU: 26 UID: 0 PID: 176 Comm: kworker/26:0 Tainted: G            E       6.19.0-rc4-gd2320443c4cf #222 PREEMPT(voluntary)
Tainted: [E]=UNSIGNED_MODULE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
Workqueue: events cxl_proto_err_work_fn [cxl_core]
Call Trace:
 <TASK>
 dump_stack_lvl+0x26/0xc0
 dump_stack+0x10/0x20
 vpanic+0x35e/0x3b0
 panic+0x57/0x60
 cxl_proto_err_work_fn+0x1fc/0x210 [cxl_core]
 process_one_work+0x22b/0x600
 worker_thread+0x195/0x350
 kthread+0x119/0x230
 ? __pfx_worker_thread+0x10/0x10
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x261/0x2e0
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>
Kernel Offset: disabled
---[ end Kernel panic - not syncing: CXL cachemem error. ]---

=== Endpoint ====
root@tbowman-cxl:~/aer-inject# ./ep-ce-inject.sh
pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0f:00.0
pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0f:00.0
aer_event: 0000:0f:00.0 CXL Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
cxl_pci 0000:0f:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
cxl_pci 0000:0f:00.0:   device [8086:0d93] error status/mask=00004000/0000a000
cxl_pci 0000:0f:00.0:    [14] CorrIntErr
cxl_port_aer_correctable_error: device=0000:0f:00.0 host=0000:0e:00.0 status='CRC Threshold Hit'

root@tbowman-cxl:~/aer-inject# ./ep-uce-inject.sh
pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0f:00.0
pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0f:00.0
aer_event: 0000:0f:00.0 CXL Bus Error: severity=Fatal, , TLP Header=Not available
cxl_pci 0000:0f:00.0: AER: CXL Bus Error: severity=Uncorrectable (Fatal), type=Inaccessible, (Unregistered Agent ID)
cxl_port_aer_uncorrectable_error: device=0000:0f:00.0 host=0000:0e:00.0 status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
Kernel panic - not syncing: CXL cachemem error.
CPU: 26 UID: 0 PID: 247 Comm: irq/24-aerdrv Tainted: G            E       6.19.0-rc4-gd2320443c4cf #222 PREEMPT(voluntary)
Tainted: [E]=UNSIGNED_MODULE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x26/0xc0
 dump_stack+0x10/0x20
 vpanic+0x35e/0x3b0
 panic+0x57/0x60
 cxl_pci_error_detected+0xbb/0xc0 [cxl_core]
 report_error_detected+0xda/0x1d0
 ? __pfx_report_frozen_detected+0x10/0x10
 report_frozen_detected+0x16/0x20
 __pci_walk_bus+0x51/0x80
 ? __pfx_report_frozen_detected+0x10/0x10
 pci_walk_bus+0x32/0x50
 pcie_do_recovery+0x302/0x450
 ? __pfx_aer_root_reset+0x10/0x10
 aer_isr_one_error_type+0x18e/0x330
 aer_isr_one_error+0x124/0x150
 aer_isr+0x4c/0x80
 irq_thread_fn+0x28/0x70
 irq_thread+0x19a/0x2a0
 ? __pfx_irq_thread_fn+0x10/0x10
 ? __pfx_irq_thread_dtor+0x10/0x10
 kthread+0x119/0x230
 ? __pfx_irq_thread+0x10/0x10
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x261/0x2e0
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>
Kernel Offset: disabled
---[ end Kernel panic - not syncing: CXL cachemem error. ]---

== Changes ==
 Changes in v13->v14:
 PCI: Move CXL DVSEC definitions into uapi/linux/pci_regs.h
 - Add Jonathan's and Dan's review-by
 - Update commit title prefix (Bjorn)
 - Revert format fix for cxl_sbr_masked() (Jonathan)
 - Update 'Compute Express Link' comment block (Jonathan)
 - Move PCI_DVSEC_CXL_FLEXBUS definitions to later patch where
   used (Jonathan)
 - Removed stray change (Bjorn)
 PCI: Update CXL DVSEC definitions
 - New patch. Split from previous patch such that there is now a separate
   move patch and a format fix patch.
 - Formatting update requested (Bjorn)
 - Remove PCI_DVSEC_HEADER1_LENGTH_MASK because it duplicates
   PCI_DVSEC_HEADER1_LEN() (Bjorn)
 - Add Dan's review-by
 PCI: Introduce pcie_is_cxl()
 - Move FLEXBUS_STATUS DVSEC here (Jonathan)
 - Remove check for EP and USP (Dan)
 - Update commit message (Bjorn)
 - Fix writing past 80 columns (Bjorn)
 - Add pci_is_pcie() parent bridge check at beginning of function (Bjorn)
 PCI: Replace cxl_error_is_native() with pcie_aer_is_native()
 - New commit
 cxl/pci: Move CXL driver's RCH error handling into core/ras_rch.c
 - Add sign-off for Dan and Jonathan
 - Revert inadvertent formatting of cxl_dport_map_rch_aer() (Jonathan)
 - Remove default value for CXL_RCH_RAS (Dan)
 - Remove unnecessary pci.h include in core.h & ras_rch.c (Jonathan)
 - Add linux/types.h include in ras_rch.c (Jonathan)
 - Change CONFIG_CXL_RCH_RAS -> CONFIG_CXL_RAS (Dan)
 PCI/AER: Export pci_aer_unmask_internal_errors
 - New commit. Bjorn requested separating out and adding immediatetly
   before being used. This is called from cxl_rch_enable_rcec() in
   following patch.
 PCI/AER: Update is_internal_error() to be non-static is_aer_internal_error()
 - New commit
 PCI/AER: Move CXL RCH error handling to aer_cxl_rch.c
 - Add review-by and signed-off for Dan
 - Commit message fixup (Dan)
 - Update commit message with use-case description (Dan, Lukas)
 - Make cxl_error_is_native() static (Dan)
 - Make is_internal_error() non-static, non-export (Terry)
 PCI/AER: Use guard() in cxl_rch_handle_error_iter()
 - Add review-by for Jonathan, Dave Jiang, Dan WIlliams, and Bjorn
 - Remove cleanup.h (Jonathan)
 - Reverted comment removal (Bjorn)
 - Move this patch after pci/pcie/aer_cxl_rch.c creation (Bjorn)
 PCI/AER: Replace PCIEAER_CXL symbol with CXL_RAS
 - New commit
 PCI/AER: Report CXL or PCIe bus type in AER trace logging
 - Merged with Dan's commit. Changes are moving bus_type the last
   parameter in function calls (Dan)
 - Removed all DCOs because of changes (Terry)
 - Update commit message (Bjorn)
 - Add Bjorn's ack-by
 PCI/AER: Update struct aer_err_info with kernel-doc formatting
 - New commit
 cxl/mem: Clarify @host for devm_cxl_add_nvdimm()
 - New commit
 cxl/port: Remove "enumerate dports" helpers
 - New commit
 cxl/port: Fix devm resource leaks around with dport management
 - New commit
 cxl/port: Move dport operations to a driver event
 - New commit
 cxl/port: Move dport RAS reporting to a port resource
 - New commit
 cxl: Map CXL Endpoint Port and CXL Switch Port RAS registers
 - Correct message spelling (Terry)
 cxl/port: Move endpoint component register management to cxl_port
 - Correct message spelling (Terry)
 cxl/port: Map Port component registers before switchport init
 - Updates to use cxl_port_setup_regs() (Dan)
 cxl: Change CXL handlers to use guard() instead of scoped_guard()
 - Add reviewed-by for Jonathan and Dave Jiang
 PCI/ERR: Introduce PCI_ERS_RESULT_PANIC
 - Add review-by for Dan
 - Update Title prefix (Bjorn)
 - Removed merge_result. Only logging error for device reporting the
   error (Dan)
 - Remove PCI_ERS_RESULT_PANIC paragraph in pci-error-recovery.rst (Bjorn)
 PCI/AER: Move AER driver's CXL VH handling to pcie/aer_cxl_vh.c
 - Replaced workqueue_types.h include with 'struct work_struct'
   predeclaration (Bjorn)
 - Update error message (Bjorn)
 - Reordered 'struct cxl_proto_err_work_data' (Bjorn)
 - Remove export of cxl_error_is_native() here (Bjorn)
 cxl/port: Unify endpoint and switch port lookup
 - New patch
 PCI/AER: Dequeue forwarded CXL error
 - Update commit title's prefix (Bjorn)
 - Add pdev ref get in AER driver before enqueue and add pdev ref put in
   CXL driver after dequeue and handling (Dan)
 - Removed handling to simplify patch context (Terry)
 PCI: Introduce CXL Port protocol error handlers
 - Add Dave Jiang's review-by
 - Update commit message & headline (Bjorn)
 - Refactor cxl_port_error_detected()/cxl_port_cor_error_detected() to
   one line (Jonathan)
 - Remove cxl_walk_port(). Only log the erroring device. No port walking. (Dan)
 - Remove cxl_pci_drv_bound(). Check for 'is_cxl' parent port is
   sufficient (Dan)
 - Remove device_lock_if()
 - Combine CE and UCE here (Terry)
 cxl: Update Endpoint uncorrectable protocol error handling
 - Update commit headline (Bjorn)
 - Rename pci_error_detected()/pci_cor_error_detected() ->
   cxl_pci_error_detected/cxl_pci_cor_error_detected() (Jonathan)
 - Remove now-invalid comment in cxl_error_detected() (Jonathan)
 - Split into separate patches for UCE and CE (Terry)
 cxl: Update Endpoint correctable protocol error handling
 - New commit
 - Change cxl_cor_error_detected() parameter to &pdev->dev device from
   memdev device. (Terry)
 cxl: Enable CXL protocol errors during CXL Port probe
 - Update commit title's prefix (Bjorn)

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

Dan Williams (8):
  PCI/AER: Replace PCIEAER_CXL symbol with CXL_RAS
  cxl/mem: Clarify @host for devm_cxl_add_nvdimm()
  cxl/port: Remove "enumerate dports" helpers
  cxl/port: Fix devm resource leaks around with dport management
  cxl/port: Move dport operations to a driver event
  cxl/port: Move dport RAS reporting to a port resource
  cxl/port: Move endpoint component register management to cxl_port
  cxl/port: Unify endpoint and switch port lookup

Dave Jiang (1):
  cxl/pci: Remove CXL VH handling in CONFIG_PCIEAER_CXL conditional
    blocks from core/pci.c

Terry Bowman (25):
  PCI: Move CXL DVSEC definitions into uapi/linux/pci_regs.h
  PCI: Update CXL DVSEC definitions
  PCI: Introduce pcie_is_cxl()
  cxl/pci: Remove unnecessary CXL Endpoint handling helper functions
  cxl/pci: Remove unnecessary CXL RCH handling helper functions
  PCI: Replace cxl_error_is_native() with pcie_aer_is_native()
  cxl/pci: Move CXL driver's RCH error handling into core/ras_rch.c
  PCI/AER: Export pci_aer_unmask_internal_errors()
  PCI/AER: Update is_internal_error() to be non-static
    is_aer_internal_error()
  PCI/AER: Move CXL RCH error handling to aer_cxl_rch.c
  PCI/AER: Use guard() in cxl_rch_handle_error_iter()
  PCI/AER: Report CXL or PCIe bus type in AER trace logging
  PCI/AER: Update struct aer_err_info with kernel-doc formatting
  cxl: Update RAS handler interfaces to also support CXL Ports
  cxl: Update CXL Endpoint tracing
  cxl: Map CXL Endpoint Port and CXL Switch Port RAS registers
  cxl/port: Map Port component registers before switchport init
  cxl: Change CXL handlers to use guard() instead of scoped_guard()
  PCI/ERR: Introduce PCI_ERS_RESULT_PANIC
  PCI/AER: Move AER driver's CXL VH handling to pcie/aer_cxl_vh.c
  PCI/AER: Dequeue forwarded CXL error
  PCI: Introduce CXL Port protocol error handlers
  cxl: Update Endpoint uncorrectable protocol error handling
  cxl: Update Endpoint correctable protocol error handling
  cxl: Enable CXL protocol errors during CXL Port probe

 Documentation/PCI/pci-error-recovery.rst |   2 +
 drivers/cxl/Kconfig                      |   4 +
 drivers/cxl/acpi.c                       |  11 +-
 drivers/cxl/core/Makefile                |   3 +-
 drivers/cxl/core/core.h                  |  26 ++
 drivers/cxl/core/hdm.c                   |   6 +-
 drivers/cxl/core/pci.c                   | 402 +++-------------------
 drivers/cxl/core/pmem.c                  |  13 +-
 drivers/cxl/core/port.c                  | 245 +++++++-------
 drivers/cxl/core/ras.c                   | 405 ++++++++++++++++++++++-
 drivers/cxl/core/ras_rch.c               | 121 +++++++
 drivers/cxl/core/regs.c                  |  14 +-
 drivers/cxl/core/trace.h                 |  25 +-
 drivers/cxl/cxl.h                        |  53 +--
 drivers/cxl/cxlmem.h                     |   4 +-
 drivers/cxl/cxlpci.h                     |  93 +++---
 drivers/cxl/mem.c                        |   4 +-
 drivers/cxl/pci.c                        |  73 +---
 drivers/cxl/port.c                       | 187 ++++++++++-
 drivers/pci/pci.c                        |   1 +
 drivers/pci/pci.h                        |  39 ++-
 drivers/pci/pcie/Kconfig                 |   9 -
 drivers/pci/pcie/Makefile                |   2 +
 drivers/pci/pcie/aer.c                   | 144 ++------
 drivers/pci/pcie/aer_cxl_rch.c           | 104 ++++++
 drivers/pci/pcie/aer_cxl_vh.c            |  82 +++++
 drivers/pci/pcie/portdrv.h               |  16 +
 drivers/pci/probe.c                      |  31 ++
 include/linux/aer.h                      |  26 ++
 include/linux/pci.h                      |  11 +
 include/ras/ras_event.h                  |  12 +-
 include/uapi/linux/pci_regs.h            |  64 +++-
 tools/testing/cxl/Kbuild                 |  11 +-
 tools/testing/cxl/cxl_core_exports.c     |  22 --
 tools/testing/cxl/exports.h              |  13 -
 tools/testing/cxl/test/cxl.c             |   6 +-
 tools/testing/cxl/test/mock.c            |  54 +--
 tools/testing/cxl/test/mock.h            |   4 +-
 38 files changed, 1435 insertions(+), 907 deletions(-)
 create mode 100644 drivers/cxl/core/ras_rch.c
 create mode 100644 drivers/pci/pcie/aer_cxl_rch.c
 create mode 100644 drivers/pci/pcie/aer_cxl_vh.c
 delete mode 100644 tools/testing/cxl/exports.h


base-commit: 0f61b1860cc3f52aef9036d7235ed1f017632193
-- 
2.34.1


