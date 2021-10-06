Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB274242AB
	for <lists+linux-pci@lfdr.de>; Wed,  6 Oct 2021 18:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhJFQbd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Oct 2021 12:31:33 -0400
Received: from foss.arm.com ([217.140.110.172]:48004 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231755AbhJFQbd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Oct 2021 12:31:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA7AE6D;
        Wed,  6 Oct 2021 09:29:40 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 000233F70D;
        Wed,  6 Oct 2021 09:29:39 -0700 (PDT)
Date:   Wed, 6 Oct 2021 17:29:34 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        pali@kernel.org
Subject: Re: [PATCH 09/13] PCI: aardvark: Implement re-issuing config
 requests on CRS response
Message-ID: <20211006162934.GA12073@lpieralisi>
References: <20211004121938.546d8f73@thinkpad>
 <20211005192826.GA1111810@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211005192826.GA1111810@bhelgaas>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 05, 2021 at 02:28:26PM -0500, Bjorn Helgaas wrote:
> On Mon, Oct 04, 2021 at 12:19:38PM +0200, Marek Beh�n wrote:
> > On Mon, 4 Oct 2021 09:53:35 +0100
> > Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> > > On Mon, Oct 04, 2021 at 09:21:48AM +0200, Marek Beh�n wrote:
> > > > On Sat, 2 Oct 2021 11:35:19 -0500
> > > > Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > >   
> > > > > On Fri, Oct 01, 2021 at 09:58:52PM +0200, Marek Beh�n wrote:  
> > > > > > From: Pali Roh�r <pali@kernel.org>
> > > > > > 
> > > > > > Commit 43f5c77bcbd2 ("PCI: aardvark: Fix reporting CRS value") fixed
> > > > > > handling of CRS response and when CRSSVE flag was not enabled it marked CRS
> > > > > > response as failed transaction (due to simplicity).
> > > > > > 
> > > > > > But pci-aardvark.c driver is already waiting up to the PIO_RETRY_CNT count
> > > > > > for PIO config response and so we can with a small change implement
> > > > > > re-issuing of config requests as described in PCIe base specification.
> > > > > > 
> > > > > > This change implements re-issuing of config requests when response is CRS.
> > > > > > Set upper bound of wait cycles to around PIO_RETRY_CNT, afterwards the
> > > > > > transaction is marked as failed and an all-ones value is returned as
> > > > > > before.    
> > > > > 
> > > > > Does this fix a problem?  
> > > > 
> > > > Hello Bjorn,
> > > > 
> > > > Pali has suspisions that certain Marvell WiFi cards may need this [1]
> > > > to work, but we do not have them so we cannot test this.
> > > > 
> > > > I guess you think this should be considered a new feature instead of a
> > > > fix, so that the Fixes tag should be removed, yes? Pali was of the
> > > > opinion that this patch "fixes" the driver to conform more to the PCIe
> > > > specification, that is why we added the Fixes tag.
> > > > 
> > > > Anyway if you think this should be considered a new feature, this patch
> > > > can be skipped. The following patches apply even without it.  
> > > 
> > > I do not think we should apply to the mainline a fix that can't be
> > > tested sorry, I will skip this patch.
> > 
> > Lorenzo,
> > 
> > my explanation was incorrect.
> > 
> > The functionality added by this patch _is_ tested and correctly does a
> > retry: it was done by simulating a CRS reply.
> > 
> > We just don't know whether there are real cards used by users that
> > need this functionality (the mentioned Marvell card may be such a card).
> 
> My claim is that the spec allows root complexes that retry zero times,
> so we must assume such a root complex exists and we cannot rely on any
> retries.  If such a root complex exists, this patch might fix a
> problem, but only for aardvark.  It would be better to fix the problem
> in a way that works for all PCIe controllers.

We need a way for those PCI controllers to communicate to SW that
they actually received a CRS completion (and that they don't retry
in HW).

By implementing the logic in the aardvark controller that platform
information is there so to the best of my knowledge this patch
is sound.

I assume that the HW retry is in the specs because there is no
architected way if CRS Software Visibility is not enabled/present to
report CRS completion in an architected PCI manner but I just
don't know the entire background behind this.

Lorenzo

> I'm playing devil's advocate here, and it's quite possible that I'm
> interpreting the spec incorrectly.  Maybe the Marvell card is a way to
> test this in the real world.
