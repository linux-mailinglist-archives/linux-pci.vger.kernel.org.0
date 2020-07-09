Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39BBD219E23
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jul 2020 12:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgGIKrT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jul 2020 06:47:19 -0400
Received: from mail-eopbgr70089.outbound.protection.outlook.com ([40.107.7.89]:6977
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726302AbgGIKrS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Jul 2020 06:47:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5SxVh9y/Zxe2en0yRk0SwDOZi8Amyb5c+e/eyepHrPiNeZfHFU9utibESESDHC8rj4OCPN6rDRLNujaqSCVSc4J4SjtRoyBl1qQP2AaQ7iS/IzNdzHmARTz1DG4zoTPcX0yBanMkaUkifdKDHM6AE2zzDD4Lq+ptSZyJh4toK0+u6UtP34b5Cv64QMPQXw61KRDEc6ydDYDQbJMKfKjIjbQc/incAmEn5i9fV4vGUe8GNyx+ZH49vOdgMeJx8418WG/YqjjnWSy8JREEvWLdTUzkmYcPTD6Ez8/zhdh7+U12h8uSCg7vKWFUjQXorv6Vi+ssb/DB+sjKKlgOQ62fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5abRccOqBeBzGfb0wRoFHjpqCFeYn7An+DkDd0gmeKQ=;
 b=Z1aSnUVcp0hIjGTfcvJBxwjAD3pk92ILJEia/38gEFb2Inv7a6hF8biobEnPR2vQPVqFAWBOqoe2INy3AMxpCOLAP3VnW3gDo+FaT2xtt+SMBcXCj8qZ6RdgbR3sAAUatjd2ZDPGsxiMkxJUvMlGhHa9WJ5WbMbDF3zLthzIjorP+YN/d6lcFesHm6Jj5qYrhuLWVMo18XPbSHlPKhbmzIGPqy7mYNHrmSC6fjOAStd90cJpwCsBlcKhUIct4yFnvh+b3uDthDplOP0FQ5ZSQ2A/n+LncASz+KWScyWAbxdPay6dej4NkfKbDhpyKIdJpbwu740bmt2BF5Imc93EAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5abRccOqBeBzGfb0wRoFHjpqCFeYn7An+DkDd0gmeKQ=;
 b=IXTg7lrwv5jjrCy2prfAXvJJ4lBKHVJ1iMHtuUQ05Qy4KWTGvFoHIT9/qV3Cijea3eYXZv3TdSWLQIl7woYr+kwxyW3bhO1wyCuwglvhIispfqjF+4TGXdWjlamm+5RiZZlaVXxzg2DE5dIvNw88K1cyuyJYdb2ElIwd2J7LukE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR0402MB2815.eurprd04.prod.outlook.com
 (2603:10a6:800:ae::16) by VI1PR0402MB3949.eurprd04.prod.outlook.com
 (2603:10a6:803:23::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Thu, 9 Jul
 2020 10:47:11 +0000
Received: from VI1PR0402MB2815.eurprd04.prod.outlook.com
 ([fe80::81fd:56b7:594b:59c0]) by VI1PR0402MB2815.eurprd04.prod.outlook.com
 ([fe80::81fd:56b7:594b:59c0%10]) with mapi id 15.20.3174.022; Thu, 9 Jul 2020
 10:47:11 +0000
Subject: Re: [EXT] Re: [PATCH v2 12/12] bus: fsl-mc: Add ACPI support for
 fsl-mc
To:     Makarand Pawagi <makarand.pawagi@nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
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
From:   Diana Craciun OSS <diana.craciun@oss.nxp.com>
Message-ID: <d41589da-c2f9-a750-f57a-25dccf51e69f@oss.nxp.com>
Date:   Thu, 9 Jul 2020 13:47:07 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <DB7PR04MB4986C63772CB47A2A827D028EB640@DB7PR04MB4986.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0008.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::18) To VI1PR0402MB2815.eurprd04.prod.outlook.com
 (2603:10a6:800:ae::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.11] (5.12.39.252) by AM0PR10CA0008.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend Transport; Thu, 9 Jul 2020 10:47:09 +0000
X-Originating-IP: [5.12.39.252]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6c522a54-d28b-4574-868b-08d823f56edc
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3949:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB3949CB4CCF536FE1AB268922BE640@VI1PR0402MB3949.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 04599F3534
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +LPB63C0Kg2Kfd6TMkT7bb427SMF0pxLxYd5zmZ+wyFN4Q4Y/HQ46ehgT6MLhhYwKUe2NfHUTiCegRAro8C4U8ykT+SeVSTSXmFDeIhxiVDXwW8MQdYC+wRjc+8rUvT0zMI1b/QJH9AQyQkuI9KIKfgJWf+caWkZoES7gDSKuZ891J4nPHxk+YZdz5QwSM9QM7P3jFo+vyBJHVCdpBQSFQ3F8kxR733TXWIEnc2EBzc/zDECCOq/QgevQCgQJqSEfwyaaRZWefBCo3SEAIJTJN2p4vvHuKP83GnLIyvNYKYSBidBJTLe2IINyPvGXA46KhO6qYf2BVLuvkcQXHM018o6HrRWsxxAXeDV55gN9ypz6vtS/JDrtxgQmExtakd9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB2815.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(52116002)(31696002)(8936002)(4326008)(66476007)(66556008)(31686004)(16576012)(110136005)(316002)(54906003)(2906002)(2616005)(7416002)(956004)(5660300002)(8676002)(86362001)(66946007)(478600001)(16526019)(186003)(6486002)(83380400001)(53546011)(26005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: FL62FDFtGsSjhN035FfcGJOFxk5DX1YroQXgwZjSNaIRxY1MLZ1bRgQNFvwSphtNlWhDZpu3uatuZvFxgpdfVHQ5uUDCj5If1RmKzWpNdTdkDTgtEIS5xLasCDhZAr9L9E9uNGPfIBP0y2lIoP0GO9N1yTWGWejf+yiU1DDEoxELWRLKR4DzS/Q3y9lUPpjcl0/PqfrqLTRfdU6YEGILWaAG6bHK8CwQJWiBsi4B2OqpM11GN9shoX6Fg9AYGYtbSaeouXQW1zD3JkW/nagbV6YAKbHdjmfxZJWnLLj44bYRvdqhDXimMU4MO3TZg6RrngMOIoJkRXDMUV4SljChpIo7hCrL6ZcCVjdM5YTWPxsM4ND4m6RC6Hl/gxggDyibUFO7KGVijMF8KLYZ6GtbKa+0VTDL0P8ypYFLocM1bYvgu0p3DCuWi/00fr5agZsVP6ZSP0vYa2nM9KO1nr/iily3bHWp1eHoEI/BZ1/kMww=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c522a54-d28b-4574-868b-08d823f56edc
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB2815.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2020 10:47:11.0159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nWls2nEpj/ieeHW5nrZswLv5p49Zbx39n0c6pjrw+zOeIykMF8R008quf6VhwvqejTvkr8Z1Jd/FAv2lIyz6dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3949
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/9/2020 1:37 PM, Makarand Pawagi wrote:
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
>>>>>>   drivers/bus/fsl-mc/fsl-mc-bus.c             | 73 ++++++++++++----
>>>>>>   drivers/bus/fsl-mc/fsl-mc-msi.c             | 37 +++++----
>>>>>>   drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c | 92
>>>>>> ++++++++++++++++-----
>>>>>>   3 files changed, 150 insertions(+), 52 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c
>>>>>> b/drivers/bus/fsl-mc/fsl-mc-bus.c index 824ff77bbe86..324d49d6df89
>>>>>> 100644
>>>>>> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
>>>>>> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
>>>>>> @@ -18,6 +18,8 @@
>>>>>>   #include <linux/bitops.h>
>>>>>>   #include <linux/msi.h>
>>>>>>   #include <linux/dma-mapping.h>
>>>>>> +#include <linux/acpi.h>
>>>>>> +#include <linux/iommu.h>
>>>>>>
>>>>>>   #include "fsl-mc-private.h"
>>>>>>
>>>>>> @@ -38,6 +40,7 @@ struct fsl_mc {
>>>>>>      struct fsl_mc_device *root_mc_bus_dev;
>>>>>>      u8 num_translation_ranges;
>>>>>>      struct fsl_mc_addr_translation_range *translation_ranges;
>>>>>> +   void *fsl_mc_regs;
>>>>>>   };
>>>>>>
>>>>>>   /**
>>>>>> @@ -56,6 +59,10 @@ struct fsl_mc_addr_translation_range {
>>>>>>      phys_addr_t start_phys_addr;
>>>>>>   };
>>>>>>
>>>>>> +#define FSL_MC_FAPR        0x28
>>>>>> +#define MC_FAPR_PL BIT(18)
>>>>>> +#define MC_FAPR_BMT        BIT(17)
>>>>>> +
>>>>>>   /**
>>>>>>    * fsl_mc_bus_match - device to driver matching callback
>>>>>>    * @dev: the fsl-mc device to match against @@ -124,7 +131,10 @@
>>>>>> static int fsl_mc_dma_configure(struct device *dev)
>>>>>>      while (dev_is_fsl_mc(dma_dev))
>>>>>>              dma_dev = dma_dev->parent;
>>>>>>
>>>>>> -   return of_dma_configure_id(dev, dma_dev->of_node, 0, &input_id);
>>>>>> +   if (dev_of_node(dma_dev))
>>>>>> +           return of_dma_configure_id(dev, dma_dev->of_node, 0,
>>>>>> + &input_id);
>>>>>> +
>>>>>> +   return acpi_dma_configure_id(dev, DEV_DMA_COHERENT, &input_id);
>>>>>>   }
>>>>>>
>>>>>>   static ssize_t modalias_show(struct device *dev, struct
>>>>>> device_attribute *attr, @@ -865,8 +875,11 @@ static int
>>>> fsl_mc_bus_probe(struct platform_device *pdev)
>>>>>>      struct fsl_mc_io *mc_io = NULL;
>>>>>>      int container_id;
>>>>>>      phys_addr_t mc_portal_phys_addr;
>>>>>> -   u32 mc_portal_size;
>>>>>> -   struct resource res;
>>>>>> +   u32 mc_portal_size, mc_stream_id;
>>>>>> +   struct resource *plat_res;
>>>>>> +
>>>>>> +   if (!iommu_present(&fsl_mc_bus_type))
>>>>>> +           return -EPROBE_DEFER;
>>>>>>
>>>>>>      mc = devm_kzalloc(&pdev->dev, sizeof(*mc), GFP_KERNEL);
>>>>>>      if (!mc)
>>>>>> @@ -874,19 +887,33 @@ static int fsl_mc_bus_probe(struct
>>>>>> platform_device *pdev)
>>>>>>
>>>>>>      platform_set_drvdata(pdev, mc);
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
>>>>>>      /*
>>>>>>       * Get physical address of MC portal for the root DPRC:
>>>>>>       */
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
>>>>>>      error = fsl_create_mc_io(&pdev->dev, mc_portal_phys_addr,
>>>>>>                               mc_portal_size, NULL,
>>>>>>                               FSL_MC_IO_ATOMIC_CONTEXT_PORTAL,
>>>>>> &mc_io); @@ -903,11 +930,13 @@ static int fsl_mc_bus_probe(struct
>>>> platform_device *pdev)
>>>>>>      dev_info(&pdev->dev, "MC firmware version: %u.%u.%u\n",
>>>>>>               mc_version.major, mc_version.minor,
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
>>>>>>      error = dprc_get_container_id(mc_io, 0, &container_id);
>>>>>>      if (error < 0) {
>>>>>> @@ -934,6 +963,7 @@ static int fsl_mc_bus_probe(struct
>>>>>> platform_device
>>>> *pdev)
>>>>>>              goto error_cleanup_mc_io;
>>>>>>
>>>>>>      mc->root_mc_bus_dev = mc_bus_dev;
>>>>>> +   mc_bus_dev->dev.fwnode = pdev->dev.fwnode;
>>>>> Makarand, this looks a bit weird. Is there really a reason for it?
>>>> Can you clarify please so that we can reach a conclusion on this matter ?
>>>>
>>> Laurentiu, can you clarify what exactly is the doubt here? Are you asking about
>> fwnode assignment from pdev to mc_bus_dev?
>> Yes. I remember that a while ago I tested without this fwnode assignment and
>> didn't encounter any issues. Maybe we can just drop it?
> Did you tested with PHY changes? Because this is needed for MAC driver, where it needs the mc bus node.

Maybe it worth a comment or maybe have it in a different patch?

Thanks,
Diana

>
>> ---
>> Best Regards, Laurentiu

