Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40136974D7
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 04:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbjBODWZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 22:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232655AbjBODWY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 22:22:24 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F162A32E76
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 19:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676431336; x=1707967336;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dJAY0cfcit6GrAbz/aj8uVJ/E88JV8yo1qsmIy6zvY8=;
  b=EDYvam0kJd/7sUO9k+thvvpjPbn9om+W1b2vCMG8o+xmlY0TSkffDpVU
   F17h6M974GyXzUsvN+5TIoFe263A9N/QFuvrE8rOnBPYHzsDMvLhZSTDw
   pJUT/XM2Rs1aw96hE1m7AY/lCx9g3i2u0/fKgo519Hhr4RMO4z1UwLHT5
   3NiSIWMk0xxKeUq8wWwujD+/Acg291usqFFTIsbpiT7BfPaZ5qhU+qu6i
   FAhUmYUJ9OHoh5LX8S4OrIbYjsW5X1RZ56rh69HUerYj8MAmuF/ElAzHS
   IMWBwIB+sGeAZLpzXoCsCBL9eAconBZHYhGqOZncYfbJ1QXHuzkJcQtmd
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,298,1669046400"; 
   d="scan'208";a="223351464"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2023 11:22:16 +0800
IronPort-SDR: zhevCybJ0T9CldeY5uwSnmhMMkrOF9k0rahfjAyhpJSi9CnNuy8MlVJHwvMJk+WAWYoYz0iGLT
 2PAF5icUJSQLPCQvy/plH9JkwPH8gpO8RzQsW6e8CFsFs7JHKKnyQs3wypzy/7q8oG3iCd0DVo
 YmMwLAirtwEApxAkDzGAo8WiqfKl1SxxTFS/a2XOCZ76tG3HaOcAYCuIMcH9QyMGLoZrmrrZ/W
 vFhBDxqEiGjFkezRngNF5MSsvH2DQoLaU7cmAb7IURFR1s6HzLFkeXp9etlVvrxi2d3sz1h81H
 UTE=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2023 18:33:39 -0800
IronPort-SDR: I0wXkBLL6OXxBKqA+J4dUW1SAv81YQiUKEQAqSTFWoDoZG+d243lUx8ICHoZVVeBfxwejybW9M
 cqIzY3Ikwlr7k/cet2UDCiBJWj9/cDWeTnAWfhifTBAVBR4DyfhXgUIHgeG/GHEKtjPjr02nVF
 uw9glk+HLF1AFppo9+zz/F1geXyBD4ywqx4CopAYxKxs4OCAt/i9t0IaqzTgQSuG7oqq9Q6Ak9
 ZAMr66RRh9pvFkzNTX4lNBejX0ux5DAcQp2azVJ+DjdB8iqyZSd4fvzAWeUxNA0pFn4Obj+afP
 92g=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2023 19:22:15 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PGk081kJSz1RwtC
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 19:22:16 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1676431335; x=1679023336; bh=dJAY0cfcit6GrAbz/a
        j8uVJ/E88JV8yo1qsmIy6zvY8=; b=e2jrhZ6dmvCSgGt/Ch4Oea1kfypTe3LcTy
        oN/lrxjySvYJetk6d6s+3nCO5vhF6N9QrYyiJ0xuuN3EBpgYsCoI0HmnTMx6bsmJ
        XcYg28svYDLigPGKppWCUr31zbTMKnfIN5O2fSPrE8MLNhMjW+CcgUubm6f6y8lB
        +aBBm9lbe/8u4X0Zamg3KrnKr/dS2k82yFgz6Glwh/6sOja3WB7NhRdjsqT8R9CD
        Sv/DmoU7uvfJUtidh0+BUEKHYjo889WTsrJMej1l52fJWsceL0ksjqBCS5O3+2WV
        OHlsMf011bnrDa/UYE0ZXrsGXfohIxbXHD4s6kODaiD+ufwkb3EQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UQOTBHkDVL6q for <linux-pci@vger.kernel.org>;
        Tue, 14 Feb 2023 19:22:15 -0800 (PST)
Received: from fedora.flets-east.jp (unknown [10.225.163.119])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PGk061pVDz1RvTp;
        Tue, 14 Feb 2023 19:22:13 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 09/12] misc: pci_endpoint_test: Do not write status in IRQ handler
Date:   Wed, 15 Feb 2023 12:21:52 +0900
Message-Id: <20230215032155.74993-10-damien.lemoal@opensource.wdc.com>
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
---
 drivers/misc/pci_endpoint_test.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint=
_test.c
index e27d471cc847..c1370950c79d 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -158,10 +158,7 @@ static irqreturn_t pci_endpoint_test_irqhandler(int =
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
2.39.1

