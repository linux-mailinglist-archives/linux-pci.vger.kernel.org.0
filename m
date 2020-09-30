Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A0527EBB5
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 17:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbgI3PCN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 11:02:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:57674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgI3PCN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Sep 2020 11:02:13 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EE2920789;
        Wed, 30 Sep 2020 15:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601478132;
        bh=MdE1i8KgB3QnwXcjilTU0w0symDifwqpaU/PORoVu5I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FolePRkIR98oqR+FMUde+BLZiLt3IVCR4Cn3rd8ymzuvFEg3vAfWdViIMcnz0FnKC
         X0UvJyZ131W481CJsVWVIdORGvVd+ZmgM8deQvU+OCTVSSZWSGJqDw0VhjtieB3XB6
         eOWzS6qGAr1MyAnPrkhNVsNrT4p5+SX5nKPEvYeY=
Received: by mail-oi1-f180.google.com with SMTP id 185so1988831oie.11;
        Wed, 30 Sep 2020 08:02:12 -0700 (PDT)
X-Gm-Message-State: AOAM530TfWqAWulx87rU7fHKKozKFYPd5H3RMn8JoZh2E7HUp1/5y7dW
        gKy80ua8o+zbyatKlo1db8V5duXkFh0jx4yIzg==
X-Google-Smtp-Source: ABdhPJxGWMQf9BR7BPtzdlH19vuVhLB7nPfhp5mLIHpIIUIFAco8YDsbqZom1mvT7pQuhqCygZo++TAN9SGz8m3PAfY=
X-Received: by 2002:aca:7543:: with SMTP id q64mr1661890oic.147.1601478131261;
 Wed, 30 Sep 2020 08:02:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200916054130.8685-1-Zhiqiang.Hou@nxp.com> <CAL_JsqJwgNUpWFTq2YWowDUigndSOB4rUcVm0a_U=FEpEmk94Q@mail.gmail.com>
 <HE1PR0402MB3371F8191538F47E8249F048843F0@HE1PR0402MB3371.eurprd04.prod.outlook.com>
 <CAL_JsqLdQY_DqpduaTv4hMDM_-cvZ_+s8W+HdOuZVVYjTO4yxw@mail.gmail.com>
 <HE1PR0402MB337180458625B05D1529535384390@HE1PR0402MB3371.eurprd04.prod.outlook.com>
 <20200928093911.GB12010@e121166-lin.cambridge.arm.com> <HE1PR0402MB33713A623A37D08AE3253DEB84320@HE1PR0402MB3371.eurprd04.prod.outlook.com>
 <DM5PR12MB1276D80424F88F8A9243D5E2DA320@DM5PR12MB1276.namprd12.prod.outlook.com>
 <CAL_JsqJJxq2jZzbzZffsrPxnoLJdWLLS-7bG-vaqyqs5NkQhHQ@mail.gmail.com> <9ac53f04-f2e8-c5f9-e1f7-e54270ec55a0@ti.com>
In-Reply-To: <9ac53f04-f2e8-c5f9-e1f7-e54270ec55a0@ti.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 30 Sep 2020 10:01:59 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJEp8yyctJYUjHM4Ti6ggPb4ouYM_WDvpj_PiobnAozBw@mail.gmail.com>
Message-ID: <CAL_JsqJEp8yyctJYUjHM4Ti6ggPb4ouYM_WDvpj_PiobnAozBw@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc: Added link up check in map_bus of dw_child_pcie_ops
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michael Walle <michael@walle.cc>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 30, 2020 at 8:22 AM Kishon Vijay Abraham I <kishon@ti.com> wrot=
e:
>
> Hi,
>
> On 29/09/20 10:41 pm, Rob Herring wrote:
> > On Tue, Sep 29, 2020 at 10:24 AM Gustavo Pimentel
> > <Gustavo.Pimentel@synopsys.com> wrote:
> >>
> >> On Tue, Sep 29, 2020 at 5:5:41, Z.q. Hou <zhiqiang.hou@nxp.com> wrote:
> >>
> >>> Hi Lorenzo,
> >>>
> >>> Thanks a lot for your comments!
> >>>
> >>>> -----Original Message-----
> >>>> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> >>>> Sent: 2020=E5=B9=B49=E6=9C=8828=E6=97=A5 17:39
> >>>> To: Z.q. Hou <zhiqiang.hou@nxp.com>
> >>>> Cc: Rob Herring <robh@kernel.org>; linux-kernel@vger.kernel.org; PCI
> >>>> <linux-pci@vger.kernel.org>; Bjorn Helgaas <bhelgaas@google.com>;
> >>>> Gustavo Pimentel <gustavo.pimentel@synopsys.com>; Michael Walle
> >>>> <michael@walle.cc>; Ard Biesheuvel <ardb@kernel.org>
> >>>> Subject: Re: [PATCH] PCI: dwc: Added link up check in map_bus of
> >>>> dw_child_pcie_ops
> >>>>
> >>>> On Thu, Sep 24, 2020 at 04:24:47AM +0000, Z.q. Hou wrote:
> >>>>> Hi Rob,
> >>>>>
> >>>>> Thanks a lot for your comments!
> >>>>>
> >>>>>> -----Original Message-----
> >>>>>> From: Rob Herring <robh@kernel.org>
> >>>>>> Sent: 2020=E5=B9=B49=E6=9C=8818=E6=97=A5 23:28
> >>>>>> To: Z.q. Hou <zhiqiang.hou@nxp.com>
> >>>>>> Cc: linux-kernel@vger.kernel.org; PCI <linux-pci@vger.kernel.org>;
> >>>>>> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>; Bjorn Helgaas
> >>>>>> <bhelgaas@google.com>; Gustavo Pimentel
> >>>>>> <gustavo.pimentel@synopsys.com>; Michael Walle
> >>>> <michael@walle.cc>;
> >>>>>> Ard Biesheuvel <ardb@kernel.org>
> >>>>>> Subject: Re: [PATCH] PCI: dwc: Added link up check in map_bus of
> >>>>>> dw_child_pcie_ops
> >>>>>>
> >>>>>> On Fri, Sep 18, 2020 at 5:02 AM Z.q. Hou <zhiqiang.hou@nxp.com>
> >>>> wrote:
> >>>>>>>
> >>>>>>> Hi Rob,
> >>>>>>>
> >>>>>>> Thanks a lot for your comments!
> >>>>>>>
> >>>>>>>> -----Original Message-----
> >>>>>>>> From: Rob Herring <robh@kernel.org>
> >>>>>>>> Sent: 2020=E5=B9=B49=E6=9C=8817=E6=97=A5 4:29
> >>>>>>>> To: Z.q. Hou <zhiqiang.hou@nxp.com>
> >>>>>>>> Cc: linux-kernel@vger.kernel.org; PCI
> >>>>>>>> <linux-pci@vger.kernel.org>; Lorenzo Pieralisi
> >>>>>>>> <lorenzo.pieralisi@arm.com>; Bjorn Helgaas
> >>>>>>>> <bhelgaas@google.com>; Gustavo Pimentel
> >>>>>>>> <gustavo.pimentel@synopsys.com>; Michael Walle
> >>>>>> <michael@walle.cc>;
> >>>>>>>> Ard Biesheuvel <ardb@kernel.org>
> >>>>>>>> Subject: Re: [PATCH] PCI: dwc: Added link up check in map_bus of
> >>>>>>>> dw_child_pcie_ops
> >>>>>>>>
> >>>>>>>> On Tue, Sep 15, 2020 at 11:49 PM Zhiqiang Hou
> >>>>>> <Zhiqiang.Hou@nxp.com>
> >>>>>>>> wrote:
> >>>>>>>>>
> >>>>>>>>> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> >>>>>>>>>
> >>>>>>>>> On NXP Layerscape platforms, it results in SError in the
> >>>>>>>>> enumeration of the PCIe controller, which is not connecting
> >>>>>>>>> with an Endpoint device. And it doesn't make sense to
> >>>>>>>>> enumerate the Endpoints when the PCIe link is down. So this
> >>>>>>>>> patch added the link up check to avoid to fire configuration
> >>>> transactions on link down bus.
> >>>>>>>>
> >>>>>>>> Michael reported the same issue as well.
> >>>>>>>>
> >>>>>>>> What happens if the link goes down between the check and the
> >>>> access?
> >>>>>>>
> >>>>>>> This patch cannot cover this case, and will get the SError.
> >>>>>>> But I think it makes sense to avoid firing transactions on link d=
own bus.
> >>>>>>
> >>>>>> That's impossible to do without a race even in h/w.
> >>>>>
> >>>>> Agree.
> >>>>>
> >>>>>>
> >>>>>>>> It's a racy check. I'd like to find an alternative solution.
> >>>>>>>> It's even worse if Layerscape is used in ECAM mode. I looked at
> >>>>>>>> the EDK2 setup for layerscape[1] and it looks like root ports
> >>>>>>>> are just skipped if link
> >>>>>> is down.
> >>>>>>>> Maybe a link down just never happens once up, but if so, then we
> >>>>>>>> only need to check it once and fail probe.
> >>>>>>>
> >>>>>>> Many customers connect the FPGA Endpoint, which may establish PCI=
e
> >>>>>>> link after the PCIe enumeration and then rescan the PCIe bus, so =
I
> >>>>>>> think it should not exit the probe of root port even if there is
> >>>>>>> not link up
> >>>>>> during enumeration.
> >>>>>>
> >>>>>> That's a good reason. I want to unify the behavior here as it vari=
es
> >>>>>> per platform currently and wasn't sure which way to go.
> >>>>>>
> >>>>>>
> >>>>>>>> I've dug into this a bit more and am curious about the
> >>>>>>>> PCIE_ABSERR register setting which is set to:
> >>>>>>>>
> >>>>>>>> #define PCIE_ABSERR_SETTING 0x9401 /* Forward error of
> >>>>>>>> non-posted request */
> >>>>>>>>
> >>>>>>>> It seems to me this is not what we want at least for config
> >>>>>>>> accesses, but commit 84d897d6993 where this was added seems to
> >>>>>>>> say otherwise. Is it not possible to configure the response per =
access
> >>>> type?
> >>>>>>>
> >>>>>>> Thanks a lot for your investigation!
> >>>>>>> The story is like this: Some customers worry about these silent
> >>>>>>> error (DWC PCIe IP won't forward the error of outbound non-post
> >>>>>>> request by default), so we were pushed to enable the error
> >>>>>>> forwarding to AXI in the commit
> >>>>>>> 84d897d6993 as you saw. But it cannot differentiate the config
> >>>>>>> transactions from the MEM_rd, except the Vendor ID access, which
> >>>>>>> is controlled by a separate bit and it was set to not forward
> >>>>>>> error of access
> >>>>>> of Vendor ID.
> >>>>>>> So we think it's okay to enable the error forwarding, the SError
> >>>>>>> should not occur, because after the enumeration it won't access
> >>>>>>> the
> >>>>>> non-existent functions.
> >>>>>>
> >>>>>> We've rejected upstream support for platforms aborting on config
> >>>>>> accesses[1]. I think there's clear consensus that aborting is the
> >>>>>> wrong behavior.
> >>>>>>
> >>>>>> Do MEM_wr errors get forwarded? Seems like that would be enough.
> >>>>>> Also, wouldn't page faults catch most OOB accesses anyways? You ne=
ed
> >>>>>> things page aligned anyways with an IOMMU and doing userspace acce=
ss
> >>>>>> or guest assignment.
> >>>>>
> >>>>> Yes, errors of MEM_wr can be forwarded.
> >>>>>
> >>>>>>
> >>>>>> Here's another idea, how about only enabling forwarding errors if
> >>>>>> the link is up? If really would need to be configured any time the
> >>>>>> link state changes rather than just at probe. I'm not sure if you
> >>>>>> have a way to disable it on link down though.
> >>>>>
> >>>>> Dug deeper into this issue and found the setting of not forwarding
> >>>>> error of non-existent Vender ID access counts on the link partner: =
1.
> >>>>> When there is a link partner (namely link up), it will return 0xfff=
f
> >>>>> when read non-existent function Vendor ID and won't forward error t=
o
> >>>>> AXI.  2. When no link partner (link down), it will forward the erro=
r
> >>>>> of reading non-existent function Vendor ID to AXI and result in
> >>>>> SError.
> >>>>>
> >>>>> I think this is a DWC PCIe IP specific issue but not get feedback f=
rom
> >>>>> design team.  I'm thinking to disable this error forwarding just li=
ke
> >>>>> other platforms, since when these errors (UR, CA and CT) are detect=
ed,
> >>>>> AER driver can also report the error and try to recover.
> >>>>
> >>>> I take this as you shall send a patch to fix this issue shortly, is =
this correct ?
> >>>
> >>> The issue becomes complex:
> >>> I reviewed the DWC PCIe databook of verion 4.40a which is used on Lay=
erscape platforms, and it said that " Your RC application should not genera=
te CFG requests until it has confirmed that the link is up by sampling the =
smlh_link_up and rmlh_link_up outputs".
> >>> So, the link up checking should not be remove before each outbound CF=
G access.
> >>> Gustavo, can you share more details on the link up checking? Does it =
only exist in the 4.40a?
> >>
> >> Hi Zhiqiang,
> >>
> >> According to the information that I got from the IP team you are corre=
ct,
> >> the same requirement still exists on the newer IP versions.
> >
> > How is that possible in a race free way?
> >
> > Testing on meson and layerscape (with the forwarding of errors
> > disabled) shows a link check is not needed. But then dra7xx seems to
> > need one (or has some f/w setup).
>
> Yeah, I don't see any registers in the DRA7x PCIe wrapper for disabling
> error forwarding.

It's a DWC port logic register AFAICT, but perhaps not present in all versi=
ons.

Rob
