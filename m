Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 644AD41B245
	for <lists+linux-pci@lfdr.de>; Tue, 28 Sep 2021 16:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241306AbhI1Onx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Sep 2021 10:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241152AbhI1Onw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Sep 2021 10:43:52 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CA8C061745
        for <linux-pci@vger.kernel.org>; Tue, 28 Sep 2021 07:42:13 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id n4-20020a4aa7c4000000b002adb4997965so5561132oom.10
        for <linux-pci@vger.kernel.org>; Tue, 28 Sep 2021 07:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EhyfaFfmpYzLgiWiMX1s0Z67f4LnrHK0KizRdjLnqJw=;
        b=chZAM6VPfyeAr8nqg4SrTVeBKQVNy32nK0MCL9hXLqYHkCSaBIuCY4L9340PwMXY81
         oX7KSMtTXh9aMON1lHCK0x3P5EwD2uawm9OkvBX4/0RXdgLlydme/qvFUvgvv9WA9Sv/
         Yz21N3KSQUS2EZKolBII/gB4UKw+N3eLKo52na8cVvsAJ+Qc2SeaGzdn8hRPrSmtLUIP
         aRpX80YJRQ8nBCKprXegn9SXbCfxmYUl3oIwG6UYYMLCsBzmBW5xMWFkV25U8SWzllts
         kIxnMRI6kDbq5RYBmMNwi7Wlv9DpyqfjkDB7DdGDvHHixU/+azKq4y+P+1z9W+Dxdw1N
         bQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EhyfaFfmpYzLgiWiMX1s0Z67f4LnrHK0KizRdjLnqJw=;
        b=bLyDl8BpjVTqt9jFK6eN85C2svPSiMPEF5FQjkYJZkTdPHPeFZI/h3Ze7oB80V1mVp
         tn/vWl9+2t3SrjFMkLln5Q9AQz+uQEUsEgHZFITojT1z4Ps6YIy9SC3CK/kXol6n0kvG
         ZajVUUivFzeEeff2y+RNCBFQ3Hqm8zVQKGbjzNA5Bvjbm7eMrfRLuIR4NJBDQoJpeJuP
         XxTKqImnoqiyVjuPh6p7PPnGe8/BGrPiJH3HlnMD61qoTkouvwX/hIJPacDrysz5u2hu
         RfIkUrtjvpdE3IWJEa5wRJa66p9On7Prgr7HiPgiPB8Cl5eyxD4Vo2kXFuBTlY3ZwO9c
         mabg==
X-Gm-Message-State: AOAM532zV6nFTFJPLh3bGE6AnIOv1MreEqsBRWRBq7U6n06WjZQPcimz
        9DSQY8AW4fDOfFzjcutNu/y3YqS9dbJ9Xd63xj8kuA==
X-Google-Smtp-Source: ABdhPJxsyNViSzziMqVNWC0HCL2fNBAjJtzRxqsLj/BUr+opO/6Yx5+T1yeJwLyWxMocosrCzkw74g3ptylH1JuvRA0=
X-Received: by 2002:a4a:88e2:: with SMTP id q31mr5127880ooh.91.1632840132764;
 Tue, 28 Sep 2021 07:42:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210923172647.72738-1-ben.widawsky@intel.com> <20210923172647.72738-4-ben.widawsky@intel.com>
In-Reply-To: <20210923172647.72738-4-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 28 Sep 2021 07:42:00 -0700
Message-ID: <CAPcyv4jZUiwqGrYGX3Mmj9XqUvZwZwh79wAQTFxf5g+wZOohtQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] cxl/pci: Remove pci request/release regions
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Andrew Donnellan <ajd@linux.ibm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "David E. Box" <david.e.box@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 23, 2021 at 10:26 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> Quoting Dan, "... the request + release regions should probably just be
> dropped. It's not like any of the register enumeration would collide
> with someone else who already has the registers mapped. The collision
> only comes when the registers are mapped for their final usage, and that
> will have more precision in the request."

Looks good to me:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

>
> Recommended-by: Dan Williams <dan.j.williams@intel.com>

This isn't one of the canonical tags:
Documentation/process/submitting-patches.rst

I'll change this to Suggested-by:

> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/pci.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index ccc7c2573ddc..7256c236fdb3 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -453,9 +453,6 @@ static int cxl_pci_setup_regs(struct cxl_mem *cxlm)
>                 return -ENXIO;
>         }
>
> -       if (pci_request_mem_regions(pdev, pci_name(pdev)))
> -               return -ENODEV;
> -
>         /* Get the size of the Register Locator DVSEC */
>         pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
>         regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
> @@ -499,8 +496,6 @@ static int cxl_pci_setup_regs(struct cxl_mem *cxlm)
>                 n_maps++;
>         }
>
> -       pci_release_mem_regions(pdev);
> -
>         for (i = 0; i < n_maps; i++) {
>                 ret = cxl_map_regs(cxlm, &maps[i]);
>                 if (ret)
> --
> 2.33.0
>
