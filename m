Return-Path: <linux-pci+bounces-21191-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABAAA31549
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 20:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BD397A3038
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 19:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA9F264609;
	Tue, 11 Feb 2025 19:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Zsg5bzJf"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC637262D3B;
	Tue, 11 Feb 2025 19:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739301901; cv=fail; b=btVSPO7gjMHGjhJd9aklDCc8/wFSZrdKjN0iuDaZgoAIPwGlxzD1HjdNIUA69B0yoorjwtPTDZMG/hOIK8jdE1wruZbZHXjlHYEC41cOiYiMPVOE6l6k7cyLhSvdhheXdORNNYHXlcUxpEk45AMCGk8IWyK/N1PGi9S0nC/FTZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739301901; c=relaxed/simple;
	bh=36I6R1pRNOSPGDL3apupSWy3vxjI/vcc14My7OcYjBo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jXqRlcCF6c4BmXR+gyJ6G59MOEhFV7qJ3Xq1q9wJpKc1ja5xP4Ddn9XCSmZDm9DSoWTPtAu9tx5Tb+NEUwEyj/P/PHQge00pzLEalJ7/asgr2p/BA5C48Ou/jB8H3MtHtkOX1+LWC/vcSJ5utO6mnbGBpWf2DD/VXVlTzcUdH/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Zsg5bzJf; arc=fail smtp.client-ip=40.107.237.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v4gx6VbXLK99B7wVNhl2Aoi7ML/cb2Z07MulImGgQvZ/ZERfXHtIHysagsbJ92hVxWTT/3vGl2+NESqdc9TZ8c53BUmJL/6S83O7fDgZXsLDOeC6+OFKQy7wKN6WFGG/AsZC3dlXgZ9ntgaAZ66KRMSP7LxhX8AkNAb+YDLF78wWFPrrdUQbKyTi7tQu75RElGPBib8bhXMuYW/kDU7s7fCbNnjzkLX3EythZ29cln114gJP+O+AFsifeWSZQyC4eKNyafdjdMON+tbR5pedyUDoiYCRyl6pR9H+GceQIIZMYCa0EYUZ7uIU+guwWZ0yoEh/av9mKrbLfCXYfok7sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9xxSfmQwfMlIWys5J5xcQYtvOd84vyMivqfT3dS3xQ=;
 b=YPEfCtGgXcrK7PxLNYGBeQSPe2BwdAjXJB0PVa/tFeIM4pW8ky1PGLttMs4RGT1R5LKJ9jSrTLjLwLvl4Yxgl7Q2HHD5FoG6BewuPWZeS1cIq9hbuBD8dd2eu/3Sh/0XGLAdOYEaK7Mf4LN/tyGcJrS2GObk/3pe9jEN99jt9X553TWPBA8QeJgtva0yEaI22xd1BD4KRMXT0ZNOIEVSw1b+FAZO5hAMQF9Q9QrQBmL9D3C1Wrc7RTRQEK6IcaSUBx1n8npdehuGHUlFEqO8Ru++1FaoL77lKNjcW/NYCm3v+Dzy99z6bHFn6zIDcndCoUboMwY8hj02h6ga99fVUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9xxSfmQwfMlIWys5J5xcQYtvOd84vyMivqfT3dS3xQ=;
 b=Zsg5bzJft0m+DPQo7gHWyozutKjiFtvyAXS8bMJjMuLMmPa0pFmsfIywm8bv2zHZt/1P2ji5ffhV4K5YWBUVXkWVVLP/4Q7G2VrixwRJKtP3+V34rgQQ9+1AESPAshg8NZFcNBwgU4qCyDnGYxKuLJNRp26/kMK1ToE3NsPOu8U=
Received: from BN9PR03CA0453.namprd03.prod.outlook.com (2603:10b6:408:139::8)
 by DS0PR12MB6391.namprd12.prod.outlook.com (2603:10b6:8:cd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Tue, 11 Feb
 2025 19:24:51 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:408:139:cafe::88) by BN9PR03CA0453.outlook.office365.com
 (2603:10b6:408:139::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Tue,
 11 Feb 2025 19:24:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 19:24:50 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 13:24:49 -0600
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
Subject: [PATCH v7 00/17] Enable CXL PCIe port protocol error handling and logging
Date: Tue, 11 Feb 2025 13:24:27 -0600
Message-ID: <20250211192444.2292833-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|DS0PR12MB6391:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b8a610a-c483-4fee-4701-08dd4ad1c153
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700013|82310400026|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c29BwJ+Jn6kmUx7+rMjhNM15QKGvNncpxFoaeH+cfgM1cxtpu19unjB1fBId?=
 =?us-ascii?Q?nQebIQRr+2PHjZao3AIJ7fcypedTb2p9+eAOG6LPJyAqTYWcEubzla9dOeet?=
 =?us-ascii?Q?RFGOVlTey3Dg+jej06m2hBcspeVMGUPXm/H0MjfSBd3Z9Vg5Zky5Gav9d7u6?=
 =?us-ascii?Q?uxBFhj2uUwZwLKK/tOTJ3/L0RzUqF4TTmNqL74Lwz5bTfv46Ya64AXYYQf3n?=
 =?us-ascii?Q?vjS3fgn7Kjg3qcIuD+iEFM4kwEgd1HTm4mZnQBDTMIiIWaJOaA+AUYZHHPvC?=
 =?us-ascii?Q?sbCkigNdSSKCHlgKn92wYB1zAFfm/o3Qugu90HHSaOjKoZPbrqTJ6Z+yNcOG?=
 =?us-ascii?Q?kUCbvJ+Czky2GwwQIKUBwvy8cWEqQQTXEXkDnSASU1KCJba5/PmpmLAyFW9h?=
 =?us-ascii?Q?nL3z5rHvR1kL5qRWOSilAyIAGsIn/gsJ3uwEbe0nzVzLr5sLZBAjPfRq4bM6?=
 =?us-ascii?Q?cDIUp7b8/Q8I74yeR8VpPpQg5WHOTYSl+T0P78fhlVwtTiFOI+AtFEtuNdFW?=
 =?us-ascii?Q?bb9RZRO1aVmlN9gwmoRarCW+3WRFvUs7fNqoETthiZXfpHjjP3r/KSwxKwFw?=
 =?us-ascii?Q?rQkBtdamFh2XCZG117zTWX/Dud3hV8koZ+Rsj4QLS/hh9J3Zympftb3+E11F?=
 =?us-ascii?Q?GwjIrFRs18Y0c7Bm32k4/C1NW1JIoZGXtN1U217WmIHhQ9yYEtSrppJVHSW0?=
 =?us-ascii?Q?z55AdEDGr8rIAv9sRbu/vpT2RRgV1NQZiY6kp7/+gme+GwDVqBM+qnVZgFDC?=
 =?us-ascii?Q?Q/Ml1Rp0SICATbaMXKV2RZThdSr6vRK4k2rk8v+6lreIpz/ib1QqMz5D2EcB?=
 =?us-ascii?Q?ZbOOWF5N7Va4ZqS88cRiBCjIqW+VTxPpGzOTiVMWMs8SEQ5O2J0nZiKT4Xb5?=
 =?us-ascii?Q?3kPlenfomYmdc61CUpY2sPWbfioDoE20sc9PYhY4cLIqPAsFbh87YXIaAiCo?=
 =?us-ascii?Q?XVBMfogcQ6JtKYv3YaUphhjsSvu5Eo2bF5RTFjDU6MJ19hzTexGemQl3QgR1?=
 =?us-ascii?Q?xzhXPqv74ao1tqeUKEL5I/TdzMMScKsELhGGF4o+OUk7jX4SlTyqOMMUMCuQ?=
 =?us-ascii?Q?/juX5iO6Cc8q87Em6g3o667hIjp8qmbyUsotAEZmiK18wmZ2cFs3Ql2nD07v?=
 =?us-ascii?Q?kGeA6HSJ9uqVjuVdtEY8yfKWngD6BFzoBbq4OrCJrBGP1+dSD3nvGnVvSbLX?=
 =?us-ascii?Q?47vGAEXgiosx+y9w3ICsFM6c1cuFMENdX5IAz6aqbM+o2/v9KYtjGAp0rJD8?=
 =?us-ascii?Q?4HEK2xzGNjQ1Y/HPyijskUJEIKuQr8KKz19qKh8y8IuQu3szxT4/dFO/tS11?=
 =?us-ascii?Q?9nn455iC3gySwizJTb9vLob/QzNVRviH75UAMlVPAqGXbDOQFWBdG/a7v9gA?=
 =?us-ascii?Q?kJhD5wXpzuGuXZfdD5k4jPctpGkjoqlCtG7lo4DmOQathcLgli9cstdv69LI?=
 =?us-ascii?Q?8ND3HsPFJT8dL+O43R2LzOfdzXg3dooZ+RMYTYf+j4eNlELEbA8+YN+UfmPY?=
 =?us-ascii?Q?PVOtZe52xx5RHb88KSWHz9ZytXqaL15cUp+q?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700013)(82310400026)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 19:24:50.7934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b8a610a-c483-4fee-4701-08dd4ad1c153
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6391

This patchset (v7) was a quick respin from the v6 patchset. v7 includes
fixes to correctly rebase changes into the expected patch.

The first 6 patches update the existing AER service driver to support CXL
PCIe Port Protocol Error handling and reporting. This includes AER service
driver changes for adding correctable and uncorrectable error support, CXL
specific recovery handling, and addition of CXL driver callback handlers.

The following 10 patches address CXL driver support for CXL PCIe Port
Protocol Errors. This includes the following changes to the CXL drivers:
mapping CXL components' RAS registers, interface updates for common
Restricted CXL host (RCH) and Virtual Hierarchy (VH) modes, adding CXL
Port Protocol Error handlers, introducing CXL tracing for CXL PCIe Port
devices, and adding capability to assign/clear CXL PCIe Port Protocol
Error handlers.

The patches mentioned above also includes a new patch to log the CXL
and PCIe names using dev_name() in the port error trace routines.
Example output is below and in the commit message.

The final patch is new to v6 and changes the Endpoint and RCH DP handling
to use CXL handling instead of PCIe handling. This was not initially
planned to be included in this patchset but found it would be more complex
to support both CXL errors (for CXL ports) and PCIe errors (for Endpoints
and RCH DPs) in the same driver. This final patch completes the support
for all CXL devices to use the CXL handling path.

Also, this patchset includes the removal of a patch present in previous
revisions. The previous patchset added changes to aer_get_device_error_info()
to read USP AER info and has been removed from this version. As a result, in
the case of a USP UCE fatal error the AER is not logged but CXL handlers do
attempt to read and log the RAS.

History details from the RFC can be found here:
https://lore.kernel.org/linux-cxl/20240617200411.1426554-1-terry.bowman@amd.com/


 Testing:
 ========
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
 cxl_port_aer_correctable_error: device=port1 (0000:0c:00.0) parent=root0 (pci0000:0c) status='Received Error From Physical Layer'

 == Root Port UnCorrectable Error ==
 root@tbowman-cxl:~/aer-inject# ./root-uce-inject.sh
 pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0c:00.0
 pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0c:00.0
 pcieport 0000:0c:00.0: CXL Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
 pcieport 0000:0c:00.0:   device [8086:7075] error status/mask=00400000/02000000
 pcieport 0000:0c:00.0:    [22] UncorrIntErr
 aer_event: 0000:0c:00.0 CXL Bus Error: severity=Fatal, Uncorrectable Internal Error, TLP Header=Not available
 cxl_port_aer_uncorrectable_error: device=port1 (0000:0c:00.0) parent=root0 (pci0000:0c) status: 'Memory Byte Enable Parity Error' first_error: 'Memory Byte Enable '
 cxl_detach_ep: cxl_mem mem3: disconnect mem3 from port2
 cxl_detach_ep: cxl_mem mem3: disconnect mem3 from port1
 cxl_detach_ep: cxl_mem mem0: disconnect mem0 from port2
 cxl_detach_ep: cxl_mem mem0: disconnect mem0 from port1
 cxl_detach_ep: cxl_mem mem2: disconnect mem2 from port2
 cxl_detach_ep: cxl_mem mem2: disconnect mem2 from port1
 cxl_detach_ep: cxl_mem mem1: disconnect mem1 from port2
 cxl_detach_ep: cxl_mem mem1: delete port2
 cxl_detach_ep: cxl_mem mem1: disconnect mem1 from port1
 Kernel panic - not syncing: CXL cachemem error.
 CPU: 10 UID: 0 PID: 146 Comm: irq/24-aerdrv Tainted: G            E      6.13.0-rc5-amdsos-cxldbg-gc0a8083c0d66-dirty #5207
 Tainted: [E]=UNSIGNED_MODULE
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
 Call Trace:
  <TASK>
  dump_stack_lvl+0x27/0x90
  dump_stack+0x10/0x20
  panic+0x33e/0x380
  ? preempt_count_add+0x4b/0xc0
  cxl_do_recovery+0xcb/0xd0
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
 Kernel Offset: 0x5800000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
 ---[ end Kernel panic - not syncing: CXL cachemem error. ]---

 == Upstream Port Correctable Error ==
 root@tbowman-cxl:~/aer-inject# ./us-ce-inject.sh
 pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0d:00.0
 pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0d:00.0
 pcieport 0000:0d:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
 pcieport 0000:0d:00.0:   device [19e5:a128] error status/mask=00004000/0000a000
 pcieport 0000:0d:00.0:    [14] CorrIntErr
 aer_event: 0000:0d:00.0 CXL Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
 cxl_port_aer_correctable_error: device=port2 (0000:0d:00.0) parent=port1 (0000:0c:00.0) status='Received Error From Physical Layer'

 == Upstream Port UnCorrectable Error ==
 root@tbowman-cxl:~/aer-inject# ./us-uce-inject.sh
 pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0d:00.0
 pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0d:00.0
 pcieport 0000:0d:00.0: AER: CXL Bus Error: severity=Uncorrectable (Fatal), type=Inaccessible, (Unregistered Agent ID)
 aer_event: 0000:0d:00.0 CXL Bus Error: severity=Fatal, , TLP Header=Not available
 cxl_port_aer_uncorrectable_error: device=port2 (0000:0d:00.0) parent=port1 (0000:0c:00.0) status: 'Memory Byte Enable Parity Error' first_error: 'Memory Byte $
 cxl_detach_ep: cxl_mem mem2: disconnect mem2 from port2
 cxl_detach_ep: cxl_mem mem2: disconnect mem2 from port1
 cxl_detach_ep: cxl_mem mem3: disconnect mem3 from port2
 cxl_detach_ep: cxl_mem mem3: disconnect mem3 from port1
 cxl_detach_ep: cxl_mem mem0: disconnect mem0 from port2
 cxl_detach_ep: cxl_mem mem0: disconnect mem0 from port1
 cxl_detach_ep: cxl_mem mem1: disconnect mem1 from port2
 cxl_detach_ep: cxl_mem mem1: delete port2
 cxl_detach_ep: cxl_mem mem1: disconnect mem1 from port1
 Kernel panic - not syncing: CXL cachemem error.
 CPU: 10 UID: 0 PID: 147 Comm: irq/24-aerdrv Tainted: G            E      6.13.0-rc5-amdsos-cxldbg-ge0fa85845e09-dirty #5226
 Tainted: [E]=UNSIGNED_MODULE
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
 Call Trace:
  <TASK>
  dump_stack_lvl+0x27/0x90
  dump_stack+0x10/0x20
  panic+0x33e/0x380
  ? preempt_count_add+0x4b/0xc0
  cxl_do_recovery+0xd2/0xe0
  aer_isr+0x355/0x6a0
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
 Kernel Offset: 0x10c00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
 ---[ end Kernel panic - not syncing: CXL cachemem error. ]---

 == Downstream Port Correctable Error ==
 root@tbowman-cxl:~/aer-inject# ./ds-ce-inject.sh
 pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0e:00.0
 pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0e:00.0
 pcieport 0000:0e:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
 pcieport 0000:0e:00.0:   device [19e5:a129] error status/mask=00004000/0000a000
 pcieport 0000:0e:00.0:    [14] CorrIntErr
 aer_event: 0000:0e:00.0 CXL Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
 cxl_port_aer_correctable_error: device=port2 (0000:0e:00.0) parent=port1 (0000:0d:00.0) status='Received Error From Physical Layer'

 == Downstream Port UnCorrectable Error ==
 root@tbowman-cxl:~/aer-inject# ./ds-uce-inject.sh
 pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0e:00.0
 pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0e:00.0
 pcieport 0000:0e:00.0: CXL Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
 pcieport 0000:0e:00.0:   device [19e5:a129] error status/mask=00400000/02000000
 pcieport 0000:0e:00.0:    [22] UncorrIntErr
 aer_event: 0000:0e:00.0 CXL Bus Error: severity=Fatal, Uncorrectable Internal Error, TLP Header=Not available
 cxl_detach_ep: cxl_mem mem3: disconnect mem3 from port2
 cxl_detach_ep: cxl_mem mem3: disconnect mem3 from port1
 Kernel panic - not syncing: CXL cachemem error.
 CPU: 10 UID: 0 PID: 147 Comm: irq/24-aerdrv Tainted: G            E      6.13.0-rc5-amdsos-cxldbg-gc0a8083c0d66-dirty #5207
 Tainted: [E]=UNSIGNED_MODULE
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
 Call Trace:
  <TASK>
  dump_stack_lvl+0x27/0x90
  dump_stack+0x10/0x20
  panic+0x33e/0x380
  ? preempt_count_add+0x4b/0xc0
  cxl_do_recovery+0xcb/0xd0
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
 Kernel Offset: 0xe400000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
 ---[ end Kernel panic - not syncing: CXL cachemem error. ]---

 == Endpoint Correctable Error ==
 root@tbowman-cxl:~/aer-inject# ./ep-ce-inject.sh
 pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0f:00.0
 pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0f:00.0
 cxl_pci 0000:0f:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
 cxl_pci 0000:0f:00.0:   device [8086:0d93] error status/mask=00004000/00000000
 cxl_pci 0000:0f:00.0:    [14] CorrIntErr
 aer_event: 0000:0f:00.0 CXL Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
 cxl_aer_correctable_error: memdev=mem0 host=0000:0f:00.0 serial=0: status: 'Received Error From Physical Layer'

 == Endpoint UnCorrectable Error ==
 root@tbowman-cxl:~/aer-inject# ./ep-uce-inject.sh
 pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0f:00.0
 pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0f:00.0
 cxl_pci 0000:0f:00.0: AER: CXL Bus Error: severity=Uncorrectable (Fatal), type=Inaccessible, (Unregistered Agent ID)
 aer_event: 0000:0f:00.0 CXL Bus Error: severity=Fatal, , TLP Header=Not available
 cxl_aer_uncorrectable_error: memdev=mem0 host=0000:0f:00.0 serial=0: status: 'Memory Byte Enable Parity Error' first_error: 'Memory '
 cxl_detach_ep: cxl_mem mem0: disconnect mem0 from port2
 cxl_detach_ep: cxl_mem mem0: disconnect mem0 from port1
 Kernel panic - not syncing: CXL cachemem error.
 CPU: 10 UID: 0 PID: 147 Comm: irq/24-aerdrv Tainted: G            E      6.13.0-rc5-amdsos-cxldbg-ge0fa85845e09-dirty #5225
 Tainted: [E]=UNSIGNED_MODULE
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
 Call Trace:
  <TASK>
  dump_stack_lvl+0x27/0x90
  dump_stack+0x10/0x20
  panic+0x33e/0x380
  cxl_do_recovery+0xd2/0xe0
  aer_isr+0x355/0x6a0
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
 Kernel Offset: 0x5c00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
 ---[ end Kernel panic - not syncing: CXL cachemem error. ]---

 Changes
 =======
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
 [Terry] Rebase to 5585e342e8d3 (cxl/next)
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
  PCI/AER: Add CXL PCIe Port uncorrectable error recovery in AER service
    driver
  cxl/pci: Map CXL PCIe Root Port and Downstream Switch Port RAS
    registers
  cxl/pci: Map CXL PCIe Upstream Switch Port RAS registers
  cxl/pci: Update RAS handler interfaces to also support CXL PCIe Ports
  cxl/pci: Add log message and add type check in existing RAS handlers
  cxl/pci: Change find_cxl_port() to non-static
  cxl/pci: Add error handler for CXL PCIe Port RAS errors
  cxl/pci: Add trace logging for CXL PCIe Port RAS errors
  cxl/pci: Update CXL Port RAS logging to also display PCIe SBDF
  cxl/pci: Add support to assign and clear pci_driver::cxl_err_handlers
  PCI/AER: Enable internal errors for CXL Upstream and Downstream Switch
    Ports
  cxl/pci: Handle CXL Endpoint and RCH Protocol Errors separately from
    PCIe errors

 drivers/cxl/core/core.h       |   2 +
 drivers/cxl/core/pci.c        | 261 ++++++++++++++++++++++++++--------
 drivers/cxl/core/port.c       |   4 +-
 drivers/cxl/core/trace.h      |  57 ++++++++
 drivers/cxl/cxl.h             |  10 +-
 drivers/cxl/cxlpci.h          |   3 +-
 drivers/cxl/mem.c             |  39 ++++-
 drivers/cxl/pci.c             |  10 +-
 drivers/pci/pci.c             |  13 ++
 drivers/pci/pci.h             |   3 +
 drivers/pci/pcie/aer.c        |  99 ++++++++-----
 drivers/pci/pcie/err.c        |  58 ++++++++
 drivers/pci/probe.c           |  10 ++
 include/linux/aer.h           |   1 +
 include/linux/pci.h           |  18 +++
 include/ras/ras_event.h       |   9 +-
 include/uapi/linux/pci_regs.h |   3 +-
 17 files changed, 486 insertions(+), 114 deletions(-)


base-commit: 5585e342e8d38cc598279bdb87f235f8b954dd5a
-- 
2.34.1


