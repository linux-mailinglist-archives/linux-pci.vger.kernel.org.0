Return-Path: <linux-pci+bounces-23120-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C793A5694F
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 14:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F75F169DD7
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 13:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944D821767B;
	Fri,  7 Mar 2025 13:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="m8ygcWX2"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6312192589;
	Fri,  7 Mar 2025 13:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741355286; cv=none; b=CzHr2DTN3cgCQPhgsgIEtrvCjSWPEwltcbbaen2rIyHyWO1WGTsJVPQlreARe2TCMUXP1dE6rpbYAztCDNzJYUaop7BKZK+o2341EeTFY0YHTpyQValaeWjXk0XEtkh0mRK3q1qAT/EqT3ozu7teojnqSV/uDuzcgkkwf3e0TbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741355286; c=relaxed/simple;
	bh=fmJ1NqRX1egqCqcVWfkneLv27whMcpn9Hb28oegHMFw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9SycJaL20iAA36fd7j3kTzkkO/IR0mRDLt5eSrjGWwUwhJGatK4DtcAumtZvD8AuZ4Am+JpylasjOcuiXcrpK3Sn2o8ycYC4QofjYhFfRa3XJzngSS4QlZGtBOtRo79Z9GlEknzjlElMpP0hCBGECdq+mM+OKIIRPUM7xYBSq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=m8ygcWX2; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 527DlTUR277139
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Mar 2025 07:47:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741355249;
	bh=fn8PJISG7nz+9M3smr+t7vlUzBPXHdJzLkFrEsCAvb8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=m8ygcWX2jCwq6mIFpL0XeVU72hQp0T6SdGQblbRHjn5rnWTDiyoxUTheIKL67CXHG
	 9ajXQ85vUMQy3HASgNQ8g51wh34LcxJ48ulmTc1pNHTQgDT8gW6Pe0VKaTBqejuWZv
	 xBVjg5JUW+iycVvx3yMFxtHHkthN9AXqivApfJsk=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 527DlTbD111964
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 7 Mar 2025 07:47:29 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 7
 Mar 2025 07:47:29 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 7 Mar 2025 07:47:29 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 527DlScZ089637;
	Fri, 7 Mar 2025 07:47:28 -0600
Date: Fri, 7 Mar 2025 19:17:27 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Chen Wang <unicorn_wang@outlook.com>
CC: Chen Wang <unicornxw@gmail.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <s-vadapalli@ti.com>,
        <thomas.richard@bootlin.com>, <bwawrzyn@cisco.com>,
        <wojciech.jasko-EXT@continental-corporation.com>, <kishon@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sophgo@lists.linux.dev>
Subject: Re: [PATCH] PCI: cadence: Fix NULL pointer error for ops
Message-ID: <20250307134727.m57er2ky6e3dmftl@uda0492258>
References: <20250304081742.848985-1-unicornxw@gmail.com>
 <PN0PR01MB10393C44D1F4B9189C52D31EBFED52@PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <PN0PR01MB10393C44D1F4B9189C52D31EBFED52@PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Fri, Mar 07, 2025 at 09:07:35PM +0800, Chen Wang wrote:
> Hello~
> 
> Any comment on this? Or can we have this bugfix patch picked for coming
> v6.15?

Is there a driver in Linux which is affected by the issue that you are
trying to fix in this patch? Please point to the driver since I don't
see such a driver.

Regards,
Siddharth.

> 
> Regards,
> 
> Chen
> 
> On 2025/3/4 16:17, Chen Wang wrote:
> > From: Chen Wang <unicorn_wang@outlook.com>
> > 
> > ops of struct cdns_pcie may be NULL, direct use
> > will result in a null pointer error.
> > 
> > Add checking of pcie->ops before using it.
> > 
> > Fixes: 40d957e6f9eb ("PCI: cadence: Add support to start link and verify link status")
> > Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> > ---
> >   drivers/pci/controller/cadence/pcie-cadence-host.c | 2 +-
> >   drivers/pci/controller/cadence/pcie-cadence.c      | 4 ++--
> >   drivers/pci/controller/cadence/pcie-cadence.h      | 6 +++---
> >   3 files changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> > index 8af95e9da7ce..9b9d7e722ead 100644
> > --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> > +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> > @@ -452,7 +452,7 @@ static int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
> >   	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_PCI_ADDR1(0), addr1);
> >   	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_DESC1(0), desc1);
> > -	if (pcie->ops->cpu_addr_fixup)
> > +	if (pcie->ops && pcie->ops->cpu_addr_fixup)
> >   		cpu_addr = pcie->ops->cpu_addr_fixup(pcie, cpu_addr);
> >   	addr0 = CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS(12) |
> > diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
> > index 204e045aed8c..56c3d6cdd70e 100644
> > --- a/drivers/pci/controller/cadence/pcie-cadence.c
> > +++ b/drivers/pci/controller/cadence/pcie-cadence.c
> > @@ -90,7 +90,7 @@ void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u8 fn,
> >   	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_DESC1(r), desc1);
> >   	/* Set the CPU address */
> > -	if (pcie->ops->cpu_addr_fixup)
> > +	if (pcie->ops && pcie->ops->cpu_addr_fixup)
> >   		cpu_addr = pcie->ops->cpu_addr_fixup(pcie, cpu_addr);
> >   	addr0 = CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS(nbits) |
> > @@ -120,7 +120,7 @@ void cdns_pcie_set_outbound_region_for_normal_msg(struct cdns_pcie *pcie,
> >   	}
> >   	/* Set the CPU address */
> > -	if (pcie->ops->cpu_addr_fixup)
> > +	if (pcie->ops && pcie->ops->cpu_addr_fixup)
> >   		cpu_addr = pcie->ops->cpu_addr_fixup(pcie, cpu_addr);
> >   	addr0 = CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS(17) |
> > diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> > index f5eeff834ec1..436630d18fe0 100644
> > --- a/drivers/pci/controller/cadence/pcie-cadence.h
> > +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> > @@ -499,7 +499,7 @@ static inline u32 cdns_pcie_ep_fn_readl(struct cdns_pcie *pcie, u8 fn, u32 reg)
> >   static inline int cdns_pcie_start_link(struct cdns_pcie *pcie)
> >   {
> > -	if (pcie->ops->start_link)
> > +	if (pcie->ops && pcie->ops->start_link)
> >   		return pcie->ops->start_link(pcie);
> >   	return 0;
> > @@ -507,13 +507,13 @@ static inline int cdns_pcie_start_link(struct cdns_pcie *pcie)
> >   static inline void cdns_pcie_stop_link(struct cdns_pcie *pcie)
> >   {
> > -	if (pcie->ops->stop_link)
> > +	if (pcie->ops && pcie->ops->stop_link)
> >   		pcie->ops->stop_link(pcie);
> >   }
> >   static inline bool cdns_pcie_link_up(struct cdns_pcie *pcie)
> >   {
> > -	if (pcie->ops->link_up)
> > +	if (pcie->ops && pcie->ops->link_up)
> >   		return pcie->ops->link_up(pcie);
> >   	return true;
> > 
> > base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6

