Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE6E3C4356
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jul 2021 06:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhGLEzP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Jul 2021 00:55:15 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:48518
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229477AbhGLEzP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Jul 2021 00:55:15 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 0EBF140616
        for <linux-pci@vger.kernel.org>; Mon, 12 Jul 2021 04:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1626065546;
        bh=QRC3zaF7/QzMXGsoRGdqQl3BuaKhXLRU2RMUVdvz18g=;
        h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type;
        b=InaQCgtvWRWYuQPaHxTQ7gnNIGaNAohAQSnQ0RCuJAOuM7yNY3b8BU9cFSveN8Lww
         6VsSEIshD/BkbL3EHCO17r5sdl+4BtHWOsnqm6k2/IHbR+0fypWwNBoJVdCwadeO3B
         pIIGvh7IucJK0hNymtdjb7pM03KAiDXxX8gJdtrEMfclV6Nvexh1sVEVYKhIgj6Eyj
         QeYK2Q5av13F0/RIVBDVYriiQp5XG+oUr3e0UOFbAlhp0ylwpV3QhPZkF2Af49hAjh
         XeBqGurM1xGl9xz0i5vtmwX7rOaxNt5OLwCmT91gFEO7mu9cSxP2bmyZPgPvHc+DJ6
         gKZ7dGypKDH/g==
Received: by mail-ed1-f72.google.com with SMTP id e3-20020a0564020883b029039ef9536577so7753601edy.5
        for <linux-pci@vger.kernel.org>; Sun, 11 Jul 2021 21:52:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QRC3zaF7/QzMXGsoRGdqQl3BuaKhXLRU2RMUVdvz18g=;
        b=gJqWyd+lxdxz6DeIYWPslvEPwUVuYsDues1LW91NEhX7DAqf/Qnd3sBTdnep1bdbnG
         jv3f5CQfKFiShnF/YJzs2tp9OZhBiwT/rr9a7lteb9DLon9L2J9qYqXmr4E1alZGkuSD
         KXY5Hld8eqTHueD+p0xdChav79EJUlUFlj2NzfJJj5sc/QS96XT3hbAzFZGuhVvRrv2e
         h+RZ+o0moXyDR16JflvEVXJhyQD4bF7PirKJp0BG/ZTaVjH4TPDO1sQxsm3YjiqA8jYM
         LOEY9AI5vvrVjqzdpD+Wi+2TUrZRl76Ye9HAd2ggN0oaZNti7XRN6EdjlQ7p7uGfQ/Hn
         /log==
X-Gm-Message-State: AOAM533C3kbQljbgF+/ai8Eawcz9lHBqqdZeyOJtALpATzyWTGc+aD6u
        nU3oV0/UGQEUsy59DvqfUhF4yD8HM5QlOdtBFnz40t4GMgbzXuDc7tTE/HkXZbk/fsC3yPBAkct
        kmcv1u3NZPKuAwoeWlBIaLRm9ORLBSWJ53yt+Y+acwQDYRDyDuFoxgw==
X-Received: by 2002:a17:907:3f0c:: with SMTP id hq12mr45742120ejc.117.1626065545607;
        Sun, 11 Jul 2021 21:52:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyrUCs/YA8tM7yjnbsf5Uzz2oaLCkq+73fYF+D0AaBFrMFrN3hi5ffRSjKR/oXxwMUDwaGu9IbwkOtThu3YuaQ=
X-Received: by 2002:a17:907:3f0c:: with SMTP id hq12mr45742108ejc.117.1626065545336;
 Sun, 11 Jul 2021 21:52:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210401131252.531935-1-kai.heng.feng@canonical.com>
 <20210709231529.GA3270116@roeck-us.net> <CAAd53p7s=k7pa_GdaetQGQYp9GbQR+jkQWLQoe6-c0oTjCQXxw@mail.gmail.com>
 <f2239f52-8675-17fb-bf5f-80be0abe78d2@roeck-us.net>
In-Reply-To: <f2239f52-8675-17fb-bf5f-80be0abe78d2@roeck-us.net>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Mon, 12 Jul 2021 12:52:14 +0800
Message-ID: <CAAd53p48RFDiahzaqoJnNn-V6EQZzMxrDcQaTo2GM7vHrGqC=Q@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Coalesce contiguous regions for host bridges
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 12, 2021 at 12:50 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 7/11/21 8:50 PM, Kai-Heng Feng wrote:
> > Hi Guenter,
> >
> > On Sat, Jul 10, 2021 at 7:15 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >>
> >> Hi,
> >>
> >> On Thu, Apr 01, 2021 at 09:12:52PM +0800, Kai-Heng Feng wrote:
> >>> Built-in graphics on HP EliteDesk 805 G6 doesn't work because graphics
> >>> can't get the BAR it needs:
> >>> [    0.611504] pci_bus 0000:00: root bus resource [mem 0x10020200000-0x100303fffff window]
> >>> [    0.611505] pci_bus 0000:00: root bus resource [mem 0x10030400000-0x100401fffff window]
> >>> ...
> >>> [    0.638083] pci 0000:00:08.1:   bridge window [mem 0xd2000000-0xd23fffff]
> >>> [    0.638086] pci 0000:00:08.1:   bridge window [mem 0x10030000000-0x100401fffff 64bit pref]
> >>> [    0.962086] pci 0000:00:08.1: can't claim BAR 15 [mem 0x10030000000-0x100401fffff 64bit pref]: no compatible bridge window
> >>> [    0.962086] pci 0000:00:08.1: [mem 0x10030000000-0x100401fffff 64bit pref] clipped to [mem 0x10030000000-0x100303fffff 64bit pref]
> >>> [    0.962086] pci 0000:00:08.1:   bridge window [mem 0x10030000000-0x100303fffff 64bit pref]
> >>> [    0.962086] pci 0000:07:00.0: can't claim BAR 0 [mem 0x10030000000-0x1003fffffff 64bit pref]: no compatible bridge window
> >>> [    0.962086] pci 0000:07:00.0: can't claim BAR 2 [mem 0x10040000000-0x100401fffff 64bit pref]: no compatible bridge window
> >>>
> >>> However, the root bus has two contiguous regions that can contain the
> >>> child resource requested.
> >>>
> >>> Bjorn Helgaas pointed out that we can simply coalesce contiguous regions
> >>> for host bridges, since host bridge don't have _SRS. So do that
> >>> accordingly to make child resource can be contained. This change makes
> >>> the graphics works on the system in question.
> >>>
> >>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=212013
> >>> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> >>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >>
> >> With this patch in place, I can no longer boot the ppc:sam460ex
> >> qemu emulation from nvme. I see the following boot error:
> >>
> >> nvme nvme0: Device not ready; aborting initialisation, CSTS=0x0
> >> nvme nvme0: Removing after probe failure status: -19
> >>
> >> A key difference seems to be swapped region addresses:
> >>
> >> ok:
> >>
> >> PCI host bridge to bus 0002:00^M
> >> pci_bus 0002:00: root bus resource [io  0x0000-0xffff]
> >> pci_bus 0002:00: root bus resource [mem 0xd80000000-0xdffffffff] (bus address [0x80000000-0xffffffff])
> >> pci_bus 0002:00: root bus resource [mem 0xc0ee00000-0xc0eefffff] (bus address [0x00000000-0x000fffff])
> >>
> >> bad:
> >>
> >> PCI host bridge to bus 0002:00^M
> >> pci_bus 0002:00: root bus resource [io  0x0000-0xffff]
> >> pci_bus 0002:00: root bus resource [mem 0xc0ee00000-0xc0eefffff] (bus address [0x00000000-0x000fffff])
> >> pci_bus 0002:00: root bus resource [mem 0xd80000000-0xdffffffff] (bus address [0x80000000-0xffffffff])
> >>
> >> and then bar address assignments are swapped/changed.
> >>
> >> ok:
> >>
> >> pci 0002:00:06.0: BAR 0: assigned [mem 0xd80000000-0xd83ffffff]^M
> >> pci 0002:00:06.0: BAR 1: assigned [mem 0xd84000000-0xd841fffff]^M
> >> pci 0002:00:02.0: BAR 0: assigned [mem 0xd84200000-0xd84203fff 64bit]^M
> >> pci 0002:00:01.0: BAR 5: assigned [mem 0xd84204000-0xd842041ff]^M
> >> pci 0002:00:03.0: BAR 0: assigned [io  0x1000-0x107f]^M
> >> pci 0002:00:03.0: BAR 1: assigned [mem 0xd84204200-0xd8420427f]^M
> >> pci 0002:00:01.0: BAR 4: assigned [io  0x1080-0x108f]^M
> >> pci 0002:00:01.0: BAR 0: assigned [io  0x1090-0x1097]^M
> >> pci 0002:00:01.0: BAR 2: assigned [io  0x1098-0x109f]^M
> >> pci 0002:00:01.0: BAR 1: assigned [io  0x10a0-0x10a3]^M
> >> pci 0002:00:01.0: BAR 3: assigned [io  0x10a4-0x10a7]^M
> >> pci_bus 0002:00: resource 4 [io  0x0000-0xffff]^M
> >> pci_bus 0002:00: resource 5 [mem 0xd80000000-0xdffffffff]^M
> >> pci_bus 0002:00: resource 6 [mem 0xc0ee00000-0xc0eefffff]^M
> >>
> >> bad:
> >>
> >> pci 0002:00:06.0: BAR 0: assigned [mem 0xd80000000-0xd83ffffff]^M
> >> pci 0002:00:06.0: BAR 1: assigned [mem 0xd84000000-0xd841fffff]^M
> >> pci 0002:00:02.0: BAR 0: assigned [mem 0xc0ee00000-0xc0ee03fff 64bit]^M
> >> pci 0002:00:01.0: BAR 5: assigned [mem 0xc0ee04000-0xc0ee041ff]^M
> >> pci 0002:00:03.0: BAR 0: assigned [io  0x1000-0x107f]^M
> >> pci 0002:00:03.0: BAR 1: assigned [mem 0xc0ee04200-0xc0ee0427f]^M
> >> pci 0002:00:01.0: BAR 4: assigned [io  0x1080-0x108f]^M
> >> pci 0002:00:01.0: BAR 0: assigned [io  0x1090-0x1097]^M
> >> pci 0002:00:01.0: BAR 2: assigned [io  0x1098-0x109f]^M
> >> pci 0002:00:01.0: BAR 1: assigned [io  0x10a0-0x10a3]^M
> >> pci 0002:00:01.0: BAR 3: assigned [io  0x10a4-0x10a7]^M
> >> pci_bus 0002:00: resource 4 [io  0x0000-0xffff]^M
> >> pci_bus 0002:00: resource 5 [mem 0xc0ee00000-0xc0eefffff]^M
> >> pci_bus 0002:00: resource 6 [mem 0xd80000000-0xdffffffff]^M
> >>
> >> Reverting this patch fixes the problem.
> >
> > Can you please comment out the list_sort()? Seems like the precaution
> > breaks your system...
> >
>
> Yes, everything works if I re-apply your patch and comment out the
> call to list_sort().

Thanks for your testing!
I'll send a new patch that doesn't have list_sort().

Kai-Heng

>
> Guenter
