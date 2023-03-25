Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366BF6C8C05
	for <lists+linux-pci@lfdr.de>; Sat, 25 Mar 2023 08:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjCYHDC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Mar 2023 03:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjCYHDA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Mar 2023 03:03:00 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88C576AC
        for <linux-pci@vger.kernel.org>; Sat, 25 Mar 2023 00:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679727776; x=1711263776;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9hc8RCCLWTxRBYC9gxcz8ZAIDPbMiGNQupCTpkbGyu0=;
  b=ZEJTVdsaBMS0Rio1xApWsNUwzLLksar4jsihd+F0Pw5wi7yKu7fQXqMd
   FyDHrwv6C40UT5b56Cw+bWIupvHSxHWZovGFIqk8SJlw7yyMY2aPu+ttK
   UCxWQtQB9mwfqJerNoHR3eJZ+I5YoxPNwaQmZe/tZ3Pp0uP/9u1W37pfv
   oz8OOZdZqOdwX5eYe1lRNDa/BPcrioBSulqEOv3mLHtnSLyZLUeUoMUzw
   Tf3CJUsKDBFM2qnhOq6gxDRkwO4RrcPKE8yutlA1GPdh48Or7F67+zjML
   OjUFCIun8+e3cd7a1c7weXdb4G7nzkdHrAnwlQUTqfR2uNbFIDv9uHtdS
   g==;
X-IronPort-AV: E=Sophos;i="5.98,289,1673884800"; 
   d="scan'208";a="224756919"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2023 15:02:56 +0800
IronPort-SDR: Q2aag1xP/q6MAy3fcrefbssWeN2m7qsQdhoBRWRBfaybQXWPSjVbyXzlPPPJltD8aWUDmMQ/zj
 2Ohk/jMFgmKdOcU2vS4RKmt5jnn1mOSSedXI6d1nLSHjvNTw2E2YokdXvIn6Inrh5S/yLwrYoG
 ijvMptJMRYm7FgcPYNFfjOzgYgDlwBbisb4e2wInm8Hod2ofAH48ovKfD67mEvUUYiRlYfhlew
 b11JGOIyxE6n0O1LPSJL500JmL2snohDp9VFi7R5hF4ehqKrBNYt/kZgYjAS60HXBpmnwZQhiU
 eA0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Mar 2023 23:19:11 -0700
IronPort-SDR: YEHH5W7QcuAuAOZst4MpINVe1VPch7GV4KVOHkzbd7RskHeV+g/vP+/ID9zbmg6n0WujnUCt/h
 1lBfwPacSC7wLBEmFvtdOWdAgPlSnVhGpCYW/DjTOSm7hQKt79KbG4Itzim+YuCCnlp6fQwUxn
 5k5Lh1oeh+ONPVI8ZnP3bFNjTPPntgd4PgYhothcKvosHTGYvauyDZtpc8n4CxZc8zdtXPDylY
 /DOvs0icj8rH0KzUMAG96fppMqzYSUapEQ161fdfHmomWnoyEJzKeNak2FYO0W0+Psx6f++veR
 D9I=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Mar 2023 00:02:57 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pk95D1RPPz1RtW0
        for <linux-pci@vger.kernel.org>; Sat, 25 Mar 2023 00:02:56 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1679727775; x=1682319776; bh=9hc8RCCLWTxRBYC9gx
        cz8ZAIDPbMiGNQupCTpkbGyu0=; b=ZdeuN38sM1qA0XgchFb/3INIsVfdvtLKAz
        mHUMIDJCyl7g1vWdOCAUuYQ6bAC49x/e0HzXk601ABa921G0zHd/W9cttwkboeS9
        Xbf+wB1wdVgdNJVPSTkKiVg3xShoRPU2hU+3eN/VnAq7zBhMFancRVNK2NjA937B
        qSXDZFWMWatZMSvGZ4FzMr3V382FtDVAQEmRbUxUUO0PXBlHx6HaaXkIKES0ns3W
        w8mw0E0e/JOmlOuQKyS+XFgFI2ktbLONPpQycyTQSATrSi9Sw85rTHCSk92FaOki
        5eXwDmL8ZqtjeLwHQUabK/3OJr10V4o6GILCixGYRSSvneL3AgUw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CcnUm1hTYjdj for <linux-pci@vger.kernel.org>;
        Sat, 25 Mar 2023 00:02:55 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pk95B1NXmz1RtVm;
        Sat, 25 Mar 2023 00:02:53 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 14/16] misc: pci_endpoint_test: Re-init completion for every test
Date:   Sat, 25 Mar 2023 16:02:24 +0900
Message-Id: <20230325070226.511323-15-damien.lemoal@opensource.wdc.com>
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

