Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01D4ACE06D
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2019 13:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfJGL2T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Oct 2019 07:28:19 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34216 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbfJGL2T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Oct 2019 07:28:19 -0400
Received: by mail-ot1-f65.google.com with SMTP id m19so10658458otp.1;
        Mon, 07 Oct 2019 04:28:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YGcJhb6FO7h8bn0PN5g5/J7rHhn/sRHebhA5vRwhP50=;
        b=XN0q1E4lL9YQ1kXkK2qHXTpb22Byt71COB3wGUo4R7/RWCajM1NR2o1hz3GSgddfzg
         /eTKexKRdtRAbKwSoyqSpBYtRKQePfASBDVYw+FYOlghaDI/QnjD+f1Tk7uqQVM6Llby
         KGvmAt4U4Afm9fIxG/khZGX17jyeLp2FTVNqrUWaAC9Toux2zaHUd0v6QXP8k+adBtgl
         PgW+x76qt96fEC7tRlQX71A+UEVlsbZ6IFid4J21S48Gm61MGgYtT9exLjGbwmYvCbse
         De0roIaveDXhHurw6if0LgXSVyw1UDcXB/y8CcHQ/mpkksAoqQa70jhl+L/+p3DkiPbu
         p69w==
X-Gm-Message-State: APjAAAXfwzzFk3JkX5TidDFzVs0igMrt4wWXbpCW9n3EYZQg655Y6Z6B
        Kqo5N3QmTJuSI88Q4+74JSTneojxO8RFf67fojE=
X-Google-Smtp-Source: APXvYqzBmHfKFvtECJeRY00loEdXqitWnoyqdj/RbKBpWfpOLrsCGcp97jTNyPA9J7qD+wBBhYzkoxrSfHwjweI4Dgs=
X-Received: by 2002:a9d:6642:: with SMTP id q2mr20514624otm.250.1570447698307;
 Mon, 07 Oct 2019 04:28:18 -0700 (PDT)
MIME-Version: 1.0
References: <1570178133-21532-1-git-send-email-fabrizio.castro@bp.renesas.com> <1570178133-21532-2-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1570178133-21532-2-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Oct 2019 13:28:07 +0200
Message-ID: <CAMuHMdUJZGYCSV2SSqJ4BOUfP08ML+gz4_UkOx7nKqCj+vHwXg@mail.gmail.com>
Subject: Re: [PATCH 1/7] dt-bindings: watchdog: renesas-wdt: Document r8a774b1 support
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>, xu_shunji@hoperun.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 4, 2019 at 10:35 AM Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> RZ/G2N (a.k.a. R8A774B1) watchdog implementation is compatible
> with R-Car Gen3, therefore add the relevant documentation.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
