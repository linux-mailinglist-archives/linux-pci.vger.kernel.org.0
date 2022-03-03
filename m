Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760474CB7F7
	for <lists+linux-pci@lfdr.de>; Thu,  3 Mar 2022 08:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiCCHft (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Mar 2022 02:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiCCHfs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Mar 2022 02:35:48 -0500
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01on2123.outbound.protection.outlook.com [40.107.23.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB16C15D3AB
        for <linux-pci@vger.kernel.org>; Wed,  2 Mar 2022 23:35:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ItI8F3CzCjaRqncezgW7fFWdtbBCiIAIKXpjgEB7L1a1rlzB3YmiuX9qAySeGimxcfkTvMhY2ylfhL6Mf79t3WoJ+OfnP1ZOU/GmbIcxZo00COUt18N3yyUXvc/UGAmRdrv1RHYbCLKNTGJR+JwyHZEBu02+aF9OTznQAs9PUqE/bwmLgmtF6gzPIn3x0RJj3oRP6PxhvacPFg+E1VEYpu+BwbXnqz9b3iETS/Rx4a9XuQLJvGRa3stxpUXfG13LyM9gPMAMtZ+5w4vpnunaDIArwr3+v2rCIpWYfSDpwU21Dxbh8niWyvuO06c/Eb/fvjRdp1ERjRgFEXX9JmPb7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3fttv8ZL043poodz2CDc1mS/8yNdywyaPVpqf7Gn48=;
 b=Z/8uoQdi9CHll0kFWtf7PbMux8+AoIriiTMwkjCkHIdkqnpGoFJh2BaokWY9Buv+AMn7xCEV3WSW9j61b9QqksK1BbcC0Br52ik/eSZ/rdNKhimrgVGdAw0VgG/WtMSeD7t52zq4jSvU7YJhH3B5fVg7hWS6M/gWx3OgXLk9iKAPWKW6pGiuNMvapuT0e4u4ggjN+8j1e172DO6DDdFi3MsqiXAV2YDQH7NyQIsxbSnK3fxkuFpNPOEWf6ukVT2Nw21upJrXbULHk9scGg1tdoCD1/T7Y+0WE1imNlaDDQaHrLka+mwUub0h/05NwjDzMcQ0YQRJC6poBLJsIilvHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3fttv8ZL043poodz2CDc1mS/8yNdywyaPVpqf7Gn48=;
 b=M6NwPLsAhufcZ5lXrUZ54b4tHf/uVliP22VfNrOxtWDWzlYe376PR40hGH+tMlijD0sXWUZbeoUJCrWWoEtthb9Na3/+KQWQG2ZzoB2c7wc7j7oa7Cbx3zXTktBw2AciNo6tfBXT1iug1SxZRVGUMmjlz8e0EMv2Dqcud0Ikoxo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toradex.com;
Received: from ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3d::11)
 by ZR0P278MB0799.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Thu, 3 Mar
 2022 07:34:58 +0000
Received: from ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6c4e:9890:b0f5:6abb]) by ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6c4e:9890:b0f5:6abb%5]) with mapi id 15.20.5038.015; Thu, 3 Mar 2022
 07:34:58 +0000
Date:   Thu, 3 Mar 2022 08:34:57 +0100
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>, Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v2] PCI: imx6: Fix PERST# start-up sequence
Message-ID: <20220303073457.GA333450@francesco-nb.int.toradex.com>
References: <20220214161522.102810-1-francesco.dolcini@toradex.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214161522.102810-1-francesco.dolcini@toradex.com>
X-ClientProxiedBy: GV0P278CA0003.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:26::13) To ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:3d::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07da846b-6782-4108-b2f4-08d9fce851b7
X-MS-TrafficTypeDiagnostic: ZR0P278MB0799:EE_
X-Microsoft-Antispam-PRVS: <ZR0P278MB0799C9959AF98F1D4ABEAD7EE2049@ZR0P278MB0799.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X5nwvq9Y/aniqIsSVz2gg1mEEHceHbufzgyhlzREW/nFdswIHyCbHA+NVeJraBQXnAT9qbZJq+prfp5UUVVUihmADVQtYxD3xFpW7I/RwstJPmGKEvhTdTfAyQ4Wgq3+URTuowUXVgTa6GyyL6kMKZNEsHxT37Z6S30h9ZC+ZMeJBA/FCJ4ZW+Lt5yv+NVci3mexSrFxRrZGId73xJPHrsgOHxAdt1rnl7V2f0cns6BU5PxAoazFRkyuuBaN1fwQu5Q8BqJDnrmsUYNKeP5hawo0wiymVUEWhS1NLk3qcmTDKjdCHlKAbo6WWw1m1ZHT1zxBVDfd+/kvJXMLW33/9N3UUy3eQ6HFDxpWzUdzNCOrifXBr2KeBIibcFE/yMs2Ur+mWZ/aCcFErNIw4+hzp5zQsXFyz9OSVPQ7Ji01WDD4X64sj3bUFxe3AQzRtjYYzyrzLv469GUO2JD6T0QQXAxBfoDPeVHN0JYOlBetHDTbQ1/DLtRJZ8kbVoX9OQ6ZHQ3wUZnLGZoTguBR/z5VcPcXsBLwAHNjRBA+bZOzJTRUHjYYxPHhKsm+dVFGIocIUB86W+tu1wziot5qnxnf/0qFVHxGbxwK7AvFOxso3B4rts4cQPFfviOPLOePOajXv0RyiZ6hImaK30/wFDpeuCVWZqqRAs+KC0Ubx4GPZgdTejnkgj93PgOArTGJVNWVqrWw5CtU18DgHIdFLt5cx4HpoPSQwPoAMBOSEq73uWPAW0WRNg9jLjvVV9mO38hLWZr/sWX6E97EF83ft7gMbVnIDJqEKBk66V6mYfUFE3M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(39850400004)(376002)(396003)(136003)(366004)(346002)(4326008)(66946007)(66556008)(66476007)(1076003)(8676002)(508600001)(6486002)(966005)(52116002)(110136005)(6506007)(6512007)(33656002)(54906003)(316002)(2906002)(107886003)(83380400001)(86362001)(44832011)(5660300002)(7416002)(8936002)(186003)(38350700002)(38100700002)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vFjUl+QfXCMN2+hwnlbVjMjbNtJ6lhC6K990OzZqrheSgulWET8pHEdGWvJh?=
 =?us-ascii?Q?ynRqVcwR26RBoWFOiyQpz7j2RMikXoGBS1cCKCAy+p8IcYj+7XhAvp/wDbSS?=
 =?us-ascii?Q?I2uXIwVGkn+zWhey/I3yhR/sK7fRpfbVih3lCZriiJ/XKWtmdG9BEGo1RkJn?=
 =?us-ascii?Q?UQcQeqV7JoIMLDYKRM6F5irnOOZyC1zDsZg/HbSA7fQ/HkhMmEsGq7GxG4Bs?=
 =?us-ascii?Q?3pRxqraPYsV6+C5zNKjHtqEUtwi+Za5cRGgqSrqipRPyU/BveztD4L9sCC/8?=
 =?us-ascii?Q?2q2HLSCJQdSGu8VJCSUw8+02oLOer/d3Gp+HkHI4n987av1YYpzEcwBmIidH?=
 =?us-ascii?Q?UUkbKDwkgtB0x1qbugCf1rf8VyZMBQotkXmSMkcliH87H/TPNXzKb0rvodeA?=
 =?us-ascii?Q?f3wI3nvnxipuIjKU2sHEA+Y/bRLGXn1XdiRMOVSkI/t8JAORp3dlfISvHWY6?=
 =?us-ascii?Q?oxalk0CCJT0H4JhHZUF/vj2lS3OtTQCRMBMkX8Nn+gyj4xv4xDEiofz9xq8v?=
 =?us-ascii?Q?DtX25sqfkIwefJ9HkEYLQigrsJaHyes2S4wqIVpAJFJ+xHjjqmFq28FKSETx?=
 =?us-ascii?Q?whYnWQ8nn8d+fqvM+2vVlh1ho/278Ky5Zpa+jaATfhDD6qdw3NKA+s6sMkW2?=
 =?us-ascii?Q?M8A3Ejw+ekFDmbaLaph+FFpZIfyaLQS7Qo+0lWIjbhXBHDon5pQVZh5AuOCP?=
 =?us-ascii?Q?XhxmTrBVoevCLuSVXgE36O3Hd8YWawyWHrf+plGSe//VsHWRWqFBEprPH09u?=
 =?us-ascii?Q?ygP3S1Or0OKKpHPfxWCvXt5AxPIROvSYf29XsHd7e2PjKSGBmPlMzvXA+O2K?=
 =?us-ascii?Q?AS8dn1tKgOE0ECmUMEe3xktv2/h/EffWUEdrrwLlMWPI0Tq9F+lVGlne04RQ?=
 =?us-ascii?Q?69Wz68rXKGtx8IQdk5/GUUtXGxa3wK06OB/HNGAwci0yA82WH1tuBvoGJjyp?=
 =?us-ascii?Q?CoAW8eFJ/5UI2uIRgcutAC6UZIzDnCKLtKELIGr7XO0UqClckrftX3coBDxL?=
 =?us-ascii?Q?unB5DrmBPvdM+uqWllN0hrw8XHiDWokFOtAmXM+zkLraQX+Y3nALGyvbYfJ/?=
 =?us-ascii?Q?FUay2tdFrtEta8eeEX0j+V2TCvIKup0AXeMe4vudE1VJmRE99JfyDxHzgiS/?=
 =?us-ascii?Q?7YMTTKumMgm7wJDOQnZgivpJ+G9pkanlUMhr4AUUesfE6FFOv7AmmT7RI9D6?=
 =?us-ascii?Q?0VBSvj635lXpCg+J4ovSl1Hp+4wJBHUsV9MZHVhiobtdpYLGSBXpI3QTT27r?=
 =?us-ascii?Q?royl4g/NRywh2EIwkCmnKZzJ6CiaSfVIdXRuXKyBvfOrEVAFhr1ts6AwSHbv?=
 =?us-ascii?Q?hylcpVMmZFl5r+lKH1InInfgoMvp4AxtF1tAaPfkkEcENS19uqGCYWVAepul?=
 =?us-ascii?Q?LbsPc9uI/dh7fpifbjDEspldj2NVfoUaSWvVIJwYx2uJlAALfd6/Cxx5BsyB?=
 =?us-ascii?Q?UUQTZbfr6NfbaTtIAn576rzerVvByywf3EHrHaSdKyKMw8oGr+8vopbWD7MP?=
 =?us-ascii?Q?ZdUgsc1OhcOlCI/7qhidB1mUTyvxUe3PE7oZW49HNCq6BJWHN7L7o/2V1Atf?=
 =?us-ascii?Q?Um4kDQ+QC9pCYwPAhyzb2iBFVGtFcjibnBtMKruFg1wfpBEN80Y7hAmQxiFM?=
 =?us-ascii?Q?ZOLFZzh3Nvz9NBwca825DUBjcLNgtSsRh0F8RSlr9fjeD7rxeqPT9xr0gSgo?=
 =?us-ascii?Q?QrI63A=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07da846b-6782-4108-b2f4-08d9fce851b7
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 07:34:58.4647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qWEqLkfuz5h1HjPejO5rDL4gRHS6HvS62FJ0ZC8YXR69kzTCl6nAJFepZLynvnsauVMFUMhcaTm9Wycr5nhftNZVk2pJ0ACyXW4chWXuZ2o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0799
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Just a gently ping. Should I resend adding the acked-by Richard Zhu?

Francesco

On Mon, Feb 14, 2022 at 05:15:22PM +0100, Francesco Dolcini wrote:
> According to the PCIe standard the PERST# signal (reset-gpio in
> fsl,imx* compatible dts) should be kept asserted for at least 100 usec
> before the PCIe refclock is stable, should be kept asserted for at
> least 100 msec after the power rails are stable and the host should wait
> at least 100 msec after it is de-asserted before accessing the
> configuration space of any attached device.
> 
> From PCIe CEM r2.0, sec 2.6.2
> 
>   T-PVPERL: Power stable to PERST# inactive - 100 msec
>   T-PERST-CLK: REFCLK stable before PERST# inactive - 100 usec.
> 
> From PCIe r5.0, sec 6.6.1
> 
>   With a Downstream Port that does not support Link speeds greater than
>   5.0 GT/s, software must wait a minimum of 100 ms before sending a
>   Configuration Request to the device immediately below that Port.
> 
> Failure to do so could prevent PCIe devices to be working correctly,
> and this was experienced with real devices.
> 
> Move reset assert to imx6_pcie_assert_core_reset(), this way we ensure
> that PERST# is asserted before enabling any clock, move de-assert to the
> end of imx6_pcie_deassert_core_reset() after the clock is enabled and
> deemed stable and add a new delay of 100 msec just afterward.
> 
> Link: https://lore.kernel.org/all/20220211152550.286821-1-francesco.dolcini@toradex.com
> Fixes: bb38919ec56e ("PCI: imx6: Add support for i.MX6 PCIe controller")
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
> v2: Add complete reference to the PCIe standards, s/PCI-E/PCIe/g
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 7b200b66114a..73baa2044ccf 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -408,6 +408,11 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
>  			dev_err(dev, "failed to disable vpcie regulator: %d\n",
>  				ret);
>  	}
> +
> +	/* Some boards don't have PCIe reset GPIO. */
> +	if (gpio_is_valid(imx6_pcie->reset_gpio))
> +		gpio_set_value_cansleep(imx6_pcie->reset_gpio,
> +					imx6_pcie->gpio_active_high);
>  }
>  
>  static unsigned int imx6_pcie_grp_offset(const struct imx6_pcie *imx6_pcie)
> @@ -544,15 +549,6 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
>  	/* allow the clocks to stabilize */
>  	usleep_range(200, 500);
>  
> -	/* Some boards don't have PCIe reset GPIO. */
> -	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
> -		gpio_set_value_cansleep(imx6_pcie->reset_gpio,
> -					imx6_pcie->gpio_active_high);
> -		msleep(100);
> -		gpio_set_value_cansleep(imx6_pcie->reset_gpio,
> -					!imx6_pcie->gpio_active_high);
> -	}
> -
>  	switch (imx6_pcie->drvdata->variant) {
>  	case IMX8MQ:
>  		reset_control_deassert(imx6_pcie->pciephy_reset);
> @@ -599,6 +595,15 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
>  		break;
>  	}
>  
> +	/* Some boards don't have PCIe reset GPIO. */
> +	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
> +		msleep(100);
> +		gpio_set_value_cansleep(imx6_pcie->reset_gpio,
> +					!imx6_pcie->gpio_active_high);
> +		/* Wait for 100ms after PERST# deassertion (PCIe r5.0, 6.6.1) */
> +		msleep(100);
> +	}
> +
>  	return;
>  
>  err_ref_clk:
> -- 
> 2.25.1
> 
