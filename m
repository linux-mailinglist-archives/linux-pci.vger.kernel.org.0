Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1328A2D9A72
	for <lists+linux-pci@lfdr.de>; Mon, 14 Dec 2020 15:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408331AbgLNO6u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Dec 2020 09:58:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:46380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407905AbgLNO6c (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Dec 2020 09:58:32 -0500
X-Gm-Message-State: AOAM531xvQIO47hW+9J+BOisfG3zlGs+k1M4P6s5hQAsBe/xHa5qvY0+
        yTRiJ9VJNIqV4JGq/hhLPHq+KvOLR+wKwSY8JQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607957870;
        bh=YjqfvjSV9lpOWWw1+HWGyAfGe7Q5uZpQr/FuGmIm8vk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E338AB4Tg40+60Asw0fBlGJ4Z4Ibb4OwsmIqeAEmrBh6BxZ9sifmmPx0EG1wdoP2A
         FEXMPIoh5+e0aDyaT2hqsftFKBJ2vaiUHv0gbnTSQtE87xcSFbqNXZzAFxI9/7bP5o
         LaL6VGdUgV+ur7ZrBgvTvedPGU6gDep4Yd0iNyUSbxaVE5Ytf1yc84a92owqvw3Rq4
         qJX95mj8Aw2wFwlx2uiKwaehcV7og3BGBUeL2TlGoohHPBwF23o6aLQCR9H11Mpdmk
         kW8wpCrlnYXsVargOW3zvZ9j8Z10gLWL1HWhRg+2KVGlDQcAWe5wmo9NCkkkhkkzXE
         BZaTQK2NovtQw==
X-Google-Smtp-Source: ABdhPJyLSMg72Yznek8jiRzdUGmAOe93FaxVsu09rOZbryfT+7YOWyVJmc74/U/1ioJcgEsg5vL3GH9lh22HzFPUC5g=
X-Received: by 2002:a05:6402:1841:: with SMTP id v1mr25750693edy.194.1607957868199;
 Mon, 14 Dec 2020 06:57:48 -0800 (PST)
MIME-Version: 1.0
References: <20201211121507.28166-1-daniel.thompson@linaro.org>
 <CAL_JsqKQxFvkFtph1BZD2LKdZjboxhMTWkZe_AWS-vMD9y0pMw@mail.gmail.com>
 <20201211170558.clfazgoetmery6u3@holly.lan> <20201214104337.wbvq2gvj3wi6bvzc@holly.lan>
In-Reply-To: <20201214104337.wbvq2gvj3wi6bvzc@holly.lan>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 14 Dec 2020 08:57:36 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+horJfhz0EAL6gcBW39DGzY27CU7PGWqricG579T0q4w@mail.gmail.com>
Message-ID: <CAL_Jsq+horJfhz0EAL6gcBW39DGzY27CU7PGWqricG579T0q4w@mail.gmail.com>
Subject: Re: [RFC HACK PATCH] PCI: dwc: layerscape: Hack around enumeration
 problems with Honeycomb LX2K
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jon Nettleton <jon@solid-run.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linaro Patches <patches@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 14, 2020 at 4:43 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Fri, Dec 11, 2020 at 05:05:58PM +0000, Daniel Thompson wrote:
> > On Fri, Dec 11, 2020 at 08:37:40AM -0600, Rob Herring wrote:
> > > On Fri, Dec 11, 2020 at 6:15 AM Daniel Thompson
> > > >     BTW I noticed many other pcie-designware drivers take advantage
> > > >     of a function called dw_pcie_wait_for_link() in their init paths...
> > > >     but my naive attempts to add it to the layerscape driver results
> > > >     in non-booting systems so I haven't embarrassed myself by including
> > > >     that in the patch!
> > >
> > > You need to look at what's pending for v5.11, because I reworked this
> > > to be more unified. The ordering of init is also possibly changed. The
> > > sequence is now like this:
> > >
> > >         dw_pcie_setup_rc(pp);
> > >         dw_pcie_msi_init(pp);
> > >
> > >         if (!dw_pcie_link_up(pci) && pci->ops->start_link) {
> > >                 ret = pci->ops->start_link(pci);
> > >                 if (ret)
> > >                         goto err_free_msi;
> > >         }
> > >
> > >         /* Ignore errors, the link may come up later */
> > >         dw_pcie_wait_for_link(pci);
> >
> > Thanks. That looks likely to fix it since IIUC dw_pcie_wait_for_link()
> > will end up waiting somewhat like the double check I added to
> > ls_pcie_link_up().
> >
> > I'll take a look at let you know.
>
> Yes. These changes have fixed the enumeration problems for me.
>
> I tested pci/next and I cherry picked your patch series onto v5.10 and
> both are working well.
>
> Given this fixes a bug for me, do you think there is any scope for me
> to whittle down your series into patches for the stable kernels or am
> I likely to find too many extra bits being pulled in?

I think I'd just go the adding a delay route. It's a fairly big series
and depends on my other clean-up done in 5.10. And there's at least
some possibility it regresses some platform given the limited testing
linux-next gets.

Rob
