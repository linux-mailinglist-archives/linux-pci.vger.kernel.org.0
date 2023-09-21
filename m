Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0337A9B6B
	for <lists+linux-pci@lfdr.de>; Thu, 21 Sep 2023 21:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjIUTBU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 21 Sep 2023 15:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjIUTBF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Sep 2023 15:01:05 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16441EE5B9;
        Thu, 21 Sep 2023 11:45:50 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3adbe273a0cso232690b6e.0;
        Thu, 21 Sep 2023 11:45:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695321949; x=1695926749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mSC2Mx8lZwcBsu4ssGOLP2DR4kbz2MNqD+ptdUPWGs4=;
        b=Ec/eKrMY/6jzKOTjojd1uhPAk7Lf3tN/nMEAasAVwCuBeTeADao+R1OZZSRLd/jIzE
         ZrFoM4llkyPQHbDNk5MOdT/mecrBWpGshU8KRzPGLP1gl6XX4Rw4RDbl1RCnQ/CBJYrw
         CyrzPQMUOAf7XygfjRGc4cDkvWP3JFXBdgyyMW6S5ucoZeMG+IGH56hd3qENpCGOFofI
         KEzjdD5/KEYEguShD6MCA2dy6vN++fsi4uP5yRYFKTUy+8OSTmnes9J7PD/jes06Flgo
         tYMJFzpYu4QR1E+VIXKcP/td0hv2E5aQZj4cjGKh3iXVQeDyv0PiZM2DOlB04jSvUnCQ
         Y6XQ==
X-Gm-Message-State: AOJu0Yzdu8v4AWQyXGdp7cHsMf5LgQxi1+LVpKgZIk+Dv+M3vBH1PkZ6
        TZa9Vg/uh3UQhU+kVjoX7UcuqzJgBX7tc33wcQA=
X-Google-Smtp-Source: AGHT+IHQOvwO1HCg1mAMiEkCzXok2CE6zEvjP3SkSyr60AQ/8kEpBnleecz/hKIvBiyPJ9jqrBg4+T2inrVGBJ83Dr8=
X-Received: by 2002:a05:6808:2092:b0:3ad:af12:2fe0 with SMTP id
 s18-20020a056808209200b003adaf122fe0mr6862727oiw.3.1695321949259; Thu, 21 Sep
 2023 11:45:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230920180337.809-1-shiju.jose@huawei.com>
In-Reply-To: <20230920180337.809-1-shiju.jose@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 21 Sep 2023 20:45:38 +0200
Message-ID: <CAJZ5v0j2qAakkcuMS0Np8Do5w4Np67ddt_EfqYY4br+p-WXV9w@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] ACPI / APEI: Fix for overwriting AER info when
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 20, 2023 at 8:03 PM <shiju.jose@huawei.com> wrote:
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
> Changes from v2 to v3:
> 1. Add stub code for ghes_estatus_pool_region_free() to fix following
> build error, reported by kernel test robot, if CONFIG_ACPI_APEI_GHES
> is not enabled.
> ld: drivers/pci/pcie/aer.o: in function `aer_recover_work_func':
> aer.c:(.text+0xec5): undefined reference to `ghes_estatus_pool_region_free'
>
> Changes from v1 to v2:
> 1. Updated patch description with the description Bjorn has suggested.
> 2. Add Acked-by: Bjorn Helgaas <bhelgaas@google.com>.
> ---
>  drivers/acpi/apei/ghes.c | 23 ++++++++++++++++++++++-
>  drivers/pci/pcie/aer.c   | 10 ++++++++++
>  include/acpi/ghes.h      |  4 ++++
>  3 files changed, 36 insertions(+), 1 deletion(-)
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
> index e85ff946e8c8..ba1ce820c141 100644
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
> index 3c8bba9f1114..be1dd4c1a917 100644
> --- a/include/acpi/ghes.h
> +++ b/include/acpi/ghes.h
> @@ -73,8 +73,12 @@ int ghes_register_vendor_record_notifier(struct notifier_block *nb);
>  void ghes_unregister_vendor_record_notifier(struct notifier_block *nb);
>
>  struct list_head *ghes_get_devices(void);
> +
> +void ghes_estatus_pool_region_free(unsigned long addr, u32 size);
>  #else
>  static inline struct list_head *ghes_get_devices(void) { return NULL; }
> +
> +static inline void ghes_estatus_pool_region_free(unsigned long addr, u32 size) { return; }
>  #endif
>
>  int ghes_estatus_pool_init(unsigned int num_ghes);
> --

Applied as 6.7 material, thanks!
