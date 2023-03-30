Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3CE66CFF40
	for <lists+linux-pci@lfdr.de>; Thu, 30 Mar 2023 10:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjC3Iyo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Mar 2023 04:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjC3Iyh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Mar 2023 04:54:37 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF0E7EC1
        for <linux-pci@vger.kernel.org>; Thu, 30 Mar 2023 01:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680166468; x=1711702468;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c6fb/ATpu4bjomFurbyO/sIS4IvcEwK34bItru+sYXM=;
  b=E4RM6BwlX8mZcc0AnzxdKpG98NoU+5H6VAGqIK3ju//s7D/BvHQI/Hzq
   TYLreW4gj+0Bu7w/6RMatgVRjKmQcu3lYRq3QbY5OniXZKYst+PgKEiKE
   58+oZSghWtBN6t5SycmJRbHOzI+AJ4mt8aWJl4QJ5qp68ilp/uNi8XrUo
   IvPYVpr8/aoPYn3BdWGCJbBbb/kCScSTcP3A0Obyt8BeQ10QtXxewd46N
   zh06uuDplUWU7Pyr7TjOlfdSAqTcNjMSco4FXhJGbWbGml8CPd+LTTPV9
   XjRzGtfzWqbLHntXkFPJH6jKWL0ylIIp9tiH98/tH6Fr7N9EzI23bvZxa
   g==;
X-IronPort-AV: E=Sophos;i="5.98,303,1673884800"; 
   d="scan'208";a="331310490"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 16:54:26 +0800
IronPort-SDR: tOy1UuApEzm9H0iFguCq6DrSJpdz6Dj1Pet47mfv66h6AzUHEXmqMpzyKvmIAYN/sGJgDqFjcF
 Z/Hxvmlwkoq6/u4re88W7j5vQAO/3a4IkazFTUhIUE7Uwtq+SRfF+M2Z3qwYOq7B0avljUQDUW
 TZxRabrTo4QvoFeUKu/oCQaA2NK45EwIDqvT9lke55TUf9K4z6AWK2sCs22eUaTNq1ljQJus+Y
 +z8jZhKWhd/f/hXwDD1RuQ/rQPi7aFZX+414o9/6UFYRfbawjZ0Ynygvp0I3h86tBS23FcmO1M
 PLo=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 01:10:34 -0700
IronPort-SDR: fYCcU+P9VOu1yQqp5AJEUWNkPEUcYw5vGiPUlWO5WLh1tVDKnsXXb+oBTPm0xXlL/D/GkkJ0qy
 89D77UXNiEPnQZZWULcTpuWFm667ay9yLf+cvFRMYy/TIngDVa8E8XrMhXqAYCltCaL1cNtucn
 FF0BU8KdVPyBjvMFTaurf1st3uuFk6tGb+5B7/RLkgUke3OHPh9byJfZzkd5/i3FrT+PFO3mXX
 s61I9gcMvbp/xME0bkIyOKnwGVtNMVNDkAVr9Gc7bwx3JogGstgu+LxD9ZBIaRXPBu9wsmARWV
 trg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 01:54:26 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PnHKZ29n3z1RtVv
        for <linux-pci@vger.kernel.org>; Thu, 30 Mar 2023 01:54:26 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1680166465; x=1682758466; bh=c6fb/ATpu4bjomFurb
        yO/sIS4IvcEwK34bItru+sYXM=; b=FxKJCv33s3R6Tdsr8jhJDzmD9BG77tPnQA
        q9dwM2Zqz9B3NaEdGiZ0sFcEB6FNP7ua3VU3xUxgyr5BaJlk7qTefEz6dRsU+PZY
        c9pz/N3Q/wFYwthCS5XTQxxrC/qicLJd3n6zE4bDaeQUz8oHiTXNlzewdc7xg/24
        Hdo9SH6rk/4zJgSGLCMGBwWr0Y0YFzg1oMiiJZe9TzTHY1bGJI0oWKJOmaXqDoz7
        7/l84D3Bg92dV/DYQhe+H/q0AGCKeFkdiPcLN7j1oG7ijMZZ/RAGfLsht+5VWQW6
        y5coBlyNLFYFWyaVMfOpM1wddl/oQT+4+VfZDUP82kiDM66+GDIA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id slpYdqnETC0m for <linux-pci@vger.kernel.org>;
        Thu, 30 Mar 2023 01:54:25 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PnHKX1qPXz1RtVp;
        Thu, 30 Mar 2023 01:54:24 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v4 14/17] misc: pci_endpoint_test: Free IRQs before removing the device
Date:   Thu, 30 Mar 2023 17:53:54 +0900
Message-Id: <20230330085357.2653599-15-damien.lemoal@opensource.wdc.com>
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

In pci_endpoint_test_remove(), freeing the IRQs after removing the
device creates a small race window for IRQs to be received with the test
device memory already released, causing the IRQ handler to access
invalid memory, resulting in an oops.

Free the device IRQs before removing the device to avoid this issue.

Fixes: e03327122e2c ("pci_endpoint_test: Add 2 ioctl commands")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/misc/pci_endpoint_test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint=
_test.c
index a7244de081ec..01235236e9bc 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -938,6 +938,9 @@ static void pci_endpoint_test_remove(struct pci_dev *=
pdev)
 	if (id < 0)
 		return;
=20
+	pci_endpoint_test_release_irq(test);
+	pci_endpoint_test_free_irq_vectors(test);
+
 	misc_deregister(&test->miscdev);
 	kfree(misc_device->name);
 	kfree(test->name);
@@ -947,9 +950,6 @@ static void pci_endpoint_test_remove(struct pci_dev *=
pdev)
 			pci_iounmap(pdev, test->bar[bar]);
 	}
=20
-	pci_endpoint_test_release_irq(test);
-	pci_endpoint_test_free_irq_vectors(test);
-
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
 }
--=20
2.39.2

