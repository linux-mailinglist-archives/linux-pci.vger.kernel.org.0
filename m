Return-Path: <linux-pci+bounces-38122-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6ACBDC8C8
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 06:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 953553B5C8B
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 04:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EF32FF675;
	Wed, 15 Oct 2025 04:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iGTOqGbf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E922FF644;
	Wed, 15 Oct 2025 04:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760503827; cv=none; b=ARDXPixxj9zwVwsLJnc/85qRepQHfsBzVTxxxhFHGxxS0bcfaUwe/j/NWfj33YCSq1I62cmRmpyth05nSKLM83zXRgJBw6fU2Vg90ISKk6ARGeHpCB2a4RQmSlEpi2KIrdpB/u+o7Tz8DTsmU6HlM8DeZu/ofGG67DIyLuSqEbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760503827; c=relaxed/simple;
	bh=1c3Jqm3wVNb92Z5FJcsFkBXhJiXPQVjq/7phEiXgND8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZ9yIzdHHu4wv5M0WsLdfF9DzVuAjeAfclrQDrgIR1w0poKByAszVhkplde9oBv2Cnor9QtD853Wm9iKoJwZMFZ4WpRJebzSzfr9xMVjO3Xkcfk5v2PDhljjGPhCK8awIhoIdYRxhwGRopk0JNJPmJPYJAy2mlKER5OSGbhlw9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iGTOqGbf; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760503826; x=1792039826;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1c3Jqm3wVNb92Z5FJcsFkBXhJiXPQVjq/7phEiXgND8=;
  b=iGTOqGbfxBzeb6KNkXvx1W8hfK+V+Kb50jM/2qZdw+SVpKNm8hvadJys
   kvjmHm2WqDjEZP5q1lRD1RPPn/32J7/17vtJLCbgBcJBBXnwsQiWplTK8
   YSiEJ13S/JN7vpdnZnjFCgwH4iwJ2fYeatFTZZBUOWWrYle94k6lOOxpZ
   Kx+/5BaytbaGq10eCMyubBZrL7fyA+ZF2/ioA3hlD2wtTk4yLmVY7XlJc
   BGOYIricWwIKXND8VDiaJp6wV4JggRnYZr0jn/8GzOv+sftLwJwrSqrqj
   KY/xNEXxMQcTyk+bQ+uRB1crnTLxAStwemZb66CehndSnR7g0WmjY+TmP
   w==;
X-CSE-ConnectionGUID: dvfOls04RN+gLwMyihhF0Q==
X-CSE-MsgGUID: 1fFmc6DuQm2bW0cojv7HzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="62378065"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="62378065"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 21:50:25 -0700
X-CSE-ConnectionGUID: vTqsBFKDSgWS/FFl8+cgaA==
X-CSE-MsgGUID: 1H+yDRUmRGWpZov5tgERsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="181625697"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 14 Oct 2025 21:50:20 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v8tSr-0003SB-1X;
	Wed, 15 Oct 2025 04:50:17 +0000
Date: Wed, 15 Oct 2025 12:49:24 +0800
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
Subject: Re: [PATCH v12 2/3] PCI: trace: Add a RAS tracepoint to monitor link
 speed changes
Message-ID: <202510151212.ifOhr1Ak-lkp@intel.com>
References: <20251014123159.57764-3-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014123159.57764-3-xueshuai@linux.alibaba.com>

Hi Shuai,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master v6.18-rc1 next-20251014]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shuai-Xue/PCI-trace-Add-a-generic-RAS-tracepoint-for-hotplug-event/20251014-203432
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20251014123159.57764-3-xueshuai%40linux.alibaba.com
patch subject: [PATCH v12 2/3] PCI: trace: Add a RAS tracepoint to monitor link speed changes
config: sparc-randconfig-001-20251015 (https://download.01.org/0day-ci/archive/20251015/202510151212.ifOhr1Ak-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251015/202510151212.ifOhr1Ak-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510151212.ifOhr1Ak-lkp@intel.com/

All errors (new ones prefixed by >>):

   sparc64-linux-ld: drivers/pci/trace.o: in function `trace_raw_output_pcie_link_event':
   trace.c:(.text+0x1dc): undefined reference to `pci_speed_string'
>> sparc64-linux-ld: trace.c:(.text+0x1ec): undefined reference to `pci_speed_string'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

