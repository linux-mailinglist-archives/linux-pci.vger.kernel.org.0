Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 443F46314D
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2019 08:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfGIG6i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jul 2019 02:58:38 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45169 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfGIG6i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jul 2019 02:58:38 -0400
Received: by mail-ot1-f68.google.com with SMTP id x21so18809529otq.12;
        Mon, 08 Jul 2019 23:58:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pGavdZ4WExZ0epeZDCNcnUKmzSN0Fc64RT61jAPHbnY=;
        b=koe4MX+IaOxHatJR/Bw3NNuWFStTtm+JrqH7s3ymxlavQjlXSOsqnyXgNEUB4AJx9Z
         Nbi3Os/sLbRZRo/h3isT75y9XqwHX82ZdPLwDnaXT8MIxZ4VcyRFQteLjFatamEyfCtU
         +N67UrsqAblb2W9gs/6pid3yOpE1ZnizZza8zvf3MYU1pUUhmPrjOPyL3B2BRKGHjTcL
         IafAvysIkPsfS/ew8QHFy2UKMNwNneRD9BdQ89HEL1XmdE3TEB4F2VdH4vVCjX4uxRsU
         Y0FuZzqyNnLTBJ7zXgyaimMzJ0ESzeoZdo9q/aovRXBHmRn4eiXXPT+jWZ8eisthQZ2V
         PP6g==
X-Gm-Message-State: APjAAAUpFMJaxQDGerbYGL8vdyl30un8IpTsEBdWg5NZvXVuyejDWa6A
        ExIRQW5B8hS01Xeg64sBmXlWylRrLhzpFMZbCMg=
X-Google-Smtp-Source: APXvYqx8uxfaphgkIPxp19O0BQJxlhSBPQyJkjjqnmvDfhLSLcjCnj6RErBD526oHWjHNwYN4IBT2CjYOPNEsssuWCU=
X-Received: by 2002:a9d:7a90:: with SMTP id l16mr6055405otn.297.1562655517831;
 Mon, 08 Jul 2019 23:58:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190709011559.12379-1-marek.vasut@gmail.com>
In-Reply-To: <20190709011559.12379-1-marek.vasut@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 9 Jul 2019 08:58:26 +0200
Message-ID: <CAMuHMdWhHpBkgfrN+VZKFfa1f_A7mdP0i=ZPo4E875bZkhR3og@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: rcar: Do not abort on too many inbound dma-ranges
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

On Tue, Jul 9, 2019 at 3:18 AM <marek.vasut@gmail.com> wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>
> In case the "dma-ranges" DT property contains either too many ranges
> or the range start address is unaligned in such a way that populating
> the range into the controller requires multiple entries, a situation
> may occur where all ranges cannot be loaded into the controller.
>
> Currently, the driver refuses to probe in such a situation. Relax this
> behavior, load as many ranges as possible and warn if some ranges do
> not fit anymore.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>

Thanks for your patch!

> --- a/drivers/pci/controller/pcie-rcar.c
> +++ b/drivers/pci/controller/pcie-rcar.c
> @@ -1069,8 +1069,9 @@ static int rcar_pcie_inbound_ranges(struct rcar_pcie *pcie,
>                 idx += 2;
>
>                 if (idx > MAX_NR_INBOUND_MAPS) {
> -                       dev_err(pcie->dev, "Failed to map inbound regions!\n");
> -                       return -EINVAL;
> +                       dev_warn(pcie->dev,
> +                                "Too many inbound regions, not all are mapped.\n");
> +                       break;
>                 }
>         }
>         *index = idx;

The incremented idx is stored here.  Hence for each subsequent call to
rcar_pcie_inbound_ranges() from the loop in rcar_pcie_parse_map_dma_ranges(),
it will write to nonexisting registers.

It seems that can already happen now (but only for the last iteration,
just before it errors out), so probably you want to fix that first, by
moving the check to the start of the loop.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
