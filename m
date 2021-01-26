Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B430B303AED
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jan 2021 11:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404636AbhAZK5e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jan 2021 05:57:34 -0500
Received: from mail-oo1-f50.google.com ([209.85.161.50]:37357 "EHLO
        mail-oo1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404595AbhAZK5Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Jan 2021 05:57:25 -0500
Received: by mail-oo1-f50.google.com with SMTP id q3so4018468oog.4;
        Tue, 26 Jan 2021 02:57:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vE9H2Qr5sibnEqk/nQ37bCH833rnUqU+D/XJreRlBIY=;
        b=RqFHRQMRON7Y704dghi7T+2FLNOtRY6pNEhelx2oOxN18eBTg9z37fZ07Xlpb4gEWY
         sAjzWmEfiDHIiusQ0gXgCq3OcRbP4peRyu9ImKgpoS1PzhCQtTauXBgqYEmQwLXsSkfn
         WCDOpN0xnazrVdq0aJcvjqi0M/kIvKotPPwmgVrcZ6xrZbqjaODgWWda1xUUSS3s4foW
         G637qWvnKH+qeOWV/57/LtkzR0D1hEzkFx3wA/fS1mi4VkFwAkvXjV76L4lDX5gfJ6qE
         QuZBYPO+gDLU9IgTbJ1L8OS5Kty47b1q0ApN3ghLJNL5hqCIMquLTQWRKjW5yyaGXBKM
         7UXg==
X-Gm-Message-State: AOAM532C27uCpFHCv5jpWO3ukPZMTBmLmbzTW62qA+J/s8DOK4HMclDy
        xGhJ7PCzqfyo0NhRDSuJOdiQ2r3g+Mtq+pXzIKI=
X-Google-Smtp-Source: ABdhPJwTZPke/usOg0RvQsIEXnT6uGT4ZI8MRW0YYj/Wx3ZAFOAdXjRdctIR0fTh39ONcS4pufK/qV8Y8blx+4t+oGI=
X-Received: by 2002:a4a:cb87:: with SMTP id y7mr3536978ooq.1.1611658604662;
 Tue, 26 Jan 2021 02:56:44 -0800 (PST)
MIME-Version: 1.0
References: <20210120105246.23218-1-michael@walle.cc> <20210126100256.GA20547@e121166-lin.cambridge.arm.com>
 <1a36ef741c5ab2a6e90b38c58944aa25@walle.cc>
In-Reply-To: <1a36ef741c5ab2a6e90b38c58944aa25@walle.cc>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 26 Jan 2021 11:56:33 +0100
Message-ID: <CAMuHMdUE25X326b2RaW+R_XFcFpdP5GsesoTMero3Em7vp5WzQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc: layerscape: convert to builtin_platform_driver()
To:     Michael Walle <michael@walle.cc>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Roy Zang <roy.zang@nxp.com>,
        Saravana Kannan <saravanak@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Mingkai Hu <mingkai.hu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Michael,

On Tue, Jan 26, 2021 at 11:46 AM Michael Walle <michael@walle.cc> wrote:
> Am 2021-01-26 11:02, schrieb Lorenzo Pieralisi:
> > On Wed, Jan 20, 2021 at 11:52:46AM +0100, Michael Walle wrote:
> >> fw_devlink will defer the probe until all suppliers are ready. We
> >> can't
> >> use builtin_platform_driver_probe() because it doesn't retry after
> >> probe
> >> deferral. Convert it to builtin_platform_driver().
> >>
> >> Fixes: e590474768f1 ("driver core: Set fw_devlink=on by default")
> >
> > I will have to drop this Fixes: tag if you don't mind, it is not
> > in the mainline.
>
> That commit is in Greg's for-next tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?h=driver-core-next&id=e590474768f1cc04852190b61dec692411b22e2a
>
> I was under the impression there are other commits with this
> particular fixes tag, too. Either it was removed from
> for-next queues or I was confused.
>
> But I'm fine with removing the tag, assuming this will end
> up together with the "driver core: Set fw_devlink=on by default"
> commit in 5.11.

Definitely not v5.11.

And I sincerely doubt it will be applied for v5.12.
It's already way too late to implement all changes to existing drivers
needed, and get them accepted for v5.12.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
