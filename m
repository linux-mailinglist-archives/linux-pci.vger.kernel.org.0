Return-Path: <linux-pci+bounces-16885-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F64C9CE16E
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 15:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D427F1F219CE
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 14:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6335E1D4618;
	Fri, 15 Nov 2024 14:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="eLPp5mIg"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2042.outbound.protection.outlook.com [40.107.247.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315911CEAD6
	for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 14:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731681556; cv=fail; b=ojvDGzwte0LSGgTrfjo+iBmz8sT9NfSQBUjUCTIXYeTbeG0Qj9Ku2h5tW1wIr3VRoaVrXQLmeWJi4pYHeEUn7Ex5yPL1+lIIUVEHITu+X5hPcujUUyhFV3iL2bFKc/iiNQ1YO6jJXkDIgvVvDMUc/H3aaSiMPNitA8Re2kD3goQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731681556; c=relaxed/simple;
	bh=sFL4yrQu9rQdHdopzxF3wcuvtcPOoOOGAuZL/Yr0UOI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PmK2OPg3dNLxuL+bABKO+NbR14D3Xs0RszpI80OxYdnvzeFbD0RqSL/lXSzDEWV7TYgk2pumYI8JQUF/mOkDRmhqNWn8mjjFEO7Oxbf5j/pf4Ni3+mhaSU0oX2tUhNuT6RuB1Lxh+j9aJQiVQsPploLesOo5Xf5GuauJJTx6gYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=eLPp5mIg; arc=fail smtp.client-ip=40.107.247.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xlY/m0EmENc88Xymw3Szif3V3DdfhjybgeO6but+M+Fg8uX1GA9Pjw2eI16sFvwiCLGbJYnuiUriENiZF5WW+9uHv6IJl4rhPXG+olR3iciWLBGVScGP8dYAaFw3KQ7YbiokFtRV0KXxip9aveEOOUg+Opvvmj68HnC7ijmJY1WrhTaM0w580OJtBEvbXMB2/na9IeyAiFwxNTDSmRaOAF/dNX3fkqkM1wL7db1t5tqRXdcQyPR2YPDvQrE269sS/0ZEfWAZneFGWVaLkPl0Im/4phJuBi1rhDOMDPF39Qui93yfQEE/1oS1Gd2XxABt1e3g2KO0cBodjLVLy8MdPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKDVwSGgbrSPe/1EkdovfzU7hht5+SFl1NSvqvVkerQ=;
 b=l3cfykpW+qRNxdV8fPqwxz/ZRc21MCW1GcijufE3xq1Iu9d59BLadsw0b1RK7I9Xjqj0Vf4wcayagzWGhUsR0Vg2/5Ka2GPf/EhuWUYOvnyklwswwzUYNtZhX496JR4k/eMcWE1Z3Kr1jgCj6/ijhApwh/fDt6BCtlbB0ccKOnRU9PA4sxOPpPC9WWQ0DHdiOpmcoa7fXJP+903O6o6ux9yk7cX4zZeN8AfZhbNhbTLmI9gID5RjerPIIAXva1+rzBYsZmil+JzT8tUs93Oc5eIM6EibCqlt0L5gJOE/VmKI7oU1lqtCHinOvpyO8JZoaffpaQYngIftQJNRJ57H+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=google.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKDVwSGgbrSPe/1EkdovfzU7hht5+SFl1NSvqvVkerQ=;
 b=eLPp5mIgqKOIqOzNSA2oB9UBzd2jxeMRrl2ACc44DVwmtY3oTrtmqYoOvMkQAApkt/4180WxtoLgl+Qkj7gNYGRGvbsUkPIrk4uI6TGaNJfaH3GqBCj34EwcSAlYC783Mj/yBVjUvJTi/ir3VIdPtw1XB1B7/Wz1K9mVFapATKI=
Received: from DB6PR0301CA0078.eurprd03.prod.outlook.com (2603:10a6:6:30::25)
 by AM9PR02MB7169.eurprd02.prod.outlook.com (2603:10a6:20b:3b4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Fri, 15 Nov
 2024 14:39:11 +0000
Received: from DU2PEPF00028D12.eurprd03.prod.outlook.com
 (2603:10a6:6:30:cafe::bb) by DB6PR0301CA0078.outlook.office365.com
 (2603:10a6:6:30::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18 via Frontend
 Transport; Fri, 15 Nov 2024 14:39:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF00028D12.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Fri, 15 Nov 2024 14:39:09 +0000
Received: from se-mail02w.axis.com (10.20.40.8) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 Nov
 2024 15:39:06 +0100
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 15 Nov 2024 15:39:06 +0100
Received: from pc36611-1939.se.axis.com (pc36611-1939.se.axis.com [10.88.125.175])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 7C2F73BB;
	Fri, 15 Nov 2024 15:39:06 +0100 (CET)
Received: by pc36611-1939.se.axis.com (Postfix, from userid 363)
	id 77D8762686; Fri, 15 Nov 2024 15:39:06 +0100 (CET)
Date: Fri, 15 Nov 2024 15:39:06 +0100
From: Jesper Nilsson <jesper.nilsson@axis.com>
To: Niklas Cassel <cassel@kernel.org>
CC: Jesper Nilsson <jesper.nilsson@axis.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
	<kw@linux.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	"Rob Herring" <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Damien
 Le Moal" <dlemoal@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	<linux-arm-kernel@axis.com>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] PCI: artpec6: Implement dw_pcie_ep operation
 get_features
Message-ID: <20241115143906.GQ6523@axis.com>
References: <20241115084749.1915915-5-cassel@kernel.org>
 <20241115084749.1915915-6-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241115084749.1915915-6-cassel@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D12:EE_|AM9PR02MB7169:EE_
X-MS-Office365-Filtering-Correlation-Id: 89ac9ad4-a034-4dbb-3729-08dd05834400
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kZwmdqkMgVg8qwo+/iAXFXLTDJYBIX6CveLub3rP/lE2r0dNYM3aWtDqEz+m?=
 =?us-ascii?Q?RGzdMXCIuZIMkhAISxzLDGHPbRXqpOl+9l6KCWsYKhKdNcyjUsDyIufZX5us?=
 =?us-ascii?Q?F0Um3vJp40wsr+AfV3v7oTVnSxKJOwv62SRlsnbQCulDq7d/qyx2J2soOmiW?=
 =?us-ascii?Q?kJi9YnTnN270UEsWQ2lGwtOd3FkyZGmjhHVeFn0gqc1kT4PbPpouhvOuN2H4?=
 =?us-ascii?Q?jr37OF0ZDRDtJQXSBjbBdcA6SBVWIRFjhIVH4rNgo8YUPjkHcVP55mVBeiO5?=
 =?us-ascii?Q?xHR8jn8USVcdu+7EBht3C2RXb05vNmb8NoCyqbzoX2MKxk6wd0eTQ0Py2LkG?=
 =?us-ascii?Q?2fJ9jmE3dwWQ5X0aFDcPI8YFgw5U3KwgWqs+6PD+77JuPCMEPAKPklLYeOaY?=
 =?us-ascii?Q?XZf/1Xq1+0S4KyYmyvjxMDVTbYwdchB2t4vtrXTUyYISc0y+D/4mHaeZR7Il?=
 =?us-ascii?Q?8iyqGt12eHwYi0O150zDqFeZ2qp+3epmEDRFl87LMAOLR+ZQ/MyrvkBzGVqb?=
 =?us-ascii?Q?2KTiLwGbKkUPyGVakx2iZsZu0/rJuWotfiRwW6kx4LlN9iDuSoTBrWK05gDJ?=
 =?us-ascii?Q?xKTTPVwgbUrLmaEdAEy+sjpynoJBOWhChkqTzHiU4YwEDufxKeK6WPpJOoYy?=
 =?us-ascii?Q?em3MPwfXRACwDNalpC/UAIflb+SyleMKJZsflOosRlQ3lhetYny3s2Z1FnQH?=
 =?us-ascii?Q?Sg83QxcQqRToVQKCflnVBEP3pSzqwfvKEfClRTNQ8hRHrClx2P3lIlEL1BMK?=
 =?us-ascii?Q?mzR8KeoLgJnfsuFrMHyT2X+qQaNDwxAM/FxfqKa3qo0JPxpkQ+WYJO9YjNS4?=
 =?us-ascii?Q?x1j5H174OAVjbenUvh8O79p4oH5j2REF6tN/MMWBMDEkoW5SDh4v/7BkYIzA?=
 =?us-ascii?Q?BBi7yIUeSvd+Rz1mhlRIyJxkMt4jN6qIPvthTH6Wys/F0sCw6EFCX9H9AsPq?=
 =?us-ascii?Q?PYO6yq2qqQl7UPPH1fN0vlx7YytRWOIMhEDPP0T5KSTdUJ3gfdSSWduN8gbq?=
 =?us-ascii?Q?0vIOBiZyGbuNEVQag1fxFBV6sVyBvBg283Wy3U9M2HKlJ4uE75USBVa3D0Q8?=
 =?us-ascii?Q?1XgEqQwPK14OSJBIDS4yASlZcTpEAFpMvbX3hrERgpcGz3nj2KxMz1GlM3Z3?=
 =?us-ascii?Q?136y2Gr+rWfw4Sx9JwgBizcigBPqX5k3oer3Mi1PjNMLQRzf8xuXcURarSDW?=
 =?us-ascii?Q?cuvQ4oADbhUtufFNVqLaKzP0Jplubams0cU1DZttPSPxI+U3S3rlgHCcSffZ?=
 =?us-ascii?Q?ovoNStyyM4WM953cVpgYbqzZ4FH35CiM51ki0AJcpmmjFGO98b+20dZ7p2i6?=
 =?us-ascii?Q?eQipObIUeaakC90Bm514lDNOONpvNAJUlfMrDTqNdZhPBHpEmKCHb/8YvvsR?=
 =?us-ascii?Q?zvjwNRhWZl4SoMTDP1dzRYmffrmEAt8xuWd7TGnPwPB4sSdXyw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 14:39:09.5416
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89ac9ad4-a034-4dbb-3729-08dd05834400
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D12.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB7169

On Fri, Nov 15, 2024 at 09:47:50AM +0100, Niklas Cassel wrote:
> All non-DWC EPC drivers implement (struct pci_epc *)->ops->get_features().
> All DWC EPC drivers implement (struct dw_pcie_ep *)->ops->get_features(),
> except for pcie-artpec6.c.
> 
> epc_features has been required in pci-epf-test.c since commit 6613bc2301ba
> ("PCI: endpoint: Fix NULL pointer dereference for ->get_features()").
> 
> A follow-up commit will make further use of epc_features in EPC core code.
> 
> Implement epc_features in the only EPC driver where it is currently not
> implemented.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>

For the ARTPEC-6 part:

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com

