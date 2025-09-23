Return-Path: <linux-pci+bounces-36803-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A546BB97613
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 21:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F9253B589A
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 19:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4910C3009C1;
	Tue, 23 Sep 2025 19:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QN/Zh6ya"
X-Original-To: linux-pci@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011012.outbound.protection.outlook.com [40.107.130.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFB6C2FB;
	Tue, 23 Sep 2025 19:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758656365; cv=fail; b=ePC+7e3VX5Fc4cemfKgyjAtnQfMawcrqzCHX+uOOojvPY7tfOR0VkWTy8363DW5A2zJyJ5rzHHblP7FMJrsjT/OPgP3iGQ7Hedq0olkSKm+dNOtj7oeUR/sNM5QB2p5l6i3vs1eScYWCvYCexbrln3ZPimJnkiIZiSbfWfrldg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758656365; c=relaxed/simple;
	bh=697IKxa2ZGwE+ytQnRM0hAJeuMUzGBRYRhJHwhidyvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LFxoxrdJa5jQXY3olE338CpKHxe7tNklqv19soRz/k81QyfKgu9TFPixkOaJf84DWZnsGF7cQOVg7av1i9r6mf15R/0eiGod9fg99U1P1nibViaSG924xDRNCog89kE+FZxPJ3Hy1Xw+me1KPw+5pKSrTk8sMaBRuUMw0B8241I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QN/Zh6ya; arc=fail smtp.client-ip=40.107.130.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MO7D+eAlnMkftjb2QjyVsIT1L0wStf0MSvgFwL8PBXi7MgLCaHb6lY2S+0HUNWHbdn1d1XRCRG8X8y+ihb43j6VF1JQmKn0aJkzTuItxz5ZtbKC6lWmOMctdxAdtlVoFznFAD+0EFxHQhwkVSAqKYkBNkvKBSXebJ/ZF8LiFOVc8otgs0Jtl0GRmVyxOKiizcu4CzaJkLPixPcBMexoCI7jhddmNd0N+9E5JLJvjuQRnIcP/JtTE5iYmz2ajlc8pn68yk0W3uMqJUliwNGH6CykgH4Qt/9/E7RVD2KHMUN5sMaj5uo1ptnxhQBG+6pU00YNb/SwwYrzKR8kgQ4OXIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRsWamg0AsIdfKymV9tjSQ/F4rRIhFCHFfJI8NNGNW4=;
 b=bN7/mrE/QfJpcjT8i7R6mVqBeEoSxig8c9PWAahyX1pOqet4mIXRlwKXyKJ0HySuCmLeuIqVe5fzP5VgyM+bUpcLofhs3Wp6mY1aWHZl3DEV0xRui76Br2rIKLeGRBD4GREeSg+sivN+Aa/txqt1uwFgH07DVFJ66yi/2mXDx6Fh9TLwVdyRalyzXVeY7BI8Afls9L8BE3YQYWvnT/LPhQUI45kAGl48ZVW5lQ9p6O/ptHTPHSGUP/10Gu3NeXqDRAixvGbV//DFcDN6RLjWTkB5g+VX8zwtODEa0FSsB+0ht1exLxgg/xOnHI9CVzD7DLwmmqs/t2qNyc9RAPgX+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRsWamg0AsIdfKymV9tjSQ/F4rRIhFCHFfJI8NNGNW4=;
 b=QN/Zh6yacNt2TCCJvEFYSZ5tnLI3mG5SQTisc5uIUc9Firyd/l2fMHKvCUQ9NzyK9zf2oZfLpRG3PKNxTxFwy1b4MPinZMyI2IY8BHmYz7A1Lsy8X/BZ32qFsoJTZpCDElZm6YcFlhZThyKYmrgLlo84X4lTgOP/NKs3os0sHleoRTnUP2ul36uhjQZlbJhXrIEvli/L0HFF1agbFcuqeoYRJm9obJFx0iLmKLHpEc2awV193JtMX+h4VzVZiHDduFVhb7oHl4iyEkcFFki+S5WGDXjWHLVdM/actJwQTx/M9Wsvj4vZIiy8dNH5wBt575lAao8IKHP/3Oz6X/LTUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by VE1PR04MB7421.eurprd04.prod.outlook.com (2603:10a6:800:1b3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 19:39:15 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 19:39:15 +0000
Date: Tue, 23 Sep 2025 15:39:04 -0400
From: Frank Li <Frank.li@nxp.com>
To: zhangsenchuan@eswincomputing.com
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	p.zabel@pengutronix.de, johan+linaro@kernel.org,
	quic_schintav@quicinc.com, shradha.t@samsung.com, cassel@kernel.org,
	thippeswamy.havalige@amd.com, mayank.rana@oss.qualcomm.com,
	inochiama@gmail.com, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com,
	Yanghui Ou <ouyanghui@eswincomputing.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: EIC7700: Add Eswin PCIe host
 controller
Message-ID: <aNL3WFTUUPEYQget@lizhi-Precision-Tower-5810>
References: <20250923120946.1218-1-zhangsenchuan@eswincomputing.com>
 <20250923121200.1235-1-zhangsenchuan@eswincomputing.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923121200.1235-1-zhangsenchuan@eswincomputing.com>
X-ClientProxiedBy: BYAPR21CA0027.namprd21.prod.outlook.com
 (2603:10b6:a03:114::37) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|VE1PR04MB7421:EE_
X-MS-Office365-Filtering-Correlation-Id: 62e9ee0e-e993-4cbc-7342-08ddfad8e0c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|52116014|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kZcQ6u555yHt7owaawarGSdes/A7tqAJhzesy4yuq/uJA6g2tVNFMw9Dc0fv?=
 =?us-ascii?Q?crHYre6ZzLKKRCG2lkxNpjRoLiNqZRMn1lcueEWuT2mPwyXOnunbJi72gYRq?=
 =?us-ascii?Q?T2IrWbAD1BD48SeDzOEs2DVGqF4rjbzI92weHf5MkdJrKLPO2o4TouKygFKs?=
 =?us-ascii?Q?kzmz4GrDEykXv0/Z9P54sokgCb4y5nu07snrw0bUhQ4A5byjR3BTjhZqEaS6?=
 =?us-ascii?Q?tVv8SQcr78y+54HBOOtms/VMrVylsjLRKrMtVN5hlHuc/+6y53yiYWn9v8KE?=
 =?us-ascii?Q?peLdwme7YsbNO/XoM1Rw0+4/p6LaUehvuWKXfIHmt+n3zqx3a9UnIFet9RvM?=
 =?us-ascii?Q?+kBBpZWT+Qe8TzY1pS3R5xQYUBTmuFr3BNbA9dIvOEp6vVEFxE/HCCG5Jxiy?=
 =?us-ascii?Q?anxB+VL4TPoMUusMvI4wY3w+jIuh+gR1TP/qoSunvfrAMm3WyCOzSEn62ZFL?=
 =?us-ascii?Q?O0x/PanB3xluXNF/EB6MIMX2YOID2GsomcK1MH3Dwb77f07OARXwtGSQG4T3?=
 =?us-ascii?Q?5cqUCF9H2AbCbCkxWhWCpG75pk82toWuFbHv1ONeIYvhfj9O2gA7CYJaVSjP?=
 =?us-ascii?Q?mGZPwl9qbQfptProVJ0qf4nal/vL/rA8sKAOXqXIOi+W9bo27Xqc1XrGoWvz?=
 =?us-ascii?Q?r3s6BZw1mPjbVTmsokPCkn572PDomAhkGDMhRKbQRjPMP5164lTL6Pl2H63j?=
 =?us-ascii?Q?K9eFBW/NUS0IC3NRshz8ZNrl/kiBtyCaVAAaOu0UOykpxzE38xej0uhtOcmo?=
 =?us-ascii?Q?G8gKu4XLkagR3EFvlZ/q7N0keERM3eLC7n9VmLiTnmXwlvfbPpS3bE84V5Cy?=
 =?us-ascii?Q?zrFCxi8eispCaN2snQT6mYG1LrHpy1WohviVqSU9pWhmvaOjjhVaSbVqh2eC?=
 =?us-ascii?Q?0KHFwDX8cR7GVxEo/BMqjfi5hz7wOkW/dbeK5Fck640+zgH3szJx8E6LebV+?=
 =?us-ascii?Q?Zp4VrAo1Mt4MZiE+altlH/YbAcKUPUlNSkmjvOFI6dhiGukXaNvxopkWAi3R?=
 =?us-ascii?Q?8o/UcBwrkdWqwvhevpRIfbSJW/cxCRPlw7GRGj5nJhJaQjNiEaexDTX/UhCV?=
 =?us-ascii?Q?7Tcztz/maeJs9NL6dBt+tpnqLyrqCK4MCTpX/RAM7ALxv++qp9nwNFVfzT1p?=
 =?us-ascii?Q?2xDo4LXq3xz+VotccVzUwgl33xG9G1hSNg06WkcegzdeOK1GA3irVE/TUlvp?=
 =?us-ascii?Q?LuOFvyQZb1poSlUaNM9q9xOpc37MJJnCFSwqgz5XmGNBhAjBBqHNpi6y5fqg?=
 =?us-ascii?Q?ywBAcEBKPSI1mO8ZsG0k7FmhUhGVbUcXF7o5tnL2cNJO5AwP2K/81n6r3w+q?=
 =?us-ascii?Q?VszS8eyvs1RhGwZiluDihxcxZNmqJ4efvY+eQgl1lvnoeSxyWDMmNsyOxZ3x?=
 =?us-ascii?Q?28juXkd4PlRF5s6dYT/wYOJ9fa9nSU4vYT+eVT6GwTD0gf02jM91lTVi5Mdq?=
 =?us-ascii?Q?UVVIKOgDEu8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(52116014)(376014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dHbMqjeGcmcvfvDYS00P3FmMuTdHiobQx/5YYOaXflHB7GxfhN/YzrdI/Q/G?=
 =?us-ascii?Q?7JohOOWXvxXDoltulW0+4eHOzs2GnM1lgXNcTy+4lvbetei1LAY8erJndovf?=
 =?us-ascii?Q?gZloGgl74bLU4lSHZWcOV+NNAXwh0mMWTYA/G1FT0mhtffBfmeSAze2WpOQ1?=
 =?us-ascii?Q?kUDT5cNA07xn/ekZ7izxl0PdYY5VZqomT51RGChMJAwZVx+ynYKPsXS4xx91?=
 =?us-ascii?Q?dfV4SH3LMbrTBobFHimj18v7USoX9/g08JS1++0VWMSm1zL0oNeV5L3tLYKC?=
 =?us-ascii?Q?0dB/3lZiItR422LhzgUVVGY4x0sRxExafXBeR//VgukgDtl4lQWcui7dHGzZ?=
 =?us-ascii?Q?O2OwEr0eZ2j7ggHD/oLT32DwfW+lmII9f3ZmARG7W7ksDgFwMXVlKR6ag21o?=
 =?us-ascii?Q?O7aZohA5+sxUHyl6XCY9HpLFWdhjDoM/lon2E3xVKaQqIhZfJpPg6rJ1A2us?=
 =?us-ascii?Q?olZtiddulkjIdwo2pUaBRTRM/+GRUjvKFe1SebQ9VJRfDs5cDTVdtcYdHHp/?=
 =?us-ascii?Q?+hETpF8iCvDs9XUkKPlW8TG3b9rNL7R0SyTsqJUjz7gPZEebm92YY8USx9NR?=
 =?us-ascii?Q?8Obw/Qw+UR/N1/NqqQDanpEMT+8Ebb0hl0SdlqdW/QbPdRO+MWsD6JvzTzas?=
 =?us-ascii?Q?bJK4WurnhknsT0cJcc2sDvCpAGipuXsTkmfpGyN+jtcPIlttf7QAh2qx3ZjJ?=
 =?us-ascii?Q?vTmDtq2OCKNQAzEN+jUp9dKquB5fDUOxRf770oOHM5QRyKNowzxVrmsTQ/4f?=
 =?us-ascii?Q?Bap/LI6fp5ZcMk9hr/8hhl36Nkm+5ZM7EIOrt9AiAz09V2PQPRe2dMveBZId?=
 =?us-ascii?Q?I2tWFX4uy4OBCP6Lt7RtvM4vRMfQlWdJnEe8Q2Z3TXNkns48xlvJ99lwzrJ5?=
 =?us-ascii?Q?kOLjdb1zhpLODKfLM42JAvDgEWYdrNpsXW+X68o4nn/fGXuJA/A0JUbDcOFh?=
 =?us-ascii?Q?OCb298K7das23eW1A0afXI6sqAr6/Hjh1gUiAwhbl6x4J0Pkmg2vd9wVJTK4?=
 =?us-ascii?Q?6VihXGoH9fGCKbDZxuLo76901WDlu2YKIt+u8Wz9c/K/u4r6KI7MtD/E+NXP?=
 =?us-ascii?Q?dbyEwtCi6xJ4MZLHFAQ5cWmeX8ZX3XZuM84jJ4kQX4SZUhEslNZsQzHEyugn?=
 =?us-ascii?Q?N52x1AY8T7PNkV+tsewIusBdNFiX9NVwge+WjPj6n1EeOJ36UodQLAVe/gAB?=
 =?us-ascii?Q?pE5cO82PySCd//nGTZUPfDS7cSdC7/qGdoG/gW1AyNJXKFteJwnHpOr+1uTH?=
 =?us-ascii?Q?VGj4GuHCIe+C8ykkZocBSdwATlLB5GJP0dyXYR6hBGDD6aEAfrEbyenkd31l?=
 =?us-ascii?Q?/LHPAdNn+hfNujjvg4mDFz/Iz6kIn3VoGeF5RPxdTSR9MlU0zouDIJNVpl5F?=
 =?us-ascii?Q?Tf9UUxw5LxyUHH1uffZUzCuyM9pLkK6cEzIwErip1y6s2WT+RBFws2aT6yEH?=
 =?us-ascii?Q?mL6r+zx7hBefJwWsknmwQnQzmOxTfX/tSD4oVXZQrKYbQUhKGxVWU3gyINeb?=
 =?us-ascii?Q?5cRCW88A1riEhm1UfMcRcHQmdsSJ37R/hTMrhbBtOXbj5DZl42GBVEln6BUM?=
 =?us-ascii?Q?6HuPaySQiM5Nn3CFBmDKhO7POPMoxOnDBwqD4U6K?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e9ee0e-e993-4cbc-7342-08ddfad8e0c1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 19:39:14.9425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EDdk2lqxmlzimWpX5W+K083wkMqIPTL86SqcpKZjKKpzpCSjcHK3vMssRJkA8Jz9KoeAdKYc3zUK3jq3qW6FOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7421

On Tue, Sep 23, 2025 at 08:12:00PM +0800, zhangsenchuan@eswincomputing.com wrote:
> From: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
>
> Add Device Tree binding documentation for the Eswin EIC7700 PCIe
> controller module, the PCIe controller enables the core to correctly
> initialize and manage the PCIe bus and connected devices.
>
> Signed-off-by: Yu Ning <ningyu@eswincomputing.com>
> Signed-off-by: Yanghui Ou <ouyanghui@eswincomputing.com>
> Signed-off-by: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> ---
>  .../bindings/pci/eswin,eic7700-pcie.yaml      | 173 ++++++++++++++++++
>  1 file changed, 173 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/eswin,eic7700-pcie.yaml
>
> diff --git a/Documentation/devicetree/bindings/pci/eswin,eic7700-pcie.yaml b/Documentation/devicetree/bindings/pci/eswin,eic7700-pcie.yaml
> new file mode 100644
> index 000000000000..2f105d09e38e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/eswin,eic7700-pcie.yaml
> @@ -0,0 +1,173 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/eswin,eic7700-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Eswin EIC7700 PCIe host controller
> +
> +maintainers:
> +  - Yu Ning <ningyu@eswincomputing.com>
> +  - Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> +  - Yanghui Ou <ouyanghui@eswincomputing.com>
> +
> +description:
> +  The PCIe controller on EIC7700 SoC.
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-host-bridge.yaml#

In drivers, you put drivers/pci/controller/dwc/pcie-eic7700.c under dwc,
suppose it is dwc core.

so it should refer to snps,dw-pcie.yaml.

If reg-names or interrupt-names don't match your requirement, please update
snps,dw-pcie.yaml in case difference vendor use difference name for the
same functions.

Frank

> +
> +properties:
> +  compatible:
> +    const: eswin,eic7700-pcie
> +
> +  reg:
> +    maxItems: 3
> +
> +  reg-names:
> +    items:
> +      - const: dbi
> +      - const: config
> +      - const: mgmt
> +
> +  ranges:
> +    maxItems: 3
> +
> +  num-lanes:
> +    maximum: 4
> +
> +  '#interrupt-cells':
> +    const: 1
> +
> +  interrupts:
> +    maxItems: 9
> +
> +  interrupt-names:
> +    items:
> +      - const: msi
> +      - const: inta # Assert_INTA
> +      - const: intb # Assert_INTB
> +      - const: intc # Assert_INTC
> +      - const: intd # Assert_INTD
> +      - const: inte # Desassert_INTA
> +      - const: intf # Desassert_INTB
> +      - const: intg # Desassert_INTC
> +      - const: inth # Desassert_INTD
> +
> +  interrupt-map:
> +    maxItems: 4
> +
> +  interrupt-map-mask:
> +    items:
> +      - const: 0
> +      - const: 0
> +      - const: 0
> +      - const: 7
> +
> +  clocks:
> +    maxItems: 4
> +
> +  clock-names:
> +    items:
> +      - const: mstr
> +      - const: dbi
> +      - const: pclk
> +      - const: aux
> +
> +  resets:
> +    maxItems: 2
> +
> +  reset-names:
> +    items:
> +      - const: cfg
> +      - const: powerup
> +
> +patternProperties:
> +  "^pcie@":
> +    type: object
> +    $ref: /schemas/pci/pci-pci-bridge.yaml#
> +
> +    properties:
> +      reg:
> +        maxItems: 1
> +
> +      resets:
> +        maxItems: 1
> +
> +      reset-names:
> +        items:
> +          - const: perst
> +
> +    required:
> +      - reg
> +      - ranges
> +      - resets
> +      - reset-names
> +
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - ranges
> +  - interrupts
> +  - interrupt-names
> +  - interrupt-map-mask
> +  - interrupt-map
> +  - '#interrupt-cells'
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        pcie@54000000 {
> +            compatible = "eswin,eic7700-pcie";
> +            reg = <0x0 0x54000000 0x0 0x4000000>,
> +                  <0x0 0x40000000 0x0 0x800000>,
> +                  <0x0 0x50000000 0x0 0x100000>;
> +            reg-names = "dbi", "config", "mgmt";
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            #interrupt-cells = <1>;
> +            ranges = <0x01000000 0x0 0x40800000 0x0 0x40800000 0x0 0x800000>,
> +                     <0x02000000 0x0 0x41000000 0x0 0x41000000 0x0 0xf000000>,
> +                     <0x43000000 0x80 0x00000000 0x80 0x00000000 0x2 0x00000000>;
> +            bus-range = <0x00 0xff>;
> +            clocks = <&clock 203>,
> +                     <&clock 204>,
> +                     <&clock 205>,
> +                     <&clock 206>;
> +            clock-names = "mstr", "dbi", "pclk", "aux";
> +            resets = <&reset 97>,
> +                     <&reset 98>;
> +            reset-names = "cfg", "powerup";
> +            interrupts = <220>, <179>, <180>, <181>, <182>, <183>, <184>, <185>, <186>;
> +            interrupt-names = "msi", "inta", "intb", "intc", "intd",
> +                              "inte", "intf", "intg", "inth";
> +            interrupt-parent = <&plic>;
> +            interrupt-map-mask = <0x0 0x0 0x0 0x7>;
> +            interrupt-map = <0x0 0x0 0x0 0x1 &plic 179>,
> +                            <0x0 0x0 0x0 0x2 &plic 180>,
> +                            <0x0 0x0 0x0 0x3 &plic 181>,
> +                            <0x0 0x0 0x0 0x4 &plic 182>;
> +            device_type = "pci";
> +            pcie@0 {
> +                reg = <0x0 0x0 0x0 0x0 0x0>;
> +                #address-cells = <3>;
> +                #size-cells = <2>;
> +                ranges;
> +                device_type = "pci";
> +                num-lanes = <4>;
> +                resets = <&reset 99>;
> +                reset-names = "perst";
> +            };
> +        };
> +    };
> --
> 2.25.1
>

