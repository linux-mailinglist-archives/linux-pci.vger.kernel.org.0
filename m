Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA046B0250
	for <lists+linux-pci@lfdr.de>; Wed,  8 Mar 2023 10:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjCHJFE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 04:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjCHJEh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 04:04:37 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B63FBBA6
        for <linux-pci@vger.kernel.org>; Wed,  8 Mar 2023 01:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678266273; x=1709802273;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RAJsnh9eMj1J3xd5auGSvxnCGfbqyyD8ow/+wuTkITM=;
  b=Nx0HM6C59v+CPYDH1PvAUGvpvho/BmyYl4xM0LJNZEAd/9LLE8vsCCQS
   ZC3HyzB6Wv/9zfLzs8O3fZY2aVzIOLSZWgiA9q1VldMcPmei8JaX+0lqo
   jqwBnhckPecFDVKdfA3f5HgGmrxA/8ZZT0hd6wvQPlbJ2cEfnqz2nItBr
   edEVZMnx58vyaKSnpjE/NnhhlZtwEKUq8wisO78fCRd1l/o0jEWSK+J6i
   BUjCMx9oupn2Dc7gxc2ct9aXyve6LKPADPeAQK4oQb5NhAJ6BtsVffXhU
   sdr+ORkjL6s+gZ+k79bptIYtc4I3HpTbDNQEFDWCYPg/Y5at4OvOCXst4
   w==;
X-IronPort-AV: E=Sophos;i="5.98,243,1673884800"; 
   d="scan'208";a="224880567"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Mar 2023 17:03:37 +0800
IronPort-SDR: 8oPLnCTIJYncq4QLBt6peOalE6Fol4BRmXIyxjO90+2Oi3dSfEGiIyMe7xF1uNkMAkH+Ugxcjg
 /Gh0m5M6gK6//D/TpYZOeu/3mMmnnvUMv9SKv4SI/ZKZTazapXQC7sK8yNvv0mOtt3K70yoVLm
 B8uQuG6lkb397+xz5EdEmmdcZzm+t48ZDSPGZepiR52m7ppFTWVYe8TO0F+Yn5qGaVR6W5QyyB
 mDG2IuhgE4xof0PfPYB33YG5FBs6I4wijpJ+SfRj+Pth7xL4vcXzZyYh0aEBwBF01jWq38kQ0k
 /fw=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Mar 2023 00:14:35 -0800
IronPort-SDR: m1Sb9YuEboVbWBaI3WbjETGf660jBQx9c/rQK1za4v+H0cJ4io8IYgiRlh2i9FYNUIm4fV9pOd
 HdcSv/vYP8sMLhVOPVp2rYE33Dx92iJTZWdw+gyaoGwLEKyUDeyR2KZ4TAm053CcBxGM4ldho+
 ZIkxSiArh89AdvMmiQDLRSJz80h51ULm6lDmKYIMbpaeipCQmCWtX3jD9qL/nowJA8DGVJa//5
 85+3Fm64LKKQmx/mndy2tWhUFVaVD6vZ1R96USY1XDLttsXEGswRyHwJTDnjdculXXH5xB5D6E
 zYU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Mar 2023 01:03:39 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PWmZK4Gncz1RwvT
        for <linux-pci@vger.kernel.org>; Wed,  8 Mar 2023 01:03:37 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1678266216; x=1680858217; bh=RAJsnh9eMj1J3xd5au
        GSvxnCGfbqyyD8ow/+wuTkITM=; b=SySrlM0ktmdVjV93HwqToEewWpSAgEyMe2
        J1TeQpIGNEa7sIgG8TcVqHZZrqDB/+SXDgotawK7K7QaUtBqAUNm4nv+PSyc2kX0
        WUuHvz0ZQpQuDy45HNyi3iLq3oxxncz2+ABnr4elqOzqkj3vX77gu/Avo4uuuiHw
        R/UZBwumF86AuufyE6qCVcb/9f1UX4Oxf68cKrvUNUv+vakoptMwstFZnp0GzB6M
        a4W8yaPhRJzEcjp0/I7vAsNscD5rOTp4+R0xDzy+pCD5wHC6vyHMhZwKY51olncL
        wMooCDNxzZ/XUsMHU6deaev5p/ZLViv8VJVtJwQgkcxRjtvd9Zqw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JiSncpuGOzRR for <linux-pci@vger.kernel.org>;
        Wed,  8 Mar 2023 01:03:36 -0800 (PST)
Received: from ephost.wdc.com (unknown [10.225.163.68])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PWmZH1mRjz1RvTp;
        Wed,  8 Mar 2023 01:03:34 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 11/16] PCI: epf-test: Simplify dma support checks
Date:   Wed,  8 Mar 2023 18:03:08 +0900
Message-Id: <20230308090313.1653-12-damien.lemoal@opensource.wdc.com>
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

There is no need to have each read, write and copy test functions check
for the FLAG_USE_DMA flag against the dma support status indicated by
epf_test->dma_supported. Move this test to the command handler function
pci_epf_test_cmd_handler() to check once for all cases.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 45 +++++++------------
 1 file changed, 15 insertions(+), 30 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/=
endpoint/functions/pci-epf-test.c
index d1b5441391fb..eaa252a170a2 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -331,7 +331,6 @@ static int pci_epf_test_copy(struct pci_epf_test *epf=
_test,
 			     struct pci_epf_test_reg *reg)
 {
 	int ret;
-	bool use_dma;
 	void __iomem *src_addr;
 	void __iomem *dst_addr;
 	phys_addr_t src_phys_addr;
@@ -374,14 +373,7 @@ static int pci_epf_test_copy(struct pci_epf_test *ep=
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
@@ -407,7 +399,8 @@ static int pci_epf_test_copy(struct pci_epf_test *epf=
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
@@ -432,7 +425,6 @@ static int pci_epf_test_read(struct pci_epf_test *epf=
_test,
 	void __iomem *src_addr;
 	void *buf;
 	u32 crc32;
-	bool use_dma;
 	phys_addr_t phys_addr;
 	phys_addr_t dst_phys_addr;
 	struct timespec64 start, end;
@@ -463,14 +455,7 @@ static int pci_epf_test_read(struct pci_epf_test *ep=
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
@@ -495,7 +480,8 @@ static int pci_epf_test_read(struct pci_epf_test *epf=
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
@@ -520,7 +506,6 @@ static int pci_epf_test_write(struct pci_epf_test *ep=
f_test,
 	int ret;
 	void __iomem *dst_addr;
 	void *buf;
-	bool use_dma;
 	phys_addr_t phys_addr;
 	phys_addr_t src_phys_addr;
 	struct timespec64 start, end;
@@ -554,14 +539,7 @@ static int pci_epf_test_write(struct pci_epf_test *e=
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
@@ -588,7 +566,8 @@ static int pci_epf_test_write(struct pci_epf_test *ep=
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
@@ -673,6 +652,12 @@ static void pci_epf_test_cmd_handler(struct work_str=
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

