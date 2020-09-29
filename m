Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A12F27BFDF
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 10:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgI2IqI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 04:46:08 -0400
Received: from mail-eopbgr60055.outbound.protection.outlook.com ([40.107.6.55]:60441
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725372AbgI2IqH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Sep 2020 04:46:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ux9vjazJRnCZJcGBdDB2eRVcUzPJT6gZjg7Em/abOFYparwEO9B52i8tAxfTOQnb2h8FIjDcbnrW28ECddQDYzRrgMfuP/FepvAgdoj3nQ3K1+C3BSwH4nWeJh7z6U/R4BmHPcnGDi2FWpYldZFBF1aQP/qVsibZ7s65GkI5RR4NpPBvMqze2kvdNTOh1kKIq/s1atUcwenmrWCBunJWLwrD01RIaN21pbYUHjnEp+vQ7yWpsx5rrIsk2uSaa4DyX7oFhSLhhmtS6m35u9IaLFN8MwfJ7BJMH/AMy6A6EPSv7UlvG30sKeuHTJ4M2vP2woOIlv+h9+70EfxaVjfdTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSQYE269/M3Dju+lj/Sb1EexruO+iji0spXGTI4C6cg=;
 b=KEAqiWsSwQgWotwXyjb+ZbcbunmWo7b9qpVb29VYLDviwK3CTpN/fM5nxqlEIKAzs8kWxrlcGpXwzMIYP27H/ezdPLxLpXh9d6Nej2xlFBQJQFZatUANA3Y7gnjVxpHkTEbAos8ktLeVdI709TRbeRBwpCKF/IH/SnXiPj9wpKCqWOKAMzNnA9IFrSAG2jYlfS5Cla1N2qVaOobSPDwawV+4/HjzTE5Jp5j51JNJvRqA6XlqYUYOQWOv2LZd8FmP7Sf1yMrvsO3J8+Zi8LRblpaz6cnt9viih7wgrv2ZC8dxogb45KmjqUQGrXiL/+t52oDI2SJd57t71Ri0+Avoyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSQYE269/M3Dju+lj/Sb1EexruO+iji0spXGTI4C6cg=;
 b=ms/WkSnPWwghldenzxoOULEaIf05ba1a35sGrZ1ao3ftMlGEMTZgjC1+Qs39W48Ll8CPKOAGjWfD50mqvMOTa2vgJcQcHVri+DlrG/RbZxgBDDQiFYbdE2P9ARWDUjM1mUF73BIAGNyUYVo3W/CIe5jTi0KVzORR0/q5/UcQVUA=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR04MB6910.eurprd04.prod.outlook.com (2603:10a6:803:135::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Tue, 29 Sep
 2020 08:46:04 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 08:46:04 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     hch@infradead.org, sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, kishon@ti.com,
        lorenzo.pieralisi@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH V2 3/4] misc: vop: simply return the saved dma address instead of virt_to_phys
Date:   Tue, 29 Sep 2020 16:44:24 +0800
Message-Id: <20200929084425.24052-4-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929084425.24052-1-sherry.sun@nxp.com>
References: <20200929084425.24052-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0302CA0032.eurprd03.prod.outlook.com
 (2603:10a6:205:2::45) To VI1PR04MB4960.eurprd04.prod.outlook.com
 (2603:10a6:803:57::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxp.ap.freescale.net (119.31.174.71) by AM4PR0302CA0032.eurprd03.prod.outlook.com (2603:10a6:205:2::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22 via Frontend Transport; Tue, 29 Sep 2020 08:45:59 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 805aba85-990f-4176-3783-08d864541969
X-MS-TrafficTypeDiagnostic: VI1PR04MB6910:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB69102F0012F64C4A250304FC92320@VI1PR04MB6910.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lOOBtWbWmYXLHSUUXZyANJ/fYiOCRR26CX2w7w1HZ0lGAKKt8u/hR30kyVEKC/tQWaT5O4A0WZQGd++TkmMOPGKpMP6Nm4WvFUrbB09PWNW1ls4nJB5oYku411LHLgNJwdB+CQULWuT6o5lyiESNmS7xe3Fkx7NxnkipHs8aAYp45KYw7ZDHp25kJGrBsUurBSUAHnGWNk4vUOpAK86hZfxgwlfhJxhG7ihVO78hyaGRzg54KBVWDYvFPbrb0AdrOmGBs9BTdlptUQ4Rs35WUHH3wBjHHhtsNalDKnJ9iit5+0y8PEAQerL2Wd4HD/G89AByKnjJqQBgd3hJ+5gTYb4h7CPjZXSl/1aoVptJsX/i460TUQKr1ED/fuB8OBab
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(2616005)(186003)(956004)(316002)(6666004)(8936002)(6506007)(52116002)(478600001)(6486002)(5660300002)(66946007)(1076003)(26005)(4326008)(6512007)(16526019)(8676002)(2906002)(86362001)(83380400001)(66556008)(44832011)(66476007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 0uboAwKBuRVgNCc1VfY62rfgZqRzAPl1/myaNnypRIyyqTCPSZh+4pNLin/JkgdyR2DrOQi3ItF5hilqM0UXJ7x9pVuImtJsffyE77DN31cXTjh9viWSfFkHje2pxF9+qZwIiuAcN6vSNrxObWaIdU3SJprz03eh69YR44MfJRj8SaehaCVWK2XI1MmLdMYIhOQsX+POh4iLlAg+u/R3EkKNsoliSMGPHOQGVKOtHw6Z7D0Ejl5cvpmkJfl8BS9VKbVqa4Ru681Y6vVUFE62otwCJDpgyLcZB8S8ZVMgJGOH4we5u0/ORrVR/7I9dt1xfbh0w7hER1A2F5SEFANT4i7XhBaaxeqzA9xl2MWDjCXhTJCMvPY3aBSPqmiNb1QO9taFkppxrfoPj9T4Ya+/yeE/DiNaWGsLrz0MnCVC2Gkbo95WOxTCpfIMH1ze+sGpA6X7NIj6NpX94Rvm9Nv744NU/d0rJfJ5o5WgL1JItThH+sjcPwGkg6Mi41zRq+HQgUkhAnZ2+3ZtD9w9FThsEnNz8RNd8emp9TkcwxByQvPl96tav6NKZBQJeB8Fl4kOKcbml6U7RXFnJKKYFkjZNLpsxC2O5souBnV4PjUOzD/X1/zESHZVDeaa4MSYdKOkA7bpYEHc8RGi9oAI3rBYIA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 805aba85-990f-4176-3783-08d864541969
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 08:46:04.3579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CabfxXhHOacQAZDnFsSnZ3jWO8GDOPHUAhBssXgMuAd8ijbJlYqmSCAkFBH5KczoOuIFhh0OKpGfLtmxae32EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6910
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The device page and vring should use consistent memory which are
allocated by dma_alloc_coherent api, when user space wants to get its
physical address, virt_to_phys cannot be used, should simply return the
saved device page dma address by get_dp_dma callback and the vring dma
address saved in mic_vqconfig.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/misc/mic/bus/vop_bus.h    |  2 ++
 drivers/misc/mic/host/mic_boot.c  |  8 ++++++++
 drivers/misc/mic/vop/vop_vringh.c | 11 +++++++++--
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/mic/bus/vop_bus.h b/drivers/misc/mic/bus/vop_bus.h
index 4fa02808c1e2..d891eacae358 100644
--- a/drivers/misc/mic/bus/vop_bus.h
+++ b/drivers/misc/mic/bus/vop_bus.h
@@ -75,6 +75,7 @@ struct vop_driver {
  *                 node to add/remove/configure virtio devices.
  * @get_dp: Get access to the virtio device page used by the self
  *          node to add/remove/configure virtio devices.
+ * @get_dp_dma: Get dma address of the virtio device page.
  * @send_intr: Send an interrupt to the peer node on a specified doorbell.
  * @remap: Map a buffer with the specified DMA address and length.
  * @unmap: Unmap a buffer previously mapped.
@@ -92,6 +93,7 @@ struct vop_hw_ops {
 	void (*ack_interrupt)(struct vop_device *vpdev, int num);
 	void __iomem * (*get_remote_dp)(struct vop_device *vpdev);
 	void * (*get_dp)(struct vop_device *vpdev);
+	dma_addr_t (*get_dp_dma)(struct vop_device *vpdev);
 	void (*send_intr)(struct vop_device *vpdev, int db);
 	void __iomem * (*remap)(struct vop_device *vpdev,
 				  dma_addr_t pa, size_t len);
diff --git a/drivers/misc/mic/host/mic_boot.c b/drivers/misc/mic/host/mic_boot.c
index fb5b3989753d..ced03662cd8f 100644
--- a/drivers/misc/mic/host/mic_boot.c
+++ b/drivers/misc/mic/host/mic_boot.c
@@ -88,6 +88,13 @@ static void *__mic_get_dp(struct vop_device *vpdev)
 	return mdev->dp;
 }
 
+static dma_addr_t __mic_get_dp_dma(struct vop_device *vpdev)
+{
+	struct mic_device *mdev = vpdev_to_mdev(&vpdev->dev);
+
+	return mdev->dp_dma_addr;
+}
+
 static void __iomem *__mic_get_remote_dp(struct vop_device *vpdev)
 {
 	return NULL;
@@ -119,6 +126,7 @@ static struct vop_hw_ops vop_hw_ops = {
 	.ack_interrupt = __mic_ack_interrupt,
 	.next_db = __mic_next_db,
 	.get_dp = __mic_get_dp,
+	.get_dp_dma = __mic_get_dp_dma,
 	.get_remote_dp = __mic_get_remote_dp,
 	.send_intr = __mic_send_intr,
 	.remap = __mic_ioremap,
diff --git a/drivers/misc/mic/vop/vop_vringh.c b/drivers/misc/mic/vop/vop_vringh.c
index 422a28c1bb7a..4d5feb39aeb7 100644
--- a/drivers/misc/mic/vop/vop_vringh.c
+++ b/drivers/misc/mic/vop/vop_vringh.c
@@ -995,6 +995,7 @@ vop_query_offset(struct vop_vdev *vdev, unsigned long offset,
 		 unsigned long *size, unsigned long *pa)
 {
 	struct vop_device *vpdev = vdev->vpdev;
+	struct mic_vqconfig *vqconfig = mic_vq_config(vdev->dd);
 	unsigned long start = MIC_DP_SIZE;
 	int i;
 
@@ -1007,7 +1008,13 @@ vop_query_offset(struct vop_vdev *vdev, unsigned long offset,
 	 * ....
 	 */
 	if (!offset) {
-		*pa = virt_to_phys(vpdev->hw_ops->get_dp(vpdev));
+		if (vpdev->hw_ops->get_dp_dma)
+			*pa = vpdev->hw_ops->get_dp_dma(vpdev);
+		else {
+			dev_err(vop_dev(vdev), "can't get device page physical address\n");
+			return -EINVAL;
+		}
+
 		*size = MIC_DP_SIZE;
 		return 0;
 	}
@@ -1016,7 +1023,7 @@ vop_query_offset(struct vop_vdev *vdev, unsigned long offset,
 		struct vop_vringh *vvr = &vdev->vvr[i];
 
 		if (offset == start) {
-			*pa = virt_to_phys(vvr->vring.va);
+			*pa = vqconfig[i].address;
 			*size = vvr->vring.len;
 			return 0;
 		}
-- 
2.17.1

