Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4537425C563
	for <lists+linux-pci@lfdr.de>; Thu,  3 Sep 2020 17:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgICP31 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Sep 2020 11:29:27 -0400
Received: from mail-dm6nam11on2045.outbound.protection.outlook.com ([40.107.223.45]:48480
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728446AbgICP3V (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Sep 2020 11:29:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UH8gixY8ll0iSqZchM/yoRttGPYVCmxS0qOKE4mvKCRAcB4vz8+VPsh7/vIS+ezmQIantCNA96blhUPHuVVLyKSSn1YatOJz7lqDgXteR13zApjC8NqxVf2OEhOWLWp7Awy3+5aWFJed4kbX6jI6ynaEYg+U2FInb7je7UR+hRp5heiGn3FWk/TbaMJqNh5VejVjfi9SEEcvZeQF9fhTmNxEHJLiUhTpMoFFV/0nh8ApVCmogHxgTATeqQIjZD5Cpvr92uRpR8UnZ1nho7DCAs6SfipKyulRWyu7fr0jPpsA3NK8wdF4XaaetllSDZkKhDzN1TxuNgGOyKEKvrNjow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXKBqi/TRMBjwJo9Y/0qZdemVzgnQ5f5xhJ8Wjf2C1w=;
 b=muHJXos4odfbptLgmn08w1Z/GuYicdsZi2fuvPT1set8WNSia3niHwaACjOhUue9t6YLDb2e6M5Ky5L/NuV3y7mJT8ORFxM/ewLSjNwh+WUZzhScYng2vsuLjzWnenUQRXYLeB08FO8laOeWSo7ImYgg5ewUNOIPVg5+h2D//Gux+omHxVnsrE9t7ygu20HbCSARcvYLdrAAB1gDTGtDak1RHhLaAHlteIhaRhs88arVh+O2jmmP1TjRGV1GydMv2ExKeztI6PMJBq3dfXypwNCpf4oURFz9yPuganG0BuALd4gFnHHtYBzlS31vwnbGHwzojhabI28LOHCqQqm8zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXKBqi/TRMBjwJo9Y/0qZdemVzgnQ5f5xhJ8Wjf2C1w=;
 b=lZNMKYIFGu9sOzh5dTBBkAfGnYlZ/qYPEfhtOEr2RN62gU/IouMSoJVUheRx3J6jKM0KX06pioApCllUxxfMGtJapqa0CewmATcJYaPndU9LvIAAiq9iUA+6AgmUZEonuS76lXogm+yvFHImydy26muwSA8glkrJxE9hKbIPCxg=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) by
 DM6PR12MB2812.namprd12.prod.outlook.com (2603:10b6:5:44::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.25; Thu, 3 Sep 2020 15:29:18 +0000
Received: from DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::60b8:886b:2c51:2983]) by DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::60b8:886b:2c51:2983%3]) with mapi id 15.20.3348.016; Thu, 3 Sep 2020
 15:29:18 +0000
Subject: Re: [PATCH v4 3/8] drm/amdgpu: Fix SMU error failure
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     amd-gfx@lists.freedesktop.org,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-pci@vger.kernel.org, alexander.deucher@amd.com,
        nirmodas@amd.com, Dennis.Li@amd.com, christian.koenig@amd.com,
        luben.tuikov@amd.com, bhelgaas@google.com
References: <20200902220550.GA271051@bjorn-Precision-5520>
From:   Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <ff9a3bf3-b035-8c89-c31f-91722d922a82@amd.com>
Date:   Thu, 3 Sep 2020 11:29:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <20200902220550.GA271051@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0033.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::46)
 To DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by YT1PR01CA0033.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16 via Frontend Transport; Thu, 3 Sep 2020 15:29:18 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f6a0c041-1582-403b-56dc-08d8501e1fb0
X-MS-TrafficTypeDiagnostic: DM6PR12MB2812:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2812621B2BC6F59CE8B26A8DEA2C0@DM6PR12MB2812.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cxwuWWWBX8+EXHk5A8oDqvy1B1CVBI/d8fECzraxLGvzULmgwjS3CCTmS3Q983o8Ap+i/HWXqHT2IolbaJeqp4sDDQHEs9ZFaqHz8zFVlHDcOA0mfqkeWt3LJcn2QxBEcR46H8vd/9RBbEI5KRYHGxroLiGRVIQFwYmnpvQ/oaNK7X4BenW17s7ReilQj2T+mH4kkTjfUPbJuKvXdOkfK6PEQ1NufH2NvvmNmoZYVkC3PkQKEQGABkkjdtLhW+t8yyqPyTHZeKD5TQ5MACHtmRXD96vfV4LxQQz9bk1v/GvxTbfM06H6bndntXbkmku/lYuYIYfMj9LXkYn9JXDW/mhvTZT/BzypJTsSY3jDpQeHUfzfD4yWpu7zVJL88CZb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4340.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(6916009)(956004)(2616005)(66556008)(52116002)(26005)(6486002)(53546011)(31696002)(66946007)(86362001)(66476007)(36756003)(8676002)(5660300002)(83380400001)(4326008)(16576012)(2906002)(8936002)(478600001)(186003)(316002)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: opyS+UR5PjYuoN2VTyXGNS9SjHcrvsGvjayVrV9z/6+SfccSWb9Y5zIUOL194o17Pxuef+o9ASG176T55zJI1mh+8pfTMVFcqICBFP0ElCCIRKX8j0oN2NsDTbVOd+jSDxD28ievUXKLhrebezMlatyjVbV3k5DGKnhxFDoMNo9AR+VMsaOw6BpMTQeqzSElXspT+iyFZhV7Wp6GgtkJmHc/lmTlXXKHvZ+Ftsayeu1lOqg2obb3+Go4XU9yawPl/+nwTW6ocNBrokeegCrU12lmC4uZLvK/g1lcPd7YDhFZqmGWSmIKKjJka53c8rI8HoFF18HyS6YwfKb9NJGSFLnj2LqwZ+uCBBA0MA9ylb89qUsDR0F0qCqkPpAIWRJ1W3kamd/GBrT56U3bmhoisWRjQnQ5DBjaOslAANwN/iLqx2TuubHsDVEhZtKaij5DghePLNH4rklLHnKi4kWD2VjfA5XpaAK8OD6qS5U17KKOrc8wYFYo807IZTkdEjuPni9aXFEcMuNRd90X+mm5jslXrxpUW+GRiebW66DOFMgt+pA3+yzYw2Gx2olCYEWoTYCqBcnVUvbOjpwfvNbksixHUKWZrWy++IidRXT+i1zR13vb3DICXKsiq+/rBmbXCVChRSKCOYP7WGyHIrWRUQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6a0c041-1582-403b-56dc-08d8501e1fb0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4340.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 15:29:18.6106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zw7PSepyjVRnU0KuwgIoyyICtrX9REhOXnEsjUNq3XgsEPspP6Sx8KQSA6U4tSQxdVX8PX7lcmSKLEhw4cHBIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2812
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 9/2/20 6:05 PM, Bjorn Helgaas wrote:
> On Wed, Sep 02, 2020 at 02:42:05PM -0400, Andrey Grodzovsky wrote:
>> Wait for HW/PSP initiated ASIC reset to complete before
>> starting the recovery operations.
>>
>> v2: Remove typo
>>
>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 22 ++++++++++++++++++++--
>>   1 file changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index e999f1f..412d07e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -4838,14 +4838,32 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
>>   {
>>   	struct drm_device *dev = pci_get_drvdata(pdev);
>>   	struct amdgpu_device *adev = drm_to_adev(dev);
>> -	int r;
>> +	int r, i;
>>   	bool vram_lost;
>> +	u32 memsize;
>>   
>>   	DRM_INFO("PCI error: slot reset callback!!\n");
>>   
>> +	/* wait for asic to come out of reset */
> I know it's totally OCD, but it is a minor speed bump to read "asic"
> here and "ASIC" in the commit log above and the new comment below.
>
>> +	msleep(500);
>> +
>>   	pci_restore_state(pdev);
>>   
>> -	adev->in_pci_err_recovery = true;
>> +	/* confirm  ASIC came out of reset */
>> +	for (i = 0; i < adev->usec_timeout; i++) {
>> +		memsize = amdgpu_asic_get_config_memsize(adev);
>> +
>> +		if (memsize != 0xffffffff)
> I guess this is a spot where you actually depend on an MMIO read
> returning 0xffffffff because adev->in_pci_err_recovery is false at
> this point, so amdgpu_mm_rreg() will actually *do* the MMIO read
> instead of returning 0.  Right?


Yes, i picked this form another place where they use it to confirm PCI confspace and
the BARs specifically are restored and active and so you can read back sane MMIO 
regs values.

Andrey


>
>> +			break;
>> +		udelay(1);
>> +	}
>> +	if (memsize == 0xffffffff) {
>> +		r = -ETIME;
>> +		goto out;
>> +	}
>> +
>> +	/* TODO Call amdgpu_pre_asic_reset instead */
>> +	adev->in_pci_err_recovery = true;	
>>   	r = amdgpu_device_ip_suspend(adev);
>>   	adev->in_pci_err_recovery = false;
>>   	if (r)
>> -- 
>> 2.7.4
>>
