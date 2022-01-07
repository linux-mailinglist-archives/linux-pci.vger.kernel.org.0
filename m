Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580F8487C08
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jan 2022 19:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348801AbiAGSSY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jan 2022 13:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348834AbiAGSSX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jan 2022 13:18:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838A8C061574;
        Fri,  7 Jan 2022 10:18:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D537761F8C;
        Fri,  7 Jan 2022 18:18:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F5C8C36AE0;
        Fri,  7 Jan 2022 18:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641579502;
        bh=uOEOl/NwRA3PkSryb0Xx+c1DctY6qveaChGe30yKiWs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lAXkRk1kurXScMSVF1vdjDUZa6d6WKgp/GPeEcCR7b8nS6Xclc6WhWjpiAxlIoBhh
         Ssx0jlaZnsFYcx0JMHq34YsKtwSXjaarpEbTWBFm25j4Rl6NjJKGa4Vrs6OLtNNHTc
         Y+b57HMpGS0yeAD1J2HJP8KeUtF/HkdW2ANosLzVOjuANsUEXhr5i0VzVpxD9OMmH8
         iL3h1XxZTNia6orD1ZH6NsAjCvuiTdvTDkgOuMI63XzIfREwEtPgx4zYCj2cOFMcNy
         jsfFJkEUlpdyJdj9cd+kFovuV0V1hcEY7d0vjnYJ9Cd03rF6bsJOizaxAcYMC0InfV
         62N4Sjr3oi5Ig==
Received: by pali.im (Postfix)
        id 7AF42B22; Fri,  7 Jan 2022 19:18:19 +0100 (CET)
Date:   Fri, 7 Jan 2022 19:18:19 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/15] PCI: mvebu: Check that PCI bridge specified in DT
 has function number zero
Message-ID: <20220107181819.yiya3mxhtfsnubg4@pali>
References: <20211125124605.25915-4-pali@kernel.org>
 <20220107181512.GA390598@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220107181512.GA390598@bhelgaas>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 07 January 2022 12:15:12 Bjorn Helgaas wrote:
> On Thu, Nov 25, 2021 at 01:45:53PM +0100, Pali Rohár wrote:
> > Driver cannot handle PCI bridges at non-zero function address. So add
> > appropriate check. Currently all in-tree kernel DTS files set PCI bridge
> > function to zero.
> 
> Why can the driver not handle bridges at non-zero function addresses?
> The PCI spec allows that, doesn't it?  Is this a hardware limitation?

It is software / kernel limitation.

Because this bridge is virtual, emulated by pci-bridge-emul.c driver and
this driver can emulate only single function PCI-to-PCI bridge device.

> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > Cc: stable@vger.kernel.org
> > ---
> >  drivers/pci/controller/pci-mvebu.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> > index 6197f7e7c317..08274132cdfb 100644
> > --- a/drivers/pci/controller/pci-mvebu.c
> > +++ b/drivers/pci/controller/pci-mvebu.c
> > @@ -864,6 +864,11 @@ static int mvebu_pcie_parse_port(struct mvebu_pcie *pcie,
> >  	port->devfn = of_pci_get_devfn(child);
> >  	if (port->devfn < 0)
> >  		goto skip;
> > +	if (PCI_FUNC(port->devfn) != 0) {
> > +		dev_err(dev, "%s: invalid function number, must be zero\n",
> > +			port->name);
> > +		goto skip;
> > +	}
> >  
> >  	ret = mvebu_get_tgt_attr(dev->of_node, port->devfn, IORESOURCE_MEM,
> >  				 &port->mem_target, &port->mem_attr);
> > -- 
> > 2.20.1
> > 
