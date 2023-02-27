Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898066A4286
	for <lists+linux-pci@lfdr.de>; Mon, 27 Feb 2023 14:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjB0NW2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Feb 2023 08:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjB0NWZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Feb 2023 08:22:25 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2094.outbound.protection.outlook.com [40.107.93.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE40E2054B;
        Mon, 27 Feb 2023 05:22:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cf0Fwhi57cWm+d6ApZeqqqX1Jn1y56PziNjQ658Nf/2GyXulTrhFLbssTlbiUlSzKAmp6Y/lLbE6E0n2Xo/gRwij56uSk3lIIFrWKuY6LoPrnBKhaq/3gfZ5AnWOoGDHVn/1t/AfedaR/isly+eng0UltN4Ogq4A2UnCME9kFgJndFxrOb+Fyle09uXqNIbaq7rl9/8vJ/iD1ZqbXoES+TZfHw/67IND2NQZ6He2E0XBSi0dsNY7phcd7KUdA2eiy78b6jNpXGA1Sd7w/xDec2gp6JHweFkqG5VJXHYpINOpaaY3wXxL2ssqfWqwv8nFzm9AG6TQ9XqAuDExDBhEag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hEHzOK+0dYpV0ltEgeBv9S5VqpSxJaAI5Jzyun9Aabw=;
 b=nsyXl5ziNVsF+Ub4A9QlMQCbCq9BvZhEydBfwFwPwX1EAsINnmclCLTGuoEqCHZ532cot/u5YsU5oun9ofjC64raVNbn7rym2r5cRShV1aL/Vb0+NIWxIQ0T0rvpl7xLhXuQqNh1HmQyMdPFzSEFR9jFRcPipgoxHAmwKIjjtvZKdRK7uOzuDgLUWuC55FUsnCYUBoUO56qqLxaksU92WsgWY+JnACHIpECy3BMDOrwlGkDpZ0vXrqjTNfmMT2IwUVjRR45W7jRg9EAfbrI0Np0cDxi1lYtjh2PuINurhjedwwTWaA7gldZEueVYxnDofjaFotpsiikoeK0hQsuIbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEHzOK+0dYpV0ltEgeBv9S5VqpSxJaAI5Jzyun9Aabw=;
 b=IqhQjMKsBFePAwitmyshNDtya9E5pkMx9HZoYGEmYViFXnZOUiKf93o/K45bD3FAxjRtTLF4VjmhDW70Fv6jpdVGvq1c+3CiyZ2e/OfCbdIxO1pyq9LXkOpBk8Th+qa25Xd+4nzwKCPnIIiRYcq4FP7pt1Fh7b6p3WCmrDj/Uuo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24) by
 MWHPR01MB2719.prod.exchangelabs.com (2603:10b6:300:f8::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.29; Mon, 27 Feb 2023 13:22:09 +0000
Received: from DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::fc8b:5e5e:a850:7f0a]) by DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::fc8b:5e5e:a850:7f0a%6]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 13:22:09 +0000
From:   Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        joro@8bytes.org, bhelgaas@google.com, robin.murphy@arm.com,
        will@kernel.org
Cc:     jean-philippe@linaro.org, darren@os.amperecomputing.com,
        scott@os.amperecomputing.com, gankulkarni@os.amperecomputing.com
Subject: [PATCH 0/2] Add support to enable ATS on VFs independently.
Date:   Mon, 27 Feb 2023 05:21:49 -0800
Message-Id: <20230227132151.1907480-1-gankulkarni@os.amperecomputing.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR05CA0013.namprd05.prod.outlook.com (2603:10b6:610::26)
 To DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR01MB6824:EE_|MWHPR01MB2719:EE_
X-MS-Office365-Filtering-Correlation-Id: b1be4bbd-a2d4-4748-b392-08db18c5a0d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: er4aGU0PqCGl6XUX4dp6vcKwDqDVsIJQ8pw3Vr4lNB+7N4f4YXjCEFeon7mOW+65IeSNDT0JLFGrVrcdt7Fy8v+rhVZ8xN/w6+sBT54zWI5EjPnNQfEafdO7AW9EhCWhFa8LURVxriHRaYVHEQ/FD6h1UfQ+CC97Bt8vKjOxw5IB8rbRz63kKVXUZ7Qel6YGOacAgJTK/KyA7bWp0VpCr37ugnRMtlMeI0+W2wMGhW2bzfcYE70nRO737ypkkT9n9Uv0PuvCP+hrjtoi4c0jhO36blK0JXzFCIjoAYvbJuJbxCvPuHHFQKTH0zEzl2LsgEoipg+uRJsLJhLEtN0mUERs+rVUelHdKjfZ0ZgbOsmVX9+lyR21rIUaMGeNCyoQcgI8xaa0ZHGldRBFHa74COfPzxC9wtaih8J7PALRamNaw0+tPsitKrihKvmGOxoHObsm9ISP67cZ4QYOMcnVev9hSL4I5iqfTWisdEQ+6TxFMPoIPuanEjjfWZEnDb4ddHt3URfFyQUBPnILVnEzpHclAQsZd4xizhLS+J9pPeiRCO4Hsub+ErNBx7ZcftlXdMaG2PHKcvqZtiIy9WBJ4+EywvrSg9Zq/pq3RcTeGwmvBdJe2TMuD44ZbdRjztiMtsfg5tk83Nylk5KdtZKncVaNt3CMsoyF2r62QhkXNAJM/WkHSoRwnT9/ErkSpzjm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR01MB6824.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39850400004)(376002)(366004)(346002)(136003)(396003)(451199018)(8936002)(2906002)(5660300002)(4744005)(41300700001)(66946007)(66556008)(66476007)(4326008)(8676002)(316002)(966005)(478600001)(6486002)(52116002)(6666004)(107886003)(26005)(6512007)(186003)(1076003)(6506007)(2616005)(86362001)(83380400001)(38350700002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lj7RxcjC/qptuwKdOJXcQXYoYhd4W1pCi19OVgb9/2zCn6/M8G9Cxsr0wTyD?=
 =?us-ascii?Q?tbSCITME12lm5g1MBpkKNcNoK81FCpYDlYBoCpl4KbIbwqfkbH7AzrOYq/hg?=
 =?us-ascii?Q?Dzeb542nLw1mvGLDctxZNXaGHpKilreAr3cxCBNPNQqyYra5oayCkDxgXw96?=
 =?us-ascii?Q?KSPlYdqijqEVLRifsY0/DaOtWzxU2BGkm6pJv7wN7oASTShnq59YrWhWnNTH?=
 =?us-ascii?Q?LPrKuRvO5W4IA0Xl1OZDFDcflQBjfkJMPyzI0s3Obx5cMIvNd68dA4D9Z5Ep?=
 =?us-ascii?Q?MApSSq9+ducWYnWQW4kr22F1aLPvfyFHbUSuk1KUZ2Rx2T9Mpo//lu2h5e2g?=
 =?us-ascii?Q?l9TFkwv6YYzRTi/OhQZF0Qi+42PlXZwyAncAhn2DFPTjakjcy53CSaR39CsE?=
 =?us-ascii?Q?6eTj3qp/uXI7YKtq3RFfl8FV2vb8M8UQiNRI0eZrFQP8ilRm3OPRqQDizZxE?=
 =?us-ascii?Q?PzUUTQg9mplDdQPgSvDTO4VhzgjD/Zs08QcX6sPJ0E16DAVNUS5+Yq8zKiS5?=
 =?us-ascii?Q?lpJXNVtcoSIJyGDasLekNUFtR0QFsu83USp3bKoYqO58AC9TGer2vh0TSHSd?=
 =?us-ascii?Q?KcrsQ6M+BCAX5zvXCjn21JrzMbCqpZ0Hq8oaERCi7E1jzoAWNrUe9IxUaha8?=
 =?us-ascii?Q?7V9oXMsQTVzGXa+Qw5Nhx/pqBUUo7yhC0scpkKMlSh2ejmggiQA10tWdUNGO?=
 =?us-ascii?Q?yrPIwf93HNbZCpCcN40T8IBA9cd3HukkWaawOPJ2IDFvrzraMfqnx011iB+x?=
 =?us-ascii?Q?VW8BA6lLxSTeNBMDgMLjC+V7i3rJR1f2r8eVLn1ULmI/tHVJEyjcg+8Gkb2k?=
 =?us-ascii?Q?sH2NavmtkIZZVFWuM6z54R78Mbs5Vb+hNdAkjrEyCrDj35jnwkip3vygodqw?=
 =?us-ascii?Q?0qL6bh3T89t7TcTwBftiiGhYP+xTKRQsV9l7l+g1MIsmd/ayvrGkJMawNezj?=
 =?us-ascii?Q?rb3Xij6C5Mieo6OV5dwY1hov3H2QrigwO4AiyUeaQ2GGgBi+Be9feWLj+7iW?=
 =?us-ascii?Q?NrZs6PlkTrui++Qo5UB2YZKumkrT4YkLoV43pJFba+QhYycFAmnIJ5KpA6Np?=
 =?us-ascii?Q?PKKKv/0rGlePtiCbBIAv+tPq18ltbXMspTfFAGkjtY54Xs0L97IoebjTzilD?=
 =?us-ascii?Q?K8Cm2Lkq4WQT0kNgWE59vpeWuWp6Z3mPaerzHNe4KrVqHH6Wh+upXZUnjP3F?=
 =?us-ascii?Q?atjRW3+Np6eLcXQVWqrmt7WaQedCwBk6v21Siffz/6Z2y31Dx0Yr4oFpOy12?=
 =?us-ascii?Q?TVXUCQ7McgxthN4gZ+JmAPrQ6dnc8LXPKwN3fp3i5bPoiRwkLlZSAA1BViQI?=
 =?us-ascii?Q?hrHOBIZw0dEAPBYMdQl1CKFuxWT+Iey1X5ZSmSEgVhw5EjM+dXQP81LVtIIm?=
 =?us-ascii?Q?6i5swAOteGNp7zF2u7rBV5kWg8lZyBTaVN5ZaKjunl0C74wpaDZekJB3/yUe?=
 =?us-ascii?Q?gUl0qn28r6AiicGCQ7C/++DCjaA4rxjcHsseS+SPh958ljf69MWoJJFV3WwI?=
 =?us-ascii?Q?pGkogHFWb6/9SN+wRHFrgkr17VgRU7bjr8yGIHfK6eouiSnheHthz7v7LGjj?=
 =?us-ascii?Q?myruoLRD44VvgQgOOg7MUxRSjwfuzU0e6jduOdHdRyuNoJpvF+Rg/j69DuZc?=
 =?us-ascii?Q?AzBOie8DOdz+p1xD2YHPSdw=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1be4bbd-a2d4-4748-b392-08db18c5a0d6
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6824.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 13:22:09.0525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q6cXfBwqFawXe29bX34iQptQL1H2BGlhFWB3es7UcFonVq+tuuuXLcxMqu5HX2WtaMZX3TYy8O4NorBIMHpBJlLQGVq8bs+NszNubnZmO5s26wVJrOzVgHyW05/GXE1U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR01MB2719
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

As discussed in [1], adding a helper function to configure the STU of an
ATS capability. Function pci_ats_stu_configure() can be called to program
the STU while enumerating the PF, to support scenarios like PF is not
enabled with ATS, whereas VFs can enable it.

In SMMU-V3 driver, calling pci_ats_stu_configure() to confgiure the STU
while enumerating a PF in passthrough mode.


[1] https://lore.kernel.org/linux-arm-kernel/20230221154624.GA3701506@bhelgaas/T/


Ganapatrao Kulkarni (2):
  PCI/ATS: Add a helper function to configure ATS STU of a PF.
  iommu/arm-smmu-v3: Configure STU of a PF if ATS is not enabled.

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 25 +++++++++++++++-
 drivers/pci/ats.c                           | 32 +++++++++++++++++++--
 include/linux/pci-ats.h                     |  1 +
 3 files changed, 55 insertions(+), 3 deletions(-)

-- 
2.38.1

