Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D90CDCBACC
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2019 14:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387593AbfJDMtE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Oct 2019 08:49:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:60006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387574AbfJDMtE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Oct 2019 08:49:04 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C3E0215EA;
        Fri,  4 Oct 2019 12:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570193343;
        bh=Qq8yUf1E6rfRdC96Z95+tYp8yLd7gCODj3q1cTKqEkU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ALZlVgl62wYzdKB9RQfKgBLGvDHRZXQA/FWBp0chOg5Zt/Tdg493M9mrQmgle0Bdi
         8dKq4PFHsv/+YcA//RjvDduCDipQp0q5u1v9i8DdEx9OhpXej1QJMOHfV207SulIwD
         W3tGzD7RzIs0O7JoYVDBdVNbT2kCWHzTEwiQ7Nao=
Date:   Fri, 4 Oct 2019 07:49:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com
Subject: Re: [PATCH v7 1/7] PCI/ATS: Fix pci_prg_resp_pasid_required()
 dependency issues
Message-ID: <20191004124901.GA40317@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b310600-045a-2f02-d82b-edb44cbcffcd@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 03, 2019 at 02:11:28PM -0700, Kuppuswamy Sathyanarayanan wrote:
> 
> On 10/3/19 2:01 PM, Bjorn Helgaas wrote:
> > On Thu, Oct 03, 2019 at 01:37:26PM -0700, Kuppuswamy Sathyanarayanan wrote:
> > > On Thu, Oct 03, 2019 at 02:04:13PM -0500, Bjorn Helgaas wrote:
> > > > On Thu, Oct 03, 2019 at 10:20:24AM -0700, Kuppuswamy Sathyanarayanan wrote:
> > > > > Hi Bjorn,
> > > > > 
> > > > > Thanks for looking into this patch set.
> > > > > 
> > > > > On 9/5/19 12:18 PM, Bjorn Helgaas wrote:
> > > > > > On Wed, Aug 28, 2019 at 03:14:01PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> > > > > > > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > > > > > 
> > > > > > > Since pci_prg_resp_pasid_required() function has dependency on both
> > > > > > > PASID and PRI, define it only if both CONFIG_PCI_PRI and
> > > > > > > CONFIG_PCI_PASID config options are enabled.
> > > > > > > 
> > > > > > > Fixes: e5567f5f6762 ("PCI/ATS: Add pci_prg_resp_pasid_required()
> > > > > > > interface.")
> > > > > > [Don't split tags, including "Fixes:" across lines]
> > > > > > 
> > > > > > This definitely doesn't fix e5567f5f6762.  That commit added
> > > > > > pci_prg_resp_pasid_required(), but with no dependency on
> > > > > > CONFIG_PCI_PRI or CONFIG_PCI_PASID.
> > > > > > 
> > > > > > This patch is only required when a subsequent patch is applied.  It
> > > > > > should be squashed into the commit that requires it so it's obvious
> > > > > > why it's needed.
> > > > > > 
> > > > > > I've been poking at this series, and I'll post a v8 soon with this and
> > > > > > other fixes.
> > > > > In your v8 submission you did not merge this patch. You did not use
> > > > > pri_cap or pasid_cap cached values. Instead you have re-read the
> > > > > value from register. Is this intentional?
> > > > > 
> > > > > Since this function will be called for every VF device we might loose some
> > > > > performance benefit.
> > > > This particular patch doesn't do any caching.  IIRC it fiddles with
> > > > ifdefs to solve a problem that would be introduced by a future patch.
> > > > I don't remember the exact details, but I think the series I merged
> > > > doesn't have that problem.  If it does, let me know the details and we
> > > > can fix it.
> > > This patch by itself does not do any caching. But your caching patch
> > > missed modifying this function to use cached values. Please check the
> > > current implementation of this function. It still reads
> > > PCI_EXT_CAP_ID_PRI register instead of using cached value. Please let
> > > me know your comments.
> > > 
> > > int pci_prg_resp_pasid_required(struct pci_dev *pdev)
> > > {
> > >      u16 status;
> > >      int pri;
> > > 
> > >      if (pdev->is_virtfn)
> > >          pdev = pci_physfn(pdev);
> > > 
> > >      pri = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
> > >      if (!pri)
> > >          return 0;
> > > 
> > >      pci_read_config_word(pdev, pri + PCI_PRI_STATUS, &status);
> > > 
> > >      if (status & PCI_PRI_STATUS_PASID)
> > >          return 1;
> > > 
> > >      return 0;
> > > }
> > > EXPORT_SYMBOL_GPL(pci_prg_resp_pasid_required);
> > > 
> > > If caching is applied to this function then we need this #ifdef
> > > dependency correction patch.
> > IIRC this #ifdef patch wasn't connected to the actual *need* for the
> > #ifdef, so it was very difficult to review.  I thought this function
> > would be infrequently used and it wasn't worth trying to sort out the
> > #ifdef muddle to do the caching.  But it does seem sort of pointless
> > to chase the capability list again here, so maybe it *is* worth
> > optimizing.
> > 
> > The PRG Response PASID Required bit is read-only, so I wonder if it
> > would be simpler if we just read PCI_PRI_STATUS once and save the bit
> > in the struct pci_dev?  We could do that in pci_enable_pri(), or if we
> > might need the value before that's called, we could add a
> > pci_pri_init() and do it there.
> 
> Yes, caching PASID Required bit in pci_pri_init() function would
> provide performance benefits. But another thing to consider is,
> since this bit is same for both PF/VF, is it worth to add this bit
> it to struct pci_dev?or struct pci_sriov is the more appropriate
> place?

IIUC, the PRI capability is not specific to SR-IOV, so I don't think
it would make sense to cache PRG Response PASID Required in pci_sriov.

PFs may implement PRI; VFs do not (PCIe r5.0, sec 10.5.2), so I think
the bit should be cached in the pci_dev, and if we want to know the
value for a VF, we should read it from the PF's pci_dev.

Bjorn
