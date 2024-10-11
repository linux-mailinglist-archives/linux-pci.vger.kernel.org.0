Return-Path: <linux-pci+bounces-14345-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3111699AABF
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 19:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B765B283F42
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 17:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84BD1BB6BB;
	Fri, 11 Oct 2024 17:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d0Fhsuji"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17327195811
	for <linux-pci@vger.kernel.org>; Fri, 11 Oct 2024 17:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728669446; cv=none; b=huPyLvexPP7DIHioJiu3rWv7uFibTV4/SqkuypeMSczU0A8H/1Iudu6veFnsw1iesLyjaoCzwWknOHVEChQrw+7cYWWtUCMf4gw7qAMuDp+B/nXcFfNrIerzqRMMP3amVfo7xV5HqRQQ/15kkuimNdwtf52Lf14SJSdhHCan3tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728669446; c=relaxed/simple;
	bh=6Wwg7wRcmCKnw61litvaGWv26gm86DrWn4uFeen2lF4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tCYjCzRZWIEsFUduHveoXkNpZg9mlO/ffvZy/+wLveveAzJY6cJTHNBLM96uwSTDzzA0F6TzzTvLywbtFqlYQqlvrBKuygO83WF83E/NaMzkODnVTYegA4ezZjkKEtyD15xKxoCeqTDJJIteUdugOvcGtECyNc+vuQ51fuRkrS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d0Fhsuji; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728669445; x=1760205445;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6Wwg7wRcmCKnw61litvaGWv26gm86DrWn4uFeen2lF4=;
  b=d0FhsujiTUF8HvR0YzPUYEPyrraVky5QCDfgKXsyA8gmugR3qolWL6ZY
   Jj9Md0WVajbqFLD7byHm9CXcq8hR9nj7HywgsaTbO/o/SulXrBoWoMu5/
   48eoFGSP3EMkE9tl81bYrbXAdM8FsZDrG50Z9wqyykJShzPf7ziwlCTp6
   eh8cRnP8U4GJWQEu00vtFv9kC46h40eq2uOtE5xZ/ygcMeHpvULX+Sg5S
   PpWhqr0RjlNc70fLO0lx+1RBGP7A5UZoBIgZSFd4uP33RRemWhTAkFJW1
   XXhaV9NNa884no59pZqCQHYWyBXlEMLuYGeoQNp606FiDnBMn4n5KQ4eF
   Q==;
X-CSE-ConnectionGUID: vWpVbI7qRfOIr2RgssCV+A==
X-CSE-MsgGUID: oK6zqz3oTvWWPe1oFWJZ7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="27524634"
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="27524634"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 10:57:21 -0700
X-CSE-ConnectionGUID: YK+F65rRQsqCcUsdFkmXxg==
X-CSE-MsgGUID: Vuckfk17TYu1ZOd37ZaJLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="76869320"
Received: from unknown (HELO localhost.ch.intel.com) ([10.2.230.45])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 10:57:20 -0700
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: <linux-pci@vger.kernel.org>,
	paul.m.stillwell.jr@intel.com
Cc: Nirmal Patel <nirmal.patel@linux.ntel.com>
Subject: [PATCH] PCI: vmd: Add DID 8086:B06F and 8086:B60B for Intel client SKU's
Date: Fri, 11 Oct 2024 10:56:57 -0700
Message-Id: <20241011175657.249948-1-nirmal.patel@linux.intel.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nirmal Patel <nirmal.patel@linux.ntel.com>

Add support for this VMD device which supports the bus restriction mode.
The feature that turns off vector 0 for MSI-X remapping is also enabled.

Signed-off-by: Nirmal Patel <nirmal.patel@linux.ntel.com>
---
 drivers/pci/controller/vmd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index a726de0af011..4429a3ca1de1 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -1111,6 +1111,10 @@ static const struct pci_device_id vmd_ids[] = {
 		.driver_data = VMD_FEATS_CLIENT,},
 	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
 		.driver_data = VMD_FEATS_CLIENT,},
+	{PCI_VDEVICE(INTEL, 0xb60b),
+                .driver_data = VMD_FEATS_CLIENT,},
+	{PCI_VDEVICE(INTEL, 0xb06f),
+                .driver_data = VMD_FEATS_CLIENT,},
 	{0,}
 };
 MODULE_DEVICE_TABLE(pci, vmd_ids);
-- 
2.39.1


