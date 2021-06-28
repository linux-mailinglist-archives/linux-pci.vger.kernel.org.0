Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 362A13B67C1
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jun 2021 19:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbhF1Riv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Jun 2021 13:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbhF1Riu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jun 2021 13:38:50 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E290BC061574
        for <linux-pci@vger.kernel.org>; Mon, 28 Jun 2021 10:36:24 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id c8so14762421pfp.5
        for <linux-pci@vger.kernel.org>; Mon, 28 Jun 2021 10:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GGtA7KmG4o78hcTt7ZnGdtNRg3dvE4rEaAeKUvUMqG8=;
        b=q7O3PLK5p3FkmEMgXLFp5yfmTxe66TbOnr+5Qhw+KTd4bhLO8mxfBffwiNNlCGBdUJ
         LESRbM75Y93TFKuMZ9UiKbV5ISBtZCLzbTNvOKRXCgNy1H8zVAqlImBjCr/UJbfjylTy
         xKBcGSO/P/dqhuBrVFzS3PW7q8MjQgY79CVeZusNsAXWLlr5ytpND/H6pm0UiXnrRQEi
         O8pW4MXb57t0JPUGqML2v7y0sHMJac6VUUcOr3XwsVLmwHlo7IIEafkHO6EC6yXNhMxS
         d5neHoTteJ+L2D+HnDExOUeFQXSFHW7qg0gAu8MHftWz30z3guPy3/MrPV3fabAOdOxK
         3XJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GGtA7KmG4o78hcTt7ZnGdtNRg3dvE4rEaAeKUvUMqG8=;
        b=i3B8/wVKq7LInC5fXcKJbVqdSdAR931zWn2PPEC9L2heYPql9v098HQ3rc1y1cmR9y
         G4kKoX8KtWA53hNg23a5bpQ4EE1VCxWUtV8pEQUVyfoITriNQfwlBmM2xbJfmzY4rdPO
         7vlwhjxCM+mxrHe1oxpAhPtueBQOcfGjJdl0Jpp3bM6bweFO5dEh81fi2Atgk8EDRaC5
         TqandzSlJX5mbjCjthBdl2lZSsCPbeby+l1H3BnbMIaAj/TymOWjIQeO9+vWNURfQjNP
         xx5zWMhDPuVJa+KeNWoztqnJT/atE0090CJu4m+dumkW3J5ccYm6O8HOVJZgiC5zrvYJ
         +Klw==
X-Gm-Message-State: AOAM5315eUh/MPXJSpyTg5M7gJJCDZOOdxHq1ISm8oXkt0p3gq8DN1Mu
        qlNlI79UV3B5eWERolE7BvmNgdwC4e5fbrqFz0aqng==
X-Google-Smtp-Source: ABdhPJx0bGkCkBnmJAJGpvA8M8TmO8U8Qxfs05H2Q7bgUvFfGActrmAnYTJnQP/mD4IzfO+NQWzSVkVdgUWtee/H43Y=
X-Received: by 2002:a65:6248:: with SMTP id q8mr6548554pgv.279.1624901784442;
 Mon, 28 Jun 2021 10:36:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210625233118.2814915-1-kw@linux.com> <20210625233118.2814915-2-kw@linux.com>
 <YNmf9sAB2NEnivsk@infradead.org>
In-Reply-To: <YNmf9sAB2NEnivsk@infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 28 Jun 2021 10:36:13 -0700
Message-ID: <CAPcyv4ihEZB7kXKVA1GCbWv=ZR2hvBfhwBX9fBFYYTCdg=aLrg@mail.gmail.com>
Subject: Re: [PATCH 1/2] sysfs: Invoke iomem_get_mapping() from the sysfs open callback
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Krzysztof Wilczy??ski" <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Kees Cook <keescook@chromium.org>,
        "Pali Roh??r" <pali@kernel.org>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 28, 2021 at 3:12 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Jun 25, 2021 at 11:31:17PM +0000, Krzysztof Wilczy??ski wrote:
> >       if (battr->mapping)
> > -             of->file->f_mapping = battr->mapping;
> > +             of->file->f_mapping = battr->mapping();
>
> I think get_mapping() is a better name now.  That being said this
> whole programming model looks a little weird.

I think both those points are fair.

> Also, does this patch imply the mapping field of the sysfs bin
> attributes wasn't used before at all?

It defaulted to an address_space per file rather than a shared address
space across all files that map physical addresses as file offsets.
