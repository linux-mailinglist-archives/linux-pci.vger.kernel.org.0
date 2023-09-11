Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40B679C24E
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 04:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237143AbjILCIU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Sep 2023 22:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235253AbjILBzb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Sep 2023 21:55:31 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2041.outbound.protection.outlook.com [40.107.21.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9FF1B7EB2;
        Mon, 11 Sep 2023 18:26:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ys7D5ZsP6PsywLDbvxEZI8q4r/EG7vkiA6/7R+eBrzHBb/QJVmyzuKWkxilEHLQ/4mpE3gV2lYADQ4tksPCeJQKkohGiR4NQ4MpsPvEsVrxbvXWzRla+YLG4r2IqC2NvYmvtrdBhY8WvKEOz52f+vbDg9LqMdxTav8Johw0tFDXB1kXYmPnLMzG/o+RkntvqZf1LaxCxH1zKythzsru80x9oiyj+EVPw9jLQN044ETLB9I4EJW6qJwMKffeytDcRJ7KjoJo0KZki2Bysf2GGVtQJ4ZphZgUfBYhrYxxOw7OOw+/Ts1OPWJM4jz8Aw3ePYPi5OidtSzM0ZEp6hyOr+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=swA+Mv5Ko8rpGiwnsn9lzKn2XyQXSyIoXb5iBljgaCI=;
 b=cXPIG3VUN8tVkQT4/m11oYl/QLR39Sjq9kcRpbiXNJLMxYMTlgIOWJ1VWxRYyO4XuDdypvBhcRm3RL3vnrJSk/GoEZIdvBC+zNPdmoYvqXBEX8+nwQmea/hgQaLYNbMeAPEHkK5YVgTGLtnYeKoxQsJejthpzvOQAEmulVOVVIpC+5YpHFJkTAllp+4OghMBMltF5fefl9hT2A4q1kdQCOzv9ExA65L4CxnLCfbzh7B1hpHfCKmstgTmov6gUV08YBQ6LqYJvbVJHNJWRMnYDan2A/E5Or+5toVAQOJO9cfdTsB4qfsSPCcw/tkJ28XT3IFKVqmiB6F865IdE10uvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swA+Mv5Ko8rpGiwnsn9lzKn2XyQXSyIoXb5iBljgaCI=;
 b=clebLMIRCDx3MxQJ8DwR/S3KbqXE+kueZCi/ZAfTMyW3t6YCDSDRVTeFQ4koVnXD9zQGWb5SCzw4rN1VzUKi0wAjIDmvu6kkK9eZpy8oaHJ+lxnA7p9aORHzHF0R3IC7n68vwokOtb4SoVu/G249epezxBUv0THyL5WC4wWA9zY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8125.eurprd04.prod.outlook.com (2603:10a6:102:1cc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Mon, 11 Sep
 2023 22:10:07 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::aa90:117d:c1d0:346a]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::aa90:117d:c1d0:346a%3]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 22:10:07 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     Frank.li@nxp.com, aisheng.dong@nxp.com, bhelgaas@google.com,
        devicetree@vger.kernel.org, festevam@gmail.com,
        imx@lists.linux.dev, jdmason@kudzu.us, kernel@pengutronix.de,
        kishon@kernel.org, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, lpieralisi@kernel.org, maz@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org, tglx@linutronix.de
Subject: [PATCH v2 5/5] tools: PCI: Add 'B' option for test doorbell
Date:   Mon, 11 Sep 2023 18:09:20 -0400
Message-Id: <20230911220920.1817033-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230911220920.1817033-1-Frank.Li@nxp.com>
References: <20230911220920.1817033-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0010.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::23) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB8125:EE_
X-MS-Office365-Filtering-Correlation-Id: e66a8d84-6a46-43c7-904c-08dbb313db80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r2LdZ4NGK+EPRmiJGRz+eBPgr7ZJOC6Rm02C11ij6NlJhkp2sFTxySoNTpk/BMH5VQi/2RanHIz98WHQ8sOSHOWfnmOvGdK9GzEX5oZnigIqP9Cy56ZPV+cD53osdWsSx+uV0htOhPih+ts04LfeQNmv8pv/3i9qO5P6WLmHWvo9x/usf3ZDMbpA/f8dmiozXMhPOiIEQEXRYO5CEDvXWfRFmI+teywJvxuGbi7kGMbskrZm9g5hyQrWyArhMvnQQ61b8G3LlcUwU8rIV2rFHpLQpixbEL7D48hnWO68+30DrX8dsTdsTIGD9+CwfGhJ5YfsohavI/yixQHoTFzX/qq7DzAE/IJfY7gks2AK/ch8rgPSFwHTw4kPW3eU3aC+uZ8CYxpLIGsyCHs+nkT+DujHaKgdeaizvSUKxwvjbh2tUWysLC1Wv6VZQYwziGC5e4Kd66588M7cQYOeb1qNQJYutO0d/Uw+62Lyp63lAlRUDUgWb5oXTqiLH/jtVKuENVbrLn52E8fd91gPO2j689NxHmLbRzA+bpRGTML/W1TbJ7b1/L5WIaWSYjrJMueK43jA5gcPmmzjS8tksMvf4zZrrfT+2JqsuexiK/NiQg4mB8fwC+qlJnTvDgx2qzji
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(396003)(346002)(1800799009)(186009)(451199024)(6512007)(26005)(1076003)(86362001)(2906002)(83380400001)(6486002)(2616005)(52116002)(6506007)(6666004)(7416002)(38350700002)(478600001)(38100700002)(36756003)(5660300002)(8676002)(8936002)(66476007)(66556008)(4326008)(6916009)(316002)(66946007)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XNqEVW8xHXXaA2vMQOdiUzBYMShA7HxIl5558OUEU/+tT8ExO2Uxaw9fKXn3?=
 =?us-ascii?Q?/sRL7IdfaIZ5x9OfQn/pftf5AI/GHjFYEPgL/6ce4h6xYtu0c2angq/sgurB?=
 =?us-ascii?Q?WBzRMEAS2mD7RPhmnrAsMDDkYjXGIlavvoScUsGDGmxNKTwYFxsRp5fCus6u?=
 =?us-ascii?Q?fHVFEcsromlbb2MSXtWtk4K0omfe5DCZopn8yALXIZtQh6yJ27w3CIZ2/nVU?=
 =?us-ascii?Q?Ud1VCo4pFsG+TzzxvJwnDUvbZaOD3mr81b5E5qJwrttP5jT6leHq6K1IPUMR?=
 =?us-ascii?Q?IxuCXmG5ENCiVmz1YEDsBKQGdwmMykA65mbJtPQ+EsSveXc33LPtcDuirVJ4?=
 =?us-ascii?Q?q6/zUAlKPu5IIYgsccrFbqkHPc7GG1tZLGhDWWPxTQf/ErxsGwbGRMPjWVvC?=
 =?us-ascii?Q?++d5EyP6kw5Eg7GbM0pLG2rHHLV3KrvfPFfYZq+Xan1KL7qVsJa9RjNqCpUt?=
 =?us-ascii?Q?RFKs/rJ9V73b2lDZ7eJIxvzfTtKB9WjK8N9uWN2eWmZD6QgPuXrJ0i4gsFe7?=
 =?us-ascii?Q?unn8nG64B0xCWYbeMtw/dfXbSqrB3Bh1t9bhwLkxRXmiINqqwqpUrGPSz1Km?=
 =?us-ascii?Q?4X8z6x2X6J/AA5Y3MhjNFKrsfoOwvIrwysnq+o8luSSA7QoxXPKu1Mp0YqPO?=
 =?us-ascii?Q?86O6JjkETE9aAOjxMSuQcYMx9CnHitsNUDvMHxSypCYWs4+u+Vkbv78gpPWt?=
 =?us-ascii?Q?aGwr1Bh34nUCdRT1C2DfZPxTztw+vEh5mxZs2HGxzAoJigycJMcF/MJ9tuTO?=
 =?us-ascii?Q?xPqSaPCWdtZjyKRqe/do1MjGMiXyAZall+6JsnU5Kodaem2DK+OM7XuKYG/j?=
 =?us-ascii?Q?FfhTWdL+LwlSpqv7IPyZFKkmZbx0s5CK3qZynqcJEF+XXU9cBzd4SpnWGKN3?=
 =?us-ascii?Q?If0Jv6KnHfbd2YPZ79eZ0RrnWOAtT/DMISlL1MrezJCsOysfMDGbK8SkKkMW?=
 =?us-ascii?Q?tiNrbvZOsvxFKJwGzRKyfJABS/IaiC+yhcWuTTam40WKf5jfUd+PeTlR8hgx?=
 =?us-ascii?Q?lXlJAXhBTVgMDBULmaaHV1AQDXxCD1LRe2tncmcZIO+1UZXU0GSKtXvdWjR8?=
 =?us-ascii?Q?Vjcgk/QjobAqO9ZawBAjhHOqZs6BmbyZfu+YCGAbhqjclBFZx/L5Jm6VXAgK?=
 =?us-ascii?Q?RwEIvKKQRTXDCE2WgwkHdNDlcjvcTBar9oQTDCZkfhWQsMVFubWJsJtZjpv6?=
 =?us-ascii?Q?57/pfbTLuehehKA2hf/4Nj4k6mOtBtvw0c2pBwhv4XsoelRvtDr2acP1N7DK?=
 =?us-ascii?Q?GDGjgUpnNdFdR3tcey5kfnsl92G56B2/1Z04RmkzBTym9ctbBm4dbVzzpwu/?=
 =?us-ascii?Q?Dw9xlAMbABxV6ilPwKueeUqk3nBmZUcJlg9mAbCmiPH0Nd3byrRWrQr02mhE?=
 =?us-ascii?Q?Gr1xKoje9HyXAQpHhN6eoeyEyuV6VEpGKAaDTJywI0Ufz6IFfk4PlhwEsBFY?=
 =?us-ascii?Q?fzn3UwVWltUpHBigxGZbhEz7JtpdkUZzTqnPIf4HaFnC/dEuFpQzO0a2RP2j?=
 =?us-ascii?Q?KCixoekAuceN71XOFV2VEl5b6iHV/vB9qeLvtjjyPk26tc6mtcMZ+PUxmY43?=
 =?us-ascii?Q?Rv66BBD0Qbc9rfaQxjGSwFcwOBSxCSYN8BgPP+Ex?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e66a8d84-6a46-43c7-904c-08dbb313db80
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 22:10:07.3149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F6zgntwo0w6LJ86NUEJyaRQOnt4KlBm9G6tW39cGqBCbmb0pIhlf5Z7gSzeWQjBfwUE7atMgT+eOTiahrS8bfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8125
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add doorbell test support.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 tools/pci/pcitest.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
index 441b542346354..215d0aa8a09fe 100644
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

