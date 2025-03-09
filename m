Return-Path: <linux-pci+bounces-23208-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3475AA580DF
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 06:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16BAF3A86B7
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 05:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8C761FF2;
	Sun,  9 Mar 2025 05:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SuT3BGxR"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC953C133;
	Sun,  9 Mar 2025 05:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741499354; cv=none; b=C2XhzPC/8nR98QSPNrJmIdwLsxvu53JTUGP3Avsh0qMNaxA4gIgnlkoDOi03KlAz/oB+L4fCccc72o/WFviOBcsnkFq9OPZuk5seg3I75OkYQwneDYsi1dB3h2WRL5dAfIrxiw7Vbn1wDyAebEUTLlFtm4d7Xfmb7IwAw8hMF7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741499354; c=relaxed/simple;
	bh=bZPxp5jV+AkHzYA9fBKSNqPc/s0C8RUHq888V7WhoKs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YrogzbInOTKwd4c3ggLnXhIdprounyfTMSaEOED3RrmjYk93jEd5vxg1zoNuwfKZncJQtz6gIDg0p7mwv28N0wXg+C0kncPENmD1onGA2UljA26TwWlGM/Xw8WnKyoZG57hnQhPqobO8oiKy/SM/IPDDeSwkHEqsfMJZ12FEbV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SuT3BGxR; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5295mbLP215684
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 8 Mar 2025 23:48:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741499317;
	bh=ea59vFEkWPlyDnUdJd9y2Dei3RIVNR+SOpDzlFnCTgw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=SuT3BGxRgQ8WpSibgdCw9v+eOJnZBRF48pwoG/yOKZtqXRpKHbFuwTEsROm9GTjnc
	 qagtwOlP3r0sle3aw1iGODRhFI0q1w5W/lSonDGbj8rP5Eswu9pecuZJWj0cVKMea2
	 E3oc1Orf9yCVAgVI44M24V69MKVEBg2hvBPcJ/eM=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5295mbuN022019
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 8 Mar 2025 23:48:37 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 8
 Mar 2025 23:48:36 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 8 Mar 2025 23:48:36 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5295mZEC019524;
	Sat, 8 Mar 2025 23:48:36 -0600
Date: Sun, 9 Mar 2025 11:18:35 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Hans Zhang <18255117159@163.com>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <bwawrzyn@cisco.com>,
        <thomas.richard@bootlin.com>,
        <wojciech.jasko-EXT@continental-corporation.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [v2] PCI: cadence: Add configuration space capability search API
Message-ID: <20250309054835.4ydiq4xpguxtbvkf@uda0492258>
References: <20250308133903.322216-1-18255117159@163.com>
 <20250309023839.2cakdpmsbzn6pm7g@uda0492258>
 <3e6645a8-6de9-4125-8444-fa1a4f526881@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3e6645a8-6de9-4125-8444-fa1a4f526881@163.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Sun, Mar 09, 2025 at 11:18:21AM +0800, Hans Zhang wrote:
> 
> 
> On 2025/3/9 10:38, Siddharth Vadapalli wrote:
> > On Sat, Mar 08, 2025 at 09:39:03PM +0800, Hans Zhang wrote:
> > > Add configuration space capability search API using struct cdns_pcie*
> > > pointer.
> > > 
> > > The offset address of capability or extended capability designed by
> > > different SOC design companies may not be the same. Therefore, a flexible
> > > public API is required to find the offset address of a capability or
> > > extended capability in the configuration space.
> > > 
> > > Signed-off-by: Hans Zhang <18255117159@163.com>
> > > ---
> > > Changes since v1:
> > > https://lore.kernel.org/linux-pci/20250123070935.1810110-1-18255117159@163.com
> > > 
> > > - Added calling the new API in PCI-Cadence ep.c.
> > > - Add a commit message reason for adding the API.
> > 
> > In reply to your v1 patch, you have mentioned the following:
> > "Our controller driver currently has no plans for upstream and needs to
> > wait for notification from the boss."
> > at:
> > https://lore.kernel.org/linux-pci/fcfd4827-4d9e-4bcd-b1d0-8f9e349a6be7@163.com/
> > 
> > Since you have posted this patch, does it mean that you will be
> > upstreaming your driver as well? If not, we still end up in the same
> > situation as earlier where the Upstream Linux has APIs to support a
> > Downstream driver.
> > 
> > Bjorn indicated the above already at:
> > https://lore.kernel.org/linux-pci/20250123170831.GA1226684@bhelgaas/
> > and you did agree to do so. But this patch has no reference to the
> > upstream driver series which shall be making use of the APIs in this
> > patch.
> 
> Hi Siddharth,
> 
> 
> Bjorn:
>   If/when you upstream code that needs this interface, include this
>   patch as part of the series.  As Siddharth pointed out, we avoid
>   merging code that has no upstream users.
> 
> 
> Hans: This user is: pcie-cadence-ep.c. I think this is an optimization of
> Cadence common code. I think this is an optimization of Cadence common code.
> Siddharth, what do you think?

This seems to be an extension of the driver rather than an optimization.
At first glance, though it seems like this patch is enabling code-reuse,
it is actually attempting to walk through the config space registers to
identify a capability. Prior to this patch, those offsets were hard-coded,
saving the trouble of having to walk through the capability pointers to
arrive at the capability.

This patch will affect the following functions:
01. cdns_pcie_get_fn_from_vfn()
02. cdns_pcie_ep_write_header()
03. cdns_pcie_ep_set_msi()
04. cdns_pcie_ep_get_msi()
05. cdns_pcie_ep_get_msix()
06. cdns_pcie_ep_set_msix()
07. cdns_pcie_ep_send_msi_irq()
08. cdns_pcie_ep_map_msi_irq()
09. cdns_pcie_ep_send_msix_irq()
10. cdns_pcie_ep_start()
which will now take longer to get to the capability whose offset was
known. I understand that you wish to extend these functions to support
your SoC where the offsets don't match the hard-coded ones.

I will let Bjorn and others share their views on this patch.

Regards,
Siddharth.

