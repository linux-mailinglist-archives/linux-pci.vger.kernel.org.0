Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1882427EBD5
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 17:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbgI3PIL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 11:08:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:33320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbgI3PIL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Sep 2020 11:08:11 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17EDB2076B;
        Wed, 30 Sep 2020 15:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601478491;
        bh=6QqV+ps2byZU4rC+O9EPuG5NtciAPCEeD4gdtKBD0V8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=A/ivvxVa7Lw2T1yu1urk7UClaBhy0Oxhld0Oi/R59aBUlQYOSgRnn3e5XkE6gGSKk
         rg2DyNJrcQeKFp9HT57WyYGU+Uz+BYjh0JVagdB2kBzeg0MiiUi0Q6mkixYcsdOAH9
         6YHijAkeVYgXNQFyX75GqYhfsqet0wuli9JzkKIc=
Received: by mail-ot1-f51.google.com with SMTP id n61so2121324ota.10;
        Wed, 30 Sep 2020 08:08:11 -0700 (PDT)
X-Gm-Message-State: AOAM530AwIcolv0SkYZdw+3KUKAC0ufHiKUO5NkhkBWQbRZVDqalSmjg
        z1aUgZe+OSSkW6S0b50pRkcGc+XSKmwnttXknw==
X-Google-Smtp-Source: ABdhPJxR8X69n4RLWzWvWtjlNHfj6t2hbM954Jp9nfbLK/knvYLAEl3iGmFm2iq7eVu7IxfjcLQLw9d0+fG5PpGV/sQ=
X-Received: by 2002:a9d:6ada:: with SMTP id m26mr1897519otq.192.1601478490346;
 Wed, 30 Sep 2020 08:08:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200929131328.13779-1-Zhiqiang.Hou@nxp.com> <6e6d021b-bc46-63b4-7e84-6ca2c8e631f9@ti.com>
In-Reply-To: <6e6d021b-bc46-63b4-7e84-6ca2c8e631f9@ti.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 30 Sep 2020 10:07:58 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+rH6-NMb0=jbdYA5mzP_2VphW4TXvKJdKr3cnsPQp1RA@mail.gmail.com>
Message-ID: <CAL_Jsq+rH6-NMb0=jbdYA5mzP_2VphW4TXvKJdKr3cnsPQp1RA@mail.gmail.com>
Subject: Re: [PATCH] PCI: layerscape: Change back to the default error
 response behavior
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Roy Zang <roy.zang@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
        Yang-Leo Li <leoyang.li@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 30, 2020 at 8:29 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Hi Hou,
>
> On 29/09/20 6:43 pm, Zhiqiang Hou wrote:
> > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> >
> > In the current error response behavior, it will send a SLVERR response
> > to device's internal AXI slave system interface when the PCIe controller
> > experiences an erroneous completion (UR, CA and CT) from an external
> > completer for its outbound non-posted request, which will result in
> > SError and crash the kernel directly.
> > This patch change back it to the default behavior to increase the
> > robustness of the kernel. In the default behavior, it always sends an
> > OKAY response to the internal AXI slave interface when the controller
> > gets these erroneous completions. And the AER driver will report and
> > try to recover these errors.
>
> I don't think not forwarding any error interrupts is a good idea.

Interrupts would be fine. Abort/SError is not. I think it is pretty
clear what the correct behavior is for config accesses.

> Maybe
> you could disable it while reading configuration space registers
> (vendorID and deviceID) and then enable error forwarding back?

To add to the locking (or lack of) problems in config accesses?

Rob
