Return-Path: <linux-pci+bounces-21930-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C8EA3E5CC
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 21:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74CD817D804
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 20:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DE926463E;
	Thu, 20 Feb 2025 20:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nDOp8B2q"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2073.outbound.protection.outlook.com [40.107.105.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F662641F1;
	Thu, 20 Feb 2025 20:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740083049; cv=fail; b=dC/GPSDlp9mSg4iZ+/bEY729yo7/2L2jTv9EVnzWMG61g4hMDMYDmGzsUsvNrsVkQ8onZ8jNLUrxoNxb54czOhEneIaCm43iYrVE5COHqeXb6uKEfISLKGXWsBYI8pYBdB0t4mBAj51+skSoyY3ydM+K27/TuXfC0WDQoDNgODg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740083049; c=relaxed/simple;
	bh=B+h8BewGTdbwErBBpEnHQUVi7km7r/wOt0p7MKeHkUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g6Cvq8t0SWec3/OvXStZp+HwZ9ZMJNmVDu5MKK3sdosLGQlsWFOacrYcVG1NIYoRzeKtlfpffechMRd86o6wnBTF1wbrABsXwfy2umFDT3XeneRhYoXmSvK/u7rjnaiodZPizID+d1djbsf53xR90TBsB1VOZ+uesVKx8yBnKr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nDOp8B2q; arc=fail smtp.client-ip=40.107.105.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VnpnbJSdaZpMS7/WsI98TT6M608QPtsLsJKXKNJQHdRCVgDDPNPNc1AfZRwp3E85g9Oenv9J48CJRj5nX4R6SVpZVevnB/xS2sRvNIuK9C7nDPfbhX+VLDNUwgr9r2Z1ios/oaiiAMahbzPWdJ9QhgNuN2uHPF4Ze0z+ZDcV/MVuCREeTT19zKD09uIsxWEqVE4U4wGP6+YvaurUILt3Tz2Sf2s+XwwRSiE9vOjQfjjuanZvta5rsXtA+yoThePbWxaKBOfAxzWJrvNn1hsv9bOwq8l7Itx42CPMbwgI/E7fvdjeIqSZKL8qsh3DvArpEv4ge2S4cRQ6HlUsyKKV6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZXNTyTBcbJQPeU2y4fFUlMOFBAK7IHmz/0hTWA9D0ys=;
 b=SRnWHf53/Kt4FU0GAiAVVnuOq15yn36dsWWPOVtT/U79XspWvPAdTZj8kfB/YKA+kyFDD1RbLFxYu3lVUs7WgNFrx3A0p/cghRJ5kVUdOEJ8kwayPYRl21UI1seAgpYHXzImp2cks1K48JAZQatbeVYDrTqgAjOR3SmDaD4zne5t5skFNs1ruRVvYMDgaO9ercrrg5twtRopZMtPnKm1MiE3d6OmOpq6zaYDqJS9EZQk9BrqTencg62aYjs0NkpvuUIED3PbFjKFzqCR4XQ32FaoyqNOqN2rAiZ6YcOehOtiL2vxRdBGDM7r2IYAK2dnDk4l5Po2QbVn80HSWTBvkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXNTyTBcbJQPeU2y4fFUlMOFBAK7IHmz/0hTWA9D0ys=;
 b=nDOp8B2q73OmQe0q64J1ecLd86tKULVhbPtmBxQAvPJkWlMrEnmw6bF6sQbqhqdnJu9MQUlPUamZYV3F7jtDCpHJSZwnCYQwY9P4AvDdfrwTpSaHiqLU4R3qS8FDGRrhEAUCNq1zJRSWdB0RiOu7AFniAIgqG86ziIOUu9dmRDJafBStEFCX1pGs72jS8mEMH6RgUdnYZQircYyLl3MH/CfzTB/luZ6S/CQAag13D9aPj6TLYwDiDNpajl+dcdY9AVLdOv0YkBWXP8t37caIvW5dqldZFFaAVfGhxuUvEfX2A0n2TeerWxt5IQemeD3OvlT63Hn9xNzegk+Q0l9Slw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DB8PR04MB6907.eurprd04.prod.outlook.com (2603:10a6:10:119::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 20:24:05 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%6]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 20:24:04 +0000
Date: Thu, 20 Feb 2025 15:23:55 -0500
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] PCI: mediatek-gen3: Configure PBUS_CSR registers
 for EN7581 SoC
Message-ID: <Z7ePW/Y9vajLjPdr@lizhi-Precision-Tower-5810>
References: <20250202-en7581-pcie-pbus-csr-v2-0-65dcb201c9a9@kernel.org>
 <20250202-en7581-pcie-pbus-csr-v2-2-65dcb201c9a9@kernel.org>
 <20250219182650.gxzlbl6ovgbacmkm@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250219182650.gxzlbl6ovgbacmkm@thinkpad>
X-ClientProxiedBy: SJ0PR03CA0374.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::19) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DB8PR04MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: ee0fb812-dc67-427b-dd3f-08dd51ec855a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGIydVkvdDNjQ0tqRTFRODh3WjFZeEdRdWdoT1NxRnFiVlhrQXRKZnJMbE9v?=
 =?utf-8?B?L1ZnN2JnNXVmL05naG1wMjlFYmpEUmdMT2FySXpHcm8xN0pVcGs5YlVvUThP?=
 =?utf-8?B?WDZVcDA0d1dTNFE0emZLcllyOFBKRFlBSW9LQnJ4U1E1M2NSTmVlTGs5aUxG?=
 =?utf-8?B?OHNLOUxJbHF5eHA3VnAvVjU1U3M3NFM2aU54bFgvSytVd292TU04a0F4RERo?=
 =?utf-8?B?QXpQVFBTZ01UWC91Z2tXRXlyeXBncEs2K3g5bHpSd3RFRmxJODNHaExvQmhO?=
 =?utf-8?B?cEJHeUo2VzMzVk1aMEU4TnlGdW50c3htbnZMdXpXWGNFZ0FxM0hHTlBnOFhm?=
 =?utf-8?B?bm10SWtOcTRVcEEvVVg1bWdJT3BFNHU3WFBlZ0dUWklyL0NOeEljczZoWkpj?=
 =?utf-8?B?QzV3cElHRDlyNnNFWDB3MVU1dzk1cXdIUGhESzhmblJuZU5iSVNWblRVZE4r?=
 =?utf-8?B?eUxGR3NXOWZ2L0R2aGQ0MzVCaFU4TzJVb3MrRzJtdWJwMHpraDFWemxBaFp5?=
 =?utf-8?B?YWt6dDZOWC9va1k0VWxPM2l4Wk0vVGNCSis3L2FySkZsdUFoM0xWZUpiSE11?=
 =?utf-8?B?dWhhYVVISHRENGJ0cEJ0NDB1cnQwaU1Ca2t5alF1dmVPRTN0MnBLVWM2cm1L?=
 =?utf-8?B?V2JqdDhsSEZUQVNzQWRuNXVUekpiM1JkTGJQa3lpUFA4VHQzUlJDM0l5NVlp?=
 =?utf-8?B?MU14cmFXbk1FTlBvbGQvSDZ5dkNnaVM1S0wxdTlhZlF3cUdDZkd0akJLZk5o?=
 =?utf-8?B?Z0hvZFRoejFLQUNoUC82dlhPd0VmWWJnc3h0OHlYb2ppTU9MQkNnSEVySm4v?=
 =?utf-8?B?eTg5Zkd6OFBOTFFuUnRQQkVnaE5jWC9pdU5QSmN3U2dKOU1hTFZQNkYyNWpJ?=
 =?utf-8?B?UzZVMU85RmRTellVcTV0WnhDTG93MzVqbVk0Wm0vdDRzTUhQYktkTHlraGda?=
 =?utf-8?B?Q3FrbEhVOUR4clJmSzQrR3Q2T2NuOUIwMFAvL28rVWVhdFZ2Ri9NRGk3TmU2?=
 =?utf-8?B?VXlkelFRU3VwRVlWTG1DcUV3ZEUxcFBvK0NZWjZjZG5xdHltaEh0TjUwR2d0?=
 =?utf-8?B?SXMxdDZQYzRRakdLalEyYWg1TllLQThSd0xVZXZCRnFkN1hvck9hM1RkOWxU?=
 =?utf-8?B?V3ZNN2ZzdE16M1JDenFlMUNVZ0Z4Ly9PWGhWN1Nwa3pPejJPaTVzTnYvTVVq?=
 =?utf-8?B?anBIbHcrWkFTV3RlR1ZRR1Raby9QWXcwejJVRlRLL0tqcEN3MlhrME9pVkto?=
 =?utf-8?B?OHFtS0RZTjlrR2VvMDd0djR5QnQ5ZTJ4M281MzVWT3VUWHJlY0k5eFFncTBB?=
 =?utf-8?B?dEhWeVNFOFJkNkdWT0pkdHJyMGM5dTZYMXRteC9jaDc1MkNZQkJEUDNDWEZK?=
 =?utf-8?B?MGdpL0djR2s0MGtrY2kvb2NlSkNvQVFtamFkL0dGb3FTU0dJb2xTcGFyUlUw?=
 =?utf-8?B?WVhiWWdlTDVaTnN6OEpOYlFkaTdLZlRhVjh0RVFhL2Q5TE1CZ3dWQWpTek1m?=
 =?utf-8?B?Rzhjd3VlbUdrckJsa1F1OFJlZGkwdnl4am9ZTy9seXNZUDI0ejFWTktxTy84?=
 =?utf-8?B?MWowU0pNYUpZODdyQjQzQ3FWdDZlaEtEVU5LYmNFNEZPTFQ2ME1rVnpIT255?=
 =?utf-8?B?NmFJR09IMUt0aHVDcUZkMFpDREZhNGFZM05VYkwwemlKcTF1ZUtwWmJSSldY?=
 =?utf-8?B?VDdlQ0ZHYmI0WG4xSkFmOVJENzdXRzFROHZvcXpZTW1zZnNLZXFlekkwUUxM?=
 =?utf-8?B?VzNCd2QxZThuYmIwcStXQVJGcDBtaUJIQ216dTlMZFFzeXNVaVJwandxUWZu?=
 =?utf-8?B?bUFZWWxXYnpNSEY2dEJQL3c4SFRDU0hITWdFNlg4RUduenJHWGlkckFYNUJP?=
 =?utf-8?B?Yk9GN1JnNHY5TldoMEtLSFRXay8wT25Ja09wamwrWnlFVlZnckh2UXdmT3h2?=
 =?utf-8?Q?RhflYX7uyHCTUX5hpoZibANpjM1pg0ng?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dklabDlGSHR0cVlhd0pROERRRHlxdXFOODZrQTNIcXNKSlpERGwyb2FHQXhR?=
 =?utf-8?B?b3czTCtrRVpPMkZMQUZzekZ0MUE2bTUvMmhUK3FzeHlvMUtHRmRFcVNrY1k0?=
 =?utf-8?B?b3ZsWnY0OCs3RTU2OW1CSjdXM3B3RGZTMnFlMjhkLyt2dy9RT0VRRWtPSkEy?=
 =?utf-8?B?bEk4L0UzN2tKdlluVEVOZGJQVkExM3ZIZlIyK3NIVUYremx3Z0cwSE5Tck5o?=
 =?utf-8?B?YnhEVUdIOWo5eGRqV2p6c3I3UUI0OGV2Rk5ORXVNYkFvVDFSazNaU2IvSC9T?=
 =?utf-8?B?NkV2MVhRcGdHZERxMU5XUWp3Lzl2Rm5NaTFyVVQ2TmI1elJFRGFFOUxOcE5G?=
 =?utf-8?B?TDBzcWYvbG1ORy9RRUFtK2tia1AxdUtndXJhbGk3ZytGaEhoVXkwRVgvaUNl?=
 =?utf-8?B?c0VzeVd1RzhuOEdBK0NWNGpNcHhoVWRCSDdKK3RqY3NNL09EdHZIMHBkQWxC?=
 =?utf-8?B?OFN3YVNSWFVkVFdQV1FlclFSRlVkZnlQbGtKU3hzMjZaNWZsRUppajZja0VJ?=
 =?utf-8?B?WEhhbmJNZmlZUitRKzFISndsSjFRSU56OU9odVlOcTQ2RTFRVnd2K2IvemJU?=
 =?utf-8?B?dEdVamF0TEpWbXdqdUxtdkExcFZNT2VTZWs3ZzFQdHJZT1pkWjBOdXNRSkN6?=
 =?utf-8?B?Zk1iT0xyekYralFSWDRTc0Z6Y2hsdTlxNzcxcUZHOVRqMmtCd1hacWlFTk5p?=
 =?utf-8?B?NmNJVUhnTDZMRXU4MzJHVGFFVmlkMmF5ZDl3ajd6S05QdTIyMDJnM3Jsams4?=
 =?utf-8?B?UWNGUlkzNzhield0STd6SUhleDNIRkhLZ0c3ZHE5NXYrbzRsN1hiN0lHNFZy?=
 =?utf-8?B?bFNJK212UGJWS3FOM0RCREpPZ3BjVDRrWDlGZGhLZTVDSHZRSFFTa0xSOHdj?=
 =?utf-8?B?dDJPS3FDUHFKYUJzSW80eXYrQWkzWkgwM3JoWXdUQkFuWk5WQ2RBbzFKbUcy?=
 =?utf-8?B?aUJVSWJBNE1iU1EzOVhWY3d0aHZkQUVzUG5jaXdBSHVjM3RxSUQvanpLS1NQ?=
 =?utf-8?B?bit4MTNtUFhILzcxeUgxNDRuMGVBaHliTHdha0RSR0VDR3RleFlXdm5yMzly?=
 =?utf-8?B?QlpZQlQ2dkNFWmN0QnpPT0E2SU81SHltL0dXT3pERXYvV2c1MzJqcjBOT0tO?=
 =?utf-8?B?dnliSWtXTEphRndWb3FNRFFSd1huS3k2UmJmVXc4dmFJUkkvWVE1eElBRVZ3?=
 =?utf-8?B?TldoK1JrbVV0VS9vM0tUd1AvYmtYbWFyM3Zvc3JnOGlaNk4vK295SGZhQjlE?=
 =?utf-8?B?N3RIWElTb2tQaDJqMGh0anVxZ0hrVU9GT2hTeFBvbVBqVUVodThHOFFRSUkw?=
 =?utf-8?B?UVY4U29nYlp4aFlKZ05hWWpYVVZuL1NWUnBBWDBTWlBHY1pCRTFJVDRZRFhC?=
 =?utf-8?B?VW5aZGJzcllhb2N4MEZWWU9VZ1ZwVnVRNTB1Y3YzZjl2Q0lhZWZKaUNPV0FS?=
 =?utf-8?B?Y3J5UHJLSUN2b0w0OUhMRUhiNTVOUHNGeVBveFpGQmphMTdvcTRjNzdtRzhR?=
 =?utf-8?B?SFM4T0MwZi9SRGNmbVM0dkNKSVVubDc5SHlSWVlnTDlXN0d0blkwRm5xdi8z?=
 =?utf-8?B?WnFKVnJsTzYwd0I1ajNlQWhUQlA3UkoxekJycWZzZFcwZ2hkYTYxK2RPemZV?=
 =?utf-8?B?MDlLYmJZNGNRRHpQQ3NpR25RV3hxdHFLaUJqMTk0V3FWbWJtNjkyNDVPZlFi?=
 =?utf-8?B?Q0llTGxZY1Y2S2ZOTmN3dDNhU0NtMWo5NDUwaWVNM01XOUFQTzVkUEtpVUxl?=
 =?utf-8?B?SW5HYXAzZ3l4c1ZqeTkvYkNnNWpXS1NERHRha2hiU1BvelVmWFdKZlRDbGt4?=
 =?utf-8?B?bGFzTS81cCt2eHIzUGk2Ym1kdDJjNWxVTENzeU9yc0JOeHNGamtLSG1QdVNp?=
 =?utf-8?B?RjhucTVCSHF5NStHazBvZTFqVGZIU2dzYUFUbFpxVUlJdldtSTVuMlFiSnN6?=
 =?utf-8?B?RU53bzh0VlR5dUtnZVE0MkhJaTRRSkl3N2JsWkdMZ09UclJVRXVXRzdVRkht?=
 =?utf-8?B?Vm53SVZBVjBxajFIeHV4OEJRWDc5UnNQTkdBMmluTlpjSlI4Z2NjbVFQQWhT?=
 =?utf-8?B?TjVUOEhQVTJVQ1NQWlhMa1ZvNjh6cVdyZTdMa3ZrYmFEVDF2Q3VmRmIwOWN5?=
 =?utf-8?Q?K5mcbzxwxbzXQd0sL28WZgeDY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee0fb812-dc67-427b-dd3f-08dd51ec855a
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 20:24:04.8850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jsGH2WMo5EAQVt9SJlOtGKJDAOeH1771xbQDugaxhGAv4o6uHHfRanhv4SUv1ri12s96wFHv0ZXrlcTYsJMKjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6907

On Wed, Feb 19, 2025 at 11:56:50PM +0530, Manivannan Sadhasivam wrote:
> On Sun, Feb 02, 2025 at 08:34:24PM +0100, Lorenzo Bianconi wrote:
> > Configure PBus base address and address mask to allow the hw
> > to detect if a given address is on PCIE0, PCIE1 or PCIE2.
> >
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>
> - Mani
>
> > ---
> >  drivers/pci/controller/pcie-mediatek-gen3.c | 30 ++++++++++++++++++++++++++++-
> >  1 file changed, 29 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> > index aa24ac9aaecc749b53cfc4faf6399913d20cdbf2..9c2a592cae959de8fbe9ca5c5c2253f8eadf2c76 100644
> > --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> > +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/irqchip/chained_irq.h>
> >  #include <linux/irqdomain.h>
> >  #include <linux/kernel.h>
> > +#include <linux/mfd/syscon.h>
> >  #include <linux/module.h>
> >  #include <linux/msi.h>
> >  #include <linux/of_device.h>
> > @@ -24,6 +25,7 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/pm_domain.h>
> >  #include <linux/pm_runtime.h>
> > +#include <linux/regmap.h>
> >  #include <linux/reset.h>
> >
> >  #include "../pci.h"
> > @@ -127,6 +129,13 @@
> >
> >  #define PCIE_MTK_RESET_TIME_US		10
> >
> > +#define PCIE_EN7581_PBUS_ADDR(_n)	(0x00 + ((_n) << 3))
> > +#define PCIE_EN7581_PBUS_ADDR_MASK(_n)	(0x04 + ((_n) << 3))
> > +#define PCIE_EN7581_PBUS_BASE_ADDR(_n)	\
> > +	((_n) == 2 ? 0x28000000 :	\
> > +	 (_n) == 1 ? 0x24000000 : 0x20000000)

look like these data should be in dts ?

> > +#define PCIE_EN7581_PBUS_BASE_ADDR_MASK	GENMASK(31, 26)
> > +
> >  /* Time in ms needed to complete PCIe reset on EN7581 SoC */
> >  #define PCIE_EN7581_RESET_TIME_MS	100
> >
> > @@ -931,7 +940,8 @@ static int mtk_pcie_parse_port(struct mtk_gen3_pcie *pcie)
> >  static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
> >  {
> >  	struct device *dev = pcie->dev;
> > -	int err;
> > +	struct regmap *map;
> > +	int err, slot;
> >  	u32 val;
> >
> >  	/*
> > @@ -945,6 +955,24 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
> >  	/* Wait for the time needed to complete the reset lines assert. */
> >  	msleep(PCIE_EN7581_RESET_TIME_MS);
> >
> > +	map = syscon_regmap_lookup_by_phandle(dev->of_node,
> > +					      "mediatek,pbus-csr");
> > +	if (IS_ERR(map))
> > +		return PTR_ERR(map);
> > +
> > +	/*
> > +	 * Configure PBus base address and address mask to allow the
> > +	 * hw to detect if a given address is on PCIE0, PCIE1 or PCIE2.
> > +	 */
> > +	slot = of_get_pci_domain_nr(dev->of_node);

I am not sure if too much abuse domain_id here.

> > +	if (slot < 0)
> > +		return slot;
> > +
> > +	regmap_write(map, PCIE_EN7581_PBUS_ADDR(slot),
> > +		     PCIE_EN7581_PBUS_BASE_ADDR(slot));
> > +	regmap_write(map, PCIE_EN7581_PBUS_ADDR_MASK(slot),
> > +		     PCIE_EN7581_PBUS_BASE_ADDR_MASK);

look like
	syscon
	{
		csr1 : csr1 =
		{
			reg = <0x20000000, >; //or other property
		}

		csr2: csr2 =
		{
			....
		}
	}

	pcie1 {
		mediatek,pbus-csr = <&csr1>;
	}

	pcie2 {
                mediatek,pbus-csr = <&csr2>;
        }

	...

Or
	pcie1 {
                mediatek,pbus-csr = <&csr1 0x20000000>;
        }
	...

	you can use syscon_regmap_lookup_by_phandle_args() to get address.
Frank


> > +
> >  	/*
> >  	 * Unlike the other MediaTek Gen3 controllers, the Airoha EN7581
> >  	 * requires PHY initialization and power-on before PHY reset deassert.
> >
> > --
> > 2.48.1
> >
>
> --
> மணிவண்ணன் சதாசிவம்

