Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A896547CABF
	for <lists+linux-pci@lfdr.de>; Wed, 22 Dec 2021 02:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240642AbhLVBYq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Dec 2021 20:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238439AbhLVBYp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Dec 2021 20:24:45 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2D3C061746
        for <linux-pci@vger.kernel.org>; Tue, 21 Dec 2021 17:24:45 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id t123so815954pfc.13
        for <linux-pci@vger.kernel.org>; Tue, 21 Dec 2021 17:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3n4TFzLxFZSVVWqxUwJzmQ/EXNIrk0ZpoC23l/r+OGA=;
        b=M0fISoDFWSrWWMt3rJCzEbOxsmpRekF3gQ8/lLx9jnMuBVm1pSMsyNP77874kG8wNJ
         6JP+7VmL9CjwmUjspmrNe/hsNX3enXIInPhyJnasWwHWUxQj1BKtlkZmYK6CxooWrJ/W
         dpCm5LB3F0UUSykTTiu12TxWSD/lu2LglJ/f69Za3m8ItWlKozMhPgGeKfteiLRsOrQd
         DseD4YbFvz04ZA2yCqwtGJy92xZeGf+oqYMZEcHS0ZpDjAJ9APpFUP1rTn8c7BA1ksHC
         sQwVRerJbnVOueRIqZLy0+z7dZS0K330o/0qfpMV+ECd/Ik6CGdkTvtQMaWaudwV/NxC
         d5uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3n4TFzLxFZSVVWqxUwJzmQ/EXNIrk0ZpoC23l/r+OGA=;
        b=PcMl3WvcBfau37ucOARWxIcyZ9qm5xo+N2FbchhotuOr85XHhH/AOT1WUCSbdcX5CT
         UvShTL17VGBcdR2Bdek1OzWB7w1+wHieEO1gNh/NWPnR2xTzYYqpvcIbN8WUshzg6rIE
         T++5vGR/mMv/EqyuAPh7dC983Mkek48eMgNYeuhOXvL8n+lmlWME1H3DKQLvGewm41u7
         aPfuJ6R3dQqpiD+W+Kou8uCIggx5PDR3DlJzxJ2JZLLLVN/EpYcBeWXZNcgF5XeGvHO4
         ZO1tDMdPycjxBOqwDDrdnskjaAw7TWVKfINzDa+Fm3sDJFeTCn/bMdVTr3cib/jl0v75
         hBZw==
X-Gm-Message-State: AOAM531MT+ls5eR8NZH5PWznPntc3tpbwOCZksJTXAIC7o9SpJG9KsxK
        Y9b8vHMsOphCCyEZUZCz7B/GzOTN0gyu2ZYWnL5QstiGIEzsjg==
X-Google-Smtp-Source: ABdhPJwI2hPnv03Us+VBfj2mq1T1RjcEtAWyxwAtRvX707LG4XAGlDixvRAyTu198YsYMpgwMpBdr0Kw6wCfUIntya8=
X-Received: by 2002:a63:9:: with SMTP id 9mr877407pga.136.1640136284606; Tue,
 21 Dec 2021 17:24:44 -0800 (PST)
MIME-Version: 1.0
References: <20211222012105.3438916-1-rajatja@google.com>
In-Reply-To: <20211222012105.3438916-1-rajatja@google.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Tue, 21 Dec 2021 17:24:08 -0800
Message-ID: <CACK8Z6HpoMDQ=9esCFfGiPUww32QrOfDm-RGhdTdWfoV0ipNXA@mail.gmail.com>
Subject: Re: [PATCH] pci: Make DWORD accesses while saving / restoring LTR state
To:     Bjorn Helgaas <bhelgaas@google.com>, kw@linux.com,
        Rajat Jain <rajatja@google.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rajatxjain@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Sorry, I forgot to mention...

On Tue, Dec 21, 2021 at 5:21 PM Rajat Jain <rajatja@google.com> wrote:
>
> Some devices have an errata such that they only support DWORD accesses
> to some registers.
>
> For e.g. this Bayhub O2 device ([VID:DID] = [0x1217:0x8621]) only
> supports DWORD accesses to LTR latency registers and L1 PM substates
> control registers:
> https://github.com/rajatxjain/public_shared/blob/main/OZ711LV2_appnote.pdf
>
> Since L1 PM substate control registers are DWORD sized, and hence their
> access in the kernel is already DWORD sized, so we don't need to do
> anything for them.
>
> However, the LTR registers being WORD sized, are in need of a solution.
> This patch converts the WORD sized accesses to these registers, into
> DWORD sized accesses, while saving and restoring them.
>
> Signed-off-by: Rajat Jain <rajatja@google.com>

... I have made a more generic proposal here:
https://lore.kernel.org/linux-pci/CACK8Z6GR9pR0Oc_G70q2MxTVgrk+PXWTFbWT1EjARnuYCRavLw@mail.gmail.com/T/#t

However that is a bigger effort in terms of implementation as well as
reaching an agreement and acceptance with the community. So I'd
appreciate it if this patch would please be included until a larger
framework is put in place.

Thanks & Best Regards,

Rajat

> ---
>  drivers/pci/pci.c       | 24 ++++++++++++++++--------
>  drivers/pci/pcie/aspm.c |  1 +
>  2 files changed, 17 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 3d2fb394986a..efa8cd16827f 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1556,7 +1556,7 @@ static void pci_save_ltr_state(struct pci_dev *dev)
>  {
>         int ltr;
>         struct pci_cap_saved_state *save_state;
> -       u16 *cap;
> +       u32 *cap;
>
>         if (!pci_is_pcie(dev))
>                 return;
> @@ -1571,25 +1571,33 @@ static void pci_save_ltr_state(struct pci_dev *dev)
>                 return;
>         }
>
> -       cap = (u16 *)&save_state->cap.data[0];
> -       pci_read_config_word(dev, ltr + PCI_LTR_MAX_SNOOP_LAT, cap++);
> -       pci_read_config_word(dev, ltr + PCI_LTR_MAX_NOSNOOP_LAT, cap++);
> +       /*
> +        * We deliberately do a dword access to save both PCI_LTR_MAX_SNOOP_LAT
> +        * and PCI_LTR_MAX_NOSNOOP_LAT together since some devices only support
> +        * dword accesses to these registers.
> +        */
> +       cap = &save_state->cap.data[0];
> +       pci_read_config_dword(dev, ltr + PCI_LTR_MAX_SNOOP_LAT, cap);
>  }
>
>  static void pci_restore_ltr_state(struct pci_dev *dev)
>  {
>         struct pci_cap_saved_state *save_state;
>         int ltr;
> -       u16 *cap;
> +       u32 *cap;
>
>         save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_LTR);
>         ltr = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_LTR);
>         if (!save_state || !ltr)
>                 return;
>
> -       cap = (u16 *)&save_state->cap.data[0];
> -       pci_write_config_word(dev, ltr + PCI_LTR_MAX_SNOOP_LAT, *cap++);
> -       pci_write_config_word(dev, ltr + PCI_LTR_MAX_NOSNOOP_LAT, *cap++);
> +       /*
> +        * We deliberately do a dword access to restore both
> +        * PCI_LTR_MAX_SNOOP_LAT and PCI_LTR_MAX_NOSNOOP_LAT together since
> +        * some devices only support dword accesses to these registers.
> +        */
> +       cap = &save_state->cap.data[0];
> +       pci_write_config_dword(dev, ltr + PCI_LTR_MAX_SNOOP_LAT, *cap);
>  }
>
>  /**
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 52c74682601a..083f47a7b69b 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -496,6 +496,7 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
>         encode_l12_threshold(l1_2_threshold, &scale, &value);
>         ctl1 |= t_common_mode << 8 | scale << 29 | value << 16;
>
> +       /* Always make DWORD sized accesses to these registers */
>         pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1, &pctl1);
>         pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CTL2, &pctl2);
>         pci_read_config_dword(child, child->l1ss + PCI_L1SS_CTL1, &cctl1);
> --
> 2.34.1.307.g9b7440fafd-goog
>
