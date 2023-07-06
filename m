Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1955749836
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jul 2023 11:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjGFJV7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jul 2023 05:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjGFJV6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jul 2023 05:21:58 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2118.outbound.protection.outlook.com [40.107.117.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E411FE2;
        Thu,  6 Jul 2023 02:21:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+7e1AmlKnBG6H8dyxsDlYjq3pkr7xHbHc8om/x2sogM1gNoC6ly3aVihhwxicjOR6g7CLT6piIxGNOJ7cl6Tc9/V8DFrPPe6cHQHa24hXx5xKqA5kK2Y35NWeayrSQ+euwQw47JVXqc9cYFJpRKeJskcQjABQKpUiSYHciF+J74+oa8bLKljiPa6akuGyiKvJU0oacbMh7XSX6/jZwKXUBTDMDI3uudSShmolFvvoThWYNx6pPlv54Dnu32btL5TCwKO3g36UYOpYsDPQfXOHNKLhuVKVhkHAGPX5KXAySCtFXisd97/OA/HFshjhzIxSVZhj3ybPMPdkBlOQ6t5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=skLC7hv4Gst696jMQBRjUS3Oc+EJCZA71mxKTSe+Pak=;
 b=msgMuYrP4UzSBdES3bt0BigZbwRVpYC/ti+SL9RFK+T8Ou5PnyDqQrunaueusB1HkU020pDuAT9dSbF3nvC0qq1Pv95qef6Mu/VxQm1wmfglK2tOXPzbxXRq/iUM+ts/acmfRPAWzr0kuSQAsEjgHe7ZAwyBU1AMzLqu9iHwAxTTsJiG1niTCS9nqYJZs5O3bz4ojuvfqai2ddrvzjd8XUvuHp2Kpj/qMWLc8t77EZIV9lYCx2tXJwnfZjIQwyTLxKYxkJqgX61onEbyhqXezOd8h9c6l2fjef3cyEziVxELRdzUTM7IHBBc13p535mEoLP+8XU+bZ/hqrOcSP4JBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skLC7hv4Gst696jMQBRjUS3Oc+EJCZA71mxKTSe+Pak=;
 b=i7KguzwBtKVuA4ZQ/L3Xixqa4IRhWbsSX9nNOxLKEjtCySaSVbIWjO7twm13as2frnG5AnHljYbbl5hloj3BC+x2SQoD7mAd63MnjJXyAtZH2i0q0Eo3ZgYXcwHQGYnuUF5L1McOSnyh/xsm8dUsET6L+zkVAxJYgeGhDLdIlKJHi6uxJ2Y48AJMz74bANoyKt4aV6Y22KkX4mKyO6Z2vCoREzRIiQMOBAtKaR3rAfgPno6HM9+u4Ge/Hi+WFih5SKdTD+dCm/yclP+tNysbxrk/tzTqzNhMV1QWeMMrsFI/5L+2DFPfKPcsPY0mIgWQLrBTcIrbRasIUwGJRp6faQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB6378.apcprd06.prod.outlook.com (2603:1096:400:419::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Thu, 6 Jul
 2023 09:20:58 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 09:20:57 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] PCI: imx6: Use devm_platform_get_and_ioremap_resource()
Date:   Thu,  6 Jul 2023 17:20:43 +0800
Message-Id: <20230706092047.18599-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::8) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB6378:EE_
X-MS-Office365-Filtering-Correlation-Id: ebb1feee-9015-412d-e4e4-08db7e024e3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AdOkFzt01qFRURLNz5aGy5YZSkodVAIiwDlOIZUYOaMJvBpuDMzNXYvj4gewQlxom5xEEYHfCVvnHc/4vNUNVZfyGbIGVR75gixvBCocFCVm3vJIYE4E9l6xk2q4fhhW+yxWl6MI8hTGn5NPnSiWxznS0e1XjPDbQHUczd4s6UEGys7XQZ/trNnRbfoPB0L9VVkjsIQDgFYKbp4resBGQLzpZvwNbsMqVbobxxQuCfwOKUPRYBUW0MPdbcI/pNXp8RCAjUtK04fgvWg4z+I7yCA/F5wT9TrZNthjFK1MP7tZ0Tv3DpKs6aiI3T7kvhBeTazkcFRaYT8pTT0sqgKztn4CG2gJ9dmL7mHKXIDPKiGc+41Y3Simxi2Iqtleu1Gy8bo+yd0HOWzDqdNZN+PfH33tZQ/xzHcFKlxO2LJ8g5JshQ8AxeJ6JHlcNeVf8koZ/IT7JFHsLkaR9YAGDNJekX2MzTPGynYlYPvAHOKBlqu8YfIaccq78YTOOtTvs/X67hnXobV1hMtIoWqw8a4WqpX+FfYd1mWF0EUhYKqNFmQZHomwKgdRbRVG1dR8Qbtxh4Kazk2y46f/ZoxkXeKeVageKLrlQu3GRRrDbHZ5DUcpmr3InNd8wTq91e1UQVqmXoR1EAtoQ+NOT8/kC7J20A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(451199021)(7416002)(1076003)(6512007)(66556008)(4326008)(66476007)(8936002)(66946007)(316002)(36756003)(5660300002)(8676002)(478600001)(2906002)(4744005)(38350700002)(110136005)(26005)(86362001)(41300700001)(6666004)(6486002)(83380400001)(6506007)(921005)(186003)(38100700002)(52116002)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m7AZhAd5S+pVKKd7JtuC7oMyCpWAqLs03C8CEHf/IshbGsZKSd2QCabj0HPF?=
 =?us-ascii?Q?vfcqc0wLb0tIvtqA0imgopKQe6ThorfvqUBFCVkFDUjMG0yf7ayQPfAaGavP?=
 =?us-ascii?Q?MSnT/65ZGISmOLZr5krFPajnIoi7Qkhn1AFRsRUNQ46Gq0K+aSQcasbuIqaR?=
 =?us-ascii?Q?Asl5O3Y2gsb5N5ppf2ZkcMR9i9knnGm7j/Txf93sjV7VhjcpzU3B6fiuzhL8?=
 =?us-ascii?Q?YvwsQKJvFWt3GwWt+Vr3sQKh9CkgAfiqBc7RbrTwoo73cpQ78r6HWTMpWRdF?=
 =?us-ascii?Q?V2+njHeEI743cJbAnfOS/MkGgaceGmvsTAcQRQAGU+/ssnaGciUbMkAGr0gv?=
 =?us-ascii?Q?Y5t03R/4KfTU3AQqG6tBuEhXFuRUb1178d9l7BO76mYwW6LpGA4Sn2boNNjd?=
 =?us-ascii?Q?EttO8zKUcrKS+0Mo2PGQzMyQ7VuajzK3eAOb86Qz3vv+i3XeVFkVg1huwxNc?=
 =?us-ascii?Q?Ym5VOqH5JKmFbwiH7wjcM3ll2P+05GJUZeSiq89exAK8Soxdk7PQzvpJIcxC?=
 =?us-ascii?Q?5EMmPzq0GvcBksQZWnX2PNvCNbhNnRk0ELpiOoWrE5KDx9qDeM3ZuzNZIokO?=
 =?us-ascii?Q?psxvu/t9sMQIEg2HvtK/z480V9ftUuDyrUhNc9yzQ75Vw6/HhpM4ShSq4l48?=
 =?us-ascii?Q?+atflbM9gWrvzDH0w62CsTWxaVh35CnuQAHs52tzoRFAGqFsGB16AlhnlSXq?=
 =?us-ascii?Q?ghjMTqwRI1uGOGfagAIRaYdTLrSyRSJh7rp29O1bG97dUWQarT/iobTTmhRz?=
 =?us-ascii?Q?NlNj9K7Ppg1eO+6YH5nEsKH3DyWNR6r0rP4GZ0M/1zyamqHcezDTnrmW/E7e?=
 =?us-ascii?Q?sFxkccCzQacEaFRPIMofmSRl8bwg1dXNbXVemdst64YrcCFuUkXOGvC5n4V2?=
 =?us-ascii?Q?Z0uLOHFx76IvB6PiQ2yVC+K/3nuFC+Upk6TfZFcWuNFeaiatKc09McGM1jef?=
 =?us-ascii?Q?uxjvaXBrjS0cq+H8zR8o8jmbsLqxM0ba1AiLzIgY6ODQtXUHyfcNr7VXSThs?=
 =?us-ascii?Q?HRxfqRV6PgJuySI8Pw4W0VLUIrQpjYS7UlEO9DcQgFlp2hlF2tK+Dk3/HjRQ?=
 =?us-ascii?Q?6Ig4ZAZZX8I3BKfAz7+1iv+R1Z+5PesyzME7xn7lC4omMv8fOqrGcIXWfwL1?=
 =?us-ascii?Q?6Js+XWZUs87mpKtbPYbcRxsvLfSHjZ3eYdfE7v82SJxfxNNMBpGQSQbg9YPI?=
 =?us-ascii?Q?+iBpClCFzsyXEnQsplwpeJoIuEctf7icBkjxaXPoB3mHK/WzxxvhdmB2JtBl?=
 =?us-ascii?Q?DdaTnk8SbOSa6MWljRDMFTIiwjh0yUBftey8+vNLR0AVRP0hvhxIJuJRIwiI?=
 =?us-ascii?Q?pCFwov1H5OvwRdiIkBpZ106GvvTxlfQmLogn/KcL+09i9RDLGVIJVBDyjG/U?=
 =?us-ascii?Q?6i9mhIxkCJQCRF0T+68RdP54SrQvqb5/xK/+K1oKar/LbkLy6LB80wMIK9nu?=
 =?us-ascii?Q?N8yB0NsRQO0BFKoz+tDZT730g7nzgl7fmQFcmAbQja7iPeUQ8qiTGmy21dTE?=
 =?us-ascii?Q?LkyZ1NQfzrVYmKlQOT6F3DAcySSYkj98od8LIM4QO73BnH4Ms8agyxuAvyF/?=
 =?us-ascii?Q?UNvNvD1N6bDq2xRmSyybMn2+Otwe1u0B0HsQtzeR?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb1feee-9015-412d-e4e4-08db7e024e3c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 09:20:57.3362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dkbZpYlz0Zpx6sogvhcRYH3HWQfj8NxKSGXsq+d2R/sAlhRtSnofxHKOYSLOig86LlTQy7eyezlQD8HoAxqHEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6378
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 27aaa2a6bf39..6bf7ad2f7b48 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1282,8 +1282,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 			return PTR_ERR(imx6_pcie->phy_base);
 	}
 
-	dbi_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pci->dbi_base = devm_ioremap_resource(dev, dbi_base);
+	pci->dbi_base = devm_platform_get_and_ioremap_resource(pdev, 0, &dbi_base);
 	if (IS_ERR(pci->dbi_base))
 		return PTR_ERR(pci->dbi_base);
 
-- 
2.39.0

