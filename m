Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDBE6974D5
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 04:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbjBODWV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 22:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbjBODWS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 22:22:18 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D998234000
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 19:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676431333; x=1707967333;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yy8bnIircEMfRxG6DHZUyEhd5BscnXdzmdZ5rinTOmA=;
  b=GVmfN+jJuWDcb8XKCohgV9EG0hrtSpZPV49KAwQ75aiT4j+g9RI2TsBt
   rhtv5xdSt473IDgJTyHFrG118eTahXGaBFNTuPhLMozigl+0SDoIBPnnk
   2YWt5kdEUhuRI/v1HMe1bXFwq8m9UVn7hNsniaDsicOfiKwZuQl1BNYCT
   lnwIdbUry/tIhbNEklaICu1jaGwxQBeMRxm4okkfQCjq09h7nhYALJb8R
   kP5BFJu1Tfu+ucMHUehUvVYzGl9s91ZfJaK/waWB3/QuLHPr9EoSBChE8
   FiRhhKW1IFqiFCDBM8GBHW+7DgW/sH4qVZCDt2GsPvvmZQhd/Z1/sYD1H
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,298,1669046400"; 
   d="scan'208";a="223351459"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2023 11:22:13 +0800
IronPort-SDR: K3W1e2eSI2KHr1TCeXH5erZLn6UAR3Hj+HI1DcA3iseTZDmWTL+33nHi8mNU+yMBfmcjSmDKfW
 CjmaqkkKrChCaiCi6aNXVwVLb4os+pxBBP1XW1KFeH/14JyiUlnnGHx5gvD6fyorskCTWHgcRp
 Qi5G0WpXDcNvCjrct4ZWoniPxiIaJez0OwMiX0Ah8G8r5FNP4F23BhJJyVi7DJa5R7ZyFYruFE
 scUcIL46vIO4IYXNHky02ZG0MF6EVi+85O1ie+3RkwgZgQVkCq1arOsXIX7ebBoSCyt0Wb9/wY
 mus=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2023 18:33:36 -0800
IronPort-SDR: xdEp9I3S77K3FKHAs4om8nAfsYDB/7HD8Ho9G8K0aVekpbm6aWe+159Y5l58HfLcK0Dv0N5ejR
 m/eJsgkkHmuiSIf//4oJLutrV0q2TZo0IrquHq4PYqJDmTk3R1pqDxdi04GGkAZs0JMfWVc7r6
 CZ7F4/D7uGwaWTiiVDbo15EtvCyuOgs25pxauNtZDth43IVbWDyjJESyTNtuqNnFe4kBpvwR09
 JMZrrUpsmUE5wXNeA9lhezfuxue5oSCU20/NiRLMYcJaNiHgM0cbWJW1fB+242mgRyiKT9u+YU
 AwA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2023 19:22:12 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PGk051mS1z1Rwrq
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 19:22:13 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1676431331; x=1679023332; bh=yy8bnIircEMfRxG6DH
        ZUyEhd5BscnXdzmdZ5rinTOmA=; b=NGns3HIq8bkxpM1vlwrK+u8qRt2zyn9L1+
        gpC3cS+f5TXoa29t0YmcBZodtmhLmfIDMYGV/XkDuWKXL4Hi79lm1Lz3uV8pY4Tg
        AlJwhLkeELsaUOl4pCMK2AGeINzhqLxTEB8cPz0I1lBCHvOvVoNn1E4SbpyJtzBa
        SIqu+OPKJPtwqSbwtOApgngu0E2o31akVa/Z1xDC+aNow3iRXDZHloOvZ71K3IZB
        nIG9ogOJ4jlDeiu732NsVcaLbomDDAgUp3RCPZgcPonhfLAQkHjSyFUpz2JL61Xj
        ehGmczMjDRopTT8hsI9gTF8uzbNp6Ma8VxTwunjUoNkNlyn9bKvA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id v7R7m_BgwpF5 for <linux-pci@vger.kernel.org>;
        Tue, 14 Feb 2023 19:22:11 -0800 (PST)
Received: from fedora.flets-east.jp (unknown [10.225.163.119])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PGk022zy0z1RvTp;
        Tue, 14 Feb 2023 19:22:10 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 07/12] pci: epf-test: Add debug and error messages
Date:   Wed, 15 Feb 2023 12:21:50 +0900
Message-Id: <20230215032155.74993-8-damien.lemoal@opensource.wdc.com>
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

Make the pci-epf-test driver more verbose with dynamic debug messages
using dev_dbg(). Also add some dev_err() error messages to help
troubleshoot issues.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 69 +++++++++++++++----
 1 file changed, 56 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/=
endpoint/functions/pci-epf-test.c
index f630393e8208..9b791f4a7ffb 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -330,6 +330,10 @@ static int pci_epf_test_copy(struct pci_epf_test *ep=
f_test, bool use_dma)
 	enum pci_barno test_reg_bar =3D epf_test->test_reg_bar;
 	volatile struct pci_epf_test_reg *reg =3D epf_test->reg[test_reg_bar];
=20
+	dev_dbg(&epf->dev,
+		"COPY src addr 0x%llx, dst addr 0x%llx, %u B\n",
+		reg->src_addr, reg->dst_addr, reg->size);
+
 	src_addr =3D pci_epc_mem_alloc_addr(epc, &src_phys_addr, reg->size);
 	if (!src_addr) {
 		dev_err(dev, "Failed to allocate source address\n");
@@ -380,6 +384,8 @@ static int pci_epf_test_copy(struct pci_epf_test *epf=
_test, bool use_dma)
=20
 		buf =3D kzalloc(reg->size, GFP_KERNEL);
 		if (!buf) {
+			dev_err(dev, "Alloc %zu B for copy failed\n",
+				(size_t)reg->size);
 			ret =3D -ENOMEM;
 			goto err_map_addr;
 		}
@@ -424,6 +430,9 @@ static int pci_epf_test_read(struct pci_epf_test *epf=
_test, bool use_dma)
 	enum pci_barno test_reg_bar =3D epf_test->test_reg_bar;
 	volatile struct pci_epf_test_reg *reg =3D epf_test->reg[test_reg_bar];
=20
+	dev_dbg(&epf->dev, "READ src addr 0x%llx, %u B\n",
+		reg->src_addr, reg->size);
+
 	src_addr =3D pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
 	if (!src_addr) {
 		dev_err(dev, "Failed to allocate address\n");
@@ -442,6 +451,8 @@ static int pci_epf_test_read(struct pci_epf_test *epf=
_test, bool use_dma)
=20
 	buf =3D kzalloc(reg->size, GFP_KERNEL);
 	if (!buf) {
+		dev_err(dev, "Alloc %zu B for read failed\n",
+			(size_t)reg->size);
 		ret =3D -ENOMEM;
 		goto err_map_addr;
 	}
@@ -506,6 +517,9 @@ static int pci_epf_test_write(struct pci_epf_test *ep=
f_test, bool use_dma)
 	enum pci_barno test_reg_bar =3D epf_test->test_reg_bar;
 	volatile struct pci_epf_test_reg *reg =3D epf_test->reg[test_reg_bar];
=20
+	dev_dbg(&epf->dev, "WRITE dst addr 0x%llx, %u B\n",
+		reg->dst_addr, reg->size);
+
 	dst_addr =3D pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
 	if (!dst_addr) {
 		dev_err(dev, "Failed to allocate address\n");
@@ -524,6 +538,8 @@ static int pci_epf_test_write(struct pci_epf_test *ep=
f_test, bool use_dma)
=20
 	buf =3D kzalloc(reg->size, GFP_KERNEL);
 	if (!buf) {
+		dev_err(dev, "Alloc %zu B for write failed\n",
+			(size_t)reg->size);
 		ret =3D -ENOMEM;
 		goto err_map_addr;
 	}
@@ -580,7 +596,7 @@ static int pci_epf_test_write(struct pci_epf_test *ep=
f_test, bool use_dma)
 	return ret;
 }
=20
-static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test, u8 irq=
_type,
+static int pci_epf_test_raise_irq(struct pci_epf_test *epf_test, u8 irq_=
type,
 				   u16 irq)
 {
 	struct pci_epf *epf =3D epf_test->epf;
@@ -588,26 +604,35 @@ static void pci_epf_test_raise_irq(struct pci_epf_t=
est *epf_test, u8 irq_type,
 	struct pci_epc *epc =3D epf->epc;
 	enum pci_barno test_reg_bar =3D epf_test->test_reg_bar;
 	volatile struct pci_epf_test_reg *reg =3D epf_test->reg[test_reg_bar];
+	int ret;
=20
 	reg->status |=3D STATUS_IRQ_RAISED;
=20
 	switch (irq_type) {
 	case IRQ_TYPE_LEGACY:
-		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
-				  PCI_EPC_IRQ_LEGACY, 0);
+		dev_dbg(&epf->dev, "RAISE legacy IRQ\n");
+		ret =3D pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
+					PCI_EPC_IRQ_LEGACY, 0);
 		break;
 	case IRQ_TYPE_MSI:
-		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
-				  PCI_EPC_IRQ_MSI, irq);
+		dev_dbg(&epf->dev, "RAISE MSI IRQ %d\n", (int)irq);
+		ret =3D pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
+					PCI_EPC_IRQ_MSI, irq);
 		break;
 	case IRQ_TYPE_MSIX:
-		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
-				  PCI_EPC_IRQ_MSIX, irq);
+		dev_dbg(&epf->dev, "RAISE MSIX IRQ %d\n", (int)irq);
+		ret =3D pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
+					PCI_EPC_IRQ_MSIX, irq);
 		break;
 	default:
 		dev_err(dev, "Failed to raise IRQ, unknown type\n");
-		break;
+		return -EINVAL;
 	}
+
+	if (ret)
+		dev_err(dev, "Raise IRQ failed %d\n", ret);
+
+	return ret;
 }
=20
 static void pci_epf_test_cmd_handler(struct work_struct *work)
@@ -684,8 +709,11 @@ static void pci_epf_test_cmd_handler(struct work_str=
uct *work)
=20
 	if (command & COMMAND_RAISE_MSI_IRQ) {
 		count =3D pci_epc_get_msi(epc, epf->func_no, epf->vfunc_no);
-		if (reg->irq_number > count || count <=3D 0)
+		if (reg->irq_number > count || count <=3D 0) {
+			dev_err(dev, "Invalid MSI %d / %d\n",
+				(int)reg->irq_number, (int)count);
 			goto reset_handler;
+		}
 		reg->status =3D STATUS_IRQ_RAISED;
 		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
 				  PCI_EPC_IRQ_MSI, reg->irq_number);
@@ -694,14 +722,19 @@ static void pci_epf_test_cmd_handler(struct work_st=
ruct *work)
=20
 	if (command & COMMAND_RAISE_MSIX_IRQ) {
 		count =3D pci_epc_get_msix(epc, epf->func_no, epf->vfunc_no);
-		if (reg->irq_number > count || count <=3D 0)
+		if (reg->irq_number > count || count <=3D 0) {
+			dev_err(dev, "Invalid MSIX %d / %d\n",
+				(int)reg->irq_number, (int)count);
 			goto reset_handler;
+		}
 		reg->status =3D STATUS_IRQ_RAISED;
 		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
 				  PCI_EPC_IRQ_MSIX, reg->irq_number);
 		goto reset_handler;
 	}
=20
+	dev_err(dev, "Unknown command 0x%x\n", command);
+
 reset_handler:
 	queue_delayed_work(kpcitest_workqueue, &epf_test->cmd_handler,
 			   msecs_to_jiffies(1));
@@ -828,12 +861,14 @@ static int pci_epf_test_notifier(struct notifier_bl=
ock *nb, unsigned long val,
=20
 	switch (val) {
 	case CORE_INIT:
+		dev_dbg(&epf->dev, "CORE_INIT event\n");
 		ret =3D pci_epf_test_core_init(epf);
 		if (ret)
 			return NOTIFY_BAD;
 		break;
=20
 	case LINK_UP:
+		dev_dbg(&epf->dev, "LINK_UP event\n");
 		queue_delayed_work(kpcitest_workqueue, &epf_test->cmd_handler,
 				   msecs_to_jiffies(1));
 		break;
@@ -875,8 +910,12 @@ static int pci_epf_test_alloc_space(struct pci_epf *=
epf)
 	test_reg_size =3D test_reg_bar_size + msix_table_size + pba_size;
=20
 	if (epc_features->bar_fixed_size[test_reg_bar]) {
-		if (test_reg_size > bar_size[test_reg_bar])
+		if (test_reg_size > bar_size[test_reg_bar]) {
+			dev_err(&epf->dev, "BAR %d: %zu B > %zu B\n",
+				(int)test_reg_bar, test_reg_size,
+				(size_t)bar_size[test_reg_bar]);
 			return -ENOMEM;
+		}
 		test_reg_size =3D bar_size[test_reg_bar];
 	}
=20
@@ -938,8 +977,10 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 	bool linkup_notifier =3D false;
 	bool core_init_notifier =3D false;
=20
-	if (WARN_ON_ONCE(!epc))
+	if (WARN_ON_ONCE(!epc)) {
+		dev_err(&epf->dev, "No controller\n");
 		return -EINVAL;
+	}
=20
 	epc_features =3D pci_epc_get_features(epc, epf->func_no, epf->vfunc_no)=
;
 	if (!epc_features) {
@@ -950,8 +991,10 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 	linkup_notifier =3D epc_features->linkup_notifier;
 	core_init_notifier =3D epc_features->core_init_notifier;
 	test_reg_bar =3D pci_epc_get_first_free_bar(epc_features);
-	if (test_reg_bar < 0)
+	if (test_reg_bar < 0) {
+		dev_err(&epf->dev, "No free BAR\n");
 		return -EINVAL;
+	}
 	pci_epf_configure_bar(epf, epc_features);
=20
 	epf_test->test_reg_bar =3D test_reg_bar;
--=20
2.39.1

