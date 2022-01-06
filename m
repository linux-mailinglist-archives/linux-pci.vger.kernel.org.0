Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 211D4485D46
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jan 2022 01:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343884AbiAFAh2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jan 2022 19:37:28 -0500
Received: from mga12.intel.com ([192.55.52.136]:60121 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343873AbiAFAhC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Jan 2022 19:37:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641429422; x=1672965422;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h3Q4cCTzr96nj2DncAmhqRNXFGrLjnTNVAL8jkMeg/Q=;
  b=cPLpgvqB4oZztl6L80sSvoJjOexcKa+QXsNQVzlw1xLdO3Idj2UTKqRh
   EV0D8JTq5NndoimWSAuOwOk8GN6SCYp7tc0HB3a5rEbdJRIuk0CB22S+E
   2rZEsPMSWe6qICONuqY2Dlurp6B3sMq+DqQvHdX7g5R5OxyiqhZQ2JRvh
   1ybNgsKpKi/+ahBGY8/dyYmghBmc0K7bBk2ISliLOZV2fyiyabr5S0EvD
   KWh7HvH9fYRuzkbxdYAUlr/j1I2wc4O0VUcTqADjgj89qiLkR3KZXE15b
   KzQzKrU4reJvNKxhINjEWjHexAsmWNHV9rScb4hsEXtsFXCy93vAZ2pzP
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="222558162"
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; 
   d="scan'208";a="222558162"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 16:36:28 -0800
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; 
   d="scan'208";a="526766011"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.202])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 16:36:27 -0800
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
Subject: [PATCH v2 2/2] x86/quirks: better wrap quirk conditions
Date:   Wed,  5 Jan 2022 16:36:54 -0800
Message-Id: <20220106003654.770316-2-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220106003654.770316-1-lucas.demarchi@intel.com>
References: <20220106003654.770316-1-lucas.demarchi@intel.com>
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
index 102ecd0a910e..03256f802aba 100644
--- a/arch/x86/kernel/early-quirks.c
+++ b/arch/x86/kernel/early-quirks.c
@@ -766,14 +766,12 @@ static int __init check_dev_quirk(int num, int slot, int func)
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

