Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48BAC5ADCC1
	for <lists+linux-pci@lfdr.de>; Tue,  6 Sep 2022 03:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbiIFBEG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 21:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiIFBEE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 21:04:04 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7977549B4F;
        Mon,  5 Sep 2022 18:04:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TI8TUschPIFEMe9fUKY9kOLyo9auw7hNlMxPEKHfFN9SExzf77frwmwmcKyZILdBMw4ih+SH42jF69N73lpDXrdnSP/fkHNm9AyJux2JLubULatnXCLc+54D41w5TUXEz0M5fnMHKavT8OYBYDqiDLmhNmEIcMXa1Kefyv4jSRI064A6XFo68kKpEhtVVUwuyV+hnN+FjNi6MB1Lk3LL2zzUlONmTWZ/TJlRZJxyvQwepeLxRHwt7JH4ubLKaT+sKNoR3iZFE8PRfUPvv44kXxz56IyAx8rXhhPXnYjrLsKBvGfNrXDFcBQkyImetH5Q7E1ZSfbLSdnYNkohLYE/7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AbBTW9MS9VdIwR+ThmDyqpbVrU068CfturVqUnEnUF4=;
 b=Cux43ljrXniBaQzsc0SsotWOJaNFhOayMA+0HdW63pvt3xdT+W1S8dluJuxA5Wk/Zr+/sMvmVkyyLcpD/G1InS8XUKc8adpxzvmo8X2AH5jw24Ng2+R4spzdEL9NwLeVD52Hk693/lQBxjFqxHRkch7tVnk1gJwC5P1wOGAwkPM2wx22tvkuJ2dBjReb5L0gBcE5pE4zQWO/fAsYcQiUNlyOeK7nULPXrQJLxcIytey1Tt+7MJwOpm2L8AANMQkFTwTKePyiyNotPRMYeDPaSkv+9MgSZOFAKQw75wWHWJ4SB9K4SD0ITTh9IvROF1Phqv1stbl3GAtvkp/PsrFy5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbBTW9MS9VdIwR+ThmDyqpbVrU068CfturVqUnEnUF4=;
 b=lDYPaFjUJ94CSbmxsazei/7KvIgvzcVN8PbHrbW7mCvo5n5f61tSPMxDbBmr2YvCWRHSbsY2BxE6wNCuH8KI6X1edgOtjCivXADrhIQZRc6SKYYBqtDDHpMOEzgIJcuoWkn3lVm5j27AF7JkctIED/aOg7/LV3SJ4sqG5gZ+E1JBeiPdRUpmosGGy1q6kXzO4MGx2xXAME2X7EAGRVeZGGvjL4j4XlGDjiB6u4i0To4nBcduhbnCPNA4Ra0hlF4ZpaUVZm1cY+e0fXJUmKL/ILXdRO9Ed5lGVwFi/meIXpnd9q2ySuBFM/c964jUrWANlKncl/2oRXb/tD5SjCNLJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by MW4PR12MB6732.namprd12.prod.outlook.com (2603:10b6:303:1ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.14; Tue, 6 Sep
 2022 01:04:02 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5%9]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 01:04:02 +0000
Message-ID: <082bfb32-be2a-0fc4-6818-2730e904c000@nvidia.com>
Date:   Mon, 5 Sep 2022 18:03:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v9 8/8] ABI: sysfs-bus-pci: add documentation for p2pmem
 allocate
Content-Language: en-US
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20220825152425.6296-1-logang@deltatee.com>
 <20220825152425.6296-9-logang@deltatee.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220825152425.6296-9-logang@deltatee.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::28) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 967079d0-7870-4ad5-e8dc-08da8fa3afd5
X-MS-TrafficTypeDiagnostic: MW4PR12MB6732:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SY5SZlTl1vPPCQ3SO4Nj8Gx4zLhqiQ9BBc35lhVZOJuG4/cWq2qS0+dDMU3cz+4n0Dw75jB1hEyuH49Q/dNpQBQGTOXcRSULM0vqtDJDR/2NSb0zgCJNqcniWSxnLVDm55T0wOJwuFiWtD6rglnfSVd3DrlL0tNcJ1p8envfQkRrRVlzX7tDLATpdgXnE3KzbYMS8Ec0i6eceqqKT+hkl63jD+97n8LY9rTv8L462JwSzz6p8p7HOUjh1bBM2bEZXTXN4yPB4B9u/l0Hhe0jfVlj5whgbm0PVKIjvh0oNksTjNyn6hYq1kVYwLYUMxZ0a5Q497/+RrPX8yh88CCFnH/R0Ujk/EfR+/bYIWacjUOJzr7aQKBgoA0qdk3BJxAkXy8Bf0mrzj/qr793pj3yg/AE4Vt+vC8e0bt2yhSPMGalsYlGQrhZEipTyGyM+I968rPnCzfgX6qxG7MUK4E8vB31Tke1EM2Nf8MjuGIiDtIxwVKUn6axjEmIH7W81gkXxkAfKbSmj+gMOeB93xrmgW2rNhrTukx1MAP8Trm9jiMWyJf4rQBIxctSM7/uw15aOkFfIytTGjLd3hvIPxfgoH5a6A0G8AybLyxaMzILI03pFULjTD0KfmWdYRU99WHxKRE5fDA4KhgMbN4EWH81/S1AVx9RZlSwD+PpKMPWDZj8uByUckdgEmQTn5qHV72yi+5kBcsO0GAR6Rp5hHK6V6qQbCWHhiUeDnPPFBhaEEEdCyKuIp9opD8LlzobR4GIgUbSaPgTlu+CoIownEzSbxQGEmJrfXdCMjnb2Rf+YUI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(31686004)(83380400001)(66556008)(316002)(66946007)(38100700002)(66476007)(54906003)(2906002)(8676002)(4326008)(7416002)(53546011)(6506007)(31696002)(186003)(8936002)(5660300002)(478600001)(6486002)(26005)(6512007)(6666004)(36756003)(86362001)(2616005)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDl0NldZUDJlNzFVYkdPZ0x1S0J6ODREYXY0eXZRaXNMUkE3bzdDYlQzNXRl?=
 =?utf-8?B?MWhFeEYybHRoNEFNemRYLzZ3R2VyemxqaURtQWtNSjY0Slp0NklGVnB1UTNR?=
 =?utf-8?B?cFRXUWNrRHRFK0I1RUx4VFFCUWpnL2xIOHpNYWxVcW53VDJEUXgxM1VmVWZl?=
 =?utf-8?B?Uy84QzJ1bVVmeUdPR3NTQmRDTnN4L1NpK3pReUNjT00rNWhIS005RDI2Zkg0?=
 =?utf-8?B?RlF5MUxYUmdLcEkvL0dJVTlkbHJUMGtYcDdMN3lPRU5BTnNWY3RBMzdSWFk3?=
 =?utf-8?B?QTJoakgrNjNwOVNBS2t5eStCNTBaOFNTWEg5ME4wSytmeFFJVWx4UEhsWGxs?=
 =?utf-8?B?TzFRcThsdVNUU2ZDNUZCV1l2TXpoY1hQcVhIZldab0d4bkFVNFE1SkVCandt?=
 =?utf-8?B?Y0xUS2gvdG5QdVhheXpIbmFOTFpSYmdRQWdIaytINnNiNnhYZGZOV1FrV3ll?=
 =?utf-8?B?a3g1Y3hZT2tENHJuU05KMktySEVlTlRmTmdRN0c4cE1zWnM5SE1CWUdHOWJ1?=
 =?utf-8?B?TjBwS3UyMytYamdvVUZNYU5LdDhHVGY4SXlNZ3BGL0M1WmRQQ28ya2lsbno1?=
 =?utf-8?B?M1ZSeFIxQnFIS1VidVg2ZEQzeTdxZlhucXZsU0RwUDZqVkJNRFMyMit6MHZT?=
 =?utf-8?B?SGI5NGlHYThpcHhHWTV2UHlGNWppU3ZqQnFUWndKMUc1THpmRW0zaTU5dmlt?=
 =?utf-8?B?MnNBaUNvL0NKRVNvVDhnR0FHRTR1YmlnSExlR1plZ3E1aFAzWDh4dko3dHZp?=
 =?utf-8?B?T21Gd3hKcXNTQmY4ZS9nTnZGZlN0STBTZGI1eHNOR3FZWVBsK2hpVkszRG41?=
 =?utf-8?B?V1NzV0g3cmlEeWFJV08xa3FTVlIwbUY5ZVl2RUNaNEtwWFllR1krc3RQcnYr?=
 =?utf-8?B?ZFcrc2lGQnRIMzljV1Q1SE8wOHNUTEM1Y3BoZDFIYTRuNjNyUjUxVkVlV2pi?=
 =?utf-8?B?ZWRYYmk3SGh0ampJWUVCOE9FV2tHajJaMmIyQ3hNSFNwdDRsTTl5VzdJV2FW?=
 =?utf-8?B?eForbjdnTVdLWlQ4bHFPdkVCYUZ5RVF6M1dxOWFBN1daWVRwWVZkVFVtWkhW?=
 =?utf-8?B?Yzl3N0ZNdzhVMHo3MWFUb2tuYXdnQWhKUHNmTVBET0NSYmN0WHJvdlJFZGZj?=
 =?utf-8?B?TmxtYXVsTTRKTjRGNkxRVUpPUS81ckU0RFRFQkhUMmp5a3FwcldnWlNKWito?=
 =?utf-8?B?T3ZVZ2ZzYVJEaU5jMm1jaERSeThTaDg2TVNUa09iNWEyMTY1NHV2S0RiS3Fj?=
 =?utf-8?B?NmxtQ1o3NWlJZ2lQNUtTNnorM2wzVkt3UnZ1TEFrN2d4NHNUemZ5T2xmWjVM?=
 =?utf-8?B?MXhBd2FQeVE5R1ByVHRDRE5kMVcxdUk5Lzh3ZWd4NVZMWEhKZkdvbmlGRFhm?=
 =?utf-8?B?NzZGQVJSUWFXR1dsOTJlaHpCbTduYjVBMmpuZUgxMkRrd0FNc0w4VGRTa1ky?=
 =?utf-8?B?aVcybWV2SGYwMG1pTllQbFVjcmFoUk41dFo2SDA2S3JJTnplOTF2WnZONTYw?=
 =?utf-8?B?UE1mNTJpbVZGS1hHTEIzNnprak5lLy8zdmVDWC9tZDRMRVBBQ3dpOThieldt?=
 =?utf-8?B?U0FGRURhaE9RT3pVSG5Pc21PMWsrMUxKRDhMdWZocm5OdVllWEhob0EzUU1C?=
 =?utf-8?B?OGRkdWc1NkN3NzF4OWRxcS9URXNBc1hLTDhUcSszRXV0ZS9MbituV0RtNUY0?=
 =?utf-8?B?RlhjQkt5SmJRc3dLemdvV2xscEZianVEcW41dXJWRFRZcmRkakppTUU1TXJB?=
 =?utf-8?B?MEdZQ05OaVFyVGMrcnRmaGJ0bjI4K3Y4aFlxUkdrc1cvQVBqdTMvbmFRMUh6?=
 =?utf-8?B?R1FTZ1JpZzFVQ1FFTERuSGZldlJsUXloVDhkZUJjTVJTZlB2Q1V6bDVTdkN2?=
 =?utf-8?B?Ymc5YWVYN1U2T1ZHNjN5NEExcE9KeGxacEMxR0FrTTN3TzhIV05XQnBGZmw5?=
 =?utf-8?B?Q2UrclpwY2NydjE5bDM0M3V5T2VKNWM4aHFPZkRUM1VCdDJtZEp6UmFzWHVP?=
 =?utf-8?B?bXBuVjRCaVpBWWN1QjZ3QS9IUDRsbElFSnkyUFNWWWhINkpWam9DYWpITnRH?=
 =?utf-8?B?S2VuS2EwSmR2dytVbTdrSGlmT2l0VzJXMDB3ZnpqMzNlaGZ6VlhYV0lRVmJt?=
 =?utf-8?B?ekNSYldnbzIzdksxbThtTmJqZjhkaUxlMEl6bndPUUZzVTdNRnR3dXdvYlNP?=
 =?utf-8?B?b3c9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 967079d0-7870-4ad5-e8dc-08da8fa3afd5
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 01:04:02.1475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1WokUuAzWVmkZrri9r6cNnFyD+S306FaIIT29ySSEbX1LSUQv9GNWj9byMRDfQVnFHbEazi73vQeodNvbm+yYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6732
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/25/22 08:24, Logan Gunthorpe wrote:
> Add documentation for the p2pmem/allocate binary file which allows
> for allocating p2pmem buffers in userspace for passing to drivers
> that support them. (Currently only O_DIRECT to NVMe devices.)
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-pci | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index 6fc2c2efe8ab..dca5e032b4fa 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -171,7 +171,7 @@ Description:
>  		binary file containing the Vital Product Data for the
>  		device.  It should follow the VPD format defined in
>  		PCI Specification 2.1 or 2.2, but users should consider
> -		that some devices may have incorrectly formatted data.  
> +		that some devices may have incorrectly formatted data.
>  		If the underlying VPD has a writable section then the
>  		corresponding section of this file will be writable.
>  
> @@ -407,6 +407,16 @@ Description:
>  	        file contains a '1' if the memory has been published for
>  		use outside the driver that owns the device.
>  
> +What:		/sys/bus/pci/devices/.../p2pmem/allocate
> +Date:		August 2022
> +Contact:	Logan Gunthorpe <logang@deltatee.com>
> +Description:
> +		Thes attribute allows mapping p2pmem into userspace. For

s/Thes/This/

Actually, the sentence goes on to say "file", which refers to the same
thing as "attribute". So maybe just saying "This attribute" would be
slightly clearer? So:

		This file allows mapping p2pmem into userspace. For


With the typo fix and optionally the "attribute" change (up to you),
please feel free to add:

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,

-- 
John Hubbard
NVIDIA

> +		each mmap() call on this file, the kernel will allocate
> +		a chunk of Peer-to-Peer memory for use in Peer-to-Peer
> +		transactions. This memory can be used in O_DIRECT calls
> +		to NVMe backed files for Peer-to-Peer copies.
> +
>  What:		/sys/bus/pci/devices/.../link/clkpm
>  		/sys/bus/pci/devices/.../link/l0s_aspm
>  		/sys/bus/pci/devices/.../link/l1_aspm

