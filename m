Return-Path: <linux-pci+bounces-20094-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC54A15B7B
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jan 2025 06:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E3693A9245
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jan 2025 05:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6B4126C18;
	Sat, 18 Jan 2025 05:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HERuR3em"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2179739FD9;
	Sat, 18 Jan 2025 05:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737177210; cv=none; b=g8HcAReC+jYCN5OvMZFh8HgiKinqFrXLfZL3igf24LuXW2oN0+9V94/TcwuTxUe348WSDXnO9PSE2ztnB6kXPne538ga0Q4KoSIJIHB+R4m7nybznmAdViZymFUE9edUR+Tmlb7Kd4bRtlG7AFrPonO9FJM+1L2EOmqyu/LfZDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737177210; c=relaxed/simple;
	bh=qrqjIdPc4T8eUdQHTfJmEtboo7rW8s3cxOidyzMOpkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVnC1ynrwoIi2OT+nSrOnhSOzv1JrXltLCdr+Ii/KI3LwOSymKaoAdQpQUAlhYY2c6PGxQOed9NIqP0YTxqkSp7Azc30ZQ1uxZFu7W1Khebrsj0ok1oRml64DVQNpYxlnbYyHsrAlYYrb/xc+v49maFApy0i0DV4Jkk/tHbL+s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HERuR3em; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737177209; x=1768713209;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qrqjIdPc4T8eUdQHTfJmEtboo7rW8s3cxOidyzMOpkI=;
  b=HERuR3emHBwCjYjyRAdAZX+lvjFX8XXOgjiI4HcI2YYYwNvoV3fnc09g
   zad/0nrK3b81+ZyDUZPQVwyA1SJ+49W9rT7yLm7lBxqwF6b5sPg8JdNHc
   c1OPT52evGW73rr4yttkXmVH1XsmOab0L+/VCQjdd8ZuShtGB7kmhZcvi
   OPSZBYZJSUHOD8fXumM+suge42o2e8cW1QVV8igr0yf1tJb2mY2SMhW9K
   oo6sWY10E0450jlGEQRXLhpBBh3dGGY6YY+4lLu6j4/oqVNk5BCS2tb1R
   4/TwqvagLGbhBFvCubOQecHPRW8vFl1pFBy9hzJ1Qr3AMTQoNDLq3QWh0
   w==;
X-CSE-ConnectionGUID: NQc5+eYcQw6Ywv86gPvYDA==
X-CSE-MsgGUID: KJxENMHiQTSnyhZNpBor8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="41548473"
X-IronPort-AV: E=Sophos;i="6.13,214,1732608000"; 
   d="scan'208";a="41548473"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 21:13:29 -0800
X-CSE-ConnectionGUID: PR2naFDUQxaDMLm0e9wFyg==
X-CSE-MsgGUID: F/8lLk9mQrSh4a+OLurkyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,214,1732608000"; 
   d="scan'208";a="136826982"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 17 Jan 2025 21:13:24 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tZ197-000U71-1f;
	Sat, 18 Jan 2025 05:13:21 +0000
Date: Sat, 18 Jan 2025 13:13:03 +0800
From: kernel test robot <lkp@intel.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>, rostedt@goodmis.org,
	lukas@wunner.de, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, helgaas@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	bhelgaas@google.com, tony.luck@intel.com, bp@alien8.de,
	xueshuai@linux.alibaba.com, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, oleg@redhat.com, naveen@kernel.org,
	davem@davemloft.net, anil.s.keshavamurthy@intel.com,
	mark.rutland@arm.com, peterz@infradead.org,
	tianruidong@linux.alibaba.com
Subject: Re: [PATCH v6] PCI: hotplug: Add a generic RAS tracepoint for
 hotplug event
Message-ID: <202501181212.7IZfQ160-lkp@intel.com>
References: <20250115013753.49126-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115013753.49126-1-xueshuai@linux.alibaba.com>

Hi Shuai,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master v6.13-rc7 next-20250117]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shuai-Xue/PCI-hotplug-Add-a-generic-RAS-tracepoint-for-hotplug-event/20250115-094016
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20250115013753.49126-1-xueshuai%40linux.alibaba.com
patch subject: [PATCH v6] PCI: hotplug: Add a generic RAS tracepoint for hotplug event
config: i386-buildonly-randconfig-004-20250116 (https://download.01.org/0day-ci/archive/20250118/202501181212.7IZfQ160-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250118/202501181212.7IZfQ160-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501181212.7IZfQ160-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <built-in>:1:
>> ./usr/include/linux/pci.h:22:10: fatal error: 'linux/tracepoint.h' file not found
      22 | #include <linux/tracepoint.h>
         |          ^~~~~~~~~~~~~~~~~~~~
   1 error generated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

