Return-Path: <linux-pci+bounces-33302-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B48F8B18569
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 18:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2456C1C214E4
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 16:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF32328B7DF;
	Fri,  1 Aug 2025 16:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cKzV773p"
X-Original-To: linux-pci@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011042.outbound.protection.outlook.com [40.107.130.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A4026C39B;
	Fri,  1 Aug 2025 16:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754064503; cv=fail; b=ipZIWnBGNlKRgr0uOYjOMDTiljlybik50w1KA/zvOkPMj4tsm8OlJ/Iuc136Be7B0sa0kmpQ9ginEeq/EfnyFNmAQpN26jZ9rP9PULaYLFajSC7Agw+cYmnydF9LnlabBZJU6nwebGrt7jAk9Q+a5cSCkDLMlK/eTJvvjOXF7VE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754064503; c=relaxed/simple;
	bh=QDjMHOVQ41aPVmMdXUWlCnTPI/HBdv3F4m+dtboB8gI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=afJYs896BdC6pXC1TsJb0OC6av6xtwI6n21NY4gPlJhcwnESpdaOBw58/F+IAKDIFfdTCl8yS9MHU7ONUJshIsas0J729CHndixilopwsGql7goP6Tig7aENSikn9PXY4qGorKRJ6+UzMym+CcMAqM2Ifqf5SgKgxkyYYEgZqpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cKzV773p; arc=fail smtp.client-ip=40.107.130.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=akRm4lvqnGFyftIX4WY2G+ntJUupROJy2qPP7VtA03LI8Yb0rw2p3ALYT8ZMlyVKKG3W+JFnKKH8oBw6sGr9fVjX2JciCSu0h0fmjZAM3dhAkJVwLz7FsmIr/loEk4ZrmhBbMMMNDqLn7t1hEdYHn14TGP7Zd/FaUb4wVmAIwjZvx8kJp1qqTCmanWU4D5dlhyFSAMXQihuw5KXsAAqnsnOAeCsOteNxzgq9qYLQ4kKjB1crt0iiDx2Vup7+tl38YppKRiNy/RgaK64INiu8PukNGQ6czP89Gz23kvGzDLun3mr5egM3DekM7w1NvCmku6Ex1rwPlAvkiLfEHZKJ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OaB6rsyi0WDFTelPSry8OIWw0e7s7xH/B9rg8UjzsSc=;
 b=roJEL2cD3TY4j723ZpMghBqzufTBeZm0/R+3+oB5fFFGMHm76BCkKWZMzHiYgIUG+fm/ex0eSvo9Jrn6FaSoeS9TINlaWUVQzPIOwAszb6N/wQ+rVptA1huhB6pzGKdAqCE4ZS8OiLamf0w9/1D86IEWU9k+OX1OGRTnunf6/HnPWiROTb5wv3d4jcKMRgVX66RA3QhrLdofC26EdjmsqkThA76Au5ptGUW9oZlAq7rNSyHxWy5AUHr+DETDhAZSoiNJYfrSZC8IPgJwdPa0m7GwkZ5qM+CGnnbjXAxB5eAMzM6xT3adGCKrA+17BkpXD2TzYiIhonhW70bOOTTSog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OaB6rsyi0WDFTelPSry8OIWw0e7s7xH/B9rg8UjzsSc=;
 b=cKzV773p3CtnyFr1DfrlFbhuqf0bUAbg35oYCjxgK8iqSjQ5P+aNpntByMPIyPGHn5AX+mtxINKtGAyZUrTit1mP6n8UEiu6zo6yxiRHCxLBnfaIVyEYzVbg5lZ4z+ol9O0gowz8k+j5SCRrD1PY6zMc+LtDFksA/H0z/MRzZYaaf2A86deMxV8xnq2UB5adsEOe2ijsQU0gyax6hcmJp8o6dDVkPYOBpOMaJhmpdPwW1B8xSt+SKh6WjSsAKO505lbBzGRWF15Ewu5WJLod4f6RwA0NA7pgQBeyDWPCYS9XMb080V1xuW9TvDhi/XOL5tuQ6ZjC3fCS4YIJkd4Qvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8896.eurprd04.prod.outlook.com (2603:10a6:102:20f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Fri, 1 Aug
 2025 16:08:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8989.011; Fri, 1 Aug 2025
 16:08:18 +0000
Date: Fri, 1 Aug 2025 12:08:11 -0400
From: Frank Li <Frank.li@nxp.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] PCI: endpoint: pci-ep-msi: Fix NULL vs IS_ERR()
 check in pci_epf_write_msi_msg()
Message-ID: <aIzma3CtnELeb1Ss@lizhi-Precision-Tower-5810>
References: <aIzCdV8jyBeql-Oa@stanley.mountain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIzCdV8jyBeql-Oa@stanley.mountain>
X-ClientProxiedBy: SJ0PR05CA0095.namprd05.prod.outlook.com
 (2603:10b6:a03:334::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8896:EE_
X-MS-Office365-Filtering-Correlation-Id: f0262b80-8256-4710-e4a2-08ddd115a116
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|19092799006|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gmwFXnGWi9mzMAfcKlo3amQL2H3+w/0NvcW+C2PDCBFBr8y71OQW+/n0yuvK?=
 =?us-ascii?Q?REAnMDiFa6RjfynORDUDiLTx8hhXhBXZZf9mqxJ7eE0rrWrLQwnpbgzSA+QO?=
 =?us-ascii?Q?uTLciKAhYy51QoBHE/z7YK1I3A9xBVJ0tEhWDYhpIu9HcpDvRRRulo1ZId52?=
 =?us-ascii?Q?aXAOs1DL/D7F4okeDGPfWUMgrK8FfrWPnZR1DQlQIh3za906C8D3XS5UT5ts?=
 =?us-ascii?Q?oXf5+nPci75Zf3bzmPogWHny/Ipkub9YPC9AJtUVEWyUTchaaa1jE4YTJD/N?=
 =?us-ascii?Q?EPoMexPI7He4UenKiqyIbMSf76aZqUlZRaQq07Pscshw+zmeRQjKOfH7xoYt?=
 =?us-ascii?Q?IajrH1+lmue7gRiqwfk09s4NJmM/MuTQ23FtKKYTht6ALlxX30phfNMsQwpC?=
 =?us-ascii?Q?/cw+kxF5c4fZWD9+zsYupuW/VRURC5e75ymAn+LXfWWXlbMphJcGdQdZ0cLf?=
 =?us-ascii?Q?K4ZiayWBJ8X+nLfk+AoGzKI9fHB0ts6rgq2E3eWJoj6ZVuKWdufj9UhUOWgp?=
 =?us-ascii?Q?FDlK/7D8o/ZaLI46T941DDaZLKv+WRuy6I0tKhn86cejx1140GXLccwou9/s?=
 =?us-ascii?Q?YkqUFYCErTYgxwPL02acchmt4Opm7vvYysbvJE7s4GmaOHF7ISw1I5b29axe?=
 =?us-ascii?Q?q/1JtLnT2sJv7D8A0NPj1fnjEy3Zl8YD5Kr5CnZE/4K+mEv6jfPMdCIPitIV?=
 =?us-ascii?Q?+vhUy9sesDBmWAVHgzkV3BZ85DZPF2JAPNiT8iG7d0A1dNNgtDe+YWBxafeP?=
 =?us-ascii?Q?A2ButwkbTnAHKcUHzc2r/0bLGCzFiO+/pPVSIdZPMjYt0NI+2zQxpcLeU8dJ?=
 =?us-ascii?Q?duwyGfYQ7ML8pqyQIzi2++i3mlZaQf1kYyfZyo/V15n8V6qyevAeMPWyzkig?=
 =?us-ascii?Q?4Yk3dmqpg2f5XKo4e98gE7OGRKljq68jSqZc5Te1jWMmTkOeEhmSFgXl8DgD?=
 =?us-ascii?Q?2TIJYVGcmbgc6c671ch8UGwI6tjLVrPHEYTjq8w7WOhb4NEyAOkX7ac8uohW?=
 =?us-ascii?Q?JDcb0jufDapgxXCxqzmUIC1fGOLTI+A9LOQitvElx3X3CqkhHuL7GpQi7JTJ?=
 =?us-ascii?Q?ZDj7uc2h7zBGAOw40K6gC9/L3N+zfJm4iKyc/2Q24YxvQ1ZsL7PlzSKQAb2t?=
 =?us-ascii?Q?n67avbtXC5TG6Jd08qZoyVqYnTjeyIJX9mkKtgiVKKZ9Ep2be7RRHwHIBqWo?=
 =?us-ascii?Q?5uTogzl0uis2TwiUYv6N8m0dse/ngnkEf6bPituox/3ZzQbZNkLvILlMBHKg?=
 =?us-ascii?Q?c2fYzGl3wDPmbECUT2AilZqgGfarWNYeGkRBrGM9t6q9woV9tP1MYYBpRJtT?=
 =?us-ascii?Q?0ofIpreCCUP33MZK1XmPZ9Hru50sAS6vxN91gtaRBPH79ZjEMY8sS4IXY0qu?=
 =?us-ascii?Q?N7NTnZYieavdPuXtXoID82GFWf3sFmf+jGa8T6bNEfaE1JGjJBwKCzctVLGo?=
 =?us-ascii?Q?VMjXN/vpl7OCM+l4UqSylbvNSTvmus3PDq2+iD4rPYdrg8ykZS3ulQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(19092799006)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gBnlWmX9QdKkjHhv2XKfqHu/jKarH5IA1/HEedye2iN+H8KR00s1y4iKjkL9?=
 =?us-ascii?Q?TXUtwkMlkY/6/UoSIdMidVA3F6wgGZWm04Ut95D3SVpKGGW+zn6irLaXe7/m?=
 =?us-ascii?Q?Hd2fwewjgKiHBQnmhXbfwHpLCmVfIEZETASR/1JzkIkXv9e8cMDyegdzJD+E?=
 =?us-ascii?Q?Laxm0sTTW8iu8MvCnFdxpBpMFnMTrm4NzBtEsF+Du/jdWwbGou5nEzcgKzGP?=
 =?us-ascii?Q?5pHeC2V6GjCsxcl3kGJsYZWOC+khBkEWGcry5XMZG0dAaAtduIIUMI34ZEBX?=
 =?us-ascii?Q?gc2pSs5UBC8Zubiur5ZhIa7tXJb2+4nanpOhzuU5XjMaaiaSbnjvP546sOeg?=
 =?us-ascii?Q?xtTA5qDsPA2yfIM8He96ZZd4CXWcZjfBtfoH3hZQCTvvt1gC+P0ztZmDb813?=
 =?us-ascii?Q?giw56+9aTP/WgwtO/aVPhdzUpCgdXVd2kkvfLsr3Uh6EBQ9Q177MCvZhrRBq?=
 =?us-ascii?Q?E8fEvhiscUxQKgDAsAQj2cEUEydnr/bfi8KKYzHVMg+M5ph4zwEzKxvpPJq9?=
 =?us-ascii?Q?Tl95jgTgeHnzB4REddikxkQLZkW4yT+4wBdUZSZmfQgOWktdkXaGW1IA/duy?=
 =?us-ascii?Q?NNA5IqoTrqgunxQ7npmCjh0QqV5RKtzQjvdZJNLFjB6/f9BzxwAno/3RXV1I?=
 =?us-ascii?Q?WWLUuQyw5nTDNqQcmM/FRWV7STPpJwIz0P4lJkpB1neIY3+QRimQXOUpdaHL?=
 =?us-ascii?Q?8SbakC0NsA/5nE8UiO7H0sWXS6nmj7o3SwKVh3tgutWp8kto9M6kqAt28t88?=
 =?us-ascii?Q?0EIqjbeHg9dFA1BrqQFHgvyYj+2fb7lTe1Es/5zvv+GWc6W0nZc89qDoq+y3?=
 =?us-ascii?Q?Pgj8pzRqG/mbJ3PADOSADusbDKUkbxCNy3SRQ3+Tzc4S0LJKbSeOCuu7E2QI?=
 =?us-ascii?Q?kw+yE6VYCnwFTkZOijGDb1MT1WjwY4bdH/1esKM81o269+yfWUCDW3CfBhPt?=
 =?us-ascii?Q?k2hFZeDIsgSDyTPQ8pV2egOjy4kQVRpSS3S2pgiJ54kXQADeHnZ7WFaXP5Ay?=
 =?us-ascii?Q?YPKdLJga+TTNkNsA2H4mhpDL9iyuTWGUVb5xtrDEYcarDZkjMpFdIbfhh3nr?=
 =?us-ascii?Q?vjVb2M5dT6O4T/+uJx6sgI5pseUrzoQNeiFvAzebO7rjJoFa8IbYIyPovudT?=
 =?us-ascii?Q?3HCv0Y5ir0BE/MyramogsXBZ/NxstXlpEPGAOEP/aJP4YunOv0FpcOtqglRR?=
 =?us-ascii?Q?Ondk+0vke7hF9XipGfKgttUSqXPGlP2LVnCybd5R0XNoYJVqXCcnV9GAPgXj?=
 =?us-ascii?Q?hDX6eT0MCfoAtPFi/sStPz0ILiRb9oRE88pEWd8p6aEYiN+SowpXq9QujcCB?=
 =?us-ascii?Q?D4MQbf8mw9lAUr+b+Y3Fv6xBG+KiLMcTYpoPOgMJzr6FWnlAs3YWtRl5y7Nb?=
 =?us-ascii?Q?OSINoDihDCQ5qS3Z4yWfCSecvs6PXnveeD731sF0zCIu67RBA7+nNJbs9EWp?=
 =?us-ascii?Q?UmRuMIieUc4sHjzF7HeK4PmDqVD1GopFHz3ROz7207+lb+pIlS624AZxTJVD?=
 =?us-ascii?Q?4zILNgCjiOwXW3eq/V+b8eECJakr2SJl89AnGo1BN8jIv1mRPJONeSuXj2IV?=
 =?us-ascii?Q?JMiquCMRY8J4qJSJq2zZGBGrx1sIUwjxrXwBGryV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0262b80-8256-4710-e4a2-08ddd115a116
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 16:08:18.5340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TVWC3tsRTbiEi2/tuQtja1kIeXGdB3yEm6f7ggTm0cBSzMAKpYAOQKE6aQAZfXavKzRBQLREgJHBkApsKxgQPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8896

On Fri, Aug 01, 2025 at 04:34:45PM +0300, Dan Carpenter wrote:
> The pci_epc_get() function returns error pointers.  It never returns NULL.
> Update the check to match.
>
> Fixes: 1c3b002c6bf6 ("PCI: endpoint: Add RC-to-EP doorbell support using platform MSI controller")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/pci/endpoint/pci-ep-msi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
> index 9ca89cbfec15..1b58357b905f 100644
> --- a/drivers/pci/endpoint/pci-ep-msi.c
> +++ b/drivers/pci/endpoint/pci-ep-msi.c
> @@ -24,7 +24,7 @@ static void pci_epf_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
>  	struct pci_epf *epf;
>
>  	epc = pci_epc_get(dev_name(msi_desc_to_dev(desc)));
> -	if (!epc)
> +	if (IS_ERR(epc))
>  		return;
>
>  	epf = list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list);
> --
> 2.47.2
>

