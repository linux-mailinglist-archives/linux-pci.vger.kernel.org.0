Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D09418459
	for <lists+linux-pci@lfdr.de>; Sat, 25 Sep 2021 22:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbhIYUSp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Sep 2021 16:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhIYUSo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Sep 2021 16:18:44 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA25AC061570;
        Sat, 25 Sep 2021 13:17:09 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id 188so12768664vsv.0;
        Sat, 25 Sep 2021 13:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4avZOfZm1u+aKpvIhV7cRkLhBytvyCiQq+DzBLIetBs=;
        b=it6CQquhgjOSghhWHwRoIUwOAD+aRreCPxbDO7PkRMkSIw2NvMDB0+f+JVFeEK5n2m
         MxuZo13JOYgWlWgcC+nf0cwEk8VSac0XhMuriMMtXvn8WVp3cwpiQ3oGKrKI0c6FeAI8
         yEdODJgWqqH8vMfnQI879t+Ly2l+kFgqjiEWvhp6dXl6KLb8nQ14ldlzs1G0jw7B1k4x
         RAeeBpejv7kI6aAsHlojrCNgQYHc5o9doevgM5Eke/mjlypCKRIc+B1XK4j3EcDX19ry
         frL8BY0p1OKP9WHmMQScvdVdILl/DBVffCG55YTfJyXbsbvfCrCPVQn5fKn5WSiTaORn
         oRWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4avZOfZm1u+aKpvIhV7cRkLhBytvyCiQq+DzBLIetBs=;
        b=D/WquGLMI20lYcQuOyMoFNV5+sZt6xiA/Ram99Z2LndbU8FZC15JALcYEYWV8DXY7s
         Kc17+Z2MIRmrlNRXfg6E/5aaFp6Hz7CzVnH2RitAwyeZuhtqI3gCPex+IrAoFhz0o/iL
         1pNoosCo7hn+CDi8r6atoJDRvKOkdJWa1epUgd6KfaYsTib8k0nS3LHz9Q0SeNUyuStK
         40KajGMxPuXqKDZgumiWddeKNYzIs0zvLT1y5pGNcVopKDIJVrb0DPSGH8EsnQbQNK+Z
         C6rGiskFxYFBJi7dhO2CykPIgqUShL3vp/nO1k2+9pFFj9UJlv+yLLeJtsYXd0A4tfVD
         34mA==
X-Gm-Message-State: AOAM533g7GCCPlsqqzkJeYm6KVTNxHEZps7Q8DyPHFQhK+D+HXK3K57b
        QXMpLCtD0z2LZ9GvOy4srXnOUscta/rNnNEp8RI=
X-Google-Smtp-Source: ABdhPJzLJuTQR9VhMkKFf0u0aMjQ7yr2pVsPF9Qzym2EufI3G/6e9bCttp19+oR4uzeiAHO37n6qULIgp2/NGVk7qYY=
X-Received: by 2002:a05:6102:3005:: with SMTP id s5mr15012307vsa.48.1632601028806;
 Sat, 25 Sep 2021 13:17:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210924211139.3477-1-sergio.paracuellos@gmail.com>
 <20210924211139.3477-6-sergio.paracuellos@gmail.com> <CAK8P3a3SpuioCVBfQpHFGuNQoXG7g8w9VL+V8rYd8Q80Od89HA@mail.gmail.com>
 <CAMhs-H8jF10NpTgCP=_FEaBcedTN75b6MoyrEVrrayJEAdufwA@mail.gmail.com> <CAK8P3a0p0YwsiG8NgZGPxGp=GwTLXfEO=D=CY3TtmYwiDSuaXg@mail.gmail.com>
In-Reply-To: <CAK8P3a0p0YwsiG8NgZGPxGp=GwTLXfEO=D=CY3TtmYwiDSuaXg@mail.gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Sat, 25 Sep 2021 22:16:57 +0200
Message-ID: <CAMhs-H9aSNF4qP1HUtwNkA9bhMzErN9jXnscNvbiWSY=kyce2Q@mail.gmail.com>
Subject: Re: [PATCH 5/6] MIPS: implement architecture dependent 'pci_remap_iospace()'
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        gregkh <gregkh@linuxfoundation.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-staging@lists.linux.dev, NeilBrown <neil@brown.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Arnd,

On Sat, Sep 25, 2021 at 9:34 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sat, Sep 25, 2021 at 8:10 PM Sergio Paracuellos
> <sergio.paracuellos@gmail.com> wrote:
> > > It might be good to check that res->start is zero here, otherwise
> > > the io_port_base would be off. That could happen if you ever have more
> > > than one bridge.
> >
> > Do you mean something like the following?
>
> Yes, exactly.
>
> > int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
> > {
> >     unsigned long vaddr;
> >     size_t size;
> >
> >     if (res->start != 0) {
> >          // Should I WARN_ONCE or just show an error/warning message??
> >          WARN_ONCE(1, "resource start must be zero\n");
> >          return -ENODEV;
> >    }
>
> I don't care if it's WARN(), WARN_ONCE() or pr_warn(). If we ever see the
> message, the system is not working and the person who caused the problem
> will figure it out.

Pretty clear, thanks. I will collect you Acked-by's and make this
change and send v3.

Best regards,
    Sergio Paracuellos
>
>         Arnd
