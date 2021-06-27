Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3DEC3B52CF
	for <lists+linux-pci@lfdr.de>; Sun, 27 Jun 2021 12:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhF0K1l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Jun 2021 06:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhF0K1l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Jun 2021 06:27:41 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AD0C061574
        for <linux-pci@vger.kernel.org>; Sun, 27 Jun 2021 03:25:17 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id h2so18449658iob.11
        for <linux-pci@vger.kernel.org>; Sun, 27 Jun 2021 03:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d7R5lcm/ZZsGck/8b80wYeNsHBK72ar/NeWNtdKrjrI=;
        b=gh5E0vYnVwmkDNd9PIyZSUCI8XZMMcPigsaqgunhIpmee6YMe0WCxpxJV3e1JcvTZG
         F2cM2n5M54XTX4Eohhn6cG0o12bIhU8f4UPx7/Zx8a6JMvkBfMbWQMnxDpU2l+djvewi
         onwvfP+hL5auVz5fkVssdGUVe8GxNLwcfBtiBUGVbUQ/uAEWb1bQ+/PSlbgAvr02L4mS
         e4XXszmatDe7m9AzQYrwnOHq8GZnYgDBXzKX814hzs2njwYVZ5J/GlH2zeLv9JTYiaJX
         mPlNrNkRhS+mLFSDy0LAGcfdkrFEDwZS2zD9vZin6w0u8bbdiztEuDz8vOM8Ra+ZViw/
         C5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d7R5lcm/ZZsGck/8b80wYeNsHBK72ar/NeWNtdKrjrI=;
        b=NcTu4aBOjhjHvlp/QV5rwCKrV5JbS0h2W+Yco7QbW1oep52oDVVI+ax2B4B7rpq8Oz
         xiQTgTC2o/KVcDpX6+iTKuLd+xZ1eNoPBjPTxrbLxv2jijXAFJ98qdjZPIe7j0WRUlHz
         tmzWQSkmfrCvpmckJWg5GjcTBopxlf0ZbuEONaW6WxFKQrnuJpV4FU6Y5F7xW3IoRc70
         46TCJxx/MmOQB3XnodTc34+mFyCF92hoBo5omE6Qw4g2HaoQRscUJ2OmziEkQWN7FoxO
         wAS1kGj1moMFj2IUAIBxtK2kZTyhdjLg0tifjAnkan7F+spM2ogetW+wt+Kvh8wtpg9Z
         k6dg==
X-Gm-Message-State: AOAM531Q+KHqM9SrWGroSKNKMcjYPwcsCNkr7jYYC6g9yqxmVhZ+aZe8
        88NxGOERCgWOG03n5nwVQWBSUqNhZM2CqPn8/OY=
X-Google-Smtp-Source: ABdhPJxN/kaVSGf8GBWVPqe8zPGc/2Nio/93jC0r2KhB33fzrbJrKvuHWLg+6xp8d7p9NXoazAF9PmAnYwFeftOCQj4=
X-Received: by 2002:a5e:a80b:: with SMTP id c11mr12023768ioa.94.1624789516527;
 Sun, 27 Jun 2021 03:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210625093030.3698570-4-chenhuacai@loongson.cn> <20210625222204.GA3657225@bjorn-Precision-5520>
In-Reply-To: <20210625222204.GA3657225@bjorn-Precision-5520>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sun, 27 Jun 2021 18:25:04 +0800
Message-ID: <CAAhV-H68tBbTxoy-qOP4F3KDWEjunZMC-v3dAPWfU==NCMBbyA@mail.gmail.com>
Subject: Re: [PATCH V3 3/4] PCI: Improve the MRRS quirk for LS7A
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Bjorn,

On Sat, Jun 26, 2021 at 6:22 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Jun 25, 2021 at 05:30:29PM +0800, Huacai Chen wrote:
> > In new revision of LS7A, some PCIe ports support larger value than 256,
> > but their maximum supported MRRS values are not detectable. Moreover,
> > the current loongson_mrrs_quirk() cannot avoid devices increasing its
> > MRRS after pci_enable_device(), and some devices (e.g. Realtek 8169)
> > will actually set a big value in its driver. So the only possible way is
> > configure MRRS of all devices in BIOS, and add a PCI device flag (i.e.,
> > PCI_DEV_FLAGS_NO_INCREASE_MRRS) to stop the increasing MRRS operations.
> >
> > However, according to PCIe Spec, it is legal for an OS to program any
> > value for MRRS, and it is also legal for an endpoint to generate a Read
> > Request with any size up to its MRRS. As the hardware engineers says,
> > the root cause here is LS7A doesn't break up large read requests (Yes,
> > that is a problem in the LS7A design).
>
> "LS7A doesn't break up large read requests" claims to be a root cause,
> but you haven't yet said what the actual *problem* is.
>
> Is the problem that an endpoint reports a malformed TLP because it
> received a completion bigger than it can handle?  Is it that the LS7A
> root port reports some kind of error if it receives a Memory Read
> request with a size that's "too big"?  Maybe the LS7A doesn't know
> what to do when it receives a Memory Read request with MRRS > MPS?
> What exactly happens when the problem occurs?
The hardware engineer said that the problem is: LS7A PCIe port reports
CA (Completer Abort) if it receives a Memory Read
request with a size that's "too big".

Huacai
>
> MRRS applies only to the read request.  It is not directly related to
> the size of the completions that carry the data back to the device
> (except that obviously you shouldn't get a completion larger than the
> read you requested).
>
> The setting that directly controls the size of completions is MPS
> (Max_Payload_Size).  One reason to break up read requests is because
> the endpoint's buffers can't accommodate big TLPs.  One way to deal
> with that is to set MPS in the hierarchy to a smaller value.  Then the
> root port must ensure that no TLP exceeds the MPS size, regardless of
> what the MRRS in the read request was.
>
> For example, if the endpoint's MRRS=4096 and the hierarchy's MPS=128,
> it's up to the root port to break up completions into 128-byte chunks.
>
> It's also possible to set the endpoint's MRRS=128, which means reads
> to main memory will never receive completions larger than 128 bytes.
> But it does NOT guarantee that a peer-to-peer DMA from another device
> will be limited to 128 bytes.  The other device is allowed to generate
> Memory Write TLPs with payloads up to its MPS size, and MRRS is not
> involved at all.
>
> It's not clear yet whether the LS7A problem is with MRRS, with MPS, or
> with some combination.  It's important to understand exactly what is
> broken here so the quirk doesn't get in the way of future changes to
> the generic MRRS and MPS configuration.
>
> Here's a good overview:
>
>   https://www.xilinx.com/support/documentation/white_papers/wp350.pdf
>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  drivers/pci/pci.c    | 5 +++++
> >  drivers/pci/quirks.c | 8 +++++++-
> >  include/linux/pci.h  | 2 ++
> >  3 files changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index b717680377a9..6f0d2f5b6f30 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -5802,6 +5802,11 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
> >
> >       v = (ffs(rq) - 8) << 12;
> >
> > +     if (dev->dev_flags & PCI_DEV_FLAGS_NO_INCREASE_MRRS) {
> > +             if (rq > pcie_get_readrq(dev))
> > +                     return -EINVAL;
> > +     }
> > +
> >       ret = pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
> >                                                 PCI_EXP_DEVCTL_READRQ, v);
> >
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index dee4798a49fc..8284480dc7e4 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -263,7 +263,13 @@ static void loongson_mrrs_quirk(struct pci_dev *dev)
> >                * anything larger than this. So force this limit on
> >                * any devices attached under these ports.
> >                */
> > -             if (pci_match_id(bridge_devids, bridge)) {
> > +             if (bridge && pci_match_id(bridge_devids, bridge)) {
> > +                     dev->dev_flags |= PCI_DEV_FLAGS_NO_INCREASE_MRRS;
> > +
> > +                     if (pcie_bus_config == PCIE_BUS_DEFAULT ||
> > +                         pcie_bus_config == PCIE_BUS_TUNE_OFF)
> > +                             break;
> > +
> >                       if (pcie_get_readrq(dev) > 256) {
> >                               pci_info(dev, "limiting MRRS to 256\n");
> >                               pcie_set_readrq(dev, 256);
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 24306504226a..5e0ec3e4318b 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -227,6 +227,8 @@ enum pci_dev_flags {
> >       PCI_DEV_FLAGS_NO_FLR_RESET = (__force pci_dev_flags_t) (1 << 10),
> >       /* Don't use Relaxed Ordering for TLPs directed at this device */
> >       PCI_DEV_FLAGS_NO_RELAXED_ORDERING = (__force pci_dev_flags_t) (1 << 11),
> > +     /* Don't increase BIOS's MRRS configuration */
> > +     PCI_DEV_FLAGS_NO_INCREASE_MRRS = (__force pci_dev_flags_t) (1 << 12),
> >  };
> >
> >  enum pci_irq_reroute_variant {
> > --
> > 2.27.0
> >
