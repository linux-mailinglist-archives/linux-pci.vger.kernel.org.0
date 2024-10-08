Return-Path: <linux-pci+bounces-14005-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B26169959E4
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 00:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75D60286589
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2024 22:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219211E0488;
	Tue,  8 Oct 2024 22:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LM+ZDg1A"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBFC2C859;
	Tue,  8 Oct 2024 22:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728425832; cv=fail; b=JuFiP+5DRE8uwA8D0pnDYA0FPpdtz6UDI2HpjnIdtlOyTM6Hhpor1xHAqWVFco19bcwHMAUSzDxIvfFeCaDfdZe9d+o64IWTxEWDSrpmLmhqvLdzcAo4i5hUQzwA13WIQLobB4Frl0S8OhPrnnBuUWVn6xPPSZ8qUdYRhuZ2vp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728425832; c=relaxed/simple;
	bh=riaH1Yr+nm6klnhj+xroZ3EyggBC4ZntJByd/BeMajo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NXhwTxtuMGlzcTYivUPtmLumC/n8ajsdw3+thZrwNuOFbTwj4H84qg4Fia2UaIBrskf3Vsdme/iSiOSmEHtLwYWNWVV5nDt1ECTVjDVS/dYue+flLpLDn8eD6hrmjwsvrSSFceS4uAUTg88yTA4uXT+1nF3DNm4rD9ha9enlJck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LM+ZDg1A; arc=fail smtp.client-ip=40.107.237.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nVy4sl89yGo1XMEwzt0z5wu3pF84WyW25sfqETXKZH/cSowx+ta93FxXLdrRyNfDw3k3btA9H6b6HIGEQBupVSWd6FXM6PW2N5F5K38i4Smf4jbRKDkh9Y/MReoiT2MqT+ZWnZY+s/AtQB8emPJh5uvFQlCqiLeh5drTtVm354nPFiYWjggvcNz4OvtlssuQ24cWa8+y96i4P5G+4FqKbUNepFRmaOHT5zvPPye7x58Bl1DC+Ol6CDz8Tgc+5XEwDHXIiqfLz4Wc99PUGvPhaBR0q0ut1PDP8Beb8IwL3EEbRNK0eMzsvYaRsW++2ZUfwT5Gbl8ueFg0XmWY8qkw8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oxtFjGCAJFjFkboF9hIlXGZMAMO50hX0GdXXxTaztKE=;
 b=NWzTQRYHtTDmVd/0p9UbTHGCw2dVHDVc43K2asuaOANF+cYqV5eIlG5ZAoRXHYE8UNYCpmIFuQ/f4Go5h5R4kGnf3T2XLcmkLoqqEELlrC45nCD8j8jO8q2y6nf4/yPpgyma3cNcfkipHO2TgeNZX1qIHC9B7xT98UPwavTK8nDeDUzVQHNF/NmI0fCLKhGVQJYeXvFEsq4xA7shh125aJzMxyLxhWTR+Coyw3ZdfqM21z8AKvuAP8/kBBScOqEH1BjPqff5pfEkc11EGrEhCHpd3BwdjM3iyQR0SmnoMG6DsUF7P58psAwk7YA4sZMrOvckjHfa2/qPpireflRquQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxtFjGCAJFjFkboF9hIlXGZMAMO50hX0GdXXxTaztKE=;
 b=LM+ZDg1A5VW89aJYCFMZc+HulYSIWG/y58EpO9SjWD6OVOkv5lQNIvyguv3yuGcgaQTqOFMyCKIBOQHyGxCyiD13ZWFP5EeMoBkkioY9HmwZ2mgg3y5Q/tylH2xft+bvvllP7ogdnXNNoc3b95JTOlRgJrc2H4VC0U8CcLQjguE=
Received: from MN2PR15CA0052.namprd15.prod.outlook.com (2603:10b6:208:237::21)
 by SJ0PR12MB8616.namprd12.prod.outlook.com (2603:10b6:a03:485::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.24; Tue, 8 Oct
 2024 22:17:04 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:208:237:cafe::7d) by MN2PR15CA0052.outlook.office365.com
 (2603:10b6:208:237::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23 via Frontend
 Transport; Tue, 8 Oct 2024 22:17:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 22:17:04 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Oct
 2024 17:17:03 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <smita.koralahallichannabasappa@amd.com>,
	<terry.bowman@amd.com>
Subject: [PATCH 0/15] Enable CXL PCIe port protocol error handling and logging
Date: Tue, 8 Oct 2024 17:16:42 -0500
Message-ID: <20241008221657.1130181-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|SJ0PR12MB8616:EE_
X-MS-Office365-Filtering-Correlation-Id: d53620de-1392-49ed-b3a2-08dce7e6f070
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P+PiHEFvI07/o1InX9wvpdX0xpyDKtYO+s2f85RtBjVdiwIczrxx2+CrYCwP?=
 =?us-ascii?Q?EIdNhsc7UIpRpYeC6a0IwY5w1bqzp9MGIy0ixkBaVrURvjgCCcMwXboBu+cA?=
 =?us-ascii?Q?CoryIoc/eKzo4EurtyjtJOT/SqYb83EkVHlgpGmZtwev+zt4a0SVnnaRr1f2?=
 =?us-ascii?Q?3+tvXxqqBCgKKAdU2IPGB9mqaXmUACZHyhsefUGcV4o8jxV8efh1IgEwlVOB?=
 =?us-ascii?Q?n8DP1l9rIy+QzyWYsBLM/prBpxtVBQllhrRoGyJonqHZPRayXVts4yhAQAB8?=
 =?us-ascii?Q?r0L5nvQp3+O8DRJDlGcjrBH/WEAuLKETXRlw9OsDZVD7pQ+vffBtqSnF71WO?=
 =?us-ascii?Q?/Q+ZbklTx41aLnbybepBsXnFrzdKOK2MSFAr/5Cxpmwx87xW6AKqw5fAMVls?=
 =?us-ascii?Q?6HrC6OXJ1WTsKiTpqEdEAOg5SoExy0cjPNTLYUueaG3uOU6SjumK6lCXjinU?=
 =?us-ascii?Q?4fXm86FAflMH6VDSd3+LnugsDldBNNQS5VGz2RBX93jbqa1VOiqYAQWrnMoG?=
 =?us-ascii?Q?2FaaNJXJF1qF7lJHQtQGRmaXhkJIfJbZVUCJboSTd8WONgkH130Vffi/8tMI?=
 =?us-ascii?Q?V906buqAxMtQl8SFbkVoQA09xbiB2/nxt4KNDS6Rp/CvRMGVi7TDIZw2cENw?=
 =?us-ascii?Q?jAdvCl9eSuBnrp20jUy+6gA6WocSIF6B3Xq89g9my+nLHli5gRGccKsV8aQq?=
 =?us-ascii?Q?QW1O2yGRsGPW/39Fgg4upxFAm6k911hC1l8Xo8O//cJE+DAyXsiW5PghvkUL?=
 =?us-ascii?Q?yEZa/2dJZZtZUw9iO63vLnhAqLwneK6fyiSXlZQwwVMq/ZBHiwGRP7pyGQbh?=
 =?us-ascii?Q?Yl3Gx38JCIwSSPEJwsHVdf4P0Vag4CbRJq2pmZK0n/kKCnuO0IPZn1/owWx2?=
 =?us-ascii?Q?x1gdYMYDaKxT5uLNc/cRZPGRIcSxLUYTTUpStCBJ8NXawlTNNML53iKaPu9K?=
 =?us-ascii?Q?rYJqAyvQpgkzFfM044gaYC1+bQVX/AyO/mNxxFfeLxZGsOnwstY1EZ5DGCWU?=
 =?us-ascii?Q?eCYMjL3nPw7oq2WfTo+l6EWRFnBemkfKWjERencs15M8/cTLYnWCunyl0i9s?=
 =?us-ascii?Q?Et4at3IO73DkWNXqPpHQKrQJcFdL1OajxRBZAKGXw767cGKFl20sHeBifHQ8?=
 =?us-ascii?Q?eEHXLjDV52mDTlNi3NbiMxjEvrjLmh3TPIRNXPaXkE63a3iYU/nI4mQhxeld?=
 =?us-ascii?Q?AlXl/YvKqkVdY4453NXJqTnsFJWSdcKqFu5Q0N+JZXOZP0JQVNVObL9LFKC+?=
 =?us-ascii?Q?G4rFr9145HbX2uceJeBAgeNVdQSXgAmeniV8yPGlwE49td8VSS0xsPV07Me5?=
 =?us-ascii?Q?uRJteobavMwwXMCiNNDX/QCSkeOz7ie3EwYV8FVbAVpzeEJnQRBT4sK4xgFH?=
 =?us-ascii?Q?9OQph2mcN275jJ41xCvGxGCCa5UQtNTnDYk35iDwJolPvnTmSA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 22:17:04.1554
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d53620de-1392-49ed-b3a2-08dce7e6f070
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8616

This is a continuation of the CXL port error handling RFC from earlier.[1]
The RFC resulted in the decision to add CXL PCIe port error handling to
the existing RCH downstream port handling. This patchset adds the CXL PCIe
port handling and logging.

The first 7 patches update the existing AER service driver to support CXL
PCIe port protocol error handling and reporting. This includes AER service
driver changes for adding correctable and uncorrectable error support, CXL
specific recovery handling, and addition of CXL driver callback handlers.

The following 8 patches address CXL driver support for CXL PCIe port
protocol errors. This includes the following changes to the CXL drivers:
mapping CXL port and downstream port RAS registers, interface updates for
common RCH and VH, adding port specific error handlers, and protocol error
logging.

[1] - https://lore.kernel.org/linux-cxl/20240617200411.1426554
-1-terry.bowman@amd.com/

Testing:

Below are test results for this patchset. This is using Qemu with a root
port (0c:00.0), upstream switch port (0d:00.0),and downstream switch port
(0e:00.0).

This was tested using aer-inject updated to support CE and UCE internal
error injection. CXL RAS was set using a test patch (not upstreamed).

    Root port UCE:
    root@tbowman-cxl:~/aer-inject# ./root-uce-inject.sh
    [   27.318920] pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0c:00.0
    [   27.320164] pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0c:00.0
    [   27.321518] pcieport 0000:0c:00.0: PCIe Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
    [   27.322483] pcieport 0000:0c:00.0:   device [8086:7075] error status/mask=00400000/02000000
    [   27.323243] pcieport 0000:0c:00.0:    [22] UncorrIntErr
    [   27.325584] aer_event: 0000:0c:00.0 PCIe Bus Error: severity=Fatal, Uncorrectable Internal Error, TLP Header=Not available
    [   27.325584]
    [   27.327171] cxl_port_aer_uncorrectable_error: device=0000:0c:00.0 host=pci0000:0c status: 'Memory Address Parity Error'
    first_error: 'Memory Address Parity Error'
    [   27.333277] Kernel panic - not syncing: CXL cachemem error. Invoking panic
    [   27.333872] CPU: 12 UID: 0 PID: 122 Comm: irq/24-aerdrv Not tainted 6.11.0-rc1-port-error-g1fb9097c3728 #3857
    [   27.334761] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
    [   27.335716] Call Trace:
    [   27.335985]  <TASK>
    [   27.336226]  panic+0x2ed/0x320
    [   27.336547]  ? __pfx_cxl_report_normal_detected+0x10/0x10
    [   27.337037]  ? __pfx_aer_root_reset+0x10/0x10
    [   27.337453]  cxl_do_recovery+0x304/0x310
    [   27.337833]  aer_isr+0x3fd/0x700
    [   27.338154]  ? __pfx_irq_thread_fn+0x10/0x10
    [   27.338572]  irq_thread_fn+0x1f/0x60
    [   27.338923]  irq_thread+0x102/0x1b0
    [   27.339267]  ? __pfx_irq_thread_dtor+0x10/0x10
    [   27.339683]  ? __pfx_irq_thread+0x10/0x10
    [   27.340059]  kthread+0xcd/0x100
    [   27.340387]  ? __pfx_kthread+0x10/0x10
    [   27.340748]  ret_from_fork+0x2f/0x50
    [   27.341100]  ? __pfx_kthread+0x10/0x10
    [   27.341466]  ret_from_fork_asm+0x1a/0x30
    [   27.341842]  </TASK>
    [   27.342281] Kernel Offset: 0x1ba00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
    [   27.343221] ---[ end Kernel panic - not syncing: CXL cachemem error. Invoking panic ]---

    Root port CE:
    root@tbowman-cxl:~/aer-inject# ./root-ce-inject.sh
    [   19.444339] pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0c:00.0
    [   19.445530] pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0c:00.0
    [   19.446750] pcieport 0000:0c:00.0: PCIe Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
    [   19.447742] pcieport 0000:0c:00.0:   device [8086:7075] error status/mask=00004000/0000a000
    [   19.448549] pcieport 0000:0c:00.0:    [14] CorrIntErr
    [   19.449223] aer_event: 0000:0c:00.0 PCIe Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
    [   19.449223]
    [   19.451415] cxl_port_aer_correctable_error: device=0000:0c:00.0 host=pci0000:0c status='Received Error From Physical Layer'

    Upstream switch port UCE:
    root@tbowman-cxl:~/aer-inject# ./us-uce-inject.sh
    [   45.236853] pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0d:00.0
    [   45.238101] pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0d:00.0
    [   45.239416] pcieport 0000:0d:00.0: PCIe Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
    [   45.240412] pcieport 0000:0d:00.0:   device [19e5:a128] error status/mask=00400000/02000000
    [   45.241159] pcieport 0000:0d:00.0:    [22] UncorrIntErr
    [   45.242448] aer_event: 0000:0d:00.0 PCIe Bus Error: severity=Fatal, Uncorrectable Internal Error, TLP Header=Not available
    [   45.242448]
    [   45.244008] cxl_port_aer_uncorrectable_error: device=0000:0d:00.0 host=0000:0c:00.0 status: 'Memory Address Parity Error'
    first_error: 'Memory Address Parity Error'
    [   45.249129] Kernel panic - not syncing: CXL cachemem error. Invoking panic
    [   45.249800] CPU: 12 UID: 0 PID: 122 Comm: irq/24-aerdrv Not tainted 6.11.0-rc1-port-error-g1fb9097c3728 #3855
    [   45.250795] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
    [   45.251907] Call Trace:
    [   45.253284]  <TASK>
    [   45.253564]  panic+0x2ed/0x320
    [   45.253909]  ? __pfx_cxl_report_normal_detected+0x10/0x10
    [   45.255455]  ? __pfx_aer_root_reset+0x10/0x10
    [   45.255915]  cxl_do_recovery+0x304/0x310
    [   45.257219]  aer_isr+0x3fd/0x700
    [   45.257572]  ? __pfx_irq_thread_fn+0x10/0x10
    [   45.258006]  irq_thread_fn+0x1f/0x60
    [   45.258383]  irq_thread+0x102/0x1b0
    [   45.258748]  ? __pfx_irq_thread_dtor+0x10/0x10
    [   45.259196]  ? __pfx_irq_thread+0x10/0x10
    [   45.259605]  kthread+0xcd/0x100
    [   45.259956]  ? __pfx_kthread+0x10/0x10
    [   45.260386]  ret_from_fork+0x2f/0x50
    [   45.260879]  ? __pfx_kthread+0x10/0x10
    [   45.261418]  ret_from_fork_asm+0x1a/0x30
    [   45.261936]  </TASK>
    [   45.262451] Kernel Offset: 0xc600000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
    [   45.263467] ---[ end Kernel panic - not syncing: CXL cachemem error. Invoking panic ]---

    Upstream switch port CE:
    root@tbowman-cxl:~/aer-inject# ./us-ce-inject.sh 
    [   37.504029] pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0d:00.0
    [   37.506076] pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0d:00.0
    [   37.507599] pcieport 0000:0d:00.0: PCIe Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
    [   37.508759] pcieport 0000:0d:00.0:   device [19e5:a128] error status/mask=00004000/0000a000
    [   37.509574] pcieport 0000:0d:00.0:    [14] CorrIntErr            
    [   37.510180] aer_event: 0000:0d:00.0 PCIe Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
    [   37.510180] 
    [   37.512057] cxl_port_aer_correctable_error: device=0000:0d:00.0 host=0000:0c:00.0 status='Received Error From Physical Layer'

    Downstream switch port UCE:
    root@tbowman-cxl:~/aer-inject# ./ds-uce-inject.sh
    [   29.421532] pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0e:00.0
    [   29.422812] pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0e:00.0
    [   29.424551] pcieport 0000:0e:00.0: PCIe Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
    [   29.425670] pcieport 0000:0e:00.0:   device [19e5:a129] error status/mask=00400000/02000000
    [   29.426487] pcieport 0000:0e:00.0:    [22] UncorrIntErr
    [   29.427111] aer_event: 0000:0e:00.0 PCIe Bus Error: severity=Fatal, Uncorrectable Internal Error, TLP Header=Not available
    [   29.427111]
    [   29.428688] cxl_port_aer_uncorrectable_error: device=0000:0e:00.0 host=0000:0d:00.0 status: 'Memory Address Parity Error'
    first_error: 'Memory Address Parity Error'
    [   29.430173] Kernel panic - not syncing: CXL cachemem error. Invoking panic
    [   29.430862] CPU: 12 UID: 0 PID: 122 Comm: irq/24-aerdrv Not tainted 6.11.0-rc1-port-error-g844fd2319372 #3851
    [   29.431874] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
    [   29.433031] Call Trace:
    [   29.433354]  <TASK>
    [   29.433631]  panic+0x2ed/0x320
    [   29.434010]  ? __pfx_cxl_report_normal_detected+0x10/0x10
    [   29.434653]  ? __pfx_aer_root_reset+0x10/0x10
    [   29.435179]  cxl_do_recovery+0x304/0x310
    [   29.435626]  aer_isr+0x3fd/0x700
    [   29.436027]  ? __pfx_irq_thread_fn+0x10/0x10
    [   29.436507]  irq_thread_fn+0x1f/0x60
    [   29.436898]  irq_thread+0x102/0x1b0
    [   29.437293]  ? __pfx_irq_thread_dtor+0x10/0x10
    [   29.437758]  ? __pfx_irq_thread+0x10/0x10
    [   29.438189]  kthread+0xcd/0x100
    [   29.438551]  ? __pfx_kthread+0x10/0x10
    [   29.438959]  ret_from_fork+0x2f/0x50
    [   29.439362]  ? __pfx_kthread+0x10/0x10
    [   29.439771]  ret_from_fork_asm+0x1a/0x30
    [   29.440221]  </TASK>
    [   29.440738] Kernel Offset: 0x10a00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
    [   29.441812] ---[ end Kernel panic - not syncing: CXL cachemem error. Invoking panic ]---

    Downstream switch port CE:
    root@tbowman-cxl:~/aer-inject# ./ds-ce-inject.sh
    [  177.114442] pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0e:00.0
    [  177.115602] pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0e:00.0
    [  177.116973] pcieport 0000:0e:00.0: PCIe Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
    [  177.117985] pcieport 0000:0e:00.0:   device [19e5:a129] error status/mask=00004000/0000a000
    [  177.118809] pcieport 0000:0e:00.0:    [14] CorrIntErr
    [  177.119521] aer_event: 0000:0e:00.0 PCIe Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
    [  177.119521]
    [  177.122037] cxl_port_aer_correctable_error: device=0000:0e:00.0 host=0000:0d:00.0 status='Received Error From Physical Layer'

Changes RFC->v1:
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
 [TODO][Bjorn] Dont use Kconfig to enable/disable a CXL external interface

Terry Bowman (15):
  cxl/aer/pci: Add CXL PCIe port error handler callbacks in AER service
    driver
  cxl/aer/pci: Update is_internal_error() to be callable w/o
    CONFIG_PCIEAER_CXL
  cxl/aer/pci: Refactor AER driver's existing interfaces to support CXL
    PCIe ports
  cxl/aer/pci: Add CXL PCIe port correctable error support in AER
    service driver
  cxl/aer/pci: Update AER driver to read UCE fatal status for all CXL
    PCIe port devices
  cxl/aer/pci: Introduce PCI_ERS_RESULT_PANIC to pci_ers_result type
  cxl/aer/pci: Add CXL PCIe port uncorrectable error recovery in AER
    service driver
  cxl/pci: Change find_cxl_ports() to be non-static
  cxl/pci: Map CXL PCIe downstream port RAS registers
  cxl/pci: Map CXL PCIe upstream port RAS registers
  cxl/pci: Update RAS handler interfaces to support CXL PCIe ports
  cxl/pci: Add error handler for CXL PCIe port RAS errors
  cxl/pci: Add trace logging for CXL PCIe port RAS errors
  cxl/aer/pci: Export pci_aer_unmask_internal_errors()
  cxl/pci: Enable internal CE/UCE interrupts for CXL PCIe port devices

 drivers/cxl/core/core.h  |   3 +
 drivers/cxl/core/pci.c   | 172 +++++++++++++++++++++++++++++++--------
 drivers/cxl/core/port.c  |   4 +-
 drivers/cxl/core/trace.h |  47 +++++++++++
 drivers/cxl/cxl.h        |  14 +++-
 drivers/cxl/mem.c        |  30 ++++++-
 drivers/cxl/pci.c        |   8 ++
 drivers/pci/pci.h        |   5 ++
 drivers/pci/pcie/aer.c   | 123 ++++++++++++++++++++--------
 drivers/pci/pcie/err.c   | 150 ++++++++++++++++++++++++++++++++++
 include/linux/aer.h      |  16 ++++
 include/linux/pci.h      |   3 +
 12 files changed, 503 insertions(+), 72 deletions(-)


base-commit: f7982d85e136ba7e26b31a725c1841373f81f84a
-- 
2.34.1


