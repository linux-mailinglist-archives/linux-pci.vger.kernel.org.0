Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E2823BD07
	for <lists+linux-pci@lfdr.de>; Tue,  4 Aug 2020 17:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729532AbgHDPOs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Aug 2020 11:14:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:45296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729475AbgHDPOB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Aug 2020 11:14:01 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7655B208A9;
        Tue,  4 Aug 2020 15:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596554040;
        bh=q6X2dU7ZZ4+XPPTPplXE/0OrGHQCfDhreLawITIU70I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Wz1+lQjZXnuluMpy2YBcVb+vfLcZvxuCWpDnmRdZydSKN9nFA6tL4WOqi3vh9IkCO
         eZ9RDMIx8A/IkNkWXbsyghLi+s9211ZKTG9vVRrqwYsWRfCl812pV9ZRSeNOAI5Nol
         /pRhQeRcaK/b+LDLDCW+H8trKpySjR/C40u87jZc=
Received: by mail-ot1-f46.google.com with SMTP id h22so1581727otq.11;
        Tue, 04 Aug 2020 08:14:00 -0700 (PDT)
X-Gm-Message-State: AOAM533QmgwL9v2w9/2jWmwWCPE4v91/11JihEiKgMGkJeqB1YxqOqsM
        25uOiw82NaVw6lCfukopl8VeTMuNkcwwNwUMLA==
X-Google-Smtp-Source: ABdhPJxHk3qin2vlNcpJ7XVSQJZ9Cn6o7vq+1qFFsRD928bFTqjpVHUNEkk0OlhrXgYn4G4YPSmP6YRWDwdNRkHTfYY=
X-Received: by 2002:a05:6830:1d8e:: with SMTP id y14mr6552120oti.129.1596554039822;
 Tue, 04 Aug 2020 08:13:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200804120430.9253-1-geert+renesas@glider.be>
In-Reply-To: <20200804120430.9253-1-geert+renesas@glider.be>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 4 Aug 2020 09:13:48 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLKLREj7aaCuyRLBuBDtYHoHsVaG6Qg73wqAfvAX6iN4w@mail.gmail.com>
Message-ID: <CAL_JsqLKLREj7aaCuyRLBuBDtYHoHsVaG6Qg73wqAfvAX6iN4w@mail.gmail.com>
Subject: Re: [PATCH] PCI: rcar-gen2: Fix crash in resource_list_first_type()
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 4, 2020 at 6:04 AM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> The conversion to modern host bridge probing made the driver allocate
> its private data using devm_pci_alloc_host_bridge(), but forgot to
> remove the old allocation.  Hence part of the driver initialization is
> done using the new instance, while another part is done using the old
> instance, leading to a crash due to uninitialized bridge DMA ranges:
>
>     Unable to handle kernel NULL pointer dereference at virtual address 00000008
>     pgd = (ptrval)
>     [00000008] *pgd=00000000
>     Internal error: Oops: 5 [#1] SMP ARM
>     CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.8.0-rc1-shmobile-00035-g92d69cc6275845a7 #645
>     Hardware name: Generic R-Car Gen2 (Flattened Device Tree)
>     PC is at rcar_pci_probe+0x154/0x340
>     LR is at _raw_spin_unlock_irqrestore+0x18/0x20
>
> Fix this by dropping the old allocation.
>
> Fixes: 92d69cc6275845a7 ("PCI: rcar-gen2: Convert to use modern host bridge probe functions")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/pci/controller/pci-rcar-gen2.c | 4 ----
>  1 file changed, 4 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
