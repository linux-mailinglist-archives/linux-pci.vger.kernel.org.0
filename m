Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF48447591
	for <lists+linux-pci@lfdr.de>; Sun,  7 Nov 2021 21:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbhKGUOC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 7 Nov 2021 15:14:02 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:38521 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhKGUOB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 7 Nov 2021 15:14:01 -0500
Received: by mail-ed1-f42.google.com with SMTP id z21so8800867edb.5;
        Sun, 07 Nov 2021 12:11:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lkC8QTPx7W0KudzcgiRkNUFVpiXFHP3aWutEWiq0qHo=;
        b=Bv6jZSTxPNW30cHpFfu+oe743IXBQjnP8WRHK+R1gmSC4kUPXGin4MPMJm6Hduz88F
         heejfqDKBQxq5t/vVgOoedinycFcGnvJnXeljpXf5mXh9bIDrnMe2R7ZUF+2k15iurCZ
         d+ToaMpBpK/MYkQUd9C1FHfnp9JD0nwOsIBLOCuTTdhZzXCcvXO2xJKBhuXZMTuv6Y+r
         2TMj8JorvSo2YvkgdTABrm6wvBHsuwC0JESVuBiEZmIPUuoYozDJBW9p3IlIS+6ErlIx
         u0Zy9q0BnrzngSrz3M9rD16+rUViqG+cu4MAccWirk654z5omoIkJiJDb/uQhFLFeg4O
         GmeA==
X-Gm-Message-State: AOAM530LsJgNpAUfxIq9PKMTwemkN77SOzFaNdtwnsj2T1yXLx9/Bxcf
        KL8Qf4C1ade+AhMn4npFJVC5IhnzJXinQQ==
X-Google-Smtp-Source: ABdhPJzOYNzzl7SNTmNo/AmAIM9DkCv8h+d+L75ZBPcIy05euNJ6hERJyaxuL3mWeDTo1Y/tWGxjTA==
X-Received: by 2002:a05:6402:34d3:: with SMTP id w19mr42625344edc.229.1636315877785;
        Sun, 07 Nov 2021 12:11:17 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id m3sm8244098eds.71.2021.11.07.12.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 12:11:17 -0800 (PST)
Date:   Sun, 7 Nov 2021 21:11:16 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     marek.vasut@gmail.com
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v3] PCI: rcar: Check if device is runtime suspended
 instead of __clk_is_enabled()
Message-ID: <YYgy5EbjcOVuzxzu@rocinante>
References: <20211107191057.145467-1-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211107191057.145467-1-marek.vasut@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+CC Randy as he sent a patch to fix the same thing]

Hi Marek,

> Replace __clk_is_enabled() with pm_runtime_suspended(),
> otherwise the following build error occurs:
>   arm-linux-gnueabi-ld: drivers/pci/controller/pcie-rcar-host.o: in function `rcar_pcie_aarch32_abort_handler':
>   pcie-rcar-host.c:(.text+0xdd0): undefined reference to `__clk_is_enabled'
> 
> Fixes: a115b1bd3af0 ("PCI: rcar: Add L1 link state fix into data abort hook")

Randy sent a patch which aims to fix the same issue, albeit in a slightly
different way.  I wonder if it would make sense for the two of you to look
at which approach should we pick, or even whether we should combine the
two into one patch?

  https://lore.kernel.org/linux-pci/20211107013703.19995-1-rdunlap@infradead.org/

	Krzysztof
