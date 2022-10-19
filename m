Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F6C604D9B
	for <lists+linux-pci@lfdr.de>; Wed, 19 Oct 2022 18:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiJSQjz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Oct 2022 12:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbiJSQjr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Oct 2022 12:39:47 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDD2286DC;
        Wed, 19 Oct 2022 09:39:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRTC21/y+FZcWfYAo6CNKbdR/jimbZMgBUnNi+0bzvb9U+X007+sjFx7OqazIhGsmpjxeRH7Tsz+5ClOxAfhBziL5fej/t+YJ7AP2BE41YqPHcyGHgzm0h9Ge+d4GFz2BKqXf/N5AA6OPPISXB0BbyT3Fs7s558oLm5uG9T3EPrGWHf8WairoDA4otIfqbFFxXThgjRwkOIXAFvMubpuC6MOmp0mo+htcPnmVmVuFHY0bCtwi8Wuf6WrSIraUiEvL7QkExioS7iiCsrtXTD/pOqHkW4BXjAzznn7ZOTRnswfj6eqXXlRaLQXOu5WarOqv/dq17WZK5hyzM0xbFrabg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfqKjmRXfkbqfS71fsocR7ajWkM3hp3bLrQF/zSSm4k=;
 b=juHcSyYHnmzzZ9DPFdworlvMJz4zG2Ei9tCsXz6mHNr6vM4frPKT6MP4K2BTL0Owf4FANoNK0pwCOH32mQ4aZyPz9bDoY84m9xRqIa0Y1Yeq/yGjdsMGl0Ln7iZSIrAl83IvYroQRQf05GFNrNtmvoh8vQ5WbqbyTl2+snOD6h4mSqKr2Fvam9AbzdE+V+4MZdMRHDmsy/PO1BkSowi/yFNTq9qiLTIJJqot4rGWVeu103fSgtMD9y4Xq3h/hSUf2FCPOCQfU6rn+EDDd67BXV260TXIX9xyxuTYojuNQTSRigyw4gqlcThgcfTtjs4Y9VENpFA/aVaexdxGifHfsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfqKjmRXfkbqfS71fsocR7ajWkM3hp3bLrQF/zSSm4k=;
 b=b8NuZqbsFLU53SXfr0nDxZbH//Bsn7E6B7AbN85WFZJ6kACAOzOTZyOaFHBiyngL6+QcaYEXhAlZN2JyaQmCjmrb5jUw/Rs0M7qhOowV8hMg39kpBb8ieodzWXA68kpsFMEwGouCd7AX+HVIpzumzqwsdL+Wq/kHLwIfX/637tA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by DBAPR04MB7318.eurprd04.prod.outlook.com (2603:10a6:10:1ab::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Wed, 19 Oct
 2022 16:39:31 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::6110:8304:5648:88f5]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::6110:8304:5648:88f5%10]) with mapi id 15.20.5723.034; Wed, 19 Oct
 2022 16:39:31 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     helgaas@kernel.org
Cc:     Frank.Li@nxp.com, allenbh@gmail.com, bhelgaas@google.com,
        dave.jiang@intel.com, imx@lists.linux.dev, jdmason@kudzu.us,
        kw@linux.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lpieralisi@kernel.org, mani@kernel.org,
        ntb@lists.linux.dev
Subject: [RESENT PATCH v13 4/6] PCI: endpoint: pci-epf-vntb: remove unused field epf_db_phy
Date:   Wed, 19 Oct 2022 12:38:53 -0400
Message-Id: <20221019163855.1267295-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221019163855.1267295-1-Frank.Li@nxp.com>
References: <20221019163855.1267295-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0352.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::27) To HE1PR0401MB2331.eurprd04.prod.outlook.com
 (2603:10a6:3:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2331:EE_|DBAPR04MB7318:EE_
X-MS-Office365-Filtering-Correlation-Id: c63729df-7257-42f2-0f27-08dab1f07eee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sgMSH1j/Oe4RCIHZ1QGhpddxvLwO9cm+0Yd3FRoS7ZKqJZuD2hKu0HiTUNnQs7+pxIyUmLeKyai/jdiG90n19jrRrHCAIHA9sMa+tzTcF0TsNorqR6fJzH45Oh/t5e1fw7uBKJhUOHKV1qDG4BaMJt1nR3LndYuH99RSH5inHQM9GWzs1l04ezFaV+1I4XzmwV00xa2Xut96uCr9QfUMvi9P7bbfjTU67Yo+mJ9kSETJzu9kefgnSvfO004HOtSP9Y3qqpwqPwEZFO6YvCFShKwr6CxdUm+BagXKbLk2SW/ylxhQ87ZHibjKet8unIZibROyeuwjinnV31c8mrlpI4yE7ageiEwKJB1DSp92bb2RLzH0jymYvF6Zqe9qORkZa0fyW6TgFPMiAA5h1oIyOpn1gJXNRA5xH23FteXkbi2TP852BYQXBR6gZKv4NMOjN2awsq33A/WoOHduRW7eVRrJ47K8sYqe3mV7vdlRUI5Ga2X5DgZZV5O49v91JmRzHvbwteigWKx8Vh+5bUHHwXV8+/s9S0KTMq1oJl3X57+UG64DgEJs7zgva2dXYkJBzXpUzaGK3ub3Wf5UR2P0XPcw+qYnlk8Z+uUhMEKb+Ldz2T6cqU0a4uYO3Cc6Od2Sp6Z+0Khno/pwv1WaW4ZxuliWM7rCQpYMA0d6WLcDUe3DvzSyOIomowCiAk/f6BRQ8cEkakX50A1qbQ5qH2gxeKUFA4OsQ6Z84vWbTrSsHA2gKkzXkUVhmYpta7T/HGm/F8uBdCduyGi+EqFPh92cfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(451199015)(41300700001)(5660300002)(8936002)(4744005)(2906002)(26005)(316002)(66946007)(7416002)(6916009)(4326008)(8676002)(38100700002)(66556008)(66476007)(83380400001)(38350700002)(6666004)(52116002)(86362001)(6486002)(6506007)(478600001)(6512007)(186003)(1076003)(2616005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sjSclDhTOLByVRpjF81CLV2eMGrAPaHxWDp2SxGFB23CxII3elXx4MMd/w6T?=
 =?us-ascii?Q?t9n5Dv91DahGsoMpyCRFjYvxcGmkZ768PN/PbCk4UjaPDKsSa+TxhCLc3odm?=
 =?us-ascii?Q?dpdRq/V4tCVUnTBuItzficLqU962GYQ0bztLJITUC0PYmnALXivZacNNHt5h?=
 =?us-ascii?Q?pmCmmQEPBC0uppioYB+1MErxfrT7HRpeJMlzzIVIatvLlFEwf+RrSPI5jt/Y?=
 =?us-ascii?Q?S3OQ1LiNAJU8bsFTna2Z1aJ9h/88Ep9wfGJ/S1i7GFDbRheX3F9hDak49m+H?=
 =?us-ascii?Q?LpNdkFN0sfUzwHdpXPMs1WZS6Y1pkgT1lTgeZ7LPnPQxIXKKjM7MWzvgsDKT?=
 =?us-ascii?Q?9GRxlakskuWnKt8iJO6h5MkNoge7D5YSsaRZxEaf0X7rlsWAiKNCCW5hKUjt?=
 =?us-ascii?Q?Ng09Ah0azAcWsZQw5q54nKL3ox6E12H64x6dcnNRO4dXZ4Oufkm0tZfMPlSF?=
 =?us-ascii?Q?ah87g5uMnJwUe5NEesoZubswnh1jj1zLSc5vE/lBiD6zadDEgb+OAykG59KL?=
 =?us-ascii?Q?7rmup51e7H+UCzkkCiA5ujSoVcYq8rsORc01Ukv5K3FzCnHRY0LB9GsVH5QI?=
 =?us-ascii?Q?aOBxCTJxJojiajRS/B/K9BkYrkcSDNpNqLHEhwAS2qR4f6uiqQ2ne8mL1+7q?=
 =?us-ascii?Q?NB/JAIYZVpjDOsJtT+ij5R55qWWqHS2yonO7a1IoPaw+gtUJy2LQPJeSle05?=
 =?us-ascii?Q?od5DomckQIWtPElnJ1/t9mTL3+p4ZXb1vMRy+jJ8nXl1kgTa0+KwW4ty0SuW?=
 =?us-ascii?Q?2KvqgPh0Ekc0wfayCTvhqB4260aKDxkqy0oSEx4igzs+g1mnMXjhsdRolC5J?=
 =?us-ascii?Q?+0Lcy6+GDkYYix0MDL+ETBLZUU9PlpDRk6a2vyh3uB4Ris2pXDhaF3wWtxxZ?=
 =?us-ascii?Q?b+F+hBufMBivVVWZHTAWlCf1p2/CGphiNRBXH0ZY8CD6QMeaxfo5aRvywIW8?=
 =?us-ascii?Q?S2/qQ1EFWBkcRioYRK5ZtZcJCE3TQd6L03jBbOJ4NpmGv9IAvYEjC3mTtlVL?=
 =?us-ascii?Q?kgWqjZsMy/oj6cKEA75NmMQpU301g+gFzTRFfCdiSt/UgNfdGlSTYaiSh0iA?=
 =?us-ascii?Q?5xVYAi2K79N1QsomUDmss+PP2jRRw0mPrc8y1xe7sVPQe+QKNM6++OT44R+4?=
 =?us-ascii?Q?LU4+dEZwbAXZ9O0/Z2D3LrJM9d5EW8NCVXokeXy37SvEnd0T00wtpIT/XIvT?=
 =?us-ascii?Q?tuoN1CE43KrPhqixqkbaAPuoMBaKii/QvC08IFEhpepRexYxuG+jPVrHuk1P?=
 =?us-ascii?Q?Kp27W69B90Fr19XqZPvL13lr/dkNRe2ssm5PCanBS0NNXdzsXCP++EhBI/lc?=
 =?us-ascii?Q?zyxb3GnaEnC3/TgSsMDtMvWCniWoORoBExYPT8jThmIHee8d+qLtLBNhwzqW?=
 =?us-ascii?Q?6mVvEp01A0RaiRVOI8Bvj5xXAhGcEysEz/hsCxij/SKrMLeNBy1szIC8HG5A?=
 =?us-ascii?Q?+QMr/8QzBUe9UoSUtnstI+QXDy0+CaCUI8wPLrhPH3FWEdsnBCVLRNqPWe10?=
 =?us-ascii?Q?tHTWxrYNBVZgTjNcq26qZ0+onoqiPi9IdIyaX/7O7y+WQi1WR+nkbDSC01Ci?=
 =?us-ascii?Q?peT/P96VptrEK/1sZMdscY77tOlqwUb7tgejMJG+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c63729df-7257-42f2-0f27-08dab1f07eee
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 16:39:30.9425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JohXJEyXz2YbeGxo38HPi0V+UwFS4xuAGTyJ98CmH2V95x387H1IJxyUb/R5RVDs+62HfvgNJ8Pvdf5KbluZ2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7318
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

None use epf_db_phy and remove it.

Signed-off-by: Frank Li <frank.li@nxp.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 191924a83454..ee66101cb5c4 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -136,7 +136,6 @@ struct epf_ntb {
 
 	struct epf_ntb_ctrl *reg;
 
-	phys_addr_t epf_db_phy;
 	void __iomem *epf_db;
 
 	phys_addr_t vpci_mw_phy[MAX_MW];
-- 
2.34.1

