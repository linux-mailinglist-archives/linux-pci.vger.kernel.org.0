Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC421DDF44
	for <lists+linux-pci@lfdr.de>; Fri, 22 May 2020 07:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbgEVFXa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 May 2020 01:23:30 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43160 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgEVFXa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 May 2020 01:23:30 -0400
Received: by mail-qk1-f193.google.com with SMTP id i14so9620079qka.10;
        Thu, 21 May 2020 22:23:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2yxPyGEr8MWT1pOhw2naOgT5hnh4gm8Tc6BN4m/HHiM=;
        b=bCCLyKSeW4SYOYrbtsqw6DILi56i7Uac+owfIoq7gkPlZYMCc5AMLJg6ALFMtt/ZFU
         85l9AsZlNzsWffhunnDhXHD65+bTavwvK2VKPNJQ7qq8L81cew49XuKFs3kqI1uZbJRY
         kBCVU9YC67H1A6iwDwaVN2j3RrX3EKheewLbF6fST4c5ptGtOF6JRcRF7/cxYM4rS9vX
         4iVEVGxzW2oxAUTZVgLc2p3O8HaVDy3IMBxr5Rir8xOk3FC1KFK6n3ilkO1hDY4jdBUm
         wA2HO/LAdKUil0zkWaMXpqGrw9NLopibbvvJr2IjhUhySQ9/302rNcOggte/kWtM1KvD
         0VoA==
X-Gm-Message-State: AOAM5316eoku9k7S8h/fxUdNU2US/aPNNzLmAeqeTVJ2zRCglktpvwxw
        23o5dnvntJgmPlOy0+YtTnPCzcaUZVA=
X-Google-Smtp-Source: ABdhPJz2rrQCfIvELxNSTJrc0Tjmiw7rfECQd4FSIecU9g/XagoyPem06C+zwUQD6IymbXzTyvRuQw==
X-Received: by 2002:a37:a1cb:: with SMTP id k194mr13115064qke.501.1590125008229;
        Thu, 21 May 2020 22:23:28 -0700 (PDT)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com. [209.85.222.169])
        by smtp.gmail.com with ESMTPSA id m7sm6624847qti.6.2020.05.21.22.23.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 22:23:28 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id m11so9689569qka.4;
        Thu, 21 May 2020 22:23:27 -0700 (PDT)
X-Received: by 2002:a05:620a:6da:: with SMTP id 26mr13060082qky.196.1590125007554;
 Thu, 21 May 2020 22:23:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200520135708.GA1086370@bjorn-Precision-5520> <alpine.LFD.2.21.2005220144230.21168@redsun52.ssa.fujisawa.hgst.com>
In-Reply-To: <alpine.LFD.2.21.2005220144230.21168@redsun52.ssa.fujisawa.hgst.com>
From:   Paul Burton <paulburton@kernel.org>
Date:   Thu, 21 May 2020 22:23:14 -0700
X-Gmail-Original-Message-ID: <CAG0y8xkAqscKC0qpx+zkBsmxtZFRaHdSgNLA78eGJUsQEtxQSA@mail.gmail.com>
Message-ID: <CAG0y8xkAqscKC0qpx+zkBsmxtZFRaHdSgNLA78eGJUsQEtxQSA@mail.gmail.com>
Subject: Re: piix4-poweroff.c I/O BAR usage
To:     "Maciej W. Rozycki" <macro@wdc.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Krzysztof Wilczynski <kw@linux.com>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

On Thu, May 21, 2020 at 6:04 PM Maciej W. Rozycki <macro@wdc.com> wrote:
>  Paul may or may not be reachable anymore, so I'll step in.

I'm reachable but lacking free time & with no access to Malta hardware
I can't claim to be too useful here, so thanks for responding :)

Before being moved to a driver (which was mostly driven by a desire to
migrate Malta to a multi-platform/generic kernel using DT) this code
was part of arch/mips/mti-malta/ where I added it in commit
b6911bba598f ("MIPS: Malta: add suspend state entry code"). My main
motivation at the time was to make QEMU exit after running poweroff,
but I did ensure it worked on real Malta boards too (at least Malta-R
with CoreFPGA6). Over the years since then it shocked a couple of
hardware people to see software power off a Malta - if the original
hardware designers had intended that to work then the knowledge had
been lost over time :)

I suspect the code was based on visws_machine_power_off():

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/platform/visws/visws_quirks.c?h=v3.10#n125

> > pci_request_region() takes a BAR number (0-5), but here we're passing
> > PCI_BRIDGE_RESOURCES (13 if CONFIG_PCI_IOV, or 7 otherwise), which is
> > the bridge I/O window.
> >
> > I don't think this device ([8086:7113]) is a bridge, so that resource
> > should be empty.
>
>  Hmm, isn't the resource actually set up by `quirk_piix4_acpi' though?

I agree that the region used is meant to match that set up by
quirk_piix4_acpi(), which also refers to it using the
PCI_BRIDGE_RESOURCES macro.

Thanks,
    Paul
