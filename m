Return-Path: <linux-pci+bounces-4743-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44904878F63
	for <lists+linux-pci@lfdr.de>; Tue, 12 Mar 2024 09:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9855B2113B
	for <lists+linux-pci@lfdr.de>; Tue, 12 Mar 2024 08:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0924F69D11;
	Tue, 12 Mar 2024 08:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="hEOyIf2G"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A733269D00;
	Tue, 12 Mar 2024 08:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710230612; cv=none; b=ok1Wo2HQQVbX7l0meeGgJdYuF/I3qLIfJHLVqwmWQjPFltbFIkq/437m1KTx0cekQj/aYVdY6te6zVQVpSTi36xKeiGOzDoLKsX6AazzqdBGO6XVdwkDZoVaqkQd4MXzuYKFObw+wlpPrlMNqw6FBCkRcYV7EPSg0zcAKNfVjXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710230612; c=relaxed/simple;
	bh=PV7Q++jUj48L4YB7ZkJ3Y0aTwxMtWVUehKb/76qyJaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I54FBC3pOhf9YHeC1rlQgmt8jxgbpTSBsJRQJH749LGXvx4aB0D2fXvbru08zcrjzBa72G0lgXyqq5BOKflSksBX8Agk4CIkeJ6HErTDet3KspR93hMIGoBEm8k9ZbseOXnup2YLUlAWP52CnQUdedpi0nI0rXQDywindySU9lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=hEOyIf2G; arc=none smtp.client-ip=207.54.90.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710230610; x=1741766610;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PV7Q++jUj48L4YB7ZkJ3Y0aTwxMtWVUehKb/76qyJaA=;
  b=hEOyIf2Gm8/W/FGG4EY92BbNrk2Wak2kTFeGE45w2U+wMO45YEpSTmaS
   BQI4ftZ/KoMvXw8nBAlZ9pTPAjFXf8HBkpSPwoesGTs3SyVe6ofqso1jE
   coGCahpnKI663JWvdRbNf2rpk8eWAYvVxBnyt6eqNR3VTSACs6N1Hqg6B
   d36r+m606Z6dqtSoVwZl71k73cBMFN2bGaVBtKrY/2lC4ajeJAv1Xz8gs
   AUBL2BjRgloBz26dcoQOgvuttKAHEmeJ1ucOpp0Gi8g+7AmyknpopgPnR
   UePhr83h+vsZKy/DurH+ipemkdO8vbTLDdCyVlHVlCU9cv7HERICoSKzW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="131361122"
X-IronPort-AV: E=Sophos;i="6.07,118,1708354800"; 
   d="scan'208";a="131361122"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 17:03:21 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 8CFE5DD93B;
	Tue, 12 Mar 2024 17:03:19 +0900 (JST)
Received: from m3003.s.css.fujitsu.com (sqmail-3003.b.css.fujitsu.com [10.128.233.114])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id C0A2FD9941;
	Tue, 12 Mar 2024 17:03:18 +0900 (JST)
Received: from cxl-test.. (unknown [10.118.236.45])
	by m3003.s.css.fujitsu.com (Postfix) with ESMTP id 819C820059BA;
	Tue, 12 Mar 2024 17:03:18 +0900 (JST)
From: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
To: kobayashi.da-06@jp.fujitsu.com,
	linux-cxl@vger.kernel.org
Cc: y-goto@fujitsu.com,
	linux-pci@vger.kernel.org,
	mj@ucw.cz,
	dan.j.williams@intel.com,
	"Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Subject: [PATCH v3 0/3] Display cxl1.1 device link status
Date: Tue, 12 Mar 2024 17:05:56 +0900
Message-ID: <20240312080559.14904-1-kobayashi.da-06@fujitsu.com>
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

v2[2] -> v3:
- Fix unnecessary initialization and wrong types (Bjohn).
- Create a helper function for getting a PCIe capability offset (Bjohn).
- Move platform-specific implementation to the lib directory in pciutils (Martin).

[1]
https://lore.kernel.org/linux-cxl/20231220050738.178481-1-kobayashi.da-06@fujitsu.com/
[2]
https://lore.kernel.org/linux-cxl/20240227083313.87699-1-kobayashi.da-06@fujitsu.com/

Kobayashi,Daisuke (3):
  Add sysfs attribute for CXL 1.1 device link status
  Remove conditional branch that is not suitable for cxl1.1 devices

 drivers/cxl/acpi.c |   4 -
 drivers/cxl/pci.c  | 193 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 193 insertions(+), 4 deletions(-)

  Add function to display cxl1.1 device link status

 lib/access.c | 29 +++++++++++++++++++++
 lib/pci.h    |  2 ++
 ls-caps.c    | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 104 insertions(+)
-- 
2.43.0


