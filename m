Return-Path: <linux-pci+bounces-37069-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C24BA20C3
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 02:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28B041BC797A
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 00:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186AF3A1D2;
	Fri, 26 Sep 2025 00:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hy7IHfoE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D512B2DA;
	Fri, 26 Sep 2025 00:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758845989; cv=none; b=XM0c9PiyrJ1mcO5nJvs8SDbiNeEh5Qg+UqIxSpSeto175ztXYIJExxjfrnBFzg1AFv/0MABFDtjEKItVmF8ByHZp7CdZVIE0hd7f9yo7db1yIKMnWR2UfupxnL8EcvQmqTfaQdwA+aq4R2AjXbigv796M7VlEDpZcTF9OWcDisE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758845989; c=relaxed/simple;
	bh=n8M7Lv3wfpL1GX/MJgDEmNfO0OV9bNtF1FjVkjFNdY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJPF3LjwNb04ZOnZwthB0AnFtrXiqQrKdbmM57bLIPTEUN6oyDeTHqhr3CMQzaqpoyTlytDKlZUcQ1VZVUNOCewIC8gGQi07F7q2RnwLL8XUUI+Cz3CdBSsnut6Hfopclq0V+uWQEXdseKy4zNf85iScDyATOvMuKlPVmwsecis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hy7IHfoE; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758845987; x=1790381987;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n8M7Lv3wfpL1GX/MJgDEmNfO0OV9bNtF1FjVkjFNdY8=;
  b=Hy7IHfoEDTcJWcAxaek2AJDsenMl5aVNP0hr1mxVWSaLy8CQLF+GLWif
   hTjSwSRQdTFmuP/c7Zx+PGjMR8vejuVHGlpxdnMln+MOzMlg16lPrPOxt
   c4Q+B2YuzFHKO9E7jCO1G7Np+7iMaEbCnJNEPlbL1qeqbMmZRwm9nK+rp
   WQUVM94ERRUItYj7Vu4N+P/ffGxZPRG9jO6Jopdh5YSGyA0vg7PiczH56
   5iIu3iRSgilzhiaHJxgG/Yryy5SPGNOC2m24cNke71aYMS6+aywcAXCKA
   Yl4F4Y8O/ZbflpEuPJyIex+2KfNejWp3KCFkgDiwzaqQqErbpx8bLkdEt
   Q==;
X-CSE-ConnectionGUID: jnLo8pGQRQ6Lm1lMpPVoOw==
X-CSE-MsgGUID: d6yvK09UQ92VP+N2bznLCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="60875623"
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; 
   d="scan'208";a="60875623"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 17:19:46 -0700
X-CSE-ConnectionGUID: 0NCXSoKiRwKHXpULZw+g2g==
X-CSE-MsgGUID: FS9MS3pjSbmmFlKr2kBDNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; 
   d="scan'208";a="178227175"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 25 Sep 2025 17:19:40 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v1wBW-0005kL-1h;
	Fri, 26 Sep 2025 00:19:38 +0000
Date: Fri, 26 Sep 2025 08:18:55 +0800
From: kernel test robot <lkp@intel.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>, rostedt@goodmis.org,
	lukas@wunner.de, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, helgaas@kernel.org,
	ilpo.jarvinen@linux.intel.com, mattc@purestorage.com,
	Jonathan.Cameron@huawei.com
Cc: oe-kbuild-all@lists.linux.dev, bhelgaas@google.com, tony.luck@intel.com,
	bp@alien8.de, xueshuai@linux.alibaba.com, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, oleg@redhat.com, naveen@kernel.org,
	davem@davemloft.net, mark.rutland@arm.com, peterz@infradead.org,
	tianruidong@linux.alibaba.com
Subject: Re: [PATCH v11 2/3] PCI: trace: Add a RAS tracepoint to monitor link
 speed changes
Message-ID: <202509260804.F13FDt4V-lkp@intel.com>
References: <20250925061928.42758-3-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925061928.42758-3-xueshuai@linux.alibaba.com>

Hi Shuai,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/for-linus]
[also build test ERROR on trace/for-next linus/master v6.17-rc7 next-20250925]
[cannot apply to pci/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shuai-Xue/PCI-trace-Add-a-generic-RAS-tracepoint-for-hotplug-event/20250925-142250
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
patch link:    https://lore.kernel.org/r/20250925061928.42758-3-xueshuai%40linux.alibaba.com
patch subject: [PATCH v11 2/3] PCI: trace: Add a RAS tracepoint to monitor link speed changes
config: x86_64-buildonly-randconfig-006-20250926 (https://download.01.org/0day-ci/archive/20250926/202509260804.F13FDt4V-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250926/202509260804.F13FDt4V-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509260804.F13FDt4V-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: vmlinux.o: in function `trace_raw_output_pcie_link_event':
   trace.c:(.text+0x91792a): undefined reference to `pci_speed_string'
>> ld: trace.c:(.text+0x917935): undefined reference to `pci_speed_string'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

