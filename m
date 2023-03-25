Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E45C6C8BFC
	for <lists+linux-pci@lfdr.de>; Sat, 25 Mar 2023 08:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbjCYHCn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Mar 2023 03:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjCYHCm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Mar 2023 03:02:42 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD8618B07
        for <linux-pci@vger.kernel.org>; Sat, 25 Mar 2023 00:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679727760; x=1711263760;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s337vsR4bX90nEJfYlGg1DUOEOdyobGliyQs10wRS+U=;
  b=XAGxImA+l7PUJg90vL6uDLRDGIEIo89n6Cp15lecQFaT0ecNr0nkVKGT
   LfUml0qQN2m9C5sEp+kXN5/HfZ7OHF3FWm7adLttNeErPIs87xmcZnrc6
   1z4ECTW/pwVC+G2/aGCBVYK0+V9D1Pdksuz4Uy2a5J/GmyAS+ILXc+lwn
   QwVCGeBPQWWKuqTUk1Ht3LB6qciH7/D63KU0Kfn7l0xKIcW22mBMkZCeF
   3ytRet6EEVOPLL1PdrEPo3RZYzGk+zZvTwX0TptUCL+M3WbHKlXaIQ9X8
   PcTeOHeymMLsnIWETaZZP2ki2qgvToRiwhokOZI90plUVc5pahLQCbVxj
   A==;
X-IronPort-AV: E=Sophos;i="5.98,289,1673884800"; 
   d="scan'208";a="224756738"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2023 15:02:39 +0800
IronPort-SDR: A7lQxxa2UiHe85lnp6i1j/fMxMBMieQZMGffaE3h2hMKvtJ2RVFF2sLTeufs2jSo+93m3oZmRs
 tVDGC5PHBkkRnEYocyv7TMOEsYTrqLV0KrF7l/QCgDLczq21Oiriv+es8pYU/f4r/jKUtIsZ4Y
 Wubp0Jn0+7kXvX+Nu+6Twux3V1hfqJiv0iu3E1pFdGH+M7+VTDwkINU3svi75xKSjBK2uYM8dg
 uYlpslBcGnN7NH2XUONZ0cIug6CXWzgEmq/IQPqiO9BPrQdDVXa3SB7BLN6ILWvxKTxgGIshG8
 gAY=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Mar 2023 23:18:54 -0700
IronPort-SDR: gqvuuWtgiWf1CXuNvAWZg6KLTKazb1v9tQ3zaQkKOb03VfHVfKPoRRGaV9H2CqoVrVQfdK6AxD
 GOsIp9+NzYrQrFIWXpuo0en5DaCHTfeN4zhmQj/XkBZdR0w0asH5nrrB6zXUIrjIcQstorNUri
 QoNX7FxcfmdIrgFtUxlyQyxSCsrs5RK784X7C85RyJ8Ayp0XbUTaQmE2s9aYlHKH8cNGKqFRGt
 9btXwRmINTslZtHwdVZadb+bHJaZjw2i4TwlKxELNToVIys5U52d2zE0srT3DRuY/7QDo/tgDz
 qjM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Mar 2023 00:02:40 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pk94v4xlmz1RtW0
        for <linux-pci@vger.kernel.org>; Sat, 25 Mar 2023 00:02:39 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1679727759; x=1682319760; bh=s337vsR4bX90nEJfYl
        Gg1DUOEOdyobGliyQs10wRS+U=; b=BMUp3NVobPt2vrxBYV3658GiNlJ5Hoc7xN
        7YYCncVG2OV1lJqxTVjGrVxI1MyUSmM7clKU4L+o5JNARrClnXytf1/5AHyH5sMe
        kPlIpe9/XxDR8P0ydgWSu65fcOYCxsOA3ZQpR4hnXzghzMeAPkOfUI4sKOrCCxel
        BGYZZZ+gbRx3dOlDU5IhPEjW2S0DU3sEl12exlKhyrkqy1ARvfL1m+U04UuGqab7
        YmreWGicywSPUDq0Jtjgk23pVfCWrEQgJ5wBsicGc37VYccI+L0NifUFkWKwHmKT
        m8km4EgXfKWzARrU1tofsG9UZc4UCD3XwSYiwTlrBJtTLXbmMEQA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jXVvpOipUhX9 for <linux-pci@vger.kernel.org>;
        Sat, 25 Mar 2023 00:02:39 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pk94s4TH5z1RtVn;
        Sat, 25 Mar 2023 00:02:37 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 05/16] PCI: epf-test: Use dmaengine_submit() to initiate DMA transfer
Date:   Sat, 25 Mar 2023 16:02:15 +0900
Message-Id: <20230325070226.511323-6-damien.lemoal@opensource.wdc.com>
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

