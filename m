Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59F84F471E
	for <lists+linux-pci@lfdr.de>; Wed,  6 Apr 2022 01:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240904AbiDEU7z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Apr 2022 16:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350084AbiDEPLq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Apr 2022 11:11:46 -0400
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E17B107A93;
        Tue,  5 Apr 2022 06:25:30 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id w134so15468852ybe.10;
        Tue, 05 Apr 2022 06:25:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E5Al4J7VCG/P8LTv1wy0Uzk4KB0CIZvLVMNw+72bmlY=;
        b=pi+F9TIqKCEsUNjCb9dXoXQQNWKsRRxNdv5tIwo+338XztSKFJIYmHZkceBh6r31HM
         zOTEafVXA117xUkDIWXQSCqSwY7HnBzPCE7H7i85C/kKEg+7wdLDKD+j9xsWQF98VQrl
         5Kjz/7MYovpuUNj8n9fKK9hYnLmdWvAoDaDhCquMQvMxs13dSczKF+xMgB739HndQrSS
         Rp/JRdwBjIGx6li46fitUbQLTiDJJbqjnIXi4rtPfui9XBxI2FZBy2MpNhHlQkWzydG4
         qBUwmqE/gZejHwC62QLm5ZSfAa8sCHXWIfpuGriNwHcsb6EFjqr9zJy5unCcyAqHpyjW
         vTog==
X-Gm-Message-State: AOAM5334oGiOzG8pbMFgDpKN4hv9B9HGkKRbYFupf1gXc4FXR09Cc7DL
        VxPINjrv6k3JFzyzhFHueIjR5jZUD+v7hpIxDsk=
X-Google-Smtp-Source: ABdhPJzvtUL+VkrikhhCBPKyLKqDEV2E5D8I7wR0e3nEvz40gGldfHk2pv2u3E/1r3WC/KqC7zaSc0uRoPXPW/UhUpc=
X-Received: by 2002:a05:6902:1544:b0:63d:d3a7:8cc4 with SMTP id
 r4-20020a056902154400b0063dd3a78cc4mr2582151ybu.622.1649165129602; Tue, 05
 Apr 2022 06:25:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220325184609.4059963-1-rajatja@google.com>
In-Reply-To: <20220325184609.4059963-1-rajatja@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Apr 2022 15:25:17 +0200
Message-ID: <CAJZ5v0jQW3NcbtBWxUW8RQ-eCB3M6wdqztDmPr4q5+=FYmfJHw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] PCI: ACPI: Support Microsoft's "DmaProperty"
To:     Rajat Jain <rajatja@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        Dmitry Torokhov <dtor@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Pavel Machek <pavel@denx.de>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>
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

On Fri, Mar 25, 2022 at 7:46 PM Rajat Jain <rajatja@google.com> wrote:
>
> The "DmaProperty" is supported and documented by Microsoft here:
> https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports
> They use this property for DMA protection:
> https://docs.microsoft.com/en-us/windows/security/information-protection/kernel-dma-protection-for-thunderbolt
>
> Support the "DmaProperty" with the same semantics. This is useful for
> internal PCI devices that do not hang off a PCIe rootport, but offer
> an attack surface for DMA attacks (e.g. internal network devices).
>
> Signed-off-by: Rajat Jain <rajatja@google.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> v5: * Reorder the patches in the series
> v4: * Add the GUID.
>     * Update the comment and commitlog.
> v3: * Use Microsoft's documented property "DmaProperty"
>     * Resctrict to ACPI only
>
>  drivers/acpi/property.c |  3 +++
>  drivers/pci/pci-acpi.c  | 16 ++++++++++++++++
>  2 files changed, 19 insertions(+)
>
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index d0986bda2964..20603cacc28d 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -48,6 +48,9 @@ static const guid_t prp_guids[] = {
>         /* Storage device needs D3 GUID: 5025030f-842f-4ab4-a561-99a5189762d0 */
>         GUID_INIT(0x5025030f, 0x842f, 0x4ab4,
>                   0xa5, 0x61, 0x99, 0xa5, 0x18, 0x97, 0x62, 0xd0),
> +       /* DmaProperty for PCI devices GUID: 70d24161-6dd5-4c9e-8070-705531292865 */
> +       GUID_INIT(0x70d24161, 0x6dd5, 0x4c9e,
> +                 0x80, 0x70, 0x70, 0x55, 0x31, 0x29, 0x28, 0x65),
>  };
>
>  /* ACPI _DSD data subnodes GUID: dbb8e3e6-5886-4ba6-8795-1319f52a966b */
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 1f15ab7eabf8..378e05096c52 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1350,12 +1350,28 @@ static void pci_acpi_set_external_facing(struct pci_dev *dev)
>                 dev->external_facing = 1;
>  }
>
> +static void pci_acpi_check_for_dma_protection(struct pci_dev *dev)
> +{
> +       u8 val;
> +
> +       /*
> +        * Property also used by Microsoft Windows for same purpose,
> +        * (to implement DMA protection from a device, using the IOMMU).
> +        */
> +       if (device_property_read_u8(&dev->dev, "DmaProperty", &val))
> +               return;
> +
> +       if (val)
> +               dev->untrusted = 1;
> +}
> +
>  void pci_acpi_setup(struct device *dev, struct acpi_device *adev)
>  {
>         struct pci_dev *pci_dev = to_pci_dev(dev);
>
>         pci_acpi_optimize_delay(pci_dev, adev->handle);
>         pci_acpi_set_external_facing(pci_dev);
> +       pci_acpi_check_for_dma_protection(pci_dev);
>         pci_acpi_add_edr_notifier(pci_dev);
>
>         pci_acpi_add_pm_notifier(adev, pci_dev);
> --
> 2.35.1.1021.g381101b075-goog
>
