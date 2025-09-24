Return-Path: <linux-pci+bounces-36900-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCE4B9C374
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 22:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C4D04C376F
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 20:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3CC2749FE;
	Wed, 24 Sep 2025 20:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ktoy/pkF"
X-Original-To: linux-pci@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013059.outbound.protection.outlook.com [52.101.83.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65A98F54;
	Wed, 24 Sep 2025 20:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758747565; cv=fail; b=YscZo+RBHep1iRqm1VVvfW4qaq436pBcC3K2MLv1x3P8WcWkYYAETraCX4QOZNgk9LhgO8+OIlY6nVfSoRn4qR6TZQKc4ozk10bM9+4oc9eWLPinkS918OLhK5ikt9oM+MYmq+2/rjOqsnvxv60GyTjT1hlevKDn5UbTonuChBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758747565; c=relaxed/simple;
	bh=dDkwB3IoLsxgR4rNrYjBINJ2l7qq0EJpmI6IQUo5lNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OE9Sb58sCFpR9Ge+eCbLsEuX/1b7JHBdIMJH3F1kYfl8PrLruokJjdjp0Oc5w2dQuzZtNyhuTbFsKwpqon7e+ljBuLwxzsOLdFZvUW1WqdE2i2j6VPbqbhViuNLJboVRuXIXI8MyzAHonJaHugofM4ibFXvSHe2CUrkwUdwAv2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ktoy/pkF; arc=fail smtp.client-ip=52.101.83.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kjQ66bWB17+HxUdOg27qUK1968XXgxlw/PdOwlik7BzV+/1hdyT92MHP8n4ryYSmGC57ylxTSrcKNJtY0O13ZVC3Q/llntMaKyuPnE6SIk/awfqKFZQdLdtTVym4HO0d9Vhd/LQw/2gV17dk9TdkPUVorQYR+LHJNpavAvslVJ1uIRPq8dF3l09f5ek2N81kzFjIUwb7C0eukGL+EcjPOo5Ljc5lqF+S9FSkZDIz55J06C9CqrxKnhiPu88m2Giib2ei3hFUzaF+AaIPd7E+xdhhT00NfgfXllZdYbmm9VlXAO0vVe73qaNB4HI70xbvQQq6ucJYI8LeWw/zj3AJfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLQwVc1w/sS3cRfltjv8ih4BvpnDmQnaS6OQNsdhaKA=;
 b=nxxcYB3w5y1fsavZ5R4f3LXrWUdXk96tdxuVAnxkxq43zzD4/CzjoaShDtbhJE4TZXWlQFDjtAvlj+6cAD3GCy7fPpeoLg9DNFakKWTT+B6SpW7euMjl37aCzHGN45peREvJ5NZuACCqnEKhbLQBWBTcN0cBPqfAOoBse9KUJ3P0Pv+EOGpZE/9mz8TMY73dR0WmYReypgng0XFs1g7M5INxaKavQ+NF3dq+WcKuBloxBEOj0P2s2blLLAQtN5cUqxLX7IyrvHwifMk/I3pYHeDKXvZARsh4d+B4xvVXzc8jD/ZqC8MFMhfx/0v08yC/qlzJGdHhZ28JhndVdwVqZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLQwVc1w/sS3cRfltjv8ih4BvpnDmQnaS6OQNsdhaKA=;
 b=ktoy/pkF9590GeG8549G6o+6e8+JhIEQEYhZW+xhYz7iSj7SHjwAEsQU425+ZPW3rSgiHmoRt+o1J+XFGP6ZhyCa9rvXZRFDSBXU41qtHGyl5oDQKiAeRQgWQGhWGtZMqO5hghwVZx7ZYcC1hBBfwfCjH+4oLM8/Q0Zups6SusD8Vo96GKskWbMDtbA1expMDE5IGtyQvFAF41flYN+GOrPNB5rqe3dRwPNmix4eR/NQhsntVNspme9e+Kcx4XGOUphjhFwfUuYRxB5BU2sIBfzjji8DiuGRahz/tmlCrBVdWD58Nxx8wK07EfoXL9SdZNzzlFplAsKVYG75d3+0KQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by AS5PR04MB11419.eurprd04.prod.outlook.com (2603:10a6:20b:6c4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Wed, 24 Sep
 2025 20:59:20 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 20:59:20 +0000
Date: Wed, 24 Sep 2025 16:59:11 -0400
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, jingoohan1@gmail.com,
	l.stach@pengutronix.de, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v6 1/4] PCI: dwc: Remove the L1SS check before putting
 the link into L2
Message-ID: <aNRbn+bZ8MP77sdh@lizhi-Precision-Tower-5810>
References: <20250924072324.3046687-2-hongxing.zhu@nxp.com>
 <20250924194457.GA2131297@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924194457.GA2131297@bhelgaas>
X-ClientProxiedBy: BYAPR07CA0090.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::31) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|AS5PR04MB11419:EE_
X-MS-Office365-Filtering-Correlation-Id: d8c231de-b7ba-4bbf-70af-08ddfbad3b9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|376014|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Niygwsv5+julerpe3H+QIiKYPkS7tXifAyC0XlzFsrdqw6pP7GlsGA/ZLxFh?=
 =?us-ascii?Q?l+m3b88uwJ0FqsnwVI+HwBjKkLPLf97YE544KFRog7LMOTSTvfEJtT8rgM/V?=
 =?us-ascii?Q?uALIaXGa0pV2QaU6T2AlCyZxrASm/CugjcMMptXLqPZy/U4eZAn5eo/6pL2D?=
 =?us-ascii?Q?yZ9lbri7JXTy5KtTj7uQ9KSHeM6MAvHlJc9KfLn3ZyhjvyH6f57Y01qc+3hM?=
 =?us-ascii?Q?/Y0pLL3+NE0KmRPufpjlGQUO7v2UTgmj4UW4V6q8lvwM15a39faGoOaU8HKv?=
 =?us-ascii?Q?PZGsTR/2QD9nrZDtLvPrJs3QkgmJ0/9ekPZ320+gORLW+L+WFzs8ZuCiV8ib?=
 =?us-ascii?Q?RQNwyLrf+mfpHAwbR2EBRh5A6lESfk9+6/ZgQwgMF0fZIKTf+qNUhgFscaLC?=
 =?us-ascii?Q?sJpQchNThX9ilfSJAH6q78+uw8wty6Zj6Pnsnm8exwQrXt3kpCCrxeaoUhzC?=
 =?us-ascii?Q?coPgrh/MxyW3eKlCI9ywM/B0rAlYdLAeqIy8yVEiGD4FjadvXVPk0USMSgqy?=
 =?us-ascii?Q?3iJuTl8B4pBmf7z2Qb9m/nwi8oCG4Prcfh42ku+YGX0hHnGoEuMTTXPCLLgj?=
 =?us-ascii?Q?f3bKloFKZngWdDVJC3afteHzg5SAOeHNln0RMREOvUR4RhkPSCprtLbyVTea?=
 =?us-ascii?Q?Jub6OOr5LDPbvTO/3EULKp02YOE9zb9c0f2IkB5Q9VVp4TMXyAA9/rKCr+X2?=
 =?us-ascii?Q?qZYDZ4CzrzWRbf5p9P/xv4sQjIEx/zs5fSv3W/wwbXKkyJ7gQ38p6L3w4pG+?=
 =?us-ascii?Q?krEfhgYFCfhLPds2OyGRNPHwHvZ7JEyAcghdeeAVmMcqZoFRj7j/KvQiDwdf?=
 =?us-ascii?Q?CR+kKZFmPz3s5sZVLpRbvgoOLSvBApYoa0XnS4Ir/MW0q6s01AHwm9dftZEO?=
 =?us-ascii?Q?JHRpyYjwKyYhGDEJ/w7Z6yA84xoZKUZawq1hnjBQRMKMJZRySzg5/aokUIr6?=
 =?us-ascii?Q?MKAv9IsGkNuTVii/eUX9mJZsAGUc0v45kxui2SNcIEe5T52knYO2ih9dZGlN?=
 =?us-ascii?Q?QvHcdYvqUkLDjCNwPJF5mdVOe+WJOSX/ffa0mH2YKgpN54A5y5pHxebnpNk2?=
 =?us-ascii?Q?DCPX2d7ZlN0HZtr20dXEk7UbQNRHGLxBAzsiN9WlI3XsAdm4f0rnH4sPn/ZF?=
 =?us-ascii?Q?VhZBIJYoXbh/WtGxXsH9VXlAsEHbujNTBp3f0Rvtsfl8QGZ/NV7NVp4Cu9Bs?=
 =?us-ascii?Q?3lQyxz08CNbqMxBchwefSxkaSBHFWxYt+8yhXrM3DlrrwyqLMuX87uHUR/KE?=
 =?us-ascii?Q?hluUMzELDaSRQRiaNOaWffUpYZp9e7vxEJi4qpbm6e/0ieGXdbTma106FmeE?=
 =?us-ascii?Q?UD5MTNINm3ZTi8xxEBCsm7lSgNg9zaTR/K8TvQY68e3B7/UMygyUi4Wd//7y?=
 =?us-ascii?Q?mXlW3HN+BS+UuSv7YbLbmDIDmdlHyXxuDYeZNcJy0fJ/DBv6GlcY5oAbNbGX?=
 =?us-ascii?Q?7CNo53jChGfkFBCkiyYI+LzILSAPbOZkW89HadXJQJnIuxSVQA3Iqw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(376014)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+srY92DvnjorscKXKf0v51KGgSRfd28rxaGqDSDlYf9s/UNpYC92rPl+TqE2?=
 =?us-ascii?Q?I0f1gy5UsgxMyqY6BjtA4q5ofC+eKEnr9R514ThBLoFFknm/apIkkawGWVrH?=
 =?us-ascii?Q?clwqKXisAtg3stxyriizMxjzVCDLGrVUrf1RxtQxDJIGhsEJc+HLED6GY4i5?=
 =?us-ascii?Q?vdyz/G5ORBL5Cefdo202owMaACmv6vZX/HltFYYOSyA19FF4v3fB/V7NRcEO?=
 =?us-ascii?Q?hbMJMG3l214F9/dM8j5VzpeR8ZERz/iAhEY/ftYHeRcbcwd9GwewMo+xbPiy?=
 =?us-ascii?Q?prCLALGKsPvbtvhRylwb53zIEqZjTYZJYpmlODUEMc2RDPyWsUA0wxUKYFMu?=
 =?us-ascii?Q?afDIraa+ZL75E4TYbzLmEUl6js2pGDJmhfY/KiczGlQtPDNnpBs7BElHyUxS?=
 =?us-ascii?Q?pMI099OKiQoCuOsDt6FaWF2dZfoGR+4YZSdbhF5fxF/RAljGyFzYQaBRHUok?=
 =?us-ascii?Q?7M/vya4C5CekzjO9CWK+mkKeEz4IN+umLhaNeI9UKq8VGO6rRNvxqWDTqql8?=
 =?us-ascii?Q?QolpxFXrlRDfpUhV23aYUPGnONs1TJ9ZRmb/iiYHe8xdUnv2VRG2uqzwK7lf?=
 =?us-ascii?Q?mJ7qhy823ZJUXGUMkCk5WH/4WqaF5b+KDCGymRGZobaOipzsaL5pGgxrOhN9?=
 =?us-ascii?Q?5MazVAmLKz6FiCFoXxzE37fkAZe79rWEjfoZ+iPCoMSQpinQrfl/+PbQ4cU8?=
 =?us-ascii?Q?gJDKgf1WaTh4zuhJ5An8gO/sWhZMLRPD9NPtN1zKY8HDnihW2av0eBGbDZBE?=
 =?us-ascii?Q?HljT39B6qnqTzgydT0b/97AMi/sXYwuY+Sa9Qxv9Cw/dUJnbYgLnpC6rv/en?=
 =?us-ascii?Q?gDdBCJ6ZZn9v/8pDVCHFzYwmsA58OCLf7zVZi9KXl+m4+ujCHx7kbiEZ2cLo?=
 =?us-ascii?Q?slkO4d+5AnMCcAc+ttWOw+dAbbfFDPKkpNZzHt3PU1S2nnO+/hqYjMJ2ewya?=
 =?us-ascii?Q?H42Tr0NDQspmIR31vd7r1dtjYB/0IdCo6jTeIq0Bo+pH7YMuzqNXQwDyQp67?=
 =?us-ascii?Q?2ZPBdSN4ToC+bDaF9gUW9A0mGlsHdAfbJ25nPLKcPDj+1uu8hscVn7Mxdls7?=
 =?us-ascii?Q?B6ogKUDTFKPJb6doPZo3Z3dVJUXk4NWZTxZ26aMbvI7psLq3tWRVAf2th6Wg?=
 =?us-ascii?Q?6XSy3P59SDK1JnQBKDAbsX0YkY+AgrCNtF/aN++S2zwq9iN1Xc82GrAuEBJS?=
 =?us-ascii?Q?Sj/uGGTUULU6YvjmXvfW5R4bCkjnqABQnT+y4goFMIaWJQ/wsvJtKmTNp9NI?=
 =?us-ascii?Q?fbe/4PBZlmZR2uvfHB3rdliQox9GsUAll/fntLaVMPdBAnPoK/8qn84K4rDn?=
 =?us-ascii?Q?lQbZXOLO/5n30J4Tu9c59cYV7tqfw/PDaQfA/u6QVZmZ4clJBAYF0uyDXRAu?=
 =?us-ascii?Q?DOnWNa7IWyB0AU9gxMvnAA64uBaMwf0ZBMXdMs0FUBzgnH3fA4gHoId/MHXL?=
 =?us-ascii?Q?oY05cb/5Zvspq8ElPab3N0BOg8qAIsy8IBSVmF2ZmwrVG+HTbT2wrPPSj+ND?=
 =?us-ascii?Q?/BohH+pDR1XL/INmAGUPs0FZXO8hHvc+WjLww8CZtDqAr4W29dZkM0Tu6h1q?=
 =?us-ascii?Q?xB6SDWiU/45ezRpzNAjwDtlGYv+qZTNLD9ocd6t+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c231de-b7ba-4bbf-70af-08ddfbad3b9f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 20:59:20.7559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CA752QsTFDUdifi43BQALQg4Ti1jr1AY0wbAkMCXCc3X84vi9bRHRn/DNItXZBi7BlKyLL910lWNjna1oZxkxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB11419

On Wed, Sep 24, 2025 at 02:44:57PM -0500, Bjorn Helgaas wrote:
> On Wed, Sep 24, 2025 at 03:23:21PM +0800, Richard Zhu wrote:
> > The ASPM configuration shouldn't leak out here. Remove the L1SS check
> > during L2 entry.
>
> I'm all in favor of removing this code if possible, but we need to
> explain why this is safe.  The L1SS check was added for some reason,
> and we need to explain why that reason doesn't apply.

That's original discussion
https://lore.kernel.org/linux-pci/20230720160738.GC48270@thinkpad/

"To be precise, NVMe driver will shutdown the device if there is no ASPM support
and keep it in low power mode otherwise (there are other cases as well but we do
not need to worry).

But here you are not checking for ASPM state in the suspend path, and just
forcing the link to be in L2/L3 (thereby D3Cold) even though NVMe driver may
expect it to be in low power state like ASPM/APST.

So you should only put the link to L2/L3 if there is no ASPM support. Otherwise,
you'll ending up with bug reports when users connect NVMe to it.

- Mani"

Frank


>
> > Cc: stable@vger.kernel.org
> > Fixes: 4774faf854f5 ("PCI: dwc: Implement generic suspend/resume functionality")
> > Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware-host.c | 8 --------
> >  1 file changed, 8 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index 952f8594b501..9d46d1f0334b 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -1005,17 +1005,9 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
> >
> >  int dw_pcie_suspend_noirq(struct dw_pcie *pci)
> >  {
> > -	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> >  	u32 val;
> >  	int ret;
> >
> > -	/*
> > -	 * If L1SS is supported, then do not put the link into L2 as some
> > -	 * devices such as NVMe expect low resume latency.
> > -	 */
> > -	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
> > -		return 0;
> > -
> >  	if (pci->pp.ops->pme_turn_off) {
> >  		pci->pp.ops->pme_turn_off(&pci->pp);
> >  	} else {
> > --
> > 2.37.1
> >

