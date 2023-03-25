Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99326C8C00
	for <lists+linux-pci@lfdr.de>; Sat, 25 Mar 2023 08:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjCYHCz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Mar 2023 03:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbjCYHCv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Mar 2023 03:02:51 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2201816A
        for <linux-pci@vger.kernel.org>; Sat, 25 Mar 2023 00:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679727767; x=1711263767;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hccwggJJwzfgdDztJNFo5zJ5OiRPzd+iDuSC1/Wq8lQ=;
  b=VqA/kCzkvqUaTYMlS9eJSuBQZsRsLRkhzzyQPgzNRoDt6hk7f2KumSNP
   Dt8J8H8t5CziZfUTo6J+9Sa4v9I6HaYeFK2QW0Og6YXXkXFwxzba2GZwh
   F7L/Sg8Wnw0ABdhSZeFP2SpGounGs6+1b5XYLDYUdg8TQFCyrlHNKNhhl
   h0ldan76R+/4dq8Lsv2BC3g9rUyv8teqQpEuwUBllQHPWc3yAaGYVaRWG
   G9JQ+yRGUEhWIjgLrGyS0eEsv6sTyGmMnGmy4n/D70BcUsYIua9pEHM36
   mzMFNPAXAVSwzGKRV4/S+yJ7uaBQP7hMu67aT7Z1ZGU+ULaXdBA/nNKvW
   w==;
X-IronPort-AV: E=Sophos;i="5.98,289,1673884800"; 
   d="scan'208";a="224756844"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2023 15:02:47 +0800
IronPort-SDR: Rnh9vKATpC1xoP4Z20pNSiiwnDZf6+VRyhqjPV9bseOLFlHgmUbS+kcGx7UG0xfw3rjDhj7aIf
 WyCkIZ0zDs1lWtRGKl4P5Gtost8NWMzshf+3ckVN9UWeX3h0ljTCncfur1mNQ3LhRCMLs4LoXz
 CGuobIEam5+oqnrUhmpkr378GGoUNuzi/rPu1SUALVZlbmtx2xBdVkO/MUp3Thy0cPLbiQkgXJ
 O3UVFYF3pBpXn/6d9xEJiCFJmM3eAMgyVkri0YFLLHy2rZDvdE++/mjgS2GW6gTgLR7bqHPoq5
 hmo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Mar 2023 23:19:02 -0700
IronPort-SDR: 9FGKLGevL2vRveG8EusDme1qhEI1tF1th0hJlZIxFBQusKvsFSmZ/LkcP/Mo7tLAwhICa8cuT2
 8TjKwzzsEtFtFD8rkwCiOFWNEzzrLWhxekGooqDbWKaz9kDtCRMU8czopbBHTCH/SFAd76R4MD
 lDut/i8/Gt4EYQAZkyv6bDOj4VU+6zMU+4VNo9tncSPqxBa/1To2kkb5epq5SquabtZx83ykvX
 2AqDoqHFkJduy/+o+EpNk1lnDsYQbuNmLuNtaKAyZJ1ptDbwilUZNZl/4abK5121YZBifBJzWz
 4xY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Mar 2023 00:02:48 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pk9531K75z1RtVq
        for <linux-pci@vger.kernel.org>; Sat, 25 Mar 2023 00:02:47 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1679727766; x=1682319767; bh=hccwggJJwzfgdDztJN
        Fo5zJ5OiRPzd+iDuSC1/Wq8lQ=; b=ORjXzP76DgZwxyU91yulctmtiUnNlOLf9h
        SCOnas/IPiNuw+Ej3PK/Rlz3UuloPNfoh7c9Q8/GvG3MH+ckVZ/IVUwFoAs4cD6e
        NsAkRDEkM9zrFGqiUH6xq8hJU8rqagTxso2quw+UC8HPXg8QFtIRpLtkPnoidNQ6
        YMzQ45iA3c8vzl1Sv48nVpdrCPVzmZvnnkM0jEq/Sxm5gR6kmBBJwWIJUMrbzSw4
        ITOhZ2qk1fU90VedJs0kiFGjHgVIejvT1s/WNUepgZ/oOf2GnvUJ+/LETUty5hyX
        go9406Bx+eVhqbTJV4wpCK1KteF2x03AxZURHGduMEp1uuIGbNGQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ypLLjA7LriHr for <linux-pci@vger.kernel.org>;
        Sat, 25 Mar 2023 00:02:46 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pk950662gz1RtVt;
        Sat, 25 Mar 2023 00:02:44 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 09/16] PCI: epf-test: Improve handling of command and status registers
Date:   Sat, 25 Mar 2023 16:02:19 +0900
Message-Id: <20230325070226.511323-10-damien.lemoal@opensource.wdc.com>
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

