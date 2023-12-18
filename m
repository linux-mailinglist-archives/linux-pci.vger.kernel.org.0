Return-Path: <linux-pci+bounces-1142-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C617781738D
	for <lists+linux-pci@lfdr.de>; Mon, 18 Dec 2023 15:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF95F2843F7
	for <lists+linux-pci@lfdr.de>; Mon, 18 Dec 2023 14:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A7D1D12A;
	Mon, 18 Dec 2023 14:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eC9ZQRSC"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2051.outbound.protection.outlook.com [40.107.20.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E41129EF9;
	Mon, 18 Dec 2023 14:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=guPuoZQgWrR884Xih2DpRn2bypaXZHednUFuSXktJFPbeB3xUf432xQWcmvSUdP+77ESin+sqg5GijKfqTUsdyJwqD1aHrOnAEhQKFg3v7oaOCD9FgSpGuxNPslHxSGXLfRzrmsabK4Unauvjm+J6fivlK3nkL7cS67pL8btjbTJzsfaQOa6y0vHN6Rox8Pc4xPRndhkpEHO6eggAiT+Q1tSzSFfQltHBgL4iu7DZO/S2PllMz7XSYmxusc++yRzz39X6KP6IKbtXAe0Etu3HhJ0U9I/dqVbebMYz+RCVma+yKC9De+KVlkEpTdRmhBQDksrYsKBzsayA4+A8XJOVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrRpNMUEDerZbEzLcy8MMzZlREfAWUm564S5exPA2Vk=;
 b=GL8p7+7OzONSBrmiy26e2A/13qTIua0FcJGWl2MkIjuZWExKJ9CHpDEMID4PlbxF7mTagstA8yk0HOQ9jlhK2IAaysT9iDvgm8bbEvY1ZJjVUUpiuj3z1FAYCyS4VmAHNuAyU4yX6ILrWJSgKWVsZQu3eRHPIr3e8j2TttGvRZG0lP6rQwB6GhZ/nJ/zDlJo/45UH1VkvnuZ4HDBoEwUmcUwzo+OGG+ZdDMlysuwaeh+OLLXucC86cIdBunnBhQuR5OItVMUgezgBaCJ/Q3rTeseWWWnb5ESwWNLVJBhOqsc3a4Et+NZw4vZs3mi68BlH4EEKlcMccwc6w4raI+Few==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrRpNMUEDerZbEzLcy8MMzZlREfAWUm564S5exPA2Vk=;
 b=eC9ZQRSCF4gJMwMDfgOJ6Pmz9GOJfUPgNikCrXDK27YKwjFOfiTJVACLX2391X4p+aCwnv4qbmegpI9hPjFg89BkEhdl+RTWr5ubRu/q/An21XAlzNVpXVzlJNtabyov2R+vIRNCaq+QIHkUxlHfTwEcMGSZmjI6S5zeOZjsxTU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB7624.eurprd04.prod.outlook.com (2603:10a6:20b:291::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 14:28:44 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 14:28:44 +0000
Date: Mon, 18 Dec 2023 09:28:33 -0500
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
Subject: Re: [PATCH v4 01/15] PCI: imx6: Simplify clock handling by using
 bulk_clk_*() function
Message-ID: <ZYBXEaUcNuKDswux@lizhi-Precision-Tower-5810>
References: <20231217051210.754832-1-Frank.Li@nxp.com>
 <20231217051210.754832-2-Frank.Li@nxp.com>
 <20231217170655.GC6748@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231217170655.GC6748@thinkpad>
X-ClientProxiedBy: BYAPR06CA0003.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::16) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB7624:EE_
X-MS-Office365-Filtering-Correlation-Id: 293c8db0-1435-4bdc-df50-08dbffd5a368
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LiygWHOWjErvLoQ3n+JxwsEtZxvOnOr9EAxphYWc41ZSokxWazvyiSDgj5GfnNFF/nrwcmN3R7Q3Ch3Ehn+xbWw4PIo+1F9qnZRiZnwR5WsfQISyY91dSr8gBvgWYCPG8O5cwnGDip0DfBuZ60aM95h86OR00NwfUU3SX1nZLNpyvFVV8uYeycSeGmf7t/mknvcHkS176T7Ab5R/7ewNdKBQEdSEGvFG3gmD/gScry8G4ZZwh+jwUug2X+hdiVBsgnrGPI6FMccCHJ0wm0eJ/yiT3kaDrpb13YdbRGHtyXj12n68fy6U5S3XeaRV6hPX0cqT+pJz2+w/TnCNN9M0s0EVtO4131PSDl8Eg+1PwT0EtibDAoVHtUAA+Z6o+aARVRSNYh2AOaMUM1qLwmSU/GgCrLDC1vhSr0yXBOp9XAK2PdKj3KSC3h43nIUBrVpI9d6oBj4/QaCCFyZt6K3+++4MdA3mWafkFuqD8HgKKDMKQ7Zl9WgJLA7Q7KXPS/AVDAejwA37HuYGdPAN2Yvb8G9/H9TXUA0IBRxa+2F6Gu9w3yw6t1Lvr2MScA1aEfVNMruEtLz3v5tS8FgF60thk4iBheZFHzgwV5NN+DVnFEIaykGg+bax7tgzIXm+RJzp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(39860400002)(396003)(376002)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(26005)(38350700005)(38100700002)(86362001)(83380400001)(5660300002)(9686003)(6512007)(52116002)(6506007)(8936002)(8676002)(4326008)(316002)(66556008)(66946007)(6486002)(6916009)(66476007)(33716001)(41300700001)(2906002)(7416002)(478600001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blVhTVZVblY1YXcxdzRoTVJHczJqeHNFajcrVFczOTB3czdNdGlub3FjTkNu?=
 =?utf-8?B?Z3BCNXlNNjdwUzZVbC9mRG9GWmRzeGtiMzE4aVh3ZlJlS3NUTEVoWm9BVDJr?=
 =?utf-8?B?YmU4d04rZ0JBaU1JSkNBaDZBRTFSaDhLb2NzQXpteWRQQk1XSlp6bkxZeUxS?=
 =?utf-8?B?N293aHN5b2JjVnNiRklJYXVZdEZQR1owYklPMDB6dFlSeHBpQlV6N2lFWW95?=
 =?utf-8?B?dGxIT0lTb0FIb0xZK1lCOENpbXAzdHBQS2JyL05LbVBJMzAwYm9lMVRrRXNv?=
 =?utf-8?B?TkJtcjNaRlZaZGhzdmFBRmt6czZwRUVVMWVWKzRkcGpyKzF4L0JQTlZzd0lm?=
 =?utf-8?B?UTd1dUZKekJPL2toc2ZkUkVJS3FNREVMYU5OS3F3VjdtRmordG9uWFNYNW9B?=
 =?utf-8?B?dllTU0xlb3dKa3FrWUNORlRpK21RUTQ2Ri9KSUMyeERPb0xxUnhJNHBCK0Y1?=
 =?utf-8?B?YVQ5YjhTWUdOaTVraXE1cWhLSHBiL3d0TFpDRmpWYzZiTHNka21DcElmZTFN?=
 =?utf-8?B?WjdtNnFCQjczSTY4cnVMSGRvNUovcG5ZdVk2UHFBcFJBTlY1TzZPdno1LzQx?=
 =?utf-8?B?WGpSOVFKM2MxUktDelI1endrMDJabTBmMGZnTmZtN29WZDdaaHkxUjh3K0dY?=
 =?utf-8?B?S1B2TkMraWQveWF2VDlDNy8xYkpUd2lnbUs2UUppNGFCZ3dIVkpNMUhTZDlW?=
 =?utf-8?B?Z3FFOVZSU2tvZFdybGxtMldxNW4zS2Z5WEgrakFpN255OXpFdzM1K2svTWo1?=
 =?utf-8?B?dmc2UFhEazJta1o3a2VxcXJqYXlZdEFGaDRQNTAybERPZ29iUDVpRFRyRjJE?=
 =?utf-8?B?TS9rTkx2S1BpQWZqZnNOdHlpa05JUFNEOHorK2g0MjBmcG15VWYrZFF2aGxP?=
 =?utf-8?B?dnljMk5QN3B1OVAwYTY3aFFZQ2gvN2RGSDFFdjNMMFp5ckhyS1FkZ3hIK0cz?=
 =?utf-8?B?bExtTUR0UU12cUFGOGpzMHA3UWpQbnNyQWROR29QWjZXQjRnVFNlMnd4T3pp?=
 =?utf-8?B?U0YwMm1ydFdoSDYyY09qdHpqalJWZHJUazRzZ3UwV0xrNHRVS0ZDNUpRRVdQ?=
 =?utf-8?B?eHlqS041RXhxRzRIU3NjV256SWkyU2FCZGptTG4zRjEyem1rT1lRN1ZwdHFL?=
 =?utf-8?B?dWJxbC80VkZpdFBwbG83SzBNN2UxNDAyaWlVbmRiSUxiZXlZNEJqQ2dBZjV0?=
 =?utf-8?B?WksvdWxUbndyZmNhMnh6UFhZU0NXeGZLRVNzWlJJVjBWTXd0c1ZWdFE0WkRv?=
 =?utf-8?B?Y1ZZUXBYVFFFdVZEdUdxNUYwOUFrZDF6S3ROMWRwWmZyaTZrNWhjMmsxZ0Nv?=
 =?utf-8?B?WVh1SDRZV0VvcURQTFBSUWtQSlFPU1h3UUFCMVBaYlJjODNIWTQ1eHFROVow?=
 =?utf-8?B?cjhjM2xSTlV5KzdMOVdEOUVxSEZaK0hxNW1EMHNsVFo4eE9pbkJycGpBNzlM?=
 =?utf-8?B?ekxveElqcTZEUXhBN3hYNU5WRFZ2eGtWWldPMStpWGZoTnF6cHVwUnoxZGh6?=
 =?utf-8?B?MC9tSWdDUFU0NUtmMHNkek0rNmZhc1o1RldxTTI3dkxTbGI0eUxubExLK0R2?=
 =?utf-8?B?c2RJZGdhR3Y1TWpwWm9qN0RFcjBPQVpZVFhyd1owS0VScHJNeDRRc1lLc3A3?=
 =?utf-8?B?MFg4YTUwbHJMSUNrWnltS3lrT0xuc2ZzaC9YRENrbnYzZDZ1QW9leDl5Z1Vu?=
 =?utf-8?B?dVFWUUtZTkJtdWpIQ2d1Y0gzRWd3K216Y3NXamdiaHE0OWdMbVQ5b3p4KzM3?=
 =?utf-8?B?NHZra0lUMlJObDRuQUQzeHBpM2l3cHlVRzhMbDFLMEtTUmx2U0FrVk02RmVI?=
 =?utf-8?B?RHZIMG9ibjBGV0JhalluU3cxNWJjWGszMEpoaUJUV2RhbGpML0dLMGowV3ZN?=
 =?utf-8?B?SGRQODR0RlplWUJkdzA1RHBCVE8wK2k1QVlHd0Mvb1liVmpQcGNhdTFHZWRB?=
 =?utf-8?B?Qy9HUk10MkpoSG5Td0NFYk9kU3RueGZ2aDFEaVE5MXFKRmtqU1ZzUDJvRllD?=
 =?utf-8?B?ZDEyc3JleXMzUE4xbWg4MFMvZ2JLS0FlTm5zWkVDWi9nR3hwZXdFb3hWUHlh?=
 =?utf-8?B?Ly9LcUFDcVcrbElXcXN4OVdNNVV4MTNYUTVaNGpzV3JVT3lXd1I0SWtybkhF?=
 =?utf-8?Q?rLdg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 293c8db0-1435-4bdc-df50-08dbffd5a368
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 14:28:44.1135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: didtamXe48aLTRo9g1fkkf6OpXA5K1CkUE3jOSmvRWq4Wx0Hb0232z8SADy1gOacJG+9i8FX9LpGQqakUYgIqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7624

On Sun, Dec 17, 2023 at 10:36:55PM +0530, Manivannan Sadhasivam wrote:
> On Sun, Dec 17, 2023 at 12:11:56AM -0500, Frank Li wrote:
> > Refactors the clock handling logic in the imx6 PCI driver by adding
> > clk_names[] define in drvdata . Simplifies the code and makes it more
> > maintainable, as future additions of SOC support will only require
> > straightforward changes.
> > 
> 
> Commit description should be in imperative mood as per
> Documentation/process/submitting-patches.rst:
> 
> "Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
> instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
> to do frotz", as if you are giving orders to the codebase to change
> its behaviour."

How about: 

Refactors the clock handling logic. Adds clk_names[] define in drvdata.
Using clk_bulk*() api simplifies the code.

> 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > 
> > Notes:
> >     Change from v3 to v4
> >     - using clk_bulk_*() API
> >     Change from v1 to v3
> >     - none
> > 
> >  drivers/pci/controller/dwc/pci-imx6.c | 128 ++++++++------------------
> >  1 file changed, 38 insertions(+), 90 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index 74703362aeec7..2086214345e9a 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> 
> [...]
> 
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
> >  
> > -	imx6_pcie->pcie = devm_clk_get(dev, "pcie");
> > -	if (IS_ERR(imx6_pcie->pcie))
> > -		return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie),
> > -				     "pcie clock source missing or invalid\n");
> > +		imx6_pcie->clks[i].id = imx6_pcie->drvdata->clk_names[i];
> > +		imx6_pcie->clks_cnt++;
> 
> You can just initialize clks_cnt in drv_data with sizeof() of clk_names.

sizeof will return pre allocated clk_names size, for here, it should be 6.
Not initilized string cnt.

or you have to duplicate two line 
	clk_names = {"clk1", "clk2", ...},
	clks_cnt = ARRAY_SIZE({"clk1", "clk2", ...},


Anyway, it need copy to clks[i].id, count here is simple.

Frank


> 
> > +	}
> > +
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
> > @@ -1470,6 +1405,9 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
> >  	imx6_pcie_assert_core_reset(imx6_pcie);
> >  }
> >  
> > +#define IMX6_CLKS_COMMON "pcie_bus", "pcie"
> > +#define IMX6_CLKS_NO_PHYDRV IMX6_CLKS_COMMON, "pcie_phy"
> > +
> 
> Just use the clock names directly instead of definitions. It makes the code more
> readable.
> 
> Rest LGTM!
> 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்

