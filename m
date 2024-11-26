Return-Path: <linux-pci+bounces-17367-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2919D9C4A
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 18:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0BF4B23286
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 17:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445BA1DA109;
	Tue, 26 Nov 2024 17:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mWiyYUEB"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011048.outbound.protection.outlook.com [52.101.65.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1061D63FD;
	Tue, 26 Nov 2024 17:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732641555; cv=fail; b=RXV1qX1dA3+vS3w/cYLKPbP3wQlH61oWxJJFaSi/fvpOnHbC2UQQ1nKWuQfnbcBWNxwmy8f0Y/BOHcLhz4EO6XZf/nLqbWp31LcM7kSTGJO3d4USLcnOqBr6ijlRezLqXnGdNOqPYzmYh6vI16nxQML/QLqSXvwgtJrYWN/M674=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732641555; c=relaxed/simple;
	bh=ip7i9KXviyaH8piKrD5aZp7Pd6Q6r9QDcpk+zMBDfwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=efhk6YU0SQO6o/rvtRBQ2w7eZrQQa4uMZqF20GBjrf2WFnE5YjMpdnXDPaqZ39U69QdwMCH8xNJQ7PdtoDUaLhvzz3BNfv/tEbIH5ME/Cq7NLtPs6Q2bZ/IIdPhFYMUhXzCxO+QMb6d1wj1OyzMZBM2FQqF5y2rRxuOQkymNbQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mWiyYUEB; arc=fail smtp.client-ip=52.101.65.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xQ5R50l4uhoXrQCIAoIGe21JiW3esPvlJ1GSgTA/lF+FNhaO/Zt0ADLhCsP5MmX+dSUO4fKE/kTm+HeHiU4t3967ZxFfUCY6o2XE+hgLWpDph/a0YP/l9UCMKFyRIwKAg+PtOgCUGcBcE5z3jEITBsQKlQNgUvR0uvdz6mcmuWr28fdJAUy3UJOUk9oR4h5cc4dfAmeNFpjNrsKKfQCwa4x5BVCpY1V8TlDHal1lE2xACJPXsBfh4OfyCUuuJSeB7vYmjCkSMhA1CUBz3PQAx5/pC1bFez3yYcriB94984U1yAScLPcauTUtJ7mEKPkeHwQoynzhuBLz5C/Cpt2nSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IwMcmMjh8IfcUmag/GcvzIAa/pvRIA+skzN3tWVAXLY=;
 b=FmACsq0U2+IF8uAFngmcK2kbCRkRZ3KokgDOhlUHkkiU77lEXGDkTJ7S6+f+C75j++5UkEF0kdpOSGflsJhTSRVYCcSsjgowlCs5Jat0bD4N+40cc+UnHAGmfHIYfHnyL1rIAbLOqu3sh1G5kp5ah8cQkhmYHz5WxLXC+cfba1GASl/og/5XwIO791U2+KkoQOMjn8O/ZsGnYDXJ5lJ5calEtgGeWqt64kcmz7gq+9G81EGs27qroxLIg6R11GiSHQXIpgXiJEn+o0Y6SIIubUSfvLFQ0opEo+3qLgb1qI+1gp07LR9Y0hoQZzfeJIH+JMOxditl2uC7EKGysNqxrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IwMcmMjh8IfcUmag/GcvzIAa/pvRIA+skzN3tWVAXLY=;
 b=mWiyYUEBFC3aJDFbdQHYxePwpMCBbJGJua8cIia01AQh7M7Dsinv8mN9Ir3c6Rv0PGJqr2R1ItlnpICsNrkcxriijUhuy2Y4Bm1fl4HPmc9rT+La+PBDZzTsje0d2P/dwnlJVLQWUhUEiDODJ3Xnn5KxeJWPUxVglrhkp/Fgw7abITDEi3eyiVVzgu65MEYGj0LymzseBOIxkELGw36PaByr9kiNGcIdnf/JWEPA7M1DoKf8l9qDlLf8ic4cfLxNwjQsxPkugxls7MU37QJ7t8EsPrXg3qoC6BFLQPq2LNea6Tok2sWKJxqqVCGGCdMZ8nRT+cUv3TSXY2P5o/XePQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10363.eurprd04.prod.outlook.com (2603:10a6:10:55f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Tue, 26 Nov
 2024 17:19:10 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 17:19:10 +0000
Date: Tue, 26 Nov 2024 12:19:01 -0500
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>,
	dlemoal@kernel.org, maz@kernel.org, tglx@linutronix.de,
	jdmason@kudzu.us
Subject: Re: [PATCH v8 2/6] PCI: endpoint: Add RC-to-EP doorbell support
 using platform MSI controller
Message-ID: <Z0YAChEOnmezCBcU@lizhi-Precision-Tower-5810>
References: <20241116-ep-msi-v8-0-6f1f68ffd1bb@nxp.com>
 <20241116-ep-msi-v8-2-6f1f68ffd1bb@nxp.com>
 <20241124071100.ts34jbnosiipnx2x@thinkpad>
 <Z0S7+U5W2DOmzdJL@lizhi-Precision-Tower-5810>
 <20241126041449.qouyatajd5rie5o2@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241126041449.qouyatajd5rie5o2@thinkpad>
X-ClientProxiedBy: SJ0PR13CA0015.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB10363:EE_
X-MS-Office365-Filtering-Correlation-Id: bd802a61-8236-4db3-bfb3-08dd0e3e70ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWw5dElkNlMrTkI2NlVyc2JGbFZyVjJNYjNRUGxqMkRpalM3eG82S2hvZ0VY?=
 =?utf-8?B?U3JOVzhGbEUrSm9jd0lFSHQvVktKSDRtT0JPRmZRckFEVEZpT1Z6ZjNUajh4?=
 =?utf-8?B?K2VUQSswUGJqMitScDBjalh5aWFqSzlnZFVpclo1M3JCRmsvekpVK2c4Vnho?=
 =?utf-8?B?ZjlMbEFCM050M2Q0RjdzK3AyakRHTGNRN0JrZXJjUEhwZ2NCdGVRdU9Ybnkr?=
 =?utf-8?B?b0hEajVDTTJyYmE3MGpPT2xRbXA3dkM5Rk1PMjFtSFM1T1FEYnoraVFoVDJL?=
 =?utf-8?B?K2xpczZqcENwZEVoK01CK2g4SWJXcm5vSGRsZEpOckZ6SnhVZFN5TVJKNEta?=
 =?utf-8?B?L01KVGVLQnhJazVETElnSC96SkUzbDRmL3NGUDdJakRxWnVxRFFHanRsTXo1?=
 =?utf-8?B?VHcrYkYzcU4wc084SFNsVHc1eHlXeVFPTldRSk5vSHgvdlltcm5XeWlPbGhG?=
 =?utf-8?B?c1F4R3NybklvMHFsYUNRVjhSYzg2OGlTbUVxOE9tSXkzTnBYS1NXTk9DZ3cr?=
 =?utf-8?B?TDQxVml6WXhxZUZYSUNhMnhFVGRDcWRpSS8zVkVISy9LcTFBaUo5bFFNZnJ3?=
 =?utf-8?B?d0lab3NVK2YzNkVJd1JtR3JPd2dHakRUVVk1ZGg4TEE0cmdZQk9tV2d3My91?=
 =?utf-8?B?UFVxU01CeVlSV0tnWDlReFpJa0VYb01QNXlsZkxJZDhPRVM5MDdPam10ak5Z?=
 =?utf-8?B?aW5wYlY0RVZGcjBSdzhOdlIvMFRyVVlUc1AxS01MVG00NWFpMUhJbW1TV0pa?=
 =?utf-8?B?TGg5b21oYlNKUDFwa3ZzOW8yNGllK0FTZWVuQXJhcEg5dnI3QThZQ1BXMFBD?=
 =?utf-8?B?SWNXampYRVhtcm5XdnNnbEY4c1I2QjRvamZ0eFozZHVaT3JoTmRUWE5HSE9V?=
 =?utf-8?B?MXZIa1VpNUFzd1hhQWl4SzJpNmwyOVJrUHgzMlNieW05OFdzMXRFWnZqZVZ0?=
 =?utf-8?B?SmdiYmN5bWQvRklGK29lZkZDbGRmV1grYzhmMndTOFNLVElhN1ptMnQ4QUlF?=
 =?utf-8?B?QnZpT3NBVE1rWXNBcTFCbnV1dkdCNmdXR1VnNTJnZnlTemYrY2VMN1F5MWwr?=
 =?utf-8?B?Qmx6SDRmSDJvZ25QaTdYeXRseG4yZ0xxUWxRalRhMTdKYk1EVjM0UEQ5dWdZ?=
 =?utf-8?B?Qk1NNk0wcVhYeWlCNXlYWjBremljUmFKUSsxQ3VHOWhGWk4wSG52VHpaeVRX?=
 =?utf-8?B?NDRmTFQxaXpiamUxZEg1UkNkcmUyYzRZczJIWVYreUVWbmtHb3AyZGdWM0Ur?=
 =?utf-8?B?TFpZamRqbUlPNDJhMzlwblk0ZlVmZGhQZjkwUFJCZlB1dnFjd2JSZWZVSng4?=
 =?utf-8?B?OWU5bUIyVXkrbDdzL0IrODFvL3JpcFAvS3Q1YXVmNDZMdHFhU3p1SDdsUGoz?=
 =?utf-8?B?VzEzRTNlRkFoWUdBL0U5M1c5M3hML1Jja0NNSjB1UWg2Rlc5bEtEVXRSaWtZ?=
 =?utf-8?B?aFBLdnhQNkxqdm12M0ZoVlczUnpFWnp4M2RRS2JZZ2V0U013SFU2T2dUVXRs?=
 =?utf-8?B?dFZydUQzNW9DeGdCa01BMHNhMm5KZnIzMHk0bXdLcVhIbHFtWm85RWpHZk5G?=
 =?utf-8?B?ZW9HWGJ0VENHZEpnMFhCN1RzNEdzSVhIS1dVa0pzdVNEQ3FoVjhkWVhBYkRM?=
 =?utf-8?B?SHEycXU4d25mVDB5UVYwRVhpNmw4UVYvWnZLcjRUUlNETXQ2WVpWN2R5R0FF?=
 =?utf-8?B?RWQzSU9oL1pjMXhrN3psTHVpUUN6bzNBS0JwMVhnQnZTd3A4Vk9RM2YyUWEr?=
 =?utf-8?B?VHFTNDJBN3B0RVJNeEhzdyt1b2hqY1NqTDdwY28yOGtIT25tRytvUnBRZGk5?=
 =?utf-8?B?RWxPeFo3SmhNR215ZStEWEpmUUc3NlVyZXhuL1hZUG5MWlVvMW5oaVZVMVRo?=
 =?utf-8?B?VUJxTUZCNERvdE1ieEYxdzIwV2YyZEs1TW1nR1B4cWttL3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Unk1UW9zeDlmbmlta3l6M0hld2lTRUh4cWpiSWtKNGZJdURXeDUyeGFoWDdZ?=
 =?utf-8?B?bWJaNEVZVmpWeVRpQ0JPTXdGM1F5K2tMRFJoTTd0bDNVc1F1UlNjL3BMZ21N?=
 =?utf-8?B?azZwVnd4SXdnTm1HNmVXci96MWZhMDhQUEZSVmNDQ1hXSkxUZjVsVXR4NHJq?=
 =?utf-8?B?dWlYRnI2ZDdVcHVhZXR6anQxYkhGcUJZMThqMndBU0h6UGx5ZERrakdyN0RL?=
 =?utf-8?B?ZFBQWE9FeExyWWNJSHJOc1BqSXJScEJVQkpEUEU5UStXbnUzak5VN1BvL05p?=
 =?utf-8?B?WXBVYkNNd0V4K2xyUmgzOTQ5MDY1am4zSFRpaEZKeHJ4RGw5QjFZQlhTM3FR?=
 =?utf-8?B?NmZDRUkyUDV1ZnNMakZoSzNJaHkzVUVQakNHbmVyeUlZVjlQa3d3aWJrRkNV?=
 =?utf-8?B?UWNicyt5WStQa25kN2t3T0hYUTlnVmFJOElzWW0zdWVJUHdlYU42R29kTmdI?=
 =?utf-8?B?TjNreE05YkxIckZ4eTVZWCtiUWtpVkh5b0ErWnBOUVpmZEppQ012U1J6UXNk?=
 =?utf-8?B?RFZvTTd5SFplclFLbUx1YnVQWUdOVFlNWGRxZ0x3NmpoNzEvVU41TmlXMTdC?=
 =?utf-8?B?WkJRNGR4NHFnWVlqN0NPcjJtY1pCMUs1VGRJRlYrZmRwakY5Vk9OaTRKc0pT?=
 =?utf-8?B?QjN3ZXdvZDVFeFZPYWRRYWgwK3lHQW5jOE9WaWhNVW5obUR0b21MTFFmcDB6?=
 =?utf-8?B?T3A4LzRqaUpyQmNhb3c4ZC9xQUIzSm5UZDlzUHZBY3dvc2t3aldDaHphUUUx?=
 =?utf-8?B?WWN4cTNJTzJvRG83S291alU4SkVEUktidzNnWkRwVFBLbjVsS2I5NElldWZa?=
 =?utf-8?B?RTZacWhCUUs0VFZuUFNnWmVMTDlRcXhoRzBHbVJYRzFXTUhONDh0eURRaHZZ?=
 =?utf-8?B?TWRiWVozTmtCQktpUFNvMDArWENsZWhsZWFxVlF4eCtHUklYdStoT3U4SFJM?=
 =?utf-8?B?b3VHT0YzempvVysyQm9ZSHhTZm0zRm5MTTFxUWJvK1B5d2NjbDgzUUloUzVE?=
 =?utf-8?B?ODFHUlZVZzdlOWE4bWZaOE0vZEd3S2hKRENGQWdnczNwYzM4UTFoRWptMWtT?=
 =?utf-8?B?eUZ4Y1Nob2k3VW9sMks2M3oyaDl6MkhIa1BveEVjYzFKb3dOZ2NuR2RHTXJN?=
 =?utf-8?B?NGFnblMvWnZuMTVOQkVhSDNsdEN4K3lyak1rSXBzbHRMSnYwRUJVVW5Dc0d4?=
 =?utf-8?B?b2tqUDU0TE5YaW5nVVpITERDSWpVdGltVlMxTnlEV05hbHFLTXk4V2Rya2xX?=
 =?utf-8?B?OXdVMS9iK2JodmRyUjZ1NmVlbkhJRCtyczlGVHJEb0t4WVhrdEovZTNkUUdm?=
 =?utf-8?B?MHJ0YmJrd2w5SHMvbWxjYmI5SWtXc2pwcVhLRGdib21IdldCWGIyOUV0Vlls?=
 =?utf-8?B?SEVXblBDM0hjQjFRSXZQdTVvcVdYUnRyYnBoQ2p6N3ZhdWpjZWtiS2hzZlph?=
 =?utf-8?B?ZEE4T2VmR3BXSjhLK0JTSEVIR2tEVWg3ZkIvUlZPbXl2RFpxeTdxUjlXS0d2?=
 =?utf-8?B?bjA5UHhwaXVNSW1JdEtjOXl3c09WWlNBNHUrUEgrcnEvcFNleElVeWY1Sk5U?=
 =?utf-8?B?Rkw3ZkdNTkUzeVBWZDZBdE9hK08yRHg3ZXczWlh1Y051R1pWT3I0UlUrZGxI?=
 =?utf-8?B?aEgxd2RBa2JIWWk3ZTR0OEMrWnlTZFp3cWVFTTVSNTVvdGFhWHZ5M2NPOTdN?=
 =?utf-8?B?b0YvUnNwUnlTRUttbWVreW5TdnJLOVpQTUUzUGxVUW1MekpWLzZiY21XUmNO?=
 =?utf-8?B?MXJKYlV2TTBxMGx5OFNsVzF4bkhKMjhCTExIVG04MEdlQThHam1GSXBYbFJV?=
 =?utf-8?B?amVvbmVOWll0WFpPaHRhRlFvaG5CTHBEN01VTnEwQ2FwcERFK0VIWSttTzVQ?=
 =?utf-8?B?OWhLNnBZY3o3cjFwbmI5U2puWUNHSTdmVlplRWl2MFRRLy9tSDF0QXUvdTVv?=
 =?utf-8?B?Z1BhMWRtZHZRZ050cUVPbkhWc01aeHkvMC9MK0o5dGVlck5OSEd2OTljc1Ju?=
 =?utf-8?B?QWdOaW1teWFqZjI2cGU3VWRNandwOWtTRUNRWDNIbGFIa3JxSnQ4OVFLd2lw?=
 =?utf-8?B?TlFBa3dVOTZvWm9LVlFBK1BYbnNjSlNUZVR0OHA2TzZKUlNZZVhZK3RjOGs5?=
 =?utf-8?Q?OI+mgRDn4ia2xiB1iqMLWaQkT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd802a61-8236-4db3-bfb3-08dd0e3e70ce
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 17:19:10.1410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dq0ZGdsOeIz/MrMdd7L9yOuGDyeMoaUsoZCwuqejaV4ZZHrn/GpV97+f7ekgRmj52jE46QyUlf93Ty8//7bHYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10363

On Tue, Nov 26, 2024 at 09:44:49AM +0530, Manivannan Sadhasivam wrote:
> On Mon, Nov 25, 2024 at 01:03:37PM -0500, Frank Li wrote:
> > On Sun, Nov 24, 2024 at 12:41:00PM +0530, Manivannan Sadhasivam wrote:
> > > On Sat, Nov 16, 2024 at 09:40:42AM -0500, Frank Li wrote:
> > > > Doorbell feature is implemented by mapping the EP's MSI interrupt
> > > > controller message address to a dedicated BAR in the EPC core. It is the
> > > > responsibility of the EPF driver to pass the actual message data to be
> > > > written by the host to the doorbell BAR region through its own logic.
> > > >
> > > > Tested-by: Niklas Cassel <cassel@kernel.org>
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > > change from v5 to v8
> > > > -none
> > > >
> > > > Change from v4 to v5
> > > > - Remove request_irq() in pci_epc_alloc_doorbell() and leave to EP function
> > > > driver, so ep function driver can register differece call back function for
> > > > difference doorbell events and set irq affinity to differece CPU core.
> > > > - Improve error message when MSI allocate failure.
> > > >
> > > > Change from v3 to v4
> > > > - msi change to use msi_get_virq() avoid use msi_for_each_desc().
> > > > - add new struct for pci_epf_doorbell_msg to msi msg,virq and irq name.
> > > > - move mutex lock to epc function
> > > > - initialize variable at declear place.
> > > > - passdown epf to epc*() function to simplify code.
> > > > ---
> > > >  drivers/pci/endpoint/Makefile     |  2 +-
> > > >  drivers/pci/endpoint/pci-ep-msi.c | 99 +++++++++++++++++++++++++++++++++++++++
> > > >  include/linux/pci-ep-msi.h        | 15 ++++++
> > > >  include/linux/pci-epf.h           | 16 +++++++
> > > >  4 files changed, 131 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/pci/endpoint/Makefile b/drivers/pci/endpoint/Makefile
> > > > index 95b2fe47e3b06..a1ccce440c2c5 100644
> > > > --- a/drivers/pci/endpoint/Makefile
> > > > +++ b/drivers/pci/endpoint/Makefile
> > > > @@ -5,4 +5,4 @@
> > > >
> > > >  obj-$(CONFIG_PCI_ENDPOINT_CONFIGFS)	+= pci-ep-cfs.o
> > > >  obj-$(CONFIG_PCI_ENDPOINT)		+= pci-epc-core.o pci-epf-core.o\
> > > > -					   pci-epc-mem.o functions/
> > > > +					   pci-epc-mem.o pci-ep-msi.o functions/
> > > > diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
> > > > new file mode 100644
> > > > index 0000000000000..7868a529dce37
> > > > --- /dev/null
> > > > +++ b/drivers/pci/endpoint/pci-ep-msi.c
> > > > @@ -0,0 +1,99 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * PCI Endpoint *Controller* (EPC) MSI library
> > > > + *
> > > > + * Copyright (C) 2024 NXP
> > > > + * Author: Frank Li <Frank.Li@nxp.com>
> > > > + */
> > > > +
> > > > +#include <linux/cleanup.h>
> > > > +#include <linux/device.h>
> > > > +#include <linux/slab.h>
> > >
> > > Please sort alphabetically.
> > >
> > > > +#include <linux/module.h>
> > > > +#include <linux/msi.h>
> > > > +#include <linux/pci-epc.h>
> > > > +#include <linux/pci-epf.h>
> > > > +#include <linux/pci-ep-cfs.h>
> > > > +#include <linux/pci-ep-msi.h>
> > > > +
> > > > +static bool pci_epc_match_parent(struct device *dev, void *param)
> > > > +{
> > > > +	return dev->parent == param;
> > > > +}
> > > > +
> > > > +static void pci_epc_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
> > > > +{
> > > > +	struct pci_epc *epc __free(pci_epc_put) = NULL;
> > > > +	struct pci_epf *epf;
> > > > +
> > > > +	epc = pci_epc_get_fn(pci_epc_match_parent, desc->dev);
> > >
> > > You were passing 'epc->dev.parent' to platform_device_msi_init_and_alloc_irqs().
> > > So 'desc->dev' should be the EPC parent, right? If so, you can do:
> > >
> > > 	epc = pci_epc_get(dev_name(msi_desc_to_dev(desc)));
> > >
> > > since we are reusing the parent dev name for EPC.
> >
> > I think it is not good to depend on hidden situation, "name is the same."
> > May it change in future because no one will realize here depend on the same
> > name and just think it is trivial update for device name.
> >
>
> No one should change the EPC name just like that. The name is exposed to
> configfs interface and the existing userspace scripts rely on that. So changing
> the name will break them.
>
> I'd strongly suggest you to use the existing API instead of adding a new one for
> the same purpose.
>
> > >
> > > > +	if (!epc)
> > > > +		return;
> > > > +
> > > > +	/* Only support one EPF for doorbell */
> > > > +	epf = list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list);
> > >
> > > Why don't you impose this restriction in pci_epf_alloc_doorbell() itself?
> >
> > This is callback from platform_device_msi_init_and_alloc_irqs(). So it is
> > actually restriction at pci_epf_alloc_doorbell().
> >
>
> I don't know how to parse this last sentence. But my question was why don't you
> impose this one EPF restriction in pci_epf_alloc_doorbell() before allocating
> the MSI domain using platform_device_msi_init_and_alloc_irqs()? This way if
> someone calls pci_epf_alloc_doorbell() multi EPF, it will fail.

Yes, it is limitation for current platfrom msi framework. It is totally
equal.

call stack is
	pci_epf_alloc_doorbell()
	     platform_device_msi_init_and_alloc_irqs()
		...
		pci_epc_write_msi_msg()



It is totally equal return at pci_epc_write_msi_msg() or return before
platform_device_msi_init_and_alloc_irqs().

why check epf in pci_epc_write_msi_msg() is because it use epf in here.
pci_epf_alloc_doorbell() never use epf variable. If check unused variable
in pci_epf_alloc_doorbell(), user don't know why and what's exactly
restrict it.

Frank

>
> - Mani
>
> --
> மணிவண்ணன் சதாசிவம்

