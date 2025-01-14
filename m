Return-Path: <linux-pci+bounces-19755-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC7FA11139
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 20:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A4A5164EE0
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 19:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E437C1ADC6D;
	Tue, 14 Jan 2025 19:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZI/SDpam"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2078.outbound.protection.outlook.com [40.107.247.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2090A1FBCAA;
	Tue, 14 Jan 2025 19:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736883172; cv=fail; b=KmAQ515icBk/Fr4gHNd+QvpGhCdsPf0HF0ou4povPfS8Qhz+K+G/6ep9ujZPygeciv4o/OHQSgzWue9QtB1I+mA69u+oZYA+vd1EkTg7afeqnr5qVMhBpxJdtpLpcTZ4sIZvirZ4XHKTsnDwRLq3jNu5xy+KskxU8GfS9CfGssU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736883172; c=relaxed/simple;
	bh=2+zNaAqEYbE14o/04eoiXpiyhZb9Xl4x+Sl3/Up61P8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G8PmlufmnXhKmMHDVQy5/OMjVbNPfzRV95sQOIrRrgaCQdT9WyTWq4SP1EWbdFC5gDoLPWlhi7YEyWtvBfOjoUlVZZgprIISWtQ/BR/+eoLP4HTzE+pYNBWWEQGJ4PRh1u30MqhLJCh0+JzuWhVuczVMvYTJ6RO2IbDfVFI8i+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZI/SDpam; arc=fail smtp.client-ip=40.107.247.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cn6xEn9gmzHBlKG9fEQzu5Zql+vx1tafXM6A4eaU/aZmMCHivR4egFYH2cS4R30TUgBzgijZK7Uhvuv9kJsiK88xt/LIG4M8izccCOHJMrzC9KklvbLd8r7rOWPd7Dz2FPNcAwSZnlEve9tPGLO3pZMOTvtxcBZ+Cl7Bo+aCP41Y40tCA+5knVVcXMYN2qN9Cjd8sEBlf0+kAAhBEjG55G9NFmVJQ7V3EosaSSHxa4WsEYuIIblapDAo3rXt+parNgt6hsEfESG9UkvsLS7Zh3rllMNqlZzwInGa6JnyrHqNv0mDRcNL53ySXN2SP2+RnaaniirPbRYl7CxcC9utBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Fg2lblujLeKo2UdZcOLp1Uo/4xngn2Yi+Y+85ES5y0=;
 b=FjbCVbdNKRLEEJBFKEMSEopEuRxRIEWZ8MTcxb9XVQCJRqMdFe/RjRWBAtk78vFRlPrP8X5Q/IiuRVoh6xkpK+oXtcOeh3LQUCAQjbfPkcNM/ptrmZLMRuQxWVsClJrboxz4seY/LD4YQg7ua9KeMg+ITJLl1GreFnxLrfQCGLpJJ1zGlseBUfenYgVOEkfsg/HtuJ23gjaWDGB6ydgth9q93QQR1arE70Gk/hUoCePJ++/oBg6xPYlfzsnu1VYvmo798UfuK+A/2UcsKOGGZFp1C5cB9bILphe14IQOuOOXNtYl0nSFvDQu4ayGSv6dOpidnFrAj60Jc3dl9UkW/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Fg2lblujLeKo2UdZcOLp1Uo/4xngn2Yi+Y+85ES5y0=;
 b=ZI/SDpam9FI3qZwld7em+EJYF02v8c0nviH9+agoZDRh/MThIXSXTb6bWbNrNu6OOe2pv+Hppfeast8wupUmAd3yd2yExyyTR/mz3j5D1NqqoRVFNXKgrwqaA2w8uyc3lv5Qio5IxMLXbXbX69JvB45nepnRtt0F8B4qWtS/rY0a6ea7wOHF3k0AOmLmlAFhOcw/xDVzKYhRi4ArN5fmWTdKcqzNwQoUvW22l9tP3PBwWW+fHfpdLkW3HsQyv8/Ayt0C2J7eZiiZXtvRc2DCWDJnIYC7a6QwDdy4it26GiqK1fKGq7rJiZ1i8mP6zi2CW2geJ1CRDnWbMXDWpffIuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10847.eurprd04.prod.outlook.com (2603:10a6:150:20a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Tue, 14 Jan
 2025 19:32:46 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 19:32:46 +0000
Date: Tue, 14 Jan 2025 14:32:38 -0500
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, dlemoal@kernel.org,
	jingoohan1@gmail.com, bhelgaas@google.com, lpieralisi@kernel.org,
	kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org,
	quic_krichai@quicinc.com, imx@lists.linux.dev,
	kernel@pengutronix.de, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] PCI: dwc: Always stop link in the
 dw_pcie_suspend_noirq
Message-ID: <Z4a71nPa1H01+Ang@lizhi-Precision-Tower-5810>
References: <20241210081557.163555-2-hongxing.zhu@nxp.com>
 <20250114181518.GA473181@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114181518.GA473181@bhelgaas>
X-ClientProxiedBy: BYAPR06CA0001.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10847:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e496d62-6ad7-42d8-6219-08dd34d23904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HL9RJDZ6dqBUbxWGSS70Nbq9h0ejNZWsyRTkd78Y+Rquh37Wzf24Sl715z8m?=
 =?us-ascii?Q?+c6qiSWnKhLVf3+eSOd6gd0yAwYRQ+n/RuU98jv+3Pi1u9BFUVtON0wN/ZOp?=
 =?us-ascii?Q?OTugDzIxdyPUkQBJumatWfTOXkXQiXaEZ/LG/G8gpL51j6LD9VeCyL5IYgt5?=
 =?us-ascii?Q?36m0aHRCmoPjMG/VJngcFnZRa0sFmAbU3Q9ahJbN/kQYuFTMdV59VpunawMT?=
 =?us-ascii?Q?lkvsxGlIGXr4+lcZL0KOMFhasgl5FdD0cAc2rZ6sYmwGIpD+bNi7kW5xR5H5?=
 =?us-ascii?Q?hIg8y2WDrCMT9+3tWAhOMqMPkAbpjZ5NSvMZKwcGA6qcfPs/eG+D4xGGuM+7?=
 =?us-ascii?Q?8ELB/SHElX+zWQakbDx1pYoAacy2G+sVaXGmuCCXYXn3DZmXmk3fuDdoNqxw?=
 =?us-ascii?Q?BUYC/gYI1QGd9JCwtvg09Tvh/Tq440+GQWBvuR2dMzlAba8LR1HErzjVUCOY?=
 =?us-ascii?Q?C+ejXLUqm97dt9uJgkwMOROH0Qf6p9hLdZW6N/6SlYFAUugG9V5uhS1ZwcmF?=
 =?us-ascii?Q?nKMmwPE5826MjybvQtR08E/mZhlYX6ocHXkLdLUNnzeVDmOMxoIX246CEfoZ?=
 =?us-ascii?Q?8A7z1ddq7httxZwRrsjDRGiJDfvGy6OsY3qlvOZwnC5T1+mcUhoKFPXleIWE?=
 =?us-ascii?Q?uiDdgtmpkzMeefF1BBqqvozhQxI9ckMLoyu0jLBHBxwETFKb6WO3ynTC/Z6e?=
 =?us-ascii?Q?/XRYbAtZdWIZCoOcBOU1d1813e8+QCfqYMHUOHijcqaoA7MGsboK8JEAOQrY?=
 =?us-ascii?Q?TVamid64IGX2hV3UKn/nu6pbXHzmXHt2FTA2bd6AES+uP8hEd4wNwYA2KbpV?=
 =?us-ascii?Q?ta3bcCwCmcfJ39Tu9izvH1mmuR/eSdJBPzOsQiWfeMUdeSM20SMa5CVEf4kT?=
 =?us-ascii?Q?eMmhy70pBXf6Z+Hvwogmtc963rLv/dSF/7cEMFTI0yYspQkKmlBPPNPf+eyT?=
 =?us-ascii?Q?JOgb6rtrrYJEm9/bIDhN27tvNZunvMJOggxhTxq1CSXWlQOwG815XS/TqqWO?=
 =?us-ascii?Q?2s34JWn9x9I/jMW/V36dS8m9UZ7SjNPb6qve9tQxK3riXvRfDyT+ANnFS80w?=
 =?us-ascii?Q?TuoivgzpOMg16CRhItzAr0ftZfLEBe44n1P6TIaO/U84ltWJEVUNjKtMznUq?=
 =?us-ascii?Q?+oUJF5KCSOGd79OH7qaI/X+3wgdMqE1jvj5PYU5FS5a/mthFNjkEkIeGnxNY?=
 =?us-ascii?Q?ssm9fQTseZj5iYq53M4hvMf4Gyggaq9TVEP2nrmNKRR/BgWbLXA+iD4Z4g8T?=
 =?us-ascii?Q?yOZZjfYzyFdvZQcVU6RE/+HJckk7H5EhLY0YjgpNDK9DatneqSbTPV4saYYP?=
 =?us-ascii?Q?eqMQ05M0V31rTJSg79uidfsNrtWZZVyxLBp0SIvlnSxcVuASa3lq0FXrLlmK?=
 =?us-ascii?Q?b623+CifVJdiHsq2SIZmUx7TzFv5cSGrjPPucagMFhBlyUQUCu2VhFSHS0pP?=
 =?us-ascii?Q?0C9f9nlv59Dk0SnVdGwfI3ETpQ6XmS1E?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4o7HeBxWggFVMPrkx9S3KtpVDm9lu2PdqRLm9RHEybOcx6uMCUhJsrddRTWF?=
 =?us-ascii?Q?gi4CGQGBZ6yOPseq+w4J27fZuMvWsJOx+KRh6W+pYa/8lY0FiaimM9lmbV6u?=
 =?us-ascii?Q?ZBEjWhx87agC9kDlGXZF9HoObk8tPB91tx+w+1ojki/BWvNgrtFYhuer2ApU?=
 =?us-ascii?Q?/yd13bTq4HK2NljO0sd79u1fk6+eiKzV83+xtlo8uqQiRmF9+eYydh/Y1X58?=
 =?us-ascii?Q?xnkiE/Z+1KQPGpt04lw4HrnOcZSfHQ/iuB0Wha+n46vAXh+2p7XKhNE2dL50?=
 =?us-ascii?Q?m6TYJ0r+2eGMj0voDI1ujmfuVYJlkcKBp8JtWjEZXC56dzryzhCiBihhvRZO?=
 =?us-ascii?Q?t537qIY2fTBdUPlZbM2CQnsNKILTiXTuXYKjMM4BoDy99dtaYkTd80Dg3tDO?=
 =?us-ascii?Q?jKoFBEozkdGadfInBoGoY31sWLBA6riGa83DQyyZXXPjXE4Xhvyiidv/L+zv?=
 =?us-ascii?Q?JaZ0Tmc7OetPz7/1ixrKQelqtBcO4Ck+eBUAwMtEFCiRa4gC0stzez3/BWrc?=
 =?us-ascii?Q?FT9DR2xrWRKqyroJkzY86O8gckUHMVAJLPonOJzw5lzR7GgnM9kQWCHbuYPd?=
 =?us-ascii?Q?F/C6PVhgTzCV4uwPFBAAy3PvsUeXEaS2Ja1P/JEH77D8o75FR83a6uFUx81V?=
 =?us-ascii?Q?uGCxbwanqjrt7ap5QvN9RbWhhHDGP83fVhLNzMaLMFEhYq2E+f5hjPE+Pa9/?=
 =?us-ascii?Q?9HR8q8Bi+hKnSK6arFxxM2ya7v5QFc4ndKS2TsvtUmtaBR5ymkwCoiLNb4Qk?=
 =?us-ascii?Q?kltun6/WT9dCFOhu2m57WOtCgFHvkL43hFJ44FmXZBi6hWiSPebVzMZwXay4?=
 =?us-ascii?Q?6C6IauTFjwJCNtGD/y63I/BFS3vTd++ETCKk4pSYNfNk/PyhXfS5GW9sgY+w?=
 =?us-ascii?Q?b8Xu2cEL69dwXEcsbD+mV2TJzDdUQS0u8t2aBdqo3XpWN3f9Dg6birwIsXGY?=
 =?us-ascii?Q?EjwvTwIG3yn0Qbcex7WTM35RSlM4kZwh/E9eMtQ+M8ENeCCJiPXb+F7Y0FXp?=
 =?us-ascii?Q?+CrwE23+hrhS2f2WURspKqEuY+EuX9Wq2TCpUyTyRZkny0H1V5l9ZWZIimZP?=
 =?us-ascii?Q?5uicOnr1KSA37Qv38io8nSK6W9FpKEF/8hqdROLMz26H5P8ffxz2tEpASvLx?=
 =?us-ascii?Q?IT9ZdXRptizv770doTxYIrAHFsxsHAf0M1t28HfWvlfj7Iwv6nQfb8e/dTMt?=
 =?us-ascii?Q?qKNHvDT71psBukkaSBErYYUEBtWfEvgmwxHqH3fYhI4PJlYm4ELGUGPnrEX9?=
 =?us-ascii?Q?DLJdHE1NTTNsyvO+1pjCXvWDFXHrJitHC6nC4GhkbSP3umke3UmhzHxXt2NR?=
 =?us-ascii?Q?344Cbka8CaZA3N0u6iMSO4yRnND90eCF6McKDX2IE2VG5C6+FXbxCgXjCrlz?=
 =?us-ascii?Q?6U2Q/PfqTiLMuEUX+d9TaDOev+pvYpbt9+9iCTZd52RwrNsJG5bJFkeYg53r?=
 =?us-ascii?Q?x5TDRocmJlz4CsvCqmK1W0fpTwLmk0DReIcH12J/+z92GGMLZp7waRRuylvo?=
 =?us-ascii?Q?e0B3gaCk86lE6KDsI/KGjqBh8bd1ggZazaRSn7L5GgcB45aGdOux/O57Yz3B?=
 =?us-ascii?Q?nWt/20E+XbG6RKV1hU038bXDtIOZadKYcYzDbkUm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e496d62-6ad7-42d8-6219-08dd34d23904
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 19:32:46.2034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R6QhhGC0UZHuu3MbAqgchv93R0I0p6ofhPRjXrE72trqH9Lko4ma5rhRuiDLkvC69IeyhRe4gji2GyoaJ5+9Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10847

On Tue, Jan 14, 2025 at 12:15:18PM -0600, Bjorn Helgaas wrote:
> On Tue, Dec 10, 2024 at 04:15:56PM +0800, Richard Zhu wrote:
> > On i.MX8QM, PCIe link can't be re-established again in
> > dw_pcie_resume_noirq(), if the LTSSM_EN bit is not cleared properly in
> > dw_pcie_suspend_noirq().
> >
> > Add dw_pcie_stop_link() into dw_pcie_suspend_noirq() to fix this issue and
> > keep symmetric in suspend/resume function since there is
> > dw_pcie_start_link() in dw_pcie_resume_noirq().
> >
> > Fixes: 4774faf854f5 ("PCI: dwc: Implement generic suspend/resume functionality")
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware-host.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index f882b11fd7b94..f56cb7b9e6f99 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -1001,6 +1001,7 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
> >  		return ret;
> >  	}
> >
> > +	dw_pcie_stop_link(pci);
>
> We should try to avoid changes to the generic DWC path just to
> accommodate one controller.  Since other DWC-based controllers
> apparently don't need dw_pcie_stop_link() here, this seems like it
> might be the wrong place for this change.
>
> If doing dw_pcie_stop_link() here is really helpful for all DWC
> controllers, this would be fine, but the commit log should then explain
> why it helps everybody, not why one particular controller benefits.

It should be for all dwc controllers although find such problem at i.MX8QM
platfrom. It should keep symmetric between suspend/resume function.

So far only layerscape and i.MX platform use these common functions. Other
dwc platform still have not switched to this common function yet.

Frank

>
> If it's only needed for i.MX8QM, we do already have a
> controller-specific hook (.deinit()) just below; maybe that could be
> used?
>
> >  	if (pci->pp.ops->deinit)
> >  		pci->pp.ops->deinit(&pci->pp);
> >
> > --
> > 2.37.1
> >

