Return-Path: <linux-pci+bounces-23700-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B173A60806
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 05:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C66BE19C0835
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 04:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E50443AA4;
	Fri, 14 Mar 2025 04:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="zKBeeihX"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C48F50F;
	Fri, 14 Mar 2025 04:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741925850; cv=none; b=cZyWMJcvLF3AHSJ1/Q4B5bBgF2RXO+YN9fM0RILZ7zxgUlP31LIqbFDf6xz0tV8mOPIVUqsVe6JAScLlcYVNhfAc3n6NIccy7jB57HhYXQM0AoCClA6+wjPm7FA1KOIa4BnWnGTWXK2Dt1YTHgC4e/FdpxEuKsGIHT6j/3tM+ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741925850; c=relaxed/simple;
	bh=TnEWx0F+7GIBzZufC7ym7uTdsaxdyCuwesSiGz6Nu7g=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isCiDLrRfUoYorDjRRjJ4Jmjn06r7Z94wJ/XTZaVZk60FSHGGnomaUYXhW7ouv52RL85Xw1X1IMAADRfLcUu/XDptmtlDqrdbke13udqXUnoLu914qY8PyHpWtvcGo9z1mpBwvEvFX6yD3+8dUOQCeRcEzZ9eDK/mE9Nee7KLSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=zKBeeihX; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52E4H7751577816
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 23:17:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741925827;
	bh=uJxJyWw+HNGoEkY0YqzV8FUsX4LKlrT7ZOekNYT3OXg=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=zKBeeihXhZ1QITWJuK3qrT/tyE4HVnXoRuzNmvNEv9uqrrliXTYcLFgAKLvhfZsry
	 hLUynqqDWXbKfWI1IQS3GtSjXD8/lilRGvXOa9tAzUTxW11lhkleCjV0wa9ib8k5xg
	 YYBPxSIzzeHjpN1ySx20PJb3Sn3MHG8S4sZ7ODsc=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52E4H7xI031477
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Mar 2025 23:17:07 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Mar 2025 23:17:06 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Mar 2025 23:17:06 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52E4H5Lg046200;
	Thu, 13 Mar 2025 23:17:06 -0500
Date: Fri, 14 Mar 2025 09:47:05 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <vigneshr@ti.com>, <manivannan.sadhasivam@linaro.org>,
        <robh@kernel.org>, <bhelgaas@google.com>, <rogerq@kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
Subject: Re: [PATCH] PCI: j721e: Fix the value of linkdown_irq_regfield for
 J784S4
Message-ID: <20250314041705.v5j2fjulol5ywvyq@uda0492258>
References: <20250313055519.j3bpvsm6govd5ytk@uda0492258>
 <20250313160215.GA736346@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250313160215.GA736346@bhelgaas>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Thu, Mar 13, 2025 at 11:02:15AM -0500, Bjorn Helgaas wrote:
> On Thu, Mar 13, 2025 at 11:25:19AM +0530, Siddharth Vadapalli wrote:
> > On Wed, Mar 12, 2025 at 11:16:00AM -0500, Bjorn Helgaas wrote:
> > > On Wed, Mar 05, 2025 at 06:50:18PM +0530, Siddharth Vadapalli wrote:
> > > > Commit under Fixes assigned the value of 'linkdown_irq_regfield' for the
> > > > J784S4 SoC as 'LINK_DOWN' which corresponds to BIT(1). However, according
> > > > to the Technical Reference Manual and Register Documentation for the J784S4
> > > > SoC [0], BIT(1) corresponds to "ENABLE_SYS_EN_PCIE_DPA_1" which is __NOT__
> > > > the field for the link-state interrupt. Instead, it is BIT(10) of the
> > > > "PCIE_INTD_ENABLE_REG_SYS_2" register that corresponds to the link-state
> > > > field named as "ENABLE_SYS_EN_PCIE_LINK_STATE".
> > > 
> > > I guess the reason we want this is that on J784S4, we ignore actual
> > > link-down interrupts (and we don't write STATUS_CLR_REG_SYS_2 to clear
> > > the interrupt indication, so maybe there's an interrupt storm), and we
> > > think some other interrupt (DPA_1, whatever that is) is actually a
> > > link-down interrupt?
> > 
> > While it is true that actual link-down interrupts are ignored, it is not
> > the case that there's an interrupt storm because the same incorrect macro
> > is used to enable the interrupt line. Since the enables an interrupt for
> > DPA_1 which never fires, we don't run into the situation where we are not
> > clearing the interrupt (the interrupt handler will look for the same
> > incorrect field to clear the interrupt if it does fire for DPA_1, but that
> > doesn't happen). The 'linkdown_irq_regfield' corresponds to the
> > "link-state" field not just in the J784S4 SoC, but in all SoCs supported by
> > the pci-j721e.c driver. It is only in J721E that it is BIT(1)
> > [LINK_DOWN macro], while in all other SoCs (J784S4 included), it is BIT(10)
> > [J7200_LINK_DOWN macro since it was first added for J7200 SoC]. Matt
> > probably referred to J721E's Technical Reference Manual and ended up
> > incorrectly assigning "LINK_DOWN", due to which the driver is enabling
> > the DPA_1 interrupt and the interrupt handler is also going to look for
> > the field corresponding to receiving an interrupt for DPA_1.
> 
> So I guess without this patch, we incorrectly ignore link-down
> interrupts on J784S4.  It's good to have a one-sentence motivation
> like that somewhere in the commit log that we can pull out and include
> in the merge commit log and the pull request.

Yes, we can prepend the following to the existing commit message:
"Link down interrupts on J784S4 SoC are missed because..."

resulting in the following updated paragraph in the commit message:
Link down interrupts on J784S4 SoC are missed because commit under Fixes
assigned the value of 'linkdown_irq_regfield' for the....


> 
> > I can only hope that the URL will redirect to the latest version of
> > the User Guide if at all it becomes invalid.
> 
> OK, thanks, I guess there's nothing more to do ;)  I guess that manual
> is not really designed for collaborative development.
> 
> Thanks for the patient hand holding!

:)

Regards,
Siddharth.

