Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046A4425B7F
	for <lists+linux-pci@lfdr.de>; Thu,  7 Oct 2021 21:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbhJGT1t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Oct 2021 15:27:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:54344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232299AbhJGT1s (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Oct 2021 15:27:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5ECA9610A1;
        Thu,  7 Oct 2021 19:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633634754;
        bh=VC0rNjhUsL+0wtKtB0OaRqR0gnmkuM3IMDS7R1K3mts=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KsXeQyMV6OUoph5YyXRsvJnMxqK+81JeWudQy5uBeIYXFhkCY8xDbvSXTZs581fO4
         nV5R4k9JMxgVhUxp+WL6/r+kXwKjBw9HXtBFThD5RtZgXyDdzP9xTFsv0LvxfQwfkt
         2enfOYyZEmNWrXIkct+4V7FG3Ov2fKpmICax+fTKfO7ih28qs8iiSka9WnBYkQPsl6
         4WklmnJWkqPcILr/bXPPQm6StdLHn+31WjpX+FRhqLl+97+X/OU4n8CeIy5M9KS4U4
         fJcZisdBefrWqIqHPH65uizwVg97vezeTwthtiJPBJe0h+9JYDovFkCLAbKHwP/iv6
         Kb1nWV0jxprXQ==
Date:   Thu, 7 Oct 2021 14:25:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        pali@kernel.org
Subject: Re: [PATCH 09/13] PCI: aardvark: Implement re-issuing config
 requests on CRS response
Message-ID: <20211007192553.GA1259781@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211007143625.6ad647c3@thinkpad>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 07, 2021 at 02:36:25PM +0200, Marek Behún wrote:
> On Thu, 7 Oct 2021 12:51:57 +0100
> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> 
> > On Wed, Oct 06, 2021 at 03:13:05PM -0500, Bjorn Helgaas wrote:
> > 
> > [...]
> > 
> > > > We need a way for those PCI controllers to communicate to SW that
> > > > they actually received a CRS completion (and that they don't retry
> > > > in HW).  
> > > 
> > > AFAICT this would be controller-dependent.  I think some controllers
> > > have registers that control the number of retries, but of course
> > > that's completely controller-dependent, too.
> > >   
> > > > By implementing the logic in the aardvark controller that platform
> > > > information is there so to the best of my knowledge this patch
> > > > is sound.
> > > > 
> > > > I assume that the HW retry is in the specs because there is no
> > > > architected way if CRS Software Visibility is not enabled/present to
> > > > report CRS completion in an architected PCI manner but I just
> > > > don't know the entire background behind this.  
> > > 
> > > I assume an error bit would be set in the Status or Secondary Status
> > > register when a PCIe transaction fails.  I'm not sure anybody *looks*
> > > at those, though.
> > > 
> > > This still looks like a PCI controller band-aid for a device or driver
> > > problem that will likely still exist on other platforms.  
> > 
> > Yes that's true. I believe we can merge this patch (?) but it would
> > also be good if Pali/Marek have time to test on other HW and
> > maybe generalize the concept.
> 
> We are willing to try to implement a generic API if you propose should
> such API look (at least some hints).

That's the whole point -- CRS SV *is* the generic way for controllers
to report CRS completions to software.  If the controller doesn't
support CRS SV, I don't think a generic API is possible.

Or maybe I don't understand the sort of generic API you have in mind.
What sort of information do you envision the API might provide?

Bjorn
