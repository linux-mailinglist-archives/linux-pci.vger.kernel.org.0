Return-Path: <linux-pci+bounces-1293-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2FF81C9F5
	for <lists+linux-pci@lfdr.de>; Fri, 22 Dec 2023 13:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D2861F22D96
	for <lists+linux-pci@lfdr.de>; Fri, 22 Dec 2023 12:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8441804E;
	Fri, 22 Dec 2023 12:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P+wgWllB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8206F18043;
	Fri, 22 Dec 2023 12:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703248155; x=1734784155;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=W9BM0HBysXXzPmYSLOHxDQBjtsNT8ib3ZOWo2DiabTc=;
  b=P+wgWllBIMF5mvV18Dl68n8K+Pz/uQ/yJtS3oS9IOJMgTkPE9ivW4aOe
   n/6MHiaJ8gemPbnbekG6aWGYmaHU7ogs4GxVgnObFh/YyQHgd+iRd5Qd5
   LKNk5kFvSpzWZd4HsWs716FG7V3+AObFp29+jFkvQu+Glcg6BxrhFllnW
   Lds6BA3KMndONxcVbvfSjovmQs1RPOHNBToDZ5xjV5U44xJkqlSGDcmZj
   z6rEIz9YvlzqF4bi9pfzCuP1zhnmUD6cmQVFB60RvI3dWjP8MWYlqk27I
   XMrdF1UuuANZ7FrfqeqpIxnA2bFBBuhA6T2WATOGkXu8cHxHF+0w/pbvv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="3195357"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="3195357"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 04:29:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="805932771"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="805932771"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.94.248.105])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 04:29:09 -0800
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
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/7] PCI: Solve two bridge window sizing issues
Date: Fri, 22 Dec 2023 14:28:54 +0200
Message-Id: <20231222122901.49538-1-ilpo.jarvinen@linux.intel.com>
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

Ilpo Järvinen (7):
  PCI: Fix resource double counting on remove & rescan
  resource: Rename find_resource() to find_empty_resource_slot()
  resource: Document find_empty_resource_slot() and resource_constraint
  resource: Use typedef for alignf callback
  resource: Handle simple alignment inside __find_empty_resource_slot()
  resource: Export find_empty_resource_slot()
  PCI: Relax bridge window tail sizing rules

 drivers/pci/bus.c       | 10 +----
 drivers/pci/setup-bus.c | 81 ++++++++++++++++++++++++++++++++++++++---
 include/linux/ioport.h  | 44 ++++++++++++++++++++--
 include/linux/pci.h     |  5 +--
 kernel/resource.c       | 69 ++++++++++++++++-------------------
 5 files changed, 150 insertions(+), 59 deletions(-)

-- 
2.30.2


