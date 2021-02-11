Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01843318C7C
	for <lists+linux-pci@lfdr.de>; Thu, 11 Feb 2021 14:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbhBKNqJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Feb 2021 08:46:09 -0500
Received: from mga06.intel.com ([134.134.136.31]:32463 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232018AbhBKNnC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Feb 2021 08:43:02 -0500
IronPort-SDR: JzOmRVpIAnd1DVMULS81c36CJkn9N0zwLb5f6Xqq+EBy4PNSdTT5bzd+TumVhtZRwi9Q0GsbzC
 LJN6DI04sQ2Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="243731534"
X-IronPort-AV: E=Sophos;i="5.81,170,1610438400"; 
   d="scan'208";a="243731534"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2021 05:40:53 -0800
IronPort-SDR: Q39XVtNXwgLLoTu2Y1h5v/7ttbGiA/VbPz59me3cbmB7Dm1YVucub5Kh7xw2LCTmStyw+6kPCB
 ujSdVpdMxW4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,170,1610438400"; 
   d="scan'208";a="490341617"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 11 Feb 2021 05:40:46 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0A71B35A; Thu, 11 Feb 2021 15:40:46 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Rapoport <rppt@kernel.org>, Wolfram Sang <wsa@kernel.org>,
        Sumit Gupta <sumitg@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        x86@kernel.org, linux-pm@vger.kernel.org,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mark Gross <mgross@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-acpi@vger.kernel.org
Subject: [PATCH v1 4/9] x86/PCI: Get rid of custom x86 model comparison
Date:   Thu, 11 Feb 2021 15:40:03 +0200
Message-Id: <20210211134008.38282-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210211134008.38282-1-andriy.shevchenko@linux.intel.com>
References: <20210211134008.38282-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Switch the platform code to use x86_id_table and accompanying API
instead of custom comparison against x86 CPU model.

This is one of the last users of custom API for that and following
changes will remove it for the good.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/pci/intel_mid_pci.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/x86/pci/intel_mid_pci.c b/arch/x86/pci/intel_mid_pci.c
index 95e2e6bd8d8c..938a8b7bfe7f 100644
--- a/arch/x86/pci/intel_mid_pci.c
+++ b/arch/x86/pci/intel_mid_pci.c
@@ -28,10 +28,12 @@
 #include <linux/io.h>
 #include <linux/smp.h>
 
+#include <asm/cpu_device_id.h>
 #include <asm/segment.h>
 #include <asm/pci_x86.h>
 #include <asm/hw_irq.h>
 #include <asm/io_apic.h>
+#include <asm/intel-family.h>
 #include <asm/intel-mid.h>
 #include <asm/acpi.h>
 
@@ -212,10 +214,17 @@ static int pci_write(struct pci_bus *bus, unsigned int devfn, int where,
 			       where, size, value);
 }
 
+static const struct x86_cpu_id intel_mid_cpu_ids[] = {
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_MID, NULL),
+	{}
+};
+
 static int intel_mid_pci_irq_enable(struct pci_dev *dev)
 {
+	const struct x86_cpu_id *id;
 	struct irq_alloc_info info;
 	bool polarity_low;
+	u16 model = 0;
 	int ret;
 	u8 gsi;
 
@@ -228,8 +237,12 @@ static int intel_mid_pci_irq_enable(struct pci_dev *dev)
 		return ret;
 	}
 
-	switch (intel_mid_identify_cpu()) {
-	case INTEL_MID_CPU_CHIP_TANGIER:
+	id = x86_match_cpu(intel_mid_cpu_ids);
+	if (id)
+		model = id->model;
+
+	switch (model) {
+	case INTEL_FAM6_ATOM_SILVERMONT_MID:
 		polarity_low = false;
 
 		/* Special treatment for IRQ0 */
-- 
2.30.0

