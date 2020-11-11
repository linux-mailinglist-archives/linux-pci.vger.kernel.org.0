Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC9F2AFB79
	for <lists+linux-pci@lfdr.de>; Wed, 11 Nov 2020 23:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgKKWiT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Nov 2020 17:38:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:42690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726698AbgKKWgS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Nov 2020 17:36:18 -0500
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82A83208FE;
        Wed, 11 Nov 2020 22:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605133778;
        bh=nhL3zDC2cu9ECuf/EjEmddbUzNGl6XB+KcxciHyfxIg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=WYbPxyGHItIogP9N/qogHFF0VxqqBTuxMmPzwcLW4niXK91oexIp5ZziWynNJ6zTn
         y8s7LBfGEkQAKW5bImzSB4HYA6vkyGcyQD8VVvZLI7c/B4raCIMB6mscDhKlXKDD9p
         xIAoQK+8xyxfEmpnyeMks0sLclWImx2BYPtlGf5w=
Date:   Wed, 11 Nov 2020 16:29:37 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "amurray@thegoodpenguin.co.uk" <amurray@thegoodpenguin.co.uk>,
        "robh@kernel.org" <robh@kernel.org>,
        "treding@nvidia.com" <treding@nvidia.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kthota@nvidia.com" <kthota@nvidia.com>,
        "mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>,
        "sagar.tv@gmail.com" <sagar.tv@gmail.com>
Subject: Re: [PATCH V2] PCI: dwc: Add support to configure for ECRC
Message-ID: <20201111222937.GA977451@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b4a728e-bfa3-42a2-423d-e270e8993901@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 11, 2020 at 10:21:46PM +0530, Vidya Sagar wrote:
> 
> 
> On 11/11/2020 9:57 PM, Jingoo Han wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On 11/11/20, 7:12 AM, Vidya Sagar wrote:
> > > 
> > > DesignWare core has a TLP digest (TD) override bit in one of the control
> > > registers of ATU. This bit also needs to be programmed for proper ECRC
> > > functionality. This is currently identified as an issue with DesignWare
> > > IP version 4.90a.
> > > 
> > > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > > ---
> > > V2:
> > > * Addressed Bjorn's comments
> > > 
> > >   drivers/pci/controller/dwc/pcie-designware.c | 52 ++++++++++++++++++--
> > >   drivers/pci/controller/dwc/pcie-designware.h |  1 +
> > >   2 files changed, 49 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > index c2dea8fc97c8..ec0d13ab6bad 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > @@ -225,6 +225,46 @@ static void dw_pcie_writel_ob_unroll(struct dw_pcie *pci, u32 index, u32 reg,
> > >        dw_pcie_writel_atu(pci, offset + reg, val);
> > >   }
> > > 
> > > +static inline u32 dw_pcie_enable_ecrc(u32 val)
> > 
> > What is the reason to use inline here?
>
> Actually, I wanted to move the programming part inside the respective APIs
> but then I wanted to give some details as well in comments so to avoid
> duplication, I came up with this function. But, I'm making it inline for
> better code optimization by compiler.

I don't really care either way, but I'd be surprised if the compiler
didn't inline this all by itself even without the explicit "inline".

> > > +{
> > > +     /*
> > > +      * DesignWare core version 4.90A has this strange design issue
> > > +      * where the 'TD' bit in the Control register-1 of the ATU outbound
> > > +      * region acts like an override for the ECRC setting i.e. the presence
> > > +      * of TLP Digest(ECRC) in the outgoing TLPs is solely determined by
> > > +      * this bit. This is contrary to the PCIe spec which says that the
> > > +      * enablement of the ECRC is solely determined by the AER registers.
> > > +      *
> > > +      * Because of this, even when the ECRC is enabled through AER
> > > +      * registers, the transactions going through ATU won't have TLP Digest
> > > +      * as there is no way the AER sub-system could program the TD bit which
> > > +      * is specific to DesignWare core.
> > > +      *
> > > +      * The best way to handle this scenario is to program the TD bit
> > > +      * always. It affects only the traffic from root port to downstream
> > > +      * devices.
> > > +      *
> > > +      * At this point,
> > > +      * When ECRC is enabled in AER registers, everything works normally
> > > +      * When ECRC is NOT enabled in AER registers, then,
> > > +      * on Root Port:- TLP Digest (DWord size) gets appended to each packet
> > > +      *                even through it is not required. Since downstream
> > > +      *                TLPs are mostly for configuration accesses and BAR
> > > +      *                accesses, they are not in critical path and won't
> > > +      *                have much negative effect on the performance.
> > > +      * on End Point:- TLP Digest is received for some/all the packets coming
> > > +      *                from the root port. TLP Digest is ignored because,
> > > +      *                as per the PCIe Spec r5.0 v1.0 section 2.2.3
> > > +      *                "TLP Digest Rules", when an endpoint receives TLP
> > > +      *                Digest when its ECRC check functionality is disabled
> > > +      *                in AER registers, received TLP Digest is just ignored.
> > > +      * Since there is no issue or error reported either side, best way to
> > > +      * handle the scenario is to program TD bit by default.
> > > +      */
> > > +
> > > +     return val | PCIE_ATU_TD;
> > > +}
