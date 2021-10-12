Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B364242AFFF
	for <lists+linux-pci@lfdr.de>; Wed, 13 Oct 2021 01:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234098AbhJLXOH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Oct 2021 19:14:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:42038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229588AbhJLXOH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Oct 2021 19:14:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9AC8A60C49;
        Tue, 12 Oct 2021 23:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634080324;
        bh=XqxlPp6YkN/WfuyoQ/c4x1VlZQyfuu5pa8exw8RscaE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jdFYDK5QGubWgrvW5Hj9GLJ3T8+p4EkaPRYileJCu4dc06QLkKtJkWtWej+ANZTvG
         /reHq7mNkzEyWunsPNpVSRnZrnqYaaAjLn53xDnSgQmC5leZLXvsMhEmeOBt+Be1GV
         2NOph/7YdMT/a0shKsXNDy57o+LC+ZXuo+aJigxGVRhtdJnB+4/yIzQM/V1eRJLUlY
         5ckQOEX9qIcgMNS2YoAgSLREla4ghiZ/yDXRAysVyACjqr+mxrhv/oKKvabPVf0Hmd
         2rz2bGLth2UJ2dysQfm6F+t6gVRr9BUDy71iwhoNj9R/R/czw9e/VLH9nj7NjHAZHY
         5mYb2UjzixkVw==
Received: by pali.im (Postfix)
        id 08EB67B4; Wed, 13 Oct 2021 01:12:01 +0200 (CEST)
Date:   Wed, 13 Oct 2021 01:12:01 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Naveen Naidu <naveennaidu479@gmail.com>
Cc:     Lukas Wunner <lukas@wunner.de>, bhelgaas@google.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: Re: [PATCH 16/22] PCI: pciehp: Use RESPONSE_IS_PCI_ERROR() to check
 read from hardware
Message-ID: <20211012231201.xj7fvfgvpde5wwrl@pali>
References: <cover.1633972263.git.naveennaidu479@gmail.com>
 <36c7c3005c4d86a6884b270807d84433a86c0953.1633972263.git.naveennaidu479@gmail.com>
 <20211011194740.GA14357@wunner.de>
 <20211012160505.3dov6gjnmxdq5lz6@theprophet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012160505.3dov6gjnmxdq5lz6@theprophet>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 12 October 2021 21:35:13 Naveen Naidu wrote:
> On 11/10, Lukas Wunner wrote:
> > On Mon, Oct 11, 2021 at 11:37:33PM +0530, Naveen Naidu wrote:
> > > An MMIO read from a PCI device that doesn't exist or doesn't respond
> > > causes a PCI error.  There's no real data to return to satisfy the
> > > CPU read, so most hardware fabricates ~0 data.
> > > 
> > > Use RESPONSE_IS_PCI_ERROR() to check the response we get when we read
> > > data from hardware.
> > 
> > Actually what happens is that PCI read transactions *time out*,
> > so the host controller fabricates a response.
> >
> 
> Ah! yes. Now that I look at it, RESPONSE_IS_PCI_TIMEOUT() does indeed
> seem like a better option to RESPONSE_IS_PCI_ERROR(), since it's more
> specfic and depicts the actual condition. 

This is not fully correct. 0xffffffff is returned when some error
happens. It does not have to be timeout error. Errors like Unsupported
Request, Completer Abort or Configuration Request Retry Status (when
CRSSVE bit is disabled) are also reported as 0xffffffff and they do not
represent timeout. For example Unsupported Request is returned when you
try to read from non-existent device behind some PCIe switch.

Also pci-aardvark.c fabricates value 0xffffffff when trying to read from
config space below the PCIe Root Port when PCIe link is not up.

And I have seen that Completer Abort was returned by PCIe switch when
switch itself did not received reply from device below switch. So it
means that controller can receive some reply from other device even when
no real reply was sent. Which means that timeout can be reported by some
other message.

So I think that generic PCI_ERROR is the best name. You do not know what
really happened (only some controller drivers can provide additional
information, it does not have any standard HW<-->OS API) and application
logic must decide how to process error.

> I'll wait for sometime and see if others have any objection/a better
> name for the macro and then redo the patch with that.
> 
> Thank you very much for the review ^^ 
> 
> > By contrast, a PCI *error* usually denotes an Uncorrectable or
> > Correctable Error as specified in section 6.2.2 of the PCIe Base Spec.
> > 
> > Thus something like RESPONSE_IS_PCI_TIMEOUT() or IS_PCI_TIMEOUT() would
> > probably be more appropriate.  I'll leave the exact bikeshed color for
> > others to decide. :-)
> > 
> > 
> > > Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
> > > ---
> > >  drivers/pci/hotplug/pciehp_hpc.c | 10 +++++-----
> > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > Acked-by: Lukas Wunner <lukas@wunner.de>
