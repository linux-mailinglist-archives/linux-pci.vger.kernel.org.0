Return-Path: <linux-pci+bounces-37811-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF13BCD943
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 16:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DFD6E4E530F
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 14:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7812F3601;
	Fri, 10 Oct 2025 14:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ScUzQdrE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E9F3D6F;
	Fri, 10 Oct 2025 14:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760107366; cv=none; b=oyCafUXQnqd2xIqszFiib5WJruWO6HOQU5ZXusRla/iEhsHOdKMiNUjeg2O+BPm2OvzPEc7XFOV/LPqCKgVM0lByydpna2+FoCsqvdEJrhiTfInA/cYlNKzPl9b2C9dhpwsKXYXmKwldRbYeScJrdg0dUQqD/Bm06RFfsA13tEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760107366; c=relaxed/simple;
	bh=cBi1fiEOIVmQkj4I6mHqhrC4PBTYmdVJpugrfMkk5zA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=BHKTlRPDMxjek8yMiWkwy2ILiC0PKRBrmzZR6kWBHIag9xhSZkEgIPEcb6eWeXKH5p7McPhx+4mnKj8jXEWncn+/t3Nrediq7fgzm7z+gBIb10ANf1ssGiGlV/AFVr/+lHIZsq4tV9uho1rfevuztUbYC4vPwRkmIw3YsAs3FIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ScUzQdrE; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760107365; x=1791643365;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cBi1fiEOIVmQkj4I6mHqhrC4PBTYmdVJpugrfMkk5zA=;
  b=ScUzQdrEnaQVhKKdu0oLf0oixhE5xbHxO5pCny19gtkN5J6wlUbXWCY1
   R9HuY8bxf/RZsU6M88Z33OmR3bjGqB7RdPYtj8fWgVGND265ZDv0pXROd
   DXwp3bsCGNIzEy19xCGypyah51yHrCoPnEr5dtBP7em2Qmav14WX4/M+Y
   7FDO/jj7gVv/EhWVCzOV+dRSwowbOnO9ILgSi4jmySqEsqLSXxpw/K7zW
   tF5BPtxhEYOe5YattnJBmMic6WpohExrlhIwEKq/kq393oxVkLqvqYnOa
   SWdXefqPtl2BpmPpxibG0ds/dZ95Wh0Dw5U3j3mOhX4N5DtbBcdD1q5Qs
   g==;
X-CSE-ConnectionGUID: ODK13TYwT4ycOQlnRvGf/A==
X-CSE-MsgGUID: aGLZtciIRve3s8ofFCCWNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="62370357"
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; 
   d="scan'208";a="62370357"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 07:42:44 -0700
X-CSE-ConnectionGUID: XG4VPK2kTT2DGWLSZ/D56A==
X-CSE-MsgGUID: VCg+i/+DS8yUc7WNA30elA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; 
   d="scan'208";a="180573752"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.127])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 07:42:40 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/3] PCI & resource: Make coalescing host bridge windows safer
Date: Fri, 10 Oct 2025 17:42:28 +0300
Message-Id: <20251010144231.15773-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

Here's a series for Geert to test if this fixes the improper coalescing
of resources as was experienced with the pci_add_resource() change (I
know the breaking change was pulled before 6.18 main PR but I'd want to
retry it later once the known issues have been addressed). The expected
result is there'll be two adjacent host bridge resources in the
resource tree as the different name should disallow coalescing them
together, and therefore BAR0 has a window into which it belongs to.

Generic info for the series:

PCI host bridge windows were coalesced in place into one of the structs
on the resources list. The host bridge window coalescing code does not
know who holds references and still needs the struct resource it's
coalescing from/to so it is safer to perform coalescing into entirely
a new struct resource instead and leave the old resource addresses as
they were.

The checks when coalescing is allowed are also made stricter so that
only resources that have identical the metadata can be coalesced.

As a bonus, there's also a bit of framework to easily create kunit
tests for resource tree functions (beyond just resource_coalesce()).

Ilpo Järvinen (3):
  PCI: Refactor host bridge window coalescing loop to use prev
  PCI: Do not coalesce host bridge resource structs in place
  resource, kunit: add test case for resource_coalesce()

 drivers/pci/probe.c          |  26 +++----
 include/linux/ioport.h       |   5 ++
 include/linux/resource_ext.h |   3 +
 kernel/resource.c            | 139 ++++++++++++++++++++++++++++++++++-
 kernel/resource_kunit.c      | 121 ++++++++++++++++++++++++++++++
 5 files changed, 279 insertions(+), 15 deletions(-)


base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.39.5


