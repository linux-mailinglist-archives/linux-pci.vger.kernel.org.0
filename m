Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 760854032A3
	for <lists+linux-pci@lfdr.de>; Wed,  8 Sep 2021 04:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347460AbhIHC1f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Sep 2021 22:27:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347291AbhIHC1c (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Sep 2021 22:27:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F38B6115A;
        Wed,  8 Sep 2021 02:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631067982;
        bh=HYnHLjCiZ43UklggCXk+gEJ/KTCGLWfLyN/w5Nooqo8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=meJEv9TqnXEwjW9millMRGi8PpRu+yp0axW9Nlxys7xwmdqc0+9d+j9B+fQk5nysT
         lO89499TloTTBTPwaqlLJAp8wwIb1sauJlFW6Vdi4inK1xz7IAYYTd3BFzWgJbQhcH
         RqYgAyTmxSafTvb/KHU7aXiDp0w8K3GKkp9u08C9+5XmahgsGErmqduIZO656RF1Fs
         FDiPYqcoQ/4VEf16KtON7RDPrFYobFS7iKO9kw7vNuwJzxcQWo5JgRgD+H59ZkR/mp
         36+LW7CnXJq/qNpPjX6xI/wW+ziZOW07UaQEgEz0tCyDSxfUY96ZlCKR2rTGgw4+RL
         HJOgVz209Q3qw==
Date:   Tue, 7 Sep 2021 21:26:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Miller <davem@davemloft.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [GIT PULL] PCI changes for v5.15
Message-ID: <20210908022620.GA845134@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiCgh_V-g74LE4pQKqakbiK+CM5opVtH1t2+Y3R=uH9EA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 07, 2021 at 07:08:42PM -0700, Linus Torvalds wrote:
> On Tue, Sep 7, 2021 at 2:39 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> >   drivers/net/ethernet/broadcom/bnxt/bnxt.c
> >   drivers/net/ethernet/broadcom/bnx2.c
> >     Fallout from the VPD changes below.  These include both PCI core and
> >     driver changes, and the driver changes got merged via the net tree and
> >     then reverted so everything would be merged via the PCI tree.
> 
> Christ.
> 
> So the revert from the networking tree has basically _zero_ useful
> information. It just says "revert".

Sorry about that.  I intended to push my test merge in case you wanted
to see my resolution, but I forgot.  I just pushed it ("v5.15-merge"),
but I'm guessing you've already come up with the same resolution.

I was a little mystified about why there was a conflict at all, since
I expected those patches to apply cleanly on top of the revert, and I
should have investigated that more instead of just chalking it up to
my lack of git-fu.

Bjorn
