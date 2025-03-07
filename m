Return-Path: <linux-pci+bounces-23128-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5580AA56BC9
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 16:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9850A1894758
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 15:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E651F1714B4;
	Fri,  7 Mar 2025 15:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aVcQQYH4"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0720C21CC56;
	Fri,  7 Mar 2025 15:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360821; cv=none; b=RgFy5h0qkG0kQC7ZETcneEez5WdGtOMDL87H6r1lOgNeRqh9EQYCP/HhAVzO2J+sN5xZBeVRnBR5WI8f7vXBUxVPTtLBzxRwl3RZUoequ3m33hUPmJ2p0DD+K71W2pKmw+8Y+lrLEq4KmljffnOHQr9t/QBcB7jn/ZMi6XhxXmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360821; c=relaxed/simple;
	bh=I9v90QuvOYFQkO1/C5xGBSl3JhGgZd8frHszZDZ4isA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tx6grZSiYuD8QjAsw6aVar/MnCUSJ6tXs6COvz5NWxh0Bq3sXFPgnMYt0HeO7thvtcmx+xUyMiu5Ma97A0oyW2RbB9FEcbYv0cX1QC3Q15sqyMJRk8bfadVsnkqdazDmfJ11+ttAjqH4lcmtwHoRICQHN/ZPjE8MNDnTymj65V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=aVcQQYH4; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 527FJqdG394955
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Mar 2025 09:19:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741360792;
	bh=YTzilPJdRmVeHy3CfMoVeWv44AxPr5bm5tl37FH45Yc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=aVcQQYH4YmjTwASvChTUzHIWoflgHKVZfmjBdosy3FKeF+Hxkg3xagqte1ehjIKZ+
	 zV8zX5YwoO/0RZeEqx62oCj2KUxj/fdnAceKTRDZbUtLxjK8KB5RkWVlzjT5KAovMB
	 UjtMtN+fbFPh6w8Oahm+yOfk8+Or028RTvRHjoBM=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 527FJqoa006291
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 7 Mar 2025 09:19:52 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 7
 Mar 2025 09:19:51 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 7 Mar 2025 09:19:51 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 527FJoai127353;
	Fri, 7 Mar 2025 09:19:51 -0600
Date: Fri, 7 Mar 2025 20:49:49 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Chen Wang <unicorn_wang@outlook.com>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Chen Wang <unicornxw@gmail.com>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <thomas.richard@bootlin.com>, <bwawrzyn@cisco.com>,
        <wojciech.jasko-EXT@continental-corporation.com>, <kishon@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sophgo@lists.linux.dev>
Subject: Re: [PATCH] PCI: cadence: Fix NULL pointer error for ops
Message-ID: <20250307151949.7rmxl22euubnzzpj@uda0492258>
References: <20250304081742.848985-1-unicornxw@gmail.com>
 <PN0PR01MB10393C44D1F4B9189C52D31EBFED52@PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM>
 <20250307134727.m57er2ky6e3dmftl@uda0492258>
 <PN0PR01MB10393326D387DD49EF563F787FED52@PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PN0PR01MB10393326D387DD49EF563F787FED52@PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Fri, Mar 07, 2025 at 10:44:10PM +0800, Chen Wang wrote:
> 
> On 2025/3/7 21:47, Siddharth Vadapalli wrote:
> > On Fri, Mar 07, 2025 at 09:07:35PM +0800, Chen Wang wrote:
> > > Hello~
> > > 
> > > Any comment on this? Or can we have this bugfix patch picked for coming
> > > v6.15?
> > Is there a driver in Linux which is affected by the issue that you are
> > trying to fix in this patch? Please point to the driver since I don't
> > see such a driver.
> > 
> > Regards,
> > Siddharth.
> 
> Oh, sorry I didn't explain the change history clearly. I am developing a
> PCIe driver for a new soc (SG2042), and this PCIe controller uses cadence's
> IP. In the code, I found that if I don't assign a value to cdns_pcie.ops, it
> will crash during operation. At first, I didn't fix the bug in the cadence
> code, but used a workaround in the SG2042 driver. Later in the code review,
> Manivannan pointed out my problem and hoped that I would submit a patch to
> fix this problem in the cadence driver.
> 
> Adding Manivannan who should know about this.
> 
> Please take a look at this: https://lore.kernel.org/linux-riscv/20250119122353.v3tzitthmu5tu3dg@thinkpad/.
> For your convenience, I have excerpted some of the text below.
> 
> ```
> 
> > +static struct pci_ops sg2042_pcie_host_ops = {
> > +    .map_bus    = cdns_pci_map_bus,
> > +    .read        = sg2042_pcie_config_read,
> > +    .write        = sg2042_pcie_config_write,
> > +};
> > +
> > +/* Dummy ops which will be assigned to cdns_pcie.ops, which must be
> !NULL. */
> 
> Because cadence code driver doesn't check for !ops? Please fix it instead.
> And
> the fix is trivial.

Thank you for providing the context for this patch. Maybe the context
should go into the commit message, but that's not a reason to block this
patch, so:

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Regards,
Siddharth.

