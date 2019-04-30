Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA58F208
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2019 10:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfD3IbR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Apr 2019 04:31:17 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:37195 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbfD3IbQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Apr 2019 04:31:16 -0400
X-Originating-IP: 88.190.179.123
Received: from localhost (unknown [88.190.179.123])
        (Authenticated sender: repk@triplefau.lt)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id EF872FF80F;
        Tue, 30 Apr 2019 08:31:12 +0000 (UTC)
Date:   Tue, 30 Apr 2019 10:40:01 +0200
From:   Remi Pommarel <repk@triplefau.lt>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Ellie Reeves <ellierevves@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] PCI: aardvark: Use LTSSM state to build link training
 flag
Message-ID: <20190430084000.GT2754@voidbox.localdomain>
References: <20190316161243.29517-1-repk@triplefau.lt>
 <20190425210439.GG11428@google.com>
 <20190425222756.GR2754@voidbox.localdomain>
 <20190429194532.GA119268@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429194532.GA119268@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 29, 2019 at 02:45:32PM -0500, Bjorn Helgaas wrote:
> On Fri, Apr 26, 2019 at 12:27:57AM +0200, Remi Pommarel wrote:
> > On Thu, Apr 25, 2019 at 04:04:39PM -0500, Bjorn Helgaas wrote:
> > > On Sat, Mar 16, 2019 at 05:12:43PM +0100, Remi Pommarel wrote:
> 
> > > It sounds like reading and/or writing some registers during a retrain
> > > causes some sort of EL1 error?  Is this a separate erratum?  Is there
> > > a list of the registers and operations (read/write) that are affected?
> > > The backtrace below suggests that it's actually a read of LNKCAP or
> > > LNKCTL (not LNKSTA) that caused the error.
> > 
> > IIUC, the backtrace below produces an EL1 error when doing a PIO
> > transfer while the link is still retraining. See my comment below for
> > more about that. But accessing any root complex's register seems fine.
> > > 
> > > It sounds like there are really two problems:
> > > 
> > >   1) Reading PCI_EXP_LNKSTA (or the Aardvark equivalent) doesn't give
> > >      valid data for PCI_EXP_LNKSTA_LT.
> > 
> > The 1) is correct.
> > 
> > >   2) Sometimes config reads cause EL1 errors.
> > 
> > Actually EL1 error happens when we try to access device's register with
> > a PIO transfer, which is when we try to use the link while it is being
> > retrained.
> > 
> > IMHO, 1) and 2) are linked. ASPM core tries to use the link too early
> > because it has read invalid data for PCI_EXP_LNKSTA_LT.
> 
> From the software point of view, there is no such thing as "using the
> link too early".  The pattern of:
> 
>   - Verify that link is up
>   - Access device on other end of link
> 
> is always racy because the link can go down at any time due to hotplug
> or other issues.  In particular, the link can go down after we verify
> that the link is up, but before we access the device.
> 
> Software must be able to deal with that gracefully.  I don't know
> whether that means catching and recovering from that EL1 error, or
> masking it, or what.  This is architecture-specific stuff that's
> outside the scope of PCIe itself.
> 
> But a link going down should never directly cause a kernel panic.

Ah, yes, you are right. There is "worse" than the EL1 error though, boot
can also hang while accessing those registers when link is not in a
ready state.

So, yes, I do agree that there are two issues here. The
PCI_EXP_LNKSTA_LT register one and the EL1 error or hang one. On the
other hand I don't think I can split it in two because this patch only
fixes the former which happens to not trigger the latter (ASPM core is
kind enough to wait for the link to be ready after retraining).

Thus the second issue remains and hot plugging for example would
likely trigger it. I'll try to see with Thomas if we could reach the
vendor about that.

By the way, I have replied to Lorenzo with, what I think, is a more
legible patch. I could send a v3 with it if you prefer this one.

-- 
Remi
