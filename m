Return-Path: <linux-pci+bounces-11761-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 401BE954908
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2024 14:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F18A1280C5E
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2024 12:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315E61917DF;
	Fri, 16 Aug 2024 12:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kEhKAyor"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4EE192B93;
	Fri, 16 Aug 2024 12:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723812299; cv=none; b=bfyI400vObm1kOzRAozu2gPdTCcktiAKG8MA9N18/cWPpYYx8cT8WogJLKmiC22c6xERS+o35DGeehHukDEcofB6qwObKiA8oRYL9fsEAva5mzy+LQ2TpmKJHTBqtIPl5hukbEv9xCX0BwFxI3wr4KtR1T726hnqliVVoVuC9c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723812299; c=relaxed/simple;
	bh=a1wMG3F56AHOEbZ2fzPzZeByW/CEN4zUy3fYWVDPUAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jd6qZWV/yNlo3qN8ku/QCRjt0cDqHIeG5h7pIoTKEYQbWimGA85I74JpxalqSfSNVQmAyUhmTHdQyJeY4Al6W3oFWdbOwWC+kk4jwBh/nz1LqcJpz3Y3efPcV/ZEVwgJazljxoPvS+ET/8AJ+hbvBd7XmpMez898Q+1EFjut50k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kEhKAyor; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723812297; x=1755348297;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a1wMG3F56AHOEbZ2fzPzZeByW/CEN4zUy3fYWVDPUAg=;
  b=kEhKAyork9RTB+zwCheih/yCoBz/2s1WPYj98utgW7n52zeIL8IUKHT9
   qVrLUX2cDTCrPNW/9tYPyDuddHr6P+4dAvz/qkqre/lz0gpTmv8Jv4+pW
   6cUXParfrpsdCcxveF9GP5b5UtSZAZOIwmYgXNK3+baznenLajXwFY2ST
   olZo6KuQIB7LqTMmbCgbQR3ZfXrIZfoGCBsNz7YF7tvGaO6D+8qtrh3OR
   g1e896rA14j49PtRh+ilDptxeF+mfS7FXK3RM8NpUpriNvIDyA3/TIKeL
   IiMW51/kg7ot6JACkbjnE1dIOX4JV3stVlKbTCDTKV09uhuNYf4oxGQbt
   g==;
X-CSE-ConnectionGUID: TL/ACBlnTVmgg/9GhPpL5Q==
X-CSE-MsgGUID: d+3p70S5ROC74YB7lFPH8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="44625447"
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="44625447"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 05:44:56 -0700
X-CSE-ConnectionGUID: l6axIvtVRDGcK1AYbyLEyQ==
X-CSE-MsgGUID: rEQ8uUvzT3iT08p0wMxdWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="64333870"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 16 Aug 2024 05:44:54 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sewK4-0006QG-19;
	Fri, 16 Aug 2024 12:44:52 +0000
Date: Fri, 16 Aug 2024 20:44:28 +0800
From: kernel test robot <lkp@intel.com>
To: Miao Wang via B4 Relay <devnull+shankerwangmiao.gmail.com@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, Miao Wang <shankerwangmiao@gmail.com>
Subject: Re: [PATCH] ACPI: PCI: check if the io space is page aligned
Message-ID: <202408162020.SGGpRl7q-lkp@intel.com>
References: <20240814-check_pci_probe_res-v1-1-122ee07821ab@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814-check_pci_probe_res-v1-1-122ee07821ab@gmail.com>

Hi Miao,

kernel test robot noticed the following build errors:

[auto build test ERROR on 7c626ce4bae1ac14f60076d00eafe71af30450ba]

url:    https://github.com/intel-lab-lkp/linux/commits/Miao-Wang-via-B4-Relay/ACPI-PCI-check-if-the-io-space-is-page-aligned/20240815-003833
base:   7c626ce4bae1ac14f60076d00eafe71af30450ba
patch link:    https://lore.kernel.org/r/20240814-check_pci_probe_res-v1-1-122ee07821ab%40gmail.com
patch subject: [PATCH] ACPI: PCI: check if the io space is page aligned
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20240816/202408162020.SGGpRl7q-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240816/202408162020.SGGpRl7q-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408162020.SGGpRl7q-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/pm_runtime.h:11,
                    from drivers/acpi/pci_root.c:17:
   drivers/acpi/pci_root.c: In function 'acpi_pci_root_remap_iospace':
>> drivers/acpi/pci_root.c:873:31: error: incompatible type for argument 1 of '_dev_err'
     873 |                 dev_err(device->dev,
         |                         ~~~~~~^~~~~
         |                               |
         |                               struct device
   include/linux/dev_printk.h:110:25: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                         ^~~
   drivers/acpi/pci_root.c:873:17: note: in expansion of macro 'dev_err'
     873 |                 dev_err(device->dev,
         |                 ^~~~~~~
   include/linux/dev_printk.h:50:36: note: expected 'const struct device *' but argument is of type 'struct device'
      50 | void _dev_err(const struct device *dev, const char *fmt, ...);
         |               ~~~~~~~~~~~~~~~~~~~~~^~~


vim +/_dev_err +873 drivers/acpi/pci_root.c

   860	
   861	static void acpi_pci_root_remap_iospace(struct acpi_device *device,
   862				struct resource_entry *entry)
   863	{
   864	#ifdef PCI_IOBASE
   865		struct resource *res = entry->res;
   866		resource_size_t cpu_addr = res->start;
   867		resource_size_t pci_addr = cpu_addr - entry->offset;
   868		resource_size_t length = resource_size(res);
   869		unsigned long port;
   870	
   871		if (!PAGE_ALIGNED(cpu_addr) || !PAGE_ALIGNED(length) ||
   872			!PAGE_ALIGNED(pci_addr)) {
 > 873			dev_err(device->dev,
   874				FW_BUG "I/O resource %pR or its offset %pa is not page aligned\n",
   875				res, &entry->offset);
   876			goto err;
   877		}
   878	
   879		if (pci_register_io_range(&device->fwnode, cpu_addr, length))
   880			goto err;
   881	
   882		port = pci_address_to_pio(cpu_addr);
   883		if (port == (unsigned long)-1)
   884			goto err;
   885	
   886		res->start = port;
   887		res->end = port + length - 1;
   888		entry->offset = port - pci_addr;
   889	
   890		if (pci_remap_iospace(res, cpu_addr) < 0)
   891			goto err;
   892	
   893		pr_info("Remapped I/O %pa to %pR\n", &cpu_addr, res);
   894		return;
   895	err:
   896		res->flags |= IORESOURCE_DISABLED;
   897	#endif
   898	}
   899	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

