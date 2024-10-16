Return-Path: <linux-pci+bounces-14639-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6409A08EF
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 14:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D3F5281ED0
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 12:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A09207A03;
	Wed, 16 Oct 2024 12:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VCNTazhX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1D72071E7;
	Wed, 16 Oct 2024 12:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729080059; cv=none; b=fJJXRpvf1ObAKZyt3KVymaj3yMSTSZfpjV0PXs9loujyAelG6J3v8VgFUgbLaq+a+fv9TnaDyfcJdid3obwwZojyxwN5/YoIfT4Yfr9slMZPy18h3yE1ferJ9eweqlpjFC8Aa3d2CwW2cXeR9y/rfxPp64mHBnaI/YNHoQzH+5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729080059; c=relaxed/simple;
	bh=WxvWqUHf+WmlKFB9owh4yalNmZYY1tal6KAd5WcG/+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=FNXyG9qLP1WMy074NLg/7Cn5i7xfJxGWAt4de9AWAxI1K6dFKmIOAHLfs1wGQFLFqxyBrcQ0MuO14tzLSj8HKbwxosAtIVkxlMQG5IR3tU22OjkHu6eBm+vcSqPgDbjQPuKeYUWO++uYmNn5T0x37BAXr1ZUisgo+LLuZuxHtMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VCNTazhX; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729080058; x=1760616058;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WxvWqUHf+WmlKFB9owh4yalNmZYY1tal6KAd5WcG/+Q=;
  b=VCNTazhXJZebaN0bo/wzZbh5u46TLYD5FUgYQrpVHKEDNamRNrf5lobz
   s7rbb4uJaXvn70eOuwMyQ6yj2995Nsym5A26FutqgEwgWLYKikIprDYjZ
   J75T5qv5SVdoS0Z/XY+Wpdh/2QZX1gMHd5lkKAbOKZswuZQSkVaWBxhvc
   Hgb7j+fbgItaJFuSk+FwHqVPX3XBRZD/5F4LuJN1PaRMAErLfygraWEo7
   2JrU3vLcmxpqLc/vo7LlJZzEHhb9RzOuT84ywKbX50r85mylqAgU9M9qm
   wfsd1djYutMLpdX60Ml8dAgp8FArrYNQxSCqjsMAUELRIS3dt5fGFhPyS
   w==;
X-CSE-ConnectionGUID: SQ94f4yyRc+St+/YJayTIA==
X-CSE-MsgGUID: QVMlmLxzS3KzMftio1jRjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11226"; a="53937092"
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="53937092"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 05:00:57 -0700
X-CSE-ConnectionGUID: x5CGuv+WQbSyDt2dMEhO3A==
X-CSE-MsgGUID: P9nCAo0aQESP4VXMTYiiBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="82169798"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.221])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 05:00:55 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/1] PCI: Convert pdev_sort_resources() to use resource name helper
Date: Wed, 16 Oct 2024 15:00:48 +0300
Message-Id: <20241016120048.1355-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use pci_resource_name() helper in pdev_sort_resources() to print
resources in user-friendly format.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 23082bc0ca37..071c5436b4a5 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -134,6 +134,7 @@ static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
 	int i;
 
 	pci_dev_for_each_resource(dev, r, i) {
+		const char *r_name = pci_resource_name(dev, i);
 		struct pci_dev_resource *dev_res, *tmp;
 		resource_size_t r_align;
 		struct list_head *n;
@@ -146,8 +147,8 @@ static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
 
 		r_align = pci_resource_alignment(dev, r);
 		if (!r_align) {
-			pci_warn(dev, "BAR %d: %pR has bogus alignment\n",
-				 i, r);
+			pci_warn(dev, "%s: %pR has bogus alignment\n",
+				 r_name, r);
 			continue;
 		}
 
-- 
2.39.5


