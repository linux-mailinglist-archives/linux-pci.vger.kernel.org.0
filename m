Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A396C8C06
	for <lists+linux-pci@lfdr.de>; Sat, 25 Mar 2023 08:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjCYHDE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Mar 2023 03:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbjCYHDC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Mar 2023 03:03:02 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4329EEF
        for <linux-pci@vger.kernel.org>; Sat, 25 Mar 2023 00:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679727778; x=1711263778;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nNNBPPwx3BeLf51ftFKDBjdeNrqS7hVotbLqERxh9VU=;
  b=FsftmrEyvv8zFLRX+3MFUMF3L10wyDeJS1MAkovSMjs2dQOMjvfX+aUI
   aOED1dimpDEQcFgwrk6iEL05iEyap1jF5eKc8ySWU5yG1wD91BGh4SYd/
   E719DuQclNi/HqEVBNYFR3EoJVLeMmEbTvqjTNSWKDG00s7DRNhHj1nqd
   Vuwl/5/mEB/OWzFsbX3hr05IsLMC3GXVfnecUXKa3MWPj+67xINx9V6gK
   msp2l05rW+n7IZZU/cHVA/bOQSF12EOoQf66b1U17LJHLQvZXN1hwG6Lu
   VZKK+8ulVEqNQcgXnQOONoBdZXqr+tDJfLDc0dIW//fXB7E6R5c1GhS9y
   w==;
X-IronPort-AV: E=Sophos;i="5.98,289,1673884800"; 
   d="scan'208";a="224756924"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2023 15:02:57 +0800
IronPort-SDR: E8ff1rfPxiPbCb9a1TExwJ+JlORZ9f37JD1q8Zf4oRYtFNUPfgaCSad8bJuOln1PNdC1WGps/C
 S4ej4ZuJlCqTszO0HvSCtYNbj7vVsEUtr9XPnS69sx+w/xH/PJ1qMBmXw/eWUDavTl+3KdmVgr
 AurhsMLIgm3+mfBSVkfXYKqpzu5bO4ULfh9Ffy8OkoAk7n0jOBnRh8ncYm0sPJImIMSJ2y+TzD
 XUSjArZtKi19I6imfYNdQu0APMLMXdCvO7kIqqgEHEh6G28u4BhIX7GUDsWTZzoznsVDwHi7HK
 QIo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Mar 2023 23:19:12 -0700
IronPort-SDR: fw/cdYMMccZ3GcRKkGjetMd7httdGQYDrRpe+mSdFjf5RYDf+VW4mViCejXjfq69XMcUiC3ow4
 pk/ffnU1GoDtA+zjEajUp/9gbbYccVaJfv5euItlyaX+i+4fku3dU9VZUKU65tdhWeYaKePZYA
 8Q+FEMbBBuJGSqEKmHHZijjV3kMvFrPqJn4TEXiktnyIDYcgCYGxiJOn//tZfrQ6qEsX5tM9yv
 FbAvLNTaNDcnTd7dXF9ujN+AqzZXF4CTSrFZ0lIff6vVE0uA8DbIDzoYWADagmJV6j/ORgwmt/
 x4k=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Mar 2023 00:02:58 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pk95F5Qcwz1RtVt
        for <linux-pci@vger.kernel.org>; Sat, 25 Mar 2023 00:02:57 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1679727777; x=1682319778; bh=nNNBPPwx3BeLf51ftF
        KDBjdeNrqS7hVotbLqERxh9VU=; b=XWwpfcbUHnLI5c5fimTdv/CJvgvE5uUsEr
        InGAa4He1kowskrbL3glrKgS5eAZ/S+nU9HjH6Zx8vfsDtKageWnOmbivT8+JdBI
        p5zreJv64LfW1fkLgc8/3aZFAZzEr5997Dt68HeF8v6H6JSL1YdmDA7Nbap169Ni
        pmF/3ylcdwC+nirfaAZJjBVaoiANScBIZfkcseXBvPjHOwNv8wcIghcf34OoHYxD
        mADghavU+nWnjv5DBGWF+qMEBDbtli/jr/6H60hzOKTaQWgmSMo7DGTXD2FQ6bsO
        h0M4+Km9vnh5fvwQ8nTHFO/A+0oh5L5AgfOC3y3AC8ZVcow7I0yA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id o7Leb_j5UwnC for <linux-pci@vger.kernel.org>;
        Sat, 25 Mar 2023 00:02:57 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pk95C5gZrz1RtVn;
        Sat, 25 Mar 2023 00:02:55 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 15/16] misc: pci_endpoint_test: Do not write status in IRQ handler
Date:   Sat, 25 Mar 2023 16:02:25 +0900
Message-Id: <20230325070226.511323-16-damien.lemoal@opensource.wdc.com>
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

