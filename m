Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1EB4787D5
	for <lists+linux-pci@lfdr.de>; Fri, 17 Dec 2021 10:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbhLQJgJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Dec 2021 04:36:09 -0500
Received: from mail-eopbgr60070.outbound.protection.outlook.com ([40.107.6.70]:13124
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234197AbhLQJgI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Dec 2021 04:36:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDOtSYfw32RwBuAglYRIEWRUxU4c6NJjSkjNZE1oCndGn9GVRF14EIiBAyCY0yKzjHu63GtxD1h1SCOKWdOeVpO1YBLePzHRgpLMeBVMmE7fEaziTR1DEMcW1x8+CBO92PG0LFYLntFX1uUz9Otlnwyy5fDyosiBCKAFmc0iM7LA6wuNFt5Il2VRHOwUkYaNSo6nE5Nzp1Y9M4VjoY0QpLI2DwASrZ7Seuq+cvUZiPQgYuCABFCmhD7cQgOVacwrAOHv3lYPQX9zLpzY64DfvX8Qugvc6LK7DQedHxyAunSgq07cuBHWKuAJV42Cf/3RzKDfToEvyhs94yG/GxCkvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cs8LwdU7oXmNJPm2DOpnNiNFt/GbbOlvnPkvP5sFVvk=;
 b=baUWnv7Gxz0r5ytf31ZTIznEFYng6Gjh2jLPIbmsy6vaa8mZL6xaUDdmcQ6wLoHtRfuCFIh0OLriS4xLeNfCP4N8UDOUHGcEjQxnvWf7wpRo+W/2L0itdthNy/6uVx1sgxYHHW5QxUY3vgj1+UChBzYDhQ8am8rq88dIe5b+RxCdlc0rvl8rc7HcPtW4weuXVL/T7RbTdKr0jI4KcppwkmpcYECRX4/TpbwSWfDlTlIHV7WPvmQQlHIjwkng5kWKE8ssAb6kiNYs4e6lJRMdgfE7Zzg679MMwk6ou3RKxNIbqVS6hVILlr0++5ml/NiEcCBo5ysLx+pJW+y3MyTNxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cs8LwdU7oXmNJPm2DOpnNiNFt/GbbOlvnPkvP5sFVvk=;
 b=pgalxoUUMNXmADDkVOCr5FCi+r4G+ylH104qZemLcOJdX9qpGGR6o6T9EgpeCY+BszAE+wYyoS6v+OzBYoegiATe0eurMX58xKRg6XIY88gfWMcozDsKlVi1rx5FV7FOqhkUzP5wyME/XGMCAtdI/9DLFyV+umWNok1VjKipTsU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB2974.eurprd04.prod.outlook.com (2603:10a6:802:a::24)
 by VI1PR04MB5710.eurprd04.prod.outlook.com (2603:10a6:803:df::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Fri, 17 Dec
 2021 09:36:05 +0000
Received: from VI1PR04MB2974.eurprd04.prod.outlook.com
 ([fe80::2519:18e0:1cfb:f145]) by VI1PR04MB2974.eurprd04.prod.outlook.com
 ([fe80::2519:18e0:1cfb:f145%3]) with mapi id 15.20.4778.019; Fri, 17 Dec 2021
 09:36:05 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kishon@ti.com, lorenzo.pieralisi@arm.com
Cc:     Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCH] PCI: endpoint: Fix alignment fault error in copy tests
Date:   Fri, 17 Dec 2021 17:47:08 +0800
Message-Id: <20211217094708.28678-1-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:4:186::21) To VI1PR04MB2974.eurprd04.prod.outlook.com
 (2603:10a6:802:a::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f72f6595-e8e8-4c3f-f4b3-08d9c140a587
X-MS-TrafficTypeDiagnostic: VI1PR04MB5710:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB5710115A9763D31A2BEB7D1984789@VI1PR04MB5710.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LpJL0GLgwfL6oJgy9WSNva32GHRpoYW67/K0foHKfPSOJ+sanXj9sHiiuyCtlTr+dEWsEulrobGD3rbKbfBY70/nJ5bDJLRS+ZnY65VwJPt8KsU135EdC59/ezQF4dt6Ud306t/Izut37xoO8Jx+Zhf+nwjPp4Gs5Z1K0IIRAhdbDAEMAS40NLcEshzzMteYIOmrMFY11k1CC4W8vlCuqlZUdvtJ3jgT+Y4sPV/lF07QB6kx/MQTtNCIgrFY+8q8EOC2ZC3z4qV4jkXJyIRuVd1BqB6zXu7JEluAxhc8bJOPWH+1DBOM0uoDcBtSqBJK7UPlM0cuAhNwAS+8/XCMslOefhdFr4tXDTos2katgVSrvdm8poRiuA+MAeqmH7xo5QsO4n7nBtlp9Sn/Jfx4f2ImAIJBMB71iV03gTl9hbD5jOAo4Oe9ceReVBPowMFO7SVtkPvWXgRwtRC9ADRWzRHmX/H4Z5tmxXs8Ct1E0EUgp9unr/Gq9QdMc6oTXes+Mi3tSVzoZEpAXCM7XY0Zx1uSUrL9j73MtpVChbFjUO6Z5W6W6wAYby08UqNxBgCcSx/usHsNJ38j1J04jOmNdOrQqg+jnLc7puxRdKhg4c0pFgWrpa5vJbB6AlxD3/x9K2krWRtSYzptDynYSgkRwAyijrY7OLZ57cfYtBEAi1P+PsOa2OnTnOus4VEHujiiE0ep6qDya57XCq17ska1Dw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB2974.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(66476007)(8936002)(36756003)(86362001)(52116002)(26005)(6506007)(316002)(45080400002)(66946007)(8676002)(83380400001)(6486002)(66556008)(508600001)(2616005)(186003)(1076003)(5660300002)(6512007)(4326008)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fnHDVUUaqC9o7VoU9ZGc8+RqlLOkxtKmJ9wZV6wk7zu4MyOcQEJ28c12Kg7n?=
 =?us-ascii?Q?JwWNHCSgGApp6c0Dr4w7zY/T24xZhAmwDDTJ6bkR47SYFCvtcT9ELyWSgi7Z?=
 =?us-ascii?Q?J5jpXeNGmc5ZZNr4pYUv6NEHgz9s4VuBqfZAigGuHJ2Mq0DAM8+78XKYqwfJ?=
 =?us-ascii?Q?LhasV2chdslQeSgawCz1+ZpiqrRpocqhTRAoHTUG8KVmOSvhlZIJRQezGCSl?=
 =?us-ascii?Q?8HinC5+nUAhFdbi0MR6LR4aX+IUEg4VWwsq4e3kAo7Tj5dcdv7XYzllMubv5?=
 =?us-ascii?Q?gI0JAoNgcN128aTPOmLWPFGifGQuGPZqnNYJtbkNdZJvkgSYp1pQtmtcTjXo?=
 =?us-ascii?Q?R145eDcMbs8uZKvnjEVqUqzi4t6FIrnTzydtDR3HamBM3mZkH88B4jqUBTpW?=
 =?us-ascii?Q?06+CN/yuyGwXcGBclEfdJq5LpSnwZqlz9lVChWCZJf0844XSg4ax8+Somwwo?=
 =?us-ascii?Q?lIrdzyxeUYyhRtehAFVhXmRmfnRl4zOkPZQseDWuCi5kVUdYjCBv0SqzyyuI?=
 =?us-ascii?Q?FUTiiDAxYQibYdUrCvfPAJO3/O0w8qYt+PrTHgt98pcd9YgpVZriT1ge9CBr?=
 =?us-ascii?Q?fpWuKHpOo3KzNoO8Jmw5uoBzBvxy5nEgeQtSK45M3fPAErJuH1lRWwGjHZqD?=
 =?us-ascii?Q?q6gkLVy6CTMHSCxNDUBsWduWC2l7nq5xWeEQfR5gp4IWJS/WQEfML+Y+OUos?=
 =?us-ascii?Q?IQes40RBbZ6T8t4QYNSyPTyky3MT+QqgxttwQScXTNZWcDkpxiSUP1v1p06S?=
 =?us-ascii?Q?/h0yALleF2NfywrJL4lTwgo9GmhqHGUY2okFgf6zC84wK/F5TwDsWTyHmgv8?=
 =?us-ascii?Q?HJUbbSkGd9xWf5PI4FSDCfqjfH2VoLGgzQo62Gt+vfSwL7psV4970HSb8bKG?=
 =?us-ascii?Q?K2OjfQqSnLPbOw6u/HRkfozheuymAE/gGiKiIYH9QQOm0G0C1Rskv2dnDZI3?=
 =?us-ascii?Q?g15D8MtZRJjw2PY/iW+rQNrWR4E38cISCai7ojo+tXp91flz2kZ/lBbz/l+n?=
 =?us-ascii?Q?ofI9MKDE1s0yqhGBH9jwDwUCRbBZm4M2TrTQ57wtR8jJP1YFCMCagkFC53MC?=
 =?us-ascii?Q?5ctGzvxkJWA4WdCqUpEEnbfj+7X8Ir03rBVDUPhZjN4JQIEQKYAAmQMmbRFC?=
 =?us-ascii?Q?/vagxxGhJAOQvo95nXKncr8uV6MxMff1C+t5maBrXv2HjLhW2GcugEyeeHkZ?=
 =?us-ascii?Q?2cghAV0b7/Xx4Ubtv1/5EFKTh1VuYwAAQYJYsx+dfuVELwYfIXvOzXIRY81e?=
 =?us-ascii?Q?iivKeAnNT+wVaTDkPnd8jisY3hUb3y/umXppIsqcBowtCZO7FB/cCuWIVmlD?=
 =?us-ascii?Q?/dHIpB98Q9WEexaDjjtku/g8ngzOcoThtAGc1Vpe1A7Zv+6Q1OeBluiGrh5b?=
 =?us-ascii?Q?uyyoWHvJncv5Msual1dXIvYblzY5Yz1FkRxXx+ECjPJSC9+6eEBfpUPynCck?=
 =?us-ascii?Q?QdlVyU5Y5us2rMG++tIY08TcyJdtosa1iGuq5oq2E7kkdhW3f/UlDoOl1UA9?=
 =?us-ascii?Q?NLXWezuZKNHj4C5ntAZVCWUerxLGl47Qx9JbK1n9EoMYp7uOs0RJR+R5mpym?=
 =?us-ascii?Q?mW3tvsnfHBPsFl8Eh3CzyIarAnwz7gk6HYesrmrn71X34pF8ORKYs0hOP7s9?=
 =?us-ascii?Q?BBUG0O1FBrOhc3v1jFJkmEY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f72f6595-e8e8-4c3f-f4b3-08d9c140a587
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB2974.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 09:36:05.2135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /jKtD5e0N5XdAMsMvbzAY4Cr+4axcQNirnoxIx4ckgt+95uL+MWIbaglg6XrtMVQYzxgvSJgiP0gKkv7mb4qpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5710
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

In the copy tests, it uses the memcpy() to copy data between
IO memory space. This can cause the alignment fualt error
(pasted the error logs below) due to the memcpy() may use
unaligned accesses.

Alignment fault error logs:
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

