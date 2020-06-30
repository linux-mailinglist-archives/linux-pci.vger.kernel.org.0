Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D49A20FB64
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jun 2020 20:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731573AbgF3SJU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Jun 2020 14:09:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:37132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728566AbgF3SJT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Jun 2020 14:09:19 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 482EB206C0;
        Tue, 30 Jun 2020 18:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593540558;
        bh=5WVwI9V0bvuYlDJK1bD7y8a6tFTxacqy/VIWlu5mFkE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=V5InnpzvN8ngt1Mwy7cPok3fE5TO7AU5KiaG7dHHaCoJc/shrphDd/wgvAEd9cJpp
         Hvv2A6/GvWO8Cr9C7dxiXsYRzpq0kfRCezleNguJFFwf+gQLY+ox8D6y0arhjM0NqA
         ZbNB9kMvPCQDC5OHV0/KvcRAhMrsHnN281jEL/4Y=
Date:   Tue, 30 Jun 2020 13:09:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     bhelgaas@google.com, corbet@lwn.net, robh+dt@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        hongxing.zhu@nxp.com, l.stach@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, m-karicheri2@ti.com, songxiaowei@hisilicon.com,
        wangbinghui@hisilicon.com, amurray@thegoodpenguin.co.uk,
        sathyanarayanan.kuppuswamy@linux.intel.com, hkallweit1@gmail.com,
        rafael.j.wysocki@intel.com, rdunlap@infradead.org,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: PCI: Replace lkml.org, spinics, gmane with lore.kernel.org
Message-ID: <20200630180917.GA3455699@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200627103050.71712-1-grandmaster@al2klimov.de>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI: Replace lkml.org, spinics, gmane with lore.kernel.org

The lkml.org, spinics.net, and gmane.org archives are not very reliable
and, in some cases, not even easily accessible.  Replace links to them with
links to lore.kernel.org, the archives hosted by kernel.org.

I found the gmane items via the Wayback Machine archive at
https://web.archive.org/.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/Documentation/PCI/pci.rst b/Documentation/PCI/pci.rst
index d2815d735c86..281d8a241eae 100644
--- a/Documentation/PCI/pci.rst
+++ b/Documentation/PCI/pci.rst
@@ -214,7 +214,7 @@ the PCI device by calling pci_enable_device(). This will:
    problem and unlikely to get fixed soon.
 
    This has been discussed before but not changed as of 2.6.19:
-   http://lkml.org/lkml/2006/3/2/194
+   https://lore.kernel.org/r/20060302180025.GC28895@flint.arm.linux.org.uk/
 
 
 pci_set_master() will enable DMA by setting the bus master bit
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 54ebbef850be..9d7a43261613 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3549,7 +3549,7 @@ static void quirk_no_bus_reset(struct pci_dev *dev)
  * The device will throw a Link Down error on AER-capable systems and
  * regardless of AER, config space of the device is never accessible again
  * and typically causes the system to hang or reset when access is attempted.
- * http://www.spinics.net/lists/linux-pci/msg34797.html
+ * https://lore.kernel.org/r/20140923210318.498dacbd@dualc.maya.org/
  */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0030, quirk_no_bus_reset);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0032, quirk_no_bus_reset);
@@ -4378,9 +4378,9 @@ static int pci_acs_ctrl_enabled(u16 acs_ctrl_req, u16 acs_ctrl_ena)
  * redirect (CR) since all transactions are redirected to the upstream
  * root complex.
  *
- * http://permalink.gmane.org/gmane.comp.emulators.kvm.devel/94086
- * http://permalink.gmane.org/gmane.comp.emulators.kvm.devel/94102
- * http://permalink.gmane.org/gmane.comp.emulators.kvm.devel/99402
+ * https://lore.kernel.org/r/201207111426.q6BEQTbh002928@mail.maya.org/
+ * https://lore.kernel.org/r/20120711165854.GM25282@amd.com/
+ * https://lore.kernel.org/r/20121005130857.GX4009@amd.com/
  *
  * 1002:4385 SBx00 SMBus Controller
  * 1002:439c SB7x0/SB8x0/SB9x0 IDE Controller
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index d21fa04fa44d..43eda101fcf4 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -73,7 +73,8 @@ static void pci_std_update_resource(struct pci_dev *dev, int resno)
 		/*
 		 * Apparently some Matrox devices have ROM BARs that read
 		 * as zero when disabled, so don't update ROM BARs unless
-		 * they're enabled.  See https://lkml.org/lkml/2005/8/30/138.
+		 * they're enabled.  See
+		 * https://lore.kernel.org/r/43147B3D.1030309@vc.cvut.cz/
 		 */
 		if (!(res->flags & IORESOURCE_ROM_ENABLE))
 			return;
