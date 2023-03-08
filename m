Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14A16B0248
	for <lists+linux-pci@lfdr.de>; Wed,  8 Mar 2023 10:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjCHJEd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 04:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjCHJE1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 04:04:27 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1E23B0E9
        for <linux-pci@vger.kernel.org>; Wed,  8 Mar 2023 01:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678266258; x=1709802258;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pgP6j3ThKHkldq+XHZBPzJ6mOm42AtjAZKYFIlZCE9A=;
  b=J8GY1q1tsG5yn3oKOGkT6UkmOxOQD610KZmie5z7vT0RrO7bcM3TMcwa
   7wrNdPRJa5/nNbmvwEz7O+DlnlscczsEfGnb9SG+vyqKoTfkecC7KsHOT
   nws6yQVcBRVvF3iWRArY3P7oczKnTJ7IM1zUqrfqvySyrRtdKdiPandSm
   WYYbRWNvXC/6zUTBgdKXl+f59syr1vS07/CnLoIMrLqP8xTRec0pPGIrR
   lZDAJksJzJ0NmdEVMfskZidpOWQHyrbYIQj7o/yzhXyvHo9M/zplzFzA3
   lbtz2mEqDc9MEF2VONewIwRQ5QbleM8ir1D4Fckv3pY9sywtwlqGd4IzL
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,243,1673884800"; 
   d="scan'208";a="224880546"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Mar 2023 17:03:24 +0800
IronPort-SDR: BwqgS020vtocrFfLC/a79P9J4zJ0cnyt0DrRwPKxJ8h5fvEP76Oa+qs+Rh55qHyYbvzdQujP2/
 OTVTQH60Ran5oqr6mK5dq6jOHOzuTgMcWp8BYXNlZqHjXIpOyYOJ9vtFCjt4ELPaXhkHMakV9e
 8IbXZNIeYPUnI/IqdmlLJXupUFVT1JOTKIpkqTnB/gAAAwzpq/miu+CW8U7UUeyGh/fwor/+uO
 RNnUpSBmQptVKtWlsWjsCci3JJumYR+K+CJeH7M4Ya0YTUHsavCYmVsrQwn7EbYvzCQ77spjys
 fTk=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Mar 2023 00:14:22 -0800
IronPort-SDR: LJk4S+PZTJ8pokWRz1wMfrTGLgWdo2BkZRCgpFzTXfhi0OLrXcL/UqQ9XOxN4LjttCt8HKDZBH
 QExkPwx3KzQhrbs7IhYndSBYSw56pQJ5s+V9hHVNmlAb5hr8ZfQE/7suN/6unETjSZUfkKBLt0
 ePRxdJXWcM6+ZTDgcD5kPB6lmyd7/+a7YQKyU28hJU+EZZJAFPuftComRRxRFV65vo4YApdhyx
 MDASmaoUjkWLySOVB2HsbBDefZWp85ITuDt/Wwb4CTr/0RNqCnR+AHCDTRijNOxeothZ3+KaI3
 tSU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Mar 2023 01:03:26 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PWmZ45XqHz1RwvT
        for <linux-pci@vger.kernel.org>; Wed,  8 Mar 2023 01:03:24 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1678266203; x=1680858204; bh=pgP6j3ThKHkldq+XHZ
        BPzJ6mOm42AtjAZKYFIlZCE9A=; b=OZcPfqD6otk00vf4bF3gaw9yUsOGIuJTJI
        l56PCnv1YjUpopmVr0CIyZdkU58r9xZhdoVxug5KCkZt8UEaWxhRcFVorM/HbPm5
        vU2JED00/5J2NYOju1mmQXanvItUdEWPLkngEqNn4em7OsVmAf6xi8E+q6TNxld0
        r6TIM+nuMWJLanNHNLueb6R0rFddLhBw65d2YGeatPbAV74+8QLZjxU/65azC928
        pbgNnxmWGobUW6u0IjMK896AXlCCK4Sj38gM5y/Zr8YDFY3798l7lqn/k1o7GZ8K
        iuxg5Vi5C/vo+7/eE+/NX636zTF9BZtE/mPPlDa523WuEP57rY3Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NLO9OmUV5oAi for <linux-pci@vger.kernel.org>;
        Wed,  8 Mar 2023 01:03:23 -0800 (PST)
Received: from ephost.wdc.com (unknown [10.225.163.68])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PWmZ235lVz1RvLy;
        Wed,  8 Mar 2023 01:03:22 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 04/16] PCI: epf-test: Fix DMA transfer completion detection
Date:   Wed,  8 Mar 2023 18:03:01 +0900
Message-Id: <20230308090313.1653-5-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308090313.1653-1-damien.lemoal@opensource.wdc.com>
References: <20230308090313.1653-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci_epf_test_data_transfer() and pci_epf_test_dma_callback() are not
handling DMA transfer completion correctly, leading to completion
notifications to the RP side that are too early. This problem can be
detected when the RP side is running an IOMMU with messages such as:

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
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 40 ++++++++++++++-----
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/=
endpoint/functions/pci-epf-test.c
index d65419735d2e..557fbb91c729 100644
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
@@ -152,25 +160,35 @@ static int pci_epf_test_data_transfer(struct pci_ep=
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
2.39.2

