Return-Path: <linux-pci+bounces-26591-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B1AA99707
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 19:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7806189DA00
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 17:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF88E28C5CA;
	Wed, 23 Apr 2025 17:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LVO4ExS1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11BE41C69;
	Wed, 23 Apr 2025 17:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745430652; cv=none; b=LtZkTPEc5z62Y6eg4SaYoHzaS9Mjjbf9opasq9xEop3uGwu765T17llugAZesncEPEB8UC14VmES1i8Y0VRuQ3R2DmfhUJoXBLZaogHtdDPaTKP7LzIqqpcuVtAyJA6OxduLZKsWOcSGqB0TVu4J8MzuSRPcFBZc58GbQQDUNxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745430652; c=relaxed/simple;
	bh=YHqV0/vsjdlvZq49xUct2su2HrCcfTwULHjf8E7ltpY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dROXmDyQDR2Wd6sv/JgC9zL4HP0qRXLL/RljcmJTUpKjdGLDMk8I4Sd/pcTxB638LwMb2xN/BGfGe7fpm1hwdDn5TVg1qsAm0kxqZ5klnmSRLoc0rQ4UGjLogWdIRBEKXa2HVh5uaO9St1MWmWXOTclQh+0oqtf+FlQTG7bVjSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LVO4ExS1; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745430651; x=1776966651;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YHqV0/vsjdlvZq49xUct2su2HrCcfTwULHjf8E7ltpY=;
  b=LVO4ExS1Q7RpcTje8AqhuZsT47Nt1xvo2S3Bg4qfV50HiATBgq23Ibgu
   lSuZffcg3tNeeLMSOyMt7IeL+wJH9Wc7p/M2i41QHZMVruJ6AkElUwB1C
   1ytbLqg0kOo2goJoeD/Z4m7j3TEel9uX6N8Cnx/yzc9TOJaTKFhjiAeTd
   9sdeL5XYSkr+X7XVDS5v/WoGQsTNECRafhkR7DrqXSPNkQTm/a9sDaqrR
   dT9YXlqZ18UeRxiBZ1W4C0Saz23yAWHqv0d5D4sEyS8R1f9of9w2O24yg
   aeWfxMsFMR/sb6XCgnznOpK23jC0y+4ugcXYpPJ8aJSn80Yv8mumOAg8c
   A==;
X-CSE-ConnectionGUID: 3wqbSBiUSjWqjvXlo6sU/A==
X-CSE-MsgGUID: YmIsj/G5TZW8Jvhc1QV01A==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="47168307"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="47168307"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 10:50:50 -0700
X-CSE-ConnectionGUID: CAE7ZIKpQdiQnEIAbnnH5Q==
X-CSE-MsgGUID: kDCQGA9HQaGOPbeE+lWXbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="163350453"
Received: from ldmartin-desk2.corp.intel.com (HELO debox1-desk4.lan) ([10.125.111.241])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 10:50:50 -0700
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
Subject: [PATCH 0/7] sysfs: Introduce macros for attribute groups with visibility control
Date: Wed, 23 Apr 2025 10:50:30 -0700
Message-ID: <20250423175040.784680-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The ATTRIBUTE_GROUP() helper does not support adding an .is_visible
function for visibility control. With the introduction of
SYSFS_GROUP_VISIBLE, DEFINE_SYSFS_GROUP_VISIBLE, and related macros,
attribute group definitions can now fully encapsulate visibility logic
while eliminating boilerplate code.

The following new macros are introduced:

        NAMED_ATTRIBUTE_GROUP_VISIBLE()
        NAMED_ATTRIBUTE_GROUPS_VISIBLE()
        NAMED_ATTRIBUTE_GROUP_COMBO_VISIBLE()
        NAMED_ATTRIBUTE_GROUPS_COMBO_VISIBLE()

This isn=E2=80=99t just a cleanup effort =E2=80=94 I plan to use these macr=
os in new driver
code I'm working on, and wanted to avoid having to open-code these common
visibility patterns yet again. Documenting and generalizing them now will
help avoid duplication and make future code easier to read and maintain.

These macros integrate visibility logic directly into attribute group
definitions, improving readability and maintainability. The
DEFINE[_SIMPLE_]ATTRIBUTE_GROUP_VISIBLE() macros current have four users.
Two out of them could be modified. The usbtouchscreen driver uses the @name
field which isn't supported by ATTRIBUTE_GROUPS(). But for the ones that
could be modified the diffstat was significant:

 drivers/pci/doe.c                              |  2 +-
 drivers/platform/x86/dell/alienware-wmi-base.c | 23 +++++++++--------------
 drivers/platform/x86/dell/alienware-wmi-wmax.c |  7 ++++---
 drivers/soundwire/sysfs_slave.c                | 32 +++++++++++++---------=
----------
 4 files changed, 27 insertions(+), 37 deletions(-)

David E. Box (7):
  sysfs: Rename attribute group visibility macros
  sysfs: Introduce macros to simplify creation of visible attribute
    groups
  docs: sysfs.rst: document additional attribute group macros
  pci: doe: Replace sysfs visibility macro
  soundwire: sysfs: Use ATTRIBUTE_GROUP_VISIBLE()
  platform/x86/dell: alienware-wmi: update sysfs visibility macros
  sysfs: Remove transitional attribute group alias macros

 Documentation/filesystems/sysfs.rst           | 244 ++++++++++++++++++
 drivers/pci/doe.c                             |   2 +-
 .../platform/x86/dell/alienware-wmi-base.c    |  23 +-
 .../platform/x86/dell/alienware-wmi-wmax.c    |   7 +-
 drivers/soundwire/sysfs_slave.c               |  32 +--
 include/linux/sysfs.h                         |  46 +++-
 6 files changed, 306 insertions(+), 48 deletions(-)


base-commit: 9c32cda43eb78f78c73aee4aa344b777714e259b
--=20
2.43.0


