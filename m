Return-Path: <linux-pci+bounces-5915-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F9F89D33B
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 09:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FB5C282C3E
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 07:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8739C7BB1A;
	Tue,  9 Apr 2024 07:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="OihpwSIq"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625E27BAFE;
	Tue,  9 Apr 2024 07:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712648008; cv=none; b=bm7EwwUTKrbLz5qERCAUZJB/Jtqo4xyn3kGS6ixnN7ZjBV9XBMujsirZsbdGK2wIFYKLC7I77XfpgsXLrEfRTNrcazx14EyAzhXWi56XpgZuzqNmcYlt4R1FiIYcfufdadw6exmSN+15IPlmUC7IXWHwvSnKni5CgvxVJbk5qn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712648008; c=relaxed/simple;
	bh=a46KyyspFa/zbErsmBdpiV2e+Dw2p04bggbRAUUKodY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AdAP3A2sMw+BrXqg6SLWWL0JLrgDf4n9C/tVRoL3EEvu4R0dMmDtopCtk6p/MhUPSy1WXbaVM2i9sE80/ybg9zi/tDGuvYvly0jr2ealFR/YdGTt6f5MAmDcNDRL5a5FVN2QQxQ1A2cE0GiIUKvqf6zuFQn3ijKS9gJLliP6mmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=OihpwSIq; arc=none smtp.client-ip=207.54.90.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1712648006; x=1744184006;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=a46KyyspFa/zbErsmBdpiV2e+Dw2p04bggbRAUUKodY=;
  b=OihpwSIqNq/GKQElrpZx5fQlZ3sNYW+pst3JmVhVPB+MpaSidiYu088E
   IxtT6/BYEwlutO1iZV4dMngwHmZKHweka0P+qPqYqAZnJzDoMy0sNPwSC
   MrdMpybAKEhFZWZ+3fgDOguohnRR7ebXe8lmiJx9BKChiyAFvi+w/zass
   6sfDdjUEIRkDanCQSCzX5cr27PQpZ30CTJX49v0jCfGHdyEwSW46ItuVP
   PHcZ/goz/7OrKBMzEteOmR+QUSmf58kUEIvCwCvkAzY32vQcTbNS//bQm
   e39YujugudrriFb+J4XYO2iqYc8GtrTISjl+VmblzX/kI8J3I1jYZvDGh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="134397672"
X-IronPort-AV: E=Sophos;i="6.07,189,1708354800"; 
   d="scan'208";a="134397672"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 16:33:17 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
	by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id E1D69E9A32;
	Tue,  9 Apr 2024 16:33:14 +0900 (JST)
Received: from m3002.s.css.fujitsu.com (msm3.b.css.fujitsu.com [10.128.233.104])
	by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 394F4D595C;
	Tue,  9 Apr 2024 16:33:14 +0900 (JST)
Received: from cxl-test.. (unknown [10.118.236.45])
	by m3002.s.css.fujitsu.com (Postfix) with ESMTP id 0D30F204E185;
	Tue,  9 Apr 2024 16:33:14 +0900 (JST)
From: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
To: kobayashi.da-06@jp.fujitsu.com,
	linux-cxl@vger.kernel.org
Cc: y-goto@fujitsu.com,
	linux-pci@vger.kernel.org,
	mj@ucw.cz,
	dan.j.williams@intel.com,
	"Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Subject: [PATCH v4 0/3] cxl: Export cxl1.1 device link status to sysfs
Date: Tue,  9 Apr 2024 16:35:25 +0900
Message-ID: <20240409073528.13214-1-kobayashi.da-06@fujitsu.com>
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
the configuration space to sysfs. Ultimately, the expectation is that this
sysfs file will be consumed by PCI user tools to utilize link status information.


Changes
v1[1] -> v2:
The following are the main changes made based on the feedback from Dan Williams.
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
[1]
https://lore.kernel.org/linux-cxl/20231220050738.178481-1-kobayashi.da-06@fujitsu.com/
[2]
https://lore.kernel.org/linux-cxl/20240227083313.87699-1-kobayashi.da-06@fujitsu.com/
[3]
https://lore.kernel.org/linux-cxl/20240312080559.14904-1-kobayashi.da-06@fujitsu.com/

Kobayashi,Daisuke (3):
  Add rcd_regs to cxl_rcrb_info
  Add rcd_regs initialization at __rcrb_to_component()
  Add sysfs attribute for CXL 1.1 device link status

 drivers/cxl/core/regs.c | 18 ++++++++++
 drivers/cxl/cxl.h       |  3 ++
 drivers/cxl/pci.c       | 74 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 95 insertions(+)

-- 
2.44.0


