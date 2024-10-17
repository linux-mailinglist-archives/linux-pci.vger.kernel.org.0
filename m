Return-Path: <linux-pci+bounces-14792-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B26119A2507
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 16:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3C511C21815
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 14:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA2F5680;
	Thu, 17 Oct 2024 14:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TtF7f8CQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F691DDA24;
	Thu, 17 Oct 2024 14:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729175502; cv=none; b=czfT45bcadsnGeoL4Ub6bmkPWaGQF5W26qCfaCi4WjQqk1sipNXj3UPQFOM50/RYW0BLE0ofJDqJMm6ozfhmlwDmQ0nXopXV0LX70N20Yb9rpKNjYTJLxSiSVI3Ud0Nc/DYWhrtdpVEpT6XXRT6998OjA519M6/CxP56z1+3uQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729175502; c=relaxed/simple;
	bh=A6I+1Mo0s9rf0efecXbUhyVTUK5/MgyC4EDlCrCN0wc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=TqoEJh9OaVPbX3B/Vy+FcrZHgUc1SsUv+I9gH8fFX1a03tfpatpMENqPaL/opr27iwcWh9EMBbU4RoWpA6W9CIR53f9FolmW6rb960CIZywb3vBKIzrEoyExlciVY6vk94ICnU+IcBJBW2glLrWHp1UCfYX9SfQ8Iumt4ov7wkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TtF7f8CQ; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729175500; x=1760711500;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=A6I+1Mo0s9rf0efecXbUhyVTUK5/MgyC4EDlCrCN0wc=;
  b=TtF7f8CQ5TDc4FCN/RAqyxBfsKY3ir1jIe1SYfSiLR79CZMai9xfzhyC
   jjDWczJT6a9vJtnYLwM/jjfW5srdYsnpHg2iZ3daEGQZ8LZXPihhQEG4v
   T6ttFTKE5zygIXfvz+o3QkJf/f7IDPx8WKCgbumUU/zS+tnxdF9k0p5Vz
   Ad+jMFgsISNkw6gOEavGqbJRueXpSKFHnnS+m50Q/cXxC5LppgTsfqo0N
   a7KfLtKHER+Y0VCff3CdB1eHSDR6/Q0Wqij8YikghvDsSEK2D4FKDMKl+
   g6GH4Bk/4Ml1FteyEyOEMKhONvNeiffcKhSmV4RjuFwgmNAtMaIjImlsr
   g==;
X-CSE-ConnectionGUID: phAkrVRYTuiMtHOkVpca5w==
X-CSE-MsgGUID: 3OpRkGZmSW2QzUsEV+EbOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="16281354"
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="16281354"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 07:31:39 -0700
X-CSE-ConnectionGUID: lkBNolF6SH2OYt3uGRxK2g==
X-CSE-MsgGUID: 3pNpCI13QP+cFx3G2FW6+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="83394683"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.91])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 07:31:38 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/4] PCI: cpqphp: Fix and cleanups
Date: Thu, 17 Oct 2024 17:31:27 +0300
Message-Id: <20241017143131.46163-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix one PCIBIOS_* return value confusion in cpqphp and cleanup a few
other things.

As for the last patch, I'm not entire sure if it's a step forward or
backward. I guess alternatively it would be possible to add the missing
recursion too if that's preferred but I cannot test the code (and it's
somewhat unclear what that code even attempts to do when considering
all possible topologies).

Ilpo Järvinen (4):
  PCI: cpqphp: Fix PCIBIOS_* return value confusions
  PCI: cpqphp: Use pci_bus_read_dev_vendor_id() to detect presence
  PCI: cpqphp: Use define to read class/revision dword
  PCI: cpqphp: Simplify PCI_ScanBusForNonBridge()

 drivers/pci/hotplug/cpqphp_pci.c | 43 +++++++++++---------------------
 1 file changed, 15 insertions(+), 28 deletions(-)

-- 
2.39.5


