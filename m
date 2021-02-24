Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B092A3245E4
	for <lists+linux-pci@lfdr.de>; Wed, 24 Feb 2021 22:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbhBXVlT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Feb 2021 16:41:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:50538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232740AbhBXVlS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Feb 2021 16:41:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F5F564F03;
        Wed, 24 Feb 2021 21:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614202838;
        bh=Tzi1oSim8dQza2sBJydfCnnRECh/HC7rlaF/wb2l6zg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=XDAbHJrZbnKg2+O4eGbe2MUmHRexIEyxAGnUdWf1d6mNuOZssm1iIVtUVy2sVtZ3J
         LnBiURK5xwzxq9l+/1m6ZeY3/QwRBOgTpxP93M4gO8jjU3sQvVzU0XSmGIjlxcXHqa
         aXl3iPFQB+A87nLCnHuopP5h9Zd1zoAavrGzFEtmbGOYXx/zFEQpZRcTjE8dNsAThW
         fbUMKOgdSxkOl8fuS3X/rnHjmSIH2zlAWT+lXerGFLEfQzBdV6awSLQgsbNDP4FPmS
         D7IbWYj9bC6g4dK4Hr9idH2LON1yQDLFXd7z1w0y0C5C2F0kvn/VPMsXbXRMRMDU0J
         XaNBl6z6/JByw==
Date:   Wed, 24 Feb 2021 15:40:36 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [GIT PULL] PCI changes for v5.12
Message-ID: <20210224214036.GA1586541@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiUjFdHYxQzTPJX+J38iSz-hS8Sn9sNx=+B=uMX+Q3wwQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 24, 2021 at 11:21:44AM -0800, Linus Torvalds wrote:
> On Wed, Feb 24, 2021 at 11:03 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.12-changes
> 
> I pulled this, but I'm now unpulling it again.
> 
> Why are many of those commits only two hours old, and most of the rest
> is from yesterday?
> 
> Has any of this been in linux-next?

Sorry about the mess.  This has been in linux-next.  Most of the
recent commit dates are from typos I fixed in commit logs and
documentation patches.  A few are because I also sorted a few patches
onto different topic branches.

Here's a little history of the pci/next branch from linux-next and
from my pull request:

  next-20210222: pci/next 84c8d3d0b60e
  next-20210223: pci/next 4cb431e82c25
    $ git diff 84c8d3d0b60e 4cb431e82c25
    - fix documentation and comment typos, whitespace issues
    - add fc235fcb0f7c ("PCI: acpiphp: Remove unused acpiphp_callback typedef")
    - add f8ee579d53ac ("PCI: pci-bridge-emul: Fix array overruns, improve safety")
    - add f6bda644fa3a ("PCI: Fix pci_register_io_range() memory leak")
    - add d2bb2f9e1af6 ("PCI/ASPM: Move LTR, ASPM L1SS save/restore into PCIe save/restore")
    - add e34a4f0b7001 ("PCI/ASPM: Move LTR save/restore state functions earlier")

  next-20210224: pci/next 6039bd61b69f
    $ git diff 4cb431e82c25 6039bd61b69f
    - drop d2bb2f9e1af6 ("PCI/ASPM: Move LTR, ASPM L1SS save/restore into PCIe save/restore")
    - drop e34a4f0b7001 ("PCI/ASPM: Move LTR save/restore state functions earlier")
    - dropped these cosmetic changes

  pci-v5.12-changes: 2bd36c391515
    $ git diff 6039bd61b69f 2bd36c391515
    <empty>
    - no content changes; changed commit logs and moved patches
      between topic branches

  pci-v5.12-changes: e18fb64b7986 (updated)
    $ git diff 2bd36c391515 e18fb64b7986
    <empty>
    - no content changes; added Signed-off-by for patches moved to
      topic branch

I'll send you a new pull request because I forgot to add my sign-off
on a couple patches I had moved to a topic branch.

Sorry again.

Bjorn
