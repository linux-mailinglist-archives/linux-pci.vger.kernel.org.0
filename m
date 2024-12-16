Return-Path: <linux-pci+bounces-18537-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B7F9F381B
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 18:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA48C188F4F5
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 17:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6C5207A05;
	Mon, 16 Dec 2024 17:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a1UBBTyw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438ED2066E0;
	Mon, 16 Dec 2024 17:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371825; cv=none; b=s+ldoxMkjaQMkxfuacakx+orkUUbUflFUCvNY7kV+gZIQdROLY6z4/Gik8cfOAYe2lEFq/L8IEI7u6ZMm5lqLtSw33ANCOrtx9UCFDW1bQtrAELdIektK9buzpXGoFRH1F4svB0uIRKqTb6Dg5bewi0Cj/NvcrLSvvUFc2PHSvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371825; c=relaxed/simple;
	bh=h+FgumeOC/q2PKTlkJhvmfVs/+GxY2pDU60CX54A8K4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=erdwTvuK9Kiny8VAlcu4mqVon3fc3wlbT3aJ7aUPOPLUCcX1h5klRYt3nirUXgHM4utLZxbglWTKwL4AeaEef7PnPPQO3OvBJXq54PNrbgPEKnkfKmD6yv/VTSmRAAeVB32+1WhIptoInxN1bLQih6A/TQ5Qor8XE4k6r6MP1OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a1UBBTyw; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734371823; x=1765907823;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h+FgumeOC/q2PKTlkJhvmfVs/+GxY2pDU60CX54A8K4=;
  b=a1UBBTywgyBKHL+x1e1zOWVPbxQpWTQq9aHugHrRpHm4QKrDzisk2gZh
   +RCJLVMZXFOsPmSW9U4nmaYNn1IANs3vUyt/P0fGHOOYT82Qb0EBPN2JC
   o4w/PM6ztX17e7r+DP5zOAiPFJMvLZdgJM2p3QOX4qFJWnf5MBGQM9VlI
   WxStp/NSOFr+z7E2ZDlbZ9JT0fZFhPGmk0G95er7rjFV4NAZxMSJgYEUy
   0FZHXiWb0yITXXymITRyEivOl6E/ssA8r8e9jwZLi9IdhWwRWmjWCQ3Ip
   M2eVbYklIyR/cz56Lf5mIolltBsVV9p4Fk4L7s/VulCVxRhBX0JE7bV78
   g==;
X-CSE-ConnectionGUID: WeVP3ZP6QBST9qV1uTUIbw==
X-CSE-MsgGUID: wpKBCj6iRyiH3Ic1AoYwTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="45465713"
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="45465713"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:57:02 -0800
X-CSE-ConnectionGUID: MzE7bZkzQo+EA0RxkbCPxQ==
X-CSE-MsgGUID: k/bM3eEFRcu4jmxFTvIzoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="97309333"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.29])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:56:58 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	Igor Mammedov <imammedo@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 02/25] PCI: size0 is unrelated to add_align
Date: Mon, 16 Dec 2024 19:56:09 +0200
Message-Id: <20241216175632.4175-3-ilpo.jarvinen@linux.intel.com>
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

The commit 566f1dd52816 ("PCI: Relax bridge window tail sizing rules")
relaxed bridge window tail alignment rule for the non-optional part
(size0, no add_size/add_align). The required alignment given for
pbus_upstream_space_available(), however, was add_align which relates
only to size1 alignment.

As pbus_upstream_space_available() only selects between normal and
relaxed tail alignment of the bridge window, the different alignment
only makes relaxed tail alignment to be used more often than what was
intended which should be harmless because relaxed tail alignment itself
should work in all cases.

For consistency, change pbus_upstream_space_available() call to use
min_align which is the alignment that is going to be used for the bridge
window in the case where size0 sized allocation is attempted.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index d92832e1f4a1..09c275f8d088 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1145,7 +1145,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 
 	if (bus->self && size0 &&
 	    !pbus_upstream_space_available(bus, mask | IORESOURCE_PREFETCH, type,
-					   size0, add_align)) {
+					   size0, min_align)) {
 		min_align = 1ULL << (max_order + __ffs(SZ_1M));
 		min_align = max(min_align, win_align);
 		size0 = calculate_memsize(size, min_size, 0, 0, resource_size(b_res), win_align);
-- 
2.39.5


