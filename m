Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082C1614FDD
	for <lists+linux-pci@lfdr.de>; Tue,  1 Nov 2022 17:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbiKAQ6R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Nov 2022 12:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbiKAQ6B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Nov 2022 12:58:01 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70059.outbound.protection.outlook.com [40.107.7.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866051D64B;
        Tue,  1 Nov 2022 09:57:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fm2h9Jh6UJaW/wyLm05q4qQzHQlbqP2dNeBCDWPXqa4FQ5ghbvWxdKA0vOVzeSMFt9hOrGgec6agE95GPbkGsw3gu7WY1Qk4nXOJntXTpVOwLyqw/sMMSI3nfa9RVzECi6rR1fMGBdDlnv/IlmOwJKLQMcOlrcbSe4ThmMfKdDu64kzARzsT4AlL3uJCV7ys1hEfYFlLE2NKyHKvfiG38cafCivSgHCX9L9yKRyhevBpaAKxPXQT9YzmrvyDZil8jCT7cMgmlqgdZ7Y2AOlAylRReMp64GeftTv3Mfqs/FKYdMHfgRrODOsm+jCwFFxaiGigVBfsNBUdAfj3PVtPaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ioq8i8JEn9HvTPMXs4bwgq2Vsrd8In4CWHIXoks/i+E=;
 b=ZNMMTJi0ydImqpNXVUT718wTqSdYNnGT2PKYEGnU7ax8JZ7guGr3W3OnEcgy6OAMnbynPP8yxP7TcFQgq1gn6PrJ6vRb1vfiuyOPuucmSn9TX+icxos78+RzX93Sh+ZNmCUjuqOL4cudlRHtZKBH/RQqrkiz7jwLGOxXeflW+FpmlShRioz/vGwMvLCs97Cyy0ZaSu/yapeudKtWl4vjhAqTigFPzawYSw3KeMRiyEKmlrni1DVbcWZpQxcGaXtNpeTEXC8zX/xFOrbScThsKOcWHoDBz/O0J/Dx8xeRAT1qBG2mjqq8lw/inJ1cH46mRmv21A5KUVPM7QgoF1qTeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ioq8i8JEn9HvTPMXs4bwgq2Vsrd8In4CWHIXoks/i+E=;
 b=r37bcl9P9LEjKc1JmWV6sRpWuitvnms/FigdTkAdImekSnC0GhqmCSEZ5Q+D+Uj/FSfrKnZfnKXOs4MjbaD+Yphs4dbDTaONij8WycrGgdE7ShfTZGCepHREWkBapJTtPeVYhtYXCqXHkLDOx1B4gDpOHAdIPxGa1uHEt8pONxo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by DU2PR04MB8631.eurprd04.prod.outlook.com (2603:10a6:10:2de::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Tue, 1 Nov
 2022 16:57:53 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28%11]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 16:57:53 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     mani@kernel.org
Cc:     Frank.Li@nxp.com, allenbh@gmail.com, bhelgaas@google.com,
        dave.jiang@intel.com, helgaas@kernel.org, imx@lists.linux.dev,
        jdmason@kudzu.us, kw@linux.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lpieralisi@kernel.org,
        ntb@lists.linux.dev
Subject: [PATCH v15 6/7] PCI: endpoint: pci-epf-vntb: fix sparse build warning at epf_db
Date:   Tue,  1 Nov 2022 12:57:08 -0400
Message-Id: <20221101165709.983416-7-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221101165709.983416-1-Frank.Li@nxp.com>
References: <20221101165709.983416-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::20) To HE1PR0401MB2331.eurprd04.prod.outlook.com
 (2603:10a6:3:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2331:EE_|DU2PR04MB8631:EE_
X-MS-Office365-Filtering-Correlation-Id: 38dd3ef1-7a5b-474c-6086-08dabc2a372a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ujNrmyKR/HpPvTLXweXxn1uMCz0MRPgxETl11FbuzqximUloyfHV9RH8hFIKexAGL6YHbAkGLfyzv6g7KQi9BpixYSp3jMC+zWtUGABP0Y5fawp+mGwZ0HnoKIRDGh/utErWksDb4iWeQDjYuKwtS219Z7BS3imD7a+u9XEJvzKTgMVp7xUYhv3OIEYB/MhAKIRUksodbM3MA9exTmb/ukBlziNbA70KwbXjZD+5Jihi8emWy7ywE7p4X9SSBgC6vFgiS3r7tjEtxQ6DDD/vOPuroVc65hKh0SNgYqbvTqeoEnJwAbqPRovaJvsoff2tbJyOfO5LM5hmFLvFoey27+VJPuZ0QgcCO0vdsjPC4w9Xo/qTJZIQskhD5e13g7Yh/Wowf79fO/bIlZb+3sVbX/b9fHs6SwsxmospGaATB83wJhDefSI/xm9wSA6xBsMb5/V+93LtSv/9L9dtUKT5ngdAsSzmPMs6BTftJqaVciXt2qqNs2uGZqh1+/TF0RlOVykFiiV6ZcwmY97JzeqyW4inz3NgOeeRstYH0EVnXrHqQYLtBvqNH5yad+JOXAZOXZ8xJGThlSL841Dm/GVWQ3swm7SKIANJI+Msga2eOkwTC2vIWdOdR/4WCpuLbc1nSou9bgjj2nHZ36Z3PI5WLJ6HLZeEBEkInQz7Zx+VqPM8caTvBw6N+OTxl1U/3SUIjl33cNBesc+Pt0EEgX7CyPFfTUYqkoN6Vp+aFSAedr1vGxRQH3JN/NlfjjdZEU3tBo/PMPXVUtAVDwR+dprnsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199015)(83380400001)(36756003)(86362001)(38350700002)(38100700002)(6916009)(316002)(6666004)(2616005)(1076003)(7416002)(5660300002)(186003)(6486002)(2906002)(6512007)(26005)(41300700001)(6506007)(8676002)(4326008)(66476007)(66556008)(66946007)(52116002)(8936002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tazUIOimJbuh/duBCEBCbNAGRlI9AxAaAJ5ldjlbiUV2sRDJFZvuZd1sNGV3?=
 =?us-ascii?Q?7P165UYw1Ar0xy1oKupqRPBJrovuVKikl0eRPMvoHC82PZUK7Sfz0YcAJ4zj?=
 =?us-ascii?Q?Nd7Hgps2Q013vbMWIuERvoSxGe0Vx6oeRwdqoJIvI0/ApMJ9jr9L6IQ6kRUM?=
 =?us-ascii?Q?DW8nJer11gDUbT8+ADrzscQqLT0eH/mJnNf0Hv8f2Ni6Nby0SiKUDXkv+HMv?=
 =?us-ascii?Q?nXmNenIEIBaHgzdfxXRjVhCtoB2ixKbvLR9h2DA2PGJx5iQciy4gDy9tO5el?=
 =?us-ascii?Q?6plVvTQfCtvMN1esNBiOBFH/BiUmo2Q0bbDa/OIzaxGoNGGPctY8uavLTJoa?=
 =?us-ascii?Q?iq6ru8SQk/l/BMoZi4qBL6UzvXbHlk8M7QE3h9p4dh/Om+1v6/r9cfLdNKef?=
 =?us-ascii?Q?CfU5hVr4MSO722Wkp7KpJadRLogqa9PG2djVMHTjRF5vPeP+hBkyTW8YIW2B?=
 =?us-ascii?Q?wCbQNJa7tRO4bl5a9zLDx4gIhc3DRGpYV8K8BMTDLdDglq9AnAtPiItUdJTl?=
 =?us-ascii?Q?GfjnpUmToWPvyfOD0ilsZLw7sL8URuFqpKztHrsAeyG5B5ndxyQnZmMsHBh7?=
 =?us-ascii?Q?6b+pXOiaRel4f9WWrJWQWOhHSoFbJDx10FKhvgL7EdFlmR3hoym0LS22WGT1?=
 =?us-ascii?Q?ejKgLqr4Lf5lzk2rC7anuEkK4Bw3L4nmOWwzKdHqGSYVTyjBuFo1BSGmhdcj?=
 =?us-ascii?Q?WeirGxdqFyH0BS7qMb2a/L9EfRXodlu0N7ojk5Iw4K1So4emb1y6kwblPM7I?=
 =?us-ascii?Q?Z7o9TxlCc2ligcir4XTflYOUdfj7mCPqj2gK95MkM2P0CLUpwBuJjP0/PnG3?=
 =?us-ascii?Q?w8je9k1mzVEa6yYEEhoMh4VRPUhn5dn4ShnkXyF1wlhC+joGjfm3Bn0rAqRg?=
 =?us-ascii?Q?m4K9DNyQtWzsOcWW2WLvXGXR1ViawuRh6iaiRSAJrlRzX9nyjUTL4HzQ6IxL?=
 =?us-ascii?Q?vhidhP7fAUDILmuTnOqcHiccaewWY5+oKsa5Pfnp2sjpKqay5fEXq30bAJ3o?=
 =?us-ascii?Q?l56M5junXjtv4c3dCwBFGbvi8iiKCcq2TeVTm+d52PttT8GEvyLN13HAbRq0?=
 =?us-ascii?Q?k8zeqdjuxSAov/oSMUDhRQJX23OsPv5Qw6mM0ZowD9Dx+qPA0RsnWrtszz3j?=
 =?us-ascii?Q?FnHBQMX/YtbJ2nV/D3RXYl6ZnyFCa863q5CuuR8J0I6wAsyT1UjGW3Vqc21M?=
 =?us-ascii?Q?Sne0I4eL3YP8G81gKbeao5iL/aBgGD1gpymlvf6X9IVp2wgg8D/nd6usnqlR?=
 =?us-ascii?Q?SXVtOnOGLZNf1XKoxOzT9kyzbwQULbo9jU6HBbSkRhKJPj3PAk/BESIABj8g?=
 =?us-ascii?Q?mWeW+u7PlbjwUTBf0qguWDBT4fyV7MJCcsoYHsVXGeKiFjIx7rtJEefzdmtG?=
 =?us-ascii?Q?042yXq5gn9IbdX5/wblZtP6nn63x3jo4LDqKMNGVfz66ImhzKHnL4atSLAyZ?=
 =?us-ascii?Q?QwIiE1dIiOGgKObhi3hRpfYVoeKEGOTI5BvkMkfGNR5lD+EC3Cdj4wCOjeUu?=
 =?us-ascii?Q?jv+yyOwETVSXv4ibNStKM8qK1SLhmZ6JMD+IhcZf6n9Jd5RjAhbkPEALhJfM?=
 =?us-ascii?Q?6LJzMhiu9fA9fv4cAYbdY/KOp2f9IQKCu7D0GRtP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38dd3ef1-7a5b-474c-6086-08dabc2a372a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 16:57:52.9956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OioOmnxSwTVY6h3Uk2Mew2b9mDdM39VwyWPSP4P1IgHcHQJfNBDAzJrkXq6MX0lRrsuwfhrWXmcd7rj0EhDwkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8631
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

