Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54616772A6B
	for <lists+linux-pci@lfdr.de>; Mon,  7 Aug 2023 18:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjHGQUb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Aug 2023 12:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjHGQU3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Aug 2023 12:20:29 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2046.outbound.protection.outlook.com [40.107.6.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E4410CF;
        Mon,  7 Aug 2023 09:20:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NfOXq+kCW811XvIkLs30cavd4MiJJw7wpVYME8pq3iWNDMfV7gFfDWIH5zNZQdkY4o+b795QnDFZ3ZSKqmjn85AQyFqTSzO8gaddJpZWFD5tsP10JIAy/Hu0bOv7MkXYF7A9yxMO20Fjk9dF7hPNRP2A+re6TGMMvMEuK1gyMZafdk3CqMPp05n7XnFD1OEO365e10MJsQOaVMnARWYN5qArurweL1vM5nsWqC6d7wf8sm33suDNuFmTre5lQuysfqKYxxnwCEZjwQTWuC9Wz/qnrvlVSoA4RZoKpqE55AyfTAQ0rB6jWCVuGWjmwm1hB/hj/Y8ZrTaWaQovWUnogQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBiCiP2CL7b952bj8I40tLUMWz+rhYhvcxg1YnVeZKw=;
 b=e/PlguF7qpSCnfXpvzGCdYn7Jonl76YLf194QGHu8QyhbDra6/2L9i93nrfbAsbvXj9mbYOFn1JMHGoOJQnFiRe/q+8MJ9SdmKl7CClidthxEVWepcv4yIUyL/NH4F8naNCS/TMmc0P8cZ2dHlWFMDEYwaV7gAj0DiVG1cQkcI/JpJx7UfvZkEGoaRmFTQZig7BfkUoddBgmDSefTzpBLtxdOt5V71Pt2QK39nYUVQdJl99LgqahWgdzMllHuYIFh3DZ7MeRuZQ1DNNib7808QapEPao6FlGn8rejDc835ZXVP4Dp2NFSrkgo+qIVRV5NPmUhG10tSozXXZP7Bbcvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBiCiP2CL7b952bj8I40tLUMWz+rhYhvcxg1YnVeZKw=;
 b=rHCYUlXoEjkqaqi/SVFmMqUmYlX4HhHVlw45qjtYgmMCsTGnU0kqrvH6GQEiBSj21jBsieq3yski60sz5oTo392UfDyXtaXXlY5c7fvzrC4qEzP0AV0h9NK/fa+z8cPjtIy1uADgDxxNp610xzOIX/C8fHi8DjRZboZIKOWKAeM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM7PR04MB7029.eurprd04.prod.outlook.com (2603:10a6:20b:118::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 16:20:26 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1%7]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 16:20:26 +0000
Date:   Mon, 7 Aug 2023 12:20:10 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     helgaas@kernel.org
Cc:     bhelgaas@google.com, devicetree@vger.kernel.org,
        gustavo.pimentel@synopsys.com, imx@lists.linux.dev, kw@linux.com,
        leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        lpieralisi@kernel.org, mani@kernel.org,
        manivannan.sadhasivam@linaro.org, minghuan.lian@nxp.com,
        mingkai.hu@nxp.com, robh+dt@kernel.org, roy.zang@nxp.com,
        shawnguo@kernel.org, zhiqiang.hou@nxp.com
Subject: Re: [PATCH v9 0/3] dwc general suspend/resume functionality
Message-ID: <ZNEZuoUVBVscVVKL@lizhi-Precision-Tower-5810>
References: <20230804180637.462573-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804180637.462573-1-Frank.Li@nxp.com>
X-ClientProxiedBy: BY5PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::16) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM7PR04MB7029:EE_
X-MS-Office365-Filtering-Correlation-Id: 820727a8-795f-4d55-7547-08db9762354e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QJM+S0FB1Ta0T8//RXnHaiSZ4agSxhR7dIPKWnByKR/PtNbZ2g0IaF1TkrPT2+AEi7C97ZAdzq3Rrkxh20vOrktKL/6XLR9/lpqL+l0CbqJ2N0ti7A6hPpKZIwl45jrN9edefnUvWSVIa3NnbnhU1gDsxaH1DMAA+ZD1WlS1/ZN4+p36S07aHgxt5YhqeGxkDg+x/evghAK+WdWl7CCqEaJgd0HIP4bVwsm1PjYuVZ1x+xX1dDXR4HLm+Y7BVd+kBQ9dKsZ2JvMdX1CsL+U/XrdMmgvcN7FuKpbBHDGLemb09yHyVyTeswnvgzj9cpXtHY3DZg44jSQiol4xAlImjkIxHRfin+BwrvHqSjQ1nDoxcmDp4Q3h9tvn4gTLFW4oXHQLZvANtnJOmed1uMmjo44tKtMZ6jXE6rLXudgOEmcL3PAqBOkKlEB0Ask1fmE7fU1AEciFPRxb4vbQMhXgyp/o84VUds9giMy6z/jsQQnPjDQZow3/jB+w05mF3UFl1q3mME/7F00Qm3YOXOrlkuUeVp267fM6lM9MZArwaKKyBy+IzI+baeyqGnCpUxUuA6Knboky+Sw7RSl2JfFFHtjg5P+5xVT44nfQLK3dkfWxz/GKED0hc5yhAO4x0FhuVgWYhxkbo3tXtN3xO8buBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(451199021)(186006)(1800799003)(966005)(9686003)(6512007)(4326008)(316002)(6916009)(86362001)(478600001)(38350700002)(38100700002)(52116002)(6666004)(66946007)(6486002)(66556008)(66476007)(33716001)(6506007)(41300700001)(26005)(15650500001)(8676002)(8936002)(2906002)(83380400001)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BmSGq2ETocUCoAbkKA9OxfhuC/Bg3dtXhXc6ZND0z0JGPXPf5LrUxKI4CfhK?=
 =?us-ascii?Q?sPXiKmUxwOy15mJKMWuJnX/NXUP09qHGip3qutosrHYIHlXmBOSr4+OPf28N?=
 =?us-ascii?Q?lrqi501FT2anB/i/6h8DhUzG8D532enWDnyar9VJ3tJtwaZkfaQdNIsA44ha?=
 =?us-ascii?Q?cMkwiUWZBipW8FC448y7r6cFBlg47W2EQtDNOfCioTGxX1dJzpfBW7GYShaA?=
 =?us-ascii?Q?hL8m8vRyiNOO+REZ93Ze+CSbR3E9sENbD8LnuAPA/tpBHnX959xtZpg83Hz+?=
 =?us-ascii?Q?6hNpYpqamDOZN5oPgcji5DmfoXK2QBmtLTy3VR5MzixfSyKTdmrBW1bIWVLH?=
 =?us-ascii?Q?XrpipizAzRiroNWpirw8T3kYRJ6PQZ49JU45nuS166kcnZd5qzApd9o44/+v?=
 =?us-ascii?Q?g11oGjyKw2cgTc21PnZ/DMs6+qEOxk/WXp8gVS/ocI38PzlvhzDS9rZQy8xl?=
 =?us-ascii?Q?EHDUIouRbP7dZnzW5cZXIRdM+oMD//L42bjGScIJhdTyys1SmoMBmHgAYkYf?=
 =?us-ascii?Q?xjUmXB030oTJWCAUyBst/7zQijouxSFJRE0fBAYsSh9GO5SBKlp8ajfdpfiP?=
 =?us-ascii?Q?uAPNBwsvVRTN1+Y3ytWBiOSUSp0HGyjzBdAP9L2Jjhc/im+0a31qN11mu0MY?=
 =?us-ascii?Q?9O7wfCFTh+VhPcrwuv5fAy5x9Gsd7Qr2nKLP2DFU/6m1jXn8XAwAP+YbfLzC?=
 =?us-ascii?Q?8BqMYJevLbz1CxYXLUxNK5eDfNCcbjJHDYEu6z8wJWcKGZv5xNChwQ7JEh57?=
 =?us-ascii?Q?joUshmEza0LFC+N3Vp2G4w8DsefL+zX/+aAjhvxogXfU3Aph5ebirbvF8Zg+?=
 =?us-ascii?Q?Vw+7knsxXie1FEBOQXg4etrL9SZb+XK4yqpU/nSaef1uQrRL5oLiCzujXRcP?=
 =?us-ascii?Q?Eg35ufGIpLFyBoPko6Eu55pG3xNxNaMZG60Jid2kjKJWufd5GdTxS0Cjd/F6?=
 =?us-ascii?Q?mr96YudlG+tY9gPf7J8ZVuYc8/IspV69u25c88f+b1QSjqJf2XIJfFlqn4Si?=
 =?us-ascii?Q?jQKKVINBEtHRET7auJMNaHt3IhVr2BamAkvAac9S9v9+ba6wyMx4JA1NfI7i?=
 =?us-ascii?Q?oxHO1VbJW+eK13v2fO8LzC7/rBQDWKPQose8VS/m2u/rH8GZsBCusAR7086g?=
 =?us-ascii?Q?O/3JBidDsVTmUVtfMPtS1nVKRjtz510K7NPzc4/TFNDsb198rjPKVPkQIxzz?=
 =?us-ascii?Q?xLVg+QENuMOZCXb+QwLk2ncAIJjydOpjILxLo3PWshXU4YEME91SxzWRaGL3?=
 =?us-ascii?Q?rxmlKRd4dtulrI9D/QaBXNaheXMTmE0PrDRzOAU7hUAybSQF1TgSTR6NanuR?=
 =?us-ascii?Q?gQSj0T68DHXwcdSTzpOib5gsXiWAr5dsJQVz7UkZatsKVOpcW7IsX5ktrhUv?=
 =?us-ascii?Q?wCxerUvUJ5AWx9a8BNm+WeeVgdMpZ5Er7dTQcJthLz+cTg9uWmNDh1t2hpxV?=
 =?us-ascii?Q?5Zzq7OBHSq7uYho6H3505qtYFM3RZdYpwys3KedY0t9lwvqhcokwxgGlHW6Q?=
 =?us-ascii?Q?mjs4q/9xZod01E+Hq0sZwLHTaFRkchcE7kP1OczJKTAqzYrQFg7ftgZIfxhk?=
 =?us-ascii?Q?eIGUNA8e8kowqpV0Aq0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 820727a8-795f-4d55-7547-08db9762354e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 16:20:26.1969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MqSA+Y11YmcKlrQJ7RXN/jrdciZsisgKWVMH2gtKI0xKE5JUmEZW3CuxAfXr6v+OHp1ptDqORiWl2eBnGXmcwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7029
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 04, 2023 at 02:06:34PM -0400, Frank Li wrote:
> Change log

Sorry, I forget change cover-letter subject. It should be v10.

Change log
 - Change from v9 to v10
   min change according to Mani's feedback
   Add Mani's ACK tag

Frank

>  - Change from v8 to v9
>    Reported-by: kernel test robot <lkp@intel.com>
>    Closes: https://lore.kernel.org/oe-kbuild-all/202308042251.yGAFqeDw-lkp@intel.com/
> 
>  - Change from v7 to v8
>    Add new patch to add common PCIE_PME_TO_L2_TIMEOUT_US define.
>    timeout value using PCIE_PME_TO_L2_TIMEOUT_US.
> 
>  - Chnage from v6 to v7
>    Remove local varible struct dw_pcie *pci = pcie->pci
>    Change according to Manivannan's feedback
>      remove unused lut_off and lut_base
>      fixed  100 to 1000(for 1ms)
>      using dev_err for timeout
>      refine commit message
>      fix sleep value 100 (should be 1000 for 1ms).
>      use dev_err when timeout
> 
>  - Change from v5 to v6
>    change to NOIRQ_SYSTEM_SLEEP_PM_OPS to remove #ifdef PM_CONFIG
>    refine commit message
>    change according to Manivannan's comments.
>      remove reduncate step dw_pcie_set_dstate()
>      return 0 when .pme_turn_off is zero
>      call host_deinit() in suspend
>      check .host_deinit and .host_init point before call.
> 
>  - Change from v4 to v5
>    Closes: https://lore.kernel.org/oe-kbuild-all/202307211904.zExw4Q8H-lkp@intel.com/
> 
>  - Change from v3 to v4
>    change according to Manivannan's comments.
> 
>  - change at v2 to v3
>    Basic rewrite whole patch according rob herry suggestion.
>    put common function into dwc, so more soc can share the same logic.
> 
> 
> Frank Li (2):
>   PCI: Add macro PCIE_PME_TO_L2_TIMEOUT_US
>   PCI: dwc: Implement general suspend/resume functionality for L2/L3
>     transitions
> 
> Hou Zhiqiang (1):
>   PCI: layerscape: Add power management support for ls1028a
> 
>  drivers/pci/controller/dwc/pci-layerscape.c   | 130 ++++++++++++++++--
>  .../pci/controller/dwc/pcie-designware-host.c |  76 ++++++++++
>  drivers/pci/controller/dwc/pcie-designware.h  |  28 ++++
>  drivers/pci/pci.h                             |   6 +
>  4 files changed, 231 insertions(+), 9 deletions(-)
> 
> -- 
> 2.34.1
> 
