Return-Path: <linux-pci+bounces-6573-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4CB8AE787
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 15:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17BF11C2352A
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 13:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B756A136659;
	Tue, 23 Apr 2024 13:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XwGZMm8y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE831332AC;
	Tue, 23 Apr 2024 13:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877731; cv=none; b=U01Qi/cbFnjWwoz/UzJzUsxBbBvAA+2stTjUJHazIYv9LF6bW9yD8rcdD7mQJ7d5WiLTig4LrbkXDbGsiLIOWaTxHpFl04xPcGI/PWzp3oiY/JcVwPrSFpYS9TBBgst0W5w4QC6mKVka7niUv5cE0p3h2iAD0ltDV5UhSuGEnDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877731; c=relaxed/simple;
	bh=tiSx6svfQLvugPCGXyVAGPzzoOTF3iLPPrc0SKFu0M8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XFKwFk1QzI8L/Qfz8qqPHPfN+jKohztx1RbPBaPU0oLaaZFHJkHHp+q/NjglqqAJDlF0qDfsRrtBlO8803CYoOmpbVaTD8tsvJromZKWZ9Z1ABB613vHSU8/bjEK5CfAX96BInHq87/pHVsYS9lo+0Fh4dmWlFJEJk28gBxQNCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XwGZMm8y; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713877730; x=1745413730;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tiSx6svfQLvugPCGXyVAGPzzoOTF3iLPPrc0SKFu0M8=;
  b=XwGZMm8y0fBEdVH2rK6TyeanO7D8Gc2+ZJYir4BWzjO8z3Jhw5hxQo9P
   WgLd+b8sfot5lA0K6RHLFpy5vclyX5Qfqt4nQzXZ0mLhbVNjxeo2cmyDV
   ziWyaOfQpVuvzPHX9E6s4wQUkAgjv/BU8AViw55J1X6J7KdYIIrK7E4Zt
   CwsAEJcISY27hFF9Jj7uqAgmWbtE8SmrTyNNZab6JPv/otFBMvnqhTjGj
   F0INaS31WlA8CgM5jldB6Q6Nq6yqw7Mm0JvjywElU/a9H4Dtijo09hqjw
   dw/8Ft0ulUHoV/LudU56cTnpGjjzhWKbnNaIf+9Q4LD+G3MqTms6Pbyjl
   w==;
X-CSE-ConnectionGUID: Sqzw/vWwTjaPHIRmDBDY8g==
X-CSE-MsgGUID: kIC0K6JgSbOib901EAFoUg==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="20008203"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="20008203"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 06:08:44 -0700
X-CSE-ConnectionGUID: OYpV9A9RRUa4vVQImhUSjQ==
X-CSE-MsgGUID: dKv9YnJiSqC5zgo/pnELCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24399533"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.40])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 06:08:37 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 2/2] PCI: Small clarification to the intent of LT wait
Date: Tue, 23 Apr 2024 16:08:20 +0300
Message-Id: <20240423130820.43824-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240423130820.43824-1-ilpo.jarvinen@linux.intel.com>
References: <20240423130820.43824-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Make a small clarification into the comment relating to the LT wait and
the purpose of the check that implements the implementation note in
PCIe r6.1 sec 7.5.3.7.

Suggested-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

v2:
- New patch
---
 drivers/pci/pci.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 70b8c87055cb..5a25facb3ce7 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4625,9 +4625,10 @@ int pcie_retrain_link(struct pci_dev *pdev, bool use_lt)
 
 	/*
 	 * Ensure the updated LNKCTL parameters are used during link
-	 * training by checking that there is no ongoing link training to
-	 * avoid LTSSM race as recommended in Implementation Note at the
-	 * end of PCIe r6.0.1 sec 7.5.3.7.
+	 * training by checking that there is no ongoing link training that
+	 * may have started before link parameters were changed, so as to
+	 * avoid LTSSM race as recommended in Implementation Note at the end
+	 * of PCIe r6.1 sec 7.5.3.7.
 	 */
 	rc = pcie_wait_for_link_status(pdev, true, false);
 	if (rc)
-- 
2.39.2


