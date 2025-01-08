Return-Path: <linux-pci+bounces-19552-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6682A062E3
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 18:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2EA81680EC
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 17:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB7E20012C;
	Wed,  8 Jan 2025 17:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SAjr7G5n"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFC51FDE2C;
	Wed,  8 Jan 2025 17:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736355751; cv=none; b=V1g1CkSfa3oHqmykEBHljw1lZVGpCh7IsCoJSKbx3sVX7SEcc67vOzZ5xPTjiNHtzzeDF8qU4GZs+EGlzGk+1oju/JpyzsvOlmOkU0y2RqCt+ZwLZofXR3eI+6/CnzOE3pKc9LJoVcIURHsborew1/8ugNTyyELFd/LixtMgrn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736355751; c=relaxed/simple;
	bh=6nc8mK/8BSOxBDkGX2NS9aWph9cd3I/+ZTubwE+UB5U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=htDa1fkJZ6GIz2wwaMoRMIZsawzLK5mJkmzarl89l6CQ9ok+GJdRL+hJv7ZC6XJq4dErBTSLFtNxNa5Vp40bP7t39Hya5JYNs7gx50YRsR9LJ0JGG9lrX64yvz66PyXZCBhoGknUINN0tPz1kR6FjzSGj+po7IPnAYcPcA0oe+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SAjr7G5n; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736355750; x=1767891750;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6nc8mK/8BSOxBDkGX2NS9aWph9cd3I/+ZTubwE+UB5U=;
  b=SAjr7G5nHjBVyq0qXIk8+6PJEXP+3jU3ObC9FBAydxDwtWSMrKmtocUc
   cHtLDToZRLw0vXaYFvcwhYu1kqjiwmaK3xXQiRGRExp7nSwB2lZfTATwt
   bvKaqozFhYqqh23E5faBnRRfmYv6ki91fTsr9Jfi0iFFsP+zH+gOTr6Xy
   5eNVLtxr9zcS6kJrrGyskXk07hTIhTb42gZr01vOlEuaSO45LHPr3ukK7
   xp7mzpr3dkdko9nwys1yicZ3bxlsU7m6XqfGthP47c1wZlbqap9J42u/f
   2DRw7MsOHZAGvxRwZvnbJWw3v2Jq+z3teg80UjT0BVHV4EsXozEyXdiRb
   g==;
X-CSE-ConnectionGUID: HepoNjQ9SjC0TXBtFlrjHA==
X-CSE-MsgGUID: 79LBaVwbQ7OI1f3AtNjlNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="35882077"
X-IronPort-AV: E=Sophos;i="6.12,298,1728975600"; 
   d="scan'208";a="35882077"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 09:02:29 -0800
X-CSE-ConnectionGUID: t0N5vDdgStaneAz3GgvkIg==
X-CSE-MsgGUID: xdoNBc4RS+a+Bp7w+MQh7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108255838"
Received: from test2-linux-lab.an.altera.com ([10.244.156.200])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 09:02:28 -0800
From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
To: lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	joyce.ooi@intel.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: matthew.gerlach@altera.com,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v3 2/5] arm64: dts: agilex: add soc0 label
Date: Wed,  8 Jan 2025 10:59:06 -0600
Message-Id: <20250108165909.3344354-3-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250108165909.3344354-1-matthew.gerlach@linux.intel.com>
References: <20250108165909.3344354-1-matthew.gerlach@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a label to the soc@0 device tree node.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
v3:
 - Remove accepted patches from patch set.
---
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
index 2a5eeb21da47..98e14b9b4228 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
@@ -149,7 +149,7 @@ usbphy0: usbphy {
 		compatible = "usb-nop-xceiv";
 	};
 
-	soc@0 {
+	soc0: soc@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "simple-bus";
-- 
2.34.1


