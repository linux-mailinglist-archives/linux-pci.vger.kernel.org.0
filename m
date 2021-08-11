Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB4F43E98BF
	for <lists+linux-pci@lfdr.de>; Wed, 11 Aug 2021 21:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhHKT3j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Aug 2021 15:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhHKT3j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Aug 2021 15:29:39 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509F9C061765;
        Wed, 11 Aug 2021 12:29:15 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id a7-20020a9d5c870000b029050333abe08aso4620804oti.13;
        Wed, 11 Aug 2021 12:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cItHMKJVxWFQWZ7rI24FO7YfKCVa/vam+UV+c07Up1o=;
        b=iWEAazlRiGBVCeST1c1e7cLPlTN8E0/DRTC+Bhae5/qa0DJidHsFfDDZICR1xh2jqW
         a9giG76Vp4DmKoBcyDzT/XI2QJOwCBM+LldPNoSwSv9V6dyl2g4Ju5J/p3uaT27bHeJS
         7Ug5gjCJwR0WRWBRcwvV8l7p4L8zlYv3h3lyzb0KFwexwxjy+aes7cDy6Cj7HNTle0Ko
         Oidg8E6/qB9NhurNGGum5OQdqdcqoio5jJpAHKp3E/r6LZSw1x4/j7aalzBhhtvDlxMs
         Dz4HQYeIk6TqwJl28LXMiooX/d8gG3vCQxCwbndVa901PhdMtsMSjh14+EUhqGYSzK39
         OHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cItHMKJVxWFQWZ7rI24FO7YfKCVa/vam+UV+c07Up1o=;
        b=AMk1wAI+L/tIuM6l3CpH4zMxUK7PQmy4wur3zNzzcxbJhy9QPkL6UAgV2WopY4wGRf
         NRZ9D00jX9UOuUyI2Op4uO2rGUHyRD7uSxea7MJKbiYYC6hSzxJWrU+YP+D+x8XSrENX
         uFeaBCSPrM9xUjQMgMVx/uy/l6Jy5K1jcijozKZY1CI9HSBo5bVcT8ZSe1TUQbkr4Udx
         9x8KdFED7Oe1q30f8Y5FR9Uk42QdPkKbp38QXa4yjgorOgGzwEQ+JIVZTpNgNfSK/GXL
         lLDPkpPehlZgVLvZ+BN3XnbITD8hk3uRStDPEERW8b77iMUDVuUkINb0Ivd9iRub0Z9D
         dHFA==
X-Gm-Message-State: AOAM532mcrb+DWey7dr6AlBOymTT9tgsd8E628vmuoZyCVyJKctagB2e
        dmjEKmyaxRqqkL0Xv1ZXjqI3BQ9/UQVhkrak/SI=
X-Google-Smtp-Source: ABdhPJw8P2BEPyaHP96Yjy6S2wYbnIXwHhEmGm+qPmLkxNgYmZbqrkYjLD6Sd8KRIlva1aL6GA+e0zObqJ+5qV00IUE=
X-Received: by 2002:a05:6830:1e78:: with SMTP id m24mr418330otr.23.1628710154710;
 Wed, 11 Aug 2021 12:29:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210811191104.21919-1-Ramesh.Errabolu@amd.com>
In-Reply-To: <20210811191104.21919-1-Ramesh.Errabolu@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 11 Aug 2021 15:29:03 -0400
Message-ID: <CADnq5_OVA1fB5x6=CGrd_5O-i=P7snmoJaTyauF2RKuWjc8Gog@mail.gmail.com>
Subject: Re: [PATCH] Whitelist AMD host bridge device(s) to enable P2P DMA
To:     Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Cc:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 11, 2021 at 3:11 PM Ramesh Errabolu <Ramesh.Errabolu@amd.com> wrote:
>
> Current implementation will disallow P2P DMA if the participating
> devices belong to different root complexes. Implementation allows
> this default behavior to be overridden for whitelisted devices. The
> patch adds an AMD host bridge to be whitelisted

Why do we need this?  cpu_supports_p2pdma() should return true for all
AMD Zen CPUs.

Alex

>
> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
> ---
>  drivers/pci/p2pdma.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 196382630363..7003bb9faf23 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -305,6 +305,8 @@ static const struct pci_p2pdma_whitelist_entry {
>         {PCI_VENDOR_ID_INTEL,   0x2032, 0},
>         {PCI_VENDOR_ID_INTEL,   0x2033, 0},
>         {PCI_VENDOR_ID_INTEL,   0x2020, 0},
> +       /* AMD Host Bridge Devices */
> +       {PCI_VENDOR_ID_AMD,     0x1480, 0},
>         {}
>  };
>
> --
> 2.31.1
>
