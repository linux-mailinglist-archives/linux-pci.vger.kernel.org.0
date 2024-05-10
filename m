Return-Path: <linux-pci+bounces-7323-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4808C1F07
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 09:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15E8D282519
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 07:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF0A15ECD5;
	Fri, 10 May 2024 07:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="QHB37+kq"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFFA20309;
	Fri, 10 May 2024 07:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715326558; cv=none; b=mBEkoG7JyITk3QiP6A1b3wourwyBsQucsuvAVFrP0ni4wxs52kl3ixMgrWVlSkriWdCliPm43jgh/mNuCDEsxIqRxfMs8Up1b5WYEgczPGC78f/hcyTfJIHVnfzNCjIiM2dI7iWMZ8NvIF12EW3NXI3Opv9EQOH4rF537mwfGJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715326558; c=relaxed/simple;
	bh=fqWHT0Wog6+HUayUTc3LSh9/i2Z4J4C5vCkjSNN4x9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VBx/Oaed7ex2EzIdjJCNI4/ksSFJVvI0NVv+7aM00DIBD5rkT6PCd056g/t9QZj28igURSULLmP92nrkHFWhz1rB2z0A+Q9q3CxwIlpR2BO3xS/0oKoCgGq4U8jvA9yBePI+osdkRyhaxooOaYUcCSaTS+Bz8OY1TxLYsVHbT68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=QHB37+kq; arc=none smtp.client-ip=139.138.36.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1715326555; x=1746862555;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fqWHT0Wog6+HUayUTc3LSh9/i2Z4J4C5vCkjSNN4x9c=;
  b=QHB37+kq05+mAMiOsp3988TLLS2IKw4NB2jJFfm//WH9KoEjBQ+eyNm4
   dlTHMa1FNDC8Y08uHTiYJcki53YYnIE9sBrMtEgdzaAhqLAC1hRNQHv73
   aKQ+G9FjdMqSECwvQHnhxvpzuhmeEgFmjLqiQuL3iRkefPhwcB1MunF0M
   OBqBJDgTV13dFxaiRao2fROPDPzBndTOeXeIAF3pV8zGe5KenK0MZ5FzC
   dnP0H1zGydO3NYig+w0yNmYVLxoYhBy2i5UYa+80v4B/n1nb6VFNXnqQO
   Yh/Aemn5VSzSuIJgREk5j9mK4uNlkf0y3Fq3xUgztnp06wvOt0sk5qY8b
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="146347935"
X-IronPort-AV: E=Sophos;i="6.08,150,1712588400"; 
   d="scan'208";a="146347935"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 16:34:43 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 081E0D6F00;
	Fri, 10 May 2024 16:34:42 +0900 (JST)
Received: from m3002.s.css.fujitsu.com (msm3.b.css.fujitsu.com [10.128.233.104])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 49725EA0A7;
	Fri, 10 May 2024 16:34:41 +0900 (JST)
Received: from cxl-test.. (unknown [10.118.236.45])
	by m3002.s.css.fujitsu.com (Postfix) with ESMTP id 206BB204F435;
	Fri, 10 May 2024 16:34:41 +0900 (JST)
From: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
To: kobayashi.da-06@jp.fujitsu.com,
	linux-cxl@vger.kernel.org
Cc: y-goto@fujitsu.com,
	linux-pci@vger.kernel.org,
	mj@ucw.cz,
	dan.j.williams@intel.com,
	"Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Subject: [PATCH v7 0/2] cxl: Export cxl1.1 device link status to sysfs
Date: Fri, 10 May 2024 16:37:08 +0900
Message-ID: <20240510073710.98953-1-kobayashi.da-06@fujitsu.com>
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

v6[6] -> v7:
- Fix comments on white space inline

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
[6]
https://lore.kernel.org/linux-cxl/20240424050102.26788-1-kobayashi.da-06@fujitsu.com/

Kobayashi,Daisuke (2):
  cxl: Add rcd_regs to cxl_rcrb_info
  cxl/pci: Add sysfs attribute for CXL 1.1 device link statu

 drivers/cxl/core/core.h |   4 ++
 drivers/cxl/core/regs.c |  16 +++++++
 drivers/cxl/cxl.h       |   3 ++
 drivers/cxl/pci.c       | 101 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 124 insertions(+)

-- 
2.44.0


