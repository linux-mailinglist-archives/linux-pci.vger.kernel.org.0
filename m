Return-Path: <linux-pci+bounces-21545-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BACFA36F39
	for <lists+linux-pci@lfdr.de>; Sat, 15 Feb 2025 16:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0680716B1BE
	for <lists+linux-pci@lfdr.de>; Sat, 15 Feb 2025 15:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7A91EA7CB;
	Sat, 15 Feb 2025 15:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ie8MOZ8E"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32BC1DE2C7;
	Sat, 15 Feb 2025 15:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739635073; cv=none; b=ENJ2PhC49AC5oM6d7boux/juNvNDpcXMHt1RIrssRtB9b0zwX7XDPrt3MtChueD1Ixyi8TLHcy6jWruvt8C3iJT3IuCRqHWnmo4e0K+yp4ps3pSeRNa4cL6sOVsnN0isHMOOfTPBi8MPh6P1cC0nWOBIfmubbbhdYOzwXx+pS3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739635073; c=relaxed/simple;
	bh=brCSiXZsjkohcYDqcLh5ZHfSXSjjmNaioTOMXFzJLMo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BQ6RQhBDzy3Jm/EeceMttpW3Jo9TLgk+TxyCEh9/M88tgGRHdhOwG66vIGlizU6hEc393+GLzFvYbPbUAq7BXVpZWT7D7UBya4xn/vR3hVWVAvHBncz1pIA1Y5ixYv88CvB1CjtJLJ80bDsnskZXGGU21yRhNeOlN/5SPTHt9N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ie8MOZ8E; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739635072; x=1771171072;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=brCSiXZsjkohcYDqcLh5ZHfSXSjjmNaioTOMXFzJLMo=;
  b=Ie8MOZ8ECuDc9sSeCf4Qx0VRy+AYFBHmn/rNbrnk+YybkbRVNtj4kjkU
   JdXCHfNPDpql7OigpDp7cm5GoX1PT3UIMxihLF/lQIB6Fmu1UXtzqCWHm
   o8b3kNEXEjUhVdgoIpDVyE4BstHOov7LAd7DyoS5Aw9vB1xEPY9dbn79d
   zdZUUOoqMfpNfEehZppIG7MOCNv9HP+UTk/NzRSPtz/9qUEubmx450FHx
   8cE0SMCOp22vof9aTsnP1jsKC7qbLaCvn5vesb8kII0egKwXtfSoRR1x4
   zL6SDw+r3DASwswpnYYXRxPgvOsgJTPxFxgNvBupy/MTZUIwkTltTdALx
   A==;
X-CSE-ConnectionGUID: PS6PKz5XS+a0wrvstkLcxw==
X-CSE-MsgGUID: RUwXgk1VR4W+W4aKIDWxZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="40509945"
X-IronPort-AV: E=Sophos;i="6.13,289,1732608000"; 
   d="scan'208";a="40509945"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 07:57:51 -0800
X-CSE-ConnectionGUID: FrT4qabXREaPQ7MGR62s5Q==
X-CSE-MsgGUID: ZK9DViRrSuuuqZZ2miucYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,289,1732608000"; 
   d="scan'208";a="113701912"
Received: from test2-linux-lab.an.altera.com ([10.244.157.115])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 07:57:49 -0800
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
Subject: [PATCH v7 2/7] dt-bindings: intel: document Agilex PCIe Root Port
Date: Sat, 15 Feb 2025 09:53:54 -0600
Message-Id: <20250215155359.321513-3-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250215155359.321513-1-matthew.gerlach@linux.intel.com>
References: <20250215155359.321513-1-matthew.gerlach@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Agilex7f devkit can support PCIe End Points with the appropriate
daughter card.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
v7:
 - New patch to series.
---
 Documentation/devicetree/bindings/arm/intel,socfpga.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/intel,socfpga.yaml b/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
index 2ee0c740eb56..0da5810c9510 100644
--- a/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
+++ b/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
@@ -20,6 +20,7 @@ properties:
               - intel,n5x-socdk
               - intel,socfpga-agilex-n6000
               - intel,socfpga-agilex-socdk
+              - intel,socfpga-agilex7f-socdk-pcie-root-port
           - const: intel,socfpga-agilex
       - description: Agilex5 boards
         items:
-- 
2.34.1


