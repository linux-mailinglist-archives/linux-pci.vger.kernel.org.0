Return-Path: <linux-pci+bounces-20296-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA394A1A991
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 19:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D63873A8CF7
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 18:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB1D19146E;
	Thu, 23 Jan 2025 18:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NxNL1bqG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F2E15ECDF;
	Thu, 23 Jan 2025 18:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737656585; cv=none; b=KCo2kOGQbbHRqkOU3pSRyJW8dBVebmBXkTnd26w/1td9CHetB3zW1smcOFj0qNPW12H6Sb/jGAbbsG+NvT5a1+eaKaznxtGjLACk/ij2+AHxBIe67UZbQV6n8s1KzlAd/KmHqsjx2QoTxJm4pdY/YSYNy4kqM3Rw1oXR+joWUR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737656585; c=relaxed/simple;
	bh=lNb8JDsH41zRgxYMUIjSya9K5SMuyfqwPF7qvuGBD3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k/Vqj0K1qPgM6NiM2sdXZG+QRkdvlPWJSuFd92FLijUuh1Y9tWs0S2MvU5htV+r0L9PajZcl8U2sFSacYtQL8DuUvqyp92ZX7j1Ram3WJKIaR9KV6Uv9dN4m147zAKjFTLDLw+lBWp3LYy1DRi3EuhugiRObwrjfqWSmPoRKS38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NxNL1bqG; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737656584; x=1769192584;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lNb8JDsH41zRgxYMUIjSya9K5SMuyfqwPF7qvuGBD3Q=;
  b=NxNL1bqGV6J4epVmk5EPub1ha/3SoHvRWASI/KNIsQHsDMnpo+lTFYxu
   MqXODhd1jYkpIazIbTPbt6IHVn7nN3NNo0yWPQDnFksnwMJoURTS0wXsB
   TUrGDrPhaB3iiYGkzNhnCgekWLIhQpLx6SjyPDHCVMKaycFuFIauvEPPK
   Hoka0czVVWMZg70XXwFDz02Zgdei+WYoE0IbNZkPUAJzpHbP4NEHkkLVf
   PbqX/e/ArnTT+YpllQrd/UohxNNkLuNarYbjmBsEmw4yjfPSX0r7sBGTi
   +KuuG01vFdGMwfuwOH498NRcx7x+XXPjeBhr/JnUaaibxpxGECYqUJB13
   g==;
X-CSE-ConnectionGUID: iG+d6U2+QvO+XvlMe9nJPg==
X-CSE-MsgGUID: NHGTM6a8RiWdaPWiyT3Jlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="49573247"
X-IronPort-AV: E=Sophos;i="6.13,229,1732608000"; 
   d="scan'208";a="49573247"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 10:23:03 -0800
X-CSE-ConnectionGUID: BVURNVXPQo2OtjxxlGCbnA==
X-CSE-MsgGUID: ptl2HirKT6S+V1NPr+/jfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111574816"
Received: from test2-linux-lab.an.altera.com ([10.244.156.200])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 10:23:02 -0800
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
	peter.colberg@altera.com,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v4 2/5] arm64: dts: agilex: add soc0 label
Date: Thu, 23 Jan 2025 12:19:29 -0600
Message-Id: <20250123181932.935870-3-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250123181932.935870-1-matthew.gerlach@linux.intel.com>
References: <20250123181932.935870-1-matthew.gerlach@linux.intel.com>
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
index 1235ba5a9865..144fe74e929e 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
@@ -152,7 +152,7 @@ usbphy0: usbphy {
 		compatible = "usb-nop-xceiv";
 	};
 
-	soc@0 {
+	soc0: soc@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "simple-bus";
-- 
2.34.1


