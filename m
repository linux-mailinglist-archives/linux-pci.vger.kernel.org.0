Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D554219E11
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jul 2020 12:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgGIKj7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jul 2020 06:39:59 -0400
Received: from mail-eopbgr10050.outbound.protection.outlook.com ([40.107.1.50]:51403
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726315AbgGIKj7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Jul 2020 06:39:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cxy3HeYlil0ywqIgDYbqNgDVLIJ9W0w1r3F8saTK4iq1P5LQLqLRIZ8rr2lw0PtyDq56+dLZzPa1+Q59CFopogrs6EN8lT6NPd/OIzWHqn/9z5VJHPEh7GJ9LaVtlOLKC6VwBGohVoKUT5yMpLsnWSt1WG0ilG9jWQ3kwtbWDOhXjqi11nlfGlvDekKfnZgIDoXkzXj1IcpLACjFEegNnQXbLetmJrk7H8UJKBN9w4vumrz5coTdsUL8az/lNLKWS02sM5U1HmNJ3WX3TaACidI8xRP4zsaeAI2nesufn2YsbFlilCwgtpcgD1LB8aj5bPKqk2bL/74quSgLMsb2wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l73i1q0sGEK71+BuU2TDgGJb9Xum+lnorR4vNzlaJTo=;
 b=WtJG1cMsMN3oVHngQ1JGaoLYBw9XDEkress/XEOAKszCRKj+wt0aJCDgByDrzLUeG2hYB0UaNUdwgAo46qNqmo/GKqpXNCEOj0itmiQKXkeglQEcWlkzZAi7YT19M5wraO6MzTx3G13sekWGZDB5Cnk3kpABXhraIkK0Av/D2Z4hyXAcQRfwgHx+Z80B5BJrl7h98Y68ZfccHF907iFVZhXiKoKSZzJFK4C41gZAM0WrpTuKZq29j0c3LrTal8XJYbvTxscR/0IT/NdeCDzoVYVvWqohMyn4zadwHXUPFyLG2nXwnzYaxXqRvNmQNG7+m4PPZ35OXLnjZPJS9TWMxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l73i1q0sGEK71+BuU2TDgGJb9Xum+lnorR4vNzlaJTo=;
 b=VKdCd1Ns33HAacslZ8d8Gfboz9l8dR/9ZQjsj5k9fVzVKuzISS3OzmJTT59Uq8onmBQ021riFuBYiXpBODz0cOjt2L6LAkm5dHqSTjO3KnOaXpr78/vTgrFqWNY3ctcA7r/wy9eN1LpOApcwrNVICi7DVvUqmOxlHqKmvh40254=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VI1PR04MB7117.eurprd04.prod.outlook.com (2603:10a6:800:12f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Thu, 9 Jul
 2020 10:39:52 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::b97a:64f0:3ab5:d7fa]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::b97a:64f0:3ab5:d7fa%5]) with mapi id 15.20.3174.022; Thu, 9 Jul 2020
 10:39:52 +0000
Subject: Re: [EXT] Re: [PATCH v2 12/12] bus: fsl-mc: Add ACPI support for
 fsl-mc
To:     Makarand Pawagi <makarand.pawagi@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Diana Madalina Craciun (OSS)" <diana.craciun@oss.nxp.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
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
 <a7845603-9bc9-9099-dfc4-19b7bc4f4e44@nxp.com>
 <20200709091950.GA18149@e121166-lin.cambridge.arm.com>
 <DB7PR04MB4986D1A0BB7B685911DF4831EB640@DB7PR04MB4986.eurprd04.prod.outlook.com>
 <203372be-144c-54ba-d011-30d0746dd615@nxp.com>
 <DB7PR04MB4986C63772CB47A2A827D028EB640@DB7PR04MB4986.eurprd04.prod.outlook.com>
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
Message-ID: <a225239f-24f9-cceb-0b29-4071ab0de956@nxp.com>
Date:   Thu, 9 Jul 2020 13:39:43 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <DB7PR04MB4986C63772CB47A2A827D028EB640@DB7PR04MB4986.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR07CA0093.eurprd07.prod.outlook.com
 (2603:10a6:207:6::27) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.107] (86.120.184.194) by AM3PR07CA0093.eurprd07.prod.outlook.com (2603:10a6:207:6::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.14 via Frontend Transport; Thu, 9 Jul 2020 10:39:45 +0000
X-Originating-IP: [86.120.184.194]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5baca5af-4e5f-412f-dcd3-08d823f46984
X-MS-TrafficTypeDiagnostic: VI1PR04MB7117:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB71175399581E63812874084BEC640@VI1PR04MB7117.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mficoAVJOYcyqIHd+PP17syNar9VElt3/c5sl3dSeFFMimPHbDmHHbT7k7KnCNnBrwOrAAiMjDOBL7Q24i+d8TN4JPYbZ9jJNTf6i3Lz/kp4DjNKnFSHikIUQUNOJLCb0L8cAqoMh1/VlrGNN/uzyb3SqDZUc7OagaWou0oMhAWarYlT8Q4WF6ab6gcqQDBwPGQcsArPkDhuyyPF30MjOuMC+/hVtdZc8B5KgURyBjuyiG2hiAzCKU76P6cuV58YTtkDdkJSx3fUIftM7O2d0EHo9lfozDXZWyfm0iSJKrvuY3sV8PPM3SQb3sYnbl6fvMoHEtF/loukBCXN+lbYp2o/46HzN+EAe8SVzNEn7QaSN7BsPoriEby8IRj/q46P
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(8936002)(52116002)(186003)(8676002)(31686004)(2906002)(956004)(6486002)(26005)(2616005)(36756003)(478600001)(4326008)(16526019)(16576012)(83380400001)(7416002)(54906003)(53546011)(86362001)(110136005)(66556008)(66476007)(66946007)(44832011)(31696002)(5660300002)(316002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: CyEdX54H0CvXBMw9dzFbkPgulNup2cxZOMnwrzgoF1O8/CqpXY9JxW2oBiFZKGbf+K2vm6wiF1FvtWoyFuBUcikTgty31uju78Rubhn+U/v/2ArCsg+8F5WVIQhp43nDzKOYNpBLHzgZLiyuDBgkdnqJoZ6bagdzXxQQnuxdux1W0dxF5RKjb+K1yskacUkKzBGwG2M5RGEOL3nMV8M4eovdqaDZMNwFFU4oeiFD15dNRjHVq9jXTaZQ1woxvX5r9J1ltUP/iOuQycf0to25UyHTb+3T3sCjXmeEMmeqLmQ5B/ymiMIrRiSs7JCOKPBCuhJjqW9qiitMI6uat0DkWNXExSW/Paq93ZxocRmTX4/JCbhwJYihMKUmvvdr0a/UQSmP3uOZokeu15eZg+Sx62zz18dsASH3OiWTV9mAHaz6TZfnTSqI5CMM/O5XmTzYpWupAE7NiFb9PpE2u5imvOxItNjWgc2CKyAVR9nCeum8G6AGjZ7WX3/nzoXHZLQ2
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5baca5af-4e5f-412f-dcd3-08d823f46984
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2020 10:39:52.5130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E6C9HuNllOuuOafD8OfJ28xK89DIYYm5EpAanS0OF0rfRwEIguESeytwoPH2RiVrEYsjN170bx1O73kgzbQi2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7117
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 7/9/2020 1:37 PM, Makarand Pawagi wrote:
> 
> 
>> -----Original Message-----
>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>> Sent: Thursday, July 9, 2020 3:45 PM
>> To: Makarand Pawagi <makarand.pawagi@nxp.com>; Lorenzo Pieralisi
>> <lorenzo.pieralisi@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org; Diana Madalina Craciun (OSS)
>> <diana.craciun@oss.nxp.com>; iommu@lists.linux-foundation.org; linux-
>> acpi@vger.kernel.org; devicetree@vger.kernel.org; linux-pci@vger.kernel.org;
>> Rob Herring <robh+dt@kernel.org>; Rafael J. Wysocki <rjw@rjwysocki.net>;
>> Joerg Roedel <joro@8bytes.org>; Hanjun Guo <guohanjun@huawei.com>; Bjorn
>> Helgaas <bhelgaas@google.com>; Sudeep Holla <sudeep.holla@arm.com>;
>> Robin Murphy <robin.murphy@arm.com>; Catalin Marinas
>> <catalin.marinas@arm.com>; Will Deacon <will@kernel.org>; Marc Zyngier
>> <maz@kernel.org>
>> Subject: Re: [EXT] Re: [PATCH v2 12/12] bus: fsl-mc: Add ACPI support for fsl-mc
>>
>>
>>
>> On 7/9/2020 12:26 PM, Makarand Pawagi wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>>> Sent: Thursday, July 9, 2020 2:50 PM
>>>> To: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>>> Cc: linux-arm-kernel@lists.infradead.org; Makarand Pawagi
>>>> <makarand.pawagi@nxp.com>; Diana Madalina Craciun (OSS)
>>>> <diana.craciun@oss.nxp.com>; iommu@lists.linux-foundation.org; linux-
>>>> acpi@vger.kernel.org; devicetree@vger.kernel.org;
>>>> linux-pci@vger.kernel.org; Rob Herring <robh+dt@kernel.org>; Rafael
>>>> J. Wysocki <rjw@rjwysocki.net>; Joerg Roedel <joro@8bytes.org>;
>>>> Hanjun Guo <guohanjun@huawei.com>; Bjorn Helgaas
>>>> <bhelgaas@google.com>; Sudeep Holla <sudeep.holla@arm.com>; Robin
>>>> Murphy <robin.murphy@arm.com>; Catalin Marinas
>>>> <catalin.marinas@arm.com>; Will Deacon <will@kernel.org>; Marc
>>>> Zyngier <maz@kernel.org>
>>>> Subject: [EXT] Re: [PATCH v2 12/12] bus: fsl-mc: Add ACPI support for
>>>> fsl-mc
>>>>
>>>> Caution: EXT Email
>>>>
>>>> On Wed, Jul 01, 2020 at 07:55:28PM +0300, Laurentiu Tudor wrote:
>>>>>
>>>>>
>>>>> On 6/19/2020 11:20 AM, Lorenzo Pieralisi wrote:
>>>>>> From: Makarand Pawagi <makarand.pawagi@nxp.com>
>>>>>>
>>>>>> Add ACPI support in the fsl-mc driver. Driver parses MC DSDT table
>>>>>> to extract memory and other resources.
>>>>>>
>>>>>> Interrupt (GIC ITS) information is extracted from the MADT table by
>>>>>> drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c.
>>>>>>
>>>>>> IORT table is parsed to configure DMA.
>>>>>>
>>>>>> Signed-off-by: Makarand Pawagi <makarand.pawagi@nxp.com>
>>>>>> Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
>>>>>> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>>>>> ---
>>>>>>  drivers/bus/fsl-mc/fsl-mc-bus.c             | 73 ++++++++++++----
>>>>>>  drivers/bus/fsl-mc/fsl-mc-msi.c             | 37 +++++----
>>>>>>  drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c | 92
>>>>>> ++++++++++++++++-----
>>>>>>  3 files changed, 150 insertions(+), 52 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c
>>>>>> b/drivers/bus/fsl-mc/fsl-mc-bus.c index 824ff77bbe86..324d49d6df89
>>>>>> 100644
>>>>>> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
>>>>>> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
>>>>>> @@ -18,6 +18,8 @@
>>>>>>  #include <linux/bitops.h>
>>>>>>  #include <linux/msi.h>
>>>>>>  #include <linux/dma-mapping.h>
>>>>>> +#include <linux/acpi.h>
>>>>>> +#include <linux/iommu.h>
>>>>>>
>>>>>>  #include "fsl-mc-private.h"
>>>>>>
>>>>>> @@ -38,6 +40,7 @@ struct fsl_mc {
>>>>>>     struct fsl_mc_device *root_mc_bus_dev;
>>>>>>     u8 num_translation_ranges;
>>>>>>     struct fsl_mc_addr_translation_range *translation_ranges;
>>>>>> +   void *fsl_mc_regs;
>>>>>>  };
>>>>>>
>>>>>>  /**
>>>>>> @@ -56,6 +59,10 @@ struct fsl_mc_addr_translation_range {
>>>>>>     phys_addr_t start_phys_addr;
>>>>>>  };
>>>>>>
>>>>>> +#define FSL_MC_FAPR        0x28
>>>>>> +#define MC_FAPR_PL BIT(18)
>>>>>> +#define MC_FAPR_BMT        BIT(17)
>>>>>> +
>>>>>>  /**
>>>>>>   * fsl_mc_bus_match - device to driver matching callback
>>>>>>   * @dev: the fsl-mc device to match against @@ -124,7 +131,10 @@
>>>>>> static int fsl_mc_dma_configure(struct device *dev)
>>>>>>     while (dev_is_fsl_mc(dma_dev))
>>>>>>             dma_dev = dma_dev->parent;
>>>>>>
>>>>>> -   return of_dma_configure_id(dev, dma_dev->of_node, 0, &input_id);
>>>>>> +   if (dev_of_node(dma_dev))
>>>>>> +           return of_dma_configure_id(dev, dma_dev->of_node, 0,
>>>>>> + &input_id);
>>>>>> +
>>>>>> +   return acpi_dma_configure_id(dev, DEV_DMA_COHERENT, &input_id);
>>>>>>  }
>>>>>>
>>>>>>  static ssize_t modalias_show(struct device *dev, struct
>>>>>> device_attribute *attr, @@ -865,8 +875,11 @@ static int
>>>> fsl_mc_bus_probe(struct platform_device *pdev)
>>>>>>     struct fsl_mc_io *mc_io = NULL;
>>>>>>     int container_id;
>>>>>>     phys_addr_t mc_portal_phys_addr;
>>>>>> -   u32 mc_portal_size;
>>>>>> -   struct resource res;
>>>>>> +   u32 mc_portal_size, mc_stream_id;
>>>>>> +   struct resource *plat_res;
>>>>>> +
>>>>>> +   if (!iommu_present(&fsl_mc_bus_type))
>>>>>> +           return -EPROBE_DEFER;
>>>>>>
>>>>>>     mc = devm_kzalloc(&pdev->dev, sizeof(*mc), GFP_KERNEL);
>>>>>>     if (!mc)
>>>>>> @@ -874,19 +887,33 @@ static int fsl_mc_bus_probe(struct
>>>>>> platform_device *pdev)
>>>>>>
>>>>>>     platform_set_drvdata(pdev, mc);
>>>>>>
>>>>>> +   plat_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>>>>>> +   mc->fsl_mc_regs = devm_ioremap_resource(&pdev->dev, plat_res);
>>>>>> +   if (IS_ERR(mc->fsl_mc_regs))
>>>>>> +           return PTR_ERR(mc->fsl_mc_regs);
>>>>>> +
>>>>>> +   if (IS_ENABLED(CONFIG_ACPI) && !dev_of_node(&pdev->dev)) {
>>>>>> +           mc_stream_id = readl(mc->fsl_mc_regs + FSL_MC_FAPR);
>>>>>> +           /*
>>>>>> +            * HW ORs the PL and BMT bit, places the result in bit 15 of
>>>>>> +            * the StreamID and ORs in the ICID. Calculate it accordingly.
>>>>>> +            */
>>>>>> +           mc_stream_id = (mc_stream_id & 0xffff) |
>>>>>> +                           ((mc_stream_id & (MC_FAPR_PL | MC_FAPR_BMT)) ?
>>>>>> +                                   0x4000 : 0);
>>>>>> +           error = acpi_dma_configure_id(&pdev->dev, DEV_DMA_COHERENT,
>>>>>> +                                         &mc_stream_id);
>>>>>> +           if (error)
>>>>>> +                   dev_warn(&pdev->dev, "failed to configure dma: %d.\n",
>>>>>> +                            error);
>>>>>> +   }
>>>>>> +
>>>>>>     /*
>>>>>>      * Get physical address of MC portal for the root DPRC:
>>>>>>      */
>>>>>> -   error = of_address_to_resource(pdev->dev.of_node, 0, &res);
>>>>>> -   if (error < 0) {
>>>>>> -           dev_err(&pdev->dev,
>>>>>> -                   "of_address_to_resource() failed for %pOF\n",
>>>>>> -                   pdev->dev.of_node);
>>>>>> -           return error;
>>>>>> -   }
>>>>>> -
>>>>>> -   mc_portal_phys_addr = res.start;
>>>>>> -   mc_portal_size = resource_size(&res);
>>>>>> +   plat_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>>>> +   mc_portal_phys_addr = plat_res->start;
>>>>>> +   mc_portal_size = resource_size(plat_res);
>>>>>>     error = fsl_create_mc_io(&pdev->dev, mc_portal_phys_addr,
>>>>>>                              mc_portal_size, NULL,
>>>>>>                              FSL_MC_IO_ATOMIC_CONTEXT_PORTAL,
>>>>>> &mc_io); @@ -903,11 +930,13 @@ static int fsl_mc_bus_probe(struct
>>>> platform_device *pdev)
>>>>>>     dev_info(&pdev->dev, "MC firmware version: %u.%u.%u\n",
>>>>>>              mc_version.major, mc_version.minor,
>>>>>> mc_version.revision);
>>>>>>
>>>>>> -   error = get_mc_addr_translation_ranges(&pdev->dev,
>>>>>> -                                          &mc->translation_ranges,
>>>>>> -                                          &mc->num_translation_ranges);
>>>>>> -   if (error < 0)
>>>>>> -           goto error_cleanup_mc_io;
>>>>>> +   if (dev_of_node(&pdev->dev)) {
>>>>>> +           error = get_mc_addr_translation_ranges(&pdev->dev,
>>>>>> +                                           &mc->translation_ranges,
>>>>>> +                                           &mc->num_translation_ranges);
>>>>>> +           if (error < 0)
>>>>>> +                   goto error_cleanup_mc_io;
>>>>>> +   }
>>>>>>
>>>>>>     error = dprc_get_container_id(mc_io, 0, &container_id);
>>>>>>     if (error < 0) {
>>>>>> @@ -934,6 +963,7 @@ static int fsl_mc_bus_probe(struct
>>>>>> platform_device
>>>> *pdev)
>>>>>>             goto error_cleanup_mc_io;
>>>>>>
>>>>>>     mc->root_mc_bus_dev = mc_bus_dev;
>>>>>> +   mc_bus_dev->dev.fwnode = pdev->dev.fwnode;
>>>>>
>>>>> Makarand, this looks a bit weird. Is there really a reason for it?
>>>>
>>>> Can you clarify please so that we can reach a conclusion on this matter ?
>>>>
>>> Laurentiu, can you clarify what exactly is the doubt here? Are you asking about
>> fwnode assignment from pdev to mc_bus_dev?
>>>
>>
>> Yes. I remember that a while ago I tested without this fwnode assignment and
>> didn't encounter any issues. Maybe we can just drop it?
> 
> Did you tested with PHY changes? Because this is needed for MAC driver, where it needs the mc bus node.
> 

Good point, no i haven't. Then I'm ok with leaving it for the time being.

---
Best Regards, Laurentiu
