Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E816974D2
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 04:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjBODWP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 22:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbjBODWM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 22:22:12 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8967532E42
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 19:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676431327; x=1707967327;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ulTFomFNmfH7tQJKLFImDfoeozX3ww0CC3AYjVDn1+4=;
  b=Cdfmnq1OovEguTNXHCggk0EIIr4f2JuA8V5tUFtLDNxxJGj3llAukt6k
   nvzMaFY+LJwN5qa9LDEuyvz4J3XXsD16PHz5Rny+IfrXUVn7ppvQKjFa8
   F0atAic21R1pZK7slCl67QL3xcAnmMq7u8C6e9QeCm4TkejLuaHTPebwf
   HisvZyOmEWIaZ+l5hgwF/ay7SIiul4uNdCDsiMXK+CRf+8AtG873gwRrV
   NRzq84ufroFEroxD5toA0pmglwdXEttFCzvcn/oM4YC/n8RokFDsqq2I8
   N9nUQm6uyJVjODNkyxLBwuGYmoCRBgx78zxQ84rOcPF8mnhRmWYCP4Dzd
   A==;
X-IronPort-AV: E=Sophos;i="5.97,298,1669046400"; 
   d="scan'208";a="223351453"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2023 11:22:07 +0800
IronPort-SDR: rQvR8wLJ501OpIjjPoPi3GBcQn2G5bTyz8e5uanfM/s6K1JnoLHIR0J+JRRx5dha9z/96gTlX1
 zquFlR/jFciIpv+w3xpZ8iYbjQyMjAUx6H7oHCwyQZi1TlFCH8YwVrqshjvo7EP7nDsPcsXVpI
 bk6LTS+k1DwU/CXD2nIQZ8QvCpuILU0es0CHZFZGLpxOgsGskjVltznRt2dW/NwpZQvF5HIOWM
 ALoaroAn3ZERKN5N2YBnTE67NG+e9I9fFi3+WPza6Utewf8MUs3AxfxTDJ7cjdOzYORPDWXhHP
 AIc=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2023 18:33:30 -0800
IronPort-SDR: 1gmvSo6NWwlSkEyFom0AyIekEa9H7YqGtCFT0y/a/ZdFXq8jgf9HNcwASACcO3uETSgitHlWH5
 bVZXDkKKK9+C7hDnJfs3xrqPj+tiU7Ucq8rMj+AMNs0+3v2N0QrTnxStIRlfylNu8TEVDaMW3e
 cmWR4OiSnXPRIdXIiibAvwbwqg8wLQNAT8JSizjfDIoqO5V61t0QFcyeVAnKDSv9xHrn+5tl3O
 Byv4liJry9Tuj89f1V/l+YIGQWGeJdwuPz5c7L22JM6J3QTJEvTbYqQltSG3jRWu2H24BrbFtA
 sGU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2023 19:22:06 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PGjzy6fy6z1RwvL
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 19:22:06 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1676431326; x=1679023327; bh=ulTFomFNmfH7tQJKLF
        ImDfoeozX3ww0CC3AYjVDn1+4=; b=A/0PfAo8CK3cfZlSb7FH0F4kz9iBlhqBFJ
        Zj6Zks1e4p3u5yCm/x8LKX5G63oZRTcZFY88f1HG0/Yr16Ptjks70q/S3HyBwX3s
        k0AE9zGqO8WpeDe0ABR5ENvRSlifLzRIi+ZTJT4reLnr6lX8ytDUDfX8NfNpz2FB
        2fk0CEQ1SEi8SV/lpMeebv02XgD8fYd7zYfWYwalofzsWdmHP36JdeHRq6Zm7169
        tkY76ICMHEZWqB5EK4IbeGgkv2NW7KCGBPC4gb8Srx8YzVVoxgL7Q9o26rtaH4CG
        yIsGtEVhHP2q1glalsHraevGTOVmp35k4zMZ1TmBDoXfcTeyyU+A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 28OaNLOOrVMC for <linux-pci@vger.kernel.org>;
        Tue, 14 Feb 2023 19:22:06 -0800 (PST)
Received: from fedora.flets-east.jp (unknown [10.225.163.119])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PGjzw3Mysz1RvLy;
        Tue, 14 Feb 2023 19:22:04 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 04/12] pci: epf-test: Use driver registers as volatile
Date:   Wed, 15 Feb 2023 12:21:47 +0900
Message-Id: <20230215032155.74993-5-damien.lemoal@opensource.wdc.com>
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

The pci-epf-test driver uses struct pci_epf_test_reg directly from the
test register bar memory to execute tests cases sent by the RC side.
Make sure to declare pci_epf_test_reg use as volatile to ensure that
modifications to the fields of that structure make it to memory to be
seen by the RC side on completion.

Also initialize the test register bar to 0 when it is allocated.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/=
endpoint/functions/pci-epf-test.c
index 030769893efb..df3074667bbc 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -340,7 +340,7 @@ static int pci_epf_test_copy(struct pci_epf_test *epf=
_test)
 	struct device *dev =3D &epf->dev;
 	struct pci_epc *epc =3D epf->epc;
 	enum pci_barno test_reg_bar =3D epf_test->test_reg_bar;
-	struct pci_epf_test_reg *reg =3D epf_test->reg[test_reg_bar];
+	volatile struct pci_epf_test_reg *reg =3D epf_test->reg[test_reg_bar];
=20
 	src_addr =3D pci_epc_mem_alloc_addr(epc, &src_phys_addr, reg->size);
 	if (!src_addr) {
@@ -441,7 +441,7 @@ static int pci_epf_test_read(struct pci_epf_test *epf=
_test)
 	struct pci_epc *epc =3D epf->epc;
 	struct device *dma_dev =3D epf->epc->dev.parent;
 	enum pci_barno test_reg_bar =3D epf_test->test_reg_bar;
-	struct pci_epf_test_reg *reg =3D epf_test->reg[test_reg_bar];
+	volatile struct pci_epf_test_reg *reg =3D epf_test->reg[test_reg_bar];
=20
 	src_addr =3D pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
 	if (!src_addr) {
@@ -530,7 +530,7 @@ static int pci_epf_test_write(struct pci_epf_test *ep=
f_test)
 	struct pci_epc *epc =3D epf->epc;
 	struct device *dma_dev =3D epf->epc->dev.parent;
 	enum pci_barno test_reg_bar =3D epf_test->test_reg_bar;
-	struct pci_epf_test_reg *reg =3D epf_test->reg[test_reg_bar];
+	volatile struct pci_epf_test_reg *reg =3D epf_test->reg[test_reg_bar];
=20
 	dst_addr =3D pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
 	if (!dst_addr) {
@@ -619,7 +619,7 @@ static void pci_epf_test_raise_irq(struct pci_epf_tes=
t *epf_test, u8 irq_type,
 	struct device *dev =3D &epf->dev;
 	struct pci_epc *epc =3D epf->epc;
 	enum pci_barno test_reg_bar =3D epf_test->test_reg_bar;
-	struct pci_epf_test_reg *reg =3D epf_test->reg[test_reg_bar];
+	volatile struct pci_epf_test_reg *reg =3D epf_test->reg[test_reg_bar];
=20
 	reg->status |=3D STATUS_IRQ_RAISED;
=20
@@ -653,7 +653,7 @@ static void pci_epf_test_cmd_handler(struct work_stru=
ct *work)
 	struct device *dev =3D &epf->dev;
 	struct pci_epc *epc =3D epf->epc;
 	enum pci_barno test_reg_bar =3D epf_test->test_reg_bar;
-	struct pci_epf_test_reg *reg =3D epf_test->reg[test_reg_bar];
+	volatile struct pci_epf_test_reg *reg =3D epf_test->reg[test_reg_bar];
=20
 	command =3D reg->command;
 	if (!command)
@@ -911,6 +911,7 @@ static int pci_epf_test_alloc_space(struct pci_epf *e=
pf)
 		dev_err(dev, "Failed to allocated register space\n");
 		return -ENOMEM;
 	}
+	memset(base, 0, test_reg_size);
 	epf_test->reg[test_reg_bar] =3D base;
=20
 	for (bar =3D 0; bar < PCI_STD_NUM_BARS; bar +=3D add) {
--=20
2.39.1

