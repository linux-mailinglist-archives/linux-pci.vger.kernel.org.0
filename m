Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B99BF44545B
	for <lists+linux-pci@lfdr.de>; Thu,  4 Nov 2021 14:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbhKDN7m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Nov 2021 09:59:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:42164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229505AbhKDN7m (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Nov 2021 09:59:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C8E060EBD;
        Thu,  4 Nov 2021 13:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636034224;
        bh=LmRim0t3JU43qMKfrhS3HrTRGgWYpquyItL1o78EZ7Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=I5QDAAVg/RBM1psXeBWNaVB41292EQwLnaZJjzwdUp4K4EU02+2rSfZUyFH0CCnqb
         0rAG77sB/pLXdYZCtFZAX8KfqdCJLVVXJfkfpZ3Ojooqv8fxADGldBFpT3QAmwdFHN
         I2sddnAts5Zw1x0Lc8iyDFgpgYZqH6mKc4IIdJn2cU8+pk3ZqJWrCSivX3bQr1j6DI
         dZr3/sckDrhExp1S/daJPneBZFLhPHlqNTge162qnVkP51KOrh5F9YujznYKYs7KWo
         rtVWexHgELkd1sTEIELiimOA09V4iTfWicofrAvMIW4G9ZdxTwrVnw15DywC6ivKjv
         s8fvCxLDC/73g==
Received: by mail-ed1-f53.google.com with SMTP id c8so5029356ede.13;
        Thu, 04 Nov 2021 06:57:03 -0700 (PDT)
X-Gm-Message-State: AOAM530cEYniUZwGNBCugt4j/GYrNpvr0qHVXehcDFx8JSCOvpu0l376
        8WmtILZ9jGquM+U5Cwyr7uRiP+163NdDVvJ/Tg==
X-Google-Smtp-Source: ABdhPJzP7zlHbNM1xPserEcnAkr13cJAvN5KhcVsaVPWeHPZmkLf/dh80gNoW9un31YR1oC6H9rgbdD7sjM8VvVlYxs=
X-Received: by 2002:aa7:dc13:: with SMTP id b19mr54689320edu.145.1636034220156;
 Thu, 04 Nov 2021 06:57:00 -0700 (PDT)
MIME-Version: 1.0
References: <20211103062518.25695-1-wanjiabing@vivo.com> <20211103143059.GA683503@bhelgaas>
In-Reply-To: <20211103143059.GA683503@bhelgaas>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 4 Nov 2021 08:56:48 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK4zg7+CPj_6_wRYDtgU-dqouXmrQhR7C_YyFeOe0Meww@mail.gmail.com>
Message-ID: <CAL_JsqK4zg7+CPj_6_wRYDtgU-dqouXmrQhR7C_YyFeOe0Meww@mail.gmail.com>
Subject: Re: [PATCH] PCI: kirin: Fix of_node_put() issue in pcie-kirin
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Wan Jiabing <wanjiabing@vivo.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        jiabing.wan@qq.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 3, 2021 at 9:31 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+to Mauro, author of code being changed,
> Rob for "of_pci_get_devfn()" naming question]
>
> On Wed, Nov 03, 2021 at 02:25:18AM -0400, Wan Jiabing wrote:
> > Fix following coccicheck warning:
> > ./drivers/pci/controller/dwc/pcie-kirin.c:414:2-34: WARNING: Function
> > for_each_available_child_of_node should have of_node_put() before return.
> >
> > Early exits from for_each_available_child_of_node should decrement the
> > node reference counter. Replace return by goto here.
> >
> > Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-kirin.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> > index 06017e826832..23a2c076ce53 100644
> > --- a/drivers/pci/controller/dwc/pcie-kirin.c
> > +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> > @@ -422,7 +422,8 @@ static int kirin_pcie_parse_port(struct kirin_pcie *pcie,
> >                       pcie->num_slots++;
> >                       if (pcie->num_slots > MAX_PCI_SLOTS) {
> >                               dev_err(dev, "Too many PCI slots!\n");
> > -                             return -EINVAL;
> > +                             ret = -EINVAL;
> > +                             goto put_node;
> >                       }
> >
> >                       ret = of_pci_get_devfn(child);
>
> This is a change to the code added here:
>   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?id=31bd24f0cfe0
>
> This fix looks right to me; all the other early exits from the inner
> loop drop the "child" reference.
>
> But this is a nested loop and the *outer* loop also increments
> refcounts, and I don't see that outer loop reference on "parent" being
> dropped at all:
>
>     for_each_available_child_of_node(node, parent) {
>       for_each_available_child_of_node(parent, child) {
>         ...
>         if (error)
>           goto put_node;
>       }
>     }
>
>   put_node:
>     of_node_put(child);

Indeed. There should be a put on the parent.

This whole function is less than ideal as it assumes the board has 2
levels of PCI nodes. This might be another (like brcmstb thread) place
to use .add_bus(). But that's a problem for another day.

> The "of_pci_get_devfn()" immediately after is unrelated, but possibly
> a confusing name.  "Get" often suggests a reference count being
> increased, but that's not the case with of_pci_get_devfn().

I guess you have to know that only nodes are refcounted and property
functions never are.

There's also of_pci_get_max_link_speed() and of_get_pci_domain_nr().

Rob
