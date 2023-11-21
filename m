Return-Path: <linux-pci+bounces-31-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B5A7F2AE8
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 11:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DA0D28195D
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 10:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CFD47791;
	Tue, 21 Nov 2023 10:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N0yWFk90"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98BDC1;
	Tue, 21 Nov 2023 02:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700563505; x=1732099505;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l+a71bvgEh/TboifQfXVauuzp5BKzhlFcNngQXU+KhQ=;
  b=N0yWFk90pG4vwpdHgNxHDoWaX4P9yIjNgcqqmAttZFsXcsyhLPfpkDDd
   C1dgV6ZI/X4gsC43xXXh7bMUUNdDVqA9Ab8+d9dv2WPpuF4nZozte0EZM
   pKPW9G5jQ3CNGzUVQ8IDQw9bspWtJZiO+TqDqfhEampw1DxbS4+h4ZSfW
   P3gGrBi7sSF4874E1tiri20iku7oziGZgEx/3HFD0V8G6NBcQAkQXUo+Y
   23icPG9MZ7U6uYWDlYaQa/E3eTsq6pjNBKfTSXm/HFye/fidExIONuOaF
   bNo8HVsQ2JsU8DoFnuRJVZqCyiEXOS36T4u5iyqM0BfDbgcG8dVS+K1WE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="13356770"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="13356770"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 02:45:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="857288861"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="857288861"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Nov 2023 02:44:57 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r5OFM-0007hR-2t;
	Tue, 21 Nov 2023 10:44:51 +0000
Date: Tue, 21 Nov 2023 18:44:12 +0800
From: kernel test robot <lkp@intel.com>
To: Philipp Stanner <pstanner@redhat.com>,
	Bjorn Helgaas <helgaas@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Eric Auger <eric.auger@redhat.com>,
	Kent Overstreet <kmo@daterainc.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>, NeilBrown <neilb@suse.de>,
	John Sanpe <sanpeqf@gmail.com>, Dave Jiang <dave.jiang@intel.com>,
	Yury Norov <yury.norov@gmail.com>,
	Kees Cook <keescook@chromium.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	David Gow <davidgow@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Thomas Gleixner <tglx@linutronix.de>,
	"wuqiang.matt" <wuqiang.matt@bytedance.com>,
	Jason Baron <jbaron@akamai.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Danilo Krummrich <dakr@redhat.com>
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/4] lib: move pci_iomap.c to drivers/pci/
Message-ID: <202311211816.wS7kAE5o-lkp@intel.com>
References: <20231120215945.52027-3-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120215945.52027-3-pstanner@redhat.com>

Hi Philipp,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v6.7-rc2 next-20231121]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Philipp-Stanner/lib-move-pci_iomap-c-to-drivers-pci/20231121-060258
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20231120215945.52027-3-pstanner%40redhat.com
patch subject: [PATCH 1/4] lib: move pci_iomap.c to drivers/pci/
config: arm-kismet-CONFIG_GENERIC_PCI_IOMAP-CONFIG_ARM-0-0 (https://download.01.org/0day-ci/archive/20231121/202311211816.wS7kAE5o-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20231121/202311211816.wS7kAE5o-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311211816.wS7kAE5o-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for GENERIC_PCI_IOMAP when selected by ARM
   
   WARNING: unmet direct dependencies detected for GENERIC_PCI_IOMAP
     Depends on [n]: PCI [=n]
     Selected by [y]:
     - ARM [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

