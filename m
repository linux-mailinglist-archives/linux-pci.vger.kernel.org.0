Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3F46CFF32
	for <lists+linux-pci@lfdr.de>; Thu, 30 Mar 2023 10:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjC3IyN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Mar 2023 04:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjC3IyL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Mar 2023 04:54:11 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58817AAB
        for <linux-pci@vger.kernel.org>; Thu, 30 Mar 2023 01:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680166450; x=1711702450;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s337vsR4bX90nEJfYlGg1DUOEOdyobGliyQs10wRS+U=;
  b=SQhWO00x2VhDVFeplirBcTUyQBITiehvwvXsNvX9t0rq5OR+r1lDfnYI
   QU/0OOwEbuD8FrjZy3PPryGBQ+p+mNsy9eRLHlXinsGfZW1cz/Ho/nW2w
   DQd/BN03elOMT3pXW7zG4IQZUkWgsrqv7JisTdg2d0zUH7/wN98XbPtrA
   PEeR6TpDA0OuBQVp6ROrjvSwD2OEjT2hPAIPRphgnsRW1NBk0kO9vvEI7
   Nvzi+E2/Y7lE6xfLjZ6DoHDp9x7Bg4AXPG+CDhyRGs7b7JWHnXnd/kdGn
   qFrYnc4SJg0J2Bpz9Lbxmzwlp0543xXzyA2pEUZOMDWx6TS1ZSHGV2pUK
   A==;
X-IronPort-AV: E=Sophos;i="5.98,303,1673884800"; 
   d="scan'208";a="331310440"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 16:54:10 +0800
IronPort-SDR: TZWLR2PfjoGZTub6sHvPSgO1JoUVVmsYqPb+lCoIgEk8x0t3pX2qqKsSRhFWTVoNYO1X72nLhp
 q2tVQm7TK6Dlil2kzjvCHvqO9bq8h8vYC9wyzNif1/zpwr/88Rp/XXzZQR3aDGGvOUHu6528Dv
 0sOXPsy8noKSI3M5drjYuL/lMnr9uzzOYLnJkvWtSqU7FfSFnDuECe4qqJgvnSKH0Pn6lo8A0a
 jcKmVt+8UlEOpQJ1g7cxZfSeyjhpXQXoe8Djp+Ae4lcCJAhhytP1m/97oOkD09+PB/s+Z8IM4d
 dKU=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 01:10:18 -0700
IronPort-SDR: Cgr8/3QmxSzjw0ZfDoLfdoFnWvRIiGUItyuLjgqSDTKFfg07cV4b7Wq0oO0jsWHKLbjYQ6GZ30
 viWnYNDy7SGOFK+ra77Or2KQeHuMUSFQS+K75IZ1DRlxnwAchv/RcaaL3B3umAcGWMKwig7ORb
 4hkMT3FcnFTeqG6ZDENMk5UOJGGwvjYL7IV1qKQD2Rckja0aA2lR0sRrkQH0F8bZYSZlLwFzQW
 0lYASok3oN5Q6SYo2N/fLmTH65U/FOGbDwwWwwlSlw1Azf2Coba3/SHYerZYKoYWue6ld2EaQf
 9Io=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 01:54:10 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PnHKG0mzrz1RtVx
        for <linux-pci@vger.kernel.org>; Thu, 30 Mar 2023 01:54:10 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1680166449; x=1682758450; bh=s337vsR4bX90nEJfYl
        Gg1DUOEOdyobGliyQs10wRS+U=; b=lGqTFYFaA5yaIOCmLP7bJcrlZW9N16FdXb
        fhgJSX23Ka7cvusJ1LmUqrhgJzG4V9Wqskrx5hDNnxfZhr4gxcfYk2tu2rJOYrFC
        bd97Mr7xfHFY2+BdrgdnRYyxGQd1XcL1m21GPUy5W57/WYx9C5GHs2bhTxPUI+Md
        L45pL6RloBXCWCleY/MbRNJdb5m0lZVkbIpNT/ib4hDmQqorRbiZuoffIO+MRmSu
        TGptQ6vXmQn31NkuNX59ySh0HkMp1ia460TQWFGp+6IyYF8fEBawS0DcHh26ZZop
        R7C9SX21dW6ZEhQaJwJxzVKorgL/Rmg2Mqsh9dhL6d6fHU4lGeNA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sMvp8qFiqRqk for <linux-pci@vger.kernel.org>;
        Thu, 30 Mar 2023 01:54:09 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PnHKD0vFfz1RtVn;
        Thu, 30 Mar 2023 01:54:07 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v4 05/17] PCI: epf-test: Use dmaengine_submit() to initiate DMA transfer
Date:   Thu, 30 Mar 2023 17:53:45 +0900
Message-Id: <20230330085357.2653599-6-damien.lemoal@opensource.wdc.com>
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

Instead of an open coded call to the tx_submit() operation of struct
dma_async_tx_descriptor, use the helper function dmaengine_submit().
No functional change is introduced with this.

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/=
endpoint/functions/pci-epf-test.c
index dbea6eb0dee7..7cdc6c915ef5 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -163,7 +163,7 @@ static int pci_epf_test_data_transfer(struct pci_epf_=
test *epf_test,
 	epf_test->transfer_chan =3D chan;
 	tx->callback =3D pci_epf_test_dma_callback;
 	tx->callback_param =3D epf_test;
-	epf_test->transfer_cookie =3D tx->tx_submit(tx);
+	epf_test->transfer_cookie =3D dmaengine_submit(tx);
=20
 	ret =3D dma_submit_error(epf_test->transfer_cookie);
 	if (ret) {
--=20
2.39.2

