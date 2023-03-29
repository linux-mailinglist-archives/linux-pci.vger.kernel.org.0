Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2046CF28B
	for <lists+linux-pci@lfdr.de>; Wed, 29 Mar 2023 20:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjC2S4Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Mar 2023 14:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjC2S4X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Mar 2023 14:56:23 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546CD5251
        for <linux-pci@vger.kernel.org>; Wed, 29 Mar 2023 11:56:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R72bg74YoyFu0RPrD+PS1CpxYaT1FWzmCXgkwoLzZd9yCMVRcxopU69FvRql4WoRXNpX0hvt94gKj7Ax+j/beE4WHyqb4obImTlkppWQnTat8rUGgzk1SVCuvbDhwVYspe6naDSGtNnJE4mHN3LBZSrWo4C2duGcjwwlQrrMzs749y13xsb/KSmg4EpUfIYTG43T9DAYxHVzly/C515pp+xfiFcZcUzjrTsZJ5AVYpgZKR+Qsk/wxDrpmebPro37eubngE7IeQvGB2Otz+Odx8RGou7Kx1U9gdxTwETyo3GCMWAui+eht2p5MYwcFwoVIFD/EcRiNkh+dkkON0ptaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGlfsFlCZHR7k4J8uKdUSaP4R40prKe9nygyn5zkojI=;
 b=MMkbqqBWu0NWbjos5M/weHNIuRW8K8dtCapFiwyOvkRroPOjj+crnEk0j/e1COyUJxHh0w1q7Ue4n/C+P4cp8t6HnvBk0in0XH1C8pFBCKOhHlkbR+ymtD6vc9kQ+RGAv99tMPMPR84tdk+/P7zlr4f6xS12QgFD47eSUH/ZoDoTSMIaUjXsXf/i0Cs6VqaQxxpXH2rrOvFNT3Wu9Fx16p2MPx3VAjQPpEYDO9qlMWn5Qg/IBarcY26eU6pADQW8fgMZ+FeGcP1G3//LZwkNu4GbK2VK0UUF1lRG4VmTgnnVKPqYoyzlyn63yNDtigyLkW6VKIcq1g+GiyrmLxc0hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGlfsFlCZHR7k4J8uKdUSaP4R40prKe9nygyn5zkojI=;
 b=BHd2KK61NxWnaFyADQA5vqsr3LSPvdHGK0XZrXtxDpylqJQbB7jtv0tQz+vky24P1bvvdVkeIZUTYOsV7bBY3KzSUAhQKayYjKAzoxXmsfxa8TClFb0+nB26o/zGzSuI8rfWvJ3iV+dXvO2XunBl9AGxQLjcJVYSQbq0CS7uLjM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY8PR12MB7586.namprd12.prod.outlook.com (2603:10b6:930:99::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20; Wed, 29 Mar
 2023 18:56:19 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe%2]) with mapi id 15.20.6222.028; Wed, 29 Mar 2023
 18:56:19 +0000
Message-ID: <ae3218a7-52e6-cf96-2223-dac2e1f9d14a@amd.com>
Date:   Wed, 29 Mar 2023 13:56:15 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] PCI: Add quirk to clear AMD strap_15B8 NO_SOFT_RESET dev2
 f0
Content-Language: en-US
To:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>, bhelgaas@google.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org,
        linux-pci@vger.kernel.org
Cc:     thomas@glanzmann.de, "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
References: <20230329172859.699743-1-Basavaraj.Natikar@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20230329172859.699743-1-Basavaraj.Natikar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR1501CA0003.namprd15.prod.outlook.com
 (2603:10b6:207:17::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY8PR12MB7586:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d12873b-9491-4a65-f9dd-08db308747ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y7EcVjPPfhvHOcfnvhGet4QOrbo/grbIWa++OHd6y0qWGmWmN+w07xaPnPRwXr9QhYxcalSVxCNeU/O3kFt/ZPt1x34K3eAFTYQmipsMhadYN1JzB6uYTYFyXg1nDXhSl6b387Q2Va35n+exeZGtyQY5y7kKLpjhwRF3KHsPc51s8q/Cq7b2jn3jDD13LB6NfkhFdUwNC4R7IEp1u0OKLYfpjMTnrzq1Ku6X23fXCKmKJ1WzQqCING+Fol+UWV/j3qBJqYcxOmEaeU4BavYucsgzTYvDGRSdqxJUzpNk86U9exKfETSgAj3FjE8yWv5kBbX33LQYCavJOAUx3ux92aWa8DBI1EH61XQXZyE/qgCFJgRJaTITXfCOhNslWScCVMAB8ZpKkCkLAbfeCX/0J0jEM2HWCrQ1vHyoAd5xjiZ7ic2inhX3wuiSmchx+D29oW6tJydToMiE8A0l96H+pCReFoRpXwa3XJSv9lbVLt2dtsLblhPVFavgqv3i6bJaDdAaRoeRRVWuWjkm7NCbjvGJCBSRBNoWhUx9mCrPn7d+mFJaDlN9MDaAx2yOqXC3jGakJVjglHxNpKsVMOF/pMFGf5Jv3PXl+rBG1C9TxDJyAoxEO+Pw+OLFhQ0IkHVX8MflD+efbueGnl4GOgo8aw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(451199021)(5660300002)(8936002)(2906002)(41300700001)(31686004)(86362001)(66556008)(66476007)(66946007)(8676002)(4326008)(2616005)(316002)(478600001)(966005)(6486002)(6666004)(26005)(6506007)(6512007)(53546011)(186003)(36756003)(83380400001)(38100700002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkhMV3B1QkxqSi9LOU1iRXF2Y2NMVTNzdVplRytQZjRUYzR5VFlVNE1ueUpC?=
 =?utf-8?B?NHFrN29pMlJ5OFlyc1R3ZFNtUU8rbEs2U0QyQzVpMXA2cTdJZXR0RUJtYk5r?=
 =?utf-8?B?RnZDUEcyb25ITzdNMlVaQWU3TU5TMFBCYUJyd05PZHQwMUlaR2RXR1dYaHps?=
 =?utf-8?B?QW83dWoxNFkzam1mcVYrV210cThaOE85cFN3TnA3MERES1B4NEpqNEdTN3Fv?=
 =?utf-8?B?K0ttMFFKL3BUTWo0MEw2T2JCNHZZNi9uWndaWGJhUFBGKzFrazZudTN0M0RK?=
 =?utf-8?B?aVZvR09xUEd6OUt3aEtXNGJvMzRPOVF2TTNtS3JveDdTVHBkb0dsQTZpcGZF?=
 =?utf-8?B?K2Ntb2wwa0UvRmIrUjhSR3FPem0xN0hwZTMvWVhIYytrSWxsWU9YMExqRzRj?=
 =?utf-8?B?bDFVY0dSdVorMkhDNzBTOEV4QUphV0JqMU5VNTQ1b2NtdEhxZG1EN01ubWRj?=
 =?utf-8?B?MC9OQkIvbXpsa2ZzelZVbUQ2S09iV0QyYUZoRlRvbnNOL0RUaGVEcmlIZ3pD?=
 =?utf-8?B?VkxTOUtoVmRRVHcwTnd3N1dKMS9FUlJPSjh5SDFXdkt0L2xvbXBDWmVnYVcx?=
 =?utf-8?B?QXdZd051TktFM1VBWnY2ZGlKV0lGV2JOaUxGWnd5YlVWSDUxd1FkRFlxcTFI?=
 =?utf-8?B?TGNWYTJqc3VSQnRNSEpZL0NSQTlBVFZHeDhRaDZSZzFYcDdiMFN1aXZJWUNY?=
 =?utf-8?B?ZDRuRG1qSmIrNE1mWTByb3ZGMnZ0Y05MQTBTQTg2MUJTRElidkNPenlJeEwr?=
 =?utf-8?B?WFhDVS9wMXJjU2dFZ1hFNEpITGY5dWlNQ00wWEIzM3NLbk1rK1U4RG1mTlRx?=
 =?utf-8?B?ejd1a1hWVWtNTVoxVUdoVm5SUmVLT0JEYVZ5OUtKK0RCeFpVRzBDQTBMeTRX?=
 =?utf-8?B?YzdyODdrMzdRbk5ONEcrT04rakZucHpJVk40MDR4dVE0eVJvQXdjb1BIRUtP?=
 =?utf-8?B?bURaNHRrSkl4c0RkdFFXdi9QeUpPYU5KamY4aHhRYndaaGRIRnFRdGd4cjVZ?=
 =?utf-8?B?eTZHWVo4ZElTaDdlcVF0dVViNmQrZis2bnpaeTNiUFBKQ2Z2b2FiOWRmczZ4?=
 =?utf-8?B?RXhYVkViTDRUTG9VbmhvajFVdW5WZ3UxdUpEaklZMEFxUFE1eGlKdzlsamVW?=
 =?utf-8?B?eVhsR0dMNkphY3dpczhvODFpQ1ljTGFXdm93T09GRzJ2aGwwSWUvM1dvSnpU?=
 =?utf-8?B?a3doc1Qzc3ZqM011K25jNWpyaW12RElLZWtCSW16dXBvakRkMDRtdTBuWHFJ?=
 =?utf-8?B?SERmL2Z1cFFLZ0hRcCtmcHZVUmtBNUR5TjlHSjJuWE9kM0dwL2V0a011RGVr?=
 =?utf-8?B?emdWZXNLVHZiOVFrbHFOemZtTG93MjRjWldUeG9ZZ3hnYnFmc3o4bEh6em0z?=
 =?utf-8?B?YXJNQmJVajU5TU85SXdZZ3pTSWMwcThISnRXRUkvTkZ2aDVOZ1g2b25FR2hm?=
 =?utf-8?B?WFpDcGdJYzIvUUJKdWNwbG5uUXprRVJ0Q0NqWDk2V2VPOEhtZW9ZK0phc0g5?=
 =?utf-8?B?UFpSSDRXNGZMVm5EV0dMRGlhZ2hjNElHWDNrMVhnbGM4NmhRc3E2cjJremJU?=
 =?utf-8?B?WS9oczJzTSsrT3NwVnVWNHlzbUQrVmJ5UzRyQmk0QWNYZHZKOFI4VnVuNGJR?=
 =?utf-8?B?enlKbGNnc1I4NmN0a1dHM2YrMmxUV08ySWFYcnUwaHkrb3htb0FLQ215RmhM?=
 =?utf-8?B?Rm9pbmlnRm5tRVBIWGQ3Z2hjK2YwdTAwT3JnM2VQMTJpak93SHBZK2hIT3gr?=
 =?utf-8?B?S1F4N3Y1MVp2WjBEbXF6dTdleHZOZ3RLS1JrZmZQSUQyMjdTRGk2TEVnWTUw?=
 =?utf-8?B?NWcwUzR6RlVWaTZQTzhHaU1lQjVFNlU2RFpYc0VJR1RGRmx2OTJxS2orMno3?=
 =?utf-8?B?azd4V1RqOHRrM1Y0U3ZJK2puc015SkRwUGhma2RSTGJyRm5pK1ZBR0d2aFRp?=
 =?utf-8?B?dERROFBualJzUDFQMDkvdEQ1dXljdFl0dFFQZG1JdW9XYVNneHpFY3FBUU9v?=
 =?utf-8?B?ZXFFTTZnNEd4MTROWGpqVXpKdkllMnBmaks0ZDdubUNHcUQxTkFCSFVSL2Fs?=
 =?utf-8?B?blNZMmNVMDNwTkpkY1Q4ZWhyMzY4emMwR2xTU293b1hJS1d4bTdYMmROa0tC?=
 =?utf-8?Q?BIvkOU9/ogYFRifIIoEjZY5N5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d12873b-9491-4a65-f9dd-08db308747ee
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 18:56:19.0667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n6o+kTrqvIRiUTatmkDuMumlOXp7NTeOF6ORQ0oPA43JuIVnlJKwg7SS7s//UD/br2euLmBw0IU71l/knMfubA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7586
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+Yazen

On 3/29/2023 12:28, Basavaraj Natikar wrote:
> The AMD [1022:15b8] USB controller loses some internal functional
> MSI-X context when transitioning from D0 to D3hot. BIOS normally
> traps D0->D3hot and D3hot->D0 transitions so it can save and restore
> that internal context, but some firmware in the field lacks due to
> AMD_15B8_RCC_DEV2_EPF0_STRAP2 NO_SOFT_RESET bit is set.
> 
> Hence add quirk to clear AMD_15B8_RCC_DEV2_EPF0_STRAP2 NO_SOFT_RESET
> bit before USB controller initialization during boot.
> 
> Reported-by: Thomas Glanzmann <thomas@glanzmann.de>

Thomas Glanzmann,

Can you please test this on your side?

Explicitly test it with amdgpu blacklisted or iGPU disabled in BIOS 
setup so that we can confirm that it is working and the amdgpu version 
of it isn't being used.

Thanks,

> Link: https://lore.kernel.org/linux-usb/Y%2Fz9GdHjPyF2rNG3@glanzmann.de/T/#u
> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   arch/x86/pci/fixup.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> index 615a76d70019..bf5161dcf89e 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -7,6 +7,7 @@
>   #include <linux/dmi.h>
>   #include <linux/pci.h>
>   #include <linux/vgaarb.h>
> +#include <asm/amd_nb.h>
>   #include <asm/hpet.h>
>   #include <asm/pci_x86.h>
>   
> @@ -824,3 +825,23 @@ static void rs690_fix_64bit_dma(struct pci_dev *pdev)
>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7910, rs690_fix_64bit_dma);
>   
>   #endif
> +
> +#ifdef CONFIG_AMD_NB
> +
> +#define AMD_15B8_RCC_DEV2_EPF0_STRAP2                                  0x10136008
> +#define AMD_15B8_RCC_DEV2_EPF0_STRAP2_NO_SOFT_RESET_DEV2_F0_MASK       0x00000080L
> +
> +static void quirk_clear_strap_no_soft_reset_dev2_f0(struct pci_dev *dev)
> +{
> +	u32 data;
> +
> +	if (!amd_smn_read(0, AMD_15B8_RCC_DEV2_EPF0_STRAP2, &data)) {
> +		data &= ~AMD_15B8_RCC_DEV2_EPF0_STRAP2_NO_SOFT_RESET_DEV2_F0_MASK;
> +		if (amd_smn_write(0, AMD_15B8_RCC_DEV2_EPF0_STRAP2, data))
> +			pci_err(dev, "Failed to write data 0x%x\n", data);
> +	} else {
> +		pci_err(dev, "Failed to read data\n");
> +	}
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15b8, quirk_clear_strap_no_soft_reset_dev2_f0);
> +#endif

