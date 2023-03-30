Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41656D0B07
	for <lists+linux-pci@lfdr.de>; Thu, 30 Mar 2023 18:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjC3Q2Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Mar 2023 12:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjC3Q2X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Mar 2023 12:28:23 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195AA1BD2;
        Thu, 30 Mar 2023 09:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680193702; x=1711729702;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+jsYsz3z4S0KxQURpz+5dUW16i3yUqiq6XHaWQFPwWw=;
  b=KWNB/Hf/Mddj+X+FG8MXxwdRk0lROCdGGZ8DanJF0pqjpZs6o7bNuN5M
   8xnc72VYeLN+leEaMzgtRNWVtF++N+S6pYj8tEHuwxLmcGhRIthrb1dXM
   03nRWjVRniJS/ZmHUpqJc2qsr/nFP9+Bp2aiqilAb8746dhoLhqGxl+1I
   /n5KqFD9t6BawYqDa2NwmZ7qJ3TS0RhT9lilxabFaZV1D2qMZj665eH2T
   NnMgDgEk7etfoURkFlGhbiUH5kpwawFUohzQ7fflpTfWfFWR45vmiU5Ko
   mFFibbT90qbD3BRjtwYCMXncaS+tRltPvCqetuWDPo6mTqR0wMhCRchg+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="427495915"
X-IronPort-AV: E=Sophos;i="5.98,305,1673942400"; 
   d="scan'208";a="427495915"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 09:28:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="858971536"
X-IronPort-AV: E=Sophos;i="5.98,305,1673942400"; 
   d="scan'208";a="858971536"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 30 Mar 2023 09:28:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9DDDB13A; Thu, 30 Mar 2023 19:24:42 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
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
Subject: [PATCH v8 0/7] Add pci_dev_for_each_resource() helper and update users
Date:   Thu, 30 Mar 2023 19:24:27 +0300
Message-Id: <20230330162434.35055-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Provide two new helper macros to iterate over PCI device resources and
convert users.

Looking at it, refactor existing pci_bus_for_each_resource() and convert
users accordingly.

Note, the amount of lines grew due to the documentation update.

Changelog v8:
- fixed issue with pci_bus_for_each_resource() macro (LKP)
- due to above added a new patch to document how it works
- moved the last patch to be #2 (Philippe)
- added tags (Philippe)

Changelog v7:
- made both macros to share same name (Bjorn)
- split out the pci_resource_n() conversion (Bjorn)

Changelog v6:
- dropped unused variable in PPC code (LKP)

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

Andy Shevchenko (6):
  kernel.h: Split out COUNT_ARGS() and CONCATENATE()
  PCI: Introduce pci_resource_n()
  PCI: Document pci_bus_for_each_resource() to avoid confusion
  PCI: Allow pci_bus_for_each_resource() to take less arguments
  EISA: Convert to use less arguments in pci_bus_for_each_resource()
  pcmcia: Convert to use less arguments in pci_bus_for_each_resource()

Mika Westerberg (1):
  PCI: Introduce pci_dev_for_each_resource()

 .clang-format                             |  1 +
 arch/alpha/kernel/pci.c                   |  5 +-
 arch/arm/kernel/bios32.c                  | 16 +++--
 arch/arm/mach-dove/pcie.c                 | 10 ++--
 arch/arm/mach-mv78xx0/pcie.c              | 10 ++--
 arch/arm/mach-orion5x/pci.c               | 10 ++--
 arch/mips/pci/ops-bcm63xx.c               |  8 +--
 arch/mips/pci/pci-legacy.c                |  3 +-
 arch/powerpc/kernel/pci-common.c          | 21 +++----
 arch/powerpc/platforms/4xx/pci.c          |  8 +--
 arch/powerpc/platforms/52xx/mpc52xx_pci.c |  5 +-
 arch/powerpc/platforms/pseries/pci.c      | 16 ++---
 arch/sh/drivers/pci/pcie-sh7786.c         | 10 ++--
 arch/sparc/kernel/leon_pci.c              |  5 +-
 arch/sparc/kernel/pci.c                   | 10 ++--
 arch/sparc/kernel/pcic.c                  |  5 +-
 drivers/eisa/pci_eisa.c                   |  4 +-
 drivers/pci/bus.c                         |  7 +--
 drivers/pci/hotplug/shpchp_sysfs.c        |  8 +--
 drivers/pci/pci.c                         |  3 +-
 drivers/pci/probe.c                       |  2 +-
 drivers/pci/remove.c                      |  5 +-
 drivers/pci/setup-bus.c                   | 37 +++++-------
 drivers/pci/setup-res.c                   |  4 +-
 drivers/pci/vgaarb.c                      | 17 ++----
 drivers/pci/xen-pcifront.c                |  4 +-
 drivers/pcmcia/rsrc_nonstatic.c           |  9 +--
 drivers/pcmcia/yenta_socket.c             |  3 +-
 drivers/pnp/quirks.c                      | 29 ++++-----
 include/linux/args.h                      | 13 ++++
 include/linux/kernel.h                    |  8 +--
 include/linux/pci.h                       | 72 +++++++++++++++++++----
 32 files changed, 190 insertions(+), 178 deletions(-)
 create mode 100644 include/linux/args.h

-- 
2.40.0.1.gaa8946217a0b

