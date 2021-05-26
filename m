Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2ED39183B
	for <lists+linux-pci@lfdr.de>; Wed, 26 May 2021 14:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbhEZNBR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 May 2021 09:01:17 -0400
Received: from verein.lst.de ([213.95.11.211]:34829 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232103AbhEZNBR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 May 2021 09:01:17 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0E26967373; Wed, 26 May 2021 14:59:43 +0200 (CEST)
Date:   Wed, 26 May 2021 14:59:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Keith Busch <kbusch@kernel.org>, Koba Ko <koba.ko@canonical.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Henrik Juul Hansen <hjhansen2020@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] nvme-pci: Avoid to go into d3cold if device can't use
 npss.
Message-ID: <20210526125942.GA25080@lst.de>
References: <20210520033315.490584-1-koba.ko@canonical.com> <20210525074426.GA14916@lst.de> <CAJB-X+UFi-iAkRBZQUsd6B_P+Bi-TAa_sQjnhJagD0S91WoFUQ@mail.gmail.com> <20210526024934.GB3704949@dhcp-10-100-145-180.wdc.com> <CAAd53p7xabD2t__=t67uRLrrFOB7YGgr_GMhi6L48PFGhNe80w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAd53p7xabD2t__=t67uRLrrFOB7YGgr_GMhi6L48PFGhNe80w@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 26, 2021 at 08:11:41PM +0800, Kai-Heng Feng wrote:
> On Wed, May 26, 2021 at 10:49 AM Keith Busch <kbusch@kernel.org> wrote:
> >
> > On Wed, May 26, 2021 at 10:02:27AM +0800, Koba Ko wrote:
> > > On Tue, May 25, 2021 at 3:44 PM Christoph Hellwig <hch@lst.de> wrote:
> > > >
> > > > On Thu, May 20, 2021 at 11:33:15AM +0800, Koba Ko wrote:
> > > > > After resume, host can't change power state of the closed controller
> > > > > from D3cold to D0.
> > > >
> > > > Why?
> > > As per Kai-Heng said, it's a regression introduced by commit
> > > b97120b15ebd ("nvme-pci:
> > > use simple suspend when a HMB is enabled"). The affected NVMe is using HMB.
> >
> > That really doesn't add up. The mentioned commit restores the driver
> > behavior for HMB drives that existed prior to d916b1be94b6d from kernel
> > 5.3. Is that NVMe device broken in pre-5.3 kernels, too?
> 
> Quite likely. The system in question is a late 2020 Ice Lake laptop,
> so it was released after 5.3 kernel.

This is just a mess.  We had to disable the sensible power state based
suspend on these systems because Intel broke it by just cutting the power
off.  And now the shutdown based one doesn't work either because it can't
handle d3cold.  Someone we need to stop Intel and the integrators from
doing stupid things, and I'm not sure how.

But degrading all systems even more is just a bad idea, so I fear we'll
need a quirk again.  Can you figure out by switching the cards if this
is the fault of the platform or the nvme device?

> 
> Kai-Heng
---end quoted text---
