Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4C01DD0B7
	for <lists+linux-pci@lfdr.de>; Thu, 21 May 2020 17:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbgEUPDj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 11:03:39 -0400
Received: from mail-vi1eur05on2049.outbound.protection.outlook.com ([40.107.21.49]:24163
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728229AbgEUPDj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 May 2020 11:03:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TtN6+n/RacHsA9gHu6HuKkZ39BCUIRVNVobuqOFtXmaOx1Rl8aJhD1EU2F+JUl73AAAeHLR/mUzelL3fukFQ58rdD/BjpmOjYw1D9yMsczFleGqAwL/2byLrayQ+4bBUCvclf1XfBaPaYuQI6BPSNh28z5mKlPXC7IeDWVpS6esgVDjYoLvxSKo10t9ctQh+DqV/14T7iZgI0ndy8eH0fOrcXhIU7sllfyDZNDDpocr3pkY/rDQ22X8wiH3mfsjs4DW6H/lxtpb7fGNI2d88JKKXKKWzbYn3CZEVr7XQHxvKwXV88+xrs/W+D3mi973NIo/OUxXJvL6oQRlzU3fL3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6IhSuCxNIUhMJU28fHdUeD3ip3Uj9Qf8OhoJJ2VmZ0=;
 b=A2pxsRzvYKtEcpsLYa7bOg7JJAhnKFg1HF+T8YKUfKzyqjtOn+9yXSCOA6FL+V6vQy95lGatn3cm6dQzvZ9B7xrX8+ESrQihlUEvWOWNQ2/mEeDpRVbVeq+ahjj1RmhDthyWlU9uy+3J3VDc/BqsyP+lrxUbgZ2QIh2IUSyt1dvNI54xVKUOPLMkk+32iCXkR/MiPEsKVBugUAn2vFQbWJRb5HrNbgshqilK8dekASL/bpLjtn6cu+Xu9fGpsSxqzjgtV57stZB21ozDD4S/IoXMBgc9AYJ4IgxqvTqGFWRyhGnzxZBlpVnPHMjhgUxDyB9aPTAiqF0hk+6lzHMfdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6IhSuCxNIUhMJU28fHdUeD3ip3Uj9Qf8OhoJJ2VmZ0=;
 b=WE4nGzt/O6zIQb7s8wPKRKlsrnO2qfmwVtx1v41rnO5ff0wtZO9V/RUcIHqx9zp4+VXRixilIFUaEtrW26rI1vd43bxpNCGwrIRI4Fq/WH/7XmGL+5qHF2qK7H6204eOYKDVX0raI4ATaITb8NLeHP5LzdmMYL/Tj3FWK1BJilk=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VI1PR0402MB3647.eurprd04.prod.outlook.com (2603:10a6:803:1c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Thu, 21 May
 2020 15:03:35 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::c7e:c51a:1ea4:968d]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::c7e:c51a:1ea4:968d%5]) with mapi id 15.20.3000.022; Thu, 21 May 2020
 15:03:35 +0000
Subject: Re: [PATCH 12/12] bus: fsl-mc: Add ACPI support for fsl-mc
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Diana Craciun <diana.craciun@oss.nxp.com>,
        Makarand Pawagi <makarand.pawagi@nxp.com>,
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
 <20200521130008.8266-13-lorenzo.pieralisi@arm.com>
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
Message-ID: <3045acd5-0bcf-40c1-e65f-0b740200b2e0@nxp.com>
Date:   Thu, 21 May 2020 18:03:21 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200521130008.8266-13-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0307.eurprd07.prod.outlook.com
 (2603:10a6:800:130::35) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.43.159] (213.233.104.197) by VI1PR07CA0307.eurprd07.prod.outlook.com (2603:10a6:800:130::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.8 via Frontend Transport; Thu, 21 May 2020 15:03:33 +0000
X-Originating-IP: [213.233.104.197]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f4cf816b-abaa-473a-42df-08d7fd98226d
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3647:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB36477425C77CE45473D995FBECB70@VI1PR0402MB3647.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:232;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZZeFBiztcbrix8f7bh3QTHWTTTQb5iN5KT4mSsYIs7Yuk2MxlQs15kSldNVh7p4dNCaU7UcyTA81+UC13A6/7y2pu1M2TWEj60mJPqgv0hsKpRHp1/6LG94cZQkqsGea6WlrQqR30CE+xxA/MwREeHkoceOx2OdqoqfGbE8urRkxHbTzIdxxAH3kqwPRU1qTlyyF2gziOhjBh8ouUCS9240G3LY13Q0y/a6HfRH+UkTmkD4Zr3QvSzTgR5agSfXcnh15vBTMkrzgCD+7gSCB3aAXPloK0QxF5SW77eDIwlh9R7bxWUh27sdSgGmksirN7E2YwUSD9YWuF4Ty/9J5GVGx6k0ubAAW8t7hUnHfLdkjyVolKj06k1DI2fdFV+xYixG/TU+XxJbhCJhdlPPK4sJLQwSUiD6ZhidY7+1U/vmLkbKfOSsDxQW7SAkY0XfX7hRha3UN2AuYwyURT9oXIu9tfYLdFRRJ6PmQC5jIDrfGePIOsPQmcZLL6cQ8EHxk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(346002)(366004)(136003)(376002)(316002)(16526019)(16576012)(6666004)(956004)(2616005)(6486002)(66946007)(54906003)(86362001)(52116002)(53546011)(66556008)(26005)(31696002)(186003)(5660300002)(7416002)(8936002)(31686004)(66476007)(36756003)(478600001)(30864003)(8676002)(4326008)(2906002)(44832011)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 7vlpk8gtbVXCisSlz25gm6HEAgUAUSj2qApaDt4IolRe1EVfafuCy71gP2CVIHQQ8rUQ5vORW3ajderxxhnQ2lapdXE54Vo2EirZOJhO+Pp7BsvNFvalXvzLpVkdcOJk2yOFU/Onv36D9K+Vbavyk5j9AsW1V2bw1Wo2vGJR211Hiw0ihktNAWVWhnEnzgirXp5aGXRAfU6XXD1o2GNJ9I1VGLqVJ5cHEsyDmW2rH9/dN5voQIafWa8Crd4aMMLqckMjHqYExVqHP+LTWp8/3abqQjTGIUW28TYdUi73sdEpjx+VRBhqQuAxlyKsPxCFtDtWyf6oIrtU8I0O2SgNZsWdpZGogg7ZZL8xBcHqgg4PsnLXgoWrucdE8Yoz5+JxzeELDkJ+NII2DhQ3jdT2IMf/DTfCeKTaUzIm6eFCOkXCryiyVHzrrTLxJcRPvUIdi8x45q448lGaDU6ApRwDalhoknJHNzMaVXj/02G1/JtBICo+ZFJI836n1FLWWr4Q
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4cf816b-abaa-473a-42df-08d7fd98226d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 15:03:35.3681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vnXdjIjYwLB3dzcwrglXqVP75MbAKSchgmqUgWRUwV643JoMLkGMPYRNRFPYQcvp04LSe5UaJaUq1w856XcSTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3647
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On 5/21/2020 4:00 PM, Lorenzo Pieralisi wrote:
> From: Diana Craciun <diana.craciun@oss.nxp.com>
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

The author of this patch should be Makarand. I think I accidentaly broke
it when we exchanged the patches. Very sorry about it.

---
Best Regards, Laurentiu


>  drivers/bus/fsl-mc/fsl-mc-bus.c             | 73 +++++++++++++++-----
>  drivers/bus/fsl-mc/fsl-mc-msi.c             | 37 +++++-----
>  drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c | 75 ++++++++++++++++++++-
>  3 files changed, 150 insertions(+), 35 deletions(-)
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
>  	return 0;
>  
>  error_cleanup_mc_io:
> @@ -967,11 +997,18 @@ static const struct of_device_id fsl_mc_bus_match_table[] = {
>  
>  MODULE_DEVICE_TABLE(of, fsl_mc_bus_match_table);
>  
> +static const struct acpi_device_id fsl_mc_bus_acpi_match_table[] = {
> +	{"NXP0008", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, fsl_mc_bus_acpi_match_table);
> +
>  static struct platform_driver fsl_mc_bus_driver = {
>  	.driver = {
>  		   .name = "fsl_mc_bus",
>  		   .pm = NULL,
>  		   .of_match_table = fsl_mc_bus_match_table,
> +		   .acpi_match_table = fsl_mc_bus_acpi_match_table,
>  		   },
>  	.probe = fsl_mc_bus_probe,
>  	.remove = fsl_mc_bus_remove,
> diff --git a/drivers/bus/fsl-mc/fsl-mc-msi.c b/drivers/bus/fsl-mc/fsl-mc-msi.c
> index e7bbff445a83..8edadf05cbb7 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-msi.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-msi.c
> @@ -13,6 +13,7 @@
>  #include <linux/irq.h>
>  #include <linux/irqdomain.h>
>  #include <linux/msi.h>
> +#include <linux/acpi_iort.h>
>  
>  #include "fsl-mc-private.h"
>  
> @@ -179,25 +180,31 @@ struct irq_domain *fsl_mc_msi_create_irq_domain(struct fwnode_handle *fwnode,
>  
>  struct irq_domain *fsl_mc_find_msi_domain(struct device *dev)
>  {
> -	struct irq_domain *msi_domain = NULL;
> +	struct device *root_dprc_dev;
> +	struct device *bus_dev;
> +	struct irq_domain *msi_domain;
>  	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
>  
> -	msi_domain = of_msi_map_get_device_domain(dev, mc_dev->icid,
> +	fsl_mc_get_root_dprc(dev, &root_dprc_dev);
> +	bus_dev = root_dprc_dev->parent;
> +
> +	if (bus_dev->of_node) {
> +		msi_domain = of_msi_map_get_device_domain(dev,
> +						  mc_dev->icid,
>  						  DOMAIN_BUS_FSL_MC_MSI);
>  
> -	/*
> -	 * if the msi-map property is missing assume that all the
> -	 * child containers inherit the domain from the parent
> -	 */
> -	if (!msi_domain) {
> -		struct device *root_dprc_dev;
> -		struct device *bus_dev;
> -
> -		fsl_mc_get_root_dprc(dev, &root_dprc_dev);
> -		bus_dev = root_dprc_dev->parent;
> -		msi_domain = of_msi_get_domain(bus_dev,
> -					       bus_dev->of_node,
> -					       DOMAIN_BUS_FSL_MC_MSI);
> +		/*
> +		 * if the msi-map property is missing assume that all the
> +		 * child containers inherit the domain from the parent
> +		 */
> +		if (!msi_domain)
> +
> +			msi_domain = of_msi_get_domain(bus_dev,
> +						bus_dev->of_node,
> +						DOMAIN_BUS_FSL_MC_MSI);
> +	} else {
> +		msi_domain = iort_get_device_domain(dev, mc_dev->icid,
> +						    DOMAIN_BUS_FSL_MC_MSI);
>  	}
>  
>  	return msi_domain;
> diff --git a/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c b/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
> index a5c8d577e424..b8b948fb6b2d 100644
> --- a/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
> +++ b/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
> @@ -7,6 +7,8 @@
>   *
>   */
>  
> +#include <linux/acpi.h>
> +#include <linux/acpi_iort.h>
>  #include <linux/of_device.h>
>  #include <linux/of_address.h>
>  #include <linux/irq.h>
> @@ -30,7 +32,8 @@ static u32 fsl_mc_msi_domain_get_msi_id(struct irq_domain *domain,
>  	u32 out_id;
>  
>  	of_node = irq_domain_get_of_node(domain);
> -	out_id = of_msi_map_id(&mc_dev->dev, of_node, mc_dev->icid);
> +	out_id = of_node ? of_msi_map_id(&mc_dev->dev, of_node, mc_dev->icid) :
> +			iort_msi_map_id(&mc_dev->dev, mc_dev->icid);
>  
>  	return out_id;
>  }
> @@ -79,7 +82,67 @@ static const struct of_device_id its_device_id[] = {
>  	{},
>  };
>  
> -static int __init its_fsl_mc_msi_init(void)
> +static int __init its_fsl_mc_msi_init_one(struct fwnode_handle *handle,
> +					  const char *name)
> +{
> +	struct irq_domain *parent;
> +	struct irq_domain *mc_msi_domain;
> +
> +	parent = irq_find_matching_fwnode(handle, DOMAIN_BUS_NEXUS);
> +	if (!parent || !msi_get_domain_info(parent)) {
> +		pr_err("%s: Unable to locate ITS domain\n", name);
> +		return -ENXIO;
> +	}
> +
> +	mc_msi_domain = fsl_mc_msi_create_irq_domain(handle,
> +						&its_fsl_mc_msi_domain_info,
> +						parent);
> +	if (!mc_msi_domain)
> +		pr_err("ACPIF: unable to create fsl-mc domain\n");
> +
> +	pr_info("fsl-mc MSI: domain created\n");
> +
> +	return 0;
> +}
> +
> +static int __init
> +its_fsl_mc_msi_parse_madt(union acpi_subtable_headers *header,
> +			  const unsigned long end)
> +{
> +	struct acpi_madt_generic_translator *its_entry;
> +	struct fwnode_handle *dom_handle;
> +	const char *node_name;
> +	int err = -ENXIO;
> +
> +	its_entry = (struct acpi_madt_generic_translator *)header;
> +	node_name = kasprintf(GFP_KERNEL, "ITS@0x%lx",
> +			      (long)its_entry->base_address);
> +
> +	dom_handle = iort_find_domain_token(its_entry->translation_id);
> +	if (!dom_handle) {
> +		pr_err("%s: Unable to locate ITS domain handle\n", node_name);
> +		goto out;
> +	}
> +
> +	err = its_fsl_mc_msi_init_one(dom_handle, node_name);
> +	if (!err)
> +		pr_info("fsl-mc MSI: %s domain created\n", node_name);
> +
> +out:
> +	kfree(node_name);
> +	return err;
> +}
> +
> +
> +static int __init its_fsl_mc_acpi_msi_init(void)
> +{
> +	acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_TRANSLATOR,
> +			      its_fsl_mc_msi_parse_madt, 0);
> +
> +	return 0;
> +}
> +
> +static int __init its_fsl_mc_of_msi_init(void)
>  {
>  	struct device_node *np;
>  	struct irq_domain *parent;
> @@ -113,4 +176,12 @@ static int __init its_fsl_mc_msi_init(void)
>  	return 0;
>  }
>  
> +static int __init its_fsl_mc_msi_init(void)
> +{
> +	its_fsl_mc_of_msi_init();
> +	its_fsl_mc_acpi_msi_init();
> +
> +	return 0;
> +}
> +
>  early_initcall(its_fsl_mc_msi_init);
> 
