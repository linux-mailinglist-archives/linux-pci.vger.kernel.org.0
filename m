Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E618D1B2AF6
	for <lists+linux-pci@lfdr.de>; Tue, 21 Apr 2020 17:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbgDUPSH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 21 Apr 2020 11:18:07 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2077 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725613AbgDUPSH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 Apr 2020 11:18:07 -0400
Received: from lhreml721-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id BF833D248BFA70D8CFB2;
        Tue, 21 Apr 2020 16:18:05 +0100 (IST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 lhreml721-chm.china.huawei.com (10.201.108.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 21 Apr 2020 16:18:05 +0100
Received: from lhreml715-chm.china.huawei.com ([10.201.108.66]) by
 lhreml715-chm.china.huawei.com ([10.201.108.66]) with mapi id 15.01.1913.007;
 Tue, 21 Apr 2020 16:18:04 +0100
From:   Shiju Jose <shiju.jose@huawei.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "bp@alien8.de" <bp@alien8.de>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "zhangliguang@linux.alibaba.com" <zhangliguang@linux.alibaba.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Linuxarm <linuxarm@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        tanxiaofei <tanxiaofei@huawei.com>,
        yangyicong <yangyicong@huawei.com>
Subject: RE: [RESEND PATCH v7 4/6] ACPI / APEI: Add callback for ARM HW errors
 to the GHES notifier
Thread-Topic: [RESEND PATCH v7 4/6] ACPI / APEI: Add callback for ARM HW
 errors to the GHES notifier
Thread-Index: AQHWF+AgGjWUb7UHikyyLKOn1rsB1aiDjc8AgAAhSyA=
Date:   Tue, 21 Apr 2020 15:18:04 +0000
Message-ID: <19755019addc4fc3bbac5238157dee2c@huawei.com>
References: <ShijuJose> <20200421132136.1595-1-shiju.jose@huawei.com>
 <20200421132136.1595-5-shiju.jose@huawei.com> <20200421141426.GD2682@kadam>
In-Reply-To: <20200421141426.GD2682@kadam>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.83.77]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Dan,

>-----Original Message-----
>From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
>Sent: 21 April 2020 15:14
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: linux-acpi@vger.kernel.org; linux-pci@vger.kernel.org; linux-
>kernel@vger.kernel.org; rjw@rjwysocki.net; bp@alien8.de;
>james.morse@arm.com; helgaas@kernel.org; lenb@kernel.org;
>tony.luck@intel.com; gregkh@linuxfoundation.org;
>zhangliguang@linux.alibaba.com; tglx@linutronix.de; Linuxarm
><linuxarm@huawei.com>; Jonathan Cameron
><jonathan.cameron@huawei.com>; tanxiaofei <tanxiaofei@huawei.com>;
>yangyicong <yangyicong@huawei.com>
>Subject: Re: [RESEND PATCH v7 4/6] ACPI / APEI: Add callback for ARM HW
>errors to the GHES notifier
>
>On Tue, Apr 21, 2020 at 02:21:34PM +0100, Shiju Jose wrote:
>>  static BLOCKING_NOTIFIER_HEAD(ghes_event_notify_list);
>> @@ -670,12 +692,7 @@ static void ghes_do_proc(struct ghes *ghes,
>>  			pr_warn(GHES_PFX "ghes event queue full\n");
>>  			break;
>>  		}
>> -
>> -		if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
>> -			struct cper_sec_proc_arm *err =
>acpi_hest_get_payload(gdata);
>> -
>> -			log_arm_hw_error(err);
>> -		} else {
>> +		{
>>  			void *err = acpi_hest_get_payload(gdata);
>
>This is ugly.  Just move the "void *err;" declaration to the top of the function
>so we can delete this block.
Ok. I will change. 
>
>>
>>  			log_non_standard_event(sec_type, fru_id, fru_text,
>> --
>
>regards,
>dan carpenter

Thanks,
Shiju
