Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289614C41AC
	for <lists+linux-pci@lfdr.de>; Fri, 25 Feb 2022 10:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237428AbiBYJnk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Feb 2022 04:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233806AbiBYJnj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Feb 2022 04:43:39 -0500
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01on2117.outbound.protection.outlook.com [40.107.23.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E991A273D;
        Fri, 25 Feb 2022 01:43:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=clacuUVM16/m8LSmdCnIL7/hLC/KpM6Un6DjttwXOZ+JZBLffXsJyceOKodtTtUZQNONWuYdYDugs190AUvdrjq0pRGVRf8aIV6IVkY8/cQzaYe+JhUBye/aSaMvOitaej72zl/YYrp7SA3x/x8wSZAmZuMbF/rTeeigj1lzOVFWUftRbd3KFTjxqBJN+Mf812fQVv0een/P5G3AQ/jQAr0Gi+j7qZbvJJKAQ92PfIfG9+qI5AqIoiKfswRwVh2dh2t+zTgJOOWQMhO4GyBzA87ZMfNdnie3EKQDdZcOQCKenEbaMOC4anTOH890d3eg+5q0f69naDA3T2QjRKyyjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWN5P7jBad2RGPEcnpe06943yiFUIbvdL91sFEG0K8I=;
 b=KtyG7IyAA5V6RROukeVO0aBfuPOxZCrRB21yId7uE1ggByDpBLHe1eXlUAdXF+t+ZC3ahGGAzPxkDb6TGsSRHtF5sJ3Kuhefw+A4Pmz7ycgMgZWdSeZnqWDLihq1zqtvV5EVdyZdtTzy4UwwAHs6l6EfTpGihgCDQYRXU8Q6w0pJWQBvFnMpnW7x/HVXpJAX56kcDKOQJC/y5pLC3mfrMi2fkcy88KAOn62HfpbXQioMji9l3nGU5IgGnHYvG7ZZcnkrpw5R/8VAAwFSVLBC8F6rIC/DXEdHCX5B+ly0GbqywUf+QtEMmsULRQJMDq6cwLW6n9kvDc+njyYW2jTBaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWN5P7jBad2RGPEcnpe06943yiFUIbvdL91sFEG0K8I=;
 b=QtDl9UxojcCrCvlk41D79oDxDheaXNs/oYh9TeZ2+YJEgn7m/hmtUkbG4oEYvx8zJoJR7gfHHLtLcK9ZuE6JL5s6PJakTTRw8kfk0Z1izf2P08YyfkM/TyyNBppnxI286wPqKb5AYc2C61GObBDXUlgn+1s4DGTEq7ndAfGy0u4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toradex.com;
Received: from ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3d::11)
 by ZRAP278MB0208.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Fri, 25 Feb
 2022 09:43:02 +0000
Received: from ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6c4e:9890:b0f5:6abb]) by ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6c4e:9890:b0f5:6abb%5]) with mapi id 15.20.5017.025; Fri, 25 Feb 2022
 09:43:02 +0000
Date:   Fri, 25 Feb 2022 10:43:01 +0100
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, bhelgaas@google.com, broonie@kernel.org,
        lorenzo.pieralisi@arm.com, jingoohan1@gmail.com,
        festevam@gmail.com, francesco.dolcini@toradex.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: Re: [PATCH v8 5/8] PCI: imx6: Refine the regulator usage
Message-ID: <20220225094301.GA2171975@francesco-nb.int.toradex.com>
References: <1645760667-10510-1-git-send-email-hongxing.zhu@nxp.com>
 <1645760667-10510-6-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1645760667-10510-6-git-send-email-hongxing.zhu@nxp.com>
X-ClientProxiedBy: GV0P278CA0085.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2b::18) To ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:3d::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6e756ed-57ff-41c9-7cab-08d9f8433746
X-MS-TrafficTypeDiagnostic: ZRAP278MB0208:EE_
X-Microsoft-Antispam-PRVS: <ZRAP278MB02089EEA4E2A7B4D88A4BCE2E23E9@ZRAP278MB0208.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DIbbYs50AmHnVjeX9LC4Geas8oRkx+GYanVZ4NeyV8Jt2OqpyxaTNh2B59D4TJO5F1ALywuuXzXtZ7SUnSB8EW5QrHcFdYQQ4fbMECg27dsic3nZJGFLqcEsN1JCnk4rnzkGZqxECEnlRw3Kk7w+P+MLCuMbYBlfp3Pu3TADsJDokrPRH0LFza5MRAaPcUqH6W9a4PMWJaimfeyowRa4YIHsKWG12e3pRA97w7123sohb0B3ekXVtaTsBw4LDKcnIyGjm1x150BkFfR3YCoTUh6jVYlSM36nPK/PqbYwl4SgdLardP23RM7k47Fm9oVlQO+gX7AKkWjBpPlg9BVgTxxA70y+JFBjr6UsbjlEkXHKLb5QHW+LQK56e5hOn7cJqDdCIy1fCfXSieuSru6r1FOU0yOg3WM49yjSSDjWUijoBqk0668Hn/p73JVu58B2zkcIg5iEoGZP5Do3tyTVTuYjBgiMc1JwVtjWu5dAhZS9doOX+6f9KyjaxHJWTpr50tk9tJy9itxYO9d9GGkd1gpeRdHeiGdsHNuaHNN2SOEvuZCt71gr0hBZKp4dlbIASYkydZOKHqFgHapMu8bEaKrUEGZFosvRBUB/Y89k69v6JkKqH4j0XOS4NSx19VzVv3gyEShEBTv9DQDXx+p34qnNA+Fc+enycqmoM9U87NOXQZux3g8JWSx4XcLyXFa/k68kxsXAYkVEuAcY2wBPLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(376002)(346002)(366004)(39850400004)(136003)(396003)(4326008)(66946007)(5660300002)(8936002)(8676002)(7416002)(316002)(66476007)(66556008)(2906002)(33656002)(6916009)(6486002)(508600001)(52116002)(6506007)(6512007)(83380400001)(38100700002)(38350700002)(1076003)(86362001)(26005)(44832011)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l1lWUHjn2+DZTfcLfe4CQxlml8elAkiEx/W1STjSkgcRPHSbnFQJH5H+WWbq?=
 =?us-ascii?Q?qe0N5+xymQjJw4hq7F6r7x4r7AD2GUmvvD2WL00kLQ68ukqEZFj7SOM8DwkA?=
 =?us-ascii?Q?1A97xMyNdWxjnATXmQM/l4EYRFo2qj7zTXY+0nsbPCn6rbeebHECJHx7boh3?=
 =?us-ascii?Q?bRrDtxa6oVh1mUZRSk+FO8dsZacGH7tcl8IM+3ktN71IMHKmGwS+4qmJMDLM?=
 =?us-ascii?Q?RcjTiS475yg1FJDrhx5t22EID/NF+xHTJmc0GgBflPO46To5VeJsjrfSE4Lf?=
 =?us-ascii?Q?K3g3T2qKoTc9r2OpU9vpGHQUw4SHCsObRfl4DMmKsB+uYqHf8ykTpfVlWYDS?=
 =?us-ascii?Q?buSfBMVbXcVXV2uxD8cdLwsKbwSVMRu+SBJDMCpULqZp3dRwW2rTBTrvlffa?=
 =?us-ascii?Q?lGI0VYmX6zoiiNU7oVmTjXNZHqQVgqq49DWT/q0TLBQmdkZ3mYFSFvIrgFFt?=
 =?us-ascii?Q?FKge/0E34x3TEeykwnUInkH1rxMgWQ0QcT3A72hEfysU6DbIuh5A7vpRflSR?=
 =?us-ascii?Q?9+PQBtUL7TOi1lrB+XwCQhS+fn8vopcojQNMAFPFvf1Ns5HMs+rz3irpWXhl?=
 =?us-ascii?Q?VbJMKfQKjtbojiq3n614OuMZ1ZLMMxVktkrGLjkg3NBFG6ignM5Tf50Z0+K1?=
 =?us-ascii?Q?Y5tWpAgw/c/ApwU4xMChFApieL449GYT0qkEeCxPbWWwXaiUdOPjYjMFH7tM?=
 =?us-ascii?Q?30cpdQNIRXUctEmH4xbRZkpq2yBVUH/Jy2Z6VI77n8XGLS6DWpkhizxgEWTQ?=
 =?us-ascii?Q?7Mk6aoxMojY9l49TDPmeeT8JD5BDlaupsY7XuDfdUfWZLTB8ub6al29rpiNx?=
 =?us-ascii?Q?7uC3hC6+O8GfOXb2ABxKDSQOLKV4R4B+ynMXMi32dYpIpinVcljZ5pz3FLXk?=
 =?us-ascii?Q?6oiSJDCLIfQfJUWLIVRcmq4kzZunSlJJSxnRYmz/EOp0BJQkqxbIQhGaJP6A?=
 =?us-ascii?Q?I6JMQB+homCHEEr/8htDF66VXdVH1e4uV46UiXnApWmKNKIQbNbtaXKJsCTu?=
 =?us-ascii?Q?9mC8PtOTfzltKr5nlKSoiZFzh+9/7YKurqEPYofFZWufZwh5Dkfcq9kovvTu?=
 =?us-ascii?Q?vEkP9cyb9ka5W8pjRjzNLR47rIaInooW0pnDalDxTBijafG/VUFX3XSU/axd?=
 =?us-ascii?Q?tkvDRs4v+3KpnkB3LVBiAgzkhEoTxVwouxNqZKxGfGLd9IgNKE6VCEORe9v1?=
 =?us-ascii?Q?Zbh33SvXtM23OB7Tesi4FnLAl0gNyBVvElMyzPRqeKEp0gsZxXqwVicTCEYn?=
 =?us-ascii?Q?zLlwC86A05BDRcGE2HbMZRci8BRLbTVxLn82P2Yo+agH8spQIE8NaUn8z1kJ?=
 =?us-ascii?Q?Mhv3EEbWt+XdCXY0iSaOm4V8csPc+RsuV/sUCVAvXHdmg4OCePspdbayXW/j?=
 =?us-ascii?Q?hkuxcB27FzmaDj99Tc4J39gy8ejOv5LhYKko3J3idxUKAespqBZUn36gtLno?=
 =?us-ascii?Q?/vTs767m9zLUBY77j/OwnNN1MKE2/NJmhRHwcVvB3ioNYfh0OlmIp4HpIQsJ?=
 =?us-ascii?Q?KfO9csXPIj9P69/tlF8NJZ8z9V/KsG3gqXYr2sYPLmeigobEXnhcXUhZmHqm?=
 =?us-ascii?Q?qvQV2NS9bbZLuEmIWs2CheQsihNLZksEoK0YSN7WPJMa8wuMXjhAhZUGyR+n?=
 =?us-ascii?Q?Exj6GIiRQ0sceZ2acytDQSupzKB7AkvF40E96v5lX8eHNu9/HIt8DyCGlyL+?=
 =?us-ascii?Q?H3k3Zg=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6e756ed-57ff-41c9-7cab-08d9f8433746
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 09:43:02.4749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qK6fpirhemoPODsghY4meo+0e5WBBkvIM7XDfIFZXLtMEuncY0Ygy/5o+8uwzWfc1tGc7ehhO5zhpiiwNx6xqc3YrBwqFtQmnQPM8187AdY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0208
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 25, 2022 at 11:44:24AM +0800, Richard Zhu wrote:
> The driver should undo any enables it did itself. The regulator disable
> shouldn't be basing decisions on regulator_is_enabled().
> 
> To keep the balance of the regulator usage counter, disable the regulator
> just behind of imx6_pcie_assert_core_reset() in resume and shutdown.

While this patch does not look wrong and improving the existing code, I
do have a couple of concern.

1. It's weird that regulator enable/disable are really non symmetric in
the code, enable is in imx6_pcie_deassert_core_reset(), while disable is
not in imx6_pcie_assert_core_reset() but spread around.

2. We are playing around with vpcie during regulator during
suspend/resume, why? We currently have issue with suspend/resume when a
PCIe switch is there, with the final effect of PCIe being not usable
afterward. I fear like this is related to our issue.

What about vpcie enable in probe, and vpcie disable in shutdown and
that's all? 

Francesco

> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 0f1b8c873a4a..160a0bd02098 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -369,8 +369,6 @@ static int imx6_pcie_attach_pd(struct device *dev)
>  
>  static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
>  {
> -	struct device *dev = imx6_pcie->pci->dev;
> -
>  	switch (imx6_pcie->drvdata->variant) {
>  	case IMX7D:
>  	case IMX8MQ:
> @@ -400,14 +398,6 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
>  				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 0 << 16);
>  		break;
>  	}
> -
> -	if (imx6_pcie->vpcie && regulator_is_enabled(imx6_pcie->vpcie) > 0) {
> -		int ret = regulator_disable(imx6_pcie->vpcie);
> -
> -		if (ret)
> -			dev_err(dev, "failed to disable vpcie regulator: %d\n",
> -				ret);
> -	}
>  }
>  
>  static unsigned int imx6_pcie_grp_offset(const struct imx6_pcie *imx6_pcie)
> @@ -584,7 +574,7 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
>  	struct device *dev = pci->dev;
>  	int ret, err;
>  
> -	if (imx6_pcie->vpcie && !regulator_is_enabled(imx6_pcie->vpcie)) {
> +	if (imx6_pcie->vpcie) {
>  		ret = regulator_enable(imx6_pcie->vpcie);
>  		if (ret) {
>  			dev_err(dev, "failed to enable vpcie regulator: %d\n",
> @@ -657,7 +647,7 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
>  	return 0;
>  
>  err_clks:
> -	if (imx6_pcie->vpcie && regulator_is_enabled(imx6_pcie->vpcie) > 0) {
> +	if (imx6_pcie->vpcie) {
>  		ret = regulator_disable(imx6_pcie->vpcie);
>  		if (ret)
>  			dev_err(dev, "failed to disable vpcie regulator: %d\n",
> @@ -1029,6 +1019,9 @@ static int imx6_pcie_resume_noirq(struct device *dev)
>  		return 0;
>  
>  	imx6_pcie_assert_core_reset(imx6_pcie);
> +	if (imx6_pcie->vpcie)
> +		regulator_disable(imx6_pcie->vpcie);
> +
>  	imx6_pcie_init_phy(imx6_pcie);
>  	imx6_pcie_deassert_core_reset(imx6_pcie);
>  	dw_pcie_setup_rc(pp);
> @@ -1262,6 +1255,8 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
>  
>  	/* bring down link, so bootloader gets clean state in case of reboot */
>  	imx6_pcie_assert_core_reset(imx6_pcie);
> +	if (imx6_pcie->vpcie)
> +		regulator_disable(imx6_pcie->vpcie);
>  }
>  
>  static const struct imx6_pcie_drvdata drvdata[] = {
> -- 
> 2.25.1
> 
