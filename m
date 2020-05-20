Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEBDE1DC2F6
	for <lists+linux-pci@lfdr.de>; Thu, 21 May 2020 01:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbgETX36 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 19:29:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:56314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728552AbgETX36 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 May 2020 19:29:58 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A2EE20759;
        Wed, 20 May 2020 23:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590017397;
        bh=ml/5Lrb2JgHgCp2VG6AK9LVynTzj51rBivW+PswI6+o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UIPVLuZVgVbu1MDPPDKLeIa1NDT6Suo3tfoROlVkPKt4JxkVPkITrhDdxjUoEDl03
         u9ml8rR7GHi4lFOgXalX0yl0wEn4QnTR/y1JqjVtTnPzuFQz+J7L9P/r9m4GaAGsTi
         iDXhPf8tdcezG3ysThtzWSDIe5tNByC/DzJW3Fbs=
Date:   Wed, 20 May 2020 18:29:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marcos Scriven <marcos@scriven.org>
Cc:     linux-pci@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] PCI: Avoid FLR for AMD Matisse HD Audio and USB
 Controllers
Message-ID: <20200520232954.GA1124908@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAri2DoF-6A3qcag4etdWh3vQQUGqzfebw6syeU8HFeph5tWQw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 20, 2020 at 10:41:03AM +0100, Marcos Scriven wrote:
> On Mon, 18 May 2020 at 20:26, Marcos Scriven <marcos@scriven.org> wrote:
> >
> > On Mon, 18 May 2020 at 17:17, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >
> > > [+cc Alex]
> > >
> > > On Sat, May 16, 2020 at 02:37:23PM +0100, Marcos Scriven wrote:
> > > > This patch fixes an FLR bug on the following two devices:
> > > >
> > > > AMD Matisse HD Audio Controller 0x1487
> > > > AMD Matisse USB 3.0 Host Controller 0x149c
> > > >
> > > > As there was already such a quirk for an Intel network device, I have
> > > > renamed that method and updated the comments, trying to make it
> > > > clearer what the specific original devices that were affected are
> > > > (based on the commit message this was original done:
> > > > https://git.thm.de/mhnn55/eco32-linux-ba/commit/f65fd1aa4f9881d5540192d11f7b8ed2fec936db).
> > > >
> > > > I have ordered them by hex product ID.
> > > >
> > > > I have verified this works on a X570 I AORUS PRO WIFI (rev. 1.0) motherboard.
> > >
> > > If we avoid FLR, is there another method used to reset these devices
> > > between attachments to different VMs?  Does the lack of FLR mean we
> > > can leak information between VMs?
> > >
> > > Would additional delay after the FLR work around this, e.g., something
> > > like 51ba09452d11 ("PCI: Delay after FLR of Intel DC P3700 NVMe")?
> > >
> >
> > Thanks for looking at this patch Bjorn.
> >
> > To take your three points:
> >
> > 1. Certainly I can see those devices able to be passed back and forth
> > between host and guest multiple times, once this patch is applied.
> >
> > 2. I don't know the answer to that question; would appreciate guidance
> > on how to determine this. Do you mean perhaps some buffered data in
> > the USB controller, for instance?
> >
> > 3. I have not tried an additional delay. This is the logs I see when
> > the error is occurring:
> >
> > [ 2423.556570] vfio-pci 0000:0c:00.3: not ready 1023ms after FLR; waiting
> > [ 2425.604526] vfio-pci 0000:0c:00.3: not ready 2047ms after FLR; waiting
> > [ 2428.804509] vfio-pci 0000:0c:00.3: not ready 4095ms after FLR; waiting
> > [ 2433.924409] vfio-pci 0000:0c:00.3: not ready 8191ms after FLR; waiting
> > [ 2443.140721] vfio-pci 0000:0c:00.3: not ready 16383ms after FLR; waiting
> > [ 2461.571944] vfio-pci 0000:0c:00.3: not ready 32767ms after FLR; waiting
> > [ 2496.387544] vfio-pci 0000:0c:00.3: not ready 65535ms after FLR; giving up
> >
> > What makes this bug especially bad is the host never recovers, and
> > eventually hangs or crashes.
> >
> > For reference, the delay example you're talking about is:
> >
> > static int delay_250ms_after_flr(struct pci_dev *dev, int probe)
> > {
> > if (!pcie_has_flr(dev))
> > return -ENOTTY;
> >
> > if (probe)
> > return 0;
> >
> > pcie_flr(dev);
> >
> > msleep(250);
> >
> > return 0;
> > }
> >
> > I don't know if it would work, but I will try it out and report back.
> >
> > Marcos
> >
> >
> 
> Bjorn/Alex
> 
> I have just tried the alternate approach of adding a 250ms delay to
> the function level reset - this unfortunately results in the same
> broken behaviour, with the host itself never recovering.
> 
> [   76.905410] vfio-pci 0000:0d:00.3: not ready 1023ms after FLR; waiting
> [   79.018014] vfio-pci 0000:0d:00.3: not ready 2047ms after FLR; waiting
> [   82.089390] vfio-pci 0000:0d:00.3: not ready 4095ms after FLR; waiting
> [   87.209416] vfio-pci 0000:0d:00.3: not ready 8191ms after FLR; waiting
> [   96.425440] vfio-pci 0000:0d:00.3: not ready 16383ms after FLR; waiting
> [  114.615491] vfio-pci 0000:0d:00.3: not ready 32767ms after FLR; waiting
> [  149.417712] vfio-pci 0000:0d:00.3: not ready 65535ms after FLR; giving up
> 
> I also tried a full second, to no avail.
> 
> What would be the next step in proceeding with the original patch please?

Implementation of FLR is "strongly recommended" by the spec but is
optional.  So I don't see a problem with just avoiding it via your
patch.

I applied it to pci/virtualization for v5.8, thanks!

Bjorn
