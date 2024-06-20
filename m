Return-Path: <linux-pci+bounces-9002-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8043190FB75
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 05:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAB1B283836
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 03:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8221CD23;
	Thu, 20 Jun 2024 03:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L9xNRFYD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE37E63C;
	Thu, 20 Jun 2024 03:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718852515; cv=none; b=ko3aFimRqWeAtoNmxfN8C+EaK+0f3qjrbmWBKdT9b0IQlJ3Luf2hL94RxypTvFqzFZrHfZW2cmj5lalHG4EMRGyh/W6Qz3kMh/Tu+pgmIuObzexOn2iX+4uDXIG+KAO482K/cIYWRYlWkedwP/OEQinMfCdQ/RtU1GB61a3abbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718852515; c=relaxed/simple;
	bh=EIVXR1Drz5ZwlD3T4VwTfooVVhT2SxMV7lr93B1iMIg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iPfmhix/GS9ZfVdlYSE9AiAZb0weDZ05sonaSr9SklOgYNvZiH3OcBP2ERHpg1scCtcELVVbs1/17FXuUdcM4xG3R7eWtPgpBU/TyDNhMEnBDVpkD5GZTFKOthllIwn7MP5viqbASNKmqLqUjjABJG+vyMVHD0Es/vBUazHkB9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L9xNRFYD; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718852513; x=1750388513;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EIVXR1Drz5ZwlD3T4VwTfooVVhT2SxMV7lr93B1iMIg=;
  b=L9xNRFYDNG/RU4cwBwoEO7alZhI+NLCgItNop79wuEqWQyX3E3cpI2Za
   8o4JBqM1HOGGrOx4ECDBGjJYb0R/s6vLKSfk6WdG+xXewe4w16xiAEMN3
   m/1CILuDPekFomkygWvY5gkQyoTf8K9Bxv8wGkHFYjcp38NhPBlxHhtss
   CqKiC8mw0EuULCbf3ntjzGu68h96VMt0HUcRXLa+TxwyiqHE7/ZdAWIAb
   cTFJQTDlRYndmz0dh/zldSDrRUpOxOFikutrjbK2Hd7C6r7Ivw1GLfAeQ
   h5xbM/cxC+XjV4GutqJf8GypNkU2K0TvvqpGcevt0xxuJLUS37SdEMXd5
   A==;
X-CSE-ConnectionGUID: 93BSlk5HS8KrTmXA/pMLLA==
X-CSE-MsgGUID: hiVqABXRQN+aPvu7Z05gWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="26444191"
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="26444191"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 20:01:52 -0700
X-CSE-ConnectionGUID: GsV7gGC6RDm/wd79OQ/n6A==
X-CSE-MsgGUID: I3E8fsj0QnmEqr/RNB1usw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="42049389"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.127])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 20:01:45 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com,
	mahesh@linux.ibm.com,
	oohall@gmail.com,
	linuxppc-dev@lists.ozlabs.org,
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
	helgaas@kernel.org,
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
Subject: [PATCH v5 0/2] PCI/AER: Handle Advisory Non-Fatal error
Date: Thu, 20 Jun 2024 10:58:55 +0800
Message-Id: <20240620025857.206647-1-zhenzhong.duan@intel.com>
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
     [12] TLP

Note:
checkpatch.pl will produce following warnings on PATCH1&2:

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
v5:
 - squash patch 1 and 3 (Kuppuswamy)
 - add comment about avoiding race and fix typo error (Kuppuswamy)
 - collect Jonathan and Kuppuswamy's R-b

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

v4: https://lkml.org/lkml/2024/5/9/247
v3: https://lore.kernel.org/lkml/20240417061407.1491361-1-zhenzhong.duan@intel.com
v2: https://lore.kernel.org/linux-pci/20240125062802.50819-1-qingshun.wang@linux.intel.com
v1: https://lore.kernel.org/linux-pci/20240111073227.31488-1-qingshun.wang@linux.intel.com


Zhenzhong Duan (2):
  PCI/AER: Clear UNCOR_STATUS bits that might be ANFE
  PCI/AER: Print UNCOR_STATUS bits that might be ANFE

 drivers/pci/pci.h      |  1 +
 drivers/pci/pcie/aer.c | 79 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 79 insertions(+), 1 deletion(-)

-- 
2.34.1


