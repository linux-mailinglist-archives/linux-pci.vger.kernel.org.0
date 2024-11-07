Return-Path: <linux-pci+bounces-16185-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E73F9BFAD8
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 01:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F51A1F22227
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 00:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5714E10F9;
	Thu,  7 Nov 2024 00:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Wn5QLex6"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2080.outbound.protection.outlook.com [40.107.104.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8664A21;
	Thu,  7 Nov 2024 00:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730940117; cv=fail; b=cBnRbRU0mOLHr+loC7YKl+2h/A30m+2ceRdTyl7IdlYrmdRxlqeJV6r1oECM8w94DnzvIT1IfD+s5N7ByUEtdEMYAOk7VCuv2xGSH0cdQtmaZUGej5k4vtNFbhEl324iIEbYWxH5yJ9QyozubsPGTEYPzcRokfaCL43fw8/143E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730940117; c=relaxed/simple;
	bh=w+mIYqZzyaZdHt3GiPQykGFzr/kkcl33Js0cBTKLdAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RARAJisW5SlTAf/K/LSxUfrdK2yK/8BXwhOnoDIB3w7h0H29EiKECX1beD4KAu9jV0cDad9zKlek7qS8r/OHtRYf1jgDyl8YSLM4mA+8vARv91FNJm3abNCZSWl9zFJOCxv2KLDlUmnmCvuo/c9iMql6Y2ipxnnpHmKGnw4RzIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Wn5QLex6; arc=fail smtp.client-ip=40.107.104.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/DWKzbpTNpwlue3p5Xn3GI8QFGxI2HCM5GLHJRsMyg0y3+QRHu2diHKfA5GTDxjteezuOiGcfcRCelPRkPRW1PfVQXstDNxMukgTlyorkWVlpIqm8zvLHPptu32MlfruluQAUMfO/zr8u5fk4kKiGEkSAoqtTRELPr4OTpsa8TRGbjv8BzeQf9MUXWidehEiMUfU+jzkc+un0eVFxlai5KgFoEp9calE/ajf5pWLP/Xn68CIx7w/TeNU7txjyHb/bNAiDllZ6tfTbK/5ZWXQdbzfMVDZ6zhH2zq36Wyzu4rkFvZlv0bs1pKAU8v8sRsZbn2o7u5SPBowzMxsx587w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6LM7OeQAzFxfhPwXKg8NLOGA+6A2OumhtQy9XTt6mfw=;
 b=uwkkWJ2bXJX6wEygwBXJij40e7lOkJgCaSSImFJ55qKeuw6yuXIBLnTpSz614JwPUpyZo7l2X4D8YFM/1tal4jVdJ0SpfYi4/2WNMj3/gFWrM9Xg2hUTO3/QIQLd51pIGgD6Zgy3+gEAljfdk4LWyJJQcd+scxiYWOI7WJOAJ0vzrmYx0ea8XZtB2eHzd5vsuiJjBP+I4EH1ujPM0YRlktx12ZY9fSXGRH6JaaFMsm3xQmaRdk7hbFi+cngqGlKA02Mbgk9iBVoZ6w9ghJ9s3oWna8rSfBZymhSWrRtVa8zLbnBQzHLOD2i/VnXj5ta2iNG+7WG30ErRYDdhzpQiGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6LM7OeQAzFxfhPwXKg8NLOGA+6A2OumhtQy9XTt6mfw=;
 b=Wn5QLex6lXNo9YUZMzBnvQNni5wXfXBMH8ANvyBfbc6dVWUvo43jJoYJrIufuSmBfo9B1ZwruddR6uGyPU5A5lbwMzHQGU06UosqhXK6OhyNVVbqrEyx/po+NAw1Ez4dWxeUzx/bed3nA49ICHfwl9dtUZvCu2+UrBuYMC221VidBnpYKiJBuUlgsaEh3Iu9/wx+GLNJScUz+kyJXW96RTySTAD+HITpo9paSgxDId5zNeOT6uUw01172TulcQqhFGeQY1MUHiVNWUD3g1EMJq1kz+P65QAfq3eDg21CVqNyGYX4bv8j3zz12V1Jo8pY6bbSxaVaT76D0ReaoYKMGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7717.eurprd04.prod.outlook.com (2603:10a6:20b:292::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 00:41:51 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 00:41:51 +0000
Date: Wed, 6 Nov 2024 19:41:42 -0500
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
Message-ID: <ZywMxnij3wZ9PGmj@lizhi-Precision-Tower-5810>
References: <20241031-ep-msi-v4-0-717da2d99b28@nxp.com>
 <Zyszr3Cqg8UXlbqw@ryzen>
 <Zys4qs-uHvISaaPB@ryzen>
 <ZyujpT+4bd7TwbcM@lizhi-Precision-Tower-5810>
 <ZywCXOjuTTiayIxd@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZywCXOjuTTiayIxd@ryzen>
X-ClientProxiedBy: BYAPR08CA0050.namprd08.prod.outlook.com
 (2603:10b6:a03:117::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7717:EE_
X-MS-Office365-Filtering-Correlation-Id: 7667da35-1464-4f6a-7fbd-08dcfec4f80a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nAnobd7E7tqHeJRukE4ILTdQ7I/CI3aUhJrSjlSUy/qn8qoCZJTS78basyFn?=
 =?us-ascii?Q?6TE35O+7THcanKP76DAuxV92F3u0nQX60Obkz51Wl9iqKmPzPnHN8NedbWgg?=
 =?us-ascii?Q?+aTPOGeHucnBZ7TT9QhjpWqYP+FETZ7EAUN1UzFjbtHIPhS3XQCBF3TWObGm?=
 =?us-ascii?Q?iUUgwVjuFND1KpXRaKQI4rwlOragb/cyyZtHo6fRIHPaOf6c3/AuPLshSath?=
 =?us-ascii?Q?oU9OFqZaDxgzU+tbA400BF3vR1HJ3sG1n/oePulIGiK/Bo/2p/GnqQxPQz3N?=
 =?us-ascii?Q?ZGZXNP+5dSl6eTRHBdulm6gttJs7SCZC5Jtxf2AUTG3m0D3Cc0WVzC/xevHs?=
 =?us-ascii?Q?A44aoS4iTg5Izy+G8UorfmlapTeTpyHHUBqILdLgZjjB3XbnbynxSdgjuxYu?=
 =?us-ascii?Q?rhskxd9wG4edG5DVC1ZMG2iOJ174PvalcX/Rv1sz07haKZ6XQHCc1NraBjYM?=
 =?us-ascii?Q?HpxZzQqMpRl20HIl3cDaEcStY03zDQWrP/0hjUuSSobqzowdzF0ExWYySlqT?=
 =?us-ascii?Q?6pwERaMYjBQL9CXPmlYJGeOoIJ2X38pkjz/ivIaEqcSpQebF5F/hMri/sy35?=
 =?us-ascii?Q?FL6igpwwegBNqYqG5AF5so+e9U8nCXfyvYpnFOHK1/GT+pXEtKIiJq6w9wPZ?=
 =?us-ascii?Q?Y0LdVuYZEz1PmXdVHrW+TbkaeexsJJsQWhkeAOQNoGXac7d1iZIPHEwUHdfQ?=
 =?us-ascii?Q?VPp0PmQLHNVGBAmQmuFb9TUYDQTuM5Jbpac0GoOPar+NhKfV74IWoqH+oLjt?=
 =?us-ascii?Q?G5O2D9UHWQQYo3iRDLmFVBIDGwb9eC7mWQGWCtlwy/zyxr0pRMqiVLmIV0Up?=
 =?us-ascii?Q?SHxq7h18xXihDLa/5y+KUToKacDMG/vmsml5BdTlLndbpjnIQYRh7YxXCxIJ?=
 =?us-ascii?Q?3txVTODwrfIabaRjHAEWxS/Yy5MXfjBVGhIMtI+yZDVjY+EofPGebzANxGwx?=
 =?us-ascii?Q?+4/fGszDoXMIhdFIRl+QYhCJtdOSkzS6gZVXe+pNWsOei9mWGLPcqgqNqaS/?=
 =?us-ascii?Q?aUwYFqVGZ0PBraI0LGup9AVwMTG8pdseOmF770QobYarDinfMxneqQxvCaPi?=
 =?us-ascii?Q?e5rMDTzvaQxW3KsU0FjRm+UlFvWYWLyeO6yP1miMDMSR3ZLjxrXuA4HiHwFt?=
 =?us-ascii?Q?9funLLjXIJ8p8rEwMRaaZd8S3jYuGr3c3BlYmSTm1XDDzUkVxcXbJIh8l32y?=
 =?us-ascii?Q?nrCt7j7rRgwPIm6+fdTubNzPnWpdYZFhXO48fIt7GxiIAmK65NIt13XkUHOO?=
 =?us-ascii?Q?FEYCGe7mpDbQAo2dfGT16Gn+NKgRz/nJo1NmYfqVS+Ki2lrCGAi8ZUFUnoDD?=
 =?us-ascii?Q?NKDtHjZv+Ateq/rqZJJo439e?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mGhRHSdH5NnsY2F3OEY90RMpQvlGU6Hp1wkS5awXxeJdfj2nxXQaH/ZZW/Tx?=
 =?us-ascii?Q?LJMsi4r3KEN9xjc/9o3EmLJYPHkKnVNJovHEX6YJ1qgUYmqXqHzYFKadc/xe?=
 =?us-ascii?Q?AAdrpyKK/ixkf9nRUVdgnWmIhbKaF9cgEmI8jiFd/OCL9qHIme7g7pCmMi+t?=
 =?us-ascii?Q?xr2PZSIP6I2yz7TJP2+X8Wv9+O7hfS86owyIP2BY9/36R7sWYLp45jVRgpa2?=
 =?us-ascii?Q?djPq846NpZOWWvt2bdhqN+m16hpD5KnBq5+uBX+zHAUyKpCD+etfzt5xqR3o?=
 =?us-ascii?Q?jqsBV1tqPW+BXj6l7vgNsqSxAAsM8L8bPDR7/FVOkTC0Ia/3nHCe5xax0qeH?=
 =?us-ascii?Q?MElBD0UL0kEbwcm7VvxbYhag8DLqaxZYkoUw6KhMNifjZiPcFEpg3wG7peAx?=
 =?us-ascii?Q?hJeYd+n9YEOdY4PheuMMxNiekWHraycbIbvjhMoVZNWeJfzktPHnH7ppfda1?=
 =?us-ascii?Q?eD9Lv+j1tOax+TeVx9349rOgsfFN/CJNTI0JCDTwtZMa0uZ5GrHTbArzIl4W?=
 =?us-ascii?Q?QPUZ2MJTVBcZN1kEunTvF7SnPPiCLBjhiIvIyJCzd2Ow8lXRzsKuBmolzzGA?=
 =?us-ascii?Q?Qh4jZBVtXurouG7gUbHKMFzI8fZt+XlFgP86JNcjPdaZIHRke4Vx3hzHrsg5?=
 =?us-ascii?Q?PjZ5hoyoofR0Ky+dLktlAKCPbvaz+E9ST6X4FzEr/zy91YBGQefgx1is8CTf?=
 =?us-ascii?Q?vknRehK9pd0yJN0DJp1xkF9Ytj1VZatnMFj+Ssq+bwhEcc5VXKVKoPBntomW?=
 =?us-ascii?Q?ox3IRK0OS06xAEnzOB6pFYb+Ym1EWaLeyHhjfU+fKSs9aFJgT9v4Sb/s/gIP?=
 =?us-ascii?Q?ow+LHJnNu4DK9lrAsrPrLsZymRlXlXE2myaKeqrdRFIov4CI/fi3JGSrlw6o?=
 =?us-ascii?Q?H5TYB0TxvCk9kPw6eL5C/owpz0qsdcmSNNutrcH8TJbIojje0bVYGxoeGIXe?=
 =?us-ascii?Q?pN5x7OcO7B5wyfCDiTTmh0U4dk8fE2y3poZ/9S+5gw6lIagF8myZKUy2PCNB?=
 =?us-ascii?Q?K/dK+HLt8lYJNikiBp3yRjf2gP3HkTcR2mIs5BWS8pZi7LrquBkGtsBldERt?=
 =?us-ascii?Q?LaAbXH3Qu379pKTwNVOHa2b3asFscQ2lWy9bBY0ttxDh0YLu6v5kwxBDo5dT?=
 =?us-ascii?Q?wvhKqsbPOvnXvd9sGpQRZgBVS1PhCjo5Kg4XsExExDxtsZTEbOgqlS28lW9E?=
 =?us-ascii?Q?kxt5Fl5r0gzbrlIV8/M0P20a6Sh6vF7a6QvzzRkf/11LxF8Pn124FAybQLZj?=
 =?us-ascii?Q?zOIJrYuVhWwp2yv7YaGSESCYu6KeskX4AMVQaA68Dlym1ZIgq1vvQRhziw+2?=
 =?us-ascii?Q?NXW2I6ZKSBLjeL7FobWX8O9IHnbfvDU/8cEtmgUeiRFRXJlp5BFzs7CDPgXq?=
 =?us-ascii?Q?x7wa2PNFeZXke+1ZOTB6OCYqAlmy6wYYgutxxQqzZcHWklN6nXeTfAX1UlUz?=
 =?us-ascii?Q?NagDQf/yeWocnV1ggcyHOMLqHhhMkMPnKR8UXKDvIj0l3dNIdxLDNAFWp/jl?=
 =?us-ascii?Q?zEsjHqzji6gNztNU01GiaLqii8xPAj6WPL77yajeJw3vBgXrkHWCCIc9+C8H?=
 =?us-ascii?Q?bCJTw8KQo77W0/OpoUGvUWqWl5ylHnSObPcTTgQ8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7667da35-1464-4f6a-7fbd-08dcfec4f80a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 00:41:50.9442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kR6vVYZN8RJqoRyjEwA2J2qJDOqNU6x/si3r0l1nsPtQdyu2Yz+ALFK2uaEiBI0FBWMaEXperpHsRjy90YOdfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7717

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

Sorry, typo, my means msi-map.

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

It should be fine.  Some hardware many append some stream id bits before
send to ITS.

>
>
> You also didn't answer which imx platform that you are using to test this,
> I don't see a single imx platform that specifies "msi-parent".

Only imx95 support its now. LUT part code is still under review. EP support
part should after lut merged. Preivous use layerscape, which uboot set it.

Frank

>
>
> Kind regards,
> Niklas

