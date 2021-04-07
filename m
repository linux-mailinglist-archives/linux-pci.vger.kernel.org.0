Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D143565DF
	for <lists+linux-pci@lfdr.de>; Wed,  7 Apr 2021 09:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235082AbhDGH7p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Apr 2021 03:59:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:39682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229529AbhDGH7o (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Apr 2021 03:59:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF597611C1;
        Wed,  7 Apr 2021 07:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617782375;
        bh=1rw7Kb/JSlr5mc5WyLCitVbVfwtpHINc2U5b/i3f+nk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HaYd/I9GGJCp5RfO6pYB0kEnjF/AwRxRvsrqkpF5Eb7PANSCkCxFYTaM2qhoEmuS4
         6d4AG1xZVmLL6Gs2IeUbjPH8wg4pXkJ8UgOG/A6FSkA8nwKxS//mMLN4vtXIxo4P1g
         CEzkOKQrb7BCdqN8gzh4mPZfAEO5qV1avUglG33uAhifV4ss2Nceu4/TbzoJ37BpkV
         8/KXDokZZOwiUdaHNnk7NOST60h9uYbSol/al+hkErO1OKJ4vUbTHsHnh434D9BDgq
         e3feI0Qjd2r6JiivL5De05pup50CFITnoc2MGMdX7/C+yFUVKaSaODtskYwcT1g9m2
         ynYPt51crh97g==
Date:   Wed, 7 Apr 2021 10:59:31 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: merge slot and bus reset implementations
Message-ID: <YG1mY7HfMD6zIKJV@unreal>
References: <20210401053656.16065-1-raphael.norwitz@nutanix.com>
 <YGW8Oe9jn+n9sVsw@unreal>
 <20210401105616.71156d08@omen>
 <YGlzEA5HL6ZvNsB8@unreal>
 <20210406081626.31f19c0f@x1.home.shazbot.org>
 <YG1eBUY0vCTV+Za/@unreal>
 <YG1j7+Mj4IiparPe@rocinante>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YG1j7+Mj4IiparPe@rocinante>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 07, 2021 at 09:49:03AM +0200, Krzysztof Wilczyński wrote:
> [+cc Greg for visibility]
> 
> Hello,
> 
> [...]
> > > > > > The previous coding style is preferable one in the Linux kernel.
> > > > > > int rc = pci_dev_reset_slot_function(dev, probe);
> > > > > > if (rc != -ENOTTY)
> > > > > >   return rc;
> > > > > > return pci_parent_bus_reset(dev, probe);  
> > > > > 
> > > > > 
> > > > > That'd be news to me, do you have a reference?  I've never seen
> > > > > complaints for ternaries previously.  Thanks,  
> > > > 
> > > > The complaint is not to ternaries, but to the function call as one of
> > > > the parameters, that makes it harder to read.
> > > 
> > > Sorry, I don't find a function call as a parameter to a ternary to be
> > > extraordinary, nor do I find it to be a discouraged usage model within
> > > the kernel.  This seems like a pretty low bar for hard to read code.
> > 
> > It is up to us where this bar is set.
> 
> The only person who ever pulled my ear, so to speak, over using ternary
> was Greg as a bad style where, especially where it does not need to be
> used.

Good to hear that I'm not alone.

> 
> But, I digress.  I humbly think that we should move back on track and
> finish review of Raphael's patch.  Would use a ternary here be
> a show-stopper?

Of course no, I would fix it locally when apply.

Thanks

> 
> Krzysztof
