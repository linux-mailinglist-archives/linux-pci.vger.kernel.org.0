Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F9D42079C
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 10:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhJDIz1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 04:55:27 -0400
Received: from foss.arm.com ([217.140.110.172]:51188 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229631AbhJDIz1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Oct 2021 04:55:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78D47101E;
        Mon,  4 Oct 2021 01:53:38 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D47B3F66F;
        Mon,  4 Oct 2021 01:53:37 -0700 (PDT)
Date:   Mon, 4 Oct 2021 09:53:35 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        pali@kernel.org
Subject: Re: [PATCH 09/13] PCI: aardvark: Implement re-issuing config
 requests on CRS response
Message-ID: <20211004085335.GC22336@lpieralisi>
References: <20211001195856.10081-10-kabel@kernel.org>
 <20211002163519.GA973164@bhelgaas>
 <20211004092148.6e18f6f5@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211004092148.6e18f6f5@thinkpad>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 04, 2021 at 09:21:48AM +0200, Marek Behún wrote:
> On Sat, 2 Oct 2021 11:35:19 -0500
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > On Fri, Oct 01, 2021 at 09:58:52PM +0200, Marek Behún wrote:
> > > From: Pali Rohár <pali@kernel.org>
> > > 
> > > Commit 43f5c77bcbd2 ("PCI: aardvark: Fix reporting CRS value") fixed
> > > handling of CRS response and when CRSSVE flag was not enabled it marked CRS
> > > response as failed transaction (due to simplicity).
> > > 
> > > But pci-aardvark.c driver is already waiting up to the PIO_RETRY_CNT count
> > > for PIO config response and so we can with a small change implement
> > > re-issuing of config requests as described in PCIe base specification.
> > > 
> > > This change implements re-issuing of config requests when response is CRS.
> > > Set upper bound of wait cycles to around PIO_RETRY_CNT, afterwards the
> > > transaction is marked as failed and an all-ones value is returned as
> > > before.  
> > 
> > Does this fix a problem?
> 
> Hello Bjorn,
> 
> Pali has suspisions that certain Marvell WiFi cards may need this [1]
> to work, but we do not have them so we cannot test this.
> 
> I guess you think this should be considered a new feature instead of a
> fix, so that the Fixes tag should be removed, yes? Pali was of the
> opinion that this patch "fixes" the driver to conform more to the PCIe
> specification, that is why we added the Fixes tag.
> 
> Anyway if you think this should be considered a new feature, this patch
> can be skipped. The following patches apply even without it.

I do not think we should apply to the mainline a fix that can't be
tested sorry, I will skip this patch.

Thanks,
Lorenzo

> Marek
> 
> [1]
> https://lore.kernel.org/linux-wireless/CAHp75Vd5iCLELx8s+Zvcj8ufd2bN6CK26soDMkZyC1CwMO2Qeg@mail.gmail.com/
