Return-Path: <linux-pci+bounces-40457-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E1BC394D3
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 07:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0F3E1A402A8
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 06:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC00926CE2D;
	Thu,  6 Nov 2025 06:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="G+yfkb2k"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010004.outbound.protection.outlook.com [40.93.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170342745C;
	Thu,  6 Nov 2025 06:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762412016; cv=fail; b=t88B0PDOB0wL2yJacJfr5xklB8Nar8bwTsXi2rjST0Bzgo6lCw9of/YS6d4US9k6b3l0LKbtgdRLdYxdoDRShqeiF6gS8Y22rIEaEiAh2TSVZuf2aE+0j/hZL1CAbEyUuSp7nybOMUKnXIJBw5Tal6ZCzj4kYX5dPA8YwOFco3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762412016; c=relaxed/simple;
	bh=q6Scbv2Nw1QRVqEvEt2Qsbh44aCeU/gu/z1bhEhim74=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pC0NvkR1cvQ7q7pf/iIIcDCQoD8UPU+Tac9A1bCpFg5L0pglsNpsKKiD8eCXfMv0ODtqAONLy/vy+nCt3IEaX8aMnU/l6ZeipW44KaIpPqSzfrnxh2oSd3tfjLN8Xpgi3YV/ZidFvQNU9OShQ1pzFcLnqIo4E7D5mqGsHaMlDRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=G+yfkb2k; arc=fail smtp.client-ip=40.93.198.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wz7R2sdLqNWpfHNGbNTVIbaUmVLMR1wr+3jskq86x11VLNGD6erd8ZJBxJNva72YFTGdY9B+0Pzlu55RqocfeTZoen2hiprB9FbWygkyTsSbELapdA4bI0Tl+/LmNzbEWa1jdAxVGHHVPBljyrmZmrE+bZOLrtTtqTIbzvCPtu6L8iIVgTslD4rNtjlF5BJv2341tbXNkUtFDlH+rJyBT60Y+gQXSMg0WO2/BvXZ2xvi5SdCAHCgtc6cWG7XFsf9cOi73tKiMVId6a2l1I86RA48BfDvYOIjgWg4eddI2pwLrqfFF3gruZDsMb2zStK8mqnynGdNUivvvrdqqFEUyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTiGsBKiP0VhHkiM5i+vII8KYWVV/ip0LaNVfiZBrxk=;
 b=KtY1WIlwGTRWH59I6GZRg9sOD7SkfQDeNsAJKOpRFNHtTuxofG/KEEIHsyaelVY4I8qrph1QLZsAXAWWN89jRJC7s+7Vjf6Gh5lflh0yVtWdOyeJdAPTpf7Gpdi4GOIJjAwnkDnH41JninesMy7tLW0zG2DYc10PO2NT8PSh/ylNR4+TbmO9XqCs/RBPRIVTiTespHNfskmDJeGPzNakgdMHhcItsHEPE+aYJbsbnWibwAnaYeXbqz9ey9cSJlMrbxMhBPg5pQzXVTqPVgbNLkrBxtzr7QTU+KNTCT9z13p3WooEX6JR+NltcUeOtWl1jd0DYwHYVqt/j7Dva4Zbuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTiGsBKiP0VhHkiM5i+vII8KYWVV/ip0LaNVfiZBrxk=;
 b=G+yfkb2k6eI2JMERt/f1iTpOsL8UB3jl9RrbnLLeWdX6rArJiABKqxtNdaAXI8Y4V/BbTXlsSalslGCknpPpEEh7ZrmkYKorEW2J49Qf47zOBMlzsVE8tKiqN/kp3j+UrEl0+HgQibaeQQ6qnWRsBrbvH2thgUu7PSh9llBaeG4=
Received: from CH2PR11CA0003.namprd11.prod.outlook.com (2603:10b6:610:54::13)
 by LV0PR10MB997614.namprd10.prod.outlook.com (2603:10b6:408:33d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 06:53:31 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:54:cafe::74) by CH2PR11CA0003.outlook.office365.com
 (2603:10b6:610:54::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Thu,
 6 Nov 2025 06:53:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 06:53:29 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 00:53:20 -0600
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 00:53:20 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 6 Nov 2025 00:53:20 -0600
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A66rGVL831554;
	Thu, 6 Nov 2025 00:53:16 -0600
Message-ID: <9b9f4bb33620bbd30d4fc8d440f6e8fab71ed6ff.camel@ti.com>
Subject: Re: [PATCH v2] PCI: cadence: Enable support for applying lane
 equalization presets
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Manivannan Sadhasivam <mani@kernel.org>
CC: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <robh@kernel.org>,
	<bhelgaas@google.com>, <kishon@kernel.org>, <18255117159@163.com>,
	<unicorn_wang@outlook.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<srk@ti.com>, <s-vadapalli@ti.com>
Date: Thu, 6 Nov 2025 12:23:30 +0530
In-Reply-To: <57nw5lae3ev7krf3dtrllxaq2wvoajijq62ac5uttvajxjvpor@cmahebflp37x>
References: <20251028134601.3688030-1-s-vadapalli@ti.com>
	 <57nw5lae3ev7krf3dtrllxaq2wvoajijq62ac5uttvajxjvpor@cmahebflp37x>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|LV0PR10MB997614:EE_
X-MS-Office365-Filtering-Correlation-Id: e586f13d-ee07-42cf-a099-08de1d0131b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|32650700017|34020700016|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UEEzWDNHMHJjaDl0UG1RZGNFd2srUDNIS05MSWxTVi9peHEwVlRJSENydWcv?=
 =?utf-8?B?UklqN0ZCY3QvZnVXdWp0Vm8rT3ZMN0hiT2NJdjZTMzFQWk9kampQeG9OZ0pz?=
 =?utf-8?B?VzIyNU03ZmVhNFlQSU5IWnpPZjh3R3VCVDV3d1pqcG9OSk1SbkdYVVVsRUVC?=
 =?utf-8?B?UzNyWGNJVWJrMWRnUFF6b3lzUG9lbzhBQ3FDVzhaMm1HcXR6dG95cXl0cXc4?=
 =?utf-8?B?T1I5WW1vNlp0NDJON2JvT096aDNteEQ1bEx2VnJpTHhzaWRVanUwbXhvNzhG?=
 =?utf-8?B?b3psTEdnQzdEbk5SWm85OGNoRVpDUEgrZ2lsNjNLOGhjMmk4K2VjYWhLcEh4?=
 =?utf-8?B?M2s1cVpzVmROejByakNtZ25iTnQ3RVF2RzZwSEphSVFrVUJMYTRIR2J3WDVS?=
 =?utf-8?B?aTJCemsrRkV3L0Zna1lPdER3ckFCZkltVjgrbTd4ci84Mi9iUTI2dkZqNHY2?=
 =?utf-8?B?cDFHcGJUN204YVhSWnFoS29HczZNQml0akVHRmFWeisvSTliaE5mai9RN3hY?=
 =?utf-8?B?Yk1UVTdBbWw0emI4YkZ3cFhtTGIvd3hlNTljNk04ZFhFVVdCUUE0RjJCcGpZ?=
 =?utf-8?B?M2JRSm0vQXNlcjBXYnppbnRMU0hjVEUvVWhWNEhRa1JkMGtZV3Z1LzlwWUFW?=
 =?utf-8?B?SXNvSFJkVTJWc091ZDJwaXVBeW1nUjVsS0ZrZ1B1UjdQamZDaEpaOXlJelFD?=
 =?utf-8?B?UEo5bG9uUS9ZTWJ4a2xmQnhUOHhHdE1XMDN0aDgxTE5PWjRNRmJRQUVyaXZm?=
 =?utf-8?B?S1JxaFlacThId3JCNVBvRDdpU0c0aFdpQ0R3Y0ZNSDlWejY1eG9rTXMxM21F?=
 =?utf-8?B?MVAvaWE3bjhXWTliNkdpRWVEb3ZrQzRVb0tXbEQyQ24vdk54Y2t1UDQyTHVy?=
 =?utf-8?B?WXdYWUVFSTZRSThjU0xxdm1mcThPZ2ZKZTZCZmJmMlJnMzhVZmxOcTBzUkRO?=
 =?utf-8?B?c29Qd3FLeDIyRE96VHFBQkwyTlg0VG1OSlpLN0g1UTFiVUFSUUNDdSthYzl1?=
 =?utf-8?B?UVJMZWwvK3dMVHlkK1hQTnpkUm1QaGFmNkNDQTBSMVJpSFY4RnppUi95WE9V?=
 =?utf-8?B?SldVNWMyV1JBNDlOMWhxd2s0ekZaa0xnNTFaSzcrRUlaZHVtamkxQTkzaVlx?=
 =?utf-8?B?d3J5Y1BFak4zS09HOFR4L2FqMlBUNTJPNUFhb1JndXEwOWZrSCtyMkwxMG1z?=
 =?utf-8?B?c1JwZWFZbmZFdHc5VmFlalNtN2FMK3J0SFhVM3c5UWdjVWp6Ymt1Y29jVnpS?=
 =?utf-8?B?b1FDbzFRYjBOeHFRaWRvY285RWN6THprSDl1UHNnOVE4cXErSTdqcEJib1RI?=
 =?utf-8?B?OHk5MlBkcW92QktZMnBFWVc5dnkxaUp0T25rN250S3l3NWJaOE9hR09IL2dW?=
 =?utf-8?B?dFZEOVNQa2ZMZ1FxalpaMlA4QzR1eTR4OFJTVVIyNTBMRi9RckxxRGNGZWxO?=
 =?utf-8?B?UWhWTWdMbHUzbGI3N1dGK0ovOUlpaHVpTFVHSzV3aGczSXo5NGFLTHNxdlpY?=
 =?utf-8?B?eVpuR3JkOWxKN3Zwck5wUEQvUUt5WjNFVDVmM3ZtT1V1NFFjTXdCeFVPRW14?=
 =?utf-8?B?N2tIcExlQnBXM1JNZFcrdlJKUjE1SVhPa3dzc2lFNnVtYWFoNmlZeWdhWmlG?=
 =?utf-8?B?aDlranV4dWJKY1cvNWIwaWJ4RkJzM3hPemo1Vmd4VUxjVnI1ZDZrYWM2VXJS?=
 =?utf-8?B?MnJVSVd6ZVNFQkUxWmtqZ2hxQWg4STNrN0V1R2ZnK1RaSXhySFVLMytJdXh5?=
 =?utf-8?B?ZlcxVkU2UCtLaUg5YXhKQk1GOU1oOVFwRlFuUEFsc3NhdWtJWFpGdGFWQTJB?=
 =?utf-8?B?V3NoRUVSdkExb3hUeFJZaHlxeENtbDFxQnVHOS9rZTNuK3l0ZUJlNnJuMVdn?=
 =?utf-8?B?QlBMV2x3Y0dTTWZjMGovWTZ1UEhNK3FHcUR6S1o1WjVpOGd3K092WnhxbW9W?=
 =?utf-8?B?OS9HOVQrRjQyMlJ6MFludzJKRkhsTm9IYVhPb24xa1Y0ODRMaldpb3RuY3RW?=
 =?utf-8?B?amkxQitZTlBsWHpOSmY5c0xCQ3owZ1VJbWw3Z0hMenhWd2VMeDY1eFRJamhk?=
 =?utf-8?B?K2hkYXhJK0sxVTg2bEozRGN2QndPM3YxMGhNbjQ0MWFUeFhPOWhpRDhscExo?=
 =?utf-8?Q?VLbg=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(7416014)(376014)(32650700017)(34020700016)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 06:53:29.6765
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e586f13d-ee07-42cf-a099-08de1d0131b6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR10MB997614

On Wed, 2025-11-05 at 20:40 +0530, Manivannan Sadhasivam wrote:
> On Tue, Oct 28, 2025 at 07:15:58PM +0530, Siddharth Vadapalli wrote:
> > The PCIe Link Equalization procedure allows peers on a PCIe Link to
> > improve the signal quality by exchanging transmitter presets and
> > receiver preset hints in the form of Ordered Sets.
> >=20
> > For link speeds of 8.0 GT/s and above, the transmitter presets and the
> > receiver preset hints are configurable parameters which can be tuned to
> > establish a stable link. This allows setting up a stable link that is
> > specific to the peers across a Link.
> >=20
> > The device-tree property 'eq-presets-Ngts' (eq-presets-8gts,
> > eq-presets-16gts, ...) specifies the transmitter presets and receiver
> > preset hints to be applied to every lane of the link for every supporte=
d
> > link speed that is greater than or equal to 8.0 GT/s.
> >=20
> > Hence, enable support for applying the 'optional' lane equalization
> > presets when operating in the Root-Port (Root-Complex / Host) mode.
> >=20
> > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > ---
> >=20
> > Hello,
> >=20
> > This patch is based on linux-next tagged next-20251028.
>=20
> Just rebase on top of pci/main or any topic branches in pci tree if there=
 are
> any dependency.

There are no dependencies. I tested on top of linux-next to see if there
may be any issues with changes from other subsystems. Also, I ensured that
the patch applies on v6.18-rc1 as stated below.

>=20
> > It also applies cleanly on v6.18-rc1.
> >=20
> > Link to v1 patch:
> > https://lore.kernel.org/r/20251027133013.2589119-1-s-vadapalli@ti.com/
> > Changes since v1:
> > - Implemented Bjorn's suggestion of adding 'fallthrough' keyword in
> >   switch-case to avoid compilation warnings, since 'fallthrough' is
> >   intentional.
> >=20
> > Regards,
> > Siddharth.
> >=20
> >  .../controller/cadence/pcie-cadence-host.c    | 85 +++++++++++++++++++
> >  drivers/pci/controller/cadence/pcie-cadence.h |  5 ++
> >  2 files changed, 90 insertions(+)
> >=20
> > diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drive=
rs/pci/controller/cadence/pcie-cadence-host.c
> > index fffd63d6665e..ae85ad8cce82 100644
> > --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> > +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> > @@ -168,6 +168,90 @@ static void cdns_pcie_host_enable_ptm_response(str=
uct cdns_pcie *pcie)
> >  	cdns_pcie_writel(pcie, CDNS_PCIE_LM_PTM_CTRL, val | CDNS_PCIE_LM_TPM_=
CTRL_PTMRSEN);
> >  }
> > =20
> > +static void cdns_pcie_setup_lane_equalization_presets(struct cdns_pcie=
_rc *rc)
> > +{
> > +	struct cdns_pcie *pcie =3D &rc->pcie;
> > +	struct device *dev =3D pcie->dev;
> > +	struct device_node *np =3D dev->of_node;
> > +	int max_link_speed, max_lanes, ret;
> > +	u32 lane_eq_ctrl_reg;
> > +	u16 cap;
> > +	u16 *presets_8gts;
> > +	u8 *presets_ngts;
> > +	u8 i, j;
> > +
> > +	ret =3D of_property_read_u32(np, "num-lanes", &max_lanes);
> > +	if (ret)
> > +		return;
> > +
> > +	/* Lane Equalization presets are optional, so error message is not ne=
cessary */
> > +	ret =3D of_pci_get_equalization_presets(dev, &rc->eq_presets, max_lan=
es);
> > +	if (ret)
> > +		return;
> > +
> > +	max_link_speed =3D of_pci_get_max_link_speed(np);
>=20
> 'max-link-speed' property is used to *limit* the max link speed of the
> controller, in case the hardware default value is wrong or to workaround =
the
> hardware defect. If you goal is to find the actual max link speed of the =
Root
> Port, you should read the Link Capabilities register.

The intent was to get the maximum link speed that the user wants the
Controller to support. The idea is that the user will only specify the
presets in the device-tree ranging from 8.0 GT/s until the maximum link
speed that they desire. The Controller could support a higher link speed in
Hardware, but if the user doesn't intend to enable it, the presets won't be
present in the device-tree anyway.

>=20
> Unfortunately, the ti,j721e-pci-host.yaml binding has marked this propert=
y as
> 'required'. It should've been optional instead.
>=20
> > +	if (max_link_speed < 0) {
> > +		dev_err(dev, "%s: link-speed unknown, skipping preset setup\n", __fu=
nc__);
>=20
> Don't print the function names in error log.

I will fix this in v3. Thank you for reviewing the patch. Please let me
know if you have further feedback regarding my comment above on the
'maximum link speed'.

Regards,
Siddharth.

