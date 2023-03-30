Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2049E6CFF30
	for <lists+linux-pci@lfdr.de>; Thu, 30 Mar 2023 10:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjC3IyJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Mar 2023 04:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC3IyH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Mar 2023 04:54:07 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC02420F
        for <linux-pci@vger.kernel.org>; Thu, 30 Mar 2023 01:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680166447; x=1711702447;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mBNv4vFEtRrRogU1bpDNqFs895hGS3croCKNhICIOZA=;
  b=aqcWXpNPFU1CVH565NxKmR4nHmZwHrIYQ4jYi8QwAX/ZlGm9m+tHsfHg
   dH90wlhf+9/e22AnKjEeDKHYlcTVv9VnLq+kSOsRHwTKwgd4G2UrfwP4Y
   F5xAji+71NI1tXPkvPMdjXoWOy9fMTZ8FH+QbYuVjnBzM5OuFd/ZImNuD
   QGbNg5GLy5Dvf4wdViYVFASC7ZYe4/Wa8HnxGz4XH4txapc84MXCoX0Qt
   Cdbk68BkukKN8mWlMGc8r0kKar6lBM5zLq8lAn6ZCMMeZOtnpiiJSjBYG
   9++0QE4Kx1c9N4GM3tr3u1QwUFGk6xn5Y4jy9maN1ypSweBURJ0FrU5aX
   A==;
X-IronPort-AV: E=Sophos;i="5.98,303,1673884800"; 
   d="scan'208";a="331310424"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 16:54:06 +0800
IronPort-SDR: ti5aybD4mnmPQHgLoo5VORg71ipRDFl2/ec+kgylXz+h4EVuGhIROXg998I007bb9FEuvWL/t9
 RR0jMtQ2B9ylLENFKCWIL0arsK9KQ41oUxXdWHkk/SdBskOuEo7FKYyflwvYorDHSrJGLIk7fQ
 XiKzERvthDNoCx0j+0iPSkJVUaa0D2UOcGwsmISI9M5yl/Ld3Z8EKFzJgdSWjBLjYAVKjrvDPY
 Rd/zGLX+bh/spNdkS/y/5XIab9c79iHHBoTYkEVJOLfFi81OguM/CVUycHkjRbqVqBO0q8WBXQ
 /ic=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 01:10:15 -0700
IronPort-SDR: JFP2elDmSsahMtTLJxXowoeZJrsmlFbKtb3vke0GuI1h6tDkxW27v5MKeqTBXwvzs3HY3bQT6w
 VTYwVNeE42E1kHhNCcqkmTD8xSKLxodsu67ggB2E93pSURCo8lRwMEOlsGcxrqBxtryW/k5gUM
 COSSjmdMEn3VZ1qHWs6h6cj/shvK9nZEJi0mHxu2Iirfzss/YTwhXCedl/MnoIoOEa3s6FcyP4
 gFeRl1j/U5VdjlEag0Sp+x0dKYo30WVfMP6kotaucWpQhE7HYU+OCmJLwcmbXGSgDFoL3eJxq6
 jd8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 01:54:07 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PnHKB4Jvrz1RtVv
        for <linux-pci@vger.kernel.org>; Thu, 30 Mar 2023 01:54:06 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1680166446; x=1682758447; bh=mBNv4vFEtRrRogU1bp
        DNqFs895hGS3croCKNhICIOZA=; b=Ud1bf1coUzdxUD2gsW0OeI0axQETcidBSB
        jmsrnMoxm993/OIhJvo8O+1ByML8Lyj7lwGtlqMkeAb6UQvz7+zXrIjG2dBsYY1M
        LTCSp/vicO8m7X4cnR1mtmNGVrmikhOwLcY8zrsVHYNepRoL1YNos6fT3P0Bbabm
        NP+bUr52qNXmxcibwLWZtq1wMbqspMSkVC9OPgvn0CGTtZMKjnPWgHPoyU6oNiTB
        xXfYckRhlzUficZt2Eo4JiWSd2bqsSN8mv1ySR7U/sxzDr3bwu7Ui/C5whdPa/q2
        ccPyuBE2Z8gfAE/MTIDqRVVYNQOuRbUVhKGS8ixNva2JvoNvib7w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NrxqscnpOzaD for <linux-pci@vger.kernel.org>;
        Thu, 30 Mar 2023 01:54:06 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PnHK83p79z1RtVn;
        Thu, 30 Mar 2023 01:54:04 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v4 03/17] PCI: epf-test: Fix DMA transfer completion initialization
Date:   Thu, 30 Mar 2023 17:53:43 +0900
Message-Id: <20230330085357.2653599-4-damien.lemoal@opensource.wdc.com>
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

Re-initialize the transfer_complete DMA transfer completion before
calling tx_submit(), to avoid seeing the DMA transfer complete before
the completion is initialized, thus potentially losing the completion
notification.

Fixes: 8353813c88ef ("PCI: endpoint: Enable DMA tests for endpoints with =
DMA capabilities")
Cc: stable@vger.kernel.org
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/=
endpoint/functions/pci-epf-test.c
index 0f9d2ec822ac..d65419735d2e 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -151,10 +151,10 @@ static int pci_epf_test_data_transfer(struct pci_ep=
f_test *epf_test,
 		return -EIO;
 	}
=20
+	reinit_completion(&epf_test->transfer_complete);
 	tx->callback =3D pci_epf_test_dma_callback;
 	tx->callback_param =3D epf_test;
 	cookie =3D tx->tx_submit(tx);
-	reinit_completion(&epf_test->transfer_complete);
=20
 	ret =3D dma_submit_error(cookie);
 	if (ret) {
--=20
2.39.2

