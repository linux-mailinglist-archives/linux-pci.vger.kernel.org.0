Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32FA26CFF3C
	for <lists+linux-pci@lfdr.de>; Thu, 30 Mar 2023 10:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjC3Iy0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Mar 2023 04:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjC3IyY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Mar 2023 04:54:24 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66605420F
        for <linux-pci@vger.kernel.org>; Thu, 30 Mar 2023 01:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680166460; x=1711702460;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mxCZujNEUTbNED023BSGdq18vAZhegc8Tr7mjQSp0FE=;
  b=fz0D5LGC9e9PUIIFBVAn2lP1RzC6f7F7bvT1GlihiexghIneA/vib85G
   BnWB5Lx0PbqAVm4jnrwbTknQHmSyVQeS4SQbBnnlG36/TzpBbd1JbWtqU
   K7qvThOPEdeOZIlP/ape+Kr9Sgt/Zt6rWX2gzN2M4eNhBhZXRkdTMOAnk
   T/mvj+vmODHikjhkkNjeGVZqPkMWyMZWu2QQaplbURiOxhGE8588Z11qQ
   cUs74/jYK89nPMFRLHsevFuE6xl9T9JqFRTchpikOYXbWaM+MTAEOQLuG
   6pFumgc5zAV2CxUxgROHrPRfRF6NaWbwk4i1KCpIBFVaBlQrmsGYgwDVG
   g==;
X-IronPort-AV: E=Sophos;i="5.98,303,1673884800"; 
   d="scan'208";a="331310473"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 16:54:19 +0800
IronPort-SDR: 7eaByLetD4HQUrndY8gP/LFE8b1I1Y0uinWFdFOS/ZmOCc9QG757e5nbsmeS/VcVQGsgY3Cm5o
 OLMkJ5tamqLuSoDx5LsQAHRyPuJQ0k1DLIA+yU43gMPsOcq34N2qXd6rLSFQQ8SRgr2lrbhVv3
 H9juJ7HIMbPR8pu/al5rn4VNflFR8eHXNKLHfX+Ws+RDEuXEUBrHh80okWom0rXqZy4wXuwKG6
 CnbqhSfCQ2JHiLW8Lf5kSlTumvXRTKybfOIGOqWvkilVbSQ8ZhFyCjtet1sVh+TJCS6V3pvaMO
 ubA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 01:10:28 -0700
IronPort-SDR: Rcr35KPj/y1OXHigoVKlAHAfJ5T2kHT/Cj4BfSsbX9nyr81AvEtId68pyaGWxJLyI/gJqWJR8g
 7mQFbGx7xUnE6J4qVtozAxi9WHmepYJM4i0oe+uuzuLYYIi4AMzUuVkWc72PjqK2NiNN3KmEfz
 vDtm54UWB9fwc06K3LxQZfCiblJxKgkdYVFsdSMKttfOy6Kj7XAmEs9aLb0qkCnsBUXZXlcY20
 BZnFE1DpyjC2TgXeAbDAUtYQJVKJ5YBlQGz4w+9HeGtLZ4UeY7rNjkDadjAcklBOne+k5vjxhb
 MFY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 01:54:20 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PnHKR3q8Wz1RtVy
        for <linux-pci@vger.kernel.org>; Thu, 30 Mar 2023 01:54:19 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1680166458; x=1682758459; bh=mxCZujNEUTbNED023B
        SGdq18vAZhegc8Tr7mjQSp0FE=; b=fHhJ7yGQToP2N4LbTSpr5wnoxYS4GSfFU5
        /VCBi6Q+kC9+CYm54NVyDfEMp8OPE5Yb+/mPmitlLoSrDm9K0FmGOK776RGXIG87
        QbHEfR5xvBt0m2pDntbUDTYPbqKVZ5vJCivRoxHfEm48Wxel3CYMvS7jM5h/jgEA
        dvgCj5L6Lx0yNNulU09e+61QtRQklkTeJ0nSLyob7pHwZwR2IOPuJkQmIAO3072+
        gakipZdf6f49tnCpsbRGub5SXNzEW6j6tiBPsmtQJImF0yUlDghAQPzSel+/gK2F
        xptWiY+sPko5Ls6yumjtcF6PloY/wpm1yTpexEeStve5dzhMAZkA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RQQfRiQlT-Xc for <linux-pci@vger.kernel.org>;
        Thu, 30 Mar 2023 01:54:18 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PnHKP22P8z1RtVp;
        Thu, 30 Mar 2023 01:54:17 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v4 10/17] PCI: epf-test: Cleanup pci_epf_test_cmd_handler()
Date:   Thu, 30 Mar 2023 17:53:50 +0900
Message-Id: <20230330085357.2653599-11-damien.lemoal@opensource.wdc.com>
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

Command codes are never combined together as flags into a single value.
Thus we can replace the series of "if" tests in
pci_epf_test_cmd_handler() with a cleaner switch-case statement.
This also allows checking that we got a valid command and print an error
message if we did not.

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 30 +++++++++----------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/=
endpoint/functions/pci-epf-test.c
index fa48e9b3c393..c2a14f828bdf 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -676,41 +676,39 @@ static void pci_epf_test_cmd_handler(struct work_st=
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

