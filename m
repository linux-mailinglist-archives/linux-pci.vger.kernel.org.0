Return-Path: <linux-pci+bounces-18815-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D38A9F85B7
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 21:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFB7C165EFA
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 20:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A7A1EE7A8;
	Thu, 19 Dec 2024 20:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WUmiGbva"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2052.outbound.protection.outlook.com [40.107.241.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28451A0B0C;
	Thu, 19 Dec 2024 20:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734639450; cv=fail; b=NJyutc3p/gpc8NgAIFDs9N2+pKl9qOFsBv2rXGpqgIw1SZEIrxBYl7X1Qh7+E0SdLXsSZLGDyQ+jbTIxz21rH1atq+h/ZA95/MSUfP+vbUDTmWrDIWui/+ZmeyX0pSyinCPvZxUK5D1+ASME+EFrbl3YR0/spNIuA/OlF2i9Gkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734639450; c=relaxed/simple;
	bh=Uy+sLkGeX8Wu3vUrJqv7jkNLSoS/kddcLcOnOOrgjF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pvjGeIyME/MJwLChNG5WmMCQjUYaku7KWobwe8Ywdpl+U9ftg3aEM2Qu/sGJg6fUL5b1yWVuCZAC9CdfEivE/mLHt1eJROhKbaifD8JwHv7jbEH9d7JTr5LtObrUFhwfF1otoM0IN2THlDV5ImBOjqgQhsaCtE4Y7ACyFNXAgnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WUmiGbva; arc=fail smtp.client-ip=40.107.241.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t0QjC0YhzUwGJsGkLIN0g26C0Cfre/Rj8KToIK9mZD22dxIq62ZqC2bHlhPZ9wbLYRSg3UxgFbyN2dn699ER0zIJui3c7VFQm0lXEiQms2S216NeAqB1sfcTI2UDXBOaFPENCqCEr4jsXW7NUcBI+bT7/kAad0E8kzsoO8K1qkaKi8o0Sra13XcSbiyvkgFg8GiLfWEE/9Eg+J4am3BIxyhFY7COFUzu9MINdI52ZDE+DIaIrsM9PiwiCjWc9Nx2Qoy1eYfZuLC7Z5+yEKm2lBKmIvCVoVlRS8oYtSNQ0VWOLZhktEgcWQKOELT91fJozq6W5HnJgonXSSp4u0YHow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egJIARN4UlWDk2dNsqBGO74iQI0iMW2qA1k8xamz8OY=;
 b=K02jQU3ZqhlwAi5Q3HR2A/iXKh6DpUB8FsuOZUy8kwdfMlKeECsvXwQgRSMnAp0h7B8lEvYoSdmDGbj5dYJrwHhGnFUZJwKNYr55tPgxvG0T4S2TKrRJT5/mPwW2ZlJuHChI+DzTIExwJHiZPDEhoczkTSrdeAgYpCE3a2EaKYQt3Sqlu+AsG/9jvkNDPYixtWwfcaNpA1gB021k6swPV5MMMqgC5pqcxFimtL8txdVjaUEXHtf1Vr88V5zE1wcNAgtsLKilYeYgoVxrjY9HQYwijNposoln3YIgXeaTTIYpA3PorZTXbwEaqzm427UpyzPdWlxgMOVWqOXGDmt0cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egJIARN4UlWDk2dNsqBGO74iQI0iMW2qA1k8xamz8OY=;
 b=WUmiGbva6VBLQVZZCeeYSAl8zwnN1ZWz9lsrIh1nPPKnfpm9KEDklMeO02zZTnC+Cd1BxzhMwTKMnydHl+z/Fz9Pfbu48tlrUtxEjLmBElJZyg22ozFyKeqtBO5EpN+cLJ0zrQALjWEzuDRDLh9gB0tnb1bMGz9IsrH5H5UDd+QflqsagjdR4+5M/PHEdQqVwx7cgc8ZkdSy5cIGD2pyaEo5BOW7pe/pmsaBfPUZSp91UCZKRWnzgFPwYhXBqrQCX1OmtLzV2W+svqhH5cVa+X3q9wTFa2kIuQBvNVszRgfhcqu5E1yUcOxIN9KRsNaCOUU228DKKtcua8+GzLpE2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB6936.eurprd04.prod.outlook.com (2603:10a6:20b:106::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Thu, 19 Dec
 2024 20:17:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 20:17:24 +0000
Date: Thu, 19 Dec 2024 15:17:15 -0500
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
Message-ID: <Z2R/S4y3fF2Dw4Ye@lizhi-Precision-Tower-5810>
References: <20241218-ep-msi-v13-0-646e2192dc24@nxp.com>
 <20241218-ep-msi-v13-4-646e2192dc24@nxp.com>
 <868qscq70x.wl-maz@kernel.org>
 <Z2RRimPlT41Ru281@lizhi-Precision-Tower-5810>
 <Z2R9qPmAyTcc5mtg@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2R9qPmAyTcc5mtg@ryzen>
X-ClientProxiedBy: BYAPR11CA0039.namprd11.prod.outlook.com
 (2603:10b6:a03:80::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB6936:EE_
X-MS-Office365-Filtering-Correlation-Id: cb39e1b4-41b1-456e-dee4-08dd206a2685
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wDKbECkwJxzKwbbrAksfO8P5S5rpKQy+ZSmei0MbyG/dFwHafOgE67GOCoS4?=
 =?us-ascii?Q?14l7LGFESTDZUv3quce7lsMaPuJ/txa9zgB71qoE/2+iBXh5XMrztDtYgNdK?=
 =?us-ascii?Q?nAb+5Kga4oou7FokCfL+dqGLn1QPloAJxe0HSfKAw3wVGG3JEsFAwHYtWKAF?=
 =?us-ascii?Q?BjDWXFZ6rLEs9wVuFKnk3FQXk7WCoXwmbU87L+W8BLy8dFx+TguNbzCuUgz3?=
 =?us-ascii?Q?QmGS4AR3XQB1u78KrPg5mLyEDon+BdGQoWOfFYkfyt+h8SbBHrInSeFeVxH/?=
 =?us-ascii?Q?EbxY2CaIRFMbaLlc3FavQB6LNlStnWHF3rwK8x8Aajjhemqcnb7/srjmtjIQ?=
 =?us-ascii?Q?x1o0q34vLe4Z7So9ndMe172QnDsG6+R5cPg0pBykE4Tw91mBvOpKhGUfQFBk?=
 =?us-ascii?Q?ZjHLYlp5xF8KxB4dT2RG2oeQwa7U0Urq/GUJg5+UWqkRytzqTLi6SSttrvoh?=
 =?us-ascii?Q?smnwPol/BVvfeo7DCpM60p5iIL1FGuRYCbkjOLySJLsnqRK7qU52CdKvyf8r?=
 =?us-ascii?Q?+GluNMVtLiDhkzy7pQK8PPTxfDWxRXBobXE+r8IWOBUy21Q60MVec0Fxb+03?=
 =?us-ascii?Q?7NLh/1TiAfIJW7yuG5iY4/sVv3IJ5LvbvR8moEmV5ekgP1JKuJQseVmCpINh?=
 =?us-ascii?Q?VctDh5nInFGUeAw2MVTpnHDogAS2C73jsPE3Gb8+mjak4EWLWcZEQeAnUuVa?=
 =?us-ascii?Q?mJ22IrJxqecClTpevZSfgUuSK0O6StBCdAB9b5pQoNp2TBxUxzXJMBZCgG2Q?=
 =?us-ascii?Q?E1vjRC/x/YoSnrRmzUAIiYqGySMP3F8lSqziBm6x+k8hDomb2UeqRglzQvRg?=
 =?us-ascii?Q?whbKsKffCghgyj6szp7DB0fAvp6QIxPUQ363Mwggx0205g5y/3imNystPhoN?=
 =?us-ascii?Q?P9HlIWEZsNEM7boa3JQR0q7T7QfbiK62kYFXoljr2Bfq3+QY2EUmvddxj1PD?=
 =?us-ascii?Q?OwWg7WFm1fNfNYSWnh1bxWgEdcw4ZaVD8iNkIQJbfHyT5dcttTCC3v1Cr36w?=
 =?us-ascii?Q?sGRu/yojCLgQS7o4ngURc001bSeYuNVwvTIF8chi/ZHC35St6oRh6Y7o4t5j?=
 =?us-ascii?Q?295/f/uEF6SLSC/L3GpqAD8ZTpRs0L2dUNgEtLGo0POn5MHd0LyKj1+eExFS?=
 =?us-ascii?Q?3JyK8/G9C/OuHMBKk+PXdOSIGrAtqVdv7WjazE0UZShpGsdW3X7YjF67muyJ?=
 =?us-ascii?Q?DY0TuJszF/1+Lkd236CJxdIIDhmrYUUWyjjeO/Mc8CfBLCpmIbCDvyTNLlYH?=
 =?us-ascii?Q?UJe7+JzpyMM3lzjr1skkJNdei6FQzgUM5HJct4I9hf5Qx0EQceq0CNRsB5X9?=
 =?us-ascii?Q?jGF/Grl3K2iEe2Zff/Ut4xzZGgQNbCAAa2K2mQvFTNmBkuBP7i3TnFWy1XNG?=
 =?us-ascii?Q?xd0N0RBhDeu/3w6kxFQCbTBrmS/ZP60DAgtoPCDK8ddTxA1FWQOgiSy+nYnt?=
 =?us-ascii?Q?TNViKaJfbLWJW0BVe9qm2creXNGGgbqI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WVaGY8zWTmz4myFwfWk+UW1WEIY9fVOejdbyglhC8+J8eInvRoWKLk4jVNYf?=
 =?us-ascii?Q?93p3kA7xSFzNkVTbzn0kxr2Qs806YHr4IBBUlPNXQohZgEDkf4tne8Uq726G?=
 =?us-ascii?Q?ypKGfRWUGMSX7be7l56mwa53qxoiKRvOV+zgO9oc9mjcIoIkzKCou8L9ZsY4?=
 =?us-ascii?Q?HRp0fJwS3xdUYPADtvN3N9NfBFYDv+3cEOj/YoclZBNDHDHAT6LTFP2J+ZOF?=
 =?us-ascii?Q?xQvIooA060isE89eBbBkhRbnAkwhrW5pE3vpo286w3BJsyHofBGS7UxRTEe3?=
 =?us-ascii?Q?cpZvKZ8k9gD/sB/eOuIV7hUBwfFpQ7VfVYc8rT6wewGwFhanFIdhqyU3hMbf?=
 =?us-ascii?Q?tRkaOISD6qdiXoy7CtgsXvObgeB8Llh//S/oKquMgB+nEHoSX7Q7fMX1Tgsl?=
 =?us-ascii?Q?5/QRoMMmggy82MU3jdV1ibgJM3xKC5+Iw6iOC6sLtI8avUyALpyVDxG6pgwL?=
 =?us-ascii?Q?2H0dPpK8WuiZBZicuZn78HhsUzY2ZjkH6KnhzxiEo/XXFdc+9AHP7nGbUQnc?=
 =?us-ascii?Q?VbnP2ujUCFYM2BGwxDMaUt6DabItZwIOuZxFR8ShhcIkkf201FfssQ9O4awr?=
 =?us-ascii?Q?A+eMk6HkGe7NmOZRaEwNAD0FU8/Q7RVrS0uIkkwwnh71riL7AVPxYvY+4AJJ?=
 =?us-ascii?Q?oHADGChvnXF51EMQ5j1DSbYbes6mgj/dZyGihrAvib0FspCz5luUH1ezg3x3?=
 =?us-ascii?Q?bCgD2k7q15UHWjMeGgAs2+3U1qga4bpgB1NpG6BXROP1p5n8qQxNXGgpWO+/?=
 =?us-ascii?Q?Fjaj5dcLY239L9q6TXlh3ZlXOxDkRnoZSd2h5SSF5oPGmni9U5EAEAVqsZdF?=
 =?us-ascii?Q?Q3W8W7Zl8Xz6C+DFgTgvC6EyQT5QKA+MhaiPKhUB8CpyzoymWC6ADIGGbIP/?=
 =?us-ascii?Q?mgBKZKJzTWFzqTnI8YGS+qfHbWhY15D+3jRRU+W5wp+K5CWcOhP3ABw7p+PT?=
 =?us-ascii?Q?6j2h7ktS8hAnqf85ugjku9MUL638zJ7ZbMaOQP98UQ5lHSYNATmzAFdRtcTH?=
 =?us-ascii?Q?hLSJAOegVp/WzMkkrmIt6EHYoc+3Jfw5HhsMiusZg5AgJaAZ2BRUPCAcbJP9?=
 =?us-ascii?Q?gfcPDr/h9UrgXRTb2rXRFzyXj6SpRJ0FBQu++RhdS9degmV1mIwMyqyrJa3C?=
 =?us-ascii?Q?+RnzpwGUnXxVaeyFJy8DeVUNDFDishj8qO45wc/Ejj+pWXauC5QMmjaEs6TS?=
 =?us-ascii?Q?cNtl/LeH8BRfgm8M/zzx09aN1rX7jFliUtpxLaee2HZR7AS1z7hN7sQ7PqD4?=
 =?us-ascii?Q?qPbKUkGb3fta74HDJIFkVSAcHJjOFMYH1I3HX1FOWiT6PMHwCjebEwZvupAr?=
 =?us-ascii?Q?CLpQBSUxl0FbC+i/SuucOT3AXgSfSNwW0PTHpR/LLpQs0zz2/G+7pBhSQ9i/?=
 =?us-ascii?Q?aY6J3m0xjctX2vsm9uYKb7cIYY8Bx/ve+BRy+xuyrFvLTNZ53xjhG+U/N7w1?=
 =?us-ascii?Q?cdFYFVofcxQQ+xpNNDHWdS5zGK6Qp+BJsrBH5dqXjZux11+I7cgPDql6+/PC?=
 =?us-ascii?Q?tvCFgQqiMA1RZ4rfsS9MqN5a40Z59S32gVVmjZw61YmWjN0MXjKIpQDQe9im?=
 =?us-ascii?Q?EhoVcxPJuJlno66eXkE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb39e1b4-41b1-456e-dee4-08dd206a2685
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 20:17:24.3629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4UGyc5Hu0qzLBQWasKLjUCw5hXHdUBlL1yuQWq6w3gTmiGsUwy+OORTqgwGQe92AWySe1wwkhTfbPNdghGCscg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6936

On Thu, Dec 19, 2024 at 09:10:16PM +0100, Niklas Cassel wrote:
> On Thu, Dec 19, 2024 at 12:02:02PM -0500, Frank Li wrote:
> > On Thu, Dec 19, 2024 at 10:52:30AM +0000, Marc Zyngier wrote:
> > > On Wed, 18 Dec 2024 23:08:39 +0000,
>
> [...]
>
> > If use latest ITS MSI64 should be simple, only need descript it at DTS
> > (I have not hardware to test this case yet).
> > pci-ep {
> > 	...
> > 	msi-map = <0 &its, 0x<8_0000, 0xff>;
> > 			      ^, ctrl ID.
> > 	msi-mask = <0xff>;
> > 	...
> > }
>
> [...]
>
> > This solution already test by Tested-by: Niklas Cassel <cassel@kernel.org>
> > who use another dwc controller, which they already implemented
> > "implementation-specific" by only update dts to provide hardware
> > information.(I guest he use ITS's MSI64)
> >
> > Because it is new patches, I have not added Niklas's test-by tag. There
> > are not big functional change since Nikas test. The major change is make
> > msi part better align current MSI framework according to Thomas's
> > suggestion.
>
> Frank, I tested this series (a few revisions back) on the rockchip rk3588,
> which just like imx95, uses a DWC based PCIe EP controller, and ARM GIC ITS,
> but unlike imx95, it does not require any additional look up table registers
> to be configured.
>
>
> While the rk3588 PCIe host controller node has:
> msi-map = <0x0000 &its1 0x0000 0x1000>;
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi?h=v6.13-rc3#n164
>
> The rk3588 PCIe endpoint controller node, which is the only one relevant
> in this case, only has:
> msi-parent = <&its1 0x0000>;
> no msi-map.
> https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/commit/?h=v6.14-armsoc/dts64&id=b6f09f497b07008aa65c31341138cecafa78222c

Thank you very much. I update msi part, so endpoint controller node align
host controller node.

It should be
msi-map = <0x0000 &its1 0x0000 0x1000>;

So if your hardware support multi physical function, your can create more
than one pci_test func. Previous version only support one EP func.

Frank

>
>
> Kind regards,
> Niklas

