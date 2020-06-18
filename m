Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D4E1FF9D9
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jun 2020 19:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbgFRREU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Jun 2020 13:04:20 -0400
Received: from mga12.intel.com ([192.55.52.136]:18911 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728080AbgFRRES (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Jun 2020 13:04:18 -0400
IronPort-SDR: mJudlzBy5CgBteVYjBUp+ZaWnr0SOaMW0S2BhPzrM7x1XzJDmkKgRsvTU78pWtT289PU/xwFYy
 KQmyaGCrDqPQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="122411240"
X-IronPort-AV: E=Sophos;i="5.75,251,1589266800"; 
   d="scan'208";a="122411240"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 10:04:18 -0700
IronPort-SDR: 2gUCSVXlX5ylAJVF4QwcE0B9MofR7qkp80j9DIU+dI0X1ei5sbxmeZ1zAqvFyEzMz4Moemxtf1
 uv4bSt5vJbzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,251,1589266800"; 
   d="scan'208";a="309176337"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 18 Jun 2020 10:04:13 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jlxxX-00EJAf-Ne; Thu, 18 Jun 2020 20:04:15 +0300
Date:   Thu, 18 Jun 2020 20:04:15 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "zhangliguang@linux.alibaba.com" <zhangliguang@linux.alibaba.com>,
        "Wangkefeng (OS Kernel Lab)" <wangkefeng.wang@huawei.com>,
        "jroedel@suse.de" <jroedel@suse.de>,
        Linuxarm <linuxarm@huawei.com>,
        yangyicong <yangyicong@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        tanxiaofei <tanxiaofei@huawei.com>
Subject: Re: [PATCH v10 2/2] PCI: hip: Add handling of HiSilicon HIP PCIe
 controller errors
Message-ID: <20200618170415.GY2428291@smile.fi.intel.com>
References: <20200618154051.639-3-shiju.jose@huawei.com>
 <20200618155627.GX2428291@smile.fi.intel.com>
 <761e579035d346bf8cce2dfc6857587c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <761e579035d346bf8cce2dfc6857587c@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 18, 2020 at 04:35:31PM +0000, Shiju Jose wrote:
> >-----Original Message-----
> >From: Andy Shevchenko [mailto:andriy.shevchenko@linux.intel.com]
> >Sent: 18 June 2020 16:56
> >To: Shiju Jose <shiju.jose@huawei.com>
> >Cc: linux-acpi@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> >kernel@vger.kernel.org; rjw@rjwysocki.net; helgaas@kernel.org;
> >bp@alien8.de; james.morse@arm.com; lenb@kernel.org;
> >tony.luck@intel.com; dan.carpenter@oracle.com;
> >zhangliguang@linux.alibaba.com; Wangkefeng (OS Kernel Lab)
> ><wangkefeng.wang@huawei.com>; jroedel@suse.de; Linuxarm
> ><linuxarm@huawei.com>; yangyicong <yangyicong@huawei.com>; Jonathan
> >Cameron <jonathan.cameron@huawei.com>; tanxiaofei
> ><tanxiaofei@huawei.com>
> >Subject: Re: [PATCH v10 2/2] PCI: hip: Add handling of HiSilicon HIP PCIe
> >controller errors
> >
> >On Thu, Jun 18, 2020 at 04:40:51PM +0100, Shiju Jose wrote:

...

> >> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> >
> >Hmm... Did I give a tag?

Yes, and please, be sure that you got explicit tags from reviewers.

...

> >> +	for_each_set_bit_from(idx, (const unsigned long *)&edata->val_bits,
> >
> >Can't you make val_bits unsigned long? Because this casting is incorrect.
> >Otherwise, make a local copy into unsigned long variable.
> 
> The data val_bits in the error record is 64 bits, thus used u64.
> Casting is added because of a compilation warning on _find_nex_bit_ function as it 
> expects the type of the address as const unsigned long*.
> Probably I will make local copy of val_bits into unsigned long variable.

I see.  So, something like this:

	unsigned long bits[] = { BITMAP_FROM_U64(edata->val_bits) };
	...
	for_each_set_bit_from(i, bits, ...)
		...

looks plausible. Or if you have better idea...

-- 
With Best Regards,
Andy Shevchenko


