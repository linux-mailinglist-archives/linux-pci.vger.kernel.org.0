Return-Path: <linux-pci+bounces-4087-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B89868AC9
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 09:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1B22282602
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 08:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653737A706;
	Tue, 27 Feb 2024 08:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="LVyWEkdV"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9061978B63;
	Tue, 27 Feb 2024 08:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709022717; cv=none; b=otR1IlIpIICWEqlzfpm7QXu36J0i2S3r3N7jm/7TTTALDk3BnhIg9+CNbxoc2ly7ACURSQjkNnN+amZG+HDjTG/UwpD/GOAzykH62DzFth6EpqPlfPEEsssidXtHYdWNzuLbSnzNTcTxrda8M/OfZy7iuzv8O72JdTESXLl2Fyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709022717; c=relaxed/simple;
	bh=QaU6xtLanhVm/lVZZdQ2W7V9TciWhdO0uo1lqexjJvg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JqiU14MX03ZjAadmELnjf0wXQua/wdGhnq/XEKpret+otNYdQzI3bbGa9WhfAuvhvPwo2uQfaIsloXjMuPZL/B0lzi5upPFX1vMRmD7En1uhixT3El90Yigqm6zvndJBR0Jm9bki2j/M/c/gimT/BGRNUgvLSyYAh6q1DaU6otE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=LVyWEkdV; arc=none smtp.client-ip=68.232.139.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1709022713; x=1740558713;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QaU6xtLanhVm/lVZZdQ2W7V9TciWhdO0uo1lqexjJvg=;
  b=LVyWEkdVBANfjiwN9p1oT1TcaR5UjJ3M+qw1VD1vLpCqnvcN8Aa4yEF0
   ULfxPdGphccIio3/VcAo4EUAvSxBnNnd2wRunNngBnxdBS5Gk+cZDXcvP
   PZ7L506bwYAyE8K+0IVuiNwDGcL6WgGld8BHzB6TW7jDDIrKDR7sYJw3y
   tysmcv4zvFw3iUMoM5hmOWSMBKXw9vSbqbSaeUeLHrIBQUS7Ec0JR29CM
   D5LZWCx1IcPggGITZfEubZdHJvHXyGhUftFfE8Psztn69CW6htYnpo/ox
   IGYnybWpokICZT/ZpzBwq+hkEBtYPE4WlJuV4FlxpNj20zwq/QLMTC6Qz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="152321650"
X-IronPort-AV: E=Sophos;i="6.06,187,1705330800"; 
   d="scan'208";a="152321650"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 17:30:40 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 2D104D9F01;
	Tue, 27 Feb 2024 17:30:40 +0900 (JST)
Received: from m3002.s.css.fujitsu.com (msm3.b.css.fujitsu.com [10.128.233.104])
	by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 71890CF7E5;
	Tue, 27 Feb 2024 17:30:39 +0900 (JST)
Received: from cxl-test.. (unknown [10.118.236.45])
	by m3002.s.css.fujitsu.com (Postfix) with ESMTP id 429FA20C19DC;
	Tue, 27 Feb 2024 17:30:39 +0900 (JST)
From: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
To: kobayashi.da-06@jp.fujitsu.com,
	linux-cxl@vger.kernel.org
Cc: y-goto@fujitsu.com,
	linux-pci@vger.kernel.org,
	mj@ucw.cz,
	dan.j.williams@intel.com,
	"Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Subject: [RFC PATCH v2 0/3] Display cxl1.1 device link status
Date: Tue, 27 Feb 2024 17:33:10 +0900
Message-ID: <20240227083313.87699-1-kobayashi.da-06@fujitsu.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00

Hello.

This patch series adds a feature that displays the link status
of the CXL1.1 device.

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
This patch solves these issues.

The procedure is as follows:
First, obtain the RCRB address within the cxl driver, then access 
the configuration space. Next, output the link status information from
the configuration space to sysfs. Finally, read sysfs within lspci to 
display the link status information.

Changes
v1[1] -> v2:
The following are the main changes made based on the feedback from Dan Williams.
- Modified to perform rcrb access within the CXL driver.
- Added new attributes to the sysfs of the PCI device.
- Output the link status information to the sysfs of the PCI device.
- Retrieve information from sysfs as the source when displaying information in lspci.


[1]
https://lore.kernel.org/linux-cxl/20231220050738.178481-1-kobayashi.da-06@fujitsu.com/


Kobayashi,Daisuke (3):
  Add sysfs attribute for CXL 1.1 device link status
  Removed conditional branches that are not suitable for cxl1.1 devices

 drivers/cxl/acpi.c |   4 -
 drivers/cxl/pci.c  | 206 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 206 insertions(+), 4 deletions(-)
  
  Add function to display cxl1.1 device link status

 ls-caps.c | 96 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)
-- 
2.43.0


