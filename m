Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37AFF43F1A
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2019 17:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731581AbfFMPyS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 11:54:18 -0400
Received: from verein.lst.de ([213.95.11.211]:36725 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731572AbfFMIyc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Jun 2019 04:54:32 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 2E87468B02; Thu, 13 Jun 2019 10:54:03 +0200 (CEST)
Date:   Thu, 13 Jun 2019 10:54:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <keith.busch@gmail.com>
Cc:     Daniel Drake <drake@endlessm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux PCI <linux-pci@vger.kernel.org>,
        linux-ide@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Subject: Re: [PATCH] PCI: Add Intel remapped NVMe device support
Message-ID: <20190613085402.GC13442@lst.de>
References: <20190610074456.2761-1-drake@endlessm.com> <CAOSXXT7OFzHeTxNqZ1sS6giRxhDcrUUnVjURWBiFUc5T_8p=MA@mail.gmail.com> <CAD8Lp45djPU_Ur8uCO2Y5Sbek_5N9QKkxLXdKNVcvkr6rFPLUQ@mail.gmail.com> <CAOSXXT7H6HxY-za66Tr9ybRQyHsTdwwAgk9O2F=xK42MT8HsuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOSXXT7H6HxY-za66Tr9ybRQyHsTdwwAgk9O2F=xK42MT8HsuA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 12, 2019 at 08:32:46AM -0600, Keith Busch wrote:
> On Mon, Jun 10, 2019 at 8:46 PM Daniel Drake <drake@endlessm.com> wrote:
> > What's the specific problem that you see here?
> 
> Performance. Have you had a chance to benchmark these storage devices
> comparing legacy vs MSI interrupts? I don't think anyone would chose
> the slower one on purpose. These platforms have an option to disable
> raid mode, so the kernel's current recommendation should be the user's
> best option.

And it isn't just performance.  I really don't understand how

 a) quirks on the PCI ID
 b) reset handling, including the PCI device removal as the last
    escalation step
 c) SR-IOV VFs and their management
 d) power management

and probably various other bits I didn't even think of are going to
work.

So until we get very clear and good documentation from Intel on that
I don't think any form of upstream support will fly.  And given that
Dan who submitted the original patch can't even talk about this thing
any more and apparently got a gag order doesn't really give me confidence
any of this will ever work.
