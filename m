Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B885BD144
	for <lists+linux-pci@lfdr.de>; Mon, 19 Sep 2022 17:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiISPlW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Sep 2022 11:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiISPlR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Sep 2022 11:41:17 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10078.outbound.protection.outlook.com [40.107.1.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB57399CA;
        Mon, 19 Sep 2022 08:41:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRk3boPjjxuMD6NigIm/BvuFA4JDwZ8elEawe+esYrYgp4gsp04wk6rTPEBj32hLzQdzhqbKRTtvw7k39m1x4N5nOcPjhsfIE2K1O9XcCjapJSWEZyRoVR2CnfvYTC07eb8nZ3TbakG/yDZRLICTvwXEAreX+vAftWaohsCSiRwTwRAAdUCacyU8+bZvh2CIRz9ZOeufHGorYJA1kO1IFSAJ7ZbHhIOlVt8FJpPobADYCd0iMV9Q9M/Xi5c+StZIhBONbZCKd1YvGSL7ZEKDUAen4iqpAjV5amEZGCIVmHriIKmCkUBXZpxEp5aoX1K1bI8q8jwIaqdxHio/J3YCgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PxyZmoQ4HPxt9JAZN3QVzBllZWpIazPpqniEWrzTllw=;
 b=Z2PET0njyMxgg/T1tXJ6TEXyESPyYzWcunUd0NYbsLprGcASOfP0W3aQp5bj+Km0x7ztwNEyR5Vo8oF5Nj0ZdXMJp2TelZyCp/NEnW8cFrvB87M5z0sgY//PG4U0xkDaenCeC4NWZpKMvXxlUlmWHGOg2znTAy4Mgg68GZ1x5kas6jDv81UTan2Tl+KhElBYxMh0yVwbnyG+0nZXhWp08QPuNn03DP/nLekVxKzise8Hd+4NheCUfIMgBj9mf1OuF1DTF58TELKJTIDbM2m+/CNTGPotqlhZddV9yHxV0FpQm95V6RdY43FrxUTdOCHwYs0EDq3rRExLYs3EXrZ16Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxyZmoQ4HPxt9JAZN3QVzBllZWpIazPpqniEWrzTllw=;
 b=o4FtEvCaK2wWAy7LRS+8K8nNGjt+IKE5/TvjBMEEBgH81QMt7/MB1GTeXQ1oaHrFKS4pNeUx7V77VWnOaMSDujs0kdFWWo0tlpa07aC2+wcy6kNNi9ZgHLVfs8StSfM/DxH1AzfZvPXJW97M0e1P5qkVWfJfBY15t/IdGzeKSA0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com (2603:10a6:20b:408::22)
 by AM0PR04MB6945.eurprd04.prod.outlook.com (2603:10a6:208:17f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 15:41:11 +0000
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::5a3:ff70:317d:a99e]) by AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::5a3:ff70:317d:a99e%7]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 15:41:11 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     maz@kernel.org, tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kw@linux.com, bhelgaas@google.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        peng.fan@nxp.com, aisheng.dong@nxp.com, jdmason@kudzu.us,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com, ntb@lists.linux.dev,
        lznuaa@gmail.com, imx@lists.linux.dev,
        manivannan.sadhasivam@linaro.org
Subject: [PATCH v11 2/6] irqchip: allow pass down .pm field at IRQCHIP_PLATFORM_DRIVER_END
Date:   Mon, 19 Sep 2022 10:40:34 -0500
Message-Id: <20220919154038.187168-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220919154038.187168-1-Frank.Li@nxp.com>
References: <20220919154038.187168-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0059.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::34) To AM9PR04MB8793.eurprd04.prod.outlook.com
 (2603:10a6:20b:408::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8793:EE_|AM0PR04MB6945:EE_
X-MS-Office365-Filtering-Correlation-Id: b8555b49-e1c4-4d66-36bb-08da9a5560e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o7qW4IUI8z7Ei3qL37BOMKsA996WvhgNyWKNR15nRqcBlH169jvZkZb0nTkrKhTdu1YfkJCDBOgXuPqEvb1Fg47MKtTCaqFpzg+pOZS7+cw8z37lww6evxvmId4xwfGZIYvxiHkuMdmqEjQh6kaMchUS6qcnkqvPgG+HYih/Gil3NhbjWvhkNZp8E1jb7rc1c4SstkDgJHDgb8RN/fZGMagBECwaI8kZrm19MnNi9gkPeMeFdsjqq1Q2FkI2H8W9LIHz5usQVnEHtwM5WVQZlVIcR63Oxkc+hI7qXwl8a5iMuh5dvBHoOasKZEUHiE3e3Ar8bftpIMqqi9jJc6dnqa9AsUsjHHVXD5NGp3Ntg4b+YYcXbpe1a8ZL+MKmsADupJnMeURS+tTfVR9gYarEPuAK25pKfiFxx/egfeO4d88Bv/zSn5076/C7vSgga2Y3RAsedXdTEIv+gdyISPkvgktAqoUWsXpMGSWSkBHKx+qDZfUHkNLFqGGcJlhic8dOMfEGWtEbGEXuKo0/JXi55YmFoTRIT1F19C0n0uaysGcG3E3pVYdlnolOp7vOvRvLIdZ+stvujmicCe4hDq1lgQbNei00PyIROzxSH/iIuanE8DXO/ZQvrCXcMFuV8MjMwqXigk3r+voJ8Ym2FbUvOeyD2IUAjlxoA/nmp4ygmtxGEH8ZHacjj30ag9x2gBd26gikDl36vcMjKUgWNNXDEt9hAP2PR2Bl6oJkbPWqMDLpJYKe8VHxrqgj+Sa8/LYUpk5HGx04O6olZq8YgENlFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8793.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199015)(66476007)(36756003)(66556008)(1076003)(2616005)(2906002)(66946007)(38350700002)(38100700002)(4326008)(83380400001)(8936002)(186003)(41300700001)(6666004)(478600001)(8676002)(6512007)(86362001)(26005)(316002)(6506007)(52116002)(5660300002)(6486002)(7416002)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+gAOAl43DJyWX/fzKU6PouZWUIGmrdGDppPEMRo+W3lZ/Qn5eqC6obFM9Dfl?=
 =?us-ascii?Q?rcIwJKh7yhN2J+NJqHKoWUHImN8CQeNGI0X83gh03Oz5+8Kp7ujinkD470IK?=
 =?us-ascii?Q?zAIw8MTnplMWXbYiKgkeLY1g/dhMhJdQuNVhsClPIUJyzIuv/GwJSxoLCdRj?=
 =?us-ascii?Q?qEhiJFGyftdswebc+f6NE+djf2P6cJRyAs8/xjT9qSOGfsITq4/LwkMosxAc?=
 =?us-ascii?Q?PBzzkX5QfhgHPtJZ8LMqhbjNlLyI3Q6oUqgaRqlTeepdqT8Eg3nR1gKTPBQR?=
 =?us-ascii?Q?WETKbCsc1KrlcFTcd3jZPKGSGh+bjsrsV8nX6JesxZ7DxyDs0zJDFfR88Wrr?=
 =?us-ascii?Q?k6Gzaw32Q8O0rhA6hh7pqkQumtp4cO69uQlLl6y7whg9/tjE+1O1Ty6rpUnM?=
 =?us-ascii?Q?b4SilMTLPMKn8ui4uQT0REygUSBNqNX5Vdqlf1pQbAMOeMmYq5S/QrtgkXlD?=
 =?us-ascii?Q?eWTu9B6pYRZJ04YSkRpm0rIvswxopdsduiBRZeIzDWBxCg45m0r4GedFKVqd?=
 =?us-ascii?Q?2+O82nIy37GxJdV0YUJAebs6nfcwQl+gp6Xk0clPxwNQLG6iNEeMgUOXG32b?=
 =?us-ascii?Q?CBobiq9Fl+d1ajcNmK1GyuUHBsG3drzpGrFOx5o46q+IKED1DcDCPXBE1RlK?=
 =?us-ascii?Q?Y9vWWkkTd8it/MAcmBABaO3YRJ7feCQ8RuuuJZEMqHeHYnSvVyLSA6r8QUpF?=
 =?us-ascii?Q?Rs0qUat2DnB7fsk4VIJbRwu07GImyKWQ/Z6t/in2Qab403tqS5T2EKdT4Iyj?=
 =?us-ascii?Q?QcLdvy41vubt9+ATL1fLb1hpAuKhCEzKmDvCaPt+WMRwNdpwrtflqVUZjcIW?=
 =?us-ascii?Q?2mC+X4djKSswM2p32kvLFp01IXV181jn/2ftdJ8GIM0MLX/Fq8SydY8aL0t4?=
 =?us-ascii?Q?U1851U3J8dHGqsdldahjZ4xfENkqnORlLz6I3mhG0SoT7F0SVaZXJpxWE7S0?=
 =?us-ascii?Q?Ld/QZcRmfLxkE0XVOO04ca7bHNiX9ssnxxlFMqz7i07tpbx+LBuE/1NLt5RX?=
 =?us-ascii?Q?1W+T0wyDp6h5PQ/yOVpjwI5KMFiBAKaOQF8lL0EAWP0kZRL3CB+I7vZ/IslN?=
 =?us-ascii?Q?97mEiJSOYkjnKsMrqIp1pnpv96EDTBoZeC7QdZmRKepgRJmaMGYAkowRs9Z5?=
 =?us-ascii?Q?+mvScBHmCUzfJ1IKbTv85rhJB9o63NhEG6AWOFGtPPMY74qYXFaPFRmaR1C2?=
 =?us-ascii?Q?O9g3itDHWv+twyPR7qVgavttO1hlNyfOXuVqBbmLCthpYFoC3q9nZ5RUhNNs?=
 =?us-ascii?Q?1o9zmqwbimPKNwTbJcR8hkOAknTrnkT7Sst3lvGwjTYaXwAd0wILIMh67FUD?=
 =?us-ascii?Q?uBo64lbgnHZvR1fOQnkcyBkS+dAq4zm/DSR370C7nOA9cRn3U5pnH6Fpgb9y?=
 =?us-ascii?Q?mR+JxsL+2Liu6FUeaTvAiHd+s5wDx3DLk3j9So8XzRW3uDFfWEvonsu91fTz?=
 =?us-ascii?Q?CoBfH0NEzYWX99yhrGz6rD7vUW2ZyExM0uCBPJPi7yKkyM0UwTERn+LoxJki?=
 =?us-ascii?Q?jZ64AnDu3Ojmk3T4H4CPlTTChuCGLTDGFZVJ5zkp3gJQ9QeVX79wkcZf0zCY?=
 =?us-ascii?Q?j+lJk62eIecP+oCQrwbUGOKPGopyzpcS+F03+908?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8555b49-e1c4-4d66-36bb-08da9a5560e2
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 15:41:11.7337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6FLCkfH4BkNat93CeG655T+3lC1vwBiq92NTJkAXwTttDM91UobSG2HVc5K+uKu8++WAdfKufQRAMfmaE5A6rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6945
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

IRQCHIP_PLATFORM_DRIVER_* compilation define platform_driver
for irqchip. But can't set .pm field of platform_driver.
Added variadic macros to set .pm field or other field if need.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 include/linux/irqchip.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/irqchip.h b/include/linux/irqchip.h
index 3a091d0710ae1..d5e6024cb2a8c 100644
--- a/include/linux/irqchip.h
+++ b/include/linux/irqchip.h
@@ -44,7 +44,8 @@ static const struct of_device_id drv_name##_irqchip_match_table[] = {
 #define IRQCHIP_MATCH(compat, fn) { .compatible = compat,		\
 				    .data = typecheck_irq_init_cb(fn), },
 
-#define IRQCHIP_PLATFORM_DRIVER_END(drv_name)				\
+
+#define IRQCHIP_PLATFORM_DRIVER_END(drv_name, ...)			\
 	{},								\
 };									\
 MODULE_DEVICE_TABLE(of, drv_name##_irqchip_match_table);		\
@@ -56,6 +57,7 @@ static struct platform_driver drv_name##_driver = {			\
 		.owner = THIS_MODULE,					\
 		.of_match_table = drv_name##_irqchip_match_table,	\
 		.suppress_bind_attrs = true,				\
+		__VA_ARGS__						\
 	},								\
 };									\
 builtin_platform_driver(drv_name##_driver)
-- 
2.35.1

