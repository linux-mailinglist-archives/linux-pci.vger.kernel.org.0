Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB6A6CFF31
	for <lists+linux-pci@lfdr.de>; Thu, 30 Mar 2023 10:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjC3IyM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Mar 2023 04:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC3IyK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Mar 2023 04:54:10 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979056A6A
        for <linux-pci@vger.kernel.org>; Thu, 30 Mar 2023 01:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680166449; x=1711702449;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+HydAFEgNOgg0eVz7b8c5RJLJ0jDAA9i/cU2toh3C2E=;
  b=Jm/Gb74e1W+Y0unq3UGB3mCE/XUWIyVJqHFE3WbJmUGQXMH5iAOmrlYx
   xJ4T1VXLlaozENMzN7v9QpO+j3IMO3WKTro9Uf61LeaXQYnOT/pl5euim
   v0hqcNyvI8oIn29LtuzbGKLw/+Dra9v9+mxEqX8pFkbyIdHvuRl+z4NfV
   K5l9CjCKkHb2CMuSijMkXr9CMBYLWQa2bIrJq062NAgc9oaSg8e9dWkXZ
   U8BTedrpGKhPi5cbe6c1e5uoNIOGCI8dAXRVzRxcrLS+B1pSaAWV5JfIU
   vcXoLOAHZ6ARQtVYgY4XD3zO7/7ZStrnlNuG6bNufGri0YmUxs7K3Kc7v
   g==;
X-IronPort-AV: E=Sophos;i="5.98,303,1673884800"; 
   d="scan'208";a="331310432"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 16:54:08 +0800
IronPort-SDR: KdBkAYwfq4WSYrVA4pEALcDQXOTKbV3I6dhksSuaQjcQHPngEsVB0l9w/CXeZWZvUgqWm4KUJy
 IYe6rhvBpDTJ0uB0dtAfRW6mP6GKpOqgUWxnBTMPNSNWL68cXBah8KZwhxSuoekycJUoGSyxaM
 tfmfT+18fbhytZc8w1nnrhte6d19WXmGf2D5OFCqd6BxVc7b17hdBOKwx8PuCz9yaVWRf2frY9
 PnKBx72GkuuIBmyxgI++xzD1AW3Yv20PQfE3Vcmrp6sgQL3hT9xlFyxVNXFjfBdamq6VkOJefM
 JNs=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 01:10:17 -0700
IronPort-SDR: Azr5VUi8ZrxLyUsyuSG0aCSo55NsPBnFpLlUIQdCpFytHfWC0TsSOP5fT2tYdxhhoqZip17P6/
 pRJZKXjcttFu70m+uUfuWa/AcAeGmC0fnh5zRIeafas98ONqhsKZzoKWZNh7BcoFXNBKRHteQ1
 CoRVEeQ5hgWvyriotQl3xXwiNU0EUCbSZu/D8f4t2POhE1ci9AQ5xPYzb65ypilNZftGo8Pr7w
 O530UtoTa0IE8ILEPSpiWbHShBrtILrwf6wJeeqOg0Rhn2Ok2T0NyF6hDF4cLptaKQKSDYnFXY
 oew=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 01:54:09 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PnHKD3q6tz1RtVp
        for <linux-pci@vger.kernel.org>; Thu, 30 Mar 2023 01:54:08 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1680166447; x=1682758448; bh=+HydAFEgNOgg0eVz7b
        8c5RJLJ0jDAA9i/cU2toh3C2E=; b=qJqb4vinKufLfO70wsGT7rPSuFVTempvQz
        iXZwZJ0rOLmR33WdSt+JE6W2gOdmsz0zoMpTkjAg0krspVol3gOAasXuI+5G//Gy
        z2q4/zrAd6dEeKg7jjgcL/dNdSvmCciHqPf5xcb2FqK2yMncRqgWx4tC3QBbXg57
        138zSA+71C6JcC9lgdZsJoxEaoxTG/CmeO8VKQ/UHE1sE2I4VZ2MGV+OIUO1PIW1
        a/WQeTiRojcVo/kHNAlbuXlxXi362tfHFNvHP5OjuyWGG7Fkzd9BVfSUlkpfETCu
        Uk75XASHuk6nGrDhm9brUDdtZtwHPbVK8GG9VLoK6a97qkSmIavQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xFAIRifsGjmD for <linux-pci@vger.kernel.org>;
        Thu, 30 Mar 2023 01:54:07 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PnHKB2yhpz1RtVm;
        Thu, 30 Mar 2023 01:54:06 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v4 04/17] PCI: epf-test: Fix DMA transfer completion detection
Date:   Thu, 30 Mar 2023 17:53:44 +0900
Message-Id: <20230330085357.2653599-5-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330085357.2653599-1-damien.lemoal@opensource.wdc.com>
References: <20230330085357.2653599-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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

Fixes: 8353813c88ef ("PCI: endpoint: Enable DMA tests for endpoints with =
DMA capabilities")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 38 +++++++++++++------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/=
endpoint/functions/pci-epf-test.c
index d65419735d2e..dbea6eb0dee7 100644
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
@@ -152,25 +160,33 @@ static int pci_epf_test_data_transfer(struct pci_ep=
f_test *epf_test,
 	}
=20
 	reinit_completion(&epf_test->transfer_complete);
+	epf_test->transfer_chan =3D chan;
 	tx->callback =3D pci_epf_test_dma_callback;
 	tx->callback_param =3D epf_test;
-	cookie =3D tx->tx_submit(tx);
+	epf_test->transfer_cookie =3D tx->tx_submit(tx);
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
+terminate:
+	dmaengine_terminate_sync(chan);
+
+	return ret;
 }
=20
 struct epf_dma_filter {
--=20
2.39.2

