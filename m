Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542276C8C08
	for <lists+linux-pci@lfdr.de>; Sat, 25 Mar 2023 08:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbjCYHDI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Mar 2023 03:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbjCYHDH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Mar 2023 03:03:07 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB3AE071
        for <linux-pci@vger.kernel.org>; Sat, 25 Mar 2023 00:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679727782; x=1711263782;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p+MxxNmS9DVwNUcLA55VvIMV4ImTHL2q/nFJco681WM=;
  b=VWl8kGbiDFRxXf0sDaHEstrDPpQY4yf5Qd9vYgL3EfM/mINilMFe1/j+
   Ak/rFlUUxNNzFnil+2sRB4OSmVofORyR6w9zUMqnbuxOl4Kj5gkYMeybC
   u3/qIK57kaL0cruOuT1gZB7k7wCKyqn6SEgazj6TkPk+Sm5FAIqB/zj0Z
   bEU4fjTQ/CiQcIDnWwcij4zTAM5X07Ol+smlMpCW8UlwTH5BtFWBlvdt+
   D6wyINVca2rfzXm7ASsIJZLdTRqESbsw2Oojqy7A4WevpARlKKEXW8czu
   5KvMNPU7n3LQ6jA5jdtBKFrvfaYZHXerYyI7uLqVOEwz8NRbygRJqRoJc
   A==;
X-IronPort-AV: E=Sophos;i="5.98,289,1673884800"; 
   d="scan'208";a="224756931"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2023 15:02:59 +0800
IronPort-SDR: HvLVtuQ2GuoomnmtmE/gEGpf87Q02v548I6E5nRB0lzqIQGmbcqr8y9nrMNb2wHJAIMjwqTQSn
 lmbn3GZxauMPsuel/j/9HDSgO3jwexDX63Z1i9q6i2agfH8Jmj0e+0DXy8b5nR7+HtWv2sr9BF
 PN84vMn2DIydwJYMpHPLZx8ZInAvW3rxAkd6K6RzU9R3q2GuHN8WEPl+jeKZLMNFer4psH39u9
 A9e8Nyy8GJGblJ0BQVvI79Z34jHJkb8L4n2WWKRp81FS2d7SsZzfu3uxwCAmz0fhi9uk0scVXk
 NP8=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Mar 2023 23:19:14 -0700
IronPort-SDR: vuG0wFlbc5jJK/xT3HAm1SyFBDC9XttmtDyhl3n0Dfi5W/dS/79JpWWBPwMJNvE8UZFhXzJ967
 GwEyHBclQYIaK10fFy2djj3R6tPp6jP5CAUufB93P09FRGo9xaZ9sx2nv/R++K0NmwRIlfctaK
 v5norezaqbW+3VuS6czkIrNOiyD5GwzQCf0Iiw2Kl5/ZiIW0pvADfYcx/ABz/NfP44Q884rZIo
 B7HDslsxiZclfxAJHvCxxDD2FWLfBspaRsUQFtTbiOnH7EPybfHZTVG3A9AXN+o4ZGIXVCgOiO
 c+o=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Mar 2023 00:03:00 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pk95H3yQsz1RtVw
        for <linux-pci@vger.kernel.org>; Sat, 25 Mar 2023 00:02:59 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1679727778; x=1682319779; bh=p+MxxNmS9DVwNUcLA5
        5VvIMV4ImTHL2q/nFJco681WM=; b=F7gOef9JVRsRe0kzwgoFYK3QAFQZSpvaV/
        1vkTlkWbmJvzkWvpF1Kh8yjEBbSM1FHeatjONlTLshkweIQ+/Sv8Fknzm18cO70M
        /9RZyTERvc0IobleB5GFquG9BNJqFM3iEq2HbNYm/4ytliF6CoW2tygVNpUvs7+4
        Jwxf7jlNzLfykDMjkCB5MumHRVv7VRE+Xqu03FzutaVrt5xz0KCIO2+P2oRscUy7
        SDpw3djl5pNo7Bz0nrckJwrL44CunqYqPBCG35l+vd5rwweL0Afe8WUrRdQvQWxJ
        Urd1n+Qme/f3HyFmkc94FGBY5itSQkJKIb1jw49ZGHc14kS167zw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OFEOvCaWvJVB for <linux-pci@vger.kernel.org>;
        Sat, 25 Mar 2023 00:02:58 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pk95F39cdz1RtVm;
        Sat, 25 Mar 2023 00:02:57 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 16/16] misc: pci_endpoint_test: Simplify pci_endpoint_test_msi_irq()
Date:   Sat, 25 Mar 2023 16:02:26 +0900
Message-Id: <20230325070226.511323-17-damien.lemoal@opensource.wdc.com>
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

