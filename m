Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42AF64B2A53
	for <lists+linux-pci@lfdr.de>; Fri, 11 Feb 2022 17:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244891AbiBKQaR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Feb 2022 11:30:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiBKQaR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Feb 2022 11:30:17 -0500
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01on2099.outbound.protection.outlook.com [40.107.23.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA998CCB;
        Fri, 11 Feb 2022 08:30:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=haKcMV3vf00pYVqJFN+Fk6dbThRqeadveWxcNgsu7UmodpWHB6JxeXZc/7YRoI6GQY+zXu9ykbMG1kOcYRC5urMgR2egXXIBbGKmGp+yFPAAhu9NV7YaXFC1f+GAn9uuV/brXt5Z48Yt5nUyzsC5ekCYG+mI7DctLhuOCXlQ1hvPJwBbaXc/KdL1vyLh064IhVZFQEMrROZIumaDPimWF4VmewinuReEw/B1m1gcjhq0KjnrNClAY+/xjTqArYnTSKr60AUSj3kC6gF8MmA65WO2Mvr4lN2B1jliU8tUtpz9kXNRBJx+GnB4vMb6jaEBhoQeIpwr/ZIvnnlx9fXrNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tq/PoMrHyi0oE3YMCFvc9k18GqSkqfDAUoySY0jWLPc=;
 b=RxGSowLrc07pnHUMwZwB42KGu94yh4cvyA+VwT+jFw63gV+tgzziTXT6VbCaGdDf3CpPfZgzqghkZOM+FeMTJzoOOfjR7huz4v4vAaVCgy0vbLg6R8MfFaLvBd+sX6b8AylWIDTjXRFiszEw8K2coQuUJdTDVE6qhbYjX0N+u1SXwnra1c5aXnUH8MAceiyt6Mrj2yMWuVLe2OxxctgrtHRVG/CVS3GkZLblZ8CZrsS4PxqyWXvQtjbIMwUd6Oo2RVmgM4rfm43wZd1a8Cn0zw72+NChND3+u9kCB7krfcRUjPK3JL4Uyejp8WvoO2zranFKcD/6TEoRzKnIUvWk9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tq/PoMrHyi0oE3YMCFvc9k18GqSkqfDAUoySY0jWLPc=;
 b=m4hzjxWSvaoS5v8YbC6FChYSIdE2yXaHeQfxJp0bSRL6rjHLGF/B+45HZsWa6n2tWuY9TXYCUQ0EWAGD/phg2Bx9zIsvlwjAa70JdOMAnUd7+quDPUTHHVDqZFFGUzTaC/8fyaTXGhgtFB4dV4Oxf5JElssMD0G8/VPmDK6gVwk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toradex.com;
Received: from ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3d::11)
 by ZRAP278MB0528.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Fri, 11 Feb
 2022 16:30:13 +0000
Received: from ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6c4e:9890:b0f5:6abb]) by ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6c4e:9890:b0f5:6abb%4]) with mapi id 15.20.4951.021; Fri, 11 Feb 2022
 16:30:13 +0000
Date:   Fri, 11 Feb 2022 17:30:12 +0100
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, bhelgaas@google.com, broonie@kernel.org,
        lorenzo.pieralisi@arm.com, jingoohan1@gmail.com,
        festevam@gmail.com, linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH v6 3/8] PCI: imx6: Move imx6_pcie_clk_disable() earlier
Message-ID: <20220211163012.GB287827@francesco-nb.int.toradex.com>
References: <1644290735-3797-1-git-send-email-hongxing.zhu@nxp.com>
 <1644290735-3797-4-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644290735-3797-4-git-send-email-hongxing.zhu@nxp.com>
X-ClientProxiedBy: GVAP278CA0011.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:20::21) To ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:3d::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 700ff989-5706-42f4-3ddf-08d9ed7bc757
X-MS-TrafficTypeDiagnostic: ZRAP278MB0528:EE_
X-Microsoft-Antispam-PRVS: <ZRAP278MB052819FEB635BB205A1BCAB5E2309@ZRAP278MB0528.CHEP278.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: omEDraYNt7ZqE16cckHnpr/AYzfLzq6+C695MmZR9pmi63/D8PWcdHt6Ll57+RySwa1vp0QBfYHaxeuBHnkNu2DOMSCM0Dq2gWBC0LQlSYLOf4oAay5afCQwBag7GGNVbpHaTfHqrkNCESw/g+eUMVCrLGEX2UOvUiH626nNWfCy87DmSnH0Ogr3t4QoNpO3upBXhXC85j9ECR2u/BLVMFerJavoVLE1moi1xQyUoN/5sdLImuSx6q9PKiGz+H8TjXh0jDIGYPfAIbiYwyzOnM1LRL/7sAZyKhAnSn9Gg+ev/eoM2kJS+04BpVMdClCFWrYYx17w/1WP1ZG4BjTV/GqxVbwvGkoQKTqrGHUzY04so36Ao4yGmBSG7ri4UgCMLGZMaBUpDGzzpMjO5mJCN85R/0V+mXUEy212H4Fjz8E2lRXl4+6yr8QwiGOQLtgrHjtgWNkS06wcFSeydedQiYimTDG60Xysro7cBdVQZklh044hGiA6hNMSLOHs/rDQyh99bw7/vHojksDCdpaluaapP0ym1+LLF1IzW//dKVWP5/L/M7WuhSk6sutWxqW4mXUTDe5QYwQh2GxKwu8/chtgIzf2QtbuBQT36tfUfRmRacH117bo7iP5IPjngX1TczAXUddM2H+X+apeSufZKNGgOsV65yMDhG8k3bOfIonyBJrGS21ucYQUTrJ6/O5YphRoDNRoabD8A6e+Az6z/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(39850400004)(396003)(136003)(376002)(346002)(33656002)(83380400001)(508600001)(1076003)(6486002)(44832011)(7416002)(5660300002)(2906002)(8936002)(86362001)(66946007)(66476007)(4326008)(8676002)(316002)(66556008)(38350700002)(6512007)(26005)(38100700002)(186003)(6506007)(6916009)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EDzXm3z1ngBIfD6Gq3tuBR3ffK17+dhesFhQs43eVgJ5L0Csofy2RfPSZCtO?=
 =?us-ascii?Q?3zsQB+EzF9tZwzPF7nLSMuQ8EAEzf6xSD4eZlLWUAvVuwm6mNGe8F4YpOUfg?=
 =?us-ascii?Q?VLcpVJo/4RMlSFi5ND2N4pp+wDq6SU1RfbDajSNghFrUfxTbeXfRqaMlFQg4?=
 =?us-ascii?Q?CXKuTkj/101p6lhpjEIgPaexuAunY48r51Hbkp8og2vH+lueJ15dIp2U4wAj?=
 =?us-ascii?Q?JPSpdFXet5qlhVgODx4RbwFgxu7MVRFIxLUxhv5W7844BtpcYC1mznPV1J0T?=
 =?us-ascii?Q?LIaGJtXHuG87zJmV4LYgmAPWzDl9MEDn7DeA8SL8Ji48YdDb084gmfXmuWFD?=
 =?us-ascii?Q?0qRnwiLYjGlptnSF+1ECtC1m5/VJYszRh8r1sXTUFUmihRu7BxjUm9S6jn3f?=
 =?us-ascii?Q?UPrA6EJEH+eD+XpASc7W9Q9Q9IOKMxQuR6suNbwxTLTF56jQjkDT1rhX0xh5?=
 =?us-ascii?Q?jXOLQ99U/EK8EmU9wzEq+io8VdwdY6INCRtN01k1SmYahzrs4aVGLKi8x8yp?=
 =?us-ascii?Q?lbi5RzFTwMpenkQo64U7RMmH789HW2/ChgILOYCVaDrvEY22Hv1H/B52/q/H?=
 =?us-ascii?Q?Z9iblsCKoefErwvOzAVGRut4gILh6DfgGE73ZXkT7Y6WGvx68GSc/kGAJsAB?=
 =?us-ascii?Q?5vfGZAez/qOc0DTw5ijTiLcjIwlmje7LVnv2b1gjsj2AtJN5RiVVzIgHUFeC?=
 =?us-ascii?Q?K5t5IGIkYyF28/wCKHkpLLgmxCHggIXGtvrdYSysHe3zBbmaoQBKN7akW4uK?=
 =?us-ascii?Q?rvm44oOQzE621Cochkq/G5QFozrFlqu/FXY4AlSb1blp45rIpORnO0CVNn4L?=
 =?us-ascii?Q?Vvp4j2NzPWwgr8qNs/sT2uDN0+Iz+NBXkiCwch2Jczn7YnOuEQjpLp2YiSv5?=
 =?us-ascii?Q?8Dn8BelXuQ1vC26p83I108HRv5cdo3J+bODPCuTTGAaTx/lM/1rZOa1fUWIr?=
 =?us-ascii?Q?VnufvbUTZkHRXQSk0AHsphviJqj18geNYQCpIej6l+EdtNOF4bL0qoRvnrLD?=
 =?us-ascii?Q?fRE43DhgXt/LjFTYTFqRFndKY7ahzO9ffpjMBKm0qraLJkaFjwAuTBrqn//P?=
 =?us-ascii?Q?pElvi2WHYA4ISVqoZZ+XzlzUxyUEzKBomTopcemQkV9wtYlPQ3tG6eM/n9Wt?=
 =?us-ascii?Q?5mQsXI71UfRs24NnIHiHyjffbNEKOXOl/JFmnE6b/tXH29ZzAwwphMrB4s/F?=
 =?us-ascii?Q?5PhN04gOmA0MyTgp2js579lDw4Zoz+m1X2R7Ti71+4Od1pyZaCMkW4Vrj0CK?=
 =?us-ascii?Q?CqL5f2+qw8ooClwHvn9PqTZ7ZInnU33hwJgnauzIaPBHMeUDUJNcXkBli8gA?=
 =?us-ascii?Q?7hgNjSRoEsD7StzW6tIGUoggT96oNxp70ZD7ZHOKP0jg33oChDOO7oD3Ct13?=
 =?us-ascii?Q?LZ9/XjYNIiOai0CdCXj8cwL9GYprlqwKjajUZOoIzlzhXKENZfyf8udZlWNy?=
 =?us-ascii?Q?7xYpvzbXbqgvyGzmRQIJTAFp22XwsByj4r9UIrbZSxYGDfDoHBWqC1gFzbDz?=
 =?us-ascii?Q?pWUiCqwIKXXcM9ZdHTR4ch8BcNyMZ63ZkbVHa9PtHZou5CJlA0Mm1wsUc0lP?=
 =?us-ascii?Q?5k6lnHMR7pGRsQnaOGjMhe9s/tNDoZQgfOhsE2WmVr50XanCNztr4YZMUbC6?=
 =?us-ascii?Q?32LHBHENGfHNSbrDwzOqLXkJ5YJrKuPNtZFFBeQ6rDZyAHTpO5qamHjXDDLN?=
 =?us-ascii?Q?+pKR5A=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 700ff989-5706-42f4-3ddf-08d9ed7bc757
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 16:30:13.2029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pOcJMd2oNPLlc9YOy8H8bHVnVlg0FSBLLf8FhQpz23ZMTkqa4fT57kYRi+/pSW2DxVMq3iHUKMnTi1n2gdX+Z6m8sB46ekORf6B54uk0hBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0528
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Richard,

On Tue, Feb 08, 2022 at 11:25:30AM +0800, Richard Zhu wrote:
> Just move the imx6_pcie_clk_disable() to an earlier place without function
> changes, since it wouldn't be only used in imx6_pcie_suspend_noirq() later.

In which patch are you going to use imx6_pcie_clk_disable()? I could not
see it in this patch series.

Francesco

> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 47 +++++++++++++--------------
>  1 file changed, 23 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 3ca2eef39617..e157f0bec37e 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -533,6 +533,29 @@ static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
>  	return ret;
>  }
>  
> +static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
> +{
> +	clk_disable_unprepare(imx6_pcie->pcie);
> +	clk_disable_unprepare(imx6_pcie->pcie_phy);
> +	clk_disable_unprepare(imx6_pcie->pcie_bus);
> +
> +	switch (imx6_pcie->drvdata->variant) {
> +	case IMX6SX:
> +		clk_disable_unprepare(imx6_pcie->pcie_inbound_axi);
> +		break;
> +	case IMX7D:
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
> +				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
> +		break;
> +	case IMX8MQ:
> +		clk_disable_unprepare(imx6_pcie->pcie_aux);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
>  static void imx7d_pcie_wait_for_phy_pll_lock(struct imx6_pcie *imx6_pcie)
>  {
>  	u32 val;
> @@ -965,30 +988,6 @@ static void imx6_pcie_pm_turnoff(struct imx6_pcie *imx6_pcie)
>  	usleep_range(1000, 10000);
>  }
>  
> -static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
> -{
> -	clk_disable_unprepare(imx6_pcie->pcie);
> -	clk_disable_unprepare(imx6_pcie->pcie_phy);
> -	clk_disable_unprepare(imx6_pcie->pcie_bus);
> -
> -	switch (imx6_pcie->drvdata->variant) {
> -	case IMX6SX:
> -		clk_disable_unprepare(imx6_pcie->pcie_inbound_axi);
> -		break;
> -	case IMX7D:
> -		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> -				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
> -				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
> -		break;
> -	case IMX8MQ:
> -	case IMX8MM:
> -		clk_disable_unprepare(imx6_pcie->pcie_aux);
> -		break;
> -	default:
> -		break;
> -	}
> -}
> -
>  static int imx6_pcie_suspend_noirq(struct device *dev)
>  {
>  	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
> -- 
> 2.25.1
> 
