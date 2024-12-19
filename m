Return-Path: <linux-pci+bounces-18819-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 540229F8659
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 21:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FC3916CCE6
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 20:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF881509BD;
	Thu, 19 Dec 2024 20:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Dc8Blj6k"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CBB22612;
	Thu, 19 Dec 2024 20:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734641650; cv=fail; b=at8Z9zuvRbxVvSJexGjeLDkRlDrpeYkbo6I7akkbDy0tD9vS75X7nzBzjAxIBHwt9hEt/sPRfyxIYhEdI1cxJnqJBlvvDgSuI4AbUkKePsIxFD2DtrbiFMHOajyDhbyVhNvFhmMllbsoYnxw3nPG0ZfTYt0vC0erjqwSsRiH8nY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734641650; c=relaxed/simple;
	bh=bUoZ2jjqS5qwFCmsSe5h68wiZT4ncLI3/LFFStBzVI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UAcy+jzY6Dck1nrNa6tBH2VWCok5EohruZrR927R3LGdF4QoKoHn8rISQvX8h5kVvHrgY8c8FfU8AVJPX5H09kpbynxc3C94Y5sBTtfH6H8jMfc0BFVseO1XLX9/zTGv+uowHJQIPEc5NB6cB/UT/tIVsLyogHU7FUVRlpHx/zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Dc8Blj6k; arc=fail smtp.client-ip=40.107.21.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BXi4chNkX9NhgrF+sjmUZfccnZ4eTDskWTi79hDiCv0KDM/IC1earBjWchlqJ8cz5kBRq11OSlePULD1r9Zscwrcn4BvSzyvxvaoQtVK5tKnDKDfqBNGYIEHQKSRWxBzjjnJnJDisUlLuPRlPjI3lyQEAkAYI6fCMd73aHgJxFvFOLvVr/t965kWXT2LcoyiUZhvK0uf9qMXyM5t43z99dEzuVCwB9iHHa+7QhKSNTyIwWViBomgjaF6Il3AnRsOGHJVUPFuUajRgtop+MR5MfYAgNDZmmtUXODzy+KzEKh3zqCbCpngy7JxoVzR81j4eJlvUZpSg8FiYWDhGOiXQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUoZ2jjqS5qwFCmsSe5h68wiZT4ncLI3/LFFStBzVI4=;
 b=iZFLvzrstPPMkPGqxtd3Dy/JOBOxxKlDEMDCFmHxONuGiyjlj4rQm5rx7i81oOjmjFKlNju2WZxDy5MvSmTPAnT+h6L+IliQpzlY509hd1JY/6XnO6pcEA8QenDrTCiKa3krfRZxgoJ5aKwScf5ULbnwM04cPIDoqdC6shusI1Bo12GG8n8Jk+8M8zzLMUZOyd70cQGK5msITEMZhLgwb+KxWTzGAH27D3FVtds77s3GrhjKHtzLeZql6kp85Nyq7ndpCslGEJFQRXu+zDxz78nONNCw3pITxallvc1Kol1mt4oPrmh8iLaDpixkX1imq7lSC8n0bYaPgHYpq69Z/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUoZ2jjqS5qwFCmsSe5h68wiZT4ncLI3/LFFStBzVI4=;
 b=Dc8Blj6kCgx376TrChk0cs7hXKubY9tOFnUZAa5+AvMjmcAP+TbJS9hoFSVLGCrl+Jlb5pw0ERsnF49GMqceUmgw3cgBXTOPS9ocvXmur0S+UQVL62tfJ9GqLvMEmnVhYG0R/BP97axwigMqNrnvI6L/3QoYMo47fJFTQ9Lv289Ygp4ARuAJl3IKyW53gUM3C2GO8svQkCXREjRNBpY8hKED4MPiAIH0EeJ1hgKdVfOLuGa8brC5cXrz6G/LLUfP0oiOMyaCos4u3XNRovwCa3bibJlh32mWitSEpyzARNc5mLJ8L9dUarQP8hvGar6pRGeB7W9gnfHnnXLi5tjS5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS5PR04MB9855.eurprd04.prod.outlook.com (2603:10a6:20b:652::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Thu, 19 Dec
 2024 20:54:05 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 20:54:05 +0000
Date: Thu, 19 Dec 2024 15:53:56 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anup Patel <apatel@ventanamicro.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, imx@lists.linux.dev, dlemoal@kernel.org,
	jdmason@kudzu.us, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v13 4/9] irqchip/gic-v3-its: Add
 DOMAIN_BUS_DEVICE_PCI_EP_MSI support
Message-ID: <Z2SH5I/5oAHkNxS3@lizhi-Precision-Tower-5810>
References: <20241218-ep-msi-v13-0-646e2192dc24@nxp.com>
 <20241218-ep-msi-v13-4-646e2192dc24@nxp.com>
 <868qscq70x.wl-maz@kernel.org>
 <Z2RRimPlT41Ru281@lizhi-Precision-Tower-5810>
 <Z2R9qPmAyTcc5mtg@ryzen>
 <Z2R/S4y3fF2Dw4Ye@lizhi-Precision-Tower-5810>
 <Z2SFYwC7KC-qiZD2@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2SFYwC7KC-qiZD2@ryzen>
X-ClientProxiedBy: BY5PR17CA0010.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS5PR04MB9855:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fbbc5da-e778-4bf4-9ac3-08dd206f464f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AAorejPBs0wL0Zu739EyV8LiugRlEPXsYQsk7KlQVnKyWUWxr2WQx+olpUeS?=
 =?us-ascii?Q?fEcNASy8dgNMvDGxhUpIZLASOW6h+lPYbjAa01d7xKm7N+Uq3MCwxTn26qq5?=
 =?us-ascii?Q?ksjz9Owhf7GyM9kSThJ7qPbjvf+ANBXTsKz9heJEZbFSZTELqDavNz7XTe07?=
 =?us-ascii?Q?rf/3YSgi+l+sJEKuXJclXGd7mQDuVATYjhxB8eKbPpAEZiETJJcr6Evhf/vB?=
 =?us-ascii?Q?hiyO1eLPwou0PfykoUR08d8tG9khKQwybNQSC5bfLImPSFAmyK9w1NJUa+/b?=
 =?us-ascii?Q?fY+suNHTEiUs5FW7ycHHIFFPrgxidkxwDQaep1x6AA5Am2KLZM5J/mGFCoKR?=
 =?us-ascii?Q?nhgK5j6hhqT8tfrp8GMJ9ReQr09pmngwDzkS38WVDT1MquQjuMnaOzcLFV8g?=
 =?us-ascii?Q?NTZ88B3vUV2FH37IyA/HyndJMITinLXbsxuqRibzvjY6GExShzLWfUxw2JE8?=
 =?us-ascii?Q?YvDEDv2IHowwBtm5z8Vrg1vF82IKs/EbfYa2cLTbl1tOnbmABna98xs9/8+n?=
 =?us-ascii?Q?ScU+X+hkTmYbvIh9p88bFNZM/PQdDU/JSqinIxYXTNauXwmzTETZl5+ltsnP?=
 =?us-ascii?Q?SPW75IdpehN6Fm2DEOKFEc1ZagQ1M8MyfD2U/RCiyLjPz/ouNk8Ddgrx2QRA?=
 =?us-ascii?Q?7VmIEPDKIySZFZ22E66fuCdD9IuDqt5yz0OA4JQNvjxLjvZT2HnCPpKsmsUn?=
 =?us-ascii?Q?zQUtLXwlm/SA1pO2hf2v32Pw+ZabNydIzZpJrhSz5EqBL0x0Q6SMMBoogN9t?=
 =?us-ascii?Q?UUlcqqPG9rhp72u7dHDg/941c0zfZCw+G3xlfYXUMkz+Y2dTIuD02oQxe5G5?=
 =?us-ascii?Q?PUaBbvL9mpj9popozupdJ0Lqob00lonMtMwLSAAJXAAzpaWIBjPmIeLnyEEf?=
 =?us-ascii?Q?7mddzHY1uI6kkzkviCw/U2Izp3olyqqrlCxfbLs3/9jU39i07lF861qC5S+f?=
 =?us-ascii?Q?it66uXWU1/4dHoYOPTzoMcM9bxdxqWbIfBqbkXHGiqGsFGFhT7iWZB+oZt22?=
 =?us-ascii?Q?+/Hwq5GzvM1YzTAvkdpg+33nYyjhxLbmm6NbPmjp4rTbz8ol+dUCdskxPjFM?=
 =?us-ascii?Q?x1cmwQnUnGdDx8J9fQkE/7uDExAaIF6b3ZWtaSLVcB+FvOiTAyqMgrgR6but?=
 =?us-ascii?Q?aeuVMYez2+pE3X4ywJSNMxWvgAxmjVwmW5JCV8b+d+LfxRy6j/ffAhW3Qesd?=
 =?us-ascii?Q?+ujSOqd20M0A+7WwMlOs+r93XyghjEDn+5+BAHcOIFcA6YF2EpW0CjoQa570?=
 =?us-ascii?Q?yOlk45Yb2sg4kWcVK8Kd16Ib1gGdPHJWvISaRpXZokhuB1iwnROr28hduKWp?=
 =?us-ascii?Q?dUKEjF9AiGxFbCPmRQCKSHuSy1AvrLivGdyY6t9iPljRxbF1hDT+D4uBKgZi?=
 =?us-ascii?Q?UuKdyTknmz0BBXUdcZ1q9+8JWXZtOBituZPYjAcjSVG21Jlch0w/7nDXPdqa?=
 =?us-ascii?Q?R7cZkeLfSLVbWj0BOdOaMKsY3uaNytDm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ptGyd7nYee9Dv2CeL9cQp7xQ+sjbn8IDw0fLMwl43y0NiEmobEiT2qw9+Hfs?=
 =?us-ascii?Q?e9lGzgapiizQbEtMvApQ2wEGyT1KPO4CSucDOloo9Q8HFclOtrDk5P/y/iEX?=
 =?us-ascii?Q?4bo/r32HB3IsfQ7yV4zkFxkUoT8AL8VyPm4VEQTb+NbwWVD9oIcgDgrnbnD+?=
 =?us-ascii?Q?Rl+dkh8giwPu2tnLmdE6W/jJMJ22wP1ZqZxupC91h249W3wz9Bu8jXbKRaW+?=
 =?us-ascii?Q?5gZ16CXP5Ihx8oEnil2dqpLWukoe0TeKDXaMkNB4i5BWZ7ap2GZ0H4D9h0BP?=
 =?us-ascii?Q?AZ9ciNY9ugy9hWRNzuuEWB1N/NwP14G9uDEyd6PDIHm5kxXN67O1DfbEVB0M?=
 =?us-ascii?Q?Yb7jggCSJRa+EDO2nqBFtZwjjFJB3S8lAOK0u06zBVc8bwIYNq7X0FofWE2E?=
 =?us-ascii?Q?hI7ky8sDNrVbbc2HgnYB365xfN38Izk2NgV1XtsE0880UGhZrdRAfY4S011Z?=
 =?us-ascii?Q?ZkO6g2oSo37lg/B/q1ouIyRziIoDrQpXxdErmv3RNogV9ARr6jCAAHb2XGer?=
 =?us-ascii?Q?OyJUbGFf2qx3YNykqwxtyKq0i0H/gQz6qLEDiOmAwzi50C/C8wx/uLpZy3pI?=
 =?us-ascii?Q?ln3Sngn/gWTlIO2iXoXEJwUy1WmbJ5JdkUWv4QUnbrtqgXAke+dOpzU9Rcls?=
 =?us-ascii?Q?nDfPeBUzqYL6ayV8QR4HeXDQ0rprjGA56SLEVT1ojNKPeY0k4Cb3/sX70yOX?=
 =?us-ascii?Q?xLmtx0aWAUUnFdBYJZ3vXOWIlmbVDqKhVRJrXocI03ABx7efOesamTOleplF?=
 =?us-ascii?Q?YTtxp9kOekq06jq/Jy/uaxqoc/Pl6nTYt0++L+GH/IzHSQEcWEbaXEE5gvTQ?=
 =?us-ascii?Q?YsCFoGhshyLvrFK+CIKDGeAax9PzT6gzcYMTOhxRkk6c9QwZlf8gu4TLDkfl?=
 =?us-ascii?Q?vWKHXZYPd4iKeIrfgPC6CIpQfS0wMuFz7sstnHT5/R/8jc7Wo9Pg5je5Hn67?=
 =?us-ascii?Q?N5hJjrtEs0DKZtZgKt29Ne1wJHlTvNsILHfRLV+TR2k8lAYLIHFQTZIxlL3D?=
 =?us-ascii?Q?1NDPvMyBWcCfbZkaWlnln21yrFzRSYWcOB7wToRkgvSbys0j1GhHNFF4VqhD?=
 =?us-ascii?Q?c4jBSUeQ1gqvcHwKiVmdjVr5FjNnlCgHc1XUgyMdvdA/KqqY3Gk8K2ZsOu2q?=
 =?us-ascii?Q?GBJyhLIScbTXvX3bAWVezja7FxCIDiU8k1vMyZSDyKBjgIiIr7/VXXdOgyie?=
 =?us-ascii?Q?oFcLTvY27HupVkkJUcSRz0ZFBAI5/YMDDboGzCv9o7WwFOPgwycXgCxOEVMs?=
 =?us-ascii?Q?YBgWsbbAf7Wf1VSJbKlvk1VcsHUHhJRrQt5irpL+bg43pQ7CxV0SemEuDJIC?=
 =?us-ascii?Q?jVTBNTP28HNHdkb8bNDSmmuwfrl0D+sGrFtE7oOa0ttGOC9oc0iraa48RfPT?=
 =?us-ascii?Q?XlkOA/CM/VAbEYLOvSgFY9TbXyCNfUg/ozaoNxThoFa6KzXINbiOZbh3hCLv?=
 =?us-ascii?Q?iayPTxsb9IlHB9BaZzIB17mCpcZ30nkUKwy1Pj+clF405IBW+s6RIrmVUQjl?=
 =?us-ascii?Q?4W1a29hUVx/Bk+i8EBRl4Sbz5fNtipMM+h5DQbUNRa7+i/l4qobNe9aIhvom?=
 =?us-ascii?Q?yK2QqapXryfG1oQW0L4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fbbc5da-e778-4bf4-9ac3-08dd206f464f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 20:54:05.0792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PreWJyL7hebVOUhwpdtWXqOTvR/qoi3t2DVTuqSUWqTSBHm/epc21mUljLQC5utDlw5IIiPFld/zJR+yZuHHXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9855

On Thu, Dec 19, 2024 at 09:43:15PM +0100, Niklas Cassel wrote:
> On Thu, Dec 19, 2024 at 03:17:15PM -0500, Frank Li wrote:
> >
> > Thank you very much. I update msi part, so endpoint controller node align
> > host controller node.
> >
> > It should be
> > msi-map = <0x0000 &its1 0x0000 0x1000>;
> >
> > So if your hardware support multi physical function, your can create more
> > than one pci_test func. Previous version only support one EP func.
>
> I see. That seems like an improvement.
> I will need to ask Rockchip maintainer to drop my msi-parent patch for PCIe
> EP node then. (Which is currently queued up in for-6.14)
>
> However, for the PCIe host node, rk3588 has:
> iommu-map = <0x0000 &mmu600_pcie 0x0000 0x1000>;
>
> For the PCIe endpoint node, rk3588 has:
> iommus = <&mmu600_pcie 0x0000>;
>
> https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/commit/?h=v6.14-armsoc/dts64&id=da92d3dfc871e821a1bface3ba5afcf8cda19805
>
> Is it fine that for the PCIe EP node, we specify iommu mapping using:
> iommus = <&mmu600_pcie 0x0000>;
> but the ITS/MSI map will be:
> msi-map = <0x0000 &its1 0x0000 0x1000>;

For doorbell feature, it should be fine.

>
> isn't this a bit inconsistent?

Ideally, iommus need do similar map.

>
> The physical function is the "F" in the BDF.
> Does this mean that:
> iommus = <&mmu600_pcie 0x0000>;
> the IOMMU will not be able to distinguish different PCI physical functions
> from the same PCI device?

You are right. All physical functions will share one IOMMU space.

> So two different physical functions on the same
> PCI device share the same IOMMU mappings?

Yes,
Function should be okay. Only miss isolation protection. func1 and access
func2's dma memory address. At most system it should be fine.

Frank

>
>
> Kind regards,
> Niklas

