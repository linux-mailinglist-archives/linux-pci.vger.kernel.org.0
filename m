Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0802444764F
	for <lists+linux-pci@lfdr.de>; Sun,  7 Nov 2021 23:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236608AbhKGWgL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 7 Nov 2021 17:36:11 -0500
Received: from mail-lf1-f54.google.com ([209.85.167.54]:43990 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234833AbhKGWgL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 7 Nov 2021 17:36:11 -0500
Received: by mail-lf1-f54.google.com with SMTP id b40so2621521lfv.10;
        Sun, 07 Nov 2021 14:33:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TcOnjusgh26WRRygIELm5rEJNqqciEbrMWW+wpZH2YQ=;
        b=dQDaExH3wGpqpzJXcS5mYcFKs4VQg2eLLP/8abaF453BGupWqLpFdxoSMFt3hRZGUo
         762Ohom0u/AnJAHllyAJOX0WTtnuimBo+0IwV2KVDUA2HNiWs87ll1JNXcTZdcB3m00t
         dioY3eKQS42IgyVfAq2SgEySKsuLBK2/GuN1yCkF0dlXh6/QpEJxz4hh+jMxMdLSEZf/
         2H//G1LigOtkgCpeGpwVAlZ6JJ3vlzGCyzjRAVn0K7E/LDE/SWr+cHWvoA1DDmK5oLVU
         IQ8PO6EDP9G1WHDENcYO0xEq5qMyG7zx1DvayMoqc2HdZqDdyS+BFqYHY/ovLzc8X2v8
         qsyw==
X-Gm-Message-State: AOAM532qceJFbnR3BJS0v7RCXK4y5hjnu+JAGTGNkufmJ0947im1mNgE
        qFyhJjDhsZaTy2zRuXTzVNs=
X-Google-Smtp-Source: ABdhPJzlmG70iXy2dF/h7jB9af/pURZnvY8IWZIv2ofdCRAf7IDnnQyVMQgndAvyD4RskBg7yGP+Qw==
X-Received: by 2002:ac2:5d4a:: with SMTP id w10mr68127082lfd.584.1636324406811;
        Sun, 07 Nov 2021 14:33:26 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id w15sm49383lfe.245.2021.11.07.14.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 14:33:26 -0800 (PST)
Date:   Sun, 7 Nov 2021 23:33:24 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     marek.vasut@gmail.com, linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3] PCI: rcar: Check if device is runtime suspended
 instead of __clk_is_enabled()
Message-ID: <YYhUNBkCBpNwnjxz@rocinante>
References: <20211107191057.145467-1-marek.vasut@gmail.com>
 <YYgy5EbjcOVuzxzu@rocinante>
 <5c7d3591-4f9e-1598-8bfc-179c5049c379@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5c7d3591-4f9e-1598-8bfc-179c5049c379@infradead.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Randy,

[...]
> > Randy sent a patch which aims to fix the same issue, albeit in a slightly
> > different way.  I wonder if it would make sense for the two of you to look
> > at which approach should we pick, or even whether we should combine the
> > two into one patch?
> > 
> >    https://lore.kernel.org/linux-pci/20211107013703.19995-1-rdunlap@infradead.org/
> 
> Hi,
> I saw Marek's patch a couple of hours ago.
> 
> As long as pm_runtime_suspended() is always available,
> either live or as a stub (and it looks like it is),
> I don't see any reason for my patch at all.

Understood!  I marked it accordingly in Patchwok.  Thank you both!

By the way, can I count on your Acked-by or Reviewed-by here for Marek?  If
you agree with the premise of the changes here, etc., of course.

	Krzysztof
