Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BA66974D4
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 04:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjBODWT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 22:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjBODWN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 22:22:13 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9E13345A
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 19:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676431330; x=1707967330;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=miWCyUP1x/mMlv5q6IoApDuVbCCiPqu3nFRQhVuY9xY=;
  b=IFsVOAYkUpbRcaZNF8W+qCkLbkks2GaTT6ABsKWxWTEt2e5/SbpR+kZj
   mJEU36vnfxlydZMJwKwsXCI15zohJyT7m65O4tJN2xT97FF0HsQhNgXW5
   JTAIstu1Yan6N4T3MwP8NQeL0orw+Uf2/y5tGLuwgmQre12oMS65kBSqq
   68H0tgxZJmI78A7B1JYCEYsZj3oUuwMhm4idfisGC1waG173n2fEN/FEH
   WPIcgXE5ES9NW72JLw0ScE1Hr7Vr6HNt3AtA1zl+vW614RrHZ6sD960oH
   65zaAFT3MlfTbub2Z01jlGG9tSkFlU2O/+IdTuIJsrMGVAMtkqqF/vBLr
   g==;
X-IronPort-AV: E=Sophos;i="5.97,298,1669046400"; 
   d="scan'208";a="223351456"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2023 11:22:10 +0800
IronPort-SDR: Jzmu4uR0IQK7woyVxwMzwllX7uDFmN61IE1SZooP1AyHs2iNW3cU6schudm+m9D8/MePSHm7vk
 34zPQdO2BVfLtTYf/0/kpXvj/cr0jiwO7LkgOebQZV4Y2pk32d7bugWeRXwu1t4RIPYDHFL7Pv
 O2SvHlIrFIYQGrU6aYg3+Z68oxep/E4UimWPPyzs5GhzmnJJBP+z2TnOqzSEMhpNkbHAmHWnD5
 bODRJFKdiGi0rOco2W+liyjDedIOr/ySfBVfZVoaCsDne4JnZ3mgKWAQCDiMDjypHZPzpX907t
 3og=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2023 18:33:33 -0800
IronPort-SDR: 7kVAIXhBk0XrAiIgQoFb0uAJNrjIB+i3PZFDTgJdMbgma4Bnyaj1MEbc6IleUHY2vG4Yw8uv2L
 Ssetv85o1onAB7eE/Wr6bUSdgaWkcgUnMGm77iLMZeZOh1WvhfLHA1gvZIUpdB0qswb5/A1vFg
 c4u2pNS32vlgXcFrWYLj75U4VP8MLbAprh1yuzwE/FC4uYmaVf2KhOIJ7aTpjPh7cAi9azzppS
 9J0J+XvoQSKbyyowPVDAmMDHurTKBormSIC64VetuGgtGkbU+xJ8XCWiA6hDutcjTGmx0h2ny2
 AXc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2023 19:22:10 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PGk025kQ2z1RwtC
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 19:22:10 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1676431329; x=1679023330; bh=miWCyUP1x/mMlv5q6I
        oApDuVbCCiPqu3nFRQhVuY9xY=; b=gqG6g/4Rm+tJbzm6gWiBgjcpkdrRrUEzy+
        Ganvm03ErSipIWd9VLmAcO9kfGzhTX7nMeDrm9TM/gKK1WEVvba1NWkZkfTU07Rp
        1YZ9YwAAqA8Xy8MCkKCKkQN4VLEXfnYzU9169N8/cK2zx7KtOsXj1kFhvg1TlUm9
        4qIoutlHOc7B7d8lgbHQCSdFzpPCc/NSFnqns9yooEfRRBCjFLJAkRfGsWo+aUtA
        j6ngHfddYSvFU1YhRDbuykw1Rich/l40qCualQuGUvLI53BrtDe7f+vMf3TP6QYg
        ADSaI5vKwZ4bHKib5DGHfjoDJjIntNKGlArnVoE4WuJthpeYFZbw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zOzdwdsGQTg7 for <linux-pci@vger.kernel.org>;
        Tue, 14 Feb 2023 19:22:09 -0800 (PST)
Received: from fedora.flets-east.jp (unknown [10.225.163.119])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PGk00244Kz1RvLy;
        Tue, 14 Feb 2023 19:22:07 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 06/12] pci: epf-test: Simplify transfers result print
Date:   Wed, 15 Feb 2023 12:21:49 +0900
Message-Id: <20230215032155.74993-7-damien.lemoal@opensource.wdc.com>
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

In pci_epf_test_print_rate(), instead of open coding a reduction loop to
allow for a disivision by a 32-bits ns value, simply use div64_u64() to
calculate the rate. To match the printed unit of KB/s, this calculation
divides the rate by 1000 instead of 1024 (that would be KiB/s unit).

The format of the results printed by pci_epf_test_print_rate() is also
changed to be more compact without the double new line. dev_info() is
used instead of pr_info().

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 42 ++++++++-----------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/=
endpoint/functions/pci-epf-test.c
index e07868c99531..f630393e8208 100644
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
 static int pci_epf_test_copy(struct pci_epf_test *epf_test, bool use_dma=
)
@@ -400,7 +389,8 @@ static int pci_epf_test_copy(struct pci_epf_test *epf=
_test, bool use_dma)
 		kfree(buf);
 	}
 	ktime_get_ts64(&end);
-	pci_epf_test_print_rate("COPY", reg->size, &start, &end, use_dma);
+	pci_epf_test_print_rate(epf_test, "COPY", reg->size, &start, &end,
+				use_dma);
=20
 err_map_addr:
 	pci_epc_unmap_addr(epc, epf->func_no, epf->vfunc_no, dst_phys_addr);
@@ -481,7 +471,8 @@ static int pci_epf_test_read(struct pci_epf_test *epf=
_test, bool use_dma)
 		ktime_get_ts64(&end);
 	}
=20
-	pci_epf_test_print_rate("READ", reg->size, &start, &end, use_dma);
+	pci_epf_test_print_rate(epf_test, "READ", reg->size, &start, &end,
+				use_dma);
=20
 	crc32 =3D crc32_le(~0, buf, reg->size);
 	if (crc32 !=3D reg->checksum)
@@ -567,7 +558,8 @@ static int pci_epf_test_write(struct pci_epf_test *ep=
f_test, bool use_dma)
 		ktime_get_ts64(&end);
 	}
=20
-	pci_epf_test_print_rate("WRITE", reg->size, &start, &end, use_dma);
+	pci_epf_test_print_rate(epf_test, "WRITE", reg->size, &start, &end,
+				use_dma);
=20
 	/*
 	 * wait 1ms inorder for the write to complete. Without this delay L3
--=20
2.39.1

