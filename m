Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 719272B0B0D
	for <lists+linux-pci@lfdr.de>; Thu, 12 Nov 2020 18:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgKLRNb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Nov 2020 12:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbgKLRNb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Nov 2020 12:13:31 -0500
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5056FC0613D1
        for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2020 09:13:31 -0800 (PST)
Received: by mail-oo1-xc43.google.com with SMTP id i13so1478064oou.11
        for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2020 09:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EeXN02X4gtavN8SDSAXEmGeRiStK8SgOgNbvSY62whg=;
        b=WFxXjv4djQq3QqcrawRswlquZovgS+mudUGlVMQn3wmucJ90owCA6lTvpyRNHEPfvw
         lI4PUPQqQClWQNSBoZd9lwfCcRLXLeBP4U+neRzllH7TQUOgQoPBrIsomMK2oTfVS0SH
         UoB9XzrmeFoVukB+kHRkNge6IedE25zAhkNb7H+0CoE4qdS270BU9GKdfhBFa+ctNiY5
         5Cn7QFLzCRwdKD0kLwdM1vzS2Y+D22EBVGZoABdCBoflAmiJWTuTzbvXrBfn2N0D5UEr
         ku1RSnL9urzKMLNm49MOU/7nvXti4g87UzwnvJGxH1xGnht6Fu+/mrhm5H7nMnIO4UZz
         QA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EeXN02X4gtavN8SDSAXEmGeRiStK8SgOgNbvSY62whg=;
        b=UFw+W3dCYMcgI8cVf7N/Yldc8kB9RwZyxLYK+i3jCK47MZ1C8CkA8M7ZfPpwD+pE7/
         I5X5Kp8j6ftM4KZcm3hi0qmU4md1EJjHSBZck9YUlpD5GR5xF0dgplQ07PajegWfIafG
         Fk0PnY9HkQKJMupFxFJvKdYP6x8xjhyGfkSanbzJQmJ0mYhM6I8Lw3SrKVEfosVpdXHm
         mWLpP4+4yQixpVO+CGOkXC9iFpbnYamgbJtMdHzXpsmVasD34SuhwrUtUJLrXEOeW4zl
         bFpaC6kB/JjNxF5KOo5+YrIElFiMu7P8Wb79bPZkzcWEOhNQlBjtKsjfvQZmMCgWiGXJ
         LTNA==
X-Gm-Message-State: AOAM532X4hqqXPjLqE+6d8gG3jKljVG0zj4+SjnQaxHA+PsazxChLKWE
        8SyZ9M3nZZNwjhBQLRWlJDdPf+hcm1uBcbV9OVYb1w==
X-Google-Smtp-Source: ABdhPJxbOrT0vEW8dUaUzDWY7ogeIBcnMnXlZ79eFK54xjRyu0iK8z0DMWsIbfX7rvrsU2KtWIm4NzX2dhf+n0u4c/w=
X-Received: by 2002:a4a:5557:: with SMTP id e84mr191238oob.75.1605201210776;
 Thu, 12 Nov 2020 09:13:30 -0800 (PST)
MIME-Version: 1.0
References: <20201112131400.3775119-1-phil@raspberrypi.com>
 <883066bd-2a0c-f0d8-c556-7df0e73f0503@gmail.com> <CA+-6iNxc9UiEqFXj4jMJRXW1XAS7aB4hANa7mHRsK8++t2A18A@mail.gmail.com>
 <CAMEGJJ12UT5KN6G2-xZ4oHn4Dpj=_k77DW=Hb324HYabUyw4pg@mail.gmail.com> <20201112164705.GA20154@wunner.de>
In-Reply-To: <20201112164705.GA20154@wunner.de>
From:   Phil Elwell <phil@raspberrypi.com>
Date:   Thu, 12 Nov 2020 17:13:20 +0000
Message-ID: <CAMEGJJ2vB20LW=UwKOEQF8C_coSUQdLKk4ezTh7JDTrsKKSDcw@mail.gmail.com>
Subject: Re: [PATCH] PCI: brcmstb: Restore initial fundamental reset
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Jim Quinlan <james.quinlan@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh@kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 12 Nov 2020 at 16:47, Lukas Wunner <lukas@wunner.de> wrote:
>
> On Thu, Nov 12, 2020 at 04:42:28PM +0000, Phil Elwell wrote:
> > On Thu, 12 Nov 2020 at 16:28, Jim Quinlan <james.quinlan@broadcom.com> wrote:
> > > As for me considering that  this line is superfluous -- which
> > > apparently it is not : AFAIK PERST# is always asserted from cold start
> > > on all Brcm STB SOCs, and I expected the same on the RPi.  Asserting
> > > PERST# at this point in time should be a no-op.  Is this not the case?
> >
> > The reason it isn't superfluous here is that when using USB to boot,
> > the Raspberry Pi BCM2711 firmware will already have configured the
> > PCIe bus once, so another reset is necessary.
>
> I think that begs the question why the firmware doesn't reset the
> PCIe bus before handing over control to the kernel?

Are you advocating removing all resets that merely reapply the
power-on reset state?

Phil
