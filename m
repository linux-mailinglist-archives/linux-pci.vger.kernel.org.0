Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A855BD13F
	for <lists+linux-pci@lfdr.de>; Mon, 19 Sep 2022 17:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbiISPlS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Sep 2022 11:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiISPlK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Sep 2022 11:41:10 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60043.outbound.protection.outlook.com [40.107.6.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A7132D9C;
        Mon, 19 Sep 2022 08:41:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTAy5v4oc/7uDf1Nv4Lj2XeLyOQ/AQ8/NBlUm6ApR98YJ4yU9nsnkwLPD64c0b0Vj6Mz56e4Lw38epwPSvkzGtgSZY9gfDpXdTVJQHYVCclthUWPdXfhgFjkwdwp2yJet32H+dVOs57Mfp/XJmpaf3zEczj54lCM96LsA8ZWrcvcrPL1dngGJdcFzpGxjgqs7Ba8b7likmUK6SAw+zmJWKOUL7hSck+A1g7sNqNwVpIPXNHruvlVV1epSQCbNwiG+98bPG2AKOMAq2/vmn3DwU+uHARg2qcToXRrxXWJHGYVxQ7PnBI/QhRFcRoD0pW4UOe8ldOQ/KRNYLdz35hEZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbNiVo7RZMy4Rlt7L0xulvmPhpNytBQxjbyUTmsqFR4=;
 b=j0Yoz7stlKLj/cuX1jZsdw5D7ceTrna53XE0GjS/2Qo1fLwpTW0RvgT51afqzRi94j6xQP8wikojSnOVP9tYYLJiFoCc8bm3VZb6f81An2uFXnTdHWupS6Jd3e1T0GxC2xuc15t0Qvyx2/nloxbQ6CuVwodYTrbl6XgHXmtWLOf/uhTtwKrxMzfVa331lc10BDUQKkbcGSLaJOHSwIHe4CdBuAJiDd4Asx1nVu8c5qD1f2rTtwWYqAnN/NSkYWkzEE+W1dcgDxawArXJEER7O+OhJ/LWIq44ilzoiL12FJ3OiG3JdprtTvrU/kuy84wWnwkVOzbjHOOrCKk4H181sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbNiVo7RZMy4Rlt7L0xulvmPhpNytBQxjbyUTmsqFR4=;
 b=LdQezMm2rSDQ5VbAAAdzUUGXTxqpYzV6jLioP2vN9ukj/aF+iBDoJI2fDLmQCXADeioGMFSHTZUC9A8F+LxBM5CXgOfDZLov9dBUCchu01guoerJXKPaG7NSS8xYuR3k+AaVrvKyGRRw42XSYgGmWgZtgTyJ3WmZ613ErKb2mcI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com (2603:10a6:20b:408::22)
 by AM0PR04MB6945.eurprd04.prod.outlook.com (2603:10a6:208:17f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 15:41:06 +0000
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::5a3:ff70:317d:a99e]) by AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::5a3:ff70:317d:a99e%7]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 15:41:06 +0000
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
Subject: [PATCH v11 1/6] platform-msi: export symbol platform_msi_create_irq_domain()
Date:   Mon, 19 Sep 2022 10:40:33 -0500
Message-Id: <20220919154038.187168-2-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6a0c14b8-184f-47a9-536d-08da9a555d85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3fOTwClIv8ISS3vsBnDEXBD8bPnbU1J2niYTy8MA/rQMKYtPqrWisvFGMRJmgP8tMbWpWYzDK32dx1W05MvqYOWJv4zcGzoSO+SyOiMGijinkfbhH/Z7EORTwTi93kxyTVT73MJnAGXsNv9DJfpaAazj8utRAa7L7/VfXZWLUoiXdFH0ZwkQIC/WSxRW/jOhMODrvqgTr6Z7/rnC8J119jCqW1yybvFp+y8c7MFeyuXawOZWv617GPCqoyroJlRrG0k+ufYU2zW1+8/O1IVKDkATsBFaglpUBr2jyTn7vvtHP7bBxSeJ7J/ouSrkjekHyIURw87JTk4hXE0nDOayOVx+ViUDWI2Cx/ox5Edbz4azr/ysYtN/BVC8lyzk/w6737X6evG9Q8MyJv5rHjHQcwuwL5vcuHUkEuksyRIlgGy7GjGQSarZRBei936hDf3MzJSjr38jwt84zuAhh38Nt8iBazlDKQDNXZKgX62yZ9cH8HPbP9IkCW+NKOyb9rk8JnVddf3sEDl046JtS+nBFs11YLKFy1aiKgGZiEixzDStqTa4UCIaDvpfFSPmT0d0osoNAc1f7q6l7NS3FUWDHEVBO3DkjP34+8mjIJ8PDRI17Q9fbFcVu8Ae+nNb2YF58VDEAMqRyY87NiBUm6pmR0+8bjb+9sfbJjP1irpZlxIHJsXNuR49qXl7E+/EIiGCLvC8wYmSjGRFznCKXdf2HcyMujJ9llD/Uxap6HtCjmrCWsEjSQstL5o5jLoW2FK0fTQAoZKZWfJle/HI6eus0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8793.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199015)(66476007)(36756003)(66556008)(1076003)(2616005)(2906002)(66946007)(38350700002)(38100700002)(4326008)(8936002)(186003)(41300700001)(6666004)(478600001)(8676002)(6512007)(86362001)(26005)(316002)(6506007)(52116002)(5660300002)(6486002)(7416002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?px9a/ojJwQQn6OPjGY93ugeIqnHTvbSVG+6kY6qYpj7kt0Eub0o7JNAJxf90?=
 =?us-ascii?Q?AmgyJ7pki6G1mZr8kBNfyJ8Oh3EWnX/19IRIVI0PhblENEpTM+zpXKyMOIe0?=
 =?us-ascii?Q?Zol73kCkl9bjOjzBYNLpJ9fQQQrhG7/oRr1P+5Vq9evOrtrJvLwViTVZT8LZ?=
 =?us-ascii?Q?p1mEP9TJ+V08J2Z3eG54HMZVqV2YRchcoYtfU5VioEn+80qicBHTQXsjiUOA?=
 =?us-ascii?Q?fZjyW3vY3lL4tILwr2vLNuMQ32afzj5oUOycmypz23pRsmIQfjBssyiNPA+K?=
 =?us-ascii?Q?l4cgNVLCUbJi5l7NTxtG7U0gYfU69sj1eHfuQSiaTvgwvoiOqG33G5Vsh+k+?=
 =?us-ascii?Q?YV4pzcaE5IUH4CXkcJ0ohtVUqW43HqRqpyrp9pjD8vlFFgKLiKIGZp2GgBXX?=
 =?us-ascii?Q?PQCEW2MIYIw5mGlDD2H2NB3FZDzkWje1cfJ06CHc/xzxADOKoDq6MQ3iOwBc?=
 =?us-ascii?Q?T/tC34Pz3/1UYGepfOg2AwLmNE6egtWfik7S72jm0IcslisdwMb6I0KxBvmH?=
 =?us-ascii?Q?DH4VbxNpyceTrQvb3iZUPX91joAr0C2Aug2Du24jwZ7B1vNmSKHvQPjQ5MSJ?=
 =?us-ascii?Q?c9DYOF2N7ZWa4Ogr910WA8wXtcOk+CBiBhRxqEFXoU3GemRNbUYwX5CD0OI8?=
 =?us-ascii?Q?5NHZ+M1XOla9/d2SbZRQB87BDQJnkvOhjQlWWJeGLSLzsrWV1YbkCSZsjTjA?=
 =?us-ascii?Q?mPBbUAuDM9xWDUCdAcB6P0CEP+AoyDToYgqd2y2+uy10fLxvhNyVgnmN6ppo?=
 =?us-ascii?Q?Yy5kt5y2OXiICpgJsvtudKzd84crsPlxnc+/anVWEci5aO/AlPz7b91hPT5x?=
 =?us-ascii?Q?TUsel/xAnGJJG/0exa1/T04UZwQDiTrgXaEnLyxm87/HLklslHw84Kk7b39U?=
 =?us-ascii?Q?8E9ws59wtPHUJA3viD2O5Lo+VlXumGfHY+TXJq94kUFqWF/x6gbR5RDD3pQe?=
 =?us-ascii?Q?xiXvpxoduizyLlfG6VttYu/EiWKnfZqHYgKBOn+e7Z1f9laGxhECOj/JDNsp?=
 =?us-ascii?Q?NiYrRAiBF39ftVO/NlZ0hA3ULe6SUjSlNn7I2/8jHGtAd/uoIRK98C7NFo7v?=
 =?us-ascii?Q?wYCY3E6X8oOxYZTpO77Naz9WrNmMZ+HH/WiqML5OnZTVQWg3NcR0becJX3RQ?=
 =?us-ascii?Q?xxTvD8S2vFLzt+sbCI4zWFRrC3NuzEHQonnxwvL72ifK2pmkEcqY5lxwah4O?=
 =?us-ascii?Q?f+HMrUSWAcUdgfaZnlOq2BxCYPLmAQJNojnuZnr5zf9EzlKsEEmrVvOAHTC9?=
 =?us-ascii?Q?CmB8FPkToaM5PhLYEw0OOJuCjzn9dhOpXZTdT56eLK7dgH/h1s+KQ9dPDFOs?=
 =?us-ascii?Q?Y82dVKFzwMMeOXVqyfh2vc4p6X8BNheZjPrY5OnROFhk6Hl6mmq/ZCkTkAgR?=
 =?us-ascii?Q?NghL+NoITeVyySfiC0LD9B21xlGbit9SuKBbN+Uo634HjRVSheutPzAfOylL?=
 =?us-ascii?Q?Da2y++WcO99DeA2I1Nqt01w1il31SybeF/ud3eFle2vGlcCv28ZWlq4lnuWt?=
 =?us-ascii?Q?fH4qbsABolls4dr6Fcs6+7ldsOcomH3JDNb/yFN2eXL9Ygx/l0ZLRCWAAYJk?=
 =?us-ascii?Q?dApxBgPbqNcG9w0i3y4GNzLrE09gePawko3anSF4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a0c14b8-184f-47a9-536d-08da9a555d85
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 15:41:06.1247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oxo3L/Ak9O60nN4T28M8dqaH9lrwHrowwThInyFmd5QlMkuFvqdEeNv6URp11J9/6NsY0QwzdLjC8tpcuIlk+g==
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

Make platform msi irqchip driver can be built as module

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/base/platform-msi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 296ea673d6615..12b044151298b 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -138,6 +138,7 @@ struct irq_domain *platform_msi_create_irq_domain(struct fwnode_handle *fwnode,
 
 	return domain;
 }
+EXPORT_SYMBOL_GPL(platform_msi_create_irq_domain);
 
 static int platform_msi_alloc_priv_data(struct device *dev, unsigned int nvec,
 					irq_write_msi_msg_t write_msi_msg)
-- 
2.35.1

