Return-Path: <linux-pci+bounces-8794-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1283590894A
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 12:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE0D71F2BC13
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 10:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7671C193067;
	Fri, 14 Jun 2024 10:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iayTsd34"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8636148319;
	Fri, 14 Jun 2024 10:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718359581; cv=none; b=kyHQFZ08F9eGoPnWBccgrFmBlV6upF93qBIQ0TdqPcN63qXrPNui706iXPARmCDHn0e74HStsw01rSUleqA205fciCnTjX0BJa4OeQkqQs9JGIBvhYOpm/yMw0VG7F1MEMpG5z0i00DZUrENQh2DBTfc/eQeSHktHiCmJ77KtU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718359581; c=relaxed/simple;
	bh=M+wudfRew0zZ0o2jEhGKUvusyJLRH89lvhLCPTPKDJc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=jdAYE9vjqhtGx51YLDic+6gXif9YSVLfzP+ftu91XuC4/OIrqNE+L00XcRmYpAcbx9LHlUPe2yKj6msQS9U3JwiQ8SKwqC31QsUhasfGcf5PR5ck0Dq6V5CvFmRjbm969VwCuW3orw56LQjk3F8hHV+GkDommj8xD5FLvv+Qt7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iayTsd34; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718359580; x=1749895580;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=M+wudfRew0zZ0o2jEhGKUvusyJLRH89lvhLCPTPKDJc=;
  b=iayTsd348RioBTVogaMcGVtwRvwKQ6zbb5ZY0+VfC4yUFROfPVnN4oB7
   NlSVfMUQFkCUTu9DHcDfUXjAgYeXx9TXgHgIK5EEzUE1tq9hbcEeqUkqr
   vGBGvMPdF+unkysdNgZ4Iu4XAYfBeMOlNbF0mlfu6qk8SqmSdw2hSUq7J
   6dsSOhdX9034V8Z0nCELKCrM4K8gMsMtPG2xBuzrbTWak3Sb3uJazWIF3
   AIrg4qtD2GDGpz8YhPAuG8cwRTLyawoJKl8jnbJh+0WjJ1NS+vOH3BPDR
   sTlA/46g3p9URsyeIYSmwOf/yf5pXQyXW7l1etj6PQbflCPoDFNQ2ZxAS
   g==;
X-CSE-ConnectionGUID: Dfyh1Pw4RFWffGyXK7JNuw==
X-CSE-MsgGUID: ECsfw+lMSTChVR3HS+si3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="32715804"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="32715804"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 03:06:19 -0700
X-CSE-ConnectionGUID: Swo5ctbJQEaxpmynKRoqug==
X-CSE-MsgGUID: GnEecZIsRhGB7Xm97YsUMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="45575859"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.222])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 03:06:14 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc: linux-kernel@vger.kernel.org,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-tegra@vger.kernel.org,
	Robert Richter <rric@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 0/4] PCI: Resource helper improvements
Date: Fri, 14 Jun 2024 13:06:02 +0300
Message-Id: <20240614100606.15830-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series introduces resource_set_{range,size}() helpers to replace
often repeated code fragments to set resource start and end addresses.
The last two patches clean up nearby code.

For now, this series only converts PCI subsystem. There are plenty of
resource start/end setting code elsewhere in the kernel but those can
be converted once the helpers reach Linus' tree.

--
v2:
- Improved commit message
- Added patch to introduce ALIGN_DOWN_IF_NONZERO()

Ilpo Järvinen (4):
  resource: Add resource set range and size helpers
  PCI: Use resource_set_{range,size}() helpers
  PCI: Use align and resource helpers, and SZ_* in quirk_s3_64M()
  PCI: Introduce ALIGN_DOWN_IF_NONZERO() helper locally

 drivers/pci/controller/pci-tegra.c       |  2 +-
 drivers/pci/controller/pci-thunder-pem.c |  4 +--
 drivers/pci/ecam.c                       |  2 +-
 drivers/pci/iov.c                        |  6 ++--
 drivers/pci/pci.c                        |  3 +-
 drivers/pci/quirks.c                     | 23 +++++++---------
 drivers/pci/setup-bus.c                  | 35 ++++++++++--------------
 drivers/pci/setup-res.c                  |  7 ++---
 include/linux/ioport.h                   | 32 ++++++++++++++++++++++
 9 files changed, 68 insertions(+), 46 deletions(-)

-- 
2.39.2


