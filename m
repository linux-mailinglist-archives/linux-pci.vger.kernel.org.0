Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4741C1AF946
	for <lists+linux-pci@lfdr.de>; Sun, 19 Apr 2020 12:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbgDSKOd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 19 Apr 2020 06:14:33 -0400
Received: from mail-vi1eur05on2062.outbound.protection.outlook.com ([40.107.21.62]:6219
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725914AbgDSKOc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 19 Apr 2020 06:14:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQO5JP/oQtHQZ5+GxiQyCZf4ZXVWthOKiBsi/+c5QlqM+caJIu7XUkvX1OYvsfl8Rx4vKXEpVCt+ZXOwbaxQAY79nm/Jy+iHf5ADB1Xgx8hZEwGWMARxaLpJ1w1qKgy/Lqj3T3ZyMF7f5BVsqlhK1SW2KMA6FwTYWmjTszMnKRs2OAEp5L8ybyZ2Efp7mn1WDpjtPjZbvG6jy2I5WKYvSko4OzzSpxo4O6H8BHzHTDi4FhCkrfntH/LbPbPn2u6LUJCmVYal7ziFyfWcUtFn2jrKJmK7x2oKrJbywwI9N2SmaDVyCd96htN6/KfgHZcQ1rQ10acdZYWHd4ecIj028w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+5caYKVKMOtTFkqQ4eJRiCCox+zLxPtoY+NV05oDT4=;
 b=oSdAIy+nBaEbMu3RAR+PnoQq5y/vfiXSlsj10jkuulmzaYubZmbCZkbFqspakbBp7Ey8WFpXvYbSO6PbObGHPoobUl/S9L999MU9cdy3hnxkjcPhiDRFWp6O1imD1wPoG7gt1FMr2oUZ6B5kENEgawQNuE+CBVUaMwvDSI5tR8QPC1AVoHJh5T8J3CyfZptM7E7+iw7RYuQ/x+QMGJTe/2f3aQVGd3JhAf7juYbA6rj0OtiS3pvDQGqOYXNm3/QPRI/xWkCY3oGaCwZHyLmDIlCO2Gs+84B8aItLB0irZ9Yt/BXaVg/xjf4OnSvDQ1y06xyXCS0TyRjTyOdN5rgfmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+5caYKVKMOtTFkqQ4eJRiCCox+zLxPtoY+NV05oDT4=;
 b=ZRntKzP41QAIK9g0ETt5LwUXQOM6Nd8dtXu8dyBv3cYWCLW3QKmRJgBPBO49dSS/cSlrwo37qIRm0r/NhP7gTTf3DyGAyCJheQ1dFUVeybxvuCzSu9yWoW9+jssm7umCLxqIu4HUhtJfpW8XAu/fdtC0RCXpBYGG5Ug4XH+9DJ0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=maxg@mellanox.com; 
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB5233.eurprd05.prod.outlook.com (2603:10a6:208:e9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Sun, 19 Apr
 2020 10:14:27 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4%5]) with mapi id 15.20.2921.027; Sun, 19 Apr 2020
 10:14:27 +0000
Subject: Re: [PATCH 1/2] powerpc/dma: Define map/unmap mmio resource callbacks
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-pci@vger.kernel.org, fbarrat@linux.ibm.com,
        clsoto@us.ibm.com, idanw@mellanox.com, aneela@mellanox.com,
        shlomin@mellanox.com
References: <20200416165725.206741-1-maxg@mellanox.com>
 <20200417065548.GB18880@lst.de>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <f2dd07d1-35ab-0568-828b-b8e3aad8e800@mellanox.com>
Date:   Sun, 19 Apr 2020 13:14:23 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200417065548.GB18880@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM3PR07CA0146.eurprd07.prod.outlook.com
 (2603:10a6:207:8::32) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (217.132.177.164) by AM3PR07CA0146.eurprd07.prod.outlook.com (2603:10a6:207:8::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.6 via Frontend Transport; Sun, 19 Apr 2020 10:14:26 +0000
X-Originating-IP: [217.132.177.164]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7e3c024c-0dbc-4f91-d28a-08d7e44a7108
X-MS-TrafficTypeDiagnostic: AM0PR05MB5233:|AM0PR05MB5233:|AM0PR05MB5233:
X-LD-Processed: a652971c-7d2e-4d9b-a6a4-d149256f461b,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB52332C5D1555EA8D1C766CBCB6D70@AM0PR05MB5233.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0378F1E47A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB5810.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(86362001)(6486002)(81156014)(6666004)(186003)(16526019)(8676002)(478600001)(66946007)(66556008)(66476007)(2616005)(4326008)(8936002)(6916009)(36756003)(31686004)(53546011)(5660300002)(2906002)(316002)(107886003)(956004)(16576012)(26005)(31696002)(52116002);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EZ0LwNlsVUeLqAPm+Q7sdWR8eGCs+LYKubsHoSyUX3mdDsO4pomILavzIXREmXupLwK1PHBPvoR/rXFHRlnrcrcIr5zUF+ho1u6qJzp4cBeXm33Knpr+6QuCKBFZsIyYU7YUM5w81aY+nkXZw67K9CFdhpsEGaUdLVQxDk454mPfg7LPE9eN90VB3cSG2BYelFsS0M5vrJ9/djdIdaDLI996Vf7gFruNEWt82q2AhYVLHr4ZxNdbz7RBh2J8FXViTs40TQ5yXJRMOCCUOA2Jx35OOzFL6qI8JQtaq0hlpbXWSI1ffYKQGE33xfM4TTDWPQdR0g3R8ETA/OesctdkbQSwFIfML6SCnv4YjbFs59uquUef4ruLrdLj6CVNCQH65nhV2txXYz3J4KcbFQlFFmT5WPxM0OIA6oSP9TXaqw6Z0/dMnVgtKaej1qn+25Mk
X-MS-Exchange-AntiSpam-MessageData: Vqp1TYwIw3eAM0ZM75McSl/lG/6xQUgC3Rp3A73fneCBfSYKDo7muxEl5IC7YuL99nt4yGwtWhlDDzo+0eH9ypndeUv5C5MGqIqSlplP6+WbeRmNchu9vcgUvPCIxhhNZR5vv0wvncORsJ36jFIbAs2WwTiPx2YLCKRLparL9zRZUUVMHkBRipLHW5QP5QQUs408oQUUc5x+xzHJzfsKhdB+F6RFO41e3X3SEtfqSzUsksMbNqmdlTHMWefRGKM2bFbhr8uchxmtrtF/D0nfa7pIysqqmH+s9mlAv7GoEQSg6/dMyMOhy2do2MohmM/a0SKyjjllkZMcN21BskaU+AcCkq600XjUksbnfZGhSBoAQeegcItMvYQkpyl0r2V5f6PAy9jV8I2rcVfA0cMI/8dNaQ344I9fBtkKnaSEBC0IvfifxGidcrp5ZcFf8L7pTnyeUV1PXQYRmZW1wze9Yu2o07WhqC9GMfz/UyJnt3c0FuszaYmynROtw/B3P1Rm1j+LC5OwACSi/qHAmJ1T8uywOzdz32s+6WoGx+tAWV61T0KzYmqej7+3NlNe699bSv3F3Q5LXnYewZTBsJFzYowONp7PvE+b5BqJgxNZkx0vbN3dZYZ6Uz2e3tL5DYJMOmG374rLqgdyUIsOXKVcQyuOxT+jH9GCTVzGt8PfuuglbiTE67mUwjM1+ei5ESXSjLJhkWRCPPldBD8bcKcucXIvdhoW+qBmxat2oqSiR9vKyShN4I8QymV5ya+4Bl4C+0dIuKnzzory/hEdknEDrJGpoftoP4dT0n2miWezB3tNbu3nmzgpier6ZCTHIZ4l
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e3c024c-0dbc-4f91-d28a-08d7e44a7108
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2020 10:14:27.3409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yUfQBXiSziRODIpkArO8pubtTK/l+fVVb+KEMxdYBFI9z9Ea4r8ZXOUhX6HEH4fdB1OMkcm57UcaXz+pKNF+7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5233
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 4/17/2020 9:55 AM, Christoph Hellwig wrote:
>>   		dma_direct_unmap_sg(dev, sglist, nelems, direction, attrs);
>>   }
>>   
>> +static dma_addr_t dma_iommu_map_resource(struct device *dev,
>> +					 phys_addr_t phys_addr, size_t size,
>> +					 enum dma_data_direction dir,
>> +					 unsigned long attrs)
>> +{
>> +	struct pci_dev *pdev = to_pci_dev(dev);
>> +	struct pci_controller *phb = pci_bus_to_host(pdev->bus);
>> +
>> +	if (dma_iommu_map_bypass(dev, attrs)) {
>> +		if (phb->controller_ops.dma_map_resource &&
>> +		    phb->controller_ops.dma_map_resource(pdev, phys_addr, size,
>> +							 dir))
>> +			return DMA_MAPPING_ERROR;
>> +		return dma_direct_map_resource(dev, phys_addr, size,
>> +					       dir, attrs);
>> +	}
>> +	return DMA_MAPPING_ERROR;
> Just a nitpick, but to the return errors early would be a much more
> logical flow.  Also if the callback just decides if the mapping is
> possible in bypass mode it should have that in the name:
>
> 	struct pci_controller_ops *ops = &phb->controller_ops;
>
> 	if (!dma_iommu_map_bypass(dev, attrs) ||
> 	    !ops->dma_can_direct_map_resource ||
> 	    !ops->dma_can_direct_map_resource(pdev, phys_addr, size, dir)
> 		return DMA_MAPPING_ERROR;
> 	return dma_direct_map_resource(dev, phys_addr, size, dir, attrs);

maybe call it dma_direct_map_resource/dma_direct_unmap_resource for 
symmetry ?

do you mean (small logic change):

         if (!dma_iommu_map_bypass(dev, attrs) ||
             !ops->dma_direct_map_resource ||
             ops->dma_direct_map_resource(pdev, phys_addr, size, dir))
                 return DMA_MAPPING_ERROR;

         return dma_direct_map_resource(dev, phys_addr, size, dir, attrs);


>
>> +	if (dma_iommu_map_bypass(dev, attrs)) {
>> +		if (phb->controller_ops.dma_unmap_resource)
>> +			phb->controller_ops.dma_unmap_resource(pdev, dma_handle,
>> +							size, dir);
>> +	}
> This can do a little early return as well, coupled with a WARN_ON_ONCE
> as we should never end up in the unmap path for a setup where the map didn't
> work.

how about:

         struct pci_controller_ops *ops = &phb->controller_ops;

         if (dma_iommu_map_bypass(dev, attrs) && 
ops->dma_direct_unmap_resource)
                 ops->dma_direct_unmap_resource(pdev, dma_handle, size, 
dir);


