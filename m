Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4704230C6
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 21:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbhJETaT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 15:30:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229671AbhJETaT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Oct 2021 15:30:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1150661027;
        Tue,  5 Oct 2021 19:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633462108;
        bh=9JUGZ+smNoQ+dVO8HYAVZPWk0SiP7DmQOZjjrNdl2ws=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=aeLnPYvWogEyCXNe4BZQ6IVMvG5M7tsPs73etoTPswIVWCorWGi/40VWaDMyGL4Pp
         WjmBaB6LWsw0OXtgJg1sUK6Ep3u74OLB/H0uKQZxyl/9Z+E45i+t0eRXW12I9B7NwF
         QiHkklYfdlk8NXKUdBHmjd5wNwxTdTFaYeLRbiZxH25Od2CZps2bFI3J/Mzv8Zjo9h
         d6xmeb4XKU7Ux4/gym/+tdMGQ93NcFdEaSl6rwfibbx9SREpa7XV4pAkYcP1dQDIGp
         FBDjZMvrhnRh01Xw/ez8ksgZNbrf7x1xLAVj9mjGjz1tBjQ1Djp1zvGV4EcsTL/i/H
         cZ7UPdknCNXXA==
Date:   Tue, 5 Oct 2021 14:28:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        pali@kernel.org
Subject: Re: [PATCH 09/13] PCI: aardvark: Implement re-issuing config
 requests on CRS response
Message-ID: <20211005192826.GA1111810@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211004121938.546d8f73@thinkpad>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 04, 2021 at 12:19:38PM +0200, Marek Behún wrote:
> On Mon, 4 Oct 2021 09:53:35 +0100
> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> > On Mon, Oct 04, 2021 at 09:21:48AM +0200, Marek Behún wrote:
> > > On Sat, 2 Oct 2021 11:35:19 -0500
> > > Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >   
> > > > On Fri, Oct 01, 2021 at 09:58:52PM +0200, Marek Behún wrote:  
> > > > > From: Pali Rohár <pali@kernel.org>
> > > > > 
> > > > > Commit 43f5c77bcbd2 ("PCI: aardvark: Fix reporting CRS value") fixed
> > > > > handling of CRS response and when CRSSVE flag was not enabled it marked CRS
> > > > > response as failed transaction (due to simplicity).
> > > > > 
> > > > > But pci-aardvark.c driver is already waiting up to the PIO_RETRY_CNT count
> > > > > for PIO config response and so we can with a small change implement
> > > > > re-issuing of config requests as described in PCIe base specification.
> > > > > 
> > > > > This change implements re-issuing of config requests when response is CRS.
> > > > > Set upper bound of wait cycles to around PIO_RETRY_CNT, afterwards the
> > > > > transaction is marked as failed and an all-ones value is returned as
> > > > > before.    
> > > > 
> > > > Does this fix a problem?  
> > > 
> > > Hello Bjorn,
> > > 
> > > Pali has suspisions that certain Marvell WiFi cards may need this [1]
> > > to work, but we do not have them so we cannot test this.
> > > 
> > > I guess you think this should be considered a new feature instead of a
> > > fix, so that the Fixes tag should be removed, yes? Pali was of the
> > > opinion that this patch "fixes" the driver to conform more to the PCIe
> > > specification, that is why we added the Fixes tag.
> > > 
> > > Anyway if you think this should be considered a new feature, this patch
> > > can be skipped. The following patches apply even without it.  
> > 
> > I do not think we should apply to the mainline a fix that can't be
> > tested sorry, I will skip this patch.
> 
> Lorenzo,
> 
> my explanation was incorrect.
> 
> The functionality added by this patch _is_ tested and correctly does a
> retry: it was done by simulating a CRS reply.
> 
> We just don't know whether there are real cards used by users that
> need this functionality (the mentioned Marvell card may be such a card).

My claim is that the spec allows root complexes that retry zero times,
so we must assume such a root complex exists and we cannot rely on any
retries.  If such a root complex exists, this patch might fix a
problem, but only for aardvark.  It would be better to fix the problem
in a way that works for all PCIe controllers.

I'm playing devil's advocate here, and it's quite possible that I'm
interpreting the spec incorrectly.  Maybe the Marvell card is a way to
test this in the real world.

Bjorn
