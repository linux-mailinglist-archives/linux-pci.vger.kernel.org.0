Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03573772B84
	for <lists+linux-pci@lfdr.de>; Mon,  7 Aug 2023 18:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbjHGQxK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Aug 2023 12:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjHGQxJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Aug 2023 12:53:09 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2072.outbound.protection.outlook.com [40.107.7.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47261A6;
        Mon,  7 Aug 2023 09:53:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOLHl6IW1pZ7w6BevtM/P3dMTxHjnV095m3KKGMLxakVGTf/XH1WHmM3EMgIeLmy4bGJmgjM13K0GJ6ymld24XSp5gwIN3eKuMwDpJORjZbWylGmFysfTwOCN23KYRJ7MeJ9BtC/TSwuqqKqyHyn6X9Kw3lXXqmvWI+JCc6smX00l+O/Vmhxc7yugJ2RosTBP+Ylg8JjRDB2RjYOzoCDVMuYMTJeza94uIAk26+dxGcSeQKgiIxXbnP6mqlRBolacb70jOBjVjxH+87E5X9y7qapOnRcd0cmbyEbcPS2jt7j78PwMXhKUgzdXL/9lX4rJFO7SGruKFR+iMJug/2EqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjyxhbW06JhrkrTCJL7QM3CGDyh+FD/nRHJUcFll8aA=;
 b=d+k5Nv1aFghoIHVktSSkd9Eh1z5PWS3FsWZJTrB5fLs7t0AOOGggKGhVR0SUT3xpoGiytLvFl2JfuG7Nb9gzYgUUCAjqwnwhphAP8Ee+qVQOX6X2FZdja0na4Buzp1d7bV5hOP4jNGtwaDylGSdgMa/Gwj5LfhQoGoxW7e0hJ0lDwnrLu5mfoCrO1PI4YpAhTTE3ao+sX/LeH/NnvPUYjBIpgAgNoErxKZB7wNsvwLltkQJ6dbWez5Qfj+gQrSFC3yzNqITGGyp7COiIm8jaEv5s7K1AnL1FwZYej8GyB9EQSgPnmb/S+IX81jurxFlgwjEkpLB/VBpSaDtxGsOmHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjyxhbW06JhrkrTCJL7QM3CGDyh+FD/nRHJUcFll8aA=;
 b=KscFYe5xeTmr2CHLHVZ6075dR9UuknXiCLco72RcbMvfMO1tuA7Lu6sqtHL4k1vfmgcsde8zh49EsS5EYMumagu2jk9yRJD3fUbd0T1aeEXMwvBnSB7Ig8ndLOiYERxObYLHa4DEsBGmJPGJYgpgc4ubS1ASp57A0QceQhV28Vs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DBAPR04MB7318.eurprd04.prod.outlook.com (2603:10a6:10:1ab::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 16:53:05 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1%7]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 16:53:05 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     helgaas@kernel.org
Cc:     Frank.li@nxp.com, bhelgaas@google.com, devicetree@vger.kernel.org,
        gustavo.pimentel@synopsys.com, imx@lists.linux.dev, kw@linux.com,
        leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        lpieralisi@kernel.org, mani@kernel.org,
        manivannan.sadhasivam@linaro.org, minghuan.lian@nxp.com,
        mingkai.hu@nxp.com, robh+dt@kernel.org, roy.zang@nxp.com,
        shawnguo@kernel.org, zhiqiang.hou@nxp.com
Subject: [PATCH v10 resent 1/3] PCI: Add macro PCIE_PME_TO_L2_TIMEOUT_US
Date:   Mon,  7 Aug 2023 12:52:36 -0400
Message-Id: <20230807165238.569297-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807165238.569297-1-Frank.Li@nxp.com>
References: <20230807165238.569297-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0093.namprd05.prod.outlook.com
 (2603:10b6:a03:334::8) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DBAPR04MB7318:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d55efd5-9710-433c-3383-08db9766c528
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jbiVzTsGrBXWeGxV17qDRtvsFvnybDeb5bU9PKGN9R8QIpktJhQPxPIdxXghJo04bOQKz7ZYEFfsrHghKg1JIXtueoRbeGf7VpayOSihgk9GfjYJ51ruHw4TQvgfXOzeJ8q0ox7iuCaC8MhqhJ8CgVQyn3VT79OAwmFosvRNWu8dpAHVDW4VmBpS5i3vcdK2aBenwKw9qh16n5TDBmWnUGTdgSQZYyW1uWgyTC3QsC9Xl+Y6QUTzBMPijIOZk7Ad6sHThR0wxcT7QKUiWzs1icQ1K5EUwoZClQ8hkSk83JYv9GvPt/iMAd3Zaf1FmBu1D+4PdT/VBM5WTJ6k0nx4C9xKIZ6GFZ5+CN3ioZnp4r3kwmzraGKchtcFFMDXGi1XC4LSnuk1duESDw4RFkhSW90cCMJYZO0BJVjRT12Sw9CgFHfynCglFIlnG61nEk1EMI1vLrnlcGcoakTxh8aqsbW3Gum3Q13gw8i84BwenuXDQxAhbklD4UfjQOAubxnH6VEaYhfUePdW8BB50HOj67Dx14LxpcW7fRUGFRSDqHJ3f59cZC/mumShLW8dkUNnXkAdKKNhqpIDjtw1ATPihSRsVXpnu31WKbmdYAfzsasRAvNWQVM42nZ1fo1zq+CH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(451199021)(186006)(1800799003)(2616005)(36756003)(6512007)(4326008)(316002)(6916009)(86362001)(478600001)(38350700002)(38100700002)(52116002)(6666004)(66946007)(6486002)(66556008)(66476007)(6506007)(41300700001)(1076003)(26005)(8676002)(8936002)(4744005)(2906002)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lxdE+7iBNCXY6W6a1Z1DrfMMI52XCAtkgbxCjB1cZnaIQop4IUuW3LkCl134?=
 =?us-ascii?Q?8K+rMONcA4lNKYYwTBSNtgXPwgyd84WpfasYzFhCEB9mcu8k7VmhcIuUFPjP?=
 =?us-ascii?Q?6ZzJ6F2k3w0T6EOlOvd+ZbfzKBJM6KtKptuDpF3OP9He0bKhVj7zZ2ujSCYN?=
 =?us-ascii?Q?R5NVdBs5hyRNacEVvQ5XzxCeFXAVnBM//7tFKV7d7GWhB1RzydGlj2NOYjTV?=
 =?us-ascii?Q?pVl7J2I2q7Ui2SZmJj/4EYJMsdlcJVDDe0DGQghm/ZWU8sKdppqhhz05dKet?=
 =?us-ascii?Q?GlEPUMaIkfMHRAfgc5FZKPOuk5Lp8U35Yg39kZquxf2o+ioNtwPMQlqDK32Y?=
 =?us-ascii?Q?NRmkr4SJM6JvQuEqtH0thXeDrIKPiHNxpK4CG/g93+gCgBBVgsQXEOzfzMdR?=
 =?us-ascii?Q?QZeEw8RghnmqOFQ5Kl4idQoa4Qw9hKXWJfeBPBb8wINQiPigpXkzjnuFo9gw?=
 =?us-ascii?Q?hoZN/4yRWHpgum7nwNmivnpiHyaDg1H9Z5O78LR1Ev5sY13HMAHJ3Tyah+bp?=
 =?us-ascii?Q?rXGgf96/CK05yhAKUjJeAQXkJuMllYP+Dd+3umbolaxd8mrhTqjMRMAfs9XL?=
 =?us-ascii?Q?CZo/Zss736zt0cUq6DQfLj+1wyBj6EC+28D93QPsr0oWEj7RjBlRe0jKuPwp?=
 =?us-ascii?Q?MPKFhwCzCAn55NrZEjKvDTct7u2r3z8XjvJt4YRAF/lrsVAQTCUzwwSezzMw?=
 =?us-ascii?Q?Im6/35UpfrGwAWGSJ0wmvPijAbcnfgZBC8fGQ4TqVtcrohk88riDdG9HI6ep?=
 =?us-ascii?Q?vrM5+9seD8x0ValhMA+Ajy/RZOD1rBQ6+RXAwy4CuH8AmFmJDH3S1pFcbKgt?=
 =?us-ascii?Q?gVD0ki+h9yjjJ2F30B5/Q8TM1wx5c1sc7qX+y39BCqfSwzjAr919/3Ru7/B0?=
 =?us-ascii?Q?LKMfnz5BlHy9HhL3+2buMqfKye1OessiF3FV7IR2W0tEXFkFmtKJdOdZXq/z?=
 =?us-ascii?Q?M1JOaUAp1tjz/Xmav+TIg22HKCRgEy/UIRjgO3BnefGH4bq2VhwfzcgPIuAd?=
 =?us-ascii?Q?mXnNbMi97V1F5C3yTt3HITti45FVL/rSoMbnwrm9gfFj+R+vuC0BddS6MM7C?=
 =?us-ascii?Q?BlSBmwQd0Ng4RIs0+8BJzexG+OUbuCP0r/NAiER7Qi5XiILaA26mNgsAWaHJ?=
 =?us-ascii?Q?OVk4TPbWgWo7EKsk1UlMzUy78IFuPKJrLcJaejKSVSVwTJQ/xVtihn+QSF3K?=
 =?us-ascii?Q?dh2smOPiO5fKpbgqRF83FJAkO8Ll1ps8qvXVWECXEQ80NJcTvLQu8c/gY1z/?=
 =?us-ascii?Q?HUIvlWJbEKoYToLasjnv0drwEE53KVwWXQ5tyQfyDRG2ubCijfNNuX5IW/Ty?=
 =?us-ascii?Q?nRTsVaUS92YpUL2MwQy26tLyTzxv/9dMM7CFIuWtXBiXHesBM3I21teS/9Dc?=
 =?us-ascii?Q?OUV4bgWHRj92pEAX9/3BgcSZy+dXbpmiIOQXQ9UN9YY4ZhkS75oHZrpbUjSh?=
 =?us-ascii?Q?3tm8eW3O0US5NjmsAzuDzEZ/SqcGWv+8pndXA79YhPiGl8SaaAlPGbnshc56?=
 =?us-ascii?Q?CT64Wpx8aWoImQj4iM+jjv+ze7e9pDyJ2w9/28iqOkhrZz87n0nUPKeRxT68?=
 =?us-ascii?Q?+nt0fepOlHN+U7zyeCKR3kdvX10vZ9pHfDbRekp8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d55efd5-9710-433c-3383-08db9766c528
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 16:53:05.6846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DKgL6SAOmvu4MPjKGmV0uP5im3fNEIK00h0Kkb60TfVMNcvoC5HRofASkbCh+FXq9xnYWjTLTBzKJOsfzRbyFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7318
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Introduce the PCIE_PME_TO_L2_TIMEOUT_US macro to facilitate checking the
L2 ready timeout in the PCI subsystem.

Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/pci.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index a4c3974340576..da8156663c825 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -13,6 +13,12 @@
 
 #define PCIE_LINK_RETRAIN_TIMEOUT_MS	1000
 
+/*
+ * PCIe r6.0, sec 5.3.3.2.1 <PME Synchronization>
+ * Recommends 1ms to 10ms timeout to check L2 ready.
+ */
+#define PCIE_PME_TO_L2_TIMEOUT_US	10000
+
 extern const unsigned char pcie_link_speed[];
 extern bool pci_early_dump;
 
-- 
2.34.1

