Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A90961FC1EB
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jun 2020 00:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725849AbgFPW4i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Jun 2020 18:56:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:33940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbgFPW4i (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Jun 2020 18:56:38 -0400
Received: from localhost (mobile-166-170-222-206.mycingular.net [166.170.222.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5AD82082F;
        Tue, 16 Jun 2020 22:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592348197;
        bh=1Y39lAnqjB4tYzCk7tiF0QydRbO/+ffQDiMnNp6WH2I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=uqk4XyBojWHCxDkX406EGFyuDQkBYLLg1HgDfsm8qQyPabis7YEuzMYKZxPrTINPm
         7LlMvpmraRa0iaGUVmzu4k+tdyjTEeU/o2A2Zsiv6jq4A3jV59Xx2pFgW6Gfc+IgIn
         16D9m1S33jQLsBRSn7bi7ZWB/WHtneQ97nyYY3pU=
Date:   Tue, 16 Jun 2020 17:56:35 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net, bp@alien8.de,
        james.morse@arm.com, lenb@kernel.org, tony.luck@intel.com,
        dan.carpenter@oracle.com, zhangliguang@linux.alibaba.com,
        andriy.shevchenko@linux.intel.com, wangkefeng.wang@huawei.com,
        jroedel@suse.de, yangyicong@hisilicon.com,
        jonathan.cameron@huawei.com, tanxiaofei@huawei.com
Subject: Re: [PATCH v9 1/2] ACPI / APEI: Add support to notify the vendor
 specific HW errors
Message-ID: <20200616225635.GA1987516@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615095312.398-2-shiju.jose@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 15, 2020 at 10:53:11AM +0100, Shiju Jose wrote:
> Add support to notify the vendor specific non-fatal HW errors
> to the drivers for the error recovery.

This doesn't actually say anything about what this patch does.  Sure,
it "adds support," but it doesn't say anything about how that support
works or how to use it.

This should say something about a FIFO and it should mention that an
event handler registered with ghes_register_event_notifier() will be
called with each vendor-specific error record.

> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  drivers/acpi/apei/ghes.c | 130 ++++++++++++++++++++++++++++++++++++++-
>  include/acpi/ghes.h      |  28 +++++++++
>  2 files changed, 157 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 24c9642e8fc7..854d8115cdfc 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -33,6 +33,7 @@
>  #include <linux/irq_work.h>
>  #include <linux/llist.h>
>  #include <linux/genalloc.h>
> +#include <linux/kfifo.h>
>  #include <linux/pci.h>
>  #include <linux/pfn.h>
>  #include <linux/aer.h>
> @@ -63,6 +64,11 @@
>  #define GHES_ESTATUS_CACHES_SIZE	4
>  
>  #define GHES_ESTATUS_IN_CACHE_MAX_NSEC	10000000000ULL
> +
> +#define GHES_EVENT_RING_SIZE	256
> +#define GHES_GDATA_POOL_MIN_ALLOC_ORDER	3
> +#define GHES_GDATA_POOL_MIN_SIZE	65536

Don't drop these new #defines right in the middle of the GHES_ESTATUS
block.  The ESTATUS ones are all related, and these new ones are
something separate.

These new names should be related somehow.  The names don't make it
clear that GHES_EVENT and GHES_GDATA are related.  IIUC GHES_GDATA is
space for storing GHES structures, and GHES_EVENT is a FIFO of struct
ghes_event_entry, each of which points to one of those GHES
structures.

>  /* Prevent too many caches are allocated because of RCU */
>  #define GHES_ESTATUS_CACHE_ALLOCED_MAX	(GHES_ESTATUS_CACHES_SIZE * 3 / 2)
>  
> @@ -122,6 +128,19 @@ static DEFINE_MUTEX(ghes_list_mutex);
>   */
>  static DEFINE_SPINLOCK(ghes_notify_lock_irq);
>  
> +struct ghes_event_entry {
> +	struct acpi_hest_generic_data *gdata;
> +	int error_severity;
> +};
> +
> +static DEFINE_KFIFO(ghes_event_ring, struct ghes_event_entry,
> +		    GHES_EVENT_RING_SIZE);
> +
> +static DEFINE_SPINLOCK(ghes_event_ring_lock);
> +
> +static struct gen_pool *ghes_gdata_pool;
> +static unsigned long ghes_gdata_pool_size_request;
> +
>  static struct gen_pool *ghes_estatus_pool;
>  static unsigned long ghes_estatus_pool_size_request;
>  
> @@ -188,6 +207,40 @@ int ghes_estatus_pool_init(int num_ghes)
>  	return -ENOMEM;
>  }
>  
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
> +
> +	vmalloc_sync_mappings();
> +
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
> +
>  static int map_gen_v2(struct ghes *ghes)
>  {
>  	return apei_map_generic_address(&ghes->generic_v2->read_ack_register);
> @@ -247,6 +300,10 @@ static struct ghes *ghes_new(struct acpi_hest_generic *generic)
>  		goto err_unmap_status_addr;
>  	}
>  
> +	ghes_gdata_pool_size_request += generic->records_to_preallocate *
> +					generic->max_sections_per_record *
> +					generic->max_raw_data_length;
> +
>  	return ghes;
>  
>  err_unmap_status_addr:
> @@ -490,6 +547,68 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
>  #endif
>  }
>  
> +static BLOCKING_NOTIFIER_HEAD(ghes_event_notify_list);
> +
> +/**
> + * ghes_register_event_notifier - register an event notifier
> + * for the non-fatal HW errors.
> + * @nb: pointer to the notifier_block structure of the event handler.
> + *
> + * return 0 : SUCCESS, non-zero : FAIL
> + */
> +int ghes_register_event_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_register(&ghes_event_notify_list, nb);
> +}
> +EXPORT_SYMBOL_GPL(ghes_register_event_notifier);
> +
> +/**
> + * ghes_unregister_event_notifier - unregister the previously
> + * registered event notifier.
> + * @nb: pointer to the notifier_block structure of the event handler.
> + */
> +void ghes_unregister_event_notifier(struct notifier_block *nb)
> +{
> +	blocking_notifier_chain_unregister(&ghes_event_notify_list, nb);
> +}
> +EXPORT_SYMBOL_GPL(ghes_unregister_event_notifier);
> +
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
> +
> +	len = acpi_hest_get_record_size(gdata);
> +	event_entry.gdata = (void *)gen_pool_alloc(ghes_gdata_pool, len);
> +	if (event_entry.gdata) {

Make this:

  if (!event_entry.gdata) {
    pr_warn(...);
    return;
  }

and then you won't have to indent the usual case below.

> +		memcpy(event_entry.gdata, gdata, len);
> +		event_entry.error_severity = sev;
> +
> +		if (kfifo_in_spinlocked(&ghes_event_ring, &event_entry, 1,
> +					&ghes_event_ring_lock))
> +			schedule_work(&ghes_event_work);
> +		else
> +			pr_warn(GHES_PFX "ghes event queue full\n");

GHES_PFX is already "GHES: ", so no need to repeat "ghes" in your
message.  You can use that space for something more useful, like the
source ID, section type, severity, etc.  Dmesg strings that are
completely constant are not as useful as they could be.

> +	}
> +}
> +
>  static void ghes_do_proc(struct ghes *ghes,
>  			 const struct acpi_hest_generic_status *estatus)
>  {
> @@ -527,6 +646,7 @@ static void ghes_do_proc(struct ghes *ghes,
>  		} else {
>  			void *err = acpi_hest_get_payload(gdata);
>  
> +			ghes_handle_non_standard_event(gdata, sev);
>  			log_non_standard_event(sec_type, fru_id, fru_text,
>  					       sec_sev, err,
>  					       gdata->error_data_length);
> @@ -1334,7 +1454,7 @@ static int __init ghes_init(void)
>  
>  	rc = platform_driver_register(&ghes_platform_driver);
>  	if (rc)
> -		goto err;
> +		goto exit;
>  
>  	rc = apei_osc_setup();
>  	if (rc == 0 && osc_sb_apei_support_acked)
> @@ -1346,8 +1466,16 @@ static int __init ghes_init(void)
>  	else
>  		pr_info(GHES_PFX "Failed to enable APEI firmware first mode.\n");
>  
> +	rc = ghes_gdata_pool_init();
> +	if (rc) {
> +		pr_warn(GHES_PFX "ghes_gdata_pool_init failed\n");

I don't think this message is really meaningful to a user.  Maybe
something about non-fatal vendor-specific errors not being logged?

> +		goto err;

I'm not sure this is an error that should cause the whole GHES driver
to be unregistered.  After all, the driver *used* to work fine even
without this vendor-specific functionality.  Seems like we ought to be
able to fall back to the previous behavior even if we can't allocate
the gdata pool.

> +	}
> +
>  	return 0;
>  err:
> +	platform_driver_unregister(&ghes_platform_driver);
> +exit:
>  	return rc;
>  }
>  device_initcall(ghes_init);
> diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
> index e3f1cddb4ac8..a3dd82069069 100644
> --- a/include/acpi/ghes.h
> +++ b/include/acpi/ghes.h
> @@ -50,6 +50,34 @@ enum {
>  	GHES_SEV_PANIC = 0x3,
>  };
>  
> +

Don't add an extra blank line here.

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
> +static inline int ghes_register_event_notifier(struct notifier_block *nb)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline void ghes_unregister_event_notifier(struct notifier_block *nb)
> +{
> +}
> +#endif
> +
>  int ghes_estatus_pool_init(int num_ghes);
>  
>  /* From drivers/edac/ghes_edac.c */
> -- 
> 2.17.1
> 
> 
