Return-Path: <linux-pci+bounces-14922-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B189A52F7
	for <lists+linux-pci@lfdr.de>; Sun, 20 Oct 2024 09:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22CB71C211FF
	for <lists+linux-pci@lfdr.de>; Sun, 20 Oct 2024 07:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC8F1754B;
	Sun, 20 Oct 2024 07:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D3LF7IVo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71450179A3
	for <linux-pci@vger.kernel.org>; Sun, 20 Oct 2024 07:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729407866; cv=none; b=tnFHNcqb/oMiHnKeu3M6Jh42tMMEbxL02+5eS8YT19mlOARGf/Qy+2wIPvFBtbfXFlDwsMt3s3f3CHWBmJKltcA6pOjl3orpJpRo4+tlsDG7ULOeHFocjqdp/U5mbWpTzBfXPii8kwbGv0nzWpdsObFjEboLYKKf0/NbVf53lOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729407866; c=relaxed/simple;
	bh=pzNJI/8qDlSaeLJMr6T4MBZi4jR1JswtTpJtLrBrlSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7ohvYNJExTR8FexnzRbsGc+jlDFPO3MVKY4cJIbklQ5D5G6U7lhW2To+oxzKKPopephImYDipZbApsZGl+LmgZX+jvu+Kdxa+ucDCpBoEee2euwNEXJz3g11ZMkwB2ylsL7XV2to4pRVSDdG3yQstEYa1Y7dlWgJX4z6g8JtLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D3LF7IVo; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729407865; x=1760943865;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pzNJI/8qDlSaeLJMr6T4MBZi4jR1JswtTpJtLrBrlSM=;
  b=D3LF7IVo8ngiqCrAnJcAnhHtBWifAHpV0MbFOThwkw5Q16VHXJnjbssa
   r6feXve3/DFBgy/XkBubbMx0vh+1ubE7fp0VJjqUW8JrQyJBMrJJGmJyY
   AARNWDUdKKcUyPr85w/w59RCFfnDbNnddVMhYHKJs9HQ/Pb+9GGVBQg7X
   t/MrB8LBGshqL56Y+kwaOqUqpyUCfYcqyYshqptACf6tsgI/tZHEVKcPX
   4wET9lE6SIMaINLA24oNYYnHZevGqB1WDbQ6YlXYG9syAJA9Nu2VpkBzP
   Q7hLqkw0nX8CgE+VL0lW8G4VZgqmQQCUCgzwB/R1KiyOcWaLrX98DPvnj
   g==;
X-CSE-ConnectionGUID: ZHsj3NlORzKXHikB2XbC0A==
X-CSE-MsgGUID: Oh4XRR3bQFufFhn6x8nKuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29016763"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29016763"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2024 00:04:25 -0700
X-CSE-ConnectionGUID: VJjJC3EYTJCnwgmpS7TpJg==
X-CSE-MsgGUID: RFbF5ww/RI6thIAus7OnxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,218,1725346800"; 
   d="scan'208";a="110071201"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 20 Oct 2024 00:04:23 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t2PzA-000Q13-2D;
	Sun, 20 Oct 2024 07:04:20 +0000
Date: Sun, 20 Oct 2024 15:04:11 +0800
From: kernel test robot <lkp@intel.com>
To: Guixin Liu <kanie@linux.alibaba.com>, bhelgaas@google.com
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: optimize proc sequential file read
Message-ID: <202410201436.9i93qAYF-lkp@intel.com>
References: <20241018054728.116519-1-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018054728.116519-1-kanie@linux.alibaba.com>

Hi Guixin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v6.12-rc3 next-20241018]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Guixin-Liu/PCI-optimize-proc-sequential-file-read/20241018-135026
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20241018054728.116519-1-kanie%40linux.alibaba.com
patch subject: [PATCH] PCI: optimize proc sequential file read
config: x86_64-randconfig-122-20241019 (https://download.01.org/0day-ci/archive/20241020/202410201436.9i93qAYF-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241020/202410201436.9i93qAYF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410201436.9i93qAYF-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/pci/proc.c:22:1: sparse: sparse: symbol 'pci_seq_tree' was not declared. Should it be static?

vim +/pci_seq_tree +22 drivers/pci/proc.c

    21	
  > 22	DEFINE_XARRAY_FLAGS(pci_seq_tree, 0);
    23	static unsigned long pci_max_idx;
    24	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

