Return-Path: <linux-pci+bounces-14991-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 505A59A9E08
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 11:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D59521F27498
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 09:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D3119884A;
	Tue, 22 Oct 2024 09:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YHYRLtQ8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2AE1974EA;
	Tue, 22 Oct 2024 09:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588330; cv=none; b=YNMEB7iGv3AA4B3wc9ELZwZoMewn7z6aRgICoFe3YDXYMHu8kjdeGiRphe/ul6PrFa5pWwVib7NDKa+zQY+zHSrTu4YaEhiYCv2nKvyryiYJzMBe5y3h/KOfxqB0YZMz1xHY5es2JBxmHfGGuL8ETJt/t0OzJOIVrneOSZDK/7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588330; c=relaxed/simple;
	bh=Zh5fxfVyxE39hNkaci5uSsCnRj62lxU34l8OCLLtS8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V7Mgc7gmup0mgM5ZLcwN1z4xgMkDz+N23WXqOwoNS31/IYZHxyvfZ4r/h0GtY/t0A3T4hyEFvgegYOzN09Uc1cNfnMNI6yaCzM0xQck7Bx85gMP5z8bZzPMLcG02OfEumeBzz1Rnqn4e0S9csnwtx1gdt7aKGydhqzkc7QoapHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YHYRLtQ8; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729588330; x=1761124330;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zh5fxfVyxE39hNkaci5uSsCnRj62lxU34l8OCLLtS8M=;
  b=YHYRLtQ8sTSvBZjsx+6CrkFZ8KB10xWiOrR8IKokzFWp9cX+GFZUD2XW
   cWiYe8cm5oJy/iSar+43xUGDq7pRDp7vqvuczAP98ButXIhqCnLlpeZlv
   TQBHZlcOCeWJOryEt3vOainXfXek5tNHNZGebiLcSqoa6Wks6W2Nuhi4i
   IOZncPPjtiGshOGs1omqFpHe8FvxGD/eHTxbzlg16IlUO242yUexXQ4Ad
   Vr+Vn4+VuBGtRsIGtTYMclZbtV2WYX1aZtDjjr+xKtmEin+JQRETQ7ZgA
   abTvGqfk6VDMYpXbjqDgylEE/K3kg4Qg5Ik3iypRdgWD/y5aCTzDseS5d
   w==;
X-CSE-ConnectionGUID: 0W7G2BCzQsiFF0TfRjRLMw==
X-CSE-MsgGUID: 0M1k2oz6SgmFg6yoqg9+eQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28885707"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28885707"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 02:12:10 -0700
X-CSE-ConnectionGUID: HQiOBNHQT6mYhVqatMkodQ==
X-CSE-MsgGUID: q7wXa3B0ROKwRT4m8WJzTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="80157990"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 02:12:07 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 3/4] PCI: cpqphp: Use define to read class/revision dword
Date: Tue, 22 Oct 2024 12:11:39 +0300
Message-Id: <20241022091140.3504-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241022091140.3504-1-ilpo.jarvinen@linux.intel.com>
References: <20241022091140.3504-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace literal 0x08 with PCI_CLASS_REVISION.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/hotplug/cpqphp_pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/cpqphp_pci.c b/drivers/pci/hotplug/cpqphp_pci.c
index 7844007dbc86..558866c15e03 100644
--- a/drivers/pci/hotplug/cpqphp_pci.c
+++ b/drivers/pci/hotplug/cpqphp_pci.c
@@ -199,7 +199,7 @@ static int PCI_ScanBusForNonBridge(struct controller *ctrl, u8 bus_num, u8 *dev_
 		/* Scan for access first */
 		if (!pci_bus_read_dev_vendor_id(ctrl->pci_bus, tdevice, &work, 0))
 			continue;
-		ret = pci_bus_read_config_dword(ctrl->pci_bus, tdevice, 0x08, &work);
+		ret = pci_bus_read_config_dword(ctrl->pci_bus, tdevice, PCI_CLASS_REVISION, &work);
 		if (ret)
 			continue;
 		dbg("Looking for nonbridge bus_num %d dev_num %d\n", bus_num, tdevice);
@@ -214,7 +214,7 @@ static int PCI_ScanBusForNonBridge(struct controller *ctrl, u8 bus_num, u8 *dev_
 		/* Scan for access first */
 		if (!pci_bus_read_dev_vendor_id(ctrl->pci_bus, tdevice, &work, 0))
 			continue;
-		ret = pci_bus_read_config_dword(ctrl->pci_bus, tdevice, 0x08, &work);
+		ret = pci_bus_read_config_dword(ctrl->pci_bus, tdevice, PCI_CLASS_REVISION, &work);
 		if (ret)
 			continue;
 		dbg("Looking for bridge bus_num %d dev_num %d\n", bus_num, tdevice);
-- 
2.39.5


