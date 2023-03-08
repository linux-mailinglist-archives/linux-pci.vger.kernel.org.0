Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4586B024A
	for <lists+linux-pci@lfdr.de>; Wed,  8 Mar 2023 10:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjCHJEg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 04:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjCHJEc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 04:04:32 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82CB13DD3
        for <linux-pci@vger.kernel.org>; Wed,  8 Mar 2023 01:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678266267; x=1709802267;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fRrs/340bIvCq/+Ph+3JgCm2ZB+BGr+A5wzPz1zbALc=;
  b=OoGQBym/+oMsffsQTgAHrPvmCV4KDc6RZ57MXePHH5J4FnbAvDLKHdwT
   MkYpwXRL+Zy2h8mDwBWG7oWsJyc2mDSYqSkYiXDutakF30d8wAk/DIQ27
   NnEWg4Vh5quZZe1QGulFOJ+g4SkJJTxzrfhPNuvdlhzPurmiVkxYHp3we
   ZpACC+qWlv42nesUc/HUvLlKbZonELN+tSzXr/czRFFf0bznaqoaZPQJQ
   zjW8YNxwPu/crq+KZCDRv4iH5g9JjGVZhRiONzwL9e6AXGG1bt2QovDch
   CPDeZCLhWvHGiZLpOWo2EDRyHOFmVUCUvLX4ABEw41WpCtBQ1L3C0WEKN
   A==;
X-IronPort-AV: E=Sophos;i="5.98,243,1673884800"; 
   d="scan'208";a="224880561"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Mar 2023 17:03:32 +0800
IronPort-SDR: jPqAhkaJRSWnTCapLbCw8wk55UDCemJIHknk78p5xE/ULmEa4CvFkPVWUhN9vktTodMgGhDArr
 iPXhSsaZ2yqePuGsYOPl0r9NJt8SHRHm1MT/J5CxWx94JkC8EHMJUFPrhU96PXRTBLffIg4ZOZ
 e78HGv7rGIHNQ8ZFI2vvAvTj8G1baAhYBD/Imm1kKikeq7/zB2F4B3oidC3hzGQzqi7AUABGBB
 4C4oqysKLncSJTywpqTS9O3KCvJZLIv/1ZZWhMNTqWVwRKt6cfHn6V5usbtEaNyALvsVidBAoS
 ap0=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Mar 2023 00:14:29 -0800
IronPort-SDR: QC3TpMyI/W/Pe8/cbX8QVeKXoQNBNlYc8sbawRDxTf339giMLGskFD1MvkereqT9O2H2rMfDQy
 9kPXbQHqwVMaHINZYwWUQ5Wk/SM1+RHdWCAGrTDzTVat0wd3AYqRzntz72/3E0DFEw85n/roqV
 FgjtHtC2LLM5OYeqzSRYHBG7qZVnttf/ewbEwq1w+wIQh4JQfMBL72ztIvxNiQrwEXF67cp9E1
 ofiPJ9bP4Q5E2NdG/73JIa+2A4v2jPpx6Nq+gjWSKEbKipsp5gQmuQGWB366KNMSMGpcy7tZ4B
 aX4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Mar 2023 01:03:33 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PWmZD1Xqqz1Rwtl
        for <linux-pci@vger.kernel.org>; Wed,  8 Mar 2023 01:03:32 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1678266211; x=1680858212; bh=fRrs/340bIvCq/+Ph+
        3JgCm2ZB+BGr+A5wzPz1zbALc=; b=LLDOb8s2b++pJl0bnRKn+tF68bwafaFH2B
        g2cYOQw45lwDb+usErfnkYgbNLrDwza0oTI0mbVBzDDwQKP4Iv1ui83Arxkw4Qiw
        LZwxpF9+dpGKSNLob6i7eUvqTjHWyp4Xqu3LkHr8m3mBhOfihkR9k9OZ/NiHeDKb
        i5XETXWPCZyE8pjxl6c1z2+dN9f+ljXuuzYljSH8RRQypc+6tn4qCO7fpOSyoq8R
        6SH8CXmLHy6rdmHHUJWrmtqQaQiqu4r32b+CuYpknRd2uKvuL2nFBwd8+a+eQpMx
        rLD2Jh7jp/9uxU5WM5m32HQx58bawZ+rrw2UxUfKZSD9np50qeIQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xs_yrhurhnjG for <linux-pci@vger.kernel.org>;
        Wed,  8 Mar 2023 01:03:31 -0800 (PST)
Received: from ephost.wdc.com (unknown [10.225.163.68])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PWmZ95dgHz1RvLy;
        Wed,  8 Mar 2023 01:03:29 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 08/16] PCI: epf-test: Simplify IRQ test commands execution
Date:   Wed,  8 Mar 2023 18:03:05 +0900
Message-Id: <20230308090313.1653-9-damien.lemoal@opensource.wdc.com>
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

For the commands COMMAND_RAISE_LEGACY_IRQ, COMMAND_RAISE_MSI_IRQ and
COMMAND_RAISE_MSIX_IRQ, the function pci_epf_test_cmd_handler()
sets the STATUS_IRQ_RAISED status flag and calls the epc function
pci_epc_raise_irq() directly. However, this is also exactly what the
pci_epf_test_raise_irq() function does. Avoid duplicating these
operations by directly using pci_epf_test_raise_irq() for the IRQ test
commands. It is OK to do so as the host side endpoint test driver always
set the correct irq type for the IRQ test commands.

At the same time, the irq number check done for the
COMMAND_RAISE_MSI_IRQ and COMMAND_RAISE_MSIX_IRQ commands can also be
moved to pci_epf_test_raise_irq() to also check the IRQ number requested
by the host for other test commands.

Overall, this significantly simplifies the pci_epf_test_cmd_handler()
function.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 43 ++++++++-----------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/=
endpoint/functions/pci-epf-test.c
index 6f4ef5251452..43d623682850 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -615,6 +615,7 @@ static void pci_epf_test_raise_irq(struct pci_epf_tes=
t *epf_test,
 	struct pci_epf *epf =3D epf_test->epf;
 	struct device *dev =3D &epf->dev;
 	struct pci_epc *epc =3D epf->epc;
+	int count;
=20
 	reg->status |=3D STATUS_IRQ_RAISED;
=20
@@ -624,10 +625,22 @@ static void pci_epf_test_raise_irq(struct pci_epf_t=
est *epf_test,
 				  PCI_EPC_IRQ_LEGACY, 0);
 		break;
 	case IRQ_TYPE_MSI:
+		count =3D pci_epc_get_msi(epc, epf->func_no, epf->vfunc_no);
+		if (reg->irq_number > count || count <=3D 0) {
+			dev_err(dev, "Invalid MSI IRQ number %d / %d\n",
+				reg->irq_number, count);
+			return;
+		}
 		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
 				  PCI_EPC_IRQ_MSI, reg->irq_number);
 		break;
 	case IRQ_TYPE_MSIX:
+		count =3D pci_epc_get_msix(epc, epf->func_no, epf->vfunc_no);
+		if (reg->irq_number > count || count <=3D 0) {
+			dev_err(dev, "Invalid MSIX IRQ number %d / %d\n",
+				reg->irq_number, count);
+			return;
+		}
 		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
 				  PCI_EPC_IRQ_MSIX, reg->irq_number);
 		break;
@@ -640,13 +653,11 @@ static void pci_epf_test_raise_irq(struct pci_epf_t=
est *epf_test,
 static void pci_epf_test_cmd_handler(struct work_struct *work)
 {
 	int ret;
-	int count;
 	u32 command;
 	struct pci_epf_test *epf_test =3D container_of(work, struct pci_epf_tes=
t,
 						     cmd_handler.work);
 	struct pci_epf *epf =3D epf_test->epf;
 	struct device *dev =3D &epf->dev;
-	struct pci_epc *epc =3D epf->epc;
 	enum pci_barno test_reg_bar =3D epf_test->test_reg_bar;
 	struct pci_epf_test_reg *reg =3D epf_test->reg[test_reg_bar];
=20
@@ -662,10 +673,10 @@ static void pci_epf_test_cmd_handler(struct work_st=
ruct *work)
 		goto reset_handler;
 	}
=20
-	if (command & COMMAND_RAISE_LEGACY_IRQ) {
-		reg->status =3D STATUS_IRQ_RAISED;
-		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
-				  PCI_EPC_IRQ_LEGACY, 0);
+	if ((command & COMMAND_RAISE_LEGACY_IRQ) ||
+	    (command & COMMAND_RAISE_MSI_IRQ) ||
+	    (command & COMMAND_RAISE_MSIX_IRQ)) {
+		pci_epf_test_raise_irq(epf_test, reg);
 		goto reset_handler;
 	}
=20
@@ -699,26 +710,6 @@ static void pci_epf_test_cmd_handler(struct work_str=
uct *work)
 		goto reset_handler;
 	}
=20
-	if (command & COMMAND_RAISE_MSI_IRQ) {
-		count =3D pci_epc_get_msi(epc, epf->func_no, epf->vfunc_no);
-		if (reg->irq_number > count || count <=3D 0)
-			goto reset_handler;
-		reg->status =3D STATUS_IRQ_RAISED;
-		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
-				  PCI_EPC_IRQ_MSI, reg->irq_number);
-		goto reset_handler;
-	}
-
-	if (command & COMMAND_RAISE_MSIX_IRQ) {
-		count =3D pci_epc_get_msix(epc, epf->func_no, epf->vfunc_no);
-		if (reg->irq_number > count || count <=3D 0)
-			goto reset_handler;
-		reg->status =3D STATUS_IRQ_RAISED;
-		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
-				  PCI_EPC_IRQ_MSIX, reg->irq_number);
-		goto reset_handler;
-	}
-
 reset_handler:
 	queue_delayed_work(kpcitest_workqueue, &epf_test->cmd_handler,
 			   msecs_to_jiffies(1));
--=20
2.39.2

