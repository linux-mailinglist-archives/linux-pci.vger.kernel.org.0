Return-Path: <linux-pci+bounces-2534-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8D483B9A3
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jan 2024 07:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F95428708E
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jan 2024 06:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467ED1118B;
	Thu, 25 Jan 2024 06:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VgNY+BzZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8AF125BC;
	Thu, 25 Jan 2024 06:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706164121; cv=none; b=RRfKDwm+iDWJc872fQHHgayM6tsd8cbEuhA1Kb9J63wovxVq0ZCfpD9bK6XqPSfAXMcGb3Q42q+jp0emnOiU0siqSCEYmoolNJ55DTZx9HOCes+fczHCqoag4NQDsoonVRORw67wUR0aazwAu2Vkyp85V4Ujkpcd4lQ+yTTcHq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706164121; c=relaxed/simple;
	bh=pvMMZU0mlB2eFcvOm/oK0NtOQG6HPvn9mMao1fi7Zqc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GAi90WQsC2bhrGBFGU+IG5g5Vce+OXeV0RWUdS1lV+xTyv9NzpTDdysGiaGx3SoG8WFUzGjrNhnT5YSr86BwaBySiFAg9FbheW9RaTH6MCSzSo5tjZkWaETK3yzhnUg9Kx5daPZ5b6Z8caREOd505hxOsYpcksz9IpKEExORuao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VgNY+BzZ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706164118; x=1737700118;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pvMMZU0mlB2eFcvOm/oK0NtOQG6HPvn9mMao1fi7Zqc=;
  b=VgNY+BzZO7tu02szbM5sY3egj0u72h+5cGdBc7pVVT5NVRIFtJueAD1x
   bd2sMU86AYMm8EbyyAqsRL3O/l2x7DRmFigeiiFfWzh52sZJhYDRhUEUU
   JAWs1TVccFwpydr/jmyd9qQU+wPA6UY3migkeskci8EpT2WgDoT0lLc7e
   VWT80yR138Kk1Rj18d0Vu/AKK9dPvTgYDoJXgzZciCkwGxpEdPQOb/s+V
   FOy/qrdAI3VdEDlR6sjyYiq0CRo2BZQ5jnO4gMhyl/CaA3n+o3eVdm2qF
   W5gMYhL1ITWXTqTXOKMZ8hj53oaZctzAd3W2DoIY5wdBRmY/RkTZjMMRL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="9456724"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9456724"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 22:28:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2122533"
Received: from linchen5-mobl.ccr.corp.intel.com (HELO localhost) ([10.254.209.209])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 22:28:27 -0800
From: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
To: linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-acpi@vger.kernel.org
Cc: chao.p.peng@linux.intel.com,
	erwin.tsaur@intel.com,
	feiting.wanyan@intel.com,
	qingshun.wang@intel.com,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	James Morse <james.morse@arm.com>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Adam Preble <adam.c.preble@intel.com>,
	Li Yang <leoyang.li@nxp.com>,
	Lukas Wunner <lukas@wunner.de>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	Robert Richter <rrichter@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	linux-edac@vger.kernel.org,
	"Wang, Qingshun" <qingshun.wang@linux.intel.com>
Subject: [PATCH v2 0/4] PCI/AER: Handle Advisory Non-Fatal properly
Date: Thu, 25 Jan 2024 14:27:58 +0800
Message-ID: <20240125062802.50819-1-qingshun.wang@linux.intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to PCIe Base Specification Revision 6.1, Sections 6.2.3.4
and 6.2.4.3, certain uncorrectable errors will signal ERR_COR instead
of ERR_NONFATAL, logged as Advisory Non-Fatal Error, and set bits in
both Correctable Error Status register and Uncorrectable Error Status
register. Currently, when handling AER events the kernel will only look
at CE status or UE status, but never both. In the Advisory
Non-Fatal Error case, bits set in the UE status register will not be
reported and cleared until the next Fatal/Non-Fatal error arrives.

For instance, previously, when the kernel receives an ANFE with Poisoned
TLP in OS native AER mode, only the status of CE will be reported and
cleared:

  AER: Corrected error received: 0000:b7:02.0
  PCIe Bus Error: severity=Corrected, type=Transaction Layer, (Receiver ID)
    device [8086:0db0] error status/mask=00002000/00000000
     [13] NonFatalErr           

If the kernel receives a Malformed TLP after that, two UE will be
reported, which is unexpected. The Malformed TLP Header was lost since
the previous ANFE gated the TLP header logs:

  PCIe Bus Error: severity=Uncorrected (Fatal), type=Transaction Layer, (Receiver ID)
    device [8086:0db0] error status/mask=00041000/00180020
     [12] TLP                    (First)
     [18] MalfTLP       

To handle this case properly, add additional fields in aer_err_info to
track both CE and UE status/mask, UE severity, and Device Status.
Use this information to determine the status bits that need to be cleared.

Now, in the previous scenario, both CE status and related UE status will
be reported and cleared after ANFE:

  AER: Corrected error received: 0000:b7:02.0
  PCIe Bus Error: severity=Corrected, type=Transaction Layer, (Receiver ID)
    device [8086:0db0] error status/mask=00002000/00000000
     [13] NonFatalErr           
    Uncorrectable errors that may cause Advisory Non-Fatal:
     [18] TLP

Additionally, add more data to aer_event tracepoint, which would help
to better understand ANFE and other errors for external observation.

Note:
checkpatch.pl will produce following errors and warnings on PATCH 4:

  ERROR: space prohibited after that open parenthesis '('
  #103: FILE: include/ras/ras_event.h:319:
  +		__field(	u16,		link_status	)

  ...similar errors omitted...

  WARNING: quoted string split across lines
  #126: FILE: include/ras/ras_event.h:342:
  +	TP_printk("%s PCIe Bus Error: severity=%s, %s, TLP Header=%s, "
  +		 "Correctable Error Status=0x%08x, "

  ...similar warnings omitted...

For readability reasons, these errors and warnings are not fixed,
following the code style of existing examples in the kernel source tree.

Change log:
v2:
  - Reference to the latest PCIe Specification in both commit messages
    and comments, as suggested by Bjorn Helgaas.
  - Describe the reason for storing additional information in
    aer_err_info in the commit message of PATCH 1, as suggested by Bjorn
    Helgaas.
  - Add more details of behavior changes in the commit message of PATCH
    2, as suggested by Bjorn Helgaas.

v1: https://lore.kernel.org/linux-pci/20240111073227.31488-1-qingshun.wang@linux.intel.com/

Wang, Qingshun (4):
  PCI/AER: Store more information in aer_err_info
  PCI/AER: Handle Advisory Non-Fatal properly
  PCI/AER: Fetch information for FTrace
  RAS: Trace more information in aer_event

 drivers/acpi/apei/ghes.c      |  16 ++-
 drivers/cxl/core/pci.c        |  15 ++-
 drivers/pci/pci.h             |  12 ++-
 drivers/pci/pcie/aer.c        | 191 +++++++++++++++++++++++++++-------
 include/linux/aer.h           |   6 +-
 include/linux/pci.h           |  27 +++++
 include/ras/ras_event.h       |  48 ++++++++-
 include/uapi/linux/pci_regs.h |   1 +
 8 files changed, 269 insertions(+), 47 deletions(-)


base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
-- 
2.42.0


