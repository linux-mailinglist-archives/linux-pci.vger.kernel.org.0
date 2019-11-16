Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60F3CFF4C3
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2019 19:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfKPSgf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Nov 2019 13:36:35 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:39230 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbfKPSgf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Nov 2019 13:36:35 -0500
Received: by mail-oi1-f173.google.com with SMTP id v138so11632013oif.6
        for <linux-pci@vger.kernel.org>; Sat, 16 Nov 2019 10:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AOmrThji9Q7H47RLN/b1XQT/DfdTB1t/udS8Cx6mkyY=;
        b=L/WH2U0uPgEifTMDabScmgbfcvqiO4zNc4yLW2+5Dz7gum2gWl90mzlYEiMYMpqOnX
         xh/45g3QHM+uciXhudArSfJdsJcBWYdOcp9tsvGVmX10dR4dVyozXmx30jCHfVlwb9LJ
         LFwq4iF6W5pB7JTkERXPGsH/4zU8PXf3tBjhoXomAKHhVVnM9IEB95lKI9sPbgiHyUV8
         vGXWOyd1Btqzhx71R6sCr2a6uTqQ5AIIKAJlrpjhO7QnZHN416ss3MbGM0a+5sQxTrU7
         oDMTGlq4w3/ttAdp0m+ETm6Psaa5z8QhwEtfng8ksNdeJiOXLb0azJEhxySmyNRRgYB/
         WrRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AOmrThji9Q7H47RLN/b1XQT/DfdTB1t/udS8Cx6mkyY=;
        b=tS4fBljOMiFPEnZ7jRpKOIDyI+7TWwp3vBEtLgLXGGNNoVo9tePYoRUnwjpCRcIapU
         6N6sa5Aw9aKUl6fvhirzhEFG3QMOgr1xL52B3skhRO4lXxvZzy0KAoOAlHj6dgQPczjG
         JyFppd6c2FnNZjfkfdCj+pPhtwxPe9I5ZU1IuBumsnm8Bjn2oI9jfcSuPgyHzx02JCA6
         Ag+m69eEr/S6hL6R/TWieR2saBY4cBcJRxFEpogVSwMVfpHYQyXD+ofE5iMAfyUi2P+Z
         DRr5ERkdf41A/VN0LNZY/KR7ccX4036JbArYeG0Jux2obPzlO7+LyRWv7yzfGKpTQRHs
         Oeow==
X-Gm-Message-State: APjAAAXBOxN32bTCqi6pa+mhVLMaY26vl2NZIkaxdFEX7MUE7FouDuIE
        OkElfHSznBCSGtfGAZqcF8Xxp9S5fajGU1YMSYjOzgvj8o8=
X-Google-Smtp-Source: APXvYqyUV8AQwozvYzumG7fMkP41k+EEbb26v/kN3g0fvgtF3GFgAINBbWrrMP7SudKZt39TyUDnsEQxZoJ9TgqLijA=
X-Received: by 2002:aca:c508:: with SMTP id v8mr12805940oif.31.1573929394010;
 Sat, 16 Nov 2019 10:36:34 -0800 (PST)
MIME-Version: 1.0
References: <CAHhAz+j+pN3fy_9NTBBchuz_X1a-FQK0Lt8ty3sk3qkufH7KYQ@mail.gmail.com>
 <20191114191750.GA230106@google.com>
In-Reply-To: <20191114191750.GA230106@google.com>
From:   Muni Sekhar <munisekharrms@gmail.com>
Date:   Sun, 17 Nov 2019 00:06:21 +0530
Message-ID: <CAHhAz+hLm9gY-bS-a84Vdo94vm1iNMqEeScY_+e1x0wTy_AMsA@mail.gmail.com>
Subject: Re: Question about pci_alloc_consistent() return address
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 15, 2019 at 12:47 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Christoph]
>
> On Thu, Nov 14, 2019 at 02:21:21PM +0530, Muni Sekhar wrote:
> >  I=E2=80=99m using pci_alloc_consistent() in PCIe driver. My PCIe devic=
e only
> > works 64 bit data  boundary transactions.
> >
> > Is there a way to make sure pci_alloc_consistent() always returns
> > 64-bit aligned address?
>
> See Documentation/DMA-API-HOWTO.txt.  pci_alloc_consistent() is
> implemented in terms of dma_alloc_coherent(), and that doc says
> regions returned from dma_alloc_coherent() are guaranteed to be at
> least PAGE_SIZE-aligned.
>
> Are you seeing otherwise, or are you just making sure?  The dma_pool
> interface for allocating smaller regions has a way to request the
> alignment you need.
Thanks for the clarification. I just want to make sure that
pci_alloc_consistent() returns 64-bit aligned address.
>
> Bjorn



--=20
Thanks,
Sekhar
