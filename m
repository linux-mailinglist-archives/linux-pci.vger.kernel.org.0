Return-Path: <linux-pci+bounces-623-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6AA808E41
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 18:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 725491F2139F
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 17:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216FA481CE;
	Thu,  7 Dec 2023 17:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="epyusAK9"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2049.outbound.protection.outlook.com [40.107.15.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A9ED1;
	Thu,  7 Dec 2023 09:10:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TT6dbbRiiQphh6hwnVPHr+Rli4XUxh9DzFKSv0gEKccCsjFZ6e5PkqKBHU8RyZjTUHiSUjjBBRVFmsJALE88+h1UrkmNE8qsLt2psvXbqE0+1R4DFoshwFGfoK0BtrlfxMXCTWXzwztlHewgjnfzxqagrxhYVJFICQRXkDhVCiG162ENlNdlGqql1FGOAXw6tce1v7Q578AmRoaQLEkZNGrmVXdCPndXNGh2nH11SLDVMgW1D5RhkymcC7wMVS0qFX+mgRnXD2A6BtG1JHAqLfSJPz5SrhR8HObD6EXAKkhxgOaDDsKGbt4k3U5QMrOdF5253/tVjw43xkq86kSLGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4ASWcLwLESKY9+tSiJJJlWJrv1TwoTvaX3YMBq+SFs=;
 b=GKqyRjWEUUcaqq53HeBJBT5pcQMMraZNAZp9jgtBPBZeRbqvfCgbmBp2MSmrofHmhKK0sgikcnsGjq4JgAFhyMUhvWGL422LSdRjn9rV4UlYwfQ+hjYsjKaK9/HJVEVD8BPNzdygQnTgTBd/5GL/hY6oWUKmIEbcJrpDq4mVDmhh+bg814eWe0lwTPitvbhdNOA2Gbbj12LqnxYv770nSLTcR5j+gPHfALNZEkneX+/f+Pic5RHiftXImSBfGzg/0QihsqQmJtuq81EDoAWT8OoZyWkkZWmT9P6jNaAMfDypJ8/Xc4wynLl3dN3Wp5n9nD7fz++5PKsfGDn2tHvXtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4ASWcLwLESKY9+tSiJJJlWJrv1TwoTvaX3YMBq+SFs=;
 b=epyusAK9WeYJlmi/EcZ7vtokvPECJ1mCynG5SJisQOu7Iqm3aK1xiynFk+W+73szcvfB3/tjKUx8uw3zIDLRfOM23OPEQBEMvGOoAneCuKwioq3pJOVmtzxsBYqduwvMx/SF902whu29/XbqeuBPNlVSgnOXoGWYF+DKbFR0kNo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB9423.eurprd04.prod.outlook.com (2603:10a6:102:2b3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Thu, 7 Dec
 2023 17:10:36 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7068.026; Thu, 7 Dec 2023
 17:10:36 +0000
Date: Thu, 7 Dec 2023 12:10:26 -0500
From: Frank Li <Frank.li@nxp.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: imx@lists.linux.dev, Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	"open list:PCI DRIVER FOR IMX6" <linux-pci@vger.kernel.org>,
	"moderated list:PCI DRIVER FOR IMX6" <linux-arm-kernel@lists.infradead.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/9] PCI: imx6: Simplify reset handling by using by using
 *_FLAG_HAS_*_RESET
Message-ID: <ZXH8guDh+pLbg0Tn@lizhi-Precision-Tower-5810>
References: <20231206155903.566194-1-Frank.Li@nxp.com>
 <20231206155903.566194-4-Frank.Li@nxp.com>
 <e314466b31dd8e88212ae5d7ac2fecf26b851829.camel@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e314466b31dd8e88212ae5d7ac2fecf26b851829.camel@pengutronix.de>
X-ClientProxiedBy: SJ0PR05CA0053.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::28) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB9423:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f34e547-4264-4559-1912-08dbf7476dca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gDG1HG3hXcj1T9Y4/Zh4PeRGS18/W/fBq4wFK84HrlyCSwYtf6sQseClmz/h2FWvnnul7jB5PC4toLOCiar7k+0Vny88YOX17kLsyJZ5zw8Nc2G7Y0dSkwfIGMJDuXSwQXHVS7WO28OvaImAW/A00OA2suf0gKWwmdpRqFMzGF3fczelBbdlOcD8xULwPdkUTVUNLSmBjAY6BekTPQhXn52so1JqkoiML9XxMUQmyEf9a3GT/rqnv0V8FoYHeard8WBlnsTLMi3Bmo9Sq/YNhbTsIHYlH3wVu2y+cqMR4Z1vjzDGOIOgd92S5JCfix1fCHyraE8pQq9VIX6oe0IlQ9jG3A7aWcBQKlHc1EQXG8njfMK858UZPhzILFduugJwjgj/s5qAbfwhnDh4t09LyQ3eEMDBsR0RJ1mIKpQJiTeIWw+MgFkcaem5NxDXEuXvyYJCpbEpZ6OwErrV1GbcCEw68jnpMvCGuP89gZVE56yb9BfFVKVW/onLuwH3js58YIIT2oNp15eYOCs4zn3/+cdF9mVD5O2y+CUInr21Z3RIElXczEOFrpz3EO5tqlrtAYydoIAqWuL0VwiWQKQ9z5Z9rxvWXObCqxRmAmtb4zGOq2xNUg68i0SLCwppWmvAEOAiY4MNfBjFureCyPMtTQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(136003)(376002)(39860400002)(366004)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(38100700002)(26005)(54906003)(8676002)(66476007)(41300700001)(6506007)(5660300002)(7416002)(52116002)(6666004)(9686003)(6916009)(4326008)(478600001)(2906002)(33716001)(8936002)(66556008)(6512007)(66946007)(6486002)(316002)(83380400001)(38350700005)(86362001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d0IvYq7HsFzD2hUoN4PrijusWMUZIg8c7+4wbWu6pjkWemtJzecePr1aQWai?=
 =?us-ascii?Q?mgpo7OpMK5VU+Dv1O2XtDq4iXoqHi3eLUxOIX2BtPNXJ9X3Os+mer9H3HRBz?=
 =?us-ascii?Q?4076hHn5BIx7JFLxt5/nhI4rAieyZubGa8l5b5dLUQ6TaVDDpZM3r5P+NWeF?=
 =?us-ascii?Q?Ot5j8kH0sblDNmjeDbg5lq/SvkdCS/aYIMLNnxI+C306AMpao/eO16eS2UMP?=
 =?us-ascii?Q?2q4j6wBOYN+6QLc+sYkNgfzitYaadrcEfW8TG/8gosEkJJghIM/8vTm5Sax5?=
 =?us-ascii?Q?/CXtc1eRFDgfqaeN+HSuz4khdl4q02mQ4Gl2QRzdueiPFyfOkua5NaKA9ASz?=
 =?us-ascii?Q?jRgSBuHW5dspUPXINW8cK/k2p542+nDAZTbRU4XPEJFZ+A0ysRJ8bZVSy6un?=
 =?us-ascii?Q?Z3bxTHPifOqLBOw3iQPrDUv4m8+4zT7R/0XP6JZEbwIe9TEuKdmwN0eq5Q32?=
 =?us-ascii?Q?BSi58AsASD89Zmvmz8vE/F7FlGE/Sl6xaSfsaauqQ6EJj+PkAFtN1tGzh9IR?=
 =?us-ascii?Q?Wg4zqqDDx3iwZMv8rJ2v1GApdA5S1EQmiu4STNtSbb6i6KF6k/C/wGe81OPb?=
 =?us-ascii?Q?wn4o7Mwlr1W70Z7DzggSncjgIphiICxyRpB0QQuFWQNgucFnyKAtF3wmSVBt?=
 =?us-ascii?Q?tvHEDi7P7NR2Vkk6VflsjWT24uJxTgReCkcMRF83y50eW6kJqBkX5PePaqa9?=
 =?us-ascii?Q?T7y6xO6k88omly+iNVGZ2wZU3Y80pJ3nnQ9/1RExu3VgZhC87B3mfnEu02Lt?=
 =?us-ascii?Q?RFU1v7CDeHE6udNH53CKgyJorCEiF2bd82ZjMibdIizOflm6/NQoUTrT8aC2?=
 =?us-ascii?Q?llo7zEY+F8DWObcxST+PH0TkzNessmt/WVtkJapD5zi/cfogxTq6nqs4i/VT?=
 =?us-ascii?Q?K6zHXi2xKCzl6vI1sEbBwTDyf55fGOn25sEYJZvGsKJSzVZkiTyrzeKGmX7Q?=
 =?us-ascii?Q?NGV4YhAWWgVIN5bGNLhOcY24C7Cka3s/c/YirFh7J/8az3yz8ekoUN/TvMM9?=
 =?us-ascii?Q?h3DeW2rbelCDyUgfIP9lMDghD+XvOPvZ/JggJgIZ4xu85tp20urmY7R6PCXh?=
 =?us-ascii?Q?cnlGcV2Z85x5VEYoYqEe7OOQoJrZSlX87r3D8D1NSjqxTEx86WkKj+eK/0tK?=
 =?us-ascii?Q?dFuMlI6W/iAsC8t/i2vdjlNtdbWlWbc6o1oGeiSE0YKgTJrPWBv20ziJCWLr?=
 =?us-ascii?Q?IWz2h6QA8CPXkanv703ETO1+/0PXiaRWhR4DDivAAnn4SQAH7nV3uZDA4i/M?=
 =?us-ascii?Q?a3bd2TbULYwRlW+Xa2I2IePh656oVlZ7cNKXHKhe7Z2ExGNYEQtMcPMhkCSc?=
 =?us-ascii?Q?MSATCnaUyij4Z0HLaHFOBBa9mKipKi+XpuzBxlFm7i9DOKOSFF3zGnQtQrff?=
 =?us-ascii?Q?PG953AxLYyIDrlTNRvneoL8CoMTLsR6bP17rC/NZSRwEZ/IoT25Kq3FV0YQ+?=
 =?us-ascii?Q?D1piaYCCdC2y4DkRkQGGePq7UUduyKjGgrJiatc70rjq9mOHypQLyr84Y2kU?=
 =?us-ascii?Q?nZZC7A6UVUUIzibS5FjerWkL980wwCkfzasA2fRbiQBnAFSrvMuxr6aDeOTD?=
 =?us-ascii?Q?Ss08Bxh4b+3/wInGGJk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f34e547-4264-4559-1912-08dbf7476dca
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 17:10:36.2509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bjre/QxGhbIBuSk/UzCtNz/YpBmABdNpTgE5oV6/XOWMp33GynwVBd0C+g7OXTQbvO3EWMVSokAocuPvz6noMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9423

On Wed, Dec 06, 2023 at 05:52:23PM +0100, Philipp Zabel wrote:
> Hi Frank,
> 
> On Mi, 2023-12-06 at 10:58 -0500, Frank Li wrote:
> > Refactors the reset handling logic in the imx6 PCI driver by adding
> > IMX6_PCIE_FLAG_HAS_*_RESET bitmask define for drvdata::flags.
> > 
> > The drvdata::flags and a bitmask ensures a cleaner and more scalable
> > switch-case structure for handling reset.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 115 +++++++++++---------------
> >  1 file changed, 47 insertions(+), 68 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index bcf52aa86462..62d77fabd82a 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> [...]
> > @@ -696,18 +698,13 @@ static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
> >  
> >  static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
> >  {
> > -	switch (imx6_pcie->drvdata->variant) {
> > -	case IMX7D:
> > -	case IMX8MQ:
> > -	case IMX8MQ_EP:
> > +	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_PHY_RESET))
> 
> This check is not strictly necessary. If the flag is not set,
> imx6_pcie->pciephy_reset is guaranteed to be NULL, and then
> reset_control_assert() is a no-op. Same for the other (de)assert
> calls below.
> 
> [...]
> 
> > @@ -1335,36 +1319,24 @@ static int imx6_pcie_probe(struct platform_device *pdev)
> >  					     "failed to get pcie phy\n");
> >  	}
> >  
> > -	switch (imx6_pcie->drvdata->variant) {
> > -	case IMX7D:
> > -		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
> > -			imx6_pcie->controller_id = 1;
> > -
> > -		imx6_pcie->pciephy_reset = devm_reset_control_get_exclusive(dev,
> > -									    "pciephy");
> > -		if (IS_ERR(imx6_pcie->pciephy_reset)) {
> > -			dev_err(dev, "Failed to get PCIEPHY reset control\n");
> > -			return PTR_ERR(imx6_pcie->pciephy_reset);
> > -		}
> > -
> > -		imx6_pcie->apps_reset = devm_reset_control_get_exclusive(dev,
> > -									 "apps");
> > -		if (IS_ERR(imx6_pcie->apps_reset)) {
> > -			dev_err(dev, "Failed to get PCIE APPS reset control\n");
> > -			return PTR_ERR(imx6_pcie->apps_reset);
> > -		}
> > -		break;
> > -	case IMX8MM:
> > -	case IMX8MM_EP:
> > -	case IMX8MP:
> > -	case IMX8MP_EP:
> > -		imx6_pcie->apps_reset = devm_reset_control_get_exclusive(dev,
> > -									 "apps");
> > +	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_APP_RESET)) {
> > +		imx6_pcie->apps_reset = devm_reset_control_get_exclusive(dev, "apps");
> [...]
> 
> I wonder whether we should just defer the check whether apps/pciephy
> resets should be used to the device tree validation, and make this an
> unconditional call to get an optional reset control:
> 
> 	imx6_pcie->apps_reset = devm_reset_control_get_optional_exclusive(dev, "apps");

I think double check here is neccesary. No sure if dts file version
binding yaml was exactly matched driver. Sometime user use old version dts. 
Double check here will help identify the dts problem. 

Frank 
> 
> regards
> Philipp

