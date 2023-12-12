Return-Path: <linux-pci+bounces-809-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFAD80F58D
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 19:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A17AF281E49
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 18:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CBF22076;
	Tue, 12 Dec 2023 18:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nlo90P0O"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2052.outbound.protection.outlook.com [40.107.21.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92433BC;
	Tue, 12 Dec 2023 10:32:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8mHU3pxdqB1QC1m52tMbzUUQjer1ET3v3JrvpE8z3w63ZpXAhg/jFtUcHOrgwtCTqN2s/bMCUrAUQt1ALR73LN8zbegQ2mKmINy5m3cxOMOwPFbsonm58ekkX0gA+lxwPO0XnV7j8Mtvbpw6pcS/PVIWCFq9n3yEFJW/tpYGK6/0t7E8f9t91RQJpmEy73zh5eL5tJCA2bZHyN7scJMFJB19ls29B3SPBfchWeRr1tY9Ba3HQBDQhenBYNgNAS1pBJTM1Eo9ZmD13/MAy2i+ORwmL7B7/GIB1OAXHK17ZundOiiOMHXU36mh/a7HZpYf9u3C7RyMoX+0TatCHskJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4hFilGVkLG7hv3Y6u/dmWlllUmCVa6jIGddL5yxCAg=;
 b=IgziUxaoIFMmCVNwb3Awu7Q0djyEffKuzJchFvakcS/caooF51Jd7Ppv/zt9ocVMwOkqjUp/CRr5eEzF9X78IHMtd+feyQWMgnxNgOIbVFXtqsyXjjkTFfOTSc66BrAtd+OSp/gO27Nj/7WJL4pVG3XoC6Xo/kBix91/w8gncMYEM3OMq5JI48peFmP8oCoEXGk4hKOYJ4VGAP2nijBFDR4pIxbW7rgJ13Ubj/qDJx+cfOKnkfU/pN3AFi7bYe1DmTR8vT3ydMOVgbZgbo8Ai+syNaMzUdwSripCCam6iXuGf2ROxGsPNPRzRE5cspJWgyWRaGptPlmDDCFd9Q4IwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4hFilGVkLG7hv3Y6u/dmWlllUmCVa6jIGddL5yxCAg=;
 b=nlo90P0OaAhLEtzUf/oYumNUo/4EKud3Sv/XLgLypQRPaiSzSRkHUJDNB2729ZFnJNJvhXJydcStViwUtoaA3OpPeUDdhxw8wz6SiNtjOZxteJmAcjJNJnThE+WxSzOpBaXTrHIrh22YshC2hKa8oaO6iu8h7vpsFUY9mtzxyDQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU0PR04MB9587.eurprd04.prod.outlook.com (2603:10a6:10:317::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 18:32:21 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 18:32:21 +0000
Date: Tue, 12 Dec 2023 13:32:11 -0500
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: bhelgaas@google.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
	festevam@gmail.com, helgaas@kernel.org, hongxing.zhu@nxp.com,
	imx@lists.linux.dev, kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org, kw@linux.com,
	l.stach@pengutronix.de, linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, lpieralisi@kernel.org, robh@kernel.org,
	s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: Re: [PATCH v3 01/13] PCI: imx6: Simplify clock handling by using
 HAS_CLK_* bitmask
Message-ID: <ZXinK/RF0Kc4ySYX@lizhi-Precision-Tower-5810>
References: <20231211215842.134823-1-Frank.Li@nxp.com>
 <20231211215842.134823-2-Frank.Li@nxp.com>
 <20231212164913.GA21240@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231212164913.GA21240@thinkpad>
X-ClientProxiedBy: BY3PR10CA0007.namprd10.prod.outlook.com
 (2603:10b6:a03:255::12) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DU0PR04MB9587:EE_
X-MS-Office365-Filtering-Correlation-Id: bb622771-3bcc-453c-ef70-08dbfb40ad88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Jn1Pnj/PbdCwat4eRpLf2Us+r7WeB8VV9lFmg6ox1SpoLWu1svj8fvTBA3kMjAyzJej6p0lyhoBALGPYYnhBvOo2n/AoB8VO2RCzbWLmUXXXtGw/FI4OKR6nG4rh4UYt3cAO10EoKSJDyMXfawFtQndBucunwNgZFKh+PbIyMm0eZNHMn5eGzQflrykxCys3OJhyGb4RBswElAl1H05Mx0nTbBvDUwflky5w1wVrU7TXfoQh/7UXZTBof8RfgQG1pfN3/65p9aKhVLUHzkHdmfiJVx3eOdwC1mzja0hJKrgonSol/q+Sc6H/0T3SSXjeWP+C6xryWLtH/M5RwLgEKDLJZxFRiX0B4u/ssIBg3P6/tud/N/UiWN6LIXqeHRnHeUttmuaeJCl8dnqs/++9sFQ0D0SbL1qXlR3dIuKXMat9lzTGi5bBlGQlq81uncEJ3+V4aWLc/8VYSkE7xYwukfLib2mywejsbU7IO6eeMWB/vb7dd5h9ExUw/JThMa/e1u9KPVzGzUULz82E9YPeuBsjQKrlJALfpcIQqlZ1IAyf6DFo8AnLIthQg5bI8cpgwsLF4xFB+ultJ7qsUSKHZIdo8TLsdtg3J8EYCp4S0MaDb4XqGGA6i7BdoXdbDxN+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(366004)(376002)(39860400002)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(66899024)(6506007)(6486002)(26005)(6512007)(6666004)(52116002)(478600001)(9686003)(38350700005)(38100700002)(86362001)(41300700001)(33716001)(2906002)(5660300002)(66476007)(66946007)(6916009)(7416002)(83380400001)(8936002)(4326008)(8676002)(316002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cjFBWStzeTlUS3hHYVBvb0Y5dlQwUUNIeXgrK0lvRCs0RlVvaWNudDN3QTVu?=
 =?utf-8?B?QUV4TjlSemhZYlBRQjJscmdWaEc3UGNMR09aM2psZXFDUVBGZjc1bHB6Zldn?=
 =?utf-8?B?SHpNWERzWnZuRHlvZzA0SkJ5czAyV3ZMRlFNd2tkQ0oxSVhqQ1dtc2RtdjRl?=
 =?utf-8?B?MnFnQjNkdmpiUU1FYW9UazZwRWZIM211bHZBWVI5bHVadldCbmpoYjk4cE1l?=
 =?utf-8?B?RFlrYTBpK0pESVF2Y3dqd090WnBjN3h2aXlQNWhRbmttREQybDE0UFBKWnVj?=
 =?utf-8?B?UTEyVEFuZ1kvS0VHTFVCUmZyY1c1cFlHR01YbEI3aC95ckFYQnVMZ3ZPNmNy?=
 =?utf-8?B?eUhwcmFPZ2l2Ujk4SGlCdHFwcFJjTHhVUUkxb1ZaaHg3V01KSXprT1RCSUpK?=
 =?utf-8?B?V3RFbStiYmFPWHJ1RmJUZmNzbFlLMndCNnRLeGlRNjhHYTVhYmhHa2ZXMlJW?=
 =?utf-8?B?bzVGTUo0dFZoS0hZRHIxbnlSSENiVjVmTDFIYkxCcnJmY0NEZCtZMHNnZFBk?=
 =?utf-8?B?MER5NmY3ZHFSK295S3hRazZobXRCYmpKVDJpRW1wZlZTcUNUTzVSa2dmeVNl?=
 =?utf-8?B?Vk1KeHNOcDZYT3A0cVk3djRlTC9NMkxsT2hwTWNyOUhSQjdnV1k5eklxbXFN?=
 =?utf-8?B?SWdCNVBJTnZLZHJvNlJiTkpDWURMTnhLMUtSSWdDTVpLRUtVT1RqK010enBV?=
 =?utf-8?B?MW0wL2gzMU5ya1RZN3lsWWY4OVJPTWNYTS9tMi9JY2U3aklHb2pnM2t2bDlq?=
 =?utf-8?B?ZG5vUzBSL3BDOU5SS3FiQVB5TVJsb2s3TG5Sc1lxNFRJb0owdFhWc3N3NE1I?=
 =?utf-8?B?ZXZwbmp5NWxBNForWlIyamVFMWZZVkgvZEhzM1c4czFNWmJDYWk5V25lU2h6?=
 =?utf-8?B?TzVKS3h3UkJWcDlrbC9zSmdJMys1aU9TU1dtUVFCOGdraUsveEV2K2d3blJr?=
 =?utf-8?B?NXo0NXEwRWwxNlF5SUx2RlMzTlZkd2MxaHg0NTJNNXhYbUNqSmJaQjB6UkJr?=
 =?utf-8?B?QTRuUVM4UmVhRjBra2c3N05vc0pJVEVTUkRvbmtKa1gyUHdzMTF4bEgvWXBp?=
 =?utf-8?B?OEtoMEswd00xNTFsbDVlTXRGVUE4RlhPRmlyTW5JY1lJenFJdThFeW9WQmVL?=
 =?utf-8?B?ejRnNysyWmJjWHdIb3hsNWtMOUJnK092N0dac21LY2tDck95djg3eFVUSk5N?=
 =?utf-8?B?Y0lWOTF0eWpuNXFWYk81T1BWRWpUTUcvQTR6Z2pOMStYNUIxMGcyeXNuamZO?=
 =?utf-8?B?a25RR0lIT25tckVhQ0xoN1RjeFBoMzNROEV6eld1MDVodDROeC9MQWJXd0hG?=
 =?utf-8?B?bHRrQ2E1UFdkZFl1WWFSdkt2eEt0L1ZtcmVpYlJWS3FLbWhBV040NUxsVjRT?=
 =?utf-8?B?VzJqb0NKaWZ3L1FGdjE1blVBY1o0aUxHd1lmN09sa0g0QXF5V3hESlp0dHR3?=
 =?utf-8?B?aDQydEJLdThTSmtyc3hXOHU2d0Z0NmxTM3VmaGpmMERnM3FrTHJ1SjJMbWty?=
 =?utf-8?B?bEtGS0NxTXhnRUZrMFhWYklyQ0xrMFRLbEVlaUJCUjlGMk9NbDgrU1pHU1pF?=
 =?utf-8?B?OEZxa0p1TCtLaXJEWCtLci9iWWNQczYxdTJ4TmQ1UmtUM3gvSmNWeENpdkZF?=
 =?utf-8?B?ZXUwSGNGN21NSWtlVExzK2lMNnJFYXRMeE94UzJCa2tJMThlRFR6bkVwb2tN?=
 =?utf-8?B?aEgrdFNQWEV5SFBTV2F1SFVGK2ltSjJqZmp6UGwxVEUzZXlLQzNTbC9nd2RQ?=
 =?utf-8?B?aTVJd3o3dmJNOXI5eUxwSGt3RjFBVXUvbVdwcTdoS0xlQmxpYzYxTUs5S2t3?=
 =?utf-8?B?cVlZaGk4U0cxd3FWSzc1RitiZ3RvWnFYSk1BSW9vM0NkVHZaUkR4Qy9OUk95?=
 =?utf-8?B?SWlubFlIR2NZNXEzL09RSVp1OTkvNHljKys1NlptMnZodDhvalJ6ay9ueFYz?=
 =?utf-8?B?NmE1SlB4RFNnR3BvQkEreldFVHo1a2xVNWpIa1B0N3NOZXJMekZQYVU5TEtu?=
 =?utf-8?B?MVV1bE1SQmhhdFFOYlMrZUZQaWhLblhwUk8zTFFXT0VuK3dDMHUwbmp4bWcw?=
 =?utf-8?B?VGRzKzI2RDVaK3ZUOXBHNWY4NWZDdCttVnkxU3RHVmpLR0U3WnVBRmluQkda?=
 =?utf-8?Q?Ni1E=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb622771-3bcc-453c-ef70-08dbfb40ad88
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 18:32:21.2638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gcQDnL1TUB3tZIuxqmDR+UoHsx8OlGjoD3iIzUJ67v0/anX6mHiKwzwwH0dYallpZIvaYrsY0in4BsgXJgfAyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9587

On Tue, Dec 12, 2023 at 10:19:13PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Dec 11, 2023 at 04:58:30PM -0500, Frank Li wrote:
> > Refactors the clock handling logic in the imx6 PCI driver by adding
> > HAS_CLK_* bitmask define for drvdata::flags . Simplifies the code and makes
> > it more maintainable, as future additions of SOC support will only require
> > straightforward changes. The drvdata::flags and a bitmask ensures a cleaner
> > and more scalable switch-case structure for handling clocks.
> > 
> 
> Is there any necessity to validate each clock in the driver? I mean, can't you
> just rely on devicetree to provide enough clocks for the functioning of the PCIe
> controller?
> 
> If you can rely on devicetree (everyone should in an ideal world), then you can
> just use devm_clk_bulk_get_all() to get all available clocks for the SoC and
> just enable/disable whatever is available.
> 
> This will greatly simplify the code.
> 
> Only downside of this approach is, if the devicetree is not supplying enough
> clocks, then it will be difficult to find why PCIe is not working. But this also
> means that the devicetree is screwed.

I have idea, how about add clk name array in drvdata.

such as
      clk_names[] = {"bus", "aux", "axi", ...}
      clk_cnt = 4.

Then use devm_clk_blk_get_all().

Code will be simplied and not too much depend on devicetree's validate.

Frank

> 
> - Mani
> 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > 
> > Notes:
> >     Change from v1 to v3
> >     - none
> > 
> >  drivers/pci/controller/dwc/pci-imx6.c | 84 +++++++++++++--------------
> >  1 file changed, 42 insertions(+), 42 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index 74703362aeec7..8a9b527934f80 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -60,6 +60,10 @@ enum imx6_pcie_variants {
> >  #define IMX6_PCIE_FLAG_IMX6_PHY			BIT(0)
> >  #define IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE	BIT(1)
> >  #define IMX6_PCIE_FLAG_SUPPORTS_SUSPEND		BIT(2)
> > +#define IMX6_PCIE_FLAG_HAS_CLK_INBOUND_AXI	BIT(3)
> > +#define IMX6_PCIE_FLAG_HAS_CLK_AUX		BIT(4)
> > +
> > +#define imx6_check_flag(pci, val)	(pci->drvdata->flags & val)
> >  
> >  struct imx6_pcie_drvdata {
> >  	enum imx6_pcie_variants variant;
> > @@ -550,19 +554,23 @@ static int imx6_pcie_attach_pd(struct device *dev)
> >  
> >  static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
> >  {
> > -	struct dw_pcie *pci = imx6_pcie->pci;
> > -	struct device *dev = pci->dev;
> >  	unsigned int offset;
> >  	int ret = 0;
> >  
> > -	switch (imx6_pcie->drvdata->variant) {
> > -	case IMX6SX:
> > +	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_CLK_INBOUND_AXI)) {
> >  		ret = clk_prepare_enable(imx6_pcie->pcie_inbound_axi);
> > -		if (ret) {
> > -			dev_err(dev, "unable to enable pcie_axi clock\n");
> > -			break;
> > -		}
> > +		if (ret)
> > +			return ret;
> > +	}
> >  
> > +	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_CLK_AUX)) {
> > +		ret = clk_prepare_enable(imx6_pcie->pcie_aux);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	switch (imx6_pcie->drvdata->variant) {
> > +	case IMX6SX:
> >  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> >  				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN, 0);
> >  		break;
> > @@ -589,12 +597,6 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
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
> > @@ -614,10 +616,13 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
> >  
> >  static void imx6_pcie_disable_ref_clk(struct imx6_pcie *imx6_pcie)
> >  {
> > -	switch (imx6_pcie->drvdata->variant) {
> > -	case IMX6SX:
> > +	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_CLK_INBOUND_AXI))
> >  		clk_disable_unprepare(imx6_pcie->pcie_inbound_axi);
> > -		break;
> > +
> > +	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_CLK_AUX))
> > +		clk_disable_unprepare(imx6_pcie->pcie_aux);
> > +
> > +	switch (imx6_pcie->drvdata->variant) {
> >  	case IMX6QP:
> >  	case IMX6Q:
> >  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> > @@ -631,14 +636,6 @@ static void imx6_pcie_disable_ref_clk(struct imx6_pcie *imx6_pcie)
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
> > @@ -1316,21 +1313,21 @@ static int imx6_pcie_probe(struct platform_device *pdev)
> >  		return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie),
> >  				     "pcie clock source missing or invalid\n");
> >  
> > -	switch (imx6_pcie->drvdata->variant) {
> > -	case IMX6SX:
> > -		imx6_pcie->pcie_inbound_axi = devm_clk_get(dev,
> > -							   "pcie_inbound_axi");
> > +	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_CLK_INBOUND_AXI)) {
> > +		imx6_pcie->pcie_inbound_axi = devm_clk_get(dev, "pcie_inbound_axi");
> >  		if (IS_ERR(imx6_pcie->pcie_inbound_axi))
> > -			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_inbound_axi),
> > -					     "pcie_inbound_axi clock missing or invalid\n");
> > -		break;
> > -	case IMX8MQ:
> > -	case IMX8MQ_EP:
> > +			dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_inbound_axi),
> > +				      "pcie_inbound_axi clock missing or invalid\n");
> > +	}
> > +
> > +	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_CLK_AUX)) {
> >  		imx6_pcie->pcie_aux = devm_clk_get(dev, "pcie_aux");
> >  		if (IS_ERR(imx6_pcie->pcie_aux))
> >  			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_aux),
> >  					     "pcie_aux clock source missing or invalid\n");
> > -		fallthrough;
> > +	}
> > +
> > +	switch (imx6_pcie->drvdata->variant) {
> >  	case IMX7D:
> >  		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
> >  			imx6_pcie->controller_id = 1;
> > @@ -1353,10 +1350,6 @@ static int imx6_pcie_probe(struct platform_device *pdev)
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
> > @@ -1482,7 +1475,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
> >  		.variant = IMX6SX,
> >  		.flags = IMX6_PCIE_FLAG_IMX6_PHY |
> >  			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE |
> > -			 IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
> > +			 IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
> > +			 IMX6_PCIE_FLAG_HAS_CLK_INBOUND_AXI,
> >  		.gpr = "fsl,imx6q-iomuxc-gpr",
> >  	},
> >  	[IMX6QP] = {
> > @@ -1500,30 +1494,36 @@ static const struct imx6_pcie_drvdata drvdata[] = {
> >  	},
> >  	[IMX8MQ] = {
> >  		.variant = IMX8MQ,
> > +		.flags = IMX6_PCIE_FLAG_HAS_CLK_AUX,
> >  		.gpr = "fsl,imx8mq-iomuxc-gpr",
> >  	},
> >  	[IMX8MM] = {
> >  		.variant = IMX8MM,
> > -		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
> > +		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
> > +			 IMX6_PCIE_FLAG_HAS_CLK_AUX,
> >  		.gpr = "fsl,imx8mm-iomuxc-gpr",
> >  	},
> >  	[IMX8MP] = {
> >  		.variant = IMX8MP,
> > -		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
> > +		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
> > +			 IMX6_PCIE_FLAG_HAS_CLK_AUX,
> >  		.gpr = "fsl,imx8mp-iomuxc-gpr",
> >  	},
> >  	[IMX8MQ_EP] = {
> >  		.variant = IMX8MQ_EP,
> > +		.flags = IMX6_PCIE_FLAG_HAS_CLK_AUX,
> >  		.mode = DW_PCIE_EP_TYPE,
> >  		.gpr = "fsl,imx8mq-iomuxc-gpr",
> >  	},
> >  	[IMX8MM_EP] = {
> >  		.variant = IMX8MM_EP,
> > +		.flags = IMX6_PCIE_FLAG_HAS_CLK_AUX,
> >  		.mode = DW_PCIE_EP_TYPE,
> >  		.gpr = "fsl,imx8mm-iomuxc-gpr",
> >  	},
> >  	[IMX8MP_EP] = {
> >  		.variant = IMX8MP_EP,
> > +		.flags = IMX6_PCIE_FLAG_HAS_CLK_AUX,
> >  		.mode = DW_PCIE_EP_TYPE,
> >  		.gpr = "fsl,imx8mp-iomuxc-gpr",
> >  	},
> > -- 
> > 2.34.1
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

