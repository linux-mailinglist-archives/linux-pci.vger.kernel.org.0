Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4670F4D9957
	for <lists+linux-pci@lfdr.de>; Tue, 15 Mar 2022 11:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347542AbiCOKrW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Mar 2022 06:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347306AbiCOKq3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Mar 2022 06:46:29 -0400
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDDD51E6E;
        Tue, 15 Mar 2022 03:44:37 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id m67so3010734ybm.4;
        Tue, 15 Mar 2022 03:44:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CjrY3YFYr3brCRAxquRT06tqZwh1Xy0fQYTMPc7ih6E=;
        b=3VSYxDpDcXjAP/bQ0LbQ/QKmlg6tQ+1unGjGKtmvJB0+Q578s7Wm4dUa/X7VeSq8sr
         Nb8UtbD8lnHFRpOanCI57shcnbHz70NGZNm7KaZMCEVE590ahG+4NftxD7JYZet1Vdmt
         MeXeaPiaHnYJDjhSXxUORqMQpZplEepWuu4DyvBpeUPGW8XWtfeS/jYJ6Q37yWvXGNks
         DcGueLbtbvIzIn3kcnG0VhzqS8BgbzoLH6ESnm5VYUkIEw4gmVpWGrAQ0RNvbwFFKw0G
         VRkdyMwY5YYKhwYJU7UKe+gZblTZzTJ0cPhuK48//EZPhbYR4nqKPdSXSCANRnIX3biu
         ckEA==
X-Gm-Message-State: AOAM531YX8wbSPxZhG6da04ysEh8VJoj82cNEU0bB0S62a4lbO1tNYXa
        I0kxEOUYPzzNZm7xSYwVLhGvt9hH2RW4dfUlq7anFEkT5nk=
X-Google-Smtp-Source: ABdhPJykk7vADGRPaEINMlZlnKlG5kRM7EPuv8J0E0lyP9lYr+nvgv20D/5cPMsoIGQQGK0NfNtQ21UfBFtDuN/FtC8=
X-Received: by 2002:a25:fe10:0:b0:625:262f:e792 with SMTP id
 k16-20020a25fe10000000b00625262fe792mr21601873ybe.365.1647341074938; Tue, 15
 Mar 2022 03:44:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220313234020.536-1-mario.limonciello@amd.com>
In-Reply-To: <20220313234020.536-1-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 15 Mar 2022 11:44:23 +0100
Message-ID: <CAJZ5v0gJktpD8wXgN8qnx54vMmCQwcH_jcN7ViW20gCOatQ1vg@mail.gmail.com>
Subject: Re: [PATCH v3] PCI / ACPI: Assume `HotPlugSupportInD3` only if device
 can wake from D3
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>
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

On Mon, Mar 14, 2022 at 12:40 AM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> According to the Microsoft spec the _DSD `HotPlugSupportInD3` is
> indicates the ability for a bridge to be able to wakeup from D3:
>
>   This ACPI object [HotPlugSupportInD3] enables the operating system
>   to identify and power manage PCIe Root Ports that are capable of
>   handling hot plug events while in D3 state.
>
> This however is static information in the ACPI table at BIOS compilation
> time and on some platforms it's possible to configure the firmware at boot
> up such that _S0W returns "0" indicating the inability to wake up the
> device from D3 as explained in the ACPI specification:
>
>   7.3.20 _S0W (S0 Device Wake State)
>
>   This object evaluates to an integer that conveys to OSPM the deepest
>   D-state supported by this device in the S0 system sleeping state
>   where the device can wake itself.
>
> This mismatch may lead to being unable to enumerate devices behind the
> hotplug bridge when a device is plugged in. To remedy these situations
> that `HotPlugSupportInD3` is specified by _S0W returns 0, explicitly
> check that the ACPI companion has returned _S0W greater than or equal
> to 3 and the device has a GPE allowing the device to generate wakeup
> signals handled by the platform in `acpi_pci_bridge_d3`.
>
> Windows 10 and Windows 11 both will prevent the bridge from going in D3
> when the firmware is configured this way and this changes aligns the
> handling of the situation to be the same.
>
> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/07_Power_and_Performance_Mgmt/device-power-management-objects.html?highlight=s0w#s0w-s0-device-wake-state
> Link: https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-pcie-root-ports-supporting-hot-plug-in-d3
> Fixes: 26ad34d510a87 ("PCI / ACPI: Whitelist D3 for more PCIe hotplug ports")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/pci/pci-acpi.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index a42dbf448860..232a8aa21bd6 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -972,6 +972,29 @@ bool acpi_pci_power_manageable(struct pci_dev *dev)
>         return adev && acpi_device_power_manageable(adev);
>  }
>
> +/**
> + * acpi_pci_s0w_supports_d3 - Deterine if ACPI device supports D3.
> + * @adev: ACPI Device node.
> + *
> + * Validate that the GPE has been enabled for the ACPI device, and if it
> + * was then evaluate the _S0W method for the ACPI device.
> + *
> + * Returns true when GPE is enabled and _S0W can support D3hot or D3cold.
> + */
> +static bool acpi_pci_s0w_supports_d3(struct acpi_device *adev)
> +{
> +       unsigned long long ret;
> +       char *method = "_S0W";

The method var appears to be redundant.  Why not use "_S0W" directly below?

> +
> +       if (!adev->wakeup.flags.valid)
> +               return false;
> +
> +       if (ACPI_FAILURE(acpi_evaluate_integer(adev->handle, method, NULL, &ret)))
> +               return false;
> +
> +       return ret >= ACPI_STATE_D3_HOT;
> +}
> +
>  bool acpi_pci_bridge_d3(struct pci_dev *dev)
>  {
>         const union acpi_object *obj;
> @@ -1003,6 +1026,13 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
>                                    ACPI_TYPE_INTEGER, &obj) < 0)
>                 return false;
>

I would do

if (!obj->integer.value)
        return false;

here so as to avoid evaluating _S0W if not necessary;

> +       /*
> +        * The ACPI firmware may have 'HotPlugSupportInD3' set on the device,
> +        * but _S0W may indicate that the device is not able to wake from D3.

I'd change this comment to something like

"If 'HotPlugSupportInD3' is set, but wakeup is not actually supported,
the former cannot be trusted anyway, so validate it by verifying the
latter."

> +        */

And here I would do

return acpi_pci_s0w_supports_d3(adev);

> +       if (!acpi_pci_s0w_supports_d3(adev))
> +               return false;
> +
>         return obj->integer.value == 1;
>  }
>
> --
