Return-Path: <linux-pci+bounces-23710-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A0CA60954
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 07:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84B7418985D2
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 06:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3A622339;
	Fri, 14 Mar 2025 06:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kwK2PpU/"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A037512B94;
	Fri, 14 Mar 2025 06:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741935307; cv=none; b=tRVufmsWmWHdMr5a2E8eE+P1dMwCNIV7egCNgVByExTa7duEnQ8dSvOtXoOWoM4+prNDsBJ0MG1SFpF9BgddE6gIu7apw8mtEuosNdarmMp6Xki/DdHy4AbIATu6irgc7Qr9p6UR9fD1eGhiNzgnvngHwbsWqwmXHkeitexnPrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741935307; c=relaxed/simple;
	bh=6gTzgQOVd3ne/8XxLFr1dWkRTC9CQZ+P5VXsdL+HTeU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DfVUQkbHBlT2q4EaRHlHGwWG2HwtEtUWiUyqMlJ5KQI3hjv4ydYwjrsE3PmU37LwnDtyWKniSMp+9hyggHz2PULFaHyKM/fSX/bbatVgv1KOCJi7nrEcXRbJ8+VYpvVSHgPZRMlrTkMB/XwwdMa/nUPU8tx821RE7Q5bUGAYFqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kwK2PpU/; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52E6skUj2064774
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Mar 2025 01:54:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741935286;
	bh=Dtma4NIIxwZ25QmncfJqv/YPoOIELjervTPth/gAlKU=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=kwK2PpU/bjctEmztwr2AEu5GYAxTepORfZ7T/uDON7Do6KtcT/0PM7dHxR7ccWh/O
	 kDgB6WtEZ5AJHuRsA32IK6VcZErzgbJ/J1f0NuXX6Yv77d+/pts2MX4WLk5Ew59+NJ
	 gM1oxS9pfpG0xFPZweuyWIrit78DYbR9xWstwqDs=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52E6skSm003712
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 14 Mar 2025 01:54:46 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Mar 2025 01:54:46 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Mar 2025 01:54:46 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52E6simv093913;
	Fri, 14 Mar 2025 01:54:45 -0500
Date: Fri, 14 Mar 2025 12:24:44 +0530
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
Message-ID: <20250314065444.fmvhyqmuefnm4mcq@uda0492258>
References: <20250307103128.3287497-1-s-vadapalli@ti.com>
 <20250307103128.3287497-2-s-vadapalli@ti.com>
 <20250313174416.n3c4srf6hb2l3bvg@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250313174416.n3c4srf6hb2l3bvg@thinkpad>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Thu, Mar 13, 2025 at 11:14:16PM +0530, Manivannan Sadhasivam wrote:

Hello Mani,

> On Fri, Mar 07, 2025 at 04:01:25PM +0530, Siddharth Vadapalli wrote:
> > From: Kishon Vijay Abraham I <kishon@ti.com>
> > 
> > Currently, the Cadence PCIe controller driver can be built as a built-in
> > module only. Since PCIe functionality is not a necessity for booting, add
> > support to build the Cadence PCIe driver as a loadable module as well.
> > 
> > Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> > ---
> >  drivers/pci/controller/cadence/Kconfig             |  6 +++---
> >  drivers/pci/controller/cadence/pcie-cadence-ep.c   |  6 ++++++
> >  drivers/pci/controller/cadence/pcie-cadence-host.c |  9 +++++++++
> >  drivers/pci/controller/cadence/pcie-cadence.c      | 12 ++++++++++++
> >  drivers/pci/controller/cadence/pcie-cadence.h      |  4 ++--
> >  5 files changed, 32 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
> > index 8a0044bb3989..82b58096eea0 100644
> > --- a/drivers/pci/controller/cadence/Kconfig
> > +++ b/drivers/pci/controller/cadence/Kconfig
> > @@ -4,16 +4,16 @@ menu "Cadence-based PCIe controllers"
> >  	depends on PCI
> >  
> >  config PCIE_CADENCE
> > -	bool
> > +	tristate
> >  
> >  config PCIE_CADENCE_HOST
> > -	bool
> > +	tristate
> >  	depends on OF
> >  	select IRQ_DOMAIN
> 
> Even though this was added earlier, looks like not needed.

Thank you for reviewing this patch.

drivers/pci/controller/cadence/Kconfig has the following:
...
	config PCIE_CADENCE_HOST
		bool
		depends on OF
		select IRQ_DOMAIN
		select PCIE_CADENCE
...
	config PCI_J721E_HOST
		bool "TI J721E PCIe controller (host mode)"
		depends on ARCH_K3 || COMPILE_TEST
		depends on OF
		select PCIE_CADENCE_HOST
		select PCI_J721E
...
So PCI_J721E_HOST selects PCIE_CADENCE_HOST which in turn selects
PCIE_CADENCE. As of now, none of these configs are enabled in
arm64-defconfig, and they also will not be accepted as built-in modules
as it will bloat the Linux Image for everyone. For that reason, they are
all being converted to loadable modules, and their configs will eventually
be enabled in arm64-defconfig as loadable modules.

Please let me know if I misunderstood your comment regarding the quoted
change not being required.

Regards,
Siddharth.

