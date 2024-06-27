Return-Path: <linux-pci+bounces-9375-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D3191A681
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 14:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BAC228517B
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 12:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F06158DB7;
	Thu, 27 Jun 2024 12:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="C8CAa5qO"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E052713A276;
	Thu, 27 Jun 2024 12:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719491121; cv=none; b=K03EifKYEF7PJ+4f2P8UJQWmPRCvvXYi0G9m1I4wjKtXCxFhgsLjdsIpqZFaYx0Z0XDXWrP57UY4adENxysX200ClbV27VM/Aa+qSZgtC71ROW4ctkQ+sDq47h+gZNJHQUImf5R9ohcRGMzVAHSD5Ar11xBaagJSlTxYL+/twEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719491121; c=relaxed/simple;
	bh=tqaCiTPc0BDgAKsEhog6Xbqnk6zFGNOhzTcLMOww80Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fuM+2XbU1zoG1XGe3qDqSsD1JxGHPViIed4ejIihY3yyrjmtoW4s5d0nDkQ4sIkGs2z4ER7lg6lIfBYqvI/UMO1QR+v8DJtoaqb0/TCNoo2z/mbR6pZizbIqOleO+R4QhX27fk7XzL8f5NK76qxma355cGtmVMzIzEYarVQD45A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=C8CAa5qO; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45RCOkIm100180;
	Thu, 27 Jun 2024 07:24:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719491086;
	bh=0pV/0H7VpYGnFqZVo1KrwYbiFTjYWzvPhrmi4sO4twM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=C8CAa5qOQ2GHiqE1q0OR2dUqbC+jTveAQi3mV3AF1j7XdPXlllM4rmSf3Zi0e5i84
	 4aBd3dxMpMG0g/o6jN9PKeLwuA894RllztkXXK8hjhQ14aA830i75Z1xYv64kN8gay
	 aMCe5lceYjAZfDNOomZuKt9KSKe0cpgbTm9+FZ0Y=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45RCOkl9069355
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 27 Jun 2024 07:24:46 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Jun 2024 07:24:46 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Jun 2024 07:24:46 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45RCOjrY087518;
	Thu, 27 Jun 2024 07:24:45 -0500
Date: Thu, 27 Jun 2024 17:54:44 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Jan Kiszka <jan.kiszka@siemens.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
	<kw@linux.com>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
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
Subject: Re: [PATCH] PCI: keystone: Add workaround for Errata #i2037 (AM65x
 SR 1.0)
Message-ID: <f27ee4af-eda9-49b1-aab1-2477e5a79642@ti.com>
References: <819861d0-1b3a-4722-969c-d2f48b624622@siemens.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <819861d0-1b3a-4722-969c-d2f48b624622@siemens.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Wed, Jun 26, 2024 at 12:10:41AM +0200, Jan Kiszka wrote:
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
> for Errata #i2037 here. The errata and workaround is applicable
> only to AM65x SR 1.0 and later versions of the silicon will have
> this fixed.
> 
> [1] -> http://www.ti.com/lit/er/sprz452d/sprz452d.pdf
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Achal Verma <a-verma1@ti.com>
> Link: https://lore.kernel.org/linux-pci/20210325090026.8843-7-kishon@ti.com/

Please drop the above. It needs to be mentioned as the v1 below the
tear-line.

> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> Needed for the IOT2050 PG1 variants. Pending downstream way too long.
> 
>  drivers/pci/controller/dwc/pci-keystone.c | 42 +++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index d3a7d14ee685..a04f1087ce91 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -34,6 +34,11 @@
>  #define PCIE_DEVICEID_SHIFT	16

[...]

>  
> +	static const struct pci_device_id am6_pci_devids[] = {
> +		{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_AM654X),
> +		 .class = PCI_CLASS_BRIDGE_PCI << 8, .class_mask = ~0, },
> +		{ 0, },
> +	};
>  
>  	if (pci_is_root_bus(bus))
>  		bridge = dev;
> @@ -562,6 +578,32 @@ static void ks_pcie_quirk(struct pci_dev *dev)
>  			pcie_set_readrq(dev, 256);
>  		}
>  	}
> +
> +	/*
> +	 * Memory transactions fail with PCI controller in AM654 PG1.0
> +	 * when MRRS is set to more than 128 Bytes. Force the MRRS to
> +	 * 128 Bytes in all downstream devices.
> +	 */

Comments on the v1 patch at:
https://lore.kernel.org/linux-pci/YF2K6+R1P3SNUoo5@rocinante/
haven't been addressed in this patch. Kindly update the patch based on
Krzysztof's feedback on the v1 patch.

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
> +			dev_info(&dev->dev, "limiting MRRS to 128\n");
> +			pcie_set_readrq(dev, 128);
> +		}
> +	}
>  }
>  DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, ks_pcie_quirk);

Regards,
Siddharth.

