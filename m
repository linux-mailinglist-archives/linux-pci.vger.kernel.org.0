Return-Path: <linux-pci+bounces-16186-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCA89BFADE
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 01:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 469CB1F2248E
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 00:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9B34A06;
	Thu,  7 Nov 2024 00:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MzXT7gP9"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2061.outbound.protection.outlook.com [40.107.247.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71FD28F4;
	Thu,  7 Nov 2024 00:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730940390; cv=fail; b=e3iXnTp2G1+21RoqF83VYHolyEuig63oUNYG2oDXJ+WlPJPQL4HK6T79D/mTgic4vWo2dQXDC778jWAFz6GpybckYLdWZoVx5dtbPZ012/lbDtQ0c2Faw4Lc/+rtYMdqQw6uFU7Nfrjcn0kNFZfzRGVii6tFLbEyn+f0VF2GjIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730940390; c=relaxed/simple;
	bh=9SEHQdjeH6ifkzX8RzLV99IewgpLi7FtusfNgFjO8Ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DJeJZx3/ag3FU4NJkgcJDCTp36hhHZcbzzUww9FlqrRUmU5UfUJq32DRlxqbmLjrU6uY2tsGtJSP4ke175P9V5GjdaaiQDhC9H6C7bnamv7A4Fxz2iysXAFcYtAG6ezFtlwnTGiYFNoK6WIMNhSo8qxsTkKjtLwATpgx5DPSdGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MzXT7gP9; arc=fail smtp.client-ip=40.107.247.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WEMpvDmjmyMJ2ZVKg9m1pmiSSO/sU2ACn4j5TW7VMSFvzyp24TavdjpPo/D2f0pwXV9XVzwQiIxbdIzkPJxCDnCeU+pFoaG/Mj3QXgjtNoAd3LGyEcYFDY2zXSZdLXflAexvFMU3T8Hfx4FAhCHN9z8gjknyCYXKYZegQF1JK0JAdkky6c9SESUTsjr4rLgDJ3hoEM89ttsTuuMYqIjpv9s8e09JntFqj1NWIV2JhzL29ClAJ7c/m67bLhJMPaZBDHAcHdBK73zeKIExfoeehu7Fw+kXiDeuMoiz6+GEWGb6xHj1UmN084sJ3AJZZztAHYeFguesnwBV9N2m+A7L9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zR/WIkdMMyiPuLy+X8CLIofW7mJE3vhsgKhoJvvjxw8=;
 b=FCLDPBYCSaPsuUgu1srWjS2R/w3RQLjG7Giy/UvJ92eQl2SleFSFq6Bb0xNfbuqsE/sgHU+gIJ+yiLbbWmgURM5TqmKWVkjQeSLp1V5AwMA7hZcDjLYA9Pja/ipOVn43vRIBMxKuHegvDH3255PIhuGqH8L31GpCkhiIfE36cGiNY6lBv6eIzur2WW3WI9b1X8nqn7UiYYEr22BNQsC6pqzknuSC+F79KM4RMmv32FxJN10Bc41+ZXFm5/Fyxz48vdUTeGp4o4asP+V532BXesr//sonPvEE3vE7xKh8M2CCXWyYbC9ZL2YjQ4sPNU7lbeuNLB6QfovHFPADns3dIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zR/WIkdMMyiPuLy+X8CLIofW7mJE3vhsgKhoJvvjxw8=;
 b=MzXT7gP9RhaCYFZIiAj/farKUl1pWhwmuSlYfsYIq2A/1x2JDyw29avSFvqoN6R1C078lJhBrgZSA9ZhV/L1gyqecKHnIsscNm32Ky901kAVqGjbs0q19PHAnpWRIsfB0mYJFbSj0TmflW511u81nUjjSknah6DtiDnA2VQuhXYGoozLs+Nc/PhXuUYz4IZBtajtme02lZBXsOqRSMwa1cdON93Rlq3OyuocbSi/bJeqWCpN79HorriJ0bjkm5uxJQ6TezvrUKFoHRqXczLhYwtGkMfyX5Luw9G4H/JiWudBpLv0U4pJLHyFTP2jqlX+Vo0QGVisECvPcVJJcGZzog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAWPR04MB9813.eurprd04.prod.outlook.com (2603:10a6:102:391::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 00:46:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 00:46:24 +0000
Date: Wed, 6 Nov 2024 19:46:16 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, dlemoal@kernel.org, maz@kernel.org,
	tglx@linutronix.de, jdmason@kudzu.us
Subject: Re: [PATCH v4 0/5] PCI: EP: Add RC-to-EP doorbell with platform MSI
 controller
Message-ID: <ZywN2GosYG4ERGW2@lizhi-Precision-Tower-5810>
References: <20241031-ep-msi-v4-0-717da2d99b28@nxp.com>
 <Zyszr3Cqg8UXlbqw@ryzen>
 <Zys4qs-uHvISaaPB@ryzen>
 <ZyujpT+4bd7TwbcM@lizhi-Precision-Tower-5810>
 <ZywCXOjuTTiayIxd@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZywCXOjuTTiayIxd@ryzen>
X-ClientProxiedBy: SJ0PR13CA0213.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAWPR04MB9813:EE_
X-MS-Office365-Filtering-Correlation-Id: ccfbffcc-3f66-46c7-a791-08dcfec59b0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E1UivctKaMb04FcFFpjywwEZJWdcDvLJmpKkqBVEzylg0rRJg/IHO3CJBd5r?=
 =?us-ascii?Q?jSabwjMFMCXwhDFMY6a+uK8T+fUxIeXBkeozAQH7pWySiN4Ad8/IQeGlR/9X?=
 =?us-ascii?Q?OwvRp0xtX0oV9HDYlZJolNQs8/0SOaGpwik8V1MPpM9uoSP5haL43hqO/rxt?=
 =?us-ascii?Q?5vRqR7ib/g4CIp/nAeHDB+VKDNy6MLKvVfSOAnXQfN41HR9Cu5K4GfLokB6O?=
 =?us-ascii?Q?3dVlOU96bhzOeqPXsvS62kVWIKwP2RPL4kdunuMWe7ivwlY72bBzFCrKRmiw?=
 =?us-ascii?Q?zY69G0VM4My2x5U9AoAIio59xGdU4nq8Cm4c8i1BFiYaInJ0LhvKUAWrX5AG?=
 =?us-ascii?Q?sqphEOqdYmLTWzhsYEaGpaVwHRx1syeVAlqm9PDqBl/AbXvO6awgtRHJM3Dr?=
 =?us-ascii?Q?xDA79/eM67JgmG6fGThEcfSHhq6ylbd+0iNwus8xFW0iApA7farzSM/h9rMz?=
 =?us-ascii?Q?n43HJrGyzE6kHYLL9J0omvgFUoCsX9vQp/m4LxNEkng5cnFF7IMIcz/wIvKs?=
 =?us-ascii?Q?hazYkpAk2rX1ljZu6kmcqd3OsLdqNWdy5JaMQwEJkQ0vMFz5GhVQnXnPBF31?=
 =?us-ascii?Q?9j3o+snoKPExWwQ5OCJPMT4voePIm0Skg2jNyStF9Idhg/p/wBKrHDbk82fL?=
 =?us-ascii?Q?AQ3VvCBhxlMJSuSQJAWDoHsDVLt2Nn9ntvV3ah8fPPi8Bd+MzbSCKujnfBGz?=
 =?us-ascii?Q?/ObLuLeP5n7ZKjNzd/MnCbeDTdql0UHkJIntSwivnkLGnHoPSlbOgDF/pVZa?=
 =?us-ascii?Q?g8Dy/Oco5h0lJOMPkrH3B/WUissfwi3c5n6v7UtPxjdPDHbsNeYz5fbYuvCj?=
 =?us-ascii?Q?lmLb3GleY5kdDRia9HESmW4Ca6h+3C9YnZWUW+oWlJM/DMiZc+k8oAYPEaMR?=
 =?us-ascii?Q?3p32Dc1nMGUtbnOSOGIRZpQymAFiQabH4ZiKsPoVhymDX615T4LVVreMrOFb?=
 =?us-ascii?Q?ygyudtgVQWRVGtqTdoTMJ/OI444O8v+DApj8Cmm/4NygLSFF5WbPMG09M5FL?=
 =?us-ascii?Q?mMr3ckuVpCJy/i3JUb104uKpRax/DlPFmzIt+1lYuj5JPiYzWLLvXVVVAQeh?=
 =?us-ascii?Q?t6lGyj7EThJQPAnYW8USuaEceB1eaVc+XETXM/VK3refANnKFIvDlxFtDH7r?=
 =?us-ascii?Q?KHojod9TODtU2rxH9DWC8YgFtLfNbvnT3SeS3WPdh+OtvxzXY7wZC1u3od6R?=
 =?us-ascii?Q?xyq2EFLD9PMht9vAxWCwJGhIdXKvwFp/G5ELPwaMBkIx3BUpUsSGzY2mJWHE?=
 =?us-ascii?Q?TIklrbPClnsQc7dl/B3fz49i2JIEhiA0VQ/LPfBaY0qElvjrSO3cmO57TSLe?=
 =?us-ascii?Q?SYlhl96qlO4Y+DfWWykeKhxY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GEri33xsfLf7OP+d1B6SezIKSiNOx11Q+R5W9XiyfetqRl1WvqScOAcLYdXf?=
 =?us-ascii?Q?OWAdSzo5sNN0jAA75lV60rWWZI/5qJO39Oc/rW5P+MQKW2wQRR5GYYxW5fh9?=
 =?us-ascii?Q?dobV74vhUL9YX+j0nEud+WHDHbYuYQNbGgituMDJDx5h9bgOInCYfD3m9ilj?=
 =?us-ascii?Q?87BGLJMRutY4WYehW26mk+Rq6RHQQDNzZgWJoAIoVtneg8S/e8MD/ByFaAjp?=
 =?us-ascii?Q?cfcTSaIawT85GYt0xmT6HKBTuRb44IcejO1jBpUMPKPObr5QZgeQyoUvJGtI?=
 =?us-ascii?Q?iHXyT8LBBlO9jHjiMGN0VT68FlA6kumT31xXyI7+MTFads3/wV6Iwg+pOlmN?=
 =?us-ascii?Q?I/vLdnDlY3cVelicLnREIs0yO5cWahy8+jcHXIJ+07H9LSHF0BJ/FomI2fML?=
 =?us-ascii?Q?2R8lhwS8gpiDu4QCMMkqv/78zFmzZo4Wg7M5vk5C5dwggYTJdHKz3uphyG42?=
 =?us-ascii?Q?koUQwAQbm3bh1MVulHCqSCZAUp4WWZwBhAUlKakQTB1oWBo5GuZOhDwvB9R/?=
 =?us-ascii?Q?gGVBYJz8GxuZxMmIDCv+8JffNiqEYt4UrjriW+W39pOX/5YshWhq2+fLi8VS?=
 =?us-ascii?Q?HGp9saCZxalAgWE8WNrS9SRvHekAWS4YsH/4IG0sSUW3mBAzXWZFYZaDx0VS?=
 =?us-ascii?Q?QcXNzvxxkWYrfBJYehue54j0LlOmiaQOm/X7PLcIhvQrXUKTl9D6Y/vDHHdY?=
 =?us-ascii?Q?jMIrYwMzcF5EntwC8SGVRtyMOJFY7LvR3jncuZO0hyUHTrAFabu+rrbeDrKV?=
 =?us-ascii?Q?Q8qbIMfDbBYX8vaRO83jstClvPm9eAF4qk9S2inTAwlmK2llcAjzeV1SrJPG?=
 =?us-ascii?Q?+mrlpYJCtISu3MquTdJ76GH7AdLAoUknsbPYrz7NiRo6eMvk45C4+yxo3K8n?=
 =?us-ascii?Q?w5dA4+R92vTGyveJrTmmZY5jMBMnXmViCn9rkNHkw6FPrvu7KrbEcdBbz2Uu?=
 =?us-ascii?Q?dtUVlU9qH9fdIRZ6odMoRHO8l0Xma+fKu08aplTm8GGQTNnrLMFQiF1qHQrt?=
 =?us-ascii?Q?tovQ1hHiienL8xpSlWpF+QzzJD3vfTk+gMgFeMsxPnl4lDLq2Cz3gKOKtTxA?=
 =?us-ascii?Q?MTy9ixJZnLp2KAX1UijuLBDXTIEGWozy//4aMZErJYCPJCu+QMa/sq7N23iu?=
 =?us-ascii?Q?ZSf/heBUFgm+v/kO3JGl4aQgFQHG877BE2pBeuqd1q9xnUKV3I30Ev7seZ9f?=
 =?us-ascii?Q?XfNv5VovkzaPY55ei/zRUOPwD8T2sKZXcw1bFGUt654AAjuNEMuIv2EcG4Jl?=
 =?us-ascii?Q?7yjlXEDUtC8qsMblbqIJZNj+AF6dEcQIMLHYPeVMfwZ5/LPyrEymbBbqNtYA?=
 =?us-ascii?Q?dCCg3MgSLrU/FjqQtNJQ1zO5HeWaFNNUjVdSxHcWJHGzZZNBhgTFGtt3ZlDP?=
 =?us-ascii?Q?uRQCtZLt/0O3zN1mfgq69QrhgtB3BDBlBi6GpakS//1TCVjA++pF08ZX5hyZ?=
 =?us-ascii?Q?63EoDNRf95vbcMEfAJevFLMZ//rsZEgOTjYsWWxgILmfTrHMT84ZZlSWDsit?=
 =?us-ascii?Q?MSipGGJkxpgsYT9vl/zpBfJSUbZpZLteD909aSVdUG24sHnfrFZpPcbAC0xa?=
 =?us-ascii?Q?o1c47ABp8vFQ7nffoT4eIfaGLaBd/7tEwAO1sr5N?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccfbffcc-3f66-46c7-a791-08dcfec59b0c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 00:46:24.4003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bjcZKudSqd9NbRaEcKb+cBCj7miy9/iifDZJ2nOvCvTjPr9i2lQmwrxfV6jluxu1qtSdnobPx8RATHsg/MBh0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9813

On Thu, Nov 07, 2024 at 12:57:16AM +0100, Niklas Cassel wrote:
> On Wed, Nov 06, 2024 at 12:13:09PM -0500, Frank Li wrote:
> > On Wed, Nov 06, 2024 at 10:36:42AM +0100, Niklas Cassel wrote:
> > > On Wed, Nov 06, 2024 at 10:15:27AM +0100, Niklas Cassel wrote:
> > > >
> > > > I do get a domain, but I do not get any IRQ on the EP side when the RC side is
> > > > writing the doorbell (as part of pcitest -B),
> > > >
> > > > [    7.978984] pci_epc_alloc_doorbell: num_db: 1
> > > > [    7.979545] pci_epf_test_bind: doorbell_addr: 0x40
> > > > [    7.979978] pci_epf_test_bind: doorbell_data: 0x0
> > > > [    7.980397] pci_epf_test_bind: doorbell_bar: 0x1
> > > > [   21.114613] pci_epf_enable_doorbell db_bar: 1
> > > > [   21.115001] pci_epf_enable_doorbell: doorbell_addr: 0xfe650040
> > > > [   21.115512] pci_epf_enable_doorbell: phys_addr: 0xfe650000
> > > > [   21.115994] pci_epf_enable_doorbell: success
> > > >
> > > > # cat /proc/interrupts | grep epc
> > > > 117:          0          0          0          0          0          0          0          0  ITS-pMSI-a40000000.pcie-ep   0 Edge      pci-epc-doorbell0
> > > >
> > > > Even if I try to write the doorbell manually from EP side using devmem:
> > > >
> > > > # devmem 0xfe670040 32 1
> > >
> > > Sorry, this should of course have been:
> > > # devmem 0xfe650040 32 1
> >
> > Thank you test it. You can't write it at EP side. ITS identify the bus
> > master. master ID (streamid) of CPU is the diffference with PCI master's
> > ID (streamid). You set msi-parent = <&its0 0x0000>, not sure if 0x0000 is
> > validate stream.
>
> I see, this makes sense since the ITS converts BDF to an MSI specifier.
>
>
> >
> > You have to run at RC side, "devmem (Bar1+0x40) 32 0".  So PCIe EP
> > controller can use EP streamid.
> >
> > some system need special register to config stream id, you can refer host
> > side's settings.
>
> > <&its0 0x0000>,  second argument is your PCIe controller's stream ID. You
> > can ref RC side.
>
> The RC node looks like this:
> msi-map = <0x0000 &its1 0x0000 0x1000>;
> So it does indeed use 0x0 as the MSI specifier.
>
>
> >
> > >
> > > Considering that the RC node is using &its1, that is probably
> > > also what should be used in the EP node when running the controller
> > > in EP mode instead of RC mode.
> >
> > Generally,  RC node should use smmu-map, instead &its1. Or your PCI
> > controller direct use 16bit RID as streamid.
>
> smmu-map? Do you mean iommu-map?
>
> I don't see why we would need to have the SMMU enabled to use ITS.
> The iommu is currently disabled on my platform.
>
> I did enable the iommu, and all BAR tests, read tests, write tests,
> and copy tests pass. However I get an iommu error when the RC is
> writing the doorbell. Perhaps you need to do dma_map_single() on
> the address that you are setting the inbound address translation to?
>
>
>
> Without the IOMMU, if I modify pci_endpoint_test.c to not send the
> DISABLE_DOORBELL command on error (so that EP side still has DB enabled),
> I can read all BARs except BAR1 (which was used for the doorbell):

If you enable IOMMU, please double check pci_epc_write_msi_msg() pass
down iommu mapped address. I have not test iommu enabled's case yet.

Frank

> [   21.077417] pci 0000:01:00.0: BAR 0 [mem 0xf0300000-0xf03fffff]: assigned
> [   21.078029] pci 0000:01:00.0: BAR 1 [mem 0xf0400000-0xf04fffff]: assigned
> [   21.078640] pci 0000:01:00.0: BAR 2 [mem 0xf0500000-0xf05fffff]: assigned
> [   21.079250] pci 0000:01:00.0: BAR 3 [mem 0xf0600000-0xf06fffff]: assigned
> [   21.079860] pci 0000:01:00.0: BAR 5 [mem 0xf0700000-0xf07fffff]: assigned
> # pcitest -B
> [   25.156623] COMMAND_ENABLE_DOORBELL complete - status: 0x440
> [   25.157131] db_bar: 1 addr: 0x40 data: 0x0
> [   25.157501] setting irq_type to: 1
> [   25.157802] writing: 0x0 to offset: 0x40 in BAR: 1
> [   35.300676] we wrote to the BAR, status is now: 0x0
>
> status is not updated after writing to DB,
> and /proc/interrupts on EP side is not incrementing.
>
> # devmem 0xf0300000
> 0x00000000
> # devmem 0xf0400040
> 0xFFFFFFFF
> # devmem 0xf0500000
> 0x00000000
> # devmem 0xf0600000
> 0x00000000
> # devmem 0xf0700000
> 0x00000000
>
> So there does seem to be something wrong with the inbound translation,
> at least when testing on rk3588 which only uses 1MB fixed size BARs:
> https://github.com/torvalds/linux/blob/v6.12-rc6/drivers/pci/controller/dwc/pcie-dw-rockchip.c#L276-L281
>
>
>
> You also didn't answer which imx platform that you are using to test this,
> I don't see a single imx platform that specifies "msi-parent".
>
>
> Kind regards,
> Niklas

