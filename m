Return-Path: <linux-pci+bounces-7282-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECBE8C0CD4
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 10:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D0641C20E88
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 08:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31EA14A089;
	Thu,  9 May 2024 08:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RMyNR/Ec"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FB2128396;
	Thu,  9 May 2024 08:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715244684; cv=none; b=kHwplKIhuX6UJmPrGW1bj1WJqISoY2QgMQJ6U0Mr7jpgPVOCSeLcqD0SlS+7zeaSPAlWpeiQXA0Iah/cS5C7svYjXBmdPBVzGmGTFcwQlUs77HKAE8Sr8V9NWhAGCkr/6FjDL7IId3n7BwjT8bcf6AMIsITWj2axU+yvlsp46MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715244684; c=relaxed/simple;
	bh=UuNlm3kDCVruMLI+aaRK5geLMaD9c7v7/gptoRxJydY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h8hcvvW+ThRUAnkPdSGOkV7OWLzrn1qkWppvZjwLC+Zs8xMPubIN24DrX08mhT0pLop8KrJE9aZdRWIWBmWhGllOAWxZ1n/tyn8tlcTIAEGlKDmGXP5XZJLqI1VZrBtIMfBND+sBucFF0r9TbxyhZE2x7JOd5RtscmeJdOd8f04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RMyNR/Ec; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715244682; x=1746780682;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UuNlm3kDCVruMLI+aaRK5geLMaD9c7v7/gptoRxJydY=;
  b=RMyNR/EcVFQOxXyLFLRmBurfxGOC8YkGdVZ1LAonFcHqAHwJ8r2Lzq8d
   e9n3Uu/FsBO8zxXtL5fFDBzXGQWT1om9bEeEcFyHjBxRl0nsvP9IbmwMQ
   2hVepN1FkUb0biScrIgm8KJih6waZagSwbF+Nbci9r9+Vd9K+miFxzao1
   NdnApebteGmI4Cr/I5njbSdJAUCp+4thgt+QZiaaVvMWFx7xZE/7hKAsa
   T++SUQ0BGEYpjYau7xQiXV3vfEbm6J9wYAl4i0JKQug/Q3yD8spTCY5Xm
   rMiESZ22if64vrJO8yqYTuDycZY5s3mVHh5USxLUfbfUr3Qb1K9gk1q3W
   A==;
X-CSE-ConnectionGUID: Q6Yonj0MQHCS+l+XbYm81Q==
X-CSE-MsgGUID: +ANTXSGVQzO1UH5wRBMG/Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="14103950"
X-IronPort-AV: E=Sophos;i="6.08,147,1712646000"; 
   d="scan'208";a="14103950"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 01:51:21 -0700
X-CSE-ConnectionGUID: 6b+qMRU8QoKFRQ8UJLIHDw==
X-CSE-MsgGUID: yt2Ktp1zSJqdCQpMpq1diw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,147,1712646000"; 
   d="scan'208";a="29060665"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 01:51:14 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: linux-pci@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-acpi@vger.kernel.org,
	rafael@kernel.org,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	bp@alien8.de,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	bhelgaas@google.com,
	helgaas@kernel.org,
	mahesh@linux.ibm.com,
	oohall@gmail.com,
	linmiaohe@huawei.com,
	shiju.jose@huawei.com,
	adam.c.preble@intel.com,
	lukas@wunner.de,
	Smita.KoralahalliChannabasappa@amd.com,
	rrichter@amd.com,
	linux-cxl@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	erwin.tsaur@intel.com,
	sathyanarayanan.kuppuswamy@intel.com,
	dan.j.williams@intel.com,
	feiting.wanyan@intel.com,
	yudong.wang@intel.com,
	chao.p.peng@intel.com,
	qingshun.wang@linux.intel.com,
	Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v4 0/3] PCI/AER: Handle Advisory Non-Fatal error
Date: Thu,  9 May 2024 16:48:30 +0800
Message-Id: <20240509084833.2147767-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is a relay work of Qingshun's v2 [1], but changed to focus on ANFE
processing as subject suggests and drops trace-event for now. I think it's
a bit heavy to do extra IOes to get PCIe registers only for trace purpose
and not see it a community request for now.

According to PCIe Base Specification Revision 6.1, Sections 6.2.3.2.4 and
6.2.4.3, certain uncorrectable errors will signal ERR_COR instead of
ERR_NONFATAL, logged as Advisory Non-Fatal Error(ANFE), and set bits in
both Correctable Error(CE) Status register and Uncorrectable Error(UE)
Status register. Currently, when handling AER events the kernel will only
look at CE status or UE status, but never both. In the ANFE case, bits set
in the UE status register will not be reported and cleared until the next
FE/NFE arrives.

For instance, previously, when the kernel receives an ANFE with Poisoned
TLP in OS native AER mode, only the status of CE will be reported and
cleared:

  AER: Correctable error message received from 0000:b7:02.0
  PCIe Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
    device [8086:0db0] error status/mask=00002000/00000000
     [13] NonFatalErr

If the kernel receives a Malformed TLP after that, two UEs will be
reported, which is unexpected. The Malformed TLP Header is lost since
the previous ANFE gated the TLP header logs:

  PCIe Bus Error: severity="Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
    device [8086:0db0] error status/mask=00041000/00180020
     [12] TLP                    (First)
     [18] MalfTLP

To handle this case properly, calculate potential ANFE related status bits
and save in aer_err_info. Use this information to determine the status bits
that need to be cleared.

Now, for the previous scenario, both CE status and related UE status will
be reported and cleared after ANFE:

  AER: Correctable error message received from 0000:b7:02.0
  PCIe Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
    device [8086:0db0] error status/mask=00002000/00000000
     [13] NonFatalErr
    Uncorrectable errors that may cause Advisory Non-Fatal:
     [18] TLP

Note:
checkpatch.pl will produce following warnings on PATCH2/3:

WARNING: 'UE' may be misspelled - perhaps 'USE'?
#22:
uncorrectable error(UE) status should be cleared. However, there is no

...similar warnings omitted...

This is a false-positive, so not fixed.

WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#10:
  PCIe Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)

...similar warnings omitted...

For readability reasons, these warnings are not fixed.



[1] https://lore.kernel.org/linux-pci/20240125062802.50819-1-qingshun.wang@linux.intel.com

Thanks
Qingshun, Zhenzhong

Changelog:
v4:
  - Fix a race in anfe_get_uc_status() (Jonathan)
  - Add a comment to explain side effect of processing ANFE as NFE (Jonathan)
  - Drop the check for PCI_EXP_DEVSTA_NFED

v3:
  - Split ANFE print and processing to two patches (Bjorn)
  - Simplify ANFE handling, drop trace event
  - Polish comments and patch description
  - Add Tested-by

v2:
  - Reference to the latest PCIe Specification in both commit messages
    and comments, as suggested by Bjorn Helgaas.
  - Describe the reason for storing additional information in
    aer_err_info in the commit message of PATCH 1, as suggested by Bjorn
    Helgaas.
  - Add more details of behavior changes in the commit message of PATCH
    2, as suggested by Bjorn Helgaas.

v3: https://lore.kernel.org/lkml/20240417061407.1491361-1-zhenzhong.duan@intel.com
v2: https://lore.kernel.org/linux-pci/20240125062802.50819-1-qingshun.wang@linux.intel.com
v1: https://lore.kernel.org/linux-pci/20240111073227.31488-1-qingshun.wang@linux.intel.com

Zhenzhong Duan (3):
  PCI/AER: Store UNCOR_STATUS bits that might be ANFE in aer_err_info
  PCI/AER: Print UNCOR_STATUS bits that might be ANFE
  PCI/AER: Clear UNCOR_STATUS bits that might be ANFE

 drivers/pci/pci.h      |  1 +
 drivers/pci/pcie/aer.c | 75 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 75 insertions(+), 1 deletion(-)

-- 
2.34.1


