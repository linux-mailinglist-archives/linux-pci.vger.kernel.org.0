Return-Path: <linux-pci+bounces-21159-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 918BFA30F81
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 16:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C47F91655E8
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 15:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09962253330;
	Tue, 11 Feb 2025 15:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X81rUFE7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214CA253B42;
	Tue, 11 Feb 2025 15:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739287283; cv=none; b=hShEA71TqwxibpPGnYxoT6J5+A9lehWOhYdLZ4G2hq8cjihpYh1d+BmcASBX9S1nWWbyZvwY1Q2469Jz8332Dq0ddBnSkLqklXCVFTIQ0djdLcncs3Ele5KR9iLBmJLRliswduzyJ0GY5OvsJdUL9W7D4Ki4C/R2EcYlAjoyu3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739287283; c=relaxed/simple;
	bh=TzAW+nYsKMP2HK51u3cfkEC/ErXD//jID9IQMb+P0mE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CzeycKCmq3vE9XIxgkUyXIW2x6WaCWLj3GuJNN8Xw9nSoRdxJ4ewnQIw7CWFDU7bYPIasJLKzJMX0LpkbwQ2uzTXDRIp+dBgsucJ467E1ULmVa3pUpBm5Td+B7S/d+AHoMMWUm12rp7bHEBjNGSxzlNXTof5M5wmj6qON1zCzz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X81rUFE7; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739287282; x=1770823282;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TzAW+nYsKMP2HK51u3cfkEC/ErXD//jID9IQMb+P0mE=;
  b=X81rUFE7bZzwxNB6gAJ0zR2LFNPGh11ny7YzBAuUvLGgR6Lgqb3AXrvz
   1CEu4ayPLzPzkXjXt0YiJzS6iXTvhU531d9n32tUcg6IafetiryEUg8fl
   UxiePoeBVHQoXMmQO3uK8QWIccYrhaxUS+aQ8/RqIZo3k2keftbVmnWoF
   o9O4/V1EnTT0sP56aYz3nvLe3gpgRkbmI4Rcq7QJNUqwQjATwJAtzJFdC
   y77Q8DzoMeRDxt70ZXDUj3R5yjgxnly+ndQcsH9mF1HsROu+HDbh6Jf+F
   rNx71/WnC8diOkXGEyBj6diDRaNq/npKgmq7k/gef0ZLKeCI0IrbSQZLa
   A==;
X-CSE-ConnectionGUID: T3+LeHdPSW6TvWQ7OTSH9Q==
X-CSE-MsgGUID: PjulTswnToKQ4hwtIU4zmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="50548281"
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; 
   d="scan'208";a="50548281"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 07:21:20 -0800
X-CSE-ConnectionGUID: EfABvA8IRgeni+pkQiB2Pw==
X-CSE-MsgGUID: eXt2iLcIRa2iZJHZ+biTWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112392594"
Received: from test2-linux-lab.an.altera.com ([10.244.157.115])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 07:21:19 -0800
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
Subject: [PATCH v6 1/7] dt-bindings: PCI: altera: Add binding for Agilex
Date: Tue, 11 Feb 2025 09:17:19 -0600
Message-Id: <20250211151725.4133582-2-matthew.gerlach@linux.intel.com>
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

Add the compatible bindings for the three variants of Agilex
PCIe Hard IP.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
v6:
 - Enhance compatible description.

v3:
 - Remove accepted patches from patch set.
---
 .../devicetree/bindings/pci/altr,pcie-root-port.yaml   | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml b/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
index 52533fccc134..1f93120d8eef 100644
--- a/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
+++ b/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
@@ -12,9 +12,19 @@ maintainers:
 
 properties:
   compatible:
+    description: Each family of socfpga has its own implementation
+      of the pci controller. altr,pcie-root-port-1.0 is used for the Cyclone5
+      family of chips. The Stratix10 family of chips is supported
+      by altr,pcie-root-port-2.0. The Agilex family of chips has
+      three, non-register compatible, variants of PCIe Hard IP referred to as
+      the f-tile, p-tile, and r-tile, depending on the specific chip instance.
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


