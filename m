Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6811F651D7B
	for <lists+linux-pci@lfdr.de>; Tue, 20 Dec 2022 10:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiLTJek (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Dec 2022 04:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233425AbiLTJeP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Dec 2022 04:34:15 -0500
X-Greylist: delayed 567 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 20 Dec 2022 01:33:56 PST
Received: from mail.rosalinux.ru (mail.rosalinux.ru [195.19.76.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718ED18693;
        Tue, 20 Dec 2022 01:33:55 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.rosalinux.ru (Postfix) with ESMTP id 5052A71E3EEF;
        Tue, 20 Dec 2022 12:23:04 +0300 (MSK)
Received: from mail.rosalinux.ru ([127.0.0.1])
        by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id lOIaIJW5cXXj; Tue, 20 Dec 2022 12:23:04 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.rosalinux.ru (Postfix) with ESMTP id 1F02D71E3EF2;
        Tue, 20 Dec 2022 12:23:04 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rosalinux.ru 1F02D71E3EF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosalinux.ru;
        s=1D4BB666-A0F1-11EB-A1A2-F53579C7F503; t=1671528184;
        bh=Cun9tEP78/02t9DydkissoRdzYCxuv0h/3TtHOePWno=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=hdlWAnzU62LAZeu+PT6EsFieeCmhqqedMOh94GQhC6O/twY2COz3oGLvsDYzS4Q7/
         IYBtyYvkFoNGXWw5JZgGy1MhCOyMTawlM2HHvf7zoophgNYjqrGc5zwIDH9Ep02kgF
         tX2qYyXHxXNLSNkLQYI5BO6n2QyIuxzUJqIGYvcj+kpvuDvYS/m403tC4stXGKZ5Dj
         +8Bqkc9pX10eS8uMH3QoFEWC3x49uYQp6/3PsjQtpNt9NboBDm5R8X6FKeK1elHWaq
         6Ia5sFoFyx8KRPZyUwRd8Nr/ueTTcACqR2QDBfOXdzlYC01DNiFnPA3kKi5v4UMqfV
         sp55QrF0QFG0w==
X-Virus-Scanned: amavisd-new at rosalinux.ru
Received: from mail.rosalinux.ru ([127.0.0.1])
        by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id H6h4kHYvn23C; Tue, 20 Dec 2022 12:23:03 +0300 (MSK)
Received: from ubuntu.localdomain (unknown [144.206.93.23])
        by mail.rosalinux.ru (Postfix) with ESMTPSA id 7076271E3EEF;
        Tue, 20 Dec 2022 12:23:03 +0300 (MSK)
From:   Aleksandr Burakov <a.burakov@rosalinux.ru>
To:     Yue Wang <yue.wang@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Aleksandr Burakov <a.burakov@rosalinux.ru>,
        linux-pci@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: [PATCH] PCI: amlogic: The check for devm_add_action_or_reset's return value added
Date:   Tue, 20 Dec 2022 12:21:37 +0300
Message-Id: <20221220092137.6527-1-a.burakov@rosalinux.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The return value of the function devm_add_action_or_reset() was not
checked hence an error code would not be returned.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 9c0ef6d34fdb ("PCI: amlogic: Add the Amlogic Meson PCIe controller=
 driver")
Signed-off-by: Aleksandr Burakov <a.burakov@rosalinux.ru>
---
 drivers/pci/controller/dwc/pci-meson.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/control=
ler/dwc/pci-meson.c
index c1527693bed9..3d82f0b65480 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -187,9 +187,13 @@ static inline struct clk *meson_pcie_probe_clock(str=
uct device *dev,
 		return ERR_PTR(ret);
 	}
=20
-	devm_add_action_or_reset(dev,
+	ret =3D devm_add_action_or_reset(dev,
 				 (void (*) (void *))clk_disable_unprepare,
 				 clk);
+	if (ret) {
+		dev_err(dev, "couldn't reset clk\n");
+		return ERR_PTR(ret);
+	}
=20
 	return clk;
 }
--=20
2.25.1

