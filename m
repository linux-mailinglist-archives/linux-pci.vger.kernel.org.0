Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8805E19477
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2019 23:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfEIVTA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 May 2019 17:19:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:47088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbfEIVTA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 May 2019 17:19:00 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE9C5217D7;
        Thu,  9 May 2019 21:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557436740;
        bh=K63oQoX5f/fyDzaZhwVLDRCJLMD2wumXjAh6iXS2tMg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i4aMKD9xahdHPrF0rxnyYzW5WI6m4Vq6Hsrc1EhXQD6daI/xGeKjJADaqpnirJWeL
         8XN8h+rqrOe2htPhGCipu3ZmeX8B1xQzNEFmp0SAS2kmHMXP8x+WpIypzURaWm15Gf
         /Q3kLQVYCykuZ7xj1v0gHWIIMV88VCHOEN39SxLQ=
Date:   Thu, 9 May 2019 16:18:58 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Frederick Lawler <fred@fredlawl.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/10] PCI/DPC: Log messages with pci_dev, not pcie_device
Message-ID: <20190509211858.GD235064@google.com>
References: <20190509141456.223614-1-helgaas@kernel.org>
 <20190509141456.223614-4-helgaas@kernel.org>
 <CAHp75Vd=fm4Sdc_ymiPgXnrCsU_9gBF16TsP0VX=ghDrbvk1Yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vd=fm4Sdc_ymiPgXnrCsU_9gBF16TsP0VX=ghDrbvk1Yw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 09, 2019 at 08:39:28PM +0300, Andy Shevchenko wrote:
> On Thu, May 9, 2019 at 5:18 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > Log messages with pci_dev, not pcie_device.  Factor out common message
> > prefixes with dev_fmt().
> >
> > Example output change:
> >
> >   - dpc 0000:00:01.1:pcie008: DPC error containment capabilities...
> >   + pcieport 0000:00:01.1: DPC: error containment capabilities...
> 
> Overall same question about Capitalizing sentences.

I think that consistency would be nice.  But I'm not sure whether the
consensus is capitalize or not, and I would want to do all of
drivers/pci in a single patch so there's a clear precedent to follow,
so I think that's slightly out of scope for this series.

> > +       pci_err(pdev, "rp_pio_status: %#010x, rp_pio_mask: %#010x\n",
> 
> And here perhaps RP PIO status: ... mask: ... ?
> See below I left examples from this patch.

Same thing here.  I noticed this as well, but didn't want to pollute
these patches with other cleanups that were not really related, so
this could be done in the future.  But I certainly agree it's weird to
have "rp_pio_status:" and "RP PIO severity=".

> >                 status, mask);
> 
> > +       pci_err(pdev, "RP PIO severity=%#010x, syserror=%#010x, exception=%#010x\n",
> >                 sev, syserr, exc);
> 
> > +       pci_err(pdev, "RP PIO ImpSpec Log %#010x\n", log);
> 
> > +                       pci_err(pdev, "RP PIO log size %u is invalid\n",
> >                                 dpc->rp_log_size);
> 
> -- 
> With Best Regards,
> Andy Shevchenko
