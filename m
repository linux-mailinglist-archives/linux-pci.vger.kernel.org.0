Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F17F7A8A77
	for <lists+linux-pci@lfdr.de>; Wed, 20 Sep 2023 19:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjITRWt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 20 Sep 2023 13:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjITRWs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Sep 2023 13:22:48 -0400
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C27AAF;
        Wed, 20 Sep 2023 10:22:42 -0700 (PDT)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-57328758a72so19506eaf.1;
        Wed, 20 Sep 2023 10:22:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695230562; x=1695835362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pYehh7LzdQJneqnFsjZ62n8i914se3ySYfcSRbCw+BE=;
        b=JttLTCjMhMV6DdkNgae6xPeAU6GSReY6hRqeYdoXvPNJf+YfLsNjHF2MSOv/ZH3awG
         lX7QsFKItgOAWkr9u969NLNaGatPW67QCtxj9aBMA736Mp4muyZunkSZzDzZ8nHvyipL
         ilijC3F0yJ0vykKto5KCCePgwvrCLKCp55rr44ul0+8ExS7PHg/WhL4O5wFg0fuUJNk+
         zrDd1ZYentHxub7tOExOqGWV9Bdle2OUyVTHml9j3BckEi2yHd5PVeZtbZHj3YL+XsM3
         ilbIugZxV8e3iBdj+QF7oOwOm3uVeZfDZLkg7/Nupz+fEK9CD33nmL0UlC+GTOynKW9P
         ZmlA==
X-Gm-Message-State: AOJu0YysIooEB31na3i20p54zZL3ZHJ35/Io+XBGUvZAEHTZL3bTCwhQ
        hMqaeymv2saiilk5YJvKpcv7qRwSL1ZpJ8D3hGs=
X-Google-Smtp-Source: AGHT+IEb9SMUBcyChlllZAnrubbMNL/iiYyldsK9QHvtjAA1iC4VMOrgwSpu5LpyXqWmUMaFgk+9F2u0K4LRdINEROw=
X-Received: by 2002:a4a:ea53:0:b0:57b:2ca3:445b with SMTP id
 j19-20020a4aea53000000b0057b2ca3445bmr2910016ooe.0.1695230561764; Wed, 20 Sep
 2023 10:22:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230919091543.794-1-shiju.jose@huawei.com>
In-Reply-To: <20230919091543.794-1-shiju.jose@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 20 Sep 2023 19:22:30 +0200
Message-ID: <CAJZ5v0jeeYAtUEoc8C2TkA+dG8hR0S090RNNfs1DfzSkbxFoTg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] ACPI / APEI: Fix for overwriting AER info when
 error status data has multiple sections
To:     shiju.jose@huawei.com
Cc:     helgaas@kernel.org, rafael@kernel.org, lenb@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, bp@alien8.de,
        ying.huang@intel.com, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, jonathan.cameron@huawei.com,
        tanxiaofei@huawei.com, prime.zeng@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 19, 2023 at 11:16 AM <shiju.jose@huawei.com> wrote:
>
> From: Shiju Jose <shiju.jose@huawei.com>
>
> ghes_handle_aer() passes AER data to the PCI core for logging and
> recovery by calling aer_recover_queue() with a pointer to struct
> aer_capability_regs.
>
> The problem was that aer_recover_queue() queues the pointer directly
> without copying the aer_capability_regs data.  The pointer was to
> the ghes->estatus buffer, which could be reused before
> aer_recover_work_func() reads the data.
>
> To avoid this problem, allocate a new aer_capability_regs structure
> from the ghes_estatus_pool, copy the AER data from the ghes->estatus
> buffer into it, pass a pointer to the new struct to
> aer_recover_queue(), and free it after aer_recover_work_func() has
> processed it.
>
> Reported-by: Bjorn Helgaas <helgaas@kernel.org>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
> Changes from v1 to v2:
> 1. Updated patch description with the description Bjorn has suggested.
> 2. Add Acked-by: Bjorn Helgaas <bhelgaas@google.com>.
> ---
>  drivers/acpi/apei/ghes.c | 23 ++++++++++++++++++++++-
>  drivers/pci/pcie/aer.c   | 10 ++++++++++
>  include/acpi/ghes.h      |  1 +
>  3 files changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index ef59d6ea16da..63ad0541db38 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -209,6 +209,20 @@ int ghes_estatus_pool_init(unsigned int num_ghes)
>         return -ENOMEM;
>  }
>
> +/**
> + * ghes_estatus_pool_region_free - free previously allocated memory
> + *                                from the ghes_estatus_pool.
> + * @addr: address of memory to free.
> + * @size: size of memory to free.
> + *
> + * Returns none.
> + */
> +void ghes_estatus_pool_region_free(unsigned long addr, u32 size)
> +{
> +       gen_pool_free(ghes_estatus_pool, addr, size);
> +}
> +EXPORT_SYMBOL_GPL(ghes_estatus_pool_region_free);
> +
>  static int map_gen_v2(struct ghes *ghes)
>  {
>         return apei_map_generic_address(&ghes->generic_v2->read_ack_register);
> @@ -564,6 +578,7 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
>             pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO) {
>                 unsigned int devfn;
>                 int aer_severity;
> +               u8 *aer_info;
>
>                 devfn = PCI_DEVFN(pcie_err->device_id.device,
>                                   pcie_err->device_id.function);
> @@ -577,11 +592,17 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
>                 if (gdata->flags & CPER_SEC_RESET)
>                         aer_severity = AER_FATAL;
>
> +               aer_info = (void *)gen_pool_alloc(ghes_estatus_pool,
> +                                                 sizeof(struct aer_capability_regs));
> +               if (!aer_info)
> +                       return;
> +               memcpy(aer_info, pcie_err->aer_info, sizeof(struct aer_capability_regs));
> +
>                 aer_recover_queue(pcie_err->device_id.segment,
>                                   pcie_err->device_id.bus,
>                                   devfn, aer_severity,
>                                   (struct aer_capability_regs *)
> -                                 pcie_err->aer_info);
> +                                 aer_info);
>         }
>  #endif
>  }
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index e85ff946e8c8..388b614c11fd 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -29,6 +29,7 @@
>  #include <linux/kfifo.h>
>  #include <linux/slab.h>
>  #include <acpi/apei.h>
> +#include <acpi/ghes.h>
>  #include <ras/ras_event.h>
>
>  #include "../pci.h"
> @@ -996,6 +997,15 @@ static void aer_recover_work_func(struct work_struct *work)
>                         continue;
>                 }
>                 cper_print_aer(pdev, entry.severity, entry.regs);
> +               /*
> +                * Memory for aer_capability_regs(entry.regs) is being allocated from the
> +                * ghes_estatus_pool to protect it from overwriting when multiple sections
> +                * are present in the error status. Thus free the same after processing
> +                * the data.
> +                */
> +               ghes_estatus_pool_region_free((unsigned long)entry.regs,
> +                                             sizeof(struct aer_capability_regs));
> +
>                 if (entry.severity == AER_NONFATAL)
>                         pcie_do_recovery(pdev, pci_channel_io_normal,
>                                          aer_root_reset);
> diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
> index 3c8bba9f1114..40d89e161076 100644
> --- a/include/acpi/ghes.h
> +++ b/include/acpi/ghes.h
> @@ -78,6 +78,7 @@ static inline struct list_head *ghes_get_devices(void) { return NULL; }
>  #endif
>
>  int ghes_estatus_pool_init(unsigned int num_ghes);
> +void ghes_estatus_pool_region_free(unsigned long addr, u32 size);

If I'm not mistaken, this needs to go under #ifdef
CONFIG_ACPI_APEI_GHES and it needs an empty stub for the case when
CONFIG_ACPI_APEI_GHES is not set.

>
>  static inline int acpi_hest_get_version(struct acpi_hest_generic_data *gdata)
>  {
> --
> 2.34.1
>
