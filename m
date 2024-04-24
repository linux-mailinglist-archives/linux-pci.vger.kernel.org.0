Return-Path: <linux-pci+bounces-6606-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 779D18B00BD
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 06:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2564C1F2564F
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 04:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E71C14387C;
	Wed, 24 Apr 2024 04:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="cGMCsPy3"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EDA328DB;
	Wed, 24 Apr 2024 04:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713934727; cv=none; b=LZ9ItnqdM7l2mvZExYarO2gz2vvkKWRx/izwfsaqVE32R4mrDIYiAEiWnkkdzkbrBCEvN0X0B/Rzi7c2s0PVDG1ILPMLngoqCHxcVZRgnMA3MM9PIP0IrfHIx77AmpUPzuxSc+x5+RIqtKEGQs4XFmzgL3pW+ILHtGwVLsiyl7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713934727; c=relaxed/simple;
	bh=JtHTIerX+6Ug9XLZdpZMEVInIR2j7MOeUg5fAHlgt6w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rFNHIvweupbHcQmNXi6vKp8AUeXXzDgjcLPq0RiJB/GfLv/Zpwy7SszG4LEG9UqT6U22wLbFzUXR7QJs6H7IHwdEs2D77mrd7d8LYi/USNdCKCZIskzYOiA7aqx7Q3KVBirWHgM6G+U1/CX/VFeJfWHrhDMBZrOyYYmsAlR2cLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=cGMCsPy3; arc=none smtp.client-ip=207.54.90.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1713934726; x=1745470726;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JtHTIerX+6Ug9XLZdpZMEVInIR2j7MOeUg5fAHlgt6w=;
  b=cGMCsPy3m7bQfOwN8Q2G5AUHc2bal1vpFC4H/NDCTC3cmMfMrOOtgwvZ
   faygl9p0lIptJwJNQ8NuTSRhVPYzD/ViIG6WctdDK+ZKTKF3sMM/9HooA
   XQ49F/a7XhFkINjAv58HODZKRdyBR1wklSvFFz2ICp9U4olFWNkyq/mhY
   C4chulUw0tWmJWtQEjUul7pN1klnf4TkQeoF1ib3Ie5C92A8Gl3V1agcG
   7WraUz4itj1KiaX1s4S/ph7iNh9mP9qFepbFz62WwB6xYfQx4lWZGfSxb
   G0ipekNoO36doumSN81ppjzo6aCy2VjW3JXtrn8IOb/+YXMGz7wrtzowf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="156509424"
X-IronPort-AV: E=Sophos;i="6.07,225,1708354800"; 
   d="scan'208";a="156509424"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 13:58:36 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id E1A0BC2ABD;
	Wed, 24 Apr 2024 13:58:32 +0900 (JST)
Received: from m3004.s.css.fujitsu.com (m3004.s.css.fujitsu.com [10.128.233.124])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 311FCF760;
	Wed, 24 Apr 2024 13:58:32 +0900 (JST)
Received: from cxl-test.. (unknown [10.118.236.45])
	by m3004.s.css.fujitsu.com (Postfix) with ESMTP id 0196820059A3;
	Wed, 24 Apr 2024 13:58:31 +0900 (JST)
From: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
To: kobayashi.da-06@jp.fujitsu.com,
	linux-cxl@vger.kernel.org
Cc: y-goto@fujitsu.com,
	linux-pci@vger.kernel.org,
	mj@ucw.cz,
	dan.j.williams@intel.com,
	dave.jiang@intel.com,
	"Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Subject: [PATCH v6 0/2] cxl: Export cxl1.1 device link status to sysfs
Date: Wed, 24 Apr 2024 14:01:00 +0900
Message-ID: <20240424050102.26788-1-kobayashi.da-06@fujitsu.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00

Export cxl1.1 device link status register value to pci device sysfs.

CXL devices are extensions of PCIe. Therefore, from CXL2.0 onwards,
the link status can be output in the same way as traditional PCIe.
However, unlike devices from CXL2.0 onwards, CXL1.1 requires a
different method to obtain the link status from traditional PCIe.
This is because the link status of the CXL1.1 device is not mapped
in the configuration space (as per cxl3.0 specification 8.1).
Instead, the configuration space containing the link status is mapped
to the memory mapped register region (as per cxl3.0 specification 8.2,
Table 8-18). Therefore, the current lspci has a problem where it does
not display the link status of the CXL1.1 device. 
Solve these issues with sysfs attributes to export the status
registers hidden in the RCRB.

The procedure is as follows:
First, obtain the RCRB address within the cxl driver, then access 
the configuration space. Next, output the link status information from
the configuration space to sysfs. Ultimately, the expectation is that
this sysfs file will be consumed by PCI user tools to utilize link status
information.


Changes
v1[1] -> v2:
- Modified to perform rcrb access within the CXL driver.
- Added new attributes to the sysfs of the PCI device.
- Output the link status information to the sysfs of the PCI device.
- Retrieve information from sysfs as the source when displaying information in lspci.

v2[2] -> v3:
- Fix unnecessary initialization and wrong types (Bjohn).
- Create a helper function for getting a PCIe capability offset (Bjohn).
- Move platform-specific implementation to the lib directory in pciutils (Martin).

v3[3] -> v4:
- RCRB register values are read once and cached.
- Added a new attribute to the sysfs of the PCI device.
- Separate lspci implementation from this patch.

v4[4] -> v5:
- Use macros for bitwise operations
- Fix RCRB access to use cxl_memdev

v5[5] -> v6:
- Add and use masks for RCRB register values

[1]
https://lore.kernel.org/linux-cxl/20231220050738.178481-1-kobayashi.da-06@fujitsu.com/
[2]
https://lore.kernel.org/linux-cxl/20240227083313.87699-1-kobayashi.da-06@fujitsu.com/
[3]
https://lore.kernel.org/linux-cxl/20240312080559.14904-1-kobayashi.da-06@fujitsu.com/
[4]
https://lore.kernel.org/linux-cxl/20240409073528.13214-1-kobayashi.da-06@fujitsu.com/
[5]
https://lore.kernel.org/linux-cxl/20240412070715.16160-1-kobayashi.da-06@fujitsu.com/

Kobayashi,Daisuke (2):
  cxl: Add rcd_regs to cxl_rcrb_info
  cxl/pci: Add sysfs attribute for CXL 1.1 device link status

 drivers/cxl/core/core.h |   4 +-
 drivers/cxl/core/regs.c |  16 +++++++
 drivers/cxl/cxl.h       |   3 ++
 drivers/cxl/pci.c       | 101 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 123 insertions(+), 1 deletion(-)

-- 
2.44.0


