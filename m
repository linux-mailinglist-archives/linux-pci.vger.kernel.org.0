Return-Path: <linux-pci+bounces-36505-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFB7B89E45
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 16:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 301F958486D
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 14:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538CB313D75;
	Fri, 19 Sep 2025 14:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mxqEKICy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE636314D0F
	for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 14:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291774; cv=none; b=QGx6CrejEgt7oW0gvquoDIBh19bC6fYCgWcEBSTCgVENIAwhIsbOxQwPEDtOdp7edgsnMg/94yk4zbjEgaFnrjlsCOhaMhmo8/ALbSnRQ53qlLFkVpMdy9qNIZh8OAOfOW9yn62c9owew5w9JVtSyQMgw9UlrK+iZ8AQ58lIjrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291774; c=relaxed/simple;
	bh=rrWCXs5psVIzpV2+9ATJlTULVdKRrUwv+Ygb2Vor4uA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aW+VrBW/b8p5WY2nJ5nlygcuK2j2vs4GK/1wb7lG2t3bO/atjhZSiFEVkf/vL7c2xyNWYE1Ok6HdUdXim7bzFBFUFWnnXKc1hAIZM9rQE4Rxx6oCfXpr7aInvCfeoLB79jr/anK51H3+WKikFEioUw/vEZ6VBRSqFuAB3Aa4srM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mxqEKICy; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758291772; x=1789827772;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rrWCXs5psVIzpV2+9ATJlTULVdKRrUwv+Ygb2Vor4uA=;
  b=mxqEKICymb5+fitoeBIYT1+X49TrSoQcNpCbDjH/g1ohjQaFpSecWni8
   ZYOVIpaVagKOmfxWDN23f1H5PHOwunpEit+8TgnlvXrtcrJ1U9J4Rwg4L
   9T3YdKqN3hQUgSP7trZjNdEKniq3gGOiY7C0dCL9Xw2OWnv+9XCjebm90
   F6Xuh5b37ioW3CmjvXcUxBcNjyzOyMQwt0X2iWZXh5/xUPhlidoxydSrs
   QaBrWYBq05ubjMOpSTR9uUz76yHxxcCx3jA67QFQ+SuOAvBYjjFErNAhG
   Lm8BELHcpNjkBoE7pNLoTGjCHQEsqhMrWePqqA4fw5fG6T0AMdSX8iYPO
   w==;
X-CSE-ConnectionGUID: XaLpT0bFQLyEvpR5m/EXaw==
X-CSE-MsgGUID: r5avSJoCSLuElfwcBaNsaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="60750578"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="60750578"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 07:22:41 -0700
X-CSE-ConnectionGUID: wIKzyQWsT7WWKTXDQgN1Eg==
X-CSE-MsgGUID: 1OVAoZIAScG5uHc5bQbKSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="176655065"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa010.fm.intel.com with ESMTP; 19 Sep 2025 07:22:41 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: xin@zytor.com,
	chao.gao@intel.com,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: [RFC PATCH 24/27] PCI/IDE: Add helpers for RID/Addr Association Registers setup
Date: Fri, 19 Sep 2025 07:22:33 -0700
Message-ID: <20250919142237.418648-25-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919142237.418648-1-dan.j.williams@intel.com>
References: <20250919142237.418648-1-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xu Yilun <yilun.xu@linux.intel.com>

These Macros are mini helpers mainly for TSM drivers to setup root port
side IDE. TDX Connect will use the Macros in later patches.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
[djbw: todo: move and merge with Aneesh's address association in PCI/IDE core]
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/pci-ide.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
index a30f9460b04a..03e7561d4ad9 100644
--- a/include/linux/pci-ide.h
+++ b/include/linux/pci-ide.h
@@ -6,6 +6,20 @@
 #ifndef __PCI_IDE_H__
 #define __PCI_IDE_H__
 
+#define SEL_ADDR1_LOWER GENMASK(31, 20)
+#define SEL_ADDR_UPPER GENMASK_ULL(63, 32)
+#define PREP_PCI_IDE_SEL_ADDR1(base, limit)                    \
+	(FIELD_PREP(PCI_IDE_SEL_ADDR_1_VALID, 1) |             \
+	 FIELD_PREP(PCI_IDE_SEL_ADDR_1_BASE_LOW,          \
+		    FIELD_GET(SEL_ADDR1_LOWER, (base))) | \
+	 FIELD_PREP(PCI_IDE_SEL_ADDR_1_LIMIT_LOW,         \
+		    FIELD_GET(SEL_ADDR1_LOWER, (limit))))
+
+#define PREP_PCI_IDE_SEL_RID_2(base, domain)               \
+	(FIELD_PREP(PCI_IDE_SEL_RID_2_VALID, 1) |          \
+	 FIELD_PREP(PCI_IDE_SEL_RID_2_BASE, (base)) | \
+	 FIELD_PREP(PCI_IDE_SEL_RID_2_SEG, (domain)))
+
 enum pci_ide_partner_select {
 	PCI_IDE_EP,
 	PCI_IDE_RP,
-- 
2.51.0


