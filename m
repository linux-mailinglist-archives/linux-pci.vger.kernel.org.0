Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293DA6974DA
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 04:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjBODWi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 22:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjBODWh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 22:22:37 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231C633465
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 19:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676431343; x=1707967343;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YbCnBFArn6l4X/m37mmtEuQyaVaLiec7s7udE1ICfj4=;
  b=XSmeM8FTT6Ptn4q9fP/QwDHtFpzMo3NkdiOUADU8bHDBvMyUiiB3j/h0
   6Ew+9Rtp8/CrTV4MA0kgygD6PHj//csvx2Y/Gjz8qXZiJWZEdrTwYgONP
   ItFFjGfv4A7c3UhtDzf34eH5+mFRdCs8aFXcg00Vp2cFITAptlk7UP+bu
   NJVUxsNH/QGJS86PHMopOXG5VyGPfFsASyPIWrr9ZCUGfcXMgjfz463QJ
   JbkdKUYsm8V9aiQeRKAB7kHpU+LMUvvV+DXh3t59VA2BNrQ9QEuQTUHn5
   dVRn9TVDjiRNc14QR96OprEZH3bZB7xYuoQx0avYEJE901SJ5C8/gWh+m
   g==;
X-IronPort-AV: E=Sophos;i="5.97,298,1669046400"; 
   d="scan'208";a="223351475"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2023 11:22:22 +0800
IronPort-SDR: VIN+n8H8+Ti1nJLXUSqRJUm7y5wYejN1vDnDGsu08HoLuNT+ONPSJ2Re1+KkhVBs+yYWkG8Yt8
 6hYAk5cTcKBpICZ698tXznavhtq6vLkZIv+u1oKLCBwc9O0FyPe+z5kKXAsMwWkTvGAQ7Z0JkI
 PAKi1ddyUo3+9Qfdh1dlTxHCmLfB5SY3ZKlKAtz8PWx9oT0zq/miM56BEJObhZ/gz9B6NExYuB
 eQG8KgCj6CQzmoWORlklPdDMd5PDb60quYtnzsuH5cPIbfENarMT2Bw+uUxxlucx+zfXAk/gMq
 pb4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2023 18:33:45 -0800
IronPort-SDR: l8eiJVzIhTXZTiRUr7y/jkML8zt8002g6rl9ezo6w77eXp4zoaQ7zZ26DkO3PIyj00luoGwbNP
 uCSfaAJrmmyGLWE8wBX3agINUVs4HBhL1kavFN3TEmVp6K2IJQhZe6ylwizR3eiUV1U8gHhx6J
 fAT4b/5X+JHT/2TbbFkko4THFhbVGtwUPURNmTKYObf5qZNaRigC935xPpArFW3DIsjcDZ4msy
 LQLkXzAoug+ZBIa0BuLfrzto097RZ7g0rhSKvfSCiBV8DPmKLpMeKodWuy7nFqjhN9aMatZ/1J
 2sw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2023 19:22:21 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PGk0F5zzkz1RwvT
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 19:22:21 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1676431340; x=1679023341; bh=YbCnBFArn6l4X/m37m
        mtEuQyaVaLiec7s7udE1ICfj4=; b=bx5yK9Zrw82x6ywebyhDK9OcsJ9ZszD9zi
        /Rcz/sSRuo3NdrCk9Vo0WArPKnjwbKEGZ/I3+9LNFyez2Qr08ZDuQMc19KNUlmoT
        04O2XidNTVL2Hah2Mik7bwjKEzVdJSeLMlhxPcaoZk221WBcx9KFxyDIoyayJ4+M
        154kvFKjsPUHiOaLzEtzytd5FUrtYLnZ7zLlteMhx5j6BvYHe+FltnpfBcX3BFE6
        7CVR+9QF6W4AMLTsTVtH8bBTILE2bnX8U9EAbAFldvZz9SmGceaj3CpG2Ns5kZQw
        DvkLhDZz99kRpZQjqoe6XZgnYXXQ5AlQAZYucfwpJ93v3pnmNOMQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id pTGcD9H_Kjv1 for <linux-pci@vger.kernel.org>;
        Tue, 14 Feb 2023 19:22:20 -0800 (PST)
Received: from fedora.flets-east.jp (unknown [10.225.163.119])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PGk0C3flkz1RvLy;
        Tue, 14 Feb 2023 19:22:19 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 12/12] misc: pci_endpoint_test: Add debug and error messages
Date:   Wed, 15 Feb 2023 12:21:55 +0900
Message-Id: <20230215032155.74993-13-damien.lemoal@opensource.wdc.com>
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

Add dynamic debug messages with dev_dbg() to help troubleshoot issues
when running the endpoint tests. The debug messages for errors detected
in pci_endpoint_test_validate_xfer_params() are changed to error
messages.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/misc/pci_endpoint_test.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint=
_test.c
index b05d3db85da8..c47f6e708ea2 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -267,12 +267,15 @@ static bool pci_endpoint_test_bar(struct pci_endpoi=
nt_test *test,
 	u32 val;
 	int size;
 	struct pci_dev *pdev =3D test->pdev;
+	struct device *dev =3D &pdev->dev;
=20
 	if (!test->bar[barno])
 		return false;
=20
 	size =3D pci_resource_len(pdev, barno);
=20
+	dev_dbg(dev, "Test BAR %d, %d B\n", (int)barno, size);
+
 	if (barno =3D=3D test->test_reg_bar)
 		size =3D 0x4;
=20
@@ -291,6 +294,10 @@ static bool pci_endpoint_test_bar(struct pci_endpoin=
t_test *test,
 static bool pci_endpoint_test_legacy_irq(struct pci_endpoint_test *test)
 {
 	u32 val;
+	struct pci_dev *pdev =3D test->pdev;
+	struct device *dev =3D &pdev->dev;
+
+	dev_dbg(dev, "Test legacy IRQ\n");
=20
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE,
 				 IRQ_TYPE_LEGACY);
@@ -310,6 +317,9 @@ static bool pci_endpoint_test_msi_irq(struct pci_endp=
oint_test *test,
 {
 	u32 val;
 	struct pci_dev *pdev =3D test->pdev;
+	struct device *dev =3D &pdev->dev;
+
+	dev_dbg(dev, "Test MSI%s %d\n", msix ? "X" : "", msi_num);
=20
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE,
 				 msix ? IRQ_TYPE_MSIX : IRQ_TYPE_MSI);
@@ -329,12 +339,12 @@ static int pci_endpoint_test_validate_xfer_params(s=
truct device *dev,
 		struct pci_endpoint_test_xfer_param *param, size_t alignment)
 {
 	if (!param->size) {
-		dev_dbg(dev, "Data size is zero\n");
+		dev_err(dev, "Data size is zero\n");
 		return -EINVAL;
 	}
=20
 	if (param->size > SIZE_MAX - alignment) {
-		dev_dbg(dev, "Maximum transfer data size exceeded\n");
+		dev_err(dev, "Maximum transfer data size exceeded\n");
 		return -EINVAL;
 	}
=20
@@ -444,6 +454,10 @@ static bool pci_endpoint_test_copy(struct pci_endpoi=
nt_test *test,
 		dst_addr =3D orig_dst_addr;
 	}
=20
+	dev_dbg(dev,
+		"Test COPY align %zu, src phys addr 0x%llx, dst phys addr 0x%llx, %zu =
B\n",
+		alignment, src_phys_addr, dst_phys_addr, size);
+
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_LOWER_DST_ADDR,
 				 lower_32_bits(dst_phys_addr));
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_UPPER_DST_ADDR,
@@ -549,6 +563,10 @@ static bool pci_endpoint_test_write(struct pci_endpo=
int_test *test,
 		addr =3D orig_addr;
 	}
=20
+	dev_dbg(dev,
+		"Test WRITE align %zu, phys addr 0x%llx, %zu B\n",
+		alignment, phys_addr, size);
+
 	crc32 =3D crc32_le(~0, addr, size);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_CHECKSUM,
 				 crc32);
@@ -647,6 +665,10 @@ static bool pci_endpoint_test_read(struct pci_endpoi=
nt_test *test,
 		addr =3D orig_addr;
 	}
=20
+	dev_dbg(dev,
+		"Test READ align %zu, phys addr 0x%llx, %zu B\n",
+		alignment, phys_addr, size);
+
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_LOWER_DST_ADDR,
 				 lower_32_bits(phys_addr));
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_UPPER_DST_ADDR,
--=20
2.39.1

