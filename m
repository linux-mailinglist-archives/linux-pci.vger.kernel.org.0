Return-Path: <linux-pci+bounces-11547-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FED94D323
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 17:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E2D6B21ABA
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 15:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6241991C8;
	Fri,  9 Aug 2024 15:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SRGNWh/y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5991990BC;
	Fri,  9 Aug 2024 15:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723216443; cv=none; b=s5Z4UP8wN3tx5oT2UQTrX22gWHyYRdE1NWJ3aGhzl/SS3ZjVSlu0bxY5S6Rrpg4iD8VjGNZyQ0DvwLHu82/tF4YVS1x6fwWhzLKAsVn2AkrX4L9dui2qf0nbySoNdnptANI8VPvE6+jLdngGsjw480gPDFhSkoHNgGrxJKPAn1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723216443; c=relaxed/simple;
	bh=naYYV/Q1zE3kfPZc2E9jmoEqynsjj+bux0XqRg8Bocw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e53jQO0eWwTKMiDaS9xLJIZae3HJEjYMHwT1k9FeXllZPQjBYqedNAMLdvvKZIuXZ7GyOfnYTMz4VhgX+uXQYRjdaqCY76ZmkuHIXNcuWos/4fElWQiyJf3lnRLZ6UbkOYprpKTqtKWtRVhJvb+d5QB1p2Ekz1vYBH/mw50Ym8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SRGNWh/y; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723216443; x=1754752443;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=naYYV/Q1zE3kfPZc2E9jmoEqynsjj+bux0XqRg8Bocw=;
  b=SRGNWh/yY23oG7bJSPa8zl57ubHn83p3Qhwjfl2N33wiZiVl6sKTf3xP
   iDYdPh0sBVN2xQQvqwRmOgmbp2Ef2MaxQpigAtyfA+2eBgjMD47NyaBXV
   LnJ79ofdLMmuaztbfcis/njEDOb0zmXF4+b4IIwA9/rP9eskvbxM6fB2C
   kRvrv1QgllBaLTLdjQzkX4meS45MYGj6VxtYlvfx6QtiwpGNkCR8psoQv
   NUVTWFSCiWyR9mMl2EPl8gS212+zlqWRazyA/YZw4cYSMsW9ttlsx4tsP
   +VnA18mh1zRDs4GQ5bPfYl3aTQ3byvAl86oetBflgWWqX25uLCsBPJeX9
   g==;
X-CSE-ConnectionGUID: ihP5hiclT1u3Vsn14HKBAQ==
X-CSE-MsgGUID: g/OnLvr+TH2O8nlANY3EEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="21368879"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="21368879"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 08:14:03 -0700
X-CSE-ConnectionGUID: MWkuUK8vQ2eKEZRakx00oA==
X-CSE-MsgGUID: cRFtqR12SzOUHIwF6qXaKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="57485963"
Received: from test2-linux-lab.an.intel.com ([10.122.105.166])
  by orviesa010.jf.intel.com with ESMTP; 09 Aug 2024 08:14:01 -0700
From: matthew.gerlach@linux.intel.com
To: lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	joyce.ooi@intel.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v2 4/7] arm64: dts: agilex: add soc0 label
Date: Fri,  9 Aug 2024 10:12:10 -0500
Message-Id: <20240809151213.94533-5-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809151213.94533-1-matthew.gerlach@linux.intel.com>
References: <20240809151213.94533-1-matthew.gerlach@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

Add a label to the soc@0 device tree node.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
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


