Return-Path: <linux-pci+bounces-10779-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4288493BDDC
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 10:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3E1D1F21A42
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 08:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1771816B73E;
	Thu, 25 Jul 2024 08:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NSg1AWdF"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EC3E556;
	Thu, 25 Jul 2024 08:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721895639; cv=none; b=rVfl7RhMKkdhwY3vtpIXq/bevUxqK3H/VZ0nBwYju/Ia/YHBIHjfUrlpo6iD6FV3dmlNolwNAxh/rTAaIEahyrVW4shtCYQe1338WeAS9FEtQ3pjOmg+/S7qoLzEHZ1poCsEEIvhtr8MYfi9KXBjTfHm3YywBznyVLgAvkEhFCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721895639; c=relaxed/simple;
	bh=Mz40wFM8hoDfhy8uyCV2iGleFgOToDDb0dSDjyLrWOk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nDKw7DHOFS4VhEL8QNzm/AjuY1vDbpZKxuz4MiFDJ1OVbv7w0elknpretLOh2dNGgj7zUGwFu1i2RPL9EDR33AoxzkynTMY+a0HL9tm2i3LiLL2WXTjzHVji2cLifB6ST0mwVgfo++axGJ5Xcpx9QE3f/AshIZLAF7IFqsKSNjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NSg1AWdF; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46P8KIgA012321;
	Thu, 25 Jul 2024 03:20:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1721895618;
	bh=0rYG+h9NHpo1i/+Yx3zd+2LSnykqrZcBRUaxP+6xwH4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=NSg1AWdFe347Skdrgojn4FojUIAix0nklKCuQ8a9gvsMjAwDicSyNHayIWb332VuA
	 /oEFgfR5fLtm2mmcl2L4He94RrfXT0KzVSvUYEuFKdpz2MdsM+TLzTIgJznTV2phyS
	 ZscjG9LbvlgGBLtpPxUzzoke7/YezitaOr7OcK8M=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46P8KI0Y126560
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 25 Jul 2024 03:20:18 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Jul 2024 03:20:18 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Jul 2024 03:20:18 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46P8KGBd047171;
	Thu, 25 Jul 2024 03:20:17 -0500
Date: Thu, 25 Jul 2024 13:50:16 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <bhelgaas@google.com>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <vigneshr@ti.com>, <kishon@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <stable@vger.kernel.org>, <ahalaney@redhat.com>, <srk@ti.com>
Subject: Re: [PATCH] PCI: j721e: Set .map_irq and .swizzle_irq to NULL
Message-ID: <93e864fb-cf52-4cc0-84a0-d689dd829afb@ti.com>
References: <20240724065048.285838-1-s-vadapalli@ti.com>
 <20240724161916.GG3349@thinkpad>
 <20240725042001.GC2317@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240725042001.GC2317@thinkpad>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Thu, Jul 25, 2024 at 09:50:01AM +0530, Manivannan Sadhasivam wrote:
> On Wed, Jul 24, 2024 at 09:49:21PM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Jul 24, 2024 at 12:20:48PM +0530, Siddharth Vadapalli wrote:
> > > Since the configuration of Legacy Interrupts (INTx) is not supported, set
> > > the .map_irq and .swizzle_irq callbacks to NULL. This fixes the error:
> > >   of_irq_parse_pci: failed with rc=-22
> > > due to the absence of Legacy Interrupts in the device-tree.
> > > 
> > 
> > Do you really need to set 'swizzle_irq' to NULL? pci_assign_irq() will bail out
> > if 'map_irq' is set to NULL.
> > 
> 
> Hold on. The errono of of_irq_parse_pci() is not -ENOENT. So the INTx interrupts
> are described in DT? Then why are they not supported?

No, the INTx interrupts are not described in the DT. It is the pcieport
driver that is attempting to setup INTx via "of_irq_parse_and_map_pci()"
which is the .map_irq callback. The sequence of execution leading to the
error is as follows:

pcie_port_probe_service()
  pci_device_probe()
    pci_assign_irq()
      hbrg->map_irq
        of_pciof_irq_parse_and_map_pci()
	  of_irq_parse_pci()
	    of_irq_parse_raw()
	      rc = -EINVAL
	      ...
	      [DEBUG] OF: of_irq_parse_raw: ipar=/bus@100000/interrupt-controller@1800000, size=3
	      if (out_irq->args_count != intsize)
	        goto fail
		  return rc

The call to of_irq_parse_raw() results in the Interrupt-Parent for the
PCIe node in the device-tree being found via of_irq_find_parent(). The
Interrupt-Parent for the PCIe node for MSI happens to be GIC_ITS:
msi-map = <0x0 &gic_its 0x0 0x10000>;
and the parent of GIC_ITS is:
gic500: interrupt-controller@1800000
which has the following:
#interrupt-cells = <3>;

The "size=3" portion of the DEBUG print above corresponds to the
#interrupt-cells property above. Now, "out_irq->args_count" is set to 1
as __assumed__ by of_irq_parse_pci() and mentioned as a comment in that
function:
	/*
	 * Ok, we don't, time to have fun. Let's start by building up an
	 * interrupt spec.  we assume #interrupt-cells is 1, which is standard
	 * for PCI. If you do different, then don't use that routine.
	 */

In of_irq_parse_pci(), since the PCIe-Port driver doesn't have a
device-tree node, the following doesn't apply:
  dn = pci_device_to_OF_node(pdev);
and we skip to the __assumption__ above and proceed as explained in the
execution sequence above.

If the device-tree nodes for the INTx interrupts were present, the
"ipar" sequence to find the interrupt parent would be skipped and we
wouldn't end up with the -22 (-EINVAL) error code.

I hope this clarifies the relation between the -22 error code and the
missing device-tree nodes for INTx.

Regards,
Siddharth.

