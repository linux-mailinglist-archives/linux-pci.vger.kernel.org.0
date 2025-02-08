Return-Path: <linux-pci+bounces-20992-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FE9A2D221
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 01:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE5C8160DCA
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 00:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD4AD2FB;
	Sat,  8 Feb 2025 00:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XJOEwcVn"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8313ADDAB;
	Sat,  8 Feb 2025 00:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738974598; cv=fail; b=owdGBvwkxOU0aFlh6zej/x2PPJM9jkztzB642s7UqgHLjJJoABYR337xi/BNFYg9sU4tyihbeei4EndHjDY3BvlkiWmVZqlIzlDODlS6lweJvn6Gkm8dMd0XyYD7PCMMnKoD9Jf+D35/jgLkEGExEQokk6iRfckr/JcFjxjnckM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738974598; c=relaxed/simple;
	bh=syjhLSNonv+3q2eaoQK4TVEZqi/S1RJmuczrB1Sr7n0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YW7QZKad05vGbtxeis01+sGcPZY/69/RLYg8TO0BDFp7NEhceZa7DdGlNpPCR9EPBfZQpkXUwUuoF4VqARvV0Ir9bgJEOwbEUAkiQlclv2LSKsF8tSPFh+v9xxgrJ5nRBlWBgK8eT7gpp6PPND5ueSNy5dkUEhsVGDVFJjlFHzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XJOEwcVn; arc=fail smtp.client-ip=40.107.92.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nwnGVxGE7CScaEUhvwzR+ilEGVOxGmR4aypYE6QEnBZUpbGofLrDH+ZOEX6SeVnwEmTXNOBrQoGpq1cTXJefKPFAH8qmGPEHRAoGb9xH2PPiETeX73nXy8SVK77V6m8cGNEGNdjYZ/4S0mLISsSpFjIqqejigl+/zbGAsI26zae5STqcewB8NNGDF8+6yuNWyEhh4PZq6LC3G6OcYcdQbMhDfCM/EkBD4YeNto3dWuYbE1z8nVWoCOfQbaQZ+FnGDexbxDqrrvTPOKkH4HemzbnADxEsXJWtvg2kjYq4JHBgxwaXRRBwm+sMicsrzs7JcIA7ELAO2g2FtWPbkMhA0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKZKF19s/5bjb3sg9vwCBu0vUsw/WDxC1Qxa6dg6sCw=;
 b=Tl3ZLZihQOEwFciLvATPgiYcpRnq/trolB4rnFLJ1/PGkpViASnHHsbitePFHwzW/gfYUzADLc94/bSV3FsFjp9agdWOnY6yqDo72EPrj/zc36IqiZnbrof3gBRndVNCD/r/o1JMiue1hKC3RPCzE+VVhTxfdmhWEsRpngfTsqPkm4wejqtVjuwaxvLJ42t6Cd26fVsbZBAIiiWQyfbp91S4lDmT/DhkZSEX/xiU+1bcOz8VKkWXakgvW5gp0Pngv1NVMPmHjgKh099EEzbVBrURdrkEumpNc7WBEPyCxhmpB0JquqGfdpF25Hq12vL9uKTvjGMGTlvucb+qNRR9Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKZKF19s/5bjb3sg9vwCBu0vUsw/WDxC1Qxa6dg6sCw=;
 b=XJOEwcVnfAOX5GXFfSftoHw0kfU7Gzr2CIet70SyYCcUauLXLjJNWkdMnyHumnGp5r8xN1TuS5gJ/vODTc5qNdATvxf1Jo7SJ1RqucP7joTjLfnEfIVWPOPR0UTl7Y4YB92PtDwjwhk+cta9mi2VH5vVDTrP0tgDSMpOz2x7fR0=
Received: from BY5PR03CA0016.namprd03.prod.outlook.com (2603:10b6:a03:1e0::26)
 by SJ2PR12MB7964.namprd12.prod.outlook.com (2603:10b6:a03:4cf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Sat, 8 Feb
 2025 00:29:49 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::c1) by BY5PR03CA0016.outlook.office365.com
 (2603:10b6:a03:1e0::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.24 via Frontend Transport; Sat,
 8 Feb 2025 00:29:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Sat, 8 Feb 2025 00:29:49 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 18:29:46 -0600
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
Subject: [PATCH v6 00/17] Enable CXL PCIe port protocol error handling and logging
Date: Fri, 7 Feb 2025 18:29:24 -0600
Message-ID: <20250208002941.4135321-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|SJ2PR12MB7964:EE_
X-MS-Office365-Filtering-Correlation-Id: 99f68723-41c0-45ab-4358-08dd47d7b28e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|36860700013|376014|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cXaTOUii4vVuX/t2B+mQkC4+A6tGs/tAeBNNM8uria0q+L2ShbRo6ofWxUJq?=
 =?us-ascii?Q?wkbhiO4jj8M92yLgRlSNw8aAf4DlY3SivWPnub4Akwe9V62I1ugh1f0Vtfn9?=
 =?us-ascii?Q?Evi6miMhfQVu1s8luUJEIbybSS0IYGZUmf9FWqykEHMKNzQ3mQNhUH0hRwea?=
 =?us-ascii?Q?aO7HKVlo750c2Ohli4zFQ+qGU6Ru0W0lyWMLJqfHDLLSDkNxnZntlgVoNMYv?=
 =?us-ascii?Q?xVoAGAVRXhiW3jxBBg3oAo7WFReI0OV/RzlM0JiyFgd7TGuBWG+LMMJSY9pF?=
 =?us-ascii?Q?ffEboSP7GVszrTC6d5pZgF2JNFbjkHB+RGTm6sFW3pwDPYWXVRHaqDZCA+iA?=
 =?us-ascii?Q?/r4JF7XNxtmDL5chWJNoIwO6N6hPLsTnIGMh2nn2a0o29LwFkdANdUL1KiTI?=
 =?us-ascii?Q?XhQduso7bbd4uejab+89hWX55yrUlJnfXR8acJY6y6+1tZDAovFH6Q1+mkzQ?=
 =?us-ascii?Q?1KEpREC914N3jU3YOyqn0tTQ4HFvpCBTVeoIyKLCKZrdi2OvnodGDttX+sYj?=
 =?us-ascii?Q?NC9WN9mT/Tm5K/r6KQTTqAb2YVVcb7zpPzZKOb/XsMZ1Nrl6oO3ivnDcpW8K?=
 =?us-ascii?Q?JAcSodQcav9Ku5TsGvCVF8c8M9YNSYwPjR+1e5GVwLNxBCW8A3XmpRT5+ri3?=
 =?us-ascii?Q?ZOxNcMCWgOyxIgWwfktCG5BcVWIvzg+xwU2puwsZoBymaW694xngGRmvT18y?=
 =?us-ascii?Q?QdGoqtZQYPeggup1AtCfuTd4ZMUupIxVNFfLti58WDCk8YjUZzmUtWD6ngcf?=
 =?us-ascii?Q?O2OE2K5RZ5AGQhimNbss9L9oLcDMA2IY9qaC5w6bfZ63iHCyYd2+ZlrJJbgj?=
 =?us-ascii?Q?FCCCFO/rq1H2Ez3bFslC8pTzfuAW9culsDELuUXrp6miLt3B0Mx1b6U+RDTI?=
 =?us-ascii?Q?4FS+Y3AHTy/GxXlR26+Kg0YBSzK9alfLkl39A8+HslABBx2PiOvIlNI/SKXw?=
 =?us-ascii?Q?IE7A8/ctJZF9MuIXm3iPddtYMxAcVrXkYfzvywvgTEdVfzsy+24IG0WzlRT6?=
 =?us-ascii?Q?HopLRIOLJp7e2xsmq0OZRXoKyTGJ1YfZL5pBKcMLH9gdAUq7kzopYzZqNC9e?=
 =?us-ascii?Q?TxNbSnlFZSl84xx9HbQzzFOrQ2ejSoM/QuGXcJP6/2ulnqIQaTxReLfPIZug?=
 =?us-ascii?Q?Od6GUN/g5O7MKP6PTyS7vBmdDJ7Om8ErZmlSmr+ijSULwos4mHTGvgaIgyrv?=
 =?us-ascii?Q?NnXw3ed0QWdfNAmni8ZHTv6GgEaTtpKsM44ndxXI+G9aALPNFbSOqkcg5eyH?=
 =?us-ascii?Q?xx7cyBrFRg2vkZdR7HujWThfs2Koc8q2t+f8gBY6o+qCaT8kd48EiycfwlNa?=
 =?us-ascii?Q?hQ3sj8iLEiUw64QpBjIuwTCe6h+0LX5ZWgPkC3lC8uRzqca3xTTxEnd6G8Z6?=
 =?us-ascii?Q?QwoRelp0BLPBSgXhVt/EVggkA6B9k4dQ922MouwUgICKSOOZEdv/NZnVmvDk?=
 =?us-ascii?Q?oxp1aCOf3m45yRphyGbEkSpL6ti0vibZsXBUY4FfsXnu5lxW2B1HmNRHN44w?=
 =?us-ascii?Q?9k9d9hycuQsztQZD7O/Ro6kUAWzi54tdxDO2?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(36860700013)(376014)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 00:29:49.3968
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99f68723-41c0-45ab-4358-08dd47d7b28e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7964

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

The final patch is new to v6 and changes the Endpoint and RCH DSP handling
to use CXL handling instead of PCIe handling. This was not initially
planned to be included in this patchset but found it would be more complex
to support both CXL errors (for CXL ports) and PCIe errors (for Endpoints
and RCH DSPs). This final patch completes the support for all CXL devices
to use the CXL handling path.

It is also worth noting a patch removed from previous patchset verions.
The previous patchset included a patch changing aer_get_device_error_info()
to read USP AER info. This patch has been removed from this patchset.
As a result, in the case of a USP UCE fatal error the AER is not logged but
CXL handlers do attempt to read and log the RAS.

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
 [Terry] Rebased to latest cxl/next
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
  cxl/pci: Add log message for unmapped registers in existing RAS
    handlers
  cxl/pci: Change find_cxl_port() to non-static
  cxl/pci: Add error handler for CXL PCIe Port RAS errors
  cxl/pci: Add trace logging for CXL PCIe Port RAS errors
  cxl/pci: Update CXL Port RAS logging to also display PCIe SBDF
  cxl/pci: Add support to assign and clear pci_driver::cxl_err_handlers
  PCI/AER: Enable internal errors for CXL Upstream and Downstream Switch
    Ports
  cxl/pci: Handle CXL Endpoint and RCH protocol errors separately from
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


