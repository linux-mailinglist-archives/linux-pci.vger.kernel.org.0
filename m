Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61EAB1EA695
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jun 2020 17:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgFAPNl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Jun 2020 11:13:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:38854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgFAPNl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Jun 2020 11:13:41 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A431C20738;
        Mon,  1 Jun 2020 15:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591024421;
        bh=xCkd2fICeOT9Ubja+5vo62mABuxHHRilmgEk9G4WHwk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=EYDb/OHT+pWpoo4RcVx+H1fEMIm5fhsJZ7hQWUeU4Gg1D4EDLU+t796v8MXUvc/pc
         uAgIgKYINjVWVd/mL3SqvTGJq1nI4p8g+gtpqxYjCTBkMeOmK5eGHsnyGMMbiwQcm3
         s3mE945pSdBwHTqRlXBUdPO9CAJNcov8kUS7E4EM=
Date:   Mon, 1 Jun 2020 10:13:39 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: Lost PCIe PME after a914ff2d78ce ("PCI/ASPM: Don't select
 CONFIG_PCIEASPM by default")
Message-ID: <20200530123421.GA532471@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200530113344.GA2834@infradead.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, May 30, 2020 at 04:33:44AM -0700, Christoph Hellwig wrote:
> On Sat, May 30, 2020 at 08:14:34AM +0100, Matthew Garrett wrote:
> > On Sat, May 30, 2020 at 08:33:50AM +0200, Heiner Kallweit wrote:
> > 
> > > It *was* default y. This changed with a914ff2d78ce ("PCI/ASPM: Don't
> > > select CONFIG_PCIEASPM by default") and that's what triggered the
> > > problem. If there's no easy solution, then maybe it's best to revert
> > > the change for now.
> > 
> > Oh, sorry, I was looking at mainline. CONFIG_PCIEASPM should 
> > *definitely* be enabled by default - platforms expect the OS to support 
> > it. If we want to get rid of default y then I think it'd make more sense 
> > to have a CONFIG_DISABLE_PCIEASPM that's under EXPERT, and people who 
> > really want to disable the code can do so.
> 
> I think the fact that the EXPERT didn't get removed in the above bug
> is a defintive bug.  But I'd go further and think the CONFIG_PCIEASPM
> option should be removed entirely.  There is absolutely no good reason
> to not build this small amount of code if PCIe support is enabled.

That might be a good solution.  I don't really want a situation where
leaving CONFIG_PCIEASPM unset is "known to break PME."

ASPM support has historically been fragile, and it's actually a
significant amount of code (~10KB on my x86), which is larger than
many other things for which we have config options.  But we do have
boot-time and run-time ways to disable it.

Another possibility might be to make it so Linux always advertises
ASPM support, but doesn't actually *do* anything unless
CONFIG_PCIEASPM is set.  I don't think advertising ASPM support means
the OS is required to change whatever configuration firmware did.

Bjorn
