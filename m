Return-Path: <linux-pci+bounces-41955-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B42FC8161C
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 16:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 746614E202B
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 15:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D01313538;
	Mon, 24 Nov 2025 15:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GIJ//jUm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB251B425C;
	Mon, 24 Nov 2025 15:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763998671; cv=none; b=mYnmSu19Vzy2In1yF860s2gDcH/AwjoxsJkKKBEURprtRxMCheSU9G9H14Qf4KwqklXZrV1/56C1YPcDQu1cwTMa1d6J1ckv+4hFab2AXvUW5Ql2Eeu5QqhTfSkC5q3rG05qXDN95YXDx6P53jSg+0Ucy23DTDaGdlNcs/FRz3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763998671; c=relaxed/simple;
	bh=mvXmtYTlP0liL3n3HBxo+l820PLNPXobvd912Sw+u3k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=gF6eIV0Rcee2BYMN/twIKSDs/KvC9l2Tlv/h484mpszjTtbo+RO4l+gz0deKsQB3gI3OdBORTspPQKLQ255oW1My2N/huKEbmWluPSC3xwkOGAnUGn5fAkeU7u+feN/LDogiKi6mxyadglje8+Yslz/ri3qU3H3OJNaNpyzVhLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GIJ//jUm; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763998670; x=1795534670;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mvXmtYTlP0liL3n3HBxo+l820PLNPXobvd912Sw+u3k=;
  b=GIJ//jUmneTbcDZ45b8lnTZ9TWdJ3MyIMIMBDFf/6sRYFOX3yPrH3G/U
   6PH+uN5FC7/KoZ5KhtXmF7AJx6yEzB/UOP7G1R82O7d13ZqH9oD2JThl6
   Nvf32jxpVE3tNkTGC7kzRQ1mwVe+DDcKfI5acZZ4oR2n64NDWbwnvTq0D
   xruiPDUlJp7mACaar/2yRMGEhMB0DFBsfCfX6MdyMKIn/To8/GXU4YOsY
   ee3LTm6Pe8eycMkM2XnZ4velfQpPdI3po+Z66UrWSxn30jJaq/O8Ty8A6
   nfkxHqzEQSeEUX9gc3j+1cYb5fXfdEyc9sGYY85ZIwRRBKl1yYi6e9fDY
   w==;
X-CSE-ConnectionGUID: E5QnEZ55SrKE3uuJbbexvQ==
X-CSE-MsgGUID: bZjweMt4Q9iWQdYKn44XUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="65938012"
X-IronPort-AV: E=Sophos;i="6.20,223,1758610800"; 
   d="scan'208";a="65938012"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 07:37:49 -0800
X-CSE-ConnectionGUID: IF4uLpgiSO+WVDkaG+1itQ==
X-CSE-MsgGUID: UPgpsHpOSomYhjSu4SHGNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,223,1758610800"; 
   d="scan'208";a="215701942"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.97])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 07:37:46 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH 1/1] PCI: Check pci_rebar_size_supported() input
Date: Mon, 24 Nov 2025 17:37:40 +0200
Message-Id: <20251124153740.2995-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

According to Dan Carpenter, smatch detects issue with size parameter
given to pci_rebar_size_supported():

  drivers/pci/rebar.c:142 pci_rebar_size_supported()
  error: undefined (user controlled) shift '(((1))) << size'

  The problem is this call tree:
  __resource_resize_store() <- takes an unsigned long from the user
     -> pci_resize_resource() <- truncates it to int
        -> pci_rebar_size_supported()

The string input to __resource_resize_store() is to unsigned long and
then passed to pci_resize_resource(). There could be similar problems
also with the values coming from GPU drivers.

Add 'size' validation to pci_rebar_size_supported().

There seems to be no SZ_128T prior to this so add one to be able to
specify the largest size supported by the kernel (PCIe r7.0 spec
already defines sizes even beyond 128TB but kernel does not yet support
them).

The issue looks older than the introduction of
pci_rebar_size_supported() in the commit bb1fabd0d94e ("PCI: Add
pci_rebar_size_supported() helper").

It would be also nice to convert 'size' unsigned too everywhere, maybe
even u8 but that is left as further work.

Fixes: 8bb705e3e79d ("PCI: Add pci_resize_resource() for resizing BARs")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

As this is so close to the merge window, I assume this will be routed
through next but I suggest not folding it to the commit bb1fabd0d94e
("PCI: Add pci_rebar_size_supported() helper") as this should be
backported. It will fail backport immediately as pci_rebar_size_supported()
is only in pci/resource but I'll deal with it when the time comes and
create a backport for it to the older codebase.

---
 drivers/pci/rebar.c   | 3 +++
 include/linux/sizes.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/pci/rebar.c b/drivers/pci/rebar.c
index 8f7af3053cd8..a84165a196fa 100644
--- a/drivers/pci/rebar.c
+++ b/drivers/pci/rebar.c
@@ -139,6 +139,9 @@ bool pci_rebar_size_supported(struct pci_dev *pdev, int bar, int size)
 {
 	u64 sizes = pci_rebar_get_possible_sizes(pdev, bar);
 
+	if (size < 0 || size > ilog2(SZ_128T) - ilog2(PCI_REBAR_MIN_SIZE))
+		return false;
+
 	return BIT(size) & sizes;
 }
 EXPORT_SYMBOL_GPL(pci_rebar_size_supported);
diff --git a/include/linux/sizes.h b/include/linux/sizes.h
index 49039494076f..f1f1a055b047 100644
--- a/include/linux/sizes.h
+++ b/include/linux/sizes.h
@@ -67,5 +67,6 @@
 #define SZ_16T				_AC(0x100000000000, ULL)
 #define SZ_32T				_AC(0x200000000000, ULL)
 #define SZ_64T				_AC(0x400000000000, ULL)
+#define SZ_128T				_AC(0x800000000000, ULL)
 
 #endif /* __LINUX_SIZES_H__ */

base-commit: bf0a90fc907e47344f88e5b9b241082184dbac27
-- 
2.39.5


