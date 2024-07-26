Return-Path: <linux-pci+bounces-10833-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F366F93D111
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 12:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8B491F21C1A
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 10:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F25178374;
	Fri, 26 Jul 2024 10:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="q3YK29yE"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA322B9C4;
	Fri, 26 Jul 2024 10:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721989483; cv=none; b=kLzmZYVG1mWzQmcLiWOGFH94LlTVDnJs2Q1WAkOVqG0SRNERQab2QV0qks07m6vsSLa10IgWb6RaqOlnlHfnxUyU4DA+anJ1zi/DTytryTiH6IUXW5B7sh0NhDTlmik9Wptrdnt3IcQlBhrQ3+CSbiIzCApIES1oLnmVpx6tZMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721989483; c=relaxed/simple;
	bh=pLmo7U3YsnJjVV9h5qw1epXAntcjLIGWaCLimBAJyFI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eGdcwpefz9J7EruYzN3Lc++5qx2PA/bvSVEaGFxNpjrK7kIr2nVG/ZOY2xy5Wu14FLM9bI3mqMWr0crsCv0prKFGlafOUHVwiTw05wDFJIh9HPxZdJagxy/7ESC37sxFVueeIgIHkfoO9oFzhOATvLiQ/UARzY8ydwCpID3k9kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=q3YK29yE; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46QAOIPB015133;
	Fri, 26 Jul 2024 05:24:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1721989458;
	bh=wwNAQqMZTOfeHyckA0S42XeXv2UW3eBc8gvudOtAbiM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=q3YK29yEzypwF7a1nBjNzhCIb1/4JRqaQKejP7CXp0v6CNaZYMPnlDqiPSuYzBb+l
	 bd4xOAMi36h1ZQgDpGkeDNKvlqP27g2/wBVgObRVbFaJKW6J666f0txpMlJVptzlro
	 Gvw93jZfcogys5Blgskabiwa2497+VO14nMznleM=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46QAOI5g086465
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 26 Jul 2024 05:24:18 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 26
 Jul 2024 05:24:18 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 26 Jul 2024 05:24:18 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46QAOHZ5110895;
	Fri, 26 Jul 2024 05:24:18 -0500
Date: Fri, 26 Jul 2024 15:54:17 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <bhelgaas@google.com>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <vigneshr@ti.com>, <kishon@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <stable@vger.kernel.org>, <ahalaney@redhat.com>, <srk@ti.com>
Subject: Re: [PATCH] PCI: j721e: Set .map_irq and .swizzle_irq to NULL
Message-ID: <4cb79826-5945-40d5-b52c-22959a5df41a@ti.com>
References: <20240724065048.285838-1-s-vadapalli@ti.com>
 <20240724161916.GG3349@thinkpad>
 <69f8c45c-29b4-4090-8034-8c5a19efa4f8@ti.com>
 <20240725074708.GB2770@thinkpad>
 <5f7328f8-eabc-4a8c-87a3-b27e2f6c0c1f@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5f7328f8-eabc-4a8c-87a3-b27e2f6c0c1f@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Thu, Jul 25, 2024 at 02:01:48PM +0530, Siddharth Vadapalli wrote:
> On Thu, Jul 25, 2024 at 01:17:08PM +0530, Manivannan Sadhasivam wrote:
> > On Thu, Jul 25, 2024 at 10:50:13AM +0530, Siddharth Vadapalli wrote:
> > > On Wed, Jul 24, 2024 at 09:49:16PM +0530, Manivannan Sadhasivam wrote:
> > > > On Wed, Jul 24, 2024 at 12:20:48PM +0530, Siddharth Vadapalli wrote:
> > > > > Since the configuration of Legacy Interrupts (INTx) is not supported, set
> > > > > the .map_irq and .swizzle_irq callbacks to NULL. This fixes the error:
> > > > >   of_irq_parse_pci: failed with rc=-22
> > > > > due to the absence of Legacy Interrupts in the device-tree.
> > > > > 
> > > > 
> > > > Do you really need to set 'swizzle_irq' to NULL? pci_assign_irq() will bail out
> > > > if 'map_irq' is set to NULL.
> > > 
> > > While 'swizzle_irq' won't be invoked if 'map_irq' is NULL, having a
> > > non-NULL 'swizzle_irq' (pci_common_swizzle in this case) with a NULL
> > > 'map_irq' seems inconsistent to me though the code-path may never invoke
> > > it. Wouldn't a non-NULL 'swizzle_irq' imply that Legacy Interrupts are
> > > supported, while a NULL 'map_irq' indicates that they aren't? Since they
> > > are always described in pairs, whether it is in the initial commit that
> > > added support for the Cadence PCIe Host controller (used by pci-j721e.c):
> > > https://github.com/torvalds/linux/commit/1b79c5284439
> > > OR the commit which moved the shared 'map_irq' and 'swizzle_irq' defaults
> > > from all the host drivers into the common 'devm_of_pci_bridge_init()'
> > > function:
> > > https://github.com/torvalds/linux/commit/b64aa11eb2dd
> > > I have set both of them to NULL for the sake of consistency.
> > > 
> > 
> > Since both callbacks are populated in the pci/of driver, this consistency won't
> > be visible in the controller drivers. From the functionality pov, setting both
> > callbacks to NULL is *not* required to disable INTx, right?
> 
> Yes, setting 'swizzle_irq' to NULL isn't required. The execution sequence
> with 'swizzle_irq' set to 'pci_common_swizzle()' is as follows:
> 
> pci_assign_irq()
>   if (pin) {
>     if (hbrg->swizzle_irq)
>       slot = (*(hbrg->swizzle_irq))(dev, &pin);
>         pci_common_swizzle()
> 	  while (!pci_is_root_bus(dev->bus)) <= NOT entered
> 	..continue execution similar to 'swizzle_irq' being NULL.
> 
> Having 'swizzle_irq' set to 'pci_common_swizzle()' will only result
> in a no-op which could have been avoided by setting it to NULL. So there
> is no difference w.r.t. functionality.

Mani,

I prefer setting 'swizzle_irq' to NULL as well unless you have an objection
to it. Kindly let me know. I plan to post the v2 for this patch addressing
Bjorn's feedback and collecting Andrew's "Tested-by" tag as well.

Regards,
Siddharth.

