Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009406C8BFD
	for <lists+linux-pci@lfdr.de>; Sat, 25 Mar 2023 08:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjCYHCp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Mar 2023 03:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbjCYHCn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Mar 2023 03:02:43 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCCB15C9A
        for <linux-pci@vger.kernel.org>; Sat, 25 Mar 2023 00:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679727762; x=1711263762;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CbKzr7JuTqmzPKIp5lOMS5tv+EX8Bq8JL59U7x90uT8=;
  b=UkrEEVjPywlgTqb1bOfJ8ypr8t+HLXiX1w+47BIFHT7HU9xn63L4Uo5p
   KMHcaebpo26+W6vmeLYFBixvtKhGNzhwCHF5fS4xhUK4CYCxuU/GLkElM
   z4ABA8Y8mQ8Vv8APmTJ/jptgFrhNmOJR2vi9PbLWdIdh0uG8MiQBFy3G8
   nivs7uc320HmYIRZZ212QVpoTjoagrdU95zwywlJ+I+VJD85Qbe170ev8
   45pdkYZxXPtA/pEkeaGR7iHuiVNnWkcV8hKY1d6bl+PEvmHeD7pYkV3iR
   C3OzHbZN4AlY6OMDBGHyesdz2XhnRI4gw78NTD25UhTwr4cABfUJA/Gp/
   A==;
X-IronPort-AV: E=Sophos;i="5.98,289,1673884800"; 
   d="scan'208";a="224756763"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2023 15:02:41 +0800
IronPort-SDR: 2yOu20Zur7+IimbyCCJmehDnvbdIiZaCri6RObtkoAwohU5t2BLNmJQBbZWZq4NTiueMk0czE8
 uoLh8EN7R5hzgyxb+6cEcg0rsowxqhFMoQ5EvXklaaSxIvd0iYAl5rf251ycM1Af2rwUq9i3Yk
 znAIxj6RdLbOBeRtzORQ3tPkshn5BPE8aKXwAtkVOFIHj5LoWoouIwIjOweoX8UcvOD7oR/br/
 7xc3idCHukj4QL7DoxBTCUx0LCHG9YBBfX4Vs2Z3KZSVXn5Sy/0cUVwG4pXE0TGNGc7hT7GAlB
 Tw0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Mar 2023 23:18:56 -0700
IronPort-SDR: ohOx9Zx2KWrnzphMy+6VFmabxssmAeJduOPaMHlLapzwpPTBh1c9QD2gLONmk1zgbUf2RpskB9
 C2Ls2A8HXxjAYLZpm1LBSQSqf0DlBemolW3EoCeJCmNmcfRWFu4NDJJFtS/VvsQZ0Ai60haRb5
 JbNU8mFPdGvwyHXMeCFrDd8RvGfc0FlSWNJrsUBnP7BWzrldL4HZM9x7swVmcq7f/QYPLVUEH6
 WCY3mVOBm5SzHtU0terP6fZzTVmk937hQPEw5JseO5enRTwDZkns8Btzf5Msod/84QEwLdojCV
 tgM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Mar 2023 00:02:42 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pk94x4y68z1RtVy
        for <linux-pci@vger.kernel.org>; Sat, 25 Mar 2023 00:02:41 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1679727760; x=1682319761; bh=CbKzr7JuTqmzPKIp5l
        OMS5tv+EX8Bq8JL59U7x90uT8=; b=gYPc2k3e+Xh6ehVJfwlO142r+EhketQZ5i
        hUFxVjQ/bEUxQUgYTSShC9+mdltAV2d/WCYt1OrUPU5xxtIWMQ2wdKicI3em5/92
        V5N+bzBySZ4F3u2xLgqjrAZnUcMfNHqoa2QX6EI4LUNSFgRbTJmQDG3hBD32jGwM
        RH8Dhs6FAGoFm5ywQIESvoRRSjxfw2jSF4ley+fMGa+hpXgd2j9g3so8Y7ss8P9k
        gdMHU8njbiiILwkotWZ48bpfmYsYMXR67loEaj9+2YrCbYx7oWTNIbBIc+HxgXoh
        vF7eczBIkCWeyITEkREin1yjJcv/kuNggU3Brij0VlyaOzXDfcLw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id co2-8XSUNP7z for <linux-pci@vger.kernel.org>;
        Sat, 25 Mar 2023 00:02:40 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pk94v2Lqpz1RtVm;
        Sat, 25 Mar 2023 00:02:39 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 06/16] PCI: epf-test: Simplify read/write/copy test functions
Date:   Sat, 25 Mar 2023 16:02:16 +0900
Message-Id: <20230325070226.511323-7-damien.lemoal@opensource.wdc.com>
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

