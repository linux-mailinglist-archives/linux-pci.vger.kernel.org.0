Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D40A2700E7
	for <lists+linux-pci@lfdr.de>; Fri, 18 Sep 2020 17:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgIRP1x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Sep 2020 11:27:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:38314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbgIRP1x (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Sep 2020 11:27:53 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F085238D6;
        Fri, 18 Sep 2020 15:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600442872;
        bh=FMMaFBxal+hIzjghF0gMThxlBZDi1XTUmBkA3rR/wrQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a93XnvBO8obMKJ+MGkXXMdIR952udHPRMcFvJ3XK5EWlhZIMLJz0/3LmJLYBxE7IU
         zUPrsQ9SfJRbFiywmMyvLqyA98wqRXK1d+MKuMln9w2uPN7q1SzFeyFb7BxiM4pm4x
         zyp1sUWjWQ97zeEPJwI2GdYR6LsyilJ1oxKdZaFE=
Received: by mail-ot1-f52.google.com with SMTP id u25so5747745otq.6;
        Fri, 18 Sep 2020 08:27:52 -0700 (PDT)
X-Gm-Message-State: AOAM532XdtrrL2XKfGU7C4y4NkJurCMx5mKe+2upX+cONvjEXvZgNwE6
        d58+vbB+L92gLQfKSQ27APsX72uwwSqFefFseg==
X-Google-Smtp-Source: ABdhPJy0+O6BUH7GXyJ4URmLPzS8MDJjgKb5bT+YAPkc22aKgTLcpecw9PHz3F4rh70FeN3U/g+7+Q7y8XbYlHZCdMQ=
X-Received: by 2002:a9d:6b0d:: with SMTP id g13mr23652773otp.129.1600442871593;
 Fri, 18 Sep 2020 08:27:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200916054130.8685-1-Zhiqiang.Hou@nxp.com> <CAL_JsqJwgNUpWFTq2YWowDUigndSOB4rUcVm0a_U=FEpEmk94Q@mail.gmail.com>
 <HE1PR0402MB3371F8191538F47E8249F048843F0@HE1PR0402MB3371.eurprd04.prod.outlook.com>
In-Reply-To: <HE1PR0402MB3371F8191538F47E8249F048843F0@HE1PR0402MB3371.eurprd04.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 18 Sep 2020 09:27:40 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLdQY_DqpduaTv4hMDM_-cvZ_+s8W+HdOuZVVYjTO4yxw@mail.gmail.com>
Message-ID: <CAL_JsqLdQY_DqpduaTv4hMDM_-cvZ_+s8W+HdOuZVVYjTO4yxw@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc: Added link up check in map_bus of dw_child_pcie_ops
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Michael Walle <michael@walle.cc>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 18, 2020 at 5:02 AM Z.q. Hou <zhiqiang.hou@nxp.com> wrote:
>
> Hi Rob,
>
> Thanks a lot for your comments!
>
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: 2020=E5=B9=B49=E6=9C=8817=E6=97=A5 4:29
> > To: Z.q. Hou <zhiqiang.hou@nxp.com>
> > Cc: linux-kernel@vger.kernel.org; PCI <linux-pci@vger.kernel.org>; Lore=
nzo
> > Pieralisi <lorenzo.pieralisi@arm.com>; Bjorn Helgaas
> > <bhelgaas@google.com>; Gustavo Pimentel
> > <gustavo.pimentel@synopsys.com>; Michael Walle <michael@walle.cc>;
> > Ard Biesheuvel <ardb@kernel.org>
> > Subject: Re: [PATCH] PCI: dwc: Added link up check in map_bus of
> > dw_child_pcie_ops
> >
> > On Tue, Sep 15, 2020 at 11:49 PM Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
> > wrote:
> > >
> > > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > >
> > > On NXP Layerscape platforms, it results in SError in the enumeration
> > > of the PCIe controller, which is not connecting with an Endpoint
> > > device. And it doesn't make sense to enumerate the Endpoints when the
> > > PCIe link is down. So this patch added the link up check to avoid to
> > > fire configuration transactions on link down bus.
> >
> > Michael reported the same issue as well.
> >
> > What happens if the link goes down between the check and the access?
>
> This patch cannot cover this case, and will get the SError.
> But I think it makes sense to avoid firing transactions on link down bus.

That's impossible to do without a race even in h/w.

> > It's a racy check. I'd like to find an alternative solution. It's even =
worse if
> > Layerscape is used in ECAM mode. I looked at the EDK2 setup for
> > layerscape[1] and it looks like root ports are just skipped if link is =
down.
> > Maybe a link down just never happens once up, but if so, then we only n=
eed
> > to check it once and fail probe.
>
> Many customers connect the FPGA Endpoint, which may establish PCIe link
> after the PCIe enumeration and then rescan the PCIe bus, so I think it sh=
ould
> not exit the probe of root port even if there is not link up during enume=
ration.

That's a good reason. I want to unify the behavior here as it varies
per platform currently and wasn't sure which way to go.


> > I've dug into this a bit more and am curious about the PCIE_ABSERR regi=
ster
> > setting which is set to:
> >
> > #define PCIE_ABSERR_SETTING 0x9401 /* Forward error of non-posted
> > request */
> >
> > It seems to me this is not what we want at least for config accesses, b=
ut
> > commit 84d897d6993 where this was added seems to say otherwise. Is it n=
ot
> > possible to configure the response per access type?
>
> Thanks a lot for your investigation!
> The story is like this: Some customers worry about these silent error (DW=
C PCIe
> IP won't forward the error of outbound non-post request by default), so w=
e
> were pushed to enable the error forwarding to AXI in the commit
> 84d897d6993 as you saw. But it cannot differentiate the config transactio=
ns
> from the MEM_rd, except the Vendor ID access, which is controlled by
> a separate bit and it was set to not forward error of access of Vendor ID=
.
> So we think it's okay to enable the error forwarding, the SError should n=
ot
> occur, because after the enumeration it won't access the non-existent fun=
ctions.

We've rejected upstream support for platforms aborting on config
accesses[1]. I think there's clear consensus that aborting is the
wrong behavior.

Do MEM_wr errors get forwarded? Seems like that would be enough. Also,
wouldn't page faults catch most OOB accesses anyways? You need things
page aligned anyways with an IOMMU and doing userspace access or guest
assignment.

Here's another idea, how about only enabling forwarding errors if the
link is up? If really would need to be configured any time the link
state changes rather than just at probe. I'm not sure if you have a
way to disable it on link down though.

Rob
