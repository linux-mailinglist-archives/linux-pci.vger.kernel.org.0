Return-Path: <linux-pci+bounces-6767-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E10D18B55AC
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 12:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BE96B22717
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 10:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1921D2941F;
	Mon, 29 Apr 2024 10:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QkWNK1Aj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344781EB2F;
	Mon, 29 Apr 2024 10:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714387606; cv=none; b=iAGASo4CF65b/odYonEMvJKrbI7VGZRwZiHT4Zk3DYx8t8ZQcLoO35RzxgK2Cvq/kPDYbkOmdTexsjC1UtVBE4UHWsT2TJtYaZm4WmIJBDXjs1dnum9rK7TEEiYu7RQnngnp6LUZnZ5+7uyJVYaAsrbmmBOOyflE4+hjVRhhhIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714387606; c=relaxed/simple;
	bh=t8f4vJyCiJqNoXJKSjDQhHNWW+nEzd6tUzo2pkjJfEc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=VOx1UxOcECMOOh9bFzkhQ2D4WvViEtUVcQ5S0MHw2L+lt7YJmE4l2KzYfQYiBAO2j94/f6IRpkGCHROgN6z7MSKEW2I32C8rYUPkfQFOB2cjGOST5KtqX38oa43z1DBTKSUGgT14nYog1j6JTqsEDQfiEMgVhD4fXiPK9fd1sJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QkWNK1Aj; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714387604; x=1745923604;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t8f4vJyCiJqNoXJKSjDQhHNWW+nEzd6tUzo2pkjJfEc=;
  b=QkWNK1AjtORgTgF2MKJm6Mg+ezK6Ct+nj70zeJ7cNlpSU2dqNsKLS9Aa
   lIfeumbaSv867PiiP3a9OamwtDaU9+A0JTm80/pVsTW/tji166krNIZ4Z
   IchTJ4vr4IAHjDXob+fHfcxMzgNt1deqJX8RPGmEH9iplyaPTjM2WP/HR
   RoS8MfhVOgFnUULvFduFaanMHFTb0QJhD1INx8Q5t56moN6rrhHqzivIT
   jKE/flM90M+QRlcUQh1ottyCx6n7iynXQy0fnTZ7zOrWdOO/9VP7ShGBc
   szgSIKItSD0RZjebAb0blcKiYwXwaSDOJi/YQ7ks8SFkI9Ok0VXa7qcp4
   Q==;
X-CSE-ConnectionGUID: 1tM/w0+dTF2gfUEN/LQp/A==
X-CSE-MsgGUID: rcLMYdLgRgeo+X2G2ET2GA==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="27558780"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="27558780"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 03:46:43 -0700
X-CSE-ConnectionGUID: F60VqCJxSUCNExF1LmhawA==
X-CSE-MsgGUID: sToV44IITk2FtBrF5selGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="30896623"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.45])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 03:46:40 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 00/10] PCI: Add generic Conf Type 0/1 helpers
Date: Mon, 29 Apr 2024 13:46:23 +0300
Message-Id: <20240429104633.11060-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series replaces PCI_CONF1{,_EXT}_ADDRESS() with more generic
helpers and makes them more widely available by placing the new helpers
into include/linux/pci.h.

Most of what is under drivers/pci/controller is converted to use the
new helpers by this series. I left arch/ changes out from this because
they're quite varied so they would be harder to verify (and review)
except ARM/orion5x that I had to do now due to a naming conflict.
Nonetheless, there is plenty custom type 0/1 code under arch/ that
could now take advantage of the new helpers.

I've postponed touching pcie-mediatek.c because there's odd slot
calculation which I brought up in another thread.

Ilpo Järvinen (10):
  ARM: orion5x: Rename PCI_CONF_{REG,FUNC}() out of the way
  PCI: Add helpers to calculate PCI Conf Type 0/1 addresses
  ARM: orion5x: Pass devfn to orion5x_pci_hw_{rd,wr}_conf()
  ARM: orion5x: Use generic PCI Conf Type 1 helper
  PCI: ixp4xx: Use generic PCI Conf Type 0 helper
  PCI: ixp4xx: Replace 1 with PCI_CONF1_TRANSACTION
  PCI: Replace PCI_CONF1{,_EXT}_ADDRESS() with the new helpers
  PCI: tegra: Use generic PCI Conf Type 1 helper
  PCI: mvebu: Use generic PCI Conf Type 1 helper
  PCI: v3: Use generic PCI Conf Type 0/1 helpers

 arch/arm/mach-orion5x/pci.c           | 54 +++++++----------
 drivers/pci/controller/pci-ftpci100.c |  6 +-
 drivers/pci/controller/pci-ixp4xx.c   |  9 ++-
 drivers/pci/controller/pci-mvebu.c    | 13 +---
 drivers/pci/controller/pci-tegra.c    | 12 +---
 drivers/pci/controller/pci-v3-semi.c  |  6 +-
 drivers/pci/controller/pcie-mt7621.c  |  7 +--
 drivers/pci/pci.h                     | 45 --------------
 include/linux/pci.h                   | 86 +++++++++++++++++++++++++++
 9 files changed, 123 insertions(+), 115 deletions(-)

-- 
2.39.2


