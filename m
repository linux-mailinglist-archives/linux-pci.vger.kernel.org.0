Return-Path: <linux-pci+bounces-39429-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5B8C0DFF1
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 14:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64BEE188759C
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 13:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C1D2877F7;
	Mon, 27 Oct 2025 13:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GRt4zW2J"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED33E28C014;
	Mon, 27 Oct 2025 13:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761571476; cv=none; b=Jc1BnW5OPgIIQfxNXTrmqVaCdjPs7IOTRaelVnE9V1bD5uHuuHugRBJxPpbBfWlSi2zEoTWbeeD1lQtRpIqgCgtbZ1AIc7JGJyMqw7L+9PBXvaUV/ixTEi6px3zUyM5KpscUcaWqj0t0Zk9kA3YPM3TZQAR2e1LEwFrU8HC66Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761571476; c=relaxed/simple;
	bh=TKU+4j7gWYZtpLSZ5pjQ0NQoGKApNys6GUcTFacHHQM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=thVQP+Jt23DhsrbZl3oF7gOU6xkLv7ErLdSRU9e2/hRWj5OfmUJErG8YYbzBhSFSDhx87CkZBx/RRtqsdz+d4lSxZ/MwNQR/poIMoQAsjYo+y46yhz/wch5ymWP12yuv5zaLiOYGgdZEPKPUxKfLNELMDN5mZgRiQLWrMFQUqRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GRt4zW2J; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761571475; x=1793107475;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TKU+4j7gWYZtpLSZ5pjQ0NQoGKApNys6GUcTFacHHQM=;
  b=GRt4zW2JdBe9bdyfCNpFmzdrGcufmy2hYRMR/VBno/DkZCUV2n63wqaz
   QXcax0ACLWOa7mHr+idK82Glfe9q3bxsQRTiWbIItk+XDkkChfCwQ5OhR
   gRF1E5TFzF05/vCWbbdfZ5CG5tm+SRISjmPSHYcK8//tM5J0+SnqEoJ55
   j079dioSUCn4GJls42OCLpmijdAg6OjHq/a6n737Hyz8hOGUar9Sqo5v+
   LVwa3hcl4W/Rcgux5HXeeGLNnVBX3+lFkgPFJpjkZS9T+LECZGzjeqWMW
   yF9FySBhH3MQKqdXmFAQLy1KrBJtfvh7IrO/M8KRkxSkzFRNYZDAyTMZ9
   g==;
X-CSE-ConnectionGUID: yU4q3xSyRyG/KZAkPPg3LQ==
X-CSE-MsgGUID: fHfu5MLaTyC3wdpsmQw/Xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="67292435"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="67292435"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 06:24:34 -0700
X-CSE-ConnectionGUID: ULjEZh7qQbWQHc4Ak8XAqg==
X-CSE-MsgGUID: n8/bv+/cQ+2XTKosE6tGUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="184936352"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.41])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 06:24:32 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Klaus Kudielka <klaus.kudielka@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] PCI: Do not size non-existing prefetchable window
Date: Mon, 27 Oct 2025 15:24:23 +0200
Message-Id: <20251027132423.8841-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pbus_size_mem() should only be called for bridge windows that exist but
__pci_bus_size_bridges() may point 'pref' to a resource that does not
exist (has zero flags) in case of non-root buses.

When prefetchable bridge window does not exist, the same
non-prefetchable bridge window is sized more than once which may result
in duplicating entries into the realloc_head list. Duplicated entries
are shown in this log and trigger a WARN_ON() because realloc_head had
residual entries after the resource assignment algorithm:

pci 0000:00:03.0: [11ab:6820] type 01 class 0x060400 PCIe Root Port
pci 0000:00:03.0: PCI bridge to [bus 00]
pci 0000:00:03.0:   bridge window [io  0x0000-0x0fff]
pci 0000:00:03.0:   bridge window [mem 0x00000000-0x000fffff]
pci 0000:00:03.0: bridge window [mem 0x00200000-0x003fffff] to [bus 02] add_size 200000 add_align 200000
pci 0000:00:03.0: bridge window [mem 0x00200000-0x003fffff] to [bus 02] add_size 200000 add_align 200000
pci 0000:00:03.0: bridge window [mem 0xe0000000-0xe03fffff]: assigned
pci 0000:00:03.0: PCI bridge to [bus 02]
pci 0000:00:03.0:   bridge window [mem 0xe0000000-0xe03fffff]
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at drivers/pci/setup-bus.c:2373 pci_assign_unassigned_root_bus_resources+0x1bc/0x234

Check resource flags of 'pref' and only size the prefetchable window if
the resource has the IORESOURCE_PREFETCH flag.

Fixes: ae88d0b9c57f ("PCI: Use pbus_select_window_for_type() during mem window sizing")
Link: https://lore.kernel.org/linux-pci/51e8cf1c62b8318882257d6b5a9de7fdaaecc343.camel@gmail.com/
Reported-by: Klaus Kudielka <klaus.kudielka@gmail.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 362ad108794d..7cb6071cff7a 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1604,7 +1604,7 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 		pbus_size_io(bus, realloc_head ? 0 : additional_io_size,
 			     additional_io_size, realloc_head);
 
-		if (pref) {
+		if (pref && (pref->flags & IORESOURCE_PREFETCH)) {
 			pbus_size_mem(bus,
 				      IORESOURCE_MEM | IORESOURCE_PREFETCH |
 				      (pref->flags & IORESOURCE_MEM_64),

base-commit: 2f2c7254931f41b5736e3ba12aaa9ac1bbeeeb92
-- 
2.39.5


