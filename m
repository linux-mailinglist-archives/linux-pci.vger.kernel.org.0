Return-Path: <linux-pci+bounces-39063-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FCCBFE137
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 21:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D203B3A8038
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 19:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9511733509F;
	Wed, 22 Oct 2025 19:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oN1NpNUp"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013031.outbound.protection.outlook.com [40.107.162.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D67A34FF46;
	Wed, 22 Oct 2025 19:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761162258; cv=fail; b=K9GXphMn4+jlBAkjAF+Ors2OsSa13h2EmSbKx0W1q2EOWfWhZ1f6BiqK1oiNJZr9VWPVWpyQZlpOGEp7rSeJ3agUKLrg/Xbz5Fxeb/sYx0DBlpWD8D2pA3JxvzQWGlfl1XH6J2/KO1qzJ1gXbVd/FuDS97OI0fiAAN50k/FRFLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761162258; c=relaxed/simple;
	bh=2TJSMSsQf8jxLeqoe3Vi5pCbsPlgHl8r2sT4HPAna8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XsYOf2JRM5Dnisx40RT4b7W0w2pu8B10VXxoEgRM0dIdgcdFqND1ViqkFmXgLb5+fwukO9MOjAAVX9UIQi1AbVZSsa6mizYt4iaAP5bxYmMoRxZF5+28qXIUDNE/rKVSO4Ix8AhHxJeuhn0V/3WAwnJithZgruLn9EbW93MBBl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oN1NpNUp; arc=fail smtp.client-ip=40.107.162.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f/cdwKYCN0NAmV8Fy8oKUZ4t14VsN11jWpF5qo8sStQT1mZZdbg/u4YOxm35U8MpIyXIDTeFcBL42rqXWaOH1rpQCk2xPorF8htKUEswq6I7/Qf9KjV/gT5Qa79MxJ/WLa7BwFRNv6KesXQy3NsQzfSa3r9y5bw3sHDXmquFR+Hs69OEb/HEUW3JgW+9i0r6U56AdbqSmGf8KumWs8ph6hILsKONDd3LxL4yTqDZehbRozpsbo0d4cs6yClhleiGVi731DSAPDgC3VymwnGTuZhsCXaJdurMq+JJuYPsicrvt8LWLzHiAavhBGmiz6SO0Vs1xFd/eDNoXR5umGRiJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nPtU1Dl37CF08iSWfaNAYIaCr+MvCHInhNkdnO9Mk98=;
 b=i7rXjDTTFDG+0xwYZOFJJlqNBJ7ce5Kr3TFIt+dUuT2Sgp45aELpoWT7LF3DuP1R06n2ZwNYLR9c3uQwMS67JOtb7Vvx5fAJY8IskTxJcMDN8iEwBqztTW4Uu7THKeQxPEvf6pVubujlrnqcwYSR8p1MKzPUwmsdRjkT3tTDTpZa9aFilWKlhdmdLuAXlFmPbRSfWpnRbLFVpzVbTCKAxUWzIV7FrlEVMHr6NXSzGHS+ffqdyMw1Bk5mEHO8nuyPpz/qb2oEToEU7PLpmmPCG1xmle+nkg+PclgMAlXYEDK6vfxzJu/bJlO/BODEoA2VgtybqcdtsAGk8Mame8PrXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPtU1Dl37CF08iSWfaNAYIaCr+MvCHInhNkdnO9Mk98=;
 b=oN1NpNUpXUyAWAHQnEwGA3yqAIJBlLB7zCX3KE5H8vhj1iF4/CB02rXYvV/O5tQuF0JA6voT0C5yEIM1IwdVCr/lK1VKXYeAdwBL1VBlICY1I8Q7VRmzZhyKg53epAR0SjuqddpFqaL9SdH6Ld1+xDDNjAN78rjbQjh7jwz+vyoq8CX5h4sYcXkI5II3yDSgQetgAV4laByHSDDTbORSx1sz0D1jrlARTOs5E7cXahb62bahekjv0fcNI1xEeMDGM09/XlGyOYRv7R+qXg8nCyF+JKum0PkP5NbsFWDTGLXQ+uCGrqrleGD/nIHZ2DkhL+upjCaQxpfMhvJvutVGXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AM9PR04MB8553.eurprd04.prod.outlook.com (2603:10a6:20b:434::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Wed, 22 Oct
 2025 19:44:11 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 19:44:11 +0000
Date: Wed, 22 Oct 2025 15:44:00 -0400
From: Frank Li <Frank.li@nxp.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: chester62515@gmail.com, mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com, s32@nxp.com, bhelgaas@google.com,
	jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com,
	Ghennadi.Procopciuc@nxp.com, ciprianmarian.costea@nxp.com,
	bogdan.hamciuc@nxp.com, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	cassel@kernel.org
Subject: Re: [PATCH 3/4 v3] PCI: s32g: Add initial PCIe support (RC)
Message-ID: <aPk0ANXxF4cU9nfm@lizhi-Precision-Tower-5810>
References: <20251022174309.1180931-1-vincent.guittot@linaro.org>
 <20251022174309.1180931-4-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022174309.1180931-4-vincent.guittot@linaro.org>
X-ClientProxiedBy: SJ0PR03CA0040.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::15) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AM9PR04MB8553:EE_
X-MS-Office365-Filtering-Correlation-Id: c6248d52-efe8-4035-3b1d-08de11a35f85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|52116014|376014|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vdijQlOvDhMVT+jV1Y8BgaEvWJk/GJ3jO17LMEcu1duNMrb8EutisKFyuh5W?=
 =?us-ascii?Q?bCx/sTTpdula608dgLJQ8k2KnxxJ6T7+gINyPkSIHuCA9mFoMyJZeAxo7a3q?=
 =?us-ascii?Q?IW13oFNKkg8KaMeNNM1OPVkS3hRDWj7QrTdB0h2XBh8/PqSsOpsf2V7E4GFH?=
 =?us-ascii?Q?s/o18Y2vAX84b27Z1PSow6xL5Av7T1Y7k90H6D8Gi87KPd87TSH9WlhAcHxq?=
 =?us-ascii?Q?v94fiZtbd7X7dsUfYw1HbmMsYvOp/xOrHvtnF0peIJ9jv9xDJqPiBX5qzxSX?=
 =?us-ascii?Q?XVNKpphzjWcEM5iovhcphdy+rdeOydrJGRywZdbSnn5lnrFHk4I0zYU28piw?=
 =?us-ascii?Q?zPUv9k6BpY4GyqaeaDISdouMmhaQLcuQazlaxkZs77TBm7N1ZzQYs6M2ZFeu?=
 =?us-ascii?Q?jl0/O/X1zzJ8xNK0mrRv2Fj9Uh0xwpoJC36QBWb8XdbGbLC2YsEDzNh2c6PU?=
 =?us-ascii?Q?vqYnm4pfSiJN84bwEfw3HFSu2QcOhUXQum4naVfgyyTbEUn+QwWarriMtbaB?=
 =?us-ascii?Q?8rQUnvlsoDgVhYzbScqrUrW1BjDT4VlsAsQyo115IXYdrwue3qadTv/A/hMJ?=
 =?us-ascii?Q?NAOgJ67BsWjfOp6uQIUHwLOzcTgvklH/oOm9FYwsLbIthwH3rQIbKcjGGX2W?=
 =?us-ascii?Q?IUTTZH4JGbsukCrU9jFQndu0NWYpIhEHIMEb9vKCZqjUJ8f8OX0/FgMusnh3?=
 =?us-ascii?Q?GjMF8pLsxj/lQMDLlfx0fiTwryiDJsBovsx6t98G2ZOVzATPomyRmqdxzxvq?=
 =?us-ascii?Q?DdGe/MI34iFEt4VcqPJXsip3nh7Wx0XJbnhIafUtBh+moeFZYAmY07ack2+W?=
 =?us-ascii?Q?Rk/vovEDZWdpjaXcKBWwpumlI9cPf2TzWwy0Yp99cvGKjulkPInNrksuVGh0?=
 =?us-ascii?Q?LR36uSsv4nT797Km61QFPCApPOJUdK7uhANrDPUopQtPygKuf8cgtOE9XCDl?=
 =?us-ascii?Q?HBHg2hiWABJIp0J7L5qhgSfGC5JRAr8vo6SHcA3w1zrqhXUTZvwF5YUmxwJ7?=
 =?us-ascii?Q?58EbYCSfByxYQdCSj8hza95mPqA5Ve5WPvqpaGq6ZWwS+lOEFlp1558TufF3?=
 =?us-ascii?Q?8mTWXZW5cLiq7jvMKO83ZDywaoIpDMDEjQP/WHmRVL7yFcMGz6LRLi43usWt?=
 =?us-ascii?Q?FlGejOJPmR5UB6WMScO+14n0vYOPIryYLpXsKKAWWheBSUfF2hs3B7+sQ4ex?=
 =?us-ascii?Q?cE/5TNLdLfIYsCcAE9Pg+BqtLgTLa/vfIfmxoRLc8ARf5mT4Kx8NmfDi3Z0O?=
 =?us-ascii?Q?M0hBipxPtTl/u0ZUAonXILIS+EtpidqG/YMcIlAN0dNm1nKlfzaxrq3equ9p?=
 =?us-ascii?Q?yaozItsMiYDxBcFe+JjJocDn7g9o1KszAx8koRAQ9eh3OFSh6lnpKA9kRkLk?=
 =?us-ascii?Q?GDuUl1Ig2qboxf/fqH2UJeVAAxJrL5WHuSjKXL1XjSPDiiAgUVBpArVoRmxE?=
 =?us-ascii?Q?5Eu42dslLJLqXT0msyoIj44tICOn1wTw497JKgZxdtNzrkJIj5DuPxSkOfgn?=
 =?us-ascii?Q?Pgp7m0t0VjY+zDTqe4/RXwJ3egvF923WwTd8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(52116014)(376014)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9Q2ZanHW5JDwY+cD/cQ6GHo0zV17OAtDXiQyW62LcTdHczZ0PZK7Z4sMMB1A?=
 =?us-ascii?Q?+wfQWjB4yEE8KU+zTjRo722E3GTKgRjqHUFbk71wmitSpEcBK5aUUxv7ow3V?=
 =?us-ascii?Q?gJ1mJMy5QylNwMIyg4KA9EqDhhTfWjOqXNtDrmdzGIqO7crD+Z8AW6Ws1bdP?=
 =?us-ascii?Q?pW+T/kmrujZZH9zvIwVbp9XKpe5zHXjUw0kAvqrYVcfEwf5A2H61NfyLj+p0?=
 =?us-ascii?Q?tYRYz+ET1TaYqHHsrYSaGH2N+kjNJJaxTK2e0uP56i5KOD8DBbkgObKIoBp8?=
 =?us-ascii?Q?Khw8pqrBQ3HaEiPCaUK0CWXYwztHt2Afw8jNHWhYmiCgUIYXlPyHlyqer8Ou?=
 =?us-ascii?Q?kISwaVeuw9hDpUneR00QfzX5v8iZlowW00b1bDgs8edNKDu8LpP7MBmiunyZ?=
 =?us-ascii?Q?k6qyHUmTYwwRiwN/ZoFIKlisG7gPcfWEHsk8EWJgBAju2kMy2PWdARRXIM5m?=
 =?us-ascii?Q?e+Ct+j4M3lBO6FpUkHtNyEgrn5RoUKcrN7JfZbCENFRSKG6Be+i7VLGCP91L?=
 =?us-ascii?Q?flltjkDEcoyGDHsOWNLqKUp2mNO6v+oT8jOU51SkzSXzU3Ut1x4IoJ6h0i9x?=
 =?us-ascii?Q?/1jkqlimYifsa9Cbfe5YiwUTD/zcLTfwleEq0x9IpA2OZ9vEiBkgKgPx3kbo?=
 =?us-ascii?Q?V1aom1gerEDqZliVZMi9g8UFbqoTNTibwzPGHZmTDorDeSulfX5CrRp97Xv4?=
 =?us-ascii?Q?JO8uJR7qSdI5y0ukZKAiSR+sQ01bnwblC0q55FUzUNjiN+WuqkC2jHqEBE19?=
 =?us-ascii?Q?csH072K0qJvRUx5B9DfV+CZoFWy0L55OcyKw484aCOlxR7gCkWcI1ZVvI8zK?=
 =?us-ascii?Q?6/ILowmvgr4AO8LxG9zZ0CzKuuMiwrBg12kw1/Zgl6qm6DR7WFltA3lVkIPp?=
 =?us-ascii?Q?tTAdGBK269sC+eUmtK+OGsXEThEHKc5ihFah77vTgWbsJfkXwpijcI7NhNmA?=
 =?us-ascii?Q?Ph58AKaAQ5TbEJ5P7okb0cT9pkgUTJHWwbGilim5MMffMa8tKMQ2UF7cLOtW?=
 =?us-ascii?Q?FHIJj2AAjYPBwWkt7F+0n4luhuZD88j7RcVLNqsHCcZA2rHg/HkHEjVcw2Ib?=
 =?us-ascii?Q?LWEuBooQlNJ3UsFFSgdSYJqR1EN5zVDBoKJilOGboTHincaZcmAF0ONgiqzD?=
 =?us-ascii?Q?57qDu5uC85PaGLyuQTiSWqbsfn8oF9Mm1XexoLhyKvv9qvuAwhxiI8mHXftd?=
 =?us-ascii?Q?/e19xCY/LEb0kXhQPPP6nHVvw3TxYmUSbuyrx97OIyAb0SveMyRjWsH327hn?=
 =?us-ascii?Q?khi7njIag8oAs0vWzMrL6aw/nd4FL6f/Ttne5+2yKT3GF/EzWAvsXSbI1jV6?=
 =?us-ascii?Q?7y04Pmuaown+RHU4H9AUdq3MRD5wwvHWWymduJCqQpoH83LIKCVv8ZWHvO+t?=
 =?us-ascii?Q?8U9YXANcNLuWTLWQaHTdPIOOagpRU/RCISR73cft89800xsq7ldD1m3ygcyq?=
 =?us-ascii?Q?qzWESCimCOjDwYNZwUKY/xitLOMzbl8wmsnsKHP1N3uOWWDHRxdLaEN8BaWl?=
 =?us-ascii?Q?q7xO7IooWd7Utw1eo6vt0MAe/H2JzgSfCX6VVd4n16KBg4+MBrMV4fQGLEpr?=
 =?us-ascii?Q?2tD1X291rZqWBVnDCtlnlwRlmhpzKQw/+ZPbaiTP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6248d52-efe8-4035-3b1d-08de11a35f85
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 19:44:11.6102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AiNWVir37CUMByVjYKyAJ9n6SNBgNLyfkM4u+11b9V+kghL5D6aEWNSy0R/DYGN0x3pkSSdkvOgcHd1PsoiHng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8553

On Wed, Oct 22, 2025 at 07:43:08PM +0200, Vincent Guittot wrote:
> Add initial support of the PCIe controller for S32G Soc family. Only
> host mode is supported.
>
> Co-developed-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
> Signed-off-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
> Co-developed-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
> Co-developed-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  drivers/pci/controller/dwc/Kconfig            |  10 +
>  drivers/pci/controller/dwc/Makefile           |   1 +
>  .../pci/controller/dwc/pcie-nxp-s32g-regs.h   |  37 ++
>  drivers/pci/controller/dwc/pcie-nxp-s32g.c    | 439 ++++++++++++++++++
>  4 files changed, 487 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-nxp-s32g-regs.h
>  create mode 100644 drivers/pci/controller/dwc/pcie-nxp-s32g.c
>
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 349d4657393c..3f3172a0cd95 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -406,6 +406,16 @@ config PCIE_UNIPHIER_EP
>  	  Say Y here if you want PCIe endpoint controller support on
>  	  UniPhier SoCs. This driver supports Pro5 SoC.
>
> +config PCIE_NXP_S32G
> +	tristate "NXP S32G PCIe controller (host mode)"
> +	depends on ARCH_S32 || COMPILE_TEST
> +	select PCIE_DW_HOST
> +	help
> +	  Enable support for the PCIe controller in NXP S32G based boards to
> +	  work in Host mode. The controller is based on DesignWare IP and
> +	  can work either as RC or EP. In order to enable host-specific
> +	  features PCIE_S32G must be selected.
> +
>  config PCIE_SOPHGO_DW
>  	bool "Sophgo DesignWare PCIe controller (host mode)"
>  	depends on ARCH_SOPHGO || COMPILE_TEST
> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> index 7ae28f3b0fb3..3301bbbad78c 100644
> --- a/drivers/pci/controller/dwc/Makefile
> +++ b/drivers/pci/controller/dwc/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
>  obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
>  obj-$(CONFIG_PCIE_FU740) += pcie-fu740.o
>  obj-$(CONFIG_PCI_IMX6) += pci-imx6.o
> +obj-$(CONFIG_PCIE_NXP_S32G) += pcie-nxp-s32g.o
>  obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
>  obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone.o
>  obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
> diff --git a/drivers/pci/controller/dwc/pcie-nxp-s32g-regs.h b/drivers/pci/controller/dwc/pcie-nxp-s32g-regs.h
> new file mode 100644
> index 000000000000..6f04204054dd
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-nxp-s32g-regs.h
> @@ -0,0 +1,37 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2015-2016 Freescale Semiconductor, Inc.
> + * Copyright 2016-2023, 2025 NXP
> + */
> +
> +#ifndef PCIE_S32G_REGS_H
> +#define PCIE_S32G_REGS_H
> +
> +/* PCIe controller Sub-System */
> +
> +/* Link Interrupt Control And Status */
> +#define PCIE_S32G_LINK_INT_CTRL_STS		0x40
> +#define LINK_REQ_RST_NOT_INT_EN			BIT(1)
> +#define LINK_REQ_RST_NOT_CLR			BIT(2)
> +
> +/* PCIe controller 0 General Control 1 */
> +#define PCIE_S32G_PE0_GEN_CTRL_1		0x50
> +#define DEVICE_TYPE_MASK			GENMASK(3, 0)
> +#define DEVICE_TYPE(x)				FIELD_PREP(DEVICE_TYPE_MASK, x)
> +#define SRIS_MODE				BIT(8)
> +
> +/* PCIe controller 0 General Control 3 */
> +#define PCIE_S32G_PE0_GEN_CTRL_3		0x58
> +#define LTSSM_EN				BIT(0)

Need S32G prefix for register field to avoid name collision.

> +
> +/* PCIe Controller 0 Transmit Message Request */
> +#define PCIE_S32G_PE0_TX_MSG_REQ		0x80
> +#define PME_TURN_OFF_REQ			BIT(19)

I think needn't use customized pme_turn_off. You can use common
dw_pcie_pme_turn_off(), which use iatu map a windows to send out pcie msg.
That's fit all new version dwc controller. I think s32 should be new enough.

> +
> +/* PCIe Controller 0 Link Debug 2 */
> +#define PCIE_S32G_PE0_LINK_DBG_2		0xB4
> +#define SMLH_LTSSM_STATE_MASK			GENMASK(5, 0)
> +#define SMLH_LINK_UP				BIT(6)
> +#define RDLH_LINK_UP				BIT(7)
> +
> +#endif  /* PCI_S32G_REGS_H */
> diff --git a/drivers/pci/controller/dwc/pcie-nxp-s32g.c b/drivers/pci/controller/dwc/pcie-nxp-s32g.c
> new file mode 100644
> index 000000000000..53529f63c555
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-nxp-s32g.c
> @@ -0,0 +1,439 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCIe host controller driver for NXP S32G SoCs
> + *
> + * Copyright 2019-2025 NXP
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/memblock.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of_address.h>
> +#include <linux/pci.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/sizes.h>
> +#include <linux/types.h>
> +
> +#include "pcie-designware.h"
> +#include "pcie-nxp-s32g-regs.h"
> +
> +struct s32g_pcie {
> +	struct dw_pcie	pci;
> +	void __iomem *ctrl_base;
> +	struct phy *phy;
> +};
> +
> +#define to_s32g_from_dw_pcie(x) \
> +	container_of(x, struct s32g_pcie, pci)
> +
> +static void s32g_pcie_writel_ctrl(struct s32g_pcie *s32g_pp, u32 reg, u32 val)
> +{
> +	writel(val, s32g_pp->ctrl_base + reg);
> +}
> +
> +static u32 s32g_pcie_readl_ctrl(struct s32g_pcie *s32g_pp, u32 reg)
> +{
> +	return readl(s32g_pp->ctrl_base + reg);
> +}
> +
> +static void s32g_pcie_enable_ltssm(struct s32g_pcie *s32g_pp)
> +{
> +	u32 reg;
> +
> +	reg = s32g_pcie_readl_ctrl(s32g_pp, PCIE_S32G_PE0_GEN_CTRL_3);
> +	reg |= LTSSM_EN;
> +	s32g_pcie_writel_ctrl(s32g_pp, PCIE_S32G_PE0_GEN_CTRL_3, reg);
> +}
> +
> +static void s32g_pcie_disable_ltssm(struct s32g_pcie *s32g_pp)
> +{
> +	u32 reg;
> +
> +	reg = s32g_pcie_readl_ctrl(s32g_pp, PCIE_S32G_PE0_GEN_CTRL_3);
> +	reg &= ~LTSSM_EN;
> +	s32g_pcie_writel_ctrl(s32g_pp, PCIE_S32G_PE0_GEN_CTRL_3, reg);
> +}
> +
> +static bool is_s32g_pcie_ltssm_enabled(struct s32g_pcie *s32g_pp)
> +{
> +	return (s32g_pcie_readl_ctrl(s32g_pp, PCIE_S32G_PE0_GEN_CTRL_3) & LTSSM_EN);
> +}
> +
> +static enum dw_pcie_ltssm s32g_pcie_get_ltssm(struct dw_pcie *pci)
> +{
> +	struct s32g_pcie *s32g_pp = to_s32g_from_dw_pcie(pci);
> +	u32 reg = s32g_pcie_readl_ctrl(s32g_pp, PCIE_S32G_PE0_LINK_DBG_2);
> +
> +	return (enum dw_pcie_ltssm)FIELD_GET(SMLH_LTSSM_STATE_MASK, reg);
> +}

Does dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG0); work for s32?

> +
> +#define PCIE_LINKUP	(SMLH_LINK_UP | RDLH_LINK_UP)
> +
> +static bool s32g_has_data_phy_link(struct s32g_pcie *s32g_pp)
> +{
> +	u32 reg = s32g_pcie_readl_ctrl(s32g_pp, PCIE_S32G_PE0_LINK_DBG_2);
> +
> +	if ((reg & PCIE_LINKUP) == PCIE_LINKUP) {
> +		switch (FIELD_GET(SMLH_LTSSM_STATE_MASK, reg)) {
> +		case DW_PCIE_LTSSM_L0:
> +		case DW_PCIE_LTSSM_L0S:
> +		case DW_PCIE_LTSSM_L1_IDLE:
> +			return true;
> +		default:
> +			return false;
> +		}
> +	}
> +
> +	return false;
> +}
> +
> +static bool s32g_pcie_link_up(struct dw_pcie *pci)
> +{
> +	struct s32g_pcie *s32g_pp = to_s32g_from_dw_pcie(pci);
> +
> +	if (!is_s32g_pcie_ltssm_enabled(s32g_pp))
> +		return false;
> +
> +	return s32g_has_data_phy_link(s32g_pp);
> +}
> +
> +static int s32g_pcie_start_link(struct dw_pcie *pci)
> +{
> +	struct s32g_pcie *s32g_pp = to_s32g_from_dw_pcie(pci);
> +
> +	s32g_pcie_enable_ltssm(s32g_pp);
> +
> +	return 0;
> +}
> +
> +static void s32g_pcie_stop_link(struct dw_pcie *pci)
> +{
> +	struct s32g_pcie *s32g_pp = to_s32g_from_dw_pcie(pci);
> +
> +	s32g_pcie_disable_ltssm(s32g_pp);
> +}
> +
> +static struct dw_pcie_ops s32g_pcie_ops = {
> +	.get_ltssm = s32g_pcie_get_ltssm,
> +	.link_up = s32g_pcie_link_up,
> +	.start_link = s32g_pcie_start_link,
> +	.stop_link = s32g_pcie_stop_link,
> +};
> +
> +static void s32g_pcie_pme_turn_off(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct s32g_pcie *s32g_pp = to_s32g_from_dw_pcie(pci);
> +	u32 reg;
> +
> +	reg = s32g_pcie_readl_ctrl(s32g_pp, PCIE_S32G_PE0_TX_MSG_REQ);
> +	reg |= PME_TURN_OFF_REQ;
> +	s32g_pcie_writel_ctrl(s32g_pp, PCIE_S32G_PE0_TX_MSG_REQ, reg);
> +}
> +
> +static const struct dw_pcie_host_ops s32g_pcie_host_ops = {
> +	.pme_turn_off = s32g_pcie_pme_turn_off,
> +};

See above comments, I think common dwc pme_turn_off() should work for s32g.

> +
> +static void s32g_pcie_disable_equalization(struct dw_pcie *pci)
> +{
> +	u32 reg;
> +
> +	reg = dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);
> +	reg &= ~(GEN3_EQ_CONTROL_OFF_FB_MODE |
> +		 GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC);
> +	reg |= FIELD_PREP(GEN3_EQ_CONTROL_OFF_FB_MODE, 1) |
> +	       FIELD_PREP(GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC, 0x84);
> +
> +	dw_pcie_dbi_ro_wr_en(pci);
> +	dw_pcie_writel_dbi(pci, GEN3_EQ_CONTROL_OFF, reg);
> +	dw_pcie_dbi_ro_wr_dis(pci);
> +}
> +
> +/* Configure the AMBA AXI Coherency Extensions (ACE) interface */
> +static void s32g_pcie_reset_mstr_ace(struct dw_pcie *pci, u64 ddr_base_addr)
> +{
> +	u32 ddr_base_low = lower_32_bits(ddr_base_addr);
> +	u32 ddr_base_high = upper_32_bits(ddr_base_addr);
> +
> +	dw_pcie_dbi_ro_wr_en(pci);
> +	dw_pcie_writel_dbi(pci, COHERENCY_CONTROL_3_OFF, 0x0);
> +
> +	/*
> +	 * Ncore is a cache-coherent interconnect module that enables the
> +	 * integration of heterogeneous coherent and non-coherent agents in
> +	 * the chip. Ncore Transactions to peripheral should be non-coherent
> +	 * or it might drop them.
> +	 * One example where this is needed are PCIe MSIs, which use NoSnoop=0
> +	 * and might end up routed to Ncore.
> +	 * Define the start of DDR as seen by Linux as the boundary between
> +	 * "memory" and "peripherals", with peripherals being below.
> +	 */
> +	dw_pcie_writel_dbi(pci, COHERENCY_CONTROL_1_OFF,
> +			   (ddr_base_low & CFG_MEMTYPE_BOUNDARY_LOW_ADDR_MASK));
> +	dw_pcie_writel_dbi(pci, COHERENCY_CONTROL_2_OFF, ddr_base_high);
> +	dw_pcie_dbi_ro_wr_dis(pci);
> +}
> +
> +static void s32g_init_pcie_controller(struct s32g_pcie *s32g_pp)
> +{
> +	struct dw_pcie *pci = &s32g_pp->pci;
> +	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	u32 val;
> +
> +	/* Set RP mode */
> +	val = s32g_pcie_readl_ctrl(s32g_pp, PCIE_S32G_PE0_GEN_CTRL_1);
> +	val &= ~DEVICE_TYPE_MASK;
> +	val |= DEVICE_TYPE(PCI_EXP_TYPE_ROOT_PORT);
> +
> +	/* Use default CRNS */
> +	val &= ~SRIS_MODE;
> +
> +	s32g_pcie_writel_ctrl(s32g_pp, PCIE_S32G_PE0_GEN_CTRL_1, val);
> +
> +	/* Disable phase 2,3 equalization */
> +	s32g_pcie_disable_equalization(pci);
> +
> +	/*
> +	 * Make sure we use the coherency defaults (just in case the settings
> +	 * have been changed from their reset values)
> +	 */
> +	s32g_pcie_reset_mstr_ace(pci, memblock_start_of_DRAM());
> +
> +	dw_pcie_dbi_ro_wr_en(pci);
> +
> +	val = dw_pcie_readl_dbi(pci, PCIE_PORT_FORCE);
> +	val |= PORT_FORCE_DO_DESKEW_FOR_SRIS;
> +	dw_pcie_writel_dbi(pci, PCIE_PORT_FORCE, val);
> +
> +	/*
> +	 * Set max payload supported, 256 bytes and
> +	 * relaxed ordering.
> +	 */
> +	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCTL);
> +	val &= ~(PCI_EXP_DEVCTL_RELAX_EN |
> +		 PCI_EXP_DEVCTL_PAYLOAD |
> +		 PCI_EXP_DEVCTL_READRQ);
> +	val |= PCI_EXP_DEVCTL_RELAX_EN |
> +	       PCI_EXP_DEVCTL_PAYLOAD_256B |
> +	       PCI_EXP_DEVCTL_READRQ_256B;
> +	dw_pcie_writel_dbi(pci, offset + PCI_EXP_DEVCTL, val);
> +
> +	/* Enable errors */
> +	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCTL);
> +	val |= PCI_EXP_DEVCTL_CERE |
> +	       PCI_EXP_DEVCTL_NFERE |
> +	       PCI_EXP_DEVCTL_FERE |
> +	       PCI_EXP_DEVCTL_URRE;
> +	dw_pcie_writel_dbi(pci, offset + PCI_EXP_DEVCTL, val);
> +
> +	val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
> +	val |= GEN3_RELATED_OFF_EQ_PHASE_2_3;
> +	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
> +
> +	dw_pcie_dbi_ro_wr_dis(pci);
> +}
> +
> +static int s32g_init_pcie_phy(struct s32g_pcie *s32g_pp)
> +{
> +	struct dw_pcie *pci = &s32g_pp->pci;
> +	struct device *dev = pci->dev;
> +	int ret;
> +
> +	ret = phy_init(s32g_pp->phy);
> +	if (ret) {
> +		dev_err(dev, "Failed to init serdes PHY\n");
> +		return ret;
> +	}
> +
> +	ret = phy_set_mode_ext(s32g_pp->phy, PHY_MODE_PCIE, 0);

0 use PHY_MODE_PCIE_RC

> +	if (ret) {
> +		dev_err(dev, "Failed to set mode on serdes PHY\n");
> +		goto err_phy_exit;
> +	}
> +
> +	ret = phy_power_on(s32g_pp->phy);
> +	if (ret) {
> +		dev_err(dev, "Failed to power on serdes PHY\n");
> +		goto err_phy_exit;
> +	}
> +
> +	return 0;
> +
> +err_phy_exit:
> +	phy_exit(s32g_pp->phy);
> +	return ret;
> +}
> +
> +static int s32g_deinit_pcie_phy(struct s32g_pcie *s32g_pp)
> +{
> +	struct dw_pcie *pci = &s32g_pp->pci;
> +	struct device *dev = pci->dev;
> +	int ret;
> +
> +	ret = phy_power_off(s32g_pp->phy);
> +	if (ret) {
> +		dev_err(dev, "Failed to power off serdes PHY\n");
> +		return ret;
> +	}
> +
> +	ret = phy_exit(s32g_pp->phy);
> +	if (ret) {
> +		dev_err(dev, "Failed to exit serdes PHY\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int s32g_pcie_init(struct device *dev,
> +			  struct s32g_pcie *s32g_pp)
> +{
> +	int ret;
> +
> +	s32g_pcie_disable_ltssm(s32g_pp);
> +
> +	ret = s32g_init_pcie_phy(s32g_pp);
> +	if (ret)
> +		return ret;
> +
> +	s32g_init_pcie_controller(s32g_pp);
> +
> +	return 0;
> +}
> +
> +static void s32g_pcie_deinit(struct s32g_pcie *s32g_pp)
> +{
> +	s32g_pcie_disable_ltssm(s32g_pp);
> +	s32g_deinit_pcie_phy(s32g_pp);
> +}
> +
> +static int s32g_pcie_host_init(struct s32g_pcie *s32g_pp)
> +{
> +	struct dw_pcie *pci = &s32g_pp->pci;
> +	struct dw_pcie_rp *pp = &pci->pp;
> +	int ret;
> +
> +	pp->ops = &s32g_pcie_host_ops;
> +
> +	ret = dw_pcie_host_init(pp);
> +
> +	return ret;
> +}
> +
> +static int s32g_pcie_get_resources(struct platform_device *pdev,
> +				   struct s32g_pcie *s32g_pp)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct dw_pcie *pci = &s32g_pp->pci;
> +
> +	s32g_pp->phy = devm_phy_get(dev, NULL);
> +	if (IS_ERR(s32g_pp->phy))
> +		return dev_err_probe(dev, PTR_ERR(s32g_pp->phy),
> +				"Failed to get serdes PHY\n");
> +	s32g_pp->ctrl_base = devm_platform_ioremap_resource_byname(pdev, "ctrl");
> +	if (IS_ERR(s32g_pp->ctrl_base))
> +		return PTR_ERR(s32g_pp->ctrl_base);
> +
> +	pci->dbi_base = devm_platform_ioremap_resource_byname(pdev, "dbi");
> +	if (IS_ERR(pci->dbi_base))
> +		return PTR_ERR(pci->dbi_base);

suppose dw_pcie_get_resources() already fetch dbi resource for you.

> +
> +	pci->dev = dev;
> +	pci->ops = &s32g_pcie_ops;
> +
> +	platform_set_drvdata(pdev, s32g_pp);
> +
> +	return 0;
> +}
> +
> +static int s32g_pcie_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct s32g_pcie *s32g_pp;
> +	int ret;
> +
> +	s32g_pp = devm_kzalloc(dev, sizeof(*s32g_pp), GFP_KERNEL);
> +	if (!s32g_pp)
> +		return -ENOMEM;
> +
> +	ret = s32g_pcie_get_resources(pdev, s32g_pp);
> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_no_callbacks(dev);
> +	devm_pm_runtime_enable(dev);
> +	ret = pm_runtime_get_sync(dev);
> +	if (ret < 0)
> +		goto err_pm_runtime_put;
> +
> +	ret = s32g_pcie_init(dev, s32g_pp);
> +	if (ret)
> +		goto err_pm_runtime_put;
> +
> +	ret = s32g_pcie_host_init(s32g_pp);
> +	if (ret)
> +		goto err_pcie_deinit;
> +
> +	return 0;
> +
> +err_pcie_deinit:
> +	s32g_pcie_deinit(s32g_pp);
> +err_pm_runtime_put:
> +	pm_runtime_put(dev);
> +
> +	return ret;
> +}
> +
> +static int s32g_pcie_suspend_noirq(struct device *dev)
> +{
> +	struct s32g_pcie *s32g_pp = dev_get_drvdata(dev);
> +	struct dw_pcie *pci = &s32g_pp->pci;
> +
> +	if (!dw_pcie_link_up(pci))
> +		return 0;
> +
> +	return dw_pcie_suspend_noirq(pci);
> +}
> +
> +static int s32g_pcie_resume_noirq(struct device *dev)
> +{
> +	struct s32g_pcie *s32g_pp = dev_get_drvdata(dev);
> +	struct dw_pcie *pci = &s32g_pp->pci;
> +
> +	s32g_init_pcie_controller(s32g_pp);

I think it should belong to host_init();

Frank

> +
> +	return dw_pcie_resume_noirq(pci);
> +}
> +
> +static const struct dev_pm_ops s32g_pcie_pm_ops = {
> +	NOIRQ_SYSTEM_SLEEP_PM_OPS(s32g_pcie_suspend_noirq,
> +				  s32g_pcie_resume_noirq)
> +};
> +
> +static const struct of_device_id s32g_pcie_of_match[] = {
> +	{ .compatible = "nxp,s32g2-pcie"},
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, s32g_pcie_of_match);
> +
> +static struct platform_driver s32g_pcie_driver = {
> +	.driver = {
> +		.name	= "s32g-pcie",
> +		.of_match_table = s32g_pcie_of_match,
> +		.suppress_bind_attrs = true,
> +		.pm = pm_sleep_ptr(&s32g_pcie_pm_ops),
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> +	},
> +	.probe = s32g_pcie_probe,
> +};
> +
> +module_platform_driver(s32g_pcie_driver);
> +
> +MODULE_AUTHOR("Ionut Vicovan <Ionut.Vicovan@nxp.com>");
> +MODULE_DESCRIPTION("NXP S32G PCIe Host controller driver");
> +MODULE_LICENSE("GPL");
> --
> 2.43.0
>

