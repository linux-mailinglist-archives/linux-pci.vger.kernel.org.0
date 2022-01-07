Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0267487DF7
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jan 2022 22:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiAGVFL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jan 2022 16:05:11 -0500
Received: from mga11.intel.com ([192.55.52.93]:64400 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229695AbiAGVFL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Jan 2022 16:05:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641589511; x=1673125511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vFLYInGUJc6hUal4AED9pTD9I7tbEWM8G9wbErgC8p0=;
  b=CZ9mUna1G/TP27ATou7jxGmnuV3iTs/yxSF7BcSukLXGnpxRP60nWSwa
   bWVQ/n6vWbxbkaRKYdSJ0RtiPjYdBNBT6bko93fEE6amd+vrD2GB+xCaE
   3rhnhF/8Y9UMdMuqSfdNBB1HcOXHqSbEe0C8MpX+9J9Ughm2Lpvg0sBJK
   CA+3xc/3r/uH7cbBvek65FKpvFFTbYd9KPc/5YsoyZ6cV60qpjIWfJjPh
   XGm0VdDKTL/lJZYLSErQ+ltD1XEePapupitbEJ8anjn7m5ubve3o9afFa
   +GMOm3l+IAfASZbxj8Fr5PEtrE3/X5DJ62C7wpaV1OKEsPYbmOUcPiXlG
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="240493446"
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="240493446"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 13:04:51 -0800
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="527506815"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.202])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 13:04:51 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     x86@kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Matt Roper <matthew.d.roper@intel.com>
Subject: [PATCH v3 2/3] x86/quirks: Improve line wrap on quirk conditions
Date:   Fri,  7 Jan 2022 13:05:15 -0800
Message-Id: <20220107210516.907834-2-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107210516.907834-1-lucas.demarchi@intel.com>
References: <20220107210516.907834-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove extra parenthesis and wrap lines so it's easier to read what are
the conditions being checked. The call to the hook also had an extra
indentation: remove here to conform to coding style.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 arch/x86/kernel/early-quirks.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
index 8b689c2b8cc7..df34963e23bf 100644
--- a/arch/x86/kernel/early-quirks.c
+++ b/arch/x86/kernel/early-quirks.c
@@ -767,14 +767,12 @@ static int __init check_dev_quirk(int num, int slot, int func)
 	device = read_pci_config_16(num, slot, func, PCI_DEVICE_ID);
 
 	for (i = 0; early_qrk[i].f != NULL; i++) {
-		if (((early_qrk[i].vendor == PCI_ANY_ID) ||
-			(early_qrk[i].vendor == vendor)) &&
-			((early_qrk[i].device == PCI_ANY_ID) ||
-			(early_qrk[i].device == device)) &&
-			(!((early_qrk[i].class ^ class) &
-			    early_qrk[i].class_mask)))
-				early_qrk[i].f(num, slot, func);
-
+		if ((early_qrk[i].vendor == PCI_ANY_ID ||
+		     early_qrk[i].vendor == vendor) &&
+		    (early_qrk[i].device == PCI_ANY_ID ||
+		     early_qrk[i].device == device) &&
+		    !((early_qrk[i].class ^ class) & early_qrk[i].class_mask))
+			early_qrk[i].f(num, slot, func);
 	}
 
 	type = read_pci_config_byte(num, slot, func,
-- 
2.34.1

