Return-Path: <linux-pci+bounces-37163-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A32BA6930
	for <lists+linux-pci@lfdr.de>; Sun, 28 Sep 2025 08:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C244D188CE2B
	for <lists+linux-pci@lfdr.de>; Sun, 28 Sep 2025 06:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C5B29B233;
	Sun, 28 Sep 2025 06:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iGBh1sXx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A56245020;
	Sun, 28 Sep 2025 06:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759041618; cv=none; b=jZy2yWJnZgZ9827jWX5YrOiJrfbSawyM16RSF7rg/AMVXvWGQfTdnm8ck4SIKwfraFt0U8/hcfXyGcuO6Vd2ZJXsST++RNmygPu46D2Aj6IQNsokNawlh9oJrgCD12WseONF4pCmpZSWScXLfJk2za8vBOR2FkYiWzChnu4pe8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759041618; c=relaxed/simple;
	bh=OLMbieYzIb5XioIjGjwsnk6KFQEqAC4Vf5edZMr1iv8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lfGic6vsGpnI9wwsYj1ASLlC9IOdzaFvyJx5U5w5HR8fFyIqTVt7rPerF9/SWqH4CdmtHSAyPSIYaHp+sM7r2mdEYZTL08q8njrBL9XD/IO7KekGoFMxSEgVxNMgb1kx3MWzcJnUbYcqyY7PhTz5GaEpAlT7z5hFJu3Im8GpKRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iGBh1sXx; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759041616; x=1790577616;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OLMbieYzIb5XioIjGjwsnk6KFQEqAC4Vf5edZMr1iv8=;
  b=iGBh1sXxll3ht9LjkXnbBQBtMWfX9LeC3Hlfm4tMRMiNI6utvMyw8xb/
   NKK+mn1OwNX5S8uJGHPfUAKO3MoSkTQkYJaJhG5+esy9xrVjix6bwYMly
   EicblNVQYYyNUWpy8Kizgg2OTz5Ykt0HqmdyLttv3LZIkMujSVAgou03A
   6GbyCJj+3+0JssDaG+PMHpzm09y7HbcyNhCa5Bsz72yhZTsHwaqvtvN/4
   HTu7ar3YVCiUd2R3DPI+kwESfYLbPw5MU4kJuoumK/A7lZRbFL5a4OOOY
   IMBGo71oenQYrUdsZEvljLdXXR/jo+/b/gIi5ezoqj0TFyOp0Ry8N+dej
   g==;
X-CSE-ConnectionGUID: e2WLxCilSwiovwmLczAosw==
X-CSE-MsgGUID: r/A5gCtaTeKWgm/vmMT/vQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61228525"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61228525"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2025 23:40:15 -0700
X-CSE-ConnectionGUID: g0XnQIQJRo6oXMDG5lt09Q==
X-CSE-MsgGUID: KpNjlxSwS7e7wzNjMDtoVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,299,1751266800"; 
   d="scan'208";a="177088835"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa006.jf.intel.com with ESMTP; 27 Sep 2025 23:40:12 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
To: linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org,
	dan.j.williams@intel.com
Cc: yilun.xu@intel.com,
	yilun.xu@linux.intel.com,
	baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com,
	aneesh.kumar@kernel.org,
	bhelgaas@google.com,
	aik@amd.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Address Association Register setup for RP
Date: Sun, 28 Sep 2025 14:27:53 +0800
Message-Id: <20250928062756.2188329-1-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset is for Address Association Register setup for RP. It is
based on devsec/tdx but the first 2 patches could be cleanly applied to
devsec/staging.

The last patch is not for apply. It takes TDX Connect as an example to
illustrate the usage of these newly introduced helpers.

ARM is expected to get benifit from this extra support in
pci_ide_stream_setup(). Intel TDX Connect should retrieve the address
range info from pci_ide.partner[PCI_IDE_RP].mem64 and use firmware call
for setup. AMD is expected to bypass the setup or does the setup but no
harm.


Xu Yilun (3):
  PCI/IDE: Add/export mini helpers for platform TSM drivers
  PCI/IDE: Add Address Association Register setup for RP
  coco/tdx-host: Illustrate IDE Address Association Register setup

 include/linux/pci-ide.h               | 17 +++++++
 drivers/pci/ide.c                     | 72 ++++++++++++++++++++++++---
 drivers/virt/coco/tdx-host/tdx-host.c | 33 ++----------
 3 files changed, 87 insertions(+), 35 deletions(-)

-- 
2.25.1


