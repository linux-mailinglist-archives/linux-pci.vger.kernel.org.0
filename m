Return-Path: <linux-pci+bounces-8650-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9BC904E9B
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 10:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 910C41F22F38
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 08:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB9F16D4E0;
	Wed, 12 Jun 2024 08:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a0/9oAwq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794AC16D33D;
	Wed, 12 Jun 2024 08:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718182604; cv=none; b=ZvHTY65BezrPgw347neIC2Bh/fUsrZ928SJL5rQ/LKG0SPQYM5dEbgZqncJF1xjLGUYD+WkurFARVFUmZGnRcjRBOOiPX6so+WBjyi5zzo1Z6iQlu8tTtQIDt3sU5hRgSauKz8wZM4QBKfb17b0W2dt9mc2NxuX9cu3mNv9nneU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718182604; c=relaxed/simple;
	bh=D3tQW505oweH4lJvd1rZezj/RbPf9yk74H/waktxya8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Mmd4VFvp9m+VJffsjTx7iaUezYwRIAeD3zB99bE0TrVVqYwOoa8KwL2RCTrLfQr1wDH3z4osmZ3y4AInUpFD2xVHd1R2GdsITgkUd847JLkPQYuEGMg0nZ0N0uSPowU3o/cM5KL0bvGGT3DhWMbQXTb1Fdj9dYJ6eh7dD8YAVQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a0/9oAwq; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718182603; x=1749718603;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D3tQW505oweH4lJvd1rZezj/RbPf9yk74H/waktxya8=;
  b=a0/9oAwq1Q48rhL2nJjz9knUNHtSe3ko/epr7/w9gQMDfC51SjRgOcTW
   Nfn/ZInmmbZsOkUzE7wpHzW9UraJ17/P/9qbfs0kyhXD2t+1CtwF61Uxa
   0uzege6AkJ5JsfvomkOKYLtzyHN+d2+QneIwcz7/PNdZlNItgZ8q/4OEd
   7iAmO5/MXDm6pky/GfMeNfQG45LPp8OWZfjH4Yf3FY/Nq98+kHjt2dBH9
   Mhn6lNtxkvu8f4Xq9DkvDvF8CsWAC43iyk5NgsIupQAuXxVttlUjLQCcz
   0KsPfltsBt1pGQ3pFmDtB3BjlFhs2yAOk2p91N4uclf7tYy6T3/AXq23G
   g==;
X-CSE-ConnectionGUID: zgnXXNwvQhipv6Zw97YEGA==
X-CSE-MsgGUID: gDQKUEVsStSBopN4N5WgHQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="26050962"
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="26050962"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 01:56:41 -0700
X-CSE-ConnectionGUID: 1CKszvE4T1+JKuRRDRMoEQ==
X-CSE-MsgGUID: NK+UoWlnT+qqIWPx6Ewk3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="62894100"
Received: from unknown (HELO localhost) ([10.245.247.204])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 01:56:35 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	Robert Richter <rric@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/3] PCI: Resource helper improvements
Date: Wed, 12 Jun 2024 11:56:26 +0300
Message-Id: <20240612085629.5015-1-ilpo.jarvinen@linux.intel.com>
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
The last patch cleans up nearby code to use pre-existing helpers &
defines.

For now, this series only converts PCI subsystem. There are plenty of
resource start/end setting code elsewhere in the kernel but those can
be converted once the helpers reach Linus' tree.

Ilpo Järvinen (3):
  resource: Add resource set range and size helpers
  PCI: Use resource_set_{range,size}() helpers
  PCI: Use align and resource helpers, and SZ_* in quirk_s3_64M()

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


