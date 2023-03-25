Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9186C8C02
	for <lists+linux-pci@lfdr.de>; Sat, 25 Mar 2023 08:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbjCYHC4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Mar 2023 03:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjCYHCy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Mar 2023 03:02:54 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC7715CA6
        for <linux-pci@vger.kernel.org>; Sat, 25 Mar 2023 00:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679727771; x=1711263771;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sBuTYkv/S3ZLZG82d1SOcoTgDB/NCZvWuNNGG6u/bhE=;
  b=qIWDpik28/5Rg2TZ8p/N/YaORkygDzvFo/ud9BLSb7V0cQBrWKiMvvE1
   ud2UaMFhSb9qiHK32q/HZQppIBmS7h9BckFgxC82ynockCQClH4lYQjbk
   PwAbr803PE5N/D/PayfmITyLq07LRyAPqvCRFPpJ3f1PknAMKi1vnO6Tc
   j7dOYjNuoKvzwJeUGfGFXCCU2YJIMHgHuJWzjOLaV1pAIU0n0xWoykJWt
   xDI8HwK62715L4qvQ4lTmPkOlWNL7EuOsWnzc8EsZelEBXondX3SmyZ0L
   CPL71w2iWnuALnByhiNWK5XSczFdwb/TDU0d8sWguL0N/4V0QOKRKNiVz
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,289,1673884800"; 
   d="scan'208";a="224756901"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2023 15:02:51 +0800
IronPort-SDR: lzGhswX5Ie/mPJAzJbYaD0mwhhvgJlspSrdpRVRhEcnhGnpVIhhFctISILOGSXsVixYJ4Y0tDL
 BeZ/DDS5Lemmt5Bml0elt3/oVVN4dgSoDmXz9FlNk5KuVd5j5u9QAKorURSXBPpOIp0Ct65zqP
 R3ZD1mzxu+51tTbJD0TM7azNk/SaciYMKBjern75BYymJMBz248QTz4CPOiaaaVZ/kvYEiW0Eb
 jDB3P8c0PfSXOIeKphYYcwyMfiBvjcGzGfZ/3pQP8bK7VHU68vZWUq69tk8K/VUZd5iU5xlQjT
 juU=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Mar 2023 23:19:06 -0700
IronPort-SDR: MBN/bOV20uxPZOnwqg/JFBhJdgUTxDDK22Xr5dq1ybGTkt/j7O/NjlN1RD+kG7yxdpftu/hpZa
 fh8wR1VubD5h2shvYejnXCSsnSadQHJf2U5ZbLjwRPOu6AQQTfylRRwoxyLr1NwK20dHO5XS6m
 OGRMAqQJr5VQ6WVig5jaPtSogNA1wk8W6Iby8yoyg9NsAnOWiORcaQYT5QSlwxPZ0WfArZ2NoV
 lo1Vp7TgBcSs0Iz7IGCftHehHm4O5VmBSy1OK76UgfDlXr3ApheKONVMxn7942tyQf+b7CBmBj
 m3w=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Mar 2023 00:02:52 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pk9566d1Fz1RtVw
        for <linux-pci@vger.kernel.org>; Sat, 25 Mar 2023 00:02:50 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1679727770; x=1682319771; bh=sBuTYkv/S3ZLZG82d1
        SOcoTgDB/NCZvWuNNGG6u/bhE=; b=sFaNCUeNT9Kd8T1C9hMxQsYVubOWNQPNh5
        ZGys35WNlFbQaKsky7ufQRVityOETbJpj2eJLjngCBHhQXUkqNh8rctluXxo2ujA
        CkNWdJMZ9qBLBJFcDBEhImn/iaAk5QiY7926le7YOFD/3Iuy12wNcvIJYoMF7pvX
        bCIt3PPxRhv8II2OPpvRnxzoRxQ0HXD/zNGrT/8riLXQWdcJtWrVW9nfgRHJaaym
        hzYNbwyROW8vEY+ws40a8Gz9WKRhuDmR6XDDbjBOJZAyiXlBVXVFGZqc3gypiWyl
        VcjneMyDp6lg1Bqft4KoQAt3JXJb7O9NJx7fZSMeGbrtCzjZkuaQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XoQjKVIxyzCd for <linux-pci@vger.kernel.org>;
        Sat, 25 Mar 2023 00:02:50 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pk954469hz1RtVp;
        Sat, 25 Mar 2023 00:02:48 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 11/16] PCI: epf-test: Simplify dma support checks
Date:   Sat, 25 Mar 2023 16:02:21 +0900
Message-Id: <20230325070226.511323-12-damien.lemoal@opensource.wdc.com>
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

There is no need to have each read, write and copy test functions check
for the FLAG_USE_DMA flag against the dma support status indicated by
epf_test->dma_supported. Move this test to the command handler function
pci_epf_test_cmd_handler() to check once for all cases.

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 45 +++++++------------
 1 file changed, 15 insertions(+), 30 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/=
endpoint/functions/pci-epf-test.c
index c2a14f828bdf..abc50d5bff97 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -329,7 +329,6 @@ static int pci_epf_test_copy(struct pci_epf_test *epf=
_test,
 			     struct pci_epf_test_reg *reg)
 {
 	int ret;
-	bool use_dma;
 	void __iomem *src_addr;
 	void __iomem *dst_addr;
 	phys_addr_t src_phys_addr;
@@ -372,14 +371,7 @@ static int pci_epf_test_copy(struct pci_epf_test *ep=
f_test,
 	}
=20
 	ktime_get_ts64(&start);
-	use_dma =3D !!(reg->flags & FLAG_USE_DMA);
-	if (use_dma) {
-		if (!epf_test->dma_supported) {
-			dev_err(dev, "Cannot transfer data using DMA\n");
-			ret =3D -EINVAL;
-			goto err_map_addr;
-		}
-
+	if (reg->flags & FLAG_USE_DMA) {
 		if (epf_test->dma_private) {
 			dev_err(dev, "Cannot transfer data using DMA\n");
 			ret =3D -EINVAL;
@@ -405,7 +397,8 @@ static int pci_epf_test_copy(struct pci_epf_test *epf=
_test,
 		kfree(buf);
 	}
 	ktime_get_ts64(&end);
-	pci_epf_test_print_rate("COPY", reg->size, &start, &end, use_dma);
+	pci_epf_test_print_rate("COPY", reg->size, &start, &end,
+				reg->flags & FLAG_USE_DMA);
=20
 err_map_addr:
 	pci_epc_unmap_addr(epc, epf->func_no, epf->vfunc_no, dst_phys_addr);
@@ -430,7 +423,6 @@ static int pci_epf_test_read(struct pci_epf_test *epf=
_test,
 	void __iomem *src_addr;
 	void *buf;
 	u32 crc32;
-	bool use_dma;
 	phys_addr_t phys_addr;
 	phys_addr_t dst_phys_addr;
 	struct timespec64 start, end;
@@ -461,14 +453,7 @@ static int pci_epf_test_read(struct pci_epf_test *ep=
f_test,
 		goto err_map_addr;
 	}
=20
-	use_dma =3D !!(reg->flags & FLAG_USE_DMA);
-	if (use_dma) {
-		if (!epf_test->dma_supported) {
-			dev_err(dev, "Cannot transfer data using DMA\n");
-			ret =3D -EINVAL;
-			goto err_dma_map;
-		}
-
+	if (reg->flags & FLAG_USE_DMA) {
 		dst_phys_addr =3D dma_map_single(dma_dev, buf, reg->size,
 					       DMA_FROM_DEVICE);
 		if (dma_mapping_error(dma_dev, dst_phys_addr)) {
@@ -493,7 +478,8 @@ static int pci_epf_test_read(struct pci_epf_test *epf=
_test,
 		ktime_get_ts64(&end);
 	}
=20
-	pci_epf_test_print_rate("READ", reg->size, &start, &end, use_dma);
+	pci_epf_test_print_rate("READ", reg->size, &start, &end,
+				reg->flags & FLAG_USE_DMA);
=20
 	crc32 =3D crc32_le(~0, buf, reg->size);
 	if (crc32 !=3D reg->checksum)
@@ -518,7 +504,6 @@ static int pci_epf_test_write(struct pci_epf_test *ep=
f_test,
 	int ret;
 	void __iomem *dst_addr;
 	void *buf;
-	bool use_dma;
 	phys_addr_t phys_addr;
 	phys_addr_t src_phys_addr;
 	struct timespec64 start, end;
@@ -552,14 +537,7 @@ static int pci_epf_test_write(struct pci_epf_test *e=
pf_test,
 	get_random_bytes(buf, reg->size);
 	reg->checksum =3D crc32_le(~0, buf, reg->size);
=20
-	use_dma =3D !!(reg->flags & FLAG_USE_DMA);
-	if (use_dma) {
-		if (!epf_test->dma_supported) {
-			dev_err(dev, "Cannot transfer data using DMA\n");
-			ret =3D -EINVAL;
-			goto err_dma_map;
-		}
-
+	if (reg->flags & FLAG_USE_DMA) {
 		src_phys_addr =3D dma_map_single(dma_dev, buf, reg->size,
 					       DMA_TO_DEVICE);
 		if (dma_mapping_error(dma_dev, src_phys_addr)) {
@@ -586,7 +564,8 @@ static int pci_epf_test_write(struct pci_epf_test *ep=
f_test,
 		ktime_get_ts64(&end);
 	}
=20
-	pci_epf_test_print_rate("WRITE", reg->size, &start, &end, use_dma);
+	pci_epf_test_print_rate("WRITE", reg->size, &start, &end,
+				reg->flags & FLAG_USE_DMA);
=20
 	/*
 	 * wait 1ms inorder for the write to complete. Without this delay L3
@@ -671,6 +650,12 @@ static void pci_epf_test_cmd_handler(struct work_str=
uct *work)
 	WRITE_ONCE(reg->command, 0);
 	WRITE_ONCE(reg->status, 0);
=20
+	if ((READ_ONCE(reg->flags) & FLAG_USE_DMA) &&
+	    !epf_test->dma_supported) {
+		dev_err(dev, "Cannot transfer data using DMA\n");
+		goto reset_handler;
+	}
+
 	if (reg->irq_type > IRQ_TYPE_MSIX) {
 		dev_err(dev, "Failed to detect IRQ type\n");
 		goto reset_handler;
--=20
2.39.2

