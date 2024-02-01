Return-Path: <linux-pci+bounces-2947-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD42845E1C
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 18:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B68D328CC99
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 17:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF5F77A0E;
	Thu,  1 Feb 2024 17:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="J4a65d5D"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2056.outbound.protection.outlook.com [40.107.21.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC3A779EA;
	Thu,  1 Feb 2024 17:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706807318; cv=fail; b=JknU4u+C5jxTxqrus9vS/ULuYpAfmkT1zPkN+eynIeugcQV+tFGnBTJL0uFEoxF0kuqSvppkatxRmfbCflOwenmELa27woZJ4Xpx04xIYEdZ9TIRtLCqCCP3dX1tAkbn5SoqYoP+f4qNFCl2uZpsB7oIYNRRWj3RdmOTWvOTrcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706807318; c=relaxed/simple;
	bh=b1WRXy2hwGFnnQ5APTHJuijCQSKl/LT+AP/x8/2f8m8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cEBi1qnkSuSxk5umsJaEJEhXbxrGZqyALkiAqVEbZ5SmxGnH+TeB8tM/PnZwZPdN+H6zF4sMWRyyG91AMKnhoZ/XixAfF1K2zPyBkQOcln3P0YCtFdlV1wrc80H40VzeyZAIQzuuZrPTtvN8JL7GzU2QCAzmppm9DIcdV4MCO1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=J4a65d5D; arc=fail smtp.client-ip=40.107.21.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqPhCBLYgMbAEEgxJK/7iwkhP3kBeqf3iWk8pAbNOtBvDEU9B8JoXR5TLLP8BM50yGH/r12tG1i2dkfuP8SXJhCkz9RW+3p9sJXgZRtHdLWOMT9w2B8olCWlSMRhjCzOaO+/u/OxdSD3XU57M0YL8XHuQQmQUvxbs6I4tMoYC9CzepbqUJ+8pAj3erj25xakOn8Rkv+WOHiCGHHRAq4ocaiqv7DW0tQCiVEsWkHTubgOZmWPmWiOR3bD97zhMrXaLHS7djXcVGatOvLgvJ6auB01fqq2CggrP0koBd3+S+PkPuPq0FJSunqg5YCLFYwA/GG7PVPoLxkiZ2ObHx0F/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JkUTov6dXSymkaK45c4LgQD+rDZuJ5FLSdbi6L8EjfI=;
 b=FyggJTss0FFJPxfI8IdGnHFaOWyEK4FH0Wa34EbrZ7k7kqBAqzth+ragg5q8cBiu3hbrcdZrCy4B3dd+f3Y1gO4fE97OVeOGMQ0xCuKW2557VYQKCfVz0rk0Ox66+gG/K1nJJ8qpMyWt1ixqPL56+Oi7pJIk9TRAKJZLZrdqjq0iU74GdfRct4p3NTjokMNbHC7hs+VimBeO+ArX+HTi5Nwfh5NzebdiGrXOrEmG8dWvxtXeTl2GVz2HuDVPk70nE9qRk0B45ucD/Qo0E+BBJhC0ksLblf2QWyYZ5DcEdgJUEmot5IEQR2L/4qvQsf48R9+g5Hij262Wj/8wX8wREw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkUTov6dXSymkaK45c4LgQD+rDZuJ5FLSdbi6L8EjfI=;
 b=J4a65d5D2M8QA9T5xVVV0ktxBKNmpko3D1FyvunL6bstfghOeElBTXNEPMlwjbIC8syVMwOAV53iEY9y6MsQmc2ewCPge8yxuvCtiTaEO7wBxo5g2XkVXWF1O+Pa3rjcvSniL7dOlkN2PZ2aB/S33/yU41gX5GxHcOtezP5Obws=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7627.eurprd04.prod.outlook.com (2603:10a6:10:208::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Thu, 1 Feb
 2024 17:08:33 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Thu, 1 Feb 2024
 17:08:33 +0000
Date: Thu, 1 Feb 2024 12:08:23 -0500
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, devicetree@vger.kernel.org,
	gustavo.pimentel@synopsys.com, imx@lists.linux.dev, kw@linux.com,
	leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
	lpieralisi@kernel.org, mani@kernel.org,
	manivannan.sadhasivam@linaro.org, minghuan.lian@nxp.com,
	mingkai.hu@nxp.com, robh+dt@kernel.org, roy.zang@nxp.com,
	shawnguo@kernel.org, zhiqiang.hou@nxp.com
Subject: Re: [PATCH v12 2/3] PCI: dwc: Implement general suspend/resume
 functionality for L2/L3 transitions
Message-ID: <ZbvQB/X0kwFs7nAb@lizhi-Precision-Tower-5810>
References: <20230821184815.2167131-3-Frank.Li@nxp.com>
 <20240201165025.GA637154@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201165025.GA637154@bhelgaas>
X-ClientProxiedBy: SJ0P220CA0028.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::11) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7627:EE_
X-MS-Office365-Filtering-Correlation-Id: 150c65e8-bfef-46b1-65d8-08dc23486b99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LhrjMkpbf5OWcKeM6CjN2SOc4V0aPbJcwyKqealkaqq/PIvm898E/7OnCDFjnKsCJralSQvN6An4VzBVK70HF8Qa5evVCTIKaoMlWHKDCL3CBR2bPzUQeKRgf/J7aa3DVeKOPOhmfD8wJHNF1/ltG/MaI9IRRZ0tB+mC8SQ68hBALSo8hw1QVxKkEHzPAZD/X3Z79QdPHf6TdAXKq29cmblHNC8WazMTRSEP0m3qCw/qa1wKjNfeWV/NVrgWS0mw3gcOoht6VFBn5SuhD8CyAms+5eLNY5k4+IEBSa7SJz6xNxxH4n8L6jVNewh8k19fZjmjJ/fEfQV/k9BnvOxdC1yFszNrsvKfWnhHFGbLoM38EuF2+MthaZNzTY20NfyBfscUj2P41ubFBi8MIDuIxh5qypxqj6rn6e3RAf33FgQAC9PxCtSagd3UANZMubYqKAAmtefpfz0KWINfzH+phRvcoZMexoleN/jeW2rK3PwO9VYVfq+G9b1S7624i1K8oWbaxorLL3dm9+UkmJxyV1FLO0kYzGdw3pwdIKJsT9T75KdkdIU+LUI6sow6Ndk3oGiHhHn+nX630Y6MZjWDwK+4qw4q18pcQvMMr2R3Jys=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(376002)(136003)(346002)(396003)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(41300700001)(83380400001)(6512007)(26005)(38100700002)(9686003)(33716001)(8936002)(8676002)(5660300002)(7416002)(4326008)(66556008)(2906002)(15650500001)(6486002)(478600001)(6916009)(52116002)(6666004)(6506007)(66476007)(966005)(66946007)(316002)(38350700005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7Cd8KUUzGhnLZC3pG2FZ4JwEqZT89AmZZ7IqIWI4YGX5/OVTgWP4B29FKcHR?=
 =?us-ascii?Q?cWLpw5ko53rwgylmRbGh6FEAAq36fAho5Kd5sgRH6o0R5crmPojC2lWogWXT?=
 =?us-ascii?Q?+Rmh8sciLpw6CUOABn/kYB39Pk/77CP+OADoifN5ZRxig8X9EaVsCv7fY6T1?=
 =?us-ascii?Q?yUOei8+U4JXyD4kPhgmWMmFVFkAWgy/TN+VQmp9TqGY1W8lzc+8MpfeRmRgH?=
 =?us-ascii?Q?AN1A5O4nGCjYrofk/Wjq+QVsAD9VDMqa6GYjFN680UctzzEjK7CqVzz1eKev?=
 =?us-ascii?Q?VWri+NeZz+1xJhB4Ncifb0GPhyetSVcNe8fLH7Wa+lYTl2/2a6xnsLvCt1bz?=
 =?us-ascii?Q?Fm0J4d6dX3fwSarWheh4XJA4/aWroyhK0ve9J6Axk7/zvrzhFf1rgiG0W7UB?=
 =?us-ascii?Q?mEzfiJZGnyOMMTuS2/6AD8M1wxqqryBAgjrD5e4KalpGbJQ16KJrpTksKIL4?=
 =?us-ascii?Q?HhwM9dg5C0hCDjoRLOs94gl2TxlnWKJtfnAI92pMxb6Y6j0TDkXiMLl9qGJL?=
 =?us-ascii?Q?uUWSHR9VsCVjVg9fyLkGT36Fp3UIV8bIlzP2AqlsbbY8pviTgI/E3g+aC3uk?=
 =?us-ascii?Q?ptecuMA7NlZo7d1ySBL5JuXtD22wwjJo6ixvDJShvRmaUXUOpybB8A+F0U6g?=
 =?us-ascii?Q?Ewc3UOqdhPtoD63J2++i/eX/LPl7w8a4pMaRw37PI11F9YbK9nxBw8patZ9E?=
 =?us-ascii?Q?xjtgVyH128+Iw2nLNO9EIxBEuoDmkg8GY/uXp8/x81tbkshaR3PsnD94pAnF?=
 =?us-ascii?Q?RJyQ4Fll/i0SJr9dBm1okhRXca4o+oRBmqLanLwUJLvAH5G7CE+LzKTEBXDE?=
 =?us-ascii?Q?XyZZ/xq5SKO2SSOSrJzEJsYHMXCpUIrM5c7nL+kKg+BM1DcdzlQHVZQghOhw?=
 =?us-ascii?Q?pUXJt2OA3T0N9vfAMPSG23hKvGNcnWn4+uSK+VTahH1UmMRsx/HbCG/h6fuQ?=
 =?us-ascii?Q?qvMrJq9hn3Do68UYKdw+vwWnWlHPKA7AZodn5fS91FGPgS5gksj0um8Bqdbe?=
 =?us-ascii?Q?Y8XXRYB7I6Yp7sjruWWBLQ+Tf9u8iniBjn+UdsJxdZ29vtSenakUZjIjuNFh?=
 =?us-ascii?Q?aNztOQgyu8SCSQmuA6CGb4YAfbWSj/dCHp0awjyy4CsyWBi0SWUy+bg2EgZL?=
 =?us-ascii?Q?ik+c37wjk+0pGK5k30XGP65zhiAP8NOCQ4DKx1NKUlwDQ3vthUPK+t1Fz73Y?=
 =?us-ascii?Q?+U/g8KCuX6tGkU7yjOrfgnkr3I1UDy3Wtx4L3pPM3O8oi5FVKRjtsfS9eU7i?=
 =?us-ascii?Q?HQv/ySJwuh04etB/g119epf8ealCw9epNU8eiL24VEecFvpCbAF7iaD3CwxN?=
 =?us-ascii?Q?vV19v/0ZXe9GZMxNcBfqL1j1UTvGghhh9E0BRqY2OJgp6EDkJ9KTrZ/5QwnV?=
 =?us-ascii?Q?KzcvcZuMHUWDH7BzKVaEZzplflEMzOKq5lkozQF1VrUGEIYfs0onjUh924wb?=
 =?us-ascii?Q?zAPwOXcHyBTN2e7UbfCVXVWEWlzVBbJAsFLsLMYDBuJRczNMLVR5sLOvrdT+?=
 =?us-ascii?Q?GG4WZVIRv8YbWlCRMj1AEx4oSZN8eQX6UlsNT+jmvldvrNBEp1kDXoKn6HNd?=
 =?us-ascii?Q?YJxpYO2WSb9JfR3LT6NmSHiATPgHSLvJPGRGCZyn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 150c65e8-bfef-46b1-65d8-08dc23486b99
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 17:08:33.1098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9gDgkk9zCI81KTM0SBY+cQ1amirO3uSGEJuzE8jpIjocP5IK045BbXR0aA1CEwA6VcJQCef4rXFDkVWp3xURTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7627

On Thu, Feb 01, 2024 at 10:50:25AM -0600, Bjorn Helgaas wrote:
> On Mon, Aug 21, 2023 at 02:48:14PM -0400, Frank Li wrote:
> > Introduce helper function dw_pcie_get_ltssm() to retrieve SMLH_LTSS_STATE.
> > ...
> 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > index 615660640801..91d13f9b21b1 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> 
> > @@ -364,6 +375,7 @@ struct dw_pcie_ops {
> >  	void    (*write_dbi2)(struct dw_pcie *pcie, void __iomem *base, u32 reg,
> >  			      size_t size, u32 val);
> >  	int	(*link_up)(struct dw_pcie *pcie);
> > +	enum dw_pcie_ltssm (*get_ltssm)(struct dw_pcie *pcie);
> 
> This has already been applied as
> https://git.kernel.org/linus/4774faf854f5 ("PCI: dwc: Implement
> generic suspend/resume functionality"), but this .get_ltssm() pointer
> doesn't seem to be used anywhere.  Should we remove it until we need
> it?

Could you place hold on for a while? I am working on imx PCIe. One old
imx6 may need it!

If not, I will submit patch to clean it. My new patches depend on

https://lore.kernel.org/imx/ZbJ+tFPn3aOYHCwf@lizhi-Precision-Tower-5810/T/#t

All already reviewed, could you please pick up these, so I can continue
my futher work.

Another
https://lore.kernel.org/imx/20240201-pme_msg-v2-0-6767052fe6a4@nxp.com/T/#t
was under review.

After these, suspend/resume will become simple and common for all dwc
platform.

Frank.

> 
> > +static inline enum dw_pcie_ltssm dw_pcie_get_ltssm(struct dw_pcie *pci)
> > +{
> > +	u32 val;
> > +
> > +	if (pci->ops && pci->ops->get_ltssm)
> > +		return pci->ops->get_ltssm(pci);
> > +
> > +	val = dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG0);
> > +
> > +	return (enum dw_pcie_ltssm)FIELD_GET(PORT_LOGIC_LTSSM_STATE_MASK, val);
> > +}

