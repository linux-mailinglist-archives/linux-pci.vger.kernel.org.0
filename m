Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4D561FB10F
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jun 2020 14:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbgFPMqf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 16 Jun 2020 08:46:35 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2315 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726526AbgFPMqf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Jun 2020 08:46:35 -0400
Received: from lhreml721-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 952434D3FD68B8FF1BE1;
        Tue, 16 Jun 2020 13:46:33 +0100 (IST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 lhreml721-chm.china.huawei.com (10.201.108.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 16 Jun 2020 13:46:33 +0100
Received: from lhreml715-chm.china.huawei.com ([10.201.108.66]) by
 lhreml715-chm.china.huawei.com ([10.201.108.66]) with mapi id 15.01.1913.007;
 Tue, 16 Jun 2020 13:46:33 +0100
From:   Shiju Jose <shiju.jose@huawei.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
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
Subject: RE: [PATCH v9 2/2] PCI: hip: Add handling of HiSilicon HIP PCIe
 controller errors
Thread-Topic: [PATCH v9 2/2] PCI: hip: Add handling of HiSilicon HIP PCIe
 controller errors
Thread-Index: AQHWQv5GPLiMMOPNiU6kqnJ8IzwlUKjZgnyAgAFqP0D///4fgIAAHHEAgAAYvgCAABDdQA==
Date:   Tue, 16 Jun 2020 12:46:32 +0000
Message-ID: <7a2aa2ac6ee6439096b26cc204194e58@huawei.com>
References: <20200615101552.802-3-shiju.jose@huawei.com>
 <20200615120053.GZ2428291@smile.fi.intel.com>
 <51550b510d1e40479bf4fce47443747c@huawei.com>
 <20200616093041.GQ2428291@smile.fi.intel.com>
 <997bd6a17f54433dbdd2c43155682bdd@huawei.com>
 <20200616124102.GS2428291@smile.fi.intel.com>
In-Reply-To: <20200616124102.GS2428291@smile.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.82.233]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Andy,

>-----Original Message-----
>From: Andy Shevchenko [mailto:andriy.shevchenko@linux.intel.com]
>Sent: 16 June 2020 13:41
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: linux-acpi@vger.kernel.org; linux-pci@vger.kernel.org; linux-
>kernel@vger.kernel.org; rjw@rjwysocki.net; bp@alien8.de;
>james.morse@arm.com; lenb@kernel.org; tony.luck@intel.com;
>dan.carpenter@oracle.com; zhangliguang@linux.alibaba.com; Wangkefeng
>(OS Kernel Lab) <wangkefeng.wang@huawei.com>; jroedel@suse.de;
>yangyicong <yangyicong@huawei.com>; Jonathan Cameron
><jonathan.cameron@huawei.com>; tanxiaofei <tanxiaofei@huawei.com>;
>Linuxarm <linuxarm@huawei.com>
>Subject: Re: [PATCH v9 2/2] PCI: hip: Add handling of HiSilicon HIP PCIe
>controller errors
>
>On Tue, Jun 16, 2020 at 11:55:46AM +0000, Shiju Jose wrote:
>> >From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
>> >owner@vger.kernel.org] On Behalf Of Andy Shevchenko On Tue, Jun 16,
>> >2020 at 09:12:56AM +0000, Shiju Jose wrote:
>> >> >From: Andy Shevchenko [mailto:andriy.shevchenko@linux.intel.com]
>> >> >On Mon, Jun 15, 2020 at 11:15:52AM +0100, Shiju Jose wrote:
>
>...
>
>> >> >> +#define HISI_PCIE_CORE_PORT_ID(v)        (((v) % 8) << 1)
>> >> >
>> >> >% -> & ?
>> >> (((v) % 8) << 1) is correct. We can make bit operation instead.
>> >
>> >y % x is usually being used when we consume y / x or in cases when y
>> >is advanced and we need to keep it under some threshold.
>> >
>> >Here it's not obvious to me, and usual pattern is to use bitwise
>operations.
>> >
>> >In any case some clarification is needed.
>> We want (v % 8) * 2 here to get the core port id, a numerical value but not
>a bit mask.
>> Maybe you want us to use ((v) & 7) << 1?
>> please point it out if I understand wrong.
>
>I understand the result, I do not understand the properties of v.
>So, looks like
>a) (v & 7) << 1 // take 3 LSBs from v and shift right to get port id pair (looks
>like)
>b) (v % 8) * 2 // get next free port or circle over 0 if no free pair found
>
>Add some comment explaining what's going on.
Sure.

>
>...
>
>> >> >> +	switch (id) {
>> >> >> +	case HISI_PCIE_SUB_MODULE_ID_AP: return "AP Layer";
>> >> >> +	case HISI_PCIE_SUB_MODULE_ID_TL: return "TL Layer";
>> >> >> +	case HISI_PCIE_SUB_MODULE_ID_MAC: return "MAC Layer";
>> >> >> +	case HISI_PCIE_SUB_MODULE_ID_DL: return "DL Layer";
>> >> >> +	case HISI_PCIE_SUB_MODULE_ID_SDI: return "SDI Layer";
>> >> >> +	}
>> >> >
>> >> >match_string() ?
>> >>
>> >> match_string() does not work here because we need sub module id ->
>> >> string conversion.
>> >
>> >Why? Are you using non-sequential (a.k.a. sparse) values?
>> These are the sequential values.
>> I mean in this case we do not have the third parameter to the
>> match_string(), string to match with the strings in the array, we just
>> have the value for the sub module id.
>> Can you suggest some example of match_string() for the similar case?
>
>Ah, I realize, this is the opposite, but still perhaps better to have like this:
>
>static const char * const foo[] = {
>	"AB",
>	"CD",
>};
>
>const char *bar(int id)
>{
>	if (id >= ARRAY_SIZE(foo))
>		return "unknown"; // whatever
>	return foo[id];
>}
Sure.
  
>
>--
>With Best Regards,
>Andy Shevchenko
>
Thanks,
Shiju

