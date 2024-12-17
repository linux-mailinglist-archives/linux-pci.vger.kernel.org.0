Return-Path: <linux-pci+bounces-18635-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DB29F4CF0
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 14:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F03C16AC83
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 13:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844B41F6699;
	Tue, 17 Dec 2024 13:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lf1IrWDn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A9F1F5437;
	Tue, 17 Dec 2024 13:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734443734; cv=none; b=LGyXWdYQR0QtFO6VfH9I1ubl920NW+JnlCR4452O81e5n7pWQn4t2VwVKQpc7DdRPJrClrFtR/8DsLlXac91NqcQocQdsra58FXVOwleXk+BA6V9B72YlV5PvrlexmglT1+Rygb2MvSQ2h93ImP8g4PZfGq1qcrJFuMD59A8WLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734443734; c=relaxed/simple;
	bh=xoqRzVI0W8mzrozTSiloHUP8vgerlWiV4vwFpAgGE2U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T0zpi/21sG5IzAYdfR9ZoQN4vQzPJ0zahbc85TwW4QnETv50YOqz58AtswT3Tzt8W8pJAjV5VYr7X71YtSiSwjQmGxtD0GIGgbTXomxxEM67nkSRscuill+ALkMl1UqfqE1TZpafhe/TKI8ziEOk5WvO80r5EPdyDDaUnSgCgnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lf1IrWDn; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734443733; x=1765979733;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xoqRzVI0W8mzrozTSiloHUP8vgerlWiV4vwFpAgGE2U=;
  b=Lf1IrWDnoxSqVA+gF7+f6d9V7JToq3VlioZ14QKbrfJx8O0tgrLpD9jh
   ZD407cpgb0kZ+tMwEk4Me1jYx8z422u22dpsOS7K3/ZifXZ4f4lpnj9hr
   EKuUaPoZYpXhVqmMggEDWH2zRtwHiZ3o+N9fgYauKChNUbvr7LhYj2xLD
   OCMNpefahGfx0brtFt27kb9WUIBUowvut5RSdW4ozAGa29o93XPJGbtnO
   COrZwY49WmUZ2DKZhuxOs8R9TRcPPl3nGVf06wBfbrZmdT1of3hUeoo+V
   CBmg/1A1fXpMBfSHpHAobCm1w7KN4IlYtdSp6Vt6ejmuHKUq2p1m7FpYQ
   Q==;
X-CSE-ConnectionGUID: +yhXDf8/TY2iQy7Z8Ijvfg==
X-CSE-MsgGUID: VAbKbsqfTTmyADU/N0zktQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="34748440"
X-IronPort-AV: E=Sophos;i="6.12,242,1728975600"; 
   d="scan'208";a="34748440"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 05:55:32 -0800
X-CSE-ConnectionGUID: zressglESBKhDC5JuZ8yNw==
X-CSE-MsgGUID: nnSQZx3+RD2pqwVzlaO1ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,242,1728975600"; 
   d="scan'208";a="98109607"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.192])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 05:55:28 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v7 8/8] PCI/AER: Add prefixes to printouts
Date: Tue, 17 Dec 2024 15:53:58 +0200
Message-Id: <20241217135358.9345-9-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241217135358.9345-1-ilpo.jarvinen@linux.intel.com>
References: <20241217135358.9345-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Only part of the AER diagnostic printouts use "AER:" prefix because
they use low-level pci_printk() directly to allow selecting level.

Add "AER:" prefix to lines that are printed with pci_printk().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/pcie/aer.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index ece8cb88d110..1c251ac65d1b 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -686,8 +686,8 @@ static void __aer_print_error(struct pci_dev *dev,
 		if (!errmsg)
 			errmsg = "Unknown Error Bit";
 
-		pci_printk(level, dev, "   [%2d] %-22s%s\n", i, errmsg,
-				info->first_error == i ? " (First)" : "");
+		pci_printk(level, dev, "%s   [%2d] %-22s%s\n", dev_fmt(""), i,
+			   errmsg, info->first_error == i ? " (First)" : "");
 	}
 	pci_dev_aer_stats_incr(dev, info);
 }
@@ -709,12 +709,12 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 
 	level = (info->severity == AER_CORRECTABLE) ? KERN_WARNING : KERN_ERR;
 
-	pci_printk(level, dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
-		   aer_error_severity_string[info->severity],
+	pci_printk(level, dev, "%sPCIe Bus Error: severity=%s, type=%s, (%s)\n",
+		   dev_fmt(""), aer_error_severity_string[info->severity],
 		   aer_error_layer[layer], aer_agent_string[agent]);
 
-	pci_printk(level, dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
-		   dev->vendor, dev->device, info->status, info->mask);
+	pci_printk(level, dev, "%s  device [%04x:%04x] error status/mask=%08x/%08x\n",
+		   dev_fmt(""), dev->vendor, dev->device, info->status, info->mask);
 
 	__aer_print_error(dev, info);
 
-- 
2.39.5


