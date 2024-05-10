Return-Path: <linux-pci+bounces-7318-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 824A08C1D65
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 06:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2F781F22ACD
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 04:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482B714C58C;
	Fri, 10 May 2024 04:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PTh0vVQU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FB314BF92;
	Fri, 10 May 2024 04:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715314855; cv=none; b=QkqLSklU/Qz5PTmMAE5PquNJfjGpa/y7LXDwX9WXjQYcCkxxHlDGGNo5F3kIxpfqw7FPLv6tTN1CBMAbVhAJuy4DFJ43+wc7Fqzl9V/gXeek8CiaovFJy+PLW/RfOeM7S8T9zaLylnhkku8XPTYHDJEyF2OBKJGt0eYZnHNCjLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715314855; c=relaxed/simple;
	bh=yde+e083D+Y6dH3TaJbEx9gaVKpWNaOkIuVpOCVIpfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1oVQ16rH2jr5U7O6LxyK/bVkbaDORYXBOR2LQg+/dCfC3zQvObbtnfNT39fV7h3RJ0qpJFArXBwT3BFW9JaUG/vPz8NtCgdoqOvJj3FhJTBum4ov5J5yH5rzU+KhSWWSmakH2njEptYzSS9Vzoj/aqFWeE0x9A7qzxqrOkMn7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PTh0vVQU; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715314850; x=1746850850;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yde+e083D+Y6dH3TaJbEx9gaVKpWNaOkIuVpOCVIpfE=;
  b=PTh0vVQUfCciOm6ydc1xegF/UKBYxwEUu1syEBAPTEg9MGtK1Ai/6Nyy
   rjVRLXGnZb264WtCsHeCUSgtQcgq8GEgox7R831PrLZ8PEkxr6ogQcD/R
   JkI8mUewpsFiroDwu63XE69+YSVwyf92xTytE6F1pavALQUuci7TDxZN/
   j4/6aYx2oDeAo+pR24M0dxxLxiP2rOY6S8XSHWZYu2kLjOaLXr5q7Ao/9
   w1sl4S3mcZhfT4HJAjwZZFmrHBJYNY4qJCVIXWwMIqNKKYAU8uL7hy+Oe
   DRbeTkC38HPqyYdXEzIMM1jnwCOSUjDwuQb1Ymk84dXKaDu5HpPpHAm9p
   g==;
X-CSE-ConnectionGUID: Z4PbYaX7T/W0gK0t+iI7gA==
X-CSE-MsgGUID: DEsxnRP5SxWtarVLBuNFKA==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="28760848"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="28760848"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 21:20:49 -0700
X-CSE-ConnectionGUID: Dpc06GWPRJu0PltILmSdeg==
X-CSE-MsgGUID: nFfoBkN2Q7GX9weKTh8MHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="29584668"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 09 May 2024 21:20:45 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s5HkQ-0005iZ-0Z;
	Fri, 10 May 2024 04:20:42 +0000
Date: Fri, 10 May 2024 12:20:29 +0800
From: kernel test robot <lkp@intel.com>
To: Wei Huang <wei.huang2@amd.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, bhelgaas@google.com, corbet@lwn.net,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, alex.williamson@redhat.com, gospo@broadcom.com,
	michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
	manoj.panicker2@amd.com, Eric.VanTassell@amd.com,
	wei.huang2@amd.com
Subject: Re: [PATCH V1 6/9] PCI/TPH: Retrieve steering tag from ACPI _DSM
Message-ID: <202405101200.FPuliW1p-lkp@intel.com>
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
config: parisc-randconfig-r081-20240510 (https://download.01.org/0day-ci/archive/20240510/202405101200.FPuliW1p-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240510/202405101200.FPuliW1p-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405101200.FPuliW1p-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/pcie/tph.c: In function 'tph_msix_table_entry':
   drivers/pci/pcie/tph.c:95:22: error: 'struct pci_dev' has no member named 'msix_base'; did you mean 'msix_cap'?
      95 |         entry = dev->msix_base + msi_index * PCI_MSIX_ENTRY_SIZE;
         |                      ^~~~~~~~~
         |                      msix_cap
   drivers/pci/pcie/tph.c: In function 'invoke_dsm':
>> drivers/pci/pcie/tph.c:221:46: error: 'pci_acpi_dsm_guid' undeclared (first use in this function)
     221 |         out_obj = acpi_evaluate_dsm(handle, &pci_acpi_dsm_guid, MIN_ST_DSM_REV,
         |                                              ^~~~~~~~~~~~~~~~~
   drivers/pci/pcie/tph.c:221:46: note: each undeclared identifier is reported only once for each function it appears in


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

