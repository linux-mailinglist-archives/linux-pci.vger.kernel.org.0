Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1276EFBBA
	for <lists+linux-pci@lfdr.de>; Wed, 26 Apr 2023 22:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239833AbjDZUfZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Apr 2023 16:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233605AbjDZUfS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Apr 2023 16:35:18 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2072.outbound.protection.outlook.com [40.107.7.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBED2D50;
        Wed, 26 Apr 2023 13:35:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fs+7J5Kb44Uhz+qiW/Gm6qs18d4sfq0pZxiaV8HhD5u9qKMUnHJQQD1yui2yBw8/zcj1b9kr6GiWuG1yivBgX617enjNtN6yQKdhUAlV9oFk8DkFF8A4LHu0abhSxBiy/j4JR+aWsvVLljTLj+8M9NsRj3zzyrJ4obLZ0fdAUZBpcA7Vuhv5tSlyvZRFP4upndHPApeoFtC5Q13t6w4vo760ytJ212UlMnvxbcmi8VN4ycptdnjYZoM+lloaKtFzcurUfYaUbJZFDI8XRDDUgpOM7Tg55uzCU2kb/9IWZMjs4xjk8TfphDz6pMQcxs02U9JLpb8ZjHvvBJ+79DdNRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WaE2Ex2VKSgfAjwB4pUsyhsi/QdPYSTdNzNyt3Ez1a4=;
 b=oJ/zcI5AUJT721JJv+CCkmAdC/3oWS/PJAH4DjGNSTbtbetOEFeBsX+PAq1iClc7xrAl3E/Nk+KuKy6RSo7tQ4QsyR0LZr4sacI52GaxSXgRdn/uTpD3l0I5LmGRwZPqhd8t/CmKbebJitaZNWr6ggvP8rDZOCRAdbX1ZvKIjUiIpxuCG04iQvJciAfcAdakVEaeEnOde7rKMFdPD9Pq4njGlW3K1+/WdqRQjNZNnQBTPwolGXbdkLQRd+zgAsYCmyeJgfVqqmTbGNfSSj24dCSUwPZ7JVuocHII2XIqa60lh8LMm2uagTdRiAOOx5mKhCUmIUr01DH71v5VZESGQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WaE2Ex2VKSgfAjwB4pUsyhsi/QdPYSTdNzNyt3Ez1a4=;
 b=Soqk3zJaNDjIw9iGHJqE1W4Bx/fwJtbur1UnM72Blhmyqo7crGmacZVER7nfqb5IJH6yBeU7nBVO2Wv9TeqlugsCcf4m4WvwfOXu0shTr/Qi5D0kVUnUH+7Y9fc/4heqPrHO2E5kxRX8NfkuiM1xAzVRCJwTNyA3j43H2nMhs1Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB8477.eurprd04.prod.outlook.com (2603:10a6:10:2c3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Wed, 26 Apr
 2023 20:35:13 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::f1d6:f05f:b8c6:4353]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::f1d6:f05f:b8c6:4353%7]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 20:35:13 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     tglx@linutronix.de
Cc:     aisheng.dong@nxp.com, bhelgaas@google.com,
        devicetree@vger.kernel.org, festevam@gmail.com, frank.li@nxp.com,
        imx@lists.linux.dev, jdmason@kudzu.us, kernel@pengutronix.de,
        kishon@ti.com, krzysztof.kozlowski+dt@linaro.org, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, lpieralisi@kernel.org,
        manivannan.sadhasivam@linaro.org, maz@kernel.org,
        ntb@lists.linux.dev, peng.fan@nxp.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: [PATCH 3/3] tools: PCI: Add 'B' option for test doorbell
Date:   Wed, 26 Apr 2023 16:34:36 -0400
Message-Id: <20230426203436.1277307-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230426203436.1277307-1-Frank.Li@nxp.com>
References: <20230426203436.1277307-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::35) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB8477:EE_
X-MS-Office365-Filtering-Correlation-Id: 19d486c8-1c2c-4651-909e-08db4695bcb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9/habAi+fH6Lzn3sfaKBp8UYc7iUTE2hpiZJ1KgupRnanWCM4ywZA+Ad2MDg30EwvvcMabduwooDXgRNQKByJd4BPds7LM+fqpumchjdN7E+kaF9cU8f7Sh+6Zwvd747hlE6xZkkvO//jkd3PFBKsK/UIB2TP6UK/GEtTgA+QD2TzKSUJNhHF5RK1UpJmOls5+fXDQ9U2KcdSqyOjJSlov0JSmiQQinDuqeFAyj0S2rTVVhJR5edQCjMQxNb7mSwTUnAF9UOYhRgbKdp0P4Y3LenkA5Vh6RiW5rEWFIpry/47JQUR9i5v9EjOyFX84edYttg4zHRfeEb2z6lugjBV347nceo2oxp/jNrBiPjYuCqzS41fKA2L2LPKusJVaqTpbmYyg9epn8l4tE22XFgzUdTXXMk6PCvVH3aFY/wLUApQf//CuhFo2y+EnuaRrzGEbRh2AKOQlSQXBPSiMjdjUdfY0J/jo2wrZ2YoazxV7NuwNmth24jPjkEKJ7o82YXAi6V04NQEpPkWHKZF4onqly+CChtSt6s1++5dNvAaOpsUCgKKC3eaYNuRilMLjncyJEi7bDuLz/Ge7ldajnZAq/cnZ4RFMD55J2Grh5ZPauz/mqjjdZdSE8DlSx3CnQg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(451199021)(38350700002)(38100700002)(26005)(1076003)(6506007)(6512007)(186003)(2616005)(83380400001)(7416002)(2906002)(8676002)(8936002)(5660300002)(36756003)(86362001)(6666004)(478600001)(52116002)(6486002)(66476007)(66556008)(66946007)(41300700001)(4326008)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?egIBqi/tNXjM9Zwu0Z+3441uxuCLUeqMKqlAkfnVdoPGeEmUJPGrRzdSryfL?=
 =?us-ascii?Q?oOoFCjYfaTh8z8mFpMX+wFzmSuPpF+Aai1v6vWT0iSro1qXAvBfBZvfujBwM?=
 =?us-ascii?Q?8BxiwaNxhVAkg+nqwWbUft02VcaxFk2Z/2CMkskehh5Ck42ohUGfhujrQmXU?=
 =?us-ascii?Q?YDy2HZG0bc/qf41XEU4BdRebAfY/QK8KoJK+ENL0RiB/I4Kf5mLoWPx1rKPs?=
 =?us-ascii?Q?lZsqr4VHcAcbnleAEuBxPTo84G/1fTcp9mYi4rcDLpgN8g7Kutb2Vn+jE4MY?=
 =?us-ascii?Q?vqsoKHKTEyv3+8IiKAOgqShPFTlx2fiDGOrZURLQrsPmvBjYukynaBMeJNhR?=
 =?us-ascii?Q?iIaNnEY24kcSUzG5EfomDCbYEM+8GRcy9090v0P4O1c4Cj0RJxXw1YHGh/pJ?=
 =?us-ascii?Q?vdeMK4UOdNwn3BxTkIvTkxlYXGPMJRzMDLiOIn7yCdfRD2p1ldQjFu2zSRBa?=
 =?us-ascii?Q?zUEA+rqMwaKsJi00NNijXboeYX3oJhczSF+FYK/EgGw6PQhWx5bCk4dIKSH4?=
 =?us-ascii?Q?/kd3BEeaDAL9/36+O/d3zg36V60Pg138WEFfVRqW8VR+/ZioX/Y7qKYJjVPb?=
 =?us-ascii?Q?J2j2MsHFnvNxWMNiO5GrmxXQDNtUK9d8YNj8sluBJNv7ONL/Wn6ixlKSfxsG?=
 =?us-ascii?Q?e/FZwhclzkI7pC/gp0oBVam+aJQD3jM9WEdxNMRATvnwkAHBpexRWY5n+bAU?=
 =?us-ascii?Q?YLSuBK8krmVAJtqHqSUZLLB6gf0mMUikbWUX7lISZxTan32IATKUlwA/TvSv?=
 =?us-ascii?Q?jrajw7KyE34DqM0Vgoe3y1oPwecvDF4I+fwl7Q+y2pRnKYi0JzMlubNJyHic?=
 =?us-ascii?Q?NgpuTjs+wFIq4n3bqmb5xIcF8KouC8m21vT26Mm2JGCcEzXMcBZ4JJLbFkrp?=
 =?us-ascii?Q?hGohJ9czNus8jVhAYu1S0VsGlogngamqIQZ8Etx+V+gOFfoUxqdkLUikkGv7?=
 =?us-ascii?Q?6hypOpG1hNnMqbJ2cReG+nsOQjpD3kWsid8O1A7IfN2XwYzJaeCY9oBxBxaY?=
 =?us-ascii?Q?TCnIUwzfO/4rGMEqUGM1msB38ke6/O5po39tNKefzmgDvmb6Z7nM7x4zy3+W?=
 =?us-ascii?Q?64eS13m9lK+ZBlRN1h9lHOp0fB1rKUSxN9ebix3XVCcH5PEgbQ0xU+DnIMZ1?=
 =?us-ascii?Q?1lkkMW6QmkJA726h0sSlxH4GFZwnbxsqq6X7MsWZ8K/S5V12avLFrZpGIAn2?=
 =?us-ascii?Q?dKfchAE1Pvx0m0GNuujUglCIVd88GMqBn9MBi2tS4ZTbuhBco6K+GiL7I5N5?=
 =?us-ascii?Q?ztJNtFll4+gDq1L6TETe6hw3uBISpuLy6g8C8aj/M2eIe/Xvko4uNm5zjfSk?=
 =?us-ascii?Q?uwKD2bf+p2vaESu0b++tCB7JFTJn68HKo6dhekQhuZRNZIBz90o45GQvQfbZ?=
 =?us-ascii?Q?ntq3f8vqkzQ3E5RCtCNPU8zo2hu/hMLCkyVYQez1IYEbsuPgiDAHc7dvWgLb?=
 =?us-ascii?Q?Sh8NSpRUoRQONhGYhw7tHzZGtXbaMZec1oXmkbrR7M7NyL3YeJKPHo0diJs4?=
 =?us-ascii?Q?AtR9PTHqBrqIHB4hjq6Q1kWR8FKbondFOW2w+/cvkgeEZUlii5pl4YMdpti3?=
 =?us-ascii?Q?oYxlVxXwix3TPpATTID0uxTyP+kexn6idmaBgsxz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d486c8-1c2c-4651-909e-08db4695bcb3
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 20:35:13.5012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L6rZM48/2wcxri8eJi403q8kKpHKRQ4JmI1XF0MFsQC+CTPmmT2ZZ1V03HTYZffx5AT5Rumx2m4wgTkAEYs2cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8477
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add doorbell test support.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 tools/pci/pcitest.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
index 441b54234635..215d0aa8a09f 100644
--- a/tools/pci/pcitest.c
+++ b/tools/pci/pcitest.c
@@ -36,6 +36,7 @@ struct pci_test {
 	bool		copy;
 	unsigned long	size;
 	bool		use_dma;
+	bool		doorbell;
 };
 
 static int run_test(struct pci_test *test)
@@ -149,6 +150,15 @@ static int run_test(struct pci_test *test)
 			fprintf(stdout, "%s\n", result[ret]);
 	}
 
+	if (test->doorbell) {
+		ret = ioctl(fd, PCITEST_DOORBELL, 0);
+		fprintf(stdout, "Push doorbell\t\t");
+		if (ret < 0)
+			fprintf(stdout, "TEST FAILED\n");
+		else
+			fprintf(stdout, "%s\n", result[ret]);
+	}
+
 	fflush(stdout);
 	close(fd);
 	return (ret < 0) ? ret : 1 - ret; /* return 0 if test succeeded */
@@ -174,7 +184,7 @@ int main(int argc, char **argv)
 	/* set default endpoint device */
 	test->device = "/dev/pci-endpoint-test.0";
 
-	while ((c = getopt(argc, argv, "D:b:m:x:i:deIlhrwcs:")) != EOF)
+	while ((c = getopt(argc, argv, "D:b:m:x:i:BdeIlhrwcs:")) != EOF)
 	switch (c) {
 	case 'D':
 		test->device = optarg;
@@ -224,6 +234,9 @@ int main(int argc, char **argv)
 	case 'd':
 		test->use_dma = true;
 		continue;
+	case 'B':
+		test->doorbell = true;
+		continue;
 	case 'h':
 	default:
 usage:
@@ -243,6 +256,7 @@ int main(int argc, char **argv)
 			"\t-w			Write buffer test\n"
 			"\t-c			Copy buffer test\n"
 			"\t-s <size>		Size of buffer {default: 100KB}\n"
+			"\t-B			Doorbell test\n"
 			"\t-h			Print this help message\n",
 			argv[0]);
 		return -EINVAL;
-- 
2.34.1

