Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF32A1F3FB5
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jun 2020 17:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730922AbgFIPoV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jun 2020 11:44:21 -0400
Received: from mga14.intel.com ([192.55.52.115]:32389 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728903AbgFIPoU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Jun 2020 11:44:20 -0400
IronPort-SDR: x1PQhVfJKw0oFPhiHMSQ8hhoLNtys/bqJI8HJeO/Q/3BO4TaxxKyx4gyz1jl5AE3TXqjwIfrag
 raTnV4UDgCfQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2020 08:44:19 -0700
IronPort-SDR: B3OCjkA00+WDlux1lmQ1P9O1e4pJaj2LD9l02uW46lOwaDhjnF5OXOF6p9F2gYMvkW+Gnsg+Ka
 2B7QtNL69Agg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,492,1583222400"; 
   d="scan'208";a="379769157"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 09 Jun 2020 08:44:16 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 09 Jun 2020 18:44:16 +0300
Date:   Tue, 9 Jun 2020 18:44:16 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        it+linux-pci@molgen.mpg.de, amd-gfx@lists.freedesktop.org
Subject: Re: close() on some Intel CNP-LP PCI devices takes up to 2.7 s
Message-ID: <20200609154416.GU247495@lahna.fi.intel.com>
References: <b0781d0e-2894-100d-a4da-e56c225eb2a6@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b0781d0e-2894-100d-a4da-e56c225eb2a6@molgen.mpg.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 09, 2020 at 05:39:21PM +0200, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> On the Intel Cannon Point-LP laptop Dell Precision 3540 with a dedicated AMD
> graphics card (both graphics devices can be used) with Debian Sid/unstable
> with Linux 5.6.14, running lspci takes quite some time, and the screen even
> flickers a short moment before the result is displayed.
> 
> Tracing lspci with strace, shows that the close() function of the three
> devices takes from
> 
> •   00:1d.0 PCI bridge: Intel Corporation Cannon Point-LP PCI Express Root
> Port #9
> 
> •   04:00.0 System peripheral: Intel Corporation JHL6340 Thunderbolt 3 NHI
> (C step) [Alpine Ridge 2C 2016] (rev 02)
> 
> •   3b:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI] Lexa
> XT [Radeon PRO WX 3100]
> 
> takes from 270 ms to 2.5 s.
> 
> > 11:43:21.714391 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:04:00.0/config", O_RDONLY) = 3
> > 11:43:21.714448 pread64(3, "\206\200\331\25\6\4\20\0\2\0\200\10 \0\0\0\0\0\0\352\0\0\4\352\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0(\20\272\10\0\0\0\0\
> > 200\0\0\0\0\0\0\0\377\1\0\0", 64, 0) = 64
> > 11:43:24.487818 close(3)                = 0
> 
> > 11:43:24.489508 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:00:1d.0/config", O_RDONLY) = 3
> > 11:43:24.489598 pread64(3, "\206\200\260\235\7\4\20\0\360\0\4\6\20\0\201\0\0\0\0\0\0\0\0\0\0;;\00000\0  \354 \354\1\300\21\320\0\0\0\0\0\0\0\0\0\0\0\0
> > @\0\0\0\0\0\0\0\377\1\22\0", 64, 0) = 64
> > 11:43:24.966661 close(3)                = 0
> 
> > 11:43:24.988544 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:3b:00.0/config", O_RDONLY) = 3
> > 11:43:24.988584 pread64(3, "\2\20\205i\7\4\20\0\0\0\200\3\20\0\0\0\f\0\0\300\0\0\0\0\f\0\0\320\0\0\0\0\0010\0\0\0\0 \354\0\0\0\0(\20\272\10\0\0$\354H\0\0\0\0\0\0\0\377\1\0\0", 64, 0) = 64
> > 11:43:25.252745 close(3)
> 
> Unfortunately, I forgot to collect the tree output, but hopefully the
> attached Linux messages and strace of lspci output will be enough for the
> start.
> 
> Please tell me, if you want me to create a bug report in the Linux bug
> tracker.

Can you try this commit?

  https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=pci/pm&id=ec411e02b7a2e785a4ed9ed283207cd14f48699d

It should be in the mainline already as well.

Note we still need to obey the delays required by the PCIe spec so 100ms
after the link is trained but this one should at least get it down from
1100ms.
