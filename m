Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 377432EEDFE
	for <lists+linux-pci@lfdr.de>; Fri,  8 Jan 2021 08:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbhAHHsk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jan 2021 02:48:40 -0500
Received: from mail-co1nam11on2073.outbound.protection.outlook.com ([40.107.220.73]:11744
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725848AbhAHHsk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Jan 2021 02:48:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VlRcHqh5WUQuxFmAVt0QkdJTTRECg17R87U59bha4Gxiw1B4uj966m97dxKMQAm32G5Luvd/VLf1NHTLrbI2XIX66Bls7KUs+gEqPP4hMV68mIsqol/cG8wyTMsvmFucC+Bd85IBPnWMztfeJjIMPOuUY+xyVfEYro7vDDt3+D64C++O8IA0pIuQoEaFSI3C/V8CblrAvAkbLJCX5yrNPvMAXQpnV51K3vpXdJpgwYCJQZBbWxm600F2XuCSU6DPqDaoHK2NDzU0VftOA/TGPBamYYjvA6psnxW9yAGwUn8cBdBB9kCUlbDROnWXQuCbuuuS4+GR2QXQPG3RobwN9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTpxKJxGklHB2Zg3f7x03fqZ4S2Bd/tqWLMD+wS6wVA=;
 b=hNm4YEEWfwSRFWUbshOH1T/bAXuVAsmNqccGHC/2XzcW33fRdjDwczE999ZuL8neJV5RSP9l5xdIdUmWyLnMmD/z9WS5SlzuiJbFLyjzt85CiQ2sSnBz8cCzW2cQomvJad1DquH+mMnPZgbQL3n5yhGtlsgXN6zHdiN2IeDiDDhG8Oa/atVtscDxUKIlb7MQtEg70YKKyU4osExkp3xnluKFRjIVy+jfrLtkvwiKEJPnKK1QpIkeTiM1XY1YeObUxZdKlzouDp0KIcZ3GhkYFFdNOIC4NPcidoxhEpvkEYfV6p9F+cX4Qb2YCQDlj0TM+8T6XMWdB4Bn2YMzua7sjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTpxKJxGklHB2Zg3f7x03fqZ4S2Bd/tqWLMD+wS6wVA=;
 b=IdXu7CdrQfuJfEJxjqC0kTsD0HWD2kAjsns5MrwTxeBqRzMe01NlSs1zQ0twIb1tNtFIVthyaTP9AtJKVzMcyEov0VFzCxGG/EAgNp9gxQunU26J3fCyuCQcksNPTxJlPtYvNEcG1YzDrKWw2QEAa9r7OVGGAi7ixUmlQi4l7No=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4755.namprd12.prod.outlook.com (2603:10b6:208:82::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.9; Fri, 8 Jan
 2021 07:47:42 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5%3]) with mapi id 15.20.3742.006; Fri, 8 Jan 2021
 07:47:42 +0000
Subject: Re: [PATCH 4/4] PCI: Add a REBAR size quirk for Sapphire RX 5600 XT
 Pulse
To:     Bjorn Helgaas <helgaas@kernel.org>, Nirmoy Das <nirmoy.das@amd.com>
Cc:     bhelgaas@google.com, ckoenig.leichtzumerken@gmail.com,
        linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devspam@moreofthesa.me.uk, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20210107213240.GA1392833@bjorn-Precision-5520>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <ad8af2b2-f00f-0a31-97c3-35f8542c749e@amd.com>
Date:   Thu, 7 Jan 2021 21:25:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210107213240.GA1392833@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM4PR0101CA0068.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::36) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM4PR0101CA0068.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Fri, 8 Jan 2021 07:47:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6a24b175-c3e8-43b0-cd18-08d8b3a9ae5f
X-MS-TrafficTypeDiagnostic: BL0PR12MB4755:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB47559C1D41279B857E3DC4F883AE0@BL0PR12MB4755.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a9umNFg+ED5Wik8HDj6vQplGXHCEHqShaWLBEjt7G/ijDXMyyOTByTSPVZaMy1QA7KUOQSoNAp5nZCxa2aI0uCyrXS1oLDW9+8Q2xo5J45vTPr2moesdq0xGrV4iX84IXwDaZfJKSP+3ZDMmRqXtjhdsTgtppNMxXqIKYlYr1WvhWsvR53e+v6q2IwXHfHY+aeCFZx6QcL2HDPAciDj1wo44mGkHR6rgQ9Xke1v8/z4QOdaM6Xb7RR1aZIVbS0xDf36uRA7n4jQSKl0obJJfaelgJYbkIevt7wCIsTLkMZvFoI/fZT2Zr8KdZWUpaoNHUr3Mua05gkMWB8867GgGZD1WmXKdLLGTuMbEeBV+sE3EJP154spVTxidmDbl7ACl2lbQobfeinBeBx1xvMHmdeH7ahZsqQeNX/dyH4eNXCK7lvvP/CTT2bV8xzRlw+hEOatz09pIl4UYGkP8mmbn1fYKtmz6aVcXeSM0CbfxihjHdFjF65XpQazrA3qx8cdRYOMaadmSItvk82GW1eINiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(2616005)(186003)(8936002)(16526019)(6636002)(6666004)(66946007)(86362001)(66556008)(52116002)(36756003)(66476007)(31696002)(478600001)(54906003)(45080400002)(66574015)(2906002)(110136005)(316002)(31686004)(83380400001)(6486002)(4326008)(8676002)(5660300002)(966005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?L2ZmbUxFaDZNdmVuSUVOME44Q1Y0Zkt3Y0g4bHQ1ZFlTS09vc1d4NzNpR2Ro?=
 =?utf-8?B?S0V4ZWtsbTdmMWxjTG1ZaVgxNWhDQjF4cDlBV3d6Q3o4NFY4SlNoRmlSVDdZ?=
 =?utf-8?B?VGEvN3VkWVJTbDJQdXAvd1VQdCtJMUJRd2EwWmJ3cXdBLzFpV1hnb1RyVE9P?=
 =?utf-8?B?SWRocDl4YjE4QnM3UnE0SFlva3JhckpvZ2ppSWQxeVptQkVjY3lLb3FZRkFX?=
 =?utf-8?B?bHhrYmxxRjMwNUdqRWk3RTByVEsySmc4SzlQZUhIblpmZVR6QmV6V3pIdGhy?=
 =?utf-8?B?b1RRZVlkM1hQd1RlYTJFcTl4cENWSURBMzgrL2EyMHNWWElJaThUcGdWQUFP?=
 =?utf-8?B?bmdRbzQ2WHBjeitaS0R2STVzK05iVFZNeDMxVWtRamVzeFF3VFc4ejFWRU01?=
 =?utf-8?B?NDRGRndCVzYwekJkaFRHcGZlNnpsQmlpTU1xZHdMRU1ab2c2cDU5S1BjQ0NH?=
 =?utf-8?B?QWJzZnpLdlNkTGlCc3ZDbGlhZnZnVHhTVjlrQVFBSEhTeWNaT2o0N1Vsc2FD?=
 =?utf-8?B?Ni9RdG9QVFlEZk5lVVl2RkZ5a0RsTGQzNU52TWtTb2V2S0JYMjl4ZzhpQ242?=
 =?utf-8?B?SlVhcjdGWEhYOWtXWkhHMlJxTklxc2J6RlcvVEczQ09keTgyT2dLamd2K1hv?=
 =?utf-8?B?R3p1bDVGeDFVbmRXMGxOVmEyemoySFA0WG02Nkc5OGtDV2dKd0s5YVNYK3Ru?=
 =?utf-8?B?eW44NUdxWlZwRHgraWwxVkJaVHpjWWRYUUY4MFhGYUtxeFVjc1BERVhocS9o?=
 =?utf-8?B?ZFI3MWpzVWUxeVNCOGRKNFNyQ2xBblBoM0U1enpGSlp4ZCs4dmRTR2E0WUdw?=
 =?utf-8?B?ZXZoaWdNaWtYdlByVDBxUENwYUcxVHhvTkpGUXRkQ0dLa2tuUEdIazJiQ05V?=
 =?utf-8?B?Q1hQU3YwRTB2anpRQ29Da0I2T1ZERmgzbWxiZ0l3M3d3Q0xaem03NGxGMXI1?=
 =?utf-8?B?S2U2bzVyUHRXczgzMEliWEIxR25MNE9hR1dtaXNnUml3WjM0a29yK3h1UDk3?=
 =?utf-8?B?N01hOUZJVUlKMmZwem9qRDVlM1FBOHNpUkpZZ0h6YStBbHAyT1FOamJCcm1t?=
 =?utf-8?B?QXVyQ0NCdzZaTXhlZnVud2wrMXFJYVRLNXk0NHU5aHdZV1hEY1RHc3JCb3Fn?=
 =?utf-8?B?SW1QS1pNaThKSWtQYmFscml1Ym94ZlBOYmJuY0pIWFhldDA4UXVLWkdDK2pt?=
 =?utf-8?B?amdMVU50ZHlOamc0UWtVdVFab1RUU3lvNlloOWt6bWtGUlJIaWEzaE5KZllm?=
 =?utf-8?B?UmlFWnBlUm5nTFI5TWo3d3BjeEhDT0FEd1FRTGNDZWVvR1pMemZkNWxCV01O?=
 =?utf-8?B?UkxOdUFIVGxVelhSR2N6eTR2NXdnenNyRDAwdFJydWFKUWdDWVBjUUk3Ni9B?=
 =?utf-8?B?emZ0L04yUFc0bHpwVS8rYlV4YytEcjBaUDVOWjArRWVSc2RwYWpyMFhBekFO?=
 =?utf-8?Q?6ROuqB3z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2021 07:47:42.8464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a24b175-c3e8-43b0-cd18-08d8b3a9ae5f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zwjjxoli6FBHu1z6E+R+D7aJmSZAGOnaGAfwfPWHNFedmdu1Kc9Sl4srhNd7mr6h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4755
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 07.01.21 um 22:32 schrieb Bjorn Helgaas:
> On Thu, Jan 07, 2021 at 06:50:17PM +0100, Nirmoy Das wrote:
>> RX 5600 XT Pulse advertises support for BAR0 being 256MB, 512MB,
>> or 1GB, but it also supports 2GB, 4GB, and 8GB. Add a rebar
>> size quirk so that CPU can fully access the BAR0.
> This isn't quite accurate.  The CPU can fully access BAR 0 no matter
> what.  I think the problem you're solving is that without this quirk,
> BAR 0 isn't big enough to cover the VRAM.
>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> IIRC, these Reported-by lines are from the "cap == 0x3f0" problem.  It
> would make sense to include these if this patch fixed that problem in
> something that had already been merged.  But this *hasn't* been
> merged, so these lines only make sense to someone who trawls through
> the mailing list to find the previous version.
>
> I don't really think it's worthwhile to include them.  It's the same
> as giving credit to reviewers, which we typically don't do except via
> a Reviewed-by tag (which I think is too strong for this case) or a
> "v2" changes note after the "---" line.  That doesn't get included in
> the git history, but is easily findable via the Link: tags as below.
>
> If you merge these via a non-PCI tree, please include the "Link:"
> lines in the PCI patches, e.g.,
>
>    Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fr%2F20210107175017.15893-5-nirmoy.das%40amd.com&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C33c14f5361e84d9d0e4908d8b353c412%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637456519678601616%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=wY9qaz3DTZA069qznMC9Wvoq9SZIzyJHE0XkaVXoqAc%3D&amp;reserved=0
>
> for this one.  Obviously the link is different for each patch and will
> change if you repost the series.
>
> I'm not sure why you put the amd patch in the middle of the series.
> Seems like it would be slightly prettier and just as safe to put it at
> the end.
>
>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
> Let me know if you want me to take the series.

I will make the suggested changes and take this through the drm subsystem.

That makes more sense since it only affects our hardware anyway.

>
>> ---
>>   drivers/pci/pci.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 16216186b51c..b061bbd4afb1 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -3577,7 +3577,14 @@ u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar)
>>   		return 0;
>>   
>>   	pci_read_config_dword(pdev, pos + PCI_REBAR_CAP, &cap);
>> -	return (cap & PCI_REBAR_CAP_SIZES) >> 4;
>> +	cap = (cap & PCI_REBAR_CAP_SIZES) >> 4;
>> +
>> +	/* Sapphire RX 5600 XT Pulse has an invalid cap dword for BAR 0 */
>> +	if (pdev->vendor == PCI_VENDOR_ID_ATI && pdev->device == 0x731f &&
>> +	    bar == 0 && cap == 0x700)
>> +		cap = 0x3f00;
> I think this is structured wrong.  It should be like this so it's
> easier to match with the spec:
>
>    cap &= PCI_REBAR_CAP_SIZES;
>
>    if (... && cap == 0x7000)
>      cap = 0x3f000;
>
>    return cap >> 4;

Good point.

Thanks,
Christian.

>
>> +
>> +	return cap;
>>   }
>>   EXPORT_SYMBOL(pci_rebar_get_possible_sizes);
>>   
>> -- 
>> 2.29.2
>>

