Return-Path: <linux-pci+bounces-1738-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 230648260AF
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jan 2024 17:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80B5BB2153C
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jan 2024 16:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138DE8839;
	Sat,  6 Jan 2024 16:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OsUSlXm4"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2075.outbound.protection.outlook.com [40.107.22.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFBCC8EC;
	Sat,  6 Jan 2024 16:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyXGOw7syKSehNxRWabtEjfeSq3yfg/TbC9xohsquq4GsqeztVrvIGUDdloAuPW7WohS1kazpkRab1aeyMa+K2V9ZCu+cPaNnLaPylOD7omJwmz7FlXxXd1ahU7GguuGEYAJEwxHLkQutq7SMYO+6aMALjtOPlFvR3RZpFAan9rYl2X30pN4OU4SMBd/iPQH+7lnAyS3shFPPtmRNKTfbRtU3H5VLrO+sooQcy1dv7J9emIX6Bvt7KjnE2CTkdLwmc2Rp63+eMD0fePduQTnD+7TwHD/Cu8EzQyxZg1WTwbcTFWPvj2j3pEDN16dCaA0FfNIz7GBpmF9EGpsIYYxoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zJExCCOCsbbZoX9RsmecaXne8uispAdKq7lX95xRv9k=;
 b=kTQJdBxZF36fZvvYR4DoI19TrEn89ra9CLPHUbd+jYKJ1qhonlnfkz7WL75aMbNMt/dNGq1Gt2fgqIuVXzy59x/nFGXYeyTnpH7U3+TL+UTxPUqXxdPDRE6JYxHtyxZvIpsNr6Vgbgu6plaa37X4gmWKJmSfdBkBPOFmqg1THuuvuZ7FvnwRRFi0XeMkdwr5T2akaxLG9C4LmkVWUqWKwhooCKA5R1WsfBwA95NlwEqNl7wzhZ/CLolWG8JgGJ3Fup70MCY559/N0rtpuhfCwuOJCzhpN3jYxo78cSCQMhz6/F9ZMmaKbUhe9SUkmHeco/yRa9TTKN31ifPKzSXodQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJExCCOCsbbZoX9RsmecaXne8uispAdKq7lX95xRv9k=;
 b=OsUSlXm4dg8v8XzKmFfqxzTZtcdyw3rVayAkdTWXZIxQ2ea9aLO9kJxnIeqnyMDz0Yxq5AJoBffN0I/IOcJt3h47v5t7qFFWlJXsrtOdOVMAKzYGpxwOnjjE2ury0jwj3R6+jJlDEMjud9UYrTS2b5p2uCH7wzK++bCJA7U/VFI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com (2603:10a6:20b:23f::5)
 by DU2PR04MB8598.eurprd04.prod.outlook.com (2603:10a6:10:2d9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.19; Sat, 6 Jan
 2024 16:48:46 +0000
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469]) by AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469%4]) with mapi id 15.20.7159.018; Sat, 6 Jan 2024
 16:48:46 +0000
Date: Sat, 6 Jan 2024 11:48:35 -0500
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
Subject: Re: [PATCH v7 01/16] PCI: imx6: Simplify clock handling by using
 bulk_clk_*() function
Message-ID: <ZZmEY5d6IRcCZjl7@lizhi-Precision-Tower-5810>
References: <20231227182727.1747435-1-Frank.Li@nxp.com>
 <20231227182727.1747435-2-Frank.Li@nxp.com>
 <20240106152708.GD2512@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240106152708.GD2512@thinkpad>
X-ClientProxiedBy: BY5PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:a03:180::36) To AS8PR04MB7511.eurprd04.prod.outlook.com
 (2603:10a6:20b:23f::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB7511:EE_|DU2PR04MB8598:EE_
X-MS-Office365-Filtering-Correlation-Id: c71d5f75-8350-4b01-aca2-08dc0ed75988
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+6qW+X8ZxPU65pm7cXM0QAn6UGqn6npxKxMU9dYFOpkSZMBAanjP65SToiYFKwmCVuZtixPc7YyewRoiYhsBaGqe7f4iwYyRna5uWzvcGGS9F+UYZuwLlXuw0TDqkCFKcZFcqrVaVbsKxmlT5jJr3zJk5rK7yp1nl8blK/IeaeFrk1N7pk59W4urNny+PDVj4nBsM/eV90ByqvAkzOz95dstoZEKAtRdZkUmqzCuvQM9h5axvFf4PMFDHz2MlmRj/cBWsMjBapXRnkC36h8XFgJrS9eNBZfO3XWIpviH7BS7ziuHzw6sgB6o8X3hCKbUseRCGcIPpRdIIN341EbanOCzx20RiUCL+jlI8p66+z+A1U5/gHcHziQFG3T3rDmqx7M+b+HoCPDJ0KcB28a6holzpsVqxWTi8sOn55+U8yiRT1C5tUKs4oMTrLg+sNr4L9sMJkd3gsjsiTNZWk7901bAyjnAwcJZ6ONZtgGGb9LWTwCAbPuSV+Nz0xy1Jwe+XM7qWtsmTuPuXflBMBN04cKbQSdz1R+7Q8WyWIT9cEVLDCTjL/I7fs/qEcVnbHueJWqdzjMI0wkuHbNm/Q79QXyE46r+0tT4vmkTMnLTh4BxXt47Fa3H0DxLqOO5mlV4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB7511.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(396003)(136003)(346002)(39850400004)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6486002)(52116002)(26005)(9686003)(478600001)(6506007)(6512007)(6666004)(83380400001)(5660300002)(2906002)(7416002)(30864003)(41300700001)(33716001)(66476007)(66556008)(66946007)(6916009)(316002)(4326008)(8936002)(8676002)(38100700002)(86362001)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blhyL3pJQ25zQ1FYUUliT3ZETHZzZWNGVDBtTjJha21Zc3RIR2FVK0NCRUxO?=
 =?utf-8?B?aFh1TXlkNmZMblRWYmhWVk52NXVBZlZTZGlONzlCUUl0bHBQR1I2MnlSZ0g4?=
 =?utf-8?B?MTZaSWhGSENQUUNCVDNyQVJFU3UwVldZU3dwOFF4eTJ3bkdJUUVLRTFVQ2Np?=
 =?utf-8?B?WU96ZkF2aGkvcUNQWGw5b0VmTDJXKzlRRi9pYjd1enlkbDFFcTZiTTBZNTM5?=
 =?utf-8?B?K2NFTGNCMVUxWDQ0bDNaNlZPVkRJVW9FTk5QRElQbGFqbkJhZCt6WlV2aEZu?=
 =?utf-8?B?c2ZpVllYRW0wTFlaQzFwMnQ5YVEyY1BjNURDVXNLbGxsczViNmlFZFpWL0U4?=
 =?utf-8?B?WGI2Z2t0UFBxbXV4eVBrM1Q2bWR1ZEN0dEhGOEFhR3FuUWJmdFl5aEhDOHZM?=
 =?utf-8?B?UlVSR3dkaGVEazVHVDIycFBrZlVtU3hXN3ZtNDlVa2l5SmNYaS91VmI5RnRq?=
 =?utf-8?B?NXk1TnFOSWZJajFoZDNsaHRWOFNaK1JKc1NqcS8weUhqZlozNnRqV0Rtb3Fm?=
 =?utf-8?B?WUkvVENSbHNKMmhDbkFXSXlmT25NV0o1aVFDSStwM2tRZHczRWExNkt6YWcy?=
 =?utf-8?B?OVQrdHpvdklIeUVjbmpwRjBmUFhWNVNBT1RQRE1hbmhQN3diZVhBS1pldk4r?=
 =?utf-8?B?K3dxWjdXOFdMSk5LWmZNcCtMZTZQVS9PNkhJbUd5V1IvNm1FNFpkdXB5Ukdo?=
 =?utf-8?B?ZlhKaHkwbGFiY3g1SXpCTm9aeVFFdXAyU1ZxU1hOSTNIWGlBN00yTDJXRUdn?=
 =?utf-8?B?Qm1BRER6Ymc1WEFjWDMxb3I1NUlkSmdWdVNIZHYwQVR1Zm1VRlNZZHI2RnFU?=
 =?utf-8?B?dzhJZEMvZUFWUzM3M1diYU0wNU92NE9UbWNzV1hWYWUwdE1XMjFNVVlJRHdX?=
 =?utf-8?B?N0lGQ0hrT1dVUlU0cHlwUVJ5eWp2NzFFMm85b2ZFV0J4Sm1jWGJ0WVdpTEhO?=
 =?utf-8?B?K01FamdpODlaN29wNXRNZkhGVThOMDdyZzh1eEtFdWVBbWhxeUIxRlk4N2Ex?=
 =?utf-8?B?TldJSkNzUDhlSG5HbUxOWFE1bzlDNlZTMWxvZFlaeGxjSjZ4elRUcG9kdThU?=
 =?utf-8?B?bGlkL2xLUmZ6RDNadm5iVGNCa0RkTWVJbFJDT1diVkppb0R4NExWaU9oWEJH?=
 =?utf-8?B?VTRPUEtETitleW9vOWh2T3hMYi9maXcrRGZZalZvWDN5SG12Z0srOHFzSVVS?=
 =?utf-8?B?ZTFSK0pKMGxNRVFvamRFZjN6RGZZaTlVZEFXakdFeWRqenhTeTNITHAzeHpH?=
 =?utf-8?B?eXFDWE9EZnMwUHFwYmxXRnRnVTB5VTVFRk51YTVQTzd2Vm1YVmUxZFE1Q0xw?=
 =?utf-8?B?ZS85Zi9mLzR3bUhtR2VuMXVlOXU0SlUvL3l2MGJQZ1RWWGpvc0IvOW1xTnRY?=
 =?utf-8?B?MkhrcGhDdVZSeU50VW1yN01yVEVjQVNldzlYZmJIcndnd0FPVGk4T09NcStM?=
 =?utf-8?B?ZXNGZFYwNStueFN0ZzdHckRQeGZmY2F6c01MQTYvckVCWHB1d09TVmp1S1lz?=
 =?utf-8?B?SWtpOTdZMm1qck1jaEcrN1FGejFZWk9PcW9wVEVuMkZXQUlXR091d0RNbVVD?=
 =?utf-8?B?TmZFU2RIaGYwR0Z0OWRJcXhTWFQ1OWxhZk04djB5NGdIY3ViZUVKS2l0VExp?=
 =?utf-8?B?YTNYWFQyWXBYR05acmlGeTNIMlpjdW45czN1cGtEYVF1WWc4ckNwTTMwWDlt?=
 =?utf-8?B?c3JOWU9EdUlxLzBGSmU0ZjdScFZ5VXNacCtORDFNWHVSQmZLTHlqNGZYVllZ?=
 =?utf-8?B?bFB0cWpWNnI2QWNZQ3NsZVpLSFNiVzVDbGY3SWwvQnJWVHJVMnFJTkRUWUNp?=
 =?utf-8?B?RGE1U05sUGlIUDFEbTNoM003Ynk4U0xGNHRRTWxiSFR2a0JLUmFodmZ3MHJW?=
 =?utf-8?B?RnBNVlYvTFVxVW9HTlZhSFZSNnoxTnBubWpnUFFBQ0xrWE4yR21mNTdaZFF3?=
 =?utf-8?B?WDg3VXdUSm4vNGY1TDI5ZjBsckZCYnpQVmU4cjk4VlFBMzEydkovY3NxWEdw?=
 =?utf-8?B?c1ZjbTk5eUNtTWdvMXVxMmtCaHZtWHRCWVhncXpoRkNNeTRHY3BEWk56MGlC?=
 =?utf-8?B?cjMxQzRjRU1pZ05GWVhyMm45ZHZsNW03K21NaWNtWWJaTjQ0cXFzMnJMK1lv?=
 =?utf-8?Q?Ap6XlHLYS8ITFyujdTvqFumcg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c71d5f75-8350-4b01-aca2-08dc0ed75988
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB7511.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2024 16:48:46.4286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qn5ajhk1m8RrkYQTdC/22i8Jss/Ic0psV54CzmBvi1gE5lMsz8d8VfjgTWx1r2cooEAqfi3J5WReDkvN+o3gFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8598

On Sat, Jan 06, 2024 at 08:57:08PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Dec 27, 2023 at 01:27:12PM -0500, Frank Li wrote:
> 
> Subject mentions, 'bulk_clk' APIs but there is no such thing. It should be
> 'clk_bulk()' APIs.
> 
> > Refactors the clock handling logic. Adds clk_names[] define in drvdata.
> > Using clk_bulk*() api simplifies the code.
> > 
> 
> I've mentioned this many times in the past. But let me reiterate here again:
> 
> Commit message should be in imperative mood as per Linux Kernel rules for
> submitting patches. Please see here:
> Documentation/process/submitting-patches.rst
> 
> The relevant part is:
> 
> "Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
> instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
> to do frotz", as if you are giving orders to the codebase to change
> its behaviour."
> 
> Please use this same format for rest of the patches as well for future ones.

I may have not understand *imperative mode*. Asked an English native
speaker. Do you menas

*Refector* the clock handling logic. *Add* clk_names[] define in drvdata.
*Use* clk_bulk*() api *simplify* the code.

> 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > 
> > Notes:
> >     Change from v4 to v5
> >     - update commit message
> >     - direct using clk name list, instead of macro
> >     - still keep caculate clk list count because sizeof return pre allocated
> >     array size.
> >     
> >     Change from v3 to v4
> >     - using clk_bulk_*() API
> >     Change from v1 to v3
> >     - none
> > 
> >  drivers/pci/controller/dwc/pci-imx6.c | 125 ++++++++------------------
> >  1 file changed, 35 insertions(+), 90 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index 74703362aeec7..50d9faaa17f71 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -61,12 +61,15 @@ enum imx6_pcie_variants {
> >  #define IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE	BIT(1)
> >  #define IMX6_PCIE_FLAG_SUPPORTS_SUSPEND		BIT(2)
> >  
> > +#define IMX6_PCIE_MAX_CLKS       6
> > +
> >  struct imx6_pcie_drvdata {
> >  	enum imx6_pcie_variants variant;
> >  	enum dw_pcie_device_mode mode;
> >  	u32 flags;
> >  	int dbi_length;
> >  	const char *gpr;
> > +	const char *clk_names[IMX6_PCIE_MAX_CLKS];
> >  };
> >  
> >  struct imx6_pcie {
> > @@ -74,11 +77,8 @@ struct imx6_pcie {
> >  	int			reset_gpio;
> >  	bool			gpio_active_high;
> >  	bool			link_is_up;
> > -	struct clk		*pcie_bus;
> > -	struct clk		*pcie_phy;
> > -	struct clk		*pcie_inbound_axi;
> > -	struct clk		*pcie;
> > -	struct clk		*pcie_aux;
> > +	struct clk_bulk_data	clks[IMX6_PCIE_MAX_CLKS];
> > +	u32			clks_cnt;
> >  	struct regmap		*iomuxc_gpr;
> >  	u16			msi_ctrl;
> >  	u32			controller_id;
> > @@ -407,13 +407,18 @@ static void imx7d_pcie_wait_for_phy_pll_lock(struct imx6_pcie *imx6_pcie)
> >  
> >  static int imx6_setup_phy_mpll(struct imx6_pcie *imx6_pcie)
> >  {
> > -	unsigned long phy_rate = clk_get_rate(imx6_pcie->pcie_phy);
> > +	unsigned long phy_rate = 0;
> >  	int mult, div;
> >  	u16 val;
> > +	int i;
> >  
> >  	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_IMX6_PHY))
> >  		return 0;
> >  
> > +	for (i = 0; i < imx6_pcie->clks_cnt; i++)
> > +		if (strncmp(imx6_pcie->clks[i].id, "pcie_phy", 8) == 0)
> > +			phy_rate = clk_get_rate(imx6_pcie->clks[i].clk);
> > +
> >  	switch (phy_rate) {
> >  	case 125000000:
> >  		/*
> > @@ -550,19 +555,11 @@ static int imx6_pcie_attach_pd(struct device *dev)
> >  
> >  static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
> >  {
> > -	struct dw_pcie *pci = imx6_pcie->pci;
> > -	struct device *dev = pci->dev;
> >  	unsigned int offset;
> >  	int ret = 0;
> >  
> >  	switch (imx6_pcie->drvdata->variant) {
> >  	case IMX6SX:
> > -		ret = clk_prepare_enable(imx6_pcie->pcie_inbound_axi);
> > -		if (ret) {
> > -			dev_err(dev, "unable to enable pcie_axi clock\n");
> > -			break;
> > -		}
> > -
> >  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> >  				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN, 0);
> >  		break;
> > @@ -589,12 +586,6 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
> >  	case IMX8MQ_EP:
> >  	case IMX8MP:
> >  	case IMX8MP_EP:
> > -		ret = clk_prepare_enable(imx6_pcie->pcie_aux);
> > -		if (ret) {
> > -			dev_err(dev, "unable to enable pcie_aux clock\n");
> > -			break;
> > -		}
> > -
> >  		offset = imx6_pcie_grp_offset(imx6_pcie);
> >  		/*
> >  		 * Set the over ride low and enabled
> > @@ -615,9 +606,6 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
> >  static void imx6_pcie_disable_ref_clk(struct imx6_pcie *imx6_pcie)
> >  {
> >  	switch (imx6_pcie->drvdata->variant) {
> > -	case IMX6SX:
> > -		clk_disable_unprepare(imx6_pcie->pcie_inbound_axi);
> > -		break;
> >  	case IMX6QP:
> >  	case IMX6Q:
> >  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> > @@ -631,14 +619,6 @@ static void imx6_pcie_disable_ref_clk(struct imx6_pcie *imx6_pcie)
> >  				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
> >  				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
> >  		break;
> > -	case IMX8MM:
> > -	case IMX8MM_EP:
> > -	case IMX8MQ:
> > -	case IMX8MQ_EP:
> > -	case IMX8MP:
> > -	case IMX8MP_EP:
> > -		clk_disable_unprepare(imx6_pcie->pcie_aux);
> > -		break;
> >  	default:
> >  		break;
> >  	}
> > @@ -650,23 +630,9 @@ static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
> >  	struct device *dev = pci->dev;
> >  	int ret;
> >  
> > -	ret = clk_prepare_enable(imx6_pcie->pcie_phy);
> > -	if (ret) {
> > -		dev_err(dev, "unable to enable pcie_phy clock\n");
> > +	ret =  clk_bulk_prepare_enable(imx6_pcie->clks_cnt, imx6_pcie->clks);
> 
> Extra space after =
> 
> > +	if (ret)
> >  		return ret;
> > -	}
> > -
> > -	ret = clk_prepare_enable(imx6_pcie->pcie_bus);
> > -	if (ret) {
> > -		dev_err(dev, "unable to enable pcie_bus clock\n");
> > -		goto err_pcie_bus;
> > -	}
> > -
> > -	ret = clk_prepare_enable(imx6_pcie->pcie);
> > -	if (ret) {
> > -		dev_err(dev, "unable to enable pcie clock\n");
> > -		goto err_pcie;
> > -	}
> >  
> >  	ret = imx6_pcie_enable_ref_clk(imx6_pcie);
> >  	if (ret) {
> > @@ -679,11 +645,7 @@ static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
> >  	return 0;
> >  
> >  err_ref_clk:
> > -	clk_disable_unprepare(imx6_pcie->pcie);
> > -err_pcie:
> > -	clk_disable_unprepare(imx6_pcie->pcie_bus);
> > -err_pcie_bus:
> > -	clk_disable_unprepare(imx6_pcie->pcie_phy);
> > +	clk_bulk_disable_unprepare(imx6_pcie->clks_cnt, imx6_pcie->clks);
> >  
> >  	return ret;
> >  }
> > @@ -691,9 +653,7 @@ static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
> >  static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
> >  {
> >  	imx6_pcie_disable_ref_clk(imx6_pcie);
> > -	clk_disable_unprepare(imx6_pcie->pcie);
> > -	clk_disable_unprepare(imx6_pcie->pcie_bus);
> > -	clk_disable_unprepare(imx6_pcie->pcie_phy);
> > +	clk_bulk_disable_unprepare(imx6_pcie->clks_cnt, imx6_pcie->clks);
> >  }
> >  
> >  static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
> > @@ -1305,32 +1265,19 @@ static int imx6_pcie_probe(struct platform_device *pdev)
> >  		return imx6_pcie->reset_gpio;
> >  	}
> >  
> > -	/* Fetch clocks */
> > -	imx6_pcie->pcie_bus = devm_clk_get(dev, "pcie_bus");
> > -	if (IS_ERR(imx6_pcie->pcie_bus))
> > -		return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_bus),
> > -				     "pcie_bus clock source missing or invalid\n");
> > +	while (imx6_pcie->drvdata->clk_names[imx6_pcie->clks_cnt]) {
> > +		int i = imx6_pcie->clks_cnt;
> 
> Why can't you initialize i to 0 directly?

can't init i to 0 directly here, otherwise next loop i will not increase.
i just reduce refer imx6_pcie->clks_cnt in 

imx6_pcie->clks[i].id = imx6_pcie->drvdata->clk_names[i];

Frank

> 
> Rest looks good to me.
> 
> - Mani
> 
> > +
> > +		imx6_pcie->clks[i].id = imx6_pcie->drvdata->clk_names[i];
> > +		imx6_pcie->clks_cnt++;
> > +	}
> >  
> > -	imx6_pcie->pcie = devm_clk_get(dev, "pcie");
> > -	if (IS_ERR(imx6_pcie->pcie))
> > -		return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie),
> > -				     "pcie clock source missing or invalid\n");
> > +	/* Fetch clocks */
> > +	ret = devm_clk_bulk_get(dev, imx6_pcie->clks_cnt, imx6_pcie->clks);
> > +	if (ret)
> > +		return ret;
> >  
> >  	switch (imx6_pcie->drvdata->variant) {
> > -	case IMX6SX:
> > -		imx6_pcie->pcie_inbound_axi = devm_clk_get(dev,
> > -							   "pcie_inbound_axi");
> > -		if (IS_ERR(imx6_pcie->pcie_inbound_axi))
> > -			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_inbound_axi),
> > -					     "pcie_inbound_axi clock missing or invalid\n");
> > -		break;
> > -	case IMX8MQ:
> > -	case IMX8MQ_EP:
> > -		imx6_pcie->pcie_aux = devm_clk_get(dev, "pcie_aux");
> > -		if (IS_ERR(imx6_pcie->pcie_aux))
> > -			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_aux),
> > -					     "pcie_aux clock source missing or invalid\n");
> > -		fallthrough;
> >  	case IMX7D:
> >  		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
> >  			imx6_pcie->controller_id = 1;
> > @@ -1353,10 +1300,6 @@ static int imx6_pcie_probe(struct platform_device *pdev)
> >  	case IMX8MM_EP:
> >  	case IMX8MP:
> >  	case IMX8MP_EP:
> > -		imx6_pcie->pcie_aux = devm_clk_get(dev, "pcie_aux");
> > -		if (IS_ERR(imx6_pcie->pcie_aux))
> > -			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_aux),
> > -					     "pcie_aux clock source missing or invalid\n");
> >  		imx6_pcie->apps_reset = devm_reset_control_get_exclusive(dev,
> >  									 "apps");
> >  		if (IS_ERR(imx6_pcie->apps_reset))
> > @@ -1372,14 +1315,6 @@ static int imx6_pcie_probe(struct platform_device *pdev)
> >  	default:
> >  		break;
> >  	}
> > -	/* Don't fetch the pcie_phy clock, if it has abstract PHY driver */
> > -	if (imx6_pcie->phy == NULL) {
> > -		imx6_pcie->pcie_phy = devm_clk_get(dev, "pcie_phy");
> > -		if (IS_ERR(imx6_pcie->pcie_phy))
> > -			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_phy),
> > -					     "pcie_phy clock source missing or invalid\n");
> > -	}
> > -
> >  
> >  	/* Grab turnoff reset */
> >  	imx6_pcie->turnoff_reset = devm_reset_control_get_optional_exclusive(dev, "turnoff");
> > @@ -1477,6 +1412,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
> >  			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE,
> >  		.dbi_length = 0x200,
> >  		.gpr = "fsl,imx6q-iomuxc-gpr",
> > +		.clk_names = {"pcie_bus", "pcie", "pcie_phy"},
> >  	},
> >  	[IMX6SX] = {
> >  		.variant = IMX6SX,
> > @@ -1484,6 +1420,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
> >  			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE |
> >  			 IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
> >  		.gpr = "fsl,imx6q-iomuxc-gpr",
> > +		.clk_names = {"pcie_bus", "pcie", "pcie_phy", "pcie_inbound_axi"},
> >  	},
> >  	[IMX6QP] = {
> >  		.variant = IMX6QP,
> > @@ -1492,40 +1429,48 @@ static const struct imx6_pcie_drvdata drvdata[] = {
> >  			 IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
> >  		.dbi_length = 0x200,
> >  		.gpr = "fsl,imx6q-iomuxc-gpr",
> > +		.clk_names = {"pcie_bus", "pcie", "pcie_phy"},
> >  	},
> >  	[IMX7D] = {
> >  		.variant = IMX7D,
> >  		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
> >  		.gpr = "fsl,imx7d-iomuxc-gpr",
> > +		.clk_names = {"pcie_bus", "pcie", "pcie_phy"},
> >  	},
> >  	[IMX8MQ] = {
> >  		.variant = IMX8MQ,
> >  		.gpr = "fsl,imx8mq-iomuxc-gpr",
> > +		.clk_names = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux"},
> >  	},
> >  	[IMX8MM] = {
> >  		.variant = IMX8MM,
> >  		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
> >  		.gpr = "fsl,imx8mm-iomuxc-gpr",
> > +		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
> >  	},
> >  	[IMX8MP] = {
> >  		.variant = IMX8MP,
> >  		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
> >  		.gpr = "fsl,imx8mp-iomuxc-gpr",
> > +		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
> >  	},
> >  	[IMX8MQ_EP] = {
> >  		.variant = IMX8MQ_EP,
> >  		.mode = DW_PCIE_EP_TYPE,
> >  		.gpr = "fsl,imx8mq-iomuxc-gpr",
> > +		.clk_names = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux"},
> >  	},
> >  	[IMX8MM_EP] = {
> >  		.variant = IMX8MM_EP,
> >  		.mode = DW_PCIE_EP_TYPE,
> >  		.gpr = "fsl,imx8mm-iomuxc-gpr",
> > +		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
> >  	},
> >  	[IMX8MP_EP] = {
> >  		.variant = IMX8MP_EP,
> >  		.mode = DW_PCIE_EP_TYPE,
> >  		.gpr = "fsl,imx8mp-iomuxc-gpr",
> > +		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
> >  	},
> >  };
> >  
> > -- 
> > 2.34.1
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

