Return-Path: <linux-pci+bounces-32136-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8F5B0560F
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 11:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 364547B5210
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 09:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC8F27700C;
	Tue, 15 Jul 2025 09:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dMuShdJZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB3F2459D7;
	Tue, 15 Jul 2025 09:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752570969; cv=none; b=uRqTc/yzsDB6CvZfsIgpGyL7AQpGEjSO2cJVfbSuFcp+fLitVZNx5d+BbcFDU5UllwOZ+LUd4NgWHv2HZPTeGXpWl5xVtQHdWZiTq6fzxI5c7FmoFp5gxGtgw4P/y2W6V/Nny7Z80ThJ6YBiqGdNMCh+IeFOdgTRMtUGavAnpas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752570969; c=relaxed/simple;
	bh=ykFCqJnDeRAU9E+3JG+mUliPAL/DkE9/PsXnNRRVb8M=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LzkEMxfBAZWN6mCbSKm3QvXln8h5xHoqKBb7HR2WH8HGIck9icSkOFypZ9ydi8ffjnZjZcGysw5NrvzM9dZIi7W+ivTUwZTbNmUrW+fMEG/HCdt2HqZR0dWeA0aVfsXGW8qolakx203Wiz6oLCAczlFhGiTdOUzIECwYD95X/Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dMuShdJZ; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56F9FpvU2812962;
	Tue, 15 Jul 2025 04:15:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752570951;
	bh=RgLXppGnaKhRmU6P1gSrKgnSIFK0acz5r/UyuFZ9QpA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=dMuShdJZwTRdU3dH+CMk0jZkaIOWM0MQ2iR7UhN8l7ZOfwSO6xaJxJX4OLU6UYdFd
	 L5NiG7Ff04/C43hEAN3V/BV6xpXRQJdNnV7d/nqMw9oo548nE7D4CEmYkyPJZkxQ74
	 cQ8hnchQ61mdibwO9H/77om7O9ykXBsV9JtCk4yc=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56F9Fptw1162032
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 15 Jul 2025 04:15:51 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 15
 Jul 2025 04:15:50 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 15 Jul 2025 04:15:50 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.169])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56F9Fnbd2621763;
	Tue, 15 Jul 2025 04:15:50 -0500
Date: Tue, 15 Jul 2025 14:45:48 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <huaqian.li@siemens.com>,
        <helgaas@kernel.org>, <baocheng.su@siemens.com>, <bhelgaas@google.com>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <diogo.ivo@siemens.com>, <kristo@kernel.org>, <krzk+dt@kernel.org>,
        <kw@linux.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <lpieralisi@kernel.org>, <nm@ti.com>, <robh@kernel.org>,
        <ssantosh@kernel.org>, <vigneshr@ti.com>
Subject: Re: [PATCH v8 4/7] PCI: keystone: Add support for PVU-based DMA
 isolation on AM654
Message-ID: <e21c6ead-2bcb-422b-a1b9-eb9dd63b7dc7@ti.com>
References: <aa3c8d033480801250b3fb0be29adda4a2c31f9e.camel@siemens.com>
 <20250422061406.112539-1-huaqian.li@siemens.com>
 <20250422061406.112539-5-huaqian.li@siemens.com>
 <7c8c29ee-2600-4eea-866f-8fe2d533418e@ti.com>
 <e9716614-1849-4524-af4d-20587df365cf@siemens.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e9716614-1849-4524-af4d-20587df365cf@siemens.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Tue, Jul 15, 2025 at 10:55:19AM +0200, Jan Kiszka wrote:

Hello Jan,

> On 25.04.25 18:48, Siddharth Vadapalli wrote:
> > On Tue, Apr 22, 2025 at 02:14:03PM +0800, huaqian.li@siemens.com wrote:
> >> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>
> >> The AM654 lacks an IOMMU, thus does not support isolating DMA requests
> >> from untrusted PCI devices to selected memory regions this way. Use
> >> static PVU-based protection instead. The PVU, when enabled, will only
> >> accept DMA requests that address previously configured regions.
> >>
> >> Use the availability of a restricted-dma-pool memory region as trigger
> >> and register it as valid DMA target with the PVU. In addition, enable
> >> the mapping of requester IDs to VirtIDs in the PCI RC. Use only a single
> >> VirtID so far, catching all devices. This may be extended later on.
> >>
> >> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> >> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> >> Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>
> >> ---
> >>  drivers/pci/controller/dwc/pci-keystone.c | 106 ++++++++++++++++++++++
> >>  1 file changed, 106 insertions(+)
> >>
> >> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> >> index 76a37368ae4f..ea2d8768e333 100644
> >> --- a/drivers/pci/controller/dwc/pci-keystone.c
> >> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> >> @@ -19,6 +19,7 @@
> >>  #include <linux/mfd/syscon.h>
> >>  #include <linux/msi.h>
> >>  #include <linux/of.h>
> >> +#include <linux/of_address.h>
> >>  #include <linux/of_irq.h>
> >>  #include <linux/of_pci.h>
> >>  #include <linux/phy/phy.h>
> >> @@ -26,6 +27,7 @@
> >>  #include <linux/regmap.h>
> >>  #include <linux/resource.h>
> >>  #include <linux/signal.h>
> >> +#include <linux/ti-pvu.h>
> >>  
> >>  #include "../../pci.h"
> >>  #include "pcie-designware.h"
> >> @@ -111,6 +113,16 @@
> >>  
> >>  #define PCI_DEVICE_ID_TI_AM654X		0xb00c
> >>  
> >> +#define KS_PCI_VIRTID			0
> >> +
> >> +#define PCIE_VMAP_xP_CTRL		0x0
> >> +#define PCIE_VMAP_xP_REQID		0x4
> >> +#define PCIE_VMAP_xP_VIRTID		0x8
> >> +
> >> +#define PCIE_VMAP_xP_CTRL_EN		BIT(0)
> >> +
> >> +#define PCIE_VMAP_xP_VIRTID_VID_MASK	0xfff
> >> +
> >>  struct ks_pcie_of_data {
> >>  	enum dw_pcie_device_mode mode;
> >>  	const struct dw_pcie_host_ops *host_ops;
> >> @@ -1137,6 +1149,94 @@ static const struct of_device_id ks_pcie_of_match[] = {
> >>  	{ },
> >>  };
> >>  
> >> +static int ks_init_vmap(struct platform_device *pdev, const char *vmap_name)
> >> +{
> >> +	struct resource *res;
> >> +	void __iomem *base;
> >> +	u32 val;
> >> +
> >> +	if (!IS_ENABLED(CONFIG_TI_PVU))
> >> +		return 0;
> >> +
> >> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, vmap_name);
> >> +	base = devm_pci_remap_cfg_resource(&pdev->dev, res);
> >> +	if (IS_ERR(base))
> >> +		return PTR_ERR(base);
> >> +
> >> +	writel(0, base + PCIE_VMAP_xP_REQID);
> >> +
> >> +	val = readl(base + PCIE_VMAP_xP_VIRTID);
> >> +	val &= ~PCIE_VMAP_xP_VIRTID_VID_MASK;
> >> +	val |= KS_PCI_VIRTID;
> > 
> > While it has been stated that we are going to start off with a single
> > VirtID for now and extend it later on, is there an example for how it may
> > be extended? The only option I see is that of associating one VirtID for
> > Low-Priority (LP) traffic and another for High-Priority (HP) traffic, in
> > which case, it might be better to define them upfront and use them like:
> > #define KS_PCI_LP_VIRTID	0
> > #define KS_PCI_HP_VIRTID	1
> 
> Sorry for the late reply, was just reminded of this question:
> 
> When trying to design anything beyond the current use case, I would be
> struggling right now with the how, simply because we would have no user
> of extended APIs around to make sure that the result would be useful.
> Can you envision such use cases? If not, I would rather suggest to
> postpone any attempts to broaden the API until we have such users.

I understand that it might not be possible to extend it (or at-least it
doesn't seem to be straightforward), in which case, we could state the
same in commit message. I had asked for an example of extending it
because the commit message states:

    ....Use only a single VirtID so far, catching all devices.
    This may be extended later on.

without explaining how it could be extended later on. To be precise, my
question was aimed at whether or not the current implementation allows
it to be extended in the future (maintaining backward compatibility). If
that's not yet known, it might be better to state that in the commit
message, or omit the portion which states that it may be extended later on.

-----8<---rest of the email has been trimmed-----8<---------------------

Regards,
Siddharth.

