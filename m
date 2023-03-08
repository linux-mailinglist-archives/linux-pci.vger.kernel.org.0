Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E496B0252
	for <lists+linux-pci@lfdr.de>; Wed,  8 Mar 2023 10:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjCHJFG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 04:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjCHJEm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 04:04:42 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF21133
        for <linux-pci@vger.kernel.org>; Wed,  8 Mar 2023 01:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678266277; x=1709802277;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9hc8RCCLWTxRBYC9gxcz8ZAIDPbMiGNQupCTpkbGyu0=;
  b=YuqG4vAuTtp7Q1zuTsaSW7onlrqCwGUfNKRrPNsud1o8e3X3ld383JpJ
   Pxuo9bVS85iE3iMV1LwDHSFI6diUpFQAmYWcKBYe/j92zJ5ehZSSrlPAI
   elIiJQi7LL3/QbjUnIYHSsdRVYyBj+1XcO4KXMXVPgKgkEdB80hOsBbdf
   1DsT0IkR1H7n2hojUB1dxV7dFJWrlIB5ZFu5dLkhNRmQST3hpWVTufZ4M
   FS2pcN3mfSNcoz36RVDZnRequCqzXsTSsDtkPc1fFQpTvNxU6ZG2QcBVa
   abM6uD74BCQsrx7Eeqq6i7rCGFbaFDtcFujmonjKKscsHe3CtASWz7nQT
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,243,1673884800"; 
   d="scan'208";a="224880581"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Mar 2023 17:03:43 +0800
IronPort-SDR: oAEKaXXGxgKWJtDaJCq/S7TSwv/LBmP6ZdNOjKMEMAUVi8Cj+BYuC/Ma/JkIb68TsLClmaMe3j
 MdF0td2bxVjW5oHBQYrsS1uFvSbuc4xdujRmdvwYHfdCi/jcRoVSEMFTF0aUbRAQTuN7IkWZmC
 tS5zBS4p5HlFVyhwXq8cKa6F/7v2hRja++74l+EHqC9EZNzNgzUMN0llk9sbEKiVRBm0+Jztwa
 ijmctqzNtZP7cLOeg4NjEb7rOdq3+vIPyN7HeoUvxJ3dp0f/QOSMc7yQJ/oOCTqiiyN3jgF0Qy
 rak=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Mar 2023 00:14:40 -0800
IronPort-SDR: w6h6vFbn1opjfUSeS+qNgd19ZFSG27fcST0otiZ/nvKJMCpxYqcc9ctsfufq6aFI2tAenwhVt4
 3dP8buYs0XwOZfRoLydT1FVvZyIqwx7WRXRINlUH6TQ12xWnPRfqGbo5boVyx7vMZa52FqZ6dS
 YwGjT+OoIw2Fkk0Nu2wjdilwssct8yEZC8C/LeWI1IYX4+Dq/BmrQleFt2PcmsSEOBDqambmf6
 wyw7QgfAwYM/bAU8D6/gG8mR+2nRGWU7jOryomfcHoVmZILoeo+QCUSL+F+bZFVtDh0+Z48fXz
 CRk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Mar 2023 01:03:44 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PWmZQ5pZZz1Rwtl
        for <linux-pci@vger.kernel.org>; Wed,  8 Mar 2023 01:03:42 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1678266222; x=1680858223; bh=9hc8RCCLWTxRBYC9gx
        cz8ZAIDPbMiGNQupCTpkbGyu0=; b=GGESRD8ykAEIZy+v+8YqSlvBylNUrtmITc
        YSabG2OqH3rYaoPONCLhns7HMfdKkdz6got+mW6XkbdiXbCm/W8XoOPrJELaNwfM
        v4rSGV1N/1/siFAUDQLezfWt2NJ6obTLv1I3HMrFTNca2stUm0M2KBRpFyeKIZGw
        7I+iiZRLyoKo5bRRD04TWSkiYNsonUynV7aSt7AQuOm1jn46qT7F74esRBTLbgIZ
        3RUzp3Ze1s/t6yNHgL2wzlSK4KycwDTBEwUwcO1mI4yHPpp+b+FIb1W62YE0iuW9
        Q0mQbXFDwzvDU+GGE4YWjH4jdmvi5X6eOITYMRacpLb8eJe4Vc4g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nVpX_4eoLj3w for <linux-pci@vger.kernel.org>;
        Wed,  8 Mar 2023 01:03:42 -0800 (PST)
Received: from ephost.wdc.com (unknown [10.225.163.68])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PWmZN611Zz1RvLy;
        Wed,  8 Mar 2023 01:03:40 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 14/16] misc: pci_endpoint_test: Re-init completion for every test
Date:   Wed,  8 Mar 2023 18:03:11 +0900
Message-Id: <20230308090313.1653-15-damien.lemoal@opensource.wdc.com>
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

The irq_raised completion used to detect the end of a test case is
initialized when the test device is probed, but never reinitialized
again before a test case. As a result, the irq_raised completion
synchronization is effective only for the first ioctl test case
executed. Any subsequent call to wait_for_completion() by another
ioctl() call will immediately return, potentially too early, leading to
false positive failures.

Fix this by reinitializing the irq_raised completion before starting a
new ioctl() test command.

Fixes: 2c156ac71c6b ("misc: Add host side PCI driver for PCI test functio=
n device")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/misc/pci_endpoint_test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint=
_test.c
index 01235236e9bc..24efe3b88a1f 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -729,6 +729,10 @@ static long pci_endpoint_test_ioctl(struct file *fil=
e, unsigned int cmd,
 	struct pci_dev *pdev =3D test->pdev;
=20
 	mutex_lock(&test->mutex);
+
+	reinit_completion(&test->irq_raised);
+	test->last_irq =3D -ENODATA;
+
 	switch (cmd) {
 	case PCITEST_BAR:
 		bar =3D arg;
--=20
2.39.2

