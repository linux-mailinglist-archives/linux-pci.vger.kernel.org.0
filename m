Return-Path: <linux-pci+bounces-30468-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6540DAE582C
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 01:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A0441C26F80
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 23:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAACF230D14;
	Mon, 23 Jun 2025 23:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lTrhbHgw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB09723B607
	for <linux-pci@vger.kernel.org>; Mon, 23 Jun 2025 23:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750722590; cv=none; b=CxfKWj/yrIBy4geJKacnrahds5b8v02gx1ntAFwOX9hqSpY1myTmF3B8P3N5sA6iDqSIfDwtLBeq6r6DqfPsvLHuR+wi9DZuQgQhCXTceCE1J1r5zdYFV99u2dkT1e4rqcFYX29aQhjerFG6aEOD3AQ7RHM/kw9xrp2OIMy3bUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750722590; c=relaxed/simple;
	bh=HXdPbts+7ImFdIG5HZfoC7TudkGbNi1saASKRQAxMOo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CQoJXpT6m4sI38pXpuKiHexQ+L+gw0lfWzptSYQblQcSUj/kTGCo2cXVhTOfd7/Sr9g/wi3K/XQAJVsHinppkDW9KH91LT0eJJqV8onupSG9XXI5FT+x/qzSXDkpUU4x1+aY9uK+O7VfTsCyuOdnuC592ZMZRXicYpQ5YkI9snE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lTrhbHgw; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750722588; x=1782258588;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HXdPbts+7ImFdIG5HZfoC7TudkGbNi1saASKRQAxMOo=;
  b=lTrhbHgwOx+Hzm+ezjxZwpxOV/CfRMFwqy/htzM5RJHlmjPx07HdKymJ
   zx5Ss8uUij2zvDMs+GdNjVY6KFR55keBh7Cqar/iq5VoOnfTpZoAboLxA
   YF0gYiRJwG0W3p0ImcwUt+rTHw8HhnpRUJAP/3Ei8p77PYsnJ5Z9A7Itp
   UrncSgSbXf/lHQQmKirAVvgjhjkD4YsfU2N+EEPRElUX6EpVaOLIcAsSB
   C8dQBg3LQxSHtFbWnQ9Du4Cd5RpZoBlhQmfDAYZdy8DlXSr3IxiE8j98o
   p4emhVpAnAl/4ns0TOP4I6XZV7OfQuI2WttFI3su7rHge7ATm1Gtk/LlU
   g==;
X-CSE-ConnectionGUID: tmZcLKYrR+WRGf7MGMvE/Q==
X-CSE-MsgGUID: U49ZAr2JS9aKNiX/FBti3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="63548933"
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="63548933"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 16:49:47 -0700
X-CSE-ConnectionGUID: eFvcfaOjS7qFtBUgc/l4pg==
X-CSE-MsgGUID: bBZlJuRLRICZ/3nhxM7iJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="151896442"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 23 Jun 2025 16:49:45 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uTqv1-000RWY-2b;
	Mon, 23 Jun 2025 23:49:43 +0000
Date: Tue, 24 Jun 2025 07:49:05 +0800
From: kernel test robot <lkp@intel.com>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>,
	Frank Li <Frank.Li@nxp.com>
Subject: [pci:endpoint/epf-vntb 3/3] Warning:
 drivers/pci/endpoint/functions/pci-epf-vntb.c:695 function parameter 'bar'
 not described in 'epf_ntb_find_bar'
Message-ID: <202506240711.TJdFg8To-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint/epf-vntb
head:   a0cc6e6fd072616315147ac68a12672d5a2fa223
commit: a0cc6e6fd072616315147ac68a12672d5a2fa223 [3/3] PCI: endpoint: pci-epf-vntb: Allow BAR assignment via configfs
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20250624/202506240711.TJdFg8To-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250624/202506240711.TJdFg8To-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506240711.TJdFg8To-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/pci/endpoint/functions/pci-epf-vntb.c:695 function parameter 'bar' not described in 'epf_ntb_find_bar'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

