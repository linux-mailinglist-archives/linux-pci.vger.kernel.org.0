Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945933C6461
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jul 2021 21:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236698AbhGLT7R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Jul 2021 15:59:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:38888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234152AbhGLT7O (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Jul 2021 15:59:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F0B061248;
        Mon, 12 Jul 2021 19:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626119786;
        bh=1/iV0tWnFbbXO0GEHBAo7CuxKn/rRuPYJSACK0eLi3Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dQfSsq1jx3lPxRdhODpiKgtXXpCGYxn7qC7Mp6Qgn9xJMpqM7nyemeJpfKs2Q57Vo
         GtZsmsqTa2/1W0MjFg2D3M4LmiYHFOWnRikS8R0iq8MpMoE2NU78hsgZfql/OyAyU0
         s/OSvAhCsvY5bs5x3cE+wvD4ujHlTSJ4imynk8zcG5eFybGJbkqo5sYqc5w9UgDjnV
         PU933Js1WfIABFGPFg9jvh5Sd750+2vO9p8N5Maf1nvDmnXMd0wtUJQQ4RQiavownL
         puxNnd78xJitKg4Lo4ErrYooveUSMSVETo9JVilH/lxlWnIfY2Q37vbFjZw1ASBdr7
         mJMxypxtJw/IA==
Received: by mail-ej1-f43.google.com with SMTP id dt7so7078571ejc.12;
        Mon, 12 Jul 2021 12:56:26 -0700 (PDT)
X-Gm-Message-State: AOAM533DyzXIDJyZufyWEIzOqya6l51g1u5NEcFHfgc4HUDABt8GGeM/
        yI//I552HnjlHw/mcwYtUmkVb+h+hT9htzHywg==
X-Google-Smtp-Source: ABdhPJzQP4XLVaKnqd28Ulh5L6F8VcTh8R/AfPyMs7r6K12YgTls+lWlluw/s3Hp7usHqSXhQeJH8grhlH9YOxbSMiM=
X-Received: by 2002:a17:906:b18d:: with SMTP id w13mr816201ejy.341.1626119784749;
 Mon, 12 Jul 2021 12:56:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210630034653.10260-1-manivannan.sadhasivam@linaro.org>
 <CAL_JsqLHp3kBc1VtGVRxVr_k69GqSC_JX88jo3stdM4W9Qq6AQ@mail.gmail.com> <20210712075302.GA8113@workstation>
In-Reply-To: <20210712075302.GA8113@workstation>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 12 Jul 2021 13:56:12 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ4R3+mx9bT4WsKRx4fS5UFbe8en+fRq65HTGcfxaxaNQ@mail.gmail.com>
Message-ID: <CAL_JsqJ4R3+mx9bT4WsKRx4fS5UFbe8en+fRq65HTGcfxaxaNQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Add Qualcomm PCIe Endpoint driver support
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        devicetree@vger.kernel.org, PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        hemantk@codeaurora.org,
        Siddartha Mohanadoss <smohanad@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sriharsha Allenki <sallenki@codeaurora.org>,
        skananth@codeaurora.org, vpernami@codeaurora.org,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 12, 2021 at 1:53 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Thu, Jul 01, 2021 at 09:25:01AM -0600, Rob Herring wrote:
> > On Tue, Jun 29, 2021 at 9:47 PM Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > >
> > > Hello,
> > >
> > > This series adds support for Qualcomm PCIe Endpoint controller found
> > > in platforms like SDX55. The Endpoint controller is based on the designware
> > > core with additional Qualcomm wrappers around the core.
> > >
> > > The driver is added separately unlike other Designware based drivers that
> > > combine RC and EP in a single driver. This is done to avoid complexity and
> > > to maintain this driver autonomously.
> > >
> > > The driver has been validated with an out of tree MHI function driver on
> > > SDX55 based Telit FN980 EVB connected to x86 host machine over PCIe.
> > >
> > > Thanks,
> > > Mani
> > >
> > > Changes in v5:
> > >
> > > * Removed the DBI register settings that are not needed
> > > * Used the standard definitions available in pci_regs.h
> > > * Added defines for all the register fields
> > > * Removed the left over code from previous iteration
> > >
> > > Changes in v4:
> > >
> > > * Removed the active_config settings needed for IPA integration
> > > * Switched to writel for couple of relaxed versions that sneaked in
> >
> > I thought we resolved this discussion. Use _relaxed variants unless
> > you need the stronger ones.
> >
>
> I thought the discussion was resolved in favor of using read/writel. Here
> is the last reply from Bjorn:
>
> "I think we came to the conclusion that writel() was better
> than incorrect use of writel_relaxed() followed by wmb(). And in this
> particular case it's definitely not happening in a hot code path..."

Certainly if you're needing wmb(), then you shouldn't be using
_relaxed() variants.

> IMO, it is safer to use readl/writel calls than the relaxed variants.

Sure, and it's safer to have one big lock than it is to have no locks
or lots of small locks.

> And so far the un-written rule I assumed is, only consider using the
> relaxed variants if the code is in hot path (but somehow I used the
> relaxed version in v1 :P )

If you want any real conclusion, then best to fix the 'un-written' part.

But what I say for every PCI review, is use the _relaxed() variants.

Rob
