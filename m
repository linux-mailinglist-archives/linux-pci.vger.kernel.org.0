Return-Path: <linux-pci+bounces-18788-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2615B9F80ED
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 18:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 233B616D5CF
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 17:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC10A15252D;
	Thu, 19 Dec 2024 17:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KCELNZs9"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2086.outbound.protection.outlook.com [40.107.22.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1F41537C3;
	Thu, 19 Dec 2024 17:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734627735; cv=fail; b=P9ezeI/hYzSFrIcFCdMcQkqfSMCX4snq3A2EzE03GfScfm401MEvVbmT5gzoILn6yzSND5bmx5mHzDwgCMi/w2olcYsVZq0dxFDBPOHEDyVC3C8ImBHNONt7rTTHcmu3fN6YrpWEpWVlILEA6gHXPxee0KrK4JT9GDE24IV/FKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734627735; c=relaxed/simple;
	bh=DoeTxVbuIjwbEAJnRgmwZRx/C20VdeRZWO6fDwq9fec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aRWTvSEHaNY+x9gQuxG74m77jIXJwDqpEZxBBBhUsEHm6eeXxLslCxjYy6P3rppzOZuw1RtatEvFUJR3vo4nkjXS99MGiVQnHgAFtk2zdZhvDzWrsJAwvKP1NJRESeC5o5zsKqH4GtvgezEqaPPcmZyjHyXlke4CdVmkL38G3vo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KCELNZs9; arc=fail smtp.client-ip=40.107.22.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JtaSgeAE2blO1fGK6THDXUlZ/pgviph3u9rM1CE/OsiNs07Bl9gY4GdAMfMoPKQU05cpxEA5sgMO80dqK12mwJBoGN1zU92wrAximsxeUE75ukm2DW4ZVKM9XpFJ3QN0yuRqceCF50qdx+v5derBx6fR5bY3ngH9sutdpQyP4cEgVhWj+Yvw7ive1/+qk6s5PUAPAAvOtiINPygNzYvY61NsKRywGdGMQQFIbHwuRJemld9mmLFzTp5AytXmbch9HOwn+nvnZcGm3LDJjES4ppeydmR+urcmJOGgj7W8ds0ZxLrWVBLX1s86kWlwCfXJcGu5DqXY2b1FlXFnan9jRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5Az84xyh8MQaZ+c/mrKtLTJ+ek3OUjQ/bPLfWm1F5I=;
 b=nrU1WdqHML9t4D26tb6Hr25r/RrJwxqd4Cm1rbzRro9lnA7aR0AbwJCvcbU7ZjFmoBxfvixACR3EixgX2kGLGBXlkJlK/vKt16EWOU8jC2eyrB0mwnSHoe6tNKUbbe7rErILK/Tu1DDQsRM1q2IoMY4DGS1KbsCgeAWYL7cwp4pqiO7Ou77RsGEghFp1tkS9jEEowxXmI5s9oGiOZS5uA1PaNHmDNj/fF+uhs7PiZvOhiD+iNY8Hrav3fRepuxCwn/67cWTCAzYoE44iGqFUdvwtcjUXTinfe2CGnxbYZQawPfWMGYq+4Ij9V4QcQXa4sNELMVcl+JxRKfaueS1xuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5Az84xyh8MQaZ+c/mrKtLTJ+ek3OUjQ/bPLfWm1F5I=;
 b=KCELNZs9vGwHeP5jkcS10dLExx3CQ/5yMV83EWJ1X7w1LqR3L6Z8UOgXo/neMAo6DMgAPy4+WqAarIov1OQ2g99wqlyMJhgCnk/xvlAe4FLMXZuz+vo1FpvRo77r3Yl6wddKgnO7E707qpfdz6HBJwt7Ei8YAAzJVbmlNd0x4Hs0EoYEY/1BvnS1vKpFjfXXk5moVj6KkLllEAJxpW2GyBBBgV8CCkKNBhWFGjm961pCFX0hnaFaHf2tLnuCA0bivu9UryOZJlUialKUBhbv5Aj0ec+UxpvhChcNEkE88mOGMcqGbe5H37Sv0GAfZ59RHJ62XTG1mhdPoFok5hn73Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9021.eurprd04.prod.outlook.com (2603:10a6:102:217::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Thu, 19 Dec
 2024 17:02:09 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 17:02:09 +0000
Date: Thu, 19 Dec 2024 12:02:02 -0500
From: Frank Li <Frank.li@nxp.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anup Patel <apatel@ventanamicro.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, imx@lists.linux.dev,
	Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org,
	jdmason@kudzu.us, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v13 4/9] irqchip/gic-v3-its: Add
 DOMAIN_BUS_DEVICE_PCI_EP_MSI support
Message-ID: <Z2RRimPlT41Ru281@lizhi-Precision-Tower-5810>
References: <20241218-ep-msi-v13-0-646e2192dc24@nxp.com>
 <20241218-ep-msi-v13-4-646e2192dc24@nxp.com>
 <868qscq70x.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <868qscq70x.wl-maz@kernel.org>
X-ClientProxiedBy: SN7PR04CA0091.namprd04.prod.outlook.com
 (2603:10b6:806:122::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9021:EE_
X-MS-Office365-Filtering-Correlation-Id: 79bea840-0fd2-484c-5c01-08dd204ee00d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c04zeFZZaHFVNElJOFhQVzFTcmZGUHRhQldnVEpua1BmcjA1aG9OOC8yYlhJ?=
 =?utf-8?B?ZDE1bm9xdGtWTkRMZm51d1paOC83SDlrRldBNGRuNVV4UTlxZnlvMlRDNjRa?=
 =?utf-8?B?SkxtYkVIaHMyMUl1Uk9QcTFQRGxNbHkwNjhOUHhFamhvNWw4TmdQSGhIa082?=
 =?utf-8?B?T1VlUnFUNnJVNHZVYy8ycThTdmRhanJVUUVvOVV2UVJ2cjNWN0hCRXlTeXhP?=
 =?utf-8?B?bFVoVnhkZXZPeTBNYnAzUmk0NDA4VmNYa2VINEZEZndTZHlVa1hSdEtSdzRz?=
 =?utf-8?B?MDc5ZWM1Y1hDMElkdHdBT3A4Wkl0NDh2OFVuUnIvUmNmT2FvSUgraU4rcnJQ?=
 =?utf-8?B?ZVZQbkVtYlBKandYUHJLOWs4REJ4WndQb0licE5LQTZhUWdXZksrKytDMkQz?=
 =?utf-8?B?SEN4WG1VbUk0WXBXdGhqTmdLV3ZpR0IxY1FTaHExRVFNQzJ1OGdZVmtxTXBr?=
 =?utf-8?B?K3k4TjducE5sT1dOazNRV0dTRVdLMm0zYnM2eTBlaVhWSE91QzQrWFBOYnRk?=
 =?utf-8?B?VVFVYWwydHc0alorREMrYXlxMC9PVmFPR0cvSXQwbDF1WlBabW16T3VTeGVi?=
 =?utf-8?B?UnhtK0lCeEdsc3RyN1lBcCs3c3NFWUNRTEtwV3VKOVdnTm10VkhQRFI5aDVs?=
 =?utf-8?B?TXVySm4vdkFObmF5eDlEdUd6NnFhS1JpaDYrc1hkTUtTWnJCMHFaZHByRWcz?=
 =?utf-8?B?T1NPbTQwZit6aDhmRVdDSVY1SkRzSVVRckRaa296K1R1b2ZsSWZXdHduRTlB?=
 =?utf-8?B?bmg1OFVmY29HYzN3U2paRHF3U1VKOXF6Sy9rODFWaS8xZXdQNUxiQlJ3UnN1?=
 =?utf-8?B?T3o2UlRUVWZYY3BQczRpekVBNDlTSlZuWnlHNFYxb293OU93Qmc0UkdPeXlu?=
 =?utf-8?B?UW5KTGdXS1B0NTFaMHlJSUc1RkJLN1ViRDVqbVAxNERCKy82b0ErZlNSSlk0?=
 =?utf-8?B?d3BKK3VDTW1ZVDc5dzdCd0RqajZsQWQwL2sxZzRvUG1La2NaUzEzM0RTVXdm?=
 =?utf-8?B?WkkzUmlsUkptVDdqMTFSMWxnWkpXQ2VTdVF1N1BXaHFRajZlUVJuSmF3MWJy?=
 =?utf-8?B?NU9QWG9ibXNkZ3pzc0xVK1RCei9zZVNvTE5WN2RXN1lrNUpvS010K0FodWto?=
 =?utf-8?B?VWZmMTExYzFNdkRyWUp3aDhxZ3AzNWJGU25iZjVuM2RPc0hhSWwwc21iTnpZ?=
 =?utf-8?B?cGg5ZFZtTmxRdzEzNWZXSVpIdjAyVU9YT0xDR1F5azFoem9PZ3AzSEg3Rlow?=
 =?utf-8?B?TC9CMjdaazd1NW5ncGlBYWRoWkhDKzdPcVBKeU96VGNUeG5hNWxvQnRRekdG?=
 =?utf-8?B?SWoySmFzbDQ5ODNTK3pQNFVReFhiQStRUHEvWXFCSzhpSmVtelBTOG1EcVVy?=
 =?utf-8?B?d3FyOVpoR2F5ZlQ0N3E4RGhZMHNhbzE1Umg1SktVQmRYRkp2UElmTlduVE9I?=
 =?utf-8?B?WXcxZiswTitQaDFrTGplYW1qK1VmNXhibjViOHRNQlJHRTVRaFUzNmVTWXlO?=
 =?utf-8?B?d2NoVVRYU3JKTWhLVElRY0YzTzgrd0Z3WEVxa2RIbmZVRjNqZ2oxbG1MaVI2?=
 =?utf-8?B?bXZYNGZleTlnREo1ZTRZNEZiTzlDbkFCaS82OTRrUSthZjFMYW5PekpEckxw?=
 =?utf-8?B?ZXl2UTQ2ZGhGZzNWT3JIVkdCb3Y5eHVDMTh6ZTVYSGhKTGlTenZzWEQxOWta?=
 =?utf-8?B?TjhFVTdzU0o2UHR0Q2RtYUNxUndTNmwzSkVURk5tdnFINDRwbldPRTM4WHJh?=
 =?utf-8?B?ajluSDN1Rmd5czVVWUNYazYvbEtHQWYrcEpVeVJidkN1OHVGbDFla1JLOTRD?=
 =?utf-8?B?OERPc09BTll3S3lKTGp5dm9IZUlaT2VORmZ5ZWRsYmtGMjFZQ2JOUVhHS2w1?=
 =?utf-8?B?azBFVTBDQ0k1OVdjRHY0bFVoRXF2MGRJb1pmQkNuRzF6RmlSa1o1K3c3Ullm?=
 =?utf-8?Q?fSkpK1YHl1b7Q0coSJ7udWKJj60BINCI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzljNG5PMFJ5OEc0ZklkK0ZKeDZraXN5Yytnb0tHcGZtd0FJam9VVHJ4R1F3?=
 =?utf-8?B?NTZraXkwbnByVlVsNC9DVUVvK3Aya3hFRDBzYzM2OWFSNVQ4Q3llS0tIazlG?=
 =?utf-8?B?NWYyRjdsYkhWK1JnZVJaak1aWFp6OWV6NlkvUUZIcWlSMFBxVUV0UjVYZzFQ?=
 =?utf-8?B?WDhIbVZaQy9jREExMUlFd0o5VzdBZUo3OGo0Zkl1VVp2YkdPek1pR2NhQVhi?=
 =?utf-8?B?NERxVWYyajdQOWR5SEowdmJWTUVlblBJZTlRbFFRS0c0TnY5bjVrbzNCeWg3?=
 =?utf-8?B?SXJFVFMya0kvV2NKajlwTjhrZC9tMmlhR2dOb3l5K3dhOUJRSGgxT0N0L25Z?=
 =?utf-8?B?R0ZlUmJDK2ptUnQwMG0zLzY3M0cwL1F4UGg5VXQ4bXBMVk9GcVBYRTB4WXUv?=
 =?utf-8?B?K3BwZTJTSmpVVHU2R0RFV2hjMEErRVZCWTlhaStTQnRONi9Hb0JhcmhtMXJi?=
 =?utf-8?B?UWd4eTJVWmFzdlpOVTFoZmtPMzhZWlF1SzZvNURlclZuK1Iwd1VkRkRESWlU?=
 =?utf-8?B?VVYwbDNkL0tTMXV1V0MxdjZyQ0IvazhXaHIvNXh4UkcrZ1JTbjVJU0xLTTQy?=
 =?utf-8?B?bUpqWk9xOXJBWElvbzhKYWZHa0tMRUVFcVV6ZGlqOC9xN2swMDdKOENQd1RY?=
 =?utf-8?B?ODFTS1dnOW8wQ2ZZL3hIM2NPQU1WQkVWYlR3Yml2Wld0eTNVZHBsMm5vZ2pS?=
 =?utf-8?B?ZEljekF1RzBHRVAwa0hlelQyMkQreVlFeGpQMTN1R0hleTJiTmhBSFVCbUpm?=
 =?utf-8?B?VDlCSFk1WkZyQ3dNbENqT1RLMzdTdWNMN3hIRjFNUmEzZ2dNc3Q1YXZSYVls?=
 =?utf-8?B?SlVQZFFaZ1poalVZcjZIWmtCK0lPS3RiWUwvbEtPSmNqQXRzZTZJT1ZHNlFG?=
 =?utf-8?B?REE2ejVZSkxpbTNqTmo3YlhKSHBPR1p0eTAwazZOT3dHcHY1VXpucUV0azY0?=
 =?utf-8?B?SnJGanFsYkNhWjhKbFdyYkxjTzhtc3FiUFptS1d4V2FUR0JUOW5acVhVd1VD?=
 =?utf-8?B?YWRrZU03WDBDcS9NNW9FYVZERkZYY1RTTkdJcU96T05mZ1ppZ0RoRFUzNGtD?=
 =?utf-8?B?dGxvRjBmWlFKclQ2eWVrVURPNkZZUjE0MjFTUGpJbkloUmlleXdJeFBjNUg2?=
 =?utf-8?B?WjBrdGVjcnhoaW0zUnN0Mnh6WVpySXlabGtiOVRmOXgrLzVnMnhrNVlXUjV3?=
 =?utf-8?B?SUQ0WWFpUzhnQVFUWWI5dWJwUkF3TFFyOGs3UEM2TDRaeWNjUThqeForUllj?=
 =?utf-8?B?MVZaeCtDQ0dYQ016WDJ6VllFaWlZTkp6NEhZMitPUDgxb0JTOStHOEx4T3hB?=
 =?utf-8?B?Q3JPSElpUDdiQTBXazlOOGVRY3VPNUZlQzVXWThGWEJQQTR1amdJN01uL0t0?=
 =?utf-8?B?M2dQNXJXdkxvV2hSL1ViQVlNRS9iaUx4L25uVkM2RGsxbURMREJUQ1htYnFW?=
 =?utf-8?B?K2ZGcEdtemdTSzh3ODJVM2FuSkg2VWdPVkxmVGM5ODZNTS9QZTBkdUd1djEy?=
 =?utf-8?B?VE9YMG02UmtSNmlnU2ZXSUZDdFQ3Skd1YXM0eGVHUGJ1ODNJUXp3VHpwRW54?=
 =?utf-8?B?QXpPZHFXM2VLZFBBRk9kVk5PdFprUnEwMHE2eWd6eEZuTFEyWXVVODdTaXF4?=
 =?utf-8?B?NVZkQUI2cXdaMk9zY3BHZmpPZHB5VzdOM3B5RG9ac1FKVlRUT0QyNUpIY2d4?=
 =?utf-8?B?MlM1czBhVWdtcEp5TlZqR3BEcmNVQzRCSzVUU0FyRTdGcmtGZGoyay90dUlM?=
 =?utf-8?B?NHFOODZWRmhwZW51NHltRWtleHBhcDV0WTA5RzVURUxGWi96MWxHSkxrenh0?=
 =?utf-8?B?cHRMQkp5OU9TVDI2eHo1YjhES1FERWg4YlRZbjRPSzNCMUVoOFdJSWI4amFj?=
 =?utf-8?B?d3hlZ1luQ1BRN3lJUUpRb3Foc0hXVlNybDhkeHRqbzN2VkdqNjEzTmwzZjV3?=
 =?utf-8?B?SUxMRDFZOVl6MEdOR2d4b0xnZStpR2NwZ1NTdWZLK1pwYzc5V2djZzg1ZGs3?=
 =?utf-8?B?dkcrSUxieWM5ZkRUSWpvdEVIT21tNDJPMytvUk1FN0o1TzlBeHdWR3RFMXNY?=
 =?utf-8?B?OVg3NzlEbVROSmtLTnRHaGprd3phclQ0VWpmR3JrZ2k3M05PdWFKSlNXcXNk?=
 =?utf-8?Q?LjBGFWqG1i0hr3WOtxvPrxUfi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79bea840-0fd2-484c-5c01-08dd204ee00d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 17:02:09.6789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ulbhnCZm6fdtV17c6tHM7v0wST3CzuwkP/4hN7KLf6TxhOAYv795u7C4Kk+pR7XWcCKAywJeO8JoYnIw8sL3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9021

On Thu, Dec 19, 2024 at 10:52:30AM +0000, Marc Zyngier wrote:
> On Wed, 18 Dec 2024 23:08:39 +0000,
> Frank Li <Frank.Li@nxp.com> wrote:
> >
> >            ┌────────────────────────────────┐
> >            │                                │
> >            │     PCI Endpoint Controller    │
> >            │                                │
> >            │   ┌─────┐  ┌─────┐     ┌─────┐ │
> > PCI Bus    │   │     │  │     │     │     │ │
> > ─────────► │   │Func1│  │Func2│ ... │Func │ │
> > Doorbell   │   │     │  │     │     │<n>  │ │
> >            │   │     │  │     │     │     │ │
> >            │   └──┬──┘  └──┬──┘     └──┬──┘ │
> >            │      │        │           │    │
> >            └──────┼────────┼───────────┼────┘
> >                   │        │           │
> >                   ▼        ▼           ▼
> >                ┌────────────────────────┐
> >                │    MSI Controller      │
> >                └────────────────────────┘
> >
> > Add domain DOMAIN_BUS_DEVICE_PCI_EP_MSI to allocate MSI domain for Endpoint
> > function in PCI Endpoint (EP) controller, So PCI Root Complex (RC) can
> > write MSI message to MSI controller to trigger doorbell IRQ for difference
> > EP functions.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > change from v12 to v13
> > - new patch
>
> This might be v13, but after all this time, I have no idea what you
> are trying to do. You keep pasting this non-ASCII drawing in commit
> messages, but I still have no idea what this PCI Bus Doorbell
> represents.

PCI Bus/Doorbell is two words. Basic over picture is a PCI EP devices (such
as imx95), which run linux and PCI Endpoint framework. i.MX95 connect to
PCI Host, such as PC (x86).

i.MX95 can use standard PCI MSI framework to issue a irq to X86. but there
are not reverse direction. X86 try write some MMIO register ( mapped PCI
bar0). But i.MX95 don't know it have been modified. So currently solution
is create a polling thread to check every 10ms.

So this patches try resolve this problem at the platform, which have MSI
controller such as ITS.

after this patches, i.MX95 can create a PCI Bar1, which map to MSI
controller register space,  when X86 write data to Bar1 (call as doorbell),
a irq will be triggered at i.MX95.

Doorbell in diagram means 'push doorbell' (write data to bar<n>).

>
> I appreciate the knowledge shortage is on my end, but it would
> definitely help if someone would take the time to explain what this is
> all about.

I am not sure if diagram in corver letter can help this, or above
descriptions is enough.


┌────────────┐   ┌───────────────────────────────────┐   ┌────────────────┐
│            │   │                                   │   │                │
│            │   │ PCI Endpoint                      │   │ PCI Host       │
│            │   │                                   │   │                │
│            │◄──┤ 1.platform_msi_domain_alloc_irqs()│   │                │
│            │   │                                   │   │                │
│ MSI        ├──►│ 2.write_msi_msg()                 ├──►├─BAR<n>         │
│ Controller │   │   update doorbell register address│   │                │
│            │   │   for BAR                         │   │                │
│            │   │                                   │   │ 3. Write BAR<n>│
│            │◄──┼───────────────────────────────────┼───┤                │
│            │   │                                   │   │                │
│            ├──►│ 4.Irq Handle                      │   │                │
│            │   │                                   │   │                │
│            │   │                                   │   │                │
└────────────┘   └───────────────────────────────────┘   └────────────────┘
(* some detail have been changed and don't affect understand overall
picture)

>
> From what I gather, the ITS is actually on an end-point, and get
> writes from the host, but that doesn't answer much.

Yes, baisc it is correct. PCI RC -> PCIe Bus TLP -> PCI Endpoint Ctrl ->
AXI transaction -> ITS MMIO map register -> CPU IRQ.

The major problem how to distingiush from difference PCI Endpoint function
driver. There are have many EP functions as much as 8, which quite similar
standard PCI, one PCIe device can have 8 physical functions.

>
> > ---
> >  drivers/irqchip/irq-gic-v3-its-msi-parent.c | 19 ++++++++++++++++++-
> >  1 file changed, 18 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/irqchip/irq-gic-v3-its-msi-parent.c b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
> > index b2a4b67545b82..16e7d53f0b133 100644
> > --- a/drivers/irqchip/irq-gic-v3-its-msi-parent.c
> > +++ b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
> > @@ -5,6 +5,7 @@
> >  // Copyright (C) 2022 Intel
> >
> >  #include <linux/acpi_iort.h>
> > +#include <linux/pci-ep-msi.h>
> >  #include <linux/pci.h>
> >
> >  #include "irq-gic-common.h"
> > @@ -173,6 +174,19 @@ static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
> >  	return its_pmsi_prepare_devid(domain, dev, nvec, info, dev_id);
> >  }
> >
> > +static int its_pci_ep_msi_prepare(struct irq_domain *domain, struct device *dev,
> > +				  int nvec, msi_alloc_info_t *info)
> > +{
> > +	u32 dev_id;
> > +	int ret;
> > +
> > +	ret = pci_epf_msi_domain_get_msi_rid(dev, &dev_id);
>
> What this doesn't express is *how* are the writes conveyed to the ITS.
> Specifically, the DevID is normally sampled as sideband information at
> during the write transaction.

Like PCI host, there msi-map in dts file, which descript how map PCI RID
to DevID, such as
	msi-map = <0 $its 0x80 8>;

This informtion should be descripted in DTS or ACPI ...

>
> Obviously, you can't do that over PCI. So there is a lot of
> undisclosed assumption about how the ITS is integrated, and how it
> samples the DevID.

Yes, it should be platform PCI endpoint ctrl driver jobs.  Platform EP
driver should implement this type of covert. Such as i.MX95, there are
hardware call LUT in PCI ctrl,  which can convert PCI' request ID to DevID
here.

On going patch may help understand these
https://lore.kernel.org/linux-pci/20241210-imx95_lut-v8-0-2e730b2e5fde@nxp.com/

If use latest ITS MSI64 should be simple, only need descript it at DTS
(I have not hardware to test this case yet).
pci-ep {
	...
	msi-map = <0 &its, 0x<8_0000, 0xff>;
			      ^, ctrl ID.
	msi-mask = <0xff>;
	...
}

>
> My conclusion is that this is not as generic as it seems to be. It is
> definitely tied to implementation-specific behaviours, none of which
> are explained.

Compared to standard PCI MSI, which also have implementation-specific
behaviours, which convert PCI request ID to DevID Or stream ID.
https://lore.kernel.org/linux-pci/20241210-imx95_lut-v8-0-2e730b2e5fde@nxp.com/
(I have struggle this for almost one year for this implementation-specific
part)

Well defined and mature PCI standard, MSI still need two parts, common part
and "implementation-specific" part.

Common part of standard PCI is at several place, such its driver/msi
libary/ kernel msi code ...

"implementation-specific" part is in PCI host bridge driver, such as
drivers/pci/controller/dwc/pcie-qcom.c

This solution already test by Tested-by: Niklas Cassel <cassel@kernel.org>
who use another dwc controller, which they already implemented
"implementation-specific" by only update dts to provide hardware
information.(I guest he use ITS's MSI64)

Because it is new patches, I have not added Niklas's test-by tag. There
are not big functional change since Nikas test. The major change is make
msi part better align current MSI framework according to Thomas's
suggestion.

Frank
>
> Thanks,
>
> 	M.
>
> --
> Without deviation from the norm, progress is not possible.

