Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F018E4F4718
	for <lists+linux-pci@lfdr.de>; Wed,  6 Apr 2022 01:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbiDEU7R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Apr 2022 16:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382107AbiDEPO2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Apr 2022 11:14:28 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B081700BE;
        Tue,  5 Apr 2022 06:26:15 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-2e5e9025c20so135503637b3.7;
        Tue, 05 Apr 2022 06:26:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5bma3Hv9/Du0X4/97+r/i96qcpXIT9vsWsP+NmZQEhc=;
        b=Vl4ngRqcIeckA/jKuKB4ELhRPTohkhg1Wqw0NA5NEXPIN81N78SpyBvYEtGcDGO/yj
         fHwy8V4//fTFc1pnlG+xf2tsbQQya205qkpRU3j2uzJ5oxizPaVI+8mkcS5C/RQ3h8xE
         sRhWmiHrMiHPG0PiMypbe4mrarR24sjBwetednlAJ9au+MQyRawPrbulFdXDd7Fw9TL+
         UvZw0tsi2g0b+sef2fagOeD1ivYsAWj4RO5WBgTapngrnL88e+UMLGEFWPl3jWTo2q+N
         8AcVXOyPgDBJsWTRaDgOdj4rvGWiAXVvu42r2AOyzggO0WBsK87unrPD1uAa0zFHVxUz
         ozDQ==
X-Gm-Message-State: AOAM530pzAdLWJ7ZQT4ykfJBCEAhhMe/HMePa2yhBoy0sEm7Ksvcy3XF
        7lbsbDJ4Sxlx9Pswf+SZd7yWkcM+D+JGhfWzPhA=
X-Google-Smtp-Source: ABdhPJwSoRVMoL8d5NZt/uFMN/p5bnGsKoxUE2f3GX9NbHU0ViSKhN6b3N2cxmhRKLuKcvzdrUX4TUIagp1Us0uHFq8=
X-Received: by 2002:a81:1549:0:b0:2eb:3dc7:bd16 with SMTP id
 70-20020a811549000000b002eb3dc7bd16mr2689122ywv.7.1649165174251; Tue, 05 Apr
 2022 06:26:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220325184609.4059963-1-rajatja@google.com> <20220325184609.4059963-2-rajatja@google.com>
In-Reply-To: <20220325184609.4059963-2-rajatja@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Apr 2022 15:26:03 +0200
Message-ID: <CAJZ5v0hH-Xujak9jGLOvxnLVHXCms8SU-2qJnzPXpAGK4FBxqA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] PCI: Rename pci_dev->untrusted to pci_dev->untrusted_dma
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
> Rename the field to make it more clear, that the device can execute DMA
> attacks on the system, and thus the system may need protection from
> such attacks from this device.
>
> No functional change intended.
>
> Signed-off-by: Rajat Jain <rajatja@google.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> v5: Use "untrusted_dma" as property name, based on feedback.
>     Reorder the patches in the series.
> v4: Initial version, created based on comments on other patch
>
>  drivers/iommu/dma-iommu.c   | 6 +++---
>  drivers/iommu/intel/iommu.c | 2 +-
>  drivers/iommu/iommu.c       | 2 +-
>  drivers/pci/ats.c           | 2 +-
>  drivers/pci/pci-acpi.c      | 2 +-
>  drivers/pci/pci.c           | 2 +-
>  drivers/pci/probe.c         | 8 ++++----
>  drivers/pci/quirks.c        | 2 +-
>  include/linux/pci.h         | 5 +++--
>  9 files changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index d85d54f2b549..7cbe300fe907 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -497,14 +497,14 @@ static int iova_reserve_iommu_regions(struct device *dev,
>         return ret;
>  }
>
> -static bool dev_is_untrusted(struct device *dev)
> +static bool dev_has_untrusted_dma(struct device *dev)
>  {
> -       return dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
> +       return dev_is_pci(dev) && to_pci_dev(dev)->untrusted_dma;
>  }
>
>  static bool dev_use_swiotlb(struct device *dev)
>  {
> -       return IS_ENABLED(CONFIG_SWIOTLB) && dev_is_untrusted(dev);
> +       return IS_ENABLED(CONFIG_SWIOTLB) && dev_has_untrusted_dma(dev);
>  }
>
>  /**
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 92fea3fbbb11..9246b7c9ab46 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -5570,7 +5570,7 @@ intel_iommu_enable_nesting(struct iommu_domain *domain)
>   */
>  static bool risky_device(struct pci_dev *pdev)
>  {
> -       if (pdev->untrusted) {
> +       if (pdev->untrusted_dma) {
>                 pci_info(pdev,
>                          "Skipping IOMMU quirk for dev [%04X:%04X] on untrusted PCI link\n",
>                          pdev->vendor, pdev->device);
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 8b86406b7162..79fb66af2e68 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1522,7 +1522,7 @@ static int iommu_get_def_domain_type(struct device *dev)
>  {
>         const struct iommu_ops *ops = dev->bus->iommu_ops;
>
> -       if (dev_is_pci(dev) && to_pci_dev(dev)->untrusted)
> +       if (dev_is_pci(dev) && to_pci_dev(dev)->untrusted_dma)
>                 return IOMMU_DOMAIN_DMA;
>
>         if (ops->def_domain_type)
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index c967ad6e2626..477c16ba9341 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -42,7 +42,7 @@ bool pci_ats_supported(struct pci_dev *dev)
>         if (!dev->ats_cap)
>                 return false;
>
> -       return (dev->untrusted == 0);
> +       return (dev->untrusted_dma == 0);
>  }
>  EXPORT_SYMBOL_GPL(pci_ats_supported);
>
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 378e05096c52..1d5a284c3661 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1362,7 +1362,7 @@ static void pci_acpi_check_for_dma_protection(struct pci_dev *dev)
>                 return;
>
>         if (val)
> -               dev->untrusted = 1;
> +               dev->untrusted_dma = 1;
>  }
>
>  void pci_acpi_setup(struct device *dev, struct acpi_device *adev)
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 9ecce435fb3f..1fb0eb8646c8 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -958,7 +958,7 @@ static void pci_std_enable_acs(struct pci_dev *dev)
>         ctrl |= (cap & PCI_ACS_UF);
>
>         /* Enable Translation Blocking for external devices and noats */
> -       if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
> +       if (pci_ats_disabled() || dev->external_facing || dev->untrusted_dma)
>                 ctrl |= (cap & PCI_ACS_TB);
>
>         pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 17a969942d37..d2a9b26fcede 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1587,7 +1587,7 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
>                 dev->is_thunderbolt = 1;
>  }
>
> -static void set_pcie_untrusted(struct pci_dev *dev)
> +static void pci_set_untrusted_dma(struct pci_dev *dev)
>  {
>         struct pci_dev *parent;
>
> @@ -1596,8 +1596,8 @@ static void set_pcie_untrusted(struct pci_dev *dev)
>          * untrusted as well.
>          */
>         parent = pci_upstream_bridge(dev);
> -       if (parent && (parent->untrusted || parent->external_facing))
> -               dev->untrusted = true;
> +       if (parent && (parent->untrusted_dma || parent->external_facing))
> +               dev->untrusted_dma = true;
>  }
>
>  static void pci_set_removable(struct pci_dev *dev)
> @@ -1862,7 +1862,7 @@ int pci_setup_device(struct pci_dev *dev)
>         /* Need to have dev->cfg_size ready */
>         set_pcie_thunderbolt(dev);
>
> -       set_pcie_untrusted(dev);
> +       pci_set_untrusted_dma(dev);
>
>         /* "Unknown power state" */
>         dev->current_state = PCI_UNKNOWN;
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 5f46fed01e6c..7ca3c2cdfb20 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5134,7 +5134,7 @@ static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
>         ctrl |= (cap & PCI_ACS_CR);
>         ctrl |= (cap & PCI_ACS_UF);
>
> -       if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
> +       if (pci_ats_disabled() || dev->external_facing || dev->untrusted_dma)
>                 ctrl |= (cap & PCI_ACS_TB);
>
>         pci_write_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, ctrl);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 678fecdf6b81..b7c5fede0b93 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -444,13 +444,14 @@ struct pci_dev {
>         unsigned int    shpc_managed:1;         /* SHPC owned by shpchp */
>         unsigned int    is_thunderbolt:1;       /* Thunderbolt controller */
>         /*
> -        * Devices marked being untrusted are the ones that can potentially
> +        * Devices marked with untrusted_dma are the ones that can potentially
>          * execute DMA attacks and similar. They are typically connected
>          * through external ports such as Thunderbolt but not limited to
>          * that. When an IOMMU is enabled they should be getting full
>          * mappings to make sure they cannot access arbitrary memory.
>          */
> -       unsigned int    untrusted:1;
> +       unsigned int    untrusted_dma:1;
> +
>         /*
>          * Info from the platform, e.g., ACPI or device tree, may mark a
>          * device as "external-facing".  An external-facing device is
> --
> 2.35.1.1021.g381101b075-goog
>
