Return-Path: <linux-pci+bounces-23408-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDAEA5B9D5
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 08:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC44D17112D
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 07:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCD02222CE;
	Tue, 11 Mar 2025 07:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Gl+Q5VdC"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2815B1E7C06;
	Tue, 11 Mar 2025 07:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741678352; cv=none; b=Z60X+KX/S0i48IxyaYstk3yZE5v1lSnvJk+AoimAQV5vin4wvpneRAxTCVDKMnGjwKGp3N3S48yp55QOKLLFce/2Sj9fDrzSnAfLoGEobhXITuXN8cyeBQfa1szz5DG/Aha/Qqz+Iv1w3Sa2PFwdRER1OMyFzmTgpzQy0JVfCi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741678352; c=relaxed/simple;
	bh=Ya6le97lQO/QUzfLoztyjsewtNn6ASubIT9SkgopjuE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EnsWlYOlPlA7ea/YbtR+zrHcueRg+jkjs7F4OfbOvryB1ls9/Hl67SxruB5iUK5+2feFMDgNA7OzxmbJuoODrrqetiDHr9OKxapvpzRRogveOhKt16sf0mA0VLydx93UCr6bPVXK+0zgJbu6dZQ2fTRgWjLQSnFk57sqxvZzYkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Gl+Q5VdC; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52B7WING699670
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 02:32:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741678339;
	bh=SV7h4ls8IB7WbhH4rLYzHQP8pvDUXO29NP9uDd/G99g=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=Gl+Q5VdCOk2Jt5F2GpIdEvc9OC9FNT8oJEQlDLVGsHP4gFb+C8D47CsoODSuJbidw
	 i2g7qZ1NB8jXzS7Fl7TWLDK3gmdm9Q1BAAwM5PxIJ/AC4wSk+9ZgPxzbDTiL+4nFRl
	 yRAIIPoBSysf0Ov+Oe9EnWbv57invSfO5yjO14QI=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52B7WI1Z003237
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 11 Mar 2025 02:32:18 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 11
 Mar 2025 02:32:18 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 11 Mar 2025 02:32:18 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52B7WHV9008584;
	Tue, 11 Mar 2025 02:32:18 -0500
Date: Tue, 11 Mar 2025 13:02:16 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <lpieralisi@kernel.org>,
        <vigneshr@ti.com>, <manivannan.sadhasivam@linaro.org>,
        <robh@kernel.org>, <bhelgaas@google.com>, <rogerq@kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
Subject: Re: [PATCH] PCI: j721e: Fix the value of linkdown_irq_regfield for
 J784S4
Message-ID: <20250311073216.ynw7rzmu36dwywij@uda0492258>
References: <20250305132018.2260771-1-s-vadapalli@ti.com>
 <20250310210746.GA2377483@rocinante>
 <20250311051806.smcu4o4dxpngimth@uda0492258>
 <20250311072546.GA277060@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250311072546.GA277060@rocinante>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Tue, Mar 11, 2025 at 04:25:46PM +0900, Krzysztof Wilczyński wrote:
> Hello,
> 
> > > > Hence, set 'linkdown_irq_regfield' to the macro 'J7200_LINK_DOWN' which
> > > > expands to BIT(10) and was first defined for the J7200 SoC. Other SoCs
> > > > already reuse this macro since it accurately represents the link-state
> > > > field in their respective "PCIE_INTD_ENABLE_REG_SYS_2" register.
> > > 
> > > Can you confirm for me that the following use the correct macro?
> > > 
> > >   333-static const struct j721e_pcie_data j721e_pcie_rc_data = {
> > >   337:	.linkdown_irq_regfield = LINK_DOWN,
> > >   
> > >   341-static const struct j721e_pcie_data j721e_pcie_ep_data = {
> > >   343:	.linkdown_irq_regfield = LINK_DOWN,
> > >   
> > >   347-static const struct j721e_pcie_data j7200_pcie_rc_data = {
> > >   350:	.linkdown_irq_regfield = J7200_LINK_DOWN,
> > >   
> > >   362-static const struct j721e_pcie_data am64_pcie_rc_data = {
> > >   364:	.linkdown_irq_regfield = J7200_LINK_DOWN,
> > >   
> > >   369-static const struct j721e_pcie_data am64_pcie_ep_data = {
> > >   371:	.linkdown_irq_regfield = J7200_LINK_DOWN,
> > >   
> > >   375-static const struct j721e_pcie_data j784s4_pcie_rc_data = {
> > >   379:	.linkdown_irq_regfield = LINK_DOWN,
> > >   
> > >   383-static const struct j721e_pcie_data j784s4_pcie_ep_data = {
> > >   385:	.linkdown_irq_regfield = LINK_DOWN,
> > >   
> > >   389-static const struct j721e_pcie_data j722s_pcie_rc_data = {
> > >   391:	.linkdown_irq_regfield = J7200_LINK_DOWN,
> > > 
> > > I am asking as some use LINK_DOWN, so I wanted to make sure.
> > 
> > Yes, the above are accurate except for J784S4 which is fixed by this
> > patch. LINK_DOWN i.e. BIT(1) is applicable only to J721E which was the
> > first SoC after which the driver has been named. For all other SoCs, the
> > integration of the PCIe Controller into the SoC led to BIT(10) of the
> > register being used to indicate the link status.
> 
> Sounds good!  Thank you for letting me know.
> 
> > > Tht said, the following has no .linkdown_irq_regfield property set:
> > > 
> > >   355-static const struct j721e_pcie_data j7200_pcie_ep_data = {
> > >   356-	.mode = PCI_MODE_EP,
> > >   357-	.quirk_detect_quiet_flag = true,
> > >   358-	.quirk_disable_flr = true,
> > >   359-	.max_lanes = 2,
> > >   360-};
> > > 
> > > Would this be a problem?  Or is this as expected?
> > 
> > Thank you for pointing this out. This has to be fixed and the
> > "linkdown_irq_regfield" member has to be added to match
> > j7200_pcie_rc_data. I will post the fix for this.
> 
> No need to send a new version.
> 
> I will update the branch directly when I pull the patch.  Not to worry.

Thank you Krzysztof :)

Regards,
Siddharth.

