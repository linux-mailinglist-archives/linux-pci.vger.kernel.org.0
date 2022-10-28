Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBA76116AA
	for <lists+linux-pci@lfdr.de>; Fri, 28 Oct 2022 18:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiJ1QAo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Oct 2022 12:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbiJ1P7E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Oct 2022 11:59:04 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2067.outbound.protection.outlook.com [40.107.249.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D22C21CD61;
        Fri, 28 Oct 2022 08:57:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b2JMW1zYqOhLEa0+aSSsy+DfHAiw5Gw0PiiScvMTpKIvchoTzZWxrwfx6qBaP9arna8rIaamMfdgZmogKl62bqn/Jq0tUN3x8b8Ehqf4w0O0evxAPRDR4SP903YoaoWLoLq+np+AePUFVtNI5od5kQWWsWirgOsS5hEAK1pnCusaYnFZLz5woalUzb5GES7mp22grkxaSeIV0maWJdB1ViTlnkHSfxrTW3a3zlvqZ3RgmJA009CZf3FSl0aXrIjX5I9dBdR0qpZ5Kd0frq0D7JiF3ECyNIb91G73+3jRcQ8BQ5EhJ6XN58tzIR5Qrqu38YyhrllJuVlyyEoIx8+vOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qTLObPZYQoAp7sIAf7mRsGpATwWKqn/VhwZAPD//lQ=;
 b=aBys9l/s21q/w6n+635kCi1+EXpBMXCNNvOqlB1v/BwNKAvUwSK/Hu6Op/Z2BC8po9gSet94dXqJv16HY0r2YiEuO/socklW51t8e5rIVjjT89Q1kgdBYDyikqgxO05gIVxu7DX7BtYoRFWn9HIJoEWFA1Ie9jzX229Tx07pD+WI1MGupxGD2IQHiwABbo7stdm3gRwPgKu9bxhr7VlFGAlNkfEydRItLHs0z+iVKNZYXTa2UFmfmHBSnpZhnebF5B4zGz+MeXIo0zPjmq6ViQeTyV9JqxVpO3ug4FQW5oJJXgO7WmpFG84jiZ/xie50I0Oio+54OrdOn4JrH1/Z+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qTLObPZYQoAp7sIAf7mRsGpATwWKqn/VhwZAPD//lQ=;
 b=FJlwNHXkunkP6vqX14ElRx0lvfR+kgtpKdqsbttVo8lwIsKZgeKIYENCkVhFKP8NbYxGd+ayGHBbehpYA7AUIhJ9PGABmg1QW2L1I3+wHaZbswq6J1m1dFb3dtBfagt/wB6MT8wxln6IuK/7tQFvD2W0jAiDCGAM+6nOPf9ztis=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by AM9PR04MB8323.eurprd04.prod.outlook.com (2603:10a6:20b:3e5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 15:57:53 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28%10]) with mapi id 15.20.5746.028; Fri, 28 Oct
 2022 15:57:53 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com
Cc:     allenbh@gmail.com, bhelgaas@google.com, dave.jiang@intel.com,
        helgaas@kernel.org, imx@lists.linux.dev, jdmason@kudzu.us,
        kw@linux.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lpieralisi@kernel.org, mani@kernel.org,
        ntb@lists.linux.dev
Subject: [PATCH v14 7/7] PCI: endpoint: pci-epf-vntb: fix sparse build warning at ntb->reg
Date:   Fri, 28 Oct 2022 11:57:03 -0400
Message-Id: <20221028155703.318928-8-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7d0791b3-0e2b-4f8f-a9b9-08dab8fd2c17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eebcoRqqlVnPDNBfEx7u1pnb42pfrROLtrYYahkOaHVKrAYp2JHwXk5QCUnu43NZVDzpZoQTvHswcEppZ1nToJDr3durM3SeU6GfxpaOvnO7cVMTzKgVW6BWFsmJQFUBsLwfD/LIBGwNxgT5IKle5rjUfRa6bzbVwCRlkvzQTtpTdQ5fwtv2Kf8ADOFO2I+zRxbPjf/PxxKNLjQFTyAYmZVLFnr3DpoedcOE5/lJrIyLj4nBKRjzN4AP14GjjXuI8OHES7V1aaGhARksEZBMkfzbOsUGagV3yKyFiEneBJAGTXpX8yYyKdXfipYH5q+fiMh0m68IdkUgeMC1PIx88wOe2lVhWIBOuXByFsS2AixLlGFxJUt4Ga9/hCYG8m/IEZiA2TKyVhea3iIlqXp+3W1Upv6HHaL5JhugS8QQiAW+BINzvZq7JT2g1pjk8iKK9yHPwdOM3xS+7ChoF1A5HzThq5rnAhISvm6p7LbZL67NIHgtU66PaftsEHd4C1IjsW61C6/tymDaFcL3DTIAxMAqf7e9O+x8598M8esMZmSH6wN34UaJ1zRtNOzrXAGr4odrgvAgVy902RREnmwCDGB2LwTZa8nsgOJqMSJcUBtY2QGoyK/jobwKb9K36xH0KOrlUl4kbp7qlPRzE27ETdLvhTJhZFatE44n+CLo5eEIArWukPVzNb2dz6/RdvWFhpkBDKi5KN2m7NNdA3kp55tTBKvTqwW9Rat8DXnmY007AbHv+bU6RGovEF/CVLTbfP2JkBqzHUH8qTXTu62FJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(451199015)(6666004)(316002)(37006003)(34206002)(8936002)(5660300002)(4326008)(2616005)(186003)(1076003)(7416002)(8676002)(52116002)(36756003)(6506007)(66476007)(66946007)(66556008)(6512007)(26005)(41300700001)(83380400001)(86362001)(38100700002)(2906002)(38350700002)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P5IoyyP20+CYLuBUFOoAA/EDGhRNs2ZwytDCKbi/lMvRvRgoU/1lg1GeohBc?=
 =?us-ascii?Q?VpITiOZPRTJJb57Snu6x3hyuZjku/yOSimn1gku1X4qNQC1pw7Iq5lbdDMFT?=
 =?us-ascii?Q?j9MDj1viXA+VfBmjSKLcI+NAEk0gfyge5S0AldiD5zxAwanhkEoek/nG8kHP?=
 =?us-ascii?Q?MY0fIor+vzhkAviM/My1cQ2njrIFM17GQzktdFdLrlirae584YeNn2S5wW1q?=
 =?us-ascii?Q?VBfQp3xOwXgtZLTrxoyC6rArhxZTIJwJUJZBbYo4jnewJfiWSbhxIqJ31Hus?=
 =?us-ascii?Q?gsVNQ0h8l5zMUVcWtaWP5XceJW+qIGohUqAFZnpRlzH6Rvdtu3gwnoSrTloY?=
 =?us-ascii?Q?5tcOgOkhexT0EcRFP2p9R9ifFkWdJLQPzeXkPcjcIXgTQqFaA/aM4Zy5ZzRr?=
 =?us-ascii?Q?npYEEtKJ18vU1p6hiI0R1BB4b1N8UK1ShkkyrbvjmPjqHRWHjj37flZW5sNV?=
 =?us-ascii?Q?8zLC63X+mHMvIe1XWUqA6ifWvlNOA3MFyMZlQMf0hzE4tYZX2dEymUQ/2DQI?=
 =?us-ascii?Q?cBjBLNo0fYjuPixegqo1PFPE7bdqbQWO75bEb7XrnTqESyQpfVxobw30+db4?=
 =?us-ascii?Q?MfoeRo/DDC/6eJaKB/Dd/w/kS6RtgQSkImAh3d09BzavPxboEnveSLwmEFH1?=
 =?us-ascii?Q?fGKkTbDpjNpZZow2/ZiHEb/fJ5vqcs8Ird42uqif1cKFGU2EtJNGW5Qd0ZWM?=
 =?us-ascii?Q?PW7xNTj/b8vETxTyCmz78S3VUM4yWdsoDineifdrWlzJpAMXOOXVVlJmQIKp?=
 =?us-ascii?Q?EF3LxUYTrFH6uD8scYAMcz7Oy2H2t61z5WBEYxc8d9CGJOeG55xveHFrowZp?=
 =?us-ascii?Q?6Q43xZV1alV5bqYUjAxx28lmYhNu/0q1EwOEl4qkXXIodXwykW2EYX9d89vo?=
 =?us-ascii?Q?XalWDXaCkZRATm6UGPog444hGYUJqBrzgd1doCt72uUmbkz4yMMe8tibtgrS?=
 =?us-ascii?Q?LhzP03odJQvsGfMQkJETYPveRkhDZrOA9eRvEFfTpY5JzbqnKNrYTH3+27US?=
 =?us-ascii?Q?kJUiE6NUJZv4YRcJd5xPiMPIHGa1u66eyHJW6fwglSQ8Yefm2/wGVzc4KU7S?=
 =?us-ascii?Q?xhKfsi9KpN9jw5FU72KkIol0US5EA7/ih9VxNEOSfFyJLKMr2lJDABmQqgNj?=
 =?us-ascii?Q?dnXaRRF1KI9Do7BqeV/ReAo8q47xJ4JzjE4CPt5Fg8H4sIQlV4E2v4iDZGHC?=
 =?us-ascii?Q?S8kgqU2cAosP0Nk4a8P74h1gxHHiXBp9JEizPL43gROP3nbDTMefYfWlanPu?=
 =?us-ascii?Q?XUKqNA5KYA15rlOx2Z9Y2r+UkGzn4dLMYLJLnOFghvWxhMs4p1Pty1D+ADX4?=
 =?us-ascii?Q?5ffon44FYlaHUuX081enBRVnvE6+AIGd9L0E6rF9Ik09fMaNjvwYu5kB/6qf?=
 =?us-ascii?Q?XzMt4R/Q9ODahdUIDGeBS5IwSU7/LMjZREs8hYAdDhAsZBSRqQDcaSAut7Us?=
 =?us-ascii?Q?3mKh6xCeYjztnGRtyUIe7Wr3CU9/CruUUrYOQcayu4Ak5vjvtAtOR6TQXJpZ?=
 =?us-ascii?Q?qq/X/KoYBho1Jc/8JyCw1s6q2epcjVSREJu1mBgomEr6GXTuvsOKCgDV5zk9?=
 =?us-ascii?Q?7qZUePSTqLMXWD6Mnv8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d0791b3-0e2b-4f8f-a9b9-08dab8fd2c17
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 15:57:53.4206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bp8/kq5a2D0TA8Jf/12e48ZKHasLuvAVv9v6/vvN+71gJxPVvmplBrXtDK/JyXBx7yhcGX4wyaAuVpHiuxbT7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8323
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

  pci-epf-vntb.c:1128:33: sparse:     expected void [noderef] __iomem *base
  pci-epf-vntb.c:1128:33: sparse:     got struct epf_ntb_ctrl *reg

Add __iomem type convert in vntb_epf_peer_spad_read() and
vntb_epf_peer_spad_write().

Signed-off-by: Frank Li <frank.li@nxp.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index db3455c1589b..55b7599345c6 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1120,7 +1120,7 @@ static u32 vntb_epf_spad_read(struct ntb_dev *ndev, int idx)
 	struct epf_ntb *ntb = ntb_ndev(ndev);
 	int off = ntb->reg->spad_offset, ct = ntb->reg->spad_count * sizeof(u32);
 	u32 val;
-	void __iomem *base = ntb->reg;
+	void __iomem *base = (void __iomem *)ntb->reg;
 
 	val = readl(base + off + ct + idx * sizeof(u32));
 	return val;
@@ -1131,7 +1131,7 @@ static int vntb_epf_spad_write(struct ntb_dev *ndev, int idx, u32 val)
 	struct epf_ntb *ntb = ntb_ndev(ndev);
 	struct epf_ntb_ctrl *ctrl = ntb->reg;
 	int off = ctrl->spad_offset, ct = ctrl->spad_count * sizeof(u32);
-	void __iomem *base = ntb->reg;
+	void __iomem *base = (void __iomem *)ntb->reg;
 
 	writel(val, base + off + ct + idx * sizeof(u32));
 	return 0;
@@ -1142,7 +1142,7 @@ static u32 vntb_epf_peer_spad_read(struct ntb_dev *ndev, int pidx, int idx)
 	struct epf_ntb *ntb = ntb_ndev(ndev);
 	struct epf_ntb_ctrl *ctrl = ntb->reg;
 	int off = ctrl->spad_offset;
-	void __iomem *base = ntb->reg;
+	void __iomem *base = (void __iomem *)ntb->reg;
 	u32 val;
 
 	val = readl(base + off + idx * sizeof(u32));
@@ -1154,7 +1154,7 @@ static int vntb_epf_peer_spad_write(struct ntb_dev *ndev, int pidx, int idx, u32
 	struct epf_ntb *ntb = ntb_ndev(ndev);
 	struct epf_ntb_ctrl *ctrl = ntb->reg;
 	int off = ctrl->spad_offset;
-	void __iomem *base = ntb->reg;
+	void __iomem *base = (void __iomem *)ntb->reg;
 
 	writel(val, base + off + idx * sizeof(u32));
 	return 0;
-- 
2.34.1

