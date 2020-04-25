Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 701781B84EF
	for <lists+linux-pci@lfdr.de>; Sat, 25 Apr 2020 10:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgDYIze (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Apr 2020 04:55:34 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39901 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgDYIzd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Apr 2020 04:55:33 -0400
Received: by mail-ot1-f66.google.com with SMTP id m13so16860922otf.6;
        Sat, 25 Apr 2020 01:55:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fUNW+YKfBgF2cMYUf1i6dEQvTH/58EF1lzSQEW40U3k=;
        b=Djwi/xu+B1tUwewBH9MplPbDjGN3W5mnFcBM8jitCCD4uIQl4t255pyBOSBDwPYbo6
         ySP91oAe7a8DcfjJz0bRlfq6GIx4W3WZguKQbuSYKBW49Hfjrppws6QF9dLq68jNw3LM
         /CqDjYuO5A9m0Me5B9lps4sxVxMqT9M8N9J/z3w2PcVSyqdb2hkp6owRqP/23u+JnIhJ
         qlKRn0FgSsV3ZztZGQsSNqdYDIeWD/ctLf28LEIDqlw3HGDTjQFku3EO7eSonKWucekt
         a2XVC95wedllY+QTY7/f5tAD6dMSygD1xE1IEk4JWkVXPFQPffymnJtPR3o+fceGHMRE
         WLjA==
X-Gm-Message-State: AGi0PuZMaGgKHBD63us/ENLpGDBhYO48MCW0Bi9VCjZ79Q5BmeJaMEjv
        mW/GVUY5NZmdiDtWUD+6IHk6Vd3+bexL2pNPN5k=
X-Google-Smtp-Source: APiQypJW5O56mWteY8Y0vMM8aMxAGMjECnsP5wKPZkmXBXqkKVaISEG8Z+bkk71DRSaQBqd6D1kBf0TvUnpAMUX91+o=
X-Received: by 2002:a9d:7990:: with SMTP id h16mr5250454otm.145.1587804932826;
 Sat, 25 Apr 2020 01:55:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200314191232.3122290-1-marek.vasut@gmail.com> <20200424195724.GA187563@google.com>
In-Reply-To: <20200424195724.GA187563@google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 25 Apr 2020 10:55:21 +0200
Message-ID: <CAMuHMdVGkM_-5q+pSOtQ5nBPGzMeOpRTJUqekYnvjiPMFepqLw@mail.gmail.com>
Subject: Re: [PATCH V3] PCI: rcar: Add the suspend/resume for pcie-rcar driver
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>,
        Gaku Inami <gaku.inami.xw@bp.renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Fri, Apr 24, 2020 at 9:57 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> [+cc Vaibhav]
>
> Alternate less redundant subject:
>
>   PCI: rcar: Add suspend/resume support

Note that there's both pcie-rcar.c (this driver, for R-Car Gen2 and Gen3
PCIe) and pci-rcar-gen2.c (for R-Car Gen2 PCI).
People tend to use the prefix "PCI: rcar: " for both :-(

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
