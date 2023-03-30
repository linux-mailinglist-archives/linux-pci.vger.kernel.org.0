Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C688F6CFF34
	for <lists+linux-pci@lfdr.de>; Thu, 30 Mar 2023 10:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjC3IyQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Mar 2023 04:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjC3IyP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Mar 2023 04:54:15 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FC63AA5
        for <linux-pci@vger.kernel.org>; Thu, 30 Mar 2023 01:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680166454; x=1711702454;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J/a1XPwL+xSkbmNIxhIJYkrLti8dXBeJ4FmvtofrtKI=;
  b=bNcAsa/3g6AXKz/Gpk3JYZLCKiw+vWbLokFsy4mNrakMDk2mJ66u2N4U
   JwP/YMtomqtJcD/rlhcQA7xTAcbaJo8HOQ3xZbqwGamWyCsLrKhkwzSoL
   2wgPSfETC/zVFUu8sCFKL2F3uDk1Pz4euxkGvyo7QfHGpWBfgHBqL+q5G
   +Oy46dPOpfUppZtMRccO1GZTJjr92YW1SodzbeTV1gq8LZu+dWy+yQ+X3
   IJHD87ybRbGjCMObjlIEcwl5lEHDL5M+5ZZqcnwvCcboLR7HCFmpVuINd
   CUYAcRq+V0UwJfuYCDFLpMccNZWCCLk7LiBx0zkZnLHT3NW5fmSYYusoJ
   w==;
X-IronPort-AV: E=Sophos;i="5.98,303,1673884800"; 
   d="scan'208";a="331310451"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 16:54:13 +0800
IronPort-SDR: b0dmW0FLt+vseg+fRo6IHeo1o3iQIlQKoncS/7rYWjTGcWDggYSIfv2w6z+/xY+R2rq6km2ZuD
 QMu92VrFuoKYyyoI3zlKaJYirL/EjWVWPj3wjM6IYej5wZ7nCfx5HCN0TRATmgzgFuttsh9XK8
 70eyDVMFjz3v0Kzyo8kYdRe3s5Q/e4piZwX2jjOFI0AyNW3wA/kuXhXDyTOPUgp7YUt8sVaGiM
 IDPzR4gPcdO738xgoRkAEvJXHwmIPTSavLPhipbkp8+lF6ElspKrApQG53LJWPJ23tuZQgdd3T
 kA4=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 01:10:22 -0700
IronPort-SDR: xpQYWOxgu/Z+woLcOwONcDpAZYgdPX4WAw7a2VDOtpww5L555a6lKX/a5EFYWYQFpSvA7a5VBo
 JnRdp/1NyFztuLv8scD35w2fAx+xJzpV/oji+6pgmGe82w1qDtIwkxAvpxihx5nNz8A5Vbycg0
 MeYiX+yKCyAGm1/RxkXha4QKir1tn2wPG5isgzmFe9dVZO9XG/khfoiYBqZwHfVEzurVNMj5PC
 ol5JAEku+jPrLsjUdcLK1bca1ZL9LRcw04zu2gyhXSuOpA1w762kGGBdQ8nrcL4n7UPNL1RWIS
 ne8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 01:54:14 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PnHKK5Wh8z1RtVx
        for <linux-pci@vger.kernel.org>; Thu, 30 Mar 2023 01:54:13 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1680166453; x=1682758454; bh=J/a1XPwL+xSkbmNIxh
        IJYkrLti8dXBeJ4FmvtofrtKI=; b=ECIwQyBM3X5Euzy28NsaWD5jxwSozBDFtf
        UYHrLTbI9WOcg9EDo+zEzGfjVbaoJ+y1lU9jPyL/PcjgrXiqUhE++Ga4Onx9OKVb
        XF3lPdUVmCabrbQCivlGxfSOxB984ecbxvAsm5hRcmUbNnNnGf2danZF/GTw+MzM
        1qEyTB9RHKpx0zwsAeQ9CYzaHhGP/qwh7tUSGsXqs2nB9/l4h/I9D+EFtEx7/zVe
        t9AL80XpTHgY1fRCbE+NSvycyB6IvNTa4tUr+jHbAhs21z+X/OGY5t6nuhLOTVvK
        HW+1qRr8OFvBhN1I2+HJixOUFol/M8bB2JK9AmpTwUZZVn9uBzEg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3wdQtvFm7T4s for <linux-pci@vger.kernel.org>;
        Thu, 30 Mar 2023 01:54:13 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PnHKH366Cz1RtVn;
        Thu, 30 Mar 2023 01:54:11 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v4 07/17] PCI: epf-test: Simplify pci_epf_test_raise_irq()
Date:   Thu, 30 Mar 2023 17:53:47 +0900
Message-Id: <20230330085357.2653599-8-damien.lemoal@opensource.wdc.com>
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

