Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D13E9433475
	for <lists+linux-pci@lfdr.de>; Tue, 19 Oct 2021 13:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhJSLQA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Oct 2021 07:16:00 -0400
Received: from mail-eopbgr130078.outbound.protection.outlook.com ([40.107.13.78]:32924
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230168AbhJSLQA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Oct 2021 07:16:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQxJnwiD2HulvAEkfXe5O7ZFMJKrInpppP8bvvTRa4qy9QKZEpfnsIjnXu3hSijZ3Ehq5CQiY3zfqREVuN2t6tB67UstNxVZwBbMolk1z3ycGoTtzrH/gljJn9niv2yE2FrN3jiXZFHVvhGciBaOhjc+VSsXALPOfj3xkGP2OA248Jx896S80fsbxhFlZd30zxMpLH8Jy6wzhqXfk+a4ul08stZ7v74d3DLyaHwRk8SHTCWAS6x18+9IiVBesx/19ey/X9iRrJBN7zVB/DgJ002naaTmI2z3WLrjWUwKlm0IOEVukQLsYiKyumGKvMC3+wheGkJ10l+oeZCJaeeBpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ASxPaA+Ymr9v9/ljlPXb+jBB+uuZ/T8U/UpiPQA2zm0=;
 b=KYGw1lGpGVfuM6Ro+Ek/3USyRR7zEuLdWtEFXmzrQ4UCaFOFxo08WvUwR+pe/ajtLEqGECivriw3+ez01S3biscFr5gyeNOGtxUvisSiFLJ0aubiCn39Xrc4Fvuf420vZv6DZ7Te4RC9N8Z3CUuI7cG8NA9izHUa9TtelaBCqNYLom/Wu3cRLvif05Ur/20to7MGyW6QuGrYoxByaWvto2mrMyFdQvfFUwxTyLWdAvlEGXj/zUX5qfIyb3V5AVVIprNGo9R+aVEMiLHm0zN4emHdoIG3IIDUGGgEXK1ll3GFkT6F3w4m13Wii/Tzg8dbJOulRfmru4DsQ3M/QKFIGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASxPaA+Ymr9v9/ljlPXb+jBB+uuZ/T8U/UpiPQA2zm0=;
 b=AE9MKgzZswrcAYzyr6sl3Kne1CPxr5MqGqF2gzMb35r61L5hL2621VbJxcjh/5qCheD5ttze8b53XDDg7qOV1lhHmkKzrlLOjj7atzS4FVRcR074awo5fUWb/UT5a9iDGG1HjSD8A5xSU9T2EBDIKljW/kDyTSA18twS1D6SD2I=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB2974.eurprd04.prod.outlook.com (2603:10a6:802:a::24)
 by VI1PR04MB3984.eurprd04.prod.outlook.com (2603:10a6:803:4e::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Tue, 19 Oct
 2021 11:13:44 +0000
Received: from VI1PR04MB2974.eurprd04.prod.outlook.com
 ([fe80::793c:ef8d:72fc:df15]) by VI1PR04MB2974.eurprd04.prod.outlook.com
 ([fe80::793c:ef8d:72fc:df15%7]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 11:13:44 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, kishon@ti.com, lorenzo.pieralisi@arm.com
Cc:     Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCH] PCI: endpoint: Fix alignment fault error in copy tests
Date:   Tue, 19 Oct 2021 19:12:22 +0800
Message-Id: <20211019111222.28313-1-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0051.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::20)
 To VI1PR04MB2974.eurprd04.prod.outlook.com (2603:10a6:802:a::24)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.73) by SG2P153CA0051.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.4 via Frontend Transport; Tue, 19 Oct 2021 11:13:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bad4402f-b0ba-499f-cb7c-08d992f18340
X-MS-TrafficTypeDiagnostic: VI1PR04MB3984:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB39841998EE1775D3DD141EB984BD9@VI1PR04MB3984.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fq/Z15NWlVFDdyqny1wUvkVVAuoIqaLVo4egOPdxnhtQJmVcicUD/eNmHuMNrsijd0f4lVWegFmEbamubwmxJg+V1LdH1+Xvf846oaw13g9uD/ITm8fIA0OUyW+6j9ZgxoXft5rfH7XII4RpPgalFiBK9IvjvKpLa4dBBRdBFeF9E1h8d+QnNkK5zPRAEP9fzek5lnRLLjRqs8U7Md9lzdyVfUCJ9b0Xa8CDBaTGOU9DktLOnlV+u3eKkvMC5+H238f/FLFBLhcB9IvIHogCL03oPIQckZC2mzBLfz6ZbMdhQwklDNtAjvBkLA/mUtfDiLvjZ/ZC8uF8WagZtNpS8/09Hz6iO7poH49HYf0nGHkiGsrnlWZgMkbC/zi4/V5NRrk17OtKvO/vodOpciAHeD5XMUmJ/qD0sHozf3NEU4emygUO3VPO/IrndEoHz+p3wxP9tUF08uoFuwZGTc7DG3mUeLuJp1wZdC7t+innGijvPlnZRKzRjUXN2a+UyoU/2NxsHiIbQCI5XjSpHaEuH/lWZnTAqt/xG/t8GSAR6bTqF3/1rwNaHy30VOaI+hO7RtOXo25YTY5T2Kwvi4QH8Y4pw7Xt1zE1+gQ5EuUykN67G6Y8cKbLdL6jc9nSC2UffItTzSPfVfSg60nQUzIpgkmQuTBYDhGYFazg7xhfUVx4FTJC6V2e/jKEy04KehlXU72nTwy1BLHIDwm8Ygx4ZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB2974.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(5660300002)(6506007)(6486002)(4326008)(8936002)(86362001)(45080400002)(83380400001)(2906002)(316002)(1076003)(2616005)(8676002)(956004)(508600001)(66556008)(186003)(66476007)(6512007)(38350700002)(38100700002)(66946007)(6666004)(52116002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vTp0awZD+T55aP3Poi0iS2S1+Yh4z6WdZgUDCxFyWhmIyNsA5j1sCBsO7H41?=
 =?us-ascii?Q?/pkWi1xgC3pD3BobX4CyUEvru0ZWLhCbO0FaeYCUqtS+MQKEyPqwVHuNU3iv?=
 =?us-ascii?Q?aXy8ejIiIdPsUuUJ9+WkheqeBZTOs+dM25rcAohjRHIA0j1w8mav9EGFJjfl?=
 =?us-ascii?Q?PCcD75mvnzqtyO8gGvKmvxkL78MHLs6lMSMV5sLk4qZE2oHLLyWSAddY8B/+?=
 =?us-ascii?Q?OCa22YC38FKOqXsS9dg30Zhskt17lTwa18HVe2BBrTx12SX3ZtFzMyeKuy96?=
 =?us-ascii?Q?4bV3rcUXbKvSRI211PAjk1OIVpCl+3GVY37Xa+OihesXizhAxSxeJzJpV7bi?=
 =?us-ascii?Q?y027YSsrridHsRsDYr9JTDFPT6ScK8Hg6g4FPFa0Z/0zcucC0jPqKF1QxveS?=
 =?us-ascii?Q?jhVeF6VHl4PSMXFB5haQxjg38B75ROZyvSkh1AMeX6xTj8SLd7slX3s6i1B9?=
 =?us-ascii?Q?N8wSUHCoV5bz7DhtezlRAO+WNFWRpn3GLfrhaUMSKpQAyEKvMJKV9ag57iYr?=
 =?us-ascii?Q?plk4FfTjq6UI7ZSIIZHE+bJIFY7EAHmlK4lIlxcEiNd2sF0ivEg3PSn+0Nvi?=
 =?us-ascii?Q?EfH5oTS9aDSq4TKZM+IbbzniEk0qpiJjMnLfESiafVYH+/pMiabkv0ZPh7yI?=
 =?us-ascii?Q?jdpz5XMekjv2va2ZSXKu4bLP2TY5lTQp+WI3oe8XrHD5P9HMjypdOdHAplfG?=
 =?us-ascii?Q?jKyZ3+jg1/ckFC/7cEn52TT1ozLmrbO7dsHNJpajfso19be5E6VhUBG/V4ez?=
 =?us-ascii?Q?wA8bOVVvo6vKgnxdsSO0v50YuKd0ZKVRaLIlA6VFKQ4gCE1A95GLb9WGJXLI?=
 =?us-ascii?Q?+WI6ZSjjF5R59VVnTWbdMcETNjAnYc1vIodF+/4R+1QAb/WL6SFvoVs1OXF8?=
 =?us-ascii?Q?nBzZ5xcrHI/tMT+1PzXrcXAbs2fHukvB1/jah7Z2qBfb4zSut6vMBj0Yc7w4?=
 =?us-ascii?Q?0iQpX28x9BaPjCov9xD4kE5aZqfafrVrd38aIrJQ5kZC3Kag3lI249Jc4SvW?=
 =?us-ascii?Q?hR1zdiy6abxgl2/hW6yV3KMeGsQV55gN5uuv4S5MY+0+Llqmm4Q5TGQ40TfR?=
 =?us-ascii?Q?K1cNKnSYP9RJE5/Jo53OQFbhkQE+r5Yof40R8hEWTgK+4siLEzgcOVyl4vqu?=
 =?us-ascii?Q?d+Vx2+lWa04Tv+dMyw31sIaEVfCYtlmx9h1E1rzbh6PSV0ZcAQMGuJKSXw2B?=
 =?us-ascii?Q?vqbnsEOeBRN1lEFQX0pVP22cf6XhpvW9joEywjR+m4erEepMpgi4RhVtPQZT?=
 =?us-ascii?Q?tq+al1bStG64VKTyfC4IXkKVT+tZmEoAR65aN8KyFGyMHWRDAk+zNTIkhUsX?=
 =?us-ascii?Q?VeA2MmiNx14aA2b3HapQsQoF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bad4402f-b0ba-499f-cb7c-08d992f18340
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB2974.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 11:13:43.8906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BOPEJs4ss68NAy6aCer0GUBx8dBOGLHXu5whSQpwmqljpMnLsbXPhJNBZKUp5NJTDQtg0Kt3umqgZ4ygw8k83A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3984
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

In the copy tests, it uses the memcpy() to copy data between
IO memory space. This can cause the alignment fualt error
(pasted the error logs below) due to the memcpy() may use
unaligned accesses.

Alignment fault error:
	Unable to handle kernel paging request at virtual address ffff8000101cd3c1
	Mem abort info:
	  ESR = 0x96000021
	  EC = 0x25: DABT (current EL), IL = 32 bits
	  SET = 0, FnV = 0
	  EA = 0, S1PTW = 0
	  FSC = 0x21: alignment fault
	Data abort info:
	  ISV = 0, ISS = 0x00000021
	  CM = 0, WnR = 0
	swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000081773000
	[ffff8000101cd3c1] pgd=1000000082410003, p4d=1000000082410003, pud=1000000082411003, pmd=1000000082412003, pte=0068004000001f13
	Internal error: Oops: 96000021 [#1] PREEMPT SMP
	Modules linked in:
	CPU: 0 PID: 6 Comm: kworker/0:0H Not tainted 5.15.0-rc1-next-20210914-dirty #2
	Hardware name: LS1012A RDB Board (DT)
	Workqueue: kpcitest pci_epf_test_cmd_handler
	pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
	pc : __memcpy+0x168/0x230
	lr : pci_epf_test_cmd_handler+0x6f0/0xa68
	sp : ffff80001003bce0
	x29: ffff80001003bce0 x28: ffff800010135000 x27: ffff8000101e5000
	x26: ffff8000101cd000 x25: ffff6cda941cf6c8 x24: 0000000000000000
	x23: ffff6cda863f2000 x22: ffff6cda9096c800 x21: ffff800010135000
	x20: ffff6cda941cf680 x19: ffffaf39fd999000 x18: 0000000000000000
	x17: 0000000000000000 x16: 0000000000000000 x15: ffffaf39fd2b6000
	x14: 0000000000000000 x13: 15f5c8fa2f984d57 x12: 604d132b60275454
	x11: 065cee5e5fb428b6 x10: aae662eb17d0cf3e x9 : 1d97c9a1b4ddef37
	x8 : 7541b65edebf928c x7 : e71937c4fc595de0 x6 : b8a0e09562430d1c
	x5 : ffff8000101e5401 x4 : ffff8000101cd401 x3 : ffff8000101e5380
	x2 : fffffffffffffff1 x1 : ffff8000101cd3c0 x0 : ffff8000101e5000
	Call trace:
	 __memcpy+0x168/0x230
	 process_one_work+0x1ec/0x370
	 worker_thread+0x44/0x478
	 kthread+0x154/0x160
	 ret_from_fork+0x10/0x20
	Code: a984346c a9c4342c f1010042 54fffee8 (a97c3c8e)
	---[ end trace 568c28c7b6336335 ]---

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 90d84d3bc868..c7e45633beaf 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -285,7 +285,17 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 		if (ret)
 			dev_err(dev, "Data transfer failed\n");
 	} else {
-		memcpy(dst_addr, src_addr, reg->size);
+		void *buf;
+
+		buf = kzalloc(reg->size, GFP_KERNEL);
+		if (!buf) {
+			ret = -ENOMEM;
+			goto err_map_addr;
+		}
+
+		memcpy_fromio(buf, src_addr, reg->size);
+		memcpy_toio(dst_addr, buf, reg->size);
+		kfree(buf);
 	}
 	ktime_get_ts64(&end);
 	pci_epf_test_print_rate("COPY", reg->size, &start, &end, use_dma);
-- 
2.17.1

