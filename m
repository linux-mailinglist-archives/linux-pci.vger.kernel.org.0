Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85BFB2868AF
	for <lists+linux-pci@lfdr.de>; Wed,  7 Oct 2020 21:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgJGT5N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Oct 2020 15:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgJGT5M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Oct 2020 15:57:12 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7BFC061755;
        Wed,  7 Oct 2020 12:57:12 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id l16so3480950eds.3;
        Wed, 07 Oct 2020 12:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sCX0hq+XuxufT3VeoStS9axc1XX2PpMzIg52Vhhxc6Y=;
        b=nlOUyb1rm/6hWJgoU3NLOD5Kg2a2eWIT+Q5tSJ/TWVvAuzwgIs+NV/mIN12jDZJd9H
         3JYt32rrwyjk2RwYihrcekpaH78oEqr1yaxdF0SOb8gAnLHL6RpKZ3EIlXkYxxB8nnKX
         keb6BKs/Jl6MT0HQg2xKoHzAwo+zFZVBtuhdqMC5Znz4NRtQpFLjiv0JG2PFnbaaiiLU
         MWNtwZJxSBbOmtgt7YNfwDVvHV1odYigvAiHwYmZNEMnuNISUPHj1zA0wWf6O/5meSlf
         HfzBDuCBR7W13UP0fI9eU8TwgvQ5Ft1s6waiE+rMJDLA9n/ehXcNXCaij46gPwi+hBUp
         MEbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sCX0hq+XuxufT3VeoStS9axc1XX2PpMzIg52Vhhxc6Y=;
        b=WtuI3pZOVmwaOJtnRa8a8KYWOeyfaSeOSrVfHHrMQ82zTahMu9ZiayC5zu84LBCYyy
         JWk+gIldBZ+ffm1QXqs6YG+whVLdoLzDp+kKjbcLW0HGlwBwqd7y9z2JJruAeINvFpPD
         /l+1M9RwU+IgS6v5oYgkXhwy4IHTBocsh3XuoRHZGcPDahElSNIQeIy+1fNKLcMN6clS
         VYzV2ewLIr4HsdRKZ/5Sz12Tx/v6iM847+BEuRXm7hs46emk0izVye5IIwMA/DLmQkS0
         K2GfxgxS91X4N6Uz6ku8h92MksJceiU2twLHosX7eT8HOhhnbQ8P1NqnT2dT/gubn16b
         nypA==
X-Gm-Message-State: AOAM532Z0KgAg+h7sQ7UqRnfAJwtHMRmDRyBVuz1CFIpNuVwn5jFoTSH
        IJwwHgSHFQN8UbTLp4nhzav9YM/F9D4RrHP22K1n02bs
X-Google-Smtp-Source: ABdhPJxc5PjfedVHpNhxbEXbY8KuEbNtzijHc/GC4lk/bSAFFEQONwV14kvvUiFrVXXSFp2T6lo5tZskYEJAZDKTkAs=
X-Received: by 2002:aa7:c683:: with SMTP id n3mr5227470edq.146.1602100631033;
 Wed, 07 Oct 2020 12:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <20201004162908.3216898-1-martin.blumenstingl@googlemail.com>
 <20201004162908.3216898-3-martin.blumenstingl@googlemail.com> <20201006212502.GA2866970@bogus>
In-Reply-To: <20201006212502.GA2866970@bogus>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 7 Oct 2020 21:57:00 +0200
Message-ID: <CAFBinCBtHANer=kN70CVgcseB0g5QauNSN+mv0gjSFPk_HOmQg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] dt-bindings: gpio: Add binding documentation for
 Etron EJ168/EJ188/EJ198
To:     Rob Herring <robh@kernel.org>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, bgolaszewski@baylibre.com,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On Tue, Oct 6, 2020 at 11:25 PM Rob Herring <robh@kernel.org> wrote:
[...]
> > +examples:
> > +  - |
> > +      pcie {
> > +        #address-cells = <3>;
> > +        #size-cells = <2>;
> > +
> > +        gpio@0,0,0 {
> > +          compatible = "pci1b6f,7023";
> > +          reg = <0x0 0x0 0x0 0x0 0x1000>;
> > +          gpio-controller;
> > +          #gpio-cells = <2>;
> > +        };
>
> How would this look if you needed to describe the XHCI controller?
> That's another PCI function?
unfortunately I have no documentation about this
the "reference driver" is poking the PCI config space registers of the
xHCI controller - without any dedicated function for this


Best regards,
Martin
