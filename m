Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA1840AEF9
	for <lists+linux-pci@lfdr.de>; Tue, 14 Sep 2021 15:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbhINNeH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Sep 2021 09:34:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:52310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233055AbhINNeH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Sep 2021 09:34:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA4AE60F26;
        Tue, 14 Sep 2021 13:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631626369;
        bh=9DKRV3ofX1R//V78a9Bh2zuoOveRAkC6uw4ue5DFN3w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Upzx8n19R4Cy9XlbQh2dJody+S7QbUlOQME6qsr5IqHlA3Yllq77afQ++vQUtc2M0
         BefCCXe9gj6tx80AxUo4JGSAV+5XqmW8lRE7jMCp7YlnLJ5EIbRh5Ef+vyElU12v4A
         n7r0SF5613V6qxBbuUImRofiWNYlR1ZZ0Nw6P7YCKWpEDNUjwHgfbVofd43I6Eanpw
         YhEZabnRiunD7Z67+Y0uzP/ghswwkQ4wdOYC0P12gyk6gtHUfVT9ua4vG54IE1MnZT
         c2xRAWGQexHbXF2IjAPbiBehXwkpEnzVrCuYGSUer94BFkIb6a8iIb+n26fS2z1MiK
         3BKoGxPdvmlLA==
Received: by mail-qv1-f46.google.com with SMTP id a13so4567040qvo.9;
        Tue, 14 Sep 2021 06:32:49 -0700 (PDT)
X-Gm-Message-State: AOAM533A2CT5HnmdfhBuJlWzi3UEBBBfjpSTeWGSLZpZdCW+FAQVtDl/
        RxIGLQ3ZURCk5Wdo3riX9Ls/uznajxnak/RpHw==
X-Google-Smtp-Source: ABdhPJyGEV1N12qjyqN9QqOoBBIFXKwb4iqIv+e7C0iMbJX1etmhDwL1uY1Zdp499VZCNnwNlRA3iWIKSBG8uELxPos=
X-Received: by 2002:ad4:56a8:: with SMTP id bd8mr5312216qvb.0.1631626368927;
 Tue, 14 Sep 2021 06:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210914095120.2132059-1-jean-philippe@linaro.org>
In-Reply-To: <20210914095120.2132059-1-jean-philippe@linaro.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 14 Sep 2021 08:32:37 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKCAezBpSghLyFjdAThQ-sMSmcnQ7-Wp_KzZk5BzQ5+TA@mail.gmail.com>
Message-ID: <CAL_JsqKCAezBpSghLyFjdAThQ-sMSmcnQ7-Wp_KzZk5BzQ5+TA@mail.gmail.com>
Subject: Re: [PATCH v2] PCI/ACPI: Don't reset a fwnode set by OF
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:ACPI FOR ARM64 (ACPI/arm64)" <linux-acpi@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Shanker Donthineni <sdonthineni@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 14, 2021 at 4:55 AM Jean-Philippe Brucker
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
> ---
> v2: Use dev_fwnode()
> v1: https://lore.kernel.org/linux-pci/20210913172358.1775381-1-jean-philippe@linaro.org/
> This fixes boot of virtio-iommu under OF on v5.15-rc1
> ---
>  drivers/pci/pci-acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
