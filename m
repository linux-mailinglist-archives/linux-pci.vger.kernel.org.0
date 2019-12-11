Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B83BA11BD18
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2019 20:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfLKTeO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Dec 2019 14:34:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:37992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbfLKTeO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Dec 2019 14:34:14 -0500
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A537D2173E;
        Wed, 11 Dec 2019 19:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576092853;
        bh=pk5mlVjD1gbfWi7be4kCl2yXmTdkckNMVaeV/EJ2Yf4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VtLfOchvvNRkPdkAqsM38NCeJFhkESnhs8pf82brAqT1xvbmo2yUupNjDThtfolE6
         +2mRg0RtyyhHx9+D5H7iQeg+i/+uu5+PxOEN+/uZQEasKXl6nPETpgi2cKoNI1MAc/
         grmWRhAKhV9qFb6xT1lTH9/xMwTpf9jPWKbdJebk=
Received: by mail-qt1-f174.google.com with SMTP id 38so7275066qtb.13;
        Wed, 11 Dec 2019 11:34:13 -0800 (PST)
X-Gm-Message-State: APjAAAUcMhkJL/TiEQ8wOvBSmJzIwSFGwY1+9aodNts6dDEXw5PWrPjf
        M8PWPpeo+CXSs9XaCXQGC9Yvm5Cdbzx4t6UXKg==
X-Google-Smtp-Source: APXvYqzgnGxu26F0CkZ7oMwgc8p9WduBrS9LANuxGEAK9qlyhrHXv1vndLPtfkakVtGDf8ibnUqcrmXE5QSpRPIx278=
X-Received: by 2002:ac8:59:: with SMTP id i25mr4308140qtg.110.1576092852765;
 Wed, 11 Dec 2019 11:34:12 -0800 (PST)
MIME-Version: 1.0
References: <20191211161808.7566-1-andrew.murray@arm.com> <20191211165855.kfoz2x63kw3gnlmm@localhost>
In-Reply-To: <20191211165855.kfoz2x63kw3gnlmm@localhost>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 11 Dec 2019 13:33:37 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJnLF9A9GoqNgwBebb8gWbCUo7txiAX2Q56cfyYvMjhVQ@mail.gmail.com>
Message-ID: <CAL_JsqJnLF9A9GoqNgwBebb8gWbCUo7txiAX2Q56cfyYvMjhVQ@mail.gmail.com>
Subject: Re: [GIT PULL] PCI: dt: Remove magic numbers for legacy PCI IRQ interrupts
To:     Olof Johansson <olof@lixom.net>
Cc:     Andrew Murray <andrew.murray@arm.com>, soc@kernel.org,
        devicetree@vger.kernel.org, PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 11, 2019 at 10:59 AM Olof Johansson <olof@lixom.net> wrote:
>
> On Wed, Dec 11, 2019 at 04:18:08PM +0000, Andrew Murray wrote:
> > Hi Arnd,
> >
> > Please consider this pull request.
> >
> > The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:
> >
> >   Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)
> >
> > are available in the Git repository at:
> >
> >   git://linux-arm.org/linux-am.git tags/pci-dt-intx-defines-5.5-rc1
> >
> > for you to fetch changes up to d50e85b9ad3d4287ab3c5108b7b36ad4fd50e5b4:
> >
> >   dt-bindings: PCI: Use IRQ flags for legacy PCI IRQ interrupts (2019-12-11 16:05:55 +0000)
> >
> > ----------------------------------------------------------------
> > PCI: dt: Remove magic numbers for legacy PCI IRQ interrupts
> >
> > PCI devices can trigger interrupts via 4 physical/virtual lines known
> > as INTA, INTB, INTC or INTD. Due to interrupt swizzling it is often
> > required to describe the interrupt mapping in the device tree. Let's
> > avoid the existing magic numbers and replace them with a #define to
> > improve clarity.
> >
> > This is based on v5.5-rc1. As this series covers multiple architectures
> > and updates include/dt-bindings it was felt that it may be more
> > convenient to merge in one go.
>
> That's a pretty high-effort way of doing this, with potential for messy
> conflicts.
>
> The standard way of making sweeping changes across the tree is usually to
> get the new interface/definition added in one release, and then moving
> usage over through the various maintainers in the release after since
> the define is then in the base tree for everybody. Would you mind using
> the same approach here, please? Especially since this is mostly a cleanup.

Yeah, it's already going to conflict with some PCI controller schema
conversions pending.

I'm happy to apply the header for 5.5-rc2. Then send the dts changes
to Arnd/Olof and the binding changes to Lorenzo.

Rob
