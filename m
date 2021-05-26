Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB88A391A1F
	for <lists+linux-pci@lfdr.de>; Wed, 26 May 2021 16:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbhEZO3n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 May 2021 10:29:43 -0400
Received: from verein.lst.de ([213.95.11.211]:35171 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233217AbhEZO3n (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 May 2021 10:29:43 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6DCCA67373; Wed, 26 May 2021 16:28:09 +0200 (CEST)
Date:   Wed, 26 May 2021 16:28:09 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Koba Ko <koba.ko@canonical.com>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Henrik Juul Hansen <hjhansen2020@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] nvme-pci: Avoid to go into d3cold if device can't use
 npss.
Message-ID: <20210526142809.GA32077@lst.de>
References: <20210520033315.490584-1-koba.ko@canonical.com> <20210525074426.GA14916@lst.de> <CAJB-X+UFi-iAkRBZQUsd6B_P+Bi-TAa_sQjnhJagD0S91WoFUQ@mail.gmail.com> <20210526024934.GB3704949@dhcp-10-100-145-180.wdc.com> <CAAd53p7xabD2t__=t67uRLrrFOB7YGgr_GMhi6L48PFGhNe80w@mail.gmail.com> <20210526125942.GA25080@lst.de> <CAAd53p4f2ZFsVRv-Q9maPBSD_uGjj7FoYKYy9MGjBPc6chk_1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAd53p4f2ZFsVRv-Q9maPBSD_uGjj7FoYKYy9MGjBPc6chk_1Q@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 26, 2021 at 10:21:59PM +0800, Kai-Heng Feng wrote:
> To be fair, resuming the NVMe from D3hot is much slower than keep it
> at D0, which gives us a faster s2idle resume time. And now AMD also
> requires s2idle on their latest laptops.

We'd much prefer to use it, but due to the broken platforms we can't
unfortunately.

> And it's more like NVMe controllers don't respect PCI D3hot.

What do you mean with that?

> Because the NVMe continues to work after s2idle and the symbol is
> rather subtle, so I suspect this is not platform or vendor specific.
> Is it possible to disable DMA for HMB NVMe on suspend?

Not in shipping products.  The NVMe technical working group is working
on a way to do that, but it will take a while until that shows up in
products.
