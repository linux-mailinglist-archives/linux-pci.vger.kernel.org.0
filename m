Return-Path: <linux-pci+bounces-28886-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD80ACCBE8
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 19:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6157168C77
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 17:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2184E1A3172;
	Tue,  3 Jun 2025 17:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HatOCwvk"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC951A2547;
	Tue,  3 Jun 2025 17:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748971371; cv=fail; b=fTmgRE6w9KwWlMSQvgyJq/m8qPEkJKYuyWJYN8ILDRTdQ+O80IJIl87BtxsCCB/TNXy232qYsbnzvLDTKHzQhqll2Xmfn49Me6k2e0keV4mUIxM836FkoUNAfYjOrR5VK9ZN9NhOuyTBZaowxoFmPjATZLOVRK8vi26IkOddIpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748971371; c=relaxed/simple;
	bh=k2qgukvVs/Z2DPhGpfF1xZ7P6wdEPr8rEWCg3wKjV9g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VQhpk0rm5jJWnQFHCh2Jp6d/HQNQpCk5ee9cSue0K5ZMsnq5eO9CqO0XLNyuCh+2foltnoDU3ythCPiA17LyE0ZXwT+ATaDslP8a4SnOGnmAAyrX6EEjmzlAjzT1/TAmchRQKu29BGEaV5VX4n04o35aZvb7Q1I5kuX+MRX1edY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HatOCwvk; arc=fail smtp.client-ip=40.107.94.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U9lPOeoyZeSsTXEJo18XljDArvk8i+czK6u67gqFx++YNcTYlhVECl3EENBh3DsnWAepAzVsStDW8UMHXvIV9o1+G77vlmqWibpF3udAW//Bx+7AyiAaGl59cBax5CR0gIPFYkZtNJ3R0znHWUWKtZ5whivoyDwnL/FNMGtJP1S8Bbm5u1wJCe5XUwqmPWTpJE1MkF2xgezUh3sL7K8ivyWK9v/zcuvl+QvVcEXrPqc6wwedyZiAdUpFKbkGvnhsvgLQR5qtXc/OHCyXIXV6PsEr1oTvniLJFlNzO7MA5ZDGLSTnwl7H//GkjGTEYT0xKD71ph+6jG+qDSSbe5y28g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zbJFsolRhLTN/NJJfscX6JX1J7qjmyMJAdQ5B2oCKzU=;
 b=y/wTMlhl09OZU6yzkLuXWwuaeiwRpWwNaZwYiGUBGaABViHf622CgKXoio2Ahhek+KhFH2ouoMaS8ktnmS2iMbaX7oYD81XG6wmIGji6acNlrOIAllgq+p7tTZYz2qzJvQHyYeWbvglmgc7YNTaYMh5rU03nDbqs8tSUgRFHo/u4X+g4hzgXPxZEAFrs0R508R+fYc8FGSI0VyZIWo7QSYYpifZYXwlkMImAMik0Da6npbEz8NedrKJNrsxgup52U2uEHhJP0jLRtcescmfeo58n3kcptxkOMiEV/kv7pBB3ooBDfTvkiBqAxfhoIT4nkluw6dFw/UP0sE1ndWC6SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbJFsolRhLTN/NJJfscX6JX1J7qjmyMJAdQ5B2oCKzU=;
 b=HatOCwvkvUWYIqT4tsMV56vClht2uuoYsm27NW2n/DlAYdrFRVcXZAJ1yHs83BX4PDIpUvYOVUtMDvmxMAf+B7D7n8Prbe0Ol2NfKSAMpYU9t1kZvyJXnEwTop728K1NoORTmhMLAanXA4wTOUA2YUTatbjEox22XwfXw6osgZk=
Received: from MN2PR06CA0029.namprd06.prod.outlook.com (2603:10b6:208:23d::34)
 by CY5PR12MB6551.namprd12.prod.outlook.com (2603:10b6:930:41::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 17:22:46 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:208:23d:cafe::86) by MN2PR06CA0029.outlook.office365.com
 (2603:10b6:208:23d::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Tue,
 3 Jun 2025 17:22:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Tue, 3 Jun 2025 17:22:45 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Jun
 2025 12:22:44 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <PradeepVineshReddy.Kodamati@amd.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <bhelgaas@google.com>,
	<bp@alien8.de>, <ming.li@zohomail.com>, <shiju.jose@huawei.com>,
	<dan.carpenter@linaro.org>, <Smita.KoralahalliChannabasappa@amd.com>,
	<kobayashi.da-06@fujitsu.com>, <terry.bowman@amd.com>, <yanfei.xu@intel.com>,
	<rrichter@amd.com>, <peterz@infradead.org>, <colyli@suse.de>,
	<uaisheng.ye@intel.com>, <fabio.m.de.francesco@linux.intel.com>,
	<ilpo.jarvinen@linux.intel.com>, <yazen.ghannam@amd.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v9 00/16] Enable CXL PCIe port protocol error handling and logging
Date: Tue, 3 Jun 2025 12:22:23 -0500
Message-ID: <20250603172239.159260-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|CY5PR12MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: a6d6d760-b5b8-4984-bb05-08dda2c34184
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Pgpnq6MqgGjsoaDw6JyKcqJ0RBRdMJwZf+keoe9RfJZNiPKcmOKKSsJZ2uAW?=
 =?us-ascii?Q?E+Tit+eUcJUatd594hJBZSJegFjo34ArJZu7lrCZTReF5E1kyS1RSsd52hRW?=
 =?us-ascii?Q?L4aHxIPLDQMJbpHKGFPXCJ4qPqx9QeARxPe0gIynUZiIJfnlXSl6Z4R2TsSj?=
 =?us-ascii?Q?53zs8Wuk/vmJWpGlJs2q2c2fLGyJWarajQOIjQuwAuYyi1U94EEtqQFR1qLe?=
 =?us-ascii?Q?3TvgqH+3Lr9ZPXp34ubuA+SKhZV6h8kEDifG9190btEZSm7VFbYyDuu/5Dzp?=
 =?us-ascii?Q?gxJO7Haus98n9zWOk6BPCQixq/qu+NibjEsSoNVGo8LK0LFhm8lNoMftFL6+?=
 =?us-ascii?Q?XjmrNbXYHX+SXQwcuPu/AzdqFswpnBwfmV+lbwgGpmkVugjxn/lREngAWBU7?=
 =?us-ascii?Q?aUp+d5L0AB1UDfqcP0XUuIJMi7g9twhYiHDekcMEyC07YV/IkA8lZN7RVen/?=
 =?us-ascii?Q?xzGoscKicoH2eQMnWut5FJ3xRZxOU+PGRwR7bbf4QCcWg1/rH+gxdm/WNAiU?=
 =?us-ascii?Q?CYsoAubsA/YID8CDoHnwSBozprpd9xl0ETnp8y9WETFUxK4c6EvIy4kBXnwi?=
 =?us-ascii?Q?wYTG6N4HCBGVuTjtVlsAU6zwMK5KpsFSjA0tROf3qTOd7tgWg2wGaIgCYlC6?=
 =?us-ascii?Q?0TgVg0zwe/CcGmHtDCl1u35n3NDaF7AR44KnZtcXkuPisyBJ+m873l7DlrXR?=
 =?us-ascii?Q?sZdCSNHPsAwEs7Coow6PHBb7aYQ/yvlEsGl/9uR6Y9jYGArXYktAuLhUjsM9?=
 =?us-ascii?Q?s9Mzo4JoyZS5o2Syr6rTfmqIfXaBMBajZP/TeHRePIcUe9TqO5Cuo3CPf+pw?=
 =?us-ascii?Q?JVMckNTJo4jHalFT/ucE637rRTZ1InGozeGX8wGoD9SqsQI1u+/IBnFcgNKN?=
 =?us-ascii?Q?0r2zs00DytNMU8LS9w6o46sGjQ6hwMD+ErH3/Hf5qVi38RoNZn9dTcaqm5hk?=
 =?us-ascii?Q?VKly1VBVArOOha8dBWxD74XL4wW86AbV4QZpnzbS14K7kEVm1MoyZK14AlYQ?=
 =?us-ascii?Q?MLmBnYKEeTVw1ZdWApW+rM4VVoN+Kut0C+QuPOsHRUZR+7+8xbYD6mJNIT6H?=
 =?us-ascii?Q?bvGnXrS0bkdeWutvkXXE9gtn7sbmw5P/3wNIff6ly7EiVtjBF7pE7qKBT5Kl?=
 =?us-ascii?Q?LED6A5xh4PlR5+otWXH0BnRQcJ89bHxnmg0LpRRJOoXeZk9FjUTsQgGmjtuc?=
 =?us-ascii?Q?/KsOvkX8eANiGCremoq7d09A23XSKnlItGQeSA+sXCHl7J2OghI4iKXfGMwy?=
 =?us-ascii?Q?KlRaU20Hen9stcA92qj4NxebAcmQ9Zf5s6LH2xgEAVb3/PWVLejGmDl+1OEh?=
 =?us-ascii?Q?77MqTqhZLCM/7KZLrpqMUECFKYSPEe1473Cr0K4IB6aNqKSLfhRwzuoT1RCD?=
 =?us-ascii?Q?yeG/Cjbwk3H/+v6jZaC39fVxv8Pfro22y4ENm7JjSyHBFjJ3zICOiQo/COjD?=
 =?us-ascii?Q?bvaxmi9f7IGNRB0O/Ah8h7gsOlIXdtT98ncpba0GjJWVTu2cla/2oWdZMxHp?=
 =?us-ascii?Q?1yQijKRVxLIvsGI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 17:22:45.7575
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6d6d760-b5b8-4984-bb05-08dda2c34184
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6551

This patchset enhances the CXL Protocol Error handling for both CXL Ports
and CXL Endpoints (EP). Originally focused on CXL Ports, the scope of this
patchset has now expanded to incorporate EPs as well.

This patchset is a continuation of v8 and can be found here:
https://lore.kernel.org/linux-cxl/20250327014717.2988633-1-terry.bowman@amd.com/

The first 2 patches introduce pci_dev::is_cxl, aer_info::is_cxl, and add
bus string to AER log tracing. aer_info::is_cxl will be used to indicate a
CXL or PCI error and will be used to direct the error handling flow in
later patches.

The next 4 patches move, where possible, the existing CXL handling from
the AER driver to the cxl_port driver. This includes introducing the kfifo
for the AER driver to offload CXL protocol error work to the CXL driver.

The next 5 patches prepare the CXL driver for adding the updated protocol
error handlers. This includes adding CXL Port RAS mapping and updating
interfaces for common support. 

The final 5 patches add the CXL error handlers for CXL EPs and CXL Ports.
CXL EPs keep the PCIe error handler for cases the EP error is interpreted
as a PCIe error. These patches also add logic to unmask CXL Protocol Errors
during port probing, and mask CXL Protocol Errors during port device
cleanup.

== Testing ==

Testing below shows the Upstream Switch Port UCE handling is broken. It
executes the native PCIe portdrv handler instead of the CXL handler. This
is because aer_get_device_error_info() does not populate the AER error
severity and status. This is intended because the USP link to access the
device can be compromised. The check for is_cxl_error() and is_internal_error()
fail as a result and then processes the error as a PCI error. I need
feedback how to handle this case.

I rebased to pci/next with Bjorn's 'Rate limit AER logs' series from here:
https://lore.kernel.org/linux-pci/20250522232339.1525671-1-helgaas@kernel.org/#r
I ran into manual merges for the AER print trace routines but nothing difficult.
I confirmed the error handling series functionality was intact after the rebase.
Note, test results below are without rate limiting series.

The sub-topology for Qemu testing is:
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

== CXL Root Port ==
root@tbowman-cxl:~/aer-inject# ./root-ce-inject.sh
pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0c:00.0
pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0c:00.0
pcieport 0000:0c:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
pcieport 0000:0c:00.0:   device [8086:7075] error status/mask=00004000/0000a000
pcieport 0000:0c:00.0:    [14] CorrIntErr            
aer_event: 0000:0c:00.0 CXL Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
cxl_aer_correctable_error: device=0000:0c:00.0 parent=pci0000:0c serial=0 status='CRC Threshold Hit'

root@tbowman-cxl:~/aer-inject/# ./root-uce-inject.sh
pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0c:00.0
pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0c:00.0
pcieport 0000:0c:00.0: CXL Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
pcieport 0000:0c:00.0:   device [8086:7075] error status/mask=00400000/02000000
pcieport 0000:0c:00.0:    [22] UncorrIntErr          
aer_event: 0000:0c:00.0 CXL Bus Error: severity=Fatal, Uncorrectable Internal Error, TLP Header=Not available
cxl_aer_uncorrectable_error: device=0000:0c:00.0 parent=pci0000:0c serial=0 status='Cache Byte Enable Parity Error' first_error='Cache Byte Enable Par'
Kernel panic - not syncing: CXL cachemem error.
CPU: 10 UID: 0 PID: 168 Comm: kworker/10:1 Tainted: G            E       6.15.0-rc4-00065-ga77879da099a-dirty #424 PREEMPT(voluntary) 
Tainted: [E]=UNSIGNED_MODULE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
Workqueue: events cxl_prot_err_work_fn [cxl_core]
Call Trace:
 <TASK>
 dump_stack_lvl+0x27/0x90
 dump_stack+0x10/0x20
 panic+0x33d/0x380
 ? preempt_count_add+0x4b/0xc0
 cxl_do_recovery+0xc7/0xd0 [cxl_core]
 cxl_prot_err_work_fn+0x11a/0x1a0 [cxl_core]
 process_scheduled_works+0xa6/0x420
 worker_thread+0x126/0x270
 kthread+0x118/0x230
 ? __pfx_worker_thread+0x10/0x10
 ? _raw_spin_unlock_irq+0x1f/0x40
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x3c/0x60
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>
Kernel Offset: 0x18600000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
---[ end Kernel panic - not syncing: CXL cachemem error. ]---

== CXL Upstream Switch Port ==
root@tbowman-cxl:~/aer-inject# ./us-ce-inject.sh
[   26.309121] pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0d:00.0
[   26.310096] pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0d:00.0
[   26.310970] pcieport 0000:0d:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
[   26.311861] pcieport 0000:0d:00.0:   device [19e5:a128] error status/mask=00004000/0000a000
[   26.312610] pcieport 0000:0d:00.0:    [14] CorrIntErr            
[   26.313312] aer_event: 0000:0d:00.0 CXL Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
[   26.314520] cxl_aer_correctable_error: device=0000:0d:00.0 parent=0000:0c:00.0 serial=0 status='CRC Threshold Hit'

root@tbowman-cxl:~/aer-inject# ./us-uce-inject.sh                          
pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0d:00.0
pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0d:00.0
pcieport 0000:0d:00.0: AER: CXL Bus Error: severity=Uncorrectable (Fatal), type=Inaccessible, (Unregistered Agent ID)
aer_event: 0000:0d:00.0 CXL Bus Error: severity=Fatal, , TLP Header=Not available
pcieport 0000:0c:00.0: unlocked secondary bus reset via: pciehp_reset_slot+0xac/0x160
------------[ cut here ]------------
WARNING: CPU: 10 PID: 146 at drivers/pci/access.c:340 pci_cfg_access_unlock+0x54/0x60
Modules linked in: cfg80211(E) binfmt_misc(E) ppdev(E) cxl_pmem(E) intel_rapl_msr(E) parport_pc(E) cxl_mem(E) intel_rapl_common(E) cxl_acpi(E) cxl_pci)
CPU: 10 UID: 0 PID: 146 Comm: irq/24-aerdrv Tainted: G            E       6.15.0-rc4-00065-ga77879da099a-dirty #425 PREEMPT(voluntary) 
Tainted: [E]=UNSIGNED_MODULE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
RIP: 0010:pci_cfg_access_unlock+0x54/0x60
Code: 00 fe 48 c7 c7 08 5b 00 b1 e8 88 04 74 00 31 c9 31 d2 be 03 00 00 00 48 c7 c7 b0 8d 84 b0 e8 93 64 8e ff 5b 5d e9 2c 1c 74 00 <0f> 0b eb cd 0f 10
RSP: 0018:ffffa2ccc06efc30 EFLAGS: 00010046
RAX: 0000000000000246 RBX: ffff973dc1c4c000 RCX: 0000000000000000
RDX: 0000000000000001 RSI: 0000000000000246 RDI: ffffffffaf669c39
RBP: ffffa2ccc06efc38 R08: 0000000000000000 R09: ffffffffb084a200
R10: 0000000000000000 R11: 0000000000000001 R12: ffff973dc3550c80
R13: 0000000000000000 R14: 0000000000000000 R15: ffff973dc1c40828
FS:  0000000000000000(0000) GS:ffff97417eeae000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005642c5514140 CR3: 00000001192a6000 CR4: 00000000003506f0
Call Trace:
 <TASK>
 pci_slot_unlock+0x43/0x70
 pci_slot_reset+0x105/0x160
 pci_bus_error_reset+0xb0/0xe0
 aer_root_reset+0x8e/0x210
 ? srso_return_thunk+0x5/0x5f
 pcie_do_recovery+0x17f/0x2b0
 ? __pfx_aer_root_reset+0x10/0x10
 aer_isr_one_error.isra.0+0x587/0x5a0
 ? srso_return_thunk+0x5/0x5f
 ? _raw_spin_unlock+0x19/0x40
 ? srso_return_thunk+0x5/0x5f
 ? finish_task_switch+0x95/0x290
 ? srso_return_thunk+0x5/0x5f
 ? __schedule+0x5d0/0x11a0
 aer_isr+0x4c/0x80
 irq_thread_fn+0x28/0x70
 irq_thread+0x183/0x270
 ? __pfx_irq_thread_fn+0x10/0x10
 ? __pfx_irq_thread_dtor+0x10/0x10
 kthread+0x118/0x230
 ? __pfx_irq_thread+0x10/0x10
 ? _raw_spin_unlock_irq+0x1f/0x40
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x3c/0x60
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>
---[ end trace 0000000000000000 ]---
pcieport 0000:0c:00.0: AER: Root Port link has been reset (0)
cxl_pci 0000:0f:00.0: mem1: restart CXL.mem after slot reset
cxl_pci 0000:10:00.0: mem0: restart CXL.mem after slot reset
cxl_pci 0000:11:00.0: mem2: restart CXL.mem after slot reset
cxl_pci 0000:12:00.0: mem3: restart CXL.mem after slot reset
cxl_pci 0000:0f:00.0: mem1: error resume successful
cxl_pci 0000:10:00.0: mem0: error resume successful
cxl_pci 0000:11:00.0: mem2: error resume successful
cxl_pci 0000:12:00.0: mem3: error resume successful
pcieport 0000:0c:00.0: AER: device recovery successful

== CXL Downstream Swicth Port == 
root@tbowman-cxl:~/aer-inject# ./ds-ce-inject.sh
pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0e:00.0
pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0e:00.0
pcieport 0000:0e:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
pcieport 0000:0e:00.0:   device [19e5:a129] error status/mask=00004000/0000a000
pcieport 0000:0e:00.0:    [14] CorrIntErr            
aer_event: 0000:0e:00.0 CXL Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
cxl_aer_correctable_error: device=0000:0e:00.0 parent=0000:0d:00.0 serial=0 status='CRC Threshold Hit'

root@tbowman-cxl:~/aer-inject# ./ds-uce-inject.sh
pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0e:00.0
pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0e:00.0
pcieport 0000:0e:00.0: CXL Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
pcieport 0000:0e:00.0:   device [19e5:a129] error status/mask=00400000/02000000
pcieport 0000:0e:00.0:    [22] UncorrIntErr          
aer_event: 0000:0e:00.0 CXL Bus Error: severity=Fatal, Uncorrectable Internal Error, TLP Header=Not available
cxl_aer_uncorrectable_error: device=0000:0e:00.0 parent=0000:0d:00.0 serial=0 status='Cache Byte Enable Parity Error' first_error='Cache Byte Enable P'
cxl_aer_uncorrectable_error: device=mem1 parent=0000:0f:00.0 serial=0 status='Cache Byte Enable Parity Error' first_error='Cache Byte Enable Parity Er'
Kernel panic - not syncing: CXL cachemem error.
CPU: 10 UID: 0 PID: 158 Comm: kworker/10:1 Tainted: G            E       6.15.0-rc4-00065-ga77879da099a-dirty #427 PREEMPT(voluntary) 
Tainted: [E]=UNSIGNED_MODULE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
Workqueue: events cxl_prot_err_work_fn [cxl_core]
Call Trace:
 <TASK>
 dump_stack_lvl+0x27/0x90
 dump_stack+0x10/0x20
 panic+0x33d/0x380
 ? preempt_count_add+0x4b/0xc0
 cxl_do_recovery+0xc7/0xd0 [cxl_core]
 cxl_prot_err_work_fn+0x11a/0x1a0 [cxl_core]
 process_scheduled_works+0xa6/0x420
 worker_thread+0x126/0x270
 kthread+0x118/0x230
 ? __pfx_worker_thread+0x10/0x10
 ? _raw_spin_unlock_irq+0x1f/0x40
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x3c/0x60
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>
Kernel Offset: 0x2800000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
---[ end Kernel panic - not syncing: CXL cachemem error. ]---

== CXL Endpoint ==
root@tbowman-cxl:~/aer-inject# ./ep-ce-inject.sh
pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0f:00.0
pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0f:00.0
cxl_pci 0000:0f:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
cxl_pci 0000:0f:00.0:   device [8086:0d93] error status/mask=00004000/00000000
cxl_pci 0000:0f:00.0:    [14] CorrIntErr            
aer_event: 0000:0f:00.0 CXL Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
cxl_aer_correctable_error: device=mem2 parent=0000:0f:00.0 serial=0 status='CRC Threshold Hit'

root@tbowman-cxl:~/aer-inject# ./ep-uce-inject.sh
pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0f:00.0
pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0f:00.0
cxl_pci 0000:0f:00.0: AER: CXL Bus Error: severity=Uncorrectable (Fatal), type=Inaccessible, (Unregistered Agent ID)
aer_event: 0000:0f:00.0 CXL Bus Error: severity=Fatal, , TLP Header=Not available
cxl_aer_uncorrectable_error: device=mem2 parent=0000:0f:00.0 serial=0 status='Cache Byte Enable Parity Error' first_error='Cache Byte Enable Parity Er'
-3i7n3j0e]c tK# ernel panic - not syncing: CXL cachemem error.
CPU: 10 UID: 0 PID: 146 Comm: irq/24-aerdrv Tainted: G            E       6.15.0-rc4-00065-ga77879da099a-dirty #427 PREEMPT(voluntary) 
Tainted: [E]=UNSIGNED_MODULE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x27/0x90
 dump_stack+0x10/0x20
 panic+0x33d/0x380
 pci_error_detected+0x30/0x30 [cxl_core]
 report_error_detected+0x113/0x180
 ? __pm_runtime_resume+0x60/0x90
 ? __pfx_report_frozen_detected+0x10/0x10
 report_frozen_detected+0x16/0x20
 __pci_walk_bus+0x50/0x70
 ? __pfx_report_frozen_detected+0x10/0x10
 pci_walk_bus+0x32/0x50
 pci_walk_bridge+0x1d/0x40
 pcie_do_recovery+0x173/0x2b0
 ? __pfx_aer_root_reset+0x10/0x10
 aer_isr_one_error.isra.0+0x587/0x5a0
 ? srso_return_thunk+0x5/0x5f
 ? _raw_spin_unlock+0x19/0x40
 ? srso_return_thunk+0x5/0x5f
 ? finish_task_switch+0x95/0x290
 ? srso_return_thunk+0x5/0x5f
 ? __schedule+0x5d0/0x11a0
 aer_isr+0x4c/0x80
 irq_thread_fn+0x28/0x70
 irq_thread+0x183/0x270
 ? __pfx_irq_thread_fn+0x10/0x10
 ? __pfx_irq_thread_dtor+0x10/0x10
 kthread+0x118/0x230
 ? __pfx_irq_thread+0x10/0x10
 ? _raw_spin_unlock_irq+0x1f/0x40
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x3c/0x60
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>
Kernel Offset: 0x11a00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
---[ end Kernel panic - not syncing: CXL cachemem error. ]---

Changes
=======
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

Terry Bowman (16):
  PCI/CXL: Add pcie_is_cxl()
  PCI/AER: Report CXL or PCIe bus error type in trace logging
  CXL/AER: Introduce kfifo for forwarding CXL errors
  PCI/AER: Dequeue forwarded CXL error
  CXL/PCI: Introduce CXL uncorrectable protocol error recovery
  cxl/pci: Move RAS initialization to cxl_port driver
  cxl/pci: Map CXL Endpoint Port and CXL Switch Port RAS registers
  cxl/pci: Update RAS handler interfaces to also support CXL Ports
  cxl/pci: Log message if RAS registers are unmapped
  cxl/pci: Unify CXL trace logging for CXL Endpoints and CXL Ports
  cxl/pci: Update __cxl_handle_cor_ras() to return early if no RAS
    errors
  cxl/pci: Introduce CXL Endpoint protocol error handlers
  cxl/pci: Introduce CXL Port protocol error handlers
  cxl/pci: Remove unnecessary CXL Endpoint handling helper functions
  CXL/PCI: Enable CXL protocol errors during CXL Port probe
  CXL/PCI: Disable CXL protocol error interrupts during CXL Port cleanup

 drivers/cxl/core/core.h       |   2 +
 drivers/cxl/core/pci.c        | 238 +++++++++++++---------------
 drivers/cxl/core/port.c       |  10 +-
 drivers/cxl/core/ras.c        | 290 +++++++++++++++++++++++++++++++++-
 drivers/cxl/core/regs.c       |   2 +
 drivers/cxl/core/trace.h      |  84 +++-------
 drivers/cxl/cxl.h             |  25 +++
 drivers/cxl/cxlpci.h          |   7 +-
 drivers/cxl/mem.c             |   3 +-
 drivers/cxl/pci.c             |   8 +-
 drivers/cxl/port.c            | 156 ++++++++++++++++++
 drivers/pci/pci.c             |   1 +
 drivers/pci/pci.h             |  14 +-
 drivers/pci/pcie/aer.c        | 172 ++++++++++++++------
 drivers/pci/pcie/rcec.c       |   1 +
 drivers/pci/probe.c           |  10 ++
 include/linux/aer.h           |  40 +++++
 include/linux/pci.h           |  19 +++
 include/ras/ras_event.h       |   9 +-
 include/uapi/linux/pci_regs.h |   8 +-
 20 files changed, 831 insertions(+), 268 deletions(-)


base-commit: 6eed708a5693709ff0d4dd8512b6934be30d4283
-- 
2.34.1


