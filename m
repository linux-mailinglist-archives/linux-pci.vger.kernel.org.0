Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCD76974D3
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 04:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbjBODWP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 22:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbjBODWM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 22:22:12 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1DA3344C
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 19:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676431328; x=1707967328;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g2jL7drT0Rd/3YHYSO/OIKxRb2xaVI6wTuLxf3tSNSA=;
  b=qrVI24fGYfhwQpWP7zqSdrk/YKcC4llMS9IIBYy2Z8skWurbmRwyUplb
   emlijrOWypatqr8xrFo+ZTVYlhL4+a5F/E4b469BkdaEAFJc/xiG5SZh3
   5uNkvAXkAQ/RuqAaA2nUXDVpBJjSRCiPYfBpGX0Z00IQoLJZj3Yvnv10W
   mt3fzUxiJyommMdDi00B+JaJuLdhnmOQTzof7QleSOF1GjBhazyIJdoer
   e6yiHhJNfFLkii4lVd1dR5VFiNcjxp3eqUmp2kKxyW6Zv+mZPsgQW8ZQl
   fPoD/XPWeIcvNQ6P/8X5mlKquP9JrIc3AdAE+FkGih3J0cP2C4m/jJA4l
   w==;
X-IronPort-AV: E=Sophos;i="5.97,298,1669046400"; 
   d="scan'208";a="223351454"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2023 11:22:08 +0800
IronPort-SDR: HjbATAQgcRiFNFOGP1gRH4wNvh+79rJKk3eTW5jKPp9sN7AWgHVWW/Z3BL+ytOdKVUodVLCEzx
 cSBr9uo3A8LKqduTN9krXYqUvqUOsojrXnvxXvsIZ++cJVPuuZ7fLk/B0eJAssEoStf8gvO8IR
 PTgR7Mtv4yzyH9RRS5P3Xehe+xvLY0nsliWe41BEI8LT9bHlzfw5hiyrw4tMLRJCHSbG6RkCOj
 nBMedd6OyFRejq4Ba1iFEfX8uQIeFHrxIHQdSCrx0ZI5QtBj+M2bD6nk2Ux0E+XIRuS86kspLf
 ueg=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2023 18:33:31 -0800
IronPort-SDR: pW3PQrgv3mp5fuDbpEsKPtlIb9YYNNj3MFU+zy4LOMEaZ+djMEzNsW3AS9gqPkWGD3DJeqTs84
 MxB3oVsDbjxHmiIpZd0OAXNVHrNhQ5KZOD76vJEvOj42oxdaSXY0opgUl3ckEL2HsRkMVAHXZP
 OWwslJ/erillNktbdWvorSXePtZVuEmbZOQ6CZVXvr4IFhzoqR1pJ0ulugz+00aIn5yGkMzJJK
 e7J4EH1cm9nGDTlFJDEa8TRfXUJ/Ci3N5wAGOdHbFqA5W8QyKLOR3xD0dslHJ9Zh6tAbRM1gv/
 bbI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2023 19:22:08 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PGk005hkSz1RvTr
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 19:22:08 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1676431327; x=1679023328; bh=g2jL7drT0Rd/3YHYSO
        /OIKxRb2xaVI6wTuLxf3tSNSA=; b=P5VgxkoUw92pCyPvsZDv8icWswFeprezUB
        PvqIIeXPhR0XQQpA95phJppcy2ZCrbxqtdl53plSrRne06XRxRdzoYTA1bXXnrZu
        AdY7Ng6V9rGqT9JAr13u+eQvRVp/nrVdXIoLtnz0L0D0kgiUm+ujU9gWqL5KmADv
        pT0RCVyYONKPXTtJjGIt5RwEM7PaVOnbwrRwuNunh83IWkaHqtMD0ZJWo+XqXWOs
        H5XK8x0cI01BFYloq2vu9q9hDGvqAmNz2bRXqfIynS4XFG46+xId+dxZnrJdtTSn
        zPu+KvBzIIVzxsB75OpOTDbNYsPT7KX38FZ27cj24Z/7hmFerCTw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6qVGL_-qYt-0 for <linux-pci@vger.kernel.org>;
        Tue, 14 Feb 2023 19:22:07 -0800 (PST)
Received: from fedora.flets-east.jp (unknown [10.225.163.119])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PGjzy2vgLz1RvTp;
        Tue, 14 Feb 2023 19:22:06 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 05/12] pci: epf-test: Simplify dma support checks
Date:   Wed, 15 Feb 2023 12:21:48 +0900
Message-Id: <20230215032155.74993-6-damien.lemoal@opensource.wdc.com>
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

There is no need to have each read, write and copy test functions check
for the FLAG_USE_DMA flag against the dma support status indicated by
epf_test->dma_supported. Move this test to the command handler function
pci_epf_test_cmd_handler() to check once for all cases. The functions
pci_epf_test_write(), pci_epf_test_read() and pci_epf_test_copy() are
modified to add the use_dma boolean argument to indicate if transfers
should be done using DMA or mmio accesses.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 43 ++++++-------------
 1 file changed, 13 insertions(+), 30 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/=
endpoint/functions/pci-epf-test.c
index df3074667bbc..e07868c99531 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -327,10 +327,9 @@ static void pci_epf_test_print_rate(const char *ops,=
 u64 size,
 		(u64)ts.tv_sec, (u32)ts.tv_nsec, rate / 1024);
 }
=20
-static int pci_epf_test_copy(struct pci_epf_test *epf_test)
+static int pci_epf_test_copy(struct pci_epf_test *epf_test, bool use_dma=
)
 {
 	int ret;
-	bool use_dma;
 	void __iomem *src_addr;
 	void __iomem *dst_addr;
 	phys_addr_t src_phys_addr;
@@ -375,14 +374,7 @@ static int pci_epf_test_copy(struct pci_epf_test *ep=
f_test)
 	}
=20
 	ktime_get_ts64(&start);
-	use_dma =3D !!(reg->flags & FLAG_USE_DMA);
 	if (use_dma) {
-		if (!epf_test->dma_supported) {
-			dev_err(dev, "Cannot transfer data using DMA\n");
-			ret =3D -EINVAL;
-			goto err_map_addr;
-		}
-
 		if (epf_test->dma_private) {
 			dev_err(dev, "Cannot transfer data using DMA\n");
 			ret =3D -EINVAL;
@@ -426,13 +418,12 @@ static int pci_epf_test_copy(struct pci_epf_test *e=
pf_test)
 	return ret;
 }
=20
-static int pci_epf_test_read(struct pci_epf_test *epf_test)
+static int pci_epf_test_read(struct pci_epf_test *epf_test, bool use_dma=
)
 {
 	int ret;
 	void __iomem *src_addr;
 	void *buf;
 	u32 crc32;
-	bool use_dma;
 	phys_addr_t phys_addr;
 	phys_addr_t dst_phys_addr;
 	struct timespec64 start, end;
@@ -465,14 +456,7 @@ static int pci_epf_test_read(struct pci_epf_test *ep=
f_test)
 		goto err_map_addr;
 	}
=20
-	use_dma =3D !!(reg->flags & FLAG_USE_DMA);
 	if (use_dma) {
-		if (!epf_test->dma_supported) {
-			dev_err(dev, "Cannot transfer data using DMA\n");
-			ret =3D -EINVAL;
-			goto err_dma_map;
-		}
-
 		dst_phys_addr =3D dma_map_single(dma_dev, buf, reg->size,
 					       DMA_FROM_DEVICE);
 		if (dma_mapping_error(dma_dev, dst_phys_addr)) {
@@ -516,12 +500,11 @@ static int pci_epf_test_read(struct pci_epf_test *e=
pf_test)
 	return ret;
 }
=20
-static int pci_epf_test_write(struct pci_epf_test *epf_test)
+static int pci_epf_test_write(struct pci_epf_test *epf_test, bool use_dm=
a)
 {
 	int ret;
 	void __iomem *dst_addr;
 	void *buf;
-	bool use_dma;
 	phys_addr_t phys_addr;
 	phys_addr_t src_phys_addr;
 	struct timespec64 start, end;
@@ -557,14 +540,7 @@ static int pci_epf_test_write(struct pci_epf_test *e=
pf_test)
 	get_random_bytes(buf, reg->size);
 	reg->checksum =3D crc32_le(~0, buf, reg->size);
=20
-	use_dma =3D !!(reg->flags & FLAG_USE_DMA);
 	if (use_dma) {
-		if (!epf_test->dma_supported) {
-			dev_err(dev, "Cannot transfer data using DMA\n");
-			ret =3D -EINVAL;
-			goto err_dma_map;
-		}
-
 		src_phys_addr =3D dma_map_single(dma_dev, buf, reg->size,
 					       DMA_TO_DEVICE);
 		if (dma_mapping_error(dma_dev, src_phys_addr)) {
@@ -647,6 +623,7 @@ static void pci_epf_test_cmd_handler(struct work_stru=
ct *work)
 	int ret;
 	int count;
 	u32 command;
+	bool use_dma;
 	struct pci_epf_test *epf_test =3D container_of(work, struct pci_epf_tes=
t,
 						     cmd_handler.work);
 	struct pci_epf *epf =3D epf_test->epf;
@@ -662,6 +639,12 @@ static void pci_epf_test_cmd_handler(struct work_str=
uct *work)
 	reg->command =3D 0;
 	reg->status =3D 0;
=20
+	use_dma =3D reg->flags & FLAG_USE_DMA;
+	if (use_dma && !epf_test->dma_supported) {
+		dev_err(dev, "Cannot transfer data using DMA\n");
+		goto reset_handler;
+	}
+
 	if (reg->irq_type > IRQ_TYPE_MSIX) {
 		dev_err(dev, "Failed to detect IRQ type\n");
 		goto reset_handler;
@@ -675,7 +658,7 @@ static void pci_epf_test_cmd_handler(struct work_stru=
ct *work)
 	}
=20
 	if (command & COMMAND_WRITE) {
-		ret =3D pci_epf_test_write(epf_test);
+		ret =3D pci_epf_test_write(epf_test, use_dma);
 		if (ret)
 			reg->status |=3D STATUS_WRITE_FAIL;
 		else
@@ -686,7 +669,7 @@ static void pci_epf_test_cmd_handler(struct work_stru=
ct *work)
 	}
=20
 	if (command & COMMAND_READ) {
-		ret =3D pci_epf_test_read(epf_test);
+		ret =3D pci_epf_test_read(epf_test, use_dma);
 		if (!ret)
 			reg->status |=3D STATUS_READ_SUCCESS;
 		else
@@ -697,7 +680,7 @@ static void pci_epf_test_cmd_handler(struct work_stru=
ct *work)
 	}
=20
 	if (command & COMMAND_COPY) {
-		ret =3D pci_epf_test_copy(epf_test);
+		ret =3D pci_epf_test_copy(epf_test, use_dma);
 		if (!ret)
 			reg->status |=3D STATUS_COPY_SUCCESS;
 		else
--=20
2.39.1

