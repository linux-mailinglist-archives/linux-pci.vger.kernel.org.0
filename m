Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAAA340B989
	for <lists+linux-pci@lfdr.de>; Tue, 14 Sep 2021 22:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbhINU4q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Sep 2021 16:56:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:52442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231856AbhINU4q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Sep 2021 16:56:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 48BC161164;
        Tue, 14 Sep 2021 20:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631652928;
        bh=mOin/4aTjl/qI/mbE6Rm0Shvlo/CkXhbdkKWdaDUYqA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=R+I1TVxunFZO7W+Mt6Vl3MiN9cTn/sNcMzBDUg9qke/aZe/LOoATpUxvYUijro42Q
         w4DuzNBIBivr3Jino3yTcdJWi/xvCW/SrZ65DNktem/Y3+04rEEHQuAepZkGp9PeKD
         C5p1c7kKvGF/yQ3AxXjtI6hYhsz/89qOafc+MuhYMZil6JpkqrtB5ygnjLhqlyHTGi
         orBnXmbNelkQLmQI9VUhDPE2M3SHTdz8frr3eWQwvTdM1oZRdMBb2lBqsUDTG6u9VA
         cwi3IBjBaCjfJKl8Gb0WqOVYc+RNyWb6whsI2kFHOLuFRtGQboBftPtDIE4g4E71cP
         yOLO8P3zma8Uw==
Date:   Tue, 14 Sep 2021 15:55:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: aardvark: Implement re-issuing config requests on
 CRS response
Message-ID: <20210914205526.GA1456139@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210914204659.hmn22qbwa2fkft7k@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 14, 2021 at 10:46:59PM +0200, Pali Rohár wrote:
> On Tuesday 14 September 2021 15:26:56 Bjorn Helgaas wrote:
> > On Mon, Aug 23, 2021 at 02:02:14PM +0200, Pali Rohár wrote:
> > > Commit 43f5c77bcbd2 ("PCI: aardvark: Fix reporting CRS value") fixed
> > > handling of CRS response and when CRSSVE flag was not enabled it marked CRS
> > > response as failed transaction (due to simplicity).
> > > 
> > > But pci-aardvark.c driver is already waiting up to the PIO_RETRY_CNT count
> > > for PIO config response and implementation of re-issuing config requests
> > > according to PCIe base specification is therefore simple.
> > 
> > I think the spec is confusingly worded.  It says (PCIe r5.0, sec
> > 2.3.2) that when handling a Completion with CRS status for a config
> > request (paraphrasing slightly),
> > 
> >   If CRS Software Visibility is enabled, for config reads of Vendor
> >   ID, the Root Complex returns 0x0001 for Vendor ID.
> > 
> >   Otherwise ... the Root Complex must re-issue the Configuration
> >   Request as a new Request.
> > 
> > BUT:
> > 
> >   A Root Complex implementation may choose to limit the number of
> >   Configuration Request/ CRS Completion Status loops before
> >   determining that something is wrong with the target of the Request
> >   and taking appropriate action, e.g., complete the Request to the
> >   host as a failed transaction.
> > 
> > So I think zero is a perfectly valid number of retries, and I'm pretty
> > sure there are RCs that never retry.
> > 
> > Is there a benefit to doing retry like this in the driver?  Can we not
> > simply rely on retries at a higher level?
> 
> I think that all drivers handle 0xFFFFFFFF read response as some kind of
> fatal error.

True.

> And because every PCI error is mapped to value 0xFFFFFFFF
> it means that higher level has no chance to distinguish easily between
> unsupported request and completion retry status.

Also true.  But we don't *want* higher-level code to distinguish
these.  The only place we should ever see CRS status is during
enumeration and after reset.  Those code paths should look for CRS
status and retry as needed.

It is illegal for a device to return CRS after it has returned a
successful completion unless an intervening reset has occurred, so
drivers and other code should never see it.

> And issue is there also with write requests. Is somebody checking return
> value of pci_bus_write_config function?

Similar case here.  The enumeration and wait-after-reset paths always
do *reads* until we get a successful completion, so I don't think we
ever issue a write that can get CRS.

> I guess that zero retry count as you pointed is valid. But it is
> something which we want?
> 
> I sent this patch because implementation of request retry was very
> simple. Driver already waits for response, so adding another loop around
> it does not increase code complexity.

"Adding a loop does not increase code complexity"?  Well, maybe not
MUCH, but it is a little, and the analysis behind it is fairly
significant.

Bjorn
