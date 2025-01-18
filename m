Return-Path: <linux-pci+bounces-20097-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E64A5A15E69
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jan 2025 18:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 398C33A7A03
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jan 2025 17:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36E61A0BE1;
	Sat, 18 Jan 2025 17:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IEPiUoif"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C42B126C03;
	Sat, 18 Jan 2025 17:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737222770; cv=none; b=I/KpmJT0IotgxJnbLb3jFUTA0GL5Jut8SF+IyM3wSlfisw48wN/VDc2dXKmElQliNkHHrFnLBN+QeCRTLI9i3b+UG3YqTn0FChU4GYgUdsb4EiGPWUqR+qmlSzcQr6T5iWtLSumbIL4tVNPDPuXVRLz0tMuBANXTZqz3RSUxC9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737222770; c=relaxed/simple;
	bh=MqQa2haTPDBqjkN4qsoe8jXlHi9SBeRvVhURc5EoEiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r6Of59vwMLTF8ktM+/0QG45EodXDElZx8leUTIFZabIpI/DaWILV84YEOos56qkHYq6RCbT++44Jyo2/qby502FUhX6IYhjkgeF369lCvBQMxM56I3zfMKZ3qTSVcCGT7/WT61lcZxLEpWCpRHIjfQTX3q3KCROFiphbr8SDfdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IEPiUoif; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737222770; x=1768758770;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MqQa2haTPDBqjkN4qsoe8jXlHi9SBeRvVhURc5EoEiE=;
  b=IEPiUoifK9Wz3O3C4yDqpD2h9RhUW3IazOPehqzfZ0JjllP2Cia4Jhsl
   ihZhL8JWXkYzXOi3HrJIOtIWS6mzaF4Zt1bJefnhYrB6SU4b5ZflCI0Ct
   NAdzcBk4jHdcF0sBWwyEDXQuInMRS47Zcy8qj3+AVXINVN+gyNJxwomA8
   tbos9gZNhfnxQXXWh/Va9qH8rlJa3iZAokudhdfzPQDxbwhdB9Q9hKKsM
   gYyekjYYlJm8VUjIBgMSybklIC4139TQQ4XAnbvWjYTv4cfNNnytSq4Gs
   i5nietq/nVTAviDKLg5ogsRUO8Pb4sK5hteNGaKVWC+UKmN7b81sTye6t
   Q==;
X-CSE-ConnectionGUID: /0H9JjR9R0mksIL48MNRYg==
X-CSE-MsgGUID: EGefKL58S0mu8tyyacVR2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11319"; a="41398684"
X-IronPort-AV: E=Sophos;i="6.13,215,1732608000"; 
   d="scan'208";a="41398684"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2025 09:52:49 -0800
X-CSE-ConnectionGUID: hPt2FJGlRR2pAyqTZTZbwA==
X-CSE-MsgGUID: C+71uOlhR3KzOgpmVdqw2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="111069689"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 18 Jan 2025 09:52:44 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tZCzx-000Ugh-39;
	Sat, 18 Jan 2025 17:52:41 +0000
Date: Sun, 19 Jan 2025 01:52:25 +0800
From: kernel test robot <lkp@intel.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>, rostedt@goodmis.org,
	lukas@wunner.de, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, helgaas@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, bhelgaas@google.com, tony.luck@intel.com,
	bp@alien8.de, xueshuai@linux.alibaba.com, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, oleg@redhat.com, naveen@kernel.org,
	davem@davemloft.net, anil.s.keshavamurthy@intel.com,
	mark.rutland@arm.com, peterz@infradead.org,
	tianruidong@linux.alibaba.com
Subject: Re: [PATCH v6] PCI: hotplug: Add a generic RAS tracepoint for
 hotplug event
Message-ID: <202501190108.tRReJA1Z-lkp@intel.com>
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
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20250119/202501190108.tRReJA1Z-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250119/202501190108.tRReJA1Z-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501190108.tRReJA1Z-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
>> ./usr/include/linux/pci.h:22:10: fatal error: linux/tracepoint.h: No such file or directory
      22 | #include <linux/tracepoint.h>
         |          ^~~~~~~~~~~~~~~~~~~~
   compilation terminated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

