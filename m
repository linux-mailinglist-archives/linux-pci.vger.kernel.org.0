Return-Path: <linux-pci+bounces-38705-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C18D5BEF496
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 06:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B5983B4EE0
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 04:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B962C15A9;
	Mon, 20 Oct 2025 04:29:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023125.outbound.protection.outlook.com [40.107.44.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67DD2BF007;
	Mon, 20 Oct 2025 04:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760934548; cv=fail; b=Yp/hQAnWC7Y2nany73U2YAN7xG1ZnZzssYd7omLdxyvEpabpeOSZdobVjwvpB943qpGe0axi7NiDDRW3gs9vS2wj2FGFYAbDZ15dkQLOKqUMeA2YNb0SkKBh/J28ywpDyAhASuHTqd3jV1jSmDtgcda3vUmLZbcxDFIy7GKEOoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760934548; c=relaxed/simple;
	bh=nzT+mclm+wlY7L7VB/oq0nfRoUcG1zrJJUa0nSSp51M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rXmthnEhkQKHnFeQvimRUvbYPgGmYQ/QURqEdUm8JykhFpalTAX4qx0MvobdqezhcBNT1FW98emTAlo5AK6Hzm2MbVHnmTnLyc3ANFRZqxFLv6X9KcX1erSPSRJODKhqkTqsoYjlERexoc+2wjQw9vQnrc+oHjzY8Do7eEajhVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dU7XllypAb0buGhE8aaQPkXrQgZvewlThO1JNUrGn6biuMwHQxoVrpVSu1544fcGLVlqsBgGuWNbF8qoP7tXvnmbc50FE/har6Dy+lf2aWcASIfMwe64NMxpRSeF8sfkDG7PWkQO4TDnHZ8nv6w9oqEMm1HKMUf7dJJslEmjaeOoOJ+7hfO41TWauNxfS1JM0pacf+McFlYm6EpuLztCpab7B6L5oGrsIg2c5cRkuMWHqWEll5QbjDCOu00YAbOXC7bRGiXgVdY13iEGRyyaNCxy2A0Zrkuh/ax9Ia1JdI4mjoInK+wpYPNhJHMRdNFT+YZ/vElFUF4EKl56aWl1aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7J9ilAuocA72ql8tN7QBUl1D0QjxiLg2OsQxaGo7mzA=;
 b=gwHa8+2fmz3eG3zORkspNymqkg0EH6z6Up8HngJXLRhFdh35eELBBFV5fpCN1jBdWPmJOi/yjBepeAq7eUp3tXE/hNzplt1DhgsnS1FJBWQsTsu+kcybmgQf1WOFKp8nISJrvORawLGeI+QoQiKFgpFvmiyhNCHoRSHsbNfeSGhF1RsErGjyQIrCLhnArdaUUayfUveAqvdlmsPzwCv9x515ugMWm8BobC2xGRoMd+Y+Szg68z85y1tDwrwp7iPoesawu20Y3lYeigQDZXLYhBRSdIU0C5J+ssTy6uVYo4hl+5Hsix16jTAXBOKydETRLCI3PvOOtNF8QB87+mLIUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR01CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:300:58::26) by PS1PPF1CDE4C809.apcprd06.prod.outlook.com
 (2603:1096:308::246) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 04:29:02 +0000
Received: from TY2PEPF0000AB87.apcprd03.prod.outlook.com
 (2603:1096:300:58:cafe::2d) by PS2PR01CA0038.outlook.office365.com
 (2603:1096:300:58::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Mon,
 20 Oct 2025 04:29:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB87.mail.protection.outlook.com (10.167.253.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 04:29:01 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 1F55B4126FFD;
	Mon, 20 Oct 2025 12:28:58 +0800 (CST)
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
Subject: [PATCH v10 10/10] arm64: dts: cix: Enable PCIe on the Orion O6 board
Date: Mon, 20 Oct 2025 12:28:57 +0800
Message-ID: <20251020042857.706786-11-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251020042857.706786-1-hans.zhang@cixtech.com>
References: <20251020042857.706786-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB87:EE_|PS1PPF1CDE4C809:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2af10545-1a2d-4e64-07e3-08de0f91324c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EFRV1dolJtapvhLxrNIQLMlheLRj5x24gkZnSTMOvE/G76NJbZkxx7Yu+Wf2?=
 =?us-ascii?Q?K4iVHDc3qszUFqk3KJa4mAxZDC/3qHC9qLteSX+JjKLb7EUM7i3J6dH1TW8c?=
 =?us-ascii?Q?yMHL39ccn5bLvJYZHb9aBGWVFoZ4pRQ1Sgrccrvj5geqmqbPTAK8RzALWC65?=
 =?us-ascii?Q?pnvhCMc1hjvCSOiv63EmPkiJA+XEZImt2tEPL0dtES7XwXrheiGDsR8JxWHN?=
 =?us-ascii?Q?Hsovz+X0NqYkVT8OKhN9v5Gbi90Dfc1jjG1xz1CpKPV6dU+ADNukz9/mxMw5?=
 =?us-ascii?Q?BBVhFwphSX0JKwN+M/f6+fy0ni6pINZrQx9Qo7TJuMMwc5ZbNVzvdRn1kauy?=
 =?us-ascii?Q?JgvjZv/HSuW6kj7d8YCXBX6Ws/08hPSIq4ymln4FvY1F+S4bAjPOiZsLZSyL?=
 =?us-ascii?Q?BgM0z4Beux0rwLAn4yw1OQumGIJLkVOqQM6WHqyrg448/S0gSWkbUc6bYYL8?=
 =?us-ascii?Q?Ap1WEdPRcLcXMnHKSEMepIAz/9iuSL/A02Giuf2XZuYjUFhGEICcMJEYlv4L?=
 =?us-ascii?Q?t4lGjJl0DOz8LDpUPVbZ80SQG1IEhGb3xQ0LaKqs7LGIL9Ux2JorrRQAyVHP?=
 =?us-ascii?Q?4SKzsw12X2pQEk/IrA6PlvcRkj3aFw6O355MXdq2LpkOYmupHZt6cBta3+fV?=
 =?us-ascii?Q?9v+yLTd2U8GPIAO4jiQouRB0t30F14RwGh0s9TDtqAPAMALlX6hJP141d0G4?=
 =?us-ascii?Q?vLmyUbEpS+8OmAjw22R43pRbunMCQXMFLGuerBtL4PJ7TRL94jfrWwBOOmu2?=
 =?us-ascii?Q?JPxHoyu70NolfaUHGmp3FFH4oZFeWNSqMqzUh4RdhhkZ3XotJbqnfS1EpySA?=
 =?us-ascii?Q?mRp1FA81u5p9/KrHQZHO6E7AZLr3Kx2ZlducDQ6MwtLBIJSJlyx/r5hfltZu?=
 =?us-ascii?Q?qigIsePSOZYQSEb9XrL12uCBfJtQxJdIiPZqcp++8LNjqQdFq0C9KFluW39z?=
 =?us-ascii?Q?m+KoNnoq+ekBdKYT/6Hw8mxS9ceIyntNEmnUEZ533uSOSg2yqwyj+E7rX+Ju?=
 =?us-ascii?Q?/ySG45XdZ7g38FFCEF94xQH1rGVT0hox7BpWfruC0sJYZTtEUMWXPjfCZq7N?=
 =?us-ascii?Q?rXNTdgSsMXjqKXkBanWGUXUCROhESjh7tAbtOfka3froOweWSip5sHCTa3h/?=
 =?us-ascii?Q?Nzni/CC10yqUbeez5WvB/k87T46EMQXjdOUE2ANjbJggCpWAGu0YbuWLeG7c?=
 =?us-ascii?Q?AGvcuCS8A6ZwC+xVa+wFej9MtbOSCE0gS21JupYE1t2cNbe6HmHOK8ANOYlP?=
 =?us-ascii?Q?vweOd2+ZDWJ7ms7OnWCQJxets5jKAUNgZFBxt6z2SGn59twHnw7PUwCcjP/e?=
 =?us-ascii?Q?5RFkPncVI1L7OVKn0YKGxnZzMMVP60fM48uyqAs5eJsZf1vkvB+3IiW/44OB?=
 =?us-ascii?Q?uNgVZDKbCBQxXtc217Ldr11/QL/OT3g5fgF7o8Yhch6CZ9ylmmBRN5ObNvzH?=
 =?us-ascii?Q?Q/Hh5E3pL79kRpQiiyQpvdPgBIeXkpaGJx5TpbFQ/XL4Qb5OA/AwtBJWcoco?=
 =?us-ascii?Q?TT002f2QMLuhEZiO7b5qd3DgGxLDxmnHpil4MNUlA5ik754kpAfHLeiT3DVk?=
 =?us-ascii?Q?N4rk5TR0xqgLP5ASQAg=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 04:29:01.9312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2af10545-1a2d-4e64-07e3-08de0f91324c
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB87.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPF1CDE4C809

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
Linux cix-localhost 6.18.0-rc2-00010-g1a768713c76c #227 SMP PREEMPT Mon Oct 20 11:35:49 CST 2025 aarch64 GNU/Linux
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


