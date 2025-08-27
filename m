Return-Path: <linux-pci+bounces-34817-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D582DB376FF
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 03:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C2131896F0F
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 01:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC37C1E86E;
	Wed, 27 Aug 2025 01:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Epbdw7yW"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11984A33;
	Wed, 27 Aug 2025 01:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756258554; cv=fail; b=dnhk68y8CX8A67kLc1xZEOXs6B8vjRvsmptFuoFhBkrEO267mdhTNnlTC6RhDBKU3Wmpy1+Ya9+y20nesG4TsQs6Uya+IlnJ9yrBOB4UD6K22HUBL7n/zJoCan5XG+2/IaWdBpKlh9YltDbnO+Q6HYPguBFPtZRfyw5bND+gLxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756258554; c=relaxed/simple;
	bh=6v0jYNQT6ZFWmec0EqIQ5EiE9evbKJZGsjxENfWiU8A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IQ2h2RHZ8h1HPjqkQcLBfZj0xqAjyggrqhZ2ydI8LXfjlDmjOlWXAPmRHvyS01U+qgWZ52MGpS4bBCRh4zRU9sbzsH8fe1FVQWEY4ISNtyiGHOg89pQDYHtLP+khhyKHRBNJCtJ/Z36cKaHZaEvTHpDSZSs9LKpEFrwff0EiHyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Epbdw7yW; arc=fail smtp.client-ip=40.107.94.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M+vdlZUTZpcJtezb1vmgfBA8PQuphtZaYyffSEkWOz0ygVxfxB8NBM3jSmoVAOXXTQG3sBuu/BdzAczZMEtGH1zcMCGc3y37NQmF7ze/kMJxdE5AB0TQX48azQ1URLeIhYnQsmwoiqiEPHdU8v00Hur6qEuVvZbjcjFSF68UAKRoN0Leja7rdjMGx+S78rikRlxw2kF7qlgg18hCP2xt+756jvZ47UmJZPAzhPquqB9697iRd8msrpmOyoWdozZ2AkR9O5hrKPtiIBPi0psggZOHouKSGdfHOvcsl8CuPToyupCp8Y1l3qYAHPuZ0ILztN7P8ygqd996sV89ibRaeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TFZefK35dWhLSDHN0Xy5cBvLSB/dnI/QVCAQe7Ut0/Y=;
 b=wd/QBInByCb4OjPl19WtR00s6fgDja81Bjr59ibJg2t3YQ+cK9BcnPILlyq2rWgErPnkE4oFpJpWexFZt7mkWU/S/BQ94ueKzvSFpwgZymjyB4LoEr8FmlmXO+c7AlEicPDMwXkzS5Il4UDcuWoWh2avogZARMxIYIf78qFcwNUgse1d9yS2oxBcc5anIMdL0Xtg3lVu2fgVsvIDtAh0ctJVEyDLkUohOJlOYenUw+ZGJ9BO0YW/DhFswSpA02nqji/Zp/ur8od3wr+DNozQJXxti9Drxbk4eIDxwDj3H2YBt5fZKhTxn3rwItYFYL9CDAGjUa5wDUFU0PVPWIeVyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFZefK35dWhLSDHN0Xy5cBvLSB/dnI/QVCAQe7Ut0/Y=;
 b=Epbdw7yW0QHgXULvHEZ5Xxj7j5gD3i5KOkK2Z5RbmaZUf4vuHDpbX+Oqjede9gR5Ave5Ak4FqNJma/DPp+vQK2iVzO1AiQu/Btgn645Q+hckG8KTFDzCNKsL6/vd0DnVbr0xN/UqXRF8DenJnz3WMmmvhbKO+iK0sUFRWA4c7t4=
Received: from SJ0PR03CA0339.namprd03.prod.outlook.com (2603:10b6:a03:39c::14)
 by SA1PR12MB8985.namprd12.prod.outlook.com (2603:10b6:806:377::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 01:35:47 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:a03:39c:cafe::2c) by SJ0PR03CA0339.outlook.office365.com
 (2603:10b6:a03:39c::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.22 via Frontend Transport; Wed,
 27 Aug 2025 01:35:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Wed, 27 Aug 2025 01:35:46 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 20:35:44 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v11 00/23] Enable CXL PCIe Port Protocol Error handling and logging
Date: Tue, 26 Aug 2025 20:35:15 -0500
Message-ID: <20250827013539.903682-1-terry.bowman@amd.com>
X-Mailer: git-send-email 2.51.0.rc2.21.ge5ab6b3e5a
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|SA1PR12MB8985:EE_
X-MS-Office365-Filtering-Correlation-Id: 52315446-6166-488b-b83a-08dde50a0bcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?By0KJKA/x5bl8IxI6YKbJKMVoa3BhfjhFHoLvgOZ1J3saMnur+yp2d2FzJ1h?=
 =?us-ascii?Q?fP+pjlzVFybIvKsHv0/Cc83HJoVy5+2hNhZcTyO07NOWGlz2UFoolFHf4F/D?=
 =?us-ascii?Q?7Fg/hlofaag6fO3D6M3ete2vom5D6g3xHb6CO/FWPrZIR6yxAx3vhT5TDq/i?=
 =?us-ascii?Q?WEH2fUhcw6G6fVLdOoC0guF17Zow85AyDlj08WbQOVSUyutsvGHFiy7bN7ey?=
 =?us-ascii?Q?eCWnmiIVKwy157ZtiaLNP8Iekl6EfzsA7yKNxNNbAZfaTyta0Izh8T32Iz8f?=
 =?us-ascii?Q?zFNpiDN/9m1khmk48n7+3J//WQAs7fzyjBbjzyYtLfBiRArvMiSUal+xVYTm?=
 =?us-ascii?Q?MN/bYmUIcqx24mseCaLDg7lufd8YIkLb7OwvLxqCe+CMi2RJmEI/h/Vg7vnH?=
 =?us-ascii?Q?fd0vJILYdE9PPo1hS4k6K6qe1Z6mwuaGboefckysKvt90jYAu1y7sF4lWGTk?=
 =?us-ascii?Q?BeBnM4OtQudYJN7Tzf1NtEVvD7nDb+UK5uwbImiMO6ifsn4hH74b8wXk38CX?=
 =?us-ascii?Q?dFpb7+uJCPUStQJevRICEfyE7nR63RM26RfmSjeCB6EAnMLgeSOH8yY6RhCm?=
 =?us-ascii?Q?sH9giFGktkUk6bU7wXTqc1d6PAgn9ho+M/Z76l/dJr0N8pxznSxHW8ds8wVh?=
 =?us-ascii?Q?aUEuF9AvXeL2MqCKL0Ddxiee6IGJWm7RvGm5rTNL1tsHI2M7Y77r+dtZ3tAo?=
 =?us-ascii?Q?EVZsAzHu4PxCMW9qvsCY/STFbRVlZOPmRhAyOJa5YvEoVI6Vc0MC41+/9BtF?=
 =?us-ascii?Q?nlF2r3uku0b03vuBkhJhyOEAKZzeX8LTa5L+HsUkDWTWPvFih30GGCj/4LMV?=
 =?us-ascii?Q?0ymIZ85RrzmtrTxKIYtyTLPyRbznOcZFtUSzKb5/W3eKZU40cDbV2urEcI6e?=
 =?us-ascii?Q?G2URIglcbxrbYLtJ58CiN4iC7L6LKfRxI3biXoGAM4/r9wU8EBbEsB8+8I3T?=
 =?us-ascii?Q?fWAMWLx0DejXfKQXN2GPhXvRqg0wfxLjFCDuvlRXAojA0P+rnsQI47BF5ZI1?=
 =?us-ascii?Q?QjHh30NX4rvLHHDUw5ZOo3bv6ABlHWXx9ill4aajctEmH0jiiajBcFCfFKaI?=
 =?us-ascii?Q?4jzvqBEBva9L/Clvwiu8D/SCTs1VyI7hGiFECsysJ3OJtoq72dD1gpPCUZN8?=
 =?us-ascii?Q?SPsUFXIgDRUH4LuD+jH2uA69Px2JeBNOeiGNfBZBD1rOIumygrnKIAgAWYLQ?=
 =?us-ascii?Q?dLyg58Lfk7yPPDxLQ3WEDELVF92aGru9D7JAOAAmEE+YZcdl1aIEOIanh7ng?=
 =?us-ascii?Q?SaaUq8sz1eTh4pmAT2BkR6q+8rQmoBgv1SI7bq3CLC9SU9SL5bE25y87Vilx?=
 =?us-ascii?Q?8PBEuUXlkFz76Vo0dT78KTkE4YNh97X+bKhbpc8sWOqhQ5d6E/auYsCgRviH?=
 =?us-ascii?Q?wbR6WyTC+u/OEYpa+Pyb4Cmky5/F8ujEAqvRMmHOpBzcn72LdkFjrQi6rDw+?=
 =?us-ascii?Q?tNXqkNf7l658pY2bp/r7OGwWjjRtuu0zq5qW/28t6iD4VGKQGVsh7+++glrA?=
 =?us-ascii?Q?unG9ieJq3aakoL5k3pYOzZMYyLjR0eaAyFKL0Wu6FiltbnaMhsIhfSiq9Q?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 01:35:46.5732
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52315446-6166-488b-b83a-08dde50a0bcf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8985

This patchset adds CXL Protocol Error handling for CXL Ports and updates CXL
Endpoints (EP) handling. Previous versions of this series can be found here:
https://lore.kernel.org/linux-cxl/20250626224252.1415009-1-terry.bowman@amd.com/

The first 6 patches reorganize protocol error related CXL code into new files.
The first patch is authored by Dave Jiang and moves the CXL handling and logging into
cxl/core/ras.c. Patch 5 and 6 move the AER driver's restricted CXL host (RCH) logic
into pci/pcie/rch_aer.c. The RCH logic is used for CXL RCH devices from CXL1.1.
CONFIG_PCIEAER_CXL is removed and replaced with CONFIG_CXL_RAS, defined in CXL
Kconfig.

The next 4 patches introduce pcie_is_cxl() and use in the AER driver to detect and
log the error type as PCIe error or CXL error.

The next 4 patches are error handler cleanup in preparation for upcoming error handler
changes.

The next 7 patches introduce CXL Port error handling as well as updating the existing
CXL Endpoint handling. This sets all CXL Ports and EPs to use similar handling and logging
flow. Note, the PCIe EP handling remains for cases the EP is not recognized as a CXL
device. These patches also include change to move the AER driver's CXL virtual hierarchy
code into a new file named pci/pcie/cxl_aer.c. This separates the AER driver's CXL
implementation from the AER driver's core file.

The final 2 patches enable/disable CXL protocol error interrupts during CXL port
creation and teardown.

Note, I'll be on PTO until 9/10. Responses may be delayed.

==== Testing ====

Below are the testing results while using QEMU. The QEMU testing uses a CXL Root
Port, CXL Upstream Switch Port, CXL Downstream Switch Port and CXL Endpoint as
given below. I've attached the QEMU startup commandline used.

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
 aer_event: 0000:0c:00.0 CXL Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not availabl e
 pcieport 0000:0c:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
 pcieport 0000:0c:00.0:   device [8086:7075] error status/mask=00004000/0000a000
 pcieport 0000:0c:00.0:    [14] CorrIntErr
 cxl_aer_correctable_error: memdev=0000:0c:00.0 host=pci0000:0c serial=0: status: 'CRC Threshold Hit'  

 root@tbowman-cxl:~/aer-inject# ./root-uce-inject.sh
 pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0c:00.0
 pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0c:00.0
 aer_event: 0000:0c:00.0 CXL Bus Error: severity=Fatal, Uncorrectable Internal Error, TLP Header=Not availabl e
 pcieport 0000:0c:00.0: CXL Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
 pcieport 0000:0c:00.0:   device [8086:7075] error status/mask=00400000/02000000
 pcieport 0000:0c:00.0:    [22] UncorrIntErr
 cxl_aer_uncorrectable_error: memdev=0000:0c:00.0 host=pci0000:0c serial=0: status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
 BUG: kernel NULL pointer dereference, address: 0000000000000008
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: Oops: 0000 [#1] SMP NOPTI
 CPU: 10 UID: 0 PID: 216 Comm: kworker/10:1 Tainted: G            E       6.16.0-rc4-testing-00054-g263b76bedfed #1306 PREEMPT(voluntary)
 Tainted: [E]=UNSIGNED_MODULE
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
 Workqueue: events cxl_proto_err_work_fn [cxl_core]
 RIP: 0010:cxl_error_detected+0x18/0xd0 [cxl_core]
 Code: 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 41 56 41 55 41 54 55 48 89 fd 53 48 8b 5f 78 <4c> 8b 63 08 4d 8d b4 24 80 00 00 00 4c 89 f7 e8 e4 68 0a f6 be 0f
 RSP: 0018:ffffd1870091fd58 EFLAGS: 00010282
 RAX: 0000000000000007 RBX: 0000000000000000 RCX: 0000000000000003
 RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff8e0241c120c8
 RBP: ffff8e0241c120c8 R08: 0000000000000284 R09: 0000000000000001
 R10: 00000000ffffffff R11: 00cccccc00cccccc R12: ffff8e0241c12148
 R13: ffff8e0241724f00 R14: 0000000000000000 R15: ffff8e0248571740
 FS:  0000000000000000(0000) GS:ffff8e05f7ba5000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000008 CR3: 0000000113a8b000 CR4: 00000000003506f0
 Call Trace:
  <TASK>
  cxl_report_error_detected+0x3e/0x70 [cxl_core]
  cxl_walk_port.constprop.0+0xa4/0x140 [cxl_core]
  cxl_proto_err_work_fn+0x1fa/0x430 [cxl_core]
  ? srso_return_thunk+0x5/0x5f
  process_scheduled_works+0xa8/0x420
  ? __pfx_worker_thread+0x10/0x10
  worker_thread+0x11c/0x260
  ? __pfx_worker_thread+0x10/0x10
  kthread+0xfe/0x210
  ? __pfx_kthread+0x10/0x10
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x18d/0x1e0
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>
 Modules linked in: cfg80211(E) binfmt_misc(E) ppdev(E) intel_rapl_msr(E) cxl_mem(E) intel_rapl_common(E) cxl_pci(E) parport_pc(E) cxl_pmem(E) parport(E) input_leds(E) joydev(E) mac_hid(E) serio_raw(E) dm_m)
 CR2: 0000000000000008
 ---[ end trace 0000000000000000 ]---
 RIP: 0010:cxl_error_detected+0x18/0xd0 [cxl_core]
 Code: 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 41 56 41 55 41 54 55 48 89 fd 53 48 8b 5f 78 <4c> 8b 63 08 4d 8d b4 24 80 00 00 00 4c 89 f7 e8 e4 68 0a f6 be 0f
 RSP: 0018:ffffd1870091fd58 EFLAGS: 00010282
 RAX: 0000000000000007 RBX: 0000000000000000 RCX: 0000000000000003
 RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff8e0241c120c8
 RBP: ffff8e0241c120c8 R08: 0000000000000284 R09: 0000000000000001
 R10: 00000000ffffffff R11: 00cccccc00cccccc R12: ffff8e0241c12148
 R13: ffff8e0241724f00 R14: 0000000000000000 R15: ffff8e0248571740
 FS:  0000000000000000(0000) GS:ffff8e05f7ba5000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000008 CR3: 0000000113a8b000 CR4: 00000000003506f0
 note: kworker/10:1[216] exited with irqs disabled

 === Upstream Switch Port ===
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
 cxl_aer_uncorrectable_error: memdev=mem0 host=0000:0f:00.0 serial=0: status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
 Kernel panic - not syncing: CXL cachemem error.
 CPU: 10 UID: 0 PID: 147 Comm: irq/24-aerdrv Tainted: G            E       6.16.0-rc4-testing-00054-g263b76bedfed #1306 PREEMPT(voluntary)
 Tainted: [E]=UNSIGNED_MODULE
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
 Call Trace:
  <TASK>
  panic+0x364/0x3d0
  ? __pfx_aer_root_reset+0x10/0x10
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
  aer_isr_one_error+0x11d/0x140
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
 Kernel Offset: 0x13400000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
 ---[ end Kernel panic - not syncing: CXL cachemem error. ]---

 === Downstream Switch Port ===
 root@tbowman-cxl:~/aer-inject# ./ds-ce-inject.sh
 pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0e:00.0
 pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0e:00.0
 aer_event: 0000:0e:00.0 CXL Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
 pcieport 0000:0e:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
 pcieport 0000:0e:00.0:   device [19e5:a129] error status/mask=00004000/0000a000
 pcieport 0000:0e:00.0:    [14] CorrIntErr
 cxl_aer_correctable_error: memdev=0000:0e:00.0 host=0000:0d:00.0 serial=0: status: 'CRC Threshold Hit'    

 root@tbowman-cxl:~/aer-inject# ./ds-uce-inject# ./ds-uce-inject.sh
 pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0e:00.0
 pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0e:00.0
 aer_event: 0000:0e:00.0 CXL Bus Error: severity=Fatal, Uncorrectable Internal Error, TLP Header=Not available
 pcieport 0000:0e:00.0: CXL Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
 pcieport 0000:0e:00.0:   device [19e5:a129] error status/mask=00400000/02000000
 pcieport 0000:0e:00.0:    [22] UncorrIntErr
 cxl_aer_uncorrectable_error: memdev=0000:0d:00.0 host=0000:0c:00.0 serial=0: status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
 BUG: kernel NULL pointer dereference, address: 0000000000000008
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: Oops: 0000 [#1] SMP NOPTI
 CPU: 10 UID: 0 PID: 196 Comm: kworker/10:1 Tainted: G            E       6.16.0-rc4-testing-00054-g263b76bedfed #1306 PREEMPT(voluntary)
 Tainted: [E]=UNSIGNED_MODULE
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
 Workqueue: events cxl_proto_err_work_fn [cxl_core]
 RIP: 0010:cxl_error_detected+0x18/0xd0 [cxl_core]
 Code: 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 41 56 41 55 41 54 55 48 89 fd 53 48 8b 5f 78 <4c> 8b 63 08 4d 8d b4 24 80 00 00 00 4c 89 f7 e8 e4 68 aa d9 be 0f
 RSP: 0018:ffffd1178086fd58 EFLAGS: 00010282
 RAX: 0000000000000007 RBX: 0000000000000000 RCX: 0000000000000003
 RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff8a0201c510c8
 RBP: ffff8a0201c510c8 R08: 000000000000028c R09: 0000000000000001
 R10: 00000000ffffffff R11: 00cccccc00cccccc R12: ffff8a0201c51148
 R13: ffff8a0201c56000 R14: ffff8a02011ed000 R15: ffff8a0201110000
 FS:  0000000000000000(0000) GS:ffff8a05d3fa5000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000008 CR3: 0000000103574000 CR4: 00000000003506f0
 Call Trace:
  <TASK>
  cxl_report_error_detected+0x3e/0x70 [cxl_core]
  cxl_walk_port.constprop.0+0x12a/0x140 [cxl_core]
  ? srso_return_thunk+0x5/0x5f
  cxl_proto_err_work_fn+0x1fa/0x430 [cxl_core]
  ? srso_return_thunk+0x5/0x5f
  process_scheduled_works+0xa8/0x420
  ? __pfx_worker_thread+0x10/0x10
  worker_thread+0x11c/0x260
  ? __pfx_worker_thread+0x10/0x10
  kthread+0xfe/0x210
  ? __pfx_kthread+0x10/0x10
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x18d/0x1e0
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>
 Modules linked in: cfg80211(E) binfmt_misc(E) intel_rapl_msr(E) intel_rapl_common(E) ppdev(E) cxl_mem(E) cxl_pmem(E) parport_pc(E) cxl_pci(E) parport(E) joydev(E) input_leds(E) mac_hid(E) serio_raw(E) dm_m)
 CR2: 0000000000000008
 ---[ end trace 0000000000000000 ]---
 RIP: 0010:cxl_error_detected+0x18/0xd0 [cxl_core]
 Code: 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 41 56 41 55 41 54 55 48 89 fd 53 48 8b 5f 78 <4c> 8b 63 08 4d 8d b4 24 80 00 00 00 4c 89 f7 e8 e4 68 aa d9 be 0f
 RSP: 0018:ffffd1178086fd58 EFLAGS: 00010282
 RAX: 0000000000000007 RBX: 0000000000000000 RCX: 0000000000000003
 RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff8a0201c510c8
 RBP: ffff8a0201c510c8 R08: 000000000000028c R09: 0000000000000001
 R10: 00000000ffffffff R11: 00cccccc00cccccc R12: ffff8a0201c51148
 R13: ffff8a0201c56000 R14: ffff8a02011ed000 R15: ffff8a0201110000
 FS:  0000000000000000(0000) GS:ffff8a05d3fa5000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000008 CR3: 0000000103574000 CR4: 00000000003506f0
 note: kworker/10:1[196] exited with irqs disabled

 === Endpoint ===
 root@tbowman-cxl:~/aer-inject# ./ep-ce-inject.sh
 pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0f:00.0
 pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0f:00.0
 aer_event: 0000:0f:00.0 CXL Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
 cxl_pci 0000:0f:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
 cxl_pci 0000:0f:00.0:   device [8086:0d93] error status/mask=00004000/00000000
 cxl_pci 0000:0f:00.0:    [14] CorrIntErr
 cxl_aer_uncorrectable_error: memdev=mem0 host=0000:0f:00.0 serial=0: status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'

 root@tbowman-cxl:~/aer-inject# ./ep-uce-inject.sh
 pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0f:00.0
 pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0f:00.0
 aer_event: 0000:0f:00.0 CXL Bus Error: severity=Fatal, , TLP Header=Not available
 cxl_pci 0000:0f:00.0: AER: CXL Bus Error: severity=Uncorrectable (Fatal), type=Inaccessible, (Unregistered Agent ID)
 cxl_aer_uncorrectable_error: memdev=mem0 host=0000:0f:00.0 serial=0: status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
 Kernel panic - not syncing: CXL cachemem error.
 CPU: 10 UID: 0 PID: 148 Comm: irq/24-aerdrv Tainted: G            E       6.16.0-rc4-testing-00054-g263b76bedfed #1306 PREEMPT(voluntary)
 Tainted: [E]=UNSIGNED_MODULE
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
 Call Trace:
  <TASK>
  panic+0x364/0x3d0
  ? __pfx_aer_root_reset+0x10/0x10
  pci_error_detected+0x2b/0x30 [cxl_core]
  report_error_detected+0xf7/0x170
  ? __pfx_report_frozen_detected+0x10/0x10
  __pci_walk_bus+0x4c/0x70
  ? __pfx_report_frozen_detected+0x10/0x10
  pci_walk_bus+0x31/0x50
  pcie_do_recovery+0x163/0x2b0
  aer_isr_one_error_type+0x1f3/0x380
  aer_isr_one_error+0x11d/0x140
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
 Kernel Offset: 0xd600000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
 ---[ end Kernel panic - not syncing: CXL cachemem error. ]---

 ==== Changes ====
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

Terry Bowman (22):
  CXL/AER: Remove CONFIG_PCIEAER_CXL and replace with CONFIG_CXL_RAS
  cxl/pci: Remove unnecessary CXL Endpoint handling helper functions
  cxl/pci: Remove unnecessary CXL RCH handling helper functions
  cxl: Move CXL driver RCH error handling into CONFIG_CXL_RCH_RAS
    conditional block
  CXL/AER: Introduce rch_aer.c into AER driver for handling CXL RCH
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
  cxl/pci: Introduce CXL Endpoint protocol error handlers
  CXL/AER: Introduce cxl_aer.c into AER driver for forwarding CXL errors
  PCI/AER: Dequeue forwarded CXL error
  CXL/PCI: Introduce CXL Port protocol error handlers
  CXL/PCI: Export and rename merge_result() to pci_ers_merge_result()
  CXL/PCI: Introduce CXL uncorrectable protocol error recovery
  CXL/PCI: Enable CXL protocol errors during CXL Port probe
  CXL/PCI: Disable CXL protocol error interrupts during CXL Port cleanup

 drivers/cxl/Kconfig           |  10 +
 drivers/cxl/core/Makefile     |   2 +-
 drivers/cxl/core/core.h       |  46 +++
 drivers/cxl/core/pci.c        | 381 ++----------------
 drivers/cxl/core/port.c       |  11 +-
 drivers/cxl/core/ras.c        | 700 +++++++++++++++++++++++++++++++++-
 drivers/cxl/core/regs.c       |  12 +-
 drivers/cxl/core/trace.h      |  68 +---
 drivers/cxl/cxl.h             |  11 +-
 drivers/cxl/cxlpci.h          |  56 ---
 drivers/cxl/mem.c             |   6 +-
 drivers/cxl/pci.c             |  11 +-
 drivers/cxl/port.c            |   5 +
 drivers/pci/pci.c             |  19 +-
 drivers/pci/pci.h             |  31 +-
 drivers/pci/pcie/Kconfig      |   9 -
 drivers/pci/pcie/Makefile     |   2 +
 drivers/pci/pcie/aer.c        | 164 +-------
 drivers/pci/pcie/cxl_aer.c    | 144 +++++++
 drivers/pci/pcie/err.c        |  14 +-
 drivers/pci/pcie/rcec.c       |   1 +
 drivers/pci/pcie/rch_aer.c    |  99 +++++
 drivers/pci/probe.c           |  25 ++
 include/linux/aer.h           |  29 ++
 include/linux/pci.h           |  30 ++
 include/ras/ras_event.h       |   9 +-
 include/uapi/linux/pci_regs.h |  65 +++-
 tools/testing/cxl/Kbuild      |   2 +-
 28 files changed, 1286 insertions(+), 676 deletions(-)
 create mode 100644 drivers/pci/pcie/cxl_aer.c
 create mode 100644 drivers/pci/pcie/rch_aer.c

base-commit: f11a5f89910a7ae970fbce4fdc02d86a8ba8570f
--
2.51.0.rc2.21.ge5ab6b3e5a


