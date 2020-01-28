Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C004214BEC4
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2020 18:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgA1Rlr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jan 2020 12:41:47 -0500
Received: from foss.arm.com ([217.140.110.172]:32956 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbgA1Rlr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Jan 2020 12:41:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 096BA328;
        Tue, 28 Jan 2020 09:41:47 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3EFED3F52E;
        Tue, 28 Jan 2020 09:41:46 -0800 (PST)
Date:   Tue, 28 Jan 2020 17:41:41 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc:     "Kalakota, SushmaX" <sushmax.kalakota@intel.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>
Subject: Re: [PATCH v3] PCI: vmd: Add two VMD Device IDs
Message-ID: <20200128174141.GA16324@e121166-lin.cambridge.arm.com>
References: <20200108220510.12063-1-sushmax.kalakota@intel.com>
 <95e7feafca42f6f5c20f05d827f2bca29525ade5.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95e7feafca42f6f5c20f05d827f2bca29525ade5.camel@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 28, 2020 at 04:50:36PM +0000, Derrick, Jonathan wrote:
> Gentle reminder this one's good to go

Applied to pci/vmd, we should be able to squeeze this in v5.6.

Apologies for the delay.

Lorenzo

> On Wed, 2020-01-08 at 15:05 -0700, Sushma Kalakota wrote:
> > Add new VMD device IDs that require the bus restriction mode.
> > 
> > Signed-off-by: Sushma Kalakota <sushmax.kalakota@intel.com>
> > Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> > ---
> > v2->v3 Removed from pci_ids.h
> > v1->v2 Squashed
> > 
> >  drivers/pci/controller/vmd.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> > index 212842263f55..c502b6c0daf5 100644
> > --- a/drivers/pci/controller/vmd.c
> > +++ b/drivers/pci/controller/vmd.c
> > @@ -868,6 +868,10 @@ static const struct pci_device_id vmd_ids[] = {
> >  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_28C0),
> >  		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW |
> >  				VMD_FEAT_HAS_BUS_RESTRICTIONS,},
> > +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x467f),
> > +		.driver_data = VMD_FEAT_HAS_BUS_RESTRICTIONS,},
> > +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x4c3d),
> > +		.driver_data = VMD_FEAT_HAS_BUS_RESTRICTIONS,},
> >  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
> >  		.driver_data = VMD_FEAT_HAS_BUS_RESTRICTIONS,},
> >  	{0,}
