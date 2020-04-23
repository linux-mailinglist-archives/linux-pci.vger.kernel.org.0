Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C231B64BC
	for <lists+linux-pci@lfdr.de>; Thu, 23 Apr 2020 21:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgDWTsN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Apr 2020 15:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgDWTsN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Apr 2020 15:48:13 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B7EC09B042
        for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2020 12:48:12 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x25so7865752wmc.0
        for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2020 12:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5ncK8mUbyQRJAXUcfcK2gNTh5SvopNuWEHUfvAJCpqQ=;
        b=bLpFWA4UYiAXFPphnI/drIN1GwdP+PEY+aec498WCbdFB9Ne3A4nBaX9MlF7nbRoOD
         NQWeJBbTwPuUetdriRD5FVQxoydlmXUSogrxI2olZl1r1hNdmhYzBJMUbQhZRrl0AqhZ
         pBlB6OBNnfnYhmhnMRVYqdtfKcuw0FAtdXD+vu6jJKz95f4fjmNVnCGnZPa7m6qDVSan
         XYi+IkCgG05zXC5RxIim/hLhYu+S36nvMKzzQt6GwAtP1XeC8I2Jzz3h2oSPEBTbHuFH
         In58Q0h7zIYXJhcwh3on5KFxsp5y9f9uLy/hj07KPFeVIVO27UZ7tuckosfWzIIdA6qn
         lH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5ncK8mUbyQRJAXUcfcK2gNTh5SvopNuWEHUfvAJCpqQ=;
        b=PDqgxvzMzNQKPXhEmg31rTmRum0tPBZbk7HtuPNBFJlWq0yeJVuXEDBqZSLzYxe4Hf
         tkLSJwKnJeEAUYeA9/Bqmu3u1qrPRBXcHaDB1GPT1hk9FNtowYga/65YTLEDtjTag9cQ
         70QCPrBrBBIvBQApV1l7BY/B+ys45cqaeP8uSLaNzkZEItx1UtjD3HjzPJIwD70g02Cn
         2EU0LZWKiAjso/b9ESqHig6bWvAJzH8nUXbzos4iabZBmOkoeYsmy+OKWhJEg47mK9sE
         ksIgt9q//B92k0q+o77Jy3Y6VdgY/pWQdfWLmUhb1fzQJdJzEhuFR5ZVS0Dk2y+AzdkT
         A0bw==
X-Gm-Message-State: AGi0PuaNffuOEMnqouTV/nZ+jFEtt0f86/d/eHYxCEewMgM1hAlR/fYM
        /UM1QriE/c0iFtaIl20cAjgP+OOzkF1qV2Azv25teg==
X-Google-Smtp-Source: APiQypIo30/rnrgZYuT/Tf+RXaR19Cm3vwGRTbmj5gfurnmQ8Zg2HvKWZPcYoToYWwl3qtHjzG59O7ZaPt9TgQN0bok=
X-Received: by 2002:adf:f844:: with SMTP id d4mr6608940wrq.362.1587671291493;
 Thu, 23 Apr 2020 12:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200406194201.846411-1-alexander.deucher@amd.com>
In-Reply-To: <20200406194201.846411-1-alexander.deucher@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 23 Apr 2020 15:48:00 -0400
Message-ID: <CADnq5_PHrTJK7+p6CuiDxt=LVF636DukpHk5FxjK4ASZFPPG+g@mail.gmail.com>
Subject: Re: [PATCH] PCI/P2PDMA: Add additional AMD ZEN root ports to the whitelist
To:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+ Bjorn

Can chance I can get this picked up for -next?

Thanks,

Alex

On Mon, Apr 6, 2020 at 3:42 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> According to the hw architect, pre-ZEN parts support
> p2p writes and ZEN parts support both p2p reads and writes.
>
> Add entries for Zen parts Raven (0x15d0) and Renoir (0x1630).
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/pci/p2pdma.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 9a8a38384121..91a4c987399d 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -282,6 +282,8 @@ static const struct pci_p2pdma_whitelist_entry {
>  } pci_p2pdma_whitelist[] =3D {
>         /* AMD ZEN */
>         {PCI_VENDOR_ID_AMD,     0x1450, 0},
> +       {PCI_VENDOR_ID_AMD,     0x15d0, 0},
> +       {PCI_VENDOR_ID_AMD,     0x1630, 0},
>
>         /* Intel Xeon E5/Core i7 */
>         {PCI_VENDOR_ID_INTEL,   0x3c00, REQ_SAME_HOST_BRIDGE},
> --
> 2.25.1
>
