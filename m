Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F11C148E17C
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jan 2022 01:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238411AbiANA2O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jan 2022 19:28:14 -0500
Received: from mga09.intel.com ([134.134.136.24]:31865 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235600AbiANA2N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Jan 2022 19:28:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642120093; x=1673656093;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9MmdtQRSP84iEIfaXDUKrSAI73pBddgm1gbmWx06UMk=;
  b=oBOLX2s5orz0XD3VMoZuPtVb1soV5NVPxJ+6tYUjFPnt7IWOYJfdOjTI
   HsGbJZcei7SvtcyqzULlbfaoc5hROkGVxdHHdJkkJDblYf/x3WYGczsi5
   CdlcOS62is+FRMKQu1+7rRY+gYTei6zwGPdcViYF8ADC+zURLnouIjHJf
   xnuEfqLxH8+4FNkACeKUiJSapXjybguDKNFXh7zEYNBO8FS98bt3nnN9a
   1mf7WThVOUvg2z/O0uMqvpX+wS0M6sBtqMsparv35tNdpwN8OGpzbY/zO
   RVQOk1ZytlNV0P5xm+PyjmvDW+Yg4HBujKhX4ALGD86T+kV2m64T6t2AV
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="243945288"
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="243945288"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 16:28:13 -0800
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="491317611"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.202])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 16:28:12 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     x86@kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH v5 5/5] x86/quirks: Improve line wrap on quirk conditions
Date:   Thu, 13 Jan 2022 16:28:43 -0800
Message-Id: <20220114002843.2083382-5-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220114002843.2083382-1-lucas.demarchi@intel.com>
References: <20220114002843.2083382-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove extra parenthesis and wrap lines so it's easier to read what are
the conditions being checked. The call to the hook also had an extra
indentation: remove here to conform to coding style.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 arch/x86/kernel/early-quirks.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
index 1db4d92f8a85..996e3cbc1c5f 100644
--- a/arch/x86/kernel/early-quirks.c
+++ b/arch/x86/kernel/early-quirks.c
@@ -769,14 +769,12 @@ static int __init check_dev_quirk(int num, int slot, int func)
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

