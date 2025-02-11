Return-Path: <linux-pci+bounces-21160-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90365A30F87
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 16:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96CBF3A3958
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 15:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A536253B5F;
	Tue, 11 Feb 2025 15:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TvnLGD+2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF20253B49;
	Tue, 11 Feb 2025 15:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739287284; cv=none; b=dpPMeDYsCyWXtmaKPGU77YiTHLgjETElzw6c6mwmRTNaqzJN2t4TcBao7azwcEzz+jh0RL1lcwH05RyWuTwzSiBtf0e8MZbNKnvJ+1nkXWquV62FgdXuep5FpVDfapeju6nojGr3GuLFyApggMYRkThCHGT/MeDpch8kgmRT+98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739287284; c=relaxed/simple;
	bh=OnVFRWVku+EZPnORw141A2bHknfm7AgB6L31jvKe4Nw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o8cEf339z85B7y0g9Yt2ts4wAwIlYr10xv2y+Ql33kRWLuWPpWj7fKh8VJY/LhEOkOzd1KVvfOOhRPv+fGsEcSsDQ9r8FuGWGpHfZ+DcdY420oBJkE9pusFUrpLQaoUfXodpKuovIRCZjLp0GzEmT3zayVTa6iY12O/l5k/tK9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TvnLGD+2; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739287282; x=1770823282;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OnVFRWVku+EZPnORw141A2bHknfm7AgB6L31jvKe4Nw=;
  b=TvnLGD+21ZzaqbRAypNwre59aCZShobF7PNF+otyyz9zHHG9zWaZLIlR
   2v7Mky6ZkgzBhfcC47vTYi5fzjlJaD2LtbmFOpY2ju+A/15H/MYukd9l/
   oR4gPWs+UCpiVSBPaEb7fs/G9lbfgIPu+bHuMSFQqQr0TdDHaa/urXwPa
   2+EETMEhbsmv4vBLZ+VCuGQvr4Mlf726OHWVsTP8ETZE3VpEaO/joXTOI
   5Wq14knoh97GdQFcL+zUx2sTn6v+A03LdQGwHtxFWBu410dcBNbcGt1wC
   6Aorzwr+ntYI68PH7i8lWZ3TepTGChG5pAIDEqNTvv0iZ4qvVsSRlf/Qr
   g==;
X-CSE-ConnectionGUID: Au55tAHGTHmuTlKHloDI4g==
X-CSE-MsgGUID: T4W0BeGoSsuwZW1OvHGkrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="50548289"
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; 
   d="scan'208";a="50548289"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 07:21:22 -0800
X-CSE-ConnectionGUID: 7MqMQxMaRK+NrQGdHaH6Rw==
X-CSE-MsgGUID: 0s/rYiKCRGOtyxmsVTTi1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112392597"
Received: from test2-linux-lab.an.altera.com ([10.244.157.115])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 07:21:21 -0800
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
Subject: [PATCH v6 2/7] arm64: dts: agilex: Fix fixed-clock schema warnings
Date: Tue, 11 Feb 2025 09:17:20 -0600
Message-Id: <20250211151725.4133582-3-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211151725.4133582-1-matthew.gerlach@linux.intel.com>
References: <20250211151725.4133582-1-matthew.gerlach@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add required clock-frequency property to fixed-clock nodes
to fix schema check warnings.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
v6:
 - New patch to series.
---
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
index 1235ba5a9865..42cb24cfa6da 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
@@ -114,21 +114,25 @@ clocks {
 		cb_intosc_hs_div2_clk: cb-intosc-hs-div2-clk {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
+			clock-frequency = <0>;
 		};
 
 		cb_intosc_ls_clk: cb-intosc-ls-clk {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
+			clock-frequency = <0>;
 		};
 
 		f2s_free_clk: f2s-free-clk {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
+			clock-frequency = <0>;
 		};
 
 		osc1: osc1 {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
+			clock-frequency = <0>;
 		};
 
 		qspi_clk: qspi-clk {
-- 
2.34.1


