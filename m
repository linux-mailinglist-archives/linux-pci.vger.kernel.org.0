Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18AB81FFAF2
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jun 2020 20:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgFRSU2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Jun 2020 14:20:28 -0400
Received: from foss.arm.com ([217.140.110.172]:57036 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725953AbgFRSU1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Jun 2020 14:20:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7AF5E31B;
        Thu, 18 Jun 2020 11:20:26 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8434D3F73C;
        Thu, 18 Jun 2020 11:20:23 -0700 (PDT)
Subject: Re: [PATCH v9 1/2] ACPI / APEI: Add support to notify the vendor
 specific HW errors
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net, bp@alien8.de,
        lenb@kernel.org, tony.luck@intel.com, dan.carpenter@oracle.com,
        zhangliguang@linux.alibaba.com, andriy.shevchenko@linux.intel.com,
        wangkefeng.wang@huawei.com, jroedel@suse.de,
        yangyicong@hisilicon.com, jonathan.cameron@huawei.com,
        tanxiaofei@huawei.com
References: <20200615095312.398-1-shiju.jose@huawei.com>
 <20200615095312.398-2-shiju.jose@huawei.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <f6d4282e-08a4-7832-9dbc-6a4c0366eefd@arm.com>
Date:   Thu, 18 Jun 2020 19:20:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200615095312.398-2-shiju.jose@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Shiju,

On 15/06/2020 10:53, Shiju Jose wrote:
> Add support to notify the vendor specific non-fatal HW errors
> to the drivers for the error recovery.

This doesn't apply cleanly to v5.8-rc1... thanks for waiting for the merge window to
finish, but please rebase onto the latest and greatest kernel!

I'm glad the notifier chains for stuff that should be built-in has gone.
(In my opinion, the RAS code should be moving in the direction of having less code run
between being told of an error, and the handler running. Notifier chains for things like
memory-errors was moving in the wrong direction!)


The Kfifo and pool are adding complexity I don't think you need.
Please make it clear from the naming this is for vendor records. (what is an event?)

The memcpy() for the records is annoying, but eliminating it takes some really invasive
changes. Lets live with it for now.


> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 24c9642e8fc7..854d8115cdfc 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -63,6 +64,11 @@
>  #define GHES_ESTATUS_CACHES_SIZE	4
>  
>  #define GHES_ESTATUS_IN_CACHE_MAX_NSEC	10000000000ULL
> +
> +#define GHES_EVENT_RING_SIZE	256
> +#define GHES_GDATA_POOL_MIN_ALLOC_ORDER	3
> +#define GHES_GDATA_POOL_MIN_SIZE	65536

Huh. Another pool of memory, and we don't know if this will ever be used.
Can we allocate from ghes_estatus_pool instead?

ghes_estatus_pool is already scaled with the number of error sources firmware describes in
ghes_estatus_pool_init(), so it should be big enough.

ghes_estatus_pool already has multiple users, estatus_nodes for work deferred from NMI
come from here, as do ghes_estatus_caches for the low-pass filter thing.


> @@ -122,6 +128,19 @@ static DEFINE_MUTEX(ghes_list_mutex);
>   */
>  static DEFINE_SPINLOCK(ghes_notify_lock_irq);
>  
> +struct ghes_event_entry {

ghes_vendor_record_entry ?

> +	struct acpi_hest_generic_data *gdata;
> +	int error_severity;
> +};

> +static DEFINE_KFIFO(ghes_event_ring, struct ghes_event_entry,
> +		    GHES_EVENT_RING_SIZE);
> +
> +static DEFINE_SPINLOCK(ghes_event_ring_lock);

Do you need the FIFO behaviour?
If you put a work_struct in the struct and schedule_work() that, these would run in any
order, and it would be less code.


> +static struct gen_pool *ghes_gdata_pool;
> +static unsigned long ghes_gdata_pool_size_request;
> +
>  static struct gen_pool *ghes_estatus_pool;
>  static unsigned long ghes_estatus_pool_size_request;

Please use the existing ghes_estatus_pool.


> @@ -188,6 +207,40 @@ int ghes_estatus_pool_init(int num_ghes)

[...]

> +static int ghes_gdata_pool_init(void)
> +{
> +	unsigned long addr, len;
> +	int rc;
> +
> +	ghes_gdata_pool = gen_pool_create(GHES_GDATA_POOL_MIN_ALLOC_ORDER, -1);
> +	if (!ghes_gdata_pool)
> +		return -ENOMEM;
> +
> +	if (ghes_gdata_pool_size_request < GHES_GDATA_POOL_MIN_SIZE)
> +		ghes_gdata_pool_size_request = GHES_GDATA_POOL_MIN_SIZE;
> +
> +	len = ghes_gdata_pool_size_request;
> +	addr = (unsigned long)vmalloc(PAGE_ALIGN(len));
> +	if (!addr)
> +		goto err_pool_alloc;

> +	vmalloc_sync_mappings();
(This isn't needed anymore. See commit 73f693c3a705 ("mm: remove
vmalloc_sync_(un)mappings()"))


> +	rc = gen_pool_add(ghes_gdata_pool, addr, PAGE_ALIGN(len), -1);
> +	if (rc)
> +		goto err_pool_add;
> +
> +	return 0;
> +
> +err_pool_add:
> +	vfree((void *)addr);
> +
> +err_pool_alloc:
> +	gen_pool_destroy(ghes_gdata_pool);
> +
> +	return -ENOMEM;
> +}

But: using ghes_estatus_pool would avoid this duplication.


> @@ -247,6 +300,10 @@ static struct ghes *ghes_new(struct acpi_hest_generic *generic)
>  		goto err_unmap_status_addr;
>  	}
>  
> +	ghes_gdata_pool_size_request += generic->records_to_preallocate *
> +					generic->max_sections_per_record *
> +					generic->max_raw_data_length;
> +

Careful, I think ghes_probe() can run in parallel on different CPUs. You can certainly
unbind/rebind it from user-space.

I recall these max this/that/preallocate stuff are junk values on some platform.
You'd at least need to cap it to sane maximum value.

But: Using ghes_estatus_pool would use ghes_estatus_pool_init()'s sizes, which allocates
64K for each error source.

History: https://www.spinics.net/lists/linux-acpi/msg84238.html


> @@ -490,6 +547,68 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)

[...]

> +static void ghes_event_work_func(struct work_struct *work)
> +{
> +	struct ghes_event_entry entry;
> +	u32 len;
> +
> +	while (kfifo_get(&ghes_event_ring, &entry)) {
> +		blocking_notifier_call_chain(&ghes_event_notify_list,
> +					     entry.error_severity,
> +					     entry.gdata);
> +		len = acpi_hest_get_record_size(entry.gdata);
> +		gen_pool_free(ghes_gdata_pool, (unsigned long)entry.gdata, len);
> +	}
> +}
> +
> +static DECLARE_WORK(ghes_event_work, ghes_event_work_func);
> +
> +static void ghes_handle_non_standard_event(struct acpi_hest_generic_data *gdata,
> +					   int sev)
> +{
> +	u32 len;

> +	struct ghes_event_entry event_entry;

> +	len = acpi_hest_get_record_size(gdata);
> +	event_entry.gdata = (void *)gen_pool_alloc(ghes_gdata_pool, len);
> +	if (event_entry.gdata) {
> +		memcpy(event_entry.gdata, gdata, len);
> +		event_entry.error_severity = sev;
> +
> +		if (kfifo_in_spinlocked(&ghes_event_ring, &event_entry, 1,

... event_entry is on the stack ...


> +					&ghes_event_ring_lock))
> +			schedule_work(&ghes_event_work);
> +		else
> +			pr_warn(GHES_PFX "ghes event queue full\n");
> +	}
> +}


I think the kfifo is adding un-needed complexity here.


> diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
> index e3f1cddb4ac8..a3dd82069069 100644
> --- a/include/acpi/ghes.h
> +++ b/include/acpi/ghes.h
> @@ -50,6 +50,34 @@ enum {

> +#ifdef CONFIG_ACPI_APEI_GHES
> +/**
> + * ghes_register_event_notifier - register an event notifier
> + * for the non-fatal HW errors.
> + * @nb: pointer to the notifier_block structure of the event notifier.
> + *
> + * Return : 0 - SUCCESS, non-zero - FAIL.
> + */
> +int ghes_register_event_notifier(struct notifier_block *nb);
> +
> +/**
> + * ghes_unregister_event_notifier - unregister the previously
> + * registered event notifier.
> + * @nb: pointer to the notifier_block structure of the event notifier.
> + */
> +void ghes_unregister_event_notifier(struct notifier_block *nb);
> +#else

Please make it clear from the names these are for vendor events, that the kernel would
otherwise ignore. It looks like these are for everything. Drivers have no business trying
to handle the errors that are handled by things like memory_failure().

~

I would post a version of this to illustrate, but there are comments on patch 2 too.

Something like:
http://www.linux-arm.org/git?p=linux-jm.git;a=commitdiff;h=9c6859f3146001cd9f8edfaf965232cb99c7dc42

(caveat emptor: I've only build tested it)


Thanks,

James
