Return-Path: <linux-pci+bounces-1506-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7964481FA10
	for <lists+linux-pci@lfdr.de>; Thu, 28 Dec 2023 17:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AADBD1C20C2F
	for <lists+linux-pci@lfdr.de>; Thu, 28 Dec 2023 16:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3C2F50C;
	Thu, 28 Dec 2023 16:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aXrQswo/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7348CF508;
	Thu, 28 Dec 2023 16:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703782643; x=1735318643;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6BZEQD+BPdQPPiPwf+9/1GG6o7RjVGwpGa0Ba6OSvC8=;
  b=aXrQswo/UAG1u3QtnMSk6q68a5HAvpgF0pZUwC1KN0zvGRDM9k0fPBjI
   tk4kQDSHjDrbd4WC5vztZ7AtDnvcGxDoDHZnYLQ8BctUi8SdS8a4IxwhT
   nRLnHp9wCY4UjXj4jHhGkKdY0voxUJ3GasCK2/lHb4L5st88qSto/vz7o
   ya9U5N3+xxFaKsM0dKoW3c2IJkkyrInK3W6q3Qu48aEzK2M6zFqFONoVk
   rmJ/eFCsI76YALAKO2+twLsNU1XO5WcIm9GY7a8ADFqHMq+NlngC3RieK
   TwAYN+FtZGwbIJp6700+nLuTLftU36jkiflfJmVs25F3vHsfEbKTonDc1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="381536537"
X-IronPort-AV: E=Sophos;i="6.04,312,1695711600"; 
   d="scan'208";a="381536537"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 08:57:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="844488429"
X-IronPort-AV: E=Sophos;i="6.04,312,1695711600"; 
   d="scan'208";a="844488429"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.94.250.171])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 08:57:15 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Lukas Wunner <lukas@wunner.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 0/7] PCI: Solve two bridge window sizing issues
Date: Thu, 28 Dec 2023 18:57:00 +0200
Message-Id: <20231228165707.3447-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

Here's a series that contains two fixes to PCI bridge window sizing
algorithm. Together, they should enable remove & rescan cycle to work
for a PCI bus that has PCI devices with optional resources and/or
disparity in BAR sizes.

For the second fix, I chose to expose find_empty_resource_slot() from
kernel/resource.c because it should increase accuracy of the cannot-fit
decision (currently that function is called find_resource()). In order
to do that sensibly, a few improvements seemed in order to make its
interface and name of the function sane before exposing it. Thus, the
few extra patches on resource side.

Unfortunately I don't have a reason to suspect these would help with
the issues related to the currently ongoing resource regression
thread [1].

[1] https://lore.kernel.org/linux-pci/ZXpaNCLiDM+Kv38H@marvin.atrad.com.au/

v2:
- Add "typedef" to kerneldoc to get correct formatting
- Use RESOURCE_SIZE_MAX instead of literal
- Remove unnecessary checks for io{port/mem}_resource
- Apply a few style tweaks from Andy

Ilpo Järvinen (7):
  PCI: Fix resource double counting on remove & rescan
  resource: Rename find_resource() to find_empty_resource_slot()
  resource: Document find_empty_resource_slot() and resource_constraint
  resource: Use typedef for alignf callback
  resource: Handle simple alignment inside __find_empty_resource_slot()
  resource: Export find_empty_resource_slot()
  PCI: Relax bridge window tail sizing rules

 drivers/pci/bus.c       | 10 ++----
 drivers/pci/setup-bus.c | 80 +++++++++++++++++++++++++++++++++++++----
 include/linux/ioport.h  | 44 ++++++++++++++++++++---
 include/linux/pci.h     |  5 +--
 kernel/resource.c       | 68 ++++++++++++++++-------------------
 5 files changed, 148 insertions(+), 59 deletions(-)

-- 
2.30.2


