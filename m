Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3588041ED34
	for <lists+linux-pci@lfdr.de>; Fri,  1 Oct 2021 14:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbhJAMR6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Oct 2021 08:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbhJAMR6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Oct 2021 08:17:58 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02ED8C061775
        for <linux-pci@vger.kernel.org>; Fri,  1 Oct 2021 05:16:13 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by albert.telenet-ops.be with bizsmtp
        id 0cGB2600S4C55Sk06cGByu; Fri, 01 Oct 2021 14:16:12 +0200
Received: from rox.of.borg ([192.168.97.57] helo=rox)
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mWHSU-0010xK-VB; Fri, 01 Oct 2021 14:16:10 +0200
Received: from geert by rox with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mWHSU-00BIs1-By; Fri, 01 Oct 2021 14:16:10 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] PCI: rcar: pcie-rcar-ep: Remove unneeded includes
Date:   Fri,  1 Oct 2021 14:16:09 +0200
Message-Id: <7c708841a2bf84f85b14a963271c3e99c8ba38a5.1633090444.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove includes that are not needed, to speed up (re)compilation.
Include <linux/pm_runtime.h>, which is needed, and was included
implicitly through <linux/phy/phy.h> before.

Most of these are relics from splitting the driver in a host and a
common part, and adding endpoint support.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pci/controller/pcie-rcar-ep.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar-ep.c b/drivers/pci/controller/pcie-rcar-ep.c
index aa1cf24a5a723d5f..f9682df1da61929b 100644
--- a/drivers/pci/controller/pcie-rcar-ep.c
+++ b/drivers/pci/controller/pcie-rcar-ep.c
@@ -6,16 +6,13 @@
  * Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
  */
 
-#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/of_pci.h>
 #include <linux/of_platform.h>
 #include <linux/pci.h>
 #include <linux/pci-epc.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 
 #include "pcie-rcar.h"
 
-- 
2.25.1

