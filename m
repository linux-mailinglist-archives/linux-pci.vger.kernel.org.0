Return-Path: <linux-pci+bounces-18133-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2B79ECDA4
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 14:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 745882816AF
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 13:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBC9381AA;
	Wed, 11 Dec 2024 13:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QAblZNSD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728451A840C
	for <linux-pci@vger.kernel.org>; Wed, 11 Dec 2024 13:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733924931; cv=none; b=QChqh8BklXFOjhT9jPzP6ntl8H4zS2/YMc9RaQ5VJO28t1SSFEgCR/vvtpwnyM3OwydgZfTT7X78K6QfoHp6yxRsNChq8ClIlHiLYDfGMYO2qm1p04CKO6VV2PsdNnO48/peFPB058rr4QngZzTBW3+Cq4P9j9RmjgrdgXC3/vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733924931; c=relaxed/simple;
	bh=OFqjVmcR4svZ8DMCIKAwuWUtXkZFPBKvhtivo2Ibo2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=HKWAEBBvB2OQGQdM5ubJ5Jyg3wv4taOpbLmzNMD5IvUI118uN9Kny5M/lp2U8OO/ZKF+9Tbci4/Usii2dhcCh2pA1Ztqb3E+0xSNH820/bb6pUoQSUQtB180z7jXpcYQfEBHgijdtQbOyK7E5kuNbg1qXZK8dYqxvCDXuYs9nHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QAblZNSD; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733924929; x=1765460929;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OFqjVmcR4svZ8DMCIKAwuWUtXkZFPBKvhtivo2Ibo2Y=;
  b=QAblZNSDyP7RBtuz4D6IyRHE4zYevO8djZ7DNJWvx0KBdJFaajN5Ystl
   TP3cj3lulQanQKT3N07xiFZ6JPg+PrGFJ0zKcvgj7GEPdtTQ5+1EuhWGq
   D7AvumKXTouUvcxOLfuzBLR36RiOjarYD+iaEXm7VjWOCtlkckYcd3bno
   H8w1ow55f9bT6+yANrIwTgNGiCBIDWhHBVjq1qKIjkXxxWpN35dFutNOu
   1FcOupKK4uGELXSzjaivtE2l6Vwt/wcv4/U1ZLGSUYX8Gg2/EMJLVMgcU
   QbZqn/4ZMWEKgpIwnyykrCesManEm95SZFAVjoKozfRVZPVBauUfMSBgm
   w==;
X-CSE-ConnectionGUID: a8GoQSNmQ46+IK4y89OTjg==
X-CSE-MsgGUID: 7H2iAbygSheNj3Osg215Gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="37139053"
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="37139053"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 05:48:49 -0800
X-CSE-ConnectionGUID: sw/5+1jRTuqLcMVeX2+f3A==
X-CSE-MsgGUID: d/qnfwtqSuO1sF8rq8wqcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="95514084"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.214])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 05:48:46 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Martin Mares <mj@ucw.cz>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-pci@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/2] lspci: Add Flit mode information and Dev3 from gen6
Date: Wed, 11 Dec 2024 15:48:38 +0200
Message-Id: <20241211134840.3375-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add Flit mode related flags and Device 3 Extended Capability into
lspci. The latter patch does not print all the Dev 3 fields but already
feels useful for checking many things (UIO and the exit latency fields
are not printed).

Ilpo Järvinen (2):
  lspci: Add Flit Mode information
  lspci: Add Dev3 Extended Capability

 lib/header.h | 23 +++++++++++++++++++++++
 ls-caps.c    | 18 +++++++++++-------
 ls-ecaps.c   | 41 ++++++++++++++++++++++++++++++++++++++++-
 lspci.h      |  2 +-
 4 files changed, 75 insertions(+), 9 deletions(-)

-- 
2.39.5


