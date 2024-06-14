Return-Path: <linux-pci+bounces-8840-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A05BA908E5B
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 17:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A0A528B456
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 15:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BE415FA8F;
	Fri, 14 Jun 2024 15:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KbMQZhWp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD524155392;
	Fri, 14 Jun 2024 15:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718377802; cv=none; b=EQ7z8Ldlhqs3Yh8p5dlBcFHHmB7MwD3qbfnI3yUz0ltCQghT07bdmnfvAORsaSFK/XL4XAcCkQrFJmep4FuLomilCLYdupEdOmz378gDzNYc57VJ/wd1/XcUkQX3CIzV2qkw3BBbDNWohVXhOSmFpzu4FmCOO2S9zUDXBDWs/5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718377802; c=relaxed/simple;
	bh=lNdCgsrxUfgCEbccTO7z4wHAU6PNz++tfaBMuUB6zXI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=eSu1hEoFhZPrG7yM58XaqJ3LRhG532r6Mm14XkV0orqo8vVTsVbdQqDUOvrvuZQigdKRcOUzv12ZcqGkx4oC81tvmpk8Gfuconp6s/aYqNC6n7669l6XFCVU7uOgRLdGmmtWzY1B74rgqV2794CmbyzJyydBpc1eLkxTWr9yxsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KbMQZhWp; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718377801; x=1749913801;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lNdCgsrxUfgCEbccTO7z4wHAU6PNz++tfaBMuUB6zXI=;
  b=KbMQZhWpc4V6KMQTBxZU40prP4aVA64ZLCI8v0qYwHcT8gWXyUAbtwPu
   MvHU5Z41XNyMAl2dmKZnw52Lc1w66ZH0cIEnJQKGHqCViZ2uS9boFym8D
   /1MDQHrFaLpZDykK9M8nJ8x/mNxFB9C2ZfHEIGj5lFP9NL8bFnebqOyNr
   nQ28DT8QGCR6iNsrVk5eyRuwSG1p6CYMuxp1GgqFgzr2GputzlzmiIOUY
   3HuIE8q754jbfeELj7M4SszCVoLKBTosWr4yI3jmF8aphzyyDJygIyWVk
   gl4/oYoc8EnK3n33NIYKqU7cgPGJ+hpf0luAIPWx1nIss7voVIFTpa30L
   w==;
X-CSE-ConnectionGUID: t6E99RXTSaOBp4mv/t0MEw==
X-CSE-MsgGUID: h5d5Qq3VSM6LXC5m7fMQkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="19089270"
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="19089270"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 08:10:00 -0700
X-CSE-ConnectionGUID: DZYqpDulRLKzAfrTJovpHg==
X-CSE-MsgGUID: WRT7o6jHTCSIhcHhpMI8GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="40629089"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.222])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 08:09:56 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>
Cc: Borislav Petkov <bp@alien8.de>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Tony Luck <tony.luck@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/3] PCI: Add support for logging Flit Mode TLPs (PCIe6)
Date: Fri, 14 Jun 2024 18:09:18 +0300
Message-Id: <20240614150921.29724-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series adds support for Flit Mode (PCIe6). The series is built on
top of the TLP Logging refactoring series:

  https://lore.kernel.org/linux-pci/20240514113109.6690-1-ilpo.jarvinen@linux.intel.com/

Important note to maintainer: The series carries
pcie_update_link_speed() refactoring change that is almost identical
with a patch in the PCIe BW controller series. The patch itself is
basically the same but the context has minor difference. This will need
to be considered if applying both series within the same kernel cycle.

Ilpo Järvinen (3):
  PCI: Refactor pcie_update_link_speed()
  PCI: Track Flit Mode Status & print it with link status
  PCI: Handle TLP Log in Flit mode

 drivers/pci/hotplug/pciehp_hpc.c |  5 +--
 drivers/pci/pci.c                | 12 ++++---
 drivers/pci/pci.h                | 13 ++++++--
 drivers/pci/pcie/aer.c           |  4 ++-
 drivers/pci/pcie/dpc.c           | 23 ++++++++++---
 drivers/pci/pcie/tlp.c           | 57 ++++++++++++++++++++++----------
 drivers/pci/probe.c              | 13 +++++---
 include/linux/aer.h              | 13 ++++++--
 include/linux/pci.h              |  1 +
 include/ras/ras_event.h          | 12 +++----
 include/uapi/linux/pci_regs.h    |  6 +++-
 11 files changed, 112 insertions(+), 47 deletions(-)

-- 
2.39.2


