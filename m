Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E7B76DA01
	for <lists+linux-pci@lfdr.de>; Wed,  2 Aug 2023 23:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjHBVy0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Aug 2023 17:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjHBVyZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Aug 2023 17:54:25 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on0615.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0e::615])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EE0119;
        Wed,  2 Aug 2023 14:54:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9vxsabwO3uQe5r/pMYnl6090kVeR+BLr2jro1ZKyPvLaZQhqkUDobHTV+pB3xedxAmoSYjlJWZ7m79znw5mm8/P3Y3WgsctSMrxglBYINdVWeyUsMeDd7awsP/Z3WTNriAcBqm2UF9cGD+DxKvU/y7k3iF0s+Xbq6V8VCsfmaSBWVRSzUZfcG+haWjS41dHBTui59mQLic87gmc/TolnUFDPtD12toNombIWtkYhyIUqQAgVd9EJ+URJUBjsxN6YujSYcM2NtXY2JZTRFOT9A9Mq8e23ESGp30qetiL0t4ph7ZWllzX+QTukru+QOCPh6jLdi7nod8dv+eBxVpeCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9H+xIo7uHG0QGOSSorbERKfl7aa0DIrX9agUu6djsL8=;
 b=DnyekvXjczciWzvV6M0WjrixQFmIINzcVaglXoJkeqCwrh5iQPmD0/csFM56s1+FJhmiQ1mI0XIRT9jFuoDE2pw55GA3RB/4QkebZuf7qZaJxtt0g6Yz2UfDXsr70mdFXHrV2E8Fsp7eJTw7QBkhwSa6rbcGJy+BMra9qy9gW17i5iMSTBA8afk8Sf7/hrhHKrVrMUcUK0foDy49cxXuA/zH4Cl26V6QhKKivactbLcmuRX4pvYH4VWUGSCZMJjio9vpAgz2kCfDZyvJe5yizMzN5l4keYwr8voe4z883iLJ/uweDh64Q9lmxKLpvmQMtM/ueWItNItlC1G7XVdWsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9H+xIo7uHG0QGOSSorbERKfl7aa0DIrX9agUu6djsL8=;
 b=AefCSvIf39d31FTA7xVxkrD7bkgtYI2hkf3s8cRKJjw0CTYiaiYEQzet7/8vX/mYAMWCGn2nUBfkCQXWeF2bRLeJv4rPH+ZTB2p4lywIv+3OZI3oyTVsiNWAzJAT4bIZJaokruBD8+vRqfHnxqVHOx/iI3IjzSy98Os4x3fTtqA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8006.eurprd04.prod.outlook.com (2603:10a6:20b:288::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Wed, 2 Aug
 2023 21:54:19 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1%7]) with mapi id 15.20.6631.046; Wed, 2 Aug 2023
 21:54:17 +0000
Date:   Wed, 2 Aug 2023 17:54:01 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, shawnguo@kernel.org, lpieralisi@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: Re: [PATCH 7/9] PCI: imx6: Add i.MX6Q and i.MX6QP PCIe EP supports
Message-ID: <ZMrQedvqMHzx32Vx@lizhi-Precision-Tower-5810>
References: <1690956412-2439-1-git-send-email-hongxing.zhu@nxp.com>
 <1690956412-2439-8-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690956412-2439-8-git-send-email-hongxing.zhu@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0186.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::11) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB8006:EE_
X-MS-Office365-Filtering-Correlation-Id: f451b698-75c7-4536-3ad1-08db93a304ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FMeyhTmxFiLhpXx1IOwS3cGxDJ2ET1DUO0m7HMs1kgWC3kNSP7a8YrBR3QKTp3sGTbNW5zEyHVynBraXeNHWv1K63urzNDT6G8OsZk+rhwI3Dt/64KU4t1uG3VTdlfBXLD3USkOsvgrjYGrHH4gVmEITrMw7C9We9jZz1WAQH3u5AHQ3y/wqxVniRTkLlGf3t56AjYQU9IVfY00lFwyUqj8xh03xYQHPOz6EZGWUV8Smv96usI+A10py/cWp07BoQSBTeaQbgKgZUfm0H5nmxp0DwK9F6u/5uj+65vlj4mmLiSEsnYUQ+Ia8Ze1geqFzKlams6+j6hOXnn5VmMzY2VE2fwOSCIia75YAuXuUlOt6bk+dz29FEUzSMGg0hQ0xCQxqAeSAciRlKpvbMtDFm7QZz3wkbIqH9Ksb4BAul7uw4HmUAkgIloj5C8lLEglzE7smhTr0juAMd78G90OGAKzqfKDgkxJ6QsbiiBGH3Qr8m9iA7HFkPH8xi/TMMYOAjC5s84ErfODzPXWRlpqJEgAzTldhV+adGkIKS56RbafYFWj4XTQoOeB/SEEXMSDa3NGb82lCeRWuJaxFRMeqeg2r3toFKIbi/qlBRjzDs+B5VGO8PYyzOOiQRyqsDdXC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(136003)(396003)(346002)(39860400002)(366004)(376002)(451199021)(6506007)(83380400001)(26005)(186003)(316002)(2906002)(66946007)(4326008)(66476007)(66556008)(6636002)(5660300002)(7416002)(6862004)(41300700001)(8676002)(8936002)(6666004)(6486002)(6512007)(9686003)(52116002)(478600001)(38100700002)(38350700002)(33716001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wo7gO7ZmRjntFHkAOoOiIqabt2IyB/uNih6If/eorXl2xN7rg0m6pEH6gxDa?=
 =?us-ascii?Q?lqaUazazyPfXs/K6bStCHut9x34v3wcTgWjOrZYkuHauWQsk6TYIWUrV0hNc?=
 =?us-ascii?Q?8wOCaoOyEOw+MaxqO3xYIn5SzuG3gViu7BDWERbOdlKC1GfKJYFaqp9MLZwh?=
 =?us-ascii?Q?s+1hPR0v7lU/IGDOmux+ncpfMJLxTy+AMlZvecKPFLZzNB05chd2d2TBHavg?=
 =?us-ascii?Q?zCZvYASazCvu/pbAmxw76eFjT5GjgK4eoHraA+Aq8AaVLcSP1onhjVi+JfzC?=
 =?us-ascii?Q?BgpGJMFtAoNtT+dLHFl+AnlG2U9Uvm3Ey+R4fQ7xSdtG9ng/wQf1+Bz70yhw?=
 =?us-ascii?Q?nh1e3fAYVXXNJ7oIdlj6uaQgumMAGFCClFhOu8F4NTBsHRf5cvw76wGxlI47?=
 =?us-ascii?Q?U2Z0XQWVLqMrMBK7x/WHF4Bf8g6sAp7p8aOAXZ2NYhAv6sLzPVZWF1onnIl5?=
 =?us-ascii?Q?fjVfRE1vRyaegmCWdOCC8T2HZN5LhaRe6TYMzorjE0NNzExO9JDTJMXg7HNa?=
 =?us-ascii?Q?CO5sMPmv9T0H83VsPnMOXMVFFZEymjBGuIlTr3TaU7k6xhlTN6m6dQC7I/Mb?=
 =?us-ascii?Q?zsMzM2o+1u5ENmz0r2IDh1zNNj2U1/Ne+mrFc2kr7G0taHcuRdXiRxbkUKnA?=
 =?us-ascii?Q?OeuHTU7fVqfyd7hjKRDWdetSrFnMy9OXnkU6EASd3tXy8VW2MhGtPeTkLhTO?=
 =?us-ascii?Q?vAHYh0ZscN5imFFJeWXEeI9OPhSZ0uUfWDrhuwQdNYTPhmZ3NcYYO7OBewBJ?=
 =?us-ascii?Q?CRQIR8NhfrtRxmPcNBbRCSF+qO1FPUkI2NsZTszVT19pAE4xsk7zhXIH767B?=
 =?us-ascii?Q?pVlkC1/MrQFLcHwJQM4SmvkwAZRLNbh8vfEZdiRGPSE2NNauccruY41pSHAv?=
 =?us-ascii?Q?h6ufJKwtQY3823nd5pZXslAmxzlCqqZvXTRJXomZQcimHk4dXiI872cLI8yl?=
 =?us-ascii?Q?m6ZG2vNUmwDzw+LxkOvuSZYji+9Z08kpYsdu2ZXRba7uPu24Euk0a2OPVmO9?=
 =?us-ascii?Q?9ydDb+8EziiY+Xx+3nHEDei7MmVcArpKAo6kYoTjEGFqnDd2uPg5CzPz84Ms?=
 =?us-ascii?Q?eQk8W1nvlLImG9m2FD2G4N0E5cEENVkPDMsYvN2phx1IURt7lMKexriUXPUk?=
 =?us-ascii?Q?PmIcZywgbl3TPZ0ur7wywfATHfQujqiPiKJllapBp9GuoIqA5sJeitHKktVa?=
 =?us-ascii?Q?QR/SIrSu3twTPTFfaQgqK+l9SlLdWqM5TKxBDmnC/F4deMMTnWdSG7pVE869?=
 =?us-ascii?Q?eqJINJWWsiTIJMj6M5/gJKrlslTrlOa7J2qmYCUET9Ewu7t++ozbM7D4HXuC?=
 =?us-ascii?Q?UnES+5L7NmhHQwmRqXX3xA/346W2T+baGaVcQwWJtP6tG/Ke1PybxGCqx13z?=
 =?us-ascii?Q?uc1QNOTUXd/UcUJy8EmoQe/VCbVN82DZUWqnCHakZfdkmcxcbptysuUK//Kr?=
 =?us-ascii?Q?Zc+ioms0xlO2XcWtN+01bFxBex2IX/R6vwnJhXBMejyC9H5wFVnVdakkzEJV?=
 =?us-ascii?Q?fBYDNwsz6zsj+pxrIPzqTeRwYZzQbRgLuXoWXoNiDSmglvFc1ToRacf7iM9z?=
 =?us-ascii?Q?KKjjSo39dcTf63E9Hw4uN4P/54qr6T1lnOnIFARc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f451b698-75c7-4536-3ad1-08db93a304ef
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 21:54:17.8026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MnHK0wLLo8vIs6mOpmTReswS6T1jfynGnld1hdrV3OfcU93KwQN07j2LKTqq3/4HMMnUS1L4kdA7OIg1BBvbXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8006
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 02, 2023 at 02:06:49PM +0800, Richard Zhu wrote:
> Add i.MX6Q and i.MX6QP PCIe EP supports.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 61 ++++++++++++++++++++++++++-
>  1 file changed, 60 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 27aaa2a6bf39..4da9553b49b4 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -46,8 +46,10 @@
>  
>  enum imx6_pcie_variants {
>  	IMX6Q,
> +	IMX6Q_EP,
>  	IMX6SX,
>  	IMX6QP,
> +	IMX6QP_EP,
>  	IMX7D,
>  	IMX8MQ,
>  	IMX8MM,
> @@ -567,7 +569,9 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
>  				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN, 0);
>  		break;
>  	case IMX6QP:
> +	case IMX6QP_EP:
>  	case IMX6Q:
> +	case IMX6Q_EP:
>  		/* power up core phy and enable ref clock */
>  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
>  				   IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
> @@ -619,7 +623,9 @@ static void imx6_pcie_disable_ref_clk(struct imx6_pcie *imx6_pcie)
>  		clk_disable_unprepare(imx6_pcie->pcie_inbound_axi);
>  		break;
>  	case IMX6QP:
> +	case IMX6QP_EP:
>  	case IMX6Q:
> +	case IMX6Q_EP:
>  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
>  				IMX6Q_GPR1_PCIE_REF_CLK_EN, 0);
>  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> @@ -720,11 +726,13 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
>  				   IMX6SX_GPR5_PCIE_BTNRST_RESET);
>  		break;
>  	case IMX6QP:
> +	case IMX6QP_EP:
>  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
>  				   IMX6Q_GPR1_PCIE_SW_RST,
>  				   IMX6Q_GPR1_PCIE_SW_RST);
>  		break;
>  	case IMX6Q:
> +	case IMX6Q_EP:
>  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
>  				   IMX6Q_GPR1_PCIE_TEST_PD, 1 << 18);
>  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> @@ -777,12 +785,14 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
>  				   IMX6SX_GPR5_PCIE_BTNRST_RESET, 0);
>  		break;
>  	case IMX6QP:
> +	case IMX6QP_EP:
>  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
>  				   IMX6Q_GPR1_PCIE_SW_RST, 0);
>  
>  		usleep_range(200, 500);
>  		break;
>  	case IMX6Q:		/* Nothing to do */
> +	case IMX6Q_EP:
>  	case IMX8MM:
>  	case IMX8MM_EP:
>  	case IMX8MP:
> @@ -827,8 +837,10 @@ static void imx6_pcie_ltssm_enable(struct device *dev)
>  
>  	switch (imx6_pcie->drvdata->variant) {
>  	case IMX6Q:
> +	case IMX6Q_EP:
>  	case IMX6SX:
>  	case IMX6QP:
> +	case IMX6QP_EP:
>  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
>  				   IMX6Q_GPR12_PCIE_CTL_2,
>  				   IMX6Q_GPR12_PCIE_CTL_2);
> @@ -851,8 +863,10 @@ static void imx6_pcie_ltssm_disable(struct device *dev)
>  
>  	switch (imx6_pcie->drvdata->variant) {
>  	case IMX6Q:
> +	case IMX6Q_EP:
>  	case IMX6SX:
>  	case IMX6QP:
> +	case IMX6QP_EP:
>  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
>  				   IMX6Q_GPR12_PCIE_CTL_2, 0);
>  		break;
> @@ -1077,6 +1091,27 @@ static int imx6_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	return 0;
>  }
>  
> +/*
> + * i.MX6Q and i.MX6QP PCIe EP BAR definitions.
> + * +-----------------------------------------------------------------+
> + * | BAR0     | BAR1     | BAR2     | BAR3     | BAR4     | BAR5     |
> + * +----------|----------|----------|----------|----------|----------+
> + * | 64-bit   | Disabled | 32-bit   | 32-bit   | Disabled | Disabled |
> + * |          |          |          | Fixed    |          |          |
> + * |          |          |          | 256Bytes |          |          |
> + * | Prefetch |          | Prefetch | None-    |          |          |
> + * | Memory   |          | Memory   | Prefetch |          |          |
> + * |          |          |          | IO       |          |          |
> + * +-----------------------------------------------------------------+
> + */
> +static const struct pci_epc_features imx6q_pcie_epc_features = {
> +	.linkup_notifier = false,
> +	.msi_capable = true,
> +	.msix_capable = false,
> +	.reserved_bar = 1 << BAR_4 | 1 << BAR_5,
> +	.align = SZ_64K,
> +};
> +
>  static const struct pci_epc_features imx8m_pcie_epc_features = {
>  	.linkup_notifier = false,
>  	.msi_capable = true,
> @@ -1088,7 +1123,16 @@ static const struct pci_epc_features imx8m_pcie_epc_features = {
>  static const struct pci_epc_features*
>  imx6_pcie_ep_get_features(struct dw_pcie_ep *ep)
>  {
> -	return &imx8m_pcie_epc_features;
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pci);
> +
> +	switch (imx6_pcie->drvdata->variant) {
> +	case IMX6Q_EP:
> +	case IMX6QP_EP:
> +		return &imx6q_pcie_epc_features;
> +	default:
> +		return &imx8m_pcie_epc_features;

Could you add "const struct pci_epc_features" *epc_features in drvdata?

	if (imx6_pcie->drvdata->epc_features)
		return imx6_pcie->drvdata->epc_features;

	return &imx8m_pcie_epc_features;


Needn't change this code if new chip added in future.

Frank

> +	}
>  }
>  
>  static const struct dw_pcie_ep_ops pcie_ep_ops = {
> @@ -1157,6 +1201,7 @@ static void imx6_pcie_pm_turnoff(struct imx6_pcie *imx6_pcie)
>  	switch (imx6_pcie->drvdata->variant) {
>  	case IMX6SX:
>  	case IMX6QP:
> +	case IMX6QP_EP:
>  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
>  				IMX6SX_GPR12_PCIE_PM_TURN_OFF,
>  				IMX6SX_GPR12_PCIE_PM_TURN_OFF);
> @@ -1478,6 +1523,12 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  		.dbi_length = 0x200,
>  		.gpr = "fsl,imx6q-iomuxc-gpr",
>  	},
> +	[IMX6Q_EP] = {
> +		.variant = IMX6Q_EP,
> +		.mode = DW_PCIE_EP_TYPE,
> +		.flags = IMX6_PCIE_FLAG_IMX6_PHY,
> +		.gpr = "fsl,imx6q-iomuxc-gpr",

See above comments
		.epc_feature = &imx6q_pcie_epc_features;

Frank

> +	},
>  	[IMX6SX] = {
>  		.variant = IMX6SX,
>  		.flags = IMX6_PCIE_FLAG_IMX6_PHY |
> @@ -1493,6 +1544,12 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  		.dbi_length = 0x200,
>  		.gpr = "fsl,imx6q-iomuxc-gpr",
>  	},
> +	[IMX6QP_EP] = {
> +		.variant = IMX6QP_EP,
> +		.mode = DW_PCIE_EP_TYPE,
> +		.flags = IMX6_PCIE_FLAG_IMX6_PHY,
> +		.gpr = "fsl,imx6q-iomuxc-gpr",
> +	},
>  	[IMX7D] = {
>  		.variant = IMX7D,
>  		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
> @@ -1531,8 +1588,10 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  
>  static const struct of_device_id imx6_pcie_of_match[] = {
>  	{ .compatible = "fsl,imx6q-pcie",  .data = &drvdata[IMX6Q],  },
> +	{ .compatible = "fsl,imx6q-pcie-ep", .data = &drvdata[IMX6Q_EP], },
>  	{ .compatible = "fsl,imx6sx-pcie", .data = &drvdata[IMX6SX], },
>  	{ .compatible = "fsl,imx6qp-pcie", .data = &drvdata[IMX6QP], },
> +	{ .compatible = "fsl,imx6qp-pcie-ep", .data = &drvdata[IMX6QP_EP], },
>  	{ .compatible = "fsl,imx7d-pcie",  .data = &drvdata[IMX7D],  },
>  	{ .compatible = "fsl,imx8mq-pcie", .data = &drvdata[IMX8MQ], },
>  	{ .compatible = "fsl,imx8mm-pcie", .data = &drvdata[IMX8MM], },
> -- 
> 2.34.1
> 
