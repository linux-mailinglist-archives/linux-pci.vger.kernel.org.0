Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0E62EAFCA
	for <lists+linux-pci@lfdr.de>; Tue,  5 Jan 2021 17:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbhAEQM2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 5 Jan 2021 11:12:28 -0500
Received: from mail-vs1-f44.google.com ([209.85.217.44]:33124 "EHLO
        mail-vs1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbhAEQM2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jan 2021 11:12:28 -0500
Received: by mail-vs1-f44.google.com with SMTP id e15so210757vsa.0
        for <linux-pci@vger.kernel.org>; Tue, 05 Jan 2021 08:12:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YKZ4xYRhDSu2DhCjvtXkOokAzr15+nlnfXlfiKslrrY=;
        b=k6KAD1pZgH8udaKAz22ft8fKBBiy1ORCg4s8d6ncJAdvimVUNMvbdfc9gTlZJkvYpG
         Av8CnfoIHVttxp3ncFh+NpkHbpLyUjFiOrQXyslqmeiY3/lDEVvceMNr3Pt/UGAAzHa1
         jievyRW50OGbrK4fdDPlr/wNwf29EIY3hkvvDAq3tszageFgAzKWHm42u2KZytuB3J7O
         MoSUoZrpo1T2je92sv4NlafSJQJkLg/pkWuvbElF1oAse0BZUfjGlaInycMlhTbwx9t1
         EGCFRzDQQlmBDEmbZRp76BD8KQHq1+hhiIgOfxol7kCfeKJTvSQr69UK5mHubOHjWKyC
         hThA==
X-Gm-Message-State: AOAM532B7DfAZwMtMowgszwjihW5HckKozkwCHIH1aLKQpvKalKJLdi0
        CUybeYA3+bPDKQr7JEDZXQQoknUOGkF3LNt4TM4=
X-Google-Smtp-Source: ABdhPJxoSLFz8Dd7wYubvom3orPgOVoBQrS+cRwXKLv/WQ3RJsErbtcru/7MlPQfn43FY+yA0EIP05ZreLahAz7FoMo=
X-Received: by 2002:a05:6102:394:: with SMTP id m20mr177150vsq.50.1609863107202;
 Tue, 05 Jan 2021 08:11:47 -0800 (PST)
MIME-Version: 1.0
References: <20210105134404.1545-1-christian.koenig@amd.com> <20210105134404.1545-5-christian.koenig@amd.com>
In-Reply-To: <20210105134404.1545-5-christian.koenig@amd.com>
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Tue, 5 Jan 2021 11:11:31 -0500
Message-ID: <CAKb7UvhUXKTVp9bXmbkU4VR8WQVZ16LNvk8QKkqiOUTKC8DVQg@mail.gmail.com>
Subject: Re: [PATCH 4/4] PCI: add a REBAR size quirk for Sapphire RX 5600 XT Pulse.
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, devspam@moreofthesa.me.uk,
        Linux PCI <linux-pci@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 5, 2021 at 8:44 AM Christian König
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Otherwise the CPU can't fully access the BAR.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>  drivers/pci/pci.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 16216186b51c..b66e4703c214 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3577,7 +3577,14 @@ u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar)
>                 return 0;
>
>         pci_read_config_dword(pdev, pos + PCI_REBAR_CAP, &cap);
> -       return (cap & PCI_REBAR_CAP_SIZES) >> 4;
> +       cap = (cap & PCI_REBAR_CAP_SIZES) >> 4;
> +
> +       /* Sapphire RX 5600 XT Pulse has an invalid cap dword for BAR 0 */
> +       if (pdev->vendor == PCI_VENDOR_ID_ATI && pdev->device == 0x731f &&
> +           bar == 0 && cap == 0x700)
> +               cap == 0x7f00;

Perhaps you meant cap = 0x7f00?

> +
> +       return cap;
>  }
>  EXPORT_SYMBOL(pci_rebar_get_possible_sizes);
>
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
