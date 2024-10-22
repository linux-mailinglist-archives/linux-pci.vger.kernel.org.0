Return-Path: <linux-pci+bounces-14988-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 564249A9DFE
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 11:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1726C285CB9
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 09:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFC6194C9E;
	Tue, 22 Oct 2024 09:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NsWqTKOw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AB383CD2;
	Tue, 22 Oct 2024 09:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588311; cv=none; b=PnrAdYwlcTk6gN1VrG/221T9iK0Fj76dni7p8giz05MGtzdZuitdmehDHPFpXRW9PjPvdZ/gA35Qu83IzBLD93W2IyDfgAKlOzZJqv4gHfPA2MfCrhzJHfs9GqbJVjrNv9+AmdhKNDImj3sOol6nEJJ2IvjNSL1o+a9xBoZdLCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588311; c=relaxed/simple;
	bh=GiwLJ1TIGrkfQgpuBcbSAcE1gBJxRKDNPhI8vZpLpFs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=jALDco51Dm/9Gfdta3ltP79MkRaMMSf3Ji8cwVpZT3aw6/fLk6FXBZjBY4qgH516XSqmmhPtoBUx5X8jKlhebSCENeCPUB3fJ1/Xai74TYD9eVPMq2KBTgKIUOVJJQeDzkYvyVuGEePLqnJLJFq0CQCYLCKJE6vTfL85y3ePOjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NsWqTKOw; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729588310; x=1761124310;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GiwLJ1TIGrkfQgpuBcbSAcE1gBJxRKDNPhI8vZpLpFs=;
  b=NsWqTKOw2Iog9lSNKBX1D0UyFZ4tsI+UqsdeXBWBKSo8eH6AMo/Ohylm
   Dnub4DZIk3Yy9C5XLKaSiE/KmpeN8+yAL/IHgqi4w5NZd62MLYzJIVzE7
   0i66z4X+2jqCsccDrKMVEBn133dvZOiN2DtWyURadTh9Nk0hoRVz0h58E
   +yxRltD1kLuFz5HW1xoDvYkOc9AVQvOKwX1JmQsKovn5uM0vQqhtPV2JF
   S3YjhD5uCiqeNSXMec8f744jUtv3D/fkq37sgDgP1qZuc3/PpOYp6RMz5
   S6SqYQCsb2yShTh62qzV0BhT2xJABDhpqrlF9FYeDChI/EfSq4EQwtvUn
   w==;
X-CSE-ConnectionGUID: 0kENBGL7QBeSnid25GDYHw==
X-CSE-MsgGUID: GNt6j44/QO+Q1kpEfwke+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="54514031"
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="54514031"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 02:11:49 -0700
X-CSE-ConnectionGUID: yLEIypwvQIO+jPEL1tOn3Q==
X-CSE-MsgGUID: pRPdQRZpQE2icYX6+op5zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="79974884"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 02:11:47 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 0/4] PCI: cpqphp: Fix and cleanups
Date: Tue, 22 Oct 2024 12:11:36 +0300
Message-Id: <20241022091140.3504-1-ilpo.jarvinen@linux.intel.com>
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

v2:
- Add a warning print if the path missing recursion is executed.

Ilpo Järvinen (4):
  PCI: cpqphp: Fix PCIBIOS_* return value confusions
  PCI: cpqphp: Use pci_bus_read_dev_vendor_id() to detect presence
  PCI: cpqphp: Use define to read class/revision dword
  PCI: cpqphp: Simplify PCI_ScanBusForNonBridge()

 drivers/pci/hotplug/cpqphp_pci.c | 47 +++++++++++++-------------------
 1 file changed, 19 insertions(+), 28 deletions(-)

-- 
2.39.5


