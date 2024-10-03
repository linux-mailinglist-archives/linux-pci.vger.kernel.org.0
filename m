Return-Path: <linux-pci+bounces-13779-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA1598F702
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 21:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B109D1F22029
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 19:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AE41AC8A2;
	Thu,  3 Oct 2024 19:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gRkX4Sl7"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2049.outbound.protection.outlook.com [40.107.249.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1FD1AC459;
	Thu,  3 Oct 2024 19:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727983838; cv=fail; b=sOalb3PicrWctY5Fh3lPLzjgAHoeY740RH6ojBfKqRQFdjMlzmhYj1p+PxrwTQJbx37EQtt00EzHs8fPIbXZhvz0qNXhspHgqj3WLr4v9pSQWgle5iXYKXp6rtz7PxFc6DFKlMkmHf+pjtqg6ahQ6vkFQGcwaoOGgeqzRWf+1y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727983838; c=relaxed/simple;
	bh=uOdhaDSDsQIrcoCUbBfUGUmmWhqA4vQFtezaMYmE3vA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XJBRoguCECbie4qA+4kgAXjxLOTgdDYaBEMzKcHuFr0rMF6bIQxhtpHSVvlz/pMvAE32V4JLjQvryyL/puUoKGydf0Rvo96EcZOztMJHIg8Zm7tEiLV9S7CvAsUCfptmBaOgKJtRVv0N9cphNH9EKplJRbkVC91+yubSQzifMws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gRkX4Sl7; arc=fail smtp.client-ip=40.107.249.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LH/IlcFuNWxpkjEwoRtex8UuN3LFQ4nfPePUKImDzu90J61RhrduYQ3EIJkAeXRa6EgYkN7JtWKykIu6GNMZgltb5GMHHEBZB236VPqkbNcvToxpkscjuIBw5/89c2+9dfy6mq2dD9gKQPS5OKprWb8Ffb2MJxd48DZt0QJrz9Kwlkfq7FtUn9eX8TIE+jjePNLkLC2Y6edb6GWUPJqJetiRsGjNX5+KeFJMwz44KpuFG3SuOWm6INdMkmSJczypmEMlUipDFNBlSsXMw4jCNH8/cRaEQH7ml1mQh2ahCE5JDG9PNa2pUHX/mOEwbueYhqZLS6GV1Bm7i2m/6HGoDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydbMQFG2nvg49/Pg//mFINAAk8TbnuNXwoLcpUcOC2U=;
 b=sbzUDCt/sYEsGDDjY8yLxDYCmUbP8FhQ39YWruYEM1DpuLToR6hSaxQKBDHucc9tY27VaVWjKYu1BNxyV6BAcCost3pbjReVWJLTDTcE0QjtuN7Xfi+4JuhUnEtoG9qVKo3S/KdUGkSJw0sBl4e18bA1SEfsPR0takOVL9nMtbqSgYBp2BqOFOYW70CYkMyL1elpY75+034Ef80zdUWkEw4BJdIMQqBplINBrFWyeGJzOcRQv09DIadurjugyob+s7b59vzVFavgUShRfPof0RA3jKxuiIFtpb8MeHKLBkf5TWXE6NDP/R27YMbts4XA6efgeCUHERhExm39fK/ocA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydbMQFG2nvg49/Pg//mFINAAk8TbnuNXwoLcpUcOC2U=;
 b=gRkX4Sl7hZLOH+fCc0bQFCmXBGLDHM99XzLP14glJWIW6oFSzm+C1DZaqcjuz2ClOqXsCrbMXdERJvU1TN4LS5XE+YwXTVqn7wAvfQuyz/nESH6yEafhrumwqVHLd0eV63SU2d6tAJmf/MmlsbGbbc9V2NB8MFp75SzAVNzZSJF3tS7o95wFtcIyGQV2z5wG48100dCo+glL4bFayNkBOzgZfVFGA3DGCCwlLlm35go+/0j7553GtgdyIJwEQK/B+/AD67kICL9IzvLOZD0vn2lU5Ps5ndpwGxKrkcGyTm7ktgUwl8OB6uF9Lo906oGlu6EcvDtE2Ff3YLPcIJTIlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10869.eurprd04.prod.outlook.com (2603:10a6:150:213::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 19:30:32 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 19:30:32 +0000
Date: Thu, 3 Oct 2024 15:30:23 -0400
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH v3 2/3] PCI: dwc: Using parent_bus_addr in of_range to
 eliminate cpu_addr_fixup()y
Message-ID: <Zv7wz45VRIDeFd4K@lizhi-Precision-Tower-5810>
References: <20240930-pci_fixup_addr-v3-0-80ee70352fc7@nxp.com>
 <20240930-pci_fixup_addr-v3-2-80ee70352fc7@nxp.com>
 <20241003055106.sm4x23sg4hh67els@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241003055106.sm4x23sg4hh67els@thinkpad>
X-ClientProxiedBy: BY5PR16CA0030.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::43) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10869:EE_
X-MS-Office365-Filtering-Correlation-Id: 84910ec9-3dd3-4b96-2429-08dce3e1d8f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RWVpM1VNQlRyTFRHZ1dQZGRiVFEvVXEyU0JFYnl0eTNQSW8vaDdNMWluS2hZ?=
 =?utf-8?B?VHpCdmJDUWxadjRNSVR1Z3NkZTBTbEVYVjUzQTVCczhYTU43T3VRQ09rUm5r?=
 =?utf-8?B?WHRTMHIvQ1ErOXBLeisyYjh0Vk9BWWJQdk54N0ZrUmJQSlczU3pzMTYrUlBF?=
 =?utf-8?B?M2VtQkFwTEwwRXJtSVRaQmJIOHBOV1NaWXl3V0Y0TExpeUZzSFJneFBZanho?=
 =?utf-8?B?cXlOeE1OSDFPLzg4SWJ5dDlwU05UbDVhc1lzWTlBb0pOaFlHQWh4T0tEZWVk?=
 =?utf-8?B?UzNzNU5IeGRBT1JlbmloZjFibGhRWEIzZFcyQkFTdlpjVXlTM3NOU2l6dEsw?=
 =?utf-8?B?aFFkemo3NFE5Ly9zajdOcmQ5aUM3T1AwRWtFaENsZ1BEMVVZYUlucXNUY1J4?=
 =?utf-8?B?QjFUdXJMeWppTlJ2R2tNVFZVREVzdHd4Wkk3ZEJQLzNSRHBhMjNpTm1ybXFr?=
 =?utf-8?B?RTNhekI2ZEw4dnZZUUJPcW04VmUyL2kyVGVNeGxtWS9YRnBPUDJTczZZZTRR?=
 =?utf-8?B?NEh2alRHZ0QwdGNwWGFlOWhtRDcyZUdkVlNKcTB3TXV5NlFMcW5yMWFjVWRL?=
 =?utf-8?B?WlI5b0IxRGQ4alBCaGZ3ZGlwU3NQM1kzSXZXYjVSa3d2R24zV1FTemZCNjVw?=
 =?utf-8?B?VFgzVDdMS1RLYVlQOEFOR2pwdHZ1UkJsMEY3RzhVak1ITzZQcEtZZ0hxVU9R?=
 =?utf-8?B?UjZsYi9KYncvdHhRRy9HSitrODVLVGR6OEduWTV3SnVlQm1ocCtLazhuL21u?=
 =?utf-8?B?TFloVEJCUEFrL2JWQkl1R2o1TG4rc0JGUUkyVXpIdnlMZmswS1RObFJyakRW?=
 =?utf-8?B?Snp2UTM2blJwOW5jWWlJZFRodlB4WmxEL1FSUmdLRHNuczhHQzMwQkc2NlpP?=
 =?utf-8?B?ZUo2eVRsZGhwQmFEUnRnS01XSHo2WVQ5Si9LOEdvYUFLTDFYNkRoa1cvdmpy?=
 =?utf-8?B?VGE5OW1qeXhIeVd3MHJ3d3h3dkVnaCsvcXc4R2dLZTZjSzZydWxiRG5jQmNX?=
 =?utf-8?B?eGxJSFlGR1Ewbk54V1lNNzltbTZrVzJuWFpKa3g0MExSandSS2wzd2ltRk1u?=
 =?utf-8?B?cHkvSDBVb3VWbG9PRGt3eVRrNCs4dEI2VkNnbFpESjBlSFRvaXFKa2ZBN1h4?=
 =?utf-8?B?RVZVWXRZaURCazFDbThPOVdFc08rdEVGV1Y0YnQ0T2MrZFlwOWVsQy9mdU9m?=
 =?utf-8?B?M2VEWUQ0RlhKTzIzTGdTcGE4eXRoWnVtTVpkOE1iNVJKZ0dYcDMyU0JzNWlv?=
 =?utf-8?B?ZHBaMGlaWVk0RGdMNlNiUVkrSkdTbStueVRndXNsSG9UMVVFYkZHeEtpWTVQ?=
 =?utf-8?B?dlI5UzIzY0krem5RZ2RBeXUwWTJNWkFkU2UyTUFIa1k2aDJEMEhPTTdQVjJy?=
 =?utf-8?B?R0RwVjBENGI0MFBOWDhSNzFNQUZRbGVwYnpadzZUckJHeWpxeDNFOEJpeGQz?=
 =?utf-8?B?dGRZalhUdWpxQWlDOXlCblhra3lydzViZEUvaU0xQjdKMEZYQUFlNzVxdFpu?=
 =?utf-8?B?V0UxR1JZNXQyeW1pbzJZMEgyUGJRNzBlVi9adWFKdktuVGpjVzRzeVgvK3cv?=
 =?utf-8?B?N3VMSUMzTFVxVzM3T3I5RTFnWHorVEVVcFdtUG82L21qeFJycFduRGxmN0JP?=
 =?utf-8?B?dXo3UG1MbnlmM2Jjem15QkJyTC9zRStGNVlNVWEvZGJIdHJhQmhUejlsbGJJ?=
 =?utf-8?B?SkxzV1cxaEF4QUJHeUhkYS9mdDNwbWJCMWgyeDJaUXJua2pVdStNSFpEbm93?=
 =?utf-8?B?UGt4c1lhQkJRWTJXQml2SzZZSlFtNGhxVlEyNVA3THdEODNScFZmdWkwWWpV?=
 =?utf-8?B?NkhPejlINEFPenJjWmVJdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3p5a20vZ3h1b0Nxam9PNzhXVklzVEVxMXMwSlE5TDdoUFdxMTA0SGRDTUR0?=
 =?utf-8?B?L1Ava3UybG5GYkpyTkdpcDYrZWROaG13dW84NlphcTBEQm9mcjZtM0xTYlF1?=
 =?utf-8?B?c1lQNFNHVWc5enVJdDNEaXZ4cGE3ZEtyZ2xxbCtLVDVROGdhSVpyUWJINkNk?=
 =?utf-8?B?UlFRb3htWldvd2dvUmhLV1JSY0NZbzdNNlBYR29RR0RtTUVkN3pidlc5RnFJ?=
 =?utf-8?B?M1pxSTJIQXBkRWdMWXBPaWY1Ym1uV2VJOERITkNwc1F6cWo5dGNuSTI0amo3?=
 =?utf-8?B?R01uRXVMWmlKekU2OUNYVi8rUVc1MWVVM3lOS1NjYUg2UjU4MmJxOUVta2tH?=
 =?utf-8?B?ZUVhZXVkTytMM3N2bW93bVRQRmtJWDlUK09uVjJ0NWM0bHB1VWduK3BNZ1Q2?=
 =?utf-8?B?cWFMMStZdDA2V3NFNkt1aE1WNDlOelBjczlPWXg0cTArRmhJdGZnUW5WV1hm?=
 =?utf-8?B?eE9Dd1BYRTY2bXBWc1JZN2JhQ1Y3RndRN1k3WmVhNGQ4ZXBZZG1YSVBkTXVh?=
 =?utf-8?B?VDBiVmV6cGFTb2xNM1B6NU43QlorQzh1NlBYUmdYL1d4SXlkcnV6a2ZrZ0JK?=
 =?utf-8?B?RCtOOTFDTlkzRkhJcGllZExsSWE4Ni9NWXZyRmo4ZGM2UFNUUWVhYitVSlda?=
 =?utf-8?B?SmVvdkxTd2N4SldqdjVKeU9SK0FTcGZQOUZmNmRKM2s4U3ovb0RhSzM3bW5k?=
 =?utf-8?B?MnhTVkNyTkp2ZWZFQmlDNTZnQTduOWNIbWtaMmxoZnJPNHhRV200U0k0Qlpo?=
 =?utf-8?B?Tmt6bnBFRWVPNTkxbkh5YUhHbGJrQXNDWEdoN3BUMDhmdXo4ZWhza0NHd0hG?=
 =?utf-8?B?NHV5QlpsOGQ5b0pObG1LcytsZkV0R0FyUlE1VEpvZUNtN1lweWdyYXIyTjlD?=
 =?utf-8?B?cFVBVmpTVXJxWTZ5Q05JL3BGeXRhNkN0VFkvZUlHekxLZFFwZkgwVFFwMnBy?=
 =?utf-8?B?Q2k3SmFoTDlTalJESU1YR1ZBcERlQzBMT2h2NmVVakpLc0MwSEZmYVFpeUhT?=
 =?utf-8?B?ejdISENVNVRtZ0NOWEhBV3NaclpoOWRjaFhreUx3ZG4xRHF3aXEyaWx1alNv?=
 =?utf-8?B?VHE2VGl1amNaeXYyaXptUThaOWJhR0QyQTgxVDREZzVwZ2tjaW1vYXRCSnNH?=
 =?utf-8?B?Und3RDZ1T0lGS0dOd0lSQ2pvN0NWRU5sUlhBMFlPdkhGRm9rM1ZQMHR5OFB0?=
 =?utf-8?B?bm9Ua3FuK250ZXVxMG9tdkNIQ1Zjc2RHWFpEZEQxQTJJbDVEYm93dUFDQk10?=
 =?utf-8?B?NEVQRXV2eGI3bWdVUXlaeVpyVEZMREV1SWdlOWI3OFZVMld1dGtSblhXdTJQ?=
 =?utf-8?B?VUY5YWJIMlMrK1BRTE4xZ1N4OC9IWDhhd2FuVWNWNlMwckRqU2wxNld5Tm5w?=
 =?utf-8?B?WDY2b2xsRnFxbGpkMkZwekhKMEVOOXlTV0x4VW5BMzJpaWEzd3lqa1dCc1Z2?=
 =?utf-8?B?aVdJWUZJYXk5dXp1akdRVUdMS0s1TUl6ZVU0aXRaOVdHYUVjNnU3VDY2VXpT?=
 =?utf-8?B?VlpQVVk1MVRWYjdVVUQrYUczU0l3b3VTMzRsZVM4WGJXOHM2NGxOSlMzVFpx?=
 =?utf-8?B?bWVtcW9IWGlOM1NHdVljSHo3OXJES01hNnA5eTNGYmpDQTVPYUdUMXgvcEto?=
 =?utf-8?B?QThoeE1BaEFHQnIxMzF2c3BGTnliVm03amJrREZ2MDMxNCthcWw3NmowZmNB?=
 =?utf-8?B?cUduYkhVMk1NUHFYKytmZjlZQmhkZk93cFo2aUZqS254TCtndCtpOXZ4bzMx?=
 =?utf-8?B?UmhVYTFndXFpb1FSdUp2VC96TjlJbFI4d3VNV1p3Zjk3Y0oyTTdyV2VqQkd0?=
 =?utf-8?B?R2JIckpiWHJkL2NaaEoza2NRdlNvVmt2R1FRZnp3VUhVSlovRDBvNmdSRWVL?=
 =?utf-8?B?dFl2SWFpOEhiUmhHL1g3cUYyUWg3ZlhJWk5YMWdKT1Qyd0FSMkJMWnRsTHM5?=
 =?utf-8?B?YmdrZVlEQTlOMGNYbHpXU3JOOFRCYVJ0UHhpUkpKam9aMWJCSitJUVJaQUl0?=
 =?utf-8?B?bDV2bEtManJYcDl0aE4rTkg5Z25jVXMyZXhFZ0VnT2RGWTF6VktLRUJSMVY4?=
 =?utf-8?B?aXFGSzJnaFpwQUR5TGhHR0NjK3laV2RyRWFrL2trTUtHdTZqb2kxMk1UUUhK?=
 =?utf-8?Q?Modun0bQkxp/+20jrQT0i8XkV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84910ec9-3dd3-4b96-2429-08dce3e1d8f8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 19:30:32.8429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t5Q5Bc1H/uhVytK/P1EeDXx4gxJUr83ay3+bDb4UN+1yksyv+ECIVLxNLZE4Iab67IRJcqnHHTcCG5QnkKDjzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10869

On Thu, Oct 03, 2024 at 11:21:06AM +0530, Manivannan Sadhasivam wrote:
> On Mon, Sep 30, 2024 at 02:44:54PM -0400, Frank Li wrote:
> > parent_bus_addr in struct of_range can indicate address information just
> > ahead of PCIe controller. Most system's bus fabric use 1:1 map between
> > input and output address. but some hardware like i.MX8QXP doesn't use 1:1
> > map. See below diagram:
> >
> >             ┌─────────┐                    ┌────────────┐
> >  ┌─────┐    │         │ IA: 0x8ff0_0000    │            │
> >  │ CPU ├───►│   ┌────►├─────────────────┐  │ PCI        │
> >  └─────┘    │   │     │ IA: 0x8ff8_0000 │  │            │
> >   CPU Addr  │   │  ┌─►├─────────────┐   │  │ Controller │
> > 0x7ff0_0000─┼───┘  │  │             │   │  │            │
> >             │      │  │             │   │  │            │   PCI Addr
> > 0x7ff8_0000─┼──────┘  │             │   └──► CfgSpace  ─┼────────────►
> >             │         │             │      │            │    0
> > 0x7000_0000─┼────────►├─────────┐   │      │            │
> >             └─────────┘         │   └──────► IOSpace   ─┼────────────►
> >              BUS Fabric         │          │            │    0
> >                                 │          │            │
> >                                 └──────────► MemSpace  ─┼────────────►
> >                         IA: 0x8000_0000    │            │  0x8000_0000
> >                                            └────────────┘
> >
> > bus@5f000000 {
> > 	compatible = "simple-bus";
> > 	#address-cells = <1>;
> > 	#size-cells = <1>;
> > 	ranges = <0x5f000000 0x0 0x5f000000 0x21000000>,
> > 		 <0x80000000 0x0 0x70000000 0x10000000>;
>
> Does this address translation apply to all peripherals in the bus or just PCIe?

No difference. Actually only PCIe under this bus fabric.

> If it is just PCIe, why can't you encode the mapping in the below PCIe node
> 'ranges' property itself?

Even it change by bus fabric, you still treat it as by PCIe. But it can't
remove ugly .cpu_fixes_up() function, becuase IO range can't know actual
address input to PCI controller.

If dt correct descript hardware behavior, we will not need .cpu_fixed_up()
at all.

>
> - Mani
>
> >
> > 	pcie@5f010000 {
> > 		compatible = "fsl,imx8q-pcie";
> > 		reg = <0x5f010000 0x10000>, <0x8ff00000 0x80000>;
> > 		reg-names = "dbi", "config";
> > 		#address-cells = <3>;
> > 		#size-cells = <2>;
> > 		device_type = "pci";
> > 		bus-range = <0x00 0xff>;
> > 		ranges = <0x81000000 0 0x00000000 0x8ff80000 0 0x00010000>,
> > 			 <0x82000000 0 0x80000000 0x80000000 0 0x0ff00000>;
> > 	...
> > 	};
> > };
> >
> > Term internal address (IA) here means the address just before PCIe
> > controller. After ATU use this IA instead CPU address, cpu_addr_fixup() can
> > be removed.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Change from v2 to v3
> > - %s/cpu_untranslate_addr/parent_bus_addr/g
> > - update diagram.
> > - improve commit message.
> >
> > Change from v1 to v2
> > - update because patch1 change get untranslate address method.
> > - add using_dtbus_info in case break back compatibility for exited platform.
> > ---
> >  drivers/pci/controller/dwc/pcie-designware-host.c | 42 +++++++++++++++++++++++
> >  drivers/pci/controller/dwc/pcie-designware.h      |  8 +++++
> >  2 files changed, 50 insertions(+)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index 3e41865c72904..823ff42c2e2c9 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -418,6 +418,34 @@ static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
> >  	}
> >  }
> >
> > +static int dw_pcie_get_untranslate_addr(struct dw_pcie *pci, resource_size_t pci_addr,
> > +					resource_size_t *i_addr)
> > +{
> > +	struct device *dev = pci->dev;
> > +	struct device_node *np = dev->of_node;
> > +	struct of_range_parser parser;
> > +	struct of_range range;
> > +	int ret;
> > +
> > +	if (!pci->using_dtbus_info) {
> > +		*i_addr = pci_addr;
> > +		return 0;
> > +	}
> > +
> > +	ret = of_range_parser_init(&parser, np);
> > +	if (ret)
> > +		return ret;
> > +
> > +	for_each_of_pci_range(&parser, &range) {
> > +		if (pci_addr == range.bus_addr) {
> > +			*i_addr = range.parent_bus_addr;
> > +			break;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  int dw_pcie_host_init(struct dw_pcie_rp *pp)
> >  {
> >  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > @@ -427,6 +455,7 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> >  	struct resource_entry *win;
> >  	struct pci_host_bridge *bridge;
> >  	struct resource *res;
> > +	int index;
> >  	int ret;
> >
> >  	raw_spin_lock_init(&pp->lock);
> > @@ -440,6 +469,13 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> >  		pp->cfg0_size = resource_size(res);
> >  		pp->cfg0_base = res->start;
> >
> > +		if (pci->using_dtbus_info) {
> > +			index = of_property_match_string(np, "reg-names", "config");
> > +			if (index < 0)
> > +				return -EINVAL;
> > +			of_property_read_reg(np, index, &pp->cfg0_base, NULL);
> > +		}
> > +
> >  		pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
> >  		if (IS_ERR(pp->va_cfg0_base))
> >  			return PTR_ERR(pp->va_cfg0_base);
> > @@ -462,6 +498,9 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> >  		pp->io_base = pci_pio_to_address(win->res->start);
> >  	}
> >
> > +	if (dw_pcie_get_untranslate_addr(pci, pp->io_bus_addr, &pp->io_base))
> > +		return -ENODEV;
> > +
> >  	/* Set default bus ops */
> >  	bridge->ops = &dw_pcie_ops;
> >  	bridge->child_ops = &dw_child_pcie_ops;
> > @@ -733,6 +772,9 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> >  		atu.cpu_addr = entry->res->start;
> >  		atu.pci_addr = entry->res->start - entry->offset;
> >
> > +		if (dw_pcie_get_untranslate_addr(pci, atu.pci_addr, &atu.cpu_addr))
> > +			return -EINVAL;
> > +
> >  		/* Adjust iATU size if MSG TLP region was allocated before */
> >  		if (pp->msg_res && pp->msg_res->parent == entry->res)
> >  			atu.size = resource_size(entry->res) -
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > index c189781524fb8..e22d32b5a5f19 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -464,6 +464,14 @@ struct dw_pcie {
> >  	struct reset_control_bulk_data	core_rsts[DW_PCIE_NUM_CORE_RSTS];
> >  	struct gpio_desc		*pe_rst;
> >  	bool			suspended;
> > +	/*
> > +	 * Use device tree 'ranges' property of bus node instead using
> > +	 * cpu_addr_fixup(). Some old platform dts 'ranges' in bus node may not
> > +	 * reflect real hardware's behavior. In case break these platform back
> > +	 * compatibility, add below flags. Set it true if dts already correct
> > +	 * indicate bus fabric address convert.
> > +	 */
> > +	bool			using_dtbus_info;
> >  };
> >
> >  #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
> >
> > --
> > 2.34.1
> >
>
> --
> மணிவண்ணன் சதாசிவம்

