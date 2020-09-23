Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3121276303
	for <lists+linux-pci@lfdr.de>; Wed, 23 Sep 2020 23:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgIWVXV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Sep 2020 17:23:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:53548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgIWVXV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Sep 2020 17:23:21 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 979A321D43;
        Wed, 23 Sep 2020 21:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600896199;
        bh=Zgn3c+UxEDUOIiDQMN544vj+WQGJs1d6/Kld3xA69RQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=saYFYIk4jQCylMNnOdIvcx39qNmSoL+cfMEeuMAHIyKXqNZhvROpBDSmC6+8eA8cO
         6HKpnNQHtLXKSzYKl9xb2tsgrEzhcEaiBwuTIWMy2eo6KYG2oYlZiPTmBge3xGgUqm
         4hDeIU7Zs7ORPFLKVrvcMg+SBWdWXwfNLs8PmGaY=
Date:   Wed, 23 Sep 2020 16:23:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ian Kumlien <ian.kumlien@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: Re: [PATCH] Use maximum latency when determining L1/L0s ASPM v2
Message-ID: <20200923212318.GA2295660@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA85sZs5f09uh+eCcZ+2Mh4Hj=GVVncZjyGR8Ru3vBQ3Z-_nNA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 23, 2020 at 01:29:18AM +0200, Ian Kumlien wrote:
> On Wed, Sep 23, 2020 at 1:00 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Sep 22, 2020 at 11:02:35PM +0200, Ian Kumlien wrote:

> > > commit db3d9c4baf4ab177d87b5cd41f624f5901e7390f
> > > Author: Ian Kumlien <ian.kumlien@gmail.com>
> > > Date:   Sun Jul 26 16:01:15 2020 +0200
> > >
> > >     Use maximum latency when determining L1 ASPM
> > >
> > >     If it's not, we clear the link for the path that had too large latency.
> > >
> > >     Currently we check the maximum latency of upstream and downstream
> > >     per link, not the maximum for the path
> > >
> > >     This would work if all links have the same latency, but:
> > >     endpoint -> c -> b -> a -> root  (in the order we walk the path)
> > >
> > >     If c or b has the higest latency, it will not register
> > >
> > >     Fix this by maintaining the maximum latency value for the path
> > >
> > >     See this bugzilla for more information:
> > >     https://bugzilla.kernel.org/show_bug.cgi?id=208741
> > >
> > >     This fixes an issue for me where my desktops machines maximum bandwidth
> > >     for remote connections dropped from 933 MBit to ~40 MBit.
> > >
> > >     The bug became obvious once we enabled ASPM on all links:
> > >     66ff14e59e8a (PCI/ASPM: Allow ASPM on links to PCIe-to-PCI/PCI-X Bridges)
> >
> > I can't connect the dots here yet.  I don't see a PCIe-to-PCI/PCI-X
> > bridge in your lspci, so I can't figure out why this commit would make
> > a difference for you.
> >
> > IIUC, the problem device is 03:00.0, the Intel I211 NIC.  Here's the
> > path to it:
> >
> >   00:01.2 Root Port              to [bus 01-07]
> >   01:00.0 Switch Upstream Port   to [bus 02-07]
> >   02:03.0 Switch Downstream Port to [bus 03]
> >   03:00.0 Endpoint (Intel I211 NIC)
> >
> > And I think this is the relevant info:
> >
> >                                                     LnkCtl    LnkCtl
> >            ------DevCap-------  ----LnkCap-------  -Before-  -After--
> >   00:01.2                                L1 <32us       L1+       L1-
> >   01:00.0                                L1 <32us       L1+       L1-
> >   02:03.0                                L1 <32us       L1+       L1+
> >   03:00.0  L0s <512ns L1 <64us  L0s <2us L1 <16us  L0s- L1-  L0s- L1-
> >
> > The NIC says it can tolerate at most 512ns of L0s exit latency and at
> > most 64us of L1 exit latency.
> >
> > 02:03.0 doesn't support L0s, and the NIC itself can't exit L0s that
> > fast anyway (it can only do <2us), so L0s should be out of the picture
> > completely.
> >
> > Before your patch, apparently we (or BIOS) enabled L1 on the link from
> > 00:01.2 to 01:00.0, and partially enabled it on the link from 02:03.0
> > to 03:00.0.
> 
> According to the spec, this is managed by the OS - which was the
> change introduced...

BIOS frequently enables ASPM and, if CONFIG_PCIEASPM_DEFAULT=y, I
don't think Linux touches it unless a user requests it via sysfs.

What does "grep ASPM .config" tell you?

Boot with "pci=earlydump" and the dmesg will tell us what the BIOS
did.

If you do this in the unmodified kernel:

  # echo 1 > /sys/.../0000:03:00.0/l1_aspm

it should enable L1 for 03:00.0.  I'd like to know whether it actually
does, and whether the NIC behaves any differently when L1 is enabled
for the entire path instead of just the first three components.

If the above doesn't work, you should be able to enable ASPM manually:

  # setpci -s03:00.0 CAP_EXP+0x10.w=0x0042

> > It looks like we *should* be able to enable L1 on both links since the
> > exit latency should be <33us (first link starts exit at T=0, completes
> > by T=32; second link starts exit at T=1, completes by T=33), and
> > 03:00.0 can tolerate up to 64us.
> >
> > I guess the effect of your patch is to disable L1 on the 00:01.2 -
> > 01:00.0 link?  And that makes the NIC work better?  I am obviously
> > missing something because I don't understand why the patch does that
> > or why it works better.
> 
> It makes it work like normal again, like if i disable ASPM on the
> nic itself...

I wonder if ASPM is just broken on this device.
__e1000e_disable_aspm() mentions hardware errata on a different Intel
NIC.

> I don't know which value that reflects, up or down - since we do max
> of both values and
> it actually disables ASPM.
> 
> What we can see is that the first device that passes the threshold
> is 01:00.0

I don't understand this.  03:00.0 claims to be able to tolerate 64us
of L1 exit latency.  The path should only have <33us of latency, so
it's not even close to the 64us threshold.

> How can I read more data from PCIe without needing to add kprint...
> 
> This is what lspci uses apparently:
> #define  PCI_EXP_LNKCAP_L0S     0x07000 /* L0s Exit Latency */
> #define  PCI_EXP_LNKCAP_L1      0x38000 /* L1 Exit Latency */
> 
> But which latencies are those? up or down?

I think the idea in aspm.c that exit latencies depend on which
direction traffic is going is incorrect.  The components at the
upstream and downstream ends of the link may have different exit
latencies, of course.
