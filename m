Return-Path: <linux-pci+bounces-25991-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BED8DA8B655
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 12:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44306189778C
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 10:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9772441B4;
	Wed, 16 Apr 2025 10:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ExvZvf32"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6A5237700;
	Wed, 16 Apr 2025 10:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744797775; cv=none; b=TDH7I5VBs+eGQ1KlSuJ8tA5voM/ICngyIZMhl5/IyTBk5DyTvI9qASijpv7pyOMAicVKAazL4UDkjZSM/UQjWfJPZPhu7COrwOLwklXl7tCAHx8VzcBDxs6DyKjpT1fGmHAmdd0iFaEQP9PXlSbCokks4K+nao30q38jOUkCnqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744797775; c=relaxed/simple;
	bh=+cKq8aKhcGOaMlZseIjnVl0ziwhnIryENv47tAzoNxg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=BpLG34OIvUn5B5qM0xjmn7pKxbELkAH5uWqr0VcdgX4TYEune4g9t2nGd0FGXAKrIofTjPVIeb9cjVuR3NDzV78WfHEmG5CB8Wavq5zAimEj1F571hcixS3sXXl61LWO1WdqpDuxcgVtrqdle5wZM6U5Wd0sOvWe8m+p4j97zpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ExvZvf32; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744797772; x=1776333772;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+cKq8aKhcGOaMlZseIjnVl0ziwhnIryENv47tAzoNxg=;
  b=ExvZvf32+dVjk/6LNeB9Y4cQ56FI1Uw53YY2QATykGJ1L0UiMv2PUhsJ
   wY0eeh9E4TxRtVnp7+u2uKVO33IazHE9dgIJUVRYtD7T7XjGCH36mFg9e
   34Nbfkq0A6ElOId8nhC0Qgja/a6bXqzjnhgQmS2VDXg6CEz2kkUDKbxm6
   SCI8aIf3cKrvNxHe2/wvLDbWu7bIIX02r9oNq+mauzGKQHdhh/pUz8oif
   FyCKC28d9eccdyUB4Aidn3k13vJifpENzTrmSnATOmUBBCDMgzG3OiZzu
   6CYPApYDEDepXho09xYPIGgllKfJep6jwHfXWJxOePSJHDHfwW6Ya95Xv
   A==;
X-CSE-ConnectionGUID: hfC2DSDNRIK9eLIep7XhrQ==
X-CSE-MsgGUID: M7ZMF9lVT22htHuLvBquMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="49987801"
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="49987801"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 03:02:50 -0700
X-CSE-ConnectionGUID: ffEA1J1qSkS2k+ZErWBacg==
X-CSE-MsgGUID: 3sxvh7DWTuK/oFTttngPIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="161449257"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.243])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 03:02:47 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/1] PCI: Use PCI_STD_NUM_BARS instead of 6
Date: Wed, 16 Apr 2025 13:02:39 +0300
Message-Id: <20250416100239.6958-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pci_read_bases() is given literal 6 that means PCI_STD_NUM_BARS.
Replace the literal with the define to annotate the code better.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 364fa2a514f8..08971fca0819 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2058,7 +2058,7 @@ int pci_setup_device(struct pci_dev *dev)
 		if (class == PCI_CLASS_BRIDGE_PCI)
 			goto bad;
 		pci_read_irq(dev);
-		pci_read_bases(dev, 6, PCI_ROM_ADDRESS);
+		pci_read_bases(dev, PCI_STD_NUM_BARS, PCI_ROM_ADDRESS);
 
 		pci_subsystem_ids(dev, &dev->subsystem_vendor, &dev->subsystem_device);
 

base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
-- 
2.39.5


