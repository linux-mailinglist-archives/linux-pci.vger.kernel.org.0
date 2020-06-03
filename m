Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C68A1ED117
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jun 2020 15:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgFCNns (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jun 2020 09:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgFCNnr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Jun 2020 09:43:47 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9A7C08C5C0;
        Wed,  3 Jun 2020 06:43:47 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h5so2426322wrc.7;
        Wed, 03 Jun 2020 06:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SOmyve9bUDmubIVPzpcziP63vVpum2UbcrFicqpkq+w=;
        b=dLQbd/+8npTMk4QLp1GlJLJSXrvXa8CCkj+1zvjWm4wHCtiVTwrq10h9aZ8EzttvgH
         kJY1Ro32Qv32VjsmheO8rPIQTYMTXHQjWKtsoKdhC/6fkjgi+uMe3mJgDggZWU0HwoYQ
         Cs3Goq8PKh3PlsqRTG8pZ/803xSfaphW1r5tJVqAKbBoTb9M4N5qVQuqUIxhxAKqX6df
         wSO4RTleRp1+UKJ8HlRhL2Ev7l6ZAZXGAJP5BeFs7Ar9uPyJ84DvN0XCHKha6fuo4Kb0
         4paMO6Z/6XR5CFul1cJJmPh5unfcREiHYfKfg09IJmc+76JgIlchU9bNd8vJcirWpn0h
         QFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SOmyve9bUDmubIVPzpcziP63vVpum2UbcrFicqpkq+w=;
        b=jQAL+Cmi882qkOK4TAodpdEeL6cMOjrMIGyuoEoSPTrU+3JnHGdIVL5WbmGiFiTuDw
         js/VBUVTBv+smOubUIjRoCRcxvY8MXnR91gWIj3iaUrSM8z9rV+wrGoZXEdEgzSqkjNn
         KtLy9ODeDOw8I4HIf5myw7YKdugsM2scbD0JKOQApy0vPc8rGYXfnM9Niesc6uCseEwq
         UGsK5EmmlbV7tXevgjW+I6EhaC8RF32oOsW38Txhig/HJ5nRsZkL20HUbfoFm1bsSStn
         VN1/sSG00TM8snHwf1B67H7cslS8vcUO52dV0lQROHK72jld5gsApndABwu187qbB6w9
         tpLQ==
X-Gm-Message-State: AOAM531Ua/Mz/YgSBf/coNFgrNi5upXpIwJsktsWUFCn/Ti8Kokt2VkO
        fHrXC1yeu1lXMbfWW8fEDJT3QMbgCGM0kJkM0Gg=
X-Google-Smtp-Source: ABdhPJyDqMwuUN33to+4ovZr0Z2o1K7X5Asu5DFxHM0Idg4MwGzkmHriwv3Fc/65Nvi83qQQQIvJeu3qs+VvIdRSuGc=
X-Received: by 2002:a5d:6789:: with SMTP id v9mr33118221wru.124.1591191826155;
 Wed, 03 Jun 2020 06:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200603114212.12525-1-piotr.stankiewicz@intel.com> <20200603114758.13295-1-piotr.stankiewicz@intel.com>
In-Reply-To: <20200603114758.13295-1-piotr.stankiewicz@intel.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 3 Jun 2020 09:43:34 -0400
Message-ID: <CADnq5_Pa4J3NVprJnpKTih8O1G-oyMMUT4nHb=RZz96i_x+sKw@mail.gmail.com>
Subject: Re: [PATCH v2 07/15] drm/amdgpu: Use PCI_IRQ_MSI_TYPES where appropriate
To:     Piotr Stankiewicz <piotr.stankiewicz@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Emily Deng <Emily.Deng@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        shaoyunl <shaoyun.liu@amd.com>, Sam Ravnborg <sam@ravnborg.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 3, 2020 at 7:48 AM Piotr Stankiewicz
<piotr.stankiewicz@intel.com> wrote:
>
> Seeing as there is shorthand available to use when asking for any type
> of interrupt, or any type of message signalled interrupt, leverage it.
>
> Signed-off-by: Piotr Stankiewicz <piotr.stankiewicz@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index 5ed4227f304b..2588dd1015db 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -249,15 +249,10 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
>
>         if (amdgpu_msi_ok(adev)) {
>                 int nvec = pci_msix_vec_count(adev->pdev);

I think you can drop pci_msix_vec_count() here.  It's not used since
we always request 1 vector.

Alex

> -               unsigned int flags;
>
> -               if (nvec <= 0) {
> -                       flags = PCI_IRQ_MSI;
> -               } else {
> -                       flags = PCI_IRQ_MSI | PCI_IRQ_MSIX;
> -               }
>                 /* we only need one vector */
> -               nvec = pci_alloc_irq_vectors(adev->pdev, 1, 1, flags);
> +               nvec = pci_alloc_irq_vectors(adev->pdev, 1, 1,
> +                                            PCI_IRQ_MSI_TYPES);
>                 if (nvec > 0) {
>                         adev->irq.msi_enabled = true;
>                         dev_dbg(adev->dev, "amdgpu: using MSI/MSI-X.\n");
> --
> 2.17.2
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
