Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929916CFF41
	for <lists+linux-pci@lfdr.de>; Thu, 30 Mar 2023 10:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjC3Iyx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Mar 2023 04:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjC3Iyi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Mar 2023 04:54:38 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975CD7683
        for <linux-pci@vger.kernel.org>; Thu, 30 Mar 2023 01:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680166470; x=1711702470;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9hc8RCCLWTxRBYC9gxcz8ZAIDPbMiGNQupCTpkbGyu0=;
  b=KVlkG3sC22/CDBmI9t3K1LVTCizMYmQUZIDUKsWhLZbTVIEVHsptGpmy
   ht216MjYtu/5bqPM/6AfBWW0bWb1CSs8Muf/Y3ACQzYfis9F8x7YClZ9N
   Ao/vL/QAg/8O/g9U3DCB9i7a+ZmYjeQ3jTrRVDt6eAlsrIarzuHQqmps1
   8ptCtGUIx2yKT5lUFRswjqYJY/xqb2jZ6XcxF38QQ9xW2smPJOS0umW9+
   j4BqaJ8Lq2F07dTWlSFmFhHhvYWemO62I4pvcDrLyFYQFN+0F6QJBbJJT
   62wziVLX+c3uzJjKcpIuZPIFW5lK4Es3qO4Qq+0+5JALrjp0OBa+TsVSM
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,303,1673884800"; 
   d="scan'208";a="331310494"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 16:54:28 +0800
IronPort-SDR: KO1byRHEdli5DY7Gzhzoj470motfKvqGj9ufgYyPZiww4Np7995qA8QOy5YWMyMx8SgF1yAJST
 f60DQtpLCofAd08y3FU+uTGVAjQZAveOMVeGOlJnJfn32HX18DfiX0o+EVn0cdJaaNMV0is2i8
 kbonqTuthRVNZ3TpRChBWDP+ydnxkXxRa6pGehXgJqo7VSOXP8MWJZXoS+9wYPyBh50UuCsj8p
 UP56jjTLrGC8L9haICon5ehMYD9Iwb7Tr5Rm4U4uDu0UFUsH75+ta3VmOMbdxUG4CnUTZXb919
 tmQ=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 01:10:36 -0700
IronPort-SDR: UWr4IAs+gBzMmmQ6SqNCpcCywpWpbwyZOwbKvUJrSJ9LTLTISnugwkFCgr6g1/FFeay8x8to+x
 oFnIc4O/TZHDd9OCPdcoz2oxRzem6bIQoXvUugV7Fzj5SzLNFzCq2Ah1nPdwKzAQ/Aq44Vb2jR
 wye0+9QH+V3wlkK2Z49hlzALTo8l6xBenDzKTxLpIYfuFlI7pl8TK3/fbbM58UeZmiIJSD/UJT
 Tx9GW6dBBJaG0PaqTICk93oE8D5UTuTQKZGS/RaSvPqDWtP2jwMQ47oyZdkl8OZm6YBnZgyRil
 9l4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 01:54:28 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PnHKc1DMHz1RtVy
        for <linux-pci@vger.kernel.org>; Thu, 30 Mar 2023 01:54:28 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1680166467; x=1682758468; bh=9hc8RCCLWTxRBYC9gx
        cz8ZAIDPbMiGNQupCTpkbGyu0=; b=It1nm9n07mW732LZlHkWDZ3RakaZhPJx9a
        kcRg9v+5g1H1Xwqf30/HDRUvrgBALuHlCQuPFAYOANB4OeKdbo3FMnhcuaza5Ntk
        JTkbh/CUsq1VD0hAJ7qfWP9C7w/geH55xr7saYthOp427w63sB7VwIFFvE5iXeHN
        pKRQxtgSzOGR1QOUgV4vlZeCQXfQvaaA7/0OlOyoL+EsdFDHqbnyQfrMETzYNsj4
        IyOlnWZi0/W3GIg1b+rmp06d7lGWWucNhsU7sPLlLPJ2PvLqz6A7lyDroZn0mwTv
        r2p3Nl7XI5XJOjM9jywpBleVNIX6MkbNoEaNlCeIF9m9jX80Nuyg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id eugez6Q_F31N for <linux-pci@vger.kernel.org>;
        Thu, 30 Mar 2023 01:54:27 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PnHKZ1JjFz1RtVm;
        Thu, 30 Mar 2023 01:54:25 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v4 15/17] misc: pci_endpoint_test: Re-init completion for every test
Date:   Thu, 30 Mar 2023 17:53:55 +0900
Message-Id: <20230330085357.2653599-16-damien.lemoal@opensource.wdc.com>
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

The irq_raised completion used to detect the end of a test case is
initialized when the test device is probed, but never reinitialized
again before a test case. As a result, the irq_raised completion
synchronization is effective only for the first ioctl test case
executed. Any subsequent call to wait_for_completion() by another
ioctl() call will immediately return, potentially too early, leading to
false positive failures.

Fix this by reinitializing the irq_raised completion before starting a
new ioctl() test command.

Fixes: 2c156ac71c6b ("misc: Add host side PCI driver for PCI test functio=
n device")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/misc/pci_endpoint_test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint=
_test.c
index 01235236e9bc..24efe3b88a1f 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -729,6 +729,10 @@ static long pci_endpoint_test_ioctl(struct file *fil=
e, unsigned int cmd,
 	struct pci_dev *pdev =3D test->pdev;
=20
 	mutex_lock(&test->mutex);
+
+	reinit_completion(&test->irq_raised);
+	test->last_irq =3D -ENODATA;
+
 	switch (cmd) {
 	case PCITEST_BAR:
 		bar =3D arg;
--=20
2.39.2

