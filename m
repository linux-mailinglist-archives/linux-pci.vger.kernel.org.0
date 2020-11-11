Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15CA92AFA2B
	for <lists+linux-pci@lfdr.de>; Wed, 11 Nov 2020 22:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgKKVGz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Nov 2020 16:06:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:42544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbgKKVGy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Nov 2020 16:06:54 -0500
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B8F020665;
        Wed, 11 Nov 2020 21:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605128813;
        bh=SPpnezmPCqGkErFMuYv3G8C5qzZ4JuroEdkA21GTq8k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=WzJ2iUQLp8YY7WrJfQMwNwSBKMVV79IQCmbyOKIUFj6KzSwTQUrmm6tQjkOUw7otT
         SU7765oRVS6RyEcGAnSLrsgr/JavZi0rkajFHYMpSG/AbQsqGHGVyKPanaGXafdY+s
         SdBA/pHyPO5U3Ofzb04Dv5vJu91L/iX6GQmKyRtk=
Date:   Wed, 11 Nov 2020 15:06:51 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>
Subject: Re: New Defects reported by Coverity Scan for Linux
Message-ID: <20201111210651.GA967833@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJ4qVTyUGr3Stn2GaoaYpTJRhSTMw2KKdjVS1+H=uPVWA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 11, 2020 at 09:34:10AM -0600, Rob Herring wrote:
> On Tue, Nov 10, 2020 at 5:36 PM Gustavo Pimentel
> <Gustavo.Pimentel@synopsys.com> wrote:
> > On Tue, Nov 10, 2020 at 17:16:41, Bjorn Helgaas <helgaas@kernel.org>
> > wrote:
> >
> > > New Coverity complaint about v5.10-rc3, resulting from 9fff3256f93d
> > > ("PCI: dwc: Restore ATU memory resource setup to use last entry").
> > >
> > > I didn't try to figure out if this is real or a false positive, so
> > > just FYI.
> > >
> > > ----- Forwarded message from scan-admin@coverity.com -----
> > >
> > > Date: Mon, 09 Nov 2020 11:13:37 +0000 (UTC)
> > > From: scan-admin@coverity.com
> > > To: bjorn@helgaas.com
> > > Subject: New Defects reported by Coverity Scan for Linux
> > > Message-ID: <5fa924618fb3b_a62932acac7322f5033088@prd-scan-dashboard-0.mail>
> > >
> > > ** CID 1469110:  Null pointer dereferences  (FORWARD_NULL)
> > > /drivers/pci/controller/dwc/pcie-designware-host.c: 596 in dw_pcie_setup_rc()
> > >
> > > ________________________________________________________________________________________________________
> > > *** CID 1469110:  Null pointer dereferences  (FORWARD_NULL)
> > > /drivers/pci/controller/dwc/pcie-designware-host.c: 596 in dw_pcie_setup_rc()
> > > 590
> > > 591                   /* Get last memory resource entry */
> > > 592                   resource_list_for_each_entry(tmp, &pp->bridge->windows)
> > > 593                           if (resource_type(tmp->res) == IORESOURCE_MEM)
> >
> > Can the pp->bridge->windows list be empty in a typical use case?
> 
> Only if the DT has missing/malformed 'ranges'. 'ranges' is required to
> have any memory or i/o space, so we would error out before this point.

There are a lot of paths that lead here, and it's an awful lot of work
to verify that they all correctly error out if 'ranges' is invalid.

It would really be nice if we could structure this in such a way that
local analysis could show that we never dereference a null pointer
here.

I wouldn't want to uglify the code unnecessarily, but if a small code
change could avoid this false positive, I think it might be worth
doing.

Bjorn
