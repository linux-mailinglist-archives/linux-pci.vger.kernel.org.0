Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCCD6974D9
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 04:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjBODWe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 22:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjBODWd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 22:22:33 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E6C3346B
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 19:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676431340; x=1707967340;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1vL+k2GBBnXNHmaxFgAGdZo/Iu3gdaY71xSDrxRY62k=;
  b=WsSuqedu0Q7Omfa02Mic0KCa6nB6FeknuE9VqEolXWfSWquREbduEEdD
   bMtaIFFPgXTbkWQ5LOOLSQUlXv6Xe6pPY1dmmvOUUk5UDXXHSGgvJ9WSL
   GPXGWgy/n4hJJUa4I6sYYppPD/HoCyww4cUlgrQwvgb+XGQr0cuwKDvn4
   Yhw1iUFodBWO3VqZd6LqaOMGc+UCGRJGWN1vz14CAy743RUqyp0857tWC
   2cYzTbBzc6TWnr0lCv8iJW+Gl3faefWeq89WMv1QqtIPS4HUSEil57Jb7
   WDFTeh/60w0x05kxddWvE01DFghiARylI5tQS/mOIwrm8UYZFVsDrX8Hu
   w==;
X-IronPort-AV: E=Sophos;i="5.97,298,1669046400"; 
   d="scan'208";a="223351472"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2023 11:22:19 +0800
IronPort-SDR: 2BupE+Igmv68uv8tJTh21cnGJvSX7XxykeMEYSW4QTtiOU8AqTTeHUdjrIS80y1UHvMnPpXSWo
 zDMlCnh1gcjECs8vE7qVAUcxJDZsfALR2bLrqg5pKxL5h8fMynsBgRph1gNbS3BmOUp/yD5oHW
 Zk5T2HDxZ9Ymdw9kpLubuTp0zwJJUDUpoyknhUKzXGX4t+kNFYDeK1c/b9P+7Uur2lr0fyyxkP
 /o9afVa5TVq3lNZszkG2jmIfWRL4s+OeuiJxq1aRt0gHGllSyDRgJTikO/E2o8hdDAuJ88+Slw
 DDg=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2023 18:33:42 -0800
IronPort-SDR: 14lMAcLt11FSymkIHX5gnHgepKNf/1hrFTn04WCZwCw+2G/XoiFql9EHuEsfZzM45N+lKUL8XF
 55tGWJpz4o+I/TUbjPLXt5F5tCI9MIHwMeFRVLp8cjm98pJyjrTaDmQhCfFsWkIP/y74Iv7hy5
 eQ55PI8ha/vdE4cwFZ5TWVUq3FhPCCsI1LaMT04bEbXjXcgOhDcnWcIOz/1B7LQFrAK+dm2tTY
 Y8/WsTbeOuJ5OSfJlPVlbqDKuK9EgL+ZdW1kPKRhbI57scTwtl3lVnMiBC98rVIM04tVwxt7q7
 czc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2023 19:22:19 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PGk0C55YRz1Rwt8
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 19:22:19 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1676431339; x=1679023340; bh=1vL+k2GBBnXNHmaxFg
        AGdZo/Iu3gdaY71xSDrxRY62k=; b=kBPdGaSqzO5tKuXy7ty2jjT/V1AGTrYOhz
        M6LDcBBHMtu0Pp/V4V2H1BfRr1YxCngQ3RhUpuA9B/IdttKb95AgJoOzz6fcg4u5
        hsGrVHg5rkmNmLzSS0SzNVfwHAJREaWWMq0C6QCUFzNq8eX116/a9vg8dh7teGk3
        Z8+BQDF4BiwTRkLW2uHiDTn82rQAe5tpcmwtzIp094C3ABwATUOrEajl/unGEVEu
        pBT1Xru34yqaeYDEIab2OIlZCDPKmxYGGX36ciudYyuAAbRWXXTQNVMmXaZF+eRq
        2HicUugsHWVCCStarv5K8y+7qfy8BUO/tonjZtnxqtAHwUrcE9+w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jCyoRjOAxzU9 for <linux-pci@vger.kernel.org>;
        Tue, 14 Feb 2023 19:22:19 -0800 (PST)
Received: from fedora.flets-east.jp (unknown [10.225.163.119])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PGk094jV6z1RvTp;
        Tue, 14 Feb 2023 19:22:17 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 11/12] misc: pci_endpoint_test: Simplify pci_endpoint_test_msi_irq()
Date:   Wed, 15 Feb 2023 12:21:54 +0900
Message-Id: <20230215032155.74993-12-damien.lemoal@opensource.wdc.com>
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

Simplify the code of pci_endpoint_test_msi_irq() by correctly using
booleans: remove the msix comparison to false as that variable is
already a boolean, and directly return the result of the comparison of
the raised interrupt number.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/misc/pci_endpoint_test.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint=
_test.c
index baab08f983a2..b05d3db85da8 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -312,21 +312,17 @@ static bool pci_endpoint_test_msi_irq(struct pci_en=
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
2.39.1

