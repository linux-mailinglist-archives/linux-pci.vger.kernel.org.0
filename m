Return-Path: <linux-pci+bounces-14728-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BBF9A193D
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 05:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAB481F21D5C
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 03:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769131E50B;
	Thu, 17 Oct 2024 03:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HSlzVb/9"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2047.outbound.protection.outlook.com [40.107.103.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3613141C6C
	for <linux-pci@vger.kernel.org>; Thu, 17 Oct 2024 03:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729134937; cv=fail; b=T8HVwSkZ0U8gSQpSXCtLRPlcIhavnef2v9qcPVk+ebIlbYdzNiAzOIDa5An9htTg9z4cBnxR0Te/HGpd+DDZEb3e31EEkFeWpcxQinN0/3oakCpGk/nBtOM/9zku8Qn1Q+0OEPXqRkTPHTjoIX7nmDTlv+ADjvpUe9vPKG0nZyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729134937; c=relaxed/simple;
	bh=1B6evDXCsEd1YO74hCJ+4q+mb4avRYpYyUB3xZqUBU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lLIYYIWEgD8TBV1jhMjTdJnnz+96pK/7gaVIlI3hegWum7Jl4sEzpYDWJFyD4YwYh0UFYp/VOycX0gK87eZ2bBeUQjzoGb0RgkW1vmxKi3m0yNLVu4cxjN0bo0WOcZDmZVGmdv9qLv7+sTMdFeyDSJBgNWPj9+tJUYbHma0pH60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HSlzVb/9; arc=fail smtp.client-ip=40.107.103.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jyPwbKK63vNTA5laqjAgBOK4rf0HBl1X1VcpvZJ2y5mH5gxFUmve15JFvsjZFVCp++46JP/LPhgCY+TCDKcV/CXXIbPazB/jgqwY0O2yJAsQjx5zQ7W4F4QrzWOXnq/ppws32XkuueATVt8xTm3zTPvfiXsGF5C0SIRFzXE2wxQLDiLtNKgse+M4LTnDnvmoTQ+FS28yD0KJB2yD+gF5S0U5b2/OTi9eV1cVCG2HwP6JORpGJ7sZs76wzvpcRNe35zJvlhzxj7iwTQsSEER73GvCDAIhbjGSl+k70+2xBB8eKoP9wAQ4TgC0qaHIYj9i4R3zFFHqvtgb48MjFXfhwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJS/bkKCPdkttGmqt0R6q0W9mKoPzlFRU2DRGyrLbfI=;
 b=yjqfC44CmXQMPqHS3f25P58PPxwtUfNIvtrj0UEbwwh3LYezrmX9VHSaSsDtAqAb6IURQqm7pDEkssvFQ+Y4Qbui3lGDBMMDYlqry3/25ltyUe+xYJqAudwPrXHLdkQ6pTiU3+Lvcco2j4XkNelHq/yJcSb5Z+ihVPGT+dVtoxkKcxJH+xnasi+T7fQzIPmWoCXztGut7ZV6tEZJ0Zba+eaeDq71liNlK4ghY4vxU2wiJhdM63SQUa5kCnCuR+WyDO7yytXV9Do333kHwaUcWEOppn3/wcGMQAf6SERKNssNXSmClPVmzQ5xy1iYKa6fo14wrH/X9PIfPm1mQ3rANg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJS/bkKCPdkttGmqt0R6q0W9mKoPzlFRU2DRGyrLbfI=;
 b=HSlzVb/96AMumziOY4Ed3IjfEjSdvL7Q5KuFUYr4MlHX1KNCBgVYGwbLflVf3oWKLe6/X/UGZGZgpExVpLUulNPmBljBPpmxHm5ZSAIAurJkpAge5Dfqf87IZbd2MWtxgCf91MKZqpTF4tJFBSRy/iHw4h+U23LWyl2bz8bIPAG332vBL3kXPYAUhZDJR9g4qPgSDCOIMGE7ySi1a3WcqcWJYj+lbaB0FYkfOzs+bFVYZOfkZxYh/CB0no6QSgsnUJtCt8yjboqnpQepXemNFFqKPsOBzJGqn6XPzCkohzoqiEuBc+6juopk49jA8f6Cqb+vGLxaJeg4BRjELUf5CQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB7052.eurprd04.prod.outlook.com (2603:10a6:10:12d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Thu, 17 Oct
 2024 03:15:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 03:15:30 +0000
Date: Wed, 16 Oct 2024 23:15:24 -0400
From: Frank Li <Frank.li@nxp.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: endpoint: test: Synchronously cancel command
 handler work
Message-ID: <ZxCBTP/v2zu2Ggw0@lizhi-Precision-Tower-5810>
References: <20241017010648.189889-1-dlemoal@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017010648.189889-1-dlemoal@kernel.org>
X-ClientProxiedBy: BYAPR01CA0068.prod.exchangelabs.com (2603:10b6:a03:94::45)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB8PR04MB7052:EE_
X-MS-Office365-Filtering-Correlation-Id: 80324b26-e0e1-4e2e-de0a-08dcee59f4c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HurS/TZR9Rd4/OqOXIWpzobEu+rzrpLP91Rir5HCv1dsiBUbYoKYZfxZsui3?=
 =?us-ascii?Q?QACjcu2hhHN2o/KiXHnQU1q+5i5y6Dyp2Z560HEpIx1tA81Z7WEi9BFg8wGY?=
 =?us-ascii?Q?dbAzcH8d6oDp1ZEYRVSyfANOWYlIU9p5pTc/vVYoknNJdzuxvXbmj5sE2/fa?=
 =?us-ascii?Q?kqZvddoaFvbhgXKcNbpmtTHMawpKULMK77kN2t1ipSjdmrhfYXlOumjn3ixr?=
 =?us-ascii?Q?EhgN7NMhkmvo1PXwCthfDcVDGnUldyh0ROO852i+Wsho8qSK1IDj0D5eMSTK?=
 =?us-ascii?Q?uNdoWPYTQ9RTviSxCWGTUPecLrDz9FebSOHrnBV4CbgZhowfgiGUnf9tARQ8?=
 =?us-ascii?Q?FkhYpb7gT0+fYzEHRCAszJPrOuuGaReJFuF9OTkxYFOWFso4oCAdak8y95NM?=
 =?us-ascii?Q?VBZKo1cggLA+lHoWKQ34M2nEdTd0hrGQ0Tt2Jq1Y8c8EpRupS2M10HvEONCD?=
 =?us-ascii?Q?bmXyM/E3Ftnu/Sl/51tu7aO3Fcbuh3LfO6f0yNSoJAuxoBu5kHhzXCoiTxEL?=
 =?us-ascii?Q?ivG/P13Ic2Il/lykZynUqxUAKUtblHiEPl34OI7f/juGDjmxxPVSf/zmNMzJ?=
 =?us-ascii?Q?1+KgDO/zG88RLFtdRrdU0ufF6PM3lrVGk0F0v7zvaPKKxl2GUzWVBWlG9irc?=
 =?us-ascii?Q?l5QthKvvCIF5eZ4nILhZ0WaZ6kUDTGLn3Ei49cKY9u7beqOIMncG1bRXJZsJ?=
 =?us-ascii?Q?MefxlvqujMWyTQB0wmRUC7VmBKPy1AlyJTzXvXKxBn4AjjsoDTSPo8C+PCLO?=
 =?us-ascii?Q?DYOOegTQ/qGJkoq3omWr3TyosBJSxi38+YYIZf+frjvZJv9ietqiZRpsiFKx?=
 =?us-ascii?Q?yWMmDUbjXBD5Q/kad0h3HeF2hW6xkvQm+Aw/PEsN9Wx9dm/zZFxSVS88rcbf?=
 =?us-ascii?Q?YVMSSTutbzPsJwL5k1UTaZuTQkQDf/mwy48QiSc1pD5mWR8fKv2r8/aHXVXO?=
 =?us-ascii?Q?+8qBEbafFC7q7XBlUHWMx1YWTodsUzBxvUZeGrqc2U2TrW6wx75qxvHFc9rg?=
 =?us-ascii?Q?vYdYPf+WlkbSONgjPMRo+fI00X+BC889/JHCsCRQVPk1Z5Y680srccD+JZvC?=
 =?us-ascii?Q?dp9Dj54gsafE8EtuN7iJeVFKBfx9QmUQUtKTM+86ZvmgOtamqh9ByUhwIVVl?=
 =?us-ascii?Q?I0Kp6KB2o4vRIahMlPrfGKbuJ8udWELAtT1t9oN7VTVhDnVt8gzIZvcUIIyO?=
 =?us-ascii?Q?Vppr/5KHwmLcqSf6SCbS+RFWxixCrmIHE/0BKeQ3MMsu5bSKEG9YXNVKPD6N?=
 =?us-ascii?Q?tWgPjnTyMjwzJif7iBRgwunnCtuk1srhWlIQ8Y7mKLpOr7MNIPYaUgnqDYzO?=
 =?us-ascii?Q?79J0k7MYiN9s9t3ijnVykPDHSGECutZL6SEsBKPCO0jh0nMeriVQ01Sm0/kB?=
 =?us-ascii?Q?DQNNwks=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HBPoVghR+sJVZmyiWbNVLm5T5Qy/AVPNilYCdVcTcW9Nmmdcy0NSRzPghW6r?=
 =?us-ascii?Q?MUnnMTUAeGtw0Esu6f1i+hiPi7/0i/NNacazxkUz7skPF3o0PbiyIzxI+y9Y?=
 =?us-ascii?Q?8v4skM49ytHYdnXd5WTDxoh5vtw06UONCmojDzosGmBVa9raR5uTT99IEVAu?=
 =?us-ascii?Q?zhJE5F7H17rE28+Zbw5jeB//xmT/1Q9M/gdArvQD5Q45SB0MjUR4P8yz8Hky?=
 =?us-ascii?Q?B80RiwF8cSFH7Ve8PUZ8+VAg7aUYRUxMtxxDZ5I47sOTYsobQchyuwcxDE4z?=
 =?us-ascii?Q?BdftEV8JkpUFZZcOqcNOlaMEkmSe5jQnuXgB1yinyYevYAZbdkfPznKGnkMX?=
 =?us-ascii?Q?js/SM3FF4xXl7a3ZP6rxcjJW6tAQp1hwRl9Jz3mJcateTMpti9sZnVN/VkNJ?=
 =?us-ascii?Q?GBKM5AFeyjSqkyAZgl5SMulEqPwyzhDSd3veCHAz+d13ibPXQgM1gpowIteW?=
 =?us-ascii?Q?7i9dU/GHZxnbLmLOC7cWRp2T4Cy/k4WR0nkLkG0dfZYQ9W2c6nmPJf94DQq/?=
 =?us-ascii?Q?yyL4PdfEleSprg2UayBJBih4U+pLtIjaSqUAiG99w69FUrHX9X+LH9EZNIkb?=
 =?us-ascii?Q?q1A8SDytGBK8EAf8tC+KnAQKSYwJlzv7zj5bUfgGPUrctl/U1EPrFlMG3eNw?=
 =?us-ascii?Q?4UqSapzCVXjqwJunxpsRcP9JDr/dLO4xV4ezwYk7swezVfZyDtQKQxpuq94O?=
 =?us-ascii?Q?vDxAnHZ+8rbsqMAXY4Nr2QpoZp0QNtsSOFkUD9F33+RElkZ2XvYYuHUH2fm9?=
 =?us-ascii?Q?bZBVfNnwSu9k8d/dkrfp+6Pn+vbbg2ISDM0z+53e2/KP8vbusu4ZliKyJ54u?=
 =?us-ascii?Q?VCFklc3lgF1PcQYA9zRyMS3+ELZ8AzTHbsbLl0z+s5K5dYXpUgwRPulTznsQ?=
 =?us-ascii?Q?RaqxFcD0FUXY9Huxlu+WMI4b5IUXKwSq2PZhhOFyoFrAYV1Bo8bPSZMzLszr?=
 =?us-ascii?Q?S1zb/CqAABOu3erzgfM7jo4v+QcdlMzNf3rI5DDM3VjWYs3kNbmxfYZkMh98?=
 =?us-ascii?Q?uMYHQPwzbV98jTBPW3KFwbCQJ8eVZ36qSES3D363KPaKRjuZo93eWWYjjPTx?=
 =?us-ascii?Q?LELWp5kITuwCaiGx5j9zU0+NyNn2Xz53a4idGSbm/ByUSRF+1KNVOqgX9MmA?=
 =?us-ascii?Q?wYtGAtT3Jh8Nq5VFNULVKUyDb0okPQewGEF3X6TFYQs5jO29EKQ4KsDAmPzk?=
 =?us-ascii?Q?oGNm/UJbGj+4el3s4hIt8sIXJ1ALJA0vp53TW1PH4gztUHRLzcGzMle4aA/J?=
 =?us-ascii?Q?jt/orOiHGsVMvySSnDucL4POcqoNY7dkCIK2E2ne8u9W15jdfxHlL8jpfAFB?=
 =?us-ascii?Q?bTzzkZZvtgBbgF96WuLiiDyYyvXEFxOQWiKp039TphL5Fr+XpOSgNF59R/gW?=
 =?us-ascii?Q?GlynCYflZ7uMJhbxYmTo0OGqKCmlpGJhGs3LixsHRmuGeVcLpguw0rQKn2Bx?=
 =?us-ascii?Q?uLppCuAlBjb2yr1h+NUSFHA1tYnR2yyCEpLE3RNc9R6IUpUAdmz683u0/RwZ?=
 =?us-ascii?Q?wvTP2l7zSo6MFmMYnFqcqaTWw/Md8kKezJnS6xXIewJo7i5lV1KzHsYlUy+j?=
 =?us-ascii?Q?483Q3Bxb+vD5vhhpJV8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80324b26-e0e1-4e2e-de0a-08dcee59f4c2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 03:15:30.8431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3s8XLHclLVKenBXwys8hLWU8WDabR0UZDIySFt/Cuq1J+/svU6YIBgw1EFF016KQKDYnNW6WqEYO6EqIrjOuTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7052

On Thu, Oct 17, 2024 at 10:06:48AM +0900, Damien Le Moal wrote:
> Use cancel_delayed_work_sync() in pci_epf_test_epc_deinit() to ensure
> that the command handler is really stopped before proceeding with DMA
> and BAR cleanup.
>
> The same change is also done in pci_epf_test_link_down() to ensure that
> the link down handling completes with the command handler fully stopped.
>
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
> Changes from v1:
>  - Corrected typos/grammar in commit message
>
>  drivers/pci/endpoint/functions/pci-epf-test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index a73bc0771d35..c2e7f67e5107 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -800,7 +800,7 @@ static void pci_epf_test_epc_deinit(struct pci_epf *epf)
>  {
>  	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
>
> -	cancel_delayed_work(&epf_test->cmd_handler);
> +	cancel_delayed_work_sync(&epf_test->cmd_handler);
>  	pci_epf_test_clean_dma_chan(epf_test);
>  	pci_epf_test_clear_bar(epf);
>  }
> @@ -931,7 +931,7 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
>  	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
>  	struct pci_epc *epc = epf->epc;
>
> -	cancel_delayed_work(&epf_test->cmd_handler);
> +	cancel_delayed_work_sync(&epf_test->cmd_handler);
>  	if (epc->init_complete) {
>  		pci_epf_test_clean_dma_chan(epf_test);
>  		pci_epf_test_clear_bar(epf);
> --
> 2.47.0
>

