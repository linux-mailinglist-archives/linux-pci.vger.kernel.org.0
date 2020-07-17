Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3519722354B
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jul 2020 09:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgGQHSS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jul 2020 03:18:18 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37199 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgGQHSS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jul 2020 03:18:18 -0400
Received: by mail-oi1-f195.google.com with SMTP id 12so7270519oir.4;
        Fri, 17 Jul 2020 00:18:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a5hTKsShr1r3N7ckghpJVGyfr7q/TFPmmyprZtIxXpA=;
        b=UlNfzIWCZAOyLy0eE6A9t2GfjZVT3oCCOPAx2qCb+ld7moJ9NFw6Ryw/j8cqEKBUMB
         oVItLNwIHjzTdQT77Rk5bXWLovd9Ms9uM9o27D6iraI/qxaDdT7uBahhPpIN8AJKVpII
         lHDSEplnbdVpDJO0MRJmYli7hvrcxjUm8CKnpav2XVrGYMs/vShrvsMS7lBPdeL+aK22
         34bekdSMHV+snBg6d6T/c4Khbv/tQYm0qHmVaM9GX973RUxlJ3ItY/DJbpyM33zFPhVS
         515MPt0ZbtSINxub67tPi6k3LowcqWWyaFDqhEAH/nTb7a/9jGhbWzYsKjbRGCDBVSST
         FxNw==
X-Gm-Message-State: AOAM533lzcQq8iJssfQQm49vLbvBpZAsn64H1LFb2lK2M0HtxQx4zIYb
        BqYBc2EIjrQ+QbfSH4aC4Qi7oFMVlunOsOOd2H8=
X-Google-Smtp-Source: ABdhPJxlyTHAAuX2MIEk8itC1oT3cHf7n9+SAmrvOegCDH4dUIhUmVSg+H3YLLWpUP0fnB5/i4BOHOfR15M/I5rhJjw=
X-Received: by 2002:aca:ac10:: with SMTP id v16mr6263830oie.153.1594970296950;
 Fri, 17 Jul 2020 00:18:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200716211517.GA17174@embeddedor>
In-Reply-To: <20200716211517.GA17174@embeddedor>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 17 Jul 2020 09:18:06 +0200
Message-ID: <CAMuHMdU7p6wY3vzV2mRzWrvn_nDuJBFVtc5QK-mLQ7kJbm1HqA@mail.gmail.com>
Subject: Re: [PATCH][next] PCI: rcar-gen2: Use fallthrough pseudo-keyword
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Gustavo,

Thanks for your patch!

On Thu, Jul 16, 2020 at 11:11 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
> Replace the existing /* fall through */ comments and its variants with
> the new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
> fall-through markings when it is the case.

Which unnecessary marking is being removed?
I don't see any.

>
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through
>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

For the actual patch contents:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
