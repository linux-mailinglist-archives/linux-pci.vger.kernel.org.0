Return-Path: <linux-pci+bounces-32333-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E82DB07F83
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 23:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71FA6A47860
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 21:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96508289E3D;
	Wed, 16 Jul 2025 21:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="M4aPlKUW"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011006.outbound.protection.outlook.com [52.101.70.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A43F2AE8E
	for <linux-pci@vger.kernel.org>; Wed, 16 Jul 2025 21:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752700987; cv=fail; b=dhbpnlW6nOh8fdBvreFZ0ZjAJ++nR1kkquCNRzOouQYfcaHccF/uhriuUq/r/5V9RpxswhvVRu7yKNPCN3YL5LuECzozgKt86qmFiRYeEizpBBDMid/NLHKZORaTo0qazG/hzWw3gq8KR4+rWGKR6KyoM+vzyOptxHemehekuhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752700987; c=relaxed/simple;
	bh=Ll5drYqc2xOmqsFzvrDHWDe1E+SxaX778raoSjoZtBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jA3tJCZNgzQy+p9LD9Qq0quqBm8yJIuXKLpDoBzuQNipPPDsNmP14oRTHJWDh+8g5++XSQKuPh2ZMsb5j8e3qQeJSLB4jW7LDQGPBeFCITdrIymIcV2bLzb9Ax8QPJwDlVXQBQnJ5Wu/iE6gyndOVmd+IgEpC16XiLVWfusfVnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=M4aPlKUW; arc=fail smtp.client-ip=52.101.70.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WICHkwm9guUFPQ49LIeIY2kF7HsTs2IVzjpXNWV+vX6Yh7IPoMMEs0KGL5/Ll4pU1k1fhJUuKewVc7BKexg+7QJ43gRuFULZZ+DuyUBLSE7Jo/7Wk9II5cpw2v5sVrFdBXe+e+JA3ct3LvDqL+vGBfuQd1yrOWmSGeXNDl/9nVA2VsvpZYUd89MmduljU+w/NhfsTDI0YLuZ3vjW4w55zob1nicJ/uE9JoLkFBDhbObhmZudQS1O0tfWP9rMXcR3hIBN4EA2OI14mQsqbB/43vIPVlNCA6HEvaTOk3cf9jX7Kr80kXuQ/y5G/cbsTmRKrCsYzyKZZ9mTx9LOGU9Gfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOyP76BklhvSAFGghZzyNeY5nuXzPIcGEYwgWaLkV6w=;
 b=sINVzT/wn9p0EG787CZQU6maYzZVY89yZ9Hu5xARsmqblbZnLdq16yTlx+mq3B06lleGt5Gmt+xhYeHKnAvHf8BeOhZOgqo6zUJ2gh9CrZ/hjSk19J3qFaLckCGLgf2rF3m8dCUe2bN+CSGb4UlYpus1UgbS/vk22oO4A8WNhtfuyte6GcKIAnd2JI3hGoM1Vq6nZRFYEPGIGnqMR6iPgOOUtYeP5C5wuvVCHfQcTCllUf3COdnIOCYNsu7dILk6VR0aKsK4j7gY35noVHqp/wS0JPUm6LVJO16w2nZBlqybEDbwTYu4EKz+62grLMltq/SiURAWlzCXTZIMGfvzTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOyP76BklhvSAFGghZzyNeY5nuXzPIcGEYwgWaLkV6w=;
 b=M4aPlKUWXwKXzZZDzsbiRtlg+9afSDFCl6/C3UYNBLpYRUlPjmXgzrU037TxYlwQhitzle6NkQKJbODp5AxNCfUdPMXWYl3QKKGodNvVUUSHkAZSoEoScdiAncojSYQkc/Vav+cjMgokdFe8PRwgcjC9IqmSJlVbY3/nKzf59moKuClZ0KFC6yWOwMlNLVioI191uVqdsfy91vggIpaJbJPwrzU8Mn8GH/G65DFRNS+vqpOjUkCIjOpv5Rwz2trs+uaOZERMY12JmL+Cu5JKcl3wN0stb256rRW0bXjnWeCdpQEyxwKcb0O+obL0dWDY6OTupnR7BybCYwYhNHCXFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB11455.eurprd04.prod.outlook.com (2603:10a6:102:4f0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 21:23:03 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 21:23:03 +0000
Date: Wed, 16 Jul 2025 17:22:58 -0400
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Brian Norris <briannorris@chromium.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Minghuan Lian <minghuan.Lian@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
	Rob Herring <robh+dt@kernel.org>, imx@lists.linux.dev,
	linux-pci@vger.kernel.org
Subject: Re: Does dwc/pci-layerscape.c support AER?
Message-ID: <aHgYMmjZzpVSAf0c@lizhi-Precision-Tower-5810>
References: <aHfgpWsC1GlQUIEm@google.com>
 <20250716204207.GA2554240@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716204207.GA2554240@bhelgaas>
X-ClientProxiedBy: AS4P195CA0023.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB11455:EE_
X-MS-Office365-Filtering-Correlation-Id: 47eee1b5-df8b-4823-d30a-08ddc4aef27d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|19092799006|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MidrZMzftVTPH8DCVoZ5WA7+5bxP0t56AMWhdQOyR5OFjqTc12TuFNtrES16?=
 =?us-ascii?Q?sdLgj4MeSIQr9hdhutQrHhYdEMXlz8vkAB5PpcIdsi+705BBjAJN4+HizhH5?=
 =?us-ascii?Q?iefu85I93KEYJqt4M6PziPYdXeNbHX+GBNzYXrsL3J1zeVAEh/oH6sAmusY+?=
 =?us-ascii?Q?f/O0+UoWqpfIvqRkK/pXPAgHvIzN4Wtc5jtx85zl6JAZbZ/Ce5Z9X9hdIvxI?=
 =?us-ascii?Q?FU7ZgPLd5lQ5g3XVj7RVn8494pgFYTYSbi6jpwalC3U7OhPa74PZV65SwKxr?=
 =?us-ascii?Q?l4wVTBJLK0RmIyXhhKJzANpzt2Q1pbJNK7a7TxTmUMxhzAJ3yRRsdxprnG2+?=
 =?us-ascii?Q?b1GvqFqABUas1X38pephAuNIWHTCH0PLQ/q+cCkW4rw7+MKoDxY45MpK2RE+?=
 =?us-ascii?Q?36RH9lNrywwTQrYT4HI3MZE3lNUIz69o3Okj7H2rwKMXRH9qerriRRAHxyrk?=
 =?us-ascii?Q?gr3N2BOCv+LDqn411GfZhXaGaiKttqKVNqmBgI8ayafQYD48vIVxZuKnalaR?=
 =?us-ascii?Q?RmRnzW57okuC34dG8sEF1BjVqSyapUiK9xA2yGLhSvZ8UwkwFHIFzctRQCIV?=
 =?us-ascii?Q?7/7xfSI82qaiZ+AJxL2UdFMlXHrsPo/BSBVvQtgBGvqLiQB0cHxBO0cDl9A1?=
 =?us-ascii?Q?xy0T192f/9V4mRqIW0Ib3X2Y5TNzA10sVKO2aZY0i0fPYeztdtAnKChVOkTu?=
 =?us-ascii?Q?w2K2vOSu4rmPpJUqsikN21B7CNtbw2LlLqbiBu+lKbd91aExYfc4COynOU1O?=
 =?us-ascii?Q?5j6CcUyJ5DjitrvcJQLrTSFU1YdWMZhLIU5OI00atfohS3sBNUapcJa+GV4s?=
 =?us-ascii?Q?4KnUNYPIf9Xg6LkW6AvzR5/h/PuosKNIOz+3LOa2fbDwW8Hqwvh60od14705?=
 =?us-ascii?Q?95op0GU/4COVxSVRMPCNEI7Cg6klxBEeh3uFkp6Evm0ok9UN91w83dDoIUXc?=
 =?us-ascii?Q?XzDGXHb7UxNfZm3qiy3zQhRXfZ/i9Nf1+kD6DCVo26sRUbZTGWa/45LjeTut?=
 =?us-ascii?Q?+QzVNvrs3qw+0lMm7tGm35KqDQor9NIcUkqIcqE9ZsBIzee8tDAmkAuM3Owx?=
 =?us-ascii?Q?GFqnQ6bIUGNLobqm8DcmKqhAozKV9Wh/nYpAMOhdLHab/0+D+emVNgKvHNq5?=
 =?us-ascii?Q?enW79mV3Gq+Vc2ZqIDOoyJsvY7QcqUoQmEovhDjtBLfl9hZRGfvasWKIDVv6?=
 =?us-ascii?Q?SXrkCL4w41P163+c7O1V2wy5pwSWDrbdtd3V9P00FR4wI+MsdtNumnMqnQA2?=
 =?us-ascii?Q?FYLktqwC8Y+mXYPN+DVQP5mEKVdCAlhI4tiCeh/EWgJTSvoe9GPO18bRt9jE?=
 =?us-ascii?Q?cv9Cwi47kqIeSO4Ozu133t+33yWd0khqAEbDyKWQKnwEJBV2FlmqHTWHBB1m?=
 =?us-ascii?Q?G+VifaaX18aosE2NaAB7ZY0YVNtIMhq8zyigcrk9z8EgHuXqynKU9IBXE5jM?=
 =?us-ascii?Q?WwQm1DnD4+0QO5d5fo51MNCzWSgqyFtzMgAFxpudLjhRL+AG2sKFHw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(19092799006)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zqAOU0c0pRqtL0Ov4hOxMDL0LnPWzk4HfmrWBjxQmdr0s7OYdqgLVZ8bojJ6?=
 =?us-ascii?Q?0IkCrQzKwwbCQ8dvtohjjCEW84sfX+NQDgY2dA3rRNdiCjEWKU685IKmCSQn?=
 =?us-ascii?Q?iNPtH2qz67BUeNHxojLOyG8kjmG6d4MXR6gxbN8WL2YSlp5+1acxUl0MGj8u?=
 =?us-ascii?Q?FGHYCQRUGkgSyw4GEc9oMX3uA/zHqaNZdkEMFAeGs3uD0EK+MDyw+LW0CfJW?=
 =?us-ascii?Q?nYUJx3FNAh2gJV1Hsdgd7bSXRkF3N0R7Z+G331DZzPObcmW8argJ5o+NvGds?=
 =?us-ascii?Q?XGWF0tJ/4X5yXWDBelambgxROtkWWLM5+tMjD4GliYbuflR0mx3MgTJlSZvR?=
 =?us-ascii?Q?bw1/TaYpdgn6xdaABH3shqeoZ3aYukHO1LHsTvr3P/haQ2tRLG1Cw+tFtqSJ?=
 =?us-ascii?Q?lBKeUz8RfGfqmJPItWc/zCwF/imvvKhpyecQFi3DrrIrwyIDqmr96748TVvB?=
 =?us-ascii?Q?QUMb9zc1+0mQm3L+/Be7zJFIqj33RastQ9MWKgxz+0/6sMiUwK2JEa4bFJGj?=
 =?us-ascii?Q?f/9go0zsHKjOMl3PADZBF2hnsVd0WmBrrzuonbceyyL8k6TiLXxnZe2Gl5o0?=
 =?us-ascii?Q?yPJFJA5LERDJ65Om38bEmT2bAW4EzZxg5Xe07rqW12ubaixuSHbaPAplUO4Q?=
 =?us-ascii?Q?uP6dpIO7A2MA4FbOfMAc0sjDcK5rJtbZS8U4hJ9olBz8yEUbSigUwwf2JSya?=
 =?us-ascii?Q?Sg1WUUkSrjFxo7SN5ldO3MEaA3zigyBtnuU8VIwBdp16ZG0kMNDBmmImpaId?=
 =?us-ascii?Q?fsfmP+iYnfw5ZvsMmKhfNylJKScE/BhJabuPnqfFFuZsDEHm6yoWd4+7WjOz?=
 =?us-ascii?Q?DdFWHPhNLtaN9WEtjnc7LkrO8vQW+nCqO+g2VsLs2BSsEh5YzzTGcL/PH3KY?=
 =?us-ascii?Q?DayiEsHtLzUhPXJw5zMQU6aXxwt4H5hXnCPW60xrsGWZ+/n0iJ1ZZEuC5p5b?=
 =?us-ascii?Q?utKO2wQOPAeLnIj+/IRQijuyCVjK4wC0LBBBOhSTGo35HWZY6KohS4SmTT4o?=
 =?us-ascii?Q?dSgODMNE9KSHfOFKjFbBw7pwURbWZUpE5vxhV4VXNF8aGWJ3pbCmSKWQXJ7P?=
 =?us-ascii?Q?qb7VroiVr3wccWUa8GILxy4+qu/N4k+2/JZivHERaOi9Vc1gpDooVVp81NFQ?=
 =?us-ascii?Q?u5DJgd58bdMnWwf+B+NA/pz1BrjyDd9IL3BSfBcBun73ekAYHsMga/0YqZHJ?=
 =?us-ascii?Q?+l4RFv/orY41UV0kvrAf6b3Or9/o+enhIjIHO4n6bKtV2eU8TK5Xj0H2PZ7W?=
 =?us-ascii?Q?MEMZD0CGro9ljsUc8h32namEnUFnedS9XTcz7meicn8bxRMTO7XBFBlaJYaB?=
 =?us-ascii?Q?bqct3vFWPypXqIrKZfFvOFUHFUnbjR+yGTLJxHZaDYzFNWAfliT7GHz+thX+?=
 =?us-ascii?Q?42FQ/CXOOBl9bGHQKvGlT0yLTK2bOrDxHqOgs1Kxq+v73Dx3A9lxxW5I5tIP?=
 =?us-ascii?Q?emv8NwZXaUR1RkyPXtK1z3v7OaZiGx1thXtboefrIh/sRDSSmDQR8Ux/aeIa?=
 =?us-ascii?Q?djpEtQHfQLTBhMeyUXfi8Z3Mu3e0W4icugKua2wsKrkvfQ9Uhy0p6kT6o7Ea?=
 =?us-ascii?Q?Zz6MpZz2thtchZe2HQlhcqPQ+NQ8hTk7GMnBhh0i?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47eee1b5-df8b-4823-d30a-08ddc4aef27d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 21:23:03.1082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r5GGWoBbQ4c5tqvBEgeekDZDJWDPPSuNUouwc5tLjtsuaSkYhWpz07AGpsvWVFTw+XO5Gd+r5p/hKcQJHlTY0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11455

On Wed, Jul 16, 2025 at 03:42:07PM -0500, Bjorn Helgaas wrote:
> On Wed, Jul 16, 2025 at 10:25:57AM -0700, Brian Norris wrote:
> > On Wed, Jul 16, 2025 at 09:35:38PM +0530, Manivannan Sadhasivam wrote:
> > > On Wed, Jul 16, 2025 at 08:20:38AM GMT, Brian Norris wrote:
> > > > On Wed, Jul 16, 2025 at 12:47:10PM +0530, Manivannan Sadhasivam wrote:
> > > > > On Wed, Jul 02, 2025 at 04:44:48PM GMT, Brian Norris wrote:
> > > > > > On Wed, Jul 02, 2025 at 07:09:42PM -0400, Frank Li wrote:
> > > > > > OTOH, I do also believe there are SoCs where DWC PCIe is
> > > > > > available, but there is no external MSI controller, and so
> > > > > > that same problem still may exist. I may even have such SoCs
> > > > > > available...
> > > > >
> > > > > Yes, pretty much all Qcom SoCs without GIC-v3 ITS suffer from
> > > > > this limitation.  And the same should be true for other
> > > > > vendors also.
> > > > >
> > > > > Interestingly, the Qcom SoCs route the AER/PME via 'global'
> > > > > SPI interrupt, which is only handled by the controller driver.
> > > > > This is similar to the 'aer' SPI interrupt in layerscape
> > > > > platforms.
> > > >
> > > > Yeah, I have some SoCs like this as well. But I also believe
> > > > that I have INTx available, and that even when MSI doesn't work
> > > > for AER/PME, INTx might.
> > > >
> > > > Do Qcom SoCs route INTx?
> > >
> > > Yes, they do. But currently, we can only use it by booting with
> > > pcie_pme=nomsi cmdline parameter.
>
> Ugh.  I think these controllers might be out of spec (or maybe we're
> not configuring MSI/MSI-X correctly for them).  Per PCIe r7.0, sec
> 6.1.4.3:
>
>   While enabled for MSI or MSI-X operation, a Function is prohibited
>   from using INTx interrupts (if implemented) to request service (MSI,
>   MSI-X, and INTx are mutually exclusive).
>
> If the controller advertises MSI or MSI-X, I think we will enable it
> and expect AER, PME, hotplug, etc. to use it.

I think it is controller implement problem, which route AER irq to INTx or
other irq line in SOC. Consider many users have similar issues, can you add
workaround or quirk for this type implementation.

Frank
>
> Bjorn

