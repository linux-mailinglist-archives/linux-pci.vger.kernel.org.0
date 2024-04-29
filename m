Return-Path: <linux-pci+bounces-6772-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EEE8B55B6
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 12:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 867D4284D83
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 10:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BDE39AC7;
	Mon, 29 Apr 2024 10:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J3sGDOe6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6303F8DE;
	Mon, 29 Apr 2024 10:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714387651; cv=none; b=TipEkuDuB2cSSG2rI9D2YU93Tz8gNVOCjVkgZ/TjCjT1y3ntMuM+YsKjOb9kuvNZBtGymahWWmCpE7R6ADYriwgMc+VdWPV0s5Pg0CVJT30NeSAbvQnL73X2ll5+lI/eBfjTPMbDJ90CDuPANvBKyecBIDLLu7Uejwd8qH3GkGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714387651; c=relaxed/simple;
	bh=Hv9GyAS0KBbDT8QkEmIsUuVpOXGR/BLCaX7u38Yg14I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eLlWdzL15kDp59IwOAX0vX5ZdawuC+ZviRgz/8Ff3xeY+20wCnjchtAZOD/7C857xGFRlJrJG+ZictEgaT1i4Pp1WFtfMI6MZNRL4WRFGIuCJEivzKWr4vGVx8Z9OjZrdtHnmMoZoNNRP0LYmwcx3J9UACZ3AhrzrpK0QN73HZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J3sGDOe6; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714387650; x=1745923650;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hv9GyAS0KBbDT8QkEmIsUuVpOXGR/BLCaX7u38Yg14I=;
  b=J3sGDOe6PGufggvz79bBM4DiXD+KlgGmMLfNEJY7mU7H+XGlE2/kfaRs
   N5nHrk4WU9ZO4ZUDwNSpkWRsw4nbFdGz2BoUad1JEK+bfgGuGZA1PBodU
   1hUYpNZxX1QtW5YKhlECKNfo4oLMsjIsV7u0zSUYqhml+I/bfitz6Tirp
   TQBNYb+4PtzkLjLUKiwzeWzKJ16jPCVQg0A3AgCRq7SKfEK0lKiVno2m8
   TX8PsmVJCXlj584aaHS3dKBZzk5q+FCK9wAWkpy3CPFJoEqlZmQOUS6MS
   EdEUxeLn59NVyrdXbnr3Vok12x/zGSzVjQ5RWxsr86CUkxLN96Xpu9aFN
   g==;
X-CSE-ConnectionGUID: quk2ILq0SyasmrmSVZCgBw==
X-CSE-MsgGUID: tS55weukSeGY+J50V5JpsA==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="9966431"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="9966431"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 03:47:30 -0700
X-CSE-ConnectionGUID: TpdIB9STR46fUwIXJHCNnQ==
X-CSE-MsgGUID: iuWN04UaTO+9rByUaag7oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26037489"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.45])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 03:47:26 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 05/10] PCI: ixp4xx: Use generic PCI Conf Type 0 helper
Date: Mon, 29 Apr 2024 13:46:28 +0300
Message-Id: <20240429104633.11060-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240429104633.11060-1-ilpo.jarvinen@linux.intel.com>
References: <20240429104633.11060-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Convert Type 0 address calculation to use pci_conf0_offset() instead of
abusing PCI_CONF1_ADDRESS().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/controller/pci-ixp4xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-ixp4xx.c b/drivers/pci/controller/pci-ixp4xx.c
index acb85e0d5675..44639838df9c 100644
--- a/drivers/pci/controller/pci-ixp4xx.c
+++ b/drivers/pci/controller/pci-ixp4xx.c
@@ -188,8 +188,8 @@ static u32 ixp4xx_config_addr(u8 bus_num, u16 devfn, int where)
 	/* Root bus is always 0 in this hardware */
 	if (bus_num == 0) {
 		/* type 0 */
-		return (PCI_CONF1_ADDRESS(0, 0, PCI_FUNC(devfn), where) &
-			~PCI_CONF1_ENABLE) | BIT(32-PCI_SLOT(devfn));
+		return pci_conf0_addr(devfn, where) |
+		       BIT(32 - PCI_SLOT(devfn));
 	} else {
 		/* type 1 */
 		return (PCI_CONF1_ADDRESS(bus_num, PCI_SLOT(devfn),
-- 
2.39.2


