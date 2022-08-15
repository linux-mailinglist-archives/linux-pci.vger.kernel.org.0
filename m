Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFD5594E2C
	for <lists+linux-pci@lfdr.de>; Tue, 16 Aug 2022 03:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240795AbiHPBsb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Aug 2022 21:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiHPBrm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Aug 2022 21:47:42 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10089.outbound.protection.outlook.com [40.107.1.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1453520263B;
        Mon, 15 Aug 2022 14:40:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mE9MZJgE7bET3oMsKj/jWnmVFaGf4oyj8HQkWrTE3fvhjRba3vwvlNjd1WZyas+CDtVvmTW6fhzwM3Ju+QaQRpj112Uui9KNph1bw3dTlmZ4tlUwZ0w6P5W6xL6/fxeDsAhl5vSiZWCuKmkpG7B86QlzSmz1Rz5mmgQ5y2IRJ9OAC8O7rJkQjHf2bZdc/J5oGZRaBO+F8i+hgrgCCH2VxM6DpHuKkHXRmkGtZJjBnahMMrZX9bX9JvUxp0M3DWIZsKc0C5HeKWCfsdmHk7BojcKdGnwYQ7zY7nDzSoBuF5G0JT6rBLtfU1yRV4SlMSNlHlGu+nx9eaAzCPD8CjnIrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PxyZmoQ4HPxt9JAZN3QVzBllZWpIazPpqniEWrzTllw=;
 b=lxewPW8SK910D67lWGNBEcbKhq4EvkfSnuoGwHeo5QbxNtlMeJGaeCHXUGTAR9YbRDw6u7P2T4vSU9BOWOUwXYqTGyxBkOMrPfda+f8VgcnmH+cd1yeHWUMatEcxTgacSAMbtvmQnmuHR/DKDm+KbxFvBaWhgPvYEh64DBLpbyq/HsD/mxDMhsDlEKKuvoy9RWBAGQjV7dX5LaP1P6z7tENrXbewtnDYGo9kZxGtizM1J1BRmZdRPzVL8buC2xjmMT93tetj+5Hvem6xTgYLjZE3gr01KmYIZMUo6W48seftJpqoOSzIKNKwN7EEY+ygMUWr4rL7uGmwwbw5CKAdmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxyZmoQ4HPxt9JAZN3QVzBllZWpIazPpqniEWrzTllw=;
 b=HOMMuUB6+q+zQQk/9c/fU70wCj6c54dhkZj0gOI24AfonDQ8llo0z7Txp79fhyn2pA3j15Xav46FBjm3ZGutQ5PrYyfrjljnkGC8g/vn+VGGkNUcf245qnKsIpdTt1Cr0P10cieyQKa2klSg2B2UxjkTS7TKLAOI009AD2111+k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM5PR0401MB2580.eurprd04.prod.outlook.com (2603:10a6:203:38::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Mon, 15 Aug
 2022 21:40:04 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c5f1:b708:61db:a004]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c5f1:b708:61db:a004%5]) with mapi id 15.20.5504.028; Mon, 15 Aug 2022
 21:40:04 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     maz@kernel.org, tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kw@linux.com, bhelgaas@google.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        peng.fan@nxp.com, aisheng.dong@nxp.com, jdmason@kudzu.us,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com, ntb@lists.linux.dev,
        lznuaa@gmail.com
Subject: [PATCH v5 1/4] irqchip: allow pass down .pm field at IRQCHIP_PLATFORM_DRIVER_END
Date:   Mon, 15 Aug 2022 16:39:33 -0500
Message-Id: <20220815213936.2380439-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220815213936.2380439-1-Frank.Li@nxp.com>
References: <20220815213936.2380439-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR15CA0006.namprd15.prod.outlook.com
 (2603:10b6:930:14::9) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b51522d-36c5-4335-c199-08da7f06b6b2
X-MS-TrafficTypeDiagnostic: AM5PR0401MB2580:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 24BcVxD3rPca4ujQiOFrqm+BC9kVnmII35aEoRLBKEZ8bTP18Vc5lzqYq+axJvz14JH2a5LrBbdnQ/4pMi7/1hxtu3/eQU7xOwaw3vUZ/cjNSTr3OFoUZxsJw/fJOer9D3P/1U/LxO881PuWRhK3cgxaMpYSRonkIeCfHJbWRNW8okaoVfaHbph+g69aYg7E1w0PlmbURbge0w3IsWNfRJoj2YiStQmS1GF9jhxuXvMW6MbUyUkCnO8FdY/JOciL7G0yNWJHlrWqzEyWGy7abrmp6l0bPw3/lZYzYkrnEXdjIGiKw2PfFSlJTGdDRUJk0EhEMQAT7WbHagP3j2EIYG2OyHryGXvwQn0cRmn3Ua1tLsQeUEl9NuyDxnZU23y/P7EL+93bxyCzckjhWhhKsCm5vW1ITgtse9/JFZCMi/9/hb1LMGz+vp0+fLujoMApioEhjT1EoU8lNqvBPOBw3S//AyWhdH+zZ9vTGfIRal2Ea4Q7AOMKi21+mquWTVUHnTf/tYew6lWrWzEP/uPLbuBRml4ud/OoQs0D9/cOhJqL+WH23tGBPYPhCaXWNlsd7uf3vkSCUIe9AgWC0cy107g6UfU7srNn7Vu06dNyJczNjTnebd34Ma2ZLjEo0uu879xH98zsu1fhDpSZ+FinqUgXAGryIjsNmdo6CW6mOI3CI8nRmfoENdzfFElPPqSznnGD6MEflSlSk2vj1sQDhzruthSYfGr8rs/b+9P7T6lsevfb0BSGbbWHwlwJC8zNm9ig/CnE3BdhEpBzo1V1sU3cTPqmyzFVZTVvrcyUNP77h/34cd+BiJWPcibWOHOj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(83380400001)(478600001)(5660300002)(1076003)(36756003)(186003)(6486002)(2616005)(38350700002)(8936002)(86362001)(41300700001)(316002)(7416002)(6666004)(4326008)(8676002)(66476007)(38100700002)(66556008)(6506007)(6512007)(52116002)(2906002)(66946007)(26005)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BjGVUjbg4q43hlsInv9oap3uRh1LN1PGvxKwZPfhjWvvV04y7+jW3/dpXS8s?=
 =?us-ascii?Q?DtynCstZfEYl8mplyeGcTtrjD1sp5eYGme8bWmwYTbs8Ab53NVlnspfXchIy?=
 =?us-ascii?Q?a4awwPmvGwb4+clHh0yfPOsOiRbgFXg7aaBmO/ZDcqaNbUzacadIfc5MHflD?=
 =?us-ascii?Q?aGWK+MS0KucAbOgKX/pKrEzIxXpm0IDWJrPYwTymvn7shkYMJ4ur/0ps19DY?=
 =?us-ascii?Q?OvePx1LPGqHz/zPh7t1JcjlfIQqjquYojLm0wh/wshA7KSKUwo/56o7n+cy2?=
 =?us-ascii?Q?bxspcj22+dcT3N1krc2ZuV+uY+bTWY3rGGRffAkjvjAyXNBpVI5lZ3lDRc9j?=
 =?us-ascii?Q?DuBB9cIYXbojr0ifYv5kCto44dpkATicB0zX/mUuMGpK4GExxtKhoXrcnscL?=
 =?us-ascii?Q?rA3x0tyWK37VehukhwVoLlp9KwEFnhCjW3qI7gHQuF6IlHNdtZJEFXTOfcbi?=
 =?us-ascii?Q?kkoQ8Bbagh3N+7IaKxvUXXqiQ9nffaB7TEX89aU83RvzDRMk2CsPkoPlzBrN?=
 =?us-ascii?Q?qvy5VB8hocY/fqXeXOYHOGrsxPXAa2h+jwlEKuk3xPDkCj239julSgTanTsd?=
 =?us-ascii?Q?DHqrNtODAxpSbptsvmmj3JkCo7ldYgepi2CugCmp9ywuXjQl8hEmbt3iRNTv?=
 =?us-ascii?Q?zjJmxrsDVS0rNWbLRCoMKx9AZriefHXwJejIfpifMJ0Oybyh/dnjPuLSmqWT?=
 =?us-ascii?Q?eFosyp0xv0ezXB3gOZq6Heg6BAzeVxyecIBifLFQJw3IqBckHzkd+86FHm0i?=
 =?us-ascii?Q?Upc9K8W7IRN8FzNKcGreb0nNDb3ER6sTPJm2LNGPxnDyCXBRJ6P9+gr9woc8?=
 =?us-ascii?Q?DhCaoKqEStnUFjkLUOiNgrsxM5mr07GkFeXagkCo7+Nmp6UAZBWcVfh1E3S9?=
 =?us-ascii?Q?N3rRhcR2PSeAmUQuyIM8AMUd8I11tW9yfGlYeC6caDj4ruOIXInutJ9B9D28?=
 =?us-ascii?Q?Wla47fLh05o46AAoQNzpWezx87gmlnKvcKifL2bg7/cthS3LWzczuUuSyEfN?=
 =?us-ascii?Q?lx+EiAoMx6cTKRm/i6xc4W0Wf80Hy4sy2pxoWGoyciHhqIzypnWp6g9EiqW/?=
 =?us-ascii?Q?6YFAyOJXlz1w9Ms+jnWIa+u02Vs9y38E3CmxWISjmPUyELjsceZ0q2wO+fsa?=
 =?us-ascii?Q?l8r9vzc1yEQ2FCQDrdc4bQE0tn+++AbM15KtpS2DOomvEY4fcQPPuPJKnHtZ?=
 =?us-ascii?Q?T8qAmNtvRYg6QUgivqsX8DJStFyzb6/ACC+tPvD3wYtgtN9Ff/m9Be9ofb3w?=
 =?us-ascii?Q?7hN9VZXbXozdSpLShmGGP+i/itQjCWwk3pZEIQsP4X4YpKcIdKuvR58PcU31?=
 =?us-ascii?Q?g4PeWjvo4Mwvw0GjiSnMYz76PvDX5riOkCQMlWcq7PUyjG59rJz6CoSg4jcf?=
 =?us-ascii?Q?uGB9lsmi87MHEZJ5+8joh2YQiRUOFMJYFHiFU/NlANdcnZjZQdNR7eG3Va/F?=
 =?us-ascii?Q?GA599QZZ5zrKMqAnr6wkDYzDA2kgQjTR9/UIzG3xqN659AXb3aGw1dVZA/q+?=
 =?us-ascii?Q?BMUiA795zbcdq5QssVayF/w9oWAYHyvjiKMTV5mbAv3P2IeUnrmV1V8XTNED?=
 =?us-ascii?Q?lmC5NT7po/CBZ6ZGDopYwLOMxF1rsn4BDTAQXciU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b51522d-36c5-4335-c199-08da7f06b6b2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 21:40:04.1639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7kGclmAP5Sr8eJ9rvC8D04qDFVtdSJ0FQzvsSyB02+9dWQXv/8GSPbtAlKAnRlGlwvtypV5iX/d1pJdEvdz2vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2580
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

