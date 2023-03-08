Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D866B024E
	for <lists+linux-pci@lfdr.de>; Wed,  8 Mar 2023 10:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjCHJEq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 04:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjCHJEf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 04:04:35 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE8A2BF0F
        for <linux-pci@vger.kernel.org>; Wed,  8 Mar 2023 01:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678266271; x=1709802271;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fn+76CMFq1pO5tJWIXTlXSR3vcfIIGSz5Meag7dwkN8=;
  b=f8w302tSbeFSF8pwO9E1DFsIN7/hr8BuFrUoqWTfv9rTZuXIOKfXK4Yy
   +yToHsDKtjWrtBACjnfp8+uKzszrfEQJa9jJJTCgkJrvPlN2s1jP/7lpq
   tEwW+36LzGOBFEgWIlNLk7d0i0GLRg8fViUl0YrU9N974wC1soXyMCsIm
   wCEScoJ3L0wBDA5dEmTaOZ220bEy91/kXDfWPp2kRtGfcDyTNV8IjDA/m
   RD+hlwHzdxrrzEDz4sXES9bBHjkIAbWYIxXbZU2QkHpjpFH73F0GAk3/y
   QIhCja97DigS8wu/QGnBYRgLz9zUt6Lq1C4oFhX3iizClMpDbmtXko6eu
   w==;
X-IronPort-AV: E=Sophos;i="5.98,243,1673884800"; 
   d="scan'208";a="224880563"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Mar 2023 17:03:33 +0800
IronPort-SDR: ye8UXIKBuOeepX+XzukCJpfwc0Qb+n4Yo1Kg4EkMjEVOf95aSMkjCygaIhiD3u42d65jtTBbqZ
 mJVttToRdm+79zcBha3998xIssnfIR3I4T1BxPonPFwXpG1dGWCi25fNYveFAW9TOqfPLilx0U
 p5qcGBDvwJvBNi97qGhMPb+SEbOeQ64WzYXeBv/bNrNu+0jtvzlIaeOjzVbeKQnLrxwig3Q6Rm
 7bD82rSDuKGSRq15URAOVgniw1mhZM479nxHECs+G9wPcW6Ec7lfw/IIBf1yrX8CgiMhi5IiCg
 wCc=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Mar 2023 00:14:31 -0800
IronPort-SDR: FzWXxXzjZGjIv+2Si8o1/qkkXCRXLoMK/v+DSdpzVxr8wAl+D8Pbig7Xr57YYhLrUMqk7IOwbh
 OTBUbxpYytcdZmrzXccxJZyz/DzQ8pcN+iNRjZ6BUiT2iPFfWPH+zgpAN2rvh9JHpdbuMD7g/H
 MwqUICUTjok9CjE7AbTzf5p6UQPuMvL0HLwiKW+KEmJ+suc2vaD/omLrnhd3MtBuh2pwfXU2TN
 nc/Q3UBRvO2Q2Dj1XT6Xd/pKiiAYiZlIn7gwDMiNLorEz8fNrZPsFipFZhNC2gWFLxKKf6UPW7
 ydc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Mar 2023 01:03:35 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PWmZF5nXGz1RwtC
        for <linux-pci@vger.kernel.org>; Wed,  8 Mar 2023 01:03:33 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1678266213; x=1680858214; bh=fn+76CMFq1pO5tJWIX
        TlXSR3vcfIIGSz5Meag7dwkN8=; b=MiXmWqCppG5gCmfPQq0bRMH8UEE3qMKsLl
        2vefZQP3qojSoOtdsMg3exvyNrQbeJRJPYIxTm0MKilrMaNJ9XL05HhW0uCJox8P
        k56+Q6ZwwCcEqjQsImcmJYDqSS9P3wyMw0V5/7ltkWZx8O62L8JDt5PNPzvYgb+0
        QF4dEdlnerWxBgChbtF3phEb6D4pyHsQsARawees2JBerBzB57ejwOBRh0pN1iYJ
        Wzu7Ivhbs1ss3sAvMOVHebE5udf5LT0B2pLo28MAihPCTIqVD619Yi7k+8DqXhF5
        pIl/zbKqlZK2H9NRCXf5FJI3cbwkJO9ETYyMXy0WPq1Fiy8ru38g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id G-no83OBx68T for <linux-pci@vger.kernel.org>;
        Wed,  8 Mar 2023 01:03:33 -0800 (PST)
Received: from ephost.wdc.com (unknown [10.225.163.68])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PWmZC3J6fz1RvTp;
        Wed,  8 Mar 2023 01:03:31 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 09/16] PCI: epf-test: Improve handling of command and status registers
Date:   Wed,  8 Mar 2023 18:03:06 +0900
Message-Id: <20230308090313.1653-10-damien.lemoal@opensource.wdc.com>
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

The pci-epf-test driver uses the test register bar memory directly
to get and execute a test registers set by the RC side and defined
using a struct pci_epf_test_reg. This direct use relies on a casts of
the register bar to get a pointer to a struct pci_epf_test_reg to
execute the test case and sending back the test result through the
status field of struct pci_epf_test_reg. In practice, the status field
is always updated before an interrupt is raised in
pci_epf_test_raise_irq(), to ensure that the RC side sees the updated
status when receiving the interrupts.

However, such cast-based direct access does not ensure that changes to
the status register make it to memory, and so visible to the host,
before an interrupt is raised, thus potentially resulting in the RC host
not seeing the correct status result for a test.

Avoid this potential problem by using READ_ONCE()/WRITE_ONCE() when
accessing the command and status fields of a pci_epf_test_reg structure.
This ensure that a test start (pci_epf_test_cmd_handler() function) and
completion (with the function pci_epf_test_raise_irq()) achive a correct
synchronization with the host side mmio register accesses.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/=
endpoint/functions/pci-epf-test.c
index 43d623682850..e0cf8c2bf6db 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -615,9 +615,14 @@ static void pci_epf_test_raise_irq(struct pci_epf_te=
st *epf_test,
 	struct pci_epf *epf =3D epf_test->epf;
 	struct device *dev =3D &epf->dev;
 	struct pci_epc *epc =3D epf->epc;
+	u32 status =3D reg->status | STATUS_IRQ_RAISED;
 	int count;
=20
-	reg->status |=3D STATUS_IRQ_RAISED;
+	/*
+	 * Set the status before raising the IRQ to ensure that the host sees
+	 * the updated value when it gets the IRQ.
+	 */
+	WRITE_ONCE(reg->status, status);
=20
 	switch (reg->irq_type) {
 	case IRQ_TYPE_LEGACY:
@@ -661,12 +666,12 @@ static void pci_epf_test_cmd_handler(struct work_st=
ruct *work)
 	enum pci_barno test_reg_bar =3D epf_test->test_reg_bar;
 	struct pci_epf_test_reg *reg =3D epf_test->reg[test_reg_bar];
=20
-	command =3D reg->command;
+	command =3D READ_ONCE(reg->command);
 	if (!command)
 		goto reset_handler;
=20
-	reg->command =3D 0;
-	reg->status =3D 0;
+	WRITE_ONCE(reg->command, 0);
+	WRITE_ONCE(reg->status, 0);
=20
 	if (reg->irq_type > IRQ_TYPE_MSIX) {
 		dev_err(dev, "Failed to detect IRQ type\n");
--=20
2.39.2

