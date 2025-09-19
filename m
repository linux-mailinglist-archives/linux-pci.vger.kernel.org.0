Return-Path: <linux-pci+bounces-36506-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E9BB89E4B
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 16:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85F2358490B
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 14:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC3E314D09;
	Fri, 19 Sep 2025 14:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nfIHANGA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7A0313D65
	for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 14:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291774; cv=none; b=s+FsQbnUy3otUoE4vDJpHu3N9FX4/y7AJ9b3zuU91aPAXiH6Ms6cRJfnX1aW3ggZOKOU3WlNANStV4xWtrugtqZeieZJjZBhOZFJgzfgv1UZKYLdBLIKLT7fwkeGUWmXQgqvDQSBI0exBBELYb3J0x9n05X0NrDaXIky0miYMY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291774; c=relaxed/simple;
	bh=B/xWxhQzPYzp5YNqQTe9e/ym4DltUHgdmnHVqqykTQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CldzIYWTsmhLovTG67yS/1VjswcGHZ03rQRTn5O1TxJi3nCE5OCNQxAMM82e6yy0uw+56lmhLJ0A3ZMd9P8EfaHHOYqR3BRCn+Gvl3Yl7L3E6m0F4cshHmSVc1LAxP/BGLQne/YrulZg62/b5KlMsmgLihcCtGaDjM3rGZpP+lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nfIHANGA; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758291773; x=1789827773;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B/xWxhQzPYzp5YNqQTe9e/ym4DltUHgdmnHVqqykTQw=;
  b=nfIHANGAeZvvCcl2bjBvwb95G91D9hN3Xr25t9aDpq8k/SDVOUiceLTH
   GCxX9dwl70hrjNUhznf7daKKtd9IDzzwACXdihIMfkOpBQFvhUwFn2Chi
   hghhocD6FE/8mR9YPPYEgnq5rZHdF6Phh+m5bzITqtb+3/XNCLLaIkxO+
   6aoUgakRc5a02+yxZ6l+NnE+2KqrK1lYHJRxDdyKTh0CLJ3LALuuucatt
   UF3NxQfoBFKUGCnpVIAUn4xd5bqJKj0D1VFZ/+0lwk0+9NozXKLITIT1/
   MVr3Aib8Qr+c+0UiDVr4+2ONWm/FmDdr/k/BZmYqgJRmtJp3XTvFQE8SS
   w==;
X-CSE-ConnectionGUID: P9KKHc2GSGipXE+qwmOV0Q==
X-CSE-MsgGUID: 3C9UD0UTQTaYyQeDmFSsPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="60750581"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="60750581"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 07:22:41 -0700
X-CSE-ConnectionGUID: gBMVkTIpRZe/cRKyAHHhhQ==
X-CSE-MsgGUID: J8Z1lHehQRGwvCkcwc0Tyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="176655068"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa010.fm.intel.com with ESMTP; 19 Sep 2025 07:22:41 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: xin@zytor.com,
	chao.gao@intel.com,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: [RFC PATCH 25/27] PCI/IDE: Export pci_ide_domain()
Date: Fri, 19 Sep 2025 07:22:34 -0700
Message-ID: <20250919142237.418648-26-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919142237.418648-1-dan.j.williams@intel.com>
References: <20250919142237.418648-1-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xu Yilun <yilun.xu@linux.intel.com>

Export another mini helper for TSM drivers to setup root port side IDE.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
[djbw: todo: move this to drivers/pci/ide.c, skip export]
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/pci/ide.c       | 3 ++-
 include/linux/pci-ide.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
index 851633b240e3..b56f1a3033a2 100644
--- a/drivers/pci/ide.c
+++ b/drivers/pci/ide.c
@@ -345,12 +345,13 @@ void pci_ide_stream_unregister(struct pci_ide *ide)
 }
 EXPORT_SYMBOL_GPL(pci_ide_stream_unregister);
 
-static int pci_ide_domain(struct pci_dev *pdev)
+int pci_ide_domain(struct pci_dev *pdev)
 {
 	if (pdev->fm_enabled)
 		return pci_domain_nr(pdev->bus);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(pci_ide_domain);
 
 struct pci_ide_partner *pci_ide_to_settings(struct pci_dev *pdev, struct pci_ide *ide)
 {
diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
index 03e7561d4ad9..6a234ece405a 100644
--- a/include/linux/pci-ide.h
+++ b/include/linux/pci-ide.h
@@ -75,6 +75,7 @@ struct pci_ide {
 	struct tsm_dev *tsm_dev;
 };
 
+int pci_ide_domain(struct pci_dev *pdev);
 struct pci_ide_partner *pci_ide_to_settings(struct pci_dev *pdev, struct pci_ide *ide);
 struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev);
 void pci_ide_stream_free(struct pci_ide *ide);
-- 
2.51.0


