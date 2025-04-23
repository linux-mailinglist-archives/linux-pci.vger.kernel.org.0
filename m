Return-Path: <linux-pci+bounces-26598-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08695A99720
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 19:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6332F4A21AB
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 17:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECFE2900A3;
	Wed, 23 Apr 2025 17:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hMy/5VOP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB02F28E61A;
	Wed, 23 Apr 2025 17:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745430657; cv=none; b=YBgRmPm5jc2+sgUzW3ILuz6PUxGv0iOkSnFzi7ot89VkUd2D/rVa1mU2HzQ2b0E+zuE1icvmCGjH8nFftBTeD5zjR/VLNIQYjdqr/jGkRmw7HN4Rwaud7kOdsdaeviF7mT0B3044+Q8Mqx8mhiC7lrQDlIejRAqaZ0HnVu7Bc7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745430657; c=relaxed/simple;
	bh=Anj1LmE3HMj4PrtjKAY91OthCI8uL5I4H5KJF+CQhR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G9eNy0Bj8AD/UwAKXZ0hHLasd9nnucGJiJGkAHb6MnEn0diV5DCEqt+M5y8ZQt54jZwYOiCzDjlrRYXKToVuMIU/laMTbFUwyCvVV2pnT7PEvm2t+G3qh5WJMgOymWD2SfBXaxN0cridGQOVRt7OrFFn32BWB9KeUjWPYpRFBoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hMy/5VOP; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745430656; x=1776966656;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Anj1LmE3HMj4PrtjKAY91OthCI8uL5I4H5KJF+CQhR0=;
  b=hMy/5VOP1AXp0XlMTP5xgapXB/aVUdKWF9zjdP/kcy0VcZ3Q0U9mJI4U
   KdA86bSU2hyw7sw9TOFXj63zlvZ0LGfP7vIGp0i6wxV/BVCFCmrjZm/Rx
   bCfO7Wi3Ae1suUIE9l/YSWECZVpT/nFz85u0BphEuUOpa8Ix7Ty6gs/Eu
   I2VxHY4O1u3JAb6jOHZ8wGfwjnAoyNqyaeWe/zt1s94pjhfxLQETQH+t4
   6L8rAtU2v1HDP58eg/HljmMsZ14lVyv8hJ6yav4tzYetnj4Ztb1l95p1w
   ADmF/wNIgfPvYfwI03JAz6+76EuPmNsinRYCCTgUPoBeqZdd/KMYynN53
   g==;
X-CSE-ConnectionGUID: EsYSrsqySUG5CWGK+PVwfg==
X-CSE-MsgGUID: 4pl+teqyTT6Iq+H6wa0gqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="47168370"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="47168370"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 10:50:53 -0700
X-CSE-ConnectionGUID: fGvrM/tlSRuTUeCqu2SAug==
X-CSE-MsgGUID: MoJ3ndr2S1KcaJAjbhCHag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="163350486"
Received: from ldmartin-desk2.corp.intel.com (HELO debox1-desk4.lan) ([10.125.111.241])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 10:50:52 -0700
From: "David E. Box" <david.e.box@linux.intel.com>
To: corbet@lwn.net,
	bhelgaas@google.com,
	kuurtb@gmail.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	vkoul@kernel.org,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	sanyog.r.kale@intel.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	david.e.box@linux.intel.com,
	dan.j.williams@intel.com,
	andriy.shevchenko@linux.intel.com
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Dell.Client.Kernel@dell.com,
	linux-sound@vger.kernel.org
Subject: [PATCH 7/7] sysfs: Remove transitional attribute group alias macros
Date: Wed, 23 Apr 2025 10:50:37 -0700
Message-ID: <20250423175040.784680-8-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250423175040.784680-1-david.e.box@linux.intel.com>
References: <20250423175040.784680-1-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Remove transitional macros used to alias named and visible sysfs attribute
group definitions. These were temporarily introduced to ease migration but
are now redundant due to the adoption of the new encapsulated
NAMED_ATTRIBUTE_* macros across all relevant drivers.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 include/linux/sysfs.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index 0804bffd6013..877fd1976668 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -220,12 +220,6 @@ struct attribute_group {
 		return a->mode;                                             \
 	}
=20
-/* Transitional aliases: so legacy code using old names continues to work =
*/
-#define DEFINE_SYSFS_GROUP_VISIBLE(name) DEFINE_SYSFS_GROUP_COMBO_VISIBILI=
TY(name)
-#define DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(name) DEFINE_SYSFS_GROUP_VISIBIL=
ITY(name)
-#define DEFINE_SYSFS_BIN_GROUP_VISIBLE(name) DEFINE_SYSFS_BIN_GROUP_COMBO_=
VISIBILITY(name)
-#define DEFINE_SIMPLE_SYSFS_BIN_GROUP_VISIBLE(name) DEFINE_SYSFS_BIN_GROUP=
_VISIBILITY(name)
-
 #define SYSFS_GROUP_VISIBLE(fn) sysfs_group_visible_##fn
=20
 /*
--=20
2.43.0


