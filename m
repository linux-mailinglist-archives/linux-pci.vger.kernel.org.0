Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD0521115C
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jul 2020 18:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgGAQzi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Jul 2020 12:55:38 -0400
Received: from mail-db8eur05on2061.outbound.protection.outlook.com ([40.107.20.61]:6048
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730955AbgGAQzh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Jul 2020 12:55:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l7FCy7fxV7UBDaNEyDX9zxQCchxTNulSc3MZvEx+uhMfVu0c+SSz/oj1CnUKUAeG165fleXK1hYXVzZ3bNtkwMT+oBvoN7ZTW6C82wUfOKTBHn+Tv2sMyFa59UpI+CM0OT8JQQ4MNKCfaFEQuOZEmBATOKH9gU/5h1Jc+VosixT9CS9zwN1ssd1sZI7Ifl4lMQmBb8LNVt9G6SnVBFk6CwkDq1TthnBRzivDWXfIHq18S9VJzxe1qAMB0lqM6PH6bSIcDSBZswMPURf8pby2M0e048UXE6KIQuRumx8qqP7IUUrc0S2t8OkQ/Q3e12GHFEl8pWxIj2I+t48TF8Ffdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=snd5uQfa7o2zadXKR1T01ka6EzpdF/YzLN/8hBi6LcY=;
 b=GSuo8R0rEFpZo4OI437eoYfSR/gQ3nBDuYVPdX/+NvzrYrF2Vxl/3hXOw0cM80iOYi6Tk5CC7u3DnwdnmlHR60vmLbfGoF2Q83Bji7lnz/hBwxWT3BtB8R2d7zOAm5y3AFmsiFmgQTq3Ha1fMh3qY3QMbtSpgi5ARIGSxD5n9WcPEoMJUSWUOoI5fa8pHnvOry0o7M0f4onvBV/5g6qZHL/lotn4YsNE64DSN7RkDiMZBYY6LLopG0+ESGAXdY6z1Y23R402BOtYa2jVQvZVr+kg9dUEeJYKlaSNXgqejQwZCwCSEGkfpka3cqf0lJBAYXbZohoLPZTy+UeuZDZxoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=snd5uQfa7o2zadXKR1T01ka6EzpdF/YzLN/8hBi6LcY=;
 b=aA7ym/SRmDtodcPUiBD52qe6OORUJOfh5GX9DN8sE09UJXXyv6Fk9bGNTk6ZrGIL9ikxvKmbX3bjTQ8WkbWETewe0K5zo5C9s6OlX3HmbcAtKUFup9Qqr3sixgh1B20ntiWJGUeqSzZPJXfaRlvYxAgDdWamSsuvACPoIj9ove8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VI1PR0402MB3421.eurprd04.prod.outlook.com (2603:10a6:803:5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Wed, 1 Jul
 2020 16:55:32 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::b97a:64f0:3ab5:d7fa]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::b97a:64f0:3ab5:d7fa%5]) with mapi id 15.20.3131.029; Wed, 1 Jul 2020
 16:55:32 +0000
Subject: Re: [PATCH v2 12/12] bus: fsl-mc: Add ACPI support for fsl-mc
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Makarand Pawagi <makarand.pawagi@nxp.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        iommu@lists.linux-foundation.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Joerg Roedel <joro@8bytes.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-13-lorenzo.pieralisi@arm.com>
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
Message-ID: <a7845603-9bc9-9099-dfc4-19b7bc4f4e44@nxp.com>
Date:   Wed, 1 Jul 2020 19:55:28 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200619082013.13661-13-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR05CA0130.eurprd05.prod.outlook.com
 (2603:10a6:207:2::32) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.107] (86.120.184.194) by AM3PR05CA0130.eurprd05.prod.outlook.com (2603:10a6:207:2::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20 via Frontend Transport; Wed, 1 Jul 2020 16:55:30 +0000
X-Originating-IP: [86.120.184.194]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6eff0799-edba-4680-d132-08d81ddf9121
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3421:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB3421AD3EF1D816EA8DA1A2B3EC6C0@VI1PR0402MB3421.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-Forefront-PRVS: 04519BA941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KcEe1HcFIdTkKCkzJFOo0IHJ0lbqbrUY+xtrAel8ntX43WAsYLz1QhDyqCZCoDkQfyww26Yuks95qY9jUT2AH8Shqr430p8EFmtVwLnYo3Rgr3geCgjoNQroZZIcqPr7T8/ICKr7cn7c7avlNRB5l2+Zy6ietm40EMZBJ16A+bTe+zFy+FsXu3KanDMb0xToe2rClyiKUai6vko18uWRUNCsnKoqBpaFN+Pml7UGO1qfWVMlnEreQkC9stdKm6DGU6En3OUK73Su62SZrR839MEbKD099W4RYBSVZFmGfwgZ5fVH4GEekHz9phdv1fvxKVLvKaDjTg0t/NPvZP98q1dCzIhfl02+oimyBdUUflOmfUqHr5E5/mVh6DZquFfE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(2906002)(44832011)(2616005)(16526019)(186003)(6486002)(8936002)(26005)(478600001)(66946007)(31686004)(66556008)(7416002)(66476007)(8676002)(83380400001)(54906003)(5660300002)(86362001)(52116002)(31696002)(16576012)(956004)(316002)(4326008)(36756003)(53546011)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 1ChIOIj7TuKXM2sJKP6OeZkQCNiPoispQnk7waHPyhejj2E2eDyWL9bZkdrTvaCy6sR4NVa+cega5oxbWj4ppTYkE2GND8+XeILuVKkgCHaxGKPvbZ60fP3NIQ8YRD35q5K92HNY6ZzI64qjU5U8URdE0yArcxcdNvNNmcZ3ymBdnmlazYLMLsvyd0v+FexTcKiUnj3Y3Imszv3YsbYpLQJ+d9m1VgaSd/fMhRznFZoV7ZynSlbyj3R7t3eA0G/RFqgnU36egV+/6AN7beVGOtWYazc4dXzNatiA54Rv45LpZCeC0yT7gDb0tDdPQJOIGSQNJ6gixu6k3KEVkQBPnUhXBvPT4u/4SUctx+QosuKybE2jgPWkWPSrekJiKu2++FPDwcuoQRVfkQP2Dukdn5Jztvfyf9J+Wgc3LhgjWgLVzIJQKOP7fNjHUYH0z0jwV/rXAPqHJnd7TuY9hr18Gd5l/cfJJgAHl9lXbPRzrbknptzmNUpi76QWmi6AFANx
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eff0799-edba-4680-d132-08d81ddf9121
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2020 16:55:32.5774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wyS3rYEksGEho9duiAyUvMNZiFkU93c/A1EJCMxcINX2QKzzuuHwD1aldHwY7nDNyaiRmL4EUDtTQzTn00m/BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3421
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/19/2020 11:20 AM, Lorenzo Pieralisi wrote:
> From: Makarand Pawagi <makarand.pawagi@nxp.com>
> 
> Add ACPI support in the fsl-mc driver. Driver parses MC DSDT table to
> extract memory and other resources.
> 
> Interrupt (GIC ITS) information is extracted from the MADT table
> by drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c.
> 
> IORT table is parsed to configure DMA.
> 
> Signed-off-by: Makarand Pawagi <makarand.pawagi@nxp.com>
> Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> ---
>  drivers/bus/fsl-mc/fsl-mc-bus.c             | 73 ++++++++++++----
>  drivers/bus/fsl-mc/fsl-mc-msi.c             | 37 +++++----
>  drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c | 92 ++++++++++++++++-----
>  3 files changed, 150 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
> index 824ff77bbe86..324d49d6df89 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> @@ -18,6 +18,8 @@
>  #include <linux/bitops.h>
>  #include <linux/msi.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/acpi.h>
> +#include <linux/iommu.h>
>  
>  #include "fsl-mc-private.h"
>  
> @@ -38,6 +40,7 @@ struct fsl_mc {
>  	struct fsl_mc_device *root_mc_bus_dev;
>  	u8 num_translation_ranges;
>  	struct fsl_mc_addr_translation_range *translation_ranges;
> +	void *fsl_mc_regs;
>  };
>  
>  /**
> @@ -56,6 +59,10 @@ struct fsl_mc_addr_translation_range {
>  	phys_addr_t start_phys_addr;
>  };
>  
> +#define FSL_MC_FAPR	0x28
> +#define MC_FAPR_PL	BIT(18)
> +#define MC_FAPR_BMT	BIT(17)
> +
>  /**
>   * fsl_mc_bus_match - device to driver matching callback
>   * @dev: the fsl-mc device to match against
> @@ -124,7 +131,10 @@ static int fsl_mc_dma_configure(struct device *dev)
>  	while (dev_is_fsl_mc(dma_dev))
>  		dma_dev = dma_dev->parent;
>  
> -	return of_dma_configure_id(dev, dma_dev->of_node, 0, &input_id);
> +	if (dev_of_node(dma_dev))
> +		return of_dma_configure_id(dev, dma_dev->of_node, 0, &input_id);
> +
> +	return acpi_dma_configure_id(dev, DEV_DMA_COHERENT, &input_id);
>  }
>  
>  static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
> @@ -865,8 +875,11 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
>  	struct fsl_mc_io *mc_io = NULL;
>  	int container_id;
>  	phys_addr_t mc_portal_phys_addr;
> -	u32 mc_portal_size;
> -	struct resource res;
> +	u32 mc_portal_size, mc_stream_id;
> +	struct resource *plat_res;
> +
> +	if (!iommu_present(&fsl_mc_bus_type))
> +		return -EPROBE_DEFER;
>  
>  	mc = devm_kzalloc(&pdev->dev, sizeof(*mc), GFP_KERNEL);
>  	if (!mc)
> @@ -874,19 +887,33 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, mc);
>  
> +	plat_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	mc->fsl_mc_regs = devm_ioremap_resource(&pdev->dev, plat_res);
> +	if (IS_ERR(mc->fsl_mc_regs))
> +		return PTR_ERR(mc->fsl_mc_regs);
> +
> +	if (IS_ENABLED(CONFIG_ACPI) && !dev_of_node(&pdev->dev)) {
> +		mc_stream_id = readl(mc->fsl_mc_regs + FSL_MC_FAPR);
> +		/*
> +		 * HW ORs the PL and BMT bit, places the result in bit 15 of
> +		 * the StreamID and ORs in the ICID. Calculate it accordingly.
> +		 */
> +		mc_stream_id = (mc_stream_id & 0xffff) |
> +				((mc_stream_id & (MC_FAPR_PL | MC_FAPR_BMT)) ?
> +					0x4000 : 0);
> +		error = acpi_dma_configure_id(&pdev->dev, DEV_DMA_COHERENT,
> +					      &mc_stream_id);
> +		if (error)
> +			dev_warn(&pdev->dev, "failed to configure dma: %d.\n",
> +				 error);
> +	}
> +
>  	/*
>  	 * Get physical address of MC portal for the root DPRC:
>  	 */
> -	error = of_address_to_resource(pdev->dev.of_node, 0, &res);
> -	if (error < 0) {
> -		dev_err(&pdev->dev,
> -			"of_address_to_resource() failed for %pOF\n",
> -			pdev->dev.of_node);
> -		return error;
> -	}
> -
> -	mc_portal_phys_addr = res.start;
> -	mc_portal_size = resource_size(&res);
> +	plat_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	mc_portal_phys_addr = plat_res->start;
> +	mc_portal_size = resource_size(plat_res);
>  	error = fsl_create_mc_io(&pdev->dev, mc_portal_phys_addr,
>  				 mc_portal_size, NULL,
>  				 FSL_MC_IO_ATOMIC_CONTEXT_PORTAL, &mc_io);
> @@ -903,11 +930,13 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
>  	dev_info(&pdev->dev, "MC firmware version: %u.%u.%u\n",
>  		 mc_version.major, mc_version.minor, mc_version.revision);
>  
> -	error = get_mc_addr_translation_ranges(&pdev->dev,
> -					       &mc->translation_ranges,
> -					       &mc->num_translation_ranges);
> -	if (error < 0)
> -		goto error_cleanup_mc_io;
> +	if (dev_of_node(&pdev->dev)) {
> +		error = get_mc_addr_translation_ranges(&pdev->dev,
> +						&mc->translation_ranges,
> +						&mc->num_translation_ranges);
> +		if (error < 0)
> +			goto error_cleanup_mc_io;
> +	}
>  
>  	error = dprc_get_container_id(mc_io, 0, &container_id);
>  	if (error < 0) {
> @@ -934,6 +963,7 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
>  		goto error_cleanup_mc_io;
>  
>  	mc->root_mc_bus_dev = mc_bus_dev;
> +	mc_bus_dev->dev.fwnode = pdev->dev.fwnode;

Makarand, this looks a bit weird. Is there really a reason for it?

---
Best Regards, Laurentiu
