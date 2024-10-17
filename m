Return-Path: <linux-pci+bounces-14795-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB499A250F
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 16:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 619831F248E4
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 14:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D891DED5C;
	Thu, 17 Oct 2024 14:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lUS38dvK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5311DED56;
	Thu, 17 Oct 2024 14:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729175527; cv=none; b=M1OKdbO+qECo/DuX7IbKg9xeOdrxUI3I72LgGcY7XuvspzCeU+4om57+vKEih6/84QoHOhEQ/DUOefAF5gatmSaS3E+GQdNSh4d+4zv5WbHd2sXO19XDIMBcxFjHDBCfGOGTh9zf3V8aqSZcgEQNaqwGvSsxrTXdkqZzoC1dJmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729175527; c=relaxed/simple;
	bh=Zh5fxfVyxE39hNkaci5uSsCnRj62lxU34l8OCLLtS8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E2wYS6F9p3nuHnXJ67H6qdVgivKStN2ToQ2fGjwKT4SZGCMnEfV7HDw6iu7GtAW4PmCmBhwWzNluNx4/cixNlPWMoapxS/LTX/rXU+MHn6eXtTEWpOM8lLcGYMN77GxhkZw6cA9zFujMX1hxCINWHlVq+bEX5rhtLl78D0tUIAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lUS38dvK; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729175522; x=1760711522;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zh5fxfVyxE39hNkaci5uSsCnRj62lxU34l8OCLLtS8M=;
  b=lUS38dvKgi1zStDXRdmPxqueOCJqbXGf9CHnFvDGaa2OpdLld+VC+dBV
   CDiESlO+tN+KEa9boQoxw6Vehz5yqRxPH+RajCUkbzR5DzT04gJrx21pS
   451tIRfFxqEQhp+bNZD3EE/gMDWOJ6WT9rzywTXM9KkQD+Ew+uiapQ7Bg
   pm+I/uOcLngz27WZifgTNtQsKmiI7/Q7VLBnOfW6NDiM1UdOTjNtsjDTZ
   nF/AYs8bKY0oKkkhnlEFn5xKIbyFNWnjmiiiX0jzL8+x+sUa3GCO7g3Mz
   96SxkpHudJhBbrp392x7FILKrW2YNvyElbcaQTS7J+wsPZoU16yIsQRjf
   w==;
X-CSE-ConnectionGUID: iWLTogtaR1+/mG0J6xEjSw==
X-CSE-MsgGUID: zm9xmKg0RXuQ2tw1PXsDOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="32592329"
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="32592329"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 07:32:02 -0700
X-CSE-ConnectionGUID: vcRea9/YTIenFuap/I1qJQ==
X-CSE-MsgGUID: PCksBMQrQpimStzLVp13rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="116002556"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.91])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 07:32:00 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 3/4] PCI: cpqphp: Use define to read class/revision dword
Date: Thu, 17 Oct 2024 17:31:30 +0300
Message-Id: <20241017143131.46163-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241017143131.46163-1-ilpo.jarvinen@linux.intel.com>
References: <20241017143131.46163-1-ilpo.jarvinen@linux.intel.com>
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


