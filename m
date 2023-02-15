Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8426974D6
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 04:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjBODWW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 22:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbjBODWV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 22:22:21 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1C23344C
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 19:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676431334; x=1707967334;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HqW3zLj+zMnKFjU8rhX70g8NHjaasT8LhoX1MesHtKg=;
  b=i5/IZqAsg/1qL6PT1tRiY8ILCw06KeVdJmBBwcSRPYg1sGN8Cq2PQ+4M
   aHdN+WiKJeiyfMNkMRlRBCy7dXGyK6HVC432Bl/lZCzpNDymrfZNKXsOD
   lJ+bqxrlTdLCXpUuPbWVwnED8Lnw0o1vaB4fjJC3vRMa+ij3T+UCYPIYI
   SBuWdVGuxgWIiDO33nqZTEBAsCVbLuHxgXgOQuJY0ut4h89IJVyP1qFPx
   wS+XkaF2Cr7ysw+ie1Yq6Mz8lu3j5vS2Aip2DuvjHNpKwkAtr7A8ixCMn
   2JnQxf+7Cjr04vUZVECemtJCOlfPmlTUwXq3M5ymLvhsFW4sZhW6oqAQ0
   A==;
X-IronPort-AV: E=Sophos;i="5.97,298,1669046400"; 
   d="scan'208";a="223351461"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2023 11:22:14 +0800
IronPort-SDR: Xh4pMNtNiPoZ3DSydnwpfZ++zNe1STsCa1Pnzx5OFlsdIPITPsk5NtCHwtOYGBsDzYjByZI0+e
 f8nbkIcM+uRgAhf1mk0vUWVt2jRtvFngQqN/n2yKhdhQnvmnN6VqnRIHskGU3E+MlCeXwV/TyZ
 yGPtQccXunUxH34ATiB45sTEXwGAX4Qa4Cahpy/67OIubaE085pcUjPxigERLvFedmmmleYoca
 QtYu6Chn0Tib5nzwta1uHvhaWt7RJRBXtW9SiQLKNaHxXp6IvMqTrks7IP7gRxz2odV1mISUsL
 0mo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2023 18:33:37 -0800
IronPort-SDR: xcX0tbCPkW2FQ/LW1MNOs96oD8AzGIM6+z4uDhTJ8KJvuViWf0t5vM9/Q91jO0oDxdT5zQ8t9K
 ZjrQumFeh69qZbKXwMrJyH99Sl54jlMCxFSzHDzKnFVnUoc1uCGBIKsSmn3+scJhS9f03uid2V
 9BfH0T2pCBcCNpXucxZ+Ugcly+XxePcVOseXec7d0fV47G30rmxyAfeOKb0z2lnPZuerwIlgtA
 fWmoG+lEb/jLgf9VOeXYVji7NOqRH1jPr2YNV2wVBK+YwbKqmdXX5siOV+m0YC7bHM+jxI829B
 Xs4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2023 19:22:13 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PGk062jTvz1Rwrq
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 19:22:14 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1676431333; x=1679023334; bh=HqW3zLj+zMnKFjU8rh
        X70g8NHjaasT8LhoX1MesHtKg=; b=dPOgLoO9gz4WrWrcHO18RXiljBxkku6YJ0
        AyBLxNJGvnwP3aIE6nD/yp3Uqwcy1L9p8CgZHBL7W/f0AQ0+wwEo4IIdtMtot+vy
        HnpmYCyDg0EqOoLjts/kRhFL1F3OxI8UEBKw+9S2LW+R4NTZfUMm4B6HI4i4GGsL
        RgZ3a6SUV04LwX25pN58loV/Z7ejYY0n6Ghl/rTlcC1kk93NgwXgUPGyxyejLRw2
        Ovq6el3y2xgzNzpu+S1ZUNgQqUoEGatRXz668Atsjmxw3bkwHCgSxPMEGKx3LUPq
        MF7zm1uDB2IOaGu7TB/zdjaRqbMfuNipuvfZ3BD3xmyqXkXNzNCA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mfwWDFnmLhCF for <linux-pci@vger.kernel.org>;
        Tue, 14 Feb 2023 19:22:13 -0800 (PST)
Received: from fedora.flets-east.jp (unknown [10.225.163.119])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PGk041bt0z1RvLy;
        Tue, 14 Feb 2023 19:22:12 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 08/12] misc: pci_endpoint_test: Free IRQs before removing the device
Date:   Wed, 15 Feb 2023 12:21:51 +0900
Message-Id: <20230215032155.74993-9-damien.lemoal@opensource.wdc.com>
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

In pci_endpoint_test_remove(), freeing the IRQs after removing the
device creates a small race window for IRQs to be received with the test
device memory already released, causing the IRQ handler to access
invalid memory, resulting in an oops.

Free the device IRQs before removing the device to avoid this issue.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/misc/pci_endpoint_test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint=
_test.c
index 11530b4ec389..e27d471cc847 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -937,6 +937,9 @@ static void pci_endpoint_test_remove(struct pci_dev *=
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
@@ -946,9 +949,6 @@ static void pci_endpoint_test_remove(struct pci_dev *=
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
2.39.1

