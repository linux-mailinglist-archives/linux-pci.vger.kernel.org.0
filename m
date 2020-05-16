Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2B41D61E3
	for <lists+linux-pci@lfdr.de>; Sat, 16 May 2020 17:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgEPPTd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 May 2020 11:19:33 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39968 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgEPPTd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 May 2020 11:19:33 -0400
Received: by mail-qt1-f193.google.com with SMTP id c24so4553633qtw.7
        for <linux-pci@vger.kernel.org>; Sat, 16 May 2020 08:19:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Ff0PLKw4149o3NP02StS9B8HlY3tUSt9fGDaDq77dZo=;
        b=jafF7iO4SVwHcn7XdyDswiH6/alhzeK17USAaIhFKtriBaslRAVzv76mSAHufNxkgs
         0MgUuQMUzw8mek57waTHEjRAXmSJ2p7fWALFDnOofAHyQVCzEgLCjxsC4oxOpfnIkFpz
         XrFk0f1OF+G06uEQ68mAdILw8jwSpVGbvAqFcihunXplFlLR38bakuon5SztHBBUahnh
         pNTg841sC266JaahNpicrnnnr172EDuxMbG0HDSXsRquFQm8itErU9gl/ViOhgucqgoD
         3nWEzppJ6jqWWXkWlZ03/btlJO3e1s08iz9iVyYf19NP8J/w4hZ06LObRA1LUrSn+76s
         7Ezw==
X-Gm-Message-State: AOAM531v8tz9JO5UpDh8nMiDZe/cnyzQZSglcP0/KbRZvNmRa+IaRk1c
        JFKvG1HqM5AYJBf5HXrejgprfBHwucA=
X-Google-Smtp-Source: ABdhPJwIQ3ReL9bBR8Xgb2Z8FNppvceQnLPx22j0aA+16TwXTCcfaIfYF/BL2uSPyN/cJEOJGj1AoA==
X-Received: by 2002:aed:2762:: with SMTP id n89mr7096474qtd.26.1589642371979;
        Sat, 16 May 2020 08:19:31 -0700 (PDT)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com. [209.85.222.180])
        by smtp.gmail.com with ESMTPSA id d6sm4075674qkj.72.2020.05.16.08.19.31
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2020 08:19:31 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id f13so5772132qkh.2
        for <linux-pci@vger.kernel.org>; Sat, 16 May 2020 08:19:31 -0700 (PDT)
X-Received: by 2002:a37:b701:: with SMTP id h1mr6516043qkf.53.1589642371346;
 Sat, 16 May 2020 08:19:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAAri2DpkcuQZYbT6XsALhx2e6vRqPHwtbjHYeiH7MNp4zmt1RA@mail.gmail.com>
In-Reply-To: <CAAri2DpkcuQZYbT6XsALhx2e6vRqPHwtbjHYeiH7MNp4zmt1RA@mail.gmail.com>
From:   Marcos Scriven <marcos@scriven.org>
Date:   Sat, 16 May 2020 16:19:20 +0100
X-Gmail-Original-Message-ID: <CAAri2Dq1-S2aoyi5dbHSZoP95mPaVTCnPBgV4CCd4BRe0yVmvg@mail.gmail.com>
Message-ID: <CAAri2Dq1-S2aoyi5dbHSZoP95mPaVTCnPBgV4CCd4BRe0yVmvg@mail.gmail.com>
Subject: Re: [PATCH] PCI: Avoid FLR for AMD Matisse HD Audio and USB Controllers
To:     linux-pci@vger.kernel.org, bhelgaas@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Apologies, I neglected to include Bjorn. Doing so now.

Marcos

On Sat, 16 May 2020 at 14:37, Marcos Scriven <marcos@scriven.org> wrote:
>
> This patch fixes an FLR bug on the following two devices:
>
> AMD Matisse HD Audio Controller 0x1487
> AMD Matisse USB 3.0 Host Controller 0x149c
>
> As there was already such a quirk for an Intel network device, I have
> renamed that method and updated the comments, trying to make it
> clearer what the specific original devices that were affected are
> (based on the commit message this was original done:
> https://git.thm.de/mhnn55/eco32-linux-ba/commit/f65fd1aa4f9881d5540192d11f7b8ed2fec936db).
>
> I have ordered them by hex product ID.
>
> I have verified this works on a X570 I AORUS PRO WIFI (rev. 1.0) motherboard.
>
>
> From 651176ab164ae51e37d5bb86f5948da558744930 Mon Sep 17 00:00:00 2001
> From: Marcos Scriven <marcos@scriven.org>
> Date: Sat, 16 May 2020 14:23:26 +0100
> Subject: [PATCH] PCI: Avoid FLR for:
>
>     AMD Matisse HD Audio Controller 0x1487
>     AMD Matisse USB 3.0 Host Controller 0x149c
>
> These devices advertise a Function Level Reset (FLR) capability, but hang
> when an FLR is triggered.
>
> To reproduce the problem, attach the device to a VM, then detach and try to
> attach again.
>
> Add a quirk to prevent the use of FLR on these devices.
>
> Signed-off-by: Marcos Scriven <marcos@scriven.org>
> ---
>  drivers/pci/quirks.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 28c9a2409c50..ff310f0cac22 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5129,13 +5129,23 @@ static void quirk_intel_qat_vf_cap(struct pci_dev *pdev)
>  }
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443, quirk_intel_qat_vf_cap);
>
> -/* FLR may cause some 82579 devices to hang */
> -static void quirk_intel_no_flr(struct pci_dev *dev)
> +/*
> + * FLR may cause the following to devices to hang:
> + *
> + * AMD Starship/Matisse HD Audio Controller 0x1487
> + * AMD Matisse USB 3.0 Host Controller 0x149c
> + * Intel 82579LM Gigabit Ethernet Controller 0x1502
> + * Intel 82579V Gigabit Ethernet Controller 0x1503
> + *
> + */
> +static void quirk_no_flr(struct pci_dev *dev)
>  {
>      dev->dev_flags |= PCI_DEV_FLAGS_NO_FLR_RESET;
>  }
> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502, quirk_intel_no_flr);
> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503, quirk_intel_no_flr);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1487, quirk_no_flr);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x149c, quirk_no_flr);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502, quirk_no_flr);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503, quirk_no_flr);
>
>  static void quirk_no_ext_tags(struct pci_dev *pdev)
>  {
> --
> 2.25.1
