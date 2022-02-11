Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5BB4B2A4F
	for <lists+linux-pci@lfdr.de>; Fri, 11 Feb 2022 17:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244754AbiBKQ2E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Feb 2022 11:28:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351554AbiBKQ2C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Feb 2022 11:28:02 -0500
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01on2096.outbound.protection.outlook.com [40.107.23.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5961A333;
        Fri, 11 Feb 2022 08:28:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3WSCx3XxYLKDSc7i3JHqkbH13lSUcysqne7GtmptsXCYX72n4DUq5D1DbNPjEUW4iSA4zdC7hIfJLid7QS4PC/gmlDMCE9OIDn8s4WsgmF7o/sYDAaTgdEMHP2KPW2kpDBDOIYyUjPmcyT/TnJdhcZRsPcLUyQRBXmn6kvj0m3RZWU7xsiuYvoLlN0sBocmEOCRaPGnsAUyqWaRu0lvdSIiguv/68Z6iCTXQaKnlFjsy5fsqUEztVspe1YrI9xerM4qWnGWbLJejKcfJIvckGYXRcINvIe/TJVv5EpK9fKDTo5WcQ1SSwxrwDRkNKX9Sx432m6ls/0WxhoeYRBK1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rPKMZ5ReFurq0h0L8ouK2zRe2/tMJ+VJ5AVkHQTOPb4=;
 b=EafzWZfDuLtXZ/qkSs/4FPHLfSduYCPtb8T57sxq7Xiav0zWtEjPjlRaXd1DLj9F/qE0T0xWgOAphfyyaaCKEMOuNhNEv6Ttl9Th8DZHoZYzQ/PlTvM0P+olCQEuTQqg53O7TT49fG3Ha/uIaqcohS2qEobVOJ+xq3vE1JO0mEvdUU/qvheSmYGIsPN43BzFKIDHz+dSuBGyig/gK5HONCI0of+2dAN2UL4ns0KsMVbFhR2iBz7fDlbk+mlYX8I/LpoqnTfocVPWCYV75MJ/4vg0cgusucfOf/QJK98l6+ypuuYoqKJrsFke9OU6s5AhfSffH2wmfu41+uUlAiqHfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPKMZ5ReFurq0h0L8ouK2zRe2/tMJ+VJ5AVkHQTOPb4=;
 b=p28F+PbjNR9yZC1bVUp76kvjiT6bwLPWAvlcTeC659dgVswhpkzF1TPQRy40KByIWnKZKmBaMQ+aINJHiFDPAIT4CQQKMiecvuOyqJbwplf0IVZ0UpTef8NEnpRmXBWuLvK5P8ZQ59N8Kc8nmcaQOuxp5cohluihUrLF+XZ6la0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toradex.com;
Received: from ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3d::11)
 by GVAP278MB0261.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:38::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.14; Fri, 11 Feb
 2022 16:27:58 +0000
Received: from ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6c4e:9890:b0f5:6abb]) by ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6c4e:9890:b0f5:6abb%4]) with mapi id 15.20.4951.021; Fri, 11 Feb 2022
 16:27:58 +0000
Date:   Fri, 11 Feb 2022 17:27:58 +0100
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, bhelgaas@google.com, broonie@kernel.org,
        lorenzo.pieralisi@arm.com, jingoohan1@gmail.com,
        festevam@gmail.com, linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH v6 5/8] PCI: imx6: Refine the regulator usage
Message-ID: <20220211162758.GA287827@francesco-nb.int.toradex.com>
References: <1644290735-3797-1-git-send-email-hongxing.zhu@nxp.com>
 <1644290735-3797-6-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644290735-3797-6-git-send-email-hongxing.zhu@nxp.com>
X-ClientProxiedBy: GV0P278CA0032.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:28::19) To ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:3d::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d697451-32c3-4b59-c240-08d9ed7b7735
X-MS-TrafficTypeDiagnostic: GVAP278MB0261:EE_
X-Microsoft-Antispam-PRVS: <GVAP278MB0261F5E95FAB92D53DFAA3F1E2309@GVAP278MB0261.CHEP278.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uBeIpqligNT5pbSbEuAWJxg2NPk5ABkcP5sYlpheP8TxoeFa7o7gWVkFnSl5qyPJoGrg2cAPBxa8U/2XQ5mWY3rSjSDu+slU813Jcjjcjty8trlosmCnF+fTMmisyMfZjP3Z6Vd2bYTEDG+r7goUZm9KtN4YcDQCTwcIxr+v7ZWpencf4gyg4ZlYoav29ce5wfJIjPy19dBlaym7nAM2Hl6vb8X7IyrgBKU0VYj/Ez2WTGgD/tlkU52kZFi4z7a5k/MDSgqKF+GTc6rEL+CTHM2uEsDMP+32udhDNTMu0OffU4p37Dw6vg03JX6EUzcio6YT95M4uncEGIgOvzLJiXfL+XeYxHwFuZEpQRBHpVIwAjQjGvwwLIdq6QXig5y+7h+MDC7j89wYz/9Gb2Jod0k4sztXV6dQx8HuipGVtSpHr01Vzk1X7i/njV7EDXxJO69TfWM5EE9b6EXeQ1229P/5RI8U+paxWklsrvuY8jCkTFoKlekRfHUcahNsXVYQgghPHKnpa06JcO9C60mxIxSrZVFVE6IlQMAQ0VmlrG57i51W1zDgrq81gv8WeFePQvsJJodHIhC+e5Erz0bQ92k1W3wfiPKdhL4bWrS7cmPyhQluz1TJBbbhR/vbg/aUHoPsDGUUg/44kfIDs86IhnOJ8UtCkETS+n8Sh21VD0h6AsGPp79itYES7auTl1oov3MCR7JCZbp0LvHfBh7p+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(136003)(396003)(39850400004)(366004)(376002)(346002)(83380400001)(6512007)(52116002)(6506007)(26005)(6486002)(508600001)(33656002)(1076003)(186003)(86362001)(66946007)(2906002)(5660300002)(44832011)(8936002)(7416002)(4326008)(66476007)(6916009)(38100700002)(38350700002)(316002)(8676002)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4hMLAUvnEUlKmDRpzb/b3CfqQd5Y2dOCo4tQT7NSFEd1W19hdhQc+FnCDc4O?=
 =?us-ascii?Q?zyyBNrfHoGs8bvr4UzGwNbHEYhHB/uNPH9utVavH+zrzZUUTjaIqyqJAxIpK?=
 =?us-ascii?Q?lpNTMRfPKVPZZdYJysTCOrvm1n9Tt/TVUrsQea2tdzEqMofGBCJGns7F85QL?=
 =?us-ascii?Q?RXyROIuS+UaQqDjDCbGbyPgdBorxNwM3pmYFr7fJ9wFGzpizlVqhb5xwaNzC?=
 =?us-ascii?Q?5Ydjo7WabhiE7+o0Ekjbo6krd5JY5lL4ggqHy3vNukRsL3q3rLDYqMeG8l8f?=
 =?us-ascii?Q?uv7o5mZ0IrxDCYYO8haYU07kkTLAjc3wkCe2wrGVa9ILnGfVgesdw3JRO3RI?=
 =?us-ascii?Q?jlJGWVgsfamt3JY0cdeUXBeQAPo6iOrEfV8A11EJS4KuDwC3ckNQa3/oEZg+?=
 =?us-ascii?Q?SOa5/WRx6h3WLWTJsJUEh3HtqEWAMTK93VkXzUj1UT6p6MENTwpnZmK6j9fe?=
 =?us-ascii?Q?b9YVC90+k7MJde8NrBlOWPccMwzy8gIIYuDkV5w03qI3WEmotGWVSxFYGKpl?=
 =?us-ascii?Q?Z7X8sjKTwGB/n1RfdFecgOWYnmILMC4Q451JSxsp6ZkqNtKiCsUIIAJTYAtB?=
 =?us-ascii?Q?qvUIu0ADPXeFhvl0ULDRE8NzdU1mou/M8vSrJ/LCaxSuNU/Wf9dUcyXkzq/h?=
 =?us-ascii?Q?di4+HROYW51WHkaEYiBIn2m45fKd/Kemy90EJvnmGuAG2P46QZJRQwLzwm67?=
 =?us-ascii?Q?kB5RjKRa9RREVGFu5pWEzX6XWWwPtrgLWwctCcsY97clDK7KziFj7M7BnfZB?=
 =?us-ascii?Q?jwGSfXHZgtG1cf52qhEQyC20ChH4NP7n8i9WdVMe0SHiOonfrd3ONJ4ez7Ks?=
 =?us-ascii?Q?my6lfqhcCEB9SME4+GXa7s3ljwvykjEtLts476stsFtH8AHSXjdfWaiApMfF?=
 =?us-ascii?Q?8l/256GEGQcugozYBiN8b5gFRaFyP/ZnaUN2P8s3vzxP0CHWKvEERBZsZrhP?=
 =?us-ascii?Q?Ns3sy+aSysg6cDKHXYRq+0IQuwUPBh2K7SBI9VUlarj5GuKsoSnXr5cE194n?=
 =?us-ascii?Q?YAm6nxpZzHpAaVstTknVWzf8QGhFs519sIvU78MzEWiXkSDsZ914c1+59dlF?=
 =?us-ascii?Q?B18pNtJ/l2Z8OmcS0H9XBQok9zmFJiFae+b/HoZ+6Emv0NVNzyw4DjdP9nM4?=
 =?us-ascii?Q?K7oWAKmrjFPjlSCcRStKKXgkYYWAvqD5RrisTJqUA7GIx1iHTluTb86OYCiR?=
 =?us-ascii?Q?/Wy25SZoldvB1netnJ1ODAXZtaqdO3cIVnT6gFPuwf6QJeFquZu/nv4jQvDB?=
 =?us-ascii?Q?5Xe2eBQ9B6ELdLunlLlH+TeT/gzVnfqqFA9plz6B4HKKEQtmraleMjhCwLRf?=
 =?us-ascii?Q?1lWQH9qnIYN87pQRwiKWzUiIPgrNy2Mqhlr8o6tLrftYgLER5VV7/6d3DsPw?=
 =?us-ascii?Q?aS7mBhi9gtMq3eFn8DTaMFvTyK338T09f68E/oDvoKGkWyezAlyhshOlMNN7?=
 =?us-ascii?Q?z3FuEvaGG4A54IuwSnsT3yrtWV3p1DEpAF8N8zav/bLYx+yr1PLRwEaUalbE?=
 =?us-ascii?Q?tN70o0hrFicFPeFBuNIIB/EBsRmCgan0z95S6xJMVQEydW2VAgb9aGUOtMOo?=
 =?us-ascii?Q?Ai7n4TICLIvtteA5Gsej+0t0ibLplAe9f7x/258smI9/iuRiITgiFKkcM9PI?=
 =?us-ascii?Q?siDA+K0LFkQzNU6XYC7J1sbK0VelWlSJCM6nfpj8RPxzNfnfVX5h5acNexJI?=
 =?us-ascii?Q?eCsUgg=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d697451-32c3-4b59-c240-08d9ed7b7735
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 16:27:58.7345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 170q9f8ttYu4XgU9VeNLhqOMawkD6+SHfssMUmBHLA5afj7s7LkI8clF9/yONapwbLd7oaPlm2BMx6aHNbbj9N6rcKntjkm63eLfzNclMLg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0261
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

On Tue, Feb 08, 2022 at 11:25:32AM +0800, Richard Zhu wrote:
> The driver should undo any enables it did itself. The regulator disable
> shouldn't be basing decisions on regulator_is_enabled().
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 0aca762d88a3..e165ad00989c 100644
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

This commit is not just cleaning up the regulator usage as you state in
the commit message, this is removing the vpcie regulator_disable
from imx6_pcie_assert_core_reset().

I would not do it, this is called for example on the shutdown callback
where it makes sense.

Francesco

