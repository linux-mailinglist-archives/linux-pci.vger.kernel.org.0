Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01D161649B
	for <lists+linux-pci@lfdr.de>; Wed,  2 Nov 2022 15:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbiKBOLW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Nov 2022 10:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbiKBOLE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Nov 2022 10:11:04 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2085.outbound.protection.outlook.com [40.107.21.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787E527FF7;
        Wed,  2 Nov 2022 07:10:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2/iev31pZsPprUyQfFELjT100QQ627d0u/PAEdFpExGBd/abvaxfRbMIxuHSmW4zbUvOCE8xdAf9gopv8tQytZAkgaeHfLZXNq9+xUB2qgVOWsXD4KSGxYk6YK2sKr1oUA31cOZd9H0TXo9qCo1+mKSeHvCAhGN7Yyf+rosavTl6GiHn6jAruQhi8PguH9v61FHWZDvgZxVCTrCVdmCBQg/3mkvYoF3yiDC8EVROUfolFdU7oJRf7TTSJv30sleOJ+sax3VtoceDskZ/rHLFQ3HPKKwOqic1lqrPLGGd86OlMri0ycQRQfOIDgJlKXtVkzPCc921dlT6dbVHlv7FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ioq8i8JEn9HvTPMXs4bwgq2Vsrd8In4CWHIXoks/i+E=;
 b=LDWFetZAkf2tRxDww8cCCLxTIQpYc4DDYP7pho/hG6VlJEzYVc7am+yDVnFesGAqar/F+KspSvQ0C6M1qD1+dyzVnQZirokBrRxl6cT5QMg1rp+C2G1sWG7xfX0kc/vjanHsfFmOT63V1eGQ5jRIMNfV+m7AFMmhaLQx3uciet1MfBf50gOqnaahQ9ONe4ADtBLW6lK3FldgJQvFZtzzMflmFose3kfMyonUWNiy2pLYykHJBiid71PwBUkKw393uoKZRKeQJhAqgGRpP9hkEcQCDK79mhOEjyzLUzX5Thhz5JPyJL6ILMHcaD35N/ricSF3yyu1hMSz+cfVpZCStg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ioq8i8JEn9HvTPMXs4bwgq2Vsrd8In4CWHIXoks/i+E=;
 b=bKtPlPBrhpm42lTOiY63nfEDhHiis7ru3mJmIbfxfKLmiETJ0DdYD6add6K9/DPlwdl8U+L74hL2/lVZIhvxBx0OEJ4fBjwWPNv/IjcpVSWGtHMtS3sf5CDCG60OpVgm4PtUvyMaZDvFaZ2X0yN08AQ/Zt5Aqn17IvjpSWv+Kx8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by DB9PR04MB8234.eurprd04.prod.outlook.com (2603:10a6:10:25d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Wed, 2 Nov
 2022 14:10:56 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28%11]) with mapi id 15.20.5769.021; Wed, 2 Nov 2022
 14:10:56 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     mani@kernel.org
Cc:     Frank.Li@nxp.com, allenbh@gmail.com, bhelgaas@google.com,
        dave.jiang@intel.com, helgaas@kernel.org, imx@lists.linux.dev,
        jdmason@kudzu.us, kw@linux.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lpieralisi@kernel.org,
        ntb@lists.linux.dev
Subject: [PATCH v16 6/7] PCI: endpoint: pci-epf-vntb: fix sparse build warning at epf_db
Date:   Wed,  2 Nov 2022 10:10:13 -0400
Message-Id: <20221102141014.1025893-7-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221102141014.1025893-1-Frank.Li@nxp.com>
References: <20221102141014.1025893-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0210.namprd05.prod.outlook.com
 (2603:10b6:a03:330::35) To HE1PR0401MB2331.eurprd04.prod.outlook.com
 (2603:10a6:3:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2331:EE_|DB9PR04MB8234:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fd3155d-3f46-4887-c17a-08dabcdc0f4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4+t9g0rQ+9sZasnpxkHyJBdTvyQ1iGyibo4hiOCbllEBnmcV1iZw1Er8JndysAVPMvgi474su5cMqwMZ3avuzGPEfswDiJInmu9DknqzVFZdryJRatxuAjUClZk4wBIgmVOk7PNVCA7hScv0GiUKfD1TXSZvZj3RZ1mjxYZohjtgWbcQh8jLboSRpU83gvyGjCGh7v1ux9TlzkMDMn4kIOJn/YuPXrq1C2IycQsiAcP3LScLs0uL1c7JEA5eRLzwBPlR8C5lhdQjuMCq8tmSKIKlrbariYaIGp+9l5XcaqFCcKCpdrZqITqjMSXSnHd+3buB/iWbAa8cDdyk7zi1Hy3sXSx+fu+JDWKNXiSv60u3GJNeidAaR7sapbJvyRM/gHMzb8HIkpZan6pwU5ql4qdX9UXs9iPPNEGnKf2WzZYVb6WjhUen8AgJpKa3mP/eN4ysXBRU77U67aUFAsEE+Ak+8Fvw7mIDZs1MCQEsbSY/lB6eVP4nzJ4l6Tj6cNCpUSJ6VerMKrnkoayoKkEUkwj+O4yKYDldnJsngLz39QFiGfpywjxKVf6xqjYUfdKClgdi4l4UUsfy7fgwW9gyMPp+AUHpPqoRO1NqvmBfYNvSdd0Ry5+juFdvZOCn32WyRsaVy9zwLdfcYwlUxrJLh1CcGpcPZ1AFun7jb/CEv6P+IeK0MQqraOeOmgp7XmxINxmjAqkaUDNNivo/j+AORVLVQxuL1exMocSpITgcWDkftayzCbI2SG4jCUhF24pYFn9rJ9E6dVWBn35nrVkVPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(451199015)(36756003)(6916009)(6486002)(5660300002)(7416002)(83380400001)(478600001)(2906002)(41300700001)(66556008)(316002)(8676002)(66476007)(4326008)(66946007)(8936002)(26005)(6512007)(186003)(38100700002)(2616005)(1076003)(38350700002)(86362001)(6666004)(52116002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V7mf4SDY/YTTpXsb6TXPIt9bB9ULodVDTWK5mH092NbkAexSJa5jatfETW1J?=
 =?us-ascii?Q?I68sJjMeE6d03RLddzxXTnuWZB2t4IlVF2dTarO33I7nWJlixUMEoLIHmWQI?=
 =?us-ascii?Q?k8qWYuUl3+x2iQ/oIKfBRv6bhbpl7KN3kwVwlTn7AXBLYupXKWI0bBM3tz4J?=
 =?us-ascii?Q?t7kJAkJwvfPMeG1Kb8gcWPSJMzswOeu+6kGr9hRGl02P276ils47wUBXdxSH?=
 =?us-ascii?Q?kyVLeTJTUmsL/+BVD4rcWz0occA+DP9ZINmGxNGgGFztnRWu30GNUgfaYLjx?=
 =?us-ascii?Q?Vol/RuMw3dE1Id8bLLP6PqncK9gUp4oVbsQHodeID6r1XFcPjW25TxJhXhtD?=
 =?us-ascii?Q?qeCI7yLUfYprn0fOQkwy32DDOa3jpjJOMzUJ3FYP+Gz76VfdtBbt6g17M29H?=
 =?us-ascii?Q?CXxiyR7WHk+6Vq62kD/b+c8YJ+nsO8C+l6yepqlkMXbJ9IB12x4z7KudsFAI?=
 =?us-ascii?Q?8iFKWrIL7w+pyE6kdIBdLp7uLEVRFEU+SFnwjG+9i+2eCL9OHT7Ep5E3TAtb?=
 =?us-ascii?Q?Fg+b+Psh3RUJC4rpnt47xm2yGu2iS3Ok6l9KnKWsdpAm0rC16jOZ75hG6MNl?=
 =?us-ascii?Q?fkhSD8PYTJXySJiL9Hf/GRczXDO6wnR8ljwiO/d5o8bWyAMK+R0qjLP0pHtX?=
 =?us-ascii?Q?U00ipLZkArlhhx3IvLt5cYqbxvuxlBlHMEQy01H2QRDeYhhovg8M//JOFPdB?=
 =?us-ascii?Q?ZyHoNZjz2Xn+5oProZlIPnKxOAARuP9s5Yw3TZjxrorrMf9S/2lb0UReXskc?=
 =?us-ascii?Q?zspP4n5rdwEETaH1OlzF1ElFDsS570VHaDsJ1qepTcEYUvNcmZg4/Gxf5iJe?=
 =?us-ascii?Q?BIYVrFKDkTkuQrJ9CLTejs63CPuKOzzfoMICSAHXEk7/JXdqABuGF9GAeDgE?=
 =?us-ascii?Q?ys1vXJnATaeXYuGtGazWY3aGlmRUdO0BYwfMeZBtd5LpjFOeLsKfbmiLVW0i?=
 =?us-ascii?Q?iM0KOniqpozeNBiYHLVQZJFfihsLdV/pesqsBNPQf0NhjDd2DeQb60QDCLzN?=
 =?us-ascii?Q?Aoa5tRbq+GWc8NtNauDZoAsrjbKZKhIjH3Y3hW3IxkomT0Tts58Zo4MP3QAh?=
 =?us-ascii?Q?zaEScTZ65dgZ7v1rutpw82DSArejZU/Nhx3WV4F/iOZmAZpPF21HPtJvQ0xg?=
 =?us-ascii?Q?FeBpxLNokePFHCj/XAgwF/enS8E+l9lniMwEESKzLNPQRv52MOe6dFXUdEDQ?=
 =?us-ascii?Q?sAr7qpSzCMFQn/SF8+VWvAShS/aBhUKmKLIHavhC71bl0Qvn1xhi+x6iCMRT?=
 =?us-ascii?Q?YvICvZuHZSFMXkiZPoJq8U4ntiUo3a6VHQvXyI8aXvgljq6tZthoWw3psVmd?=
 =?us-ascii?Q?FXpPy28BhL6/uRJ2b9PY961Tu2xX6HN3xTED73vPVkux5AjmmdaShvErhB5b?=
 =?us-ascii?Q?yezl3mR8hCgjmfF6mMoDGmS3EcgCaLBYIp8FdsUCFZUHJQmWCZwOANPRiefz?=
 =?us-ascii?Q?ObfWctTNf7XOACPb9X9QXl8OlrII3LT0dy+3oLPFygyzlZPszmOXSs98823J?=
 =?us-ascii?Q?L/ETvdYzRKB+FOA8f94PXcxksyLTzWwltZEMm4g6Qi0m7N4lT4NhqL+kuCzF?=
 =?us-ascii?Q?s/3KjMkBsOKLtFO6JM1TH6hjuQL3feELZnWklGdM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd3155d-3f46-4887-c17a-08dabcdc0f4d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 14:10:56.5208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R6plZ4XKfdgYgTeQk43lrI6xrWRIGsctwBSYHtplXPZsMQLbMLQMk3cO6fqqIMMVqvz1LTORCJw+sXMbqntWgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8234
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Frank Li <frank.li@nxp.com>

Using epf_db[i] instead of readl() because epf_db is in local
system memory and allocated by dma_alloc_coherent().

Signed-off-by: Frank Li <frank.li@nxp.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 54616281da9e..f896846ed970 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -136,7 +136,7 @@ struct epf_ntb {
 
 	struct epf_ntb_ctrl *reg;
 
-	void __iomem *epf_db;
+	u32 *epf_db;
 
 	phys_addr_t vpci_mw_phy[MAX_MW];
 	void __iomem *vpci_mw_addr[MAX_MW];
@@ -257,12 +257,10 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 	ntb = container_of(work, struct epf_ntb, cmd_handler.work);
 
 	for (i = 1; i < ntb->db_count; i++) {
-		if (readl(ntb->epf_db + i * sizeof(u32))) {
-			if (readl(ntb->epf_db + i * sizeof(u32)))
-				ntb->db |= 1 << (i - 1);
-
+		if (ntb->epf_db[i]) {
+			ntb->db |= 1 << (i - 1);
 			ntb_db_event(&ntb->ntb, i);
-			writel(0, ntb->epf_db + i * sizeof(u32));
+			ntb->epf_db[i] = 0;
 		}
 	}
 
-- 
2.34.1

