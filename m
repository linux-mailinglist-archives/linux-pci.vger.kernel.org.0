Return-Path: <linux-pci+bounces-37034-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00929BA1CEB
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 00:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91A0B2A336F
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 22:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2804C277011;
	Thu, 25 Sep 2025 22:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nY+AQLr+"
X-Original-To: linux-pci@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012016.outbound.protection.outlook.com [40.93.195.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E3713635E;
	Thu, 25 Sep 2025 22:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758839698; cv=fail; b=JgwTFqaD4FbAUJIHb5iTd/14Y5y2OEAY78i3Pv4EwKb9KEUWpATye7dUATbUAyIgdqEC0X37loNNLRsrXbZjBRl0fwckxLFOsk4vLgjfP1Bg61NhmF7Kvv+ueWz5WLAgmI8j2SAIUejraaCkev5F9rGyiuXcuL9KMjP8csXBgw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758839698; c=relaxed/simple;
	bh=imoClUSzfis84AOkHZ15VehAmZcHM8Uy6t03GIiQl3I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LidTrDQs6PaAlvjhKujBa50lxoib94892Br3E+5riJ8J2DdHhRhhYv9HZB5MwB7xjdtLLuv0ALfgBHswcg1fpTs64nXeROYtqOIxQvWKqcypHOEFDZjCg2KUteAiv0Bd2XxcOp2LhJFBS7VOAIjUBliggRAp4qHx192dr19Jf/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nY+AQLr+; arc=fail smtp.client-ip=40.93.195.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HDMciusKoI+BWS7Ps9IdXySvIuxl4XQUZsseCPSltaTUErG/TVVC3WsMK9uXOnZDLfiwheX7yUlW7/yxAerkGoSp+fy9XxkYoS9jp6Vk7aHJ16R6bsq3qpSmXRUzlz97k+VKUkfX5k8eYIAZuZhVU/3yGQEYnzQxj2cr2aO303VJYxvtQecD4CeNml2s2totMlgDYi+Xj5QHSfFXMH1llaqzxx/vEUl9MP5hJBbPScmmzFiNZS3P89YS1F94fXCAFp3tVyZLdzc5u0R4SWXH54ZTKW7uNaTs8i02i8pcrZIiXR784cmiC0YyWbRvXUASVgkNSqUvPk9MiAHHOM1M7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9sN+BeohP1efr2fogM6FKPoy4RSlWO4tIq0Or6jFek=;
 b=Co63mptCL2ge8gxnygX+LHqOH5V2KXeRjIYxn+FDLR9n5n/Awv2/ghFJS1yPZfWU0GPT4MLU9pCIHwt2AO1zdzuoZP5STP3eR/u9gp0NOL4tLv9Dw6MxTMvfI9R66rvPxwRZV0W6s+lOF/4OVJQkV0pB1eBF4BlP1rVzPZh0epERa/oli8PcAFzBY4jwq58L99io9sswLTb1j6lvc3JKMLiblfm3Pl11Wf8ck8zh3RNfYOhFO/abgsS2PDfKEQYfUwd4NYjmfQCDXzi0ePfAjPsabtrv2JiYV2Uuu9DL49HrMujNiCPOuaSVKSSaHdOEZTSxlR90jLNlA1icR2rE0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9sN+BeohP1efr2fogM6FKPoy4RSlWO4tIq0Or6jFek=;
 b=nY+AQLr+MK6yCDNnIMHuJwCrdKFMvWsR78sf20tQvhKkiSlUsB8fw5se3evOIZTiQp+2NUu0ab8Nx+diZYrCLprF08fihFwA8x5S0T/cVzZADeQ4BZiwCQs4ACK2eoeEt7AJFpkXj3JkylE47QmHtw36d6WupvnCP0Bwd9I2Jwg=
Received: from BY3PR05CA0017.namprd05.prod.outlook.com (2603:10b6:a03:254::22)
 by CH3PR12MB9344.namprd12.prod.outlook.com (2603:10b6:610:1c8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Thu, 25 Sep
 2025 22:34:48 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::29) by BY3PR05CA0017.outlook.office365.com
 (2603:10b6:a03:254::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.10 via Frontend Transport; Thu,
 25 Sep 2025 22:34:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 22:34:47 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 25 Sep
 2025 15:34:46 -0700
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
Subject: [PATCH v12 00/25]  Enable CXL PCIe Port Protocol Error handling and logging
Date: Thu, 25 Sep 2025 17:34:15 -0500
Message-ID: <20250925223440.3539069-1-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|CH3PR12MB9344:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eaf2400-9067-4507-0da7-08ddfc83bbd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qZuE9PIg9JgzJgvllj3yZV/5/JDnZxygyoLXi+Yi4a0+b3qx8CCrY7yqsPpk?=
 =?us-ascii?Q?GDP4TxdCBOV1BhBjNnVE2v6GLiCoQQVcfQkJhS6ZWCf+FOokwlbV0asMqVa7?=
 =?us-ascii?Q?33PcYjfH2adTsorKn4DbH+l7pzn4JQR1dXH4AIKnAAHg/DXELoD5Ly88E8q1?=
 =?us-ascii?Q?LtMg8n/r+rDn2tuSUdVgSX00WGjZ8CNNMo6KF4nxuujMEBiYKP0k1/ortqKX?=
 =?us-ascii?Q?aP5ASJWgM+GUM7tmCQsrvOAOIeq4BV7ysAJV8VEyhANZjPbjEr+wwLZ/iJ7A?=
 =?us-ascii?Q?lBrMqX44O1qv6Pc3mLIAxw8buBRYRyAK/qBzO8+w7iwxKPxYdp6u/2q/9g1F?=
 =?us-ascii?Q?B8z3O/vriocszkNGVTtli1ulHO3ce7v0vFSd6/yM2yHjAhfxJWBfhCWIjf5u?=
 =?us-ascii?Q?XD//rERjvbE26wXrQpmUUEZ3ap1r132nqf5gOEIqCsEgrZpx5+OebzZgfZmS?=
 =?us-ascii?Q?pqJqr9SRuHaZTqigmDNZwLz3xpVURuhbfI2f+H65pYwxvgwGX0CTGCeigddf?=
 =?us-ascii?Q?58ttcD7kt2EvJ5apPvKphTKSUqygr76lpJvdK09nMR5LuCH9gcw3XV42MFPo?=
 =?us-ascii?Q?u5MgOaBSgakPjs7UmNzwLNVAB8iycyXOfR8/qOvg6bqMU95vSrL7Q9ibe8oN?=
 =?us-ascii?Q?95zjYCTuCdUdBo9ycASwOXplr1+EYexhatLMuTa3nh/hYs3AmoQzvA7DiZWO?=
 =?us-ascii?Q?vKs46hveiinmJ1YCYH0MY5l1f75mt5TQpZATbrnw68VvJY9GdyGuovVF7ua5?=
 =?us-ascii?Q?uHTRTtj8gHLjazD5WWzwU+xrjaRfgjElfdP6pMNqbElJxSuQ/yK2JHh5I/5m?=
 =?us-ascii?Q?ZLylru3fa0LX12zPwXEruGcQ0dyjs68uDJiXTZ8fvo5H+KCIRPoDd+b5DRdP?=
 =?us-ascii?Q?ULvMpNucjaQHtTU/JiJoKkJLjwnutI4l+kMMCwi5Gt/shS/rvbF2gXYKJel2?=
 =?us-ascii?Q?i93zHxJ7qQKJIGUcfZlBeL3UwknItVIg8VMebL3ox3Ext2Oi4Fol6oRV5V3J?=
 =?us-ascii?Q?PQbCs/7k3bBsf2sn/6LPt898lfkY6Co6Um8CX5sYT5VeAVXkwWkIolcIuVwX?=
 =?us-ascii?Q?4T8dw9soaCZba3IezsTiHv2xiCkFHkw3pQXlsBwjQEqVpBffWc3t9khXvrPu?=
 =?us-ascii?Q?W3nPFv2MinRWjTzvAeF75uKih4FSNZT340OnzncRQxPMlT3QqkX9uB4NTsPp?=
 =?us-ascii?Q?q6bfJ9cqZ8FYXpkZQ7m74iHrCcDo1cdhOemVwaaCft9u3nIQ7m8/8ov8OTXB?=
 =?us-ascii?Q?JkTdAnK2Zl9TjqyDkjCG0IbYkQJULF3wsljTd/5YdbQ9hL8F/nPt8jSN9+lf?=
 =?us-ascii?Q?OVFilms71awFuwzZdP0l8MPQEe2wfCyQMFigKnrFekAxzZXg8Vi5Rb173Ned?=
 =?us-ascii?Q?0LUny2Cg0RqKVq0AGpdJ+ki80cjNquYqn+QUSFQNcIjVe1wU7EtCgUMMvSLX?=
 =?us-ascii?Q?wc0SeaL9RBX0YOikzzk4PWrDJ5bQWQAPE9h9dq3VVQYIjCS1QHZNDptTmLO4?=
 =?us-ascii?Q?uua7tNGahjN3sWJ+mL4wdoI6oZJlSf5hHOrApCdCLoUB+exPdnqBxOmweA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 22:34:47.7314
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eaf2400-9067-4507-0da7-08ddfc83bbd5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9344

This patchset updates CXL Protocol Error handling for CXL Ports and CXL
Endpoints (EP). Previous versions of this series can be found here:
https://lore.kernel.org/linux-cxl/20250827013539.903682-1-terry.bowman@amd.com/

The first 4 patches remove unneeded RAS functions in core/pci.c and then
move the remaining RAS logic to cxl/core/ras.c. CONFIG_PCIEAER_CXL is
replaced with with CONFIG_CXL_RAS. Note CONFIG_PCIEAER_CXL was defined in
AER driver's Kconfig and CONFIG_CXL_RAS is now defined in CXL's Kconfig.

The next 2 patches introduce drivers/pci/pcie/aer_cxl_rch.c and move in the
AER driver's RCH code. CONFIG_CXL_RCH is introduced and used to
conditionally compile aer_cxl_rch.c.

The next 3 patches introduce pcie_is_cxl() used in the AER driver's
CXL-PCIe error logging. This includes moving CXL DVSEC definitions to
uapi/linux/pci_regs.h.

The following 8 patches are cleanup in preparation for introducing CXL
device handling of CXL EP protocol errors. These rename the existing PCI
handlers for EPs while also introducing EP CXL error handling routines.
These also introduce PCI_ERS_RESULT_PANIC and update the handler CXL RAS
routine interfaces to support CXL device callbacks to be added later.

The following 3 patches address required changes for the CXL driver to
dequeue kfifo work. This includes introducing aer_cxl_vh.c to the AER
driver and moving in all AER driver's CXL RAS routines.

The following 3 patches add CXL Port protocol error support. These
also add CXL UCE recovery logic and move the following:
drivers/cxl/pci.c (cxl_pci) is moved to drivers/cxl/core/pci_drv.c (cxl_core)
This is required inorder to access cxl_pci_driver type from ras.c
(cxl_core) for calling cxl_pci_drv_bound().

The final 2 patches enable/disable CXL protocol errors. This is done
by updating the CXL devices' AER mask registers during port creation
and port teardown.

In summary, the new and moved files in this series are given below.
New Files:
drivers/pci/pcie/ras.c
drivers/pci/pcie/aer_cxl_rch.c
drivers/pci/pcie/aer_cxl_vh.c

Moved:
drivers/cxl/pci.c -> drivers/cxl/core/pci_drv.c
(this effectively eliminates the cxl_pci module).

=== Testing ===
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
aer_event: 0000:0c:00.0 CXL Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
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
cxl_aer_uncorrectable_error: memdev=0000:0e:00.0 host=0000:0d:00.0 serial=0: status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
cxl_aer_uncorrectable_error: memdev=mem1 host=0000:0f:00.0 serial=0: status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
cxl_aer_uncorrectable_error: memdev=0000:0e:03.0 host=0000:0d:00.0 serial=0: status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
cxl_aer_uncorrectable_error: memdev=mem2 host=0000:12:00.0 serial=0: status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
cxl_aer_uncorrectable_error: memdev=0000:0e:02.0 host=0000:0d:00.0 serial=0: status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
cxl_aer_uncorrectable_error: memdev=mem0 host=0000:11:00.0 serial=0: status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
cxl_aer_uncorrectable_error: memdev=0000:0e:01.0 host=0000:0d:00.0 serial=0: status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
cxl_aer_uncorrectable_error: memdev=mem3 host=0000:10:00.0 serial=0: status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
Kernel panic - not syncing: CXL cachemem error.
CPU: 10 UID: 0 PID: 185 Comm: kworker/10:1 Tainted: G            E       6.17.0-rc1-cxl-port-err-gc93c86e13947 #2170 PREEMPT(voluntary) 
Tainted: [E]=UNSIGNED_MODULE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
Workqueue: events cxl_proto_err_work_fn [cxl_core]
Call Trace:
 <TASK>
 vpanic+0x33f/0x3b0
 panic+0x5b/0x60
 cxl_proto_err_work_fn+0x45f/0x470 [cxl_core]
 process_one_work+0x196/0x3b0
 ? __pfx_worker_thread+0x10/0x10
 process_scheduled_works+0x42/0x60
 worker_thread+0x11c/0x260
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xfe/0x210
 ? __pfx_kthread+0x10/0x10
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x18d/0x1e0
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
cxl_aer_correctable_error: memdev=0000:0d:00.0 host=0000:0c:00.0 serial=0: status: 'CRC Threshold Hit'

root@tbowman-cxl:~/aer-inject# ./us-uce-inject.sh
pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0d:00.0
pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0d:00.0
aer_event: 0000:0d:00.0 CXL Bus Error: severity=Fatal, , TLP Header=Not available
pcieport 0000:0d:00.0: AER: CXL Bus Error: severity=Uncorrectable (Fatal), type=Inaccessible, (Unregistered Agent ID)
cxl_aer_uncorrectable_error: memdev=mem1 host=0000:0f:00.0 serial=0: status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
Kernel panic - not syncing: CXL cachemem error.
CPU: 10 UID: 0 PID: 147 Comm: irq/24-aerdrv Tainted: G            E       6.17.0-rc1-cxl-port-err-gc93c86e13947 #2170 PREEMPT(voluntary) 
Tainted: [E]=UNSIGNED_MODULE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 vpanic+0x33f/0x3b0
 panic+0x5b/0x60
 pci_error_detected+0x2b/0x30 [cxl_core]
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
 aer_isr_one_error_type+0x1f3/0x380
 aer_isr_one_error+0x117/0x140
 aer_isr+0x4c/0x80
 irq_thread_fn+0x24/0x70
 irq_thread+0x199/0x2a0
 ? __pfx_irq_thread_fn+0x10/0x10
 ? __pfx_irq_thread_dtor+0x10/0x10
 ? __pfx_irq_thread+0x10/0x10
 kthread+0xfe/0x210
 ? __pfx_kthread+0x10/0x10
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x18d/0x1e0
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
cxl_aer_uncorrectable_error: memdev=mem2 host=0000:10:00.0 serial=0: status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
cxl_aer_uncorrectable_error: memdev=0000:0e:03.0 host=0000:0d:00.0 serial=0: status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
cxl_aer_uncorrectable_error: memdev=mem1 host=0000:12:00.0 serial=0: status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
cxl_aer_uncorrectable_error: memdev=0000:0e:02.0 host=0000:0d:00.0 serial=0: status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
cxl_aer_uncorrectable_error: memdev=mem3 host=0000:11:00.0 serial=0: status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
Kernel panic - not syncing: CXL cachemem error.
CPU: 10 UID: 0 PID: 214 Comm: kworker/10:1 Tainted: G            E       6.17.0-rc1-cxl-port-err-gc93c86e13947 #2170 PREEMPT(voluntary) 
Tainted: [E]=UNSIGNED_MODULE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
Workqueue: events cxl_proto_err_work_fn [cxl_core]
Call Trace:
 <TASK>
 vpanic+0x33f/0x3b0
 panic+0x5b/0x60
 cxl_proto_err_work_fn+0x45f/0x470 [cxl_core]
 process_one_work+0x196/0x3b0
 ? __pfx_worker_thread+0x10/0x10
 process_scheduled_works+0x42/0x60
 worker_thread+0x11c/0x260
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xfe/0x210
 ? __pfx_kthread+0x10/0x10
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x18d/0x1e0
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
cxl_aer_correctable_error: memdev=mem0 host=0000:0f:00.0 serial=0: status: 'CRC Threshold Hit'

root@tbowman-cxl:~/aer-inject# ./ep-uce-inject.sh
pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0f:00.0
pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0f:00.0
aer_event: 0000:0f:00.0 CXL Bus Error: severity=Fatal, , TLP Header=Not available
cxl_core 0000:0f:00.0: AER: CXL Bus Error: severity=Uncorrectable (Fatal), type=Inaccessible, (Unregistered Agent ID)
cxl_aer_uncorrectable_error: memdev=mem0 host=0000:0f:00.0 serial=0: status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
Kernel panic - noroot@tbowman-cxlt syncing: CXL cacheme:~/aer-inject# m error.
CPU: 10 UID: 0 PID: 147 Comm: irq/24-aerdrv Tainted: G            E       6.17.0-rc1-cxl-port-err-gc93c86e13947 #2170 PREEMPT(voluntary) 
Tainted: [E]=UNSIGNED_MODULE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 vpanic+0x33f/0x3b0
 panic+0x5b/0x60
 pci_error_detected+0x2b/0x30 [cxl_core]
 report_error_detected+0xf7/0x170
 ? __pfx_report_frozen_detected+0x10/0x10
 __pci_walk_bus+0x4c/0x70
 ? __pfx_report_frozen_detected+0x10/0x10
 pci_walk_bus+0x31/0x50
 pcie_do_recovery+0x163/0x2b0
 aer_isr_one_error_type+0x1f3/0x380
 aer_isr_one_error+0x117/0x140
 aer_isr+0x4c/0x80
 irq_thread_fn+0x24/0x70
 irq_thread+0x199/0x2a0
 ? __pfx_irq_thread_fn+0x10/0x10
 ? __pfx_irq_thread_dtor+0x10/0x10
 ? __pfx_irq_thread+0x10/0x10
 kthread+0xfe/0x210
 ? __pfx_kthread+0x10/0x10
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x18d/0x1e0
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>
Kernel Offset: disabled
---[ end Kernel panic - not syncing: CXL cachemem error. ]---

==== Changes ====
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
  cxl: Remove ifdef blocks of CONFIG_PCIEAER_CXL from core/pci.c

Terry Bowman (24):
  cxl/pci: Remove unnecessary CXL Endpoint handling helper functions
  cxl/pci: Remove unnecessary CXL RCH handling helper functions
  CXL/AER: Remove CONFIG_PCIEAER_CXL and replace with CONFIG_CXL_RAS
  cxl: Move CXL driver RCH error handling into CONFIG_CXL_RCH_RAS
    conditional block
  CXL/AER: Introduce aer_cxl_rch.c into AER driver for handling CXL RCH
    errors
  CXL/PCI: Move CXL DVSEC definitions into uapi/linux/pci_regs.h
  PCI/CXL: Introduce pcie_is_cxl()
  PCI/AER: Report CXL or PCIe bus error type in trace logging
  CXL/AER: Update PCI class code check to use FIELD_GET()
  cxl/pci: Update RAS handler interfaces to also support CXL Ports
  cxl/pci: Log message if RAS registers are unmapped
  cxl/pci: Unify CXL trace logging for CXL Endpoints and CXL Ports
  cxl/pci: Update cxl_handle_cor_ras() to return early if no RAS errors
  cxl/pci: Map CXL Endpoint Port and CXL Switch Port RAS registers
  CXL/PCI: Introduce PCI_ERS_RESULT_PANIC
  cxl/pci: Introduce CXL Endpoint protocol error handlers
  CXL/AER: Introduce aer_cxl_vh.c in AER driver for forwarding CXL
    errors
  cxl: Introduce cxl_pci_drv_bound() to check for bound driver
  PCI/AER: Dequeue forwarded CXL error
  CXL/PCI: Introduce CXL Port protocol error handlers
  CXL/PCI: Export and rename merge_result() to pci_ers_merge_result()
  CXL/PCI: Introduce CXL uncorrectable protocol error recovery
  CXL/PCI: Enable CXL protocol errors during CXL Port probe
  CXL/PCI: Disable CXL protocol error interrupts during CXL Port cleanup

 Documentation/PCI/pci-error-recovery.rst |   6 +
 drivers/cxl/Kconfig                      |  16 +-
 drivers/cxl/Makefile                     |   2 -
 drivers/cxl/core/Makefile                |   3 +-
 drivers/cxl/core/core.h                  |  57 ++
 drivers/cxl/core/pci.c                   | 381 +-----------
 drivers/cxl/{pci.c => core/pci_drv.c}    |  27 +-
 drivers/cxl/core/port.c                  |  21 +-
 drivers/cxl/core/ras.c                   | 699 ++++++++++++++++++++++-
 drivers/cxl/core/regs.c                  |  12 +-
 drivers/cxl/core/trace.h                 |  68 +--
 drivers/cxl/cxl.h                        |  10 +-
 drivers/cxl/cxlpci.h                     |  56 --
 drivers/cxl/mem.c                        |   4 +-
 drivers/cxl/port.c                       |   5 +
 drivers/pci/pci.c                        |  19 +-
 drivers/pci/pci.h                        |  50 +-
 drivers/pci/pcie/Kconfig                 |   9 -
 drivers/pci/pcie/Makefile                |   2 +
 drivers/pci/pcie/aer.c                   | 156 ++---
 drivers/pci/pcie/aer_cxl_rch.c           |  99 ++++
 drivers/pci/pcie/aer_cxl_vh.c            |  98 ++++
 drivers/pci/pcie/err.c                   |  14 +-
 drivers/pci/pcie/rcec.c                  |   1 +
 drivers/pci/probe.c                      |  29 +
 include/linux/aer.h                      |  29 +
 include/linux/pci.h                      |  20 +
 include/ras/ras_event.h                  |   9 +-
 include/uapi/linux/pci_regs.h            |  65 ++-
 tools/testing/cxl/Kbuild                 |   2 +-
 30 files changed, 1304 insertions(+), 665 deletions(-)
 rename drivers/cxl/{pci.c => core/pci_drv.c} (98%)
 create mode 100644 drivers/pci/pcie/aer_cxl_rch.c
 create mode 100644 drivers/pci/pcie/aer_cxl_vh.c


base-commit: 46037455cbb748c5e85071c95f2244e81986eb58
-- 
2.34.1


