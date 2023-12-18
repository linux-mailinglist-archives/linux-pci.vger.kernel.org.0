Return-Path: <linux-pci+bounces-1143-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3348173B1
	for <lists+linux-pci@lfdr.de>; Mon, 18 Dec 2023 15:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49624B23195
	for <lists+linux-pci@lfdr.de>; Mon, 18 Dec 2023 14:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48A31D14B;
	Mon, 18 Dec 2023 14:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="idZr8iGz"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2E7372;
	Mon, 18 Dec 2023 14:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EgEslye4mLP0FqN339qha/DPYQHVMZDMaLWMCsjn0jv4OGrc62+aw3QIfrCmuQYE7uFTNjOeFw8z6WsO3n6K00O43DA1kg0JI3OoM73zjMl6INGRpsq2qJDW3GiDoOCUZBl9f0pgbS0J+J+ZjzRwGoZiFTogstSFhuMgrwNt6gGAk3UQfh51oRi09f0tRiVeMF5xvt0Zkq1RQ34oNH8hmsCH4iEi6mM3KAK/DTpmMr0W4QawwQwVltSauQX+tA0x/gtGQQnbLlruzjc7VZ2A6WxhnTdJaQ9LE3ICE2kB3iAa/oaq1GA9Une853VbecsWmrd+YFkKP70jLzWNs2i0eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACcDHXfw0i5H471Pjy0kZyOXERyNDRLEt7uISdz3rIc=;
 b=Lqf5dueUDWAC9ww2wcjrPU3xIozUMBAgqykz/OizD/xBRJUi8k4JQTxvoLC63Qe0MYMUbVa6VFMDY2RscELaI/hXrPtpP80uMOzsVWSsnpsFuykn3iiZJm/mDiXlKPhFHr8J8MVovenOCgQcL2srG//xPN60+Ht6UvWTEyXqj+OSc2dyIxq1/MoDLHJDaoIns8eDbfLhnhR29kNCX+aunrdo7eWSgl7+Z26MxInwuT8VS5tF9NSAAXsb2zaFuCFQxXLD/1KXDhCHfRf6tWTxGx3d1lldbuIFItuxUrimQ0EMZOsiaoG469qXq8rxMCQsTOqfCqlo/uhaqGVekeUlVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACcDHXfw0i5H471Pjy0kZyOXERyNDRLEt7uISdz3rIc=;
 b=idZr8iGzlgj0qNPunv6Tb3grgzTVYtasVZchoc2iKtzsBr6HYLIOh72cAy7gTWuVyhe8cyy+5rcnEZSemyW1qc8UXaxiUd8FjlWGjdAD7u6VMIu43f2h93MLwFGnlZp8NVDXLdSvcbEpGqS16U0dadHfgDDIXq1dCzP0C/o0Ex4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU2PR04MB8920.eurprd04.prod.outlook.com (2603:10a6:10:2e3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 14:35:43 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 14:35:43 +0000
Date: Mon, 18 Dec 2023 09:35:34 -0500
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
Subject: Re: [PATCH v4 02/15] PCI: imx6: Simplify phy handling by using by
 using IMX6_PCIE_FLAG_HAS_PHY
Message-ID: <ZYBYti+6So+tXhp9@lizhi-Precision-Tower-5810>
References: <20231217051210.754832-1-Frank.Li@nxp.com>
 <20231217051210.754832-3-Frank.Li@nxp.com>
 <20231217171811.GD6748@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231217171811.GD6748@thinkpad>
X-ClientProxiedBy: BY5PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::16) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DU2PR04MB8920:EE_
X-MS-Office365-Filtering-Correlation-Id: cd7bb8c6-8e97-4e5e-4287-08dbffd69d67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	x9rff7Zj/+ZAgXyYkBw264sGOk5N0l3YTYhbtMq9lDB7jgUOCDEHghjj+P2XlvWCy4FzmOUFm5HjfHSZ82ChRyIgbyBNqcH9jeoy8rERwJXlwgw5xV8MwkYUIIorPuShS8yBjW4+pBUhglY+RtPy3BYyaIhmEVmtgIVJJanwEkOZeXbxzUoRLF6kvEdBa5VzqXwiw3LhYd3vsZBqm7WDQ4XhdRCRFUlbfCeIwDpUaExAXC/v1FnDZOGT0ZSX5wo7X4xKyQkOktVVNcAISGXHKA5MM402uhX78ai+94nHRjtdnPB9ZAWA3Mjfyz7BXFnWoNO3eJ9ywm9g1d1QRTAb8AYLcZVUzJHl2bz/QNOUwj6B6Jw8ashOXJGXL3RaHwtsUoPFyTMdfuUQwDgKAnZUWc+2NlcMbSAsgeVUdGKDyBafAr/IGL5AIJgBK14GErfu7Jk6Vs2yeaCAhEbup5Az2sCpMLeztVlB2jK12TK91ZTLBnR6YzQElb95VBoefU+Bn6DGBNrbUxzToyYcgUYnZfF6X+yuYZIS1lftDTTVSx2dKoYeqs7vk3tMAkx1lY+6V3rOgwMHvCSsJP3uAfVv8kFXyJG6CrT9vQ5xGAKUQkJW6kwGocUbOuR/s44KuE91
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(396003)(346002)(136003)(366004)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(52116002)(33716001)(26005)(38100700002)(8676002)(316002)(66946007)(2906002)(5660300002)(8936002)(4326008)(41300700001)(7416002)(478600001)(6486002)(6506007)(6512007)(6666004)(9686003)(66476007)(66556008)(6916009)(86362001)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YTZwVWhNd1NkdEw0anNNNkJwVXVXWi9mcUpDL1hzY2Y5NDlJNTJocVFpaVRZ?=
 =?utf-8?B?NngyUThHWEk1L0paYWROZGRsRnAxSEN0QlZQYzNzYnZmM0dSelJwRElEMzlC?=
 =?utf-8?B?R1hnK29HczZjQk9HR0lsZEJzd24xRFZBdEsySzFhbGp0U1NBNklZcExNTjVM?=
 =?utf-8?B?SU9DSmd2dmhaQ1ViR0lqQ1Vjc1hsSm9vejBHVldXN0FRNEdmYm5udlBKOE5I?=
 =?utf-8?B?ZmxKazdnOHVoMXR0UGdpL2hsc0M4WGZLbkw1a3dBMVpZbEhCNEV2OWVXaERh?=
 =?utf-8?B?WCtjYXR3clNWTzVodkxYYWlxcEpyWjNXa0VhVElHK0x3RFgrbC9TVmQyOUxL?=
 =?utf-8?B?YWRJWE4zV014dmxiQUZoNmRTTzJjRktTN2FOSlhETEx1aVVkWkJ6YmZPeTh1?=
 =?utf-8?B?d0Q1VDBDSFpVTTh3VXVVZHJFV2pOV3BSZ3Y1cUo5SHU2TUUyVVhlTTdRWWlp?=
 =?utf-8?B?eUhwMEYyVWtMeXZZaWpIZVpLQjRPa2VqanJ5aFliYStDcGp5RTg2Z3dPVFV2?=
 =?utf-8?B?UDNGcjNsSnpENXBCQTAySzFBQWVqcXBRclJrYmNIT0g5Z3NQZi9DaSsvc0Rp?=
 =?utf-8?B?aDdLS0lSZTZ4QTEvZkRCN0FQN0Jtbk5mdTZHMDcrZFRXeHhBalRwUk5rSXZw?=
 =?utf-8?B?bnlMK3QycGdiT05rNCtzZnIvbktseTgyNENoR295UnFQRHUrNWpwUklCeGF4?=
 =?utf-8?B?MkNXTXRvSU8yNmIyYm9kQ1o3SEhwS0pUelNkZVRPckErVXVSdXNXVEhwWUdv?=
 =?utf-8?B?VVg3U0VXZ0c2M2NteTZSeXprdWNEd3IzbDhWVDJpZEo3OEFnL21STE11S2cy?=
 =?utf-8?B?MkxPSGhmN0RENlZQbTdTdENMMzI1ZWc4cFBqVlZWREo5RHBmR2pkOXpLb2VC?=
 =?utf-8?B?Q3E0Y0NMMW9jdm9Oc2NQbUZGTmZCeTluck12ZG5rZVlLK2R4Z3BRL3VoeHhy?=
 =?utf-8?B?Vi9ERHVtakJaUWIxWkJOSExkb3VHd1hyRklKa1ZxWmIxUEExSkc1aHhPYnVq?=
 =?utf-8?B?QXo2Y3dtbDlrcDVxeWZhUTNvYlZYcXI1bEk0b1FVNy9ZZk1jNHRydURLZnVp?=
 =?utf-8?B?VGN4Z1BteW14OXhrQjNYMS9obFhBM0pyT2dWZUVrbXBjVlZod2Q2MDY2QTkv?=
 =?utf-8?B?Y0pSYTNWTEt0Z1cxdW11eGEzS0o1YXFMSHpvRUNFaGw0K1FnYVFsNU5SRFRY?=
 =?utf-8?B?VW1kamltK3pLMURzRWxhU0hWdFdIWmk1UnNuekdWbkZObGpVbUwwVE4yZE1v?=
 =?utf-8?B?QW40UTZuWlJlNFcrZkdWd0lTdjUxOWtRekJRekpBWGZNNTl1VzZFSll2eWNW?=
 =?utf-8?B?amJUL1hUQWVXYWtidjR3Q1RtQUJ1OFJBTE5EOVRoY3ZWa1MwbFUraTJlSnBm?=
 =?utf-8?B?dmZuSHk3VmdrTExVUE1WZFlRRVAzdWlOVnRQVDZDNzZPS3RqZjFnQlJqMzEv?=
 =?utf-8?B?TjdkTkRXVHkvSXhhZU4rM2w3d1M3OW5wWUIrRCtleWh5SFJFbFNqK3RnN0dV?=
 =?utf-8?B?enNuanlIL2dnTzB4Z2pESytaRnZGWTBlUWs1dHVxZmg3U2dhTVFpNXRDb0VC?=
 =?utf-8?B?SUQ5Vk16dXA2TUV3bEk0Y0V0TnIyQ1Fzb20zNllnRkE2WXBiVmZnTlFkRHlu?=
 =?utf-8?B?ZWtkRWlieU1NZFRpZnFTS3MwSjlKNTJtbzZiRTdlVURXSmpNSTgrVWVWT1hx?=
 =?utf-8?B?R3VhZ0dVVDh1REp5bk95b1FxR0JtVU94RmM2SEdTblhTYmY4MEhQRlVLVEp3?=
 =?utf-8?B?RE1xY1NySUwzN0tQVmJaSUVpRkNINi9nNWZJQW55dHNGMHpsa3ZIYS83MW1p?=
 =?utf-8?B?bVFYYzgvKzFsMk95NW9RbXExeFlSZkNxd05qck5Zdktjb0dPVDA5ZWw1QllP?=
 =?utf-8?B?dWo1cCtpbHdqajZEVTlGVHFPbG1qWEpVTGUvbTUwcGFLTVBRY1JBU1l4ejlL?=
 =?utf-8?B?eVFST3E4bDZjcm51V2YwNnNUTWUwWDUwRFVWTVRISGZOaE1qUy90WWowYnND?=
 =?utf-8?B?RGdZbU9ZVEQ1em5GZVlyMFdsUHBPWDFtVEE0d3lvY1loK1hnRy9TUy9yS1Vr?=
 =?utf-8?B?MFlYdVZzWG44NFFMVTI0UnJycVpWRnpOVVZ0UUs2MHRDUWFvazFZaXFhenFW?=
 =?utf-8?Q?sM74=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd7bb8c6-8e97-4e5e-4287-08dbffd69d67
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 14:35:43.5064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DN5a5qrieqDg9MnJCFHgk2pScrQJY3hirmgm9+2wpQwwVXRgpH11q8wLNgHjXJNumGKt8iJbugOXgDj6j+a65Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8920

On Sun, Dec 17, 2023 at 10:48:11PM +0530, Manivannan Sadhasivam wrote:
> On Sun, Dec 17, 2023 at 12:11:57AM -0500, Frank Li wrote:
> > Refactors the phy handling logic in the imx6 PCI driver by adding
> > IMX6_PCIE_FLAG_HAS_PHY bitmask define for drvdata::flags.
> > 
> > The drvdata::flags and a bitmask ensures a cleaner and more scalable
> > switch-case structure for handling phy.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > 
> > Notes:
> >     Change from v1 to v3:
> >     - none
> > 
> >  drivers/pci/controller/dwc/pci-imx6.c | 23 ++++++++++++++++-------
> >  1 file changed, 16 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index 2086214345e9a..91ba26a4b4c3d 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -60,6 +60,9 @@ enum imx6_pcie_variants {
> >  #define IMX6_PCIE_FLAG_IMX6_PHY			BIT(0)
> >  #define IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE	BIT(1)
> >  #define IMX6_PCIE_FLAG_SUPPORTS_SUSPEND		BIT(2)
> > +#define IMX6_PCIE_FLAG_HAS_PHY			BIT(3)
> > +
> > +#define imx6_check_flag(pci, val)     (pci->drvdata->flags & val)
> >  
> >  #define IMX6_PCIE_MAX_CLKS       6
> >  
> > @@ -1277,6 +1280,13 @@ static int imx6_pcie_probe(struct platform_device *pdev)
> >  	if (ret)
> >  		return ret;
> >  
> > +	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_PHY)) {
> > +		imx6_pcie->phy = devm_phy_get(dev, "pcie-phy");
> 
> Can't you use devm_phy_optional_get()? This will return NULL if the PHY is not
> defined in DT. So you can use IS_ERR() to catch error if there are issues in
> acquiring PHY if defined and NULL can be safely passed to other PHY APIs like
> phy_init() as well.
> 
> With this, you won't need a flag in drv_data and can also get rid of the
> condition around PHY APIs.

The key is the driver need know which platform "pcie-phy" is manditary. 
devm_phy_optional_get() can work if dts is correct. use HAS_PHY flags just
double check if dts correct add "pcie-phy" at dts.

This is just one place to check. and Help debug dtb miss match issues.

Frank

> 
> - Mani
> 
> > +		if (IS_ERR(imx6_pcie->phy))
> > +			return dev_err_probe(dev, PTR_ERR(imx6_pcie->phy),
> > +					     "failed to get pcie phy\n");
> > +	}
> > +
> >  	switch (imx6_pcie->drvdata->variant) {
> >  	case IMX7D:
> >  		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
> > @@ -1306,11 +1316,6 @@ static int imx6_pcie_probe(struct platform_device *pdev)
> >  			return dev_err_probe(dev, PTR_ERR(imx6_pcie->apps_reset),
> >  					     "failed to get pcie apps reset control\n");
> >  
> > -		imx6_pcie->phy = devm_phy_get(dev, "pcie-phy");
> > -		if (IS_ERR(imx6_pcie->phy))
> > -			return dev_err_probe(dev, PTR_ERR(imx6_pcie->phy),
> > -					     "failed to get pcie phy\n");
> > -
> >  		break;
> >  	default:
> >  		break;
> > @@ -1447,13 +1452,15 @@ static const struct imx6_pcie_drvdata drvdata[] = {
> >  	},
> >  	[IMX8MM] = {
> >  		.variant = IMX8MM,
> > -		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
> > +		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
> > +			 IMX6_PCIE_FLAG_HAS_PHY,
> >  		.gpr = "fsl,imx8mm-iomuxc-gpr",
> >  		.clk_names = {IMX6_CLKS_COMMON, "pcie_aux"},
> >  	},
> >  	[IMX8MP] = {
> >  		.variant = IMX8MP,
> > -		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
> > +		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
> > +			 IMX6_PCIE_FLAG_HAS_PHY,
> >  		.gpr = "fsl,imx8mp-iomuxc-gpr",
> >  		.clk_names = {IMX6_CLKS_COMMON, "pcie_aux"},
> >  	},
> > @@ -1465,12 +1472,14 @@ static const struct imx6_pcie_drvdata drvdata[] = {
> >  	},
> >  	[IMX8MM_EP] = {
> >  		.variant = IMX8MM_EP,
> > +		.flags = IMX6_PCIE_FLAG_HAS_PHY,
> >  		.mode = DW_PCIE_EP_TYPE,
> >  		.gpr = "fsl,imx8mm-iomuxc-gpr",
> >  		.clk_names = {IMX6_CLKS_COMMON, "pcie_aux"},
> >  	},
> >  	[IMX8MP_EP] = {
> >  		.variant = IMX8MP_EP,
> > +		.flags = IMX6_PCIE_FLAG_HAS_PHY,
> >  		.mode = DW_PCIE_EP_TYPE,
> >  		.gpr = "fsl,imx8mp-iomuxc-gpr",
> >  		.clk_names = {IMX6_CLKS_COMMON, "pcie_aux"},
> > -- 
> > 2.34.1
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

