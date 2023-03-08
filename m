Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1EDD6B0255
	for <lists+linux-pci@lfdr.de>; Wed,  8 Mar 2023 10:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjCHJFI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 04:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjCHJEy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 04:04:54 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6053585
        for <linux-pci@vger.kernel.org>; Wed,  8 Mar 2023 01:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678266282; x=1709802282;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p+MxxNmS9DVwNUcLA55VvIMV4ImTHL2q/nFJco681WM=;
  b=YK0pU2A8FFrLiv3jumXhrJ4eRRhtRNKci1tldnyBthpghNoUwDZE112o
   KONWP03ifIkgKgCCir4omAqw1CBhiOf4bnSVod8bxxmsnwrKQzg61vy9s
   d5xjUz37idp8nswGkv/Ug218T/55BeA598kvCLJV9iozjr6bT35EaSAP8
   8aywpJCGhloH/ewrjZ9kO1OlMtz8CRWMKLRlx2qKwZomYWjz3qSoF1Spa
   m37sEi5WngqMTW1p8BRetFXG6eKtiS1WWaa44HvL1MvAfNVTjRYU8M3rO
   gi7eLUwra0xR7lnM3VqfS6LwBul4IZ7bCaMXBtdtEKDSjHTBLaSOEIs1A
   w==;
X-IronPort-AV: E=Sophos;i="5.98,243,1673884800"; 
   d="scan'208";a="224880586"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Mar 2023 17:03:46 +0800
IronPort-SDR: ZgoFqAACgxbFgp8aLME0Qeh29UPNq+RSqnrQc57cuqLStV/xCIxuoJpd1y3ygu8DkEiYj88qVD
 6FeKUpAayoPhrmeVji5VJ6iwJfpSX8HtBYn5Ym+uP1rQyCe2kImZpN3d98Na4gr9kKfsYxB6zw
 w+a+TvRtYZjsrNQnfhjpzrskZ2PWhc2NSvOopMIMpDamvoeTb6uaeUSAxzDf77jkNWjuEPTMT6
 0FPb5Y9Q2tR7AoVsq8sHP3pfzpZARE6bgnst0CzR0WNZG3Z8nOiTCbQkmy9YQR5j5jxBR+6+9w
 P6s=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Mar 2023 00:14:43 -0800
IronPort-SDR: P+scogfpD+55Ot0WLx7z7xQgtDEihu+tZIo7I2CCuEQ+WXd1XrwEMkGDv25IHoy11MxgeO+dZ/
 xSlUKdBh5CoOplExCgbu95kumjxY1uDx3SRmLKVluqaxL/3bwEz5Kkc0Wpjntv+HNB/tsMsVXj
 7Cbnmq7e3Sn7lZZu4gPsYIyKp1Th+oZebeoLDfUWac5Ra1nUS4U3SWJ9x4oDFRwfBw3YQjtBAP
 6c8IVelKBsTwVasMMQHJR6tixujn1f1fn93+g8kEFMgOSdoucepPO93kElxwETiVnnQ0CODrXR
 05c=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Mar 2023 01:03:47 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PWmZV2Hkgz1Rwt8
        for <linux-pci@vger.kernel.org>; Wed,  8 Mar 2023 01:03:46 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1678266225; x=1680858226; bh=p+MxxNmS9DVwNUcLA5
        5VvIMV4ImTHL2q/nFJco681WM=; b=JmpBHP3mLqVQ1y/vDhExWvC7oXLkJfzuVj
        4AICeGynPa222qAgRt0Pf5/XNwFBnOuWb+prS2csn26XWUl6dk04o3F4VjmuyB++
        rr2SNVZPTSgR60NpYg3yBhrRyG/ZdLHWgMY0BIDp/5Dpqy/Li9j6GW5jl4wnzNRh
        UjftQCszs6N3ja2EL1cTTFQzVpGnYDAQjtYYOGU/WtYafEyxZ0FurSLWQavD6v3f
        OOtHC2f+PRmps/FHnOAS5xV7MflmPXg5vSlQShEQFedr3ZUv+Cnzrj3pgn1ofD+f
        8pDRB0pBDNYnQvIKwAO0zJoB8AglTOjZfwzs/SOS7f5Adu0huTqQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OPxXSL1arS2W for <linux-pci@vger.kernel.org>;
        Wed,  8 Mar 2023 01:03:45 -0800 (PST)
Received: from ephost.wdc.com (unknown [10.225.163.68])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PWmZS2q1tz1RvTr;
        Wed,  8 Mar 2023 01:03:44 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 16/16] misc: pci_endpoint_test: Simplify pci_endpoint_test_msi_irq()
Date:   Wed,  8 Mar 2023 18:03:13 +0900
Message-Id: <20230308090313.1653-17-damien.lemoal@opensource.wdc.com>
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

Simplify the code of pci_endpoint_test_msi_irq() by correctly using
booleans: remove the msix comparison to false as that variable is
already a boolean, and directly return the result of the comparison of
the raised interrupt number.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/misc/pci_endpoint_test.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint=
_test.c
index afd2577261f8..ed4d0ef5e5c3 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -313,21 +313,17 @@ static bool pci_endpoint_test_msi_irq(struct pci_en=
dpoint_test *test,
 	struct pci_dev *pdev =3D test->pdev;
=20
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE,
-				 msix =3D=3D false ? IRQ_TYPE_MSI :
-				 IRQ_TYPE_MSIX);
+				 msix ? IRQ_TYPE_MSIX : IRQ_TYPE_MSI);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, msi_num);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
-				 msix =3D=3D false ? COMMAND_RAISE_MSI_IRQ :
-				 COMMAND_RAISE_MSIX_IRQ);
+				 msix ? COMMAND_RAISE_MSIX_IRQ :
+				 COMMAND_RAISE_MSI_IRQ);
 	val =3D wait_for_completion_timeout(&test->irq_raised,
 					  msecs_to_jiffies(1000));
 	if (!val)
 		return false;
=20
-	if (pci_irq_vector(pdev, msi_num - 1) =3D=3D test->last_irq)
-		return true;
-
-	return false;
+	return pci_irq_vector(pdev, msi_num - 1) =3D=3D test->last_irq;
 }
=20
 static int pci_endpoint_test_validate_xfer_params(struct device *dev,
--=20
2.39.2

