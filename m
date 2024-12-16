Return-Path: <linux-pci+bounces-18541-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A479B9F382B
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 18:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55D7F188F970
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 17:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC36A207A06;
	Mon, 16 Dec 2024 17:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fK6JDjdC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B13C20765E;
	Mon, 16 Dec 2024 17:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371858; cv=none; b=ZX6nNVLX9imqcSXua++tjFNFB7tjg+IZQ3CP3KtnFxjTC087E6DZ393TsZY38qOSZJdYWi8nnazGIUH+Qgn9rIy2R5sZJVj0gUOTy0afs8RRl/i9urFOIQEfmzJ2xH5jqCZSdXt2Kp7pjRHCDelivAq4D7MNK1PfUfqHS+SDvB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371858; c=relaxed/simple;
	bh=0cS8QYl05pYZeyUF+nQ9DcYCIw9aTu3c3ij04mOXpns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L3LZnkaLM4E4kRgZpT27RhKW38fpGgfEClF1rX1WdNuFqbDmoMzR1nhjMrLmLaFXd3VcPSCmYQM1xB9tMqlQ6qB4l3tr6LC6F9jgcprltV+2YJOx8HyuaKTb0byT2AXcN7kL9Jwqs/awYqukVtEVXYX/eXDQxPWNGn7yFwJNdq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fK6JDjdC; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734371857; x=1765907857;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0cS8QYl05pYZeyUF+nQ9DcYCIw9aTu3c3ij04mOXpns=;
  b=fK6JDjdC1uSAyk65FJu2kYvaL9QmtA2RUZ5OhQQR2Ts9+YJhS/D6AAfk
   wmiipdaUc3z5K6leabRCnmoxkXiyIifP/IaSg/pah58MkAFqnXB5LuXsp
   025RjzXcVww3V2NUI43EUguk6XhD3F3dVasy0+4959/n7GrftLJxqj+yL
   3gHWue+vut1aQCWpb2/seaqDpGxxHgKd7aG6o1q6oU9H1gJst0zuOVQYq
   dDhWWYbsYCvMmCRpKsx+wBZrSvDpT26UYY1ZhljWNPoFfFiSMqys5UrmG
   tsONnlH3BgXbKbwMMND1eFJD+OLUBimbcsXYwtnBmydrSI0RoHmJB/ezk
   Q==;
X-CSE-ConnectionGUID: oC8B1LQPRju7e+RYJQLNwA==
X-CSE-MsgGUID: hDksGtxMSMmAjlXsvL3LTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="57250877"
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="57250877"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:57:37 -0800
X-CSE-ConnectionGUID: 24mIv8ViTh2KLAgsT0lgvA==
X-CSE-MsgGUID: ZiEt2jPoR7+qPYuyBK2ORw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101418801"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.29])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:57:33 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	Igor Mammedov <imammedo@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 06/25] PCI: Use SZ_* instead of literals in setup-bus.c
Date: Mon, 16 Dec 2024 19:56:13 +0200
Message-Id: <20241216175632.4175-7-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241216175632.4175-1-ilpo.jarvinen@linux.intel.com>
References: <20241216175632.4175-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Convert literals in setup-bus.c to SZ_* defines that make the size more
human readable.

As the code is now self-explanatory, the comments about the size can be
eliminated.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index ca544fb83700..303c4fbf2d14 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -841,9 +841,9 @@ resource_size_t __weak pcibios_window_alignment(struct pci_bus *bus,
 	return 1;
 }
 
-#define PCI_P2P_DEFAULT_MEM_ALIGN	0x100000	/* 1MiB */
-#define PCI_P2P_DEFAULT_IO_ALIGN	0x1000		/* 4KiB */
-#define PCI_P2P_DEFAULT_IO_ALIGN_1K	0x400		/* 1KiB */
+#define PCI_P2P_DEFAULT_MEM_ALIGN	SZ_1M
+#define PCI_P2P_DEFAULT_IO_ALIGN	SZ_4K
+#define PCI_P2P_DEFAULT_IO_ALIGN_1K	SZ_1K
 
 static resource_size_t window_alignment(struct pci_bus *bus, unsigned long type)
 {
@@ -908,7 +908,7 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 				continue;
 			r_size = resource_size(r);
 
-			if (r_size < 0x400)
+			if (r_size < SZ_1K)
 				/* Might be re-aligned for ISA */
 				size += r_size;
 			else
-- 
2.39.5


