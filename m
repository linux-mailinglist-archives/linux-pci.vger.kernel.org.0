Return-Path: <linux-pci+bounces-5420-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F78E892094
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 16:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 860CC1F29C26
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 15:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD46517E;
	Fri, 29 Mar 2024 15:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="A5suY5E4"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2101.outbound.protection.outlook.com [40.107.104.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43001C0DCF
	for <linux-pci@vger.kernel.org>; Fri, 29 Mar 2024 15:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711726677; cv=fail; b=bJMIqzgSUDH9GV9uM1IywGCSuBG6zHVeGapKc9pYp2nYrE3sRJQ52Bsl4KW/YYkoXYrvgX+WwWK1TTPdjcSzQ8D3zG2GUDMKOElI8qZBmyFGgM1WFyxporLTpQShW4H6/qhBt/K1feEFz3btGrimdd2asULJO1++EDvsrreDiWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711726677; c=relaxed/simple;
	bh=NhTs5R8ASt0XQburhHTrLfOE+O+z1kHHI0CO7ZFpSNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rKurQ+FSrMOA/FHFZaOuIZEWY7CXJLT0OKTxFmWP9J1NncvbJAneKPnoY2EaQ60FYhC5MXsBiD2F/aOVPNHmuMSvg4TSnYkBn4pdw8Qq1pijs/4XVKHLEOrbZrwDHYnUU27/PhHa6M2aPYzztO9fylfkdiykPNMuGnPZeibsotY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=A5suY5E4; arc=fail smtp.client-ip=40.107.104.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BiHmfM62qF6oGdKrOuqnf2womDux93Szx8GQ00nKdNjFPMfSEbbEq3rv5Ckkt0KUlTbVAaIZwaiiAc8RJSdCBZfUkCPWxBGK5azKllRZckyF9SRQ1xO80xjCsaX55UaRfaJOyqoGeKaOLvX7O+7NBwUlSldPuG8lPbOJu5XTEOQNAozMxI4b9bErqtuCpyS0NSTOE+gTljvKil/R4IGeoYNGObqu/7RmNTIZNTbknDSj9tNJHb7wgTZ0SDkyIP+VnOZ2iuNqazO/xqsK7mnduppXyPgns7zvRMHdhiWJVBCYUc4zjgiBA3bMy2kPv/Wf8mLl04zZ1EGo0xdYWeJ/kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xiRUWqOayQyrFcX+48QEy62co2jWYfNTO47CRs0/F6Y=;
 b=lu8aXg8IBsiLR96cB9rU4Q/as9AsItFtU3O/fI6RsP5OCAPlqTfUvfOcV9AVkNd/JoBAyt5ZOhhEGwPGNefSFkrDhUfIZCm9CDH5GNGTSeaWVKxMvoYEsKIoSMkUIUpmiJE/sz7eMmuVmAz7c40cKC9aeYPL9aDLPCR1DVIdlznqCOmlat4nBj6C6TgIWePn/TxkYwGlZXcG2RfVzKD6WgYW5arSYK70KI5uD6F7c98sEdoB3zUGW7T7EyDFzD4JBxxaqldRZ/C2zvFeJmVHgYLOMy5vMQli8d3ZOZs6m2Xmh3VE7zHnIRbc/9ez2onuwz/BxUMOVEEevKJhQpSTgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiRUWqOayQyrFcX+48QEy62co2jWYfNTO47CRs0/F6Y=;
 b=A5suY5E4fg+2a2sjlzn8TBHhdc63zVbejaCDp7WfSjQCaW0QpeT1Uphx+3CQ1Jha8iKUNTMhIsq3BC8BMhPMASr+naH9BdTJX6OIWeMfN7Op7OE7IDAXdxx9dx+Tfk/udyS0gwEXxcUmto6IpD1jRxlssLTrPyzNvCf01VQg3aE=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB8059.eurprd04.prod.outlook.com (2603:10a6:10:1e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.40; Fri, 29 Mar
 2024 15:37:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.039; Fri, 29 Mar 2024
 15:37:53 +0000
Date: Fri, 29 Mar 2024 11:37:45 -0400
From: Frank Li <Frank.li@nxp.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 07/19] PCI: endpoint: test: Implement link_down event
 operation
Message-ID: <ZgbgSdeojLxDdbZZ@lizhi-Precision-Tower-5810>
References: <20240329090945.1097609-1-dlemoal@kernel.org>
 <20240329090945.1097609-8-dlemoal@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329090945.1097609-8-dlemoal@kernel.org>
X-ClientProxiedBy: SJ0PR05CA0195.namprd05.prod.outlook.com
 (2603:10b6:a03:330::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB8059:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qDMLFrqHJi62pktypPBTyLNqTa2ZTdO0e82HXxbO6C8qQwBVqgBKJ/kG8/Psw3cICAIO+ZJwxr8W+76RYmMUxu4ntJnUlLkB7weLjurVIbzhOvYqoPTemXpLsu6JYHQeUJhr0Ncsy/V1Z9jrTJhCapKI8j1/8t0EGyGFrGYOJtlzMQScKq4ro1SGIYCTzyrY9YHL0rf7s7+yabmiWLrziijO3dEt9lwQ9SXT/Yq3jjmKZHMk9FohV3d75rqJ5DzC/vVehEMJm3vLuegN2iQuOEVCiRM2LXan7v4sop8bh7VgaaH6AApyDN2qLTJkUTM35jnXAGRTGYCMz0AIKD/FoCbDUDU1PWyhi+AwStmMWBAiOyCiQfp2llIpJ1PpQCcUvPzEhs8hpi6MU+fOEhKWQnD1XCPiN6x5O/aSUyNNeSt8qebaIMfuxM7/xsRwa3/NKEuHclkCDdA6romf/WMM7YISnP5M+mOeIrh/OM3VJv7E5qG1YvVl2HjtRQAm9O4a+S+Eeb4QPFMEON97qjX7V28MxLlnp1N6PD+dZ5DxwKa0if3J5E6clyE5FCqrERgop54QbUI8NGoOrklPM7mNY4/qqWDf6KMbeuPOybBDloalCuMujipx+Ah0aheWz3sn3pOTgSXjwf3E84BfcznZCt3OXnlJPfE0crOEaKXTv1ln4//cnpuEjmxZ/rbXI3J044QwY5sczG0TDyxqGD8Zk63R1Inra1ROLUdxaCFGbwA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+wLviarO37gsirIbdjVoX/qmJyC122DhFZRKQFAxL829y+xthDWOwSo4hoKc?=
 =?us-ascii?Q?Qb2sv7k7F9VbSUMs9Y6flFAoELZeWHP+roZQsw9ndTO5LXZy/+WehamzMYb0?=
 =?us-ascii?Q?zWPrw7T0pRw0uEnPZG0ysyZaQm3ckaEhM/+m246xwVFGePF2oQU4Qd0wzokf?=
 =?us-ascii?Q?CkBvx2gDJs1TKArfgNbutkUMVJm1Y1moWgDTUXvYb0mZqrokskc6JOnpPrbd?=
 =?us-ascii?Q?36amEVHx2FhOOoO9RpCuJYMgpnEeVxt2xnvmiCw/wwbVQnLAN5zKyxf1bi6n?=
 =?us-ascii?Q?sR1gSiEbQXShs5tT6qB8e6T3AsmfiNt2Q+/FRWL5Azi2Jjm7yXy3MOwuRTk0?=
 =?us-ascii?Q?GrXg8nCkK6YXEjZaNDuyawhXXIeR3ZaPglhiVMXJ82rPUTNzZMocXuO8d8OW?=
 =?us-ascii?Q?+sufrPmeCM5LYqZUddAU7o4VKYKbjLI6P0/tdelhGAmwPenBNF5NrAsnxpb4?=
 =?us-ascii?Q?kgLPyv70/oy9S5j5YUBr3qB5ZYNUVNeQgJId4gl0iVgOXy1VuAo5/S4GQykq?=
 =?us-ascii?Q?Nrcz7R40ezT3z7tZaoyzyLkHW5xEGWoYQ0ng0nx3UDl73PpM9tJkGiMNEYsR?=
 =?us-ascii?Q?nZ/NTQ15wnHEUSmvN1K7torhS+cNB2mOFp6awBLgyIdtz2JEzyfJk/cxOBHn?=
 =?us-ascii?Q?85sM3MH4GcGc5NmvjHPnD9RH1ndhpMhCZXRUxcTndhw3Heg4CtlVuxlbW9S3?=
 =?us-ascii?Q?jbreUU3OXVnIyCaMaOi5hglXZ/ueDUEEViw/6AGN6mA78T+rTMda7tAa8TIm?=
 =?us-ascii?Q?3Rn0J9GUjAjE+mLHhJdP8ib6FoFqHYluSbGpWYi7CqbkBluYt5DbQ7hPdyI9?=
 =?us-ascii?Q?OJpOAwEbbfFCSdl813Elb6KOHBdWe93ifRN9al5AtBqzKXB4hHzgFobmI/xM?=
 =?us-ascii?Q?btY9uyUzDV3P73fQY9NruCG6ci3avH7WK0RwCXxRZNrRZ9kVNHqOvMWUuYa0?=
 =?us-ascii?Q?ujWSSBhByJA6ujTcU6voqKNw1fe0loHu/0HQPt8zD024HvyXtwGIwMJ4ov6k?=
 =?us-ascii?Q?FUh8oBvx5mEJKwSaAnHotBEehHmj+D154E/KKP/8GS3uDHus5tYx6t2JsWoQ?=
 =?us-ascii?Q?UNe64huairtwM0g2r0ONiDZr7ZKGWwCvJELlgBkBgGdg/kM94ltq23k9Jwby?=
 =?us-ascii?Q?5QJ8Wkc/Jnn8no+cbAP0Y8RDvlL59xP395HdMDcZwdISwlmrh8CWkrK1pvJu?=
 =?us-ascii?Q?yvd1T2fEMVPwUCwlOWUy7QWUMxqTylcSV/YIIxQx0Gx4RLJbX88btskBwTQk?=
 =?us-ascii?Q?UO8qGye0MfXr97puzUG63g4GK24rhfK6HshUP92OVxKum/6QTpgTx0BvUUa3?=
 =?us-ascii?Q?mKkOp2rVwhsIsrNogANiYnPrfAxrXk8KYQjflKRbKfd7zT0xkLnUJhz4vlMa?=
 =?us-ascii?Q?wCIkm8AqZRgOOzu0EzvSupnbmlctqr2A2bjFRVCrEe+6CQsnLF2Axs6RVv7o?=
 =?us-ascii?Q?c5/AZftEMbdu0w+SnLwHEIVCTQsRClJjyABQuSIjaZDW46sjU3zLTMxQNdOk?=
 =?us-ascii?Q?1/nM0vBgoBk3F/H0SJI63Vm6SazylwaB67nvUaE1oRZZy7ziuG1IpCyn7IAr?=
 =?us-ascii?Q?QpTfCNcA6XUkLuJ3wCm8Gut6N4jC0AS73pguNF/R?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e88688c5-2a30-417d-e65e-08dc500632f2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 15:37:53.5724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yQ5Do+SJpDgtHidHunNs4WoCwoBAghcg5o8zL8CKAUInfm9UXpW1HITtGe9qbjS8yeZLpB1bLcu2IKGMQxmb+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8059

On Fri, Mar 29, 2024 at 06:09:33PM +0900, Damien Le Moal wrote:
> Implement the link_down event operation to stop the command execution
> delayed work when the endpoint controller notifies a link down event.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index ab40c3182677..e6d4e1747c9f 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -824,9 +824,19 @@ static int pci_epf_test_link_up(struct pci_epf *epf)
>  	return 0;
>  }
>  
> +static int pci_epf_test_link_down(struct pci_epf *epf)
> +{
> +	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> +
> +	cancel_delayed_work_sync(&epf_test->cmd_handler);
> +
> +	return 0;
> +}
> +
>  static const struct pci_epc_event_ops pci_epf_test_event_ops = {
>  	.core_init = pci_epf_test_core_init,
>  	.link_up = pci_epf_test_link_up,
> +	.link_down = pci_epf_test_link_down,
>  };
>  
>  static int pci_epf_test_alloc_space(struct pci_epf *epf)
> -- 
> 2.44.0
> 

