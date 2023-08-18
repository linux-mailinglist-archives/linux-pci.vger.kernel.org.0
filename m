Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE6278072A
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 10:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358594AbjHRIbc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 18 Aug 2023 04:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357002AbjHRIbW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2023 04:31:22 -0400
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA173A94;
        Fri, 18 Aug 2023 01:31:15 -0700 (PDT)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-56d0deeca09so108139eaf.0;
        Fri, 18 Aug 2023 01:31:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692347474; x=1692952274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TT224v96xD/t8mOBj6F56AQsE9LdRNYbg/P7nBEqKas=;
        b=gKT9t8ivyXuKT4wtQq/y0ZftGOty54hgEvPrxkgPhIWYhaj7aieOWdZNO6Olfdepap
         OCMUuMBCN2gUqQBYd0yMg//EVzIHTTUEFFOTSO658/hyWI6zJWCKfVXcGPMRPtNyp1eT
         dDtn8Ls00zJlyIemgYFBrRzgCID+1TpDEJHGZfuW9gTaY0jk1Gu+9bnBKXkOWevvV1Hr
         t9KzF9MeHSuLkGIHmDVh1b5S/vsSTEpfudxruE8g5JyFg3rA+eu7VIG27zik+h8oPQti
         JaBXUGK8wDEOG8tsvHsYJrDka2hHcwFfCK09cmRJQhsay4myoRIbcioAfIP3cAXipEyp
         wweA==
X-Gm-Message-State: AOJu0YxJkaNc7pcLFhOSEXegbFdAUjAj/f7C9VKwdiVfJgWzhJGbGF3G
        TvFr4q/I60HlTZ7vUEKUyWRk4GoLoJ2zbcdwR2A=
X-Google-Smtp-Source: AGHT+IHSjeuFJ0AgiBX+X3uB5qOyvnHAknvCShoZykDwEzGNzuWpogZKSm0dPTmq0DQLs9PBA5XELt1eB6mGTd8fMbM=
X-Received: by 2002:a4a:bb05:0:b0:569:a08a:d9c5 with SMTP id
 f5-20020a4abb05000000b00569a08ad9c5mr2206435oop.0.1692347474597; Fri, 18 Aug
 2023 01:31:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230818051319.551-1-mario.limonciello@amd.com> <20230818051319.551-10-mario.limonciello@amd.com>
In-Reply-To: <20230818051319.551-10-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 18 Aug 2023 10:31:03 +0200
Message-ID: <CAJZ5v0heB1yGcEzJCA88tyEhFi_LDWcHAF6xsrEFgH4j-DmT7Q@mail.gmail.com>
Subject: Re: [PATCH v13 09/12] ACPI: x86: s2idle: Add a function to get
 constraints for a device
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Iain Lane <iain@orangesquash.org.uk>,
        Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
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

On Fri, Aug 18, 2023 at 7:15 AM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Other parts of the kernel may use constraints information to make
> decisions on what power state to put a device into.

I would say more about what the constraints are in this changelog, or
it becomes cryptic to people who are not familiar with the S0ix/LPS0
terminology.

Something like

"Some platforms may achieve additional energy conservation in deep
idle states provided that the states of all devices on the platform
meet specific requirements. In particular, they each may need to be
put into a specific minimum low-power state (or a deeper one) for this
purpose. The table of Low-Power S0 Idle (LPS0) constraints provided by
the platform firmware on some platforms using ACPI specifies that
minimum low-power state for each device.

That information may help to make decisions on what power state to put
a given device into when it is suspended, so introduce a function
allowing its caller to retrieve the minimum LPS0 low-power state for a
given device."

> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v12->v13:
>  * Drop checking for enabled, just return constraints
> v11->v12:
>  * Use for_each_lpi_constraint instead
>  * use CONFIG_SUSPEND instead of CONFIG_ACPI_SLEEP
> v9->v10:
>  * split from other patches
>  * kerneldoc fixes
>  * move debug statement to this function
> ---
>  drivers/acpi/x86/s2idle.c | 24 ++++++++++++++++++++++++
>  include/linux/acpi.h      |  6 ++++++
>  2 files changed, 30 insertions(+)
>
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index 1aa3cd5677bd8..dd961f3a60577 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -299,6 +299,30 @@ static void lpi_device_get_constraints(void)
>         ACPI_FREE(out_obj);
>  }
>
> +/**
> + * acpi_get_lps0_constraint - get any LPS0 constraint for a device

"get the minimum LPS0 low-power state for a device".

> + * @dev: device to get constraints for
> + *
> + * Returns:
> + *  - the value for constraint.
> + *  - Otherwise, -ENODEV.

Why not ACPI_STATE_UNKNOWN?

> + */
> +int acpi_get_lps0_constraint(struct device *dev)

I think that some overhead would be reduced below if this were taking
a struct acpi_device pointer as the argument.

> +{
> +       struct lpi_constraints *entry;
> +
> +       for_each_lpi_constraint(entry) {
> +               if (!device_match_acpi_handle(dev, entry->handle))
> +                       continue;
> +               acpi_handle_debug(entry->handle,
> +                                 "ACPI device constraint: %d\n", entry->min_dstate);
> +               return entry->min_dstate;
> +       }
> +       dev_dbg(dev, "No ACPI device constraint specified\n");
> +
> +       return -ENODEV;

ACPI_STATE_UNKNOWN?

> +}
> +
>  static void lpi_check_constraints(void)
>  {
>         struct lpi_constraints *entry;
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index f1552c04a2856..6745535444c76 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1109,6 +1109,12 @@ struct acpi_s2idle_dev_ops {
>  };
>  int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg);
>  void acpi_unregister_lps0_dev(struct acpi_s2idle_dev_ops *arg);
> +int acpi_get_lps0_constraint(struct device *dev);
> +#else /* CONFIG_SUSPEND && CONFIG_X86 */
> +static inline int acpi_get_lps0_constraint(struct device *dev)
> +{
> +       return -ENODEV;
> +}
>  #endif /* CONFIG_SUSPEND && CONFIG_X86 */
>  #ifndef CONFIG_IA64
>  void arch_reserve_mem_area(acpi_physical_address addr, size_t size);
> --
> 2.34.1
>
