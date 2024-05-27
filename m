Return-Path: <linux-pci+bounces-7852-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD648D0083
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 14:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 740141F23EFB
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 12:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1619315E5DB;
	Mon, 27 May 2024 12:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HUMj+oLr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F0615E5C6;
	Mon, 27 May 2024 12:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716814565; cv=none; b=DBYNvnJuzK3B3lh+Rft0OKVEt+kkkbQ0FzHFvhhXQEpkW0GaWpNJ47GbWtObsIrx0QGBKW3+4l48OijHbJlH3nBHRX276lSk03jKDlh+W2F+fSoOkZkS+a1T+a0+DrMExYXum5RZ1898eUhpPeqjVgmi/KNkm2/EYPWRUgVi2ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716814565; c=relaxed/simple;
	bh=JpZFnOGLPxlVnryQ0+GLWGmjNOXMWnNyZQTAgap75Yc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QLkFDliik0T5UluLc4pGqfMiFyo0GKfAddOAQu1Q9+7ZahC6YD8HXZ/knbNsLBn+jaaUZDQC5SmIKuAtuSUP4jfo8MAEYTjl6My5504/fhoL0ky8VrFX8cd9ZJ/L2Y3ZSIb/IbbH7yEilVylzTrNMPvckTYOJluxbnS/9eGcHvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HUMj+oLr; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716814563; x=1748350563;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JpZFnOGLPxlVnryQ0+GLWGmjNOXMWnNyZQTAgap75Yc=;
  b=HUMj+oLrLEqGpP+354o2PydNBEZWoT47LkNbbsSA2nr0x5McxLqvS5rk
   ihVBk7dYAfPp9JqH2qxHM6yJrLRlUO+WlTZ8kp6yPvD4sNs7UE5swbpSR
   7oh+R8cCeAGWhkWWc4dc/EOBbH/wWa4ILwKfmy5WlQEeHO9jkB1WrBUm/
   MmTuwnOneC/Xlcvy9YaZDG2g+xJLGhGezHrQtPoKfGHG3YjrsKA3G+cS/
   M/yIirbG54sdLI0O9qWi5vOUiuVPLk+xhiYe6Q/yxh/ZqsDAsP68dCuwE
   AM05rjAKscEsN3isF92Qp7WlqrFK3BL9aD6FLIzvB8SXHI/VWKMqQ+1EY
   Q==;
X-CSE-ConnectionGUID: 3S8DwqcWROmy+VB6dSEmHw==
X-CSE-MsgGUID: nLfL30CISM6g+voixY8xYQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="23734117"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="23734117"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 05:56:02 -0700
X-CSE-ConnectionGUID: kaWJdMYBRqCxCTMNhnyzcQ==
X-CSE-MsgGUID: gNkS6SEwTWCYvL0ZT1B5xA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="34643644"
Received: from unknown (HELO localhost) ([10.245.247.139])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 05:55:59 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/4] x86/pci/intel_mid_pci: Fix PCIBIOS_* return code handling
Date: Mon, 27 May 2024 15:55:36 +0300
Message-Id: <20240527125538.13620-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240527125538.13620-1-ilpo.jarvinen@linux.intel.com>
References: <20240527125538.13620-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

intel_mid_pci_irq_enable() uses pci_read_config_byte() that returns
PCIBIOS_* codes. The error handling, however, assumes the codes are
normal errnos because it checks for < 0.

intel_mid_pci_irq_enable() also returns the PCIBIOS_* code back to the
caller but the function is used as the (*pcibios_enable_irq) function
which should return normal errnos.

Convert the error check to plain non-zero check which works for
PCIBIOS_* return codes and convert the PCIBIOS_* return code using
pcibios_err_to_errno() into normal errno before returning it.

Fixes: 5b395e2be6c4 ("x86/platform/intel-mid: Make IRQ allocation a bit more flexible")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: stable@vger.kernel.org
---
 arch/x86/pci/intel_mid_pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/pci/intel_mid_pci.c b/arch/x86/pci/intel_mid_pci.c
index 8edd62206604..722a33be08a1 100644
--- a/arch/x86/pci/intel_mid_pci.c
+++ b/arch/x86/pci/intel_mid_pci.c
@@ -233,9 +233,9 @@ static int intel_mid_pci_irq_enable(struct pci_dev *dev)
 		return 0;
 
 	ret = pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &gsi);
-	if (ret < 0) {
+	if (ret) {
 		dev_warn(&dev->dev, "Failed to read interrupt line: %d\n", ret);
-		return ret;
+		return pcibios_err_to_errno(ret);
 	}
 
 	id = x86_match_cpu(intel_mid_cpu_ids);
-- 
2.39.2


