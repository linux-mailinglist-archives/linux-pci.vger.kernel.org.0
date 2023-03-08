Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94F16B0251
	for <lists+linux-pci@lfdr.de>; Wed,  8 Mar 2023 10:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjCHJFF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 04:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjCHJEk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 04:04:40 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E878799D4B
        for <linux-pci@vger.kernel.org>; Wed,  8 Mar 2023 01:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678266275; x=1709802275;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1v6zSkVcces00UqmQZtB9XTYzrL0xxc030Wi2sVS0DQ=;
  b=f7kmSYs3ANLvF/NxbfPwXEPB67cuVNwdNBZ3ETcpSxTiS+LPI6MnEeWM
   5Xrkl97EemmxrTnwHpGhDyhUC9+4f+/F609nA6GWDB4bECv8RP/sZCjnM
   iHshqXSG0TCXuZJzwLK8WPirbyDHaqMoidVUJ02/ucK9wF2Ru0MXjzyWx
   svXEYVDCowdWpn5aYdIm0Yp5y+3cfMCpF3T5zoVIdrRQzbh9A99ZWx+fl
   Tjn1YrHxTRR9GV3d6TlwnHYswoFbjBsYsHSu0HidSJ6CtrYjLOlddeh89
   RWN6h4/hEwsTRmKvQ3dACKOgg2DyrAzQtFL9rDpEiSj1RJDFswsl7ptNz
   w==;
X-IronPort-AV: E=Sophos;i="5.98,243,1673884800"; 
   d="scan'208";a="224880571"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Mar 2023 17:03:39 +0800
IronPort-SDR: XU9Tjm0DJ6ccFjLULdd3hMW3DVZFseCSwMHkWJ/RYmqJSNfz+094ZiOoq40mdDUjoGldqGX8Eh
 EDthZZnVuaf1zE4ubTW/cTwHBr5c5hmboOQupQS8wGv0aEDyhz2/m8xDIwjCvZZMxfgiKTxcrh
 EYPXDW/PQ0dfJcFyXcvoTFPGF6M1XAp85qm1kEvXlr5HMqLTXdRH4tlMJmlHB08FKJfMS6YvAM
 3ducUdBYb4eiWLX5Vq/JrweS38aPjZQF0wCimBYFtAwqqJsaKFCbfn+g1y1WcGy2cs7qmd9/wE
 5Fk=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Mar 2023 00:14:37 -0800
IronPort-SDR: DYE7OnMNvGBQ7CGiJdOgDOS2Yblrx90xofcHKgS4II5OksWtBRoAE7QvWAaNGWFEIrQbblhJOM
 yAHCI3MKuawVFV4I83Hcq2KPCzlYPMMG/SPoLS71mMVMc58oH6WKw7hsc2rO8jnb4c9HSIXMCn
 5q+fEqYbHz9iPe+znz9hMQpSyM9rY3hQ3DaG6a3XkfERH2U/QatLJRIF7gX+WEUK1IGv22farM
 mRpgMtfSZQNqT9o4ozn3JxeiUu0oFqC+nLpNzO2ENUMhbPD7hVCLZwll+ko5s0daQmc4O1vtFO
 O/Q=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Mar 2023 01:03:41 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PWmZM39cdz1RwvL
        for <linux-pci@vger.kernel.org>; Wed,  8 Mar 2023 01:03:39 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1678266218; x=1680858219; bh=1v6zSkVcces00UqmQZ
        tB9XTYzrL0xxc030Wi2sVS0DQ=; b=FOixOZfTFZMWo7HFbErO5qghkz9rcNsyA9
        WehFef2oYnXRHak2aNImKSDhC5f3BX44m+RhB1Ou6oWiS9iow8qX2VNPtphBsgLc
        16Kw99Snlji3118wYj8DE46twa37okvuDBVV5fioGh8zW3dRLEexqzPPD5fkOB/C
        fvoSGZ9o5vIddnZkbP9eJbT2oX2lAZMhimR4Z+K2Av3mSvX8LeknXIjWfDJTlU3l
        bGQIhLWseujF/EsRFq9CbP8MB/rTIgfsIhfHB6/yl8dZmwImMglImJDVAJapAsP0
        zIx4lqTXWyLv7lCIxY6nRGHHtlpoR1RTqT7GV54cvW2su352BAhQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ksoNDZuMg8wR for <linux-pci@vger.kernel.org>;
        Wed,  8 Mar 2023 01:03:38 -0800 (PST)
Received: from ephost.wdc.com (unknown [10.225.163.68])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PWmZJ6tlFz1RvLy;
        Wed,  8 Mar 2023 01:03:36 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 12/16] PCI: epf-test: Simplify transfers result print
Date:   Wed,  8 Mar 2023 18:03:09 +0900
Message-Id: <20230308090313.1653-13-damien.lemoal@opensource.wdc.com>
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

In pci_epf_test_print_rate(), instead of open coding a reduction loop to
allow for a division by a 32-bits ns value, simply use div64_u64() to
calculate the transfer rate. To match the printed unit of KB/s, this
calculation divides the rate by 1000 instead of 1024 (that would be
KiB/s unit).

The format of the results printed by pci_epf_test_print_rate() is also
changed to be more compact without the double new line. dev_info() is
used instead of pr_info().

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 39 +++++++------------
 1 file changed, 14 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/=
endpoint/functions/pci-epf-test.c
index eaa252a170a2..9021c4acc743 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -297,34 +297,23 @@ static void pci_epf_test_clean_dma_chan(struct pci_=
epf_test *epf_test)
 	return;
 }
=20
-static void pci_epf_test_print_rate(const char *ops, u64 size,
+static void pci_epf_test_print_rate(struct pci_epf_test *epf_test,
+				    const char *op, u64 size,
 				    struct timespec64 *start,
 				    struct timespec64 *end, bool dma)
 {
-	struct timespec64 ts;
-	u64 rate, ns;
-
-	ts =3D timespec64_sub(*end, *start);
-
-	/* convert both size (stored in 'rate') and time in terms of 'ns' */
-	ns =3D timespec64_to_ns(&ts);
-	rate =3D size * NSEC_PER_SEC;
-
-	/* Divide both size (stored in 'rate') and ns by a common factor */
-	while (ns > UINT_MAX) {
-		rate >>=3D 1;
-		ns >>=3D 1;
-	}
-
-	if (!ns)
-		return;
+	struct timespec64 ts =3D timespec64_sub(*end, *start);
+	u64 rate =3D 0, ns;
=20
 	/* calculate the rate */
-	do_div(rate, (uint32_t)ns);
+	ns =3D timespec64_to_ns(&ts);
+	if (ns)
+		rate =3D div64_u64(size * NSEC_PER_SEC, ns * 1000);
=20
-	pr_info("\n%s =3D> Size: %llu bytes\t DMA: %s\t Time: %llu.%09u seconds=
\t"
-		"Rate: %llu KB/s\n", ops, size, dma ? "YES" : "NO",
-		(u64)ts.tv_sec, (u32)ts.tv_nsec, rate / 1024);
+	dev_info(&epf_test->epf->dev,
+		 "%s =3D> Size: %llu B, DMA: %s, Time: %llu.%09u s, Rate: %llu KB/s\n"=
,
+		 op, size, dma ? "YES" : "NO",
+		 (u64)ts.tv_sec, (u32)ts.tv_nsec, rate);
 }
=20
 static int pci_epf_test_copy(struct pci_epf_test *epf_test,
@@ -399,7 +388,7 @@ static int pci_epf_test_copy(struct pci_epf_test *epf=
_test,
 		kfree(buf);
 	}
 	ktime_get_ts64(&end);
-	pci_epf_test_print_rate("COPY", reg->size, &start, &end,
+	pci_epf_test_print_rate(epf_test, "COPY", reg->size, &start, &end,
 				reg->flags & FLAG_USE_DMA);
=20
 err_map_addr:
@@ -480,7 +469,7 @@ static int pci_epf_test_read(struct pci_epf_test *epf=
_test,
 		ktime_get_ts64(&end);
 	}
=20
-	pci_epf_test_print_rate("READ", reg->size, &start, &end,
+	pci_epf_test_print_rate(epf_test, "READ", reg->size, &start, &end,
 				reg->flags & FLAG_USE_DMA);
=20
 	crc32 =3D crc32_le(~0, buf, reg->size);
@@ -566,7 +555,7 @@ static int pci_epf_test_write(struct pci_epf_test *ep=
f_test,
 		ktime_get_ts64(&end);
 	}
=20
-	pci_epf_test_print_rate("WRITE", reg->size, &start, &end,
+	pci_epf_test_print_rate(epf_test, "WRITE", reg->size, &start, &end,
 				reg->flags & FLAG_USE_DMA);
=20
 	/*
--=20
2.39.2

