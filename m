Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015BC6C8BFB
	for <lists+linux-pci@lfdr.de>; Sat, 25 Mar 2023 08:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjCYHCl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Mar 2023 03:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjCYHCk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Mar 2023 03:02:40 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCB01714F
        for <linux-pci@vger.kernel.org>; Sat, 25 Mar 2023 00:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679727758; x=1711263758;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+HydAFEgNOgg0eVz7b8c5RJLJ0jDAA9i/cU2toh3C2E=;
  b=YPoF/7/SeXBQPAmTOd2rBjKl5v5M7ojFbXFVg/bHeZ+oe2SWDhMWuWjo
   ohwyhanr9Q0KaxESwMkfKJZOQK2MmB2VE6SEDOHg8IXzDzQOP2DGuIqD4
   kKx5aGPRnp9h4MVeapy2luUno9KDyB/Ts7kADv+5kMkg9zh+mhKMyUsVo
   hANRpFd06dsCDkQPka9Pbt5L4eCVwbt1f/CsGGli3bYCD2cbMqy9mCDPz
   6U4JjtHpXwQ8bHCwCDt5vOUeUt2MOYEzRJGPKEJ6oluSbB1vCy2hAl+fG
   XEOPL7uq97M18pPjIIUvNe0KA0lf3QKQd9h4GwBc4EH4pfmAoKccN4gda
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,289,1673884800"; 
   d="scan'208";a="224756720"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2023 15:02:38 +0800
IronPort-SDR: IKkSbYJGxB2aVcXKeVvQcdDRnxRE2u14MmkHsBA0ibjUkxGC8bT51IsHVviG73c1oziyZvhPUE
 vIHv23UIU54zC9xVnFRcB/hXzs1ifX0yLHm9Nn0SU+h5VeT5g/Fi5QDp35TKr8H+YC8vD1xpEm
 HiW3IV3UWh530gB3vB7pzl+YBLQ5iIMdwVxLc4z+kyO4tddcYKFMynNFjrOSuuB20Ti2MfsVAu
 tZ6l2zK2eD3HMhgMi6eZllxRhARiozGvQj17sb3d+uxjZ2swF0XGBdMZvcIs7DuJj9hMVLd+Eb
 ArU=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Mar 2023 23:18:53 -0700
IronPort-SDR: P6FwWbHsisEm0Du2o4FrtpRuYsZp0jAOruveJJjXefMMPVrwpae8ao0yMaZRr6YDaj5SzTlMsF
 JTqBbkZO2rrGSFRUZlnjVHOeaZIeC1yBqqE8vQ5EkMnSYc95dvnOn26C3fNxIwDGCA4BghPfkj
 ctm7WrGgh/7xRv837FFQ2MWva26QQL1tkntEzLgaiOtvT22B4ohiaK5gJ8dV9oczGSUuQJGtuu
 gN4IauzBexP3WZBGl1VadtNV+tbqroiHkAgK7XmXsIRl9HeE4S5ne1YfyEma2tLGufvuWpDOiH
 Pwk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Mar 2023 00:02:39 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pk94t0gZLz1RtVy
        for <linux-pci@vger.kernel.org>; Sat, 25 Mar 2023 00:02:38 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1679727757; x=1682319758; bh=+HydAFEgNOgg0eVz7b
        8c5RJLJ0jDAA9i/cU2toh3C2E=; b=qSRQ5HsTrUIp6DsbwcWn7mV7suWRexZkch
        QFqi7/jySg4kWZaBufB749K7upS4QcKBr/6zXwWPjzyomNqgqFvWhfj2wrCBYddc
        z3VYpGmLtLZkIELLXn+bosAD9jP1HQhoiX0P8alszPNigx5iu4G3qNX89Ce1CWN7
        0RgkZG6cxgue7eunDDxzh4U5KigBZCRSrPrCKioox08TwdrjTUe4AX4LOBc8MOze
        RuE95Hl1geZPNp/Zwp77s6ytnpPWHo/KLwX0L7mvF+ReAGS0ONyVEK5HdxGa8YWG
        K60c4kt1Jy09uVdLWZr/oUYANxubaQUfntWwsnOTsyhND6Z1bO3Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5co-RQh3-Y5Q for <linux-pci@vger.kernel.org>;
        Sat, 25 Mar 2023 00:02:37 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pk94q5HdXz1RtVm;
        Sat, 25 Mar 2023 00:02:35 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 04/16] PCI: epf-test: Fix DMA transfer completion detection
Date:   Sat, 25 Mar 2023 16:02:14 +0900
Message-Id: <20230325070226.511323-5-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230325070226.511323-1-damien.lemoal@opensource.wdc.com>
References: <20230325070226.511323-1-damien.lemoal@opensource.wdc.com>
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

