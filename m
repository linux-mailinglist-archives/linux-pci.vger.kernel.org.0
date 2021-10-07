Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 948BB42532C
	for <lists+linux-pci@lfdr.de>; Thu,  7 Oct 2021 14:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241414AbhJGMiX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Oct 2021 08:38:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:34718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241238AbhJGMiW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Oct 2021 08:38:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E02A161077;
        Thu,  7 Oct 2021 12:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633610189;
        bh=i5zJojmQdpc3gA2Ltbzl4OtDXy0eek0mAeVVTCuhTKk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j6gmbbuXxrpWzIDv88IlAADqyINEDhIkLluWsf9wdiVhe4SEYCRDyFL+FxADZD4pO
         V4Hp4Y3hVlzVxzgcHJiHy80h8dtuttHwrY5jCQTGtmeT/wPbefP1Y1rKdfcoG1hp1K
         eFkjLtGOC0GQXVRZkW8CcbW+3f9qb1qvzNcm7q2f7hJxTbH9/Xp3KBPifqYqbc7tLp
         8oHVKJp19zWeAzjOVw4HcRvjmBre1ilLes4+O102sH2NqQFrDq2W8Kh+DLFSH2YsEI
         MIMNPbTEBonIZ9M0aknHukaeaSucmDDJDA9LsGvtfN3JW2AUDsK7+J6ZFRQWEF3Pxi
         AlvoWA7iRG6ug==
Date:   Thu, 7 Oct 2021 14:36:25 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        pali@kernel.org
Subject: Re: [PATCH 09/13] PCI: aardvark: Implement re-issuing config
 requests on CRS response
Message-ID: <20211007143625.6ad647c3@thinkpad>
In-Reply-To: <20211007115157.GA19256@lpieralisi>
References: <20211006162934.GA12073@lpieralisi>
        <20211006201305.GA1172706@bhelgaas>
        <20211007115157.GA19256@lpieralisi>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 7 Oct 2021 12:51:57 +0100
Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:

> On Wed, Oct 06, 2021 at 03:13:05PM -0500, Bjorn Helgaas wrote:
> 
> [...]
> 
> > > We need a way for those PCI controllers to communicate to SW that
> > > they actually received a CRS completion (and that they don't retry
> > > in HW).  
> > 
> > AFAICT this would be controller-dependent.  I think some controllers
> > have registers that control the number of retries, but of course
> > that's completely controller-dependent, too.
> >   
> > > By implementing the logic in the aardvark controller that platform
> > > information is there so to the best of my knowledge this patch
> > > is sound.
> > > 
> > > I assume that the HW retry is in the specs because there is no
> > > architected way if CRS Software Visibility is not enabled/present to
> > > report CRS completion in an architected PCI manner but I just
> > > don't know the entire background behind this.  
> > 
> > I assume an error bit would be set in the Status or Secondary Status
> > register when a PCIe transaction fails.  I'm not sure anybody *looks*
> > at those, though.
> > 
> > This still looks like a PCI controller band-aid for a device or driver
> > problem that will likely still exist on other platforms.  
> 
> Yes that's true. I believe we can merge this patch (?) but it would
> also be good if Pali/Marek have time to test on other HW and
> maybe generalize the concept.

We are willing to try to implement a generic API if you propose should
such API look (at least some hints).

But let's merge this into aardvark for now, since the generic case will
take a non-trivial time to implement.

Marek
