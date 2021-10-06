Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA404247C3
	for <lists+linux-pci@lfdr.de>; Wed,  6 Oct 2021 22:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhJFUO7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Oct 2021 16:14:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:43054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231749AbhJFUO7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Oct 2021 16:14:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8266561177;
        Wed,  6 Oct 2021 20:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633551186;
        bh=qlYhUHawVHpj2iBAtYuM7v1AtWzVwWFHp0kifaMvphE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=U+HpSfoDQmQlAmJdsQtEgXZLI5HEdo/RuiUW8VLcxo9Thztj3iiR4b9cBdM1s9vhn
         F21SnkQVSfzKxFdSZSA74PEk3tqZBc45krX17f8eSdK5quCxgkcrF4M9KuWA4/f2ox
         GsiTBWRS8zxxDwdpSGUk0T6mdLSM2Eju18vaK1rY3M5O1nANMz64DI7MHR+DZq7uqZ
         DJc19dK/KX3ojnsSdU1C8HUFhxlca8pq+hfojLpUGFwWjspigIo6tkwm8/aF25kfJV
         Uh42aawdUZ7bIxVz/m1QV3GIHPbZAPbhdQwzsmbn0f/cxkh7NzsW3FEHuQUoQ7hwjI
         e3C445NalWJbQ==
Date:   Wed, 6 Oct 2021 15:13:05 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        pali@kernel.org
Subject: Re: [PATCH 09/13] PCI: aardvark: Implement re-issuing config
 requests on CRS response
Message-ID: <20211006201305.GA1172706@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211006162934.GA12073@lpieralisi>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 06, 2021 at 05:29:34PM +0100, Lorenzo Pieralisi wrote:
> On Tue, Oct 05, 2021 at 02:28:26PM -0500, Bjorn Helgaas wrote:
> > On Mon, Oct 04, 2021 at 12:19:38PM +0200, Marek Beh�n wrote:
> > > On Mon, 4 Oct 2021 09:53:35 +0100
> > > Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> > > > On Mon, Oct 04, 2021 at 09:21:48AM +0200, Marek Beh�n wrote:
> > > > > On Sat, 2 Oct 2021 11:35:19 -0500
> > > > > Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > >   
> > > > > > On Fri, Oct 01, 2021 at 09:58:52PM +0200, Marek Beh�n wrote:  
> > > > > > > From: Pali Roh�r <pali@kernel.org>
> > > > > > > 
> > > > > > > Commit 43f5c77bcbd2 ("PCI: aardvark: Fix reporting CRS value") fixed
> > > > > > > handling of CRS response and when CRSSVE flag was not enabled it marked CRS
> > > > > > > response as failed transaction (due to simplicity).
> > > > > > > 
> > > > > > > But pci-aardvark.c driver is already waiting up to the PIO_RETRY_CNT count
> > > > > > > for PIO config response and so we can with a small change implement
> > > > > > > re-issuing of config requests as described in PCIe base specification.
> > > > > > > 
> > > > > > > This change implements re-issuing of config requests when response is CRS.
> > > > > > > Set upper bound of wait cycles to around PIO_RETRY_CNT, afterwards the
> > > > > > > transaction is marked as failed and an all-ones value is returned as
> > > > > > > before.    
> > > > > > 
> > > > > > Does this fix a problem?  
> > > > > 
> > > > > Hello Bjorn,
> > > > > 
> > > > > Pali has suspisions that certain Marvell WiFi cards may need this [1]
> > > > > to work, but we do not have them so we cannot test this.
> > > > > 
> > > > > I guess you think this should be considered a new feature instead of a
> > > > > fix, so that the Fixes tag should be removed, yes? Pali was of the
> > > > > opinion that this patch "fixes" the driver to conform more to the PCIe
> > > > > specification, that is why we added the Fixes tag.
> > > > > 
> > > > > Anyway if you think this should be considered a new feature, this patch
> > > > > can be skipped. The following patches apply even without it.  
> > > > 
> > > > I do not think we should apply to the mainline a fix that can't be
> > > > tested sorry, I will skip this patch.
> > > 
> > > Lorenzo,
> > > 
> > > my explanation was incorrect.
> > > 
> > > The functionality added by this patch _is_ tested and correctly does a
> > > retry: it was done by simulating a CRS reply.
> > > 
> > > We just don't know whether there are real cards used by users that
> > > need this functionality (the mentioned Marvell card may be such a card).
> > 
> > My claim is that the spec allows root complexes that retry zero times,
> > so we must assume such a root complex exists and we cannot rely on any
> > retries.  If such a root complex exists, this patch might fix a
> > problem, but only for aardvark.  It would be better to fix the problem
> > in a way that works for all PCIe controllers.
> 
> We need a way for those PCI controllers to communicate to SW that
> they actually received a CRS completion (and that they don't retry
> in HW).

AFAICT this would be controller-dependent.  I think some controllers
have registers that control the number of retries, but of course
that's completely controller-dependent, too.

> By implementing the logic in the aardvark controller that platform
> information is there so to the best of my knowledge this patch
> is sound.
> 
> I assume that the HW retry is in the specs because there is no
> architected way if CRS Software Visibility is not enabled/present to
> report CRS completion in an architected PCI manner but I just
> don't know the entire background behind this.

I assume an error bit would be set in the Status or Secondary Status
register when a PCIe transaction fails.  I'm not sure anybody *looks*
at those, though.

This still looks like a PCI controller band-aid for a device or driver
problem that will likely still exist on other platforms.

Bjorn
