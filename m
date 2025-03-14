Return-Path: <linux-pci+bounces-23726-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23332A60CC4
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 10:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67C947A4975
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 09:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4921A315B;
	Fri, 14 Mar 2025 09:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="I9Gnyj6q"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4869517E;
	Fri, 14 Mar 2025 09:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741943252; cv=none; b=iOxUExLmUtie1y9pYd++OmqaPjMW5Nm8G84RCN/WsfMiipz0EqokKFMx08P2JQEFyqHZJ8tr7IU7kza+nAMd/oxsbaRhOYpvSm8+lVXiuXmYrNS9HvcSsp9ZboQUVO1/qX4xSGkh1YRmophiUhjqUl/EuOWFBH2MT9oBiYXs7HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741943252; c=relaxed/simple;
	bh=fWAl0o6kzNFqcIxGpkGrqFYkLiie1rYfsKfuIM2ZjbQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RGu2CeoBBEDWxWXx+Yn7faHfMg52Q1XUMWZorfpPmULkE2tjU5tr9TERqHJycGMP64BXOCjyWYlwszoK4RzQVKa3Nn9AAJWUiWpk+r9JCMsQ9QyhRkPGN7jYP5YhyU0PC+ZbrtNxFzrpioCfIhCMWOixstiKwgj2FWH9AGghxLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=I9Gnyj6q; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52E97BUG1638695
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Mar 2025 04:07:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741943231;
	bh=PBc+H6lNDSCY0P/ZGAoCaWqWu97NXbYVzEJgVsi6CPI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=I9Gnyj6qjLjU0xS0CUgxLIJLbySBdjn0ux91+G+Hk2P9/s6bLE2OX+auY59sWPwaz
	 jAMEbPV9PCvP4qGZnRbZsZ9wEIWMobRZCUgRX6v7ZBsfc/ztQnRg5RQcaJHg+DMcxE
	 u7wleChfDMdOUk75jk0rbrJ4oMXC0tg2OAe1QRPE=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52E97B6S005456
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 14 Mar 2025 04:07:11 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Mar 2025 04:07:11 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Mar 2025 04:07:11 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52E97AxF127218;
	Fri, 14 Mar 2025 04:07:10 -0500
Date: Fri, 14 Mar 2025 14:37:09 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Thomas Richard <thomas.richard@bootlin.com>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <vigneshr@ti.com>, <kishon@kernel.org>,
        <cassel@kernel.org>, <wojciech.jasko-EXT@continental-corporation.com>,
        <bwawrzyn@cisco.com>, <linux-pci@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
Subject: Re: [PATCH 4/4] PCI: j721e: Add support to build as a loadable module
Message-ID: <20250314090709.oaaxhapvg4fxdjc7@uda0492258>
References: <20250307103128.3287497-1-s-vadapalli@ti.com>
 <20250307103128.3287497-5-s-vadapalli@ti.com>
 <88b3ecbe-32b6-4310-afb9-da19a2d0506a@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <88b3ecbe-32b6-4310-afb9-da19a2d0506a@bootlin.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Fri, Mar 14, 2025 at 10:03:01AM +0100, Thomas Richard wrote:

Hello Thomas,

> > +
> > +	if (pcie->reset_gpio) {
> > +		msleep(PCIE_T_PVPERL_MS);
> > +		gpiod_set_value_cansleep(pcie->reset_gpio, 1);
> > +	}
> > +
> > +	if (pcie->refclk)
> > +		clk_disable_unprepare(pcie->refclk);
> >  
> 
> Hello Siddharth,
> 
> I think clk_disable_unprepare() is a no-op if the clock is NULL, so the
> if statement is useless.
> 
> https://elixir.bootlin.com/linux/v6.14-rc6/source/include/linux/clk.h#L1157
> https://elixir.bootlin.com/linux/v6.14-rc6/source/drivers/clk/clk.c#L1237
> https://elixir.bootlin.com/linux/v6.14-rc6/source/drivers/clk/clk.c#L1099

Thank you for pointing it out. I will drop the unnecessary check in the
next version. I will wait for feedback on other patches in this series
before I post the next version.

Regards,
Siddharth.

