Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0365B40B26B
	for <lists+linux-pci@lfdr.de>; Tue, 14 Sep 2021 17:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbhINPCu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Sep 2021 11:02:50 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:38647 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234455AbhINPCt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Sep 2021 11:02:49 -0400
Received: by mail-ot1-f46.google.com with SMTP id i8-20020a056830402800b0051afc3e373aso18851905ots.5;
        Tue, 14 Sep 2021 08:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a69f0p2LO5nM49i5w+9S50sCyKtjFMTTVJCoHsR1aRM=;
        b=YkjeXHR+8j3ax7mjvYzbeSf1JAcmoFr83uzpN7//WlbX415E2YClaVuCRGYtsR1U6D
         XHDB1iQ114EZ1AyuBBQSNM1v7FP982r41cRfMyDhe9G5gHRACcLoWsKysQoTXq2+QHK6
         xmJXJdOaDIDyRo+9SthDXJOZJnr9oPVj40IXopIz1e4xvUjdr14eTp2h4RRv5GssGamx
         giZ0nhV1iqNYZg3jjQw4i1KsxS2rmAAl4DG4fbJauKxWumWOP1nyS+t78xJmgFFkGaoN
         PInmQDZqdw9ImzFzzvddl3i1agsYdWfSVb3HbLVS9j1j5amai3zi9wlB+p8wFpHwzjMW
         yMGw==
X-Gm-Message-State: AOAM531S8bkfZN/PTWy1JfIqieJ1kk4f5Ek7AU+BBpg/N0/x5gRDyL5u
        vW53Rv9EL2tyLQPvfGFsRZL6hl9idwn8+xRsQqk=
X-Google-Smtp-Source: ABdhPJy+bQzkn6kGRLipFnjyWkwhBd6ENe8CcNTE3CERDrwZUInvEkozWDR1E7HDcWNDT1RjJUftgDmyrR3vofRTVmI=
X-Received: by 2002:a9d:4d93:: with SMTP id u19mr15006591otk.86.1631631692184;
 Tue, 14 Sep 2021 08:01:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210914095120.2132059-1-jean-philippe@linaro.org>
In-Reply-To: <20210914095120.2132059-1-jean-philippe@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 14 Sep 2021 17:01:21 +0200
Message-ID: <CAJZ5v0g9v-0hPNMGdsSRsYq1BSiRGjcML3F3u8=vmjOfaPK87Q@mail.gmail.com>
Subject: Re: [PATCH v2] PCI/ACPI: Don't reset a fwnode set by OF
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 14, 2021 at 11:55 AM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> Commit 375553a93201 ("PCI: Setup ACPI fwnode early and at the same time
> with OF") added a call to pci_set_acpi_fwnode() in pci_setup_device(),
> which unconditionally clears any fwnode previously set by
> pci_set_of_node().
>
> pci_set_acpi_fwnode() looks for ACPI_COMPANION(), which only returns the
> existing fwnode if it was set by ACPI_COMPANION_SET(). If it was set by
> OF instead, ACPI_COMPANION() returns NULL and pci_set_acpi_fwnode()
> accidentally clears the fwnode. To fix this, look for any fwnode instead
> of just ACPI companions.
>
> Fixes: 375553a93201 ("PCI: Setup ACPI fwnode early and at the same time with OF")
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> v2: Use dev_fwnode()
> v1: https://lore.kernel.org/linux-pci/20210913172358.1775381-1-jean-philippe@linaro.org/
> This fixes boot of virtio-iommu under OF on v5.15-rc1
> ---
>  drivers/pci/pci-acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index a1b1e2a01632..0f40943a9a18 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -937,7 +937,7 @@ static struct acpi_device *acpi_pci_find_companion(struct device *dev);
>
>  void pci_set_acpi_fwnode(struct pci_dev *dev)
>  {
> -       if (!ACPI_COMPANION(&dev->dev) && !pci_dev_is_added(dev))
> +       if (!dev_fwnode(&dev->dev) && !pci_dev_is_added(dev))
>                 ACPI_COMPANION_SET(&dev->dev,
>                                    acpi_pci_find_companion(&dev->dev));
>  }
> --
> 2.33.0
>
