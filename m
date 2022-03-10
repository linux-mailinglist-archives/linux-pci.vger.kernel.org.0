Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282F94D5229
	for <lists+linux-pci@lfdr.de>; Thu, 10 Mar 2022 20:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238792AbiCJS0R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Mar 2022 13:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233999AbiCJS0Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Mar 2022 13:26:16 -0500
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560B7158799;
        Thu, 10 Mar 2022 10:25:15 -0800 (PST)
Received: by mail-yb1-f174.google.com with SMTP id z30so12616341ybi.2;
        Thu, 10 Mar 2022 10:25:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1VMWWhuvSRJCu8S6y70I3FDZGBYa2h8ntijs+vWLbu4=;
        b=KuehBEAPUdfC1Iq3KRwmMpKo3f9o+hTiwu6yWrWSgOY7wVVLejLg8XclvzUcNXgqK4
         b2I9ztz8XaxeXg0m7Wu/FdHcH51dWCjWwSqMdl85KOgp34v7ORzWTQN3Q1O7ysmksG9M
         YSCxmNNlVsfWA27JxGabBD85qMMswLgAaqYCSGVMPl6UT5/MRCJ0gJlVtFV9m68ftFcP
         dncQnGA8BgNaDFggFUq8Rn3ueRNO0zhj1ikiI2C/HpzN+MjiY+HBqSxZOuyghLO2Zcpr
         tbCYMt6bobSx6g8E5Gh8H+vsYQd5KQEQvGc08jI+ARfvT6B7QXW78qO4Bu5OIpdO++2c
         12KA==
X-Gm-Message-State: AOAM533t3e47sliiAGoeggXGMRh2Pnqk9P/W3PYR9RppCQ1L6OlJqaTN
        1bb+mwWpCKMftv/V/J0tuXpdK5PjLiSahn+FMcQ=
X-Google-Smtp-Source: ABdhPJwB6Xxzp9s0UkiJxcaCeTNWvc1OlizyzvM4l2ll06Ao/S+XgEdT0oPnlC+fKmSYsLJQgpV1zDEjsta6pYpBJaI=
X-Received: by 2002:a25:3a41:0:b0:628:86a2:dbc with SMTP id
 h62-20020a253a41000000b0062886a20dbcmr4814757yba.633.1646936714464; Thu, 10
 Mar 2022 10:25:14 -0800 (PST)
MIME-Version: 1.0
References: <20220310175832.1259-1-mario.limonciello@amd.com>
In-Reply-To: <20220310175832.1259-1-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 10 Mar 2022 19:25:03 +0100
Message-ID: <CAJZ5v0gjPwEcq2dEE+wRr3D+w7=MTEKJoQ+x9muh_R4W-DawVw@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: ACPI: Don't blindly trust `HotPlugSupportInD3`
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, Sanju.Mehta@amd.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>
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

On Thu, Mar 10, 2022 at 6:58 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> The `_DSD` `HotPlugSupportInD3` is supposed to indicate the ability for a
> bridge to be able to wakeup from D3.
>
> This however is static information in the ACPI table at BIOS compilation
> time and on some platforms it's possible to configure the firmware at boot
> up such that `_S0W` will not return "0" indicating the inability to wake
> up the device from D3.

To be precise, _S0W returning 0 means that the device cannot generate
wakeup signals from any D-states other than D0 while the system as a
whole is in S0.

> To fix these situations explicitly check that the ACPI device has a GPE
> allowing the device to generate wakeup signals handled by the platform
> in `acpi_pci_bridge_d3`.

Which may be orthogonal to the _S0W return value mentioned above.

Also, I'm not quite sure why acpi_pci_bridge_d3() should require the
root port to have a wake GPE associated with it as an indication that
the hierarchy below it can be put into D3cold.

> This changes aligns the handling of the situation the same as Windows 10
> and Windows 11 both do as well.
>
> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/07_Power_and_Performance_Mgmt/device-power-management-objects.html?highlight=s0w#s0w-s0-device-wake-state
> Link: https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-pcie-root-ports-supporting-hot-plug-in-d3
> Fixes: 26ad34d510a87 ("PCI / ACPI: Whitelist D3 for more PCIe hotplug ports")
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v1->v2:
>  * Add Mika's tag
>  * Update commit message for Rafael's suggestions
>  drivers/pci/pci-acpi.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index a42dbf448860..9f8f55ed09d9 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -999,6 +999,9 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
>         if (!adev)
>                 return false;
>
> +       if (!adev->wakeup.flags.valid)
> +               return false;

Minor nit: the two checks above could be combined.

Also I would add a comment explaining why exactly wakeup.flags.valid
is checked here, because I can imagine a case in which the wakeup
signaling capability is irrelevant for whether or not the given port
can handle D3cold.

> +
>         if (acpi_dev_get_property(adev, "HotPlugSupportInD3",
>                                    ACPI_TYPE_INTEGER, &obj) < 0)
>                 return false;
> --
