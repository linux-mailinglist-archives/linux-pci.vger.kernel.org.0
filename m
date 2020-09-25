Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5698278237
	for <lists+linux-pci@lfdr.de>; Fri, 25 Sep 2020 10:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbgIYIHJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Sep 2020 04:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbgIYIHI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Sep 2020 04:07:08 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5AAC0613CE
        for <linux-pci@vger.kernel.org>; Fri, 25 Sep 2020 01:07:08 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id f142so1952329qke.13
        for <linux-pci@vger.kernel.org>; Fri, 25 Sep 2020 01:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hn0e3Tp85GV0MRP60OpDMqINazpvyfo57YYV96qSEcQ=;
        b=QnngdGG5WlwoASqtYZgero4yQufOwOZS90U1fysFJd+DzrgFEW9bQjmABtldW27LAh
         ERev8Bh0ARgvN0brT9uPynBmrZu/KZLWBMf5mu1Tavpj4CxmwiUD+YNZuuNGpebQy+Zr
         HGl0oZDJuKWRB+aznMZtuPRhebIcVFeELlpu0aQcSlKuqRa78vH9pLsFvimH7wr0dMEm
         j9P/UNAA5sAHoEKDQd8mD8jNejfYfrDXi3RY3yrIzDOC2hN4FUf1C4FE+hDAC0O01RQN
         j9Ks2/EYQCqWpKPWVrIFQE2uLoCxtwa9SB9ZODZYw6jHZd2Owk6HQhCgHy1AlGUvcwb0
         dh3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hn0e3Tp85GV0MRP60OpDMqINazpvyfo57YYV96qSEcQ=;
        b=EcFcKo3mPLkRFY0+IZopcEVgvRZfItRA0VLfzJQqiNirBkeOnkwHgei1kQEGKeFywn
         iyH/XDk4zkvv4R024Wfgp6xQWh2iECGpF2rLUn+5IhR3l7NiEixGbtYJQ6sP4Yh+hvXH
         Uu7gi2V80euTJx9BMpBU5KGLWM32z5wEzDLgSxv+De8A1+bLPwZLoWdTxY9+IIAUdk2k
         KplkgP3ZJjIp/ggf1pbj/W6CeDRQ7NaNP1amMM/2bgAoHlgxoUy6nsK0a7WSe3or9xQy
         VDKiqVdYWsFpmOEONf6w+T9w2xv0thKqsq2PeDwF4RQ0VOIGeKvo4xDqRgOCxAzWjigx
         yQRw==
X-Gm-Message-State: AOAM531fgJMqka8NT0JJEvZyZCJqaINxuRTiX9LhOhqnXXIYKGmS6IYW
        zG+r1fBftHOWhHaNiVpx553dtH/D7KEDhSjj8DBeJsw015U=
X-Google-Smtp-Source: ABdhPJx3ahT7FEhKPf0OavdvXPLl7+bCb13GIRGxDVX6iUygdrhrgzv/E1yZH9GdKb4UtRjnrcrozUrEwalyp/r86CY=
X-Received: by 2002:ae9:ee06:: with SMTP id i6mr2939612qkg.380.1601021227723;
 Fri, 25 Sep 2020 01:07:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAA85sZvm5SyiG_AE3=4Xowz4AYuMW38uvw8QJ5D8WL3=1Tkv7w@mail.gmail.com>
 <20200924162442.GA2321475@bjorn-Precision-5520>
In-Reply-To: <20200924162442.GA2321475@bjorn-Precision-5520>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Fri, 25 Sep 2020 10:06:54 +0200
Message-ID: <CAA85sZvLN4tvFS_EpC1SHyZic8kgCDF7NFG6KSeEXqSAyjuBmA@mail.gmail.com>
Subject: Re: [PATCH] Use maximum latency when determining L1/L0s ASPM v2
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ok so it might not be related to that change then...

but:
 ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec  4.34 MBytes  36.4 Mbits/sec
[  5]   1.00-2.00   sec  7.11 MBytes  59.6 Mbits/sec
[  5]   2.00-3.00   sec  4.76 MBytes  39.9 Mbits/sec
[  5]   3.00-4.00   sec  4.13 MBytes  34.7 Mbits/sec
[  5]   4.00-5.00   sec  4.19 MBytes  35.1 Mbits/sec
[  5]   5.00-6.00   sec  5.70 MBytes  47.8 Mbits/sec
[  5]   6.00-7.00   sec  5.96 MBytes  50.0 Mbits/sec
[  5]   7.00-8.00   sec  4.17 MBytes  35.0 Mbits/sec
[  5]   8.00-9.00   sec  4.14 MBytes  34.7 Mbits/sec
[  5]   9.00-10.00  sec  4.08 MBytes  34.3 Mbits/sec
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-10.00  sec  48.6 MBytes  40.8 Mbits/sec                  receiver

The issue persists

On Thu, Sep 24, 2020 at 6:24 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Sep 23, 2020 at 11:36:00PM +0200, Ian Kumlien wrote:
>
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=66ff14e59e8a
> >
> > "7d715a6c1ae5 ("PCI: add PCI Express ASPM support") added the ability for
> > Linux to enable ASPM, but for some undocumented reason, it didn't enable
> > ASPM on links where the downstream component is a PCIe-to-PCI/PCI-X Bridge.
> >
> > Remove this exclusion so we can enable ASPM on these links."
> > ...
>
> > And all of this worked before the commit above.
>
> OK, really sorry, I got myself totally confused here, and I need to
> start over from scratch.  Correct me when I go off the rails.
>
> You're running 5.8.11+, and you get ~40 Mbit/s on the Intel I211 NIC.
> Reverting 66ff14e59e8a ("PCI/ASPM: Allow ASPM on links to
> PCIe-to-PCI/PCI-X Bridges") gets your bandwidth up to the 900+ Mbit/s
> you expect.
>
> 66ff14e59e8a only makes a difference if you have a PCIe-to-PCI/PCI-X
> Bridge (PCI_EXP_TYPE_PCI_BRIDGE) in your system.  But from your lspci
> and pci=earlydump output, I don't see any of those.  The only bridges
> I see are:
>
> [    0.810346] pci 0000:00:01.2: [1022:1483] type 01 Root Port to [bus 01-07]
> [    0.810587] pci 0000:00:03.1: [1022:1483] type 01 Root Port to [bus 08]
> [    0.810587] pci 0000:00:03.2: [1022:1483] type 01 Root Port to [bus 09]
> [    0.810837] pci 0000:00:07.1: [1022:1484] type 01 Root Port to [bus 0a]
> [    0.811587] pci 0000:00:08.1: [1022:1484] type 01 Root Port to [bus 0b]
> [    0.812586] pci 0000:01:00.0: [1022:57ad] type 01 Upstream Port to [bus 02-07]
> [    0.812629] pci 0000:02:03.0: [1022:57a3] type 01 Downstream Port to [bus 03]
> [    0.813584] pci 0000:02:04.0: [1022:57a3] type 01 Downstream Port to [bus 04]
> [    0.814584] pci 0000:02:08.0: [1022:57a4] type 01 Downstream Port to [bus 05]
> [    0.815584] pci 0000:02:09.0: [1022:57a4] type 01 Downstream Port to [bus 06]
> [    0.815584] pci 0000:02:0a.0: [1022:57a4] type 01 Downstream Port to [bus 07]
>
> So I'm lost right off the bat.  You have no PCI_EXP_TYPE_PCI_BRIDGE
> device, so how can 66ff14e59e8a make a difference for you?
>
> Can you add a printk there, e.g.,
>
>         list_for_each_entry(child, &linkbus->devices, bus_list) {
>                 if (pci_pcie_type(child) == PCI_EXP_TYPE_PCI_BRIDGE) {
>   +                     pci_info(child, "PCIe-to-PCI bridge, disabling ASPM\n");
>                         link->aspm_disable = ASPM_STATE_ALL;
>                         break;
>                 }
>         }
>
