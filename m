Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE47409DE2
	for <lists+linux-pci@lfdr.de>; Mon, 13 Sep 2021 22:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348005AbhIMUH7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Sep 2021 16:07:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:55296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243686AbhIMUHv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Sep 2021 16:07:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C69B1603E7;
        Mon, 13 Sep 2021 20:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631563594;
        bh=3yFwcmqPP0hoGNG3nmRXFMkzTerRnRmkpH0gswnmdnE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jW8jwgj1Tgrv8xzlVBul8jLuM0pvI1YI7V7Px60Pl0SaQ9zcRwVC7ONy/ysZ6+x90
         cA1whEa1/KMcW5vbC/l4h2nELNE2RpZWmNKfP1etScZgia0GZZWa27V0VA1sw9hbOI
         jBrhC2ydhEfmV0IHeBa5ohLZ1s2FfhX8NwIfgva1QkQyd+mC/6rXGFu9FScZhikhGG
         GlpCW7AobGr+qZvuKHN81B7aO9wyLTIVeBaS0BQ3kTzwvVY5jqwWab/vLWy/GGv9Sh
         YW8k4evAE2b0z3kqnLVGL3MFHA4vurMav8takMUMNOY+QYKibJo5cx8oH8oP9LSgnS
         ZUhPELlZS8k/w==
Received: by mail-ej1-f42.google.com with SMTP id i21so23660566ejd.2;
        Mon, 13 Sep 2021 13:06:34 -0700 (PDT)
X-Gm-Message-State: AOAM531p3LrvGMlZrApCh4PozkjDYAqzIBiN8LpDMlPz6pDJyX7m2Xc7
        O4aXQ9ozm9H45ziSMGANMRFPWTzmnmZHlZCFMQ==
X-Google-Smtp-Source: ABdhPJwN1MWGWOUgZkZ2lawCSXPX2nYnpWxKXQ3DsIeOIGZXLjOjxOCGLIMWEsevJxO3lFR0y54EVuySX4KmEDmXvkw=
X-Received: by 2002:a17:906:7250:: with SMTP id n16mr14461348ejk.147.1631563593463;
 Mon, 13 Sep 2021 13:06:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210913172358.1775381-1-jean-philippe@linaro.org> <20210913192805.GA1347289@bjorn-Precision-5520>
In-Reply-To: <20210913192805.GA1347289@bjorn-Precision-5520>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 13 Sep 2021 15:06:21 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq++G1JR15RMtDL8rsfB0i=Xu5xbC0LuAm3mGiVnbFwXtg@mail.gmail.com>
Message-ID: <CAL_Jsq++G1JR15RMtDL8rsfB0i=Xu5xbC0LuAm3mGiVnbFwXtg@mail.gmail.com>
Subject: Re: [PATCH] PCI/ACPI: Don't reset a fwnode set by OF
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:ACPI FOR ARM64 (ACPI/arm64)" <linux-acpi@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Shanker Donthineni <sdonthineni@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 13, 2021 at 2:28 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Rob]
>
> On Mon, Sep 13, 2021 at 06:23:59PM +0100, Jean-Philippe Brucker wrote:
> > Commit 375553a93201 ("PCI: Setup ACPI fwnode early and at the same time
> > with OF") added a call to pci_set_acpi_fwnode() in pci_setup_device(),
> > which unconditionally clears any fwnode previously set by
> > pci_set_of_node().
> >
> > pci_set_acpi_fwnode() looks for ACPI_COMPANION(), which only returns the
> > existing fwnode if it was set by ACPI_COMPANION_SET(). If it was set by
> > OF instead, ACPI_COMPANION() returns NULL and pci_set_acpi_fwnode()
> > accidentally clears the fwnode. To fix this, look for any fwnode instead
> > of just ACPI companions.
> >
> > Fixes: 375553a93201 ("PCI: Setup ACPI fwnode early and at the same time with OF")
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> > This fixes boot of virtio-iommu under OF on v5.15-rc1
> > ---
> >  drivers/pci/pci-acpi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > index a1b1e2a01632..483a9e50f6ca 100644
> > --- a/drivers/pci/pci-acpi.c
> > +++ b/drivers/pci/pci-acpi.c
> > @@ -937,7 +937,7 @@ static struct acpi_device *acpi_pci_find_companion(struct device *dev);
> >
> >  void pci_set_acpi_fwnode(struct pci_dev *dev)
> >  {
> > -     if (!ACPI_COMPANION(&dev->dev) && !pci_dev_is_added(dev))
> > +     if (!dev->dev.fwnode && !pci_dev_is_added(dev))
>
> I don't doubt that this is correct, but it seems excessively subtle,
> like we're violating some layering or something.

That stems from DT and ACPI node handle handling being asymmetric in
struct device. DT has its own node pointer plus the fwnode handle
while ACPI only uses fwnode handle. It's that way because who is going
to replace all the dev->of_node occurrences? Only ~7500 of them based
on a quick grep.

> Rafael, Rob, is there anything better we can do here?

I don't think so. Using dev_fwnode() would be slightly better than
direct access.

Rob
