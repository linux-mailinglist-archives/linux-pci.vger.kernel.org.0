Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAA22A63F6
	for <lists+linux-pci@lfdr.de>; Wed,  4 Nov 2020 13:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbgKDMNo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Nov 2020 07:13:44 -0500
Received: from mga14.intel.com ([192.55.52.115]:47985 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728287AbgKDMNn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 4 Nov 2020 07:13:43 -0500
IronPort-SDR: 1MpfaYdg47mB7Get8jpbEKh56afOF6/8JQpDinx45HRn0d+90V05Y8v99JK1/WQmYUU+WtHQhv
 Nst194offI7Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="168419488"
X-IronPort-AV: E=Sophos;i="5.77,450,1596524400"; 
   d="scan'208";a="168419488"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 04:13:43 -0800
IronPort-SDR: CvBR0A+Qgyd3U/98UQ71gFdI5mT22z3EdKYKHOrwN0jXx4Uc8OB1UB2Qglm5wFZlSpKz8uAPbR
 RIvETSBLq99A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,450,1596524400"; 
   d="scan'208";a="528915531"
Received: from tejas-system-product-name.iind.intel.com ([10.145.162.130])
  by fmsmga005.fm.intel.com with ESMTP; 04 Nov 2020 04:13:40 -0800
From:   Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     bp@alien8.de, lucas.demarchi@intel.com, matthew.d.roper@intel.com,
        hariom.pandey@intel.com
Subject: [PATCH] x86/gpu: add JSL stolen memory support
Date:   Wed,  4 Nov 2020 17:35:06 +0530
Message-Id: <20201104120506.172447-1-tejaskumarx.surendrakumar.upadhyay@intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

JSL re-uses the same stolen memory as ICL and EHL.

Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Matt Roper <matthew.d.roper@intel.com>
Signed-off-by: Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>
---
 arch/x86/kernel/early-quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
index a4b5af03dcc1..534cc3f78c6b 100644
--- a/arch/x86/kernel/early-quirks.c
+++ b/arch/x86/kernel/early-quirks.c
@@ -549,6 +549,7 @@ static const struct pci_device_id intel_early_ids[] __initconst = {
 	INTEL_CNL_IDS(&gen9_early_ops),
 	INTEL_ICL_11_IDS(&gen11_early_ops),
 	INTEL_EHL_IDS(&gen11_early_ops),
+	INTEL_JSL_IDS(&gen11_early_ops),
 	INTEL_TGL_12_IDS(&gen11_early_ops),
 	INTEL_RKL_IDS(&gen11_early_ops),
 };
-- 
2.28.0

