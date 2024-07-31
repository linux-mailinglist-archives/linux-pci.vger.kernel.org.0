Return-Path: <linux-pci+bounces-11057-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 059C594323F
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 16:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3FDD2852F5
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 14:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D6C1BC08B;
	Wed, 31 Jul 2024 14:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B5iVYBMY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF431BBBEE;
	Wed, 31 Jul 2024 14:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722436895; cv=none; b=D6XVkTkFzUeha8IGkfMxj+9zpSZbtQe1H06E66gSAPDJVkdAqgu2jwA5UKPQvQCsqEYFoqDPPwm96nRubaT+o2dnyRu0O1P8uOwi2u+Ht4Ucr5cwuzxnwpUY/MbKDjT0hfa/Q31sn+CgqFH31zjaTPLdM6Ek9LeXkKRe2yxjF3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722436895; c=relaxed/simple;
	bh=WeHXlvN46r2cNionlBgjBIg0FLgejR9y2O7YvFWnqGs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MsPlXd9YbXsnJEl7zolQAse8f4R13kpwu5qoQeYkOTDRjf7PgdvG+5mICI9uvVlHTOzxaoV9gx2ZhcOh2NIzOF2yCWtJsznvsAw36+nC3s2K9MUgwJOKFcP1No98p07LW6rAnkrS96VyrEVfmMiEZc2H+dPol5F37ZOc74WRb2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B5iVYBMY; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722436894; x=1753972894;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WeHXlvN46r2cNionlBgjBIg0FLgejR9y2O7YvFWnqGs=;
  b=B5iVYBMYKyjh2/XMPMPNhrcJjIgmraKui41KY4D4H/MrG6JQPO7ZU8ii
   JxbQkML/96fh6Yf+CQzno+CUVNeVGuDp2gkKwINfBTttxyoo99rp85VuL
   CAea87z8nj4esoUCwpw3+7z9F39aLwA2dNDjZO37n567v9Q4OKI5hogak
   BiDOyRiNMp+PmiliXGrprKfRV/YCgpVovnB+9xeJXaQZpDRthSVTJwuXH
   KB+Xx1OvIUw6RFYgvCGWEehG2yJ0zLil69C39LO3qckw7g+V1VTV5MSGx
   Qk4nOujY5F8ijJ1bbIPdLXSeM8Y4c38Izx9UcZY25T87RKvzhzQKwPdss
   g==;
X-CSE-ConnectionGUID: 67xgC+nvT8SUx4IlBH6Wcw==
X-CSE-MsgGUID: XSXz0ilGRia5z/kiDswNMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="20479819"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="20479819"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 07:41:25 -0700
X-CSE-ConnectionGUID: wwnOC70QRlWEbub1lu4p0g==
X-CSE-MsgGUID: nvj4WLE0TAOHHunQzqzE9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="55295543"
Received: from test2-linux-lab.an.intel.com ([10.122.105.166])
  by orviesa007.jf.intel.com with ESMTP; 31 Jul 2024 07:41:24 -0700
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
Subject: [PATCH 3/7] dt-bindings: PCI: altera: Add binding for Agilex
Date: Wed, 31 Jul 2024 09:39:42 -0500
Message-Id: <20240731143946.3478057-4-matthew.gerlach@linux.intel.com>
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

Add the compatible bindings for the three variants of Agilex
PCIe Hard IP.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
 .../devicetree/bindings/pci/altr,pcie-root-port.yaml     | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml b/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
index 52533fccc134..ca9691ec87d2 100644
--- a/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
+++ b/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
@@ -12,9 +12,18 @@ maintainers:
 
 properties:
   compatible:
+    description: altr,pcie-root-port-1.0 is used for the Cyclone5
+      family of chips. The Stratix10 family of chips is supported
+      by altr,pcie-root-port-2.0. The Agilex family of chips has
+      three variants of PCIe Hard IP referred to as the f-tile, p-tile,
+      and r-tile.
+
     enum:
       - altr,pcie-root-port-1.0
       - altr,pcie-root-port-2.0
+      - altr,pcie-root-port-3.0-f-tile
+      - altr,pcie-root-port-3.0-p-tile
+      - altr,pcie-root-port-3.0-r-tile
 
   reg:
     items:
-- 
2.34.1


