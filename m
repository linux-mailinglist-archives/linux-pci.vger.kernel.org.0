Return-Path: <linux-pci+bounces-2029-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CBB82A85F
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 08:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F6631F23341
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 07:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC70D271;
	Thu, 11 Jan 2024 07:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H+TmW9N3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC9FD27D
	for <linux-pci@vger.kernel.org>; Thu, 11 Jan 2024 07:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704958363; x=1736494363;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4uHCCfSiRo6BzjfxSbRHwcfNk8+xIcQ2WVIkERak6C8=;
  b=H+TmW9N3mmQLjY6zrgyguzaTSQoN/bwyrx/fKoPH9g3EQ3Not0mb7636
   JRfvdiP0+OHJ4ziskMJe6tkbydCkuo0X4pxiOvZ8pEusktrL1vtqvuIKN
   gdsdQIr+o5WgvFxGi0gqvfBZyV9pkNpmpBlB5ZMauUc2GQT6tkUI674JI
   jSRJMty8wvR58lEV34Noktzm4+yncQp2P2B5x5Jyvp6c1hWv9vi7km0ey
   ghNbkR46xWbkZNaj30MFd/0KCl4K89bjyLFa3nBpq1uMLLOOUhw2RrlYA
   hsNHDQkx6Rdffb+ly5I5lvaa22d3+Hb7vJRKoa7JIQpptWHuvd5oI3rkR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="429950003"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="429950003"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 23:32:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="872929376"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="872929376"
Received: from shijiel-mobl.ccr.corp.intel.com (HELO localhost) ([10.254.211.188])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 23:32:40 -0800
From: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
To: linux-pci@vger.kernel.org
Cc: chao.p.peng@linux.intel.com,
	chao.p.peng@intel.com,
	erwin.tsaur@intel.com,
	feiting.wanyan@intel.com,
	qingshun.wang@intel.com,
	"Wang, Qingshun" <qingshun.wang@linux.intel.com>
Subject: [PATCH 0/4] pci/aer: Handle Advisory Non-Fatal properly
Date: Thu, 11 Jan 2024 15:32:15 +0800
Message-ID: <20240111073227.31488-1-qingshun.wang@linux.intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to PCIe specification 4.0 sections 6.2.3.2.4 and 6.2.4.3,
certain uncorrectable errors will signal ERR_COR instead of
ERR_NONFATAL, logged as Advisory Non-Fatal Error, and set bits in
both Correctable Error Status register and Uncorrectable Error Status
register. Currently, when handling AER event the kernel will only look
at CE status or UE status, but never both. In the Advisory
Non-Fatal Error case, bits set in UE status register will not be
reported and cleared until the next Fatal/Non-Fatal error arrives.

For instance, before this patch series, once kernel receives an ANFE
with Poisoned TLP in OS native AER mode, only status of CE will be
reported and cleared:

[  148.459816] pcieport 0000:b7:02.0: AER: Corrected error received: 0000:b7:02.0
[  148.459858] pcieport 0000:b7:02.0: PCIe Bus Error: severity=Corrected, type=Transaction Layer, (Receiver ID)
[  148.459863] pcieport 0000:b7:02.0:   device [8086:0db0] error status/mask=00002000/00000000
[  148.459868] pcieport 0000:b7:02.0:    [13] NonFatalErr           

If the kernel receives a Malformed TLP after that, two UE will be
reported, which is unexpected. Malformed TLP Header was lost since
the previous ANF gated the TLP header logs:

[  170.540192] pcieport 0000:b7:02.0: PCIe Bus Error: severity=Uncorrected (Fatal), type=Transaction Layer, (Receiver ID)
[  170.552420] pcieport 0000:b7:02.0:   device [8086:0db0] error status/mask=00041000/00180020
[  170.561904] pcieport 0000:b7:02.0:    [12] TLP                    (First)
[  170.569656] pcieport 0000:b7:02.0:    [18] MalfTLP       

To handle this case properly, this patch set adds additional fields
in aer_err_info to track both CE and UE status/mask and UE severity.
This information will later be used to determine the register bits
that need to be cleared. Additionally, adds more data to aer_event
tracepoint, which would help to better understand ANFE and other errors
for external observation.

In the previous scenario, after this patch series, both CE status and
related UE status will be reported and cleared after ANFE:

[  148.459816] pcieport 0000:b7:02.0: AER: Corrected error received: 0000:b7:02.0
[  148.459858] pcieport 0000:b7:02.0: PCIe Bus Error: severity=Corrected, type=Transaction Layer, (Receiver ID)
[  148.459863] pcieport 0000:b7:02.0:   device [8086:0db0] error status/mask=00002000/00000000
[  148.459868] pcieport 0000:b7:02.0:    [13] NonFatalErr           
[  148.459868] pcieport 0000:b7:02.0:   Uncorrectable errors that may cause Advisory Non-Fatal:
[  148.459868] pcieport 0000:b7:02.0:    [18] TLP

Wang, Qingshun (4):
  pci/aer: Store more information in aer_err_info
  pci/aer: Handle Advisory Non-Fatal properly
  pci/aer: Fetch information for FTrace
  ras: Trace more information in aer_event

 drivers/acpi/apei/ghes.c      |  16 ++-
 drivers/cxl/core/pci.c        |  15 ++-
 drivers/pci/pci.h             |  12 ++-
 drivers/pci/pcie/aer.c        | 188 +++++++++++++++++++++++++++-------
 include/linux/aer.h           |   6 +-
 include/linux/pci.h           |  27 +++++
 include/ras/ras_event.h       |  48 ++++++++-
 include/uapi/linux/pci_regs.h |   1 +
 8 files changed, 266 insertions(+), 47 deletions(-)

base-commit: 610a9b8f49fbcf1100716370d3b5f6f884a2835a
-- 
2.42.0


