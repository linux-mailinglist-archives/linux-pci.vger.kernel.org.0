Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1947B2D7896
	for <lists+linux-pci@lfdr.de>; Fri, 11 Dec 2020 16:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392162AbgLKPA0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Dec 2020 10:00:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:60134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436895AbgLKPAW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Dec 2020 10:00:22 -0500
X-Gm-Message-State: AOAM532F1r2X6PpGL4uvgcTAAHdUcHB4fkR5alYvk07B9aAlWFgpTEly
        CCmh/qXebHctqV5idHqLxB32GCi1QjBsktA84g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607698173;
        bh=6DkU9ooSDWgagrJRUIYO/X3sDJ4hfhxHbpDrECTwLvQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kiaK+zGqvoYEXNx3YataqbgjDJZa9/RmAI/sdNtc4w68aS/w3e7TKOJ5LCC2YYYnb
         8HHAfFXS343YtkM/9vvh8laXZ+Zfg9a9cTcHB/kQxvNaJjAoTkrgCv1pB/JWBP61lf
         TSnbGrfDHJEUWmnP9E2gLFhDXyDpkNERsr4NH7mdK58ArU0gAmjxnMTrejLSxBSw3y
         vB9UmMD6xt7Vu+nXEDD2RJJ35UjED9QsVjPw7PHxnr07oQo5dWt8NAgT6toowTtfK6
         Tbuup4Y9DDg6PDFAca8hkAoCuQdvCv8e5herLXVbaO9hBMAZAIwl0rEaIoYmVXaEEm
         zNlaxGJMm+agg==
X-Google-Smtp-Source: ABdhPJwsBGHilePCX91/B+68HXzQwCke1MqxmJdd0ufB0PJoG0TAj7RNnkbSayd8FT/j3NwjznYhZmQUUCk3hgmztV8=
X-Received: by 2002:a17:906:ae43:: with SMTP id lf3mr10466222ejb.130.1607698169358;
 Fri, 11 Dec 2020 06:49:29 -0800 (PST)
MIME-Version: 1.0
References: <20201124210228.GA589610@bjorn-Precision-5520> <42ebcbe2-7d24-558a-3c33-beb7818d5516@nvidia.com>
 <49e3a6a4-9621-0734-99f1-b4f616dbcb7d@nvidia.com>
In-Reply-To: <49e3a6a4-9621-0734-99f1-b4f616dbcb7d@nvidia.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 11 Dec 2020 08:49:16 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK7EtRhGhd20P2raj1C4GLOoBQ55ngY+BvygRE-61E+9A@mail.gmail.com>
Message-ID: <CAL_JsqK7EtRhGhd20P2raj1C4GLOoBQ55ngY+BvygRE-61E+9A@mail.gmail.com>
Subject: Re: [PATCH V2] PCI: dwc: Add support to configure for ECRC
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "amurray@thegoodpenguin.co.uk" <amurray@thegoodpenguin.co.uk>,
        "treding@nvidia.com" <treding@nvidia.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kthota@nvidia.com" <kthota@nvidia.com>,
        "mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>,
        "sagar.tv@gmail.com" <sagar.tv@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 11, 2020 at 7:58 AM Vidya Sagar <vidyas@nvidia.com> wrote:
>
> Hi Lorenzo,
> Apologies to bug you, but wondering if you have any further comments on
> this patch that I need to take care of?

You can check the status of your patches in Patchwork:

https://patchwork.kernel.org/project/linux-pci/patch/20201111121145.7015-1-vidyas@nvidia.com/

If it's in 'New' state and delegated to Lorenzo or Bjorn, it's in
their queue. You can shorten the queue by reviewing stuff in front of
you. :)

Rob

>
> Thanks,
> Vidya Sagar
>
> On 12/3/2020 5:40 PM, Vidya Sagar wrote:
> >
> >
> > On 11/25/2020 2:32 AM, Bjorn Helgaas wrote:
> >> External email: Use caution opening links or attachments
> >>
> >>
> >> On Tue, Nov 24, 2020 at 03:50:01PM +0530, Vidya Sagar wrote:
> >>> Hi Bjorn,
> >>> Please let me know if this patch needs any further modifications
> >>
> >> I'm fine with it, but of course Lorenzo will take care of it.
> > Thanks Bjorn.
> >
> > Hi Lorenzo,
> > Please let me know if you have any comments for this patch.
> >
> > Thanks,
> > Vidya Sagar
> >
> >>
> >>> On 11/12/2020 10:32 PM, Vidya Sagar wrote:
> >>>> External email: Use caution opening links or attachments
> >>>>
> >>>>
> >>>> On 11/12/2020 3:59 AM, Bjorn Helgaas wrote:
> >>>>> External email: Use caution opening links or attachments
> >>>>>
> >>>>>
> >>>>> On Wed, Nov 11, 2020 at 10:21:46PM +0530, Vidya Sagar wrote:
> >>>>>>
> >>>>>>
> >>>>>> On 11/11/2020 9:57 PM, Jingoo Han wrote:
> >>>>>>> External email: Use caution opening links or attachments
> >>>>>>>
> >>>>>>>
> >>>>>>> On 11/11/20, 7:12 AM, Vidya Sagar wrote:
> >>>>>>>>
> >>>>>>>> DesignWare core has a TLP digest (TD) override bit in
> >>>>>>>> one of the control
> >>>>>>>> registers of ATU. This bit also needs to be programmed for
> >>>>>>>> proper ECRC
> >>>>>>>> functionality. This is currently identified as an issue
> >>>>>>>> with DesignWare
> >>>>>>>> IP version 4.90a.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> >>>>>>>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> >>>>>>>> ---
> >>>>>>>> V2:
> >>>>>>>> * Addressed Bjorn's comments
> >>>>>>>>
> >>>>>>>>     drivers/pci/controller/dwc/pcie-designware.c | 52
> >>>>>>>> ++++++++++++++++++--
> >>>>>>>>     drivers/pci/controller/dwc/pcie-designware.h |  1 +
> >>>>>>>>     2 files changed, 49 insertions(+), 4 deletions(-)
> >>>>>>>>
> >>>>>>>> diff --git
> >>>>>>>> a/drivers/pci/controller/dwc/pcie-designware.c
> >>>>>>>> b/drivers/pci/controller/dwc/pcie-designware.c
> >>>>>>>> index c2dea8fc97c8..ec0d13ab6bad 100644
> >>>>>>>> --- a/drivers/pci/controller/dwc/pcie-designware.c
> >>>>>>>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> >>>>>>>> @@ -225,6 +225,46 @@ static void
> >>>>>>>> dw_pcie_writel_ob_unroll(struct dw_pcie *pci, u32 index,
> >>>>>>>> u32 reg,
> >>>>>>>>          dw_pcie_writel_atu(pci, offset + reg, val);
> >>>>>>>>     }
> >>>>>>>>
> >>>>>>>> +static inline u32 dw_pcie_enable_ecrc(u32 val)
> >>>>>>>
> >>>>>>> What is the reason to use inline here?
> >>>>>>
> >>>>>> Actually, I wanted to move the programming part inside the
> >>>>>> respective APIs
> >>>>>> but then I wanted to give some details as well in comments so to
> >>>>>> avoid
> >>>>>> duplication, I came up with this function. But, I'm making it
> >>>>>> inline for
> >>>>>> better code optimization by compiler.
> >>>>>
> >>>>> I don't really care either way, but I'd be surprised if the compiler
> >>>>> didn't inline this all by itself even without the explicit "inline".
> >>>> I just checked it and you are right that compiler is indeed inlining it
> >>>> without explicitly mentioning 'inline'.
> >>>> I hope it is ok to leave it that way.
> >>>>
> >>>>>
> >>>>>>>> +{
> >>>>>>>> +     /*
> >>>>>>>> +      * DesignWare core version 4.90A has this strange design
> >>>>>>>> issue
> >>>>>>>> +      * where the 'TD' bit in the Control register-1 of
> >>>>>>>> the ATU outbound
> >>>>>>>> +      * region acts like an override for the ECRC
> >>>>>>>> setting i.e. the presence
> >>>>>>>> +      * of TLP Digest(ECRC) in the outgoing TLPs is
> >>>>>>>> solely determined by
> >>>>>>>> +      * this bit. This is contrary to the PCIe spec
> >>>>>>>> which says that the
> >>>>>>>> +      * enablement of the ECRC is solely determined by
> >>>>>>>> the AER registers.
> >>>>>>>> +      *
> >>>>>>>> +      * Because of this, even when the ECRC is enabled through AER
> >>>>>>>> +      * registers, the transactions going through ATU
> >>>>>>>> won't have TLP Digest
> >>>>>>>> +      * as there is no way the AER sub-system could
> >>>>>>>> program the TD bit which
> >>>>>>>> +      * is specific to DesignWare core.
> >>>>>>>> +      *
> >>>>>>>> +      * The best way to handle this scenario is to program the
> >>>>>>>> TD bit
> >>>>>>>> +      * always. It affects only the traffic from root
> >>>>>>>> port to downstream
> >>>>>>>> +      * devices.
> >>>>>>>> +      *
> >>>>>>>> +      * At this point,
> >>>>>>>> +      * When ECRC is enabled in AER registers,
> >>>>>>>> everything works normally
> >>>>>>>> +      * When ECRC is NOT enabled in AER registers, then,
> >>>>>>>> +      * on Root Port:- TLP Digest (DWord size) gets
> >>>>>>>> appended to each packet
> >>>>>>>> +      *                even through it is not required.
> >>>>>>>> Since downstream
> >>>>>>>> +      *                TLPs are mostly for
> >>>>>>>> configuration accesses and BAR
> >>>>>>>> +      *                accesses, they are not in
> >>>>>>>> critical path and won't
> >>>>>>>> +      *                have much negative effect on the
> >>>>>>>> performance.
> >>>>>>>> +      * on End Point:- TLP Digest is received for
> >>>>>>>> some/all the packets coming
> >>>>>>>> +      *                from the root port. TLP Digest
> >>>>>>>> is ignored because,
> >>>>>>>> +      *                as per the PCIe Spec r5.0 v1.0 section
> >>>>>>>> 2.2.3
> >>>>>>>> +      *                "TLP Digest Rules", when an
> >>>>>>>> endpoint receives TLP
> >>>>>>>> +      *                Digest when its ECRC check
> >>>>>>>> functionality is disabled
> >>>>>>>> +      *                in AER registers, received TLP
> >>>>>>>> Digest is just ignored.
> >>>>>>>> +      * Since there is no issue or error reported
> >>>>>>>> either side, best way to
> >>>>>>>> +      * handle the scenario is to program TD bit by default.
> >>>>>>>> +      */
> >>>>>>>> +
> >>>>>>>> +     return val | PCIE_ATU_TD;
> >>>>>>>> +}
