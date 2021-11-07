Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5979A447129
	for <lists+linux-pci@lfdr.de>; Sun,  7 Nov 2021 02:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbhKGBj5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 Nov 2021 21:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhKGBj4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Nov 2021 21:39:56 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F2AC061570;
        Sat,  6 Nov 2021 18:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=jQLZBi+wX3/W9cTFeeh0GrI0DtRr7qittIM2lkSiYRE=; b=e4J5OgY4qYdfOXmWO0jO+y/QDP
        Jj9VmrSJzhT+P1fq2sdTGWRxa0kTqlnOKd2dymgU3efKxtepTUZWXB4vdFSFFd2hT+hhkOR24J615
        GjMtnHO5fpzCecZRRFBdo4Aj65Pgbq2bPt06pQkXy5UZMZGJ3GrrrxBe/vWp0+R1+xuUL9DvM7/W7
        x8jOGnTNyMGYIviwBCN4Abd3yO8pbUieHxDBUZZKG7RKfuMMRVQq0iLw0FtSZHXowJBdGOwtJ787R
        vTR8qi/tgQ4uNUNz3zmb7lqstPOTyhN9qY9JrYsR2Khy/kiqQjKGJtFquVUcp/By28VD3FIaWnkoU
        ReStzMLw==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=merlin.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mjX7O-008bAC-Cz; Sun, 07 Nov 2021 01:37:11 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: [PATCH] PCI: rcar-host: adjust dependencies for ARM builds
Date:   Sat,  6 Nov 2021 18:37:03 -0700
Message-Id: <20211107013703.19995-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On ARCH=arm COMPILE_TEST builds, pcie-rcar-host.c uses __clk_is_enable(),
so for ARM builds, it should also depend on COMMON_CLK.

Fixes this build error:
arm-linux-gnueabi-ld: drivers/pci/controller/pcie-rcar-host.o: in function `rcar_pcie_aarch32_abort_handler':
pcie-rcar-host.c:(.text+0xdfc): undefined reference to `__clk_is_enabled'

Fixes: a18f4b6ea50b ("PCI: rcar: Rename pcie-rcar.c to pcie-rcar-host.c")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/r/202111070525.sBSwmOYY-lkp@intel.com
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
Fixes: tag might need some help...

 drivers/pci/controller/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20211106.orig/drivers/pci/controller/Kconfig
+++ linux-next-20211106/drivers/pci/controller/Kconfig
@@ -66,6 +66,7 @@ config PCI_RCAR_GEN2
 config PCIE_RCAR_HOST
 	bool "Renesas R-Car PCIe host controller"
 	depends on ARCH_RENESAS || COMPILE_TEST
+	depends on !ARM || (ARM && COMMON_CLK)
 	depends on PCI_MSI_IRQ_DOMAIN
 	help
 	  Say Y here if you want PCIe controller support on R-Car SoCs in host
