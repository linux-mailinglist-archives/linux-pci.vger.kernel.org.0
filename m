Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C58D21F27B
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jul 2020 15:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgGNN1w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jul 2020 09:27:52 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42115 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgGNN1v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jul 2020 09:27:51 -0400
Received: by mail-oi1-f194.google.com with SMTP id t4so13892886oij.9;
        Tue, 14 Jul 2020 06:27:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Co+8zho8E5dTiD8cmg9/ZPavIQVoRg7kJl84C1fgX4o=;
        b=Ak9rNiX58SVp3TwDXHkgLVMlvgVRokwbqMW6fzzw5RNsaFtIHKYJCHapp+PhKvXx5q
         c+tyQf6H3zW3IU7YIGzxoSspg1ZMNrvhPr8VvlcJrmPyfV/w3w1KXHD9ebDk/sTIij/X
         /foWTxlOrHmpPODKPrjxMTzRsXYttF2kvT80OV4cyjzyn2H9a/OHC6bKrmyjffJ8bXRU
         XMBYJpa1FubjV3wB5RsI2MRHh15bpznOoeLuPB5BwrNXHYnRkBMjx6ZiRuKGawmANhiQ
         oXYGnGr72PODH5NtfHBVvy7xExgD1+Q8e3CVWkJOIq1JK36G6X2GfxT1KRJFeutH8Zw4
         J5pg==
X-Gm-Message-State: AOAM533sZufFYQ/PG1NgUlIttecXG7r6ttGXBXgWEsA4WC2G/XzxBjeM
        7qXENwWJSmZJCvlgDAQk3e6z2ZKMulTqvubMOa0=
X-Google-Smtp-Source: ABdhPJzZCW5CAcdX22oZWNLapJZK91sy3IBs2TtUsKH0mXhc58jY+otLhQKYqyJqpqYGmfziPk7jXv4Of2khk72Y9k0=
X-Received: by 2002:aca:4a89:: with SMTP id x131mr3775944oia.103.1594733270598;
 Tue, 14 Jul 2020 06:27:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200713175529.29715-1-refactormyself@gmail.com> <20200713175529.29715-4-refactormyself@gmail.com>
In-Reply-To: <20200713175529.29715-4-refactormyself@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 14 Jul 2020 15:27:38 +0200
Message-ID: <CAJZ5v0gDwtZ+oYSrj_Ta56QPSeW3OSq4XHkiubOHr4xki7muPw@mail.gmail.com>
Subject: Re: [PATCH 8/14 v3] PCI/ACPI: Check the return value of pcie_capability_read_*()
To:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 13, 2020 at 6:55 PM Saheed O. Bolarinwa
<refactormyself@gmail.com> wrote:
>
> From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
>
> On failure pcie_capability_read_dword() sets it's last parameter,
> val to 0.
> However, with Patch 14/14, it is possible that val is set to ~0 on
> failure. This would introduce a bug because (x & x) == (~0 & x).
>
> This bug can be avoided if the return value of pcie_capability_read_word
> is checked to confirm success.
>
> Check the return value of pcie_capability_read_word() to ensure success.
>
> Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
> Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/pci/pci-acpi.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 7224b1e5f2a8..39eb816bc3b8 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -248,12 +248,13 @@ static bool pcie_root_rcb_set(struct pci_dev *dev)
>  {
>         struct pci_dev *rp = pcie_find_root_port(dev);
>         u16 lnkctl;
> +       int ret;
>
>         if (!rp)
>                 return false;
>
> -       pcie_capability_read_word(rp, PCI_EXP_LNKCTL, &lnkctl);
> -       if (lnkctl & PCI_EXP_LNKCTL_RCB)
> +       ret = pcie_capability_read_word(rp, PCI_EXP_LNKCTL, &lnkctl);
> +       if (!ret && (lnkctl & PCI_EXP_LNKCTL_RCB))
>                 return true;
>
>         return false;
> @@ -792,12 +793,13 @@ bool pciehp_is_native(struct pci_dev *bridge)
>  {
>         const struct pci_host_bridge *host;
>         u32 slot_cap;
> +       int ret;
>
>         if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
>                 return false;
>
> -       pcie_capability_read_dword(bridge, PCI_EXP_SLTCAP, &slot_cap);
> -       if (!(slot_cap & PCI_EXP_SLTCAP_HPC))
> +       ret = pcie_capability_read_dword(bridge, PCI_EXP_SLTCAP, &slot_cap);
> +       if (ret || !(slot_cap & PCI_EXP_SLTCAP_HPC))
>                 return false;
>
>         if (pcie_ports_native)
> --
> 2.18.2
>
