Return-Path: <linux-pci+bounces-6168-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAF58A279D
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 09:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C75C1C20C9F
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 07:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF94545976;
	Fri, 12 Apr 2024 07:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="PVKy9dli"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6464E535D9;
	Fri, 12 Apr 2024 07:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.37.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712905559; cv=none; b=lF8MOSCUQyE+XssY9JlWcXbYXlKWq16xTE2D7aK49EoPL3HUy3sp0loQkyldXAllpPtjhNt5V8EpApHsMzkJx0oFclcDQI5t0O/vLm0VcyWCVth0u0ikAUKoyQTvckYaWFaDeh3dKzHEFU1LxS5ubwBAMjp4dUJa2DOy9yJPTAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712905559; c=relaxed/simple;
	bh=MuwZ4QGBj00cHFsWkfe7gM7AReZ7jIo+a4s+rimS/vo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mD5aKSWFhpFOTwdRdp6lADkD2hraJ/5p07WImKjitKh/rzYWUB+PdyxqQt05OQg8MT61GSZCihPBHGgu0ehVVzlz8jiaQyESzwua3NIPZp1X2mBRcNI6hC1eOUiSV5JDXYXzhYc900rL0vWGbnn3x5fmISdBczX6+lSEw+xxqlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=PVKy9dli; arc=none smtp.client-ip=139.138.37.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1712905556; x=1744441556;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MuwZ4QGBj00cHFsWkfe7gM7AReZ7jIo+a4s+rimS/vo=;
  b=PVKy9dli9NxSnSDy1HYk4wAAQs1o45v2BREOduhiLVqhlAoRlo+HzUty
   v4TcEpeg+fin0+jfCv/Iwi8ecra+Mi5UNonrLhCRnWSAowOkGjTWlzfuG
   l4pOaEFe9t8b2OSfvJtXR2XF5G5Wlibcl8K29axqRG/OAVLoToVh6FG+U
   jzVoAEn1/so9BMK/6A9tw1wyWpEUvZWVbPM6jsUt0igWngWCQFPYmD06V
   tE/RT8SDDM0vkwfDhMFxIXlOp02tpuZp6Vj6yEX1Kcf25xscOTNeSOFSN
   L5Wn65gJ1EosDvBZV0hV5jonMq+yQNHBWW4HKm4BswmOYs44TL8KddaFw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="134678094"
X-IronPort-AV: E=Sophos;i="6.07,195,1708354800"; 
   d="scan'208";a="134678094"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 16:04:43 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 62DEAE8547;
	Fri, 12 Apr 2024 16:04:41 +0900 (JST)
Received: from m3002.s.css.fujitsu.com (msm3.b.css.fujitsu.com [10.128.233.104])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id AC21C16647;
	Fri, 12 Apr 2024 16:04:40 +0900 (JST)
Received: from cxl-test.. (unknown [10.118.236.45])
	by m3002.s.css.fujitsu.com (Postfix) with ESMTP id 834C9209C7C0;
	Fri, 12 Apr 2024 16:04:40 +0900 (JST)
From: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
To: kobayashi.da-06@jp.fujitsu.com,
	linux-cxl@vger.kernel.org
Cc: y-goto@fujitsu.com,
	linux-pci@vger.kernel.org,
	mj@ucw.cz,
	dan.j.williams@intel.com,
	"Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Subject: [PATCH v5 0/2] cxl: Export cxl1.1 device link status to sysfs
Date: Fri, 12 Apr 2024 16:07:13 +0900
Message-ID: <20240412070715.16160-1-kobayashi.da-06@fujitsu.com>
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

[1]
https://lore.kernel.org/linux-cxl/20231220050738.178481-1-kobayashi.da-06@fujitsu.com/
[2]
https://lore.kernel.org/linux-cxl/20240227083313.87699-1-kobayashi.da-06@fujitsu.com/
[3]
https://lore.kernel.org/linux-cxl/20240312080559.14904-1-kobayashi.da-06@fujitsu.com/
[4]
https://lore.kernel.org/linux-cxl/20240409073528.13214-1-kobayashi.da-06@fujitsu.com/

Kobayashi,Daisuke (2):
  cxl: Add rcd_regs to cxl_rcrb_info
  cxl/pci: Add sysfs attribute for CXL 1.1 device link status

 drivers/cxl/core/regs.c | 16 +++++++
 drivers/cxl/cxl.h       |  3 ++
 drivers/cxl/pci.c       | 98 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 117 insertions(+)

-- 
2.44.0


