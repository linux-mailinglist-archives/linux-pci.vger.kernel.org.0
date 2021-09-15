Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5824D40C407
	for <lists+linux-pci@lfdr.de>; Wed, 15 Sep 2021 12:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbhIOK5P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Sep 2021 06:57:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:37552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232313AbhIOK5P (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Sep 2021 06:57:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F46061279;
        Wed, 15 Sep 2021 10:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631703356;
        bh=3uN8eoZEpMvqTN9pQVcJIC73LmyfucBzqBXO6hWbINM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kG/H8yoeNfrVhUOIYEBFIvB5KpN7nv9kQkLD5o87J2JsjPTOW2nq6oR9kP9EBlbWi
         70lEbOS927jyreJzvm+bFaYAGtPDqCHV0cNezsUiD78296K+D31UvPWqac3LIq2+1K
         MoDlXmcKLsbDyhdNSb+O0hJQx0qoN82IKszx/J8QBYYCfK7MxdMdSJ/aXIcIfhRor7
         jhEhtUMOL1eiOubKeVf4X45wbJL4iXVwTEIZZbrSNH8P3aO9zTGnGm/5ZWqh39EgJp
         Jy02fRX5p+cSjWLtCp997gj5PsqxV/IyBiNBg7WNkDKdYPm9Z4UG2UpLEFwWAt/dFS
         8vPlyeptmbKnw==
Received: by pali.im (Postfix)
        id 0EEC45E1; Wed, 15 Sep 2021 12:55:54 +0200 (CEST)
Date:   Wed, 15 Sep 2021 12:55:53 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: aardvark: Implement re-issuing config requests on
 CRS response
Message-ID: <20210915105553.6eaqakvrmag6vxeq@pali>
References: <20210914204659.hmn22qbwa2fkft7k@pali>
 <20210914205526.GA1456139@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210914205526.GA1456139@bjorn-Precision-5520>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 14 September 2021 15:55:26 Bjorn Helgaas wrote:
> On Tue, Sep 14, 2021 at 10:46:59PM +0200, Pali Rohár wrote:
> > On Tuesday 14 September 2021 15:26:56 Bjorn Helgaas wrote:
> > > On Mon, Aug 23, 2021 at 02:02:14PM +0200, Pali Rohár wrote:
> > > > Commit 43f5c77bcbd2 ("PCI: aardvark: Fix reporting CRS value") fixed
> > > > handling of CRS response and when CRSSVE flag was not enabled it marked CRS
> > > > response as failed transaction (due to simplicity).
> > > > 
> > > > But pci-aardvark.c driver is already waiting up to the PIO_RETRY_CNT count
> > > > for PIO config response and implementation of re-issuing config requests
> > > > according to PCIe base specification is therefore simple.
> > > 
> > > I think the spec is confusingly worded.  It says (PCIe r5.0, sec
> > > 2.3.2) that when handling a Completion with CRS status for a config
> > > request (paraphrasing slightly),
> > > 
> > >   If CRS Software Visibility is enabled, for config reads of Vendor
> > >   ID, the Root Complex returns 0x0001 for Vendor ID.
> > > 
> > >   Otherwise ... the Root Complex must re-issue the Configuration
> > >   Request as a new Request.
> > > 
> > > BUT:
> > > 
> > >   A Root Complex implementation may choose to limit the number of
> > >   Configuration Request/ CRS Completion Status loops before
> > >   determining that something is wrong with the target of the Request
> > >   and taking appropriate action, e.g., complete the Request to the
> > >   host as a failed transaction.
> > > 
> > > So I think zero is a perfectly valid number of retries, and I'm pretty
> > > sure there are RCs that never retry.
> > > 
> > > Is there a benefit to doing retry like this in the driver?  Can we not
> > > simply rely on retries at a higher level?
> > 
> > I think that all drivers handle 0xFFFFFFFF read response as some kind of
> > fatal error.
> 
> True.
> 
> > And because every PCI error is mapped to value 0xFFFFFFFF
> > it means that higher level has no chance to distinguish easily between
> > unsupported request and completion retry status.
> 
> Also true.  But we don't *want* higher-level code to distinguish
> these.  The only place we should ever see CRS status is during
> enumeration and after reset.  Those code paths should look for CRS
> status and retry as needed.
> 
> It is illegal for a device to return CRS after it has returned a
> successful completion unless an intervening reset has occurred, so
> drivers and other code should never see it.
> 
> > And issue is there also with write requests. Is somebody checking return
> > value of pci_bus_write_config function?
> 
> Similar case here.  The enumeration and wait-after-reset paths always
> do *reads* until we get a successful completion, so I don't think we
> ever issue a write that can get CRS.

Yes, in normal conditions we should not see it.

But for testing purposes (that emulated bridge works fine) I'm using
setpci for changing some configuration.

And via setpci it is possible to turn off CRSSVE bit in which case then
Root Complex should re-issue request again.

I'm not sure how "legal" it is if userspace / setpci changes some of
these bits. At least on a hardware with a real Root Port device it
should be fully transparent. As hardware handles this re-issue and
kernel then would see (reissued) response.

Test case: Initialize device, then unbind it from sysfs, reset it (hot
reset or warm reset) and then rescan / reinit it again. Here device is
permitted to send CRS response.

We know that more PCIe cards are buggy and sometimes firmware on cards
crashes or resets card logic. Which may put card into initialization
state when it is again permitted to send CRS response.

> > I guess that zero retry count as you pointed is valid. But it is
> > something which we want?
> > 
> > I sent this patch because implementation of request retry was very
> > simple. Driver already waits for response, so adding another loop around
> > it does not increase code complexity.
> 
> "Adding a loop does not increase code complexity"?  Well, maybe not
> MUCH, but it is a little, and the analysis behind it is fairly
> significant.

I agree, it depends. For somebody it could be a little change which does
not harm and for somebody else it can be bigger. Maybe I'm biased here
as I patched pci-aardvark.c code more times and it could mean that patch
complexity for me is smaller as I know this code.
