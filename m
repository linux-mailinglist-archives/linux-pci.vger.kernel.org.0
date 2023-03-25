Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1056C8BFE
	for <lists+linux-pci@lfdr.de>; Sat, 25 Mar 2023 08:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjCYHCq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Mar 2023 03:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbjCYHCp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Mar 2023 03:02:45 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162CB15882
        for <linux-pci@vger.kernel.org>; Sat, 25 Mar 2023 00:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679727763; x=1711263763;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J/a1XPwL+xSkbmNIxhIJYkrLti8dXBeJ4FmvtofrtKI=;
  b=B22xgbGqvRO9+EUWGO00Xnsh8Gye/QVvKruEY1AAD/tK2N8fZC0QzzR7
   c+oqVSRNEUbC9I+Fd5LvhutZjO25IHbVm3uzsyulZyFkOt1YNSWSXFvbx
   XM1rkDZIRLTqyhXTnlO1LYuvzAtEwakpCJZhnUomfQm2xvBQxGeY8MyT2
   aOLiOiOr7oqWgHBUueDO4vJ5umMcUaKg0p9eqlLlfKmHgYb1HYAqSkYy8
   mfL6mqg09fF3k6WN9Of5lzSwK6Ss00CFZbp7TtntsxSOnEcBQat6WAlZh
   uuLIHwhw/HFN01IxDE0OFq2W+zJizGrRGZdoMpmFAtnbOk9A+9n7WwTUe
   A==;
X-IronPort-AV: E=Sophos;i="5.98,289,1673884800"; 
   d="scan'208";a="224756795"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2023 15:02:43 +0800
IronPort-SDR: GC5yQSVtuUuBT+RUddMyEtxSJ523zIKuPSUrjYvIisLEA3pfeWxTGhrfuF51wUf0xTCNtt9RsS
 bRgCuBwWce98nK+M+PStTVzeBnv8UX/JoI0hCtEOQiGr22dJSfdjdHBVGlXUK4hlEwl0ruPYJa
 BB8Bvkyr+a5NHEu+00KKoC7ha5gL/9DwIVA6EN4RtBtOCm41rj6bofbRL0crYm7fHQnI+daBMM
 FFCucvUZ45z56MWkxq0HJUyE5QWCI6WBh3P6tmiC2ZzW6Fl+StyG9RmUWLGorC6viO9K2nWDRi
 /d0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Mar 2023 23:18:58 -0700
IronPort-SDR: c2q8SaOz/kPwhKE5g/h0O6nxnEho124mp4XriLdSqijaApaIrbbfaine1FfeFjtHHBDZr2CvfH
 apYMAor6REEyWY1m362s/Ua+TclvgTNchj2ki5qnA9pmqzKglstflIQ0q1doz/7JwfS5FGjjgC
 nV/UqKwTCA5XObOFM6sU8zhRudUFlIN14bhbk9vvL7AIMUE8l/xHXRtE3O/Dkb9RjAu6ZrhNfM
 guaBjOjA1DffRJsQ4s/GU3/Ocv135ui65xpmebHp8wC5m8HqQ70/hfmjwYkNrj+1RMgnV/jtqV
 q/Q=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Mar 2023 00:02:44 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pk94z2hdjz1RtW0
        for <linux-pci@vger.kernel.org>; Sat, 25 Mar 2023 00:02:43 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1679727762; x=1682319763; bh=J/a1XPwL+xSkbmNIxh
        IJYkrLti8dXBeJ4FmvtofrtKI=; b=ErpSNvL+jGfnqqLqQn+/QHDaiidQDcOs/n
        0qE3jJgGN1O+ZN6jPfeKfzGvv+sV+Xm9xQbMPMzBw+tWfKc8oPxjH4+ydg+ojYG8
        XrptPtDHAY86CTM+KWSZpzCOKKXhiD2gIlYYz3cNDHoXN9TtlBUDOWt/pdO6I2+b
        FeRtpI/CuJU1v/7sjiYfIfPRCFa88s6nC6IxU2fOif0oYbgN1ijAjAfouiFQuaR6
        tmT8TAs4ryq8/i14j5xZFr9BxPUkY3A8OQLQ7dbeIketMql2ZSsuhtnQpZwPd0I3
        MZTEMyRy9ltk07vR447NImNlvt/A+W43qR/wCrI8AOZUt4JKT9hQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QTBnAcb7mLx5 for <linux-pci@vger.kernel.org>;
        Sat, 25 Mar 2023 00:02:42 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pk94x007sz1RtVn;
        Sat, 25 Mar 2023 00:02:40 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 07/16] PCI: epf-test: Simply pci_epf_test_raise_irq()
Date:   Sat, 25 Mar 2023 16:02:17 +0900
Message-Id: <20230325070226.511323-8-damien.lemoal@opensource.wdc.com>
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

Change the interface of the function pci_epf_test_raise_irq() to
directly pass a pointer to the struct pci_epf_test_reg defining the test
being executed. This avoids the need for grabbing this pointer with a
cast of the register bar and simplifies the call sites as the irq type
and irq numbers do not have to be passed as arguments.

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 21 +++++++------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/=
endpoint/functions/pci-epf-test.c
index b8b178ac7cda..3835e558937a 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -607,29 +607,27 @@ static int pci_epf_test_write(struct pci_epf_test *=
epf_test,
 	return ret;
 }
=20
-static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test, u8 irq=
_type,
-				   u16 irq)
+static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
+				   struct pci_epf_test_reg *reg)
 {
 	struct pci_epf *epf =3D epf_test->epf;
 	struct device *dev =3D &epf->dev;
 	struct pci_epc *epc =3D epf->epc;
-	enum pci_barno test_reg_bar =3D epf_test->test_reg_bar;
-	struct pci_epf_test_reg *reg =3D epf_test->reg[test_reg_bar];
=20
 	reg->status |=3D STATUS_IRQ_RAISED;
=20
-	switch (irq_type) {
+	switch (reg->irq_type) {
 	case IRQ_TYPE_LEGACY:
 		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
 				  PCI_EPC_IRQ_LEGACY, 0);
 		break;
 	case IRQ_TYPE_MSI:
 		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
-				  PCI_EPC_IRQ_MSI, irq);
+				  PCI_EPC_IRQ_MSI, reg->irq_number);
 		break;
 	case IRQ_TYPE_MSIX:
 		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
-				  PCI_EPC_IRQ_MSIX, irq);
+				  PCI_EPC_IRQ_MSIX, reg->irq_number);
 		break;
 	default:
 		dev_err(dev, "Failed to raise IRQ, unknown type\n");
@@ -675,8 +673,7 @@ static void pci_epf_test_cmd_handler(struct work_stru=
ct *work)
 			reg->status |=3D STATUS_WRITE_FAIL;
 		else
 			reg->status |=3D STATUS_WRITE_SUCCESS;
-		pci_epf_test_raise_irq(epf_test, reg->irq_type,
-				       reg->irq_number);
+		pci_epf_test_raise_irq(epf_test, reg);
 		goto reset_handler;
 	}
=20
@@ -686,8 +683,7 @@ static void pci_epf_test_cmd_handler(struct work_stru=
ct *work)
 			reg->status |=3D STATUS_READ_SUCCESS;
 		else
 			reg->status |=3D STATUS_READ_FAIL;
-		pci_epf_test_raise_irq(epf_test, reg->irq_type,
-				       reg->irq_number);
+		pci_epf_test_raise_irq(epf_test, reg);
 		goto reset_handler;
 	}
=20
@@ -697,8 +693,7 @@ static void pci_epf_test_cmd_handler(struct work_stru=
ct *work)
 			reg->status |=3D STATUS_COPY_SUCCESS;
 		else
 			reg->status |=3D STATUS_COPY_FAIL;
-		pci_epf_test_raise_irq(epf_test, reg->irq_type,
-				       reg->irq_number);
+		pci_epf_test_raise_irq(epf_test, reg);
 		goto reset_handler;
 	}
=20
--=20
2.39.2

