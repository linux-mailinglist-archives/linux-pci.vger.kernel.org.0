Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35F81447EAB
	for <lists+linux-pci@lfdr.de>; Mon,  8 Nov 2021 12:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239155AbhKHLRY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Nov 2021 06:17:24 -0500
Received: from mail-ed1-f43.google.com ([209.85.208.43]:43845 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236429AbhKHLRI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Nov 2021 06:17:08 -0500
Received: by mail-ed1-f43.google.com with SMTP id w1so61198392edd.10;
        Mon, 08 Nov 2021 03:14:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BPhVL69CQa4KX/jm9Ep2I2uQQ68dYD/1kHgu+rp2Osk=;
        b=vvxYtgXAyNpaNYsv62ER/VzyNRTs43aHNWvOWym5ltn8MfSF6OKutUpUsK1Mikvt89
         +sUEtSC1u/doPua4qkiILQca856l4NYYpDvbt0GeYKfKJhLV3hb/TtW2QNh1orO/6cBx
         Q+tuwxldWVbB6tnxh72ry2sBEXjIjIclNnKtcJ8z+3rYENOV3KbLleQEexYtLxNLGTQM
         VGk3h86qnCizeMDwOPIqiZUd2ue2Ao3lQz1ezPTHpUh/Agr9+MUWHfnEOL9pSqnevBWD
         /58/tD1AdQupuvgj3A2SZxD/+0wFhrKl5dUAOp1qXsEqnUC93RaglySnLXq3oseqfyHi
         Jdsg==
X-Gm-Message-State: AOAM531ruliDGKdnUxveWhkEW28mH6b+pND75e0tyZCX/lSz9qV7B342
        1wx1np6hxJ0qEZwgPgAqquA=
X-Google-Smtp-Source: ABdhPJy4k/x5PuDhx64QrWDmEH8mPmicA6mVQJPZpHbxVjmCgYlvdZp+yFxxlf0z+oZqaTOsFPJKMQ==
X-Received: by 2002:a50:d50c:: with SMTP id u12mr106349670edi.118.1636370063477;
        Mon, 08 Nov 2021 03:14:23 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id bi23sm7920499ejb.122.2021.11.08.03.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 03:14:22 -0800 (PST)
Date:   Mon, 8 Nov 2021 12:14:21 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v3] PCI: rcar: Check if device is runtime suspended
 instead of __clk_is_enabled()
Message-ID: <YYkGjeQz2WVbKOP/@rocinante>
References: <20211107191057.145467-1-marek.vasut@gmail.com>
 <CAMuHMdXOBNJcwWVwF-zVgYQ0uezFfRO8ODKAzVExdYV3zH158A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdXOBNJcwWVwF-zVgYQ0uezFfRO8ODKAzVExdYV3zH158A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+CC Adding Sasha for visibiity]

Hi Geert,

[...]
> > Replace __clk_is_enabled() with pm_runtime_suspended(),
> > otherwise the following build error occurs:
> >   arm-linux-gnueabi-ld: drivers/pci/controller/pcie-rcar-host.o: in function `rcar_pcie_aarch32_abort_handler':
> >   pcie-rcar-host.c:(.text+0xdd0): undefined reference to `__clk_is_enabled'
> 
> While this describes what is done and why, it misses one important
> semantic change: the old __clk_is_enabled() actually checked the wrong
> clock (bus clock instead of module clock), while pm_runtime_suspended()
> reflects (a.o.) the state of the module clock.

This looks like it was a latent bug then, something that we might need to
port back to the stable and long-term kernels, I believe.

Thank you, Geert!

	Krzysztof
