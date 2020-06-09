Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2BEB1F4803
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jun 2020 22:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733166AbgFIUX5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jun 2020 16:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728272AbgFIUX4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jun 2020 16:23:56 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F9DC05BD1E;
        Tue,  9 Jun 2020 13:23:56 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l26so4021537wme.3;
        Tue, 09 Jun 2020 13:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ck1C6EXNHUjnwGhraJCX8UhZ310w3SODnS0Nvhpy7Ok=;
        b=kCzVd5FILPb4egqErBHlATnOzfXPIbTWCRF8E98PDByFmSR91m7L94+UvwP+svZ4Dj
         6R4uQ6sjO1OcpaMoRA/A99bINYdE3a5QamoJEqb8pPN/gwku6piVEwr5omelIVFse3Xu
         YzarWMs7HObw6skg1BIbwg8ncKddn+/3xzWtyFtNdPnizy5iPTb3qrzqnPC5Q1v2tZKi
         ZWdq9W4KX5No9iMpALXa9dApY7lkCO5o5GoLj6o27jtI1+cBrmwVg6bVlFmMmZ/srBJG
         +PVMg0Vx68kelE+hzEkcFe8NZO9bQ1fknbV9Ro1zSy4Azu9o7KvCgzgvwjqqTKsmYWo6
         O8dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ck1C6EXNHUjnwGhraJCX8UhZ310w3SODnS0Nvhpy7Ok=;
        b=s0aPEHL3PJ8+rdNeBavtqbbMPYsAYx56mt3acTe8xtTSVoNHC1xZeXiqlLMxjhERw3
         xoOC9equ1mWCxhEs4B9YsyLNmGdw9W97g4Ah6k+FwLl+uDQrCZnqDR8KVq6crmPBn1C8
         xQijLMSYu5QVME8KkJJFryb/cu+eceT2R5oeIQhvsaITwfbyV07890faYyL1AfU/66T/
         uixJJvNANoVSMTb0v4+Z8OpwoIde67ueEcOl18sjDBnDIQ42XiyudW+tFzrIjF43pG/T
         RyroHwCQrc1LYJ87jf3w+Fi0nRF+PgIyrIMQY889ZHkiTaOMKJWOzFkW2Htp5qrxIcnE
         /EwA==
X-Gm-Message-State: AOAM532qNAHmvX15BgSGQvL0pEWWr2isk8coV37Luh9zoqZ5uWAPNx3r
        JfYmTpCDkjwNPL0sUNl/Z6cm68fSHHQTV9Wu7ec=
X-Google-Smtp-Source: ABdhPJwihJefCyui3E30tzcKp6cIuhvys9g/LJ6hC/9nbSQ9EPyOHipcwlZJG5XUXe+Q9lkGOQXaHWSptAQdy7oGtqY=
X-Received: by 2002:a1c:541d:: with SMTP id i29mr438556wmb.73.1591734235174;
 Tue, 09 Jun 2020 13:23:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200609091148.32749-1-piotr.stankiewicz@intel.com> <20200609091804.1220-1-piotr.stankiewicz@intel.com>
In-Reply-To: <20200609091804.1220-1-piotr.stankiewicz@intel.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 9 Jun 2020 16:23:44 -0400
Message-ID: <CADnq5_N95PjqU4nMgZBL_PoNKk8ourb_k9HLGvR_RN5FeZ3tkg@mail.gmail.com>
Subject: Re: [PATCH v3 07/15] drm/amdgpu: Use PCI_IRQ_MSI_TYPES where appropriate
To:     Piotr Stankiewicz <piotr.stankiewicz@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Aurabindo Pillai <mail@aurabindo.in>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
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

On Tue, Jun 9, 2020 at 5:18 AM Piotr Stankiewicz
<piotr.stankiewicz@intel.com> wrote:
>
> Seeing as there is shorthand available to use when asking for any type
> of interrupt, or any type of message signalled interrupt, leverage it.
>
> Signed-off-by: Piotr Stankiewicz <piotr.stankiewicz@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index 0cc4c67f95f7..97141aa81f32 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -248,17 +248,8 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
>         adev->irq.msi_enabled = false;
>
>         if (amdgpu_msi_ok(adev)) {
> -               int nvec = pci_msix_vec_count(adev->pdev);
> -               unsigned int flags;
> -
> -               if (nvec <= 0) {
> -                       flags = PCI_IRQ_MSI;
> -               } else {
> -                       flags = PCI_IRQ_MSI | PCI_IRQ_MSIX;
> -               }
>                 /* we only need one vector */
> -               nvec = pci_alloc_irq_vectors(adev->pdev, 1, 1, flags);
> -               if (nvec > 0) {
> +               if (pci_alloc_irq_vectors(adev->pdev, 1, 1, PCI_IRQ_MSI_TYPES) > 0) {
>                         adev->irq.msi_enabled = true;
>                         dev_dbg(adev->dev, "using MSI/MSI-X.\n");
>                 }
> --
> 2.17.2
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
