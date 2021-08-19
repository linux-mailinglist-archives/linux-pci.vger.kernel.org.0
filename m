Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9553E3F1334
	for <lists+linux-pci@lfdr.de>; Thu, 19 Aug 2021 08:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhHSGT6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Aug 2021 02:19:58 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:58170
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230390AbhHSGT4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Aug 2021 02:19:56 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id B2C3F411F2
        for <linux-pci@vger.kernel.org>; Thu, 19 Aug 2021 06:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629353959;
        bh=qEtVTiJin9b0M1DkYv8DcnGnIW+RsIPC9ADG4dJnT4o=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=N3xhBs+49++GdAMSJ8xlhr5Xzp+Rr+aoUebyVTv2OTbwGRYj33wGlrWZxmlu0AIoj
         8ffxay1E8CObjcUXT1mDCnStOo4ICq0Pq6ptz3n48oiVXkmYmPIawKC6gqOwkyeGjo
         +9WDvScWkVndFdiZYT2I9FibWg7s6zXI5w3H81dEuz0ilkxj/tlq5Z80urnh2uV6mR
         J4BOXDpMCH2c59ZbHRr290Htg2LhK8xGywB3V/2ubmRBYI7kLti26Ma03swvOu224k
         ir8n7QaqWdgPvc68uzSI9mgH5Q0rC5IilVr/dnBqa7m24ufNO8g+PJYv2mbcZZH3RV
         on2pgl6DQJ8+A==
Received: by mail-ed1-f70.google.com with SMTP id ec47-20020a0564020d6fb02903be5e0a8cd2so2303188edb.0
        for <linux-pci@vger.kernel.org>; Wed, 18 Aug 2021 23:19:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qEtVTiJin9b0M1DkYv8DcnGnIW+RsIPC9ADG4dJnT4o=;
        b=JsufrpzQtkyT3RHf4Dt9PgYN3azXwSFD7V3qWlS653FTQAQ9xsgXdmE45VENPn15o2
         7apKk2FFWjM6f/NFYsmfxCiPC/Suiq8xMeS2AzjkGzcd8Sm+ZK08lcwds6HqmHUalcUB
         0ovRcBim1uk8I0EDGD3gbOhT1Cg4kU223PlLLCrBdZp7Ymta1ps7vu7ndohXMYWWSOIt
         EsrvZUeWdqjPfgkUFLUY9p6YW1JZp09eZTkUgekKg99AAnTQAYDSlrtdYVxoZ6jTJZxG
         UGgJywTi5AsWmYuy5BUofSTlm20WhzDksogNG0zvxlCTsBH5S56z9gPpYvhnvEIrWnX5
         n9jQ==
X-Gm-Message-State: AOAM532q+TZFdOXmqHI5PKpsCl9xKDQLnOIMfm9ovZjUorunweVwGBKb
        c0dicLMKQwS+sTsUUOsRbKHVCTYh7UXI4lZs7s7f9tSxge9OCqYhaaP+ip+QcQI1C8VTgZkmYw2
        GYeYHTN8lPF0/z6fOoGz7jNgg56oSFiWYw9J6LRbYo3+/BMkrm5Q7Hw==
X-Received: by 2002:a05:6402:b64:: with SMTP id cb4mr14429981edb.49.1629353959257;
        Wed, 18 Aug 2021 23:19:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6uek5wW3YjQA4vSSYLJiAy5IA1O6J/ytxuGPYxDhJKHP7TDdnXrrE69RuJ6b7u6FD00XjM9NEQEB7GNyNEXw=
X-Received: by 2002:a05:6402:b64:: with SMTP id cb4mr14429958edb.49.1629353959017;
 Wed, 18 Aug 2021 23:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210819054542.608745-1-kai.heng.feng@canonical.com> <b14bc147-d39c-6f55-cc0e-7b2de92d23b1@gmail.com>
In-Reply-To: <b14bc147-d39c-6f55-cc0e-7b2de92d23b1@gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 19 Aug 2021 14:19:07 +0800
Message-ID: <CAAd53p5Fu+x9M0fAta4k-8mja4Bxybhcg9veut4v7TVFZrD_aQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/3] r8169: Implement dynamic ASPM mechanism
 for recent 1.0/2.5Gbps Realtek NICs
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     nic_swsd <nic_swsd@realtek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Linux Netdev List <netdev@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 19, 2021 at 2:08 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> On 19.08.2021 07:45, Kai-Heng Feng wrote:
> > The latest Realtek vendor driver and its Windows driver implements a
> > feature called "dynamic ASPM" which can improve performance on it's
> > ethernet NICs.
> >
> This statement would need a proof. Which performance improvement
> did you measure? And why should performance improve?

It means what patch 1/3 fixes...

> On mainline ASPM is disabled, therefore I don't think we can see
> a performance improvement. More the opposite in the scenario
> I described: If traffic starts and there's a congestion in the chip,
> then it may take a second until ASPM gets disabled. This may hit
> performance.

OK. We can know if the 1 sec interval is enough once it's deployed in the wild.

>
> > Heiner Kallweit pointed out the potential root cause can be that the
> > buffer is to small for its ASPM exit latency.
> >
> > So bring the dynamic ASPM to r8169 so we can have both nice performance
> > and powersaving at the same time.
> >
> > v2:
> > https://lore.kernel.org/netdev/20210812155341.817031-1-kai.heng.feng@canonical.com/
> >
> > v1:
> > https://lore.kernel.org/netdev/20210803152823.515849-1-kai.heng.feng@canonical.com/
> >
> > Kai-Heng Feng (3):
> >   r8169: Implement dynamic ASPM mechanism
> >   PCI/ASPM: Introduce a new helper to report ASPM support status
> >   r8169: Enable ASPM for selected NICs
> >
> >  drivers/net/ethernet/realtek/r8169_main.c | 69 ++++++++++++++++++++---
> >  drivers/pci/pcie/aspm.c                   | 11 ++++
> >  include/linux/pci.h                       |  2 +
> >  3 files changed, 74 insertions(+), 8 deletions(-)
> >
> This series is meant for your downstream kernel only, and posted here to
> get feedback. Therefore it should be annotated as RFC, not that it gets
> applied accidentally.

Noted. Will annotate in next version.

Kai-Heng
