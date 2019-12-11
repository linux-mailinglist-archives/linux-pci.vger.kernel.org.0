Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 590F111BDBF
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2019 21:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfLKUR3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Dec 2019 15:17:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:60932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbfLKUR2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Dec 2019 15:17:28 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6BBF20836;
        Wed, 11 Dec 2019 20:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576095447;
        bh=4r2Iy5r3yltzkOi+Ue/uCbrEJloSfsHyNrQQPZ6a91M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=K4rsURO1d1nG/9CUOU21PXHxDAlfjKTIYvivgtNsYl2RHhWnxioV5ZWBR5AvTs0VK
         ouL+9ULhlT2NOagYYFpOiUEp/E5LJNw/znAZJQl9HBw5tUbqd5CwjrZ8AfaYQk25T8
         Zm3bYJLHCtPdebAetY0QRpkGCgDR477M8hji3lBA=
Date:   Wed, 11 Dec 2019 14:17:25 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] pcie: Add quirk for the Arm Neoverse N1SDP platform
Message-ID: <20191211201725.GA30513@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211110049.54a2d6f3@donnerap.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 11, 2019 at 11:00:49AM +0000, Andre Przywara wrote:
> On Tue, 10 Dec 2019 08:41:15 -0600
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Mon, Dec 09, 2019 at 04:06:38PM +0000, Andre Przywara wrote:
> > > From: Deepak Pandey <Deepak.Pandey@arm.com>
> > > 
> > > The Arm N1SDP SoC suffers from some PCIe integration issues, most
> > > prominently config space accesses to not existing BDFs being answered
> > > with a bus abort, resulting in an SError.  
> > 
> > Can we tease this apart a little more?  Linux doesn't program all the
> > bits that control error signaling, so even on hardware that works
> > perfectly, much of this behavior is determined by what firmware did.
> > I wonder if Linux could be more careful about this.
> > 
> > "Bus abort" is not a term used in PCIe.
> 
> Yes, sorry, that was my sloppy term, also aiming more at the CPU
> side of the bus, between the cores and the RC.
>
> >  IIUC, a config read to a
> > device that doesn't exist should terminate with an Unsupported Request
> > completion, e.g., see the implementation note in PCIe r5.0 sec 2.3.1.
> 
> Yes, that's what Lorenzo mentioned as well.
> 
> > The UR should be an uncorrectable non-fatal error (Table 6-5), and
> > Figures 6-2 and 6-3 show how it should be handled and when it should
> > be signaled as a system error.  In case you don't have a copy of the
> > spec, I extracted those two figures and put them at [1].
> 
> Thanks for that.
> So in the last few months we tossed several ideas around how to
> work-around this without kernel intervention, all of them turned out
> to be not working. There are indeed registers in the RC that
> influence error reporting to the CPU side, but even if we could
> suppress (or catch) the SError, we can't recover and fixup the read
> transaction to the CPU. Even Lorenzo gave up on this ;-) As far as I
> understood this, there are gates missing which are supposed to
> translate this specific UR into a valid "all-1s" response.

But the commit log says firmware scanned the bus (catching the
SErrors).  Shouldn't Linux be able to catch them the same way?

The "all-1s" response directly from hardware is typical of most
platforms, but I don't think it's strictly required by the PCIe spec
and I don't think it's absolutely essential even to Linux.  If you can
catch the SErrors, isn't there a way for software to fabricate that
all-1s data and continue after the read?

> > Even ECAM compliance is not really minor -- if this controller were
> > fully compliant with the spec, you would need ZERO Linux changes to
> > support it.  Every quirk like this means additional maintenance
> > burden, and it's not just a one-time thing.  It means old kernels that
> > *should* "just work" on your system will not work unless somebody
> > backports the quirk.
> 
> I am well aware of that, and we had quite some discussions
> internally, with quite some opposition.  ...

The main point is that *future* silicon should be designed to avoid
this issue.  I hope at least that part was not controversial.

If we want to take advantage of the generic PCI code supplied by
Linux, we have to expect that the hardware will play by the rules of
PCI.

Bjorn
