Return-Path: <linux-pci+bounces-24016-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 583D7A66CEE
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 08:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36E363AD8EA
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 07:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D1D1F5846;
	Tue, 18 Mar 2025 07:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QNRcJzBH"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D251E5211;
	Tue, 18 Mar 2025 07:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742284557; cv=none; b=ElbMescjw9VZ7M1siNSgNlvFJuc8z/Jlk7r0NJ24JNQjZhpvE/KCx6Sp3OTapKDCHPYq1fDUcs+c+SFt336T8p2rls4ksNDFPqeRuAz2N58rATiq15A6onBnbfsWOE3hXLw9qcX4yBeICXgWTJR3ZrUNDfxtXUJNBlxXRkb3E80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742284557; c=relaxed/simple;
	bh=Q9XS3ty0/aXYtJXED4wsgr2je5RhzpU7+HOT1r/45VE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aVVpZ2Vb3hJDt7b/ZHkcj5u6Dcmst1iVwv0B02W/EliOb8bryKQ1TcNX0SO7BRYagYM9maV8jj8mPTI5du6ItoV0z+eoTYfgZQXFkL91iDXOPPamfFlJD0itKKqbZsEah4oXtEvLzGNXUSnIGFDZuEq53oJTJ/2KIeMJ6duo6nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QNRcJzBH; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52I7tXJP2533552
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 02:55:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1742284533;
	bh=XUxU6JIqlPthBK/qLkde7SD61X0GZkgbE6F2VVDgg+Y=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=QNRcJzBHHj4VsJWRWtyQ8zYYJ9hfBGOYs8A5nrPiYHZU7SkuBzatVCwSRSva7zX1E
	 JBeq6x/+sICyz82/tp01Efn1yDOPU92IolB2tcOMP96Q4BcHDGpwK5cwNLLKGFHXe8
	 PdmDjs/5Tkl5QYdFb+iwocQH2TS8tBFAf2k5sHg4=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52I7tWvk023106
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 18 Mar 2025 02:55:33 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 18
 Mar 2025 02:55:32 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 18 Mar 2025 02:55:32 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52I7tVjr004880;
	Tue, 18 Mar 2025 02:55:31 -0500
Date: Tue, 18 Mar 2025 13:25:30 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <vigneshr@ti.com>, <kishon@kernel.org>, <cassel@kernel.org>,
        <wojciech.jasko-EXT@continental-corporation.com>,
        <thomas.richard@bootlin.com>, <bwawrzyn@cisco.com>,
        <linux-pci@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>
Subject: Re: [PATCH 1/4] PCI: cadence: Add support to build pcie-cadence
 library as a kernel module
Message-ID: <20250318075530.ca663uwlj7uqf2tr@uda0492258>
References: <20250307103128.3287497-1-s-vadapalli@ti.com>
 <20250307103128.3287497-2-s-vadapalli@ti.com>
 <20250313174416.n3c4srf6hb2l3bvg@thinkpad>
 <20250314065444.fmvhyqmuefnm4mcq@uda0492258>
 <20250318074917.inhspuuypxmaioqe@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250318074917.inhspuuypxmaioqe@thinkpad>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Tue, Mar 18, 2025 at 01:19:17PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Mar 14, 2025 at 12:24:44PM +0530, Siddharth Vadapalli wrote:
> > On Thu, Mar 13, 2025 at 11:14:16PM +0530, Manivannan Sadhasivam wrote:
> > 
> > Hello Mani,
> > 
> > > On Fri, Mar 07, 2025 at 04:01:25PM +0530, Siddharth Vadapalli wrote:
> > > > From: Kishon Vijay Abraham I <kishon@ti.com>
> > > > 
> > > > Currently, the Cadence PCIe controller driver can be built as a built-in
> > > > module only. Since PCIe functionality is not a necessity for booting, add
> > > > support to build the Cadence PCIe driver as a loadable module as well.
> > > > 
> > > > Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> > > > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > > 
> > > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > 
> > > > ---
> > > >  drivers/pci/controller/cadence/Kconfig             |  6 +++---
> > > >  drivers/pci/controller/cadence/pcie-cadence-ep.c   |  6 ++++++
> > > >  drivers/pci/controller/cadence/pcie-cadence-host.c |  9 +++++++++
> > > >  drivers/pci/controller/cadence/pcie-cadence.c      | 12 ++++++++++++
> > > >  drivers/pci/controller/cadence/pcie-cadence.h      |  4 ++--
> > > >  5 files changed, 32 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
> > > > index 8a0044bb3989..82b58096eea0 100644
> > > > --- a/drivers/pci/controller/cadence/Kconfig
> > > > +++ b/drivers/pci/controller/cadence/Kconfig
> > > > @@ -4,16 +4,16 @@ menu "Cadence-based PCIe controllers"
> > > >  	depends on PCI
> > > >  
> > > >  config PCIE_CADENCE
> > > > -	bool
> > > > +	tristate
> > > >  
> > > >  config PCIE_CADENCE_HOST
> > > > -	bool
> > > > +	tristate
> > > >  	depends on OF
> > > >  	select IRQ_DOMAIN
> > > 
> > > Even though this was added earlier, looks like not needed.
> > 
> > Thank you for reviewing this patch.
> > 
> > drivers/pci/controller/cadence/Kconfig has the following:
> > ...
> > 	config PCIE_CADENCE_HOST
> > 		bool
> > 		depends on OF
> > 		select IRQ_DOMAIN
> > 		select PCIE_CADENCE
> > ...
> > 	config PCI_J721E_HOST
> > 		bool "TI J721E PCIe controller (host mode)"
> > 		depends on ARCH_K3 || COMPILE_TEST
> > 		depends on OF
> > 		select PCIE_CADENCE_HOST
> > 		select PCI_J721E
> > ...
> > So PCI_J721E_HOST selects PCIE_CADENCE_HOST which in turn selects
> > PCIE_CADENCE. As of now, none of these configs are enabled in
> > arm64-defconfig, and they also will not be accepted as built-in modules
> > as it will bloat the Linux Image for everyone. For that reason, they are
> > all being converted to loadable modules, and their configs will eventually
> > be enabled in arm64-defconfig as loadable modules.
> > 
> > Please let me know if I misunderstood your comment regarding the quoted
> > change not being required.
> > 
> 
> Yes, you misunderstood indeed :) My earlier comment was about IRQ_DOMAIN symbol
> which looked like not needed at all.

Thank you for clarifying. I (mis)interpret your comment in the context of
the entire "config PCIE_CADENCE_HOST" block and the change made in it :)

Regards,
Siddharth.

