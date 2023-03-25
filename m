Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BAA6C8BFF
	for <lists+linux-pci@lfdr.de>; Sat, 25 Mar 2023 08:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbjCYHCy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Mar 2023 03:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbjCYHCr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Mar 2023 03:02:47 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB7D14200
        for <linux-pci@vger.kernel.org>; Sat, 25 Mar 2023 00:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679727765; x=1711263765;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NO8Rhu//AxIrrspALxKn62RC+pXJTNz3Th/wi13bFi8=;
  b=SobxFBuzRMjpbkB8dJ802xmDMBaqa+XpHaqGVpC245g+rrBDWzQ/dOwL
   cRJyI1EELVvajIq4A4g1NM2IkmI6qjiPm3TeHv5gJMDiZQL8xD3nEykW9
   EIsBtWsdLw1mxRUujuDtEPAo+sTGSg2h2BbGR/TDSfrb6FcJMuIaZWPUw
   FLROcHeNfraoaE4EfP0eido8QNL5PJyIxFM0pQVZtLtUHy6fp/X5zJt6q
   opXPpm4ugToYiIxi9/hCJXuOXwASeTTcBtJHCuNYKTgdGrag/N//glPG4
   MO93maYdO6Tsj9uF7/6ObFoyasVbJ3V48XJowrJQdvT31SX6FZsJl2MYr
   A==;
X-IronPort-AV: E=Sophos;i="5.98,289,1673884800"; 
   d="scan'208";a="224756820"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2023 15:02:45 +0800
IronPort-SDR: 2PzuYsQJF6K9t6DMrg6egjELBgRdmwh+9J7EwqBxqFhOq3vHhWgycffQDZ4EKQ05Z4UrIpL9oz
 /mz1P30kTwwaHcBnaM45D32G1ag3Ae4otb/ayYPJK3OsfjLlr3kPZ4clqHZK6OQwac6Kl+SQnS
 dZi9gtDCDUubeZ58m7xple9BDEySTskqPod9y8hjpgCBh5EKCeYUyD8QJOzryD7g1mACe/BtEh
 6mpdzZcPRxHDLOv3eE1QuMmNqKNd8tP8IMH30dk7tQl+akVpszxEopxKrCgCPnkP9/Oh6Y/z6S
 FRg=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Mar 2023 23:19:00 -0700
IronPort-SDR: tYbPvMcy1wuX59SY3TOhlLI9DbP3C1rLj2jZPzViaWwWMi3ERqf2isT5HgCxEHsM+uHldKkPWW
 PeqRnfEMwHidJzcXxf+vKGk5GU8ZIvrdu3si1GR6oeeKtQ5rzsAqtMoMCuk8E9wEXyvwSKYTDf
 mJ90X8+6e2+e0yWVOM9pqVuL+dOtqyvehKwVC6ejI5I8euJlNMnZZRiOIttHMZIw1eduNZEykb
 XjpvsDQuQ9IAdLhfGT4MAbqu2nA1o9hiC6wEzy/RwKdNJ90Ynxl5l2ufBXO/msR//okbzsikH1
 6is=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Mar 2023 00:02:46 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pk9513hz0z1RtW3
        for <linux-pci@vger.kernel.org>; Sat, 25 Mar 2023 00:02:45 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1679727764; x=1682319765; bh=NO8Rhu//AxIrrspALx
        Kn62RC+pXJTNz3Th/wi13bFi8=; b=IZbevq3P1kCnnHQPqS5uoG1IlnbUhoF1ts
        12vfsPichJMeIer/cqJjqbMsA1n3HIVzLbeSiULxj5qMDeMcY4lQ1epJa5buxTV2
        2tONzoQDv5DNpiLW6RuNu38qxlRABrRrY3k8DmdEPlIfJ9jSagFnwEvLZ/jAAm6/
        5ryqJ6ZzXqz6HAwwSAkL+QiKnxPXM/6Oh8lNCPiOfEVgDGa/MJda2nO+++OEkxwU
        3JUdSLellbIuHSNxodu1mHp5zhVtFacj7rz3lET9pRcT2L9stRj4BJIVDHsTkIsn
        0mfSVVKjjY+K603ntCKR1iiLqq2Qv0W+S3a/NnHIYSPxFePHrsZw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XUkkJq8Vfhhn for <linux-pci@vger.kernel.org>;
        Sat, 25 Mar 2023 00:02:44 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pk94y60Cbz1RtVm;
        Sat, 25 Mar 2023 00:02:42 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 08/16] PCI: epf-test: Simplify IRQ test commands execution
Date:   Sat, 25 Mar 2023 16:02:18 +0900
Message-Id: <20230325070226.511323-9-damien.lemoal@opensource.wdc.com>
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

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 43 ++++++++-----------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/=
endpoint/functions/pci-epf-test.c
index 3835e558937a..ee90ba3a957b 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -613,6 +613,7 @@ static void pci_epf_test_raise_irq(struct pci_epf_tes=
t *epf_test,
 	struct pci_epf *epf =3D epf_test->epf;
 	struct device *dev =3D &epf->dev;
 	struct pci_epc *epc =3D epf->epc;
+	int count;
=20
 	reg->status |=3D STATUS_IRQ_RAISED;
=20
@@ -622,10 +623,22 @@ static void pci_epf_test_raise_irq(struct pci_epf_t=
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
@@ -638,13 +651,11 @@ static void pci_epf_test_raise_irq(struct pci_epf_t=
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
@@ -660,10 +671,10 @@ static void pci_epf_test_cmd_handler(struct work_st=
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
@@ -697,26 +708,6 @@ static void pci_epf_test_cmd_handler(struct work_str=
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

