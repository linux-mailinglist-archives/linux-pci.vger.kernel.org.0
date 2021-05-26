Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58FFC391B29
	for <lists+linux-pci@lfdr.de>; Wed, 26 May 2021 17:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbhEZPIH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 May 2021 11:08:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:34924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235188AbhEZPIH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 May 2021 11:08:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D09060C3D;
        Wed, 26 May 2021 15:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622041595;
        bh=Oy7BgTGryKAyp8xe25xWfjrue9Y5RYNIPBC147pGbFo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=niMC04LJXYXUtzW2Dcb2+dtMvOUv6SPJoC38MhVLRfGrARD2vKV5HnC4kTDzCFsaf
         HBJ0YjHY7iiKCugbbQ7iAtNe+PhhN56l0Suz4Py6ZvdALce+9GoJjrw8DPRzuW5uRi
         eL2F4OvDf6Czl3/XhIvDOG/VQpj1PFiR6F7iddWKy7+mPTBDR+umbrk0UdRtYuu73L
         sM8k+3P3+7yysf3qw6fUzr6/clnnVNc7397aIPvEzVcelzW/DiM7I989qRRgUsBiJt
         WGWpl1cmZb2Rly67CcMDMbX53C8wEXLsoX7ld5W+uf+HEncJLYQ70oVxre3iPdbfmO
         4tdyjhbNtsrVQ==
Date:   Wed, 26 May 2021 10:06:33 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
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
Message-ID: <20210526150633.GA1291513@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAd53p6TJev=LgdvGxC92A9HOy3B6jbPLymAqeB5bDe2=5Fdsw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 26, 2021 at 10:47:13PM +0800, Kai-Heng Feng wrote:
> On Wed, May 26, 2021 at 10:28 PM Christoph Hellwig <hch@lst.de> wrote:
> > On Wed, May 26, 2021 at 10:21:59PM +0800, Kai-Heng Feng wrote:
> > > To be fair, resuming the NVMe from D3hot is much slower than keep it
> > > at D0, which gives us a faster s2idle resume time. And now AMD also
> > > requires s2idle on their latest laptops.
> >
> > We'd much prefer to use it, but due to the broken platforms we can't
> > unfortunately.
> >
> > > And it's more like NVMe controllers don't respect PCI D3hot.
> >
> > What do you mean with that?
> 
> Originally, we found that under s2idle, most NVMe controllers caused
> substantially more power if D3hot was used.
> We were told by all the major NVMe vendors that D3hot is not
> supported. 

What is this supposed to mean?  PCIe r5.0, sec 5.3.1, says

  All Functions must support the D0 and D3 states (both D3Hot and D3Cold).

Since D3hot is required for all functions, I don't think there is a
standard way to discover whether D3hot is supported.  The PM
Capability (sec 7.5.2.1) has D1_Support and D2_Support bits, but no
D3_Support bit.

Are the vendors just saying "sorry, our devices don't conform to the
spec"?

If what you really mean is "D3hot is supported and it works, but it
consumes more power than expected, or the D3hot->D0 transition takes
longer than expected," that's a totally different thing, and you should
say *that*.

Bjorn
