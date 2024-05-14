Return-Path: <linux-pci+bounces-7456-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FB48C55D7
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2024 14:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 481651F213EA
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2024 12:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0E73B1A3;
	Tue, 14 May 2024 12:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RSU5IvbS"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D35E1E4B1;
	Tue, 14 May 2024 12:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715688744; cv=none; b=m6owmcfQ1sjU+a8z0XR/PcSiZRmyk6ec4Mc++1Pzn7IGP3L0K1nUJLNHyoxIm/Omp0NPMajWcWYTaIb3/zmJsvYsm4NvDxQ4W/aq7vA3ZcD22S3Kd5PgCht7azpA8KveA0rU6K/a+xc+HopRpAvvEzlJh+pmBHJdKPOSzdQilgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715688744; c=relaxed/simple;
	bh=yvyZt27ScHuMAxnq3bm6Nvou2bxi4i+h6DRBGE2LOE4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DsFZ0YBaDm/ujgTT1xgrMCmjCsQDexITLGnfmyis0NGLlt72dKXQBacAIeECQhTIxyIfBaHmme2pkesm/st4En6zDynb4Fjc02p+0xiVTGekNpF/BFX3Msl/9zl9aGPQHCd8YGWFIZbYfWhw75FabLTcg4pbY/9N6E1gzV+P+YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RSU5IvbS; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44ECBo3G115948;
	Tue, 14 May 2024 07:11:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715688710;
	bh=OsXgZbCTz/uuKLSGsGQZvWLyWdVYSJ4fAsjKQWfCgac=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=RSU5IvbSkiCst0Z228ER9IBFdciijquqVWZfTKVGX1ee0iIlHHlsagsqJOcixTQ7D
	 hhNHtB5B8skwhev606unk2HF9CYAzk9c0NOeKc0q/KAXdZFSk7qGSS2xNAQNMPDfJc
	 UN6eaNPGYAJjGZQWLALBYzvrIeqKp4fexuoorAy0=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44ECBo39105112
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 14 May 2024 07:11:50 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 14
 May 2024 07:11:50 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 14 May 2024 07:11:50 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44ECBnnY006071;
	Tue, 14 May 2024 07:11:50 -0500
Date: Tue, 14 May 2024 17:41:48 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <manivannan.sadhasivam@linaro.org>, <fancer.lancer@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <cassel@kernel.org>,
        <dlemoal@kernel.org>, <yoshihiro.shimoda.uh@renesas.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
Subject: Re: [PATCH v7 2/2] PCI: keystone: Fix pci_ops for AM654x SoC
Message-ID: <8b56604d-a2b8-4227-8a6f-c477332416b4@ti.com>
References: <20240328085041.2916899-3-s-vadapalli@ti.com>
 <20240513215350.GA1996021@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240513215350.GA1996021@bhelgaas>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Mon, May 13, 2024 at 04:53:50PM -0500, Bjorn Helgaas wrote:
> On Thu, Mar 28, 2024 at 02:20:41PM +0530, Siddharth Vadapalli wrote:
> > In the process of converting .scan_bus() callbacks to .add_bus(), the
> > ks_pcie_v3_65_scan_bus() function was changed to ks_pcie_v3_65_add_bus().
> > The .scan_bus() method belonged to ks_pcie_host_ops which was specific
> > to controller version 3.65a, while the .add_bus() method had been added
> > to ks_pcie_ops which is shared between the controller versions 3.65a and
> > 4.90a. Neither the older ks_pcie_v3_65_scan_bus() method, nor the newer
> > ks_pcie_v3_65_add_bus() method is applicable to the controller version
> > 4.90a which is present in AM654x SoCs.
> > 
> > Thus, as a fix, remove "ks_pcie_v3_65_add_bus()" and move its contents
> > to the .msi_init callback "ks_pcie_msi_host_init()" which is specific to
> > the 3.65a controller.
> > 
> > Fixes: 6ab15b5e7057 ("PCI: dwc: keystone: Convert .scan_bus() callback to use add_bus")
> > Suggested-by: Serge Semin <fancer.lancer@gmail.com>
> > Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> > Suggested-by: Niklas Cassel <cassel@kernel.org>
> > Reviewed-by: Niklas Cassel <cassel@kernel.org>
> > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> 
> Thanks for splitting this into two patches.  Krzysztof has applied
> both to pci/controller/keystone and we hope to merge them for v6.10.
> 
> I *would* like the commit log to be at a little higher level if
> possible.  Right now it's a detailed description at the level of the
> code edits, but it doesn't say *why* we want this change.
> 
> I think the first cut at this was
> https://lore.kernel.org/linux-pci/20231011123451.34827-1-s-vadapalli@ti.com/t/#u,
> which mentioned Completion Timeouts during MSI-X configuration and 45
> second delays during boot.
> 
> IIUC, prior to 6ab15b5e7057, ks_pcie_v3_65_scan_bus() initialized BAR
> 0 and was only used for v3.65a devices.  6ab15b5e7057 renamed it to
> ks_pcie_v3_65_add_bus() and called it for both v3.65a and v4.90a.
> 
> I think the problem is that in the current code, the
> ks_pcie_ops.add_bus() method (ks_pcie_v3_65_add_bus()) is used for all
> devices (both v3.65a and v4.90a).  So I guess doing the BAR 0 setup on
> v4.90a broke something there?

BAR0 was set to a different value on AM654x SoC which has the v4.90a
controller, which is identical to what is set even for the v3.65a
controller. The difference is that BAR0 is programmed to a different
value for enabling inbound MSI writes on top of the common configuration
performed for BAR0.

Common configuration for BAR0:
ks_pcie_probe
  dw_pcie_host_init
    dw_pcie_setup_rc
    ...
     /* Setup RC BARs */
     dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0x00000004);
     dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_1, 0x00000000);
     ...
     dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0);
    ...

MSI specific configuration of BAR0 performed after the common
configuration via the ks_pcie_v3_65_scan_bus() callback:
	/* Configure and set up BAR0 */
	ks_pcie_set_dbi_mode(ks_pcie);

	/* Enable BAR0 */
	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 1);
	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, SZ_4K - 1);

	ks_pcie_clear_dbi_mode(ks_pcie);

	 /*
	  * For BAR0, just setting bus address for inbound writes (MSI) should
	  * be sufficient.  Use physical address to avoid any conflicts.
	  */
	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, ks_pcie->app.start);

The above configuration of BAR0 shouldn't be performed for AM654x SoC.
While I am not certain, the timeouts are probably a result of the BAR
being programmed to a wrong value which results in a "no match" outcome.

> 
> I'm not quite clear on the mechanism, but it would be helpful to at
> least know what's wrong and on what platform.  E.g., currently v4.90
> suffers Completion Timeouts and 45 second boot delays?  And this patch
> fixes that?

Yes, the Completion Timeouts cause the 45 second boot delays and this
patch fixes that.

Regards,
Siddharth.

