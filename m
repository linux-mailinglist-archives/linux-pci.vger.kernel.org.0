Return-Path: <linux-pci+bounces-16-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 613847F25F3
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 07:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 792C41C20818
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 06:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B5379C0;
	Tue, 21 Nov 2023 06:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S7uZ2YIm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D94112;
	Mon, 20 Nov 2023 22:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700549401; x=1732085401;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zTuF8S9vTdqe6P2IGLvWlRUqXHAtyYNpdM18PW8Zm1A=;
  b=S7uZ2YImuk73uHOuod9YbG5WNgh5W2jZ1Alq+RMhIJsIsG0HBck7a3zo
   ZrDwNmW9+p/QV4zukFxCrTg2QPyJMTNkhOzNTPpqYpLZv69pCIVXlIJgh
   p1JREkZ3ajz9fJ8noZqBGjjnW0rBIiPT3WNCg3RqSWS72UrWXkzVGnSSb
   ro+bc83DCXcs9zIBJ4rkMMuLCMV2qLbiMYr9hNsjTLR1lOo6ZGlER2shh
   MNflwx0B6DxbItg0tTWmoEF/cXEmYBT0v/efazlhQ1cdo2Qw01C2c/tuI
   77rdCE72bsVUqSGwOGI8+4Jl/XRIM7aH4TXWwBoF6RkgjQTZSdOYz2PgL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="382170567"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="382170567"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 22:50:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="14807874"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 20 Nov 2023 22:49:54 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r5KZn-0007SY-2A;
	Tue, 21 Nov 2023 06:49:45 +0000
Date: Tue, 21 Nov 2023 14:48:09 +0800
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
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/4] lib: move pci_iomap.c to drivers/pci/
Message-ID: <202311211441.4LgOiu32-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master v6.7-rc2 next-20231120]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Philipp-Stanner/lib-move-pci_iomap-c-to-drivers-pci/20231121-060258
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20231120215945.52027-3-pstanner%40redhat.com
patch subject: [PATCH 1/4] lib: move pci_iomap.c to drivers/pci/
config: arm-spear3xx_defconfig (https://download.01.org/0day-ci/archive/20231121/202311211441.4LgOiu32-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231121/202311211441.4LgOiu32-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311211441.4LgOiu32-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/iomap.c:27:15: error: redefinition of 'pci_iomap_range'
   void __iomem *pci_iomap_range(struct pci_dev *dev,
                 ^
   include/asm-generic/pci_iomap.h:44:29: note: previous definition is here
   static inline void __iomem *pci_iomap_range(struct pci_dev *dev, int bar,
                               ^
>> drivers/pci/iomap.c:43:10: error: call to undeclared function '__pci_ioport_map'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   return __pci_ioport_map(dev, start, len);
                          ^
   drivers/pci/iomap.c:43:10: note: did you mean 'devm_ioport_map'?
   include/linux/io.h:38:16: note: 'devm_ioport_map' declared here
   void __iomem * devm_ioport_map(struct device *dev, unsigned long port,
                  ^
>> drivers/pci/iomap.c:43:10: error: incompatible integer to pointer conversion returning 'int' from a function with result type 'void *' [-Wint-conversion]
                   return __pci_ioport_map(dev, start, len);
                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/iomap.c:67:15: error: redefinition of 'pci_iomap_wc_range'
   void __iomem *pci_iomap_wc_range(struct pci_dev *dev,
                 ^
   include/asm-generic/pci_iomap.h:50:29: note: previous definition is here
   static inline void __iomem *pci_iomap_wc_range(struct pci_dev *dev, int bar,
                               ^
   drivers/pci/iomap.c:110:15: error: redefinition of 'pci_iomap'
   void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long maxlen)
                 ^
   include/asm-generic/pci_iomap.h:35:29: note: previous definition is here
   static inline void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max)
                               ^
   drivers/pci/iomap.c:131:15: error: redefinition of 'pci_iomap_wc'
   void __iomem *pci_iomap_wc(struct pci_dev *dev, int bar, unsigned long maxlen)
                 ^
   include/asm-generic/pci_iomap.h:40:29: note: previous definition is here
   static inline void __iomem *pci_iomap_wc(struct pci_dev *dev, int bar, unsigned long max)
                               ^
   6 errors generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GENERIC_PCI_IOMAP
   Depends on [n]: PCI [=n]
   Selected by [y]:
   - ARM [=y]


vim +/__pci_ioport_map +43 drivers/pci/iomap.c

66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24  11  
66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24  12  /**
eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29  13   * pci_iomap_range - create a virtual mapping cookie for a PCI BAR
66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24  14   * @dev: PCI device that owns the BAR
66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24  15   * @bar: BAR number
eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29  16   * @offset: map memory at the given offset in BAR
eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29  17   * @maxlen: max length of the memory to map
66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24  18   *
66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24  19   * Using this function you will get a __iomem address to your device BAR.
66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24  20   * You can access it using ioread*() and iowrite*(). These functions hide
66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24  21   * the details if this is a MMIO or PIO address space and will just do what
66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24  22   * you expect from them in the correct way.
66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24  23   *
66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24  24   * @maxlen specifies the maximum length to map. If you want to get access to
eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29  25   * the complete BAR from offset to the end, pass %0 here.
66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24  26   * */
eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29  27  void __iomem *pci_iomap_range(struct pci_dev *dev,
eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29  28  			      int bar,
eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29  29  			      unsigned long offset,
eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29  30  			      unsigned long maxlen)
66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24  31  {
66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24  32  	resource_size_t start = pci_resource_start(dev, bar);
66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24  33  	resource_size_t len = pci_resource_len(dev, bar);
66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24  34  	unsigned long flags = pci_resource_flags(dev, bar);
66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24  35  
eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29  36  	if (len <= offset || !start)
66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24  37  		return NULL;
eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29  38  	len -= offset;
eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29  39  	start += offset;
66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24  40  	if (maxlen && len > maxlen)
66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24  41  		len = maxlen;
66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24  42  	if (flags & IORESOURCE_IO)
b923650b84068b lib/pci_iomap.c Michael S. Tsirkin 2012-01-30 @43  		return __pci_ioport_map(dev, start, len);
92b19ff50e8f24 lib/pci_iomap.c Dan Williams       2015-08-10  44  	if (flags & IORESOURCE_MEM)
66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24  45  		return ioremap(start, len);
66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24  46  	/* What? */
66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24  47  	return NULL;
66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24  48  }
eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29  49  EXPORT_SYMBOL(pci_iomap_range);
66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24  50  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

