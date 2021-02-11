Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B2F318C8B
	for <lists+linux-pci@lfdr.de>; Thu, 11 Feb 2021 14:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhBKNtL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Feb 2021 08:49:11 -0500
Received: from mga02.intel.com ([134.134.136.20]:48915 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231755AbhBKNoo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Feb 2021 08:44:44 -0500
IronPort-SDR: mHtRjXkzbeOKu+FjUGdff6tl6UCQySAVqJJ3545p5hXcNwyjzB861APgYhoEgOnmFKoL4sIeup
 R3we8R5Pwrxw==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="169366832"
X-IronPort-AV: E=Sophos;i="5.81,170,1610438400"; 
   d="scan'208";a="169366832"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2021 05:41:01 -0800
IronPort-SDR: y3sXK0kKzjrX/UZlMbVpzk5vcxjGtKjkPDr9P4YqcE/9aj5Pxnqt8K33GmKRlpxxgkfuy9+Dsi
 hJ5EbIqfuJGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,170,1610438400"; 
   d="scan'208";a="588798000"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 11 Feb 2021 05:40:54 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3408A579; Thu, 11 Feb 2021 15:40:46 +0200 (EET)
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
Subject: [PATCH v1 8/9] x86/platform/intel-mid: Remove unused header inclusion in intel-mid.h
Date:   Thu, 11 Feb 2021 15:40:07 +0200
Message-Id: <20210211134008.38282-9-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210211134008.38282-1-andriy.shevchenko@linux.intel.com>
References: <20210211134008.38282-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

After the commit f1be6cdaf57c ("x86/platform/intel-mid: Make
intel_scu_device_register() static") the platform_device.h is not being
used anymore by intel-mid.h. Remove it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/include/asm/intel-mid.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/include/asm/intel-mid.h b/arch/x86/include/asm/intel-mid.h
index c2c7da4c60cf..c043e91f45ad 100644
--- a/arch/x86/include/asm/intel-mid.h
+++ b/arch/x86/include/asm/intel-mid.h
@@ -8,7 +8,6 @@
 #define _ASM_X86_INTEL_MID_H
 
 #include <linux/pci.h>
-#include <linux/platform_device.h>
 
 extern int intel_mid_pci_init(void);
 extern int intel_mid_pci_set_power_state(struct pci_dev *pdev, pci_power_t state);
-- 
2.30.0

