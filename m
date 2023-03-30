Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47696CFF42
	for <lists+linux-pci@lfdr.de>; Thu, 30 Mar 2023 10:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjC3Iyx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Mar 2023 04:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjC3Iyp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Mar 2023 04:54:45 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106D97ABE
        for <linux-pci@vger.kernel.org>; Thu, 30 Mar 2023 01:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680166473; x=1711702473;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nNNBPPwx3BeLf51ftFKDBjdeNrqS7hVotbLqERxh9VU=;
  b=QEYffDV4RDVjgO7W0csyNqUalvACAY8JE5LWjD3Nkp5HA+xmnFH6EMGz
   UzmwDvxqiCyGYYyI/S9Bh+p4AwJ8RoMEP+qFdCuQztluBHAz1JPYX6Vtc
   7aJMalsjGeruZyWmRS4qtJihBKBZodNtz4F11gcemtZvwsg4JTXuO+ErU
   EJ3krw4hi+LuzukRGfdVWiuPCkeU0JBQwgMzZ5B71VYCeC0lCwFjWmzQU
   aaOJ9nVmFLAD+hlDQ2liKXhmz48AeO62leb0S7hwTohhWF4xMtm86O7NT
   4v3MuhoCY6LQNVj8AVI08LY7T8+Xv/eP0IkeZokmQy8sykD8Qi9qkcMzX
   g==;
X-IronPort-AV: E=Sophos;i="5.98,303,1673884800"; 
   d="scan'208";a="331310496"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 16:54:30 +0800
IronPort-SDR: 05K367hqL39CWZuyqpEmfgeG63tQB5sisGsa6/VrmsIFb9kKnn5O8v2TgcWTDH2u56z1VaqRDw
 3VKoXqur3309IkShBSSuDbk2bWALPjPLhD0L8+O+7QSP9xrYglb6OUFEpNm5/Lxy53Em44TClZ
 ert8JYS4fBXVcOw5ispIg8kZC9CuWxXne4efICdVc0CVPmqnkb+B/f1lSOWLdoG9x8AkDjmL+F
 OJr0YRJBCCK7HZvpAkgzf+LY8EEbMHQY9Jz2te7Ra4SEFwqE9kobXDEPqX3e03FEfw2vuzjxyG
 Qp8=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 01:10:38 -0700
IronPort-SDR: TM2ap8c4VMbOoyv6VSEkXs84Xx+48Psr/j8OI0V/dywg58AnCchCNsbTmPbJr04InozrypR5WM
 Laop1ORB/WKoktgBu/2lq2MygwQgTyVnlNjC4h4ueJAyn6stbrbiiQN171rHQaV75JS+rPgpqC
 AG7NGJusFaHL/aI0WxrDRA8IVn9y5VlDxav1reuOL2Geeab9CkOa+MdXXoI1CE2as8Klsw/EHj
 Jpzt5c91BgijeXwyxIxwx3BIU4DnaR2UCnYqtj1pqP/Qbq4/5ebeumBvRXVr0rJtePVOZV3mdE
 4Ds=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 01:54:30 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PnHKd5dZTz1RtVy
        for <linux-pci@vger.kernel.org>; Thu, 30 Mar 2023 01:54:29 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1680166469; x=1682758470; bh=nNNBPPwx3BeLf51ftF
        KDBjdeNrqS7hVotbLqERxh9VU=; b=JtMq/OTySw4afmsOWIw5Cwvj3hcYmrbvQN
        5wAvhpSYmvjeWo48RcA0QS5c8sqoiepeTAqut+yWXjNjB33lv4pvk1rsIPzHKuqC
        oxXF50qdPDSiBwMoNeazZVV9R8OmpTLRZ7AnxEZ7slB5IacUMw69AV5RKu6cFqw9
        kBxclDQ4EE5WCk9IGhPRLEW+j6xN3t8OvpxQ5m2/VS/D0jxijVIg4HtgjUUucZ7e
        L27jHOd/HnOFPrOpYjqdaJKFO6p670lNGqdX7SrgHr7Mbtqt09VbgCNqVRPDktSO
        kn3Ex89TY4UpaJLqd3ga3bNl9alTtdyg4nUPBkXcUXGWOW2sP4OQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id E8T-2S0-gv2J for <linux-pci@vger.kernel.org>;
        Thu, 30 Mar 2023 01:54:29 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PnHKb68tWz1RtVn;
        Thu, 30 Mar 2023 01:54:27 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v4 16/17] misc: pci_endpoint_test: Do not write status in IRQ handler
Date:   Thu, 30 Mar 2023 17:53:56 +0900
Message-Id: <20230330085357.2653599-17-damien.lemoal@opensource.wdc.com>
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

pci_endpoint_test_irqhandler() always rewrites the status register when
an IRQ is raised, either as-is if STATUS_IRQ_RAISED is not set, or with
STATUS_IRQ_RAISED cleared if that flag is set. The first case creates a
race window with the endpoint side, meaning that the host side test
driver may end up reading what it just wrote, thus loosing the real
status as set by the endpoint side before raising the next interrupt.
This can prevent detecting that the STATUS_IRQ_RAISED flag was set by
the endpoint.

Remove this race window by not clearing the STATUS_IRQ_RAISED status
flag and not rewriting that register for every IRQ received.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/misc/pci_endpoint_test.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint=
_test.c
index 24efe3b88a1f..afd2577261f8 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -159,10 +159,7 @@ static irqreturn_t pci_endpoint_test_irqhandler(int =
irq, void *dev_id)
 	if (reg & STATUS_IRQ_RAISED) {
 		test->last_irq =3D irq;
 		complete(&test->irq_raised);
-		reg &=3D ~STATUS_IRQ_RAISED;
 	}
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_STATUS,
-				 reg);
=20
 	return IRQ_HANDLED;
 }
--=20
2.39.2

