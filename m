Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80BB679E4B9
	for <lists+linux-pci@lfdr.de>; Wed, 13 Sep 2023 12:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239667AbjIMKUb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 13 Sep 2023 06:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239536AbjIMKUa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Sep 2023 06:20:30 -0400
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9AB19A9;
        Wed, 13 Sep 2023 03:20:26 -0700 (PDT)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5711d5dac14so1520063eaf.0;
        Wed, 13 Sep 2023 03:20:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694600426; x=1695205226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2gf54HvV2WbmlS/PmGx/8BNZCPO8nJNro/BGyAgUlSw=;
        b=PYbJxh3Gz6PqnVDECF14pq7ToVTyU3/1Zzl2OT5/jXZcQ/A4Z/8fTd/1pxCoAeL5uJ
         CZlm3xieJ9jsb8amEjAhADEPSdJ9V/tw6SYG9UPay0t80h0OVdfgZmEbUV7nSa6Y57/q
         30gLxhDG29lkOoMPkNyOOBZsLBS9vu4vHLcNHYO6+qLwyfRl5ylzQlDHaB/O9n1HgpbL
         dL16EkVsTjmz69pWQyzqfa1JH04M+Hqz/yhhZ+8XUiQjZcX6POQloYxhDaeRR+KD/Kto
         8LrOgQzcwBeEqgZR3s3lLwhhTJ46LfWFmE2MUvGTWIVkMHzXeXMcrYy2f66UtOGUWR1G
         eqKw==
X-Gm-Message-State: AOJu0Yx8tSZZxnLaJZiUKUCP92l3XH98uRedhfi/2jzIcnP7E+sKpl8w
        pKnZO8x+5G2TZehKjAOTk1QZ9pYE8RNJwgZfbW2k/HhIARU=
X-Google-Smtp-Source: AGHT+IENyBNl57h1hz/NfqbymWMw+bnCc4UDeMTUE6loBsd9hS0ymSWjM3ff3i0EzRnq2UmZOm560VVRqpNGeQfVsTw=
X-Received: by 2002:a4a:e055:0:b0:573:2a32:6567 with SMTP id
 v21-20020a4ae055000000b005732a326567mr2411704oos.0.1694600426062; Wed, 13 Sep
 2023 03:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230913040832.114610-1-mario.limonciello@amd.com> <20230913040832.114610-3-mario.limonciello@amd.com>
In-Reply-To: <20230913040832.114610-3-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Sep 2023 12:20:14 +0200
Message-ID: <CAJZ5v0jtn_ak5OyTJ3oxnCjKHhLXCoth+pDYhfLw0didoEAcqg@mail.gmail.com>
Subject: Re: [PATCH v18 2/2] PCI: Add a quirk for AMD PCIe root ports w/ USB4 controllers
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        iain@orangesquash.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 13, 2023 at 6:11 AM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Iain reports that USB devices can't be used to wake a Lenovo Z13
> from suspend. This is because the PCIe root port has been put
> into D3hot and AMD's platform can't handle USB devices waking the
> platform from a hardware sleep state in this case.

It would be good to mention the PMC involvement, because it is
necessary to trigger the issue IIUC.

Apparently, if a Root Port is in D3hot at the time the PMC is called
to reduce the platform power, the PMC takes that as a license to do
something that prevents wakeup signaling from working.

> This problem only occurs on Linux, when waking from a platform hardware
> sleep state. Comparing the behavior on Windows and Linux, Windows
> doesn't put the root ports into D3.
>
> In Windows systems that support Modern Standby specify hardware
> pre-conditions for the SoC to achieve the lowest power state by device
> constraints in a SOC specific "Power Engine Plugin" (PEP) [1] [2].
> They can be marked as disabled or enabled and when enabled can specify
> the minimum power state required for an ACPI device.
>
> The policy on Linux does not take constraints into account to decide what
> state to put the device into at suspend like Windows does.

I'm not sure whether or not it is really clear what happens in Windows
nor whether it is relevant for this patch.

The relevant information is that Windows keeps these ports in D0 and
that demonstrably prevents the PMC from using a platform state in
which PCIe wakeup doesn't work.  Therefore Linux needs to do the same
thing, but only if system wakeup is enabled for them (or the devices
underneath).

> Rather for
> devices that support D3, the target state is selected by this policy:
> 1. If platform_pci_power_manageable():
>    Use platform_pci_choose_state()
> 2. If the device is armed for wakeup:
>    Select the deepest D-state that supports a PME.
> 3. Else:
>    Use D3hot.
>
> Devices are considered power manageable by the platform when they have
> one or more objects described in the table in section 7.3 of the ACPI 6.5
> specification [3].
>
> If devices are not considered power manageable; specs are ambiguous as
> to what should happen.  In this situation Windows 11 leaves PCIe
> ports in D0 while Linux puts them into D3 due to the policy introduced by
> commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend").
>
> As the Windows PEP driver uses constraints to express the desired state
> that should be selected for suspend  but Linux doesn't introduce a quirk
> for the problematic root ports.

I would say "but Linux doesn't do that, so ...", because it currently
reads like the quirk was not present which is slightly confusing.

>
> When selecting a target state specifically for sleep in
> `pci_prepare_to_sleep` this quirk will prevent the root ports from
> selecting D3hot or D3cold if they have been configured as a wakeup source.
>
> Cc: stable@vger.kernel.org
> Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/platform-design-for-modern-standby#low-power-core-silicon-cpu-soc-dram [1]
> Link: https://uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0_Idle.pdf [2]
> Link: https://uefi.org/specs/ACPI/6.5/07_Power_and_Performance_Mgmt.html#device-power-management-objects [3]
> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> Reported-by: Iain Lane <iain@orangesquash.org.uk>
> Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> The same PCI ID is used for multiple different root ports.  This problem
> only affects the root port that the USB4 controller is connected to.
>
>  drivers/pci/pci.c    |  5 +++++
>  drivers/pci/quirks.c | 28 ++++++++++++++++++++++++++++
>  include/linux/pci.h  |  2 ++
>  3 files changed, 35 insertions(+)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 59c01d68c6d5..a113b8941d09 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2752,6 +2752,11 @@ int pci_prepare_to_sleep(struct pci_dev *dev)
>         if (target_state == PCI_POWER_ERROR)
>                 return -EIO;
>
> +       /* quirk to avoid setting D3 */
> +       if (wakeup && dev->dev_flags & PCI_DEV_FLAGS_NO_WAKE_D3 &&
> +          (target_state == PCI_D3hot || target_state == PCI_D3cold))
> +               target_state = PCI_D0;
> +
>         pci_enable_wake(dev, target_state, wakeup);
>
>         error = pci_set_power_state(dev, target_state);
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index eeec1d6f9023..c6f2c301f62a 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3869,6 +3869,34 @@ static void quirk_apple_poweroff_thunderbolt(struct pci_dev *dev)
>  DECLARE_PCI_FIXUP_SUSPEND_LATE(PCI_VENDOR_ID_INTEL,
>                                PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C,
>                                quirk_apple_poweroff_thunderbolt);
> +
> +
> +/*
> + * Putting PCIe root ports on Ryzen SoCs with USB4 controllers into D3 power
> + * states may cause problems when the system attempts wake up from s2idle.
> + *
> + * This manifests as a missing wakeup interrupt on the following systems:
> + * Family 19h model 44h (PCI 0x14b9)
> + * Family 19h model 74h (PCI 0x14eb)
> + * Family 19h model 78h (PCI 0x14eb)
> + *
> + * Add a quirk to the root port if a USB4 controller is connected to it
> + * to avoid D3 power states.
> + */
> +static void quirk_ryzen_rp_d3(struct pci_dev *pdev)
> +{
> +       struct pci_dev *child = NULL;
> +
> +       while (child = pci_get_class(PCI_CLASS_SERIAL_USB_USB4, child)) {
> +               if (pci_upstream_bridge(child) != pdev)
> +                       continue;
> +               pdev->dev_flags |= PCI_DEV_FLAGS_NO_WAKE_D3;
> +               pci_info(pdev, "quirk: disabling D3 for wakeup\n");
> +               break;

I'd use pcie_find_root_port() here.

> +       }
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x14b9, quirk_ryzen_rp_d3);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x14eb, quirk_ryzen_rp_d3);
>  #endif
>
>  /*
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 8c7c2c3c6c65..2292fbc20630 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -245,6 +245,8 @@ enum pci_dev_flags {
>         PCI_DEV_FLAGS_NO_RELAXED_ORDERING = (__force pci_dev_flags_t) (1 << 11),
>         /* Device does honor MSI masking despite saying otherwise */
>         PCI_DEV_FLAGS_HAS_MSI_MASKING = (__force pci_dev_flags_t) (1 << 12),
> +       /* Wakeup events don't work over D3 */
> +       PCI_DEV_FLAGS_NO_WAKE_D3 = (__force pci_dev_flags_t) (1 << 13),
>  };
>
>  enum pci_irq_reroute_variant {
> --

Overall, I think that this is much better than the previous
iterations, because it adds the quirk where it is needed and triggers
it under the conditions in which it matters.

So with the above addressed, please feel free to add

Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>

to this patch.
