Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF1FB5133
	for <lists+linux-pci@lfdr.de>; Tue, 17 Sep 2019 17:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbfIQPPa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Sep 2019 11:15:30 -0400
Received: from foss.arm.com ([217.140.110.172]:57340 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727437AbfIQPPa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Sep 2019 11:15:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE68015A2;
        Tue, 17 Sep 2019 08:15:29 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0D203F575;
        Tue, 17 Sep 2019 08:15:28 -0700 (PDT)
Date:   Tue, 17 Sep 2019 16:15:23 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Busch, Keith" <keith.busch@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>
Subject: Re: [PATCH 2/2] PCI: vmd: Fix shadow offsets to reflect spec changes
Message-ID: <20190917151523.GA7948@e121166-lin.cambridge.arm.com>
References: <20190916135435.5017-1-jonathan.derrick@intel.com>
 <20190916135435.5017-3-jonathan.derrick@intel.com>
 <20190917104106.GB32602@e121166-lin.cambridge.arm.com>
 <87f1f92276becb6f83d040b36697ef8084e63105.camel@intel.com>
 <20190917140525.GA6377@e121166-lin.cambridge.arm.com>
 <087e23dc3bb7b94bb96c33b380732ebd1285e467.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <087e23dc3bb7b94bb96c33b380732ebd1285e467.camel@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 17, 2019 at 02:45:03PM +0000, Derrick, Jonathan wrote:
> On Tue, 2019-09-17 at 15:05 +0100, Lorenzo Pieralisi wrote:
> > On Tue, Sep 17, 2019 at 01:55:59PM +0000, Derrick, Jonathan wrote:
> > > On Tue, 2019-09-17 at 11:41 +0100, Lorenzo Pieralisi wrote:
> > > > On Mon, Sep 16, 2019 at 07:54:35AM -0600, Jon Derrick wrote:
> > > > > The shadow offset scratchpad was moved to 0x2000-0x2010. Update the
> > > > > location to get the correct shadow offset.
> > > > 
> > > > Hi Jon,
> > > > 
> > > > what does "was moved" mean ? Would this code still work on previous HW ?
> > > > 
> > > The previous code won't work on (not yet released) hw. Guests using the
> > > domain will see the wrong offset and enumerate the domain incorrectly.
> > 
> > That's true also for new kernels on _current_ hardware, isn't it ?
> > 
> > What I am saying is that there must be a way to detect the right
> > offset from HW probing or firmware otherwise things will break
> > one way of another.
> > 
> I think this is basically that, but the spec changed which register
> addresses contained the offset. The offset was still discoverable
> either way, but is now within 0x2000-0x2010, with 0x2010-0x2090 as oob
> interface.
> 
> 
> 
> > > > We must make sure that the address move is managed seamlessly by the
> > > > kernel.
> > > If we need to avoid changing addressing within stable, then that's
> > > fine. But otherwise is there an issue merging with 5.4?
> > 
> > See above. Would 5.4 with this patch applied work on systems where
> > the offset is the same as the _current_ one without this patch
> > applied ?
> I understand your concern, but these systems with wrong addressing
> won't exist because the hardware isn't released yet.
> 
> In the future, the hardware will be released and users will inevitably
> load some unfixed kernel, and we would like to point to stable for the
> fix.

I am sorry for being blunt but I need to understand. If we apply
this patch, are you telling me that the _current_ HW would fail ?

I assume the current HW+kernel set-up is working, maybe that's
what I got wrong.

Reworded: on existing HW, is this patch fixing anything ?

This patch when it hits the mainline will trickle into stable
kernel unchanged.

> > > > For the time being I have to drop this fix and it is extremely
> > > > tight to get it in v5.4, I can't send stable changes that we may
> > > > have to revert.
> > > Aren't we in the beginning of the merge window?
> > 
> > Yes and that's the problem, patches for v5.4 should have already
> > being queued a while ago, I do not know when Bjorn will send the
> > PR for v5.4 but that's going to happen shortly, I am making an
> > exception to squeeze these patches in since it is vmd only code
> > but still it is very very tight.
> > 
> If you feel there's a risk, then I think it can be staged for v5.5.
> Hardware will not be available for some time.

I do not feel it is risky, I feel it would be much better if the
scratchpad address could be detected at runtime through versioning
of sorts either HW or firmware based.

If we can't probe it inevitably we will have systems where kernels
would break and that's something we should avoid.

Lorenzo
