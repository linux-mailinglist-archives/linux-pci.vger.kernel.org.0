Return-Path: <linux-pci+bounces-41376-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E526C6332B
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 10:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3E8C5367280
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 09:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B38526E719;
	Mon, 17 Nov 2025 09:31:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022106.outbound.protection.outlook.com [40.107.75.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F8D313264;
	Mon, 17 Nov 2025 09:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763371906; cv=fail; b=jFoWwHijctwK2wTr4rdzWJL0wtzYBZ7BezNMBy2SWVV5X+hcLskfgYi/t8uJm815vh0Gvf2VdOuFLfRoFFDMv8c+3tm28lGinfC07QbFV1CO8Ko2LwLq783s3w3BoIlaIm36o2D9egB9/FdRPy3ZHGyoKoXp0755FWfmUEHCDKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763371906; c=relaxed/simple;
	bh=8MefcZ3ESbjq7ILVt/kwS967+JyMk7iu60cToG+OnOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCGfSmPUWEfs1ugz7FOt5ZXEA/0cJvC4+t7gpWZhEuM9CS7s9pjfLRRgvVcC/RdUPqlkSffvhuAPuMPOt+PxnP5AZn7eFhcJEiPVdZJ01YYmjkkEgohPo4hdOK7VLAAei/6DaaaVyJASnPK7MeJaPvxw8pIEMmU7C2ImhLgxFOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o0SFc2JmQH14fQBOOQgPuKZu5rYIyyJco6iXM9GSvEQobT3X5/WmsqXj6Godl8u9zknr46pJ9unu64VveGnanaiw3REEyAqeEvHgehGI8pNxrAgur5lo8Qbj3YOlYJIls49pug5eoteNfor35gFcQpaZi+7+esMf4NwJnatQLTvkxfQcbhOVB1m5HtM46n9etugQAzHwtjlQ2JU26nDXG/19gy33MMaEQ9OhRIKnwTSyycee5oITtIizT+eDEV4psmzlpKnjN3o9YIEqv7JThW2Qh0DKqGPdtQyl15Ngla551q9FYGdpjBcQeB50NthLlpJFqyRf6vx8cXpLxar6Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWG6Bw6pNxLMN/G8PjvlKCO93yoSBiVIFEy5pZTJE+E=;
 b=Lcl85H33brBwoReWU7k5pBl2710ekQhISf1Gf4v22shEBvcSYPMZuy0uFDcNPRGJ9NHl6lr5rXbBsFnm7k+OqedYAxGIDXhCeXJ64CrL4aBVav5ynt0tbEVzWaNNahAsxRmnadTkAg7AyilbWj7lv7ONz1z0wadJU+hqxwrLHISeVVCmFG8AcRl+eKe7AMWemYqvkarRPzD6rX2wwEh0GXp97GW1ZY/MDkXrDRsIhJ+9Fc5w0sZVk1EsJtCkAy3nlXHq6olwsXaBSYCc+dg1TghhK69GgdZSzJEzSS2XbL4Fqwvj9C9EHx7SFOB82gNQovrJzr0FjFi7bV7Y5aKTRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR01CA0114.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::18) by KL1PR06MB6818.apcprd06.prod.outlook.com
 (2603:1096:820:10d::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 09:31:40 +0000
Received: from SG1PEPF000082E2.apcprd02.prod.outlook.com
 (2603:1096:4:40:cafe::e5) by SG2PR01CA0114.outlook.office365.com
 (2603:1096:4:40::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.21 via Frontend Transport; Mon,
 17 Nov 2025 09:31:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E2.mail.protection.outlook.com (10.167.240.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 09:31:39 +0000
Received: from nchen-desktop (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 3080F41C0143;
	Mon, 17 Nov 2025 17:31:39 +0800 (CST)
Date: Mon, 17 Nov 2025 17:31:38 +0800
From: Peter Chen <peter.chen@cixtech.com>
To: hans.zhang@cixtech.com
Cc: <bhelgaas@google.com>, <helgaas@kernel.org>, <lpieralisi@kernel.org>,
	<kw@linux.com>, <mani@kernel.org>, <robh@kernel.org>,
	<kwilczynski@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <mpillai@cadence.com>,
	<fugang.duan@cixtech.com>, <guoyin.chen@cixtech.com>,
	<cix-kernel-upstream@cixtech.com>, <linux-pci@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 10/10] arm64: dts: cix: Enable PCIe on the Orion O6
 board
Message-ID: <aRrrej15SxLzRTa0@nchen-desktop>
References: <20251108140305.1120117-1-hans.zhang@cixtech.com>
 <20251108140305.1120117-11-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251108140305.1120117-11-hans.zhang@cixtech.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E2:EE_|KL1PR06MB6818:EE_
X-MS-Office365-Filtering-Correlation-Id: 60359ad9-1eb9-4a98-8fbc-08de25bc1cc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y44B9k8uL0JPDraLctWCAoJcjD6jKboS/PokBGvn9Zdm+54coP+S+OxoiCvH?=
 =?us-ascii?Q?qMI3OXaGSvUcP/OQ6Kx4I/qvSt8Ocqi680jIi7SLC8BCJxSHU9B/2dkXHqBl?=
 =?us-ascii?Q?CQzlfdmLs3zJQyZBFTK3VxKAJCPlTC3AFBoLLkCx6ueFDrQV7/S0oe9o9z/g?=
 =?us-ascii?Q?6181KnYCvFxNUvRHpJX2valuwzm5kscgSLCvcQg8lsqemyDHDL1cWo8tTD4s?=
 =?us-ascii?Q?QK8RKvpzgCGnJALZxrlGWClCvNF7+935g7C75zp2d4sYfwxuK9NDw/hUk4/o?=
 =?us-ascii?Q?+edWqXcRc5K3efcctYgm2XOZQO4UTxQNSs3ltn/YxjwWjUpZVaH+uc2pOdz2?=
 =?us-ascii?Q?JYKEeBkIh43lLTz3fCpsZ5l8EtlLTKAkw7auWadQs0/pRhvmiczg+M2/7Isr?=
 =?us-ascii?Q?MrxmZ9ZAQJMF423csXyr7UplNh2gvQ5FO/pji0UteraIqlp8YnbbTLxKo2To?=
 =?us-ascii?Q?jqZjIXJhLrfuOhsTfds0bqAmSaH4BUch5DHpHmYK5dM0BQSUeRN0RNVvuL6N?=
 =?us-ascii?Q?biuGp1dinf73AcQKuie9ir/wM1CoiiHHZjs6IcQhL6j0JWJT082QqOGN6kCq?=
 =?us-ascii?Q?tP4rRcpm+Jw92V/0VMOQ6re5toZfeZiBq1FM5XLxTYJPSoI5Sum4OFkBRBny?=
 =?us-ascii?Q?D3xoVZpeLNXmgv9aTjb9vLLSO/CxWLNldiKrfeL86WYLhxnUi6silp8MqDH5?=
 =?us-ascii?Q?gBOIYs+N8RUOKTldDRgS8pwznJZqu/hZScVIgLPQHwrlkIz59Gts+ipGDOxf?=
 =?us-ascii?Q?C7CDH5I0u/pTSbT/eD9Eg2zBro0untbkGe8fOMnFhl5JZHSn0Nr8uv6av9mP?=
 =?us-ascii?Q?OsgLUWVNz/9tKRFZUHAfgjD7oks4Wl8ax8Zvg5/6Vgig1xyf/If4TnJ6E0g8?=
 =?us-ascii?Q?wqMfIkyh3zhnLOSHiNo3q0uiBgzAuV0d2QQaG/hf3wO8fFbWS//xjQ3nhWpH?=
 =?us-ascii?Q?k3XsCPxB9EQUuGZzEnVdX/aEWXfn3WX9Y06V9kucP83TutdzOWqAsnYftwNd?=
 =?us-ascii?Q?r3gGwZsCegVG8sf5gxpigRpqt3UVFC8Npr2nPbqK3HuZnByPCZG9gRS4JXvt?=
 =?us-ascii?Q?sZmFkX2WgU4jEr1fCcleUIePrjjHp5fiC8S1dK2gxmbkPumFxhNqf0L5dIBK?=
 =?us-ascii?Q?sRz4iwt3zZfOK6VF0zc7CfV73mv7QLMuenIaYZESioIpIhugyiPHW2yd33jR?=
 =?us-ascii?Q?v2sVCuY+59KI4oufZnnOzsaZYRXyBJtbU9mRKgMSxVDaVk8tnBFBEGF8eUiX?=
 =?us-ascii?Q?zN3ciPmmHZnkFow0jGnITx1NaCLcePsdA8Zr8Ba8gXPr3CibFQuwPCSztphU?=
 =?us-ascii?Q?sT6jOPterNd2/96MUF8/fzzg3+il2IUOzKbFZ7Hg2vOWxUUy7oH/pBAK1Eb1?=
 =?us-ascii?Q?u29flo1tNLRm9LjkhWelfZ5trV4MSI5gb8/iQfYOl8GdnJrRnN5O6vHitOQZ?=
 =?us-ascii?Q?2c4JbFtXvmCRmmcHZdos/PxZsMpNltn+DmQSCNL+LmI+GEh+HNeJjm4S8Po5?=
 =?us-ascii?Q?G80WXFDoIi1gW3plBysrBmuGTN6X2QzT7LZE7UOnkZUsKgZmjW9ING9MKlQ7?=
 =?us-ascii?Q?FgnJvvZbl465iL/LtOI=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 09:31:39.8023
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60359ad9-1eb9-4a98-8fbc-08de25bc1cc9
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E2.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6818

On 25-11-08 22:03:05, hans.zhang@cixtech.com wrote:
> From: Hans Zhang <hans.zhang@cixtech.com>
> 
> Add PCIe RC support on Orion O6 board.
> 
> The Orion O6 board includes multiple PCIe root complexes. The current
> device tree configuration enables detection and basic operation of PCIe
> endpoints on this platform.
> 
> GPIO and pinctrl subsystems for this platform are not yet ready for
> upstream inclusion. Consequently, attributes such as reset-gpios and
> pinctrl configurations are temporarily omitted from the PCIe node
> definitions.
> 
> Endpoint detection and functionality are confirmed to be operational with
> this basic configuration. The missing GPIO and pinctrl support will be
> added incrementally in future patches as the dependent subsystems become
> available upstream.
> 
> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>

Applied, Thanks.

Peter
> ---
> Dear Krzysztof and Mani,
> 
> Due to the fact that the GPIO, PINCTRL and other modules of our platform are
> not yet ready for upstream. Attributes that PCIe depends on, such as reset-gpios
> and pinctrl*, have not been added for the time being. It will be added gradually
> in the future.
> 
> The following are Arnd's previous comments. We can go to upsteam separately.
> https://lore.kernel.org/all/422deb4d-db29-48c1-b0c9-7915951df500@app.fastmail.com/
> 
> 
> The following are the situations of five PCIe controller enumeration devices.
> 
> root@cix-localhost:~# uname -a
> Linux cix-localhost 6.18.0-rc4-00010-g0f5b0f23abef #237 SMP PREEMPT Sat Nov  8 21:47:44 CST 2025 aarch64 GNU/Linux
> root@cix-localhost:~#
> root@cix-localhost:~# lspci
> 0000:c0:00.0 PCI bridge: Device 1f6c:0001
> 0000:c1:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. Device 8126 (rev 01)
> 0001:90:00.0 PCI bridge: Device 1f6c:0001
> 0001:91:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller S4LV008[Pascal]
> 0002:60:00.0 PCI bridge: Device 1f6c:0001
> 0002:61:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8852BE PCIe 802.11ax Wireless Network Controller
> 0003:00:00.0 PCI bridge: Device 1f6c:0001
> 0003:01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. Device 8126 (rev 01)
> 0004:30:00.0 PCI bridge: Device 1f6c:0001
> 0004:31:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. Device 8126 (rev 01)
> ---
>  arch/arm64/boot/dts/cix/sky1-orion-o6.dts | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/cix/sky1-orion-o6.dts b/arch/arm64/boot/dts/cix/sky1-orion-o6.dts
> index d74964d53c3b..be3ec4f5d11e 100644
> --- a/arch/arm64/boot/dts/cix/sky1-orion-o6.dts
> +++ b/arch/arm64/boot/dts/cix/sky1-orion-o6.dts
> @@ -34,6 +34,26 @@ linux,cma {
>  
>  };
>  
> +&pcie_x8_rc {
> +	status = "okay";
> +};
> +
> +&pcie_x4_rc {
> +	status = "okay";
> +};
> +
> +&pcie_x2_rc {
> +	status = "okay";
> +};
> +
> +&pcie_x1_0_rc {
> +	status = "okay";
> +};
> +
> +&pcie_x1_1_rc {
> +	status = "okay";
> +};
> +
>  &uart2 {
>  	status = "okay";
>  };
> -- 
> 2.49.0
> 

-- 

Best regards,
Peter

