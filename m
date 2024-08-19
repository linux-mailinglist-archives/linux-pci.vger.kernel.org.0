Return-Path: <linux-pci+bounces-11810-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B67956D80
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 16:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18B311C223F5
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 14:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0774116D311;
	Mon, 19 Aug 2024 14:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Au57ce3W"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010063.outbound.protection.outlook.com [52.101.69.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FCC16BE3F;
	Mon, 19 Aug 2024 14:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724078399; cv=fail; b=sSJXu2IykrIZ0b5t8ShSa35EQP+mF4x7T07AR1QzKdPtf75fdPoaD+DCsx5cV2oTWfjR2pAtpqagrdf8VAj7+4+B8xybb9L4Z8QsEIgIxvDColjVzxzcSzbi+8MVL000JrQouSMCQmZ5fLbzwQO5SsT+VWfHjRyTuG/eBY0dZIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724078399; c=relaxed/simple;
	bh=dzn6ZpTUaiUVoDPeKCDvHuJZgSFAGaYbHEL4a06SDw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eOcmbo/29bT0hmTroIQ+giClJRjVW8ZV9YlWk66MbMunwCD1iLa8wfgBISgDLnwd3w+jtet8Dytq0gykqOMKax0bcH3u4TGHQzfoNqItnChctVqbc5WH4A6iSEVDugD7hj6nYW13oAFdcrI1GmjrKJFiE4AVaGNV369V093Ihjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Au57ce3W; arc=fail smtp.client-ip=52.101.69.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=czV4vWCnbUsTgM0otB5soBFxf+3gwYfcbYVcajCqBgrr69KlNluKIzX+j/GAK/ohdLEOiGAE3C6hXq+PgnqQTaw6/x7hsS5o1idrZCIl8mnR2xKRDexLSq3ecVDuWcRS7P+XMPx5WizJa2NNwvPzRPtP7WVMdCpnMQR1sVo9YePKc3WRvUqUOBmnKr6rG9/LIYC0+/VXGsMrHZ1hrXBzZdSSdCW0vYgLjdRiMlB3IBbTaWWP7zOPyIbiALEvoVXrTvaYfPqXP6eCtw5tws4ma0sGgsndpHQ40ZmjtMjeKSRe/pELTaZWGTuRj6aiCvMrNsdG7FY5Npn/AE4aE4QMAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3bS7/hshmFR+hpaoaYp942kD3ITMgWIqQE2yHv4FAK4=;
 b=FRU02u+pKyaFF4/kDdBtUIPGV0O0C0/xhemQ3vILjAkXpT2thjMVqqu1Np8DUWC/ZmKHYR7w9yKHDOkPzjnSnUyc4bAnqUH87z7ATtmv0GAnz9IGdcT8YlVI1Q3fszeIRWcftxhRC+1Y1qsuyiJghqVfsdakhPQB+y11sjqMCvPbJv+52QgJVjO1eYNkulLbCH+GOrbxdqnQH6Ipl+I0E/cJuCyiKyow0gn233tahxAyVnO3JKUroapN3gbUyGiOr0VW07JHKjLyAcgfvb5Z1VvJPXpkSbSU18NKosRXYHpIP2JzRFtMpD+mq+xQNoD6aA2XCTOiIJkGXSqhMFLCWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3bS7/hshmFR+hpaoaYp942kD3ITMgWIqQE2yHv4FAK4=;
 b=Au57ce3WhyDWb5n82/ZIIBTCZncyvOmrl1mWNAJoQOcQT+4wHLOyBDCO5rK4xbibPR1W0q5o8CXHHhFcApjTB5LI5wDuHucewyPTehQMfmkplsscF1Mmv0JhTdYKM1DE85pWHZrlqZaE7U/P39jQsEHQ6zJgVbJ0dyHlw9+CAKCQ1SDvy/TQUUZxlk1OblZrQDnM3nz4hQoUVYCJ1vf7XsGlSM8wQuNZrPZgcSN7W29N2KASIlZpu4atoL7gCNmUj2LRbo0YEBYRptNmMryuYpD88iRA7TZvuEwAbBjlNygx1u+ntY4mINXrJxAjyl2GX97HBb6lz1rJhOJzbmW17Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8278.eurprd04.prod.outlook.com (2603:10a6:20b:3ff::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 14:39:54 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 14:39:54 +0000
Date: Mon, 19 Aug 2024 10:39:45 -0400
From: Frank Li <Frank.li@nxp.com>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: hongxing.zhu@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, francesco.dolcini@toradex.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v1 3/3] PCI: imx6: reset link on resume
Message-ID: <ZsNZMdhhpGqXdJ+w@lizhi-Precision-Tower-5810>
References: <20240819090428.17349-1-eichest@gmail.com>
 <20240819090428.17349-4-eichest@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819090428.17349-4-eichest@gmail.com>
X-ClientProxiedBy: SJ0PR03CA0354.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8278:EE_
X-MS-Office365-Filtering-Correlation-Id: 414b19f8-1c41-4e2f-c1eb-08dcc05cca2a
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?LqdZevt1hzKKTtScUt30rn9w9uT7BqYxuz4uG4ckZzzY9frp48+SxwOJLL4j?=
 =?us-ascii?Q?wfzfc3ufruJ7rKrlHFPR1bn8bP095ZlLp8KznR1X7w09/RhMm4WknCMMj7Rw?=
 =?us-ascii?Q?x3kOXHhPGvoHoBWxo9DifmCm6L7XS7yzgrIxyDqMo4Bdq7FAZqpMSf8B3o4e?=
 =?us-ascii?Q?YmupXVgq5vSdwktjLkGzbUUBGdwyXyYWVtKucYI1wv0ohYKwUPk7pF9tttdT?=
 =?us-ascii?Q?roJaU2e2Hg5PfWr5qL9THh+ugAUnYPoCKkmuIxfIKXhYSeFwirVexbb8Tm+J?=
 =?us-ascii?Q?PJicDM7O3SY+XWFHQMjImbwTUBZI4wGglUTTgk69XPsWeYCkOzMB6detvWLG?=
 =?us-ascii?Q?JqsaGk77t0hxdos/1tqT636pmLMr+7qCWKepFxSxv39yg9qcSNWaCO4Klw/T?=
 =?us-ascii?Q?Xb6+TbSIulfe+yjxvbuJmukxPpOwR6PSXWdqTteso+EjoXGaaTtNS4lrrJfJ?=
 =?us-ascii?Q?6CIQ+qh1g9aZkJCCXv5LOaSMqrWtL6LnhT4XBwEn7BRJVfc8fEsCe43q8vGi?=
 =?us-ascii?Q?sOJipIIb9sg1vKr3P+vxJ91IC0XgJ3gOI+jqbR7H/MUc/5V7/B32+sUQ9taA?=
 =?us-ascii?Q?TyhMTq4hkQo1/T4AO2STqD4UwCZf43tTRHX+6pFvbJkWGB4NJalcebILvMb/?=
 =?us-ascii?Q?2SaF7a5zq+uWSkNCUkpSvfRN+b66Kt4hGO8wzv74SjJFWPTVD6qKQ7StB77i?=
 =?us-ascii?Q?UWd9p8DL76TWK480o0zGxO/qof1gGDJ2eC2sOCQjmpOKBDditNU2ndFV0YQr?=
 =?us-ascii?Q?wRP743KvmFdIdAZ4EHQE82Lgsagt1FPJdgAZSTSvifFl/TBWyzpEGy88Bppp?=
 =?us-ascii?Q?LsFOKcu0qAm7txydqxJOjcDUIVSVB3dkBlba9AuTLQSGYKrJVPrrO8LMwqzO?=
 =?us-ascii?Q?a8zY7W60rJAnWknaihhlRgL1fxM/Ocx8pACMfRBDwCKBh4kUrPknoCdRnqUs?=
 =?us-ascii?Q?DzyDLPlvxYPFiEQmOCFuYiXSEjdXrrd1uuGA97SBrfvq00Rv7nzOo84UfiXp?=
 =?us-ascii?Q?duYNTk/w39TY3Mfmdz0gxv+Z2buKUnFL8juHJk01SUXSRpwA/EK+PYDV+X7o?=
 =?us-ascii?Q?Yl1olSS7xQfMsZu2TebWuE4nQ4eAkvakrSmZkGYbsE4+32oXW/m9VxjCUrjM?=
 =?us-ascii?Q?TmOY2WEQCzK3GO3P/pIU+NrXbpC6oXfq7WTbDeRWKA43n3KbB1a6RiLgrQYK?=
 =?us-ascii?Q?pYrituV6syroAIbnvbV8cBYpi7jQq0oH5mlgncUybFGx8eHQ6FbQcpZ/gbTR?=
 =?us-ascii?Q?MrKTH6ie4FaKMlxD/P+H7HAjmfEaJ7e2QSCIKOVm6oV/Pj5Lcn9hN1RyDRzd?=
 =?us-ascii?Q?XczO6liboM+WcLkPVDgciGWlKOSsrotOCwAZlKWFdqgy1mdoklvB8MBzonEW?=
 =?us-ascii?Q?CeF0NTc=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?mnmQVEu2fo3TK+xP3PQk/UFq85yU8i0jAQBLg775eM30E2kt6iKecFJ7tUJn?=
 =?us-ascii?Q?a6U1oRypa1Zh/lJ68hsWFB6lkNa3z9WM3WUXGnHWWSf67MWNb9s6AivygdUg?=
 =?us-ascii?Q?/m5hmlZXRU4Nqh1EUJfDSydw19WjGgxo7dyUwn127YKoZrSVp+u2a6xkuF2a?=
 =?us-ascii?Q?QIlyBnCOal1x9f5E0wLNmQpJUa21QirrY5Jv5gJ/QHm+2H7XNcShqJgJtY1o?=
 =?us-ascii?Q?fI7LbQfq763L8ZhUe/cU4GJc/+9yzcvrLJAt6/3H11wuSHw20t5dO484qIwM?=
 =?us-ascii?Q?Mi7yuTbD3yuB4EeBBTVitVcidMHLNjUDGuHrbi9EgUknmhEfTpO40D+g0Vm7?=
 =?us-ascii?Q?Vy61aDCOAoQ+8rCVtBAMHDUdpBHcQDyNMZzG2Lr0PMBGT/T0LNtYfYR9iCdT?=
 =?us-ascii?Q?Dfst2O1uOtGta+0gCe+ak2KOfbj0gwbZc0E5K2aykiUQq6ovV5dF98l8/bbG?=
 =?us-ascii?Q?ML/p1dkwmVJ/DwhVSCKmxgOdffrtVSbRWvq7RthUyT/2CWjWv534n+OyLorY?=
 =?us-ascii?Q?qm2KEVPCVl73Zyha60SLrHdnEykWNc+8Vv6/CU5ABDlWWL6gSYsef+BCcFz3?=
 =?us-ascii?Q?jxjG5KWaaibIcIbrwKVM7OEzZzxVVet+2Thdam2S8tmWjDKow93nigyL5Mek?=
 =?us-ascii?Q?kRX7rMMWZepH9AzMIbIOc/IHRvIGAWestsRgFcYuJAaCsG77HSSpUY0TNfJR?=
 =?us-ascii?Q?I3zoVubWGHP/sehThM3HQ0aQT++zI4OP8+OLIFFjAXfadsKQs8f92OrhehYr?=
 =?us-ascii?Q?4ukKygnspCQIC6OIOvgwRcm0CfDxrOCByFuUsxC3dLBRkHl3kywRYuIAhq3P?=
 =?us-ascii?Q?CV+hjHs7daxlTXI49fZiENO9iSF8V2+EJMj4k25fpWf5NNuwcnzb5e0IhupH?=
 =?us-ascii?Q?aKOw9Z4mRKXs3/qA7oqzL3ZwG+Wpsrd4cI6eJ03BgLTx+jpr4wq31HnhjQdH?=
 =?us-ascii?Q?htrcT1J+za4HgbxmaCoUJFjhmK9cy/9ndz8HEZQWWibmynZKNy1rswrsi8DU?=
 =?us-ascii?Q?M5NGgGkwIJZBykKTfF7Cp1+KprvRR1giGf6OvJMdPgzIOsAljDwEm7rjxiOt?=
 =?us-ascii?Q?5/ePHc5f3aNiuXRCdQ7WLfCx5pILlsEZjY4rKiKuU0CTtViwAFd/LiWHr3iB?=
 =?us-ascii?Q?PB7UlT1gUHXda22HzCYRmSuPAdoUnN/Y3lbSTh4LEjOhMS4oiUOahz0R9DTk?=
 =?us-ascii?Q?FUzcTN0jyWOI+MCQm/kvgBkcTsfopV9YTtCoCriqySPxRB0vjpNUXMof4M+k?=
 =?us-ascii?Q?ggT7rfwiUJNu9TcEU4W1m4Wz10GyI9fpcOlnwugUFv20hU0BEc+E0y4GR9KR?=
 =?us-ascii?Q?nvo5JXC3wVXhHy0ninfBR0EGx5U1aNVl7IqQ2lpDtH8vB0sqgY9hXT22/Lyz?=
 =?us-ascii?Q?lE+8hDduURJmOHcjS8cnAqKiv3bWIWej4iC78mHhsKlTDNuWzWDStoWOWQvo?=
 =?us-ascii?Q?YjUyCoHzJOMncy1Sqh9KgKzk7OaDXQ6Fu53G4jLNXojMLDKRaV4ssFm+Ep6E?=
 =?us-ascii?Q?sGN4s4xvEGqq4iEIxk8MRWNQyJ2qKZ02gxjWRpYUBKtcqc1mFqm9X7gj3jfY?=
 =?us-ascii?Q?+kUBSt9v0OlJfF5mU/k=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 414b19f8-1c41-4e2f-c1eb-08dcc05cca2a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 14:39:54.3100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ChE1FtALbIhza/lmjkmuB4REQow53liKA12XVBkKelL1xyVVzo74iIwc4yRWGYVpFLRLUCGFMklKukqcZipOoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8278

On Mon, Aug 19, 2024 at 11:03:19AM +0200, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
>
> According to the https://www.nxp.com/docs/en/errata/IMX6DQCE.pdf errata,

Can you show errata number here?

> the i.MX6Q PCIe controller does not support suspend/resume. So suspend
> and resume was omitted. However, this does not seem to work because it
> looks like the PCIe link is still expecting a reset. If we do not reset
> the link, we end up with a frozen system after resume. The last message
> we see is:
> ath10k_pci 0000:01:00.0: Unable to change power state from D3hot to D0,
> device inaccessible
>
> Besides resetting the link, we also need to enable msi again, otherwise
> DMA access will not work and we can still end up with a frozen system.
> With these changes we can suspend and resume the system properly with a
> PCIe device attached. This was tested with a Compex WLE900VX miniPCIe
> Wifi module.
>
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 45 ++++++++++++++++++++++++++-
>  1 file changed, 44 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index f17561791e35a..751243f4c519e 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1213,14 +1213,57 @@ static int imx6_pcie_suspend_noirq(struct device *dev)
>  	return 0;
>  }
>
> +static int imx6_pcie_reset_link(struct imx6_pcie *imx6_pcie)
> +{
> +	int ret;
> +
> +	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +			   IMX6Q_GPR1_PCIE_TEST_PD, 1 << 18);
> +	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +			   IMX6Q_GPR1_PCIE_REF_CLK_EN, 0 << 16);
> +
> +	/* Reset the PCIe device */
> +	gpiod_set_value_cansleep(imx6_pcie->reset_gpiod, 1);
> +
> +	ret = imx6_pcie_enable_ref_clk(imx6_pcie);
> +	if (ret) {
> +		dev_err(imx6_pcie->pci->dev, "unable to enable pcie ref clock\n");
> +		return ret;
> +	}
> +
> +	imx6_pcie_deassert_reset_gpio(imx6_pcie);

In my patch https://lore.kernel.org/linux-pci/Zr4XG6r+HnbIlu8S@lizhi-Precision-Tower-5810/T/#mc5f38934b6cef95eca90f1a6a63b3193e45179de

imx6qp_pcie_core_reset() and imx6q_pcie_core_reset() is not symatic for
assert/desert() to match origin code. I plan fix it after above patch
merged.

Does it work if make above code symatic?

> +
> +	/*
> +	 * Setup the root complex again and enable msi. Without this PCIe will
> +	 * not work in msi mode and drivers will crash if they try to access
> +	 * the device memory area
> +	 */
> +	dw_pcie_setup_rc(&imx6_pcie->pci->pp);
> +	if (pci_msi_enabled()) {
> +		u32 val;
> +		u8 offset = dw_pcie_find_capability(imx6_pcie->pci, PCI_CAP_ID_MSI);
> +
> +		val = dw_pcie_readw_dbi(imx6_pcie->pci, offset + PCI_MSI_FLAGS);
> +		val |= PCI_MSI_FLAGS_ENABLE;
> +		dw_pcie_writew_dbi(imx6_pcie->pci, offset + PCI_MSI_FLAGS, val);
> +	}

there are already have imx6_pcie_msi_save_restore(imx6_pcie, true); in
suspend/resume, why need addtional one here?

> +
> +	return 0;
> +}
> +
>  static int imx6_pcie_resume_noirq(struct device *dev)
>  {
>  	int ret;
>  	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
>  	struct dw_pcie_rp *pp = &imx6_pcie->pci->pp;
>
> +	/*
> +	 * Even though the i.MX6Q does not support suspend/resume, we need to
> +	 * reset the link after resume or the memory mapped PCIe I/O space will
> +	 * be inaccessible. This will cause the system to freeze.
> +	 */
>  	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_SUPPORTS_SUSPEND))
> -		return 0;
> +		return imx6_pcie_reset_link(imx6_pcie);

If reset everything, I supposed we can add IMX6_PCIE_FLAG_SUPPORTS_SUSPEND
at driver data.

>
>  	ret = imx6_pcie_host_init(pp);
>  	if (ret)
> --
> 2.43.0
>

