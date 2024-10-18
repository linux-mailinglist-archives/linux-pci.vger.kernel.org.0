Return-Path: <linux-pci+bounces-14873-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F909A420F
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 17:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F4A61F24D69
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 15:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E207876C61;
	Fri, 18 Oct 2024 15:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="d3u5reb4"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2082.outbound.protection.outlook.com [40.107.21.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66DE18C03B;
	Fri, 18 Oct 2024 15:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729264430; cv=fail; b=i14srrhgA4Bwnph7i+f1R4nJsIIqXvOVUEFv0HZgD8YtmeqJssC6VjQY4z4rgn8F+eQN0TxBnSBPqIqJN2KiDYvjD/E9bCDmSVwJRBKuNWp78ztNHInW8reCazR238JyH7hYqoZmTnq/PAUVbhE8ATB9dZNLkPc+DhX2Kf/QP+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729264430; c=relaxed/simple;
	bh=hrOzfnW/nlOafQx6J57+3u3EyWUr9hKTeyEZc8L1tfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pBblgOBVG6cpqK3q19VERoZ5Kl4rsmA91KmddJSd8KP9LtnzP3ih3hdItuJnO1upGOyoQw8ViLFJs4bYf2oXyPpanWSR8J4b5lH1NGAz7vAqY60/FIqa6MYGB5lRBu5woileUeEgX5RHcd1Q5BOQ/NDV+y3pyeLnQyRH+u9inp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=d3u5reb4; arc=fail smtp.client-ip=40.107.21.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=py0fIju4y8AUK6wfs/U0zCUL720FZnI7K0OwIgazMPrGFql5X9DKMLwAn/KAUp/yzA8BieW/N8qt1IqSOm3GppqZkSbFrJfJau7DJwEKT88N2JgCCG0/nS+8zdtkju0G/GnebCIjPkyo013QSupB2+uQeURYpVzHBYzCXGl2IG202qTUkGW3dGK3u/IcvoQKtTlebf46q+SeLAL8L4XKAh9lh5VXCDeMu5vqGrov38Z/5jWVHS1jsnv0S8septvH0n1viYb/A+0/3DN+7VT0ikELN+sgM/xI4UVMRMGA0aA1DUGGsI5nB5ws98kvZrfnx8G3Dqygej7PBFB8Nksp8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=saQZiQZRzvtk2nZb7D3AyUBqhiJcBbLVw6dQ8e70KRA=;
 b=u/4nBpNdGRcI9mzpXUpMWrSxV4gwHA6xJ7GWUZQd012KRxSAfxnkYiCRCLhTnd8/33FFRq8jldytocbF2bPuznjyD50okocw4S8CIpZKn4E6X+IPDrrgvywgnNM13VnHmyx9IWxMJrLviqFIrN9XZa0RW/PejC8hFRw1Gt+j1VyvLl2N9V83gXiLSSBq8dSYf7iBskq++Z7sGPnHMhlFz36yUT1rWOk7q9WVbwbi0C4Y1x0VH1YLc1UeRuR/ABjO8b7OfJYaEN/u+evFEOpJyRe8k7BPtvAsHLA7bhfhl5yXwr/0Vph8bQJG9a2lhHXYi7hpkvRDC1QTLVZP49pAFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=saQZiQZRzvtk2nZb7D3AyUBqhiJcBbLVw6dQ8e70KRA=;
 b=d3u5reb4phagtgS6i/KKbUoGFG/Y1lzXiG9xywEkJlx8UwXzls/1rON0zMtdurl7wK4kQFFdgZv+6qG0XsuxovsFWId6t61tTWVSzqMA+RxEfps02V7JTziCJD4TTurfpVhzufvpPBjtHH+lqrtXVE5gSE3WLm3JWJji1qUd05jPs+ilscVsFOUmWQXcbYtRDtuI6V3aMUvFHOq0HbceGCZh9P/MFdRVcP4P8Mb9d/MD2zMOBmSnDqSWWHMDx5t4BAeNMoUz0mw3wJnl8/72eL3+jc87Wkvzg61UQEQc1aIGM4uj+9AhzMwbc3BbmyBXcSNwac4aN1nJQkGFeYtZ2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB7082.eurprd04.prod.outlook.com (2603:10a6:10:129::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Fri, 18 Oct
 2024 15:13:42 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 15:13:42 +0000
Date: Fri, 18 Oct 2024 11:13:34 -0400
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
Subject: Re: [PATCH v3 4/6] PCI: endpoint: pci-epf-test: Add doorbell test
 support
Message-ID: <ZxJ7HoSuYNr8mwSi@lizhi-Precision-Tower-5810>
References: <20241015-ep-msi-v3-0-cedc89a16c1a@nxp.com>
 <20241015-ep-msi-v3-4-cedc89a16c1a@nxp.com>
 <ZxJqITunljv0PGxn@ryzen.lan>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxJqITunljv0PGxn@ryzen.lan>
X-ClientProxiedBy: SJ0PR03CA0142.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB8PR04MB7082:EE_
X-MS-Office365-Filtering-Correlation-Id: d57a26ad-c7aa-401d-4183-08dcef877414
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2dCa1+31LcrHX6N14s2N1KBhgUAoITmpwuE7/rQbk6un9ZVN7ZFuVMmFKwYL?=
 =?us-ascii?Q?lw/FVb3JoybR6JiTh6vlx7A7mwwyWFWp9O7Rh/I5hUToYuFbIKnLs3ir86LP?=
 =?us-ascii?Q?1TJJ05V0yVkqtd18htVoSsk3fTU5lB5y9zgvoXty5bH1PHWz1rjfE7yf+e7s?=
 =?us-ascii?Q?AH5R4U9H7B4or/y5013AFR1YqxjFryMt2gbULMFZFBMsnJ3vV+MbHGPp3ME6?=
 =?us-ascii?Q?tWVwYSmkxjx4W6jFrPir2M3p4ToqsssyYIPv+UCp6yCQc7ugfHyV3QZL5jiw?=
 =?us-ascii?Q?xghCeMCBBvisx9BS6tkIGL3pL86zDCwy7STXdY7Sa/IXdP4spMY5FqjT3BFX?=
 =?us-ascii?Q?CVPAaJD/zlck71X/8Ge6RL3zvTIaEGGe1lmcg6pqS8jfw3qhOyEa1p4rSmbi?=
 =?us-ascii?Q?MnoJXwHh1fiCDOuXw6OkG6DGt/JDNGldAim4+Mmi74iidQIs4OR4avX7YS/E?=
 =?us-ascii?Q?lTbR7C/2srrbmuEozBcQlHq0XL25wqT6MMs9V4TdlzSZ4M8tJp3NglgKqlti?=
 =?us-ascii?Q?1ZJQIbtaJx4EsQEhlmzG4iFfyqFpNOVE/gomIPWMREj9nVoaTcLGSqVnL2TY?=
 =?us-ascii?Q?TZM1APSpg+hB7XXbZV/uE5kwQ4UV/yvOFw6hLhulxECHgmBTSMKodxOE/QYx?=
 =?us-ascii?Q?dyBncK+5fxZc2X59XtGuTge6aHG68p0Y3bQepopfababltPVNMCnpBQjXt2q?=
 =?us-ascii?Q?LcoGj84lygZLoX/U/vX1qlT2P2BD+bfmgF0sXkefgF8cRZsjQADweVPlB9KP?=
 =?us-ascii?Q?tRPUJGzjYCmnCxsx2wuV0izqo/7mcOwSi2FFwlKhfqAA1NDIPg87WHnH5VUi?=
 =?us-ascii?Q?agOc8697qPVdRe9QE7q9G1CpteZASYkOwCGBn4PqBb7RSsSYlnVgPMPCSP1r?=
 =?us-ascii?Q?3/P7Lbzvn+NPirA7NsXEyqMTk9VVvBnoX/gbCzWnnT/tVA7s9q9sd313NpPt?=
 =?us-ascii?Q?nJGnyOwLUW6YGmUVrb48D2KgAoJgtvO6UwTGOa6mOR84R46BrjqdIyHV6PEV?=
 =?us-ascii?Q?AwCK3MaiYd/uuSjL8r7tBGUGH9g0XbPHrnctdPcuFWuTEh0oMhBR9SPBMA0K?=
 =?us-ascii?Q?YjS7TSM22l3QPqaIXnb4BrDf7LQ81jrWxfQuQ0tNtVfcHsBoL2AzDNuI1yZA?=
 =?us-ascii?Q?d12cUYhy4V1i/EeNj6v3wj6P6+2p2aQc8hrkzgx6pzt4upWwxCvHcl+4Z7bM?=
 =?us-ascii?Q?fJhrYEWVhrLwdK4LrISAweob0QkZavSIe46gXFIypogvDGMOtJkWVFAFB8OD?=
 =?us-ascii?Q?GW9nmDOu4Eu7AQVTXYm3reWngLFQm2OscazrhbeGmJAtlOqnvmAEZ+YraM/q?=
 =?us-ascii?Q?TlPstvdIm/vwzE+/HZcStEX3SDO9hduXkv4MECzMRLJCyuEIYh2O6uuyfAT7?=
 =?us-ascii?Q?wLbCVRM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BkDYZiPc03LJjmSE9kxll7FbvvpdrBYtR4zVfYZxILXHbw71MeYo6bmvb7rD?=
 =?us-ascii?Q?pWRGXp4PMbdHfaQzmbzDbEKxtCvmNC8g6HT8DISTpFh6yMYytKpQd4iNmyAF?=
 =?us-ascii?Q?Iuo9tWAjL7rorUoSIlRRCSp/PJVF6A/Moi3QGcb7/GmP+Cvos1/XJl87sp37?=
 =?us-ascii?Q?3Bv/42TvUZ1nHFkKaImY2WkgmmurTgiqAEEAUicXR+I437HEY2fPWvkjp4id?=
 =?us-ascii?Q?XbLT9anFKag0YXhX0VnM1mwZeyxYfR4AQhNlFxuFhOmV2D+jWBWBUyeZGeho?=
 =?us-ascii?Q?8u1aEdK3lEsr/ZWrB/e3vt0LW7+1AvrgjQODBP9uTFZ5RifaoOppoW6zkhMx?=
 =?us-ascii?Q?oWFjAJc6SAF7d1WbZLOttN2P39M/ibow2N76LSLoUdyrXaY+E6IBwjqs9hnv?=
 =?us-ascii?Q?FyU9f8IiM/6k+8NNh1wkmIBXSCjtC4HFeBThSzjvkn+kHUNWgQExBEmXXMWU?=
 =?us-ascii?Q?+xPNF4XkROR3ZapsWZrpUjKYdA0//C6+dc8f+2GjbLSpPQZgbQPq/CBVfZS9?=
 =?us-ascii?Q?CyJSXO9jNbkERmUXlqnkNp3AREADMiR6WCEu7JimMYDc0JXT1zrp313QAFMW?=
 =?us-ascii?Q?jgHdP7yAKaOjq6UznVjc/JZWWBCl7F1syGdUVmu4IG4gfzNU7oLWC0iQoH8P?=
 =?us-ascii?Q?E36msEKiASvIGCnppKCE9E8mStw3Vse1DT03s+EMbp+k5MBezsFxCRYFavz6?=
 =?us-ascii?Q?s70HUAVI6TYWcm9JeCBnQ6QYOPE9EHhypzoCm24R3/h+2EXl7w8XZK1B23Ng?=
 =?us-ascii?Q?c5xA5ZHeqpd8PlBbob70qTgE2f6jcJQIiGuabr0oQVJDtcXWQgZ+GIwiZTcg?=
 =?us-ascii?Q?IlheDW4fmkLop8f7ruzjgBJ0BKaqBjr7x46YETIWnS2GIHOYmCtUWBmMSljl?=
 =?us-ascii?Q?8wF9cM/Gq9sodEHeg7PzqxQxqPuudzgbZZUZ3aAtCKahuQZwgiEic5sMj8W8?=
 =?us-ascii?Q?Qjkf2b3au7ehzj1iRJa+y26z8s+Z6MXcgnM/tBrwTJg6CszeE59Soa6VOtpJ?=
 =?us-ascii?Q?doGZRNIlxV1XTxaZUtsJx1x9rH7Xz1xSWFEeT0BLX+qRpZehTXU5qitujPVi?=
 =?us-ascii?Q?vt99kzkYEiE6j/nDeKv/Fwx5MsUxq2CNlTQKrHKCDYcf5LoX5OCD8EJF7vPa?=
 =?us-ascii?Q?rZDlqhS7OoTC9JG3GJkp6Wq7kUQVlvsXkG9TsdxWxVvAuM0nMBnIC6L9JmCS?=
 =?us-ascii?Q?sjmLC78hKGtiIbWYLzItwBJrTIvCh435qIiWPLm+R9+eRS0uy1xFV+bXC5IJ?=
 =?us-ascii?Q?4Ghins/Adh/WSGfK6bFBLcsJMgL0XaBcQQ2GkswMXKrySmyBnwGTXd/veDm5?=
 =?us-ascii?Q?zRIkU6BGDHTCdiDCw5jChvJjt4Mb7G5B1MZ77Tc42CQt/PcQcPPHnQj22XrA?=
 =?us-ascii?Q?zzvcX5fjjwu/osgxSKAdNLKcPTc7OXuugosqNOZ/bJFXwGhPahp10fUz85GO?=
 =?us-ascii?Q?t8xvxpm9ggxlSwGuBQBN55FKZoaLHcg/hFxGYeBDqfCuKY4NlbRngZn7DOcb?=
 =?us-ascii?Q?jzoxRtQQ0pCtaG3IV5tNIhv+N+2Jr4UMyJ/Zs6geNLG4KpobgdRLSRH0SsYU?=
 =?us-ascii?Q?8vPt4i8QN7Ri3qAJ25U250HKviKdGC1bIYMA0WBZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d57a26ad-c7aa-401d-4183-08dcef877414
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 15:13:42.7898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NX0gGPmArSKH2ABGRm8OEIe/79puJKbUy3bz+dtXHaqIjvgpZUkVTckbChrYAv8uFxwA2NqhYnOEdKIX4bbyVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7082

On Fri, Oct 18, 2024 at 04:01:05PM +0200, Niklas Cassel wrote:
> Hello Frank,
>
> On Tue, Oct 15, 2024 at 06:07:17PM -0400, Frank Li wrote:
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
> > To avoid broken compatibility, use new PID/VID and set RevID bigger than 0.
> > So only new pcitest program can distinguish with/without doorbell support
> > and avoid wrongly write test data to doorbell bar.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-test.c | 58 ++++++++++++++++++++++++++-
> >  1 file changed, 56 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > index 7c2ed6eae53ad..c054d621353a6 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > @@ -11,12 +11,14 @@
> >  #include <linux/dmaengine.h>
> >  #include <linux/io.h>
> >  #include <linux/module.h>
> > +#include <linux/msi.h>
> >  #include <linux/slab.h>
> >  #include <linux/pci_ids.h>
> >  #include <linux/random.h>
> >
> >  #include <linux/pci-epc.h>
> >  #include <linux/pci-epf.h>
> > +#include <linux/pci-ep-msi.h>
> >  #include <linux/pci_regs.h>
> >
> >  #define IRQ_TYPE_INTX			0
> > @@ -39,6 +41,7 @@
> >  #define STATUS_IRQ_RAISED		BIT(6)
> >  #define STATUS_SRC_ADDR_INVALID		BIT(7)
> >  #define STATUS_DST_ADDR_INVALID		BIT(8)
> > +#define STATUS_DOORBELL_SUCCESS		BIT(9)
> >
> >  #define FLAG_USE_DMA			BIT(0)
> >
> > @@ -50,6 +53,7 @@ struct pci_epf_test {
> >  	void			*reg[PCI_STD_NUM_BARS];
> >  	struct pci_epf		*epf;
> >  	enum pci_barno		test_reg_bar;
> > +	enum pci_barno		doorbell_bar;
> >  	size_t			msix_table_offset;
> >  	struct delayed_work	cmd_handler;
> >  	struct dma_chan		*dma_chan_tx;
> > @@ -74,6 +78,9 @@ struct pci_epf_test_reg {
> >  	u32	irq_type;
> >  	u32	irq_number;
> >  	u32	flags;
> > +	u32	doorbell_bar;
> > +	u32	doorbell_addr;
> > +	u32	doorbell_data;
> >  } __packed;
> >
> >  static struct pci_epf_header test_header = {
> > @@ -695,7 +702,7 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
> >  	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
> >
> >  	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
> > -		if (!epf_test->reg[bar])
> > +		if (!epf_test->reg[bar] && bar != epf_test->doorbell_bar)
> >  			continue;
> >
> >  		ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no,
> > @@ -810,11 +817,24 @@ static int pci_epf_test_link_down(struct pci_epf *epf)
> >  	return 0;
> >  }
> >
> > +static int pci_epf_test_doorbell(struct pci_epf *epf, int index)
> > +{
> > +	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> > +	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
> > +	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
> > +
> > +	reg->status |= STATUS_DOORBELL_SUCCESS;
> > +	pci_epf_test_raise_irq(epf_test, reg);
> > +
> > +	return 0;
> > +}
> > +
> >  static const struct pci_epc_event_ops pci_epf_test_event_ops = {
> >  	.epc_init = pci_epf_test_epc_init,
> >  	.epc_deinit = pci_epf_test_epc_deinit,
> >  	.link_up = pci_epf_test_link_up,
> >  	.link_down = pci_epf_test_link_down,
> > +	.doorbell = pci_epf_test_doorbell,
> >  };
> >
> >  static int pci_epf_test_alloc_space(struct pci_epf *epf)
> > @@ -853,7 +873,7 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
> >  		if (bar == NO_BAR)
> >  			break;
> >
> > -		if (bar == test_reg_bar)
> > +		if (bar == test_reg_bar || bar == epf_test->doorbell_bar)
> >  			continue;
> >
> >  		base = pci_epf_alloc_space(epf, bar_size[bar], bar,
> > @@ -887,7 +907,11 @@ static int pci_epf_test_bind(struct pci_epf *epf)
> >  	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> >  	const struct pci_epc_features *epc_features;
> >  	enum pci_barno test_reg_bar = BAR_0;
> > +	enum pci_barno doorbell_bar = NO_BAR;
> >  	struct pci_epc *epc = epf->epc;
> > +	struct msi_msg *msg;
> > +	u64 doorbell_addr;
> > +	u32 align;
> >
> >  	if (WARN_ON_ONCE(!epc))
> >  		return -EINVAL;
> > @@ -905,10 +929,40 @@ static int pci_epf_test_bind(struct pci_epf *epf)
> >  	epf_test->test_reg_bar = test_reg_bar;
> >  	epf_test->epc_features = epc_features;
> >
> > +	align = epc_features->align;
> > +	align = align ? align : 128;
> > +
> > +	/* Only revid >=1 support RC-to-EP Door bell */
> > +	ret = epf->header->revid > 0 ?  pci_epf_alloc_doorbell(epf, 1) : -EINVAL;
>
> I really, really don't like this idea.
>
> This means that you would need to write a revid > 1 in configfs to test this.
> I also don't think that it is right that pci-epf-test takes ownership of "rev".
>
> How about something like this instead:
>
> My thinking is that you add a doorbell_capable struct member to epc_features,
> and then populate CAPS_DOORBELL_SUPPORT based on epc_features in
> pci_epf_test_init_caps() (similar to how my proposal sets CAPS_MSI_SUPPORT).

The primary issue is that the doorbell is not a capability of the EPC
itself; rather, it's a capability of the entire system that requires an
external MSI/ITS controller. The CAPS_DOORBELL_SUPPORT should handle this
feature. Even we needn't CAPS_DOORBELL_SUPPORT, just call
pci_epf_alloc_doorbell(), if error return, means not support DOORBELL.

One potential problem is that if the EPC supports CAPS_DOORBELL_SUPPORT,
but the user continues to use older PID/VID values to enable EPF testing,
the pcitest tool may treat the doorbell BAR as a normal BAR. This could
lead to confusion for users as to why their system breaks after a kernel
update.

To use the doorbell functionality, the revid can clearly inform users that
this feature breaks previous compatibility. Users will need to update the
host-side driver, PID/VID values, and the pcitest tools accordingly.

Frank

>
>
> From 0f6bb535c6d56e03e9b3550194deec04a1c1d370 Mon Sep 17 00:00:00 2001
> From: Niklas Cassel <cassel@kernel.org>
> Date: Fri, 18 Oct 2024 10:32:39 +0200
> Subject: [PATCH] PCI: endpoint: pci-epf-test: Add support for exposing EPC
>  capabilities
>
> Currently, there is no way for the pci-endpoint-test driver (RC side),
> to know which features the EPC supports.
>
> Expose some of the EPC:s capabilities in the test_reg_bar, such that
> the pci-endpoint-test driver can know if a feature (e.g. MSI-X or DMA)
> is supported before attempting to test it.
>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/misc/pci_endpoint_test.c              | 34 +++++++++++++++
>  drivers/pci/endpoint/functions/pci-epf-test.c | 43 +++++++++++++++++++
>  2 files changed, 77 insertions(+)
>
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 3aaaf47fa4ee..7eb045dc81b6 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -69,6 +69,20 @@
>  #define PCI_ENDPOINT_TEST_FLAGS			0x2c
>  #define FLAG_USE_DMA				BIT(0)
>
> +#define CAPS_MAGIC				0x25ccf687
> +#define PCI_ENDPOINT_TEST_CAPS_MAGIC		0x30
> +#define PCI_ENDPOINT_TEST_CAPS_VERSION		0x34
> +#define PCI_ENDPOINT_TEST_CAPS			0x38
> +
> +#define CAPS_MSI_SUPPORT		BIT(0)
> +#define CAPS_MSIX_SUPPORT		BIT(1)
> +#define CAPS_DMA_SUPPORT		BIT(2)
> +#define CAPS_DMA_IS_PRIVATE		BIT(3) /* only valid if DMA_SUPPORT */
> +#define CAPS_DOORBELL_SUPPORT		BIT(4)
> +#define CAPS_DOORBELL_BAR_MASK		GENMASK(7, 5) /* only valid if DOORBELL_SUPPORT */
> +#define CAPS_DOORBELL_BAR_SHIFT		5
> +#define CAPS_DOORBELL_BAR(x)		(((x) & CAPS_DOORBELL_BAR_MASK) >> CAPS_DOORBELL_BAR_SHIFT)
> +
>  #define PCI_DEVICE_ID_TI_AM654			0xb00c
>  #define PCI_DEVICE_ID_TI_J7200			0xb00f
>  #define PCI_DEVICE_ID_TI_AM64			0xb010
> @@ -805,6 +819,24 @@ static const struct file_operations pci_endpoint_test_fops = {
>  	.unlocked_ioctl = pci_endpoint_test_ioctl,
>  };
>
> +static void pci_endpoint_get_caps(struct pci_endpoint_test *test)
> +{
> +	u32 caps_magic, caps;
> +
> +	/* check if endpoint has CAPS support */
> +	caps_magic = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CAPS_MAGIC);
> +	if (caps_magic != CAPS_MAGIC)
> +		return;
> +
> +	caps = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CAPS);
> +	pr_info("CAPS: MSI support: %u\n", (caps & CAPS_MSI_SUPPORT) ? 1 : 0);
> +	pr_info("CAPS: MSI-X support: %u\n", (caps & CAPS_MSIX_SUPPORT) ? 1 : 0);
> +	pr_info("CAPS: DMA support: %u\n", (caps & CAPS_DMA_SUPPORT) ? 1 : 0);
> +	pr_info("CAPS: DMA is private: %u\n", (caps & CAPS_DMA_IS_PRIVATE) ? 1 : 0);
> +	pr_info("CAPS: DOORBELL support: %u\n", (caps & CAPS_DOORBELL_SUPPORT) ? 1 : 0);
> +	pr_info("CAPS: DOORBELL BAR: %lu\n", CAPS_DOORBELL_BAR(caps));
> +}
> +
>  static int pci_endpoint_test_probe(struct pci_dev *pdev,
>  				   const struct pci_device_id *ent)
>  {
> @@ -906,6 +938,8 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>  		goto err_kfree_test_name;
>  	}
>
> +	pci_endpoint_get_caps(test);
> +
>  	misc_device = &test->miscdev;
>  	misc_device->minor = MISC_DYNAMIC_MINOR;
>  	misc_device->name = kstrdup(name, GFP_KERNEL);
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index a73bc0771d35..2dd90e2e8565 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -44,6 +44,18 @@
>
>  #define TIMER_RESOLUTION		1
>
> +#define CAPS_MAGIC			0x25ccf687
> +#define CAPS_VERSION			0x1
> +
> +#define CAPS_MSI_SUPPORT		BIT(0)
> +#define CAPS_MSIX_SUPPORT		BIT(1)
> +#define CAPS_DMA_SUPPORT		BIT(2)
> +#define CAPS_DMA_IS_PRIVATE		BIT(3) /* only valid if DMA_SUPPORT */
> +#define CAPS_DOORBELL_SUPPORT		BIT(4)
> +#define CAPS_DOORBELL_BAR_MASK		GENMASK(7, 5) /* only valid if DOORBELL_SUPPORT */
> +#define CAPS_DOORBELL_BAR_SHIFT		5
> +#define CAPS_DOORBELL_BAR(x)		(((x) & CAPS_DOORBELL_BAR_MASK) >> CAPS_DOORBELL_BAR_SHIFT)
> +
>  static struct workqueue_struct *kpcitest_workqueue;
>
>  struct pci_epf_test {
> @@ -74,6 +86,9 @@ struct pci_epf_test_reg {
>  	u32	irq_type;
>  	u32	irq_number;
>  	u32	flags;
> +	u32	caps_magic;
> +	u32	caps_version;
> +	u32	caps;
>  } __packed;
>
>  static struct pci_epf_header test_header = {
> @@ -741,6 +756,32 @@ static void pci_epf_test_clear_bar(struct pci_epf *epf)
>  	}
>  }
>
> +static void pci_epf_test_init_caps(struct pci_epf *epf)
> +{
> +	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> +	const struct pci_epc_features *epc_features = epf_test->epc_features;
> +	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
> +	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
> +	u32 caps = 0;
> +
> +	reg->caps_magic = cpu_to_le32(CAPS_MAGIC);
> +	reg->caps_version = cpu_to_le32(CAPS_VERSION);
> +
> +	if (epc_features->msi_capable)
> +		caps |= CAPS_MSI_SUPPORT;
> +
> +	if (epc_features->msix_capable)
> +		caps |= CAPS_MSIX_SUPPORT;
> +
> +	if (epf_test->dma_supported)
> +		caps |= CAPS_DMA_SUPPORT;
> +
> +	if (epf_test->dma_private)
> +		caps |= CAPS_DMA_IS_PRIVATE;
> +
> +	reg->caps = cpu_to_le64(caps);
> +}
> +
>  static int pci_epf_test_epc_init(struct pci_epf *epf)
>  {
>  	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> @@ -765,6 +806,8 @@ static int pci_epf_test_epc_init(struct pci_epf *epf)
>  		}
>  	}
>
> +	pci_epf_test_init_caps(epf);
> +
>  	ret = pci_epf_test_set_bar(epf);
>  	if (ret)
>  		return ret;
> --
> 2.47.0
>

