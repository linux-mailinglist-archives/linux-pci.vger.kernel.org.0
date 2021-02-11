Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89C9A318C79
	for <lists+linux-pci@lfdr.de>; Thu, 11 Feb 2021 14:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhBKNqA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Feb 2021 08:46:00 -0500
Received: from mga17.intel.com ([192.55.52.151]:41301 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232025AbhBKNnC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Feb 2021 08:43:02 -0500
IronPort-SDR: vSBJlWnvkFF/2hOxdGabGWIXnR6/pWTpd1kqybsGatQsZmvlQEgFotAmpOPAEGHdswOVpDMm6m
 MnrbtGWHrgqQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="161989287"
X-IronPort-AV: E=Sophos;i="5.81,170,1610438400"; 
   d="scan'208";a="161989287"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2021 05:41:00 -0800
IronPort-SDR: 3CrShcfgOK+PHt9p5uOnKbqZ98UviSTmLK6Buaxqgvp1wGP2oQkc5IA4uvq0vBHdKIj4B5UgIr
 todR9VJW91Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,170,1610438400"; 
   d="scan'208";a="362018023"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 11 Feb 2021 05:40:54 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1343735E; Thu, 11 Feb 2021 15:40:46 +0200 (EET)
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
Subject: [PATCH v1 5/9] x86/PCI: Describe @reg for type1_access_ok()
Date:   Thu, 11 Feb 2021 15:40:04 +0200
Message-Id: <20210211134008.38282-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210211134008.38282-1-andriy.shevchenko@linux.intel.com>
References: <20210211134008.38282-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Describe missed parameter in documentation of type1_access_ok().
Otherwise "make W=1 arch/x86/pci/" produces the following warning:
  CHECK   arch/x86/pci/intel_mid_pci.c
  CC      arch/x86/pci/intel_mid_pci.o
  arch/x86/pci/intel_mid_pci.c:152: warning: Function parameter or member 'reg' not described in 'type1_access_ok'

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/pci/intel_mid_pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/pci/intel_mid_pci.c b/arch/x86/pci/intel_mid_pci.c
index 938a8b7bfe7f..8edd62206604 100644
--- a/arch/x86/pci/intel_mid_pci.c
+++ b/arch/x86/pci/intel_mid_pci.c
@@ -142,6 +142,7 @@ static int pci_device_update_fixed(struct pci_bus *bus, unsigned int devfn,
  * type1_access_ok - check whether to use type 1
  * @bus: bus number
  * @devfn: device & function in question
+ * @reg: configuration register offset
  *
  * If the bus is on a Lincroft chip and it exists, or is not on a Lincroft at
  * all, the we can go ahead with any reads & writes.  If it's on a Lincroft,
-- 
2.30.0

