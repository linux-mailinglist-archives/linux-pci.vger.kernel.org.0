Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5911760DF57
	for <lists+linux-pci@lfdr.de>; Wed, 26 Oct 2022 13:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbiJZLRD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 26 Oct 2022 07:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbiJZLRB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Oct 2022 07:17:01 -0400
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A319185B;
        Wed, 26 Oct 2022 04:17:00 -0700 (PDT)
Received: by mail-qk1-f181.google.com with SMTP id o2so10198615qkk.10;
        Wed, 26 Oct 2022 04:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bkc8jxMr2p6wy1sRq7AUIm9TzPToZYJ54wpY7zhIe7M=;
        b=okIQpk88CukLyRLQlj6tQCb9S9y0qYVOkSH/Bq5gsQKgW4Y71LxCUd2RloCIUIYkUv
         KkHZd+jT12ttmDZF0iMbG7pvjx99gWVp2K5xJLTEPXOcEU0gLckfRkUVBR+EM03ljEfE
         yaVGufqC2mClaLwh2HsqXvyn2CIddOJeTFe9C7UWHmBdo8PpvxnKNWnIGefTpTDNaZMR
         Us5JPvlIRrgliFYZzAgDRuGgooe61hQMdGtHUMsZaYYMSBh/UPfL0hBfttR3gL9AnRot
         WjMyGMcTIofz5S1818qYac9EhCjnLrtc4zkMtxcCr6elE2H1/3E7WbvYN/tAp4nyuzdO
         2/Xw==
X-Gm-Message-State: ACrzQf0p36iWrOR3gg+sBskbfs+BIJaxPTFY4RskIsEwqdVfVvXT4vPs
        RR/ij3ZzBTZTd5PZVIffBUCIDeetpjmc4lvtKeE3LoIq
X-Google-Smtp-Source: AMsMyM6fUqqeJOG0uDJp7tM0ShfTGW7AHW/hrkgyrqrWJCztj5e71zwgscXRycTffepa26BPFVd9UIcmMujBH9yxuVY=
X-Received: by 2002:a05:620a:d89:b0:6cf:c98b:744c with SMTP id
 q9-20020a05620a0d8900b006cfc98b744cmr29776452qkl.443.1666783019193; Wed, 26
 Oct 2022 04:16:59 -0700 (PDT)
MIME-Version: 1.0
References: <20221025221054.12377-1-mario.limonciello@amd.com>
In-Reply-To: <20221025221054.12377-1-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 26 Oct 2022 13:16:45 +0200
Message-ID: <CAJZ5v0iy6WwujE6kwJ2i=A4Cjmvnvi9UgovNp_NzW759MZ-7Aw@mail.gmail.com>
Subject: Re: [PATCH v3] PCI/ACPI: PCI/ACPI: Validate devices with power
 resources support D3
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mehta Sanju <Sanju.Mehta@amd.com>,
        Lukas Wunner <lukas@wunner.de>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 26, 2022 at 12:10 AM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Firmware typically advertises that PCIe devices can support D3
> by a combination of the value returned by _S0W as well as the
> HotPlugSupportInD3 _DSD.
>
> `acpi_pci_bridge_d3` looks for this combination but also contains
> an assumption that if a device contains power resources it can support
> D3.  This was introduced from commit c6e331312ebf ("PCI/ACPI: Whitelist
> hotplug ports for D3 if power managed by ACPI").
>
> On some firmware configurations for "AMD Pink Sardine" D3 is not
> supported for wake in _S0W for the PCIe root port for tunneling.
> However the device will still be opted into runtime PM since
> `acpi_pci_bridge_d3` returns since the ACPI device contains power
> resources.
>
> When the thunderbolt driver is loaded a device link between the USB4
> router and the PCIe root port for tunneling is created where the PCIe
> root port for tunneling is the consumer and the USB4 router is the
> supplier.  Here is a demonstration of this topology that occurs:
>
> ├─ 0000:00:03.1
> |       | ACPI Path: \_SB_.PCI0.GP11 (Supports "0" in _S0W)
> |       | Device Links: supplier:pci:0000:c4:00.5
> |       └─ D0 (Runtime PM enabled)
> ├─ 0000:00:04.1
> |       | ACPI Path: \_SB_.PCI0.GP12 (Supports "0" in _S0W)
> |       | Device Links: supplier:pci:0000:c4:00.6
> |       └─ D0 (Runtime PM enabled)
> ├─ 0000:00:08.3
> |       | ACPI Path: \_SB_.PCI0.GP19
> |       ├─ D0 (Runtime PM disabled)
> |       ├─ 0000:c4:00.3
> |       |       | ACPI Path: \_SB_.PCI0.GP19.XHC3
> |       |       | Device Links: supplier:pci:0000:c4:00.5
> |       |       └─ D3cold (Runtime PM enabled)
> |       ├─ 0000:c4:00.4
> |       |       | ACPI Path: \_SB_.PCI0.GP19.XHC4
> |       |       | Device Links: supplier:pci:0000:c4:00.6
> |       |       └─ D3cold (Runtime PM enabled)
> |       ├─ 0000:c4:00.5
> |       |       | ACPI Path: \_SB_.PCI0.GP19.NHI0 (Supports "4" in _S0W)
> |       |       | Device Links: consumer:pci:0000:00:03.1 consumer:pci:0000:c4:00.3
> |       |       └─ D3cold (Runtime PM enabled)
> |       └─ 0000:c4:00.6
> |               | ACPI Path: \_SB_.PCI0.GP19.NHI1 (Supports "4" in _S0W)
> |               | Device Links: consumer:pci:0000:c4:00.4 consumer:pci:0000:00:04.1
> |               └─ D3cold (Runtime PM enabled)
>
> Allowing the PCIe root port for tunneling to go into runtime PM (even if
> it doesn't support D3) allows the USB4 router to also go into runtime PM.
> The PCIe root port for tunneling stays in D0 but is in runtime PM. Due to
> the device link the USB4 router transitions to D3cold when this happens.
>
> The expectation is the USB4 router should have also remained in D0 since
> the PCIe root port for tunneling remained in D0.
>
> Instead of making this assertion from the power resources check
> immediately, move the check to later on, which will have validated
> that the device supports wake from D3hot or D3cold.
>
> This fix prevents the USB4 router going into D3 when the firmware says that
> the PCIe root port for tunneling can't handle it while still allowing
> system that don't have the HotplugSupportInD3 _DSD to also enter D3 if they
> have power resources that can wake from D3.
>
> Fixes: dff6139015dc6 ("PCI/ACPI: Allow D3 only if Root Port can signal and wake from D3")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> v2->v3:
>  * Reword commit message
> v1->v2:
>  * Just return value of acpi_pci_power_manageable (Rafael)
>  * Remove extra word in commit message
> ---
>  drivers/pci/pci-acpi.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index a46fec776ad77..8c6aec50dd471 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -984,10 +984,6 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
>         if (acpi_pci_disabled || !dev->is_hotplug_bridge)
>                 return false;
>
> -       /* Assume D3 support if the bridge is power-manageable by ACPI. */
> -       if (acpi_pci_power_manageable(dev))
> -               return true;
> -
>         rpdev = pcie_find_root_port(dev);
>         if (!rpdev)
>                 return false;
> @@ -1023,7 +1019,8 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
>             obj->integer.value == 1)
>                 return true;
>
> -       return false;
> +       /* Assume D3 support if the bridge is power-manageable by ACPI. */
> +       return acpi_pci_power_manageable(dev);
>  }
>
>  int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
> --
> 2.34.1
>
