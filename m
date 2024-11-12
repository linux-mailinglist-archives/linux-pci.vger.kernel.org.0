Return-Path: <linux-pci+bounces-16594-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D919C64E5
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 00:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D29DB2849C
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 20:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E324218D85;
	Tue, 12 Nov 2024 20:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Zk777NT8"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2080.outbound.protection.outlook.com [40.107.20.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D511FC7F8;
	Tue, 12 Nov 2024 20:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731443871; cv=fail; b=TJHmiQkX283824jXqDlQIOpL6wSbf1C9OQ1WPIkUPkOEPeqiMF6jpsv85AnvW9EHvetaOIs5Q9EZ4hMQ3qFRkO/Db8pLtGDM4gv69osGFWDIjHiJ4seTbw3gwU/TBo6nmt75KfIW63TxXyOysva0p6QkSxM17B+b5Zn/WSW8pdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731443871; c=relaxed/simple;
	bh=aly5WPI2wddwhCAZlyU5iqS7w1CeIYYLnQZpL2RaCjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n9d/UnQiCOQuu7lBVNtIMheqffsTp4dKyDcYkrnMLr7S5UJE+kSHbmZDDOXdr4sKPuOmd262+amBNpo/ULcYzvamlOBo9G4xVxDi8kfbj6LO5NkpWan6EltSVDeNIFa8cY3kf3SauC/RalG8yktl9p9T263xEO4/ioRYQhMahBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Zk777NT8; arc=fail smtp.client-ip=40.107.20.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tg8fxJMEe3wVfucYThUjT5sFufqwLLLwMsbNURNz8lgt6vB5SwsEeIqL+JYurFloAL5NXN2gagH37oJKcX4UUMjj+YasXvHjK6ePevXaQNovCJBfp0r7gTivakhle1uER6wwC0JR5/VESyovFqm8lA8WofMphQFzLV3mE02+Dynt29ZNLUzl8Zkkh953gf3nWcZ9Dtr5jqPqmJJlNT9NU4/sNAMGpiM+kbRJs5NhbtFlI5ixlPU9vBbBow2VpDV2xznWvMA1cWxJ0LnNYpdzpt0EueDSozO8jMd6+Z3umgeSZqChuxHM246hGn/ZADuKPWnV5b8mIcw8D7EC6vUefQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=myR/O/uRq6aQeacykRE4b6036OhafHaILjWYp8TK6uo=;
 b=gucz+3Vf6CbGDfYA0WKi8fy+VuoJ8ITg1NSWWLy/4P5fkohyh/r4rEcH3dt1muCkDlKQ3nD8cfU2Ns3kUUCTGSaXmUXovTDI9J+/N2m6FyZ2x2vS9X8V+8WBCAGhsF1hNYZVpy7gD79455/Iw6shsTzX8X3TpfdA4Ii/wUGWSSIRsRY+J5ktRHnEyAmwp/8IxosEm+sebaZYiq9LyBfgg4JyUjR3SJfWoT0bQ4iX5VfNq3ZwDYCAMF4ACO0QFN7GomtJfpKdfWn1blumIt+mW/z5I7vZJAqmiKkhNFC/pNZYvzCYgYsOHT22Vwny6sm6m00EYnInqXlTf2f14bO2eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=myR/O/uRq6aQeacykRE4b6036OhafHaILjWYp8TK6uo=;
 b=Zk777NT8++o7GNtTEXPPmYVFIVo55GjSqk4O8gXk8uDBPNKmrmRNKFZk3auW1MTMFDmYes9/OjU199j0gRzolsYA0cokec9mQadTMpiQaOQxduhCWUJQBLbmGOf1whK9Hzn1YJzxTpGOkkDzd2rUmT3bhpjX/yz/K9EQT2ipkRMD7bWfljZR9Q8WATUh+ur5lomzF9vnQ0egkLfWcNStXzEnVK5h2VO6ismIjjWH38tI9GumC4AxS2/eMO4xNPIiyOcMXu4P5iMXGA2qwp5DbszTAhV2sMe2Z26nwctKkftY1eVOdsX61lNg7Lf6ag2h/0vfwc/RkR8RcCiENlo1JA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8868.eurprd04.prod.outlook.com (2603:10a6:20b:42f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Tue, 12 Nov
 2024 20:37:42 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 20:37:42 +0000
Date: Tue, 12 Nov 2024 15:37:34 -0500
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
Subject: Re: [PATCH v6 3/5] PCI: endpoint: pci-epf-test: Add doorbell test
 support
Message-ID: <ZzO8jn6OpgFhl4TN@lizhi-Precision-Tower-5810>
References: <20241112-ep-msi-v6-0-45f9722e3c2a@nxp.com>
 <20241112-ep-msi-v6-3-45f9722e3c2a@nxp.com>
 <ZzO3OcCNtHUfm867@x1-carbon>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzO3OcCNtHUfm867@x1-carbon>
X-ClientProxiedBy: SJ0PR05CA0101.namprd05.prod.outlook.com
 (2603:10b6:a03:334::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8868:EE_
X-MS-Office365-Filtering-Correlation-Id: c018612f-997b-4108-8e37-08dd0359db76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3SCJCnouVjkIO62h4J/Vzm6F3rNOFMt8wUHbHYW5DH1VCQxPRM37exBQp1E0?=
 =?us-ascii?Q?tr9JIfRb9QOmxDlx5kEnft2vEIAg/iXrnpsIcM+fCWZVgWtUiEduFKoeF14K?=
 =?us-ascii?Q?BWx7wqYiBrqr6Z0lMkxbyonE6mmKprGRQlM1wanfWPHiCCYndZuHanKt4TFq?=
 =?us-ascii?Q?0a3eXG8I+YehWUkSvMFMUVHk1NZts2OZrvSRumL7daK8sM3GybplyzUh5ZsF?=
 =?us-ascii?Q?8ifS5G1IQwKJF9HCAoQYGNfG7x5EG3Va+gBWKVaFQOKC0mJ/DzAI2fcc0q1d?=
 =?us-ascii?Q?14jR2UpexEduHRa/p/LQPzSddR+PfYoZtbXacTltHGelPJthyGSgy9I8rAf1?=
 =?us-ascii?Q?BKvUqFjj7ZqtKd2ZP2Xz1FA/wq3eBsGsQ3z4XPmV8Wn+B4xMGITXJ564YLUM?=
 =?us-ascii?Q?Gm/Ov6f27dRpYO1rZnEuPiaQLQQuSTXW05mVyd1/u4zLbulLzQNn0TUkdL+N?=
 =?us-ascii?Q?jC5pQmYeoE775gZ3a9v9LScO8hP8rfdQrUGVKkUm8QmMQWsrIZlldGEb+Rl5?=
 =?us-ascii?Q?3ae8zsCM5TmI5jpVh/LufrzCvtjN/c6BKsOzyOQ5NvlFVb+TDCVRE3AHezi0?=
 =?us-ascii?Q?/ypzbH+kvQbxPy108c9ZDNLecS3yMNar9cig/JsA7+l6j7RWmk1/MUUlIc8Z?=
 =?us-ascii?Q?77+ALHncu3FJrOn+nqQB3+pPYI3fPfsB8Ji2cZ7MMfprM90rKPeHvPukmBSu?=
 =?us-ascii?Q?biieCGA7qno7QHe4tWkV9Gha4FvlEgwYmr9Nu+zR9sglDVgmiHiIDSzIt8E7?=
 =?us-ascii?Q?I/ejq8YC9HvBlD3Uj8ldW4OA0XGGQ0ON4Yv5vlkv0mm5TDBq2dJSsk9xS7Tu?=
 =?us-ascii?Q?6un7fTY5eEcIPH/lviULUxf36bQmlRCvoQ09SEIYcIKar5PYAy7LJYYDOTdW?=
 =?us-ascii?Q?3uXsh2JoyZm2GZudx968Ix6USF9pTcpzxEz/KdXWlJZPp9FZFWsOQjRpmTA6?=
 =?us-ascii?Q?JYgk2QZeRSpUI2AX52MUEEFwXAhC5jsOxYRt8YUzqt9KnpSwIJhT5r8Fy8Xf?=
 =?us-ascii?Q?MpNjuXBHxssuYpXFF4fpL082oxCuwJ3sKHky3pzYi5LwFc0pQ9sC6gnWpxuW?=
 =?us-ascii?Q?Tg8QsZCZj12960+Of7R1MhGnZzkz1/ul1nDHSer8A04b3sfV0s5Vbj3krdxs?=
 =?us-ascii?Q?v9sIBb31S+vjhTmXT15UYjEQvPSptqyFYIMs+9va/h7muakOIb6g/7zPBZqy?=
 =?us-ascii?Q?mYAD8FKEHnQkLL7cGZ4+qBpafXbovu9uY9iyZCaBXXp0yyY067sYSOW3lUYl?=
 =?us-ascii?Q?R04ok1lqr91q4O7BaaelqmxsI1Jc2w1DYbQcvWTGEnbQa9mhCmO72GYNdgV1?=
 =?us-ascii?Q?V8klavZ/HY054cZR/sgY7RWB4IocQZugy1KbyYGzfj0YkRe/4e1Lpc1KKDti?=
 =?us-ascii?Q?Jskg6zOYN6+ZyRQ57PPvcVWGnk+S?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QbMztwWGw8bMLO2d573mvM2csx8F8F2+ZT/SrUYeUHK5BKjmPQhE9nDe8GFI?=
 =?us-ascii?Q?Yact2IbV/Y64eLgcLE01OOC9OzkSAS+OA47Gdmmc9ZSTfCfSYJOLDx6z3/dl?=
 =?us-ascii?Q?KwflH3Lx0xcbE+7/gLIwzX8ZLmeDlgT2ibVxDpQXUzYdkqT7rBv+dFqEGwdS?=
 =?us-ascii?Q?roPaquBVdNz5XDpEkUTX/SIybGa5VWV7AFcCx8C79/a7v5DNAverQKMVtPwH?=
 =?us-ascii?Q?TaUbsfZa5n+cK33n2yqyX3GJIZPnUe1m6joIUcc6j2GfyZdqJ1ntHMw9gMFX?=
 =?us-ascii?Q?KsVJ0tR5eWtKkh2y9LMQUa1PnVBAwdcCK6vFp2kykGll8WIvQrWQKJopLADf?=
 =?us-ascii?Q?W8MsN0MEXeDRJ63osRM9rVmdXanuoVmq8GWMWpDTopglxSeCfXKQuGJcyNmo?=
 =?us-ascii?Q?aps1P0mcVdmWJdgqpW0wvvpSNJdRiJWkPF5/4RTLopozIvfIpyX0m73SBD2K?=
 =?us-ascii?Q?8kc7nA56Q+PyGWL8R7NEHXevX8hJNXBTKiWFwwr/OyyCQtmdNnisHAu0nDhD?=
 =?us-ascii?Q?qdw59rbKGy4tzgHAxfWk34RzoXTnCXwml2tVuRwnSua68AQ/psmfF1zUon4N?=
 =?us-ascii?Q?PGpbjy2MIZ+FPW4kLSvFfTlYFwAy3Mu2j+obrHPWY/1tsbddwyTbwJD+Z+Nz?=
 =?us-ascii?Q?ClFGlIpBNoatMq0TaaeG2a2MoWcuK4JxbaRw0aclDnTXh617HN7oYhRov7Wb?=
 =?us-ascii?Q?o9i29mYxgnAT4yMjXrcQ3WOYTSc4eVeZWSGeHJhb8r/YEZaYxesgW64n3QKQ?=
 =?us-ascii?Q?Jnuw75KlPCymrL0bPX7Ucrzj0vooupjuVBttQUk3tnLgXFaBOfdijSPGCH4k?=
 =?us-ascii?Q?LyeZzaBMrKllUN2gh+Ulzzxf90epSxGUcD7rYp9KpWjsl67k2mCa4fAGwEsJ?=
 =?us-ascii?Q?hdPSmQHHwkdRvREjiC8t7tzUdXmBV77cD4k+h0JWiygQMEVLmbX0RwY4Y6Yh?=
 =?us-ascii?Q?+zM3o+8H44zlLIE+FovnAeMIXkqxzK0i40ybVnGNKHijMxyHGyCmMlPMBYin?=
 =?us-ascii?Q?W5/zBHFyer935kDPwwDpPs0s4/mWDbeMmzLmejUCN756lhaOhvSR7uB5WIs+?=
 =?us-ascii?Q?+2fXhDfqq6bdbChGOPjqoNwx/qZjRgyRKD98138B/KkdNj8GQw143nzjeOQ3?=
 =?us-ascii?Q?Kp1qt19crhB15hD4Bm/zqiO3+C1F1/fBtYBakeP5n/D8SZFj2n4zunj581zg?=
 =?us-ascii?Q?lTvbWVG5zozNZ0x8+p71jEBEntSpSBCuVL/22mS9Py6WtunvqdIUAneEYa3F?=
 =?us-ascii?Q?Ix0MQhKWobQI+n1VR84HrPsCJq1zOCv23vJD4z4Wvy5n7igjMQ/CHIiMvPHS?=
 =?us-ascii?Q?u43COK2NMRXjVhi0nFHPPdLsK9Bs5rHNxhckyP6duIG5s6ljpdXtjgLXW8z2?=
 =?us-ascii?Q?4sJAklYi5Xcn8dmyxesZrZG/OqaUHYdHzDAR4d80cKmuGiiamoZyL0jonJ8Y?=
 =?us-ascii?Q?71dVP5PNE7jgw7LeIPzN46O/xrplOytc81zMNwcJhP8vPRYPLBzZ7d6LnNaA?=
 =?us-ascii?Q?khomjL5riYtBp0slHbvCripQGCoKNfjotsDLO/fgi0uD6hNkrF7o5b9E5zdL?=
 =?us-ascii?Q?dBOISULTUWkVUe/F5MPWCxl67+m8A8FlLLJdA4W1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c018612f-997b-4108-8e37-08dd0359db76
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 20:37:42.6552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kHobkhbF7P4RBh4stvgjeFibzsbNhosQO+FTeuhB07tw8Q/k72pNSPjM4CsR4AZ84ug+yqv5ZbyckyHVS/OkpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8868

On Tue, Nov 12, 2024 at 09:14:49PM +0100, Niklas Cassel wrote:
> Hello Frank,
>
> On Tue, Nov 12, 2024 at 12:48:16PM -0500, Frank Li wrote:
> > Add three registers: doorbell_bar, doorbell_addr, and doorbell_data,
> > along with doorbell_done. Use pci_epf_alloc_doorbell() to allocate a
> > doorbell address space.
> >
> > Enable the Root Complex (RC) side driver to trigger pci-epc-test's doorbell
> > callback handler by writing doorbell_data to the mapped doorbell_bar's
> > address space.
> >
> > Set doorbell_done in the doorbell callback to indicate completion.
> >
> > To avoid broken compatibility, add new command COMMAND_ENABLE_DOORBELL
> > and COMMAND_DISABLE_DOORBELL. Host side need send COMMAND_ENABLE_DOORBELL
> > to map one bar's inbound address to MSI space. the command
> > COMMAND_DISABLE_DOORBELL to recovery original inbound address mapping.
> >
> > 	 	Host side new driver	Host side old driver
> >
> > EP: new driver      S				F
> > EP: old driver      F				F
> >
> > S: If EP side support MSI, 'pcitest -B' return success.
> >    If EP side doesn't support MSI, the same to 'F'.
> >
> > F: 'pcitest -B' return failure, other case as usual.
> >
> > Tested-by: Niklas Cassel <cassel@kernel.org>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Change from v5 to v6
> > - rename doorbell_addr to doorbell_offset
>
> Is there a reason why you chose to not incorporate the helper function
> that I suggested here:
> https://lore.kernel.org/linux-pci/ZzMtKUFi30_o6SwL@ryzen/
>
> I didn't see any reply from you to that message.

Oh, you said at
https://lore.kernel.org/imx/ZzIVzfkZe-hkAb4G@ryzen/T/#mc10e69e0e1e20cc8d8da9a8808177407d22bce06

I think you give up your idea about helper function, because it is one
for doorbell_offset, the other is for the atu address. bar's struct is
difference with reg. even it is similar,

one if use "addr & (align - 1)" to get offset, the other is "addr & ~algin"
to get base address.

>
> Personally I think that it is nice to have the alignment code in a single
> function, rather than duplicating the code. The helper also looks quite
> similar to how we do outbound address translation alignment:
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=endpoint&id=e73ea1c2d4d8f7ba5daaf7aa51171f63cf79bcd8
> so that people will recognize the pattern more easily.

Do you means add help function, which wrap epc's .align_addr()? I know you
make some improvement about EP's alignment, but I have not realized that
related this thread at all.

>
> But I guess you didn't like my suggestion?
> (Which is fine, but I would have expected some motivation.)

May "I now see why you did this.
One function is using the db offset, and the other is using the db base."
mis-lead me.

If I understand correct here, I can add wrap function for epc's
.align_addr(). at next version.

Frank
>
>
> Kind regards,
> Niklas

