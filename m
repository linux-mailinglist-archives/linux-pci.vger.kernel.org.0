Return-Path: <linux-pci+bounces-5314-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F3588FA79
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 09:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5E341C2B986
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 08:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BB029CEF;
	Thu, 28 Mar 2024 08:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iuXj09aV"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA172E645;
	Thu, 28 Mar 2024 08:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711616174; cv=none; b=NV296yYXq6uY9kc9Jq3kLtaUNxWeFTmT/UP36qMcZihviFkR0bxgkQCtPKUanRfyq0gngC6JWb4KGZr5d9M9v0F/J2JwKwD9j8p5jxpOui7i2obiqXNlRny9VPiKj8qMBNhA2LbxtWFIGptmUZKbYRR+dOZG73p7wtPpqTcVX6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711616174; c=relaxed/simple;
	bh=yYjxHr85dBKFgjOG+0RSwMdZXSL4Vpfh+9mfdWPiJmA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ngOtcMTi+tBg1gkAxCcBvrtWCxlMdvBBhRP4zpNtdpISXf5OHrEFr8OveNh+Vthtp3tqcrGWdACFRWVFyVbLqwgCQ97oUFM3Uxtfq1s/j5DdMoSi92v1qeMo3NOGoX9SX7MH5mApBqxNkCpx0ICT7KFrWbjHX+psLv3oQpxVpn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=iuXj09aV; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42S8tgAX014998;
	Thu, 28 Mar 2024 03:55:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711616142;
	bh=nermr1aimNjYdldtEPQ8fIB5KlP9vorwtOZqf6DA1/E=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=iuXj09aVZaOoqrGOU8cTd5WFAe1jMZRPLDPzZzbku5KxYrdEIxYinYhCyx11atzuj
	 rJoht2CQBPSm3wJP/66GBDFoQMb4haNjImJor1gljkiAAqN6NkchXBd/GHzw5Nk0XU
	 f9WzaOg+dV5B56IAPnxFhH2EACOkTfbCmTe687jQ=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42S8tfc1085259
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 28 Mar 2024 03:55:42 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 28
 Mar 2024 03:55:41 -0500
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 28 Mar 2024 03:55:41 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42S8te7U011065;
	Thu, 28 Mar 2024 03:55:41 -0500
Date: Thu, 28 Mar 2024 14:25:40 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <manivannan.sadhasivam@linaro.org>, <fancer.lancer@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <cassel@kernel.org>,
        <dlemoal@kernel.org>, <yoshihiro.shimoda.uh@renesas.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
Subject: Re: [PATCH v6] PCI: keystone: Fix pci_ops for AM654x SoC
Message-ID: <70ace5d8-1a84-492e-b5af-8b6899dfbace@ti.com>
References: <20240326144258.2404433-1-s-vadapalli@ti.com>
 <20240326232403.GA1502764@bhelgaas>
 <49077b26-9ca3-4ef7-8b25-8c58adf95f5d@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <49077b26-9ca3-4ef7-8b25-8c58adf95f5d@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Wed, Mar 27, 2024 at 03:01:08PM +0530, Siddharth Vadapalli wrote:
> On Tue, Mar 26, 2024 at 06:24:03PM -0500, Bjorn Helgaas wrote:
> > On Tue, Mar 26, 2024 at 08:12:58PM +0530, Siddharth Vadapalli wrote:
> > > In the process of converting .scan_bus() callbacks to .add_bus(), the
> > > ks_pcie_v3_65_scan_bus() function was changed to ks_pcie_v3_65_add_bus().
> > > The .scan_bus() method belonged to ks_pcie_host_ops which was specific
> > > to controller version 3.65a, while the .add_bus() method had been added
> > > to ks_pcie_ops which is shared between the controller versions 3.65a and
> > > 4.90a. Neither the older ks_pcie_v3_65_scan_bus() method, nor the newer
> > > ks_pcie_v3_65_add_bus() method is applicable to the controller version
> > > 4.90a which is present in AM654x SoCs.
> > > 
> > > Thus, as a fix, move the contents of "ks_pcie_v3_65_add_bus()" to the
> > > .msi_init callback "ks_pcie_msi_host_init()" which is specific to the
> > > 3.65a controller. Also, move the definitions of ks_pcie_set_dbi_mode()
> > > and ks_pcie_clear_dbi_mode() above ks_pcie_msi_host_init() in order to
> > > avoid forward declaration.
> > 
> > If it's possible to split this into two patches (one that strictly
> > *moves* the code without otherwise changing it, and another that makes
> > the actual fix), it would be easier to review the fix.  It's a pain to
> > have to compare the code in the old location with that in the new
> > location.
> 
> Sure. I will do so and post the v7 patch.

I have posted the v7 series at:
https://lore.kernel.org/r/20240328085041.2916899-1-s-vadapalli@ti.com/

Regards,
Siddharth.

