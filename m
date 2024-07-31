Return-Path: <linux-pci+bounces-11058-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DA5943241
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 16:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B9652854A9
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 14:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBE71BD003;
	Wed, 31 Jul 2024 14:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G9lvn1ho"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2CB1BC063;
	Wed, 31 Jul 2024 14:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722436896; cv=none; b=lKjph4Fprp80NT8RaBaJ5oc1O6WLR62Az7x+2Fpm/lzxA+x8UHSJ+Qc9eVNYjnScDNvuf4iM7FvIt4f2C8dUlwEe9vTiif08GSih5pFRtmpfsM16brBIk/mVlNBSWWimGYGQrRJP7juRJ9DU09D8E9LmYAMdCd71g5gislOZGLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722436896; c=relaxed/simple;
	bh=naYYV/Q1zE3kfPZc2E9jmoEqynsjj+bux0XqRg8Bocw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hbdIEPtvh4ATrQPHxuiRUoX7a4bsOoqsGhTM1CcOsLLPMtL5+dDq2PiWgyUHM9DsJHRk3DjGiycA8vXDddqXnPONhjJ4/eXK/emPDdAMAXgSi4Tm3H+Zv9EBn76v1H8um76W1DR3RG8xqYFw723kwLQrglo7QxFutaZyE8Wu6RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G9lvn1ho; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722436895; x=1753972895;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=naYYV/Q1zE3kfPZc2E9jmoEqynsjj+bux0XqRg8Bocw=;
  b=G9lvn1ho1DxzsAsqeoaPCqvWVmuzY1t2lw3ryq98gEiKbk8+pEkyT7FI
   dr+xGgSCnKrdP4V7h8GullAibGA8ounouGEZVDrdDCwzXHoa/wCiaRlFy
   86zBRcsIdcRZdM744dyOosawxPJ9CBJKXWqgJE6+tQud/mbEyI9CnMWCY
   ui3ArQ8EzEVW+3229Z2UWmExoFIRGE4vzdW3V4VvRKrjLauZAqNsVIcSK
   xCn7rCgFFG6xBdqaMcOkJU3vsrQnFcMHGtmaGIn25fTepdDdcgYxQjGz+
   8J5fTb3eSF2gC/ZFCoqu4wSvHkvaeMAFhzpkoCiCcUo6GXZi5TmKMN7TD
   A==;
X-CSE-ConnectionGUID: h+sKDIlnRRi4UuCSUpo58w==
X-CSE-MsgGUID: xmRWDVYsSMacYmjVvim71Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="20479825"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="20479825"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 07:41:26 -0700
X-CSE-ConnectionGUID: BIl0QuBCSBKaGCFs9BqXsA==
X-CSE-MsgGUID: 5+/4jcZcS2Sl60e8AXttnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="55295546"
Received: from test2-linux-lab.an.intel.com ([10.122.105.166])
  by orviesa007.jf.intel.com with ESMTP; 31 Jul 2024 07:41:25 -0700
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
Subject: [PATCH 4/7] arm64: dts: agilex: add soc0 label
Date: Wed, 31 Jul 2024 09:39:43 -0500
Message-Id: <20240731143946.3478057-5-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731143946.3478057-1-matthew.gerlach@linux.intel.com>
References: <20240731143946.3478057-1-matthew.gerlach@linux.intel.com>
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


