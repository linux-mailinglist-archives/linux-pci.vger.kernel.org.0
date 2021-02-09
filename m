Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54FCB315679
	for <lists+linux-pci@lfdr.de>; Tue,  9 Feb 2021 20:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbhBITFP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Feb 2021 14:05:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:47728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233236AbhBISzB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Feb 2021 13:55:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2291A64EC7;
        Tue,  9 Feb 2021 18:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612896768;
        bh=Um0381MQlq+jw86AMsINGntInS+/cd/swF0D0oxyDkg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=a0YHiuhrUOmX477wtoeOkZ9D6VCgv5H26YzN4QUfKr9RB7PwoTD4iSlK5AurFFgqn
         f4MwS6Q0yOzZlGAuwm6HD3LJAYYFNcpm3/MolYNdH3dHthgNTfQMOTeJ8ngtcyKuKR
         pYKGqVY7+JW/MX8QxhIYafDEU1gRHidgW3QXK7xJ8EQzJ3mddopn4NL/f2Hljuta+1
         xLDf1xxbZFQ9yIHfdumBj6nlc/QuD24d6KMs5Qej3mcdKRI44mrhLB1Dpe90hsNeQV
         gsPfop5Dc6lG8YLc84/cxx3RtaM6N/az5Mt7vTPrqXRyaT6KVmLRf4+sag/ckBmuN6
         b03u1x+vniN3w==
Date:   Tue, 9 Feb 2021 12:52:46 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [RESEND v4 1/6] misc: Add Synopsys DesignWare xData IP driver
Message-ID: <20210209185246.GA494880@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM5PR12MB18350F331485A6FF36ED28DADA8E9@DM5PR12MB1835.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 09, 2021 at 03:28:16PM +0000, Gustavo Pimentel wrote:
> On Mon, Feb 8, 2021 at 22:53:54, Krzysztof Wilczyński <kw@linux.com> 
> wrote:
> > [...]
> > > Thanks for your review. I will wait for a couple of days, before sending 
> > > a new version of this patch series based on your feedback.
> > 
> > Thank you!
> > 
> > There might be one more change, and improvement, to be done as per
> > Bjorn's feedback, see:
> > 
> >   https://urldefense.com/v3/__https://lore.kernel.org/linux-pci/20210208193516.GA406304@bjorn-Precision-5520/__;!!A4F2R9G_pg!Oxp56pU_UN6M2BhfNRSdYqsFUncqVklBj_1IdLQD_w_V6dKRPDO_FjPUystMa5D39SRj8uo$ 
> > 
> > The code in question would be (exceprt from the patch):
> > 
> > [...]
> > +static int dw_xdata_pcie_probe(struct pci_dev *pdev,
> > +			       const struct pci_device_id *pid)
> > +{
> > +	const struct dw_xdata_pcie_data *pdata = (void *)pid->driver_data;
> > +	struct dw_xdata *dw;
> > [...]
> > +	dw->rg_region.vaddr = pcim_iomap_table(pdev)[pdata->rg_bar];
> > +	if (!dw->rg_region.vaddr)
> > +		return -ENOMEM;
> > [...]
> > 
> > Perhaps something like the following would would?
> > 
> > void __iomem * const *iomap_table;
> > 
> > iomap_table = pcim_iomap_table(pdev);
> > if (!iomap_table)
> >         return -ENOMEM;
> > 
> > dw->rg_region.vaddr = iomap_table[pdata->rg_bar];
> > if (!dw->rg_region.vaddr)
> > 	return -ENOMEM;
> > 
> > With sensible error messages added, of course.  What do you think?
> 
> I think all the improvements are welcome. I will do that.
> My only doubt is if Bjorn recommends removing the 
> iomap_table[pdata->rg_bar] check, after adding the verification on the 
> pcim_iomap_table, because all other drivers doesn't do that.

I misunderstood the usage of pcim_iomap_table() -- it looks like one
must call pcim_iomap_regions() *first*, and test its result, and
*that* is where we should catch any pcim_iomap_table() failures, e.g.,

  rc = pcim_iomap_regions()   # or pcim_iomap_regions_request_all()
  if (rc)
    return rc;                # pcim_iomap_table() or other failure

  vaddr = pcim_iomap_table()[BAR];
  if (!vaddr)
    return -ENOMEM;           # BAR doesn't exist

You *do* correctly call pcim_iomap_regions() first, which calls
pcim_imap_table() internally, so if pcim_iomap_table() were to return
NULL, you should catch it there.

Then we assume that the subsequent "pcim_iomap_table()[BAR]" call will
succeed and NOT return NULL, so it should be safe to index into the
table.  And if the table[BAR] entry is NULL, it means the BAR doesn't
exist or isn't mapped.

That sort of makes sense, but the API design doesn't quite seem
obviously correct to me.  The table was created by
pcim_iomap_regions(), and pcim_iomap_table() is basically retrieving
that artifact.

I wonder if it could be improved by making pcim_iomap_table() strictly
internal to devres.c and having the pcim_iomap functions return the
table directly.  Then the code would look something like this:

  table = pcim_iomap_regions();
  if (IS_ERR(table))
    return PTR_ERR(table);    # pcim_iomap_table() or other failure

  vaddr = table[BAR];         # "table" is guaranteed to be non-NULL
  if (!vaddr)
    return -ENOMEM;

Obviously this is not something you should do for *this* series.
I think you should follow the example of other drivers, which means
keeping your patch exactly as you posted it.  I'm just interested in
opinions on this as a possible future API improvement.

Bjorn
