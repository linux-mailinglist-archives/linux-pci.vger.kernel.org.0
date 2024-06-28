Return-Path: <linux-pci+bounces-9395-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FD891B670
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2024 07:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43E261F24C87
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2024 05:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AB1446B4;
	Fri, 28 Jun 2024 05:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IpyKhb+m"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1146E46441;
	Fri, 28 Jun 2024 05:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719553474; cv=none; b=Q1ZeA473YcGJDq0rrPbzIRl34mKKasLAJ+gXjt5ygRhrmyhyl9APKmvwAh5V4leFf6D10FKPFL9hB7IUyt3kdMwCiNNHxF8VQoGA+CM4guY/tbzAZGT9bUiXw+V4siJ7NAvRZD0wRTXtPv3B4J98BWORTDLiA8FAutZLxuvuT3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719553474; c=relaxed/simple;
	bh=3tBrrtwcKSRzMlQKzS9mBrZTJWuydwJFmJR41cuHZUY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmF8oX4SMIv+2dTOFB+TZyOpSxFwEIcXmxDCEDHRsr6Rwi4QsY7U16l7q9qwXfpP7ftN0WFYRUS+YD9DipcD9SzSYOAyjl25RiSTkKeZDrP+fc/BCEOxKv1rSSx2Q7JTtPgP1zcf1eILlRx57gBxzyatFh/P2LWOvFcHOs+yt0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IpyKhb+m; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45S5i6Pl100950;
	Fri, 28 Jun 2024 00:44:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719553446;
	bh=QvdREwoZPVYdRX4jP9BxkEHK2SVRZXLO4DEzL6qK8lI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=IpyKhb+mgz2h6JhW52JABuc1Y3216E54zWtF6LAYwqrlYdOwaTKSa0HdcTmpUjVAh
	 7jid0Q7XxRKzmZDigzCQh5BTtYAUjgp34HGN7/uD1ju+5OIBzGvjVEqSF9qpJJ+L1d
	 asmzgldTrlkHzLW1QX4bhFuBtPxgV/b/v8zseo88=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45S5i61k014962
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 28 Jun 2024 00:44:06 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Jun 2024 00:44:06 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Jun 2024 00:44:06 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45S5i5A4007205;
	Fri, 28 Jun 2024 00:44:06 -0500
Date: Fri, 28 Jun 2024 11:14:05 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof
 =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I
	<kishon@kernel.org>,
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3] PCI: keystone: Add workaround for Errata #i2037
 (AM65x SR 1.0)
Message-ID: <059a7f46-68ea-4d77-b87a-4d2de1968c66@ti.com>
References: <7c5b8986-c69f-4ff5-9ed2-b2055ae848c4@siemens.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7c5b8986-c69f-4ff5-9ed2-b2055ae848c4@siemens.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Thu, Jun 27, 2024 at 03:35:28PM +0200, Jan Kiszka wrote:
> From: Kishon Vijay Abraham I <kishon@ti.com>
> 
> Errata #i2037 in AM65x/DRA80xM Processors Silicon Revision 1.0
> (SPRZ452D_July 2018_Revised December 2019 [1]) mentions when an
> inbound PCIe TLP spans more than two internal AXI 128-byte bursts,
> the bus may corrupt the packet payload and the corrupt data may
> cause associated applications or the processor to hang.
> 
> The workaround for Errata #i2037 is to limit the maximum read
> request size and maximum payload size to 128 Bytes. Add workaround

s/128 Bytes/128 bytes
as indicated by Krzysztof on the v1 patch at:
https://lore.kernel.org/linux-pci/YF2K6+R1P3SNUoo5@rocinante/

> for Errata #i2037 here. The errata and workaround is applicable
> only to AM65x SR 1.0 and later versions of the silicon will have
> this fixed.

[...]

> 
> +	/*
> +	 * Memory transactions fail with PCI controller in AM654 PG1.0
> +	 * when MRRS is set to more than 128 Bytes. Force the MRRS to
> +	 * 128 Bytes in all downstream devices.

s/128 Bytes/128 bytes
as indicated by Krzysztof on the v1 patch at:
https://lore.kernel.org/linux-pci/YF2K6+R1P3SNUoo5@rocinante/

> +	 */
> +	if (pci_match_id(am6_pci_devids, bridge)) {
> +		bridge_dev = pci_get_host_bridge_device(dev);
> +		if (!bridge_dev && !bridge_dev->parent)
> +			return;
> +
> +		ks_pcie = dev_get_drvdata(bridge_dev->parent);
> +		if (!ks_pcie)
> +			return;
> +
> +		val = ks_pcie_app_readl(ks_pcie, PID);
> +		val &= RTL;
> +		val >>= RTL_SHIFT;
> +		if (val != AM6_PCI_PG1_RTL_VER)
> +			return;
> +
> +		if (pcie_get_readrq(dev) > 128) {
> +			dev_info(&dev->dev, "limiting MRRS to 128 bytes\n");

Thank you for adding "bytes" in the above line.

> +			pcie_set_readrq(dev, 128);
> +		}
> +	}
>  }
>  DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, ks_pcie_quirk);

Regards,
Siddharth.

