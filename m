Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9776B024D
	for <lists+linux-pci@lfdr.de>; Wed,  8 Mar 2023 10:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjCHJEj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 04:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjCHJEc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 04:04:32 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54602CC40
        for <linux-pci@vger.kernel.org>; Wed,  8 Mar 2023 01:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678266267; x=1709802267;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=638WqZK8FgjF4CUXeYsyIP0jDJjPgD/t0ydHPdvUXp8=;
  b=DnNnKRiJjRTIi8W74KJogpfkyB6Ohin5I0XTI4Dkh8g7MVcVu6xIdt8A
   7O7pDzUGCoE4tQ17cfCpNv+YF8nw2Jw9uenKSRgUzP4gbR0tRjXf4/DOJ
   b/AWTf+0FC8YZHdagWS4iRWjDmchwReLbIrsOGJhSPKAYlMuuRFdiBTfu
   BlrFL8UMopEs7MMF9sZhJEXGzp7OnXay+xRa0RspKJWelLE17+IEr+INS
   ZUcbRy3NXdeQLxjDaoebaUx9BATuq6UIf2BveoBmUUi1DaPLTxbkA6XrF
   X+I8K71t6yjSqQTTmOAsoWN+qqzYzeILzwVf/M4GIgBR7x1fOV7uHT5KY
   w==;
X-IronPort-AV: E=Sophos;i="5.98,243,1673884800"; 
   d="scan'208";a="224880555"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Mar 2023 17:03:30 +0800
IronPort-SDR: ZjjaT7ZYro8MwX+88/alwuM5aLOWXWdT5GC919RXV1tqmf/rFHdVvbnCt2pQGayrUaAKP8GMbK
 wKHN2rISAmp8Kl4rwf58AlIHLgG65p2pSosezS5u9BguM129O8+shlU+erjllJmMhsGF9QPWxp
 3UgWqEEakoQ/agUQFbYCD/xA88jiAGmtSQY/j4ww73CF8qfht5F2c52wNnAYIQd/3oEdqlV1a1
 gjbpOONPilZErwdCd27m/MEkClkr2ZbLolJtqmWE3fSIodDBa3iuiJ1odQuLm8xmrZHUKgWDzH
 3rg=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Mar 2023 00:14:27 -0800
IronPort-SDR: abzDq5aGUpSpeS1c6Pa6w+qyr9Y2/ZnJL2DIbtx0Or7vqzO6m2utsBjN3cOeuJWr+LhM5UBygF
 RIVi8B4HMDzwXItoU2/klTjSKvSsYZNXTc1G+1UdU4XcN1TemDXjxP3qpM0NwACILwQis55bbx
 VpQyruZySqgpAa36/ATO9z9yqn81voNfskW/rCELfpexJZ2vPXlgGMFhWK4h8fb2fumsIXqi8a
 gNU2iYYyd+5Ier4+RW0mrXKbCHbCdRv0B+VHbD+eIWZdPjahdBleKtUJTXrkRlyOus+eNErmDR
 psQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Mar 2023 01:03:31 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PWmZB0dF0z1RwvL
        for <linux-pci@vger.kernel.org>; Wed,  8 Mar 2023 01:03:30 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1678266209; x=1680858210; bh=638WqZK8FgjF4CUXeY
        syIP0jDJjPgD/t0ydHPdvUXp8=; b=kOTavP7PnpaDpcbHPruSLqGSKGeDlRG74n
        eOqP/v75TssGQel256JObWptD5uWkMLeiDW6gWfWmG4PYqCzjrKdhBZ3xveHN7wG
        jg7jw0KwnWDouaqABCp1tx+ph7OKk22naHuwNzv7FTE2t85aUASVW8CCR67UHDa/
        Xg9JS9gwlV6KNWGqAVY9FiDVAYg6ZeYYBveXNE2iKxbCUkMj7rM4KvAS7BEOY+Nj
        hzPwaQ4cLQOdQgPoim5+BV0eqxXl6lj9ihocp2r/rln75yn0TfEYBxuLFkEcm2Vu
        xvJvARITuFyHKoanDgNqbKxhlH+KwSo4aJuo/3i4Rq0XSRgLDPJg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OzJtKNdo46GU for <linux-pci@vger.kernel.org>;
        Wed,  8 Mar 2023 01:03:29 -0800 (PST)
Received: from ephost.wdc.com (unknown [10.225.163.68])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PWmZ762Dpz1RvTp;
        Wed,  8 Mar 2023 01:03:27 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 07/16] PCI: epf-test: Simply pci_epf_test_raise_irq()
Date:   Wed,  8 Mar 2023 18:03:04 +0900
Message-Id: <20230308090313.1653-8-damien.lemoal@opensource.wdc.com>
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

Change the interface of the function pci_epf_test_raise_irq() to
directly pass a pointer to the struct pci_epf_test_reg defining the test
being executed. This avoids the need for grabbing this pointer with a
cast of the register bar and simplifies the call sites as the irq type
and irq numbers do not have to be passed as arguments.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 21 +++++++------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/=
endpoint/functions/pci-epf-test.c
index 1fc245d79a8e..6f4ef5251452 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -609,29 +609,27 @@ static int pci_epf_test_write(struct pci_epf_test *=
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
@@ -677,8 +675,7 @@ static void pci_epf_test_cmd_handler(struct work_stru=
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
@@ -688,8 +685,7 @@ static void pci_epf_test_cmd_handler(struct work_stru=
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
@@ -699,8 +695,7 @@ static void pci_epf_test_cmd_handler(struct work_stru=
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

