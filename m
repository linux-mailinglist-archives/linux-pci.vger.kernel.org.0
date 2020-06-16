Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50FD81FB0F7
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jun 2020 14:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbgFPMlG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Jun 2020 08:41:06 -0400
Received: from mga18.intel.com ([134.134.136.126]:48041 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726306AbgFPMlF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Jun 2020 08:41:05 -0400
IronPort-SDR: eq2ZSpfo2iaJkO/es74Uw/dHpTc/lYBTq7se63Da0viDk5T0FspjVEPxYjAYHXb26B+CU+AVfM
 zd1FpYV9Fd5A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 05:41:04 -0700
IronPort-SDR: TTPVIOf6LOi/jeY6al32iGDnRQCJtoldOC1vbMn37kUALIjrN0MwfHLxjN/V1FCMjEPmE0rE85
 osNQGX70/qPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,518,1583222400"; 
   d="scan'208";a="298888491"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004.fm.intel.com with ESMTP; 16 Jun 2020 05:41:00 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jlAti-00DpCD-Rh; Tue, 16 Jun 2020 15:41:02 +0300
Date:   Tue, 16 Jun 2020 15:41:02 +0300
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
Message-ID: <20200616124102.GS2428291@smile.fi.intel.com>
References: <20200615101552.802-3-shiju.jose@huawei.com>
 <20200615120053.GZ2428291@smile.fi.intel.com>
 <51550b510d1e40479bf4fce47443747c@huawei.com>
 <20200616093041.GQ2428291@smile.fi.intel.com>
 <997bd6a17f54433dbdd2c43155682bdd@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <997bd6a17f54433dbdd2c43155682bdd@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 16, 2020 at 11:55:46AM +0000, Shiju Jose wrote:
> >From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> >owner@vger.kernel.org] On Behalf Of Andy Shevchenko
> >On Tue, Jun 16, 2020 at 09:12:56AM +0000, Shiju Jose wrote:
> >> >From: Andy Shevchenko [mailto:andriy.shevchenko@linux.intel.com]
> >> >On Mon, Jun 15, 2020 at 11:15:52AM +0100, Shiju Jose wrote:

...

> >> >> +#define HISI_PCIE_CORE_PORT_ID(v)        (((v) % 8) << 1)
> >> >
> >> >% -> & ?
> >> (((v) % 8) << 1) is correct. We can make bit operation instead.
> >
> >y % x is usually being used when we consume y / x or in cases when y is
> >advanced and we need to keep it under some threshold.
> >
> >Here it's not obvious to me, and usual pattern is to use bitwise operations.
> >
> >In any case some clarification is needed.
> We want (v % 8) * 2 here to get the core port id, a numerical value but not a bit mask.
> Maybe you want us to use ((v) & 7) << 1? 
> please point it out if I understand wrong.

I understand the result, I do not understand the properties of v.
So, looks like
a) (v & 7) << 1 // take 3 LSBs from v and shift right to get port id pair (looks like)
b) (v % 8) * 2 // get next free port or circle over 0 if no free pair found

Add some comment explaining what's going on.

...

> >> >> +	switch (id) {
> >> >> +	case HISI_PCIE_SUB_MODULE_ID_AP: return "AP Layer";
> >> >> +	case HISI_PCIE_SUB_MODULE_ID_TL: return "TL Layer";
> >> >> +	case HISI_PCIE_SUB_MODULE_ID_MAC: return "MAC Layer";
> >> >> +	case HISI_PCIE_SUB_MODULE_ID_DL: return "DL Layer";
> >> >> +	case HISI_PCIE_SUB_MODULE_ID_SDI: return "SDI Layer";
> >> >> +	}
> >> >
> >> >match_string() ?
> >>
> >> match_string() does not work here because we need sub module id ->
> >> string conversion.
> >
> >Why? Are you using non-sequential (a.k.a. sparse) values?
> These are the sequential values.
> I mean in this case we do not have the third parameter to the match_string(),
> string to match with the strings in the array,
> we just have the value for the sub module id.
> Can you suggest some example of match_string()
> for the similar case?

Ah, I realize, this is the opposite, but still perhaps better to have like this:

static const char * const foo[] = {
	"AB",
	"CD",
};

const char *bar(int id)
{
	if (id >= ARRAY_SIZE(foo))
		return "unknown"; // whatever
	return foo[id];
}

-- 
With Best Regards,
Andy Shevchenko


