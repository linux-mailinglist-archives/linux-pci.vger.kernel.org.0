Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEEA26539B
	for <lists+linux-pci@lfdr.de>; Thu, 10 Sep 2020 23:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgIJVhl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Sep 2020 17:37:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:49328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730717AbgIJNdY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Sep 2020 09:33:24 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E553C20809;
        Thu, 10 Sep 2020 13:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599744717;
        bh=qJqfgEjM1JHkm7fFx5w2wAwPbg8pDBoa1SA0YP/hTRw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=G+knM3WxDFUjRMS6LVKoufrc8iZ7RkD3+M3b6Iob39UGeFuC0yx1StLvAZSXrk3eE
         90m2/vrAEnLx+FvxIKkDDAOt8feCA2zXVZg7Cv/lO2RBnkYBvDz72xi2x1C2HRBRVn
         VR4cjlxWJ8K2MwKk8up580rEFdZa64hoWb+OzyP4=
Date:   Thu, 10 Sep 2020 08:31:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH v1] PCI: pcie_bus_config can be set at build time
Message-ID: <20200910133155.GA782074@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+-6iNzyuVm4gw2socQuQtdrXWCam3GfQj61jYJEUa75fnbvtQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 10, 2020 at 08:57:10AM -0400, Jim Quinlan wrote:
> Hi Bjorn,
> 
> On Wed, Sep 9, 2020 at 10:25 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Tue, Sep 08, 2020 at 12:32:48PM -0400, Jim Quinlan wrote:
> > > The Kconfig is modified so that the pcie_bus_config setting can be done at
> > > build time in the same manner as the CONFIG_PCIEASPM_XXXX choice.  The
> > > pci_bus_config setting may still be overridden by the bootline param.
> >
> > I guess...  I really hate these build-time config settings for both
> > ASPM and MPS/MRRS.  But Linux just isn't smart or flexible enough to
> > do the right thing at run-time, so I guess we're kind of stuck.
> >
> > I guess you have systems where you need a different default?
>
> Yes, we've been shipping our kernel with the DEFAULT and since we do
> not have FW it is not configured optimally.  Some customers have
> noticed and I tell them to put 'pci=pcie_bus_safe' on their bootline
> but I'd rather have this setting work for all customers as it yields
> the option we want.

I'm guessing you probably don't have any hotplug slots.  Seems like we
ought to be able to recognize that and pick pcie_bus_safe
automatically.  Someday.

Maybe that's part of the description: if you have a closed system with
no possibility of adding new devices, we can use the largest MPS
that's supported by all devices, i.e., pcie_bus_safe.

> > It'd be nice if we could put a little more detail in the Kconfig to
> > help users choose the correct one.  "Ensure MPS matches upstream
> > bridge" is *accurate*, but it doesn't really tell me why I would
> > choose this rather than a different one.
>
> IIRC I just copied the comments that were in the bootline settings.
> I'm concerned about there being the same comment in two places; sooner
> or later someone will update one place and not the other.

True.  It'd be nice if we at least had *one* place with a useful
description.  I don't think we have any today.

Bjorn
