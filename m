Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A02DA184A67
	for <lists+linux-pci@lfdr.de>; Fri, 13 Mar 2020 16:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgCMPRn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Mar 2020 11:17:43 -0400
Received: from foss.arm.com ([217.140.110.172]:57070 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbgCMPRn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Mar 2020 11:17:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E61F31B;
        Fri, 13 Mar 2020 08:17:42 -0700 (PDT)
Received: from [172.16.1.159] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1CCC73F67D;
        Fri, 13 Mar 2020 08:17:38 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] ACPI: APEI: Add support to notify the vendor
 specific HW errors
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "zhangliguang@linux.alibaba.com" <zhangliguang@linux.alibaba.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Linuxarm <linuxarm@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        tanxiaofei <tanxiaofei@huawei.com>,
        yangyicong <yangyicong@huawei.com>
References: <Shiju Jose> <20200207103143.20104-1-shiju.jose@huawei.com>
 <20200207103143.20104-2-shiju.jose@huawei.com>
 <4967c0e6-b264-a13a-28c7-5ca497442823@arm.com>
 <689f0c7cb0fe49d6a9df140cc1b56690@huawei.com>
From:   James Morse <james.morse@arm.com>
Openpgp: preference=signencrypt
Message-ID: <7c1a20de-746f-8fc2-29a1-6e5d607ebb48@arm.com>
Date:   Fri, 13 Mar 2020 15:17:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <689f0c7cb0fe49d6a9df140cc1b56690@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Shiju,

On 3/12/20 12:10 PM, Shiju Jose wrote:
>> On 07/02/2020 10:31, Shiju Jose wrote:
>>> Presently APEI does not support reporting the vendor specific HW
>>> errors, received in the vendor defined table entries, to the vendor
>>> drivers for any recovery.
>>>
>>> This patch adds the support to register and unregister the error
>>> handling function for the vendor specific HW errors and notify the
>>> registered kernel driver.
>>
>> Is it possible to use the kernel's existing atomic_notifier_chain_register() API for
>> this?
>>
>> The one thing that can't be done in the same way is the GUID filtering in ghes.c.
>> Each driver would need to check if the call matched a GUID they knew about,
>> and return NOTIFY_DONE if they "don't care".
>>
>> I think this patch would be a lot smaller if it was tweaked to be able to use the
>> existing API. If there is a reason not to use it, it would be good to know what it
>> is.

> I think when using atomic_notifier_chain_register we have following limitations,
> 1. All the registered error handlers would get called, though an error is not related to those handlers.    

The notifier chain provides NOTIFY_STOP_MASK, so that one of the callers
can say the work is done. We only expect a handful of these, so I don't
think there is going to be a scalability problem.


>     Also this may lead to mishandling of the error information if a handler does not
>     implement GUID checking etc.

Which would be a bug we can fix.
There is no point worrying about bugs in out of tree code.


> 2. atomic_notifier_chain_register (notifier_chain_register) looks like does not support 
>     pass the handler's private data during the registration which supposed to 
>     passed later in the call back function *notifier_fn_t(... ,void *data) to the handler.

The callback is provided with the struct notifier_block. A bit of
container_of() magic will give you whatever structure you embedded it in!


> 3. Also got difficulty in passing the ghes error data(acpi_hest_generic_data), GUID
>     for the error received to the handler through the notifier_chain  callback interface. 

Here you've lost me. Because you need to pass more than one thing? Can't
we have a struct for that?

But, isn't it all in struct acpi_hest_generic_data already? That is
where the guid and severity come from.


>>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c index
>>> 103acbb..69e18d7 100644
>>> --- a/drivers/acpi/apei/ghes.c
>>> +++ b/drivers/acpi/apei/ghes.c
>>> @@ -490,6 +490,109 @@ static void ghes_handle_aer(struct
>>> acpi_hest_generic_data *gdata)
>>
>>> +/**
>>> + * ghes_unregister_event_handler - unregister the previously
>>> + * registered event handling function.
>>> + * @sec_type: sec_type of the corresponding CPER.
>>> + * @data: driver specific data to distinguish devices.
>>> + */
>>> +void ghes_unregister_event_handler(guid_t sec_type, void *data) {
>>> +	struct ghes_event_notify *event_notify;
>>> +	bool found = false;
>>> +
>>> +	mutex_lock(&ghes_event_notify_mutex);
>>> +	rcu_read_lock();
>>> +	list_for_each_entry_rcu(event_notify,
>>> +				&ghes_event_handler_list, list) {
>>> +		if (guid_equal(&event_notify->sec_type, &sec_type)) {
>>
>>> +			if (data != event_notify->data)
>>
>> It looks like you need multiple drivers to handle the same GUID because of
>> multiple root ports. Can't the handler lookup the right device?

> This check was because GUID is shared among multiple devices with one driver as seen
> in the B2889FC9 driver (pcie-hisi-error.c). 

(we should stop calling it by its guid ... does it have a name?!)


This must be some kind of error collector for a bus right?

I agree we may need to have multiple drivers register to handle vendor
events, but it looks like you are registering the same handler multiple
times, with different private structures.

Can't it find the affected device from the error description?


>>> @@ -525,11 +628,14 @@ static void ghes_do_proc(struct ghes *ghes,
>>>
>>>  			log_arm_hw_error(err);
>>>  		} else {
>>> -			void *err = acpi_hest_get_payload(gdata);
>>> -
>>> -			log_non_standard_event(sec_type, fru_id, fru_text,
>>> -					       sec_sev, err,
>>> -					       gdata->error_data_length);
>>> +			if (!ghes_handle_non_standard_event(sec_type, gdata,
>>> +							    sev)) {
>>> +				void *err = acpi_hest_get_payload(gdata);
>>> +
>>> +				log_non_standard_event(sec_type, fru_id,
>>> +						       fru_text, sec_sev, err,
>>> +						       gdata->error_data_length);
>>> +			}
>>
>> So, a side effect of the kernel handling these is they no longer get logged out of
>> trace points?
>>
>> I guess the driver the claims this logs some more accurate information. Are
>> there expected to be any user-space programs doing something useful with
>> B2889FC9... today?

> The B2889FC9 driver does not expect any corresponding user space programs. 
> The driver mainly for the error recovery and basic error decoding and logging.

> Previously we added the error logging for the B2889FC9 in the rasdaemon.

So this series would break the error logging in rasdaemon.

User-space would need to be upgraded to receive the trace information
from the specific driver instead. (how does it know?!)

Could we log_non_standard_event() unconditionally, maybe adding a field
to indicate that a driver claimed it, so there may be more data
somewhere else...


Thanks,

James
