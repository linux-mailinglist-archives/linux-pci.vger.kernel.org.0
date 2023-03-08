Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2DFA6B024B
	for <lists+linux-pci@lfdr.de>; Wed,  8 Mar 2023 10:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjCHJEi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 04:04:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjCHJEc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 04:04:32 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DDA12BD9
        for <linux-pci@vger.kernel.org>; Wed,  8 Mar 2023 01:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678266267; x=1709802267;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=axABW2wroxclMYood3Xo6NYAibU+vC4k1ymAe31QsQo=;
  b=alnMzTy2UEXotOtNOJ4wU+lwh7gY+CfdwbNX5AGRv6Y8JD4z7UxWqdV7
   dJvFb87gbu9XPAf0B8E0BDwBb2DZxanI1kahSNSHIs8G6nL6lzt/jJBby
   Wg/4QLnsJXbKoHB3teT9W1VsCc0wFUS/u37CFm4U61SNyvlXP9g8jy83+
   HDkCYZqvlayOLe78pQ9Lfhc19I6q1qb30nFTEzw2i6A4qMeAX2uzt5jFw
   OsA70198FD/Iob6It0t5qDkGRD5z1EyBwhHiwaXwAhVawLIs8NlCYhcJW
   2IVzP4Qb1YkWS34ZAsFfog5/T5rx1WYVgnQY18+3uT25tTlLoNwWXCXky
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,243,1673884800"; 
   d="scan'208";a="224880553"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Mar 2023 17:03:28 +0800
IronPort-SDR: Heev435MYclUB+F34DfEN3zXCjHnRXKzq/9hPHkBHn1op22fIgTZhwEYy93OQxKpuif2C5Tzh6
 oV4O8lG1RwfxZZiAqHIWYmwg5yxGJOIl6ZmVSFl1jQZaq6jzGmgKdc978e8xPTrcLSPe5cc4lt
 4bznmdMMQ3/v2wutPtRliTyxvyWwLKDSwZGnyAppVIVstqk14RujF1w/aeVkFzaav8o5z77aeX
 scLTLPuSxAzWFJARRpsdznbESR8rtqrmZGE3uHsrZlKBI9AX61afHcZwKlvL8Njnqhzb+wmufx
 kxA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Mar 2023 00:14:25 -0800
IronPort-SDR: /ziJwRfRNPQt1vEl9yS5eqSL8JSspTu0amGT9rUTB1oi5s6LH09RMpF6wmME47HqfiTtCq29b5
 LL15pquUtDlllFVSXd1GG26Zh6yExh5R3Tca+9BUhG+CoGqErwUuDVxWhLusVJvsfXY4/Lcprp
 UjVSVsB3cXGSi/2PvBzJRYXBmOIJow3udHOGS6z3TktYKxXLvLpk8DcGnllxN2KdLNe/uW2U79
 DbaY3WzVHlATZ0/FIEAMDHDh+FDlWSM8+/1UEaPFQ+IZrOzS0BnmG8bpv8tlqVGqh8o/ZC/NJl
 AVk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Mar 2023 01:03:29 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PWmZ82t5lz1RwvL
        for <linux-pci@vger.kernel.org>; Wed,  8 Mar 2023 01:03:28 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1678266207; x=1680858208; bh=axABW2wroxclMYood3
        Xo6NYAibU+vC4k1ymAe31QsQo=; b=Vd72WMh+KAdkt8feiACbPMtI+Z+ra2cKi5
        2PMR3//ny7r29Hy+Hw/3afq+VFAH6RzamblBhNbcOWI+xutcjuWSDsRHwrssbixz
        /glcXOUkOqL5bXYp8ZT58d6WC2+cPvjwDSFAHnA29UczRGeI8HVN2xgyfxl3t2nh
        7WG13AJ00Uf81Ov0gNwhctZzdr3EghB4ipK6/I7FmmiAl6q6Bm+J3uiIDtg8Lmy/
        Ko4D5Oo9myr7Wn1flpy9bGvRmo3+QQlqGM4OdeBMrt2Dt2uCSlHdEAnGJfvcH6kL
        HGMhojR6/S0CkgoD5Es0q7+wHTdV88ZQXIEfz8QxUyesipty5aqQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WIx3_vRH4jUj for <linux-pci@vger.kernel.org>;
        Wed,  8 Mar 2023 01:03:27 -0800 (PST)
Received: from ephost.wdc.com (unknown [10.225.163.68])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PWmZ60Sjcz1RvLy;
        Wed,  8 Mar 2023 01:03:25 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 06/16] PCI: epf-test: Simplify read/write/copy test functions
Date:   Wed,  8 Mar 2023 18:03:03 +0900
Message-Id: <20230308090313.1653-7-damien.lemoal@opensource.wdc.com>
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

The function pci_epf_test_cmd_handler() casts the register bar to a
struct pci_epf_test_reg to determine the command sent by the host and
execute the test function accordingly. So there is no need for doing
this cast again in each of the read, write and copy test functions. We
can simply pass the reg pointer as an argument to the functions
pci_epf_test_write(), pci_epf_test_read() and pci_epf_test_copy().

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 21 ++++++++-----------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/=
endpoint/functions/pci-epf-test.c
index 3dce9827bd2a..1fc245d79a8e 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -327,7 +327,8 @@ static void pci_epf_test_print_rate(const char *ops, =
u64 size,
 		(u64)ts.tv_sec, (u32)ts.tv_nsec, rate / 1024);
 }
=20
-static int pci_epf_test_copy(struct pci_epf_test *epf_test)
+static int pci_epf_test_copy(struct pci_epf_test *epf_test,
+			     struct pci_epf_test_reg *reg)
 {
 	int ret;
 	bool use_dma;
@@ -339,8 +340,6 @@ static int pci_epf_test_copy(struct pci_epf_test *epf=
_test)
 	struct pci_epf *epf =3D epf_test->epf;
 	struct device *dev =3D &epf->dev;
 	struct pci_epc *epc =3D epf->epc;
-	enum pci_barno test_reg_bar =3D epf_test->test_reg_bar;
-	struct pci_epf_test_reg *reg =3D epf_test->reg[test_reg_bar];
=20
 	src_addr =3D pci_epc_mem_alloc_addr(epc, &src_phys_addr, reg->size);
 	if (!src_addr) {
@@ -426,7 +425,8 @@ static int pci_epf_test_copy(struct pci_epf_test *epf=
_test)
 	return ret;
 }
=20
-static int pci_epf_test_read(struct pci_epf_test *epf_test)
+static int pci_epf_test_read(struct pci_epf_test *epf_test,
+			     struct pci_epf_test_reg *reg)
 {
 	int ret;
 	void __iomem *src_addr;
@@ -440,8 +440,6 @@ static int pci_epf_test_read(struct pci_epf_test *epf=
_test)
 	struct device *dev =3D &epf->dev;
 	struct pci_epc *epc =3D epf->epc;
 	struct device *dma_dev =3D epf->epc->dev.parent;
-	enum pci_barno test_reg_bar =3D epf_test->test_reg_bar;
-	struct pci_epf_test_reg *reg =3D epf_test->reg[test_reg_bar];
=20
 	src_addr =3D pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
 	if (!src_addr) {
@@ -516,7 +514,8 @@ static int pci_epf_test_read(struct pci_epf_test *epf=
_test)
 	return ret;
 }
=20
-static int pci_epf_test_write(struct pci_epf_test *epf_test)
+static int pci_epf_test_write(struct pci_epf_test *epf_test,
+			      struct pci_epf_test_reg *reg)
 {
 	int ret;
 	void __iomem *dst_addr;
@@ -529,8 +528,6 @@ static int pci_epf_test_write(struct pci_epf_test *ep=
f_test)
 	struct device *dev =3D &epf->dev;
 	struct pci_epc *epc =3D epf->epc;
 	struct device *dma_dev =3D epf->epc->dev.parent;
-	enum pci_barno test_reg_bar =3D epf_test->test_reg_bar;
-	struct pci_epf_test_reg *reg =3D epf_test->reg[test_reg_bar];
=20
 	dst_addr =3D pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
 	if (!dst_addr) {
@@ -675,7 +672,7 @@ static void pci_epf_test_cmd_handler(struct work_stru=
ct *work)
 	}
=20
 	if (command & COMMAND_WRITE) {
-		ret =3D pci_epf_test_write(epf_test);
+		ret =3D pci_epf_test_write(epf_test, reg);
 		if (ret)
 			reg->status |=3D STATUS_WRITE_FAIL;
 		else
@@ -686,7 +683,7 @@ static void pci_epf_test_cmd_handler(struct work_stru=
ct *work)
 	}
=20
 	if (command & COMMAND_READ) {
-		ret =3D pci_epf_test_read(epf_test);
+		ret =3D pci_epf_test_read(epf_test, reg);
 		if (!ret)
 			reg->status |=3D STATUS_READ_SUCCESS;
 		else
@@ -697,7 +694,7 @@ static void pci_epf_test_cmd_handler(struct work_stru=
ct *work)
 	}
=20
 	if (command & COMMAND_COPY) {
-		ret =3D pci_epf_test_copy(epf_test);
+		ret =3D pci_epf_test_copy(epf_test, reg);
 		if (!ret)
 			reg->status |=3D STATUS_COPY_SUCCESS;
 		else
--=20
2.39.2

