Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B61B5372E6F
	for <lists+linux-pci@lfdr.de>; Tue,  4 May 2021 19:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhEDRGZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 May 2021 13:06:25 -0400
Received: from mail-bn8nam11on2041.outbound.protection.outlook.com ([40.107.236.41]:28704
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230217AbhEDRGZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 May 2021 13:06:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPjX2xqkPKjnoKGdXi8PXcOTGoTO1hkNCGJvfcls/T2lfLd94Ao2wI3BUVyxD+pACaZKxccyDWt2oecSpayeajZQ1j9FyOdnuO97ZnncPJUMgchB35xWT1Uw2rB2t2Rlp6Eh5hMu04qNLKgZEpz5/LmfdqqTaoSWCBeex6aqKCk/GvIWPqx+dFkQalenThc0ksIQBM0YGV6ivWhxacodQ8GA8wHwGfIEZkDPxK6pli0EC6PFG1GC2nwkDJUJ4fGon99l0DNCmqNEyhKu09PlPO2/h01fOZe5mDcsVwRxmmuqNbWxt97sUpXiO0vCRKN5qL+31W5Phjj4NJCKUkF6TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pof0tHrrziOaU45Fc+U1bGeEfvdCc6UKnAlPAR26MkI=;
 b=iU6hiP0LaIf4XJr7PAmMt3FqZifLZCSPWGdfEGNwg6RQsTcCyNXFTH5OcFzzFFahOPSMaSXFxddhpybscIed40PEAB2ZGcTJdQt9PQHyD+SxkcSS262rzEoHNBK3VisbwVA35q8BOUQ51NR9HxPQR6Run/jBqWPjwvAm/kyPJtxlO5OW1cO3WsIs2x+3qhkv/0fi6lFwKk43AkstIYuv28lDxeJe7pnpDQ1hXLQt81YE7j6XbGcwuXxhnVFZbd9Iekj3v4IGE+8g+XmwHW4CZ2gMJD8YHX38ZNXmMorzj1jq/zmpHjwQnVBPv98XHQQF+w3QySdROfAhoncK7hRNtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pof0tHrrziOaU45Fc+U1bGeEfvdCc6UKnAlPAR26MkI=;
 b=5Y002uQMIbCtesXh9JEVqj4tpN3Eh8MTAxez3QN3+9W63YqkBMNxIa+wqFe1Bqwm+PTFJV2H0rOFu2RrXiAx0PiwoXPV+FRMEvdII5QjhrKbBr+jgqFZexfYz3lFdMSHmwOc7IZC4rELFJDXx1nIzzvVxtZkBqZj2LO5ousfprs=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5291.namprd12.prod.outlook.com (2603:10b6:408:104::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Tue, 4 May
 2021 17:05:28 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4087.039; Tue, 4 May 2021
 17:05:28 +0000
Subject: Re: [PATCH v5 06/27] drm/amdgpu: Handle IOMMU enabled case.
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-pci@vger.kernel.org, ckoenig.leichtzumerken@gmail.com,
        daniel.vetter@ffwll.ch, Harry.Wentland@amd.com
Cc:     ppaalanen@gmail.com, Alexander.Deucher@amd.com,
        gregkh@linuxfoundation.org, helgaas@kernel.org
References: <20210428151207.1212258-1-andrey.grodzovsky@amd.com>
 <20210428151207.1212258-7-andrey.grodzovsky@amd.com>
From:   Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <4f752f79-2541-d62d-5279-17992e4161d7@amd.com>
Date:   Tue, 4 May 2021 13:05:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210428151207.1212258-7-andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [142.116.138.207]
X-ClientProxiedBy: YTOPR0101CA0013.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::26) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.138.207) by YTOPR0101CA0013.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.37 via Frontend Transport; Tue, 4 May 2021 17:05:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae1cd809-782c-42e7-cc4b-08d90f1ed0f9
X-MS-TrafficTypeDiagnostic: BN9PR12MB5291:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB52916EBA4F8EE7555DCE1B6A925A9@BN9PR12MB5291.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yxqDwwfjL1PJl2yFpd2k02ALEAW70lSgT0k8vlWpleRl40J5iQjLPlvkiyPX9JZfX+LJHc/mHY0p5hqxtDgyfKZEubctdaM+6iYjqDUuBpkKLWoEUkNsfRCYzCK0ULlBYvgU0MMf/B6NWlL2wkhLrXnvnebj7yTMABpGnVxp2koRRyzh4QNHCz00tphEBlzMriYm1EMiqgl+YHqVW+EeKcr1X7nOYs4juz1Ovj0gEX1LjpMasi+imhJn4onhD6QpYp/zr8ozW5zEkR+kk+WEPNEUhQ4uyoR26CipsnDthIn2tu2zL1PFJlDLMW+1+FYYBJAcKtalbOk8It7VRHrAoy+daHE2u8Xlj3+gJfrEXoCHG/V5E1b509dIlvgtM1Hf+eVe03KhSQhbCw9WKlTTUB0FrXv705oy4sdhLUagC/iGCd4onaHNg5GvqYmSVKFploH37yHpxPfzpuu3ju7yBElJEVECuKIslOPkxY3WPpJDcRlhClHVEpy72ZTXNMdJ1AnO7xztQC9vD5fIjjxibLC+W/EExPTvLwmSk6AqBda6UN/scKm6M5y1NkCrNxO4j9UBlpmmAFeZOW5Q/apX948DSRvChImCRmOqh0ZhzYGszDSCzKEVDFL8uea8LyyB6hfFMLcFVJSLV1Ax0ognR9qIoCEkalKXBJAdrWnhgSWJvdE5MU04JOHf+hJ+e/ME
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5129.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(66476007)(66556008)(2906002)(6636002)(36756003)(4326008)(44832011)(5660300002)(30864003)(66946007)(31686004)(478600001)(8676002)(86362001)(16526019)(2616005)(956004)(186003)(8936002)(26005)(16576012)(31696002)(83380400001)(6486002)(316002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VitWWjN0eE5ZYW9LN2ltUDJONlpPUGNYZTZaSTA0aGR6aExzekhLcnUwK282?=
 =?utf-8?B?em12b3I2VUwyMSs3Ylk5Z0E5LzBteVVlbFkyY2FRcUVMdzdWeEpNSG8vclNp?=
 =?utf-8?B?NTZNVzlQV1JkQXZ0N2MyVUlvKzVmNktEMlZNNW1kcW5LakZ2WllNK2NybVJZ?=
 =?utf-8?B?Yk5BUm9Ocy80b0Z0Rmd2UGtVaHlpTXYxZkNrdis5L0liNXYvaTh3R0R6dHRm?=
 =?utf-8?B?V3cvV2N6S3lIdXRwc3VDTGM0L29SV2daSFdMTXQ5UXgxRDVLRHYzMzVLQW9K?=
 =?utf-8?B?dUUvc3hMRTQwRG1KdFg3anUxaU5MYlRrdmVReTc0SXBzblA3bUdqOXRXVHdQ?=
 =?utf-8?B?cGtBZ0I3UFRnMEMzVXM4UWpPdlE5MFVzNm9hV2I0cVVFT3g3dkZ4cGF2ZXow?=
 =?utf-8?B?cEx4QkFrcFFJYVY4SnpVTGdSSVBXeXFnSUZUeVR6NFN4T3MzeGFRaFFOTE1m?=
 =?utf-8?B?TDFVaTI2N0VKSStOVXJXcEVuVGREdlorUEZkN1VzMWcwTFhWTzlSZEZwcG05?=
 =?utf-8?B?eVVzMlAvMnpMUksyWk1IRzVneVZPN01VSmRaTUhGYW4wVUdNY3lzaXdObThm?=
 =?utf-8?B?ZDZtTnIweW1ndVA5N1gwUVNPRFhuQjMyWHdrWWtyNXNZTGdLL1poMlg2V2dG?=
 =?utf-8?B?TWkzd3BZeDUzYjBKU29tYmZGalZxRzlURDVaajRaeGR2YW1wdkFBQkt1bVlo?=
 =?utf-8?B?V2JyYlFITDh1R0dPU2E2MWRMOW9ndy8wc01keDlSUmNnbmRRRFB0S0svU2pn?=
 =?utf-8?B?cGNENC9kL0VVemhiTkdhQ2tJdW1USFZmb0NzSjQxWWFHQzBaQVVWdkVpaWRB?=
 =?utf-8?B?aGk3OUtCSEFMUHZBWEVwOWxuck1aOEFlVXVaWlRsWkxzN1orY3Y0YVdBRk55?=
 =?utf-8?B?SE0zbHhVNUpjK0VKS3R5WDlic0VKS0xpSnQyMVVReGJXZ1RRZkpDTFR2ZWNk?=
 =?utf-8?B?cnZqSktuY09NdEI1UE81cmF4V2FmZXZ3Ny85a0NsQXNYdFgvK3hQdGJzdUIv?=
 =?utf-8?B?d2FNbklyRUJMcmkxVy9lMitsMHFsM1BtVndFc2hUVmdFVzRKcWN0MVd5YUpy?=
 =?utf-8?B?Y2pYNkRBSUVvR0RLd2VvOUNkRDhIQnVGWU5KcDQzVjhBbGl2RVFQZTFFakZY?=
 =?utf-8?B?ZlpNNmVmTWFZY1dYb2IvMXNsTy9LVE92OGozOHpCL2RUcFdjcmQzVVFKa1h1?=
 =?utf-8?B?VVo5Y3pMV2tPYVlmSzFGeGNyMkl2WEFCeDh1OFFLejBLZ2YwM1ZWekp1eklD?=
 =?utf-8?B?VjcwdmVMS25NL3VtaGc3ODRmRkRVMHRuamdtQi9ITURPa1o4LzQ0cEd1cXZN?=
 =?utf-8?B?bVBYNWwzeXhaTU14NXU2eTZ2WGtHWWdFQUF5K3JKSkdRU0hTUkY5ZkhHOFZm?=
 =?utf-8?B?UElGcXVmN2VpQUF0dllHU3FEWGxobnRFS2FYZ3AzRFcwOE5SVXcvd0ZiTHpr?=
 =?utf-8?B?a1hSTHlvVEFNS0J1MlZzNE9YRkFuRUk4TWZTczVSWURHRVJtcmx5TENYUy9Q?=
 =?utf-8?B?YzUwLzlZbWhQYjVyYzVwaVFORmhUWWJUbUdmSHpubW5NTU5qclZOQ2QvOUVV?=
 =?utf-8?B?Q2FIdWhDOUMzNzBmMWpzS1c5Mk9SL3ArRVp6TDlDM0tJSGhMVTd3d3JicVJq?=
 =?utf-8?B?TzBZNFB6VjJsT0MyOHJUT3RVMUx5SDFON1NpT1I3RkVncDZBYytQdWJ6cHY3?=
 =?utf-8?B?VSt5eDlkR3FOTHpBc1lzSnZ1d0ZmYmpReHpMWi9qNU5yVkRGQmhtUVo1T0Z3?=
 =?utf-8?Q?o/KR81Gm8Ucp1fZS+mX8lw4P3z4seiPoS9pzCjo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1cd809-782c-42e7-cc4b-08d90f1ed0f9
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 17:05:28.1164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lL99jaj52rfX5Gws1b0YVyiz/nFSn+/tQv8UMunbcmzs2KJ9PPgRiKIU4DayBOSr4Npnvk4nD8ieb8dT22Fb+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5291
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Am 2021-04-28 um 11:11 a.m. schrieb Andrey Grodzovsky:
> Handle all DMA IOMMU gropup related dependencies before the
> group is removed.
>
> v5: Drop IOMMU notifier and switch to lockless call to ttm_tt_unpopulate
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 31 ++++++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c   |  3 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h   |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c    |  9 +++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 13 ++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  2 ++
>  drivers/gpu/drm/amd/amdgpu/cik_ih.c        |  1 -
>  drivers/gpu/drm/amd/amdgpu/cz_ih.c         |  1 -
>  drivers/gpu/drm/amd/amdgpu/iceland_ih.c    |  1 -
>  drivers/gpu/drm/amd/amdgpu/navi10_ih.c     |  3 ---
>  drivers/gpu/drm/amd/amdgpu/si_ih.c         |  1 -
>  drivers/gpu/drm/amd/amdgpu/tonga_ih.c      |  1 -
>  drivers/gpu/drm/amd/amdgpu/vega10_ih.c     |  3 ---
>  14 files changed, 56 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index fddb82897e5d..30a24db5f4d1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1054,6 +1054,8 @@ struct amdgpu_device {
>  
>  	bool                            in_pci_err_recovery;
>  	struct pci_saved_state          *pci_state;
> +
> +	struct list_head                device_bo_list;
>  };
>  
>  static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 46d646c40338..91594ddc2459 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -70,6 +70,7 @@
>  #include <drm/task_barrier.h>
>  #include <linux/pm_runtime.h>
>  
> +
>  MODULE_FIRMWARE("amdgpu/vega10_gpu_info.bin");
>  MODULE_FIRMWARE("amdgpu/vega12_gpu_info.bin");
>  MODULE_FIRMWARE("amdgpu/raven_gpu_info.bin");
> @@ -3211,7 +3212,6 @@ static const struct attribute *amdgpu_dev_attributes[] = {
>  	NULL
>  };
>  
> -
>  /**
>   * amdgpu_device_init - initialize the driver
>   *
> @@ -3316,6 +3316,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  
>  	INIT_WORK(&adev->xgmi_reset_work, amdgpu_device_xgmi_reset_func);
>  
> +	INIT_LIST_HEAD(&adev->device_bo_list);
> +
>  	adev->gfx.gfx_off_req_count = 1;
>  	adev->pm.ac_power = power_supply_is_system_supplied() > 0;
>  
> @@ -3601,6 +3603,28 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  	return r;
>  }
>  
> +static void amdgpu_clear_dma_mappings(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_bo *bo = NULL;
> +
> +	/*
> +	 * Unmaps all DMA mappings before device will be removed from it's
> +	 * IOMMU group otherwise in case of IOMMU enabled system a crash
> +	 * will happen.
> +	 */
> +
> +	spin_lock(&adev->mman.bdev.lru_lock);
> +	while (!list_empty(&adev->device_bo_list)) {
> +		bo = list_first_entry(&adev->device_bo_list, struct amdgpu_bo, bo);
> +		list_del_init(&bo->bo);
> +		spin_unlock(&adev->mman.bdev.lru_lock);
> +		if (bo->tbo.ttm)
> +			ttm_tt_unpopulate(bo->tbo.bdev, bo->tbo.ttm);

I have a patch pending (reviewed by Christian) that moves the
dma-unmapping to amdgpu_ttm_backend_unbind. With that patch,
ttm_tt_unpopulate would no longer be the right way to remove the DMA
mapping.

Maybe I'd need to add a check in ttm_tt_unpopulate to call
backend_unbind first, if necessary. Or is there some other mechanism
that moves the BO to the CPU domain before unpopulating it?

Regards,
  Felix


> +		spin_lock(&adev->mman.bdev.lru_lock);
> +	}
> +	spin_unlock(&adev->mman.bdev.lru_lock);
> +}
> +
>  /**
>   * amdgpu_device_fini - tear down the driver
>   *
> @@ -3639,12 +3663,15 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>  		amdgpu_ucode_sysfs_fini(adev);
>  	sysfs_remove_files(&adev->dev->kobj, amdgpu_dev_attributes);
>  
> -
>  	amdgpu_fbdev_fini(adev);
>  
>  	amdgpu_irq_fini_hw(adev);
>  
>  	amdgpu_device_ip_fini_early(adev);
> +
> +	amdgpu_clear_dma_mappings(adev);
> +
> +	amdgpu_gart_dummy_page_fini(adev);
>  }
>  
>  void amdgpu_device_fini_sw(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> index fde2d899b2c4..49cdcaf8512d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> @@ -92,7 +92,7 @@ static int amdgpu_gart_dummy_page_init(struct amdgpu_device *adev)
>   *
>   * Frees the dummy page used by the driver (all asics).
>   */
> -static void amdgpu_gart_dummy_page_fini(struct amdgpu_device *adev)
> +void amdgpu_gart_dummy_page_fini(struct amdgpu_device *adev)
>  {
>  	if (!adev->dummy_page_addr)
>  		return;
> @@ -397,5 +397,4 @@ void amdgpu_gart_fini(struct amdgpu_device *adev)
>  	vfree(adev->gart.pages);
>  	adev->gart.pages = NULL;
>  #endif
> -	amdgpu_gart_dummy_page_fini(adev);
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
> index afa2e2877d87..5678d9c105ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
> @@ -61,6 +61,7 @@ int amdgpu_gart_table_vram_pin(struct amdgpu_device *adev);
>  void amdgpu_gart_table_vram_unpin(struct amdgpu_device *adev);
>  int amdgpu_gart_init(struct amdgpu_device *adev);
>  void amdgpu_gart_fini(struct amdgpu_device *adev);
> +void amdgpu_gart_dummy_page_fini(struct amdgpu_device *adev);
>  int amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
>  		       int pages);
>  int amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index 63e815c27585..a922154953a7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -326,6 +326,15 @@ void amdgpu_irq_fini_hw(struct amdgpu_device *adev)
>  		if (!amdgpu_device_has_dc_support(adev))
>  			flush_work(&adev->hotplug_work);
>  	}
> +
> +	if (adev->irq.ih_soft.ring)
> +		amdgpu_ih_ring_fini(adev, &adev->irq.ih_soft);
> +	if (adev->irq.ih.ring)
> +		amdgpu_ih_ring_fini(adev, &adev->irq.ih);
> +	if (adev->irq.ih1.ring)
> +		amdgpu_ih_ring_fini(adev, &adev->irq.ih1);
> +	if (adev->irq.ih2.ring)
> +		amdgpu_ih_ring_fini(adev, &adev->irq.ih2);
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 485f249d063a..62d829f5e62c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -68,8 +68,13 @@ static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
>  		list_del_init(&bo->shadow_list);
>  		mutex_unlock(&adev->shadow_list_lock);
>  	}
> -	amdgpu_bo_unref(&bo->parent);
>  
> +
> +	spin_lock(&adev->mman.bdev.lru_lock);
> +	list_del(&bo->bo);
> +	spin_unlock(&adev->mman.bdev.lru_lock);
> +
> +	amdgpu_bo_unref(&bo->parent);
>  	kfree(bo->metadata);
>  	kfree(bo);
>  }
> @@ -585,6 +590,12 @@ static int amdgpu_bo_do_create(struct amdgpu_device *adev,
>  	if (bp->type == ttm_bo_type_device)
>  		bo->flags &= ~AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
>  
> +	INIT_LIST_HEAD(&bo->bo);
> +
> +	spin_lock(&adev->mman.bdev.lru_lock);
> +	list_add_tail(&bo->bo, &adev->device_bo_list);
> +	spin_unlock(&adev->mman.bdev.lru_lock);
> +
>  	return 0;
>  
>  fail_unreserve:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index 9ac37569823f..5ae8555ef275 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -110,6 +110,8 @@ struct amdgpu_bo {
>  	struct list_head		shadow_list;
>  
>  	struct kgd_mem                  *kfd_bo;
> +
> +	struct list_head		bo;
>  };
>  
>  static inline struct amdgpu_bo *ttm_to_amdgpu_bo(struct ttm_buffer_object *tbo)
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_ih.c b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
> index 183d44a6583c..df385ffc9768 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
> @@ -310,7 +310,6 @@ static int cik_ih_sw_fini(void *handle)
>  	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>  
>  	amdgpu_irq_fini_sw(adev);
> -	amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>  	amdgpu_irq_remove_domain(adev);
>  
>  	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
> index d32743949003..b8c47e0cf37a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
> @@ -302,7 +302,6 @@ static int cz_ih_sw_fini(void *handle)
>  	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>  
>  	amdgpu_irq_fini_sw(adev);
> -	amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>  	amdgpu_irq_remove_domain(adev);
>  
>  	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
> index da96c6013477..ddfe4eaeea05 100644
> --- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
> @@ -301,7 +301,6 @@ static int iceland_ih_sw_fini(void *handle)
>  	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>  
>  	amdgpu_irq_fini_sw(adev);
> -	amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>  	amdgpu_irq_remove_domain(adev);
>  
>  	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> index 5eea4550b856..e171a9e78544 100644
> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> @@ -571,9 +571,6 @@ static int navi10_ih_sw_fini(void *handle)
>  
>  	amdgpu_irq_fini_sw(adev);
>  	amdgpu_ih_ring_fini(adev, &adev->irq.ih_soft);
> -	amdgpu_ih_ring_fini(adev, &adev->irq.ih2);
> -	amdgpu_ih_ring_fini(adev, &adev->irq.ih1);
> -	amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>  
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c b/drivers/gpu/drm/amd/amdgpu/si_ih.c
> index 751307f3252c..9a24f17a5750 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
> @@ -176,7 +176,6 @@ static int si_ih_sw_fini(void *handle)
>  	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>  
>  	amdgpu_irq_fini_sw(adev);
> -	amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>  
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
> index 973d80ec7f6c..b08905d1c00f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
> @@ -313,7 +313,6 @@ static int tonga_ih_sw_fini(void *handle)
>  	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>  
>  	amdgpu_irq_fini_sw(adev);
> -	amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>  	amdgpu_irq_remove_domain(adev);
>  
>  	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> index 2d0094c276ca..8c8abc00f710 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> @@ -525,9 +525,6 @@ static int vega10_ih_sw_fini(void *handle)
>  
>  	amdgpu_irq_fini_sw(adev);
>  	amdgpu_ih_ring_fini(adev, &adev->irq.ih_soft);
> -	amdgpu_ih_ring_fini(adev, &adev->irq.ih2);
> -	amdgpu_ih_ring_fini(adev, &adev->irq.ih1);
> -	amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>  
>  	return 0;
>  }
