Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9DD33C426B
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jul 2021 05:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhGLEAs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Jul 2021 00:00:48 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:50252
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229508AbhGLEAr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Jul 2021 00:00:47 -0400
X-Greylist: delayed 392 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Jul 2021 00:00:46 EDT
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 534AB40325
        for <linux-pci@vger.kernel.org>; Mon, 12 Jul 2021 03:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1626061858;
        bh=TS6ZtQlpQH2xl9ZNXcYMmhzZw7AVZ3Gie0AgelezqWc=;
        h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type;
        b=ZYrevDAlWHkVoO9ZN2cqCfT7uj04JaJGn8PoiTFsxP2owAqQNU0QrgxVWoBAk5R5r
         qCVa93ofPph507MmnXxU9dpQxOBuk9pUe43NmUJHsluelcO2xwmmFZrVE45ICLK7FL
         ndUIe4Ej4JmDbpetoGf3rzZo+2c9DZkQbMrJqDf65BbsfpsMnbWcYkzdGhdMrFP6rV
         Xu85/SfMbLF1Px0P1sUu32LuhssVmACOe/AV7LKrOeN70oghmrjno77IHMHKFH6oPN
         +PBpm5Tk3nhAEQvxPZ+xu3TCGtviH+zvD1tIq7ntcHuQn1e4OigFCuJ5SNsSKJ8B96
         3d6lwbIRDNTuQ==
Received: by mail-ed1-f69.google.com with SMTP id cw12-20020a056402228cb02903a4b3e93e15so2766919edb.2
        for <linux-pci@vger.kernel.org>; Sun, 11 Jul 2021 20:50:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TS6ZtQlpQH2xl9ZNXcYMmhzZw7AVZ3Gie0AgelezqWc=;
        b=YF6uj7T53PmGtgosR+7M9f1bQ9CpbPG4C9lk9RCt67D2PGv1GQrFLPKsfNa4c+hPPK
         SKndTgCJkN0lC2o9yMcmZe3JLlGQ22yNDDTwfPuDJm8By65SlpyIpWD4YANX123GfQK+
         CyBg3MINgtkx4r5L0jbPTzVqUppL30K4FEpPjMZiLYFW2257FdXQGBVla3LRa4HykA+6
         dQDJbvqrivY97es0Jla+dAwgEP1HWg2tHEWjkZ0dmjZUYYbbllkZGONja/BmaOI79uuN
         oowE2/FfwLtERsQ7c6E0f1oMz9jZ2Z6uTpRoLxnlmTZk1SLXIBZzc5s/hm3Mr/W6rBZ5
         qvIA==
X-Gm-Message-State: AOAM532nvMyICNoFczuEAL+5+aFNNEidRLgari5f4EvERLb/ibN/KPY1
        iyzdVrECzpfFc4/nNzEpd3tAcMJgzGpxWNXjvZf0icUG2+DMVEU+ORpbrSaVSMIqHGwKu/CfbN8
        mjdgVJrEs1Wy9DVT6yvMrdYUMmkb0hN25JMZ4WzpiLOFAiu1gt6A6Ew==
X-Received: by 2002:a17:906:7946:: with SMTP id l6mr49182616ejo.230.1626061857226;
        Sun, 11 Jul 2021 20:50:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvx+nMqxgzwDNg5qoegnO4WTc4qOPZuz71EKJdoBcxAHJ998Ysjmd6WvoLjB13pp4yOo2xHqd4TRSAdL5k69I=
X-Received: by 2002:a17:906:7946:: with SMTP id l6mr49182591ejo.230.1626061856904;
 Sun, 11 Jul 2021 20:50:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210401131252.531935-1-kai.heng.feng@canonical.com> <20210709231529.GA3270116@roeck-us.net>
In-Reply-To: <20210709231529.GA3270116@roeck-us.net>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Mon, 12 Jul 2021 11:50:45 +0800
Message-ID: <CAAd53p7s=k7pa_GdaetQGQYp9GbQR+jkQWLQoe6-c0oTjCQXxw@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Coalesce contiguous regions for host bridges
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Guenter,

On Sat, Jul 10, 2021 at 7:15 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Hi,
>
> On Thu, Apr 01, 2021 at 09:12:52PM +0800, Kai-Heng Feng wrote:
> > Built-in graphics on HP EliteDesk 805 G6 doesn't work because graphics
> > can't get the BAR it needs:
> > [    0.611504] pci_bus 0000:00: root bus resource [mem 0x10020200000-0x100303fffff window]
> > [    0.611505] pci_bus 0000:00: root bus resource [mem 0x10030400000-0x100401fffff window]
> > ...
> > [    0.638083] pci 0000:00:08.1:   bridge window [mem 0xd2000000-0xd23fffff]
> > [    0.638086] pci 0000:00:08.1:   bridge window [mem 0x10030000000-0x100401fffff 64bit pref]
> > [    0.962086] pci 0000:00:08.1: can't claim BAR 15 [mem 0x10030000000-0x100401fffff 64bit pref]: no compatible bridge window
> > [    0.962086] pci 0000:00:08.1: [mem 0x10030000000-0x100401fffff 64bit pref] clipped to [mem 0x10030000000-0x100303fffff 64bit pref]
> > [    0.962086] pci 0000:00:08.1:   bridge window [mem 0x10030000000-0x100303fffff 64bit pref]
> > [    0.962086] pci 0000:07:00.0: can't claim BAR 0 [mem 0x10030000000-0x1003fffffff 64bit pref]: no compatible bridge window
> > [    0.962086] pci 0000:07:00.0: can't claim BAR 2 [mem 0x10040000000-0x100401fffff 64bit pref]: no compatible bridge window
> >
> > However, the root bus has two contiguous regions that can contain the
> > child resource requested.
> >
> > Bjorn Helgaas pointed out that we can simply coalesce contiguous regions
> > for host bridges, since host bridge don't have _SRS. So do that
> > accordingly to make child resource can be contained. This change makes
> > the graphics works on the system in question.
> >
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=212013
> > Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>
> With this patch in place, I can no longer boot the ppc:sam460ex
> qemu emulation from nvme. I see the following boot error:
>
> nvme nvme0: Device not ready; aborting initialisation, CSTS=0x0
> nvme nvme0: Removing after probe failure status: -19
>
> A key difference seems to be swapped region addresses:
>
> ok:
>
> PCI host bridge to bus 0002:00^M
> pci_bus 0002:00: root bus resource [io  0x0000-0xffff]
> pci_bus 0002:00: root bus resource [mem 0xd80000000-0xdffffffff] (bus address [0x80000000-0xffffffff])
> pci_bus 0002:00: root bus resource [mem 0xc0ee00000-0xc0eefffff] (bus address [0x00000000-0x000fffff])
>
> bad:
>
> PCI host bridge to bus 0002:00^M
> pci_bus 0002:00: root bus resource [io  0x0000-0xffff]
> pci_bus 0002:00: root bus resource [mem 0xc0ee00000-0xc0eefffff] (bus address [0x00000000-0x000fffff])
> pci_bus 0002:00: root bus resource [mem 0xd80000000-0xdffffffff] (bus address [0x80000000-0xffffffff])
>
> and then bar address assignments are swapped/changed.
>
> ok:
>
> pci 0002:00:06.0: BAR 0: assigned [mem 0xd80000000-0xd83ffffff]^M
> pci 0002:00:06.0: BAR 1: assigned [mem 0xd84000000-0xd841fffff]^M
> pci 0002:00:02.0: BAR 0: assigned [mem 0xd84200000-0xd84203fff 64bit]^M
> pci 0002:00:01.0: BAR 5: assigned [mem 0xd84204000-0xd842041ff]^M
> pci 0002:00:03.0: BAR 0: assigned [io  0x1000-0x107f]^M
> pci 0002:00:03.0: BAR 1: assigned [mem 0xd84204200-0xd8420427f]^M
> pci 0002:00:01.0: BAR 4: assigned [io  0x1080-0x108f]^M
> pci 0002:00:01.0: BAR 0: assigned [io  0x1090-0x1097]^M
> pci 0002:00:01.0: BAR 2: assigned [io  0x1098-0x109f]^M
> pci 0002:00:01.0: BAR 1: assigned [io  0x10a0-0x10a3]^M
> pci 0002:00:01.0: BAR 3: assigned [io  0x10a4-0x10a7]^M
> pci_bus 0002:00: resource 4 [io  0x0000-0xffff]^M
> pci_bus 0002:00: resource 5 [mem 0xd80000000-0xdffffffff]^M
> pci_bus 0002:00: resource 6 [mem 0xc0ee00000-0xc0eefffff]^M
>
> bad:
>
> pci 0002:00:06.0: BAR 0: assigned [mem 0xd80000000-0xd83ffffff]^M
> pci 0002:00:06.0: BAR 1: assigned [mem 0xd84000000-0xd841fffff]^M
> pci 0002:00:02.0: BAR 0: assigned [mem 0xc0ee00000-0xc0ee03fff 64bit]^M
> pci 0002:00:01.0: BAR 5: assigned [mem 0xc0ee04000-0xc0ee041ff]^M
> pci 0002:00:03.0: BAR 0: assigned [io  0x1000-0x107f]^M
> pci 0002:00:03.0: BAR 1: assigned [mem 0xc0ee04200-0xc0ee0427f]^M
> pci 0002:00:01.0: BAR 4: assigned [io  0x1080-0x108f]^M
> pci 0002:00:01.0: BAR 0: assigned [io  0x1090-0x1097]^M
> pci 0002:00:01.0: BAR 2: assigned [io  0x1098-0x109f]^M
> pci 0002:00:01.0: BAR 1: assigned [io  0x10a0-0x10a3]^M
> pci 0002:00:01.0: BAR 3: assigned [io  0x10a4-0x10a7]^M
> pci_bus 0002:00: resource 4 [io  0x0000-0xffff]^M
> pci_bus 0002:00: resource 5 [mem 0xc0ee00000-0xc0eefffff]^M
> pci_bus 0002:00: resource 6 [mem 0xd80000000-0xdffffffff]^M
>
> Reverting this patch fixes the problem.

Can you please comment out the list_sort()? Seems like the precaution
breaks your system...

Kai-Heng

>
> Guenter
>
> ---
> bisect log:
>
> # bad: [f55966571d5eb2876a11e48e798b4592fa1ffbb7] Merge tag 'drm-next-2021-07-08-1' of git://anongit.freedesktop.org/drm/drm
> # good: [e9f1cbc0c4114880090c7a578117d3b9cf184ad4] Merge tag 'acpi-5.14-rc1-2' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
> git bisect start 'f55966571d5e' 'e9f1cbc0c411'
> # bad: [b0dfd9af28b60d7ec42c359ae84c1ba97e093100] Merge tag 'clk-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux
> git bisect bad b0dfd9af28b60d7ec42c359ae84c1ba97e093100
> # bad: [364a716bd73e9846d3118a43f600f8f517658b38] Merge branch 'pci/host/intel-gw'
> git bisect bad 364a716bd73e9846d3118a43f600f8f517658b38
> # good: [c9fb9042c98df94197a1ba4cf14a77c8053b0fae] Merge branch 'pci/p2pdma'
> git bisect good c9fb9042c98df94197a1ba4cf14a77c8053b0fae
> # bad: [7132700067f234d37c234e5d711bb49ea06d2352] Merge branch 'pci/sysfs'
> git bisect bad 7132700067f234d37c234e5d711bb49ea06d2352
> # bad: [131e4f76c9ae9636046bf04d19d43af0e4ae9807] Merge branch 'pci/resource'
> git bisect bad 131e4f76c9ae9636046bf04d19d43af0e4ae9807
> # good: [411e2a43d210e98730713acf6d01dcf823ee35e3] PCI: Work around Huawei Intelligent NIC VF FLR erratum
> git bisect good 411e2a43d210e98730713acf6d01dcf823ee35e3
> # good: [e92605b0a0cdafb6c37b9d1ad24fe1cf8280eeb6] Merge branch 'pci/pm'
> git bisect good e92605b0a0cdafb6c37b9d1ad24fe1cf8280eeb6
> # bad: [65db04053efea3f3e412a7e0cc599962999c96b4] PCI: Coalesce host bridge contiguous apertures
> git bisect bad 65db04053efea3f3e412a7e0cc599962999c96b4
> # first bad commit: [65db04053efea3f3e412a7e0cc599962999c96b4] PCI: Coalesce host bridge contiguous apertures
