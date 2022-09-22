Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1419D5E682D
	for <lists+linux-pci@lfdr.de>; Thu, 22 Sep 2022 18:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbiIVQNw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Sep 2022 12:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiIVQNh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Sep 2022 12:13:37 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on062e.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0d::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FC7E05FC;
        Thu, 22 Sep 2022 09:13:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifHuuc7KNr6tWy1qEQrF+OF1KzslSNTPClSvGmikEleC04mSWO38TODcPB/Xj+/8UBqEtoaSqedIsSZRWJFNx6yeGboRrOWdEYx7N5RyJTr9r7FhD6uhRD/3SV9iWtKK0vcwGWagUVbi2z9NiuATwa1jrg/SNajJCGoZjvXnL4dRp9UDJIOJuLqEo+oUU1t0BUMXlwMjSw3y4oUpzU2IzRTAOQG9ikjX0KX9I+sHq+x2fzOlhL+Y0hL54D3APozF2DVzy1EJjXRtopUqU1a6PqWMeZw0kaiAtX6xqj6hX8Ovn2qs/8lk7I2Tac5aQwF9pevGmuwrdEnApDcwBhpBpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbNiVo7RZMy4Rlt7L0xulvmPhpNytBQxjbyUTmsqFR4=;
 b=Sy2g1xrQZpp1DL/0TfGxW3mWA/a9ejG2Mw6k64b+szoZHEIXaBLGcNxKTBe0l2iCcyOcmUy2jgi7YnOw5WS+zU4EM03ihgNYKm/vSnNYuNYdYyyFfux4wtl0pQx1THxS+oWxy4ului7fKbbqEo94em3tBjVOkmtYz9J/kGpA1PZ2dHkpYUyYzjr/vfShFsttsyLUAleF+MDv8mdgeYQJ4wXngCW/9qUjuuIPE8SxzA7Spm/aBedSOee/BpH6jk8RnJkbrjFpMHqHMGZ2/ODeZYFKsO3P+9C1J/FYSt9YJPlJ0gSFoOx7rtv7alt/gnRhVa+0IN18xVsbIUjzeamCyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbNiVo7RZMy4Rlt7L0xulvmPhpNytBQxjbyUTmsqFR4=;
 b=fXiCSG0ri7XEN84erq8iB4kTkbYyxADdVp9EdP/I5kGUEc1ikBo4gnw3hIYfD6SHDwpuegIQYe+C0ha9BtH6qQlPnMOKGncS3ulY+/4DoFBVUY5ITr4PvcJLfM0va/8WX8w6vchSSnBi0GgSSHar1uLC9BnsnyUs2/34kHlGV/8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8789.eurprd04.prod.outlook.com (2603:10a6:10:2e0::11)
 by AS8PR04MB7541.eurprd04.prod.outlook.com (2603:10a6:20b:29a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Thu, 22 Sep
 2022 16:13:31 +0000
Received: from DU2PR04MB8789.eurprd04.prod.outlook.com
 ([fe80::5c5d:d0e4:cd13:6428]) by DU2PR04MB8789.eurprd04.prod.outlook.com
 ([fe80::5c5d:d0e4:cd13:6428%5]) with mapi id 15.20.5654.018; Thu, 22 Sep 2022
 16:13:31 +0000
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
Subject: [PATCH v12 1/6] platform-msi: export symbol platform_msi_create_irq_domain()
Date:   Thu, 22 Sep 2022 11:12:41 -0500
Message-Id: <20220922161246.20586-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220922161246.20586-1-Frank.Li@nxp.com>
References: <20220922161246.20586-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:a03:254::21) To DU2PR04MB8789.eurprd04.prod.outlook.com
 (2603:10a6:10:2e0::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8789:EE_|AS8PR04MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: e0cc468c-402b-4844-982f-08da9cb5640d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KfBirGRdylp94F3zACM9lZ7+iFldMR/w0D3UAB+BUzynJZTGiEXMYuZjjfB9aQobcdPbJ8SKZRKPH7KHCMHiDKszwUT6Ar4TRggqvWT7RR46KWktUPtD3bfVs0QqKlbIx1qV37wAiX1ZmVkqAT6i2mfyVUZqssRVGGVyoAD4S7XIDlyqKy1C4CbRHd63LebLHJ0bx+LPACggbdD3hVf3e50VRX6l9ulGQmo52vT+jDhVEBz8+925NIqAUr9yL1oDhl0Eh1RTr/Dkthlbni0Zdb2R/3Pn1o+ZQEiRGkyru7AtT+uzgeLvHUPsxBes7GVqFHUC8avDGxuCaOtd9ZdEDlqeharBuUmxWmFt04HkAPq9uSXa8iiUhprO0k7zcW4UBiQa9qwuflJMDVCzLJtFkDBQLtIrWW+9/4ciuiaN1+L1esfjfp7fTwzjj5WhQpayJcC5bx/LH0giqZFtPtXudNhBto277r/kk9sNl/7lHtb1PIlOqmftaAH+1VeDemdyHeRfUdCQG4orEQvdrSm79csGOVzok0203CXfVtLcVeZM2JbF5fwpqX9BiEjoPtnZ2xKYfa97B/VNLkw2IYRmUJ+3wXWbMZmk8+sr+6kfGk7WvMG8QlWwgid/59qQIbST9kxP6B6RRjmIOifEB6vkrf+xJ4BYi7EIdrpAyGArwQJxcoytG86xm3c8bvfPBylUoIwiQrgowtxjYJIoOk8agzXgW0W9YgPQMPFOH+VIOCmjRMwoS2zPspUySaMHz+MJRiXUk8pz3F21skLmCmKtlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8789.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(451199015)(1076003)(2616005)(6512007)(186003)(38100700002)(52116002)(66556008)(38350700002)(4744005)(66476007)(8936002)(5660300002)(41300700001)(478600001)(2906002)(6506007)(6486002)(26005)(7416002)(6666004)(66946007)(4326008)(8676002)(36756003)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gp3dAyYHiVW6fKfIyZcl/WKR01XnpFjl8YUuRiAlqaxLEq2VWU2sswYKPM1A?=
 =?us-ascii?Q?ecv5RKvAB77+sc7rdfOeWO+YJ6o9gv5ZOyNsYkdLiLjcco2JFasmlYN1RWaj?=
 =?us-ascii?Q?BS+aiUi3zAeyt+E48YVGHwTmJi+8dUg+/xAFBWnVXwJ+luVcwsEvrl9xUmGZ?=
 =?us-ascii?Q?n90y8q48vfYzPaDRfhjdqmC8zvjb51zqA+cmP/I72V4DZPWKMiymhgE2RTmX?=
 =?us-ascii?Q?ENA3zGNhiJuFF/ZBBz8qwc1vJ2kQ3Pyel8NdbfDjz9H5ZfP5E0unagbZlPtK?=
 =?us-ascii?Q?qcVbT265Nkf5y8WdsEBD2qXVRNoZWeC5R41dbSTh8dhF2q1LbGi82wFTeZCh?=
 =?us-ascii?Q?fdqoDz142VtLtLMr130CBdcsNJdJnMjQNvgbOqexKLD/PfQfcb8Kk7eXVf1S?=
 =?us-ascii?Q?6rVILnNYz/5RqojSmMs5DUQG0YNkBBhEHKfbnC7WFnt83IGkxVKU7/NCAqwb?=
 =?us-ascii?Q?Nn2qgSmYnK9VIFkBHfydsZptZAhMp9v86TFBwtpgHwSYmN1Qps6FS+jWScY8?=
 =?us-ascii?Q?njmJ/TIclaHAm2pDE9O2KBLbZht1mOOmVO6+hRAdhBP1Z8MCbt8jgWNsZNsb?=
 =?us-ascii?Q?1kqvP8MxSilOF62EP2nJAV6hp1+y5qKjMAv8t4WcFvwX9l043HlRVa/P5fFN?=
 =?us-ascii?Q?wmVg+vI6zAQzlQYk+r8Ypdv2FzVjwLVG5i0zK/iQSdPjjLD4RzM3oOaUeNqG?=
 =?us-ascii?Q?QYnY+n/GOAXkkEiNqqPQNU1B2V9dM+senYWQSIrxAA8BwE2irU8zdmRtw533?=
 =?us-ascii?Q?wXgHmFYsvkxlV4pdCoaWNyIg1vW9jCFEdftsS8UOZXOl5oCMJq11NJXMOnM6?=
 =?us-ascii?Q?IjT1CwlQ1kAm+n1ZZDYZ93nC/y+bUXGPUDS0NLSE7UHNY3Pud0VcWI0nEAio?=
 =?us-ascii?Q?+ElebiTxAX6kL/xPJwEU2Y6pC+MXJ19Vbm0v7gwZYmMjupf4tGlBTx1qfAUG?=
 =?us-ascii?Q?8TOUz2ffFFQgKc8Mv6T1Lcnr8/KOc7radK2IkWkMUPwBYxC8hY6Yd+9hJLjA?=
 =?us-ascii?Q?U6mU0TD5/vSHyBuUu5aeOv70f4xKlwT0SnWCe0559HWNFpJNXS/hs/0o/y3s?=
 =?us-ascii?Q?jUkq5o3NPwJB8rN3GxJxBRezIwjvDdW+XBXosxZW4wcBQ0br15vsfwKMw7Lw?=
 =?us-ascii?Q?hKQDOAu0plG0JjZbXIk0RAnIPbK8xGWKrybUYnRzksvhKA81JdVqFKES8/N5?=
 =?us-ascii?Q?S7bwLBihx+NuKmsakPNAR+n/lAHpZGvirYLIq22gmTECOyM83Xyyz1X9LR9H?=
 =?us-ascii?Q?NdBgaWKRFCAuEf73iCIpL7HBlg7CKbxV5XycKicgjkRGp2k2VI6f8dh3tWX5?=
 =?us-ascii?Q?+sdz/LCxVMFeCIkGr46uEAc1vJ8tolLBWHO/72WcuWVgbRj0y4DNkzn+HxpH?=
 =?us-ascii?Q?43DiRVtzokPkiCIYN2va+5xhCMi8mjTbZupESXmA2CD9hrAbHDVxK4V4HuDt?=
 =?us-ascii?Q?vai7/xgFmYgW3mAtBJab8C0aZJnP2Izb0+/oLhnprf1YVTJ9/SEqZCwSspa8?=
 =?us-ascii?Q?iILQMWhXAgE4TSWwag3yk0B1KdTb2A7hv0URU87zGoIEKRILods5w4rZgARK?=
 =?us-ascii?Q?gjbLyAbEkmd9pBqYzKuAwQpvkUT+4m4/omaU3VhN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0cc468c-402b-4844-982f-08da9cb5640d
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8789.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 16:13:31.1877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aZflUDKhk899NanA7hPlAldQZZCN+4iKmx+0TOO7wkUZvzwLafSG2OmHT+vmFTU0p2kBjOzeE+vAlA/w3y9m2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7541
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,T_SPF_PERMERROR autolearn=no
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

