Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 410DE49D7FF
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jan 2022 03:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235046AbiA0CWt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jan 2022 21:22:49 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:35088
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235049AbiA0CWs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jan 2022 21:22:48 -0500
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id AC2293F1B3
        for <linux-pci@vger.kernel.org>; Thu, 27 Jan 2022 02:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643250166;
        bh=VON/Z/8bdlNSxKg/CZYPTOSTIKu2Vz6VcrvLtb84DlU=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=kWBuUG85n4C1kfpET1aN1OED57lL3fZy9kIorWk4tssmYP2PGX0677Gd7seR1GQ4l
         eX8z7KNajU2HJ1nbsLm91exT5GD3YTFH0s4xu+Kbgy/dm7xbwFuwiGtogXuGZwfpIJ
         HOMZwnhBa1Mag+jXGUd8fXY5ZuSHChmZkh9Go6mSCuU3p8BEkHjb4v3cgTLv16qv/i
         OmNWsui8V/u8RJvEHjDBFoC8XmblGvIMG1awteWbWGJbbpTyWdSvAACpe79bN5MZQN
         CjpIaS4nPTDeu7AFPF13UWQQI2W0sxWdvLgZc8sOta3ZA8gLHwBYCftHwlJNCYYSBa
         zOfY+fctlwK5w==
Received: by mail-oo1-f72.google.com with SMTP id s10-20020a4ab54a000000b002ea051bad32so825382ooo.14
        for <linux-pci@vger.kernel.org>; Wed, 26 Jan 2022 18:22:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VON/Z/8bdlNSxKg/CZYPTOSTIKu2Vz6VcrvLtb84DlU=;
        b=C+Hl/4mVDfedF6O8UZX471AnPqbdDbrWG9idcrrx85Xa2wDkwciDVCL0vOATr1YyT4
         33pyg/zktxg9RnWo5NXh4NyM04QjcyXU2jLXHPFjYEpdtoDmd03qr22sIU/IYabK4MBS
         Eh8JQqHLuVMi7u+G41tRhMDLlBNfhYK9mAW78JedEbENQD3BrcSSKmlo/t480zEk1JT5
         h4c2hxURCNNL6Om2vTiXbcZGpXCwaLl2Jd743iGDAKq7rXuy5f+Ai9qObKtjq/bTA3PF
         Bc6r5ftPm3QIBeuMe7TQyJOki2b27xNUv4EhnKvN/+kR2EaidBJFUIisfIQckRBn2iSm
         Xx4A==
X-Gm-Message-State: AOAM532RI/OpQp0xnAyK3VyZ/zocc5/ArxXkO/YOmp7rfnDVOD3Fnuy1
        nFcWr0FC3m2WJfvpMa62FbrvPgNi8PL4Kini+BTT2c0Vjoj/u88RxNUNX7nU3S7+K2aOUZTkpMU
        Fxx47a9l1iFHwrC73key90m1ovBTi8RDoFcW+JLwZgJx8NjAFeLXyaA==
X-Received: by 2002:a05:6808:2087:: with SMTP id s7mr5179152oiw.21.1643250165679;
        Wed, 26 Jan 2022 18:22:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwB+navU6gtFzHTGoJm+x+kCowK7+ulSkHm17hHbA227DyBZQFEB15yNQThEkQXUYewsy/No5viewb7ncXSxF0=
X-Received: by 2002:a05:6808:2087:: with SMTP id s7mr5179138oiw.21.1643250165478;
 Wed, 26 Jan 2022 18:22:45 -0800 (PST)
MIME-Version: 1.0
References: <20220126071853.1940111-1-kai.heng.feng@canonical.com>
 <20220126071853.1940111-2-kai.heng.feng@canonical.com> <YfEsC94BvFwd5MLy@lahna>
In-Reply-To: <YfEsC94BvFwd5MLy@lahna>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 27 Jan 2022 10:22:34 +0800
Message-ID: <CAAd53p7wPZj0DTxkfoBhhhbaGWvpU4MTbJAGGNXvAjG3qw9b9Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI/DPC: Disable DPC when link is in L2/L3 ready, L2
 and L3 state
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     bhelgaas@google.com, koba.ko@canonical.com,
        Russell Currey <ruscur@russell.cc>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 26, 2022 at 7:10 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi,
>
> On Wed, Jan 26, 2022 at 03:18:52PM +0800, Kai-Heng Feng wrote:
> > Since TLP and DLLP transmission is disabled for a Link in L2/L3 Ready,
> > L2 and L3, and DPC depends on AER, so also disable DPC here.
>
> Here too I think it is good to mention that the DPC "service" never
> implemented the PM hooks in the first place

Will amend the commit message a bit.

>
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>
> One minor comment below, but other than that looks good,
>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>
> > ---
> >  drivers/pci/pcie/dpc.c | 61 +++++++++++++++++++++++++++++++-----------
> >  1 file changed, 45 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> > index 3e9afee02e8d1..9585c10b7c577 100644
> > --- a/drivers/pci/pcie/dpc.c
> > +++ b/drivers/pci/pcie/dpc.c
> > @@ -343,13 +343,34 @@ void pci_dpc_init(struct pci_dev *pdev)
> >       }
> >  }
> >
> > +static void dpc_enable(struct pcie_device *dev)
> > +{
> > +     struct pci_dev *pdev = dev->port;
> > +     u16 ctl;
> > +
> > +     pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, &ctl);
> > +
>
> Drop the empty line here.

OK, will do.

Kai-Heng

>
> > +     ctl = (ctl & 0xfff4) | PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN;
> > +     pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, ctl);
> > +}
> > +
> > +static void dpc_disable(struct pcie_device *dev)
> > +{
> > +     struct pci_dev *pdev = dev->port;
> > +     u16 ctl;
> > +
> > +     pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, &ctl);
> > +     ctl &= ~(PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN);
> > +     pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, ctl);
> > +}
