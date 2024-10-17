Return-Path: <linux-pci+bounces-14825-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC709A2DE8
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 21:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7528C1F210DB
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 19:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B851DED54;
	Thu, 17 Oct 2024 19:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="F7Yiigpn"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2054.outbound.protection.outlook.com [40.107.247.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895381DE4D3
	for <linux-pci@vger.kernel.org>; Thu, 17 Oct 2024 19:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729193816; cv=fail; b=iqeyc10PFV5PcMiqA9tavfPXrMycOEQlP/0Ex3KueS+drlLRsStzb+qAlCisynE4ZHxMT9RwRiPQxjjbCHQ6WEFIrSatVsSVn2FPjQfjILl7g3NRlCEg0pqUqfeTRFiDG3AT2tm99oEhYtj3xmmkbFcPvNd/bu9MjOpJQiAbPXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729193816; c=relaxed/simple;
	bh=/OQvg/QppF7t9ECuHfeQw+a6eUdAy9Wobn3jvnUyt+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TT67zEtkp+m3oWqmhS7H09ArknsJgobNAa/vK8UTBL5iZEZXuzeMDbJoxjedn7U2wYmkKTo2tUICtRnkQ4bk5UKpAktTDlGO3yiqdkrOSSxWoVjshmSXPUamcml4P/OBKhyA9ALdkY+s4D5KjT3fFN17FFH9GJolc4WgzcuQJZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=F7Yiigpn; arc=fail smtp.client-ip=40.107.247.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VAD8PltWBRNSE0mWNnux+Ygrqp28tG1vI60lL6xCiN00icU63BzK1FPS+DaWL9oVH+9VJGRzcQolbyZkthbVnA9jzBL0z5iehHwekVYDIfgq440SSwTGA58x3el5RvgP8AFgSNz3/oj+hAgqM7pEhm1ofEIdw5a0IFP3E/5DPtNabLd5kQ+O5ufOGF61HrR2DACQN5zkqMfzvvpoU4791QU/YGN4+qENR+OGUxpUgu/gS0aNtOFwEV2fW5grzjCofZ1clYGHDS3HDM/xmlwc0f9RV89PTslSdj5n6QOE/En/SM5kiPeWcKKYVop4y5MyrBDg340KNYNvIy/6dvCA9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pw2CQA2TGC5stj7hIYQ27ZqeJPj1mr+9gObbQuKCl3Y=;
 b=jzai6uBfznTRTaZpTGTp4f/ifmXw/UAMQp4owHGhW2NnndE1KyNBxpFWFCYgtMxkqX8ncXzNjPgs5CDPX6QPw4zj2Ke6VsN5hh3h66rx7NCZWCuSzyv/yLIGpok+AXbxRp2j3QojOgSkY0BLeiQuDCh5tgYMKtMmuCCuteKQeMhKDFq9IRdLTnT0QqZ4pb9GpIiZbkAu66bIb8GSLuFXzi6rjXDr/4MGn4JYnURdt6aJeLp19BVNTyhIBCb1tL4uqOlJ16bfCiddyOtlzvgH/P+yquvkRNWhUlOLIp1ZhXz1Opil+ZDctlY+2Gqjl+qG+c7EJML6V631QFNYzoi25w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pw2CQA2TGC5stj7hIYQ27ZqeJPj1mr+9gObbQuKCl3Y=;
 b=F7YiigpnxXUt29d0xQsf87nAO5pQwRZoieSC9q8r1UyU6C7tAVHQ6XWCDApNiiLkpjsTfhv5JkyrU5Ft+rNO9DV1j3cb2oESWJAAKt+LwpEOYLUZ7TONIUbc1xKrJA2LG/uLgYs3PJ3DjK5K+2kPq1hGqIlNGYR4CMJ8EFeS/L4XyEMwIQmXGC5hlr/Vt6fRa1314TO7KnQdmDvROJ+JM5mw6DKsi/qAWg+8BDqyAbPv7Iy7GSOimbNE0q+6YC0OKSOqVUXsgGHURw/cY+wXrn8GZ/SxUL1k3ct2MGdb1ROHE9ymb0cykviMtS/FThhKJ8DVK5As8yPdLytyIAVkqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9915.eurprd04.prod.outlook.com (2603:10a6:10:4ec::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 19:36:48 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 19:36:48 +0000
Date: Thu, 17 Oct 2024 15:36:40 -0400
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: dwc: ep: Use align addr function for
 dw_pcie_ep_raise_{msi,msix}_irq()
Message-ID: <ZxFnSLHwKGrxzYZi@lizhi-Precision-Tower-5810>
References: <20241017132052.4014605-4-cassel@kernel.org>
 <20241017132052.4014605-6-cassel@kernel.org>
 <ZxEvFT4+X35/NxWn@lizhi-Precision-Tower-5810>
 <ZxFdSSqbefIiZLN-@ryzen.lan>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxFdSSqbefIiZLN-@ryzen.lan>
X-ClientProxiedBy: SJ0PR05CA0104.namprd05.prod.outlook.com
 (2603:10b6:a03:334::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9915:EE_
X-MS-Office365-Filtering-Correlation-Id: b786b25e-5f3f-4d00-e6f5-08dceee30a79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A68wDL0IHgPOVRsPAXI9mwc1lloZDKCtUZPScmAzVzS7nG8BLbGtfcS22f8p?=
 =?us-ascii?Q?t4S29pore/58sDhwmDPVfvCHo+irpatOht7827G5daJVz/dhk94iGwdGV85P?=
 =?us-ascii?Q?VSIhX7JRTLwkLy2G/z8u/V+v8Gb9vpdnjVzKmb9NbWO2jbubhmi0Wj5VZZX5?=
 =?us-ascii?Q?BrDmYbF3Lh351mKWrIK/sORdJZ8SadzSNtNOed7T7Jc3c+gZQUxBxx8qwVRC?=
 =?us-ascii?Q?O1QqjrWDSt7GVCAdIzponb6DAqeWixmyxb+isft6P3+8Mz6Wq98QhCuIkTsH?=
 =?us-ascii?Q?0yndc5hHly14kBoi0Vy4808cC/ahYY5imeEUzzfY5MFyLjYQVb2UHKx8TvNh?=
 =?us-ascii?Q?pLeJZMfp8I4j71InT3C0MxiGcrzl+BL0THOvsRIHOFOlsauxHgJKbAoqV0dH?=
 =?us-ascii?Q?nFoqwJsOcGckF/NIxKpKQR+bdtPpzJseaiPGsFs+I9joNbJWlZUziXDHrtxb?=
 =?us-ascii?Q?/114K/wzZXGvNbwiXHTYxk1Ob/p/KPXMmQi8D3a/iGpQFze+HIxzGk95UbBp?=
 =?us-ascii?Q?VmxwCelCxvr54IqAz1Wqbnedb1xOkmFAJnfkEMU1A3b3m6pyl1DouI9pFI8L?=
 =?us-ascii?Q?hirhdjrWOgotQ1mdXI/fGEts+GHrzgUBYsS+WEjeat5ZV5LWnn2N3vtv07fC?=
 =?us-ascii?Q?Q9k6vCQGjj+qS9M8EE46q48x6u7HULKq5o7emncCiN0oZ1ErTfK10sW0tIcx?=
 =?us-ascii?Q?vhMYE44Uh9/GRVyNuxSzne6SRK+cRvTDsGwuVc6hEsUhYLkssZQW8xyDrrp8?=
 =?us-ascii?Q?Xvqp2E0L5x+6XeJpGm/cEXfm4u18zO5lMvSsUPOwkbOTM1phPF9qzQ2FAR78?=
 =?us-ascii?Q?dbVbpZzZx7xxgzJum+pE3x+9Ux/X6SzwhcFvhsUQp3I6zE34Is0j2acTCuKz?=
 =?us-ascii?Q?8yh9QDrnvbOT0rqaQu3+xpJn6dC2BzXM4kdvZzLCCPNAjKU5Zx7K5IulJ2BE?=
 =?us-ascii?Q?s47ewFVYZh98Oiw4SWoQVzmR8OuPNnvUr0C3rQpuKdPleHaMxCazRUd0UNpa?=
 =?us-ascii?Q?aKw0bvmO3mkFVe8jXdaDqxXRxO1BJJnqgf8UERD/+fZVHz2cmo6QteSP5/r6?=
 =?us-ascii?Q?7T1lo0TZDLyAfbNnbPW6ByXI2IsKFoNoTfzl8bGl4LvGl6mv7xXPWKGrExsB?=
 =?us-ascii?Q?g+gCP1G71C/lKHZv0q7nWhaAuZx0+BSw8irGMao/mAdiS62Uj6SC3V+aakf+?=
 =?us-ascii?Q?naPKlPum/ksXc3Ges0famYrIsRJRLNlHGjR4uXqD4faGofqWpPLdvjqAZmtw?=
 =?us-ascii?Q?fG/2wQLshU597W4c0XbX8nDeoZqWrRGfuLHXBYvFbT0pQpCpGgya1ZY0MByo?=
 =?us-ascii?Q?zx4Tj9vz3XAmVj+9fdqVNe+tqyUcwr2DrsR4J3QpOZd9LUeIgKsY+MY7KTXx?=
 =?us-ascii?Q?0NsiDeM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4Jvqcqskxl/JqVF5k1xLKd34uyn2v4ablx0nR6GpJ8l8SshQZoja277vr1GI?=
 =?us-ascii?Q?wW0e4jL2tUw2JBYVx7l2HeRouIDJ3yWjP6lc9JYcJddQeycls0t0Yp9ID+o1?=
 =?us-ascii?Q?F0UfQWn0Z0huUVnupC/TIzSbJCRtw5RymAnaorzApVfJ4qd7bSC03eqeuo4A?=
 =?us-ascii?Q?ilDnbeYUejUdzXtoh7AgMAzoc0oKdny5EGzFcyxg8bBRBpR1QcelE8l/cG+X?=
 =?us-ascii?Q?snq5dzxmsxeU6hWS8F8fmK9BJVCWd9GBFu/cw/t7cnl4EqdOql4x3uWnBoBa?=
 =?us-ascii?Q?FTGvd9JdALn/C2P1sH/uDKLGLDdR1IgY03C1P1IJZ3hqBQwOQEnxijsp9JW6?=
 =?us-ascii?Q?e5bENvW4iO3eqAqSVGkTqH6dFg0JvgMvbx9u+8C4ovHB8VJUa6E5+NW+M2y8?=
 =?us-ascii?Q?l/s/jnGoef0t9pl748N/n1EXTuCzHZi22eIVAwKLk3Qu3BphZLqatynn+FRP?=
 =?us-ascii?Q?5KgREmgE4ox1A6yaVEIpZe2d6uuxRgI0i43o0Ve/qrsSzPj9GK+cB1w5Z+wo?=
 =?us-ascii?Q?H4vDCi94QjNidL3xFeQ7NQQfi9/nnOE+FUECframAl1MxEAbtgt4cqVldH7G?=
 =?us-ascii?Q?pMGN1ARZOVYAJk8W+L/93CYKVX2M9eyueGlKvzFbDoo8g91khSJU7V5NfwfK?=
 =?us-ascii?Q?T5W1gmXYEr1f/9kDnUuHCCLa4Z3aPP89fI+pX9qEkSokcNbGSnG8bBOjc0XQ?=
 =?us-ascii?Q?tkSmnCToqwLyDSKArO1f2HH8wOn0CXZO3z8zjTkkDr9O2aSOCyMdcPoGd9Ag?=
 =?us-ascii?Q?1JsbbR4UDvT5B0C561eAtIUoSiZbNyjy833WNEn+EgKnhP++Cul5ynwnEPFh?=
 =?us-ascii?Q?mL8pTHDdirOKZsIdd/aV3pND5hAbvDPx2kk9BrU3NF3/cDf+CemCk2rJIIju?=
 =?us-ascii?Q?PiBbQfZ4OeX7qhvnTUz3JDvj8VE7ttkh1d5XQTGC7pS7m45ydBjxY/reCzhA?=
 =?us-ascii?Q?uWYU3mKDuQLvfsLvqNgw/qLmIiMis1rGqgYhdSDot5Tignw/LLG4shulBfGE?=
 =?us-ascii?Q?GwcL0IXYgCZop/3GdRg+GBpwaN0RPPbqmYQA2aWM3HOO46xqBG0mOiRxxlNv?=
 =?us-ascii?Q?lmC5Aph0sXXEcrQPj6+ZCqPA+QcxRzOcytdvizr/E3JBsqmc/7JUd1r5FJza?=
 =?us-ascii?Q?Je+FXCjNkryix7k7Y5lXL7k71AxGA5xD3YGSiNqYqgbEi9mrZD0d+BiTjSU4?=
 =?us-ascii?Q?DC7JnboW9HkisJEN7bzPCvXxn4wSKfLl2AqO9b/tkI6NZpt6UePPyu3eWG6r?=
 =?us-ascii?Q?H0Sk2W34MQs8QDDV2wrWHyW2QE3Z2DqWCoxkeSHNC4GZAVPtEbiKAM5bZh8c?=
 =?us-ascii?Q?vgH/vjbToYc5y01W2rtyO/yHXp+hYyBQi9/8VzxmTo/gGvlFGiCfI3mTsGyT?=
 =?us-ascii?Q?cFvNMQaWa6oO753XBxovPxqa6Nq2dyDPufDSZdkbaz3EeQSNZojl6xA3bkVf?=
 =?us-ascii?Q?LblSTzy6kJbxlOfDsIU4pS2Gi/WN+UnKivie595DU6SCENiXwuZr8fIhHGYz?=
 =?us-ascii?Q?uFVWK2prwJi2k3+C2lDb9PRvAYUzYYQVCSdsWYPa+x0sTPSPWkwKqKacfNNt?=
 =?us-ascii?Q?ODkrPz2uuVFPP/3IVLbcRbJxa9zWMMOW/JMpZ3Te?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b786b25e-5f3f-4d00-e6f5-08dceee30a79
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 19:36:48.1485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YE5IhofrIL3Q6h0rcxCXDN8s5AxA345SnZ/sxSH/DylR13i1Zi7iEtxjUBGqQ0Aen8njuu+spC3vVxo7rFQNRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9915

On Thu, Oct 17, 2024 at 08:54:01PM +0200, Niklas Cassel wrote:
> Hello Frank,
>
> On Thu, Oct 17, 2024 at 11:36:53AM -0400, Frank Li wrote:
> > On Thu, Oct 17, 2024 at 03:20:55PM +0200, Niklas Cassel wrote:
> > > Use the dw_pcie_ep_align_addr() function to calculate the alignment in
> > > dw_pcie_ep_raise_{msi,msix}_irq() instead of open coding the same.
> > >
> > > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > > ---
> > >  .../pci/controller/dwc/pcie-designware-ep.c    | 18 +++++++++---------
> > >  1 file changed, 9 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > index 20f67fd85e83..9bafa62bed1d 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > @@ -503,7 +503,8 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
> > >  	u32 msg_addr_lower, msg_addr_upper, reg;
> > >  	struct dw_pcie_ep_func *ep_func;
> > >  	struct pci_epc *epc = ep->epc;
> > > -	unsigned int aligned_offset;
> > > +	size_t msi_mem_size = epc->mem->window.page_size;
> > > +	size_t offset;
> > >  	u16 msg_ctrl, msg_data;
> > >  	bool has_upper;
> > >  	u64 msg_addr;
> > > @@ -531,14 +532,13 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
> > >  	}
> > >  	msg_addr = ((u64)msg_addr_upper) << 32 | msg_addr_lower;
> > >
> > > -	aligned_offset = msg_addr & (epc->mem->window.page_size - 1);
> > > -	msg_addr = ALIGN_DOWN(msg_addr, epc->mem->window.page_size);
> > > +	msg_addr = dw_pcie_ep_align_addr(epc, msg_addr, &msi_mem_size, &offset);
> > >  	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
> > > -				  epc->mem->window.page_size);
> > > +				  msi_mem_size);
> > >  	if (ret)
> > >  		return ret;
> > >
> > > -	writel(msg_data | (interrupt_num - 1), ep->msi_mem + aligned_offset);
> > > +	writel(msg_data | (interrupt_num - 1), ep->msi_mem + offset);
> > >
> > >  	dw_pcie_ep_unmap_addr(epc, func_no, 0, ep->msi_mem_phys);
> > >
> > > @@ -589,8 +589,9 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
> > >  	struct pci_epf_msix_tbl *msix_tbl;
> > >  	struct dw_pcie_ep_func *ep_func;
> > >  	struct pci_epc *epc = ep->epc;
> > > +	size_t msi_mem_size = epc->mem->window.page_size;
> > > +	size_t offset;
> > >  	u32 reg, msg_data, vec_ctrl;
> > > -	unsigned int aligned_offset;
> >
> > why not direct use 'aligned_offset' ? just change  to size_t.
>
> Because I think that that name was really bad.
> aligned_offset sounds like the offset is aligned, but that is not the case.
>
> Now when we have a dw_pcie_ep_align_addr() function, I think that simply
> calling the variable offset is less ambiguous. Anyone who isn't sure what
> the offset represents can simply read the documentation for the .align_addr
> endpoint controller operation.

Make sense.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
>
> Kind regards,
> Niklas

