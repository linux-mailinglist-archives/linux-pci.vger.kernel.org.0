Return-Path: <linux-pci+bounces-6773-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 140568B55B8
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 12:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 462321C22A17
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 10:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECD53BB35;
	Mon, 29 Apr 2024 10:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hSoAbYLz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFEB3B1AA;
	Mon, 29 Apr 2024 10:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714387660; cv=none; b=vFg6o3dx3XFg5nxW5moV8mClwMzcuUz7um+LB2rtg2olZU/Gd4hKtsJNy0uGqhlDsvG3cwZ1InPTWgHRfXI0vDteoLESyM8mBf2KgWvwwaJp1S+hisWWSeZY8cIE1KRBWeIYPLMQdcahWTL+rd6TtutIgpYU6BnA6pAOiPCr4V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714387660; c=relaxed/simple;
	bh=Wc916WtLXl32fK/4WeXrrKL3Hri/FYOhOpr0WIpoRgU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qD3ush3We6HsOt2RrgK5CSMkqiUeHUfirwcVP2Hc3O9ukMPCGVQ8EbLX4jNWJO0H88ZhKK/F0nUw2omw7ttym/mFrYfR90EzAFn1xjv0uyN1G0N1bIEPkUbj/tbcyu1VFk5T/b2peXxaGF2HNnvmEisMiAao+6pgnFsbJD4XOpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hSoAbYLz; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714387658; x=1745923658;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wc916WtLXl32fK/4WeXrrKL3Hri/FYOhOpr0WIpoRgU=;
  b=hSoAbYLzCoQDLKgkwqA9ZORLRXn3e/UKeHzqJsxwDi6JqhbfsyDaO3cz
   fLBWWqo1UzbcdwLgTJu122Wi4QjDq7P9y/HCuNd8RMg2Q8tz/4rSxmWzr
   8MDL9c0tXWEknG7lhXSD0NrsVNN7glkVZL0GHgZNXi3iEOwO51gjAac0H
   cXWrPz12EIoTxQHFk3Cmqohu+VKhqDFzr6mkyk4XIgQHiEov75RuLrfLs
   7oVpcRt6JMV3J1J6Am22f/hMaBfNq5M/asAH1Otg2sYUoZ+QylLYtFAXF
   0EfuT+ar6PUDe5yy7BYdHzdr0zZUaE2qmtvnCS+qh6lJ/o/HJgyMqu5cl
   A==;
X-CSE-ConnectionGUID: 3qFg9pUMTme0Q6saKGACLQ==
X-CSE-MsgGUID: J9BfgjE+S6m2QRBL9fpssQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="27558986"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="27558986"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 03:47:38 -0700
X-CSE-ConnectionGUID: TIoj9xeOS469TRfuYgY/TQ==
X-CSE-MsgGUID: gWr1b7dpS1ObYa3kQl/YNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="30896766"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.45])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 03:47:35 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 06/10] PCI: ixp4xx: Replace 1 with PCI_CONF1_TRANSACTION
Date: Mon, 29 Apr 2024 13:46:29 +0300
Message-Id: <20240429104633.11060-7-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240429104633.11060-1-ilpo.jarvinen@linux.intel.com>
References: <20240429104633.11060-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add PCI_CONF1_TRANSACTION and replace literal 1 within PCI
Configuration Space Type 1 address with it.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/controller/pci-ixp4xx.c | 2 +-
 include/linux/pci.h                 | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-ixp4xx.c b/drivers/pci/controller/pci-ixp4xx.c
index 44639838df9c..ec0125344ca1 100644
--- a/drivers/pci/controller/pci-ixp4xx.c
+++ b/drivers/pci/controller/pci-ixp4xx.c
@@ -194,7 +194,7 @@ static u32 ixp4xx_config_addr(u8 bus_num, u16 devfn, int where)
 		/* type 1 */
 		return (PCI_CONF1_ADDRESS(bus_num, PCI_SLOT(devfn),
 					  PCI_FUNC(devfn), where) &
-			~PCI_CONF1_ENABLE) | 1;
+			~PCI_CONF1_ENABLE) | PCI_CONF1_TRANSACTION;
 	}
 }
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 4c4e3bb52a0a..df613428bc4d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1191,6 +1191,7 @@ void pci_sort_breadthfirst(void);
  * See PCI Local Bus Specification, Revision 3.0,
  * Section 3.2.2.3.2, Figure 3-1 and 3-2, p. 48-50.
  */
+#define PCI_CONF1_TRANSACTION	BIT(0)
 #define PCI_CONF_REG		0x000000ffU	/* common for Type 0/1 */
 #define PCI_CONF_FUNC		0x00000700U	/* common for Type 0/1 */
 #define PCI_CONF1_DEV		0x0000f800U
-- 
2.39.2


