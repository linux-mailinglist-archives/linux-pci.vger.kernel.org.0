Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88224EEC7E
	for <lists+linux-pci@lfdr.de>; Fri,  1 Apr 2022 13:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345568AbiDALqo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Apr 2022 07:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233087AbiDALqn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Apr 2022 07:46:43 -0400
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A54CFB93;
        Fri,  1 Apr 2022 04:44:54 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id u103so4493210ybi.9;
        Fri, 01 Apr 2022 04:44:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=13vu41OeuYYSTT4U437B0v46QttGyjHUbSgsClP5tEA=;
        b=w2ip6Ht1mAUZ3EDKkqIwZjxQ07vkPri5ez4foudtYxqKGkHkG/6Y7T7pv93FXqxBs0
         CYS8R2GdgXNFxjp/EyIKlXqo5pYOhNg+oNuMhkck9GpuO0q257MAQg7ywQ0+R40oj2aT
         cJMufJ99si1W25p5WJCSJ2fi64pIsqrO9dW9lSA3uxH2XiCodKXV0EHfW6dTy3ib2Bs1
         1Eyje4hujSoNCnysawiXm3UGcfA1G/hjglBE17UANuh4GpwVjxPtxpvRzvznZvwGdCCA
         8Gr2+q7XwTKbcv7YLBhJHFXaXYWBvFInVCqHNBUDIKWyGYZHToxTtWM3E3eEvCYj47ml
         NYqw==
X-Gm-Message-State: AOAM530173/xphigLJmJwcKSmXkcCdJV/OsgyN6A8i5ncMDFWOAklB32
        4hVhP5DngUVK2naUEacyaCoJeRU0cXV8Owtfbqk=
X-Google-Smtp-Source: ABdhPJxK4pWfclHlIuvQRwc++3Lp8UaXg0kXUG8bCNJmzSW5aKYQWX9YhyHSVr5JYg+M2JPqqIx6nBQyQMbVvoR0xgw=
X-Received: by 2002:a25:355:0:b0:63d:5a4a:64a8 with SMTP id
 82-20020a250355000000b0063d5a4a64a8mr3282425ybd.482.1648813493643; Fri, 01
 Apr 2022 04:44:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220401034003.3166-1-mario.limonciello@amd.com>
In-Reply-To: <20220401034003.3166-1-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 1 Apr 2022 13:44:42 +0200
Message-ID: <CAJZ5v0jqWZRp2ZcyO+w66EgE8SHFZ+ZeNka2aUMfLwU93wuxpQ@mail.gmail.com>
Subject: Re: [PATCH v6] PCI / ACPI: Assume "HotPlugSupportInD3" only if device
 can wake from D3
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 1, 2022 at 5:40 AM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> acpi_pci_bridge_d3(dev) returns "true" if "dev" is a hotplug bridge
> that can handle hotplug events while in D3.  Previously this meant:
>
>  1) "dev" has a _PS0 or _PR0 method, or
>
>  2) The Root Port above "dev" has a _DSD with a "HotPlugSupportInD3"
>     property with value 1.
>
> This did not consider_S0W, which tells us the deepest D-state from
> which a device can wake itself (ACPI v6.4, sec 7.3.20).
>
> On some platforms, e.g., AMD Yellow Carp, firmware may supply
> "HotPlugSupportInD3" even though the platform does not supply power
> resources through _PRW and _S0W tells us the device cannot wake from

More importantly, it doesn't supply a wakeup GPE number through _PRW,
so from the ACPI perspective the bridge has no way of generating
wakeup signals.

> D3hot.  With the previous code, these devices could be put in D3hot
> and hotplugged devices would not be recognized without manually
> rescanning.
>
> If _S0W exists and says the Root Port cannot wake itself from D3hot,
> return "false" to indicate that "dev" cannot handle hotplug events
> while in D3.
>
>  1) "dev" has a _PS0 or _PR0 method, or
>
>  2a) The Root Port above "dev" has _PRW and
>
>  2b) If the Root Port above "dev" has _S0W, it can wake from D3hot or
>      D3cold and
>
>  2c) The Root Port above "dev" has a _DSD with a
>      "HotPlugSupportInD3" property with value 1.
>
> Windows 10 and Windows 11 both will prevent the bridge from going in D3
> when the firmware is configured this way and this change aligns the
> handling of the situation to be the same.
>
> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/07_Power_and_Performance_Mgmt/device-power-management-objects.html?highlight=s0w#s0w-s0-device-wake-state
> Link: https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-pcie-root-ports-supporting-hot-plug-in-d3
> Fixes: 26ad34d510a87 ("PCI / ACPI: Whitelist D3 for more PCIe hotplug ports")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> --
> v5->v6:
>  * Re-order checks to only check for _DSD if necessary as suggested by Bjorn.
>  * Adjust commit message wording
>  * Drop rewording comment patch, just apply it while moving text to avoid
>    ping-ponging the same lines in the commits.
> v4-v5:
>  * Don't fail if _S0W is missing
> ---
>  drivers/pci/pci-acpi.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 1f15ab7eabf8..5ab797e2709d 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -976,7 +976,9 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
>  {
>         const union acpi_object *obj;
>         struct acpi_device *adev;
> +       unsigned long long state;
>         struct pci_dev *rpdev;
> +       acpi_status status;
>
>         if (acpi_pci_disabled || !dev->is_hotplug_bridge)
>                 return false;
> @@ -985,12 +987,6 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
>         if (acpi_pci_power_manageable(dev))
>                 return true;
>
> -       /*
> -        * The ACPI firmware will provide the device-specific properties through
> -        * _DSD configuration object. Look for the 'HotPlugSupportInD3' property
> -        * for the root port and if it is set we know the hierarchy behind it
> -        * supports D3 just fine.
> -        */
>         rpdev = pcie_find_root_port(dev);
>         if (!rpdev)
>                 return false;
> @@ -999,6 +995,23 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
>         if (!adev)
>                 return false;
>
> +       /*
> +        * If the bridge can't wake from D3hot, it can't signal hotplug
> +        * events in D3hot.

I would say "If the bridge cannot signal wakeup signals at all, it
cannot signal hotplug events from low-power states including D3hot and
D3cold."

With the two above remarks addressed, please feel free to add

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to this patch.

> +        */
> +       if (!adev->wakeup.flags.valid)
> +               return false;
> +
> +       status = acpi_evaluate_integer(adev->handle, "_S0W", NULL, &state);
> +       if (ACPI_SUCCESS(status) && state < ACPI_STATE_D3_HOT)
> +               return false;
> +
> +       /*
> +        * The ACPI firmware will provide the device-specific properties through
> +        * _DSD configuration object. Look for the 'HotPlugSupportInD3' property
> +        * for the root port and if it is set we make an assumption that the
> +        * hierarchy behind it supports D3 as well.
> +        */
>         if (acpi_dev_get_property(adev, "HotPlugSupportInD3",
>                                    ACPI_TYPE_INTEGER, &obj) < 0)
>                 return false;
> --
> 2.34.1
>
