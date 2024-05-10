Return-Path: <linux-pci+bounces-7319-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D4E8C1DAB
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 07:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB8541C21349
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 05:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408B515667B;
	Fri, 10 May 2024 05:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LjMj7h2D"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9171527A4;
	Fri, 10 May 2024 05:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715318756; cv=none; b=pNnO3qyhFp/OS7CADgDiE4tnbukV2ZLZRHdjBsC24YiU4yQ1tOUZi1edAiOonM8mtmT5nVoa4Tuq/cCxX2rC76knI25ex4/cvGkQarpVvTGpvF4z05D2KlvEWNsd12bEd7TyHoykSf7j0wHXtSb6x4xNYfSG7QCugnGMmfJGum4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715318756; c=relaxed/simple;
	bh=ClsNQ1eiRwIl3Mkb5R4SiIbCFUc8HXmYYfmAw5kVQoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=roM/GhtCA9qqRrQVInDz2doB6MjVGd6XRzr6706aCKQkLhgQg1VkDoIj+8kq6Lb0WsRRqaMTBKSkXvEaLm5/MscjguBxkKcVw6HlhsBnm/1bXXqAeVDhFJO8h9f21XPAc72/6TB798WnBMUJSVjyoCBwuHEpNzonu+ZGRFahT4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LjMj7h2D; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715318753; x=1746854753;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ClsNQ1eiRwIl3Mkb5R4SiIbCFUc8HXmYYfmAw5kVQoA=;
  b=LjMj7h2DBYm5f2vfP19exFHkN/WhRNwDuK9AFfkgzdlF+SukIRhj9bcC
   5Pt5irmr+CSwsaou0e2C9sRq0oq4Q84nFpcnFvjnLCK+YeeRo+M9EXL/Z
   iF/ZP5SWwhkrBXdjCOoKETVPJVd7setVaFsymUMbcOf2CDexj/xhNBO0F
   xTYMwyDHfegNulXuBo+/vO0sVTg4kgvb47HVGZbgfJI/23nDVnB5ZxeXN
   9/E2A3ohd1ayuz10j2bsZOGUvKE01pt3CMlkqY79eM70WpnX73J3UdGtW
   yC5UGHb5AaxZMcJnwftliIz48wbZT8PtDqI/awfT7Dyyv2L/mTbeJHOyN
   A==;
X-CSE-ConnectionGUID: mRipuHWqRYWgMPDbjIXXKg==
X-CSE-MsgGUID: wsESAKmiTn+aenvDjU3UXw==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="15089618"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="15089618"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 22:25:52 -0700
X-CSE-ConnectionGUID: l+Ey90NiTGefcRUfNjdBUw==
X-CSE-MsgGUID: jenVY5+XS7Ox3UzOMbN+7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="34151807"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 09 May 2024 22:25:48 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s5IlN-0005lX-0o;
	Fri, 10 May 2024 05:25:45 +0000
Date: Fri, 10 May 2024 13:24:49 +0800
From: kernel test robot <lkp@intel.com>
To: Wei Huang <wei.huang2@amd.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	bhelgaas@google.com, corbet@lwn.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	alex.williamson@redhat.com, gospo@broadcom.com,
	michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
	manoj.panicker2@amd.com, Eric.VanTassell@amd.com,
	wei.huang2@amd.com
Subject: Re: [PATCH V1 6/9] PCI/TPH: Retrieve steering tag from ACPI _DSM
Message-ID: <202405101330.7jDvJ4Jc-lkp@intel.com>
References: <20240509162741.1937586-7-wei.huang2@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509162741.1937586-7-wei.huang2@amd.com>

Hi Wei,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/for-linus]
[also build test ERROR on awilliam-vfio/next linus/master awilliam-vfio/for-linus v6.9-rc7 next-20240509]
[cannot apply to pci/next horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wei-Huang/PCI-Introduce-PCIe-TPH-support-framework/20240510-003504
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
patch link:    https://lore.kernel.org/r/20240509162741.1937586-7-wei.huang2%40amd.com
patch subject: [PATCH V1 6/9] PCI/TPH: Retrieve steering tag from ACPI _DSM
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20240510/202405101330.7jDvJ4Jc-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project b910bebc300dafb30569cecc3017b446ea8eafa0)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240510/202405101330.7jDvJ4Jc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405101330.7jDvJ4Jc-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/pci/pcie/tph.c:13:
   In file included from include/linux/acpi.h:14:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:173:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:508:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     508 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     509 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:515:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     515 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     516 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:527:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     527 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     528 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:536:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     536 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     537 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/pci/pcie/tph.c:17:
   In file included from include/linux/msi.h:27:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
         |                                                           ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
     102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
         |                                                      ^
   In file included from drivers/pci/pcie/tph.c:17:
   In file included from include/linux/msi.h:27:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
         |                                                           ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
     115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
         |                                                      ^
   In file included from drivers/pci/pcie/tph.c:17:
   In file included from include/linux/msi.h:27:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     692 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     700 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     708 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     717 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     726 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     735 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> drivers/pci/pcie/tph.c:221:39: error: use of undeclared identifier 'pci_acpi_dsm_guid'
     221 |         out_obj = acpi_evaluate_dsm(handle, &pci_acpi_dsm_guid, MIN_ST_DSM_REV,
         |                                              ^
   17 warnings and 1 error generated.


vim +/pci_acpi_dsm_guid +221 drivers/pci/pcie/tph.c

   196	
   197	#define MIN_ST_DSM_REV		7
   198	#define ST_DSM_FUNC_INDEX	0xf
   199	static bool invoke_dsm(acpi_handle handle, u32 cpu_uid, u8 ph,
   200			       u8 target_type, bool cache_ref_valid,
   201			       u64 cache_ref, union st_info *st_out)
   202	{
   203		union acpi_object in_obj, in_buf[3], *out_obj;
   204	
   205		in_buf[0].integer.type = ACPI_TYPE_INTEGER;
   206		in_buf[0].integer.value = 0; /* 0 => processor cache steering tags */
   207	
   208		in_buf[1].integer.type = ACPI_TYPE_INTEGER;
   209		in_buf[1].integer.value = cpu_uid;
   210	
   211		in_buf[2].integer.type = ACPI_TYPE_INTEGER;
   212		in_buf[2].integer.value = ph & 3;
   213		in_buf[2].integer.value |= (target_type & 1) << 2;
   214		in_buf[2].integer.value |= (cache_ref_valid & 1) << 3;
   215		in_buf[2].integer.value |= (cache_ref << 32);
   216	
   217		in_obj.type = ACPI_TYPE_PACKAGE;
   218		in_obj.package.count = ARRAY_SIZE(in_buf);
   219		in_obj.package.elements = in_buf;
   220	
 > 221		out_obj = acpi_evaluate_dsm(handle, &pci_acpi_dsm_guid, MIN_ST_DSM_REV,
   222					    ST_DSM_FUNC_INDEX, &in_obj);
   223	
   224		if (!out_obj)
   225			return false;
   226	
   227		if (out_obj->type != ACPI_TYPE_BUFFER) {
   228			pr_err("invalid return type %d from TPH _DSM\n",
   229			       out_obj->type);
   230			ACPI_FREE(out_obj);
   231			return false;
   232		}
   233	
   234		st_out->value = *((u64 *)(out_obj->buffer.pointer));
   235	
   236		ACPI_FREE(out_obj);
   237	
   238		return true;
   239	}
   240	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

