Return-Path: <linux-pci+bounces-6163-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4C08A259C
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 07:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3BBD284D9E
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 05:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198F018C1A;
	Fri, 12 Apr 2024 05:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SNCvEJlg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FE01BC4B;
	Fri, 12 Apr 2024 05:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712899117; cv=none; b=WvCQn+u6rIAYao0GL5SjO75z5PKeSCXJPq44qwkv97gP8OrUfIHTo4CkEIuFKcn4mtaMCdbrtaMnfdd8m7Hkasil+o4OKugQsWG7auXjT+BLnRRu45tCZmjk3hqqOC+hmfcLI4PwTwYTy/BJnHP8c3aynZbYixrYsvZi9aFQ2Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712899117; c=relaxed/simple;
	bh=uwFlHt+PTlQqrCZdxzJ/sKwf6ogszPPv5s8ONO3bywk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HnxdiXdzlkPjyUF6iehx7Uqge/+Md3RrHxH8wVV+QLnU0iWiD3Rq3UlrlYJ3NAAJBAnXN+o2A1L7i1svx3SIKTeywtR50QFnXeQjCvAYEQQCgvV76CqTv2rvRmzF8wPrv3vvZPh7xTQdW9PbW4eRP47UG/nc4CHRcmFZZ7WEndg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SNCvEJlg; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712899114; x=1744435114;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uwFlHt+PTlQqrCZdxzJ/sKwf6ogszPPv5s8ONO3bywk=;
  b=SNCvEJlgEqppFzvSzBwyoMrnSB7ia2PINpetDZxKlpr/7mFzjlc0pfL1
   AqZZvDtcxft7oveGT4uFilCwsWfu0GXRf2DHN9nZ/Lg9pHNG7zUYkVQqu
   m5LuB1IIgbYthNFrbxlQ9nBTX+DP+I45RjagnV0dUXY/JMhL2vSe808Fm
   XtuJmDsZr5hmi8wfjkB7+cSe+cqwyncV+Qb1iPSVFPL506hH4foBtikQV
   8SyUUKDOySaK+xuCFHXTikf9FPoxzVsXme8epdPrcYHDMfoDc17FkheOU
   z6/hIyp7S7DnZ9a0mwpUjZvutngsESU7Cgy9KJOLX1hCoYySA4/M9kmDy
   Q==;
X-CSE-ConnectionGUID: AwEHOiJUTQurruZoA2vRsg==
X-CSE-MsgGUID: b6d3Px25QgKk4DxZvCwYJw==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="8510209"
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="8510209"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 22:18:34 -0700
X-CSE-ConnectionGUID: ANtLcTM0Q3uJIRQrzST4CA==
X-CSE-MsgGUID: bA8DNO+FS1yeaDDSQiu1MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="21558046"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 11 Apr 2024 22:18:31 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rv9Iy-0009PU-1c;
	Fri, 12 Apr 2024 05:18:28 +0000
Date: Fri, 12 Apr 2024 13:17:42 +0800
From: kernel test robot <lkp@intel.com>
To: parker@finest.io, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
	linux-pci@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH 2/2] serial: exar: adding CTI PCI/PCIe serial port
 support to 8250_exar
Message-ID: <202404121307.6nkI7fuG-lkp@intel.com>
References: <9ffdef053f455c87f705dff169346bc10d307787.1712846026.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ffdef053f455c87f705dff169346bc10d307787.1712846026.git.pnewman@connecttech.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on tty/tty-next tty/tty-linus usb/usb-testing usb/usb-next usb/usb-linus pci/next pci/for-linus linus/master v6.9-rc3 next-20240411]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/parker-finest-io/serial-exar-add-missing-CTI-Exar-PCI-IDs-to-include-linux-pci_ids-h/20240412-011902
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/9ffdef053f455c87f705dff169346bc10d307787.1712846026.git.pnewman%40connecttech.com
patch subject: [PATCH 2/2] serial: exar: adding CTI PCI/PCIe serial port support to 8250_exar
config: riscv-defconfig (https://download.01.org/0day-ci/archive/20240412/202404121307.6nkI7fuG-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 8b3b4a92adee40483c27f26c478a384cd69c6f05)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240412/202404121307.6nkI7fuG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404121307.6nkI7fuG-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/tty/serial/8250/8250_exar.c:13:
   In file included from include/linux/interrupt.h:21:
   In file included from arch/riscv/include/asm/sections.h:9:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/tty/serial/8250/8250_exar.c:1573:3: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
    1573 |                 default:
         |                 ^
   drivers/tty/serial/8250/8250_exar.c:1573:3: note: insert 'break;' to avoid fall-through
    1573 |                 default:
         |                 ^
         |                 break; 
   2 warnings generated.


vim +1573 drivers/tty/serial/8250/8250_exar.c

  1547	
  1548	static unsigned int exar_get_nr_ports(struct exar8250_board *board,
  1549						struct pci_dev *pcidev)
  1550	{
  1551		unsigned int nr_ports = 0;
  1552	
  1553		if (!board || !pcidev)
  1554			return 0;
  1555	
  1556		if (pcidev->vendor == PCI_VENDOR_ID_ACCESSIO) {
  1557			nr_ports = BIT(((pcidev->device & 0x38) >> 3) - 1);
  1558		} else if (board->num_ports > 0) {
  1559			//Check if board struct overrides number of ports
  1560			nr_ports = board->num_ports;
  1561		} else if (pcidev->vendor == PCI_VENDOR_ID_EXAR) {
  1562			//Exar encodes # ports in last nibble of PCI Device ID ex. 0358
  1563			nr_ports = pcidev->device & 0x0f;
  1564		} else  if (pcidev->vendor == PCI_VENDOR_ID_CONNECT_TECH) {
  1565			//Handle CTI FPGA cards
  1566			switch (pcidev->device) {
  1567			case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_12_XIG00X:
  1568			case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_12_XIG01X:
  1569				nr_ports = 12;
  1570				break;
  1571			case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_16:
  1572				nr_ports = 16;
> 1573			default:
  1574				break;
  1575			}
  1576		}
  1577	
  1578		return nr_ports;
  1579	}
  1580	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

