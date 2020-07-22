Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D49FA22984E
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jul 2020 14:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732239AbgGVMeZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 22 Jul 2020 08:34:25 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2510 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731857AbgGVMeZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Jul 2020 08:34:25 -0400
Received: from lhreml716-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id B4809598BED4F0C36017;
        Wed, 22 Jul 2020 13:34:23 +0100 (IST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 lhreml716-chm.china.huawei.com (10.201.108.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 22 Jul 2020 13:34:23 +0100
Received: from lhreml715-chm.china.huawei.com ([10.201.108.66]) by
 lhreml715-chm.china.huawei.com ([10.201.108.66]) with mapi id 15.01.1913.007;
 Wed, 22 Jul 2020 13:34:23 +0100
From:   Shiju Jose <shiju.jose@huawei.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
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
Subject: RE: [PATCH v13 1/2] ACPI / APEI: Add a notifier chain for unknown
 (vendor) CPER records
Thread-Topic: [PATCH v13 1/2] ACPI / APEI: Add a notifier chain for unknown
 (vendor) CPER records
Thread-Index: AQHWYBeNEuC2snlLPEu+XBWu+0jruKkTg3ww
Date:   Wed, 22 Jul 2020 12:34:23 +0000
Message-ID: <eb8336f0357f447baf5c37309d320f57@huawei.com>
References: <20200722103952.1009-1-shiju.jose@huawei.com>
 <20200722103952.1009-2-shiju.jose@huawei.com>
 <20200722110146.GW3703480@smile.fi.intel.com>
In-Reply-To: <20200722110146.GW3703480@smile.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.80.253]
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
>Sent: 22 July 2020 12:02
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: linux-acpi@vger.kernel.org; linux-pci@vger.kernel.org; linux-
>kernel@vger.kernel.org; rjw@rjwysocki.net; helgaas@kernel.org;
>bp@alien8.de; james.morse@arm.com; lenb@kernel.org;
>tony.luck@intel.com; dan.carpenter@oracle.com;
>zhangliguang@linux.alibaba.com; Wangkefeng (OS Kernel Lab)
><wangkefeng.wang@huawei.com>; jroedel@suse.de; Linuxarm
><linuxarm@huawei.com>; yangyicong <yangyicong@huawei.com>; Jonathan
>Cameron <jonathan.cameron@huawei.com>; tanxiaofei
><tanxiaofei@huawei.com>
>Subject: Re: [PATCH v13 1/2] ACPI / APEI: Add a notifier chain for unknown
>(vendor) CPER records
>
>On Wed, Jul 22, 2020 at 11:39:51AM +0100, Shiju Jose wrote:
>> CPER records describing a firmware-first error are identified by GUID.
>> The ghes driver currently logs, but ignores any unknown CPER records.
>> This prevents describing errors that can't be represented by a
>> standard entry, that would otherwise allow a driver to recover from an
>error.
>> The UEFI spec calls these 'Non-standard Section Body' (N.2.3 of
>> version 2.8).
>>
>> Add a notifier chain for these non-standard/vendor-records. Callers
>> must identify their type of records by GUID.
>>
>> Record data is copied to memory from the ghes_estatus_pool to allow us
>> to keep it until after the notifier has run.
>>
>> Co-developed-by: James Morse <james.morse@arm.com>
>
>Co-developed-by: is going _in conjunction with_ SoB tag which is missing
>here.
This tag was added as per instruction from Rafael.
I was told that I cannot add SoB tag for others unless specifically given.
Probably I will leave it with Rafael/James to help on this SoB tag
as Rafael was ok to merge this patch.
>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>
>--
>With Best Regards,
>Andy Shevchenko
>
Thanks,
Shiju


