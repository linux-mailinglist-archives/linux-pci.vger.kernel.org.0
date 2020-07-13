Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E798F21E0EC
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 21:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgGMTow (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 15:44:52 -0400
Received: from mga05.intel.com ([192.55.52.43]:1454 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbgGMTow (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Jul 2020 15:44:52 -0400
IronPort-SDR: tusoCMWoQYjktk/tfw+FL1/vBcz5qpxh4421kz3YHcPgWvY/7mMUeGt6UsXjP+prD8R0dc0CNz
 Zy5SjMiuayLw==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="233561346"
X-IronPort-AV: E=Sophos;i="5.75,348,1589266800"; 
   d="scan'208";a="233561346"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2020 12:44:42 -0700
IronPort-SDR: ZtpPevMLxKEDVPqfS8nlOT3z7v3Ryrn9YI2Ivmi8dhFjmEBPzQ9GY8+1+OgJFFTDDJDseYBLND
 hseLdfM67N1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,348,1589266800"; 
   d="scan'208";a="316159780"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 13 Jul 2020 12:44:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 418BDCB; Mon, 13 Jul 2020 22:44:38 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-pci@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] x86/PCI: Describe @reg for type1_access_ok()
Date:   Mon, 13 Jul 2020 22:44:37 +0300
Message-Id: <20200713194437.11325-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200713194437.11325-1-andriy.shevchenko@linux.intel.com>
References: <20200713194437.11325-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Describe missed parameter in documentation of type1_access_ok().
Otherwise we get the following warning:

  CHECK   arch/x86/pci/intel_mid_pci.c
  CC      arch/x86/pci/intel_mid_pci.o
  arch/x86/pci/intel_mid_pci.c:152: warning: Function parameter or member 'reg' not described in 'type1_access_ok'

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/pci/intel_mid_pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/pci/intel_mid_pci.c b/arch/x86/pci/intel_mid_pci.c
index d8af4787e616..f855e12d7bed 100644
--- a/arch/x86/pci/intel_mid_pci.c
+++ b/arch/x86/pci/intel_mid_pci.c
@@ -141,6 +141,7 @@ static int pci_device_update_fixed(struct pci_bus *bus, unsigned int devfn,
  * type1_access_ok - check whether to use type 1
  * @bus: bus number
  * @devfn: device & function in question
+ * @reg: configuration register offset
  *
  * If the bus is on a Lincroft chip and it exists, or is not on a Lincroft at
  * all, the we can go ahead with any reads & writes.  If it's on a Lincroft,
-- 
2.27.0

