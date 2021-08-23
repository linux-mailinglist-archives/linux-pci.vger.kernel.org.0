Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8853F45D8
	for <lists+linux-pci@lfdr.de>; Mon, 23 Aug 2021 09:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235136AbhHWHgG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Aug 2021 03:36:06 -0400
Received: from mga05.intel.com ([192.55.52.43]:59624 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235110AbhHWHgF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Aug 2021 03:36:05 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10084"; a="302637451"
X-IronPort-AV: E=Sophos;i="5.84,343,1620716400"; 
   d="scan'208";a="302637451"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 00:35:23 -0700
X-IronPort-AV: E=Sophos;i="5.84,343,1620716400"; 
   d="scan'208";a="492581852"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 00:35:22 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mI4UG-00ChIK-Kx; Mon, 23 Aug 2021 10:35:16 +0300
Date:   Mon, 23 Aug 2021 10:35:16 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [pci:pci/misc 7/7] include/linux/pci.h:1725:54: error: parameter
 name omitted
Message-ID: <YSNPtLQ5q1poPb6x@smile.fi.intel.com>
References: <202108211050.dQMdCDWM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202108211050.dQMdCDWM-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Aug 21, 2021 at 10:44:06AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/misc
> head:   81e2ce35df9102989cefe180f41d78dd7fb8c9b9
> commit: 81e2ce35df9102989cefe180f41d78dd7fb8c9b9 [7/7] PCI: Sync __pci_register_driver() stub for CONFIG_PCI=n
> config: i386-tinyconfig (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?id=81e2ce35df9102989cefe180f41d78dd7fb8c9b9
>         git remote add pci https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
>         git fetch --no-tags pci pci/misc
>         git checkout 81e2ce35df9102989cefe180f41d78dd7fb8c9b9
>         # save the attached .config to linux build tree
>         mkdir build_dir
>         make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/kernel/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

For the record, I copied a prototype from the other one.
If we need to fix, we need to fix them both.

I'll cook the patch.

-- 
With Best Regards,
Andy Shevchenko


