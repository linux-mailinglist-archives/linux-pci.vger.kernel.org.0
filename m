Return-Path: <linux-pci+bounces-1830-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C86D282767E
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 18:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CA512817B7
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 17:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098FE55762;
	Mon,  8 Jan 2024 17:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="elxmJGlO"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2089.outbound.protection.outlook.com [40.107.21.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B64254BDA;
	Mon,  8 Jan 2024 17:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9MHISyJXrwwcvrGrfmqrbdl6vNJnmgfg/9LZAkIiRQsnzRDQzwl+Go8XxXkKeKTXHahUVPclptFgr7f0ZgSxaG++xf1K0Uoy6TW1UKvocqFwQ4nX1rqUXAnxC+8FtE7FbKSIf9ZD8XdYkXquoJ3CRIcvJeg7egFDn41ACNEtkUeK12RtJGuGC/UPEBomfBVDhKcwdZwR3B3VcVltBBBC6JGiOqL6v1Whi/Cw4YkQQnMoRJcRyZIZhn82PhjO+miHge5n6bv0UGHdU2hjziS+NARdbPUt9YyAPWfBxjyaBHPsT1xwO8nQDtPfxj7nYCEogQMmioHwiVmIGncq9W6WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56vnYMKNiQr7NvQgjdpS/xLCmRc0c0wLoz4Mn8rc8uA=;
 b=g0JEzatZkSTTevJjS92mVuRvXLBKawjDLZj8BEypNPWdjicCXFfxQO6y428AVW+y5u1DUThlg8+Z8a2bj1ImO+bm1UzBojjfX3prLbrIHK7ubmcT0V4L9i2BmRk3ef+vV98v/52BBcEAbsky5YNbslGWl99tqVChkh9Ah23+yWzM5z8/afB/jrCcQ9BL+M+2Po+CTygXTrGKky3Oldgxlf9thT7siIO8fK+bHNfUX0bkcU9Qgs9jCdlCbw6AaGdgn6+Bs0xe1UKsVsGHV3T8aqzqLWVoEymDM5dYiXNEAjXQ37jIxhqRtekXd8Q+xrOOFjHgSskCfeLpyQt7SZ4row==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56vnYMKNiQr7NvQgjdpS/xLCmRc0c0wLoz4Mn8rc8uA=;
 b=elxmJGlO4gh4bNR4mTE8RFJ1gTyjR+5FYWZv+fhaybmDo6w8Hd3yHDpmF10VXgp3bzpkyCW/Q90fr1sJHKpGeISv3K2vJMVpqSo65QICgPwmMi6hhKVKbET4m38CfcBXzpZ2NcUXZ5lTCmVEO3XhVRcXkHvcZUH9jYKrtdS+vtA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com (2603:10a6:20b:23f::5)
 by DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 17:39:40 +0000
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469]) by AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469%4]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 17:39:40 +0000
Date: Mon, 8 Jan 2024 12:39:29 -0500
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: krzysztof.kozlowski@linaro.org, bhelgaas@google.com,
	conor+dt@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com,
	helgaas@kernel.org, hongxing.zhu@nxp.com, imx@lists.linux.dev,
	kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
	kw@linux.com, l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org, robh@kernel.org, s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: Re: [PATCH v7 16/16] PCI: imx6: Add iMX95 Endpoint (EP) function
 support
Message-ID: <ZZwzUXXIBsTPVPX5@lizhi-Precision-Tower-5810>
References: <20231227182727.1747435-1-Frank.Li@nxp.com>
 <20231227182727.1747435-17-Frank.Li@nxp.com>
 <20240107062654.GO3416@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240107062654.GO3416@thinkpad>
X-ClientProxiedBy: BY3PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:a03:254::19) To AS8PR04MB7511.eurprd04.prod.outlook.com
 (2603:10a6:20b:23f::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB7511:EE_|DU0PR04MB9417:EE_
X-MS-Office365-Filtering-Correlation-Id: ade01753-6430-4f1e-9b22-08dc1070ca56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dLZ+f87tOoJDWu6E9Z+ht1RpRhY8wsjbZ5HGycbPowTJ8SrLn/kkfom37S+HO1mWEiy29BH1zgVjqgbOFX4HgQST5sHIooumr0alA4LiTWCfXmuL0mOlZeOOa5reapO6mNxboHDIFpEXLAB6zMeRwkHzq0Xxoyij8qWy7h1n0A1OZ4zUwPbCgiW0qTVCjKcUVUT6ohCoS0zLzEVxQALuYTCNWxiSuoOfdbetJBAUryiTRyrm0vmPt3LR8pkVaarBQCV1peZkQU3VOevrE87buq1ZtOvNUX69uw4ek3Shy0hhYuGwJs0Y3gKaJSDRVffY4a75TBtgFBo5oSy/5Wz3POLKXHAYGsl3zwYAUoxKX6wJb5wlKIaUqF9Bd4q3MgBCgmlge1nk8zjRVl+qN+ERdgI31wpWBDksis0Gnc9WHdgT/je3dXoUz/Ulo3DQ1SpmCzpr22c49K5jtrZqnPGuAz5aCR8oFC8L4QLlS+3u3EF6a33+AIOm0leqiVHpkS+zjUWgk7A/DirV3UNmFugOYF/kHhvsCoin3aWIW2aBYmioeOTv+ua6EuG277i6SWSYt0vt1axHZre/cSHvsOi72VsqH3vT52q/HsoYrALXnpIwPbuWDcE7lkEnrmx+zB2a
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB7511.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(136003)(396003)(366004)(376002)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(478600001)(6486002)(4326008)(66476007)(6916009)(66946007)(66556008)(26005)(6666004)(52116002)(9686003)(6506007)(6512007)(316002)(8936002)(5660300002)(2906002)(7416002)(33716001)(41300700001)(8676002)(38350700005)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2JETHg2dUU3Rk53UzRqQTJDZGh0MkQ2U3JoK1BBUXArdFk4QXJyMDFhcVJm?=
 =?utf-8?B?VGJqK29xajkraWZNMFFIYlpQSnBOSnZoUzZLcUNEeWsxOGhUNzR1YW16ajBD?=
 =?utf-8?B?elJ3ajdoTXVmTzNsbEhXNVFBQ0lpZ2U1QnM2Ym13bFRWSkJhTlFJQmgvaDYw?=
 =?utf-8?B?Vmg0YjdUemlhS0pyRytYQjhPNE5hd3ZOb0dURDJqd1lFMXVtWHZpWURTNTZX?=
 =?utf-8?B?QThHazgxYmF4SlpxY0RDQXVFaDBaRkRDOEh6TnRPdkU5TDdZRVhjRG5zNzdU?=
 =?utf-8?B?S2J2WVp1OTNBOFNDcTVuU0tGVEtBTE4zcW5lQnBQcTBxOXNqOUUvd09wcDkv?=
 =?utf-8?B?dmVHR2E3ZHJXMENmMmpqMWJMT1lISkJzWWZwY3ZucnY5eXJwUmM5RnlFeFBP?=
 =?utf-8?B?ak5NUG50d3VRN2llQWJSZVcxRkhIVFp6WnR6ZUFhaEM1U1FsWDc5MXl3eDVU?=
 =?utf-8?B?aE5rbVA3U2Jqd1hDZ1dMRTFPQlJ1UzZPZUZzdHN1akpjQi9zZmFTRVFzdm9r?=
 =?utf-8?B?cG9xZmlBaE40N1FxTWNDc1EzdEFwSUx0NXZuN1R1WHBXcHhZcGRvNXFHRmY5?=
 =?utf-8?B?YUhYUU9reE80S3dxYVkyZ1RBalV4RE5NZ0ZiMm4xRytRSWZGV0ZCWkZ6WUk4?=
 =?utf-8?B?TEM4S05LZ2Y2TkxybWVRMHlGTzl5T29ITEJ5SEpBTWs2TS9oaG9IRDc4NmQy?=
 =?utf-8?B?elpGc1R3czdENW9OYjQxNDZseFZ0SGVwZmF4VmVVQy9QNS9NWEZYSUxVTm5S?=
 =?utf-8?B?T1JQVEIvUG5QUkZzVHhQZFdKZHBoOUoyaFpRYmlkMWRFaUNiM09RVW5DRzRk?=
 =?utf-8?B?TkU1MlRzL3lSY0RmekEzb1NsR0xrZ1JIZjNDR2xqbHBRNHJZL1hScGlsOFRR?=
 =?utf-8?B?ak1kK3lxL3FOY0NMQjB2WFQ1VlJTd0lwbDNXRWtzMU1oZHhVZ0ptdXFMUnMy?=
 =?utf-8?B?N1Q3V0xHa09jS0lSYUdaRG9lMjVpaEg4enZFR1RZcGNJZDB3WmltMW9EeW5K?=
 =?utf-8?B?NHdINVI2THJCVTlJNTdmSk1MMkN0Zlg3Ly8vUHJaYmNSMmdiRGV1U3k4RzNX?=
 =?utf-8?B?Nmpidjd3U0hxc0MwTW96TTl6OWw2UVV2cVJXalpESFhVM2FnTDVwY3Zkemtk?=
 =?utf-8?B?MWk5NFk2MDJqenpwdlV6SXpvQWlaaUJabWNQQzByL2dJUjRWY2t3bDJHbER4?=
 =?utf-8?B?ckorVjZnMzBLRSt6cXB3aWZDcVlKbWVmWXNnaVJYbkVTSU9adndya090UnBP?=
 =?utf-8?B?UWhPYmxpeldSOWhLb3RGamIxbWNHamg3Z0ZOZWZJK0daOHl5dEJ3SWpqdTZI?=
 =?utf-8?B?L0poVmVtc0pKekQ4VEhWdTJvVTBsdjlIallXLzlxZmhCNWFiVTNUaDlJMFlz?=
 =?utf-8?B?Y2hqQUM2UmV5TXdRWCtVZStueXo4RzRic1VSM2FybHBLV2MrS2ZnVmUxSTdJ?=
 =?utf-8?B?Y0Yva0U0WVJiTzJxR1JxaE5mVjhsK3JOLzFmMi9yNjc3SGxBcnNGM2tQRkln?=
 =?utf-8?B?eDlOZnRsQ2IxZDg3cUlnTWhRdEFoRlBSWDI2YmdkTDVYcVFLdmJjK3VRbFBV?=
 =?utf-8?B?VXl6aHpMWjI2SC9sTlZWRUdrak5EQS8rU2pDYmxkZXpxdUx1TlZHZHRvUlNm?=
 =?utf-8?B?NE1NRHhtNlhiWm9MK203aWJkM3VhMWxBbXNTLzZDSHJ5ck4xeGFVcGhuSURV?=
 =?utf-8?B?TnJwQy81NzF3M3V6TXY4UUtBcFBXbjh5enBRUHV2R0xOczkwY3cyUXN6YW5U?=
 =?utf-8?B?eUEwTVNwdmJpR2RHQzQvOTkwd0Y1STZiNXk4RU9oZkVhbVBmdVVkNGJFTURz?=
 =?utf-8?B?L09LdzRaaGxYVlF2SVMxTkdER0pZWEUyVzFJOXRzUGV6WUdScHQrQzhFb1cv?=
 =?utf-8?B?ZlV3Uy9Bby9IRi9NVHRqa3FXc3d4eWNERVA3Nisrc3VwcHkzTGs3eWRhQUlm?=
 =?utf-8?B?Mm85NWs1NVBJdmFlYzNkOWlLNjJDL29XYi8zUWdSRFdHeFMrSUV2Z3BhL2Nj?=
 =?utf-8?B?VG9Hdm1DSk1sYUxFN3RXdTI4Wk5xUCtnTTZSRXNaUm1CZXlueVQzYyt2RHBh?=
 =?utf-8?B?Y1pGUW4xbWVxdVplQU5RY2hiaGt2MkxKa25NRnNsWWczczI1ZG8yRDk2ZGUv?=
 =?utf-8?Q?fqQGGc9MdIgDyvEy61d8LiU1O?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ade01753-6430-4f1e-9b22-08dc1070ca56
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB7511.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 17:39:39.9650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /s8V0YmXkUNMkt9Vjbi2bNsbhF3ZyhJMew68J0bGdq5iOtDEEVcN61APANz6QU6p2Ofh7zMx/Acyu75z4tBTsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9417

On Sun, Jan 07, 2024 at 11:56:54AM +0530, Manivannan Sadhasivam wrote:
> On Wed, Dec 27, 2023 at 01:27:27PM -0500, Frank Li wrote:
> 
> Subject: PCI: imx6: Add iMX95 Endpoint (EP) support
> 
> > Add iMX95 EP function support and add 64bit address support. Internal bus
> 
> Remove 'function' as that refers to endpoint function.
> 
> > bridge for PCI support 64bit dma address in iMX95. So set call
> > dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64)).
> > 
> 
> 'Hence, call dma_set_mask_and_coherent() to set 64 bit DMA mask.'
> 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > 
> > Notes:
> >     Change from v3 to v4
> >     - change align to 4k for imx95
> >     Change from v1 to v3
> >     - new patches at v3
> > 
> >  drivers/pci/controller/dwc/pci-imx6.c | 45 +++++++++++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index 6a58fd63a9dd2..00ec59867c17b 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -75,6 +75,7 @@ enum imx6_pcie_variants {
> >  	IMX8MQ_EP,
> >  	IMX8MM_EP,
> >  	IMX8MP_EP,
> > +	IMX95_EP,
> >  };
> >  
> >  #define IMX6_PCIE_FLAG_IMX6_PHY			BIT(0)
> > @@ -84,6 +85,7 @@ enum imx6_pcie_variants {
> >  #define IMX6_PCIE_FLAG_HAS_APP_RESET		BIT(4)
> >  #define IMX6_PCIE_FLAG_HAS_PHY_RESET		BIT(5)
> >  #define IMX6_PCIE_FLAG_HAS_SERDES		BIT(6)
> > +#define IMX6_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
> >  
> >  #define imx6_check_flag(pci, val)     (pci->drvdata->flags & val)
> >  
> > @@ -620,6 +622,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
> >  		break;
> >  	case IMX7D:
> >  	case IMX95:
> > +	case IMX95_EP:
> >  		break;
> >  	case IMX8MM:
> >  	case IMX8MM_EP:
> > @@ -1063,6 +1066,23 @@ static const struct pci_epc_features imx8m_pcie_epc_features = {
> >  	.align = SZ_64K,
> >  };
> >  
> > +/*
> > + * BAR#	| Default BAR enable	| Default BAR Type	| Default BAR Size	| BAR Sizing Scheme
> > + * ================================================================================================
> > + * BAR0	| Enable		| 64-bit		| 1 MB			| Programmable Size
> > + * BAR1	| Disable		| 32-bit		| 64 KB			| Fixed Size
> > + *	| (BAR0 is 64-bit)	| if BAR0 is 32-bit	|			| As Bar0 is 64bit
> 
> I couldn't understand above. And not aligned properly.

If BAR0 is 64bit, BAR1 will be disable. (Supposed it is default).
If BAR0 is 32bit, BAR1 will 64KB fixed sized.

Aligned because 'tab' show problem in patch. It show algin at '|" at code.

Frank

> 
> > + * BAR2	| Enable		| 32-bit		| 1 MB			| Programmable Size
> > + * BAR3	| Enable		| 32-bit		| 64 KB			| Programmable Size
> > + * BAR4	| Enable		| 32-bit		| 1M			| Programmable Size
> > + * BAR5	| Enable		| 32-bit		| 64 KB			| Programmable Size
> > + */
> > +static const struct pci_epc_features imx95_pcie_epc_features = {
> > +	.msi_capable = true,
> > +	.bar_fixed_size[1] = SZ_64K,
> > +	.align = SZ_4K,
> > +};
> > +
> >  static const struct pci_epc_features*
> >  imx6_pcie_ep_get_features(struct dw_pcie_ep *ep)
> >  {
> > @@ -1105,6 +1125,14 @@ static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
> >  
> >  	pci->dbi_base2 = pci->dbi_base + pcie_dbi2_offset;
> >  
> > +	/*
> 
> Use FIXME here.
> 
> - Mani
> 
> > +	 * db2 information should fetch from dtb file. dw_pcie_ep_init() can get dbi_base2 from
> > +	 * "dbi2" if pci->dbi_base2 is NULL. All code related pcie_dbi2_offset should be removed
> > +	 * after all dts added "dbi2" reg.
> > +	 */
> > +	if (imx6_pcie->drvdata->variant == IMX95_EP)
> > +		pci->dbi_base2 = NULL;
> > +
> >  	ret = dw_pcie_ep_init(ep);
> >  	if (ret) {
> >  		dev_err(dev, "failed to initialize endpoint\n");
> > @@ -1355,6 +1383,9 @@ static int imx6_pcie_probe(struct platform_device *pdev)
> >  					     "unable to find iomuxc registers\n");
> >  	}
> >  
> > +	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_SUPPORT_64BIT))
> > +		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> > +
> >  	/* Grab PCIe PHY Tx Settings */
> >  	if (of_property_read_u32(node, "fsl,tx-deemph-gen1",
> >  				 &imx6_pcie->tx_deemph_gen1))
> > @@ -1557,6 +1588,19 @@ static const struct imx6_pcie_drvdata drvdata[] = {
> >  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> >  		.epc_features = &imx8m_pcie_epc_features,
> >  	},
> > +	[IMX95_EP] = {
> > +		.variant = IMX95_EP,
> > +		.flags = IMX6_PCIE_FLAG_HAS_SERDES |
> > +			 IMX6_PCIE_FLAG_SUPPORT_64BIT,
> > +		.clk_names = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux"},
> > +		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
> > +		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
> > +		.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
> > +		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
> > +		.init_phy = imx95_pcie_init_phy,
> > +		.epc_features = &imx95_pcie_epc_features,
> > +		.mode = DW_PCIE_EP_TYPE,
> > +	},
> >  };
> >  
> >  static const struct of_device_id imx6_pcie_of_match[] = {
> > @@ -1571,6 +1615,7 @@ static const struct of_device_id imx6_pcie_of_match[] = {
> >  	{ .compatible = "fsl,imx8mq-pcie-ep", .data = &drvdata[IMX8MQ_EP], },
> >  	{ .compatible = "fsl,imx8mm-pcie-ep", .data = &drvdata[IMX8MM_EP], },
> >  	{ .compatible = "fsl,imx8mp-pcie-ep", .data = &drvdata[IMX8MP_EP], },
> > +	{ .compatible = "fsl,imx95-pcie-ep", .data = &drvdata[IMX95_EP], },
> >  	{},
> >  };
> >  
> > -- 
> > 2.34.1
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

