Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63C26CFF36
	for <lists+linux-pci@lfdr.de>; Thu, 30 Mar 2023 10:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjC3IyT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Mar 2023 04:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjC3IyS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Mar 2023 04:54:18 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B7C7683
        for <linux-pci@vger.kernel.org>; Thu, 30 Mar 2023 01:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680166456; x=1711702456;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NO8Rhu//AxIrrspALxKn62RC+pXJTNz3Th/wi13bFi8=;
  b=Oue2dFy0LreUfwbl2hW+Qlhpe2SCo7MjQqjTqCNrzawI4AXIEItG9CIw
   RnqFkxNWVCpQlv1QJ+U7KSnQccYUOyNZwCWSG9XKOud4Ns5nX8EgNRBz2
   ItAOGp6TgvHpj2dFfvdMxrXAw4mk4Wbek0CmXoC8fR/bGtGmHmxM64JiX
   CbCN9obU4gpAv2y8ZDfDsbtdFSvcc4Z6qFaePXQw8ygQKUYgjFponLYZY
   kDBhKdKw3pXkehydkkeiOviIqLRH+56JTPMR6Bh5d8KA6yqKEq4ye/gau
   3cm/TTFGiMlz6gzvDeG6w59SzGqhyzCRw/GqC7dtlecAuuLIOjEq63AtJ
   g==;
X-IronPort-AV: E=Sophos;i="5.98,303,1673884800"; 
   d="scan'208";a="331310458"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 16:54:15 +0800
IronPort-SDR: xGHI4jukKiyHsiNX8j7Y/USOCP6XmtrYxUVyu230VxDneJbs3kn1Kt+166BbpUgDSj4JNFh7e/
 Sj2iR9+or08tnI0bTXHO3Bc+C6J1T0BaffVEpzC/0sQyGT6p2lBtAOV5iDOmx36hQ1DkpHMSew
 IdHajtABL0iWyV7gv5zcFhB+6vC977Y2lPg6VMuyIJG0i52fKt23N3yvUcIM0pZVNlKnNE3U5/
 Z2njA026Fe5GZ25bRkBSbmLE0dDv48rLQjvntJ9sJ4SEXvqZRCreqOnFaYDqHBURpnKbT4gsT+
 +Os=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 01:10:24 -0700
IronPort-SDR: EoRkssIR/DDkASiuZulXfN0BPaU1OPf3cW7DviN3EvTD71xWjJvDp7zD56NeH3ttYgrdcwOuX5
 BZY9c2wsRnCq1+1LW4G3JqXnxO7zfcln3IsWPKi+YnGhx0RQKAfzcbm5fPyimzQ51BeawEFhAq
 WaPDmxcCC7TYQxt8TuBre3XKKxRXWcyN1FG2qVzTCaOaCJMqSup0oMj9/e4X5l0FPuJureLGeL
 722v+btNLli79D9oaTF+oak/lWEYX5N2Z7FvdmwA/jrhM1hpNCsSHjpW0g384hIBc51O4S1XRW
 dYw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 01:54:16 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PnHKM5C33z1RtVw
        for <linux-pci@vger.kernel.org>; Thu, 30 Mar 2023 01:54:15 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1680166454; x=1682758455; bh=NO8Rhu//AxIrrspALx
        Kn62RC+pXJTNz3Th/wi13bFi8=; b=MbCgBwh4lVlt0qktFIcbrGdwSoaUt3SYCM
        RZ1YohS2B0kqjA6uLAHX8wGERipY/dk8xIr1CKtyGKbMI/t1l7jnpdvvuSrrny+F
        Bs7HWvM3g6ADKTo2NuAbB5lyeow/9T72lYkmEE8aXRecVhcjySWOAxsIMLQxXZfE
        wC60Ee9N4a7nekalrgBMMeUv3hyhGW8pUFLerF6APdp08REWviw7NUanXXZ2nxs0
        uB0KNmvGqAAbmtSIBklQhoX90s+kdeJA+ImPIzA/pt7QJoPthhWx/p9+RBdVxu0D
        U6uuAfejy18zNz1LE/WDo562kavf57VF/OIS5qlLiVI8k9x25MAQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fzxJsMXhkE-y for <linux-pci@vger.kernel.org>;
        Thu, 30 Mar 2023 01:54:14 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PnHKK2rgQz1RtVm;
        Thu, 30 Mar 2023 01:54:13 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v4 08/17] PCI: epf-test: Simplify IRQ test commands execution
Date:   Thu, 30 Mar 2023 17:53:48 +0900
Message-Id: <20230330085357.2653599-9-damien.lemoal@opensource.wdc.com>
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

