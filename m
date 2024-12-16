Return-Path: <linux-pci+bounces-18514-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 709D49F3565
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 17:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 217F6188A179
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 16:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24498148FF0;
	Mon, 16 Dec 2024 16:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kvGODZ4F"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DD214A095;
	Mon, 16 Dec 2024 16:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365424; cv=none; b=PAPXb8I47FRKwPUcG8HlsbE2HYN+QBSccwK9pnN5tfh5JVh85pA4RGfh7TFQwBmr8uKjjM9MFgjLR6zY+Ca+PWhthy6Qyw8ioNa762YzEVJuYCf5V8gr4zGYRzAL4AOaCll7Cf+nQtYPu9ibmbtGeLXghScbduTH35/WQkTa50I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365424; c=relaxed/simple;
	bh=+uv/7k4icZNWNusvJVdXIbirJCnG0+qQNlYVBeg5/Tc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=fU8npe/RlStiOG+bLH7XezCAkuj6EuNMyqjEWVITOtbdk7MfPuigR0hRC0eVngF7wPqDFqQhPtc7fKx/rTue2+yFLGwxhrbSxC4gi9Ui2Wwh6wMOv3dpuEwh4pTwNh3lZb61/e3UjrGyCd/KPSsacbndzYT16rgabcFmUIfirZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kvGODZ4F; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734365423; x=1765901423;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+uv/7k4icZNWNusvJVdXIbirJCnG0+qQNlYVBeg5/Tc=;
  b=kvGODZ4FHeJJbpUjz4/500U4i0L/4BXFcKAeDWBJxSsz0XFBlLqru4Vf
   4fkL4HUvkFlVuTTpK7xWSAE1nler+Iy/k+ifaF2YNaZGPr4IzZWw14xR+
   OmheKrS++Ad2DxArtiIKjWAgW+VhiS7/2F5+IDuQbm5dhUT9sbeCgixDD
   QsN+GfheWpIw5D+eVp/DmFhErgiHwYgGDXOEmJIPPJnswjt12db4n71qp
   cD1VgDsxDuE3+NkcBsLvDfaqwhCO3WsbYFke8Q+ubiVv1YP0c+iI41RvB
   8vpELaBQED129zUhseeq/O4oGfFS6giJAAd6tio/QkMIM0eeYjLqWyQWe
   g==;
X-CSE-ConnectionGUID: nEp9WoOPQ+a7xHFs21ajHg==
X-CSE-MsgGUID: ZEkYG7fFQAWnAN/bTcYQxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="34904188"
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="34904188"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 08:10:22 -0800
X-CSE-ConnectionGUID: 09aDVqpbQNClxQSSDRrojA==
X-CSE-MsgGUID: i9QSmHfrT6GyVHwruP3UiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="97120698"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.29])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 08:10:19 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/4] PCI: pci_printk() removal (+ related cleanups)
Date: Mon, 16 Dec 2024 18:10:08 +0200
Message-Id: <20241216161012.1774-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

include/linux/pci.h provides pci_printk() which is a low-level
interface with level that is only useful for AER due to error severity
variations.

This series cleans up shpchp logging wrappers to avoid using low-level
pci_printk() unnecessarily and replaces pci_printk() with aer_printk().

Ilpo Järvinen (4):
  PCI: shpchp: Remove logging from module init/exit functions
  PCI: shpchp: Change dbg() -> ctrl_dbg()
  PCI: shpchp: Cleanup logging and debug wrappers
  PCI: Descope pci_printk() to aer_printk()

 drivers/pci/hotplug/shpchp.h      | 18 +-----------------
 drivers/pci/hotplug/shpchp_core.c | 13 +------------
 drivers/pci/hotplug/shpchp_hpc.c  |  2 +-
 drivers/pci/pcie/aer.c            | 10 +++++++---
 include/linux/pci.h               |  3 ---
 5 files changed, 10 insertions(+), 36 deletions(-)

-- 
2.39.5


