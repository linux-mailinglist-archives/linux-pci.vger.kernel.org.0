Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 259623D4308
	for <lists+linux-pci@lfdr.de>; Sat, 24 Jul 2021 00:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbhGWWDE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Jul 2021 18:03:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:46468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231954AbhGWWDE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 23 Jul 2021 18:03:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E68B60E92;
        Fri, 23 Jul 2021 22:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627080216;
        bh=6EN36z09hEeXoO/5efY7I2rKYLkgTb0P2gte2sdaLGk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=a2U97qiMngddptFL6b9JS1yxtny8DN+6PSvGW+PkQo0WqghRdTI6A4T9fH71Jw05M
         L8jIfJpo1HCUicXTVJboCuck6BtgAEe8hgPPoMnF0mUM9eH0N3EgaYLCyDAa6FFQ2/
         e2gkHv3Xwt9D1mE/ZbrDswxLBz1mr1JGxMJD1aEMelvL6g1p/Nrh0aWatzUdICCPZ0
         FbsZRPo+StAgJ8VpdrsOVzQCt9vMBKnKr92Lfx53dbqqst0d8scMW++LzShHEQbbzb
         zkT8tvjtBalB6g80ZOvpCJtdsGrNIR8BjMv+KEWQsHcHI+ybquXwPWlcHSdK6DDCPT
         aNkE89IKQGIGw==
Date:   Fri, 23 Jul 2021 17:43:35 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        David Airlie <airlied@linux.ie>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 0/9] PCI/VGA: Rework default VGA device selection
Message-ID: <20210723224335.GA446523@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPp9XCa+1kS/s3wK@phenom.ffwll.local>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 23, 2021 at 10:27:08AM +0200, Daniel Vetter wrote:
> On Fri, Jul 23, 2021 at 06:51:59AM +0100, Christoph Hellwig wrote:
> > On Thu, Jul 22, 2021 at 04:29:11PM -0500, Bjorn Helgaas wrote:
> > > From: Bjorn Helgaas <bhelgaas@google.com>
> > > 
> > > This is a little bit of rework and extension of Huacai's nice work at [1].
> > > 
> > > It moves the VGA arbiter to the PCI subsystem, fixes a few nits, and breaks
> > > a few pieces off Huacai's patch to make the main patch a little smaller.
> > > 
> > > That last patch is still not very small, and it needs a commit log, as I
> > > mentioned at [2].
> > 
> > FYI, I have a bunch of changes to this code that the drm maintainers
> > picked up.  They should show up in the next linux-next I think.
> 
> Yeah I think for merging I think there'll be two options:
> 
> - We also merge this series through drm-misc-next to avoid conflicts, but
>   anything after that will (i.e. from 5.16-rc1 onwards) will go in through
>   the pci tree.
> 
> - You also merge Christoph's series, and we tell Linus to ignore the
>   vgaarb changes that also come in through drm-next pull.
> 
> It's a non-rebasing tree so taking them out isn't an option, and reverting
> feels silly. Either of the above is fine with me.

Seems easiest/cleanest if I just fix this up so it applies on top of
drm-misc-next, e.g., on top of this:

  474596fc749c ("dt-bindings: display: simple-bridge: Add corpro,gm7123 compatible")

I'll post a v3 after that rebase and working on the commit log from
Huacai.

Bjorn
