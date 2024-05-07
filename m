Return-Path: <linux-pci+bounces-7151-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4750F8BDF9D
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 12:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 864F7B20FD1
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 10:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A311E14EC51;
	Tue,  7 May 2024 10:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X6LfagNW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D62A14E2DE;
	Tue,  7 May 2024 10:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715077544; cv=none; b=t50AE3xpqcNNOZMuh3vcwZ4K53K6KUP60hklX9vR+YK/T/aQklUlmWaM/kqpmt1Jm/mu4UqAbtto3dK+92+J1QMRBtbcbePrPjfLGfgRHD7prAEo0N+atGbAb++J2Gw0RGVvEuvueLV2V80juxyrZEBJC0qqvn0KiTbmw9unG1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715077544; c=relaxed/simple;
	bh=9jNmAZjFZRt65eAWVuX8vm3qJWtOwJjUSORyzEAfU3A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=W/6etdepZ6mNatksoi048RzXbUISixkdQTex8IsmkzU8i+W3xgmCyLJjkD+SL5sUsvao7xoQI7QU+gVK0cN3R+M4ctBptHVlgy70vxXAs2zPP3+CbzkUQUOCq0EtSRxXo/ThWe/hR/wtnP7zYV4tKMTVXf9WlmQc40ZzxiazRjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X6LfagNW; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715077542; x=1746613542;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9jNmAZjFZRt65eAWVuX8vm3qJWtOwJjUSORyzEAfU3A=;
  b=X6LfagNWMhR1ZT6aF0dgMX5J5MFWCK4C6FC2TenSmbBFTj3tfOegDCLN
   KQFe3pwl9pJmg9GGMQtqP4w3csO/ublzQQVwHvlFKm8s/FByX5BnetLcW
   8BRvMp0WruOxi0rWYcZWhaMN1jXbINx6MW7AP+BMUmyBA2sXTrR7bRV6c
   QcOoHlq26vqj14aSDyEAWOt4+agCp/CJXXa09ftA6AuNrCj0ZeGIDDJ6G
   rZm2YD4hUR4fKC89aSQ+ilpxG6F0ADrR/8Q5GNWxaUVKYUCCnYy0B07St
   dZOdrNnOdTJ/edCw2zZCt18ZlyX2oNCbwh3+cqa5gdsdM4LpkL0LGLWhZ
   Q==;
X-CSE-ConnectionGUID: fCjH+G/hSWKlQY+Ltk6kPw==
X-CSE-MsgGUID: JMUB/0A2QXi6ezb7NptJVw==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10729725"
X-IronPort-AV: E=Sophos;i="6.07,261,1708416000"; 
   d="scan'208";a="10729725"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 03:25:40 -0700
X-CSE-ConnectionGUID: bFLlPMywS9utbFP+qGdlWw==
X-CSE-MsgGUID: IbUb9jAVR2KgSVmCToj6Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,261,1708416000"; 
   d="scan'208";a="33280196"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.74])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 03:25:36 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 0/8] PCI: Solve two bridge window sizing issues
Date: Tue,  7 May 2024 13:25:15 +0300
Message-Id: <20240507102523.57320-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
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

For the second fix, I chose to expose find_resource_space() from
kernel/resource.c because it should increase accuracy of the cannot-fit
decision (currently that function is called find_resource()). In order
to do that sensibly, a few improvements seemed in order to make its
interface and name of the function sane before exposing it. Thus, the
few extra patches on resource side.

v3:
- Removed "slot" wording
        - Renamed find_empty_resource_slot() -> find_resource_space()
- find_resource_space() returns bool instead of int
- Added patch to convert literal 20 related to bridge win minimum
  alignment to __ffs(SZ_1M)
- Fixed kerneldoc missing "struct"
- Tweaked prints (one dbg -> info, added new dbg one for success case)
- Changelog tweaks
        - Take account largest >> 1 (in alignment calc)
        - Adjust to minor changes made into calculate_memsize()
        - Take logs from more recent kernel to get rid of reg 0xXX

v2:
- Add "typedef" to kerneldoc to get correct formatting
- Use RESOURCE_SIZE_MAX instead of literal
- Remove unnecessary checks for io{port/mem}_resource
- Apply a few style tweaks from Andy

Ilpo Järvinen (8):
  PCI: Fix resource double counting on remove & rescan
  resource: Rename find_resource() to find_resource_space()
  resource: Document find_resource_space() and resource_constraint
  resource: Use typedef for alignf callback
  resource: Handle simple alignment inside __find_resource_space()
  resource: Export find_resource_space()
  PCI: Make minimum bridge window alignment reference more obvious
  PCI: Relax bridge window tail sizing rules

 drivers/pci/bus.c       | 10 +----
 drivers/pci/setup-bus.c | 91 +++++++++++++++++++++++++++++++++++++----
 include/linux/ioport.h  | 44 ++++++++++++++++++--
 include/linux/pci.h     |  5 +--
 kernel/resource.c       | 68 ++++++++++++++----------------
 5 files changed, 157 insertions(+), 61 deletions(-)

-- 
2.39.2


