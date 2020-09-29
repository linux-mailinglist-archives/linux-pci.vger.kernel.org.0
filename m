Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD8E27D42F
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 19:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgI2RLV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 13:11:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:49208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728205AbgI2RLV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Sep 2020 13:11:21 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07C13208B8;
        Tue, 29 Sep 2020 17:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601399480;
        bh=to32lW7loD1nn8GVffNKTEhG93PmsP85GRhOV6RUSBo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FNp0B+wM7HIu0HujzPzM3i8EKZLVuSAO19nVvlNAcgvbFYjPoZgYBlSI6hlM5gt74
         7PM0BH/CcPpMmruj2IEUFNuTnFeILXq8kbZLVqEIFd9+8Df9qNc9Gh3Oajl6e+15Fn
         zPzaDJ+Hvr1KbTzZaR/uPZEXvfJBcMHjG7kQTNJ4=
Received: by mail-oi1-f180.google.com with SMTP id n2so6277223oij.1;
        Tue, 29 Sep 2020 10:11:19 -0700 (PDT)
X-Gm-Message-State: AOAM532csvZAoT5Pq15cFDhITLqCb+3jwO9qP9PECidIgpuvnFlTzZy4
        hG0P8XWkMCVCG5E6KJs++yjKi9tFbrGHq944Ew==
X-Google-Smtp-Source: ABdhPJy/snVinmk95/uGpGIIAAnF1HdqKf21HM3o0+LfAGwZiJyScyNT3V7sMzX+5F0uYZ782kZV7nCEUETuC3iawU4=
X-Received: by 2002:a05:6808:10e:: with SMTP id b14mr3317499oie.152.1601399479143;
 Tue, 29 Sep 2020 10:11:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200916054130.8685-1-Zhiqiang.Hou@nxp.com> <CAL_JsqJwgNUpWFTq2YWowDUigndSOB4rUcVm0a_U=FEpEmk94Q@mail.gmail.com>
 <HE1PR0402MB3371F8191538F47E8249F048843F0@HE1PR0402MB3371.eurprd04.prod.outlook.com>
 <CAL_JsqLdQY_DqpduaTv4hMDM_-cvZ_+s8W+HdOuZVVYjTO4yxw@mail.gmail.com>
 <HE1PR0402MB337180458625B05D1529535384390@HE1PR0402MB3371.eurprd04.prod.outlook.com>
 <20200928093911.GB12010@e121166-lin.cambridge.arm.com> <HE1PR0402MB33713A623A37D08AE3253DEB84320@HE1PR0402MB3371.eurprd04.prod.outlook.com>
 <DM5PR12MB1276D80424F88F8A9243D5E2DA320@DM5PR12MB1276.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB1276D80424F88F8A9243D5E2DA320@DM5PR12MB1276.namprd12.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 29 Sep 2020 12:11:07 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJJxq2jZzbzZffsrPxnoLJdWLLS-7bG-vaqyqs5NkQhHQ@mail.gmail.com>
Message-ID: <CAL_JsqJJxq2jZzbzZffsrPxnoLJdWLLS-7bG-vaqyqs5NkQhHQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc: Added link up check in map_bus of dw_child_pcie_ops
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     "Z.q. Hou" <zhiqiang.hou@nxp.com>,
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

On Tue, Sep 29, 2020 at 10:24 AM Gustavo Pimentel
<Gustavo.Pimentel@synopsys.com> wrote:
>
> On Tue, Sep 29, 2020 at 5:5:41, Z.q. Hou <zhiqiang.hou@nxp.com> wrote:
>
> > Hi Lorenzo,
> >
> > Thanks a lot for your comments!
> >
> > > -----Original Message-----
> > > From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Sent: 2020=E5=B9=B49=E6=9C=8828=E6=97=A5 17:39
> > > To: Z.q. Hou <zhiqiang.hou@nxp.com>
> > > Cc: Rob Herring <robh@kernel.org>; linux-kernel@vger.kernel.org; PCI
> > > <linux-pci@vger.kernel.org>; Bjorn Helgaas <bhelgaas@google.com>;
> > > Gustavo Pimentel <gustavo.pimentel@synopsys.com>; Michael Walle
> > > <michael@walle.cc>; Ard Biesheuvel <ardb@kernel.org>
> > > Subject: Re: [PATCH] PCI: dwc: Added link up check in map_bus of
> > > dw_child_pcie_ops
> > >
> > > On Thu, Sep 24, 2020 at 04:24:47AM +0000, Z.q. Hou wrote:
> > > > Hi Rob,
> > > >
> > > > Thanks a lot for your comments!
> > > >
> > > > > -----Original Message-----
> > > > > From: Rob Herring <robh@kernel.org>
> > > > > Sent: 2020=E5=B9=B49=E6=9C=8818=E6=97=A5 23:28
> > > > > To: Z.q. Hou <zhiqiang.hou@nxp.com>
> > > > > Cc: linux-kernel@vger.kernel.org; PCI <linux-pci@vger.kernel.org>=
;
> > > > > Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>; Bjorn Helgaas
> > > > > <bhelgaas@google.com>; Gustavo Pimentel
> > > > > <gustavo.pimentel@synopsys.com>; Michael Walle
> > > <michael@walle.cc>;
> > > > > Ard Biesheuvel <ardb@kernel.org>
> > > > > Subject: Re: [PATCH] PCI: dwc: Added link up check in map_bus of
> > > > > dw_child_pcie_ops
> > > > >
> > > > > On Fri, Sep 18, 2020 at 5:02 AM Z.q. Hou <zhiqiang.hou@nxp.com>
> > > wrote:
> > > > > >
> > > > > > Hi Rob,
> > > > > >
> > > > > > Thanks a lot for your comments!
> > > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: Rob Herring <robh@kernel.org>
> > > > > > > Sent: 2020=E5=B9=B49=E6=9C=8817=E6=97=A5 4:29
> > > > > > > To: Z.q. Hou <zhiqiang.hou@nxp.com>
> > > > > > > Cc: linux-kernel@vger.kernel.org; PCI
> > > > > > > <linux-pci@vger.kernel.org>; Lorenzo Pieralisi
> > > > > > > <lorenzo.pieralisi@arm.com>; Bjorn Helgaas
> > > > > > > <bhelgaas@google.com>; Gustavo Pimentel
> > > > > > > <gustavo.pimentel@synopsys.com>; Michael Walle
> > > > > <michael@walle.cc>;
> > > > > > > Ard Biesheuvel <ardb@kernel.org>
> > > > > > > Subject: Re: [PATCH] PCI: dwc: Added link up check in map_bus=
 of
> > > > > > > dw_child_pcie_ops
> > > > > > >
> > > > > > > On Tue, Sep 15, 2020 at 11:49 PM Zhiqiang Hou
> > > > > <Zhiqiang.Hou@nxp.com>
> > > > > > > wrote:
> > > > > > > >
> > > > > > > > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > > > > > > >
> > > > > > > > On NXP Layerscape platforms, it results in SError in the
> > > > > > > > enumeration of the PCIe controller, which is not connecting
> > > > > > > > with an Endpoint device. And it doesn't make sense to
> > > > > > > > enumerate the Endpoints when the PCIe link is down. So this
> > > > > > > > patch added the link up check to avoid to fire configuratio=
n
> > > transactions on link down bus.
> > > > > > >
> > > > > > > Michael reported the same issue as well.
> > > > > > >
> > > > > > > What happens if the link goes down between the check and the
> > > access?
> > > > > >
> > > > > > This patch cannot cover this case, and will get the SError.
> > > > > > But I think it makes sense to avoid firing transactions on link=
 down bus.
> > > > >
> > > > > That's impossible to do without a race even in h/w.
> > > >
> > > > Agree.
> > > >
> > > > >
> > > > > > > It's a racy check. I'd like to find an alternative solution.
> > > > > > > It's even worse if Layerscape is used in ECAM mode. I looked =
at
> > > > > > > the EDK2 setup for layerscape[1] and it looks like root ports
> > > > > > > are just skipped if link
> > > > > is down.
> > > > > > > Maybe a link down just never happens once up, but if so, then=
 we
> > > > > > > only need to check it once and fail probe.
> > > > > >
> > > > > > Many customers connect the FPGA Endpoint, which may establish P=
CIe
> > > > > > link after the PCIe enumeration and then rescan the PCIe bus, s=
o I
> > > > > > think it should not exit the probe of root port even if there i=
s
> > > > > > not link up
> > > > > during enumeration.
> > > > >
> > > > > That's a good reason. I want to unify the behavior here as it var=
ies
> > > > > per platform currently and wasn't sure which way to go.
> > > > >
> > > > >
> > > > > > > I've dug into this a bit more and am curious about the
> > > > > > > PCIE_ABSERR register setting which is set to:
> > > > > > >
> > > > > > > #define PCIE_ABSERR_SETTING 0x9401 /* Forward error of
> > > > > > > non-posted request */
> > > > > > >
> > > > > > > It seems to me this is not what we want at least for config
> > > > > > > accesses, but commit 84d897d6993 where this was added seems t=
o
> > > > > > > say otherwise. Is it not possible to configure the response p=
er access
> > > type?
> > > > > >
> > > > > > Thanks a lot for your investigation!
> > > > > > The story is like this: Some customers worry about these silent
> > > > > > error (DWC PCIe IP won't forward the error of outbound non-post
> > > > > > request by default), so we were pushed to enable the error
> > > > > > forwarding to AXI in the commit
> > > > > > 84d897d6993 as you saw. But it cannot differentiate the config
> > > > > > transactions from the MEM_rd, except the Vendor ID access, whic=
h
> > > > > > is controlled by a separate bit and it was set to not forward
> > > > > > error of access
> > > > > of Vendor ID.
> > > > > > So we think it's okay to enable the error forwarding, the SErro=
r
> > > > > > should not occur, because after the enumeration it won't access
> > > > > > the
> > > > > non-existent functions.
> > > > >
> > > > > We've rejected upstream support for platforms aborting on config
> > > > > accesses[1]. I think there's clear consensus that aborting is the
> > > > > wrong behavior.
> > > > >
> > > > > Do MEM_wr errors get forwarded? Seems like that would be enough.
> > > > > Also, wouldn't page faults catch most OOB accesses anyways? You n=
eed
> > > > > things page aligned anyways with an IOMMU and doing userspace acc=
ess
> > > > > or guest assignment.
> > > >
> > > > Yes, errors of MEM_wr can be forwarded.
> > > >
> > > > >
> > > > > Here's another idea, how about only enabling forwarding errors if
> > > > > the link is up? If really would need to be configured any time th=
e
> > > > > link state changes rather than just at probe. I'm not sure if you
> > > > > have a way to disable it on link down though.
> > > >
> > > > Dug deeper into this issue and found the setting of not forwarding
> > > > error of non-existent Vender ID access counts on the link partner: =
1.
> > > > When there is a link partner (namely link up), it will return 0xfff=
f
> > > > when read non-existent function Vendor ID and won't forward error t=
o
> > > > AXI.  2. When no link partner (link down), it will forward the erro=
r
> > > > of reading non-existent function Vendor ID to AXI and result in
> > > > SError.
> > > >
> > > > I think this is a DWC PCIe IP specific issue but not get feedback f=
rom
> > > > design team.  I'm thinking to disable this error forwarding just li=
ke
> > > > other platforms, since when these errors (UR, CA and CT) are detect=
ed,
> > > > AER driver can also report the error and try to recover.
> > >
> > > I take this as you shall send a patch to fix this issue shortly, is t=
his correct ?
> >
> > The issue becomes complex:
> > I reviewed the DWC PCIe databook of verion 4.40a which is used on Layer=
scape platforms, and it said that " Your RC application should not generate=
 CFG requests until it has confirmed that the link is up by sampling the sm=
lh_link_up and rmlh_link_up outputs".
> > So, the link up checking should not be remove before each outbound CFG =
access.
> > Gustavo, can you share more details on the link up checking? Does it on=
ly exist in the 4.40a?
>
> Hi Zhiqiang,
>
> According to the information that I got from the IP team you are correct,
> the same requirement still exists on the newer IP versions.

How is that possible in a race free way?

Testing on meson and layerscape (with the forwarding of errors
disabled) shows a link check is not needed. But then dra7xx seems to
need one (or has some f/w setup).

Rob
