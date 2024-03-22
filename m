Return-Path: <linux-pci+bounces-4993-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F858886C47
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 13:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 818701C22E39
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 12:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E106D41A89;
	Fri, 22 Mar 2024 12:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WUAtNIwr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEE73FB85;
	Fri, 22 Mar 2024 12:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711111206; cv=none; b=FeXLDHLKYwcwjvA//kUhUeSKEWq8Htxco87+PX5P+S9vUZt36Ep66I3hHfnaLBFLHpGiQbgCDpaZnrBzuse8CTEmDI36DO3Qt+WS/ud69dEt/RZrqu0T8kapX4aqy141QuB+AUtCuiFQZQKouIDVH/ZNyQajC7bglcfjTa+c9mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711111206; c=relaxed/simple;
	bh=Hy4SU5KZcj+l3b/echBs5Y8AMqDERIxFa5T1chgNL3M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ZGSEmiIRPqfuPRv3k+4YDKmHKwCwVGHqoNiBWkwnjKSbcQHgvAIDCC+eNUCmnvDuF5h6W+ivOtlg3UFV2xeW20OD7xJGMdda0R1Jaqr8UqVEjjYkpGLsSip+KeTP02w7XEobIqZp9FGtD0AfXjv8UrzUoFO9k6K1Tnf+n/VP4Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WUAtNIwr; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711111205; x=1742647205;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Hy4SU5KZcj+l3b/echBs5Y8AMqDERIxFa5T1chgNL3M=;
  b=WUAtNIwrBY9BV7Uzixop2cjU17z6pO5yMjnc5rL5BXmGyNNdNbuV3DfY
   7HSiDOqVEUPCTZC8poluTHkwsNXkRIOhxZHOQKvSdjTEiFIHwBsxxcZfA
   6F42tlfdTNczGZaNl81xr042UxVbRWdyw1UTy4NEss0KCZRgrJWKy855I
   reHzFpqoU4LJAjU8A0RGfjkNinjhb2px/HWyjxsYc4nlAV1Y4kwO1h5sw
   RAWxngUhNGUu7UDvHwD1AR/X3JUFoQcugt/DIMjGa0bjZfg78E+tA4V9S
   tnsLE0a0h8m0brceq6n8KYKH0PCanS+aatp69tKLBOVGHzWmP+NAMkJWv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="9919021"
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="9919021"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 05:40:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="45895412"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.18])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 05:40:02 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/2] PCI/ASPM: Define consolidation
Date: Fri, 22 Mar 2024 14:39:50 +0200
Message-Id: <20240322123952.6384-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series consolidates ASPM related defines into the ones in
linux/pci.h and eliminates the almost duplicate ones from aspm.c. This
allows using the input without mapping between the defines so the state
mapping code to focus on the special cases.

Ilpo Järvinen (2):
  PCI/ASPM: Consolidate link state defines
  PCI/ASPM: Cleanup ASPM disable/enable mask calculation

 drivers/pci/pcie/aspm.c | 180 ++++++++++++++++++++--------------------
 include/linux/pci.h     |  22 ++---
 2 files changed, 100 insertions(+), 102 deletions(-)

-- 
2.39.2


