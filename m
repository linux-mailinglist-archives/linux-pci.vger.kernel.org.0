Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48F464368FD
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 19:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbhJUR3u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Oct 2021 13:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhJUR3t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Oct 2021 13:29:49 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485B4C061764;
        Thu, 21 Oct 2021 10:27:33 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id h4so2691608uaw.1;
        Thu, 21 Oct 2021 10:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n3KAUH5tf43FPgeIldLgrHI6MLHGHRqbeDSFqA/wj6k=;
        b=UktcyfAWEPQILj2/NzzmvMAzdpAfMV4q5eRVROBynRVdLNYRD8/2gc+znAsZnXnhVm
         EHDpxnJll2/m+IuTvzo6nn/r+gUDbq+dvYHJXt2/MaBGXse9LLIqMA+nzFhO5ortgguY
         QkgfawKKXp9966CULV4EKTpPSMomVEmfU/DxuwznaFrwAH+Qdb+OgndgB1XrvTBt4G0c
         UdK6XeBpXM3GgG6+TtADSFokXF4axnBNObXiJ77jl2UUlGfn4O4HbpZ4mCT59XAsEh2t
         Ttb/6FgV/1PKqzze94P+8N4weGR1/O9wIOUbIFXAgl0nHlXPMqeND/GHcYY4CKBIiPTi
         jsYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n3KAUH5tf43FPgeIldLgrHI6MLHGHRqbeDSFqA/wj6k=;
        b=V7oTOdDJUOOs29NTsqouy8NzuY9f5hT/WgpjTVKvp8FQlFF5PdVa7AP3Znrauu4oM7
         UzjEXUZIanIup267RlPvriqzpIDSHUL474ptqmsJ+wPbTmCMr/IilZQmkoGRHhFGG+EJ
         LiyQW+b5JU4sGb15tJOxeISO6b3u7UBrRvxgT7o+0J/fbaPEq2NfYDU6B7q6MbXKlZv7
         mMGbOzS6R17bVHUaMnahiOVJpN9yyOcSUnzLPBE5UG/GBtZHPe51bOLo6ooah0DlOhHM
         JywAr4/TswQ4UP19t/dJnmR3q70OR//8+ZmO9vwlyeoXMOReUzCsT4DBdjgLlbxeYGLK
         Dn9Q==
X-Gm-Message-State: AOAM5325WcknKDa//nhw4trFT5Laj5SqeA84+7H6l/4WKRhPQU4ov+Vr
        a+RzO2mhWHPABNt4yGVSDQaoOlcZWY4qgK4M5mk=
X-Google-Smtp-Source: ABdhPJy9D+3cDlBwjEWxaq8dqkdQpLoO3j0avxBUK363K6hl97hfPjuGhjnr8pAKXA2wvwWYSysjy/d2TVvGs/4/j74=
X-Received: by 2002:a67:d78c:: with SMTP id q12mr8220476vsj.28.1634837252362;
 Thu, 21 Oct 2021 10:27:32 -0700 (PDT)
MIME-Version: 1.0
References: <163473978253.23166.3894301849923362863.b4-ty@arm.com> <20211021155256.GA2689055@bhelgaas>
In-Reply-To: <20211021155256.GA2689055@bhelgaas>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Thu, 21 Oct 2021 19:27:21 +0200
Message-ID: <CAMhs-H-BA+KzEwuDPzcmrDPdgJBFA2XdYTBvT4R4MEOUB=WQ1g@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] PCI: mt7621: Add MediaTek MT7621 PCIe host
 controller driver
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        John Crispin <john@phrozen.org>, NeilBrown <neil@brown.name>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Thu, Oct 21, 2021 at 5:52 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Oct 20, 2021 at 03:23:45PM +0100, Lorenzo Pieralisi wrote:
> > On Wed, 22 Sep 2021 07:00:32 +0200, Sergio Paracuellos wrote:
> > > MediaTek MT7621 PCIe subsys supports single Root complex (RC)
> > > with 3 Root Ports. Each Root Ports supports a Gen1 1-lane Link.
> > > Topology is as follows:
> > >
> > >
> > >                           MT7621 PCIe HOST Topology
> > >
> > > [...]
> >
> > Applied to pci/mt7621, thanks!
> >
> > [1/3] dt-bindings: mt7621-pci: PCIe binding documentation for MT7621 SoCs
> >       https://git.kernel.org/lpieralisi/pci/c/e5bc5605e7
> > [2/3] PCI: mt7621: Add MediaTek MT7621 PCIe host controller driver
> >       https://git.kernel.org/lpieralisi/pci/c/5797a2b2bc
> > [3/3] MAINTAINERS: add myself as maintainer of the MT7621 PCI controller driver
> >       https://git.kernel.org/lpieralisi/pci/c/eb1d7d438c
>
> Since this is a PCIe (not conventional PCI) controller, I vote for
> renaming these from:
>
>   PCI_MT7621
>   Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.yaml
>   drivers/pci/controller/pci-mt7621.c
>
> to:
>
>   PCIE_MT7621
>   Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.yaml
>   drivers/pci/controller/pcie-mt7621.c
>
> We have a mix of these, with many of the early PCIe drivers being
> named "pci", but I think that was my mistake and there's no reason to
> continue it.

I see.

>
> I can do this locally unless somebody objects.

I have no problem at all. Only one question. Do you mean to change
compatible string also, or only the name of the file? Let me know if I
have to do anything.

Thanks,
    Sergio Paracuellos
