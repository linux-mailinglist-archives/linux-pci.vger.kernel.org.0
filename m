Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5246C8C03
	for <lists+linux-pci@lfdr.de>; Sat, 25 Mar 2023 08:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjCYHC5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Mar 2023 03:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjCYHCz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Mar 2023 03:02:55 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B1F15882
        for <linux-pci@vger.kernel.org>; Sat, 25 Mar 2023 00:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679727773; x=1711263773;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f6vOJtQ60F3eVOPUSRn4w9ivZnAhueTWkWhHYuFb/Io=;
  b=DAlqeOzY+QHw+CClor5YzHU6yoPCOcMv7bBYbgHrR7oHXh1LuZBVVcR4
   GtzyYoNUZQeKJ4fCdIZG7MihkFB8jq7NM8QPXWIOQDuswr8jsSy/WO3Rj
   vohvoxm2uDhl+RM3kQ8opI+iguI93Hq8TqbfDdayiBR5CeKrkzkVH8mK7
   WwqlY2G8xLGDZA+EZCUkNZ2HHfoaiV7AZtaXmGK/E9PGt30nnZ3bg9jye
   Vwc3JDS3Gn0QkFqP6tg0fia5Wj7QAjED2/wLEesitz+fWIFljdvgEADtH
   tRoYOxbhki3yV+T2rJfofQs6sRhJ+w1s1ESX8GCa3iQMPoUYEZ1S+8r4S
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,289,1673884800"; 
   d="scan'208";a="224756910"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2023 15:02:53 +0800
IronPort-SDR: CKaDzh/thx61V8nVdG3+8I1pyjR4KXN3xlJZqZ2WI19phzJmo+IG6QDN75XCIuFvQjx5uNGQXM
 egQlFUY48ZvVlRHianV5dIiN5jJ/fmYWHdR0qEkmJY9/Evkp4j7hhLmCMlmZZlgih+naMTz3X8
 nCs4XzIVKw4/BLAyjSHFdgiRVoucFpL8YNunnBilgODQfSIZRsvLeRoV6YUmfIS9AmFMg3GSdL
 8PQtVH3SsvqwM5oPa7tfBtULHsNksUw2aTZDeFQkdENjkUIOnScG8ZFAD3GnS9FvB6uX1dqHBo
 EhQ=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Mar 2023 23:19:07 -0700
IronPort-SDR: jWqexu0nYpScKtEcFPI+IVQ9e1Dj9zM0vV9Cp33IC2kHmubvyzSwHiNNq59ctjLuYilpmMpWog
 ZSI3KrdLv+0mm7OL51wopB++b5xN3Q5pCEQOsjDi4qQN3FUD688QdAi5tiNtr3co8wSViYZnzv
 ap/MEDRWFQGkqnDd9rpmUpm7A8NawPRCJOh4XDy4ONocX3eOtIM/+Kswpn+MpHrPJ11NXG2hid
 UePYFZagaTI0Z3JgbnqLBnhuNGPqxxOkbq34xajtEepNlh4ni+2fqu8QmM4rNy2EUVw6ECSO3y
 eEo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Mar 2023 00:02:54 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pk95902Mgz1RtVp
        for <linux-pci@vger.kernel.org>; Sat, 25 Mar 2023 00:02:52 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1679727771; x=1682319772; bh=f6vOJtQ60F3eVOPUSR
        n4w9ivZnAhueTWkWhHYuFb/Io=; b=Fyk1GC7t1d/x6SyTg9DPvxsRrFNU6NCPhO
        JmBSzuEPrSlygYdi0qdAMdQm2dKjF4aG1WyfuyY2ACyliVmhCQJSLtWR3mIf1vTp
        jf6ktvybY8fp/JIBdTqp1leYQQ6v2JG1J+pZh0Y2Ph+ILjErEPxMulM9R1NCSwqx
        oXK955jha1Iur/7Z3Fa2DNc5PORY1nkPedLklyQCTdAfVZtVqgbu9nyARGYoHPDR
        kYXgv+wfFvP1pW2HOg5mEJ4gtWyNQ1CF6NjvIKo1jAG37ZBCx8jkeLZMQnZf+FrU
        cNrjy+4uqaVpLdPHIj46BMwIbt1OvRN370dMLp9RURbgqfbW9AxA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id N-pv8Y4LQr57 for <linux-pci@vger.kernel.org>;
        Sat, 25 Mar 2023 00:02:51 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pk9562cvFz1RtVm;
        Sat, 25 Mar 2023 00:02:50 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 12/16] PCI: epf-test: Simplify transfers result print
Date:   Sat, 25 Mar 2023 16:02:22 +0900
Message-Id: <20230325070226.511323-13-damien.lemoal@opensource.wdc.com>
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
index abc50d5bff97..7250219af853 100644
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
 static int pci_epf_test_copy(struct pci_epf_test *epf_test,
@@ -397,7 +386,7 @@ static int pci_epf_test_copy(struct pci_epf_test *epf=
_test,
 		kfree(buf);
 	}
 	ktime_get_ts64(&end);
-	pci_epf_test_print_rate("COPY", reg->size, &start, &end,
+	pci_epf_test_print_rate(epf_test, "COPY", reg->size, &start, &end,
 				reg->flags & FLAG_USE_DMA);
=20
 err_map_addr:
@@ -478,7 +467,7 @@ static int pci_epf_test_read(struct pci_epf_test *epf=
_test,
 		ktime_get_ts64(&end);
 	}
=20
-	pci_epf_test_print_rate("READ", reg->size, &start, &end,
+	pci_epf_test_print_rate(epf_test, "READ", reg->size, &start, &end,
 				reg->flags & FLAG_USE_DMA);
=20
 	crc32 =3D crc32_le(~0, buf, reg->size);
@@ -564,7 +553,7 @@ static int pci_epf_test_write(struct pci_epf_test *ep=
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

