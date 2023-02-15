Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97656974D1
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 04:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbjBODWN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 22:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbjBODWK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 22:22:10 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B51532E7C
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 19:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676431325; x=1707967325;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IwvAJLtuxZiowQVqD/EJeUOtDRGFm5IRLsmzFadJxXc=;
  b=hxN/XFkkjUdN9ibhLSEXlXDExjij+sY525/u5Ifffuna6Lc3UPytWuZV
   QVCrbb/XOWdlgiTFBEa+JHZPkIy7QLzlxmGdjHfbTFCf2pVdMHpTrNtmQ
   GT/SzfRRObU9wvRm+d0/NmDQxXfdOGf4GKPgnK3SNQg1ioAgK/Qqy4xsS
   gQiSbrDGBnGXGfYekYKKgefDXfTMn+AREcn/X/lVYaeIVC0FP1IL/j83z
   C5tBafpet4lqmvJo+2tlAb0jf8J/e5qFzu3isxU/uEaBvmlQd5X4Jrien
   MwQj9PfsVGOMP03XXp/Wok9OgP1Ao0lqbT+vHA92Trs2+B3NV2VF0tv8f
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,298,1669046400"; 
   d="scan'208";a="223351451"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2023 11:22:05 +0800
IronPort-SDR: 3QjOGe3gPBu+pWzRcUDQ8rUcd9ZFWZF17KCJettod0ZPP9AWjBYTlZs7Tvk/UWvo86T1jSE1EE
 vC7HQWbUw9ytQ+D+tBucATs6vtUsb75NPe93Fw6PaMtTOTF+ezZ3nXZ6jeNpDTfT1QHzHgIhDN
 L/B7Jh7NbV+k1uIEUlEHN5yfRSRDCyy9wuIASI70+ob1xTE6YJcTQ9N+Oy1Yto73xuVitnMNZr
 tgjl7HOQlHFe1GJdzfZM1CVCwGbeRLPaZ9fRw/1+JU7VQeX9ztjd+GHX+avF5T6glguK37oA8i
 1Ss=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2023 18:33:28 -0800
IronPort-SDR: pADATaYUvJcNB7EjjREKNQ+b5eA1+nqSHMeqQVXFkk6bH4eGXhudtS5/ZnxsyMhq5GPBLwOE/M
 Do5lLSh1trLsNd8o3sslRVYbYzVi2DGKHuel9x12cg7bl55H1R2PVoN5svIHSPJfswbf6vbKml
 24GAipVhHtCDU92076/FeDrNJiaOfyboM6GXnXthRGNmw18nkfo27nyzGIw8HB/tlmkTwUYk+5
 kZ7Obf6jXUKB87kyKpZHHlMFSI/Yt9W16yBjnzE3ffbuowqRrIyy3sohRxieFKNlNatrX9n2F8
 P8E=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2023 19:22:04 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PGjzx0MyKz1RwvT
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 19:22:05 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1676431324; x=1679023325; bh=IwvAJLtuxZiowQVqD/
        EJeUOtDRGFm5IRLsmzFadJxXc=; b=KG0q7RbmpTbdE3/vfAEdJexcgemlT4UkHR
        s7sZ40Iv3B5U/FAtLimd89Eya+2nShFmFgP27GocxorySRclLtasX/zqhy7gaZ+9
        dz83kzNkniRSBALgg4ym/7sEFcjutBk8B7x5rNViHPq7wwtkV0CwUaa7VPDqfMfd
        B1VPd5MC7U+Bw0PyhQaTPV1/59Dd0S8VgRhEFK/Aasis5yrv2FG95MJ3j2O/3Gp7
        j31QjhFXWvpz+MT5klkUDJHpyrOroG29J6hQkqo6IcizTYlMMGbI4twohX6iIhlI
        Yh5DQe0S6zRRYdpA80GJFOBAy+CGiuzYOWYJ1BR3fLP66xdPmUdQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id c3DuPnfgDrY5 for <linux-pci@vger.kernel.org>;
        Tue, 14 Feb 2023 19:22:04 -0800 (PST)
Received: from fedora.flets-east.jp (unknown [10.225.163.119])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PGjzt3c2Gz1RvTp;
        Tue, 14 Feb 2023 19:22:02 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 03/12] pci: epf-test: Fix DMA transfer completion detection
Date:   Wed, 15 Feb 2023 12:21:46 +0900
Message-Id: <20230215032155.74993-4-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230215032155.74993-1-damien.lemoal@opensource.wdc.com>
References: <20230215032155.74993-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci_epf_test_data_transfer() and pci_epf_test_dma_callback() are not
handling DMA transfer completion correctly, leading to completion
notifications to the RC side that are too early. This problem can be
detected when the RC side is running an IOMMU with messages such as:

pci-endpoint-test 0000:0b:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=3D0x001c address=3D0xfff00000 flags=3D0x0000]

When running the pcitest.sh tests: the address used for a previous
test transfer generates the above error while the next test transfer is
running.

Fix this by testing the dma transfer status in
pci_epf_test_dma_callback() and notifying the completion only when the
transfer status is DMA_COMPLETE or DMA_ERROR. Furthermore, in
pci_epf_test_data_transfer(), be paranoid and check again the transfer
status and always call dmaengine_terminate_sync() before returning.

While at it, also modify the channel tx submit call to use
dmaengine_submit() instead of the hard coded call to the tx_submit()
operation.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 42 +++++++++++++------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/=
endpoint/functions/pci-epf-test.c
index 55283d2379a6..030769893efb 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -54,6 +54,9 @@ struct pci_epf_test {
 	struct delayed_work	cmd_handler;
 	struct dma_chan		*dma_chan_tx;
 	struct dma_chan		*dma_chan_rx;
+	struct dma_chan		*transfer_chan;
+	dma_cookie_t		transfer_cookie;
+	enum dma_status		transfer_status;
 	struct completion	transfer_complete;
 	bool			dma_supported;
 	bool			dma_private;
@@ -85,8 +88,14 @@ static size_t bar_size[] =3D { 512, 512, 1024, 16384, =
131072, 1048576 };
 static void pci_epf_test_dma_callback(void *param)
 {
 	struct pci_epf_test *epf_test =3D param;
-
-	complete(&epf_test->transfer_complete);
+	struct dma_tx_state state;
+
+	epf_test->transfer_status =3D
+		dmaengine_tx_status(epf_test->transfer_chan,
+				    epf_test->transfer_cookie, &state);
+	if (epf_test->transfer_status =3D=3D DMA_COMPLETE ||
+	    epf_test->transfer_status =3D=3D DMA_ERROR)
+		complete(&epf_test->transfer_complete);
 }
=20
 /**
@@ -120,7 +129,6 @@ static int pci_epf_test_data_transfer(struct pci_epf_=
test *epf_test,
 	struct dma_async_tx_descriptor *tx;
 	struct dma_slave_config sconf =3D {};
 	struct device *dev =3D &epf->dev;
-	dma_cookie_t cookie;
 	int ret;
=20
 	if (IS_ERR_OR_NULL(chan)) {
@@ -151,26 +159,36 @@ static int pci_epf_test_data_transfer(struct pci_ep=
f_test *epf_test,
 		return -EIO;
 	}
=20
+	reinit_completion(&epf_test->transfer_complete);
+	epf_test->transfer_chan =3D chan;
 	tx->callback =3D pci_epf_test_dma_callback;
 	tx->callback_param =3D epf_test;
-	cookie =3D tx->tx_submit(tx);
-	reinit_completion(&epf_test->transfer_complete);
+	epf_test->transfer_cookie =3D dmaengine_submit(tx);
=20
-	ret =3D dma_submit_error(cookie);
+	ret =3D dma_submit_error(epf_test->transfer_cookie);
 	if (ret) {
-		dev_err(dev, "Failed to do DMA tx_submit %d\n", cookie);
-		return -EIO;
+		dev_err(dev, "Failed to do DMA tx_submit %d\n", ret);
+		goto terminate;
 	}
=20
 	dma_async_issue_pending(chan);
 	ret =3D wait_for_completion_interruptible(&epf_test->transfer_complete)=
;
 	if (ret < 0) {
-		dmaengine_terminate_sync(chan);
-		dev_err(dev, "DMA wait_for_completion_timeout\n");
-		return -ETIMEDOUT;
+		dev_err(dev, "DMA wait_for_completion interrupted\n");
+		goto terminate;
 	}
=20
-	return 0;
+	if (epf_test->transfer_status =3D=3D DMA_ERROR) {
+		dev_err(dev, "DMA transfer failed\n");
+		ret =3D -EIO;
+	}
+
+	WARN_ON(epf_test->transfer_status !=3D DMA_COMPLETE);
+
+terminate:
+	dmaengine_terminate_sync(chan);
+
+	return ret;
 }
=20
 struct epf_dma_filter {
--=20
2.39.1

