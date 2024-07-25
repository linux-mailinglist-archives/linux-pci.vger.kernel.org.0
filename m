Return-Path: <linux-pci+bounces-10763-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA0493BC38
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 07:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64F84285305
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 05:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E939713DDA7;
	Thu, 25 Jul 2024 05:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uDUDqTEF"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B798C13D8B3;
	Thu, 25 Jul 2024 05:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721886846; cv=none; b=S4T9tcjzkWxy73z/i/771g59l/6fgXl4y8DfVVHEqp1gqn2idV8W6XyHR1/vzKGam50s9gdnQL9r2BaJHOeuKZS18zjrVRFo5FEym1bP8czzHat+w5NFmPepznicNGcz1oN0ikfkAOr4nq0T3CZAigQXTbIdtVsACrjzieqQApI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721886846; c=relaxed/simple;
	bh=iAhpckX3WLrcRDqsdq49YABDpgjH8cOYW51iK4Yi9U8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ClZPmCRcAAvzOj6zPiWjiwNkHAXyad7OYP2g1fMsv1AlUNPFe+qm0UFtEzv6WPqpZdPnG7ygkFfp4fx451EI1wRxZkOdLSQX94Y/ft9dfj6hN5PPt58c43uZKivzEjZGF54ipi0gLIiNUW3T4cNPc3f7BKPvLhnUX0Ry1iErEs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uDUDqTEF; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46P5rjpS103866;
	Thu, 25 Jul 2024 00:53:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1721886825;
	bh=mXvRUEWdVcaZN+h7WS/2ZfLarQXHOiOFcVf6Y4xsMmk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=uDUDqTEFebvRL+mGuS7XzdeAdDfZjK7FyzbbotNDJOjJSFJ/9UHI/GUUQFG3wEEzE
	 oRf2Nk/luJL73FkeBw1SKjiI7CwR4B07idkRCJHhz8alcQo5eSI6pF1QlTRlurO4K0
	 DQXFiuVx1MXjC4EZENZl+d70b4ym52gTNTHEzIhk=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46P5rjaO044137
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 25 Jul 2024 00:53:45 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Jul 2024 00:53:45 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Jul 2024 00:53:45 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46P5rihr080277;
	Thu, 25 Jul 2024 00:53:44 -0500
Date: Thu, 25 Jul 2024 11:23:43 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <bhelgaas@google.com>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <vigneshr@ti.com>, <kishon@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <stable@vger.kernel.org>, <ahalaney@redhat.com>, <srk@ti.com>
Subject: Re: [PATCH] PCI: j721e: Set .map_irq and .swizzle_irq to NULL
Message-ID: <be3e3c5f-0d48-41b0-87f4-2210f13b9460@ti.com>
References: <20240724065048.285838-1-s-vadapalli@ti.com>
 <20240724162304.GA802428@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240724162304.GA802428@bhelgaas>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Wed, Jul 24, 2024 at 11:23:04AM -0500, Bjorn Helgaas wrote:
> Subject should say something about why this change is needed, not just
> translate the C code to English.

My intent was to summarize the change to make it easy for anyone to find
out what's being done. The commit message below explains in detail as to
why they are set to NULL. As an alternative, I could change the $subject
to:
PCI: j721e: Disable INTx mapping and swizzling
where the "Disable" is equivalent to NULL. Kindly let me know if this is
acceptable or needs to be improved further.

> 
> On Wed, Jul 24, 2024 at 12:20:48PM +0530, Siddharth Vadapalli wrote:
> > Since the configuration of Legacy Interrupts (INTx) is not supported, set
> 
> I assume you mean J721E doesn't support INTx?

Yes, the driver support doesn't exist and the device-tree also doesn't
have the required nodes. Kishon had posted a series to enable it for
J721E, J7200 and AM64 on the 4th of August 2021:
https://lore.kernel.org/r/20210804132912.30685-1-kishon@ti.com/
and based on the discussion on the series, an Errata was discovered for
J721E:
https://www.ti.com/lit/er/sprz455d/sprz455d.pdf
i2094: PCIe: End of Interrupt (EOI) Not Enabled for PCIe Legacy Interrupts

Thus, there is no support for Legacy Interrupts (INTx) in the pci-j721e.c
driver and as a consequence, no device-tree nodes either.

> 
> > the .map_irq and .swizzle_irq callbacks to NULL. This fixes the error:
> >   of_irq_parse_pci: failed with rc=-22
> 
> I guess this happens because devm_of_pci_bridge_init() initializes
> .map_irq and .swizzle_irq unconditionally?

Yes. The PCIe Controller on J721E and other SoCs is the Cadence PCIe
Controller. In the commit which added driver support for the Cadence
PCIe Controller's Host functionality:
https://github.com/torvalds/linux/commit/1b79c5284439
'map_irq' and 'swizzle_irq' were set to the same functions:
'of_irq_parse_and_map_pci()' and 'pci_common_swizzle()'
respectively. Commit:
https://github.com/torvalds/linux/commit/b64aa11eb2dd
extracted out the shared defaults from multiple Host Controller drivers
and moved them into the common 'devm_of_pci_bridge_init()' function.

While 'map_irq' and 'swizzle_irq' are unconditionally set to the
defaults in 'devm_of_pci_bridge_init()', those Host Controller driver
which haven't been using the shared defaults do have the choice of
overriding them in the driver (which is already being done).

Similarly, for pci-j721e.c, since the shared defaults inherited from the
Cadence PCIe Controller are not applicable (due to the Errata), the
pci-j721e.c driver should override them to NULL as done in this patch.

> 
> I'm not sure the default assumption should be that a host bridge
> supports INTx.
> 
> Maybe .map_irq and .swizzle_irq should only be set when we discover
> some information about INTx routing, e.g., an ACPI _PRT or the
> corresponding DT properties.

I believe that the defaults were set since most of the Host drivers were
using them in their respective drivers as indicated in the commit:
https://github.com/torvalds/linux/commit/b64aa11eb2dd

[...]

> > 
> >  drivers/pci/controller/cadence/pci-j721e.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> > index 85718246016b..5372218849a8 100644
> > --- a/drivers/pci/controller/cadence/pci-j721e.c
> > +++ b/drivers/pci/controller/cadence/pci-j721e.c
> > @@ -417,6 +417,10 @@ static int j721e_pcie_probe(struct platform_device *pdev)
> >  		if (!bridge)
> >  			return -ENOMEM;
> >  
> > +		/* Legacy interrupts are not supported */
> 
> Say "INTx" explicitly here instead of assuming "legacy" == "INTx".

Sure. I will update it in the v2 patch.

Thank you for reviewing this patch and sharing your feedback.

Regards,
Siddharth.

