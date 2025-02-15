Return-Path: <linux-pci+bounces-21544-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A5DA36F35
	for <lists+linux-pci@lfdr.de>; Sat, 15 Feb 2025 16:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34D453B06FD
	for <lists+linux-pci@lfdr.de>; Sat, 15 Feb 2025 15:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02491E5B8E;
	Sat, 15 Feb 2025 15:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HZc7w4By"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAA01AAA1D;
	Sat, 15 Feb 2025 15:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739635072; cv=none; b=tdFXkTANL+EwZVOAJbA7xzr+WUzjAWYKN1w8m5hkrrk2ya6xZprBQa08JbUVnV/R/HhGak5f/qeVSMZO0SxTiF5wX1eGEHOKpcZQXDpIiCTqxxgouXqWkBbgHkoDSrx7MZ0Q3Q42Mu/jWa5zfJE5Tx9zJlU4370/UicESxYquVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739635072; c=relaxed/simple;
	bh=jUUVEhNQX8bvdWdLrVc6ASlqOLQPC7Z+QmPWQYjvArw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HpCghhaO2gBeyVWP+XdaKx/mpeSDzWtj4swV50p1Xj+eYqkaFagOguchpUumdu1mM/tii9T/7Oq+4fjTjY/KM68TqGGZMZ38sQ1hW0Tg+i1d9uWEsTReUf2+tZq+G+AuL1wv2YeNKIOLtxXwpvSDCzTAIEEY4vWUo7p0wZhjrsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HZc7w4By; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739635071; x=1771171071;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jUUVEhNQX8bvdWdLrVc6ASlqOLQPC7Z+QmPWQYjvArw=;
  b=HZc7w4By1tBsmBtcJ5E+ip88mPxZU6sVk7l6+R8uiQQlp41hcEcSfwLj
   fszY69QzYYe0knnke1Sjyu+Z+bWp+fUry8D9bsyDlznbiGy4YJnC1noIP
   /pFVEJqQc2x5G6m6vUL4RA0Fc6SQxZCnDQ7TfTy/x4XTS2zZjeKqZb/LZ
   b78dcfVP0tSFbDXWROewoNvAdXMgJquFVdnXS1mDpz5pDkMvr70jzbYCY
   y8DlBYsnimf7LXaO2BcK8QRkUyyYtlwoyjAUSxjiljfH8yQTX07Ox4Iq/
   tPKffT5xUTVWrKa/Cq74hUCuoUE9dm7E38XLmXufnCOyuWlyfxp5sEiTt
   A==;
X-CSE-ConnectionGUID: 3iqT21JBRCuvgS7hMmK9SA==
X-CSE-MsgGUID: Kw8v+BizSbOUTPQj/d7NJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="40509939"
X-IronPort-AV: E=Sophos;i="6.13,289,1732608000"; 
   d="scan'208";a="40509939"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 07:57:50 -0800
X-CSE-ConnectionGUID: ruJe5dyPQn6ZSWiAKKLrsQ==
X-CSE-MsgGUID: jdQ2Qc0mRqm0H8P7cpTigg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,289,1732608000"; 
   d="scan'208";a="113701909"
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
Subject: [PATCH v7 1/7] dt-bindings: PCI: altera: Add binding for Agilex
Date: Sat, 15 Feb 2025 09:53:53 -0600
Message-Id: <20250215155359.321513-2-matthew.gerlach@linux.intel.com>
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

Add the compatible bindings for the three variants of Agilex
PCIe Hard IP.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
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


