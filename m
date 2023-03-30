Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36406CFF43
	for <lists+linux-pci@lfdr.de>; Thu, 30 Mar 2023 10:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjC3Iyz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Mar 2023 04:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjC3Iyx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Mar 2023 04:54:53 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257617ED1
        for <linux-pci@vger.kernel.org>; Thu, 30 Mar 2023 01:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680166478; x=1711702478;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p+MxxNmS9DVwNUcLA55VvIMV4ImTHL2q/nFJco681WM=;
  b=cZLi7chO8bJo/hNW2iBY6yhjn6H5Sey/8YUvbhBkSrafVzSeBEh+u6Xc
   qsq8sMUMgQhbtqCI0wUAtpOggCd0hKZXEuFfckVh8/QX8DZw+alcXpMrB
   QAvjBzZ5QE6qnSlJJWs5RgiKw51Kw3pVCD2upezrhvAQhzW7Yup4kqWms
   0ABrV9oskIyzwUH9witdAN9315JJGs/Px0VRm4qUDlWdsOx2nMS3GU04E
   Kegge0hhYSJbJSciRqkWUb+kGgxs8ZnIwvSqVUPLQ79lgXBQRT7krsImf
   60Na52qZ5F3AwbcYoME1X57DaqMc10E2gFy0mjbAIm3EIACmsTHF4UCVg
   g==;
X-IronPort-AV: E=Sophos;i="5.98,303,1673884800"; 
   d="scan'208";a="331310499"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 16:54:31 +0800
IronPort-SDR: bq841QrrVwDk4UnCkRF1FBHBmmqDXIenBDgduXavjpHuGeLwiXSOm9GyqVJrwjoSRxBt2PfcHJ
 ad2KQXZgAffbbTu6p0rwx/Bnfp00b75KFM9Jp3bMW79SUX3sViZtOx2aqqeJu+zKD5/CA3TQHo
 uBndvAVrPEVRxc2PllxaubdUfKXEzAf+fxHDf6WthMFfKiYyqF9sSJXydhgb0/3EkAQHUnGgoH
 hrMHWC8qOq5zkEeDPfovjqzCZYCubb8BzxkwIr78fl5DhhB6iATL8hcF/+kY6U+bKGfHwTlFI/
 spo=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 01:10:40 -0700
IronPort-SDR: ZyaoWfojku3VnrfCj+vCFyukk4xtQvklRJnI3jZ5uJCcJt5jSgXcOkd1WRrf2IyPcMb4pICsRY
 e9T25zsJAo6/jJN2puIbjZLeknUUa6bzV/x7d0z2L0J9Op6/YE3NLPnkcrcsrSoUQhnvluxvqM
 MYI7ZX53I6yYswaOsIdmR1qYvzB+ckHSKqAo4CQfqO5xzhdjYhyxAJ9zLZtjxmy+exdHznyC7T
 2lPRIvRC4f7gxttKY2qT1pIwPyUZqHfVM/1qzyF4FVZso1JEdJGdALUNYcup68g8F9NkEeaIGN
 E2o=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 01:54:32 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PnHKg3ZBcz1RtVv
        for <linux-pci@vger.kernel.org>; Thu, 30 Mar 2023 01:54:31 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1680166470; x=1682758471; bh=p+MxxNmS9DVwNUcLA5
        5VvIMV4ImTHL2q/nFJco681WM=; b=A64jJXPLc6V4e7mO/hGyesoVqemGKER85r
        9Fv0K+mxYfRuWvOgolbOD2mXYtdTrWdHuMhbowzyHdD7th39j/snJjguKojWapu6
        o/jRxO9OtWy0n6Av6fWN+d5VwGzgVsSC0rpWyGjqT0nNtK4D7JUcnUcePgQuwGAZ
        VXlYBbthsFakAAK6xMOsUYuz2KH3K9fqpkXI4Ln9/W8Dx7Ut1q1d6PcqDk7eSlhI
        aKq0XKdg1Uq/tp+V0tgOEYiVT5D4uJYrRnrRGVpC3gU5ZO00ITzOFhiLa5u5r+Z4
        BRTh93iHyoWqqBYCja70DCWatH4p4kGioQA7kMVAa6rGAgELv7qA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qpnvgEXMjTvI for <linux-pci@vger.kernel.org>;
        Thu, 30 Mar 2023 01:54:30 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PnHKd361Vz1RtVm;
        Thu, 30 Mar 2023 01:54:29 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v4 17/17] misc: pci_endpoint_test: Simplify pci_endpoint_test_msi_irq()
Date:   Thu, 30 Mar 2023 17:53:57 +0900
Message-Id: <20230330085357.2653599-18-damien.lemoal@opensource.wdc.com>
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

