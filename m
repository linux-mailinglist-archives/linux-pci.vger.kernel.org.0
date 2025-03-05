Return-Path: <linux-pci+bounces-22980-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 789D9A50389
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 16:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61561188BA22
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 15:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173BD24EF7D;
	Wed,  5 Mar 2025 15:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="mtc6ewIP"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2040.outbound.protection.outlook.com [40.107.20.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B45C17BEC5;
	Wed,  5 Mar 2025 15:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741188805; cv=fail; b=GxGxZxQSeJqcDdVWJLe4O+HCafS0Dk9FRYwT79OS+LDohE33kR1fdLmSu0lLu41HBKiGVHMQxjPwQeQShNVKgftg/kbtixnpfHV1MLqmIHiOI3sMC7Ibw3fGXcaTpt1169VVOVmTnXJLpmLiK0Q0YmLkurhmqwH0v3XfwyOaV9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741188805; c=relaxed/simple;
	bh=732vRvUfz8WBsM/MIaLusTbjPp2EV65ZqiwVT3WfUIc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CaHERS4cfsTBuB0yZTysTA2mpChidSjAjX677yjVbWh3VLsdqIA80Sot/7oWCV902T3IQNkXOMIgols/kXjHygsMt+4CGu2DIfckweYmj0bNwaYsbWYLiefHqOzDcpwYqs05q1gBL9beK8/uESxHu4tFsv5S1QcK4WnTAegUjUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=mtc6ewIP; arc=fail smtp.client-ip=40.107.20.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L4ke8TRk2kqQWtmdNk+KZyyveHv+uQOeV/OIN+H6kWCg1YnGaOlBLd36YxRe5j1NakRU/NHByyulHeS8QfpUjNsoQNkm0e7XGwemeCxEaVQP5Mtd9y5hIwdFh7QGQrzGti0plAd3wMdjMZ58qjZDsxuicYktl5wjDRRS+QBiYa6I1fAFngcdUy4hoLuKlabcMdwfULcdoZltuKR5PIBt1NkvVm5NvzYj5NxJ3WUvUwUasUjagMQieMCJ6zOnATUOTr5v3DoWwN+e3PkCRl8v6rpmtYDVzYip2Pk26u0TnPJx7SGAUqK7bDSvS9KGIS/EiwSvJraG3Qr+1kvaedSSMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AqMEPikRzroReWWrXA/nq4Khfij98Joguqp8vXS6nOc=;
 b=P0MybKkTXebSYGRDqWgb1Jp0caeiFvpslGHqk9VjjdWXxVg2gkuABhhfnm5LCIfxLnPJQ3PbgU+GtUZhuqucqbmXcuAip9CgSYjJbd5Zk8xIDN1cG5U5BSZ6Ln/qacYy4GFJQ13ST7uXHm806RJ8nqf8A23RC0f67NyvnLc0CpX5byiDutMTj+iu5GSwUrQUYAYShiEUIOgAQ9Oil2XHuBg99xZqvBOJieMdQ1hpAEcwg/FG8+8H+BnMPsBEyPN4/Na9ZnaoM735AiMY9yyNnSEv3BBhAq3ep3Jpq58NNatUrPgA9Ro1MN+dd090n/ux/vxLEvECIo9BkGTfnffvEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=google.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqMEPikRzroReWWrXA/nq4Khfij98Joguqp8vXS6nOc=;
 b=mtc6ewIP0DiN5JZo+wLlo/ZdHB2sVMa3WVESfLQVY3W4P8XtdgwCkibM5XFMYZi3WC5d0xDlEZXUiF3URBcw6RC+y0K0UYLcNi7ekVUV9vp1S0LzpGgVtmVI0vWreg9t5kGwohHYZFG01oyKwPmB8TwVDrxJ89tJI1RkFOm96j0=
Received: from AM0PR06CA0105.eurprd06.prod.outlook.com (2603:10a6:208:fa::46)
 by AM7PR02MB6324.eurprd02.prod.outlook.com (2603:10a6:20b:1bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Wed, 5 Mar
 2025 15:33:20 +0000
Received: from AMS1EPF00000045.eurprd04.prod.outlook.com
 (2603:10a6:208:fa:cafe::ae) by AM0PR06CA0105.outlook.office365.com
 (2603:10a6:208:fa::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.18 via Frontend Transport; Wed,
 5 Mar 2025 15:33:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS1EPF00000045.mail.protection.outlook.com (10.167.16.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Wed, 5 Mar 2025 15:33:19 +0000
Received: from SE-MAIL21W.axis.com (10.20.40.16) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Mar
 2025 16:33:19 +0100
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAIL21W.axis.com
 (10.20.40.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Mar
 2025 16:33:19 +0100
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Wed, 5 Mar 2025 16:33:19 +0100
Received: from pc36611-1939.se.axis.com (pc36611-1939.se.axis.com [10.88.125.175])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 0016B263;
	Wed,  5 Mar 2025 16:33:19 +0100 (CET)
Received: by pc36611-1939.se.axis.com (Postfix, from userid 363)
	id F0509627BF; Wed,  5 Mar 2025 16:33:18 +0100 (CET)
Date: Wed, 5 Mar 2025 16:33:18 +0100
From: Jesper Nilsson <jesper.nilsson@axis.com>
To: Frank Li <Frank.Li@nxp.com>
CC: Jesper Nilsson <jesper.nilsson@axis.com>, Lars Persson
	<lars.persson@axis.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
	<kw@linux.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>, <linux-arm-kernel@axis.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH RFC NOT TESTED 0/2] PCI: artpec6: Try to clean up
 artpec6_pcie_cpu_addr_fixup()
Message-ID: <Z8huvkENIBxyPKJv@axis.com>
References: <20250304-axis-v1-0-ed475ab3a3ed@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250304-axis-v1-0-ed475ab3a3ed@nxp.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000045:EE_|AM7PR02MB6324:EE_
X-MS-Office365-Filtering-Correlation-Id: 53a7fdd3-e070-424e-6135-08dd5bfb0ed0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c1LE3LGYUx6dQ+wH3v3PbsO/09Cp7jSWO1VxXpSPZ/uLIQ0ok7LgxhM+Se4u?=
 =?us-ascii?Q?QR9JKCVv10Oy3+ECr5K+NWJiDszQawZCwSTtTdcYraTBywcm1OYpclj9tXna?=
 =?us-ascii?Q?Z7aYq0ygl0lvd/TCb62cYnj/3jI6MHeANA8Hwz5rmaTOUjXtWOiAS0d2p2Y/?=
 =?us-ascii?Q?WP767pppbl4VA7X/dIlGQqQM2IrIpoqnnvHoaMGsM/PRDrHTQfsYg9jWeALF?=
 =?us-ascii?Q?VAuWt3ozGpQPGzhvmiCdRmR/y8fsPbm6apkR4UqBoQgHmKH3t8IFRtXLoF/0?=
 =?us-ascii?Q?jXSnpiHiJUjBGKFobgXqUsKn2mltGl2jGtEMRSFLEU4Js4p+SV+KAuyUoNg4?=
 =?us-ascii?Q?UQu3M7HW1xXLs1N05LFqmYUojFYC3+d3cAi3IhElLtrFopr8m2ZxV3qgAaMh?=
 =?us-ascii?Q?CgGd7XVE7Y6qWD4qHwgNZMpvN83/LFQX0bGdzAk0IT8S90mYq4Rl1bHQuloh?=
 =?us-ascii?Q?phIYi3ZyqILdTMasNbMymkWdLTWXBvbvAtxZn0XIssI67EpKT8oELAnBRQqv?=
 =?us-ascii?Q?PsiTJ3KA2NUqgpBL65ubSKnwphIAwxF9nGTVHOEEhAlRSp4CIVte+1ioLdFV?=
 =?us-ascii?Q?AMC0DlvIsenVVGpFnwOG7ygcp3+Cff1SXGxQld1UwhqaG2IJYURP5QEnHRFm?=
 =?us-ascii?Q?UfWfgqU+nFTijNwBJW/1pztvigRZ3iU9aFfpELfsOe5f0J8L/fdGQui9Bg5R?=
 =?us-ascii?Q?Te/vSbf6uRqqomUUc/XPhibU5TH9ygHhkI8LRxKLHtbaqhsgtrGAA2Mu5E4m?=
 =?us-ascii?Q?k3QEtfvSNB9QEMJishidjW5QPRIc7Nh6Phhovuskv7wWGcR4pOd18AmCohQn?=
 =?us-ascii?Q?/3AR5VyfJKRtxj47K9lyXjRlIX3xaZ+GqP8fDhnsE8w6WiiI8hRwqlhJMPeG?=
 =?us-ascii?Q?5VI1zTA88ftgUb+2Yk5num2v8Cr7H6HB/eVYM9OcLg/KTKWPT+KsAE5Rwfj7?=
 =?us-ascii?Q?vhJ3ug57mENw/WCLh0qSmleShhEnKpbUHFgAteoeUseAUqcLceobrUlxrE3I?=
 =?us-ascii?Q?RiOBQ49AfxNEbaf7iZ+K/o6s73gJqT3GaVKiIDoEhZR9SlJ4ZLQjgvbRJ3fy?=
 =?us-ascii?Q?OOb5WRyiSw9Qw3oIxeFFHjTRxGC0DBVzENd3VCgMbh+WZlKUFzOLy2rlp6vy?=
 =?us-ascii?Q?1ExJH8dslYBMLI7eCQILvb3J4isK+bStxyUqKKx+SFmU9oDObJYK87NXFr9i?=
 =?us-ascii?Q?LsLSBajkPS0mhWffbjZ9+4j1yl5YcYvakvEtfqSUqd53cuUcmwu4jxQh0vzS?=
 =?us-ascii?Q?StuUWmUtecJpsnPbQH5kTPjfjjTiBlVvkSJt8MQiHu5ImdCq/041kgt6Kin1?=
 =?us-ascii?Q?qNyfQiMdSmdPh6OftZZEzDh+ujx7aTLkkhwm5csqW4TQ7RmcNh6khshVfW2d?=
 =?us-ascii?Q?WxQOCS2zKZBh9pZW+5qEKJBUZmosTUxCPq17SsDa280iYdWNCo9AbO0Ys00n?=
 =?us-ascii?Q?Ht9weJeCTYb3syVLNn1q4ifM9hTYAbtXOcOYgxJtUotEuT+eRr45D7C3c3XW?=
 =?us-ascii?Q?8NO7Unf+aP9sf48=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 15:33:19.9622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a7fdd3-e070-424e-6135-08dd5bfb0ed0
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000045.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB6324

Hi Frank,

I'm the current maintainer of this driver. As Niklas Cassel wrote in
another email, artpec-7 was supposed to be upstreamed, as it is in most
parts identical to the artpec-6, but reality got in the way. I don't
think there is very much left to support it at the same level as artpec-6,
but give me some time to see if the best thing is to drop the artpec-7
support as Niklas suggested.

Unfortunately, I'm travelling right now and don't have access to any
of my boards. I'll perform some testing next week when I'm back and
help to clean this up.

Best regards,

/Jesper


On Tue, Mar 04, 2025 at 12:49:34PM -0500, Frank Li wrote:
> This patches basic on
> https://lore.kernel.org/imx/20250128-pci_fixup_addr-v9-0-3c4bb506f665@nxp.com/
> 
> I have not hardware to test and there are not axis,artpec7-pcie in kernel
> tree.
> 
> Look for driver owner, who help test this and start move forward to remove
> cpu_addr_fixup() work.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Frank Li (2):
>       ARM: dts: artpec6: Move PCIe nodes under bus@c0000000
>       PCI: artpec6: Use use_parent_dt_ranges and clean up artpec6_pcie_cpu_addr_fixup()
> 
>  arch/arm/boot/dts/axis/artpec6.dtsi       | 92 +++++++++++++++++--------------
>  drivers/pci/controller/dwc/pcie-artpec6.c | 20 +------
>  2 files changed, 52 insertions(+), 60 deletions(-)
> ---
> base-commit: 1552be4855dacca5ea39b15b1ef0b96c91dbea0d
> change-id: 20250304-axis-6d12970976b4
> 
> Best regards,
> ---
> Frank Li <Frank.Li@nxp.com>

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com

