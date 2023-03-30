Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552E36CFF3E
	for <lists+linux-pci@lfdr.de>; Thu, 30 Mar 2023 10:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjC3Iyf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Mar 2023 04:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjC3Iy2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Mar 2023 04:54:28 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067817DA1
        for <linux-pci@vger.kernel.org>; Thu, 30 Mar 2023 01:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680166461; x=1711702461;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bjOf5YrytMiY/Eh6f8Y0+JmyxlGKJ3hBvshVZDfAR4M=;
  b=g2RkTvkhSdwxftMOudxpDFnhBTF/nvNryeX36h8fZLfNc3/bIPfKi7Y0
   Z3A5UD8vGn7zqhPFHt0YtNpajeMv8n6N4D4awckeXnnqXvtXxxvJp+/xH
   iR7ZAMJHYP7hfCS4becyrp6PJLZU6Kqrouz2NhYtYbvRmVl6Y+H8kGy+f
   nQ7Sy4si/JsC4KHRJVubzEjDgxSGJWRBSM/3ban+FFSwryPz/SyYBfORj
   1IT14L5cdpDRHFrzPoCpq9dduLGg6Rh32JaQQk0QRIvNhoJHR6CxmrTHg
   86WGK5iFQAdZ1oI8bHtNl4pJy4AH/LaGc8uNcrYvKgNkBYlTxpNmSfYE6
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,303,1673884800"; 
   d="scan'208";a="331310475"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 16:54:21 +0800
IronPort-SDR: dDhCxCwOeQjACfQ9HWPKzZANM8RQpeLm2jMZZWMTX/3ZakTot3My3adEqGOh9ALz/c60BqQpg0
 tNaRoCpm1rzU5ngEvPzG2B6ezMXEfoHCJT8mqdvhTJWaBgWNwcd08n1/ieAlLI8wOd8uP1D0Pu
 XL4UvI5jwKhE4mnmLsqLAfk04GXzcZZbpgXYRA+0UnszYaeTWOLRGAtbP+qRDbIVXSImp9kI1r
 T5Oruo8OVQo+9BxduBzpIj0cV2z5DLZlFuX7DaktoYnid8E2g+cRU46ZtQCqQjg6gNU734iOAK
 Rqg=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 01:10:30 -0700
IronPort-SDR: BHUMTmeizuKVWUug5ZIWU/TEa9Sp6pgtlr3EdCAZarDMVgxfb84a6TQfUnbiXekNwDRQfnKALo
 iKO71yI1m8umb/qEiAwk8Tx1/4F/bFO1TuheabN68Aw5eBvMwLvRNR8001piAavqrCtGDRCnDS
 bym09opPcHRQMwCjOkKkJkMUBdGov1nzNkLHvYUjoOd47UDP1Owe2U1e566IvfY5BFrI8MubcT
 iqsrKMjNs4qRedrEl2m7CkRVrv2C7ZKd+O3XWvf/97lQwJ4ywxXJwwuHvGYlZsM7UBRv0UkR+r
 nA8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 01:54:22 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PnHKT3bCBz1RtVt
        for <linux-pci@vger.kernel.org>; Thu, 30 Mar 2023 01:54:21 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1680166460; x=1682758461; bh=bjOf5YrytMiY/Eh6f8
        Y0+JmyxlGKJ3hBvshVZDfAR4M=; b=jBAlTyOqG8BDTKnctiknVZ4VW5uAW+rhx8
        H3pl2RTc5rlCVUI0+NWN5PpvrmWe2D/kfjgOzqwhfspSZ4UxBYS8WXfYBCdLt+41
        KN6EaOatqo8N9RhNiq5Z2G29T9dvkNWUvCyH5oZtQglkD88l7abCbSaWFlCBgmwr
        TYNwvwcm2sDa3xKH5rm6tQa2+T16pGsW1ueg2EB/JDxHg7UMLJR5SSx7IbNhKRde
        hBM6ZcecJ3h5ztSjSKQTjiZLTsjbCfw8jnPggbpOutPGQgGDeM3+7cN4mhaeOl+S
        20plq4dkBkU7696gac2Vss8ZLnPa0Pnl9xcBTfoJZfyYWbAuqvRg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zuP3RZehrw2d for <linux-pci@vger.kernel.org>;
        Thu, 30 Mar 2023 01:54:20 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PnHKR1BpWz1RtVm;
        Thu, 30 Mar 2023 01:54:18 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v4 11/17] PCI: epf-test: Cleanup request result handling
Date:   Thu, 30 Mar 2023 17:53:51 +0900
Message-Id: <20230330085357.2653599-12-damien.lemoal@opensource.wdc.com>
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

Each of the test functions pci_epf_test_write(), pci_epf_test_read() and
pci_epf_test_copy() return an int result which is used by
pci_epf_test_cmd_handler() to set a success or error bit in the request
status.

In the spirit of keeping the processing of each test case self-contained
within its own test function, move the request status field update from
pci_epf_test_cmd_handler() to each of these test functions and change
these functions declaration to returning void.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 46 +++++++++----------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/=
endpoint/functions/pci-epf-test.c
index c2a14f828bdf..35bdb03f6ee1 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -325,8 +325,8 @@ static void pci_epf_test_print_rate(const char *ops, =
u64 size,
 		(u64)ts.tv_sec, (u32)ts.tv_nsec, rate / 1024);
 }
=20
-static int pci_epf_test_copy(struct pci_epf_test *epf_test,
-			     struct pci_epf_test_reg *reg)
+static void pci_epf_test_copy(struct pci_epf_test *epf_test,
+			      struct pci_epf_test_reg *reg)
 {
 	int ret;
 	bool use_dma;
@@ -420,11 +420,14 @@ static int pci_epf_test_copy(struct pci_epf_test *e=
pf_test,
 	pci_epc_mem_free_addr(epc, src_phys_addr, src_addr, reg->size);
=20
 err:
-	return ret;
+	if (!ret)
+		reg->status |=3D STATUS_COPY_SUCCESS;
+	else
+		reg->status |=3D STATUS_COPY_FAIL;
 }
=20
-static int pci_epf_test_read(struct pci_epf_test *epf_test,
-			     struct pci_epf_test_reg *reg)
+static void pci_epf_test_read(struct pci_epf_test *epf_test,
+			      struct pci_epf_test_reg *reg)
 {
 	int ret;
 	void __iomem *src_addr;
@@ -509,11 +512,14 @@ static int pci_epf_test_read(struct pci_epf_test *e=
pf_test,
 	pci_epc_mem_free_addr(epc, phys_addr, src_addr, reg->size);
=20
 err:
-	return ret;
+	if (!ret)
+		reg->status |=3D STATUS_READ_SUCCESS;
+	else
+		reg->status |=3D STATUS_READ_FAIL;
 }
=20
-static int pci_epf_test_write(struct pci_epf_test *epf_test,
-			      struct pci_epf_test_reg *reg)
+static void pci_epf_test_write(struct pci_epf_test *epf_test,
+			       struct pci_epf_test_reg *reg)
 {
 	int ret;
 	void __iomem *dst_addr;
@@ -604,7 +610,10 @@ static int pci_epf_test_write(struct pci_epf_test *e=
pf_test,
 	pci_epc_mem_free_addr(epc, phys_addr, dst_addr, reg->size);
=20
 err:
-	return ret;
+	if (!ret)
+		reg->status |=3D STATUS_WRITE_SUCCESS;
+	else
+		reg->status |=3D STATUS_WRITE_FAIL;
 }
=20
 static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
@@ -655,7 +664,6 @@ static void pci_epf_test_raise_irq(struct pci_epf_tes=
t *epf_test,
=20
 static void pci_epf_test_cmd_handler(struct work_struct *work)
 {
-	int ret;
 	u32 command;
 	struct pci_epf_test *epf_test =3D container_of(work, struct pci_epf_tes=
t,
 						     cmd_handler.work);
@@ -683,27 +691,15 @@ static void pci_epf_test_cmd_handler(struct work_st=
ruct *work)
 		pci_epf_test_raise_irq(epf_test, reg);
 		break;
 	case COMMAND_WRITE:
-		ret =3D pci_epf_test_write(epf_test, reg);
-		if (ret)
-			reg->status |=3D STATUS_WRITE_FAIL;
-		else
-			reg->status |=3D STATUS_WRITE_SUCCESS;
+		pci_epf_test_write(epf_test, reg);
 		pci_epf_test_raise_irq(epf_test, reg);
 		break;
 	case COMMAND_READ:
-		ret =3D pci_epf_test_read(epf_test, reg);
-		if (!ret)
-			reg->status |=3D STATUS_READ_SUCCESS;
-		else
-			reg->status |=3D STATUS_READ_FAIL;
+		pci_epf_test_read(epf_test, reg);
 		pci_epf_test_raise_irq(epf_test, reg);
 		break;
 	case COMMAND_COPY:
-		ret =3D pci_epf_test_copy(epf_test, reg);
-		if (!ret)
-			reg->status |=3D STATUS_COPY_SUCCESS;
-		else
-			reg->status |=3D STATUS_COPY_FAIL;
+		pci_epf_test_copy(epf_test, reg);
 		pci_epf_test_raise_irq(epf_test, reg);
 		break;
 	default:
--=20
2.39.2

