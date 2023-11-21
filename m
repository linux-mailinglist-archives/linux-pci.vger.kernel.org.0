Return-Path: <linux-pci+bounces-14-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6460D7F24CE
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 05:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1468C2822B8
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 04:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A781182AE;
	Tue, 21 Nov 2023 04:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MUnNDx8i"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A22D9;
	Mon, 20 Nov 2023 20:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700540462; x=1732076462;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HeOnsAotLtBAwdDsWn9Pxx0cziA4oaRFyuEBXtVa+Ow=;
  b=MUnNDx8iciTzpkAczlRyEkOcsg56YxxQ0zKdz3qvreiyM62LuqZt2aVK
   Quawu8rm+f0BqznccM5H8N+iIkOskyeHv5zAYIgkmFhEHYjP8+d/bdnAt
   wQdZBOhZYBvl2bjNSFY5Cps9Hro6Fk3iVBxYzmp0vQD0QAPLntllfkWja
   r4rWsbucf9gTjK1/sUP3YJ6Xixrrmb1sRkW9vnyHvUcbCwNbcAXG56r+0
   aPro9HJfjLHQN6sYr6ocdD1nQlYQ6sAbgeDgl+Uy8ehbERUZe8OCDn2Wf
   gXuHWvRGZM3KmCRpwlbNL1dzP/rK8NapgUWFOW6Tpj3QfTS06YQbXK8x+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="395690888"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="395690888"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 20:21:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="14376311"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 20 Nov 2023 20:20:31 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r5IFQ-0007Hu-2N;
	Tue, 21 Nov 2023 04:20:28 +0000
Date: Tue, 21 Nov 2023 12:20:11 +0800
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
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/4] lib: move pci_iomap.c to drivers/pci/
Message-ID: <202311211216.KqPYvOCI-lkp@intel.com>
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
config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20231121/202311211216.KqPYvOCI-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231121/202311211216.KqPYvOCI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311211216.KqPYvOCI-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/pci/iomap.c:27:15: error: redefinition of 'pci_iomap_range'
      27 | void __iomem *pci_iomap_range(struct pci_dev *dev,
         |               ^~~~~~~~~~~~~~~
   In file included from include/asm-generic/io.h:20,
                    from arch/openrisc/include/asm/io.h:37,
                    from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from include/asm-generic/hardirq.h:17,
                    from ./arch/openrisc/include/generated/asm/hardirq.h:1,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/pci.h:38,
                    from drivers/pci/iomap.c:7:
   include/asm-generic/pci_iomap.h:44:29: note: previous definition of 'pci_iomap_range' with type 'void *(struct pci_dev *, int,  long unsigned int,  long unsigned int)'
      44 | static inline void __iomem *pci_iomap_range(struct pci_dev *dev, int bar,
         |                             ^~~~~~~~~~~~~~~
   drivers/pci/iomap.c: In function 'pci_iomap_range':
>> drivers/pci/iomap.c:43:24: error: implicit declaration of function '__pci_ioport_map'; did you mean 'devm_ioport_map'? [-Werror=implicit-function-declaration]
      43 |                 return __pci_ioport_map(dev, start, len);
         |                        ^~~~~~~~~~~~~~~~
         |                        devm_ioport_map
>> drivers/pci/iomap.c:43:24: warning: returning 'int' from a function with return type 'void *' makes pointer from integer without a cast [-Wint-conversion]
      43 |                 return __pci_ioport_map(dev, start, len);
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/iomap.c: At top level:
>> drivers/pci/iomap.c:67:15: error: redefinition of 'pci_iomap_wc_range'
      67 | void __iomem *pci_iomap_wc_range(struct pci_dev *dev,
         |               ^~~~~~~~~~~~~~~~~~
   include/asm-generic/pci_iomap.h:50:29: note: previous definition of 'pci_iomap_wc_range' with type 'void *(struct pci_dev *, int,  long unsigned int,  long unsigned int)'
      50 | static inline void __iomem *pci_iomap_wc_range(struct pci_dev *dev, int bar,
         |                             ^~~~~~~~~~~~~~~~~~
>> drivers/pci/iomap.c:110:15: error: redefinition of 'pci_iomap'
     110 | void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long maxlen)
         |               ^~~~~~~~~
   include/asm-generic/pci_iomap.h:35:29: note: previous definition of 'pci_iomap' with type 'void *(struct pci_dev *, int,  long unsigned int)'
      35 | static inline void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max)
         |                             ^~~~~~~~~
>> drivers/pci/iomap.c:131:15: error: redefinition of 'pci_iomap_wc'
     131 | void __iomem *pci_iomap_wc(struct pci_dev *dev, int bar, unsigned long maxlen)
         |               ^~~~~~~~~~~~
   include/asm-generic/pci_iomap.h:40:29: note: previous definition of 'pci_iomap_wc' with type 'void *(struct pci_dev *, int,  long unsigned int)'
      40 | static inline void __iomem *pci_iomap_wc(struct pci_dev *dev, int bar, unsigned long max)
         |                             ^~~~~~~~~~~~
>> drivers/pci/iomap.c:164:6: error: redefinition of 'pci_iounmap'
     164 | void pci_iounmap(struct pci_dev *dev, void __iomem *p)
         |      ^~~~~~~~~~~
   include/asm-generic/pci_iomap.h:56:20: note: previous definition of 'pci_iounmap' with type 'void(struct pci_dev *, void *)'
      56 | static inline void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
         |                    ^~~~~~~~~~~
   cc1: some warnings being treated as errors

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GENERIC_PCI_IOMAP
   Depends on [n]: PCI [=n]
   Selected by [y]:
   - OPENRISC [=y]


vim +/pci_iomap_range +27 drivers/pci/iomap.c

66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24   11  
66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24   12  /**
eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29   13   * pci_iomap_range - create a virtual mapping cookie for a PCI BAR
66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24   14   * @dev: PCI device that owns the BAR
66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24   15   * @bar: BAR number
eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29   16   * @offset: map memory at the given offset in BAR
eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29   17   * @maxlen: max length of the memory to map
66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24   18   *
66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24   19   * Using this function you will get a __iomem address to your device BAR.
66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24   20   * You can access it using ioread*() and iowrite*(). These functions hide
66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24   21   * the details if this is a MMIO or PIO address space and will just do what
66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24   22   * you expect from them in the correct way.
66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24   23   *
66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24   24   * @maxlen specifies the maximum length to map. If you want to get access to
eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29   25   * the complete BAR from offset to the end, pass %0 here.
66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24   26   * */
eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29  @27  void __iomem *pci_iomap_range(struct pci_dev *dev,
eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29   28  			      int bar,
eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29   29  			      unsigned long offset,
eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29   30  			      unsigned long maxlen)
66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24   31  {
66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24   32  	resource_size_t start = pci_resource_start(dev, bar);
66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24   33  	resource_size_t len = pci_resource_len(dev, bar);
66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24   34  	unsigned long flags = pci_resource_flags(dev, bar);
66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24   35  
eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29   36  	if (len <= offset || !start)
66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24   37  		return NULL;
eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29   38  	len -= offset;
eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29   39  	start += offset;
66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24   40  	if (maxlen && len > maxlen)
66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24   41  		len = maxlen;
66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24   42  	if (flags & IORESOURCE_IO)
b923650b84068b lib/pci_iomap.c Michael S. Tsirkin 2012-01-30  @43  		return __pci_ioport_map(dev, start, len);
92b19ff50e8f24 lib/pci_iomap.c Dan Williams       2015-08-10   44  	if (flags & IORESOURCE_MEM)
66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24   45  		return ioremap(start, len);
66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24   46  	/* What? */
66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24   47  	return NULL;
66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24   48  }
eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29   49  EXPORT_SYMBOL(pci_iomap_range);
66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24   50  
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24   51  /**
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24   52   * pci_iomap_wc_range - create a virtual WC mapping cookie for a PCI BAR
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24   53   * @dev: PCI device that owns the BAR
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24   54   * @bar: BAR number
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24   55   * @offset: map memory at the given offset in BAR
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24   56   * @maxlen: max length of the memory to map
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24   57   *
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24   58   * Using this function you will get a __iomem address to your device BAR.
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24   59   * You can access it using ioread*() and iowrite*(). These functions hide
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24   60   * the details if this is a MMIO or PIO address space and will just do what
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24   61   * you expect from them in the correct way. When possible write combining
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24   62   * is used.
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24   63   *
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24   64   * @maxlen specifies the maximum length to map. If you want to get access to
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24   65   * the complete BAR from offset to the end, pass %0 here.
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24   66   * */
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24  @67  void __iomem *pci_iomap_wc_range(struct pci_dev *dev,
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24   68  				 int bar,
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24   69  				 unsigned long offset,
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24   70  				 unsigned long maxlen)
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24   71  {
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24   72  	resource_size_t start = pci_resource_start(dev, bar);
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24   73  	resource_size_t len = pci_resource_len(dev, bar);
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24   74  	unsigned long flags = pci_resource_flags(dev, bar);
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24   75  
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24   76  
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24   77  	if (flags & IORESOURCE_IO)
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24   78  		return NULL;
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24   79  
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24   80  	if (len <= offset || !start)
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24   81  		return NULL;
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24   82  
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24   83  	len -= offset;
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24   84  	start += offset;
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24   85  	if (maxlen && len > maxlen)
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24   86  		len = maxlen;
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24   87  
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24   88  	if (flags & IORESOURCE_MEM)
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24   89  		return ioremap_wc(start, len);
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24   90  
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24   91  	/* What? */
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24   92  	return NULL;
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24   93  }
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24   94  EXPORT_SYMBOL_GPL(pci_iomap_wc_range);
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24   95  
eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29   96  /**
eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29   97   * pci_iomap - create a virtual mapping cookie for a PCI BAR
eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29   98   * @dev: PCI device that owns the BAR
eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29   99   * @bar: BAR number
eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29  100   * @maxlen: length of the memory to map
eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29  101   *
eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29  102   * Using this function you will get a __iomem address to your device BAR.
eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29  103   * You can access it using ioread*() and iowrite*(). These functions hide
eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29  104   * the details if this is a MMIO or PIO address space and will just do what
eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29  105   * you expect from them in the correct way.
eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29  106   *
eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29  107   * @maxlen specifies the maximum length to map. If you want to get access to
eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29  108   * the complete BAR without checking for its length first, pass %0 here.
eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29  109   * */
eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29 @110  void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long maxlen)
eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29  111  {
eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29  112  	return pci_iomap_range(dev, bar, 0, maxlen);
eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29  113  }
66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24  114  EXPORT_SYMBOL(pci_iomap);
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24  115  
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24  116  /**
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24  117   * pci_iomap_wc - create a virtual WC mapping cookie for a PCI BAR
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24  118   * @dev: PCI device that owns the BAR
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24  119   * @bar: BAR number
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24  120   * @maxlen: length of the memory to map
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24  121   *
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24  122   * Using this function you will get a __iomem address to your device BAR.
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24  123   * You can access it using ioread*() and iowrite*(). These functions hide
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24  124   * the details if this is a MMIO or PIO address space and will just do what
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24  125   * you expect from them in the correct way. When possible write combining
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24  126   * is used.
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24  127   *
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24  128   * @maxlen specifies the maximum length to map. If you want to get access to
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24  129   * the complete BAR without checking for its length first, pass %0 here.
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24  130   * */
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24 @131  void __iomem *pci_iomap_wc(struct pci_dev *dev, int bar, unsigned long maxlen)
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24  132  {
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24  133  	return pci_iomap_wc_range(dev, bar, 0, maxlen);
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24  134  }
1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez  2015-08-24  135  EXPORT_SYMBOL_GPL(pci_iomap_wc);
316e8d79a0959c lib/pci_iomap.c Linus Torvalds     2021-09-19  136  
316e8d79a0959c lib/pci_iomap.c Linus Torvalds     2021-09-19  137  /*
316e8d79a0959c lib/pci_iomap.c Linus Torvalds     2021-09-19  138   * pci_iounmap() somewhat illogically comes from lib/iomap.c for the
316e8d79a0959c lib/pci_iomap.c Linus Torvalds     2021-09-19  139   * CONFIG_GENERIC_IOMAP case, because that's the code that knows about
316e8d79a0959c lib/pci_iomap.c Linus Torvalds     2021-09-19  140   * the different IOMAP ranges.
316e8d79a0959c lib/pci_iomap.c Linus Torvalds     2021-09-19  141   *
316e8d79a0959c lib/pci_iomap.c Linus Torvalds     2021-09-19  142   * But if the architecture does not use the generic iomap code, and if
316e8d79a0959c lib/pci_iomap.c Linus Torvalds     2021-09-19  143   * it has _not_ defined it's own private pci_iounmap function, we define
316e8d79a0959c lib/pci_iomap.c Linus Torvalds     2021-09-19  144   * it here.
316e8d79a0959c lib/pci_iomap.c Linus Torvalds     2021-09-19  145   *
316e8d79a0959c lib/pci_iomap.c Linus Torvalds     2021-09-19  146   * NOTE! This default implementation assumes that if the architecture
316e8d79a0959c lib/pci_iomap.c Linus Torvalds     2021-09-19  147   * support ioport mapping (HAS_IOPORT_MAP), the ioport mapping will
316e8d79a0959c lib/pci_iomap.c Linus Torvalds     2021-09-19  148   * be fixed to the range [ PCI_IOBASE, PCI_IOBASE+IO_SPACE_LIMIT [,
316e8d79a0959c lib/pci_iomap.c Linus Torvalds     2021-09-19  149   * and does not need unmapping with 'ioport_unmap()'.
316e8d79a0959c lib/pci_iomap.c Linus Torvalds     2021-09-19  150   *
316e8d79a0959c lib/pci_iomap.c Linus Torvalds     2021-09-19  151   * If you have different rules for your architecture, you need to
316e8d79a0959c lib/pci_iomap.c Linus Torvalds     2021-09-19  152   * implement your own pci_iounmap() that knows the rules for where
316e8d79a0959c lib/pci_iomap.c Linus Torvalds     2021-09-19  153   * and how IO vs MEM get mapped.
316e8d79a0959c lib/pci_iomap.c Linus Torvalds     2021-09-19  154   *
316e8d79a0959c lib/pci_iomap.c Linus Torvalds     2021-09-19  155   * This code is odd, and the ARCH_HAS/ARCH_WANTS #define logic comes
316e8d79a0959c lib/pci_iomap.c Linus Torvalds     2021-09-19  156   * from legacy <asm-generic/io.h> header file behavior. In particular,
316e8d79a0959c lib/pci_iomap.c Linus Torvalds     2021-09-19  157   * it would seem to make sense to do the iounmap(p) for the non-IO-space
316e8d79a0959c lib/pci_iomap.c Linus Torvalds     2021-09-19  158   * case here regardless, but that's not what the old header file code
316e8d79a0959c lib/pci_iomap.c Linus Torvalds     2021-09-19  159   * did. Probably incorrectly, but this is meant to be bug-for-bug
316e8d79a0959c lib/pci_iomap.c Linus Torvalds     2021-09-19  160   * compatible.
316e8d79a0959c lib/pci_iomap.c Linus Torvalds     2021-09-19  161   */
316e8d79a0959c lib/pci_iomap.c Linus Torvalds     2021-09-19  162  #if defined(ARCH_WANTS_GENERIC_PCI_IOUNMAP)
316e8d79a0959c lib/pci_iomap.c Linus Torvalds     2021-09-19  163  
316e8d79a0959c lib/pci_iomap.c Linus Torvalds     2021-09-19 @164  void pci_iounmap(struct pci_dev *dev, void __iomem *p)
316e8d79a0959c lib/pci_iomap.c Linus Torvalds     2021-09-19  165  {
316e8d79a0959c lib/pci_iomap.c Linus Torvalds     2021-09-19  166  #ifdef ARCH_HAS_GENERIC_IOPORT_MAP
316e8d79a0959c lib/pci_iomap.c Linus Torvalds     2021-09-19  167  	uintptr_t start = (uintptr_t) PCI_IOBASE;
316e8d79a0959c lib/pci_iomap.c Linus Torvalds     2021-09-19  168  	uintptr_t addr = (uintptr_t) p;
316e8d79a0959c lib/pci_iomap.c Linus Torvalds     2021-09-19  169  
316e8d79a0959c lib/pci_iomap.c Linus Torvalds     2021-09-19  170  	if (addr >= start && addr < start + IO_SPACE_LIMIT)
316e8d79a0959c lib/pci_iomap.c Linus Torvalds     2021-09-19  171  		return;
316e8d79a0959c lib/pci_iomap.c Linus Torvalds     2021-09-19  172  	iounmap(p);
316e8d79a0959c lib/pci_iomap.c Linus Torvalds     2021-09-19  173  #endif
316e8d79a0959c lib/pci_iomap.c Linus Torvalds     2021-09-19  174  }
316e8d79a0959c lib/pci_iomap.c Linus Torvalds     2021-09-19  175  EXPORT_SYMBOL(pci_iounmap);
316e8d79a0959c lib/pci_iomap.c Linus Torvalds     2021-09-19  176  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

