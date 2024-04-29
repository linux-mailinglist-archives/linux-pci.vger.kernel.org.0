Return-Path: <linux-pci+bounces-6759-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 295528B5476
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 11:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4AD6283448
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 09:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9672561F;
	Mon, 29 Apr 2024 09:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aDTs/k8q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0A6241E7;
	Mon, 29 Apr 2024 09:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714384046; cv=none; b=J5EWnh1uHpvoHHtRQwy7qDwB37U0Lxc6c7S57HuGLx/9WA67DwiARxd116IENZRKlJZKxorA65eAfmv5O23wQCllX/axjdI4LrVbjCbe5ebx7Vi49GsXeEhsCAE3UQQajes2gBz2lzB9yFLXXX/+eGTxRVn8y7fRPeLPoTncnZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714384046; c=relaxed/simple;
	bh=FiUQFSZ5TWsRn5gQDgwM56G22Frjahny+X6RQ44e+/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZwqzUVVInYwt7EWadQxZ80NiRedHklebzeagN6BkhBp8xTl7z5O8ULFygvxC2vIJ2VPF+NnTLDo2UpJ9hRFlMU/fXRgG7xFPLMBikZaWT5xkGAv7BTFRCVwnDrIOnmQqUBXWbNcfpQY44mIHMsiZcftf2Gc3bjgKHRq8S8X/H5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aDTs/k8q; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714384045; x=1745920045;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FiUQFSZ5TWsRn5gQDgwM56G22Frjahny+X6RQ44e+/U=;
  b=aDTs/k8qAsO01J4Z5vN0e03B84U7CULODv7f6xSgfmQvcl4BjBB1etUg
   Zmcv1B1nd8yO3TBNW7/VClWnsDlenTGvfYGRxA2InZg+9TyMg+jcJLFSt
   iTeqCalxk3gfPQ985bvDOVqP2dRJyXk8JW90dNAFvbYomG+Wp0NAEZ9Bx
   T8eePgdBkvstj7RxQcb5ntlwY/7Kng3w4FnwHml+NJWwkbRK4wNZ7NWTX
   ebnVO/vlSRDnoloUbvrzkdHw7LMbluIqgybKUNt4BZAs/lKexA/mU7XLX
   Dh2kZV/m/cKtSuc5N3nhPKJ+qy1mGmfD73Njxb3CBSgpbIBgd6MEO+EAB
   w==;
X-CSE-ConnectionGUID: OQvjCC7RQjGH7IAwr1w8zw==
X-CSE-MsgGUID: +n0zUJK3RWiHeO3HvOxiQA==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="9961070"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="9961070"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 02:47:25 -0700
X-CSE-ConnectionGUID: ouePNqYqRRSgHEWMUv9Klw==
X-CSE-MsgGUID: 1mLGzO2EQrWAR0Wkl6iAOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26058079"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.45])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 02:47:23 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 2/2] PCI: Cleanup accessor macros formatting
Date: Mon, 29 Apr 2024 12:47:07 +0300
Message-Id: <20240429094707.2529-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240429094707.2529-1-ilpo.jarvinen@linux.intel.com>
References: <20240429094707.2529-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Cleanup formatting of PCI accessor macros:

- Put return statements on own line
- Add a few empty lines for better readability
- Align macro continuation backslashes
- Correct function call argument indentation level
- Reorder variable declarations to reverse xmas tree

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/access.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 6449056b57dd..4962a841fa35 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -36,10 +36,13 @@ DEFINE_RAW_SPINLOCK(pci_lock);
 int noinline pci_bus_read_config_##size \
 	(struct pci_bus *bus, unsigned int devfn, int pos, type *value)	\
 {									\
-	int res;							\
 	unsigned long flags;						\
 	u32 data = 0;							\
-	if (PCI_##size##_BAD) return PCIBIOS_BAD_REGISTER_NUMBER;	\
+	int res;							\
+									\
+	if (PCI_##size##_BAD)						\
+		return PCIBIOS_BAD_REGISTER_NUMBER;			\
+									\
 	pci_lock_config(flags);						\
 	res = bus->ops->read(bus, devfn, pos, len, &data);		\
 	if (res)							\
@@ -47,6 +50,7 @@ int noinline pci_bus_read_config_##size \
 	else								\
 		*value = (type)data;					\
 	pci_unlock_config(flags);					\
+									\
 	return res;							\
 }
 
@@ -54,12 +58,16 @@ int noinline pci_bus_read_config_##size \
 int noinline pci_bus_write_config_##size \
 	(struct pci_bus *bus, unsigned int devfn, int pos, type value)	\
 {									\
-	int res;							\
 	unsigned long flags;						\
-	if (PCI_##size##_BAD) return PCIBIOS_BAD_REGISTER_NUMBER;	\
+	int res;							\
+									\
+	if (PCI_##size##_BAD)						\
+		return PCIBIOS_BAD_REGISTER_NUMBER;			\
+									\
 	pci_lock_config(flags);						\
 	res = bus->ops->write(bus, devfn, pos, len, value);		\
 	pci_unlock_config(flags);					\
+									\
 	return res;							\
 }
 
@@ -216,24 +224,27 @@ static noinline void pci_wait_cfg(struct pci_dev *dev)
 }
 
 /* Returns 0 on success, negative values indicate error. */
-#define PCI_USER_READ_CONFIG(size, type)					\
+#define PCI_USER_READ_CONFIG(size, type)				\
 int pci_user_read_config_##size						\
 	(struct pci_dev *dev, int pos, type *val)			\
 {									\
 	int ret = PCIBIOS_SUCCESSFUL;					\
 	u32 data = -1;							\
+									\
 	if (PCI_##size##_BAD)						\
 		return -EINVAL;						\
-	raw_spin_lock_irq(&pci_lock);				\
+									\
+	raw_spin_lock_irq(&pci_lock);					\
 	if (unlikely(dev->block_cfg_access))				\
 		pci_wait_cfg(dev);					\
 	ret = dev->bus->ops->read(dev->bus, dev->devfn,			\
-					pos, sizeof(type), &data);	\
-	raw_spin_unlock_irq(&pci_lock);				\
+				  pos, sizeof(type), &data);		\
+	raw_spin_unlock_irq(&pci_lock);					\
 	if (ret)							\
 		PCI_SET_ERROR_RESPONSE(val);				\
 	else								\
 		*val = (type)data;					\
+									\
 	return pcibios_err_to_errno(ret);				\
 }									\
 EXPORT_SYMBOL_GPL(pci_user_read_config_##size);
@@ -244,14 +255,17 @@ int pci_user_write_config_##size					\
 	(struct pci_dev *dev, int pos, type val)			\
 {									\
 	int ret = PCIBIOS_SUCCESSFUL;					\
+									\
 	if (PCI_##size##_BAD)						\
 		return -EINVAL;						\
-	raw_spin_lock_irq(&pci_lock);				\
+									\
+	raw_spin_lock_irq(&pci_lock);					\
 	if (unlikely(dev->block_cfg_access))				\
 		pci_wait_cfg(dev);					\
 	ret = dev->bus->ops->write(dev->bus, dev->devfn,		\
-					pos, sizeof(type), val);	\
-	raw_spin_unlock_irq(&pci_lock);				\
+				   pos, sizeof(type), val);		\
+	raw_spin_unlock_irq(&pci_lock);					\
+									\
 	return pcibios_err_to_errno(ret);				\
 }									\
 EXPORT_SYMBOL_GPL(pci_user_write_config_##size);
-- 
2.39.2


