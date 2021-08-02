Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9133DDEF2
	for <lists+linux-pci@lfdr.de>; Mon,  2 Aug 2021 20:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbhHBSKA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Aug 2021 14:10:00 -0400
Received: from mail-bn8nam12on2071.outbound.protection.outlook.com ([40.107.237.71]:32106
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229537AbhHBSJ7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Aug 2021 14:09:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixkaCZCVDvYvl21RSMaT55/LDNq2y2ISfEtOml8rcLc5VNOv9nl6KNFEO3MAeNpVbG4EMezb5CLJ+B21qQ5hIYYV4ehE9nIaTtZK59/S4jNhjGtOIV5muD+Y3TCga5TdKvNnB0OI8vaTLN2WhKMUdTD7h1qxMlDCQJ3v+KyZTp107kkevbi0WyeHT++B4VjfspEv5hdi7LBMIT8qtC2fXL5Ivyu4Z0HEevmZYk24/4qhlQxJpQCgGFEY8cfPhLfPl2ggb5U8po6iylwS3BEKGsqDkcT9oeijo2Uai+Pu1jQo+FuwB0uWg3oMrGYKy49oxUTF0ybe6zN1Fhf4EPxC1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zpqdX8mJKf5+uGF+GSU4klmKWvDrXLbPpNzizdY2Fs=;
 b=Nv2++ZBvYg+AShmvDNvZVlndzghmEvxcT+5xu3RZspB62nSRVq0h+h+MUAOb1owVXKaj6ltpyV4Dz1xwj45r2CJqWjgtKEXSw67MD5HqlrdC/AseUAxf/XQVH6kcRC9IpC5NKCR5TSkdG6pU9uDT8Wlcl2SauNpNen55xJwBsrB9u4X9BjivY/c0O6wwUymsses1pC/r9FKH1WoRzL7wKlBlvPf2C9bb0kmmB2XZzWNntdX6/Z8Erw37nSAnmKkUXi5us5ka20vp59M81AeBMDY26fFRHb+/kU6Pf1sLPsQY/Klv+G8be5hcvgCi5UXa6c9VrlmjQc/5UnMpP4z4bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zpqdX8mJKf5+uGF+GSU4klmKWvDrXLbPpNzizdY2Fs=;
 b=Oa8pmuzTGAgf+3FGNnqsaQbInm/BYKdyeIaz/uJs95OmsC0wNydTBu4WNGEsO/AgoObB1hvSnE18j+rzE94VDdGhwMVZLQGCPxjSLymPouGxZ7P8Xg71rs8nRbdUiP92ITg27Ui1/i4Yq/N4kkLjP/JyjBoVzqmAmxPzN0cpAJk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5103.namprd12.prod.outlook.com (2603:10b6:5:392::13)
 by DM4PR12MB5374.namprd12.prod.outlook.com (2603:10b6:5:39a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Mon, 2 Aug
 2021 18:09:47 +0000
Received: from DM4PR12MB5103.namprd12.prod.outlook.com
 ([fe80::18ea:5df5:f06e:f822]) by DM4PR12MB5103.namprd12.prod.outlook.com
 ([fe80::18ea:5df5:f06e:f822%3]) with mapi id 15.20.4373.026; Mon, 2 Aug 2021
 18:09:47 +0000
Subject: Re: [PATCH 1/4] PCI: Add AMD USB4 host router device IDs
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sanjay R Mehta <Sanju.Mehta@amd.com>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        bhelgaas@google.com, YehezkelShB@gmail.com,
        Basavaraj.Natikar@amd.com, linux-usb@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <1627909100-83338-1-git-send-email-Sanju.Mehta@amd.com>
 <1627909100-83338-2-git-send-email-Sanju.Mehta@amd.com>
 <YQgLX2CukV8oc8eW@lahna>
From:   Sanjay R Mehta <sanmehta@amd.com>
Message-ID: <8578079b-76f1-b596-db3c-e02618724ba7@amd.com>
Date:   Mon, 2 Aug 2021 23:39:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <YQgLX2CukV8oc8eW@lahna>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0162.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::32) To DM4PR12MB5103.namprd12.prod.outlook.com
 (2603:10b6:5:392::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.32.35] (165.204.159.242) by BM1PR01CA0162.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:68::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Mon, 2 Aug 2021 18:09:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b19892a1-edeb-4790-3414-08d955e0b696
X-MS-TrafficTypeDiagnostic: DM4PR12MB5374:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5374A3A70FDF9D7CC1967AC9E5EF9@DM4PR12MB5374.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kcdE93ZMr+NHqaZSiMlnnvqpw8mILSAAD1L4L2HLo+t02OdZY2SQzJ/9yK6yDFvo0bEWGQXqyUIsMot+paqD8tLXarIU78NpXi6bjcpG6cGiXlgVgOFHVriEWZmbspfDx4F4ZA02aqr9X4Elvn2oI631wUQ7Zy01bBOnJP9KCVSusHssBCOfk6wEfcXHWvQsgifBBH0dtLdzwd8vwUgk1wgYCdOfnlcamq6OSNwbXbqnpoaRBKA+kUVOiRCkwW4L5Rhkz69Q57JE/1LM+PeQYTpQgVHewwJ5/5YYFawAcPYx2X37kmR6wKlrXc/YIk27ziaxlCrsUIg3kPo7xIyIpMH10mkGXLlskuRTyQKvTwmwQ8mQR+zdx5Iu4tpIdKPvrg7pM67bDITcRSVyalWHxk7hyYolDIzTOVLuENk0OpOTCOewVOaHTO/d98S9/RQ+JfLUiHIjkdzrSIoqULu3fZyYBDyEEEAuRTqUwE7vg3Gi9K5KKx2oiNwpnqoqd883qP1fuB1cpVozaBbmpVZ0o6yDsieC/B063OHqgoD8tu8zRDxjAT+lSXKSkugYl8l174rewZecoUH98iZ+a33QGzbVNcn/Eg2sxmSYRc6RsADDOf6rEHVHWqYYYDE8dR9kALai/Eua7/Z42uwom9/Q8j1Ew9jSQ6qPeAWoqA+0f03Sp86Y0zfwKUTN/Bvo9gGodiXdYZ66aFDgymkxdcEnJ3H+UTMvFkwrdFHGXcB0tDl2SZyjWXyg7KWa6e2TmCDQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5103.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(6666004)(8676002)(316002)(66556008)(66476007)(66574015)(478600001)(36756003)(16576012)(31696002)(66946007)(110136005)(956004)(6636002)(2616005)(2906002)(38100700002)(186003)(5660300002)(31686004)(4326008)(53546011)(8936002)(26005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjhoM2JyV0pxcTEyTUpHdGd6ZGRibzk4ZWlFMFRtYVBYa2RxRTRFZ20zWG5E?=
 =?utf-8?B?UWZ3M25kenZwejQydW9FeUZZRm56UkkzaURvaVN5RXNFSlFCME12QnhsZEZ3?=
 =?utf-8?B?eUZCWlJhSzNETmkvVUZ2RmhSSTVUbi9UNkJCN2VHZDhrODB2ZDVuZmcza2NQ?=
 =?utf-8?B?QlMyM3lhSmxsM2cxQmk2QlFpNCt1TVdWRytGUzV1bG9LZEV3WU9DRkgxYTdC?=
 =?utf-8?B?U1N4aE1yc0Yrb041ZWxjSUloZVliaDhuOWRoM2NHOUVwME02azlacDhISUhW?=
 =?utf-8?B?dEpTbjc3SXJTMGVTWk1GRlYxSkxrTkp1dW5xUDFqWmFpUzUrbGQ3alZiNjlW?=
 =?utf-8?B?Tmswb1d6bmJkUC9sTUlqb3RzcTBRWUpPTHRBeVUxYUJlZGRrczdsajdYN0Z1?=
 =?utf-8?B?OVZZMmhzUzEzYUZBbFBZV2p1MS9iMmxZSktBWmQyeStzcUJIZ2xFN3AzNUNq?=
 =?utf-8?B?OHNIeGh6YUZ2K0ZxRUQ0U3ljUHkrUjR6QTZsb3hDQzdXY3NXeXkra1NaaE1r?=
 =?utf-8?B?WEJaMmxpR3lXRmQ5RENwWElkamJqaFdnUWIvNW9PTjFhOUVJdmNrUHFDSlhv?=
 =?utf-8?B?NW9wRHE2d2x2UTgwTUJqNG5YSWc2VGRhTHd5RU5vZ2RHUStxSldoNXFMNDRh?=
 =?utf-8?B?cFRzMkJ4MUdkeUFYMlVId280NStJNHVySTIxanRML1E0Z3F6NnBkU0UrdWhZ?=
 =?utf-8?B?c2hic0NldFNnMzF4SVh6SmhTMUQ4cTdTRUptbzVjUUNZL29SbUlxSGR0di9n?=
 =?utf-8?B?Q1FMVG1TbWY0cXNPMVNwNXJZZWxuU0laVHFMWXZGWHRGbFJldFVZcXE2NC8r?=
 =?utf-8?B?bkVFaU9aNXhncUlyR2wybnJmcitKOHp3MUdlZXJNQWZhZjRBcU1ybkxiTS85?=
 =?utf-8?B?bVVTYzJScDRnczVJZzJlQnZlZklmbis0N29iZ0VCbEhWU2ZlREI4Q1B2MUdu?=
 =?utf-8?B?UU5Yc2NVNzVLNkhlNjZrSTRZcGh3VWNRbFg3SDVtUFBUVDEvN1QwdkxOemNK?=
 =?utf-8?B?Rk93eEl0VURJdk5GRmNhVlYxanF0VHlwc1hyWlRhUDN3K1BETElsaFFmL0sv?=
 =?utf-8?B?R0RFRTZPclRYRUhOQmZOaGQvcTltTHNSV08yMHFNZjdsSUpxcDU0eFIyRGha?=
 =?utf-8?B?Y3hWMC9YOFNhcXJyM0hHZFlETWhBL2pFSmZTbUR6WlBDeFVBNG10Z3JnSXM1?=
 =?utf-8?B?dTNmUlBMa1ljemxLOE5tdW5JWUdWWU5FVFBlQXg2T0tFMVZtQWM0ZFBQeXM5?=
 =?utf-8?B?M1M0YTgyRTJKZ2ovVU41MjIwa0ZVQlJINVNNQ0pUMU93dkV5bnI3Q0JxRGli?=
 =?utf-8?B?Z1JQSnBUaHB3WE5xUmkzZTNiTWpEWmZLdjdrQ1dEMWc5eW5TYUpkWkFXSm1B?=
 =?utf-8?B?bEJZTmxGR1ZCYVJUUjB4MTZRL2s4UDA2ckJyWFhieWtTTmVjLzR4UnAwbFhX?=
 =?utf-8?B?aW50RzhFcDdtQmloV29rczg5YXhIdmpXMldUa3BjRXpxMEdGZ2g4SjBpN1pz?=
 =?utf-8?B?SzJvMENqSW1EWEp4aGlPRFpNeGFYd0tNRDdqVy9UNG51SXpWYXlpeEVUUXhT?=
 =?utf-8?B?QkptTDZzNmZwMnZxS1hURUhoZ1dYT3FrNGZ3dVVEMHNxLzk3MFl1eDd6alFp?=
 =?utf-8?B?QWc2bkJEUzk3bzdpc3JJMjltVGJQR1djV1M3Ulh1QTg3bEZ6a1R2ZGJiY3Vz?=
 =?utf-8?B?NTJsbVRFTEFqR0E3aE1Dd0cvNHlndlBXU05YUmNLWEZPMU5lVDQxa2JtVDF3?=
 =?utf-8?Q?m0ZDifFmp9atv+XMNvGd7492hW2yjy5UVzcWkN9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b19892a1-edeb-4790-3414-08d955e0b696
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5103.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2021 18:09:47.5591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mnSjzA0pUFKzT94ihoheEkR7w/q1z8LqIOMViayQPWLrTCOYRJACk/3cSep8ejbmSGCGdSuQOeQWwNurTY55gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5374
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/2/2021 8:42 PM, Mika Westerberg wrote:
> [CAUTION: External Email]
> 
> On Mon, Aug 02, 2021 at 07:58:17AM -0500, Sanjay R Mehta wrote:
>> From: Sanjay R Mehta <sanju.mehta@amd.com>
>>
>> This patch enables support for AMD USB4 host router.
>>
>> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>> Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
>> ---
>>  drivers/thunderbolt/nhi.c | 4 ++++
>>  include/linux/pci_ids.h   | 2 ++
>>  2 files changed, 6 insertions(+)
>>
>> diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
>> index fa44332..d7d9c4b 100644
>> --- a/drivers/thunderbolt/nhi.c
>> +++ b/drivers/thunderbolt/nhi.c
>> @@ -1338,6 +1338,10 @@ static struct pci_device_id nhi_ids[] = {
>>       { PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ADL_NHI1),
>>         .driver_data = (kernel_ulong_t)&icl_nhi_ops },
>>
>> +     /* AMD USB4 host */
>> +     { PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_USB4_HIA0) },
>> +     { PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_USB4_HIA1) },
>> +
>>       /* Any USB4 compliant host */
>>       { PCI_DEVICE_CLASS(PCI_CLASS_SERIAL_USB_USB4, ~0) },
>>
>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>> index 4bac183..6d50019 100644
>> --- a/include/linux/pci_ids.h
>> +++ b/include/linux/pci_ids.h
>> @@ -604,6 +604,8 @@
>>  #define PCI_DEVICE_ID_AMD_HUDSON2_SMBUS              0x780b
>>  #define PCI_DEVICE_ID_AMD_HUDSON2_IDE                0x780c
>>  #define PCI_DEVICE_ID_AMD_KERNCZ_SMBUS  0x790b
>> +#define PCI_DEVICE_ID_AMD_USB4_HIA0  0x162e
>> +#define PCI_DEVICE_ID_AMD_USB4_HIA1  0x162f
> 
> No need to add them here (and you actually should not since these IDs
> are not shared between multiple drivers, see the top level comment in
> this header).
> 
> I suggest adding these to drivers/thunderbolt/nhi.h instead.
> 
Thanks Mika. Agree and will add it in drivers/thunderbolt/nhi.h .

>>
>>  #define PCI_VENDOR_ID_TRIDENT                0x1023
>>  #define PCI_DEVICE_ID_TRIDENT_4DWAVE_DX      0x2000
>> --
>> 2.7.4
