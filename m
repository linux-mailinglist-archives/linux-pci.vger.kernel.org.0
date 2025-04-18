Return-Path: <linux-pci+bounces-26247-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71417A93E1B
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 21:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B23268A2E9E
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 19:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271DE22B8C6;
	Fri, 18 Apr 2025 19:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vWLwv5/P"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D46222594;
	Fri, 18 Apr 2025 19:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745003100; cv=none; b=oMle9U7duyZE5T07LjsNIG1UwXIh/Y3nGxiDMXWm6cLuSC7PgQ1dsF81xAKNAfiWGtAHHkigXW+4HlAkhxH76nt85kh7CD7l20+JshTR4D2eRdciq+04LC3njJLAFvSnws1rHg+KhEBISb/C5OQECWhS/7LkNuFPnWKg9mrP77k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745003100; c=relaxed/simple;
	bh=NynOvSj7sxcedY3VZBsXlo21ZHktklRq+uP/VAoPVGI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2jfTWIPrexF8mG0RxqA8oKzzAueVuCkESMmoWk0+Va+QktPpeNNkmdaC6xBB8MedtsHh39J3dBBu+xHHw3MdTO+NMujd2fIdlp36rnu4hhejQtE/GP75r4WJ+wF3PokwtETx4pcEyBIi0+umBWA3NFbju7xYbgZdco7elo1cK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vWLwv5/P; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53IJ4UWC354523
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Apr 2025 14:04:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1745003070;
	bh=FB+Mopw+KqIVgqvvOn7oaKklU78nD3/cxIwgMbOunWQ=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=vWLwv5/PaGhUDQv7GsHSU4MvHYboclMD12ndQi7ynfvL3LgspKFHGgekxZn2BdC33
	 U7YBXgM/HFX+Kxk3I0k90Cu7Wyo8ywn9RmObP2RFYjIgIYMP5sG452I9Snli9BrQSV
	 o8GGHTRr+lNqzYjPfaE/S6uKVI79P4ZerHWx0rWE=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53IJ4ULQ118070
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 18 Apr 2025 14:04:30 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 18
 Apr 2025 14:04:30 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 18 Apr 2025 14:04:30 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53IJ4Tth126391;
	Fri, 18 Apr 2025 14:04:29 -0500
Date: Fri, 18 Apr 2025 14:04:30 -0500
From: Nishanth Menon <nm@ti.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <huaqian.li@siemens.com>, <m.szyprowski@samsung.com>,
        <robin.murphy@arm.com>, <baocheng.su@siemens.com>,
        <bhelgaas@google.com>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <diogo.ivo@siemens.com>,
        <jan.kiszka@siemens.com>, <kristo@kernel.org>, <krzk+dt@kernel.org>,
        <kw@linux.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <lpieralisi@kernel.org>, <robh@kernel.org>, <s-vadapalli@ti.com>,
        <ssantosh@kernel.org>, <vigneshr@ti.com>, <iommu@lists.linux.dev>
Subject: Re: [PATCH v7 0/8] soc: ti: Add and use PVU on K3-AM65 for DMA
 isolation
Message-ID: <20250418190430.onhuowuu4bwtlm5f@sequel>
References: <20250418134324.ewsfnze2btnx2r2w@country>
 <20250418163401.GA159541@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250418163401.GA159541@bhelgaas>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 11:34-20250418, Bjorn Helgaas wrote:
> On Fri, Apr 18, 2025 at 08:43:24AM -0500, Nishanth Menon wrote:
> > On 15:30-20250418, huaqian.li@siemens.com wrote:
> > > 
> > > Jan Kiszka (7):
> > >   dt-bindings: soc: ti: Add AM65 peripheral virtualization unit
> > >   dt-bindings: PCI: ti,am65: Extend for use with PVU
> > >   soc: ti: Add IOMMU-like PVU driver
> > >   PCI: keystone: Add support for PVU-based DMA isolation on AM654
> > >   arm64: dts: ti: k3-am65-main: Add PVU nodes
> > >   arm64: dts: ti: k3-am65-main: Add VMAP registers to PCI root complexes
> > >   arm64: dts: ti: iot2050: Add overlay for DMA isolation for devices
> > >     behind PCI RC
> > > 
> > > Li Hua Qian (1):
> > >   swiotlb: Make IO_TLB_SEGSIZE configurable
> > 
> > I see at least 3 or 4 maintainers needing to co-ordinate, gets
> > complicated as I am not sure which maintainer needs to pick up what
> > patches in what dependency order. This looks like a mixed bag. Can
> > we split this patch into independent series for each maintainer with
> > clear indication of dependencies that is spread around a couple of
> > kernel windows (maybe dts comes in last?)
> 
> The keystone patch ("[4/8] PCI: keystone: Add support for PVU-based
> DMA isolation on AM654") depends on interfaces added by "[3/8] soc:
> ti: Add IOMMU-like PVU driver", so I can't really take 4/8 by itself.
> 
> But I've acked 4/8, so it can be merged along with the rest of the
> series.  I assumed the easiest would be via the drivers/soc/ti/
> maintainer, i.e., you, Nisanth :)
> 
> Let me know if I can do anything.

Thanks Bjorn, the swiotlb probably is one of the first to go in, I
guess.. I will let Li Hua/Jan suggest how they'd like to queue this.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

