Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D0E6B024F
	for <lists+linux-pci@lfdr.de>; Wed,  8 Mar 2023 10:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjCHJEt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 04:04:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjCHJEh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 04:04:37 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840793609E
        for <linux-pci@vger.kernel.org>; Wed,  8 Mar 2023 01:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678266272; x=1709802272;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YIUrKj8Ou8+6NLVJQAB+2QGq2T8Z8NPAgdYDNBm9+Kg=;
  b=ikYlJGnairq5xZIhnlSSKzQA8T7SJVAw8AV/8idtKujnM5GSxCiOIlMJ
   dUiFZ/6gH69DF+97WUJ21mrM4ZCeJNPLTPMICCwJbCfVbxze8vnJlyLuu
   8uArZ7YE028a1J6FgTI7TDM5/qZatCV692+5rQ7vY5erwiIBQW5vRTiDr
   UrROJ7pwXXXxZu+WqWV2UzPyfgy6vQqnTKwbd3RCLWL9AsnygwmIv8GFd
   QcKPO/2P58MilulWEekKb3VYq9Jm1P42niJsbsmf4+sXGF8YPrZeaH8a5
   cgo2nyLX5vI69jHzOGCZXoK0RpsosOlcVXRTmogLpNNMRjZ/JKNqEfO/F
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,243,1673884800"; 
   d="scan'208";a="224880565"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Mar 2023 17:03:35 +0800
IronPort-SDR: 2uSFk838ho2n4aJ8duWN8uauMdwzLHzII1WifcB0gfLrKb/FKsxGF//y3TYh9m5ZPuPiOZGKxm
 8fO0L2W0SP+huVcjs/vaNgSFBEYRfRc67oBfuBG3FFnp/YpqDAR1AV8iyTqdbQ6GSi9mcPu9s6
 I1MfZE1aRKOY6rZGuXYxUvp2qj7a4U1cYnm7IJDhSILOBiqk9E9hKKitmjZv/iUR5Bcsb9gXVz
 3ocmKbWSPLCsdx8iGcmutixlkG6xGLYVZrSasP1RrxmIDO/jO7r14lrhXiZphkZeUV+6ISKfxV
 QcE=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Mar 2023 00:14:32 -0800
IronPort-SDR: JkUCtK4q2o7m5bMWw8AF1i/keiGXa/JnZeXWiH2Tw0V7bFy2hIFpNfO7Sm4b6Fz63qxWFFtlws
 8vk0ySr/N1nOahssghAO9QIAL2tByo8dYNSbZPPJ//zFqO9Np5RmVl7+j1pKaKCMCq+5S/ZuWw
 p2d7pKFaHta6qgsM7zGpIBqY+COqlBQ50umHSjmzQtJ6X0VliiKuybve9MZWbKZwXQnH+oyxFU
 FyOZSB1WLzRYJJMmY6YbP2S/D1Lh7YyD+tGXV7YKcbdYOxODMznjGt3otP5sGFGgTXRMRSjX7T
 hnA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Mar 2023 01:03:37 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PWmZH3KDtz1RwtC
        for <linux-pci@vger.kernel.org>; Wed,  8 Mar 2023 01:03:35 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1678266214; x=1680858215; bh=YIUrKj8Ou8+6NLVJQA
        B+2QGq2T8Z8NPAgdYDNBm9+Kg=; b=UUNG9TfLEGtVSh6u5lqiehBcjf52zG99Lp
        IQnJLTlDTmpDj9kEQMJMXYxvHl57TduGgRQ75afY/1nQf/XDODbqrkuDq2JBZbCs
        GAUeQ7JXYsN7dVuiNlU1KSioLs0AZqoYlnnV8tJf5PX/6tCOWVJMST3wJyNhwI30
        Ta8Fz/F6H9XiIRaGS15sxJPvYu7zkfxbQEbl/pHJxPJlwBrGaLbXGLQlaHV3GKmv
        QO6lDK5PiYWMFidvDs74h/PEWjfZRJHNhv9mdIpm+UI7MGWW4i5RbujqJPaSGZae
        GBEx7nk2ocLr3d4mo+PEbqkxgBFNIZojefV5zw66RGqocTE7FbzQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VaoLX2bXjxIB for <linux-pci@vger.kernel.org>;
        Wed,  8 Mar 2023 01:03:34 -0800 (PST)
Received: from ephost.wdc.com (unknown [10.225.163.68])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PWmZF2Jrfz1RvLy;
        Wed,  8 Mar 2023 01:03:33 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 10/16] PCI: epf-test: Cleanup pci_epf_test_cmd_handler()
Date:   Wed,  8 Mar 2023 18:03:07 +0900
Message-Id: <20230308090313.1653-11-damien.lemoal@opensource.wdc.com>
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

Command codes are never combined together as flags into a single value.
Thus we can replace the series of "if" tests in
pci_epf_test_cmd_handler() with a cleaner switch-case statement.
This also allows checking that we got a valid command and print an error
message if we did not.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 30 +++++++++----------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/=
endpoint/functions/pci-epf-test.c
index e0cf8c2bf6db..d1b5441391fb 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -678,41 +678,39 @@ static void pci_epf_test_cmd_handler(struct work_st=
ruct *work)
 		goto reset_handler;
 	}
=20
-	if ((command & COMMAND_RAISE_LEGACY_IRQ) ||
-	    (command & COMMAND_RAISE_MSI_IRQ) ||
-	    (command & COMMAND_RAISE_MSIX_IRQ)) {
+	switch (command) {
+	case COMMAND_RAISE_LEGACY_IRQ:
+	case COMMAND_RAISE_MSI_IRQ:
+	case COMMAND_RAISE_MSIX_IRQ:
 		pci_epf_test_raise_irq(epf_test, reg);
-		goto reset_handler;
-	}
-
-	if (command & COMMAND_WRITE) {
+		break;
+	case COMMAND_WRITE:
 		ret =3D pci_epf_test_write(epf_test, reg);
 		if (ret)
 			reg->status |=3D STATUS_WRITE_FAIL;
 		else
 			reg->status |=3D STATUS_WRITE_SUCCESS;
 		pci_epf_test_raise_irq(epf_test, reg);
-		goto reset_handler;
-	}
-
-	if (command & COMMAND_READ) {
+		break;
+	case COMMAND_READ:
 		ret =3D pci_epf_test_read(epf_test, reg);
 		if (!ret)
 			reg->status |=3D STATUS_READ_SUCCESS;
 		else
 			reg->status |=3D STATUS_READ_FAIL;
 		pci_epf_test_raise_irq(epf_test, reg);
-		goto reset_handler;
-	}
-
-	if (command & COMMAND_COPY) {
+		break;
+	case COMMAND_COPY:
 		ret =3D pci_epf_test_copy(epf_test, reg);
 		if (!ret)
 			reg->status |=3D STATUS_COPY_SUCCESS;
 		else
 			reg->status |=3D STATUS_COPY_FAIL;
 		pci_epf_test_raise_irq(epf_test, reg);
-		goto reset_handler;
+		break;
+	default:
+		dev_err(dev, "Invalid command\n");
+		break;
 	}
=20
 reset_handler:
--=20
2.39.2

