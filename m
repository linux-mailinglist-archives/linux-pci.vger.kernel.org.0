Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7C561851A
	for <lists+linux-pci@lfdr.de>; Thu,  3 Nov 2022 17:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbiKCQrj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Nov 2022 12:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbiKCQrK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Nov 2022 12:47:10 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB0819C2C;
        Thu,  3 Nov 2022 09:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667493997; x=1699029997;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6sEwb2LvPX9v9prH3mu2nEGi0LVqQc1+Me9tIfh9Gsk=;
  b=FSAajs9mYEpAxwK1E+Kao7vQC/qmjWPLx+u/6kzAraWx6TeMe8tnDsLB
   g9o+1xrusrovOrcx7ToF5XANKPmAHc/1ZQ+Ms9pYKXlY+/x8i1zyEmYaw
   G6WRv0n8FJ8b/fnKRrCandQ+ULlB/HwEaHm2mUmnrpPE/TC6oj35Fgf/v
   YqCcJc/1s2ZszfDUGLDVGl4ufvcn06A7YJlj7sljN5Bv9w5nDhTXE1XCv
   JG13K+P6z4q27Bci4Ks+ohpmCH2umHYgK1Jsgf0E2lATSPvhpxc3l+EX/
   43+4a2eyGaxbbNxnksIZ8k/cbnCJJAXSoAKXimAsXFLNOov1GqpkbJHHk
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="373970810"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="373970810"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 09:46:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="629408020"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="629408020"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 03 Nov 2022 09:46:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 858A5F7; Thu,  3 Nov 2022 18:46:52 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Subject: [PATCH v2 0/4] PCI: Add pci_dev_for_each_resource() helper and refactor bus one
Date:   Thu,  3 Nov 2022 18:46:40 +0200
Message-Id: <20221103164644.70554-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Provide two new helper macros to iterate over PCI device resources and
convert users.

Looking at it, refactor existing pci_bus_for_each_resource() and convert
users accordingly.

This applies on top of this patch Mika sent out earlier:
https://lore.kernel.org/linux-pci/20221103103254.30497-1-mika.westerberg@linux.intel.com/

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

 .clang-format                      |  3 +++
 arch/alpha/kernel/pci.c            |  5 ++---
 arch/arm/kernel/bios32.c           | 16 ++++++-------
 arch/mips/pci/pci-legacy.c         |  3 +--
 arch/powerpc/kernel/pci-common.c   |  5 ++---
 arch/sparc/kernel/leon_pci.c       |  5 ++---
 arch/sparc/kernel/pci.c            | 10 ++++-----
 arch/sparc/kernel/pcic.c           |  5 ++---
 drivers/eisa/pci_eisa.c            |  4 ++--
 drivers/pci/bus.c                  |  7 +++---
 drivers/pci/hotplug/shpchp_sysfs.c |  8 +++----
 drivers/pci/pci.c                  |  5 ++---
 drivers/pci/probe.c                |  2 +-
 drivers/pci/remove.c               |  5 ++---
 drivers/pci/setup-bus.c            | 36 ++++++++++++------------------
 drivers/pci/setup-res.c            |  4 +---
 drivers/pci/xen-pcifront.c         |  4 +---
 drivers/pcmcia/rsrc_nonstatic.c    |  9 +++-----
 drivers/pcmcia/yenta_socket.c      |  3 +--
 include/linux/pci.h                | 25 +++++++++++++++++----
 20 files changed, 78 insertions(+), 86 deletions(-)

-- 
2.35.1

