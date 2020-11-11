Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 600BB2AFB21
	for <lists+linux-pci@lfdr.de>; Wed, 11 Nov 2020 23:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgKKWLM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Nov 2020 17:11:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:56980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbgKKWLL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Nov 2020 17:11:11 -0500
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A975208B8
        for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2020 22:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605132670;
        bh=Zcg6vF0y0SO/L8/MjjmEXiMs8Ypu+7IV8EuXwJgTm78=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jGDAWtW43R5gFTKSaf+DBA+gfioW8LiJyZFUf0Exe4HxPiOd5C50zHJoaBYQlEVXJ
         g/t89Ui2C0aXq3w7eGPA0tEbV/F9I8o5WsGyqAGZoou7Zi2Kws9leKuTLKjKq2ckgI
         wSrbpnimdyJ4qDtkB9Miai4vfT+6bdOKhTMHlSoc=
Received: by mail-oi1-f179.google.com with SMTP id t16so3947700oie.11
        for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2020 14:11:10 -0800 (PST)
X-Gm-Message-State: AOAM532w9SYdcQWe+2KkmvdWtahAd9JNhkKr0qJmcoULdQ97DZXDjSHY
        YGdZ5aFMDdKqsmlVjtpuHlwyktHbdRdLVY1aCw==
X-Google-Smtp-Source: ABdhPJwznD6/6mWwmA0H0SueGAbbKfk5GHGB9TQQ3G3t3WVSMEbggmV4Iyls2C5gl/Ij+GaI23UbACwoWTbZPEgPCLQ=
X-Received: by 2002:aca:5dc2:: with SMTP id r185mr3604563oib.106.1605132669269;
 Wed, 11 Nov 2020 14:11:09 -0800 (PST)
MIME-Version: 1.0
References: <CAL_JsqJ4qVTyUGr3Stn2GaoaYpTJRhSTMw2KKdjVS1+H=uPVWA@mail.gmail.com>
 <20201111210651.GA967833@bjorn-Precision-5520>
In-Reply-To: <20201111210651.GA967833@bjorn-Precision-5520>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 11 Nov 2020 16:10:57 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+Yvykde12ECvFOyW_3bb3k71bC16=cuzX=f+UGRrz6gg@mail.gmail.com>
Message-ID: <CAL_Jsq+Yvykde12ECvFOyW_3bb3k71bC16=cuzX=f+UGRrz6gg@mail.gmail.com>
Subject: Re: New Defects reported by Coverity Scan for Linux
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 11, 2020 at 3:06 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Nov 11, 2020 at 09:34:10AM -0600, Rob Herring wrote:
> > On Tue, Nov 10, 2020 at 5:36 PM Gustavo Pimentel
> > <Gustavo.Pimentel@synopsys.com> wrote:
> > > On Tue, Nov 10, 2020 at 17:16:41, Bjorn Helgaas <helgaas@kernel.org>
> > > wrote:
> > >
> > > > New Coverity complaint about v5.10-rc3, resulting from 9fff3256f93d
> > > > ("PCI: dwc: Restore ATU memory resource setup to use last entry").
> > > >
> > > > I didn't try to figure out if this is real or a false positive, so
> > > > just FYI.
> > > >
> > > > ----- Forwarded message from scan-admin@coverity.com -----
> > > >
> > > > Date: Mon, 09 Nov 2020 11:13:37 +0000 (UTC)
> > > > From: scan-admin@coverity.com
> > > > To: bjorn@helgaas.com
> > > > Subject: New Defects reported by Coverity Scan for Linux
> > > > Message-ID: <5fa924618fb3b_a62932acac7322f5033088@prd-scan-dashboard-0.mail>
> > > >
> > > > ** CID 1469110:  Null pointer dereferences  (FORWARD_NULL)
> > > > /drivers/pci/controller/dwc/pcie-designware-host.c: 596 in dw_pcie_setup_rc()
> > > >
> > > > ________________________________________________________________________________________________________
> > > > *** CID 1469110:  Null pointer dereferences  (FORWARD_NULL)
> > > > /drivers/pci/controller/dwc/pcie-designware-host.c: 596 in dw_pcie_setup_rc()
> > > > 590
> > > > 591                   /* Get last memory resource entry */
> > > > 592                   resource_list_for_each_entry(tmp, &pp->bridge->windows)
> > > > 593                           if (resource_type(tmp->res) == IORESOURCE_MEM)
> > >
> > > Can the pp->bridge->windows list be empty in a typical use case?
> >
> > Only if the DT has missing/malformed 'ranges'. 'ranges' is required to
> > have any memory or i/o space, so we would error out before this point.
>
> There are a lot of paths that lead here, and it's an awful lot of work
> to verify that they all correctly error out if 'ranges' is invalid.

There used to be, but I've gotten rid of most. There's also only one
caller of dw_pcie_setup_rc() in the probe path with my latest series
of DWC cleanups that's not applied yet. The only other callers are
from a couple of resume hooks (which I plan to define common functions
for).

The pci_host_bridge allocation/init fails if bridge->windows is not
populated. But actually, 'windows' can never be NULL as it is a
list_head. So it's pp or pp->bridge being NULL that's the complaint,
but that doesn't really change things. The flow is like this:

dw_pcie_host_init()
    -> devm_pci_alloc_host_bridge()
    pp->bridge = bridge;
    ...
    -> dw_pcie_setup_rc()

> It would really be nice if we could structure this in such a way that
> local analysis could show that we never dereference a null pointer
> here.

I've considered making struct pcie_port and struct pci_host_bridge a
single allocation. I'm not sure that's really worth doing though.

> I wouldn't want to uglify the code unnecessarily, but if a small code
> change could avoid this false positive, I think it might be worth
> doing.

Other than also passing in bridge ptr, not sure. Maybe if it is static
which will happen with a common resume routine. That would just shift
the problem though it would be a bit clearer that we really couldn't
ever get to a resume callback with a NULL.

Rob
