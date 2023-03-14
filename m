Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A846D6B9F90
	for <lists+linux-pci@lfdr.de>; Tue, 14 Mar 2023 20:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjCNT0J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Mar 2023 15:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjCNT0H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Mar 2023 15:26:07 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573047680;
        Tue, 14 Mar 2023 12:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678821963; x=1710357963;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=o5wvjgss3WToenPFVgKISR2zGwGV5RepaqjvWSlSslQ=;
  b=KNrV18sw6210DnZK1eieibt424sRaN+UjSdho91UXgFOgW/lEG8JWKz5
   dhfMivped0VLpl0ybj6BNJzl7yzEhQI0fGzFVDb9vEBEckYbo8LvOXEgm
   Mw1qT5qFhwAHk/1JDAs7Z7s7shsyEBN1uQXEMKEAJALn1mfyZm7UcMiT8
   RNMhkkNzgDdwaVxUslhQO72V36/Ov44/5qdbWqLMlVOivs4sHCtUDIjXk
   PoH0fk20HUsiCrn1luqIfo27Fyl4mD8SEiR3CmYgm+RwJemFxCk5wraEQ
   PaVKEpYPezzHzTd7b/c7xp+7Onkq+/k9dP6mnOBpl/PEvLV9LdCmFdSiB
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="321368987"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="321368987"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 12:26:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="822495607"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="822495607"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 14 Mar 2023 12:25:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 77DF1163; Tue, 14 Mar 2023 21:26:37 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Juergen Gross <jgross@suse.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-pci@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Anatolij Gustschin <agust@denx.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Subject: [PATCH v5 0/4] PCI: Add pci_dev_for_each_resource() helper and update users
Date:   Tue, 14 Mar 2023 21:26:30 +0200
Message-Id: <20230314192634.63531-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Provide two new helper macros to iterate over PCI device resources and
convert users.

Looking at it, refactor existing pci_bus_for_each_resource() and convert
users accordingly.

Changelog v5:
- renamed loop variable to minimize the clash (Keith)
- addressed smatch warning (Dan)
- addressed 0-day bot findings (LKP)

Changelog v4:
- rebased on top of v6.3-rc1
- added tag (Krzysztof)

Changelog v3:
- rebased on top of v2 by Mika, see above
- added tag to pcmcia patch (Dominik)

Changelog v2:
- refactor to have two macros
- refactor existing pci_bus_for_each_resource() in the same way and
  convert users

Andy Shevchenko (3):
  PCI: Split pci_bus_for_each_resource_p() out of
    pci_bus_for_each_resource()
  EISA: Convert to use pci_bus_for_each_resource_p()
  pcmcia: Convert to use pci_bus_for_each_resource_p()

Mika Westerberg (1):
  PCI: Introduce pci_dev_for_each_resource()

 .clang-format                             |  3 ++
 arch/alpha/kernel/pci.c                   |  5 ++-
 arch/arm/kernel/bios32.c                  | 16 +++++-----
 arch/arm/mach-dove/pcie.c                 | 10 +++---
 arch/arm/mach-mv78xx0/pcie.c              | 10 +++---
 arch/arm/mach-orion5x/pci.c               | 10 +++---
 arch/mips/pci/ops-bcm63xx.c               |  8 ++---
 arch/mips/pci/pci-legacy.c                |  3 +-
 arch/powerpc/kernel/pci-common.c          | 21 +++++++------
 arch/powerpc/platforms/4xx/pci.c          |  8 ++---
 arch/powerpc/platforms/52xx/mpc52xx_pci.c |  4 +--
 arch/powerpc/platforms/pseries/pci.c      | 16 +++++-----
 arch/sh/drivers/pci/pcie-sh7786.c         | 10 +++---
 arch/sparc/kernel/leon_pci.c              |  5 ++-
 arch/sparc/kernel/pci.c                   | 10 +++---
 arch/sparc/kernel/pcic.c                  |  5 ++-
 drivers/eisa/pci_eisa.c                   |  4 +--
 drivers/pci/bus.c                         |  7 ++---
 drivers/pci/hotplug/shpchp_sysfs.c        |  8 ++---
 drivers/pci/pci.c                         |  5 ++-
 drivers/pci/probe.c                       |  2 +-
 drivers/pci/remove.c                      |  5 ++-
 drivers/pci/setup-bus.c                   | 37 +++++++++--------------
 drivers/pci/setup-res.c                   |  4 +--
 drivers/pci/vgaarb.c                      | 17 +++--------
 drivers/pci/xen-pcifront.c                |  4 +--
 drivers/pcmcia/rsrc_nonstatic.c           |  9 ++----
 drivers/pcmcia/yenta_socket.c             |  3 +-
 drivers/pnp/quirks.c                      | 29 ++++++------------
 include/linux/pci.h                       | 29 ++++++++++++++----
 30 files changed, 142 insertions(+), 165 deletions(-)

-- 
2.39.2

