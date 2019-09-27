Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEC37C020D
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2019 11:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbfI0JRS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Sep 2019 05:17:18 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41125 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfI0JRS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Sep 2019 05:17:18 -0400
Received: by mail-ot1-f68.google.com with SMTP id g13so1637967otp.8;
        Fri, 27 Sep 2019 02:17:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3+QY+V36AacojxG/0XQzOM0qGjwlQNtKmC40kmfrXyA=;
        b=VEr3uS+g607rS38Ireixl1RUsos0JTvkxzPM33/QUyqOgYJaJm0d6YoE0bcEbLyr00
         iHGJjzYf5Wii0z/6QLYSMs47F0mEtyarcsB9dTo3pQ0vAKWNZtTAAifpeS+Nz3qR84kM
         ov6nguNRET3YrcHVg1zw4DUpWEwRBZC5ShvnVBFJRrOyevMniCDRMpEFbQGPUtY0ETux
         SKPMxkdh8XExlWBEWpSDA1zSGGbgSTebs45IYROtcj2rm1U+MU2qHdouzHD99M//O4SZ
         9j3dxdy5l4SxoRBeof2k9btqNGZk8RyXxvNnl3vX7ipVmqnckAcv0XeFGXieiC48BXeg
         nEAA==
X-Gm-Message-State: APjAAAUCcOGrsVOhk6byTcyIAoWoCrKcAGlRUJqRNedg/q58hiTyp7j/
        cZ0McHt0A1o6zYNb1Ivg1ND19dlW2bpeYwfQX3o=
X-Google-Smtp-Source: APXvYqxpPf7tCldKfOBJDzwGiyRfjj2zWIOfYmy8OxVjpBvmQqIYxglyIQUEnniPwSyamhz/Xmsma9UWW6oCJBnwO8s=
X-Received: by 2002:a9d:404d:: with SMTP id o13mr2414433oti.39.1569575837231;
 Fri, 27 Sep 2019 02:17:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190927002455.13169-1-robh@kernel.org> <20190927002455.13169-2-robh@kernel.org>
In-Reply-To: <20190927002455.13169-2-robh@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 27 Sep 2019 11:17:06 +0200
Message-ID: <CAMuHMdX++iEaib2c9hptqeQH60dsx-pCEWCZVtirAAkvW5v51A@mail.gmail.com>
Subject: Re: [PATCH 01/11] of: Remove unused of_find_matching_node_by_address()
To:     Rob Herring <robh@kernel.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Frank Rowand <frowand.list@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Marek Vasut <marek.vasut@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Oza Pawandeep <oza.oza@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 27, 2019 at 2:25 AM Rob Herring <robh@kernel.org> wrote:
> of_find_matching_node_by_address() is unused, so remove it.
>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
