Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD0F93C2B97
	for <lists+linux-pci@lfdr.de>; Sat, 10 Jul 2021 01:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhGIXSR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jul 2021 19:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbhGIXSR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jul 2021 19:18:17 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B53CC0613DD;
        Fri,  9 Jul 2021 16:15:32 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id a189so3965233oii.2;
        Fri, 09 Jul 2021 16:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=viBl10/P0eJzGsi1s3xaVtFWw/ZmZJsUl551hV7dj1I=;
        b=X0nszFiEFnwV17XuGUHTectU681mP9D2GnH9/ZyajfcXReCDBzT4kBm9mW09Xm/+26
         f3b2z0VN7DBxbbzHIYqsJBVUryNDo+XcFmi3DkiGs+cq8rQGC1sPrtdS7/lYkYGFKTzy
         EeP+tOC0oQSfXZ7sGtNWEt59JI9dkNWKGmq7fW2N0sgQnyO7Kcujnf7j6ghkfoxMG98p
         npNVIRPZm83H2MZ+dm3cWW/3/D14W4deoYiOItmvYz53/P/xOTNpmZTR8X7qJzbsmW73
         eZ+ehWvW8RGcfFiQvitQdVJYogIxoeHMF4f97hIBdT83Fcizr9E6ZCaCIlGDYK8NWCmI
         0uGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=viBl10/P0eJzGsi1s3xaVtFWw/ZmZJsUl551hV7dj1I=;
        b=OF9OHSasaD+X7CvUQaIti5KKJtZ2vp6MreDljJWks4B3TNi9omfWepPbbHKxZFnEf+
         CeJfrCt6QoDWb9cJ6UA1QksKIQk2i3TV5X7R2yZp2tgrgMjdzfLtWYEqY3edM/ASzWWb
         6ObuZUVJF01pB/H6cppUj+XCaqICMHHIAWkaJ2aRrnFzP4o37KjXSSxttJAjQxmOOaK4
         /+W9TYFNytHlCCrR+JVFvo7F8ZHb5ZqHNcZiVqI53kMHCuo0MfgJ2e/Bh/rbVzChkwVt
         WWbHb66TW17NlDblWg6AKSRwU1pR1fA3YUDrUu3XdnRNi3Y7FdHNzrHbZkRfLNNCVxQ9
         ukVQ==
X-Gm-Message-State: AOAM531IkNot3xEATKnbexxEBRMf56XAmZjrsTEKya9xA3gLKl5S6tw0
        7/uvZj3M9tHML0NdmeYZbvQ=
X-Google-Smtp-Source: ABdhPJwZmqDZ75Rn8O6vEvN3BkButFMmP79hYxWovQjVnvfVasW1PVStWJl5VSCpTED8RW7bgFjObw==
X-Received: by 2002:aca:5f8a:: with SMTP id t132mr1045899oib.72.1625872531749;
        Fri, 09 Jul 2021 16:15:31 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p15sm1454904oth.1.2021.07.09.16.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 16:15:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 9 Jul 2021 16:15:29 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     bhelgaas@google.com,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: Coalesce contiguous regions for host bridges
Message-ID: <20210709231529.GA3270116@roeck-us.net>
References: <20210401131252.531935-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401131252.531935-1-kai.heng.feng@canonical.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Thu, Apr 01, 2021 at 09:12:52PM +0800, Kai-Heng Feng wrote:
> Built-in graphics on HP EliteDesk 805 G6 doesn't work because graphics
> can't get the BAR it needs:
> [    0.611504] pci_bus 0000:00: root bus resource [mem 0x10020200000-0x100303fffff window]
> [    0.611505] pci_bus 0000:00: root bus resource [mem 0x10030400000-0x100401fffff window]
> ...
> [    0.638083] pci 0000:00:08.1:   bridge window [mem 0xd2000000-0xd23fffff]
> [    0.638086] pci 0000:00:08.1:   bridge window [mem 0x10030000000-0x100401fffff 64bit pref]
> [    0.962086] pci 0000:00:08.1: can't claim BAR 15 [mem 0x10030000000-0x100401fffff 64bit pref]: no compatible bridge window
> [    0.962086] pci 0000:00:08.1: [mem 0x10030000000-0x100401fffff 64bit pref] clipped to [mem 0x10030000000-0x100303fffff 64bit pref]
> [    0.962086] pci 0000:00:08.1:   bridge window [mem 0x10030000000-0x100303fffff 64bit pref]
> [    0.962086] pci 0000:07:00.0: can't claim BAR 0 [mem 0x10030000000-0x1003fffffff 64bit pref]: no compatible bridge window
> [    0.962086] pci 0000:07:00.0: can't claim BAR 2 [mem 0x10040000000-0x100401fffff 64bit pref]: no compatible bridge window
> 
> However, the root bus has two contiguous regions that can contain the
> child resource requested.
> 
> Bjorn Helgaas pointed out that we can simply coalesce contiguous regions
> for host bridges, since host bridge don't have _SRS. So do that
> accordingly to make child resource can be contained. This change makes
> the graphics works on the system in question.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=212013
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

With this patch in place, I can no longer boot the ppc:sam460ex
qemu emulation from nvme. I see the following boot error:

nvme nvme0: Device not ready; aborting initialisation, CSTS=0x0
nvme nvme0: Removing after probe failure status: -19

A key difference seems to be swapped region addresses:

ok:

PCI host bridge to bus 0002:00^M
pci_bus 0002:00: root bus resource [io  0x0000-0xffff]
pci_bus 0002:00: root bus resource [mem 0xd80000000-0xdffffffff] (bus address [0x80000000-0xffffffff])
pci_bus 0002:00: root bus resource [mem 0xc0ee00000-0xc0eefffff] (bus address [0x00000000-0x000fffff])

bad:

PCI host bridge to bus 0002:00^M
pci_bus 0002:00: root bus resource [io  0x0000-0xffff]
pci_bus 0002:00: root bus resource [mem 0xc0ee00000-0xc0eefffff] (bus address [0x00000000-0x000fffff])
pci_bus 0002:00: root bus resource [mem 0xd80000000-0xdffffffff] (bus address [0x80000000-0xffffffff])

and then bar address assignments are swapped/changed.

ok:

pci 0002:00:06.0: BAR 0: assigned [mem 0xd80000000-0xd83ffffff]^M
pci 0002:00:06.0: BAR 1: assigned [mem 0xd84000000-0xd841fffff]^M
pci 0002:00:02.0: BAR 0: assigned [mem 0xd84200000-0xd84203fff 64bit]^M
pci 0002:00:01.0: BAR 5: assigned [mem 0xd84204000-0xd842041ff]^M
pci 0002:00:03.0: BAR 0: assigned [io  0x1000-0x107f]^M
pci 0002:00:03.0: BAR 1: assigned [mem 0xd84204200-0xd8420427f]^M
pci 0002:00:01.0: BAR 4: assigned [io  0x1080-0x108f]^M
pci 0002:00:01.0: BAR 0: assigned [io  0x1090-0x1097]^M
pci 0002:00:01.0: BAR 2: assigned [io  0x1098-0x109f]^M
pci 0002:00:01.0: BAR 1: assigned [io  0x10a0-0x10a3]^M
pci 0002:00:01.0: BAR 3: assigned [io  0x10a4-0x10a7]^M
pci_bus 0002:00: resource 4 [io  0x0000-0xffff]^M
pci_bus 0002:00: resource 5 [mem 0xd80000000-0xdffffffff]^M
pci_bus 0002:00: resource 6 [mem 0xc0ee00000-0xc0eefffff]^M

bad:

pci 0002:00:06.0: BAR 0: assigned [mem 0xd80000000-0xd83ffffff]^M
pci 0002:00:06.0: BAR 1: assigned [mem 0xd84000000-0xd841fffff]^M
pci 0002:00:02.0: BAR 0: assigned [mem 0xc0ee00000-0xc0ee03fff 64bit]^M
pci 0002:00:01.0: BAR 5: assigned [mem 0xc0ee04000-0xc0ee041ff]^M
pci 0002:00:03.0: BAR 0: assigned [io  0x1000-0x107f]^M
pci 0002:00:03.0: BAR 1: assigned [mem 0xc0ee04200-0xc0ee0427f]^M
pci 0002:00:01.0: BAR 4: assigned [io  0x1080-0x108f]^M
pci 0002:00:01.0: BAR 0: assigned [io  0x1090-0x1097]^M
pci 0002:00:01.0: BAR 2: assigned [io  0x1098-0x109f]^M
pci 0002:00:01.0: BAR 1: assigned [io  0x10a0-0x10a3]^M
pci 0002:00:01.0: BAR 3: assigned [io  0x10a4-0x10a7]^M
pci_bus 0002:00: resource 4 [io  0x0000-0xffff]^M
pci_bus 0002:00: resource 5 [mem 0xc0ee00000-0xc0eefffff]^M
pci_bus 0002:00: resource 6 [mem 0xd80000000-0xdffffffff]^M

Reverting this patch fixes the problem.

Guenter

---
bisect log:

# bad: [f55966571d5eb2876a11e48e798b4592fa1ffbb7] Merge tag 'drm-next-2021-07-08-1' of git://anongit.freedesktop.org/drm/drm
# good: [e9f1cbc0c4114880090c7a578117d3b9cf184ad4] Merge tag 'acpi-5.14-rc1-2' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
git bisect start 'f55966571d5e' 'e9f1cbc0c411'
# bad: [b0dfd9af28b60d7ec42c359ae84c1ba97e093100] Merge tag 'clk-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux
git bisect bad b0dfd9af28b60d7ec42c359ae84c1ba97e093100
# bad: [364a716bd73e9846d3118a43f600f8f517658b38] Merge branch 'pci/host/intel-gw'
git bisect bad 364a716bd73e9846d3118a43f600f8f517658b38
# good: [c9fb9042c98df94197a1ba4cf14a77c8053b0fae] Merge branch 'pci/p2pdma'
git bisect good c9fb9042c98df94197a1ba4cf14a77c8053b0fae
# bad: [7132700067f234d37c234e5d711bb49ea06d2352] Merge branch 'pci/sysfs'
git bisect bad 7132700067f234d37c234e5d711bb49ea06d2352
# bad: [131e4f76c9ae9636046bf04d19d43af0e4ae9807] Merge branch 'pci/resource'
git bisect bad 131e4f76c9ae9636046bf04d19d43af0e4ae9807
# good: [411e2a43d210e98730713acf6d01dcf823ee35e3] PCI: Work around Huawei Intelligent NIC VF FLR erratum
git bisect good 411e2a43d210e98730713acf6d01dcf823ee35e3
# good: [e92605b0a0cdafb6c37b9d1ad24fe1cf8280eeb6] Merge branch 'pci/pm'
git bisect good e92605b0a0cdafb6c37b9d1ad24fe1cf8280eeb6
# bad: [65db04053efea3f3e412a7e0cc599962999c96b4] PCI: Coalesce host bridge contiguous apertures
git bisect bad 65db04053efea3f3e412a7e0cc599962999c96b4
# first bad commit: [65db04053efea3f3e412a7e0cc599962999c96b4] PCI: Coalesce host bridge contiguous apertures
