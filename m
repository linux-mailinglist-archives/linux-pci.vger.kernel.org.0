Return-Path: <linux-pci+bounces-16157-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8472D9BF41A
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 18:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C75B6B25850
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 17:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99E2206514;
	Wed,  6 Nov 2024 17:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="c0zHXFdx"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012044.outbound.protection.outlook.com [52.101.66.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87416206513;
	Wed,  6 Nov 2024 17:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730913203; cv=fail; b=kWDb4BuNgDUjYnV7kUrbRRJQAu+mxZ0Z7LruVsQG6BXtRlF6g8uLV6+NM9kA7RLX6ofZZiTLNyEhPf8usdBQoKHgkcWskagT0VPWol7JvTIc1cmZY9IjdkWtyOevTR4deTxiyiXPLlVLT9ZWkErwzgFXjytem9AJgWIGV/RbOZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730913203; c=relaxed/simple;
	bh=JRp6fZPiIS+I5jHvAQO/8YnBicEeNDd1CQuFRPJPFMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oOLSfsLUA+xuJiENnotQrsu9lF8BE071DWhUphUY07a6Xf0t+w11Wdmyup9sTNADnPRnZmDwwBKVcrmicxYp1jmi/b5XLnXQLPfwWePR3oHBZICGhghKYJV9WIJSvQO1xvFEBXfa62Gq2C8OtsIBSe4mXdjrqcYt842WKGyLlZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=c0zHXFdx; arc=fail smtp.client-ip=52.101.66.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g7r8COr9JWgj2IJXTS9QlNQ1fxZlfef/hNZnqdVStOl+AoQcNdc0Rumqz4Z+HjsTH8+xXHyenqfvDHQypaMzuAdPCvNFP9x+4R6qA3tpREY07gl6qkuQlb87WaCrJluhaeiNh3QIrnDYu3Gzv7zyqfrbuLPFQhbbKEMilJZ5GQDyBaiW58ASlWQ8W5OUs1Puxac1NqV1TPECaJ8HtcfBlW/GgGOaDKir4BdiWUG2x5G62j5tERnDwVWUeg3E7Y+ZzDycuGO9JqJQTgXFfq595PE8JMmnUOMCEDON5GnNa1cGSwsJCdIwwlADKQ2411u+G/nr8oM4Jxvp+0vUUyLC0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/Fe0o6QsUXowZtL33j25lrCZjipwwfGFFTGVDWvAnU=;
 b=Bxfzvtq/HJFo95FS2su5kKdkK0oOxupRHquacfjeSNPjn017zEDGUKRif/Rvxxi7dHfeKnNFO7gwRPn7aDrycwlNt3dE6AUthTtJFvtzbe1dJr1zazqVIujuocM5o9KQtmlku9DX4ZSWxVtIT2Fs8BjSHNxbhTX1R75Fgm9oFw+OJ8afU2hnKItpdPIfpoHrvqNs+aKU+5VgLR4QLNYn9KlP+pxGm2g7JSx67RWwxjVIpfmcSL+Zc417F4m2QeO0zFSPheJmaEGc9VmVXGBYTaq+q5gLuUny2D8yyYzkH5plzjrDFttpClFyfs0p2sk0ccPlCGxHo234x9Mk4CXGOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/Fe0o6QsUXowZtL33j25lrCZjipwwfGFFTGVDWvAnU=;
 b=c0zHXFdxXapuGoc+D+Bt/ulXUHVNcmg4OoCYHDEb1zCxjr5iXJCAeqmBL7H/hALlld1/1ZziG+wgDllJ3Lmz26MVed0/uLYjU/sFYknhj7byv3Ohy3NrMhTwAqhAE7s4mh1e9rUMNjjx1/mFA0Xi3Vunu1a4RonZuma3Dh7bCihzCsJ8PTQsjzDicNpgeXITEHbm/VVO5XblklCCvJSt3lYcvfV5IGaGFWGVEhMlBlhAZNPOQTQDiRI9PaZ4/06DBAillXrPvWD9ebYj6LJjM/RGNBsU6wUy+axpCPLYZI3onYEKbnXO7PfeuFXLdtsI6bUKn4JzHfWTR5HPS5H3Dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8284.eurprd04.prod.outlook.com (2603:10a6:10:25e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Wed, 6 Nov
 2024 17:13:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 17:13:18 +0000
Date: Wed, 6 Nov 2024 12:13:09 -0500
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
Message-ID: <ZyujpT+4bd7TwbcM@lizhi-Precision-Tower-5810>
References: <20241031-ep-msi-v4-0-717da2d99b28@nxp.com>
 <Zyszr3Cqg8UXlbqw@ryzen>
 <Zys4qs-uHvISaaPB@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zys4qs-uHvISaaPB@ryzen>
X-ClientProxiedBy: SJ0PR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::7) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8284:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d076ea0-f304-44fa-3dc4-08dcfe864ef1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FWpU4SH97nY2kS+roxmgGZR/EsBfNYVbl356JNrT55AJtEzZ9/17sWqXeD2z?=
 =?us-ascii?Q?CGTyv1tHnt2w9z+u/Oyyf5QC24IezDDHpS+gMglHEKNk0PxVj/0rqxLhDo3u?=
 =?us-ascii?Q?828ChzvNEsg0ZTSfwSxC7ZVBa3VDBh9UBFyTPGk1mmdPDLFibOiIoMpMiz8N?=
 =?us-ascii?Q?woHTCMzB4W6cfkXDuuqte1pyS/uR8bnAAxqofLjf91Hx7TzjGalYGTMf8/1C?=
 =?us-ascii?Q?dNfW1b1vygSFJqKIHN194jm6WGDd0pxzdZrAr4Mh7rwjE7+818mzKKDVtCT5?=
 =?us-ascii?Q?u4loZEHVHnMD/yJ9LyjtE58W5m4D/k8jhmA3oKA4/rj55HZJMhteVAWf9wOt?=
 =?us-ascii?Q?ROJnebPMMmWk4ZRbewN6f0xI7Zg42aEqyRhc1jr3nTxUZklwk2lRhvgWxbRP?=
 =?us-ascii?Q?WdoGbCLWqsVcwjb7uwo4lW7ZmgbtC9poPa2C7HWNaS6zRn9tx2IOfAW1KfXp?=
 =?us-ascii?Q?tNOpX8TDQ5WWzbk6oaHM6iTVVyIULSuuO3FJq5cb89DOda5Hh0fGnuU3aUhJ?=
 =?us-ascii?Q?mAxYaZOciRlE6evlAB68lZk1Jr/NlrhvPNLeiDtHBvClyAlAe9qgXmJX2VZ3?=
 =?us-ascii?Q?W/tgEXHb39Nyw+8RTh/qTtA2/V+GDV+GMxwZVncr9Xvy10i/0Fln8/q67vPO?=
 =?us-ascii?Q?rDfFdbBIglFboJgorCVb4M4rL7lCumcEE7cakhjM+ys3CPq6buRJ9oOH4xO5?=
 =?us-ascii?Q?dIPz2ETetyKiXPysWZE3z9DlR0fJAzoPLo6AjE04FvrON4iVde3BwRQa3yTV?=
 =?us-ascii?Q?XLQQCqB77U4T82+TkKRoStvA33kwrodqbLAua29557InYvaVajzHMVR1sCtj?=
 =?us-ascii?Q?sP2Cm3g0scfv+BM7b63Q9aClJSwLKJYStrqMuu3V0vHIJt89WMuqF4atgHmX?=
 =?us-ascii?Q?kpcjbb+sW3SMW4xZ7UUAtci/2MH/vrKp/R85vZ/uNxCNWvJF5O7UmZETAaHF?=
 =?us-ascii?Q?pxzFRFzVsDOot0g6wxHGOFLq4xlnvubnxzDnOCZgy9x1dZUh9ZZtXwuHn/3F?=
 =?us-ascii?Q?KATiBf8+6G990owcVujNXeaoL7qP9hXu3nqwFYUIQXSeEqjDkybVw88YnKce?=
 =?us-ascii?Q?U1zLey4MA467AMrdWDGhBVSbI/3b4jHBeBZImlobOvDSdm3g2v1mVTKxzbSb?=
 =?us-ascii?Q?l6cOrsRZCStryiw4qaJCzEGJURNG4cWnJ4j3yJqazowm/J3TevoTyM8BgSBC?=
 =?us-ascii?Q?t+5qTTZQYubCSCM2I3LpSJ1uZD85y+5iz74DNU33c/twjQx7ThJoiWTr6hSG?=
 =?us-ascii?Q?u7C68ojc0aDZXClGDA+5cZ21TJg9l9mqDdAlPDwqziFUOpJX5kHHXB2tr9rk?=
 =?us-ascii?Q?XCdw3H+mviRigHC5L7GmbHVKJjpBWGrQK4wqcKMfvvoWcY6r1tzgAkZ88lL7?=
 =?us-ascii?Q?8z5aydc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cydz5yOk6Zef8vvAHg43hcuNa5WaMPVwC0WCh+9D/BEIWQltSwFEtn2O4zO6?=
 =?us-ascii?Q?wwWq3EcTg0T/HDhM6NPLqSo09cv2wd6QurK2neD/+zldFzuizPAiCFtY1Wop?=
 =?us-ascii?Q?6pPHAnozmF86hpQz9+GTcEJs21CjTD6RzhNrd8PCTrhIYTL0bnpeArnoU8+o?=
 =?us-ascii?Q?e09FAWFy/4JuWbrnl3jj190lj8vN9e8us3qVYz1VAcDXGd0yUkywTaJZbGXE?=
 =?us-ascii?Q?DOCWETmu7bsUF6O3zhBmGV+stetFLsKGL1J4SBL4Mm0JEE+X7+qp5ZRBUVTy?=
 =?us-ascii?Q?tNqFKJ+awkvO429OJj+dzkKf76XSJsSwU5fNkQPK+H8ijiEr+TG45rqGDKqr?=
 =?us-ascii?Q?7pfksmgoRJP5Jd54atoly0ic1Hj858jCeNy1gnLzjZZ3TG2rCBguoZ9J5Yc9?=
 =?us-ascii?Q?SxTZ3UIFSoYYGVeETWYCaiJ5oUGrRch7y4FpFZYFD6KimtdEWX+Dc+nngHrU?=
 =?us-ascii?Q?4o7kOCPnW9FjvhGxMnhr6CKhAQi4bUixQy0ma1ufk6No7u5mfOk9HMIesG7f?=
 =?us-ascii?Q?3Cn1IwnAmMKnXBLjNobZGO0aH9abb9KtAJ4ET4hTUMRHKpfJsuvDtFycNzew?=
 =?us-ascii?Q?V8PuiSy35sOrNoWxJown3/eFMTGN1713FNKjdhyXK/cklxpJN+Tu9tmSy/Us?=
 =?us-ascii?Q?Qpap2hkxcZgIWAHqpoIu3kNTn9odIDZrqbOahFR+6YZm6vRfTWwb2kMPrb5m?=
 =?us-ascii?Q?jVrVKN7yrP4+kVKL9/Va7el0mKo1Ox/hbHykVR7PF0ncJWIe60gRfP70hiAL?=
 =?us-ascii?Q?cP6QkdCvRYVmEixEPiw3d8pI1g0OXFLfAHVOLITLSopmucSuFIgWiJ38E0Gv?=
 =?us-ascii?Q?7GLq/2nktuspTR/dZGbGEG0NKWlCxN7gAVa/RkUH8n3Yigxh6Fkk/JflOBtg?=
 =?us-ascii?Q?+J2svHCy/sVL5W92i6mTG80bMwgYR8YjHY9d2R9ERQ8Mvvf3wZEZUsgeFOTH?=
 =?us-ascii?Q?zcTol2Szeh77tC1TXZlCFlmw137DRpCLwjj04voDYoXHPTrP6JKfrflZaaW8?=
 =?us-ascii?Q?bDheRF+cwgN3JpUvtEbWYe3TqR9DCiP1pCpSZo9do8bR8knzXUasUAUOjSRq?=
 =?us-ascii?Q?ThfZ1rvCnrjqGKp5QQRewJJuRgAUnZn8NHsIRoqM1oWt1dbBqykikWJ2+1Ui?=
 =?us-ascii?Q?z+YNdTvS5dkUJPJj/rCqNqGG8eqS4+FPCx2qTnm7nga5C1AIM9iEvS/sFvXf?=
 =?us-ascii?Q?m6rHefBMer9EAG0QERtZK1it0gi3vycyirsCr/aZHfB42z60a9xmA7NygZdY?=
 =?us-ascii?Q?gLXXDzsRBIdLEvhyO+U9G60mNkkJE3omwEzPoQEH6an68ScGAMlf6WTyMG9g?=
 =?us-ascii?Q?2jkFULgyGlNX7N4JP3Qlxzw14d0Z182rhQQJ95TMtxUL3xVRpV3pORrt4r2l?=
 =?us-ascii?Q?XO/P5JdjDGZ0CMH0a8r0Oklgkr+VgsYPrzKwps2ApwJM0871rx/K52zLcnjx?=
 =?us-ascii?Q?Bdp+hf0Wwg704anxu1NN7nQbf52/+alb1RleoxE6giH/EqwbbcbjvBtaDVpf?=
 =?us-ascii?Q?sXkoDzIAWiWFGTnKmbv+POulaz491qNzcaIiRoDQNuh6sdWgtHuuNb6S3R1t?=
 =?us-ascii?Q?85rIsjStQlYvu1ol3K+cRM+Mx/D86QMefXVmfp9M?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d076ea0-f304-44fa-3dc4-08dcfe864ef1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 17:13:18.4362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zSjg1IEtFi1hLqRBCaj04OJ3AT8JyGi2ni2GKf1ibmPmiTLJH//1hy7Zr+CGUwPhSyzVegkrWGE8TnGnrs9m6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8284

On Wed, Nov 06, 2024 at 10:36:42AM +0100, Niklas Cassel wrote:
> On Wed, Nov 06, 2024 at 10:15:27AM +0100, Niklas Cassel wrote:
> >
> > I do get a domain, but I do not get any IRQ on the EP side when the RC side is
> > writing the doorbell (as part of pcitest -B),
> >
> > [    7.978984] pci_epc_alloc_doorbell: num_db: 1
> > [    7.979545] pci_epf_test_bind: doorbell_addr: 0x40
> > [    7.979978] pci_epf_test_bind: doorbell_data: 0x0
> > [    7.980397] pci_epf_test_bind: doorbell_bar: 0x1
> > [   21.114613] pci_epf_enable_doorbell db_bar: 1
> > [   21.115001] pci_epf_enable_doorbell: doorbell_addr: 0xfe650040
> > [   21.115512] pci_epf_enable_doorbell: phys_addr: 0xfe650000
> > [   21.115994] pci_epf_enable_doorbell: success
> >
> > # cat /proc/interrupts | grep epc
> > 117:          0          0          0          0          0          0          0          0  ITS-pMSI-a40000000.pcie-ep   0 Edge      pci-epc-doorbell0
> >
> > Even if I try to write the doorbell manually from EP side using devmem:
> >
> > # devmem 0xfe670040 32 1
>
> Sorry, this should of course have been:
> # devmem 0xfe650040 32 1

Thank you test it. You can't write it at EP side. ITS identify the bus
master. master ID (streamid) of CPU is the diffference with PCI master's
ID (streamid). You set msi-parent = <&its0 0x0000>, not sure if 0x0000 is
validate stream.

You have to run at RC side, "devmem (Bar1+0x40) 32 0".  So PCIe EP
controller can use EP streamid.

some system need special register to config stream id, you can refer host
side's settings.

Frank

>
> But the result is the name, no IRQ triggered on the EP side.
>
> (My command above was from testing "msi-parent = <&its0 0x0000>",
> rather than &its1, but that also didn't work when writing the
> corresponding "doorbell_addr" using e.g. devmem.)

<&its0 0x0000>,  second argument is your PCIe controller's stream ID. You
can ref RC side.

>
> Considering that the RC node is using &its1, that is probably
> also what should be used in the EP node when running the controller
> in EP mode instead of RC mode.

Generally,  RC node should use smmu-map, instead &its1. Or your PCI
controller direct use 16bit RID as streamid.

>
>
> Kind regards,
> Niklas

