Return-Path: <linux-pci+bounces-24315-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D097A6B7D0
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 10:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B6091B6004E
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 09:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E151F4187;
	Fri, 21 Mar 2025 09:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nSzHHFaz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD37A1F3B82;
	Fri, 21 Mar 2025 09:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742549887; cv=none; b=XczjzDjHP3qiiGj17lgwLmxU0yZ9OMYhNxREZr6O1Sng0QhkpgdjxxoUQz87HqE3QzyhJw2QzFhN7Fi3zB+/1bV5s+sfMW90MH8e9DjMc/MG2HQl4TAqfX39q1T0eAuEgjmgHIISSS2BxpIvcsPcHl4JR4yXj/fseVbDE77ImBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742549887; c=relaxed/simple;
	bh=R358JVjnvOlnGRXDLx0jNulZXye12NrgAdhLVQkGcbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9dSE0bPEF5f0S/l1iUdkUeQ76lC4teL99T9NOW61sDqZnb5iwEV2tXkPl2B8R59J3Z1uXRP8K/Pi2V7Ng+SfooA7RLshtVCv7tP/r5lA13NbCoEq2DQZDwKZ1tUXQSI+Cv7eRzJP9jOAbHWs6LK64ft2I9XyEKaqgG87Xw7VsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nSzHHFaz; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742549885; x=1774085885;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R358JVjnvOlnGRXDLx0jNulZXye12NrgAdhLVQkGcbI=;
  b=nSzHHFaztkW9ElYW8hXQM5oYRahpJ1zFQtgquu6/OnXWouuQMkULwJ7n
   scL9KTH6aOjHNge9Acw3U8Q4/0IbCAnBmaafL0tdAPyamcew6YPrUQh0a
   fdWK9eTsw3Ybaf35k2FO57Zy3pGYGpyXmoPE6x8FyygsWZHMXaLnNBxKQ
   6MpJ7cqK4DpPMn7zd3IXNcCPWW0XjidXcuqevUvXM1E0rEEWBPa6Zj+X6
   B1SAm3brJUgWja/OlYb8VkHi3voUkMGZrcqLFcAEjWVzjIkWH3oT+nUcQ
   xwhYGT+U2MY8a5tRjfgIrm4STerA5i2UFTloVriroPp8aSfXPBvHTuSjj
   g==;
X-CSE-ConnectionGUID: +jqfVXIGRwOSACoqpGUOOw==
X-CSE-MsgGUID: e74O+CoTQ+STV9lPqJ5jzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="47692789"
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="47692789"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 02:38:04 -0700
X-CSE-ConnectionGUID: 30JKucJ7T0mfLiiKPP80lA==
X-CSE-MsgGUID: k0ToPpVGQ927T+xzT4r9Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="124131266"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 21 Mar 2025 02:38:01 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tvYpD-0001ER-1V;
	Fri, 21 Mar 2025 09:37:59 +0000
Date: Fri, 21 Mar 2025 17:37:46 +0800
From: kernel test robot <lkp@intel.com>
To: Hans Zhang <18255117159@163.com>, lpieralisi@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, jingoohan1@gmail.com,
	thomas.richard@bootlin.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hans Zhang <18255117159@163.com>
Subject: Re: [v3 1/4] PCI: Introduce generic capability search functions
Message-ID: <202503211726.DEvDBGk8-lkp@intel.com>
References: <20250321040358.360755-2-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321040358.360755-2-18255117159@163.com>

Hi Hans,

kernel test robot noticed the following build errors:

[auto build test ERROR on a1cffe8cc8aef85f1b07c4464f0998b9785b795a]

url:    https://github.com/intel-lab-lkp/linux/commits/Hans-Zhang/PCI-Introduce-generic-capability-search-functions/20250321-120748
base:   a1cffe8cc8aef85f1b07c4464f0998b9785b795a
patch link:    https://lore.kernel.org/r/20250321040358.360755-2-18255117159%40163.com
patch subject: [v3 1/4] PCI: Introduce generic capability search functions
config: arc-randconfig-002-20250321 (https://download.01.org/0day-ci/archive/20250321/202503211726.DEvDBGk8-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250321/202503211726.DEvDBGk8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503211726.DEvDBGk8-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/nvme/host/nvme.h:11,
                    from drivers/nvme/host/fc.c:13:
>> include/linux/pci.h:2021:4: warning: no previous prototype for 'pci_generic_find_capability' [-Wmissing-prototypes]
    2021 | u8 pci_generic_find_capability(void *priv, pci_generic_read_cfg read_cfg,
         |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/pci.h:2024:5: warning: no previous prototype for 'pci_generic_find_ext_capability' [-Wmissing-prototypes]
    2024 | u16 pci_generic_find_ext_capability(void *priv, pci_generic_read_cfg read_cfg,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   arc-linux-ld: drivers/scsi/libsas/sas_phy.o: in function `pci_generic_find_capability':
>> sas_phy.c:(.text+0x148): multiple definition of `pci_generic_find_capability'; drivers/scsi/libsas/sas_init.o:sas_init.c:(.text+0xd18): first defined here
   arc-linux-ld: drivers/scsi/libsas/sas_phy.o: in function `pci_generic_find_ext_capability':
>> sas_phy.c:(.text+0x150): multiple definition of `pci_generic_find_ext_capability'; drivers/scsi/libsas/sas_init.o:sas_init.c:(.text+0xd20): first defined here
   arc-linux-ld: drivers/scsi/libsas/sas_port.o: in function `pci_generic_find_capability':
   sas_port.c:(.text+0x1c8): multiple definition of `pci_generic_find_capability'; drivers/scsi/libsas/sas_init.o:sas_init.c:(.text+0xd18): first defined here
   arc-linux-ld: drivers/scsi/libsas/sas_port.o: in function `pci_generic_find_ext_capability':
   sas_port.c:(.text+0x1d0): multiple definition of `pci_generic_find_ext_capability'; drivers/scsi/libsas/sas_init.o:sas_init.c:(.text+0xd20): first defined here
   arc-linux-ld: drivers/scsi/libsas/sas_event.o: in function `pci_generic_find_capability':
   sas_event.c:(.text+0xf8): multiple definition of `pci_generic_find_capability'; drivers/scsi/libsas/sas_init.o:sas_init.c:(.text+0xd18): first defined here
   arc-linux-ld: drivers/scsi/libsas/sas_event.o: in function `pci_generic_find_ext_capability':
   sas_event.c:(.text+0x100): multiple definition of `pci_generic_find_ext_capability'; drivers/scsi/libsas/sas_init.o:sas_init.c:(.text+0xd20): first defined here
   arc-linux-ld: drivers/scsi/libsas/sas_discover.o: in function `pci_generic_find_capability':
   sas_discover.c:(.text+0x874): multiple definition of `pci_generic_find_capability'; drivers/scsi/libsas/sas_init.o:sas_init.c:(.text+0xd18): first defined here
   arc-linux-ld: drivers/scsi/libsas/sas_discover.o: in function `pci_generic_find_ext_capability':
   sas_discover.c:(.text+0x87c): multiple definition of `pci_generic_find_ext_capability'; drivers/scsi/libsas/sas_init.o:sas_init.c:(.text+0xd20): first defined here
   arc-linux-ld: drivers/scsi/libsas/sas_expander.o: in function `pci_generic_find_capability':
   sas_expander.c:(.text+0x2378): multiple definition of `pci_generic_find_capability'; drivers/scsi/libsas/sas_init.o:sas_init.c:(.text+0xd18): first defined here
   arc-linux-ld: drivers/scsi/libsas/sas_expander.o: in function `pci_generic_find_ext_capability':
   sas_expander.c:(.text+0x2380): multiple definition of `pci_generic_find_ext_capability'; drivers/scsi/libsas/sas_init.o:sas_init.c:(.text+0xd20): first defined here
   arc-linux-ld: drivers/scsi/libsas/sas_scsi_host.o: in function `pci_generic_find_capability':
   sas_scsi_host.c:(.text+0x17c0): multiple definition of `pci_generic_find_capability'; drivers/scsi/libsas/sas_init.o:sas_init.c:(.text+0xd18): first defined here
   arc-linux-ld: drivers/scsi/libsas/sas_scsi_host.o: in function `pci_generic_find_ext_capability':
   sas_scsi_host.c:(.text+0x17c8): multiple definition of `pci_generic_find_ext_capability'; drivers/scsi/libsas/sas_init.o:sas_init.c:(.text+0xd20): first defined here
   arc-linux-ld: drivers/scsi/libsas/sas_task.o: in function `pci_generic_find_capability':
   sas_task.c:(.text+0xd4): multiple definition of `pci_generic_find_capability'; drivers/scsi/libsas/sas_init.o:sas_init.c:(.text+0xd18): first defined here
   arc-linux-ld: drivers/scsi/libsas/sas_task.o: in function `pci_generic_find_ext_capability':
   sas_task.c:(.text+0xdc): multiple definition of `pci_generic_find_ext_capability'; drivers/scsi/libsas/sas_init.o:sas_init.c:(.text+0xd20): first defined here
   arc-linux-ld: drivers/scsi/libsas/sas_host_smp.o: in function `pci_generic_find_capability':
   sas_host_smp.c:(.text+0x48): multiple definition of `pci_generic_find_capability'; drivers/scsi/libsas/sas_init.o:sas_init.c:(.text+0xd18): first defined here
   arc-linux-ld: drivers/scsi/libsas/sas_host_smp.o: in function `pci_generic_find_ext_capability':
   sas_host_smp.c:(.text+0x50): multiple definition of `pci_generic_find_ext_capability'; drivers/scsi/libsas/sas_init.o:sas_init.c:(.text+0xd20): first defined here
--
   arc-linux-ld: drivers/pcmcia/cistpl.o: in function `pci_generic_find_capability':
>> cistpl.c:(.text+0xfac): multiple definition of `pci_generic_find_capability'; drivers/pcmcia/pcmcia_resource.o:pcmcia_resource.c:(.text+0x1244): first defined here
   arc-linux-ld: drivers/pcmcia/cistpl.o: in function `pci_generic_find_ext_capability':
>> cistpl.c:(.text+0xfb4): multiple definition of `pci_generic_find_ext_capability'; drivers/pcmcia/pcmcia_resource.o:pcmcia_resource.c:(.text+0x124c): first defined here

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

