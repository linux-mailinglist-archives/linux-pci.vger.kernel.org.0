Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B59161FAC6B
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jun 2020 11:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgFPJao (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Jun 2020 05:30:44 -0400
Received: from mga09.intel.com ([134.134.136.24]:8638 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgFPJan (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Jun 2020 05:30:43 -0400
IronPort-SDR: iFR7LcH94oAIZ8GHgGXd9u1TwuRxT7xfMIRvPghuCJL5IhrMBAjt+chZVY2k+JIiJ0L7S3rJ8L
 JfPVcMYQ8xKg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 02:30:42 -0700
IronPort-SDR: KLzQPjWcFHRtgbHeuBelZfUfPYOc1iTXGrzOnPnwrpXK/yyfwT9iv2qi1XQH4CDDeMxZdAIUjl
 Nhj2Zjmj9UBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,518,1583222400"; 
   d="scan'208";a="298839187"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004.fm.intel.com with ESMTP; 16 Jun 2020 02:30:38 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jl7vV-00DnWz-0Z; Tue, 16 Jun 2020 12:30:41 +0300
Date:   Tue, 16 Jun 2020 12:30:41 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "bp@alien8.de" <bp@alien8.de>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "zhangliguang@linux.alibaba.com" <zhangliguang@linux.alibaba.com>,
        "Wangkefeng (OS Kernel Lab)" <wangkefeng.wang@huawei.com>,
        "jroedel@suse.de" <jroedel@suse.de>,
        yangyicong <yangyicong@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        tanxiaofei <tanxiaofei@huawei.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v9 2/2] PCI: hip: Add handling of HiSilicon HIP PCIe
 controller errors
Message-ID: <20200616093041.GQ2428291@smile.fi.intel.com>
References: <20200615101552.802-3-shiju.jose@huawei.com>
 <20200615120053.GZ2428291@smile.fi.intel.com>
 <51550b510d1e40479bf4fce47443747c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51550b510d1e40479bf4fce47443747c@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 16, 2020 at 09:12:56AM +0000, Shiju Jose wrote:
> >-----Original Message-----
> >From: Andy Shevchenko [mailto:andriy.shevchenko@linux.intel.com]
> >Sent: 15 June 2020 13:01
> >To: Shiju Jose <shiju.jose@huawei.com>
> >Cc: linux-acpi@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> >kernel@vger.kernel.org; rjw@rjwysocki.net; bp@alien8.de;
> >james.morse@arm.com; lenb@kernel.org; tony.luck@intel.com;
> >dan.carpenter@oracle.com; zhangliguang@linux.alibaba.com; Wangkefeng
> >(OS Kernel Lab) <wangkefeng.wang@huawei.com>; jroedel@suse.de;
> >yangyicong <yangyicong@huawei.com>; Jonathan Cameron
> ><jonathan.cameron@huawei.com>; tanxiaofei <tanxiaofei@huawei.com>
> >Subject: Re: [PATCH v9 2/2] PCI: hip: Add handling of HiSilicon HIP PCIe
> >controller errors
> >
> >On Mon, Jun 15, 2020 at 11:15:52AM +0100, Shiju Jose wrote:

...

> >bits.h ?
> 
> Ok. I think bits.h was already included through some other .h files.

You have direct users of the header here.
The rule of thumb is to include all headers of which you have direct users.
Some exceptions of course can be applied, but for generic headers like bits.h
there are only bitops.h or bitmap.h that guarantee inclusion of the mentioned
macros / definitions.

I don't see any header of the same domain in the list.

...

> >> +#define HISI_PCIE_CORE_PORT_ID(v)        (((v) % 8) << 1)
> >
> >% -> & ?
> (((v) % 8) << 1) is correct. We can make bit operation instead. 

y % x is usually being used when we consume y / x or in cases when y is
advanced and we need to keep it under some threshold.

Here it's not obvious to me, and usual pattern is to use bitwise operations.

In any case some clarification is needed.

...

> >> +struct hisi_pcie_error_private {
> >> +	struct notifier_block	nb;
> >> +	struct platform_device	*pdev;
> >
> >Do you really need platform device? Isn't struct device * enough?
> We need platform device as the error recovery device is a platform device,
> which provides us the "RST" reset method.

Can't you derive platform device from struct device pointer?
I really didn't see an evidence you need to keep it like this.

And in probably single case you may derive it, no?

> >> +};

...

> >> +static char *hisi_pcie_sub_module_name(u8 id) {
> >> +	switch (id) {
> >> +	case HISI_PCIE_SUB_MODULE_ID_AP: return "AP Layer";
> >> +	case HISI_PCIE_SUB_MODULE_ID_TL: return "TL Layer";
> >> +	case HISI_PCIE_SUB_MODULE_ID_MAC: return "MAC Layer";
> >> +	case HISI_PCIE_SUB_MODULE_ID_DL: return "DL Layer";
> >> +	case HISI_PCIE_SUB_MODULE_ID_SDI: return "SDI Layer";
> >> +	}
> >
> >match_string() ?
> 
> match_string() does not work here because we need sub module id -> string
> conversion.

Why? Are you using non-sequential (a.k.a. sparse) values?

> >> +	return "unknown";
> >
> >> +}
> >> +
> >> +static char *hisi_pcie_error_severity(u8 err_sev) {
> >> +	switch (err_sev) {
> >> +	case HISI_ERR_SEV_RECOVERABLE: return "recoverable";
> >> +	case HISI_ERR_SEV_FATAL: return "fatal";
> >> +	case HISI_ERR_SEV_CORRECTED: return "corrected";
> >> +	case HISI_ERR_SEV_NONE: return "none";
> >> +	}
> >
> >Ditto?
> 
> Same as above.

Ditto.

> >> +	return "unknown";
> >> +}

...

> >> +	for (i = 0; i < HISI_PCIE_ERR_MISC_REGS; i++) {
> >> +		if (edata->val_bits &
> >> +				BIT_ULL(HISI_PCIE_LOCAL_VALID_ERR_MISC
> >+ i))
> >
> >for_each_set_bit() ?
> 
> Can't use for_each_set_bit() here because edata->val_bits contains valid bits for other fields of the error data
> as well, those need to printed separately.

So, I don't get why.

You have at least two possibilities:
1/ use bitwise & to drop non-related bits (maybe in temporary variable)
2/ use for_each_set_bit_from()

You really need to know better the kernel libraries.

...

> >> +	const struct hisi_pcie_error_data *error_data =
> >> +				acpi_hest_get_payload(gdata);
> >
> >One line is better to read.
> 
> Checkpatch warning, the length of line will exceed 80 characters. 

No, it doesn't. Perhaps time to update?

-- 
With Best Regards,
Andy Shevchenko


