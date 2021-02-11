Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3184318CEA
	for <lists+linux-pci@lfdr.de>; Thu, 11 Feb 2021 15:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbhBKOE7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Feb 2021 09:04:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:40040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232137AbhBKOCt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Feb 2021 09:02:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E213664E87;
        Thu, 11 Feb 2021 14:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613052127;
        bh=N3FdnEf62xzBxUf3oHuaKM8tF+xyEqRWT4QycOAyd+c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oZ2U5HXz5+NgpwRbjtD87mUxrlPYCi3MPMsF9EKKREC4DcYU+lGux32QOv/BHKuS2
         WOGlacxqBW8/7bL0C94LfPzU1OPL6zuVxV3Y0Tx4dnS2oGbY7FSM9yK8hhkgYyBnxF
         SZ6Ug8B5yhLxdCiHk1L1oJMdak0WnuEP1qBsxSWE=
Date:   Thu, 11 Feb 2021 15:02:03 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v5 1/6] misc: Add Synopsys DesignWare xData IP driver
Message-ID: <YCU42zUbtGEvYVQ/@kroah.com>
References: <cover.1613034397.git.gustavo.pimentel@synopsys.com>
 <02835da8fc8c9293fecbe666a8db3fb79276fdde.1613034397.git.gustavo.pimentel@synopsys.com>
 <20210211114243.GH1275163@unreal>
 <YCUjzeR1ZMX2uVH7@kroah.com>
 <20210211135019.GI1275163@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211135019.GI1275163@unreal>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 11, 2021 at 03:50:19PM +0200, Leon Romanovsky wrote:
> On Thu, Feb 11, 2021 at 01:32:13PM +0100, Greg Kroah-Hartman wrote:
> > On Thu, Feb 11, 2021 at 01:42:43PM +0200, Leon Romanovsky wrote:
> > > On Thu, Feb 11, 2021 at 10:08:38AM +0100, Gustavo Pimentel wrote:
> > > > Add Synopsys DesignWare xData IP driver. This driver enables/disables
> > > > the PCI traffic generator module pertain to the Synopsys DesignWare
> > > > prototype.
> > > >
> > > > Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > > > ---
> > > >  drivers/misc/dw-xdata-pcie.c | 394 +++++++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 394 insertions(+)
> > > >  create mode 100644 drivers/misc/dw-xdata-pcie.c
> > >
> > > <...>
> > >
> > > > +MODULE_LICENSE("GPL v2");
> > >
> > > "GPL" and not "GPL v2".
> >
> > There is no difference, please go read module.h.
> 
> I read and this is why I said it.
> Documentation/process/license-rules.rst: "It exists for historic reasons."
> 
> Historic, for me, means that new code is better do not use this.

Nope, either is fine for new code, author gets to pick what they want.
Personally, I like the explicitness of "GPL v2" for a variety of
reasons.

thanks,

greg k-h
