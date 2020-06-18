Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6911FFF19
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jun 2020 01:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgFRX7D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Jun 2020 19:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgFRX7C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Jun 2020 19:59:02 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377ABC0613EF
        for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2020 16:59:02 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id z9so9375637ljh.13
        for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2020 16:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=7PagII6fDJ5a58j4a6AG7Cmr2Ky4oSAwW2kgQxweDG4=;
        b=bk69Uz49lDGVSF8gr7ZMuLu8p9PKmzSlrR0dICJpGwPkDkCuTAJOB8fk5cUJzAYrn3
         JnNTgr99A+qNAEMZe5oeoerEEnBQbGHHjYiEIx0RRjt7VDnPaVjwdzCra+naHnexBw1h
         6RmPdbhOC9IFG5xExSklpCRKd1silhEJ0IXQy3chym+qeHxi1Gm16/aamTdFrj9EvwRJ
         QmdAKYB/ARYet+tfMwboPDXub8T2BKtmU1g0GgVirI4ODdT+YLQOwHbDY0ONr/ZHoe1E
         Mf5kiWqymCodNGEb23bnfNFDo2wfM6UeOOqG2d+JKD3pJOEewebJoTMAJBTypd7hVc2l
         /rvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=7PagII6fDJ5a58j4a6AG7Cmr2Ky4oSAwW2kgQxweDG4=;
        b=T9A10mIdZ+x8xltes87NFT9TmGvx/PAE796ioXFZ0KNQIKRdMKRFHX3aI3lxGfj7rD
         pulMK9lGRGHMaMFW8OKby1c1dwn0DiIzzKFk5VPWOEpiLsBVIvSoI7YRsBlm9QDAeeo0
         B7JFTe8LH3QmqnCeEnY3PnIMvNqlD/Cb5LqFpcKSlEXs5BIZzbidIG0lf1Eyx3YIe3Z/
         7nlPtLAOTbXqs5nFDVbUe9Zj1c33SGiUHZm6OgM/Tkqw1NpphKGMc2TqWCuDv4jANg7o
         hs6yYxeoEth0QRfb2J/xI/eGn7ajavUUj81RmR4Z4mMA7ZvCkb9vN/Fjr4zeQbYfMMml
         L0CA==
X-Gm-Message-State: AOAM533DXs9961bva0mIhFp1G7vpqMgSgBzWzUkbrwYuDDwE3q6yzs0r
        41rDIMPWn2d74NLxFVK4+ELm/Eyb2N6FMlnlzALJSg==
X-Google-Smtp-Source: ABdhPJyAjpdXolZGKZCHpc53lqLyp/5JQ7iaobsCS/tjaxk8LKf6058i+Ftd4ABK9yM+9+ziJcptrHcFdaEKtHQrlfo=
X-Received: by 2002:a05:651c:550:: with SMTP id q16mr432239ljp.188.1592524740289;
 Thu, 18 Jun 2020 16:59:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200616011742.138975-1-rajatja@google.com> <20200616011742.138975-4-rajatja@google.com>
In-Reply-To: <20200616011742.138975-4-rajatja@google.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Thu, 18 Jun 2020 16:58:23 -0700
Message-ID: <CACK8Z6GqEaETgVkwd_tsbRmVGLb5kuMPP7eGi54uTCXFEOXiSw@mail.gmail.com>
Subject: Re: [PATCH 4/4] pci: export untrusted attribute in sysfs
To:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Oliver O'Halloran" <oohall@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn, All,

Thank you so much for your helpful review and inputs.

On Mon, Jun 15, 2020 at 6:17 PM Rajat Jain <rajatja@google.com> wrote:
>
> This is needed to allow the userspace to determine when an untrusted
> device has been added, and thus allowing it to bind the driver manually
> to it, if it so wishes. This is being done as part of the approach
> discussed at https://lkml.org/lkml/2020/6/9/1331
>
> Signed-off-by: Rajat Jain <rajatja@google.com>

Considering the suggestions obtained on this patch to move this
attribute to device core, please consider this particular patch
rescinded. I'll submit this as a separate patch since I think that
will take more bake time and more discussion, than the other patches
in this patchset.

Please consider applying the other 3 patches in this patchset though,
and I'd appreciate your review and comments.

Thanks & Best Regards,

Rajat


> ---
>  drivers/pci/pci-sysfs.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 6d78df981d41a..574e9c613ba26 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -50,6 +50,7 @@ pci_config_attr(subsystem_device, "0x%04x\n");
>  pci_config_attr(revision, "0x%02x\n");
>  pci_config_attr(class, "0x%06x\n");
>  pci_config_attr(irq, "%u\n");
> +pci_config_attr(untrusted, "%u\n");
>
>  static ssize_t broken_parity_status_show(struct device *dev,
>                                          struct device_attribute *attr,
> @@ -608,6 +609,7 @@ static struct attribute *pci_dev_attrs[] = {
>  #endif
>         &dev_attr_driver_override.attr,
>         &dev_attr_ari_enabled.attr,
> +       &dev_attr_untrusted.attr,
>         NULL,
>  };
>
> --
> 2.27.0.290.gba653c62da-goog
>
