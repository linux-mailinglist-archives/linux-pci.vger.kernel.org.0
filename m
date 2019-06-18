Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 969E24990A
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2019 08:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfFRGm0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jun 2019 02:42:26 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:16187 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfFRGmZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jun 2019 02:42:25 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d087b260001>; Mon, 17 Jun 2019 22:48:22 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 17 Jun 2019 22:48:21 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 17 Jun 2019 22:48:21 -0700
Received: from [10.24.192.51] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Jun
 2019 05:48:18 +0000
Subject: Re: [PATCH V5 20/27] PCI: tegra: Use legacy IRQ for port service
 drivers
To:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>
CC:     <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jonathanh@nvidia.com>,
        <vidyas@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20190617173952.29363-1-mmaddireddy@nvidia.com>
 <20190617173952.29363-21-mmaddireddy@nvidia.com>
X-Nvconfidentiality: public
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <8a8746f8-3e0f-c724-761e-8bc47b2cc3b6@nvidia.com>
Date:   Tue, 18 Jun 2019 11:17:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190617173952.29363-21-mmaddireddy@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560836902; bh=6Qt6lMRIIpz2/xRoFNVuWEjeHLBcxL7+No9uHm4qAH4=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=AFz08Yw6G3/N+dgZkDHiAXVPg7WlHCfaJqsWLbh89G71hKAhvIOVn1aju8jGAVCqk
         WSIfnTzFKGGd4WxAWhpizGOKgFqxiXIS7KCGHc0TPQ+qGt8kImiwE5NX1/Oiurp70n
         doCboCTPJc8gkynjh+qFTyBLvcs+3yqOqGoz4bRG1CqwlHS7Ghl+KY363bmaPT09Cz
         rekxSY5wUteQkxmzWpBNJY+xolP6q0csZo4A9OG8Flsc/dZrGWplvADA3QSiISvU0R
         vzzbeSgh24OrPN2BndFfUuzZ3R0S3ZXQF2dK3Vf7L3RRUE4rPeIwW03QeK1AOW2YDa
         JlM9OImLWwlzQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 17-Jun-19 11:09 PM, Manikanta Maddireddy wrote:
> Tegra signals PCIe services like AER, PME, etc. over legacy IRQ line.
> By default, service drivers register interrupt routine over MSI IRQ line.
> Use pcie_pme_disable_msi() function to disable MSI for service drivers.
>
> PME and AER interrupts registered to MSI without this change,
> cat /proc/interrupts | grep -i pci
> 36: 21 0 0 0 0 0 GICv2 104 Level       PCIE
> 37: 35 0 0 0 0 0 GICv2 105 Level       Tegra PCIe MSI
> 76: 0  0 0 0 0 0 Tegra PCIe MSI 0 Edge PCIe PME, aerdrv, PCIe BW notif
>
> PME and AER interrupts registered to legacy IRQ with this change,
> cat /proc/interrupts | grep -i pci
> 36: 33 0 0 0 0 0 GICv2 104 Level      PCIE, PCIe PME, aerdrv, PCIe BW notif
> 37: 52 0 0 0 0 0 GICv2 105 Level      Tegra PCIe MSI
>
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> ---
> V5: No change
>
> V4: No change
>
> V3: Corrected typo in commit log
>
> V2: No change
>
>  drivers/pci/controller/pci-tegra.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> index 73d5a8841405..9429c0c6a1f3 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -41,6 +41,7 @@
>  #include <soc/tegra/pmc.h>
>  
>  #include "../pci.h"
> +#include "../pcie/portdrv.h"
>  
>  #define INT_PCI_MSI_NR (8 * 32)
>  
> @@ -2725,6 +2726,9 @@ static int tegra_pcie_probe(struct platform_device *pdev)
>  		goto put_resources;
>  	}
>  
> +	/* Switch to legacy IRQ for PCIe services like AER, PME*/
> +	pcie_pme_disable_msi();
> +
>  	pm_runtime_enable(pcie->dev);
>  	err = pm_runtime_get_sync(pcie->dev);
>  	if (err) {

Hi Lorenzo,

I forgot to address Bjorn's comment here, I will correct this in V6.
Let me know if I can publish it today or you want me to wait until
you look into other patches.

Manikanta

