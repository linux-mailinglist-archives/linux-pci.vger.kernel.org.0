Return-Path: <linux-pci+bounces-5149-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FBD88B994
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 05:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8EA52E5D8F
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 04:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0B073514;
	Tue, 26 Mar 2024 04:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aVi8fu7m"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320C35D905;
	Tue, 26 Mar 2024 04:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711429174; cv=none; b=Q/k5IS+UlYvdmQEahuKgKU5r7mXRUGp4mOonkcMnpJ7gqhnSEAWMDR81dnldtgKytekmyKt6bLF1TzmP2HLYyomHeHy0PX5wkSddui7DXytaRo6+YQuIl7V+G1FwPevYuT9yQnCLkAsimLlwf+5Fjz7kOZH833RMUraytWc/wis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711429174; c=relaxed/simple;
	bh=Kk//ja//OckJbGLtdF+s+VPF2oDr7OlrPekj8ig0JWY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lgEwF36G2pK2T3O59sLMe7ebYK1ybA6kBhMikGFWrvnWIx3ggMYQULGt2BYM/DjSfiGJfnasNmyHV+NZLqoEU2ZYWJ/xn5Rxuj26U4VYr6LdpW1IOrdRqZSPqvs8PjW4fndZlnKIDpd9Li2JVyvkdDRnlgYxk6UTKFIDtnBiebM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=aVi8fu7m; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42Q4xCWg102011;
	Mon, 25 Mar 2024 23:59:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711429152;
	bh=cUjb4FFIv54rr7MmbTYuEQBtNz+9FaFMStjEdNaoD9U=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=aVi8fu7mnEddy0Tfz30Xi/MNV2qTnyIW/245IyarM3FUwzwYb6s9CGVR1lclYL6QD
	 nj0DECU66JTcSvJsxhxSnhAXjQ4wfBv3wNkbFYSgKDJnNbJKJSdAh2KXq7QO68bG18
	 Vx2ZxgCQyzNrYYHyFPg0mSQv73PRXuZjlX3aoOtI=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42Q4xCTI037922
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 Mar 2024 23:59:12 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Mar 2024 23:59:12 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Mar 2024 23:59:12 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42Q4xBbt061615;
	Mon, 25 Mar 2024 23:59:11 -0500
Date: Tue, 26 Mar 2024 10:29:10 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Niklas Cassel <cassel@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <manivannan.sadhasivam@linaro.org>, <fancer.lancer@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <dlemoal@kernel.org>,
        <yoshihiro.shimoda.uh@renesas.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>
Subject: Re: [PATCH v4] PCI: keystone: Fix pci_ops for AM654x SoC
Message-ID: <750df13b-ee2f-4067-a9e0-7fd1ace384cf@ti.com>
References: <20240325053722.1955433-1-s-vadapalli@ti.com>
 <ZgFemQ8gHpB8yMef@ryzen>
 <ea0294d4-85d1-4784-acd7-dd247165f69b@ti.com>
 <ZgF_5fYsI5lOFjOv@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZgF_5fYsI5lOFjOv@ryzen>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Mon, Mar 25, 2024 at 02:45:09PM +0100, Niklas Cassel wrote:
> Hello Siddharth,
> 
> On Mon, Mar 25, 2024 at 05:52:28PM +0530, Siddharth Vadapalli wrote:
> > On Mon, Mar 25, 2024 at 12:23:05PM +0100, Niklas Cassel wrote:
> > > On Mon, Mar 25, 2024 at 11:07:22AM +0530, Siddharth Vadapalli wrote:
> > > > @@ -822,6 +788,23 @@ static int __init ks_pcie_host_init(struct dw_pcie_rp *pp)
> > > >  	if (ret < 0)
> > > >  		return ret;
> > > >
> > > 
> > > > +	if (!ks_pcie->is_am6) {
> > > 
> > > Perhaps add a comment here stating WHY this is needed for v3.65a (!is_am6).
> > > 
> > > From reading the old threads, it appears that v3.65a:
> > > -Has no support for iATUs. iATU-specific resource handling code is to be
> > >  bypassed for v3.65 h/w. Thus v3.65a has it's own .child_ops implementation,
> > >  so that pcie-designware-host.c does not configure the iATUs.
> > > -v3.65a has it's own .msi_init implementation, so that pcie-designware-host.c
> > >  does not call dw_pcie_msi_host_init() to configure the MSI controller.
> > > 
> > > While 4.90a:
> > > -Does have iATU support.
> > > -Does use the generic dw_pcie_msi_host_init().
> > > 
> > > Considering the major differences (with v3.65a being the outlier) here,
> > > I think it would have been a much wiser idea to have two different glue
> > > drivers for these two compatibles (ti,keystone-pcie and ti,am654-pcie-rc).
> > > 
> > > Right now the driver is quite hard to read, most of the functions in this
> > > driver exist because v3.65a does not have an iATU and does not use the
> > > generic DWC way to handle MSIs. Additionally, you have "if (!ks_pcie->is_am6)"
> > > spread out all over the driver, to control quite major things, like if you
> > > should overload .child_ops, or if you should set up inbound translation without
> > > an iATU. This makes is even harder to see which code is actually used for
> > > am654... like the fact that it actually uses the generic way to handle MSIs...
> > > 
> > > The driver for am654 would be much nicer since many of the functions in
> > > this driver would not be needed (and the fact that you have only implemented
> > > EP support for am654 and not for v3.65a). All EP related stuff would be in
> > > the am654 file/driver.
> > > You could keep the quirky stuff for v3.65a in the existing pci-keystone.c
> > > driver.
> > > 
> > > (I guess if there is a function that is identical between the twos, you could
> > > have a pci-keystone-common.{c,h}  that can be used by both drivers, but from
> > > the looks of it, they seem to share very little code.
> > 
> > Thank you for reviewing the patch. I agree that two drivers will be
> > better considering the !ks_pcie->is_am6 present throughout the driver.
> > However, I hope you notice the fact that commit:
> > 6ab15b5e7057 PCI: dwc: keystone: Convert .scan_bus() callback to use add_bus
> > introduced a regression in a driver which was working prior to that
> > commit for AM654. While there are flaws in the driver and it needs to be
> > split to handle v3.65a and other versions in a cleaner manner, I am
> > unable to understand why that is a precursor to fixing the regression.
> > 
> > If splitting the driver is the only way to fix this regression, please
> > let me know and I will work on that instead, though it will take up more
> > time.
> 
> I think you are misunderstanding me.
> 
> I think this patch is fine, except for the comment that I gave:
> "Perhaps add a comment here stating WHY this is needed for v3.65a (!is_am6)."
> 
> Like:
> 
> /*
>  * This is only needed for !am654 since it has its own msi_irq_chip
>  * implementation. (am654 uses the generic msi_irq_chip implementation.)
>  */
> if (!ks_pcie->is_am6) {
> 	...
> }
> 
> 
> In fact, if you move this code to ks_pcie_msi_host_init(), instead of
> ks_pcie_host_init(), you would not need a comment (or a if (!ks_pcie->is_am6)),
> since ks_pcie_msi_host_init() is only executed by !am654.

This seems much better :)

In the current code, the execution is as follows:

	ks_pcie_probe()
	    dw_pcie_host_init()
	        pci_host_probe()
	            ks_pcie_v3_65_add_bus()

Moving the contents of ks_pcie_v3_65_add_bus() to ks_pcie_msi_host_init()
will result in:

	ks_pcie_probe()
	    dw_pcie_host_init()
	    	if (pci_msi_enabled())
			if (pp->ops->msi_init) {
				ret = pp->ops->msi_init(pp);
					ks_pcie_msi_host_init()
	        pci_host_probe()

I will update this patch based on your suggestion. If it's alright, may I
also add your "Suggested-by" tag for the v5 patch? Please let me know.

> 
> 
> 
> 
> My suggestion to split this driver to two different drivers is just because
> I noticed how different they are (am654 has iATUs, uses generic msi_irq_chip
> implementation and has EP-mode support. !am654 has no iATUs, its own MSI
> implementation and no EP-mode support.)
> 
> So the am654 driver would look like most other DWC glue drivers.
> The non-am654 driver would look mostly like it looks today, except you would
> remove the EP-mode support.
> 
> However, this suggestion can of course be implemented sometime in the future
> and should not be a blocker for the patch in $subject.

Thank you for clarifying.

Regards,
Siddharth.

