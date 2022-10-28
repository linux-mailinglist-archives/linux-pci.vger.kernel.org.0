Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10266116AB
	for <lists+linux-pci@lfdr.de>; Fri, 28 Oct 2022 18:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiJ1QAq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Oct 2022 12:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbiJ1P7E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Oct 2022 11:59:04 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2046.outbound.protection.outlook.com [40.107.104.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4DA21CD49;
        Fri, 28 Oct 2022 08:57:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cxbYpR/F7j9rqLmAZcGkcFrhF/bX3S9u+uYKWaGSkXiFDsyzEkLSsmFJjLdBFEPI9ttkM/W2iTs0lNw8WAW0omssLY66Kq4PoKCfBx5HRegrO5PLkXZzC2teGODvyM3DGHOqVj1KmYMtmPfEfgRyoFT1GjtgCMgCO5zSwzb5r1UtAG59LyYkkWmJ9iRsTi4Oo0EIkXen0d62h2NrI56fh+nCabDT/VQAxZITtWujjKK/63JfShx8q/3HYp5StydK7KkjSTuT7VGFhNrJUc7CoFU5mMyK5yNMecSxDhd0Ou6P/+WfepZai2XEa5ZFjN0oIZpbCbQ+3h2VNi1VFX3imA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISp0+2tC4tqTg7n9XUBvv+tk4luKaKnb+U8EtfJbPY0=;
 b=m7zRTJCVfqGIegqJwPictk5rqAJF+eKsW7VkfBic1pDI3RMuK64qrtkY7jJvlhvKXWBy0EMV9PgzbQ1Hb8mvQO67tct0D14UtOxdRecLHK4mTviZjfJFCSGZJ7zgy5hm8m4JONO8Thk38YMew3oFeDmm1wDzJZ+7jSFDpswvulKFVINf7lRBvkFlBNVx5UVgulEcRfkgdlxpHzrng0jg4C5OyBRuKDeyBZ9HcvFy+h2Wi1VI2S8ydau0ySiFKpgWzdrHukfHAlIylaCz0CKe24hlkPZa5z8lYAkyesy4CG9DzjyhyN/0kpV+lIL2q5ZGLZud+tb92fQpxKFH9lbCiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISp0+2tC4tqTg7n9XUBvv+tk4luKaKnb+U8EtfJbPY0=;
 b=Fqznp7BT0vADP0TwQO8/TE1vTA6dsE5lOESBTZ/cQjQncG3eI7YmXqWJsYO6+AiOZvakToB8EwODWOEO2krcdwDNL0Rkz0OLq9cExr4wj+3AaWHvA0AvhIdJN0CxYN3myOoino+0tn7Xr+zVKYvD8jKMB+7JyQXdXDxvZB/sgk0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by AM9PR04MB8323.eurprd04.prod.outlook.com (2603:10a6:20b:3e5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 15:57:49 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28%10]) with mapi id 15.20.5746.028; Fri, 28 Oct
 2022 15:57:49 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com
Cc:     allenbh@gmail.com, bhelgaas@google.com, dave.jiang@intel.com,
        helgaas@kernel.org, imx@lists.linux.dev, jdmason@kudzu.us,
        kw@linux.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lpieralisi@kernel.org, mani@kernel.org,
        ntb@lists.linux.dev
Subject: [PATCH v14 6/7] PCI: endpoint: pci-epf-vntb: fix sparse build warning at epf_db
Date:   Fri, 28 Oct 2022 11:57:02 -0400
Message-Id: <20221028155703.318928-7-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221028155703.318928-1-Frank.Li@nxp.com>
References: <20221028155703.318928-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0010.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::23) To HE1PR0401MB2331.eurprd04.prod.outlook.com
 (2603:10a6:3:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2331:EE_|AM9PR04MB8323:EE_
X-MS-Office365-Filtering-Correlation-Id: e35caa52-4f82-41a0-6359-08dab8fd29c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BDrlXnMeUR6PEJ4nsiZnaZAw5G2NE3mKxw+BswJr6j/wZymrRTPrOk0IruGfvjtwsaey0EH5/flPpLcqV8jhh8CdmQCmjzPB2R00m210D5A1T82+YtFjo87/S+6n85TqZRfbgiK53yghy+UzGETEBfk03QrYU0y8zPI8/F01u89RhlNKr8ruw5iE6dGAi1RorxDPmIijuU8m71qbaAm5KaO5wVNKvcxm7mzAqfE3uFm2hKER1wjUnVU0b34QxdPn5mFEPhIfrSGoEIiTWxOoJMqZFE9GBK1Fipbh1yA/5QDtHBuvo2Hz+WuX9OPFb4gTi/sWI/3CeDNLAgqISbbioeI9b+9BxUrR6b8OpZaqMu/Gu2TEinyNqetv+HilrASTqDeJysEtTD5IPjAT2W3y8u3nQTe2csOR0EZbi5SiM+dNeZFLqTDjtSa3Hq+8c1d21M3TyfpgCDpxhV2EKwrp4sfoYn1+m6bcHYP80SC3NXeBCEKfe+jsHF4bXBHUn4eP3W6WMe4DR+q4KQC4APLfm0ftj619b7XKokJxMZn8qmjQY69AQqzPthM1HMUvaC9YbVSGH6275P1ZoS67KiPYMipuKOnGL1K5TQIwh8z/f5OCHjeQZXiZbinef7md3UsNE8DoWaLTku2YGpeWlqwZMweRPhX9h1fzonG7Jzqs0MikayAP1j3fhWVtKK3bWjA/9ObCtJd7tbKxNo+q6LZSqu7/PXL7zvmcYSCQWT7hqh11fibuujXNH2rsvFg8o43xlu6HJpU6jOMqEhMV5k2qoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(451199015)(6666004)(316002)(37006003)(34206002)(8936002)(5660300002)(4326008)(2616005)(186003)(1076003)(7416002)(8676002)(52116002)(36756003)(6506007)(66476007)(66946007)(66556008)(6512007)(26005)(41300700001)(83380400001)(86362001)(38100700002)(2906002)(38350700002)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pEGKrOd6yV+FxK6qvvveABchbCdq0uOTaZTW44XQts4wzGImg544Bo2P5zqW?=
 =?us-ascii?Q?g2vGKGK1VCz+J+2mpn0dsOJt0wXbcz0CndogwdqJVDkCJOA6FomkEp1z1/eW?=
 =?us-ascii?Q?Uhmk1RNTA9Eqfq9aQqliriIfGJem7DU8UrdssslaxcUgTWI4rKiB5p5fN1by?=
 =?us-ascii?Q?WgFx8PGjsONrt10pcxof4RHJN1DW+6olb4r3RmeTTsMTXx7WTuSrXxpe2wWC?=
 =?us-ascii?Q?aY2kgnci8C4BJCuqEFk4gvWFg+QjPAcR5jCgCV9uKhaTCbEsecpn/zO82coM?=
 =?us-ascii?Q?dkKsBAhA82628QbcTZNM7fWL53FNxxT5eJIs3oKf2KQR72RsNaB+Lb756nWd?=
 =?us-ascii?Q?12Ma0TN1Y8b9ytyg9rbQTsxyZDxLyLxaqPD6cI5yJ8mFy1vCoeEm6r+atHY/?=
 =?us-ascii?Q?2zj46XtpIa3rGO1RlOP064NRDNyZB6UW3J82+m/vL3Y8H8dOORhgUUgZq7rE?=
 =?us-ascii?Q?n0guFJhpmYBiFHBWNYoB+ezccnGOJsLY2glJveRt23xs+nnQS/adZSzBCRnT?=
 =?us-ascii?Q?g9Fq38gAWU5ZDVBpapHbYKFSViIiWK56bs04X2Bft453c3fhCspX01LPCLNl?=
 =?us-ascii?Q?ur3hIraskVbkvFwlpdAo5EqmgzoMP7/GVRxUC56RGaJmaeJF3p8U260UNuH9?=
 =?us-ascii?Q?94AIDS0IxbDPRXH/N1qnW7fiG9FfS8tbPmb5ZWuorJcKqO9SYAZIT1mIBz68?=
 =?us-ascii?Q?B1rIMvTenIDJacMlit22Zjq3HbyHYG7nlVwi3stXofANZHa0AsMrQ/RZoUfK?=
 =?us-ascii?Q?jutyOCw9nIXYWGPYQjWAGhutZNRVRg9K5n1MeOyAWNurLxU7nQWl5he47upv?=
 =?us-ascii?Q?FIWaNqu42q+Vh25oVAtOGy+LH5q3msHo2wDWesEhS40UPLyMsVLZjWvYVW5I?=
 =?us-ascii?Q?hl1IPKCMzBmlTSjzz2crNwfjS5ziHqp78DpT+iCNxrh93ySze7MbRvB3UOVV?=
 =?us-ascii?Q?BINL85i+j/IN76CZErG1Q61nxAPALcUO6NRljXTyvmF1XQO/5sJlH0mxIqDC?=
 =?us-ascii?Q?MabZFjMWq87COKtCf2lf5Tyg1LIGojr1ZrhtcpyLcB6htg2Zu0mPKftiwMPu?=
 =?us-ascii?Q?fV01Uwl5pO4nQdC10zeTfnk2OtQdA9TS3bp5Vnz4/zFQkV0Cst9V9vWjEI+s?=
 =?us-ascii?Q?n/n1KM8NbvFXmXBMo7/zsg7mZRzKDvJO1TLnJWQrI0SiBGdsTV2mzK47vOkC?=
 =?us-ascii?Q?smjjYWwom8id6PXE0CFUdzU10YvceehxXP5Iwq1FMymdXCQ66lxN28VR0F1H?=
 =?us-ascii?Q?i5FniE+Pq6AuSnas0FrQSZfK95dIoVwMoNS2cv2tAzwxNkYl6JaXuSnn7n4r?=
 =?us-ascii?Q?gXalmhnKSJZj7ClJMUBicOnW+pnex6GjVq6vHsbaCtJgsmqG7o8WRuivFZqS?=
 =?us-ascii?Q?BbFUZxVQnrah+u/TrHnoXuBHvzF0kY9ACh7tkY+cL+Y6S8icch8HIi1M6QEz?=
 =?us-ascii?Q?g3PtR/zyEpQLjCiV1mIckcobjZK/BC+vF42H7woATrM2qsXwub7OGRqGEAVA?=
 =?us-ascii?Q?ucngtm5wKayOJAWmKDlvjhJGFB5lXBAEPcSnMo8Gq7NHoSwTn20HDd9WG92/?=
 =?us-ascii?Q?tPeDRAm0hUJiuaY02ik=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e35caa52-4f82-41a0-6359-08dab8fd29c8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 15:57:49.6862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fbfMMjdriX4L8qHmYvwhsErmFdarJ72NluRdSbyD3sOF993Hqk9bij5wHYXa63rJbkoAE7tWy1eaGy7qywG+rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8323
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 54616281da9e..db3455c1589b 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -136,7 +136,7 @@ struct epf_ntb {
 
 	struct epf_ntb_ctrl *reg;
 
-	void __iomem *epf_db;
+	u32 *epf_db;
 
 	phys_addr_t vpci_mw_phy[MAX_MW];
 	void __iomem *vpci_mw_addr[MAX_MW];
@@ -257,12 +257,9 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 	ntb = container_of(work, struct epf_ntb, cmd_handler.work);
 
 	for (i = 1; i < ntb->db_count; i++) {
-		if (readl(ntb->epf_db + i * sizeof(u32))) {
-			if (readl(ntb->epf_db + i * sizeof(u32)))
-				ntb->db |= 1 << (i - 1);
-
+		if (ntb->epf_db[i]) {
 			ntb_db_event(&ntb->ntb, i);
-			writel(0, ntb->epf_db + i * sizeof(u32));
+			ntb->epf_db[i] = 0;
 		}
 	}
 
-- 
2.34.1

