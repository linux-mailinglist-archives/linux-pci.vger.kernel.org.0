Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957E022988F
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jul 2020 14:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732287AbgGVMun (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jul 2020 08:50:43 -0400
Received: from mga12.intel.com ([192.55.52.136]:51732 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732403AbgGVMun (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Jul 2020 08:50:43 -0400
IronPort-SDR: gc2gDjImpQl/19yooEfUs/V/rE8Q/ayd4ZUjX8ns3kelmArerLSykFF15w1eiOSr734mEqf1hi
 B1r7s2jKgHYQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="129885747"
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="129885747"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 05:50:42 -0700
IronPort-SDR: ieAHr7VF0k9hgkJb8fWkRy5vl4NG3H0pd7BXy7S9Yu5jgbaVe1/rs+buh675GE1bi/b0QuZ2wo
 Qg3VjLa7rptQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="392661642"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001.fm.intel.com with ESMTP; 22 Jul 2020 05:50:38 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jyECk-003GZO-Gd; Wed, 22 Jul 2020 15:50:38 +0300
Date:   Wed, 22 Jul 2020 15:50:38 +0300
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
Subject: Re: [PATCH v13 1/2] ACPI / APEI: Add a notifier chain for unknown
 (vendor) CPER records
Message-ID: <20200722125038.GZ3703480@smile.fi.intel.com>
References: <20200722103952.1009-1-shiju.jose@huawei.com>
 <20200722103952.1009-2-shiju.jose@huawei.com>
 <20200722110146.GW3703480@smile.fi.intel.com>
 <eb8336f0357f447baf5c37309d320f57@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb8336f0357f447baf5c37309d320f57@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 22, 2020 at 12:34:23PM +0000, Shiju Jose wrote:
> >-----Original Message-----
> >From: Andy Shevchenko [mailto:andriy.shevchenko@linux.intel.com]
> >Sent: 22 July 2020 12:02
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
> >Subject: Re: [PATCH v13 1/2] ACPI / APEI: Add a notifier chain for unknown
> >(vendor) CPER records
> >
> >On Wed, Jul 22, 2020 at 11:39:51AM +0100, Shiju Jose wrote:
> >> CPER records describing a firmware-first error are identified by GUID.
> >> The ghes driver currently logs, but ignores any unknown CPER records.
> >> This prevents describing errors that can't be represented by a
> >> standard entry, that would otherwise allow a driver to recover from an
> >error.
> >> The UEFI spec calls these 'Non-standard Section Body' (N.2.3 of
> >> version 2.8).
> >>
> >> Add a notifier chain for these non-standard/vendor-records. Callers
> >> must identify their type of records by GUID.
> >>
> >> Record data is copied to memory from the ghes_estatus_pool to allow us
> >> to keep it until after the notifier has run.
> >>
> >> Co-developed-by: James Morse <james.morse@arm.com>
> >
> >Co-developed-by: is going _in conjunction with_ SoB tag which is missing
> >here.
> This tag was added as per instruction from Rafael.
> I was told that I cannot add SoB tag for others unless specifically given.
> Probably I will leave it with Rafael/James to help on this SoB tag
> as Rafael was ok to merge this patch.

I think it's a misunderstanding somewhere. According to [1]:
"Since Co-developed-by: denotes authorship, every Co-developed-by: must be
immediately followed by a Signed-off-by: of the associated co-author."

It means either both or none.

[1]: https://www.kernel.org/doc/html/latest/process/submitting-patches.html

-- 
With Best Regards,
Andy Shevchenko


