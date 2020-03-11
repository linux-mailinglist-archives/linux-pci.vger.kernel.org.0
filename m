Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEFF181F7C
	for <lists+linux-pci@lfdr.de>; Wed, 11 Mar 2020 18:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730388AbgCKR3h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Mar 2020 13:29:37 -0400
Received: from foss.arm.com ([217.140.110.172]:52574 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730385AbgCKR3g (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Mar 2020 13:29:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DEEC1FB;
        Wed, 11 Mar 2020 10:29:36 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3991D3F6CF;
        Wed, 11 Mar 2020 10:29:34 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] ACPI: APEI: Add support to notify the vendor
 specific HW errors
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        helgaas@kernel.org, lenb@kernel.org, bp@alien8.de,
        tony.luck@intel.com, gregkh@linuxfoundation.org,
        zhangliguang@linux.alibaba.com, tglx@linutronix.de,
        linuxarm@huawei.com, jonathan.cameron@huawei.com,
        tanxiaofei@huawei.com, yangyicong@hisilicon.com
References: <Shiju Jose> <20200207103143.20104-1-shiju.jose@huawei.com>
 <20200207103143.20104-2-shiju.jose@huawei.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <4967c0e6-b264-a13a-28c7-5ca497442823@arm.com>
Date:   Wed, 11 Mar 2020 17:29:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200207103143.20104-2-shiju.jose@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Shiju,

On 07/02/2020 10:31, Shiju Jose wrote:
> Presently APEI does not support reporting the vendor specific
> HW errors, received in the vendor defined table entries, to the
> vendor drivers for any recovery.
> 
> This patch adds the support to register and unregister the
> error handling function for the vendor specific HW errors and
> notify the registered kernel driver.

Is it possible to use the kernel's existing atomic_notifier_chain_register() API for this?

The one thing that can't be done in the same way is the GUID filtering in ghes.c. Each
driver would need to check if the call matched a GUID they knew about, and return
NOTIFY_DONE if they "don't care".

I think this patch would be a lot smaller if it was tweaked to be able to use the existing
API. If there is a reason not to use it, it would be good to know what it is.


> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 103acbb..69e18d7 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -490,6 +490,109 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)

> +/**
> + * ghes_unregister_event_handler - unregister the previously
> + * registered event handling function.
> + * @sec_type: sec_type of the corresponding CPER.
> + * @data: driver specific data to distinguish devices.
> + */
> +void ghes_unregister_event_handler(guid_t sec_type, void *data)
> +{
> +	struct ghes_event_notify *event_notify;
> +	bool found = false;
> +
> +	mutex_lock(&ghes_event_notify_mutex);
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(event_notify,
> +				&ghes_event_handler_list, list) {
> +		if (guid_equal(&event_notify->sec_type, &sec_type)) {

> +			if (data != event_notify->data)

It looks like you need multiple drivers to handle the same GUID because of multiple root
ports. Can't the handler lookup the right device?


> +				continue;
> +			list_del_rcu(&event_notify->list);
> +			found = true;
> +			break;
> +		}
> +	}
> +	rcu_read_unlock();
> +	mutex_unlock(&ghes_event_notify_mutex);
> +
> +	if (!found) {
> +		pr_err("Tried to unregister a GHES event handler that has not been registered\n");
> +		return;
> +	}
> +
> +	synchronize_rcu();
> +	kfree(event_notify);
> +}
> +EXPORT_SYMBOL_GPL(ghes_unregister_event_handler);

> @@ -525,11 +628,14 @@ static void ghes_do_proc(struct ghes *ghes,
>  
>  			log_arm_hw_error(err);
>  		} else {
> -			void *err = acpi_hest_get_payload(gdata);
> -
> -			log_non_standard_event(sec_type, fru_id, fru_text,
> -					       sec_sev, err,
> -					       gdata->error_data_length);
> +			if (!ghes_handle_non_standard_event(sec_type, gdata,
> +							    sev)) {
> +				void *err = acpi_hest_get_payload(gdata);
> +
> +				log_non_standard_event(sec_type, fru_id,
> +						       fru_text, sec_sev, err,
> +						       gdata->error_data_length);
> +			}

So, a side effect of the kernel handling these is they no longer get logged out of trace
points?

I guess the driver the claims this logs some more accurate information. Are there expected
to be any user-space programs doing something useful with B2889FC9... today?


Thanks,

James
