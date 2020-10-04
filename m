Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFF32828F2
	for <lists+linux-pci@lfdr.de>; Sun,  4 Oct 2020 06:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbgJDE5v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 4 Oct 2020 00:57:51 -0400
Received: from mga01.intel.com ([192.55.52.88]:60183 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgJDE5v (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 4 Oct 2020 00:57:51 -0400
IronPort-SDR: xsJTYiHMU9isfRf2SZdE1jwUUhtgnF3UIROIT03V2xI1dTi4IJKmnw/pBHKKsQxhVtCZMDjOkh
 DIJHf5af6pLQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9763"; a="181387079"
X-IronPort-AV: E=Sophos;i="5.77,334,1596524400"; 
   d="scan'208";a="181387079"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2020 21:57:50 -0700
IronPort-SDR: 1m64lsAECejvgOfT786z1x8HjoeT8NuY7DMdZ6dxJj68S/dd4q6aoFI3R85h+1em24QBB7Fadh
 rBV9lTPdiMIA==
X-IronPort-AV: E=Sophos;i="5.77,334,1596524400"; 
   d="scan'208";a="517996501"
Received: from araj-mobl1.jf.intel.com ([10.251.22.42])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2020 21:57:48 -0700
Date:   Sat, 3 Oct 2020 21:57:47 -0700
From:   "Raj, Ashok" <ashok.raj@linux.intel.com>
To:     Ethan Zhao <haifeng.zhao@intel.com>
Cc:     bhelgaas@google.com, oohall@gmail.com, ruscur@russell.cc,
        lukas@wunner.de, andriy.shevchenko@linux.intel.com,
        stuart.w.hayes@gmail.com, mr.nuke.me@gmail.com,
        mika.westerberg@linux.intel.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, sathyanarayanan.kuppuswamy@intel.com,
        xerces.zhao@gmail.com, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v7 0/5] Fix DPC hotplug race and enhance error handling
Message-ID: <20201004045745.GA3207@araj-mobl1.jf.intel.com>
References: <20201003075514.32935-1-haifeng.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201003075514.32935-1-haifeng.zhao@intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Ethan

On Sat, Oct 03, 2020 at 03:55:09AM -0400, Ethan Zhao wrote:
> Hi,folks,
> 
> This simple patch set fixed some serious security issues found when DPC
> error injection and NVMe SSD hotplug brute force test were doing -- race
> condition between DPC handler and pciehp, AER interrupt handlers, caused
> system hang and system with DPC feature couldn't recover to normal
> working state as expected (NVMe instance lost, mount operation hang,
> race PCIe access caused uncorrectable errors reported alternatively etc).

I think maybe picking from other commit messages to make this description in 
cover letter bit clear. The fundamental premise is that when due to error
conditions when events are processed by both DPC handler and hotplug handling of 
DLLSC both operating on the same device object ends up with crashes.


> 
> With this patch set applied, stable 5.9-rc6 on ICS (Ice Lake SP platform,
> see
> https://en.wikichip.org/wiki/intel/microarchitectures/ice_lake_(server))
> 
> could pass the PCIe Gen4 NVMe SSD brute force hotplug test with any time
> interval between hot-remove and plug-in operation tens of times without
> any errors occur and system works normal.

> 
> With this patch set applied, system with DPC feature could recover from
> NON-FATAL and FATAL errors injection test and works as expected.
> 
> System works smoothly when errors happen while hotplug is doing, no
> uncorrectable errors found.
> 
> Brute DPC error injection script:
> 
> for i in {0..100}
> do
>         setpci -s 64:02.0 0x196.w=000a
>         setpci -s 65:00.0 0x04.w=0544
>         mount /dev/nvme0n1p1 /root/nvme
>         sleep 1
> done
> 
> Other details see every commits description part.
> 
> This patch set could be applied to stable 5.9-rc6/rc7 directly.
> 
> Help to review and test.
> 
> v2: changed according to review by Andy Shevchenko.
> v3: changed patch 4/5 to simpler coding.
> v4: move function pci_wait_port_outdpc() to DPC driver and its
>    declaration to pci.h. (tip from Christoph Hellwig <hch@infradead.org>).
> v5: fix building issue reported by lkp@intel.com with some config.
> v6: move patch[3/5] as the first patch according to Lukas's suggestion.
>     and rewrite the comment part of patch[3/5].
> v7: change the patch[4/5], based on Bjorn's code and truth table.
>     change the patch[5/5] about the debug output information.
> 
> Thanks,
> Ethan 
> 
> 
> Ethan Zhao (5):
>   PCI/ERR: get device before call device driver to avoid NULL pointer
>     dereference
>   PCI/DPC: define a function to check and wait till port finish DPC
>     handling
>   PCI: pciehp: check and wait port status out of DPC before handling
>     DLLSC and PDC
>   PCI: only return true when dev io state is really changed
>   PCI/ERR: don't mix io state not changed and no driver together
> 
>  drivers/pci/hotplug/pciehp_hpc.c |  4 ++-
>  drivers/pci/pci.h                | 55 +++++++++++++-------------------
>  drivers/pci/pcie/dpc.c           | 27 ++++++++++++++++
>  drivers/pci/pcie/err.c           | 18 +++++++++--
>  4 files changed, 68 insertions(+), 36 deletions(-)
> 
> 
> base-commit: a1b8638ba1320e6684aa98233c15255eb803fac7
> -- 
> 2.18.4
> 
