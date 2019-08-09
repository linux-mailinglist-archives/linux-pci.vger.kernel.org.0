Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDCD881AD
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2019 19:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436752AbfHIRwW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Aug 2019 13:52:22 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41553 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbfHIRwU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Aug 2019 13:52:20 -0400
Received: by mail-ot1-f65.google.com with SMTP id o101so870645ota.8;
        Fri, 09 Aug 2019 10:52:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nbyrxcop1uQWqc7fufmpX71xGWJXim2W4dpRiy15ERE=;
        b=KwT3gvX+8Ody4TD+w9C/2I8OiOYARHOUaXoq2RVPBKgzDyhKAFE72BZWZBz4naz9ea
         ymXW+V2FyQqeSrSp41eQIVG1w5ZSJCA0FunpwKncVDxWNOrpyZgjGyw8WwLLVDb8n7pZ
         UBhOSRVXF/2k/ot0wDeuYtyuShJYzBcyonW/2gqeBA4sDwsXGI8Hr7L391UeFb+G11Q3
         0P8PQWkgI967qzzZWZqs9KdGVZqSRw8F4sPDCldkfqM6idbUJmaimhAu/YokbNPa6wnu
         YpEfXgn8tVUXzhuT4Wa0SXrJuzpqGK2fYbeQMx1uOFnhgjBb0IZqdIQKofpYi90zPbQA
         5S+A==
X-Gm-Message-State: APjAAAWCVqDtpjud6fIKm3Y3IWrt3TNZoZwVRu8D26A8ZYP2klwcmLwC
        4qJjQjXMEo8Z2c9RNArvmZtcA6KX0ch53lvqDto=
X-Google-Smtp-Source: APXvYqzy8p0sdfdCiUyVBCAwZ+V1OwGLShX2YCQ7LttipHfcMokrC+pv53nzFyaIGzPpkw3W1PCjzxdP2BOpjOdBnag=
X-Received: by 2002:a05:6808:3c5:: with SMTP id o5mr7193661oie.102.1565373139054;
 Fri, 09 Aug 2019 10:52:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190809174825.2572-1-marek.vasut@gmail.com>
In-Reply-To: <20190809174825.2572-1-marek.vasut@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 9 Aug 2019 19:52:07 +0200
Message-ID: <CAMuHMdV9baf=p5RkbcPikXfPV2Uo-qhm80-kcJyHh4Wm1wALcA@mail.gmail.com>
Subject: Re: [PATCH V2 1/3] PCI: rcar: Move the inbound index check
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marek,

On Fri, Aug 9, 2019 at 7:48 PM <marek.vasut@gmail.com> wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>
> Since the $idx variable value is stored across multiple calls to
> rcar_pcie_inbound_ranges() function, and the $idx value is used to
> index registers which are written, subsequent calls might cause
> the $idx value to be high enough to trigger writes into nonexistent
> registers.
>
> Fix this by moving the $idx value check to the beginning of the loop.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>

Thanks for your patch!

> --- a/drivers/pci/controller/pcie-rcar.c
> +++ b/drivers/pci/controller/pcie-rcar.c
> @@ -1048,6 +1048,10 @@ static int rcar_pcie_inbound_ranges(struct rcar_pcie *pcie,
>         mask &= ~0xf;
>
>         while (cpu_addr < cpu_end) {
> +               if (idx > MAX_NR_INBOUND_MAPS) {

Shouldn't that check be "idx >= MAX_NR_INBOUND_MAPS - 1" now?

> +                       dev_err(pcie->dev, "Failed to map inbound regions!\n");
> +                       return -EINVAL;
> +               }
>                 /*
>                  * Set up 64-bit inbound regions as the range parser doesn't
>                  * distinguish between 32 and 64-bit types.
> @@ -1067,11 +1071,6 @@ static int rcar_pcie_inbound_ranges(struct rcar_pcie *pcie,
>                 pci_addr += size;
>                 cpu_addr += size;
>                 idx += 2;
> -
> -               if (idx > MAX_NR_INBOUND_MAPS) {
> -                       dev_err(pcie->dev, "Failed to map inbound regions!\n");
> -                       return -EINVAL;
> -               }
>         }
>         *index = idx;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
