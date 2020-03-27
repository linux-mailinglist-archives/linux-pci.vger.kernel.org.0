Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 661C0195D86
	for <lists+linux-pci@lfdr.de>; Fri, 27 Mar 2020 19:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgC0SWV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Mar 2020 14:22:21 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50084 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbgC0SWV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 27 Mar 2020 14:22:21 -0400
Received: from zn.tnic (p200300EC2F0CFA006896CC49A8ABCE42.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:fa00:6896:cc49:a8ab:ce42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B4D041EC0C8E;
        Fri, 27 Mar 2020 19:22:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1585333339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=drSOBuDYgdgFJzfGjBudh0HtMiYsOKLj9y49+Tznv9I=;
        b=M4d5Js+FaY+Bzj3FgMg6Z9WqEvTRNgrRZSWl7HtrhC0vBQouLd0I2oImy+eYIFgGOWUMJT
        ZK6ZzdeoIbeczUDKLYFVZ9MdjYt1S5Nf65LKVa2TQpjxZ3QXWIAvzhm71wS7SW9RQTH/Mn
        qX8V5D+e8lDr+m7NxnbfQQkZ13uqcWQ=
Date:   Fri, 27 Mar 2020 19:22:14 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        helgaas@kernel.org, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, gregkh@linuxfoundation.org,
        zhangliguang@linux.alibaba.com, tglx@linutronix.de,
        linuxarm@huawei.com, jonathan.cameron@huawei.com,
        tanxiaofei@huawei.com, yangyicong@hisilicon.com
Subject: Re: [PATCH v6 1/2] ACPI / APEI: Add support to notify the vendor
 specific HW errors
Message-ID: <20200327182214.GD8015@zn.tnic>
References: <ShijuJose>
 <20200325164223.650-1-shiju.jose@huawei.com>
 <20200325164223.650-2-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200325164223.650-2-shiju.jose@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 25, 2020 at 04:42:22PM +0000, Shiju Jose wrote:
> Presently APEI does not support reporting the vendor specific
> HW errors, received in the vendor defined table entries, to the
> vendor drivers for any recovery.
> 
> This patch adds the support to register and unregister the

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

> error handling function for the vendor specific HW errors and
> notify the registered kernel driver.
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  drivers/acpi/apei/ghes.c | 35 ++++++++++++++++++++++++++++++++++-
>  drivers/ras/ras.c        |  5 +++--
>  include/acpi/ghes.h      | 28 ++++++++++++++++++++++++++++
>  include/linux/ras.h      |  6 ++++--
>  include/ras/ras_event.h  |  7 +++++--
>  5 files changed, 74 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 24c9642e8fc7..d83f0b1aad0d 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -490,6 +490,32 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
>  #endif
>  }
>  
> +static ATOMIC_NOTIFIER_HEAD(ghes_event_notify_list);
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
> +	return atomic_notifier_chain_register(&ghes_event_notify_list, nb);
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
> +	atomic_notifier_chain_unregister(&ghes_event_notify_list, nb);
> +}
> +EXPORT_SYMBOL_GPL(ghes_unregister_event_notifier);
> +
>  static void ghes_do_proc(struct ghes *ghes,
>  			 const struct acpi_hest_generic_status *estatus)
>  {
> @@ -526,10 +552,17 @@ static void ghes_do_proc(struct ghes *ghes,
>  			log_arm_hw_error(err);
>  		} else {
>  			void *err = acpi_hest_get_payload(gdata);
> +			u8 error_handled = false;
> +			int ret;
> +
> +			ret = atomic_notifier_call_chain(&ghes_event_notify_list, 0, gdata);

Well, this is a notifier with standard name for a non-standard event.
Not optimal.

Why does only this event need a notifier? Because your driver is
interested in only those events?

> +			if (ret & NOTIFY_OK)
> +				error_handled = true;
>  
>  			log_non_standard_event(sec_type, fru_id, fru_text,
>  					       sec_sev, err,
> -					       gdata->error_data_length);
> +					       gdata->error_data_length,
> +					       error_handled);

What's that error_handled thing for? That's just silly.

Your notifier returns NOTIFY_STOP when it has queued the error. If you
don't want to log it, just test == NOTIFY_STOP and do not log it then.

Then your notifier callback is queuing the error into a kfifo for
whatever reason and then scheduling a workqueue to handle it in user
context...

So I'm thinking that it would be better if you:

* make that kfifo generic and part of ghes.c and queue all types of
error records into it in ghes_do_proc() - not just the non-standard
ones.

* then, when you're done queuing, you kick a workqueue.

* that workqueue runs a normal, blocking notifier to which drivers
register.

Your driver can register to that notifier too and do the normal handling
then and not have this ad-hoc, semi-generic, semi-vendor-specific thing.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
