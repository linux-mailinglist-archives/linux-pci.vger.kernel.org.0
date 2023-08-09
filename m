Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B18F7763FF
	for <lists+linux-pci@lfdr.de>; Wed,  9 Aug 2023 17:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbjHIPhQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Aug 2023 11:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234540AbjHIPg6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Aug 2023 11:36:58 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on062f.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1f::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358C430CD;
        Wed,  9 Aug 2023 08:36:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ht9BxP1GQwEmOgTZqo9LTu3r1OJp8BjeMX5+xBDeCMPa3HAdp4+Vx9RC/FEw7aWs9TX1RKk1zloqWMjvJnaHfLmrZoExr807GYzlYGYWH42/bIotH4+JgCeoXeHdgOfhuhFLIQi6cgBlOq9NjU6T21431TlTFkMpEexxNfnMzMcsw22Lw0Vqvybcw4Wq9mlaXQ7B1JiVBgnAre8L8EcYCZ43kR8NNw4K+9NFYtBK089B4pn4yeifQATcEST0csES5f1Zwa3NG6M5LLrSPFTzQSf2H+kZKVcZtw3DkLWP4ZAf0KK1wGsk/IfumCoMLbCP5UuL08ABBw8eXXomDmsHUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yib15noWJ4gmco2+SOvGvodpLranHLyMhDXkJYTdXI4=;
 b=awoow8acQsgtiw0X9jtsKcJ4d9INpdrfZQM5KaC4SkS5pQihH2f/zGwpJwytOVwmndOHwNITxJESXX+IPmWBnBAm4+THeYAYU/AsBntPRFPCChWlfANSFavkVwyHg3hHA+RAtVbPjcwDjSz92L/spLQXr5huXanrgwnB8rOsDS3WDE2japDFvpmVhVO5XSbaEojZSYUUCqj98aF2JQWSPtVXW0b4mdBxfhWSaqiLIYjmgUiFUXbyDHwZLhohE0ilmSoFsnrdFWCQLreM4GJycEE/9jaYQy/bLrLi3AdQebSXs5LIJ1OHppArD2rvoZmS+8jI3+txRQ/rDMrOEuOwBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yib15noWJ4gmco2+SOvGvodpLranHLyMhDXkJYTdXI4=;
 b=EcX5uaKZprhKOyKnlpF6l1R/z/HV1Yt4W2ZehNPpIx0iYATbQhwEyNqmDsFIOOeVr8pjwwXMIbyPwN2s1Ij8G/Ley0QbeC6jIBokoBTdy62wGVXWMmTdrFH4102AVPw9iJA06cOPI6absHRJ5NPBbPCysb6UUvhIL7Za6tXksXc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB8PR04MB7161.eurprd04.prod.outlook.com (2603:10a6:10:124::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 15:36:04 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1%7]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 15:36:03 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     helgaas@kernel.org
Cc:     Frank.li@nxp.com, bhelgaas@google.com, devicetree@vger.kernel.org,
        gustavo.pimentel@synopsys.com, imx@lists.linux.dev, kw@linux.com,
        leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        lpieralisi@kernel.org, mani@kernel.org,
        manivannan.sadhasivam@linaro.org, minghuan.lian@nxp.com,
        mingkai.hu@nxp.com, robh+dt@kernel.org, roy.zang@nxp.com,
        shawnguo@kernel.org, zhiqiang.hou@nxp.com
Subject: [PATCH v11 resend 0/3] dwc general suspend/resume functionality
Date:   Wed,  9 Aug 2023 11:35:37 -0400
Message-Id: <20230809153540.834653-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::28) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB8PR04MB7161:EE_
X-MS-Office365-Filtering-Correlation-Id: b3eb21be-dcbb-4e59-a967-08db98ee5699
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RisI70BKsnAgVVi1xlCgd61BYNj7UFs92qU3BdUPDGx38PbuoZ2fDOwKQGBuL8XMbjlox5695m9qLOYO7tNdksW+kRWfIue3Lonho040XK0FiV0+KINNY44kGTdk/868k3wdLDAOCHkKLy4tx9Cs+cwUkmhHfW0ASIrHZYTJZg2VGieP3hRBk49r9vdUgW6wTmAGYf5fuARu7+iIdd3kuzRrKUN07Y9fZxEMfov9w8wiioWp0acrCrGpqBSsnuarcS0qpivxq3CjKiGouB85vs+Sn/h+6BkHhuLnIt2h/u+xK/TOgdgQy9/rIsoD/81ZLDgUzls13NJOucqmCgoFLpFKPEj3SP23us994NVAaQs7m7NBEqJXLMi3jOLrx0GgIwxoPUAhcfUZzH7QNFmEqawZn2pH4ns+1dMr2xGhGVF+qA+9UuLfpYPlf74/CIW+iThz79LSh9eJVQYmV2fZ30CK5HIG8rynNXtUboWtdgdDrkvXolubSizOmGsNtKnZay46+P35V0xiSm/yTxHEKch8Gp8T9kcvvsr6wrmO/+lPWZyUjE4De3oZi5GpOq+NQNE2T4zBMu859BoB2Zt5lgV9m34Org8v+UfTVO3fO7y7DULUYPhSU4yz5fO8rkNc6CM902z60Pumw9Px40si8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(186006)(451199021)(1800799006)(6666004)(6512007)(966005)(1076003)(6506007)(26005)(6486002)(52116002)(66476007)(66556008)(8676002)(8936002)(316002)(41300700001)(36756003)(83380400001)(38100700002)(38350700002)(86362001)(5660300002)(7416002)(2906002)(15650500001)(4326008)(6916009)(66946007)(478600001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JayJAnxmPpreHaTjRqusY/8Dfg5/+uIBzYqIF510niK8G8gfBY+Zqkik0vP6?=
 =?us-ascii?Q?4VVWMz8JqnWz9G5vHSf1BLYD7blaU0tADvNfW8Xv5Z/xDm9D/J8xC75aV7/C?=
 =?us-ascii?Q?iO+V/GmM+lV7EYi0Evc9j2/NOH6docDK6s9bhVlrdKv0k3IkUmxZBtgut+qz?=
 =?us-ascii?Q?rQ7g/M8w/YImpzA0oK8BXiR+isFVh5zdO/ZG5W80X8GzDWZKJ4331OZxJuT/?=
 =?us-ascii?Q?JSszw3XjhsbDkZs/gS4KoJQNKgcl75mCQ+ypV04mD8Y79kv9TBxwWS9ShMYh?=
 =?us-ascii?Q?qPwLKJrIlWJRqnjlhVOzYYoB002cabz9tlFCMQtLmMrBGoiWaTHWDRbe1Vuw?=
 =?us-ascii?Q?C77hWOMNRw2w2++w4nng7kc0Lv1VNCdBZdtFsTcR/vYtC0va1wzktf9uXDw0?=
 =?us-ascii?Q?4wYKkl+mvATSZxLHDj7xjpQxQuJiWN/g9KSHb4yG0P0KyOozm/I8Hlr1Ip/z?=
 =?us-ascii?Q?fTjU6eNMtaeKEFMcMkeffaJUW+vsZfSQxE7xhqN60HGzJRaTxMedoKdJRkBH?=
 =?us-ascii?Q?6m/19y4FcxJrKlf0u9Qjz/5F/qrHMk90SUlQknP00X04qgPpH+Lt9bcLIbBz?=
 =?us-ascii?Q?ca4LfVpYEArDa9BikDsEK4RPiCqonoFqxFvu7FV68y9SETX72ca6kLnEKVdw?=
 =?us-ascii?Q?8L8co7Sv+W2Jt+e+kxvQhumoI0J9NDLj3z1pTyb4PQz93ThMGZF7OiQI4mqJ?=
 =?us-ascii?Q?rnoCA5HtLCRk3y5acraw+P8tQ7mi7ARW1MnApI8KO4Ey/MvPSD+g17qGK1eT?=
 =?us-ascii?Q?AooqwaQfN9O4OHs3URIDot88OFLd9gIePr6TLLzdToUwRLBcBvjZyuTCdW3I?=
 =?us-ascii?Q?ndj3bpe5C+ql3MWelw6xvquSD8smjvpQsZTM3FGMQXwuRH7cliZtUADdWp5l?=
 =?us-ascii?Q?l1xcdq4OhmTrIuXJxr7afdlUVJLkXxJg3u41LsaRBAew+oJoY+Zz+KbcTXzF?=
 =?us-ascii?Q?P/BmzmbaMn67MAjH7fK3+ejaIfdsmEqLoFezJu0aU6rekMc0Y53MYzoZtZ4m?=
 =?us-ascii?Q?dQtWSqEtz8mZvr/kILEK089hrcFFPcbI7U4M2rSa5oM9ZLciZEVf7mCN9yuD?=
 =?us-ascii?Q?S92BxJs69tKNjiW7dm875AvkiaOSlNCvwMH8Wqlj2dVSgc27OH8Ge+2oj7Ou?=
 =?us-ascii?Q?KI+YNeilAFg5yuKSz5jUj6EkhtMpc1wuFW2niqCtvZ/9cyi+JJE9McNp3JD2?=
 =?us-ascii?Q?NofJJvibfhktzm+oEH3tIQRKTde+ApyX9ats5DZng295SkvK4pgz0cwalaLv?=
 =?us-ascii?Q?ytulc9VtfksItE5CRGkY62gXYJ4yzqWmyfTax4paIf7B27W7l7DXXXiS2tr1?=
 =?us-ascii?Q?CtZDC3qpup47SZrPahuXIw1KiH7A/irqdxPZtcd7Axx1rC0c/2RLcuOcI8Dn?=
 =?us-ascii?Q?HUAd/Xvp5J2v+N9iJqPwm5WNhlRAycPl3tzc4FxAhWHHx95tXvyRlRpX/w9Z?=
 =?us-ascii?Q?LisWZIZw0cqLJY18fFVSjBD55IFA8Mmn+71IJKQMBoirnWmL2/Q/6Biv8wX9?=
 =?us-ascii?Q?EyOhof/cXmqfeRqbPD4paYjLAJI2i86o/GIL/SDyyKwyQ78ot3sI0K1Ysy4z?=
 =?us-ascii?Q?iUVg0WKAQrCTT1D+oxY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3eb21be-dcbb-4e59-a967-08db98ee5699
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 15:36:03.5813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hNWUgGGIx0s00JpFReXoTy4UDa63v7e7rDtXnQxHYi4HYVm6zYMC+bsbTUee7ioExa9C4GqvmnPdU1QtSyqPaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7161
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        T_SPF_PERMERROR,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Change log
 - Change from v10 to v11
   Fixed two missed dev_err message change base on Mani's feedback

 - Change from v9 to v10
   min change according to Mani's feedback
   Add Mani's ACK tag

 - Change from v8 to v9
   Reported-by: kernel test robot <lkp@intel.com>
   Closes: https://lore.kernel.org/oe-kbuild-all/202308042251.yGAFqeDw-lkp@intel.com/

 - Change from v7 to v8
   Add new patch to add common PCIE_PME_TO_L2_TIMEOUT_US define.
   timeout value using PCIE_PME_TO_L2_TIMEOUT_US.

 - Chnage from v6 to v7
   Remove local varible struct dw_pcie *pci = pcie->pci
   Change according to Manivannan's feedback
     remove unused lut_off and lut_base
     fixed  100 to 1000(for 1ms)
     using dev_err for timeout
     refine commit message
     fix sleep value 100 (should be 1000 for 1ms).
     use dev_err when timeout

 - Change from v5 to v6
   change to NOIRQ_SYSTEM_SLEEP_PM_OPS to remove #ifdef PM_CONFIG
   refine commit message
   change according to Manivannan's comments.
     remove reduncate step dw_pcie_set_dstate()
     return 0 when .pme_turn_off is zero
     call host_deinit() in suspend
     check .host_deinit and .host_init point before call.

 - Change from v4 to v5
   Closes: https://lore.kernel.org/oe-kbuild-all/202307211904.zExw4Q8H-lkp@intel.com/

 - Change from v3 to v4
   change according to Manivannan's comments.

 - change at v2 to v3
   Basic rewrite whole patch according rob herry suggestion.
   put common function into dwc, so more soc can share the same logic.


Frank Li (2):
  PCI: Add macro PCIE_PME_TO_L2_TIMEOUT_US
  PCI: dwc: Implement general suspend/resume functionality for L2/L3
    transitions

Hou Zhiqiang (1):
  PCI: layerscape: Add power management support for ls1028a

 drivers/pci/controller/dwc/pci-layerscape.c   | 130 ++++++++++++++++--
 .../pci/controller/dwc/pcie-designware-host.c |  76 ++++++++++
 drivers/pci/controller/dwc/pcie-designware.h  |  28 ++++
 drivers/pci/pci.h                             |   6 +
 4 files changed, 231 insertions(+), 9 deletions(-)

-- 
2.34.1

