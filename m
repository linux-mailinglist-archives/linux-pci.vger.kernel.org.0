Return-Path: <linux-pci+bounces-17982-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1149EA70E
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 05:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93D5B1692E6
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 04:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF3C13635E;
	Tue, 10 Dec 2024 04:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="dx5ULuXq"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D2B41C6C
	for <linux-pci@vger.kernel.org>; Tue, 10 Dec 2024 04:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733803796; cv=none; b=utmO1dY3e24AuhlCXId6aVbvmwM++whSwY16VTIW0LfxpOKQARCrfg1PrB8xxE9DzdvGK1QJU2qvqfvyVDhatSOZSgWwW0JbJWMHViubNNkI3dChO4XGgILtcFtrm0VvnLdeJFghvuK/M5R3NCSCWosRHuN4L7l8FrjAWe4JLrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733803796; c=relaxed/simple;
	bh=OH2+qxgrSBbJ/Wl01oTSt6xcOc/nwsNamk8N8o0mTNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GDKFWBqA8He5mpXwnuMBK4v0YdjUY+/U0c3wdrtBJTol2kp24XLRr9t3/OTiw8DxWS3U6RAkYRaGMo/3/qVqZrjoZWNBvVDxPowB4ecKfcgdkuzjtak5pY1Kd1bfPrvt8osnsFuyIQoPRW54PczsNtc5khjN0MGNem0p1RTtJ/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=dx5ULuXq; arc=none smtp.client-ip=207.54.90.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1733803796; x=1765339796;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OH2+qxgrSBbJ/Wl01oTSt6xcOc/nwsNamk8N8o0mTNg=;
  b=dx5ULuXqdnRRoMJAAdzNHdE7RE28kruTEqgJoMK7vL3qe1ms/D0MIHMw
   VjgVrUIymTLUz6wQvH2ImcRtbpk2MOaXBwi/KKdm2ca9tEau6FoVThMTf
   QKiPgzspRux8sA/wOxstxoU9Fk84OYTQe4I4Wt7LRxgkVmlbOf/CAucfv
   umbfroQ0V7cAtr2yG/ovYBVxAj2PkSgyuRIW6csVI8TmZDlCx9eCJXESl
   xYRInPr9mDIcjrJa41D00/EMxPk4QsRHN3vZ5Fs02Ib8agKU9QSiHd4ND
   Qr+tar8jnbAtgxcksbvbrvquprocidX65RR8ZrLpp7CWFTsEXv5nehY0g
   g==;
X-CSE-ConnectionGUID: o/YUUPXcR4mi10zMtIrddA==
X-CSE-MsgGUID: pgR7SSmYTaKE/6wcE//fHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="162635111"
X-IronPort-AV: E=Sophos;i="6.12,221,1728918000"; 
   d="scan'208";a="162635111"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 13:08:44 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
	by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id BF3ADC2267
	for <linux-pci@vger.kernel.org>; Tue, 10 Dec 2024 13:08:41 +0900 (JST)
Received: from m3002.s.css.fujitsu.com (msm3.b.css.fujitsu.com [10.128.233.104])
	by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 8E349D5B2D
	for <linux-pci@vger.kernel.org>; Tue, 10 Dec 2024 13:08:41 +0900 (JST)
Received: from cxl-test.. (unknown [10.118.236.45])
	by m3002.s.css.fujitsu.com (Postfix) with ESMTP id 56BBE204C0B5;
	Tue, 10 Dec 2024 13:08:41 +0900 (JST)
From: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
To: kobayashi.da-06@jp.fujitsu.com,
	kw@linux.com,
	linux-pci@vger.kernel.org
Cc: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Subject: [PATCH v5 0/2] Export PBEC Data register into sysfs
Date: Tue, 10 Dec 2024 13:08:19 +0900
Message-ID: <20241210040826.11402-1-kobayashi.da-06@fujitsu.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This proposal aims to add a feature that outputs PCIe device power 
consumption information to sysfs.

Add support for PBEC (Power Budgeting Extended Capability) output 
to the PCIe driver. PBEC is defined in the 
PCIe specification(PCIe r6.0, sec 7.8.1) and is
a standard method for obtaining device power consumption information.

PCIe devices can significantly impact the overall power consumption of
a system. However, obtaining PCIe device power consumption information 
has traditionally been difficult. 

The PBEC Data register changes depending on the value of the PBEC Data 
Select register. To obtain all PBEC Data register values defined in the 
device, obtain the value of the PBEC Data register while changing the 
value of the PBEC Data Select register.

Changes:
v4->v5
https://lore.kernel.org/linux-pci/20240911012053.345286-1-kobayashi.da-06@fujitsu.com/
- All register values were output to a single file. Now, a dedicated directory
 is created, and individual values are output to separate files within this directory.
- Multiple helper functions are added to handle the output of individual register
 values to their respective files.

Kobayashi,Daisuke (2):
  Add helper functions for Power Budgeting Extended Capability.
  Export Power Budgeting Extended Capability into pci-bus-sysfs

 Documentation/ABI/testing/sysfs-bus-pci |  62 ++++++++
 drivers/pci/pci-sysfs.c                 | 179 ++++++++++++++++++++++++
 drivers/pci/pci.h                       |   3 +
 drivers/pci/probe.c                     |  66 +++++++++
 include/uapi/linux/pci_regs.h           |   3 +-
 5 files changed, 312 insertions(+), 1 deletion(-)

-- 
2.45.0


