Return-Path: <linux-pci+bounces-23644-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D974A5F815
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 15:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3721B19C4897
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 14:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF6E268684;
	Thu, 13 Mar 2025 14:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="T8kfFAgc"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2057.outbound.protection.outlook.com [40.107.247.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78279267B96;
	Thu, 13 Mar 2025 14:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876041; cv=fail; b=GEhVZYWA8fHa0btxLbhJvUQa6lxKKOJ/Jh/Wuh9fdWAQKgAsLo6i4UJv3PO3MjEGGKsFa4LbYdPsVq3s6MhnOXFjP7/ctl/oyzXf7qnQAoPB/2j84yZt7Ar0mzQRoKAx21TsZw4Dy6N9d3NgPXAe06ViktG0BO0hxeF3/ym1vAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876041; c=relaxed/simple;
	bh=Yxbm/GmsInQhuzfZbW2pphPzwz+mggKvBQTXoyg68XU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TAShE5ouNCY1LfRPLcpWO9qZ17yLLADuKUw+dATw8sxoNYjb3Rzu/rb8ummA9V2ah2+TldJtaaMZzfcIk53wf5bIMqA1GMd47swvLy0g8ARfUZg6sPjf2nam+M3UkD6CUcA24FjIC1wzWNqcHzkbF1c+SFvAF+4+M1dL7lNQmOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=T8kfFAgc; arc=fail smtp.client-ip=40.107.247.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yoWY6qWSYodRNtyXAqGDR1yskWl6rWmv/REYR7uIfvB02AfrDTbJ4XV5JIi5jjkBSpLur0zqXE9Zm7p1UG9ishYHq+WS/hLUUtMQALmaGyCV6qdvshxS0mn7AktMGWTz8ls80s1OyjINeYhLj8/xcTxPZIearjynavn4dXr0en5i91bkPGqz5kYSseHdwLHlSUOH2ssqlkGc1Hlzd0/5dfhOyhNo+lmMCV5CwTuNAlBR+YLyBI1VU2QwmQS6tMtjf07inLxynnu/GyXAYk1AS0pa2+Ho7Tk4gRaRxeWBLsMBWBdv+G0/bHhWPIpUaOYSn7siaFUYD66SN+fOX8yXeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3FW6ENuGlHz47R8J4aFoUQqLlokvYOKPuwt1MFOE5I=;
 b=Ate+ShprwB7J5XKYXhxh26lv5/MP2oqqzuWubmJ9oub/sl5md5WlDFzu6hwUhqUZfyT4+jmVY2y0RO1BV6Cnk7v+Yg82nYfdA31noRipl7qCJbaNxwgglEWE7xbidKHM5/gI0CjhOTVxI83H33FhKR70HSV8FrbSixbD4AqfrJnp9nvgfToSp8/UrgO4UFHrWdAoruTWrHSsVW7LaE6FgFHrlBwgyuLMeRbkXfkVZKV6waOtMtP8KBKdqnU+JdlDmJWmkER4DSteY+v93o+RxJMJSa/2/F1XZVqIpCbmOp6r1WxEeB60PT73J8P04lVXGNlPfpeQ1JnyEh/b6q1VAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3FW6ENuGlHz47R8J4aFoUQqLlokvYOKPuwt1MFOE5I=;
 b=T8kfFAgctPhuTqjNiFb397kunBI2RJB63y25UsqHbjHRjnN0qibQc2el5wM75Lwpw5RTHZrWvgj2DauP06Dil+smzydrY75jypqALc4S6jI++pAHVEya5OfURXPEiriF1yAZs930Pucdr+2loWqSS3RU0bHxHpGleGpV7+mTmMGXATvMXpJKDSXJ2dPlYkm+Htg3JCWTGQiBRekjYcJaFaSQWNsrpvwIcJBGfsNqPC6w9jhge8bs6JANHoYvTS4+NeG7o0FmKZ42SGNr6b70+Tvak1mORrbQQj9m3fmPmpdq3zxkBBH7zMWne/ebbEh/hBvxxpBHdI7dJ/XEj+qBdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB7184.eurprd04.prod.outlook.com (2603:10a6:800:125::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 14:27:15 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 14:27:14 +0000
Date: Thu, 13 Mar 2025 10:27:05 -0400
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
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
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v10 09/10] PCI: dwc: ep: Ensure proper iteration over
 outbound map windows
Message-ID: <Z9LrOY27J47WfdPv@lizhi-Precision-Tower-5810>
References: <20250310-pci_fixup_addr-v10-9-409dafc950d1@nxp.com>
 <20250312214700.GA710620@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312214700.GA710620@bhelgaas>
X-ClientProxiedBy: SJ0PR03CA0296.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB7184:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a7215e5-d91a-4b66-90aa-08dd623b269a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ako9yBL6+ds9BGwFUuOOvyyW24Ltj+F6GsBWe7dRIlbM/MJypsnjnOei6pYG?=
 =?us-ascii?Q?8mRyNDhVqUmEJObRCpuq3sYlGUeewSCjVPpzOk3RDO4Qa/tvQqGuTxMjE47N?=
 =?us-ascii?Q?4p1BSE9BKv/IMBHyUSLTLuDiO0gHrn01BI9F++IHByerkHBvEYcfE5wKBEn0?=
 =?us-ascii?Q?hhu6hKlDelAz4i/A7Pqhxc4VTXo+E8P2SVudjl3PErjJ/Ifagk4Z08AV87XH?=
 =?us-ascii?Q?6AnaN3KVb7CBpe0P9z5bhKQMcCIQg5kvhH0P4Xzus8hcT20KlbXFvG61ruE+?=
 =?us-ascii?Q?oajPUUd2ZuEGs5Zl/0vnSw0IhlZP6njuto46zsIENGJDWi4/13CUIYznvdN8?=
 =?us-ascii?Q?l+9tiOsQ3oqxOAO2oSifF95PXhs1CGYKHnSw6F0d0z48gOF0u7glQMnGDaoD?=
 =?us-ascii?Q?IUx9RvWCQkn6GogNJVGEMFNXbf4luRW3QVFsNliTRIDQ9piU2pHJ9yWbKYa4?=
 =?us-ascii?Q?219dfMdQ9RM4ACcUUk+Hrann64MZym22nH1gowUHImlu/C33fQLoaSBdC58U?=
 =?us-ascii?Q?ZCHiquNESvNw1DVHp1h8Oe2k+32fg5zboO+zLNRwSAiDRl+LG7yeIrtVxk0D?=
 =?us-ascii?Q?CUVCoEZ9oNyvAtOeayb7WComhhBIYrWz0F51eMxJA+cirhz3FKH/thccQ7Bb?=
 =?us-ascii?Q?4eocPnElXpnM9uKsG/bnh+Fe8xZ7k8gIHYNuyaayf6sGFJkrIQum7NOPunGU?=
 =?us-ascii?Q?juva5MoCMyNFQ5+vKbZoMgBpAF+5DbLOIfLe4WLeuaaKxMK6+HHVdFXfs9xV?=
 =?us-ascii?Q?X68EXtxLawTmxMyAetRcFsLC86H4AZ+t19OEgJF3+ZsFMCDSo7t1Np0WAAY8?=
 =?us-ascii?Q?xpoyNoAFhV711K2llviBZ4oKoTliupM89QrMJc0Lf6xDp0JHLHmalPEz1a+X?=
 =?us-ascii?Q?cOJFiJBwV5ApQ6skglGrCivA7cCeFk89fm17BbdYCjQQSCTuvGVBrPmyl1Fa?=
 =?us-ascii?Q?RULtFnYP6vS9vZTlZDUvuBKPndN9VzXNs4UK8P04RWbvzsvtvQ5d2uD4aNjY?=
 =?us-ascii?Q?ZqEOXsyDahfOtVsXTx4+5txAWJloojqxR6Kt6/93/HHEPubUA4Rmdkft22VQ?=
 =?us-ascii?Q?PIYRRulUVHt3IcZv/eOc4gYdTt7ThTUnDlyZWmXa10E3A4kAVSjazPfrtIfD?=
 =?us-ascii?Q?uAghO+JY/sj60PH+Xku5sESGzIKCzvIXCrHxEKtor+Eot//nRY5TgrgWlKRP?=
 =?us-ascii?Q?Fo5CXfDTGjjTSIFWi4R0xebYajqvgmvKbImo1hO3btYJB2qDLxnXl7pet2mN?=
 =?us-ascii?Q?hZdlHt/0riGHrc9nODeTw0qZ71qlqqEqZNOBQH9AyG2Ugr2RwePVCAnP+QsL?=
 =?us-ascii?Q?+Scwq/GTJw/4sVHLsK74sNbcJAm9DIsVCAcCtfwEWZkqwydcYn1qwnW1IuaN?=
 =?us-ascii?Q?7QpOB6HyTB50ifjsm/emfh3MH1KxUudYOvL044vr1BREYM/51F0l2HRpY3GB?=
 =?us-ascii?Q?BGtUJV4aD+LLHPG3xNhOlcurjIZpnIzo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vPEN+0vqLNK0GIeZMuZ8LqN1vYItz18ZlW7BPuAm/a+BK+D74NFdGGG0F5sc?=
 =?us-ascii?Q?LDlBvINRJeka18HH+curUwWOK9vt7VW46/PfTeo9l28GW8OEVyVBwY0aIcl2?=
 =?us-ascii?Q?GKFPxc8ZQq47JjiVNyeT13FkHLR3g0Y5v909UEfsNPgtmW+fKVboGxQJgO5k?=
 =?us-ascii?Q?pabUM0Tx7dO5eMajhCbqGbyIwrNl3GXwNVRFV0B2vUqFRkIIIeLfE9lF7z7a?=
 =?us-ascii?Q?9aYwhGEjII5CTGpl1BK+A8GTeTWe9GbQHwLrECmd7CaVbgKc4qZ4C+xwYNYn?=
 =?us-ascii?Q?3Qz5JNgFp5rcx2UOT4feRptesUAhgfUu7vJB6Cq0TxIm4V2TbpfDBNzppWW5?=
 =?us-ascii?Q?c4jB8wA0G4nPpA6bto8VyhCf5WUIOh8VzmvK0Gh9XKBgTuNWCnKK8AlFGcEE?=
 =?us-ascii?Q?vFZ6IN2jrpBYoH6PzFYxGVZK5o5cjJ6pfcEWl9WbFjGXZeAb/Rlm4si3Esdd?=
 =?us-ascii?Q?GP4p0cvh0qZC2OT3wM9ieOaj2A0Tn1Bnxk0yL6kxpYFizy72TdpxX/Gf3dbS?=
 =?us-ascii?Q?eQQcGshREY5kOQBBS2D39ahpT15cVlnURzVsfSGyjcD9kYSNDg08yvv3sTqI?=
 =?us-ascii?Q?UmcEt6U+a+Q7ShmP4tk0Xim+ykdoa2fFBMbDMR/enf5NVZc/2JbLTCfLWxmp?=
 =?us-ascii?Q?XstC3e3aYDOUyZT9xfR4pxyOJXvumXrTgoOwQ8b9k5VQgN5Rc3gerrIeeZDh?=
 =?us-ascii?Q?28JUq6jJw/kMeqmxGsHAuZNEPPz+l/bach480i/SPmZ6T7/GwvSfB0CW1DRI?=
 =?us-ascii?Q?xOiQ+RsqLUfSoeRIS4rXsS1RQ372HbNcsifIM2rRNSg4trqkatc7H1u3iaxY?=
 =?us-ascii?Q?cYnCnqd1z3dBbuts4QeWDhYCd47NzgrXGyXM/R2nuFFd0N+i2/1jRB+tPb70?=
 =?us-ascii?Q?AlGK1rXCrs8xKl8HEykT4qb9EiZoygTYP56oUBDqLxPqnd0uZaf8eUOShCxj?=
 =?us-ascii?Q?BZM85pTZKL7v7hlMJ7BKHAiyYMGwQXx30T/tBiW8oMH3rqba2wfDc949OVPX?=
 =?us-ascii?Q?P43ddDzEDOzxezqz/pJg4cG3ZiaDgPUQqVT6HCWvJEDP2lRDL5sxdqtdVwFc?=
 =?us-ascii?Q?t0QUviY2Q5LBlhQ5PWkkuDpsfhpdQb3OSWwWcEXpoDan//b4OoSXw0Pby6Jh?=
 =?us-ascii?Q?55eLbhxYli9KGBaYZRV9+jY4RmY7ygjFeOiMxUwnACwcG5wK3lLyMIjdcPJm?=
 =?us-ascii?Q?VUXUGcm0TIwQfrL7G80/xvqZnw/7E4LQv8E12SHkl6Sn8r9cShmMzZ92J2iN?=
 =?us-ascii?Q?hp8Fk1uQmrzoV/vZ0zkZ2KGv+gI2SOrtFaOTyAnM6njoSZvS+DxBReJ7FM97?=
 =?us-ascii?Q?vPw9Tl6q3foW3zEse8yfHiUIA/WpeAlAauDyqkKHOq19nKS/pXT7l+jzolg1?=
 =?us-ascii?Q?Xtq8NSRDDF19ixZzyfoEpmms7h5qapgAfjoJHWxWAnDs+gKVNZmNxNSeeeg0?=
 =?us-ascii?Q?Sv+S4Y+F1rJ47uIiWea0765bS9Tv6fKcJjArtP+vsGxzczuno0IuqRW/Xadl?=
 =?us-ascii?Q?Axq5Wyk9tB0w/LIaANgDWWQkXK3gcFGTQgXqvnus4MXc0DGjOn3RCZoW70jl?=
 =?us-ascii?Q?qcO/i9Brll7CpW1mzp7VHIWnMe5TF4sCFR0pLukq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7215e5-d91a-4b66-90aa-08dd623b269a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 14:27:14.8641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zIzNBy7jgmGP6k5v6bYHf9tUUY0mVEHy5eDOxjuQXCfvD0d6Gsa5pUWdK89LNGSHo+uCsAiCWgqlkZQARFOKuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7184

On Wed, Mar 12, 2025 at 04:47:00PM -0500, Bjorn Helgaas wrote:
> On Mon, Mar 10, 2025 at 04:16:47PM -0400, Frank Li wrote:
> > Most systems' PCIe outbound map windows have non-zero physical addresses,
> > but the possibility of encountering zero increased with commit
> > ("PCI: dwc: ep: Add bus_addr_base for outbound window").
>
> What is this commit?  I don't see it in the tree, and I don't see it
> in this series.

Sorry, it refer to old version of this series. It should be

PCI: dwc: Use parent_bus_offset

>
> It look like it might be a fixup for something in this series.  In
> that case it should go *before* the other commit (or be squashed into
> it if it's logically part of it).

Yes it should before PCI: dwc: Use parent_bus_offset to support bisect.

>
> I don't think this series touches ep->ob_window_map, so if it's a fix
> it looks like it could go anywhere earlier.

dw_pcie_ep_outbound_atu() touch ob_window_map.

Frank

>
> > 'ep->outbound_addr[n]', representing 'parent_bus_address', might be 0 on
> > some hardware, which trims high address bits through bus fabric before
> > sending to the PCIe controller.
> >
> > Replace the iteration logic with 'for_each_set_bit()' to ensure only
> > allocated map windows are iterated when determining the ATU index from a
> > given address.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > change from v9 to v10
> > - remove commit hash value
> >
> > change from v8 to v9
> > - new patch
> > ---
> >  drivers/pci/controller/dwc/pcie-designware-ep.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > index 62bc71ad20719..e333855633a77 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -282,7 +282,7 @@ static int dw_pcie_find_index(struct dw_pcie_ep *ep, phys_addr_t addr,
> >  	u32 index;
> >  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> >
> > -	for (index = 0; index < pci->num_ob_windows; index++) {
> > +	for_each_set_bit(index, ep->ob_window_map, pci->num_ob_windows) {
> >  		if (ep->outbound_addr[index] != addr)
> >  			continue;
> >  		*atu_index = index;
> >
> > --
> > 2.34.1
> >

