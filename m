Return-Path: <linux-pci+bounces-23401-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F24A5B88A
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 06:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 835E93ABB30
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 05:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EC81EE7A3;
	Tue, 11 Mar 2025 05:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cYwuJy+T"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F621EDA3A;
	Tue, 11 Mar 2025 05:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741670969; cv=none; b=QYP+GHfx4VZnEyDygzH2chH1FOt7U2C9twDYUkxzcJjjqX8XuPLXIkUncXhYQmdahfHTePfUPoyiLOH0p6jPzEWzsFfG5sWgoPSODvxbXdHGUozxiC9CUEJzt2EzsSYghH4x4AylY7tCMeS+Txde5ku77A4nQBZIoPrXhpnuo9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741670969; c=relaxed/simple;
	bh=j4T/ihpX+piLqBcmM4WOze2O+wOXuPhkdsGGFg65LBE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+8DKfiSRZIiG6HmjYjj4XqxzODp2q2mp2aGJLGM+P0RHsDgWDe7VCEAezeH4xS1+bZPGQcW9Ea9RAX6iPJaCx7/NEWhX2dQxHjCLpoRS8DsdrrS+S0l/EqOUFSt8Wrg1GpzMmwzIrZ1nLnuinaaFeg021yHd+Xxg9sIRyhr5O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cYwuJy+T; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52B5I8ni675075
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 00:18:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741670288;
	bh=NspGx0nqDbjExHcl+uSnaAoQr3YyjgF3MKCUI7kJdT8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=cYwuJy+TZKOyrfecU6ZY2c8glXSCWO9OfycFIJ3QbZLTnpLwAqDJuLH9zmk1doOzq
	 gmGEtZIuhHBgL0kTCbDTiKw9XN3R0FKgtn1UCIcb8T37lq9yrNs9kCLgu9BQimLrMg
	 3LPcgwWeuGTCZtbNUV6ZTrsDgqGTVmhlVHLOnJng=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52B5I81c034069
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 11 Mar 2025 00:18:08 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 11
 Mar 2025 00:18:08 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 11 Mar 2025 00:18:08 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52B5I6G9051545;
	Tue, 11 Mar 2025 00:18:07 -0500
Date: Tue, 11 Mar 2025 10:48:06 +0530
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
Message-ID: <20250311051806.smcu4o4dxpngimth@uda0492258>
References: <20250305132018.2260771-1-s-vadapalli@ti.com>
 <20250310210746.GA2377483@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250310210746.GA2377483@rocinante>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Tue, Mar 11, 2025 at 06:07:46AM +0900, Krzysztof Wilczyński wrote:
> Hello,
> 
> > Hence, set 'linkdown_irq_regfield' to the macro 'J7200_LINK_DOWN' which
> > expands to BIT(10) and was first defined for the J7200 SoC. Other SoCs
> > already reuse this macro since it accurately represents the link-state
> > field in their respective "PCIE_INTD_ENABLE_REG_SYS_2" register.
> 
> Can you confirm for me that the following use the correct macro?
> 
>   333-static const struct j721e_pcie_data j721e_pcie_rc_data = {
>   337:	.linkdown_irq_regfield = LINK_DOWN,
>   
>   341-static const struct j721e_pcie_data j721e_pcie_ep_data = {
>   343:	.linkdown_irq_regfield = LINK_DOWN,
>   
>   347-static const struct j721e_pcie_data j7200_pcie_rc_data = {
>   350:	.linkdown_irq_regfield = J7200_LINK_DOWN,
>   
>   362-static const struct j721e_pcie_data am64_pcie_rc_data = {
>   364:	.linkdown_irq_regfield = J7200_LINK_DOWN,
>   
>   369-static const struct j721e_pcie_data am64_pcie_ep_data = {
>   371:	.linkdown_irq_regfield = J7200_LINK_DOWN,
>   
>   375-static const struct j721e_pcie_data j784s4_pcie_rc_data = {
>   379:	.linkdown_irq_regfield = LINK_DOWN,
>   
>   383-static const struct j721e_pcie_data j784s4_pcie_ep_data = {
>   385:	.linkdown_irq_regfield = LINK_DOWN,
>   
>   389-static const struct j721e_pcie_data j722s_pcie_rc_data = {
>   391:	.linkdown_irq_regfield = J7200_LINK_DOWN,
> 
> I am asking as some use LINK_DOWN, so I wanted to make sure.

Yes, the above are accurate except for J784S4 which is fixed by this
patch. LINK_DOWN i.e. BIT(1) is applicable only to J721E which was the
first SoC after which the driver has been named. For all other SoCs, the
integration of the PCIe Controller into the SoC led to BIT(10) of the
register being used to indicate the link status.

> 
> Tht said, the following has no .linkdown_irq_regfield property set:
> 
>   355-static const struct j721e_pcie_data j7200_pcie_ep_data = {
>   356-	.mode = PCI_MODE_EP,
>   357-	.quirk_detect_quiet_flag = true,
>   358-	.quirk_disable_flr = true,
>   359-	.max_lanes = 2,
>   360-};
> 
> Would this be a problem?  Or is this as expected?

Thank you for pointing this out. This has to be fixed and the
"linkdown_irq_regfield" member has to be added to match
j7200_pcie_rc_data. I will post the fix for this.

Regards,
Siddharth.

