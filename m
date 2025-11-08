Return-Path: <linux-pci+bounces-40631-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77023C42DB4
	for <lists+linux-pci@lfdr.de>; Sat, 08 Nov 2025 15:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDFA018858D6
	for <lists+linux-pci@lfdr.de>; Sat,  8 Nov 2025 14:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E124226863;
	Sat,  8 Nov 2025 14:03:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023086.outbound.protection.outlook.com [52.101.127.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779DF212568;
	Sat,  8 Nov 2025 14:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762610597; cv=fail; b=EkAMKI/r1Q5P14vxZCYMhY6N7WCyWxvD9OL4qr4OVZxNQ2SbjOHDoWF+yjJHuxUJytBZneLLpH/6SFnjaaQlLZ/Ba5jm/GpKoE3cZj8H/bWsPnxIUMm21K5ytFRvsQw/N2p/c7j9wltSFPOVC7Hy4VYUxCZkxT+FkSPF7XMJd1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762610597; c=relaxed/simple;
	bh=xSRoZQb2UNYT+aOEzubP77z2bAgIJyDldNsTSU/nhN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=knFoNWY3LOu/feR7O8tSv8B25hqSZeZM6UNDKjDp8/gAIkzdTk2vG2DJ/3taunnmqRGQ1x+PCbv25kGYl9jsGao9tJAVsk7nyPRN0qZEe8ToCBlnpsAUK41F5GmrleURQe64PaLCgRbL+YoDQZr33mig6BJz+sRVTHX2F3D8K8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dkeujA4ukNj8at67aVpwOPTm6IxFbdvNkqsC0GrXan7U48fcoLGMZEpx6ZV430+4kwYuWce78XXZ8oTFZ8txVaM4pZA7m3VZ64oN6im7dcqZtjFfBPgi+dLyPgXk1g0FPcKy2R9g5Y7GSb3A8mNI/q1QGFEl/rKg+Vl5F9zAZO6PUiAE1Fbo0d+ko9Tk6I3ycxSDEZCoHuq098IGmfHvGCEZWZExU4/S1+Z9g0G6NN+WzbHYdxsRVODy6IzGugsNS3fi+5HPYcUbvJd+nhIg86o3JTjchyy5T1VFu2VS4RfuoGR5sf1wpYJWFPsD6kYrtsxfR35iiLqkxbkLSXypPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfKn7gVBO7GcjBMV8RC+LeGUQKD4zN506MIzDLFeQNk=;
 b=HNBf04tgsfn5UGdH8USR/InETYQEB1eb9NX4V/jlxykblBJLbrOgy/v0W+tdISP2UB5+9pgcAppGupyuOOhx/iwOidO9C9pSf/96gplzmWa5EG2p1lxU370mmcLYQskActI2Q24z4pVgkVMQVy9zEwnSg/eoaX3qNT0QKL0DHwzOTDGfzfeHrSMuuoEM1xzlUxeYyMKo/9CZ6J2azbZBesQsLu3fA9If9Bk2PmZXd/S4nrLoT2vbTk6fQjfJJvjv+G5spS+Tp2/NVTCrNwLOcW93cnK8DalRpkax3mdyE8uWcAEgnuIA1+7Qd8h+VnzzQUrPd+ztk+UbO7g5I+dt3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR01CA0121.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::25) by TY2PPF7E205D1F6.apcprd06.prod.outlook.com
 (2603:1096:408::799) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Sat, 8 Nov
 2025 14:03:11 +0000
Received: from SG2PEPF000B66C9.apcprd03.prod.outlook.com
 (2603:1096:4:40:cafe::47) by SG2PR01CA0121.outlook.office365.com
 (2603:1096:4:40::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.15 via Frontend Transport; Sat,
 8 Nov 2025 14:02:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66C9.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Sat, 8 Nov 2025 14:03:09 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 720224143A8E;
	Sat,  8 Nov 2025 22:03:06 +0800 (CST)
From: hans.zhang@cixtech.com
To: bhelgaas@google.com,
	helgaas@kernel.org,
	lpieralisi@kernel.org,
	kw@linux.com,
	mani@kernel.org,
	robh@kernel.org,
	kwilczynski@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: mpillai@cadence.com,
	fugang.duan@cixtech.com,
	guoyin.chen@cixtech.com,
	peter.chen@cixtech.com,
	cix-kernel-upstream@cixtech.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <hans.zhang@cixtech.com>
Subject: [PATCH v11 10/10] arm64: dts: cix: Enable PCIe on the Orion O6 board
Date: Sat,  8 Nov 2025 22:03:05 +0800
Message-ID: <20251108140305.1120117-11-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251108140305.1120117-1-hans.zhang@cixtech.com>
References: <20251108140305.1120117-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66C9:EE_|TY2PPF7E205D1F6:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 458b4679-3264-4cd1-da85-08de1ecf8c67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xTfG4LTJQbtbtDap6JyOQJsaYGEy9KE2H/iXAr2c/T69YGo5UTtBE2XJeqly?=
 =?us-ascii?Q?0lw4fwJPjdZZ/tes8TauVwrBbbbnqffpsrL4JFwqnuMIa7LVQBbOlDbLHpPV?=
 =?us-ascii?Q?C7ujpxoiwGiQMRkDwBzUbKV3eYHgoMCHMTcM+6kN+Pn2VWjDaAAWGkIeTWgK?=
 =?us-ascii?Q?GO80vjzc7ARNS5uroFtN+uS+/8axlU5D7w473VQxX3jhz25ZmxztbzZX03OX?=
 =?us-ascii?Q?jPPFoibA8GDVCI2EZh4IcnWmrQFJRZmJaqYavVK9SPUXV64KTcNDKSSsnrsO?=
 =?us-ascii?Q?8KW/FJ1PUHPJ7U0W7XXwVNwN78jP+ezCpXLs0CJdJBejLveR22p0Nbqxg63l?=
 =?us-ascii?Q?ui4DQmpp4NfLZ8zelusiAgM8fuBspbDGUMk1M+B078BAK1UyiCVxrVhB2baP?=
 =?us-ascii?Q?pj6a0AwGPqkj3I8Vew884IesWyAx9GdNSyvsHKZ/wjEOA9/7Mnu+vVzbA3O+?=
 =?us-ascii?Q?eOH7f9vlphmEbJfq8z1LxvPn8bilZYtai+7COZ/fGU6b9H0e/gJlIoAgOUwx?=
 =?us-ascii?Q?/fnCRMA+rmLqz6yMQTNaSp178H3x6BlZi32U+FZwhHcU4z6vCdyXlKT3UgNU?=
 =?us-ascii?Q?UcQ2YILCE/QNpN9oTztA9Aalu62lzZwXWHovnRfs9V6aurjdu2DsRTDbiCJb?=
 =?us-ascii?Q?G3C4AmxCy9TEHad7LC7F4PR/T/AxfzTlfFNolAoCxE5xWI2xxWMTQ5M9TsnK?=
 =?us-ascii?Q?qV+gMyyknOUwk+Tqww2d6IEki3Ovtmvb2jJlmH+uA7DJWqlkujggWFnlswKL?=
 =?us-ascii?Q?gvXuNxJuNxcZ9QO+ajJ/L8MSN99RuI8Xweg41gepB0HHhFrs8WSCOGKhNv3n?=
 =?us-ascii?Q?03XJ+SoK8Y8jTmEbUGwis0cpQbGLgt1L+HwhrSvXi1AukCQb0pPdnee0mTBO?=
 =?us-ascii?Q?U1sJvkNSmY6vTa1Z9Vhu2IJPlJcHNByjXrXn0dmptX6+0SKpk0KWLZl2SSlq?=
 =?us-ascii?Q?jqu7eTgZ9HODiaEIQApXER9gDd7EK8wt3bhTUoIqEy62whgMagZgh9wjwszO?=
 =?us-ascii?Q?FIiQqEBBm1uXwEyq6VX/SqrnNMIrjPiYcR/ojRpi+PFAjNLOs01Mn31EQaKx?=
 =?us-ascii?Q?1FNOfvm2cDGYcofHxS9e6Y/RcJtFH1KEtdqQcpfqksowe4HR5pEy6UyxNo4x?=
 =?us-ascii?Q?yf4y0ig9EZVdqvYcaCYt5+ip0dV82pmzJHf90Z1Ncu1tbbryuwBdF6m16S0a?=
 =?us-ascii?Q?fhHDs2KtI6tba/1hdDyZWFSA6LRPYh0F2j4rF32lSeMWUKNr4yKkizFNFLR+?=
 =?us-ascii?Q?TRegRsW1fw8KdMVUof8diY5E7eorpkkwDf8cna9ettJjtQXLNc4OHK8PC9dl?=
 =?us-ascii?Q?8lMGYdZ54IShP6AMGFNHtcp4wSB6OJ5ijwNEarVNAx9gZ+/UoSfTP+8rglkM?=
 =?us-ascii?Q?BDc7wTKqbCLpJVE3LrUJoUdBVaaMR40RNbpGotjkdIBJXMBfTWdHjpSmfndq?=
 =?us-ascii?Q?o8W5z3LCPSTRlFq4UZnl2JbVn+SrajI+f8G2MF7PYQvu1gO5U36ws2ac6mmf?=
 =?us-ascii?Q?an50yUuUp07ewgtlVaIHx184a5SpUf1hSt4nWoheDuaMHxj6m0gztG2ssxai?=
 =?us-ascii?Q?jFeF6G9sfSFUthEi20U=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 14:03:09.4182
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 458b4679-3264-4cd1-da85-08de1ecf8c67
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66C9.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPF7E205D1F6

From: Hans Zhang <hans.zhang@cixtech.com>

Add PCIe RC support on Orion O6 board.

The Orion O6 board includes multiple PCIe root complexes. The current
device tree configuration enables detection and basic operation of PCIe
endpoints on this platform.

GPIO and pinctrl subsystems for this platform are not yet ready for
upstream inclusion. Consequently, attributes such as reset-gpios and
pinctrl configurations are temporarily omitted from the PCIe node
definitions.

Endpoint detection and functionality are confirmed to be operational with
this basic configuration. The missing GPIO and pinctrl support will be
added incrementally in future patches as the dependent subsystems become
available upstream.

Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
Dear Krzysztof and Mani,

Due to the fact that the GPIO, PINCTRL and other modules of our platform are
not yet ready for upstream. Attributes that PCIe depends on, such as reset-gpios
and pinctrl*, have not been added for the time being. It will be added gradually
in the future.

The following are Arnd's previous comments. We can go to upsteam separately.
https://lore.kernel.org/all/422deb4d-db29-48c1-b0c9-7915951df500@app.fastmail.com/


The following are the situations of five PCIe controller enumeration devices.

root@cix-localhost:~# uname -a
Linux cix-localhost 6.18.0-rc4-00010-g0f5b0f23abef #237 SMP PREEMPT Sat Nov  8 21:47:44 CST 2025 aarch64 GNU/Linux
root@cix-localhost:~#
root@cix-localhost:~# lspci
0000:c0:00.0 PCI bridge: Device 1f6c:0001
0000:c1:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. Device 8126 (rev 01)
0001:90:00.0 PCI bridge: Device 1f6c:0001
0001:91:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller S4LV008[Pascal]
0002:60:00.0 PCI bridge: Device 1f6c:0001
0002:61:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8852BE PCIe 802.11ax Wireless Network Controller
0003:00:00.0 PCI bridge: Device 1f6c:0001
0003:01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. Device 8126 (rev 01)
0004:30:00.0 PCI bridge: Device 1f6c:0001
0004:31:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. Device 8126 (rev 01)
---
 arch/arm64/boot/dts/cix/sky1-orion-o6.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/cix/sky1-orion-o6.dts b/arch/arm64/boot/dts/cix/sky1-orion-o6.dts
index d74964d53c3b..be3ec4f5d11e 100644
--- a/arch/arm64/boot/dts/cix/sky1-orion-o6.dts
+++ b/arch/arm64/boot/dts/cix/sky1-orion-o6.dts
@@ -34,6 +34,26 @@ linux,cma {
 
 };
 
+&pcie_x8_rc {
+	status = "okay";
+};
+
+&pcie_x4_rc {
+	status = "okay";
+};
+
+&pcie_x2_rc {
+	status = "okay";
+};
+
+&pcie_x1_0_rc {
+	status = "okay";
+};
+
+&pcie_x1_1_rc {
+	status = "okay";
+};
+
 &uart2 {
 	status = "okay";
 };
-- 
2.49.0


