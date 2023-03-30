Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB516CFF33
	for <lists+linux-pci@lfdr.de>; Thu, 30 Mar 2023 10:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjC3IyO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Mar 2023 04:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjC3IyN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Mar 2023 04:54:13 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC8F3AA5
        for <linux-pci@vger.kernel.org>; Thu, 30 Mar 2023 01:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680166452; x=1711702452;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CbKzr7JuTqmzPKIp5lOMS5tv+EX8Bq8JL59U7x90uT8=;
  b=EzwTcdmIMvSw04XWFL0ZiJ95g2ahiEBTA0o/31RQeJvdc3cyP+LcAT3k
   5OVUeypLkAS3OPdTJiKmSgHlyUtUR3uq6eQwbPZxTr8JLVoj7c4U5qmFd
   srqQ6W72/QLtKhDpfEFCJumh7ikebZu1JHBurxcoMTEFwR+OER5BKHTrY
   /LsQr1j9yxt2dRs/AYXKqh9svRy2Bh4XP+KNSRiQU8k/oGqFmC/LyOgpc
   yhN2p5H/PUW1bMjRk96ZaKOSUK3ovzm0h+QSarUt7hABOQrDImKn58n+i
   dAl8ioEUJflJKJT7m+Bsa+i0tclYsxwcxNBJRIKidxHAfXIcZVhHz72Xo
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,303,1673884800"; 
   d="scan'208";a="331310446"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 16:54:12 +0800
IronPort-SDR: 0RnKVsmd4jvlRtpW/AIj7F8/kAAxKxrNppRWtJOMXSPqWAk5BPwGOFlfJgDVtNld0EbBm6P+xw
 9fgzyVlhBwYkdz87vdB2puQFY58YZi3BKUC6V+jB/BuhGaVcHeH3LBJVjI7tmS4lr9jc8wZCmZ
 sCTzjLX9ABvKOfdJpaYCn77fFjGcM0vAaAJbCEQH8ZsyodlKW7x5MK7svRNz1jS2K6HOWI5Jqv
 EvfTOpkmtJl+B/wIiHiM+ZKEk7G+RdHMjTeNy/eNymTai8b/+lQDJrUyemeZEcrxCcijC5DgE3
 CVM=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 01:10:20 -0700
IronPort-SDR: v528uEtrfgNrEJTWtksfVfRilCrr/FMiNgJx1/xzttqA61T3pbEHlawStwwqaJhcVOK3v8TfKu
 SD7rtMmBiyhzUlmAYw9OGjw6llihnP0P8NYiROqehzsqX+qiVivi+3JHAfN2xbWzsFchW1qbTv
 rbM2WIFwXfcDsvKG8w8nNC9UAwXbPGtg8PNOalJU45BBAKSqkIsxNpSuIt2V4nxxLJuDItojWu
 mREsbh9jil1RdWcnUXrbASB4q/kobv+zzEnq0qjOqgKbsq2ZUXWGINtFdaaHuw9GS6cI5IY4EJ
 I3Q=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 01:54:12 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PnHKH6jp1z1RtVp
        for <linux-pci@vger.kernel.org>; Thu, 30 Mar 2023 01:54:11 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1680166451; x=1682758452; bh=CbKzr7JuTqmzPKIp5l
        OMS5tv+EX8Bq8JL59U7x90uT8=; b=OoJ3huLvL53Y6BNiyZHWOH0zui1C1JYHYg
        jcA/pBY1S1/W2ZPoZavjOSMTsqy7PZX2Jgd4CSxkzuM+dnL6TbRnuYJLQ2li0/0p
        Fv3DS+dzrF1HDGmPzYbykFqWF+mP01YS2HNZ3LRnJZD9c6G9DtkfH3Nc+e938uHr
        4E4UFTQeCumkDEcCmc7wn2FTiRUnhjdU9OQ43Ylw+llKW6aIw6nJ//rt6ZR0UiY/
        0fdkaDu5vVt1UBCmUsx3t+BrvDVDHZN0d7yycN4KzSi8H1hamutRl1OEwroLErZ4
        2eMFRvb/ocQ2X6whNm7I9tKvESkGdpzb1GynKPEoJnuZMKOx9HGA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id c79uT0MqLC2V for <linux-pci@vger.kernel.org>;
        Thu, 30 Mar 2023 01:54:11 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PnHKF5yPTz1RtVm;
        Thu, 30 Mar 2023 01:54:09 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v4 06/17] PCI: epf-test: Simplify read/write/copy test functions
Date:   Thu, 30 Mar 2023 17:53:46 +0900
Message-Id: <20230330085357.2653599-7-damien.lemoal@opensource.wdc.com>
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

The function pci_epf_test_cmd_handler() casts the register bar to a
struct pci_epf_test_reg to determine the command sent by the host and
execute the test function accordingly. So there is no need for doing
this cast again in each of the read, write and copy test functions. We
can simply pass the reg pointer as an argument to the functions
pci_epf_test_write(), pci_epf_test_read() and pci_epf_test_copy().

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 21 ++++++++-----------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/=
endpoint/functions/pci-epf-test.c
index 7cdc6c915ef5..b8b178ac7cda 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -325,7 +325,8 @@ static void pci_epf_test_print_rate(const char *ops, =
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
@@ -337,8 +338,6 @@ static int pci_epf_test_copy(struct pci_epf_test *epf=
_test)
 	struct pci_epf *epf =3D epf_test->epf;
 	struct device *dev =3D &epf->dev;
 	struct pci_epc *epc =3D epf->epc;
-	enum pci_barno test_reg_bar =3D epf_test->test_reg_bar;
-	struct pci_epf_test_reg *reg =3D epf_test->reg[test_reg_bar];
=20
 	src_addr =3D pci_epc_mem_alloc_addr(epc, &src_phys_addr, reg->size);
 	if (!src_addr) {
@@ -424,7 +423,8 @@ static int pci_epf_test_copy(struct pci_epf_test *epf=
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
@@ -438,8 +438,6 @@ static int pci_epf_test_read(struct pci_epf_test *epf=
_test)
 	struct device *dev =3D &epf->dev;
 	struct pci_epc *epc =3D epf->epc;
 	struct device *dma_dev =3D epf->epc->dev.parent;
-	enum pci_barno test_reg_bar =3D epf_test->test_reg_bar;
-	struct pci_epf_test_reg *reg =3D epf_test->reg[test_reg_bar];
=20
 	src_addr =3D pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
 	if (!src_addr) {
@@ -514,7 +512,8 @@ static int pci_epf_test_read(struct pci_epf_test *epf=
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
@@ -527,8 +526,6 @@ static int pci_epf_test_write(struct pci_epf_test *ep=
f_test)
 	struct device *dev =3D &epf->dev;
 	struct pci_epc *epc =3D epf->epc;
 	struct device *dma_dev =3D epf->epc->dev.parent;
-	enum pci_barno test_reg_bar =3D epf_test->test_reg_bar;
-	struct pci_epf_test_reg *reg =3D epf_test->reg[test_reg_bar];
=20
 	dst_addr =3D pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
 	if (!dst_addr) {
@@ -673,7 +670,7 @@ static void pci_epf_test_cmd_handler(struct work_stru=
ct *work)
 	}
=20
 	if (command & COMMAND_WRITE) {
-		ret =3D pci_epf_test_write(epf_test);
+		ret =3D pci_epf_test_write(epf_test, reg);
 		if (ret)
 			reg->status |=3D STATUS_WRITE_FAIL;
 		else
@@ -684,7 +681,7 @@ static void pci_epf_test_cmd_handler(struct work_stru=
ct *work)
 	}
=20
 	if (command & COMMAND_READ) {
-		ret =3D pci_epf_test_read(epf_test);
+		ret =3D pci_epf_test_read(epf_test, reg);
 		if (!ret)
 			reg->status |=3D STATUS_READ_SUCCESS;
 		else
@@ -695,7 +692,7 @@ static void pci_epf_test_cmd_handler(struct work_stru=
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

