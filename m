Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80DFC6CFF3A
	for <lists+linux-pci@lfdr.de>; Thu, 30 Mar 2023 10:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjC3IyZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Mar 2023 04:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjC3IyV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Mar 2023 04:54:21 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A326EA5
        for <linux-pci@vger.kernel.org>; Thu, 30 Mar 2023 01:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680166458; x=1711702458;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hccwggJJwzfgdDztJNFo5zJ5OiRPzd+iDuSC1/Wq8lQ=;
  b=nxKex7RiAooyL2+gtNwCYChwZxbJe43W4LyEeE/aIZbjFQWflEyawZGv
   h+5GcbK3yYbB/6izZMpbkYxchW8Q7GnjTdFnojnxyi+aWtlIhicOqyag9
   8xZqfCSL/awImhLSpcUjH8kO6vODGTFeg0F6ZjYAU50d07yrQiBAMMZ8I
   3gUBcZDINtslbGiDbd/FJetbsTcbiQDFAHoBICTDlkfwg5yn8TkctM8ro
   SyFDOP/0mhWsUW61rO73YlyvgAleKU7sEYKlXUhv6yND9inF1U6t+RNnp
   SFHeIAt8vkm191uLQ7u2Jnw6+KA9vytLHGNWfX5+4MqtFGKPMNT65u8v8
   g==;
X-IronPort-AV: E=Sophos;i="5.98,303,1673884800"; 
   d="scan'208";a="331310467"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 16:54:18 +0800
IronPort-SDR: SGYQhnB58WdkGgvfzQfzCOm24sm5pZHGFyjKDawq4xNm4VSPC6Q5t3kXm7doEt9/9om3DdG4ux
 6cLPEKOBqqIt0hwLfBZZxCumfJ0QvU2cVtUH9j26m3bYoY5fBqUdvsMHSGF1rcUpM0LhYxd2hR
 WcpFfAqhvy9wzZFWcMHBPPiwsBtxL3PSePQ7pU14Lnpym6qoJGpzQ7zUflRId23HhPma8LjMMF
 sqUsGVQO0As7/9QzK/mtYURdXq+s/45VYq28QT/MHE8Tpup1I3k//2TSv3jeFjaODsP6IwIQsK
 NyI=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 01:10:26 -0700
IronPort-SDR: pn3StfRpEzalnzx36M1t5Lgy42mgZxPjaGBcryp0eg9qYCwJmXfSrrWAg8OKBjyPHe5vshPQsD
 FU14Hbzcj3t2ll9oKg+4ZbIhag/U58U6YDFk0NEfvlIT+3vGeGm0a91AOaiK2kRz4BDsvHUjbl
 4fOwa9F8pZRESieBmv5L5Cdbo48la/dhPbzHAUroli870AoUxv/QxJG2L55I4SDNS4PPGY4bds
 ZJYHKnnebvXaO9jiVNv9i36MgnTQHZVACBw+2yzI7MYIox5MBEoN7IilDN1jsQ6JFBynuYpIwg
 /ms=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 01:54:18 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PnHKP62hwz1RtW1
        for <linux-pci@vger.kernel.org>; Thu, 30 Mar 2023 01:54:17 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1680166456; x=1682758457; bh=hccwggJJwzfgdDztJN
        Fo5zJ5OiRPzd+iDuSC1/Wq8lQ=; b=aPNl9TZPNnyqrAj12LVLli8oq5J15uw6Vy
        xbiI2sjRMx8vg8tWys1428UIG0P5GrhSUSAxP7uZIOuTbYLVyr/fxmwAEt07GjS5
        NeoATS5YmFJB2rr202CNWj0wZKELUrj1/IzMphyGiNJmEIEfefDflU9Pj5M4of3S
        bCPPZHUcFV8zrYdh63NqeRUzTQFkbGUFdy+dVgim6vz9Rz4M/XIqTtxi5BE+sAFQ
        PAs8BbA12wUR6/EoeqRNq1lAEqQkZNtLpeHchHlLAL7b3hOizc4BPf0YNZEO1Tx9
        qzp4yMAKXlXW37ck4ht28LYEx4gq0rEIiHqZ6tcgZ40SkDLW8afA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ABqGDr16b0YR for <linux-pci@vger.kernel.org>;
        Thu, 30 Mar 2023 01:54:16 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PnHKM1jPHz1RtVn;
        Thu, 30 Mar 2023 01:54:14 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v4 09/17] PCI: epf-test: Improve handling of command and status registers
Date:   Thu, 30 Mar 2023 17:53:49 +0900
Message-Id: <20230330085357.2653599-10-damien.lemoal@opensource.wdc.com>
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

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/=
endpoint/functions/pci-epf-test.c
index ee90ba3a957b..fa48e9b3c393 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -613,9 +613,14 @@ static void pci_epf_test_raise_irq(struct pci_epf_te=
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
@@ -659,12 +664,12 @@ static void pci_epf_test_cmd_handler(struct work_st=
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

