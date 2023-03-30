Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C806CFF3F
	for <lists+linux-pci@lfdr.de>; Thu, 30 Mar 2023 10:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjC3Iyh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Mar 2023 04:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjC3Iyc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Mar 2023 04:54:32 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768DD7D80
        for <linux-pci@vger.kernel.org>; Thu, 30 Mar 2023 01:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680166465; x=1711702465;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sbB+rxwdLquQhlGuPLL4KXBL+q5ejPkT0n+IOvq5fEk=;
  b=NwV2laRpUYUGAHNe5mzrELSgDKt3cKx5WogRCYaRgYpRt1F8qfGi8RNT
   wwnW+CPyFJXcKTlZ5iISPIpNXSuGPfQCAMm52L5/R5s5inG2qeh+pQ5oT
   XDLztg1YYAWGVLBOuWOC+jdMoPieUEn8ksiCaz+uQY3KHLvzPqzwAW0ZG
   LVhY/FS9XDo0Ig7jTibNIQb+h7K6c62Jtt2hc51AfSi19jjBU0w2XC72P
   ezWEovWP3FVwARnKhSm+3LW03DDq2WCZ+71CZDPbvswJusYwJ005/BWHO
   Tza5FOSYPPfLrSefRC9ND+V9CyxmjvfqtcYrCp9vcZ+Ys7dV1q5OQ0jLI
   A==;
X-IronPort-AV: E=Sophos;i="5.98,303,1673884800"; 
   d="scan'208";a="331310487"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 16:54:25 +0800
IronPort-SDR: Ee+DnCWwFeyw4CSvDMaJ3gfsXmrrKuOStw1wZljxEMAhJCtau1h3sEkB9isycKTbEBcxt2jQO1
 qV8FbfBmXo9KBSvWGz/Cq61Ly3LU5HG+6kxs0xbZX43oRWu5OuAAXwGZFhgpnB1Vf/NLzl6eKd
 djzVq1GW6bTwl2FiiwqpmjDAVtZyDum9gAk8E0FKfTY/tlTIfIjiVHVom4ilMnMDK0dN+fXE/Y
 4ZsRqSa96UxMwZdqT297FQZ74p1SdOXAzYpV/rso3GrQvptfp4gdvfw/00uFxO0TSJ52ndpSbQ
 IVs=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 01:10:33 -0700
IronPort-SDR: gONSR/quxq9vvzzTK1KHLjB1tIpPeW7orzZ5nRUktB0uyN4T3yKHk6boFFDuOxqI4JpATRdN+7
 lvUXHkBMyDTPm4e/AXL/0xisUq115glDEsPNfylbD2N/m1XiICglC06TkLF1QF2dZMdrs7xgHe
 NXp4bpvHxUdVENxD6S9oC0XFSRMF3A2R2O0/zE+PT9gcui6U/OXg1AI4ym8SA/7+gTcHkfcPHl
 N0Nr8s64Kdw08srKB/qjQYA9CTxdMyTJ3tp9YqF7ifZiqA3CEcOPztXSVcHPcJrRGHhsEhZUv/
 Y20=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 01:54:25 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PnHKX72khz1RtW2
        for <linux-pci@vger.kernel.org>; Thu, 30 Mar 2023 01:54:24 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1680166464; x=1682758465; bh=sbB+rxwdLquQhlGuPL
        L4KXBL+q5ejPkT0n+IOvq5fEk=; b=LzB6kiiuRnnIn99IzZH40dW3v+14TJZj7X
        ggZOJC0EMit1TTWhLy7Ak9EZPZxzqCPukPyzHS8QYE8I9s00M7GUyQzVFpKTUxXm
        +SlIP+oy3ngrPkb5jY7aFkpCL8x+4zWKzwMpChb7ye7vqSsxfE0g/KtOVdAW6ctW
        /Em41MzBQYKsq6IJs80nt09ct8xRniF8r7fnx4rTL1ZMVi4FiMyQ8idgYqNIEIJq
        uINk2LR2kVXMkKtzoOpFlVZ/XJLS/gVL4B5SdhrqrE5N73Y/bauHMnGCM9eZTw6o
        K39/dyRlUYMmiNLQQe+pH5liB1uBmlOSPYWYuzyOEgF97clxTHgQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ez-PUIe-KobK for <linux-pci@vger.kernel.org>;
        Thu, 30 Mar 2023 01:54:24 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PnHKV4Sxqz1RtVm;
        Thu, 30 Mar 2023 01:54:22 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v4 13/17] PCI: epf-test: Simplify transfers result print
Date:   Thu, 30 Mar 2023 17:53:53 +0900
Message-Id: <20230330085357.2653599-14-damien.lemoal@opensource.wdc.com>
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

In pci_epf_test_print_rate(), instead of open coding a reduction loop to
allow for a division by a 32-bits ns value, simply use div64_u64() to
calculate the transfer rate. To match the printed unit of KB/s, this
calculation divides the rate by 1000 instead of 1024 (that would be
KiB/s unit).

The format of the results printed by pci_epf_test_print_rate() is also
changed to be more compact without the double new line. dev_info() is
used instead of pr_info().

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 39 +++++++------------
 1 file changed, 14 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/=
endpoint/functions/pci-epf-test.c
index b6398b8ba5ed..bfab5f246e5b 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -295,34 +295,23 @@ static void pci_epf_test_clean_dma_chan(struct pci_=
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
 static void pci_epf_test_copy(struct pci_epf_test *epf_test,
@@ -397,7 +386,7 @@ static void pci_epf_test_copy(struct pci_epf_test *ep=
f_test,
 		kfree(buf);
 	}
 	ktime_get_ts64(&end);
-	pci_epf_test_print_rate("COPY", reg->size, &start, &end,
+	pci_epf_test_print_rate(epf_test, "COPY", reg->size, &start, &end,
 				reg->flags & FLAG_USE_DMA);
=20
 err_map_addr:
@@ -481,7 +470,7 @@ static void pci_epf_test_read(struct pci_epf_test *ep=
f_test,
 		ktime_get_ts64(&end);
 	}
=20
-	pci_epf_test_print_rate("READ", reg->size, &start, &end,
+	pci_epf_test_print_rate(epf_test, "READ", reg->size, &start, &end,
 				reg->flags & FLAG_USE_DMA);
=20
 	crc32 =3D crc32_le(~0, buf, reg->size);
@@ -570,7 +559,7 @@ static void pci_epf_test_write(struct pci_epf_test *e=
pf_test,
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

