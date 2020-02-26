Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59030170AD6
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2020 22:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbgBZVs6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Feb 2020 16:48:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:55866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727503AbgBZVs6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Feb 2020 16:48:58 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 858A124670;
        Wed, 26 Feb 2020 21:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582753737;
        bh=I4qBE2Lu98HMylNu8wa2EtjZdqrPtZCAh9D+MOcEJNk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=NnxTFGGUr3KKT4drrAzAbpkB8Aaz5HEG4CuhlLRbJDxSVvl3IY8wuOk6EL+N/rn0w
         duNGEQNNOeyBX42TD218b4cONLlazx4fKSChHUyEhdxh9Wlsdka4l09jvHItR9PLCe
         ITHaZhS4kFKOIbauEQiZSD8U1u2+W2ybobBzynWA=
Date:   Wed, 26 Feb 2020 15:48:55 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com
Subject: Re: [PATCH v15 3/5] PCI/EDR: Export AER, DPC and error recovery
 functions
Message-ID: <20200226214855.GA175196@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b37ed9b-3d6f-ea94-4591-86f9d5bbe543@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 26, 2020 at 01:26:09PM -0800, Kuppuswamy Sathyanarayanan wrote:
> On 2/26/20 1:13 PM, Bjorn Helgaas wrote:
> > On Wed, Feb 26, 2020 at 11:30:43AM -0800, Kuppuswamy Sathyanarayanan wrote:
> > > On 2/25/20 5:02 PM, Bjorn Helgaas wrote:
> > > > On Thu, Feb 13, 2020 at 10:20:15AM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> > > > > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > > > ...

> > > > > diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> > > > > index 99fca8400956..acae12dbf9ff 100644
> > > > > --- a/drivers/pci/pcie/dpc.c
> > > > > +++ b/drivers/pci/pcie/dpc.c
> > > > > @@ -15,15 +15,9 @@
> > > > >    #include <linux/pci.h>
> > > > >    #include "portdrv.h"
> > > > > +#include "dpc.h"
> > > > >    #include "../pci.h"
> > > > > -struct dpc_dev {
> > > > > -	struct pci_dev		*pdev;
> > > > > -	u16			cap_pos;
> > > > > -	bool			rp_extensions;
> > > > > -	u8			rp_log_size;
> > > > > -};

> > > > Adding dpc.h shouldn't be in this patch because there's no need for a
> > > > separate dpc.h file yet -- it's only included this one place.  I'm not
> > > > positive a dpc.h is needed at all -- see comments on patch [4/5].

> > > Yes, if we use pdev in dpc functions used by EDR code, we should
> > > not need it.

> > I think struct dpc_dev might be more trouble than it's worth.  I
> > attached a possible patch at the end that folds the 25 bits of
> > DPC-related info into the struct pci_dev and gets rid of struct
> > dpc_dev completely.  I compiled it but haven't tested it.

> That would solve most of my export issues. Do you want me
> to add it to my patch list or merge it separately.

If you want to use that, I would merge it first, followed by the error
clearing cleanup, followed by the other EDR stuff.

Bjorn
