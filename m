Return-Path: <linux-pci+bounces-2838-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD5D842D4F
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 20:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B66E1F22F76
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 19:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6467B3F6;
	Tue, 30 Jan 2024 19:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XclzmR4X"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2053.outbound.protection.outlook.com [40.107.105.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447B07B3D5
	for <linux-pci@vger.kernel.org>; Tue, 30 Jan 2024 19:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706644274; cv=fail; b=HmRCGQ5BeXnyuPAqh0MOQPpUPR6Xl9Fny3DL6jlRDA82sZCjTjsKOUJpfOJZcePlO1iVHWAfxD7LfJNM6+w+JJ8CulOu/1vGOSPfm9fvy8RO9LObkq0d/5Jy7lIyK/Qe0jXAe3TAppYoUI3hdqwmtfBtowyp2wiPZy3NKPT5c3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706644274; c=relaxed/simple;
	bh=UFAcgj2vwxfdutfrhZqTRnpmaSEL6nSd3c2lADMokgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=URo0QTLjjtn0cda0mmBvKsOj0P9JazsiyssWq5qF1uLJOfDlCLTh36dcJMi43o0XgeXNisTmJqLNw+Upjwveq1A1WRjKimN3ips8acKYksgCefulbATdWeINIhUikQ0QTMU2RaGUkDnTCFsGblULTNawgPZbQ798nMhsn5lAZiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=XclzmR4X; arc=fail smtp.client-ip=40.107.105.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOqLIOOW+9W+pbaXKADtuLDBCd8nSE+nywNS2M9w6rYMK9d8pcoTZ87wJt2A45QFen4OogTOBX8Gh3E+Bmyi64U3FAgGtDKkl4sYvUxSz70D/wmBLpaUMsKZjHTxO3pGVaVvKLfncOrb6mzjVZ8zO15y/JitmT7P7IEHN7kvIz39BxbNLjd0KmgtAIQidKNh+5lXemK9NLjCcMXxqnV7sJ4ssZ/uZShLBMj7Qzlfblne8XtXLByuFbpsAH92wchmD79iTkR+oQLHN7dXmU7YFNp4bjxtszJ7wGyNEK2VJFVmQAtQXDVbTZ6G/fEsyxgpAga3Q1U/Fu6moVtre6CeDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jmc1xpMm+7RhCM98X00xHz8VQODxYZujuhdB7RWqgQo=;
 b=MUVCl/nzxXXAv8DAuGAFN7CDVhTuNnDTSKuoIdTgyYWMXgQujdWkYjU2Uie1Oqs7hJ2lNSn72PtigetoJBQ+qlbMrL5GyvdKtYBno4JAGlrm1EPNPF08rEILDQfK3pbhqvVZ4K4fF3l8Fnb4F4jPT8txIyPpqEq73D1uKvpeQzpTTbqrdUHwx2Ll4K7tLL67eeQOEf3vgRrQ5OR9km4CnPPw6WwUEmYhtawI/qYKKTBPz4vGA5t0igQaAKyn3GYlajC8Q+d42eswzSlxDIrdmOSjr2Weo0Czq36SVvpINRXR6RAsQ4/pFPpkz3QQJqSlK2b2RiqFM7az9K4cBmr1hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jmc1xpMm+7RhCM98X00xHz8VQODxYZujuhdB7RWqgQo=;
 b=XclzmR4XcXw+LR2RMWReMFYZ9Q3ny2Lfv5jnmMPEdVpe4aEzhVC1IsMaFmmqGG3deXUwre3aNons64z+OZpIyJPYKOwTRDXgNxE4LuNoLXBWhD0WPoofWt7FTGOnGAiFqQhw3+aelLXYoX0Zp3u8TAFXpkMBRQTwOk05VtSl9zs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8171.eurprd04.prod.outlook.com (2603:10a6:10:24f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 19:51:09 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 19:51:09 +0000
Date: Tue, 30 Jan 2024 14:51:01 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, ntb@lists.linux.dev,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/3] PCI: endpoint: pci-epf-vntb: remove superfluous
 checks
Message-ID: <ZblTJRoiu7xmwkmv@lizhi-Precision-Tower-5810>
References: <20240130193214.713739-1-cassel@kernel.org>
 <20240130193214.713739-4-cassel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130193214.713739-4-cassel@kernel.org>
X-ClientProxiedBy: BY3PR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:a03:217::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8171:EE_
X-MS-Office365-Filtering-Correlation-Id: eb5f0880-8365-44b0-fb4d-08dc21ccce15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ord5vkzsqRU6DrJw+4cH2x7zQZATFqV0jngoK3sYOc5FtbuJhX3hQhjp2S4CaeCxP7UPGbAXbsnqX23rLr/C3eVEZb41u6rGPsyQAoZqkDnhC+HT2IGiXN67xLnvCbDymFdKJGw/47gbv3P7wE9XdYmO93GulpNJi7bh9XBGeuwFMlq6XCjpzn+djxuCcD+EwlZNHgKrtkcxmIqMZql+WfFTLi3EM0kX5prp+5tF5pchO9dsR4CRBZJuVjux71LN6ZQu711nlGXApI01bAkQiD0HnihrRRzO2WQ/FslYITZe3yhMpFEwxvGtQxzszhy7ApAcTBuM6kiaK+dyDjg0zRflNd2DP+UFH6GpSs8RPhXAzjTdmN5L/O0iBR/A18kHvnIjdJE4BMi1Hs3BDpfBaoLdPJGWikfUO4XNzPJilqnwRmTt+iKNCx3sPBgxzRydxhnaJd2HAAz66rFBOI6bwNqKOuiHyoKAFGECvot1u9weaIgtmuHWbeqKN5StVU51Pixt9egqo/yPwGVdJwLJ8+T4kqRvR0iEuaJqJcy05eeXqT75Bk4/9Wy9lRoUzjMOXZd81kgnYi/3uMiFZ5fF1FODqgn4gUTe/pkOFFG5rQo2a/7BYY5UtamC2B5Zb/FV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(346002)(136003)(366004)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(66556008)(6916009)(66946007)(54906003)(66476007)(316002)(6486002)(478600001)(41300700001)(5660300002)(86362001)(38350700005)(2906002)(7416002)(33716001)(8936002)(8676002)(4326008)(38100700002)(26005)(9686003)(6512007)(83380400001)(6506007)(6666004)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0HAqpTvwI+FdM7SuHT2NnJAHrmvwkvhew/h2C4B/DwVdN2Zx9B7wIgxu33gN?=
 =?us-ascii?Q?/Eryd1vvNLBbq2sreEcgIYCJURgn0V17P3zBrJClv+yxbgoWoCc+af+XXbXb?=
 =?us-ascii?Q?RkZRWi7ypMBF5vLXJMiO2GIDgX6MFh4Ru/nAtIpiSUNeA0FImorAalR/v3+R?=
 =?us-ascii?Q?vP/3EC3oBSkT6jLcRIFqxDOwPaXslF0S8Wpv9y+wPUhcL9Yd6NOnjHV0Z67L?=
 =?us-ascii?Q?RGeDOmzaYobBSK1OtTEWp/X+DaP0faWIMbmEwKtdBGMMcb5hZFIjpjyNJ46Q?=
 =?us-ascii?Q?C1mK5qn9tXG6JZgC7em6alnaHwBQh8VrLyuG+weB5E2XHmaBf5RB6fCoJ3NN?=
 =?us-ascii?Q?/d8Ch/4V7Ttn6M43YUx5NMD2QrItKZQMwXey4FTzHDSfrFrulP3ktK690Gg7?=
 =?us-ascii?Q?GiBqilrIQ2g/yhptj431CqTfY3aTMAfhdqpBCXCZimgu3vG76n+4H6Ml/x6b?=
 =?us-ascii?Q?KDVriDu/xcodFv/GUB5uPdXJDKoES6OgS/GIpQa8Rlh9hs3tVeqC41NvvI4Y?=
 =?us-ascii?Q?L1jNDALSX8+tdNt6YngDG0UGFVKLNSvAqYW6v6NAVOlI1iOOF+1zBpQpYOie?=
 =?us-ascii?Q?9zdZKlQW/G4h0ltLXO0MJbjt7RTAFDprIBEwkGanNP7jAhpdVeoWSlrY0NnU?=
 =?us-ascii?Q?RzTqjbC/a1LlxBgsOkI6c2khJfyibjEVeN3DGHI79blrD73NEGtUAj0tvxjt?=
 =?us-ascii?Q?amGDA1NzySoNJO20awNwWKkXJKmfv1lNizDMXmdlTBZGP4yqT1AVTIMqHLpW?=
 =?us-ascii?Q?fY/DaHnzLLc+3ayd4HkTl4lOaLvtF4kOj34EX6ssBGrw8E3xYi+/ci1pAMJp?=
 =?us-ascii?Q?V9PQyJCXKIGyVEJUx0T/pWgY422qiLo6lSZ9CIHo8ir/PuVav7ofivqIBszg?=
 =?us-ascii?Q?l+JI9dq6rpvrcTt+g+K8hLMziH3p4Mg7/YhHj0h3q91907uYDGPEV+SQ0Ojt?=
 =?us-ascii?Q?UkMFbh8KrbejB+v4LvDUbiUj3PF5q87xJtuCjxLyY8/1PASuVdVc+UYvDOlK?=
 =?us-ascii?Q?s/lIU9VXX6yK9vpducyPLpcKWn35utw93eF2vdcK2+YI6206ZRdH3JdGWD66?=
 =?us-ascii?Q?/ZVYqiV597qaRL9XOCputEbkpJOfwsAkWERsiOSWCb/b24DIWWiA7hJyblmp?=
 =?us-ascii?Q?ZzHkgC0CqcNJSvLlBtXHWC/sr4kvpsd0B933BH5Ttm/x0cxcSdAG8MgyTblC?=
 =?us-ascii?Q?b7mWI4Tvwr9hJOleZH6XQGKFcFzRhbkPFAJZ6YgeHyHW5otRkHzMYm7pO0Ep?=
 =?us-ascii?Q?1c+VVWdGSBD6AbRSRJJApXON8dNzX3GXkv/exM/065wVp5qoYjEm0rnJDBqy?=
 =?us-ascii?Q?32E6kBdNiis1lvdL09C2s08xDq6a/kO4BcBHeccchN8JNhq4FTamx4Bhjxh/?=
 =?us-ascii?Q?/3U+iYZZfN6Nb/555zOq8GtAT8pQQt86sFcUla/U2WLavCMQd9Kc8mXH51rI?=
 =?us-ascii?Q?Vi/Og59Iaw8WXrDWy6j6gU9O7DgwH9GmiilMubz9/qt6yKP0nkAqQQM+MdYb?=
 =?us-ascii?Q?KUFOz3rmBowmWtTc3+Zx3ewLbQZn3gj+95DGwVwRt+o0NhBNiAjo2Bqs2D5I?=
 =?us-ascii?Q?VCMWuPwzx2XGgKLIiEvx4FUeO0QbKUGreeNqX1BF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb5f0880-8365-44b0-fb4d-08dc21ccce15
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 19:51:09.5661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f4A/6ZkNEZ1a7d1l18GinSXEi8kA5aYczLBDKauO4oBf0Msb4ZVSCYFvpf4Rjrs8r3143ayKBnIVw1yq/TZU5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8171

On Tue, Jan 30, 2024 at 08:32:11PM +0100, Niklas Cassel wrote:
> Remove superfluous alignment checks, these checks are already done by
> pci_epf_alloc_space().
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index ba509d67188b..eda4b906868b 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -527,7 +527,6 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
>  static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
>  {
>  	const struct pci_epc_features *epc_features;
> -	u32 align;
>  	struct device *dev = &ntb->epf->dev;
>  	int ret;
>  	struct pci_epf_bar *epf_bar;
> @@ -538,16 +537,6 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
>  	epc_features = pci_epc_get_features(ntb->epf->epc,
>  					    ntb->epf->func_no,
>  					    ntb->epf->vfunc_no);
> -	align = epc_features->align;
> -
> -	if (size < 128)
> -		size = 128;
> -
> -	if (align)
> -		size = ALIGN(size, align);
> -	else
> -		size = roundup_pow_of_two(size);
> -
>  	barno = ntb->epf_ntb_bar[BAR_DB];
>  
>  	mw_addr = pci_epf_alloc_space(ntb->epf, size, barno, epc_features, 0);
> -- 
> 2.43.0
> 

