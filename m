Return-Path: <linux-pci+bounces-8651-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61703904E9E
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 10:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9DE528740F
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 08:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2123F16D4DC;
	Wed, 12 Jun 2024 08:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RdcOWGeU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6190E18E02;
	Wed, 12 Jun 2024 08:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718182624; cv=none; b=Wt7/+znhcHpfOWZQ6hqXqkdt4+XqIjboYxeT5yIDKt3wZNGXGyqceFv4RGxjK2mT1FCh0NEbaLwn3E8lipyMTRTCHY+7426i21ANx+My8Csi86JlHOX3wLiAh8z1ys703Qy3hK8ooHrbkS5O82BJ9pmraLm3mPuT5hNNLAlKPEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718182624; c=relaxed/simple;
	bh=NcxfY/yC3SHBjeWD6d5Ymlrrf8Uc8BwT2dNHZA+FzWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ofriaUnmbD/+seP78na8Xnz+quFhn2cuBjouBHMqy/5pJ/Ap20kHpCNvq9h1LFAXPprLx2DyZYPFDsYHaeO9JEiGh59xpOqbSpZ2KOXsjzv7ZpjXu1rPDT0mQV8xY+xicjaZsjpa1/XyQoMNduFIRHLTX0i1nD5+fmwTY0yMqxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RdcOWGeU; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718182623; x=1749718623;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NcxfY/yC3SHBjeWD6d5Ymlrrf8Uc8BwT2dNHZA+FzWQ=;
  b=RdcOWGeUQK+UrnylTKLdN5hDNWO1zXn7EeYZqQU2sc/ozDoGSSbXqTFW
   e1r/sQvW2q2unTpEVKB7J1e2hTQWCpVN1HBWgRNoCJSJw1V7dbIagAVYT
   RyTrfY7i+1npHF4o+Ua26+IKodCVxiM/5+NRpPFbU1FPeO2xnIW/8oFoH
   stIjLfYwwv3Jw9jiaiJneMD0IQlB/mqreAliUvoiwP2buSCbmEp6D3nBb
   J+ju5dyNsf/6oFTOp3k38PX8Uu7RGe1qDlKiyvWxqudwVsqjiogEvmEQH
   F/rhlA5OfOc41fTZQbNU7alq1R8YuCu6Uo01gBUpuY7jzyp+BfKv1cjdn
   Q==;
X-CSE-ConnectionGUID: t7ils0w6RE+/1GmFQXFrmA==
X-CSE-MsgGUID: T+wMsRkbQd6kMoQksj2edg==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="14657744"
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="14657744"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 01:57:02 -0700
X-CSE-ConnectionGUID: iU7O8OBxR5qed2jgKr2Ogg==
X-CSE-MsgGUID: i+morLriT6in+KIEeRAFfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="70925445"
Received: from unknown (HELO localhost) ([10.245.247.204])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 01:56:57 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	linux-kernel@vger.kernel.org
Cc: Jonathan Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-tegra@vger.kernel.org,
	Robert Richter <rric@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/3] resource: Add resource set range and size helpers
Date: Wed, 12 Jun 2024 11:56:27 +0300
Message-Id: <20240612085629.5015-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240612085629.5015-1-ilpo.jarvinen@linux.intel.com>
References: <20240612085629.5015-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Setting the end address for a resource with a given size lacks a helper
and is therefore open coded unlike the getter side which has a helper
for resource size calculation. Also, almost all callsites that
calculate end address for a resource also set the start address right
before it like this:

	res->start = start_addr;
	res->end = res->start + size - 1;

Thus, add resource_set_range(res, start_addr, size) that sets the start
address and calculates the end address to simplify this often repeated
fragment. In addition, introduce resource_set_size() for the cases
where setting the start address of the resource is not necessary but
note resource_set_range() is preferred.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 include/linux/ioport.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index db7fe25f3370..2a1d33ad151c 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -216,6 +216,38 @@ struct resource *lookup_resource(struct resource *root, resource_size_t start);
 int adjust_resource(struct resource *res, resource_size_t start,
 		    resource_size_t size);
 resource_size_t resource_alignment(struct resource *res);
+
+/**
+ * resource_set_size - Calculates resource end address from size and start address
+ * @res: The resource descriptor
+ * @size: The size of the resource
+ *
+ * Calculates the end address for @res based on @size.
+ *
+ * Note: The start address of @res must be set when calling this function.
+ * Use resource_set_range() if setting both the start address and @size.
+ */
+static inline void resource_set_size(struct resource *res, resource_size_t size)
+{
+	res->end = res->start + size - 1;
+}
+
+/**
+ * resource_set_range - Sets resource start and end addresses
+ * @res: The resource descriptor
+ * @start: The start address for the resource
+ * @size: The size of the resource
+ *
+ * Sets @res start address and calculates the end address based on @size.
+ */
+static inline void resource_set_range(struct resource *res,
+				      resource_size_t start,
+				      resource_size_t size)
+{
+	res->start = start;
+	resource_set_size(res, size);
+}
+
 static inline resource_size_t resource_size(const struct resource *res)
 {
 	return res->end - res->start + 1;
-- 
2.39.2


