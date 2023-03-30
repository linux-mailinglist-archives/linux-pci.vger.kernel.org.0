Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06976CFF3D
	for <lists+linux-pci@lfdr.de>; Thu, 30 Mar 2023 10:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjC3Iyf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Mar 2023 04:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjC3Iyb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Mar 2023 04:54:31 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050377EC3
        for <linux-pci@vger.kernel.org>; Thu, 30 Mar 2023 01:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680166463; x=1711702463;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HpHoCX+FLiV3OKsXvxlbDREwVOxEqmIg95XgCiUrpLE=;
  b=QlTfhe2IILrJU8Xgam7IVORB5yIfGoNosydHKcjjzr2d+iZreRpPxqPl
   HO/HlqTY4A/lVBA0/3VpRXcFdEtGpHaCCEyJhc391xobwwSTt7YysHc3e
   eGw9zcoyb6O2NeAmEReQkupjtzcPq4IwgqAnBAyAa+Hre7mhHOZ3C18mf
   Cm3V/NybriJ9LNsXa4BDQ0yVvRkloqyv7ZCjQKntp45UCa3JJ5WKvfPP/
   6ARdjOshfIyegyPA1vThNl1WiklkQOb3CBLxKWA8dTx/lhuu4B5+wJHrK
   ZOoRB0xgKIG1BvH+67S/543kbpAUi8Qc/eC0OmS7jOrHSXd+/HF/T2oVU
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,303,1673884800"; 
   d="scan'208";a="331310481"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 16:54:23 +0800
IronPort-SDR: Pj5jWpkGIptI3aQ+Z+HNz1KphkPbtPKE1A8C5Y+cR4ihVXd9wNoKGYmowQpu5U5t9qO6ZGMv/d
 En8oGjrM86o6a3cJtUvQxa4xaKD/zr+NAlUxc1Bxd1ULKNDRbTpC2UIwK6JPdGK8jcJ0aNEa69
 iNtTW3EZdDiouHU4Rvz3czYuA8PDWnk0B54nF0i3DW7OuTuduh33Kcy8PvyWvTv9HuYjdLSfFT
 UThzTwf8FbqNlzLNIjeS3bktRk/bnfh0GRJVRHKmM6jKaEVTUS16IE9f+Nw72feD6y6ECZflGP
 fpU=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 01:10:31 -0700
IronPort-SDR: w6t36u8LQITYBhlF8aH5V5JmC5zX32BsyYm2dEho1/MR4f16LX0pa1P3R2airc5JInHQKE3ukF
 n9dmkP8auxTDweRHbSB7MEKuOIgbxs2WwXEX6UnOHAHZhwvEYrEzeDE08e/WoVtb/vw7CtEGtR
 ldaPHWhY9ijKLePfLeVaPCV9W94IcFMUj5FjEsA+qjj2MqcvWrSEgDYwsbAvTpf3Dr3XED/c7x
 LwNId4vResShUbTm3A0N/mKC9msQfMfgBCtzftMiJPhVGYWtU8/MfhzoK5om6jLvjLEEGTA5Hu
 CIM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 01:54:24 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PnHKW2VZ0z1RtVx
        for <linux-pci@vger.kernel.org>; Thu, 30 Mar 2023 01:54:23 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1680166462; x=1682758463; bh=HpHoCX+FLiV3OKsXvx
        lbDREwVOxEqmIg95XgCiUrpLE=; b=WIt0KMs3TjoW+iso1kJWYf1/n/cyuM7sCs
        e3+briDxf0dX3oTDTvSY+f4yrvCG4xLALbKxieqYNgXzl9jXbxBkFjYCbyyN/OcQ
        m6PyrAkA1UlwC0mS+xO56rIqjOBA+BRMKUmW9FN8YKBMeknws/0mzuxxwKXg1O84
        NzC/uVJdKhGqAQ+U2yJlkFIkoFmqXsTpTBL5pXj0H228SykZLjGFuFKkHLgNW5gE
        rmutF96Khv63W9Guk6e5+grP8Xn5XSjfh5qs+qJc3nDQZEQuEFp6vq3rkTK29TyL
        WwnJO5qH+IuJRUv3f5/hLgybt1g2ep9K6ZWeuE6fbsjOBIuE2pOA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vUKGSHLlv3Kk for <linux-pci@vger.kernel.org>;
        Thu, 30 Mar 2023 01:54:22 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PnHKS6F0Wz1RtVn;
        Thu, 30 Mar 2023 01:54:20 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v4 12/17] PCI: epf-test: Simplify DMA support checks
Date:   Thu, 30 Mar 2023 17:53:52 +0900
Message-Id: <20230330085357.2653599-13-damien.lemoal@opensource.wdc.com>
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
index 35bdb03f6ee1..b6398b8ba5ed 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -329,7 +329,6 @@ static void pci_epf_test_copy(struct pci_epf_test *ep=
f_test,
 			      struct pci_epf_test_reg *reg)
 {
 	int ret;
-	bool use_dma;
 	void __iomem *src_addr;
 	void __iomem *dst_addr;
 	phys_addr_t src_phys_addr;
@@ -372,14 +371,7 @@ static void pci_epf_test_copy(struct pci_epf_test *e=
pf_test,
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
@@ -405,7 +397,8 @@ static void pci_epf_test_copy(struct pci_epf_test *ep=
f_test,
 		kfree(buf);
 	}
 	ktime_get_ts64(&end);
-	pci_epf_test_print_rate("COPY", reg->size, &start, &end, use_dma);
+	pci_epf_test_print_rate("COPY", reg->size, &start, &end,
+				reg->flags & FLAG_USE_DMA);
=20
 err_map_addr:
 	pci_epc_unmap_addr(epc, epf->func_no, epf->vfunc_no, dst_phys_addr);
@@ -433,7 +426,6 @@ static void pci_epf_test_read(struct pci_epf_test *ep=
f_test,
 	void __iomem *src_addr;
 	void *buf;
 	u32 crc32;
-	bool use_dma;
 	phys_addr_t phys_addr;
 	phys_addr_t dst_phys_addr;
 	struct timespec64 start, end;
@@ -464,14 +456,7 @@ static void pci_epf_test_read(struct pci_epf_test *e=
pf_test,
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
@@ -496,7 +481,8 @@ static void pci_epf_test_read(struct pci_epf_test *ep=
f_test,
 		ktime_get_ts64(&end);
 	}
=20
-	pci_epf_test_print_rate("READ", reg->size, &start, &end, use_dma);
+	pci_epf_test_print_rate("READ", reg->size, &start, &end,
+				reg->flags & FLAG_USE_DMA);
=20
 	crc32 =3D crc32_le(~0, buf, reg->size);
 	if (crc32 !=3D reg->checksum)
@@ -524,7 +510,6 @@ static void pci_epf_test_write(struct pci_epf_test *e=
pf_test,
 	int ret;
 	void __iomem *dst_addr;
 	void *buf;
-	bool use_dma;
 	phys_addr_t phys_addr;
 	phys_addr_t src_phys_addr;
 	struct timespec64 start, end;
@@ -558,14 +543,7 @@ static void pci_epf_test_write(struct pci_epf_test *=
epf_test,
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
@@ -592,7 +570,8 @@ static void pci_epf_test_write(struct pci_epf_test *e=
pf_test,
 		ktime_get_ts64(&end);
 	}
=20
-	pci_epf_test_print_rate("WRITE", reg->size, &start, &end, use_dma);
+	pci_epf_test_print_rate("WRITE", reg->size, &start, &end,
+				reg->flags & FLAG_USE_DMA);
=20
 	/*
 	 * wait 1ms inorder for the write to complete. Without this delay L3
@@ -679,6 +658,12 @@ static void pci_epf_test_cmd_handler(struct work_str=
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

