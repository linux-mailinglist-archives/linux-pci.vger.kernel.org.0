Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588F32957A4
	for <lists+linux-pci@lfdr.de>; Thu, 22 Oct 2020 07:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502529AbgJVFIO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Oct 2020 01:08:14 -0400
Received: from mail-eopbgr50087.outbound.protection.outlook.com ([40.107.5.87]:43904
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2507748AbgJVFIN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Oct 2020 01:08:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ar77PtMWwwFuc8v5tVSP2LjU/kDi38QAG5VvqjEUWSWcNaKyI1WtFQbsGl6146axeV0AjHrJ2koiQraXv5qzdrqce/mihgYV2W+j/OJyxxoBYwfPRoNsdJW3/mSZRGkD9lVb22V1Iu/xzW0FKAqbHVg3u+g4aOfcIrW+kMNaBBSNbGWdoyd/q0gh5Vdl9hkxGHUkOipBaoVJTWmtZA+YYvB8yxUPtNfSGZoHiodHJ8qalplsZ+nu8qcbHtzOPPGTyjIA1RApVgNXeU5LBEGtAt1NO+v6Mp7KtqPZQTfyO9X3qmAI05bDKeRtfWa+nT3N+05GSEM6LbeHuT8UOLSX9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVZPF8ukCmVQBEJhvAy5sOPU3cZNXiGabWPP7Dl+XQQ=;
 b=BgPrWk5N9J2gbT/FvXNA3fHtKhbw1xZVrWw4KhpZSvrdXKpqH0YrWjxoEhz3QVLJIbsDC/Y38h0qd0Z3rmRoysqcz+/RGz9Qym7yx2B62n6dnXskJ/fH3pa7r/yz8mLMyntbkm2YOiJr/OMOHS75A8cLeE8KxdSndjQdeqEvFyxOtk0+69qGn0Z33qp4iV8sPmpgoLUSOzPWQ7cs6GlSqEG4NQAPYUUklkNItQfeBAGhhjuDJuNUN3hx5OGw36yPsRoRaX1V4UvkQXKDNSHSbzzZPim5ng0C7eWTxrSJrp/DJRla1PfFms+eYwh8kIoQPmpB07nNNitsZTIb47ONTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVZPF8ukCmVQBEJhvAy5sOPU3cZNXiGabWPP7Dl+XQQ=;
 b=chzn3uP91oT++ljsZOwvE1Q2PagSfPTvlP1yF/X10m+KPe+4+mPK9wQApB2/BNIxk+1T8XFFcD5HhMTJdpl6+ZE3sfekJCjrYbExzEGO9nR4QTeTcUPYzzjDWd9XcdKTqKcPo7AclYyBiOZsiiKj+bQ6O5yVpbzGpzWUqXDDukU=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR0402MB3358.eurprd04.prod.outlook.com (2603:10a6:803:11::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Thu, 22 Oct
 2020 05:08:08 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3477.028; Thu, 22 Oct 2020
 05:08:08 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     hch@infradead.org, sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, kishon@ti.com,
        lorenzo.pieralisi@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH V3 3/4] misc: vop: simply return the saved dma address instead of virt_to_phys
Date:   Thu, 22 Oct 2020 13:06:37 +0800
Message-Id: <20201022050638.29641-4-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201022050638.29641-1-sherry.sun@nxp.com>
References: <20201022050638.29641-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR0601CA0012.apcprd06.prod.outlook.com (2603:1096:3::22)
 To VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxp.ap.freescale.net (119.31.174.71) by SG2PR0601CA0012.apcprd06.prod.outlook.com (2603:1096:3::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Thu, 22 Oct 2020 05:08:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 94280957-fe20-41b4-821b-08d876487709
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3358:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB3358E91A5A59C152D18371B0921D0@VI1PR0402MB3358.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j9A3DRyWhnVsJHOkaPDj4W5YIKSqoIfGnTeydVVrgqoRJ7SZ0XgJlmCKGaCeMaI0Wna59lIJlkfaDSdJt1N9laQ/I41bZuwE3qxlZ6GBA/wEUiJfbcxPyQw7Mf9c/w41lzokKSmM05PAhwuBVeTV6SurG0kMXaERZOtqb1O8OLV1pJ5ED5kFbd8s5MiluWO1jQXjNV3Ao6UXKmlmgiKIacqGDPAa/PV1RULyHYyf6q1o9yXXz2LWpg8oDmTGaw5ZEmfTk6GB+82yZXJYQWvocQL1LbKbCQBGR54SsPVdLUom3VUhUqK3f2nJCR8vgdf2CDpflB4NEuzQFItXE050kg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(136003)(346002)(39860400002)(6486002)(6506007)(44832011)(2906002)(66476007)(66946007)(4326008)(83380400001)(86362001)(6512007)(316002)(2616005)(66556008)(956004)(1076003)(186003)(26005)(16526019)(478600001)(6666004)(8676002)(36756003)(52116002)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: PQS6UMWfJN2LqbBpm2LpbIcEBOR2x+IAGgXbo1AIiL0vcH9z5M/6DV7OMoFRrWyUYa1mxQdW7dJ5NZCFPpvUcYK0N8HBXdRjtJ0/4LCSMGM9eGz1LoUgztjjapnQ/omLcVOG0PNnyTEW+XATuqQCa8AKsNfmoEuMYXzSRp4YSx6Jw//h+y+l/OiPnMN4Eb+d7v+wzEolP84j8pIIzjDC6ADQ+zqSa9YgXchfTqAAyj6zBcbOy0dymQHu6QEbU0RVPH95uO+Fnp9hAURdXwUkNWxky90syobfRGxTuZkMv8QT39YJMfrKPxg6YDpDeroEXZBclMxFZ1qBwKJDip6/vSQg4BFnCkz5AU4hFY2MJfXpcl+93Mf4iV9utT5WPn/iUPlnxiMzvdiyebzbmKfNNehIeffuTKDvYs2+fyazlQL+FwzKVhc3rm5F2dSUo5rur6LvNan6BP7+balavjAfHT/G69YxxWE+aTzjuPROdwARVJjnmxMidBH/zAJfvt8U2cgeSYIv7b16HbY1Mg2G1O14hO92xkabIZ5sqWGGBt1kssGdt/UR29JCZkGbAWy03Nh/0ewfEZMsNHPJEA2BhPh0GiutsrgP3vNc6Tk1v3dEKAXcSx22nqxs3oGj6cWHKkw37JqcGP3iCMx1m8T0tA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94280957-fe20-41b4-821b-08d876487709
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2020 05:08:08.1658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zfub9iciKWkAga6Fxm2zKP7Qxtn+Rg6G/ddwwLdP4eG+ugAXih3816YHv0eO0+XYOXwkjYrHxmcHCKpalDZEmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3358
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
 drivers/misc/mic/bus/vop_bus.h    | 2 ++
 drivers/misc/mic/host/mic_boot.c  | 8 ++++++++
 drivers/misc/mic/vop/vop_vringh.c | 8 +++++++-
 3 files changed, 17 insertions(+), 1 deletion(-)

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
index 8cb85b8b3e19..9591bf609f57 100644
--- a/drivers/misc/mic/host/mic_boot.c
+++ b/drivers/misc/mic/host/mic_boot.c
@@ -89,6 +89,13 @@ static void *__mic_get_dp(struct vop_device *vpdev)
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
@@ -120,6 +127,7 @@ static struct vop_hw_ops vop_hw_ops = {
 	.ack_interrupt = __mic_ack_interrupt,
 	.next_db = __mic_next_db,
 	.get_dp = __mic_get_dp,
+	.get_dp_dma = __mic_get_dp_dma,
 	.get_remote_dp = __mic_get_remote_dp,
 	.send_intr = __mic_send_intr,
 	.remap = __mic_ioremap,
diff --git a/drivers/misc/mic/vop/vop_vringh.c b/drivers/misc/mic/vop/vop_vringh.c
index cc928d45af5a..b5612183dcb8 100644
--- a/drivers/misc/mic/vop/vop_vringh.c
+++ b/drivers/misc/mic/vop/vop_vringh.c
@@ -1009,7 +1009,13 @@ vop_query_offset(struct vop_vdev *vdev, unsigned long offset,
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
-- 
2.17.1

