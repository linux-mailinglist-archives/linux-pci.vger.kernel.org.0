Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360A279DC0E
	for <lists+linux-pci@lfdr.de>; Wed, 13 Sep 2023 00:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbjILWpo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Sep 2023 18:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbjILWpn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Sep 2023 18:45:43 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2083.outbound.protection.outlook.com [40.107.96.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E06310EB;
        Tue, 12 Sep 2023 15:45:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RgSqVRQHQOCp+MHU7KaCuVLcsplUjgFHGL6MmkJP3IDoXN8ctAsADPTjz9DAUxSCnyBgbzmF6nty5A1EYmsyzLkTs+yPy5vYGi1NU8jG0HcTY5dTh6ytf/ddASsd54vEbm3xHpty5tmgerwutqnIX97UrkpwK+di2aNxaKmtZn6Wum0LhQ3WohoY8EURqrqrJ605GNW6nL2y8lpJ6/PmHteHrvWBKLYqnFIXF9CRN4YpXi1wn+Mvo6alcKRK9gB9ns0cJu1TDpU60hkMjg15MTsegNqfaaCi3SiitN8stBveKXm70hgNpThtAx8kFb98IV3IlrxNNFcTSc9uzmZkQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+UTD/1ZJo5ZJG5uTuQwx6YXJgtLfv3gWf+wozm9Cko=;
 b=L8nGJMLpgRJifIYg9puw6Hd8SajyzIWOA8J4rkJxPgK3yy90RRp5/yZjEAXgY0nTVNRmWFZIA3SRhGK5VRvPrwp6U/zN1cjhaoIXvXGsakaVKcoFVAONUPXcNj3Xy0X4cLhIcd9pDhiYCtY8czNiw5AcdJQZvv8HFQ32yfsYfcTpRvG2lqfc2J/BZwb4O6ROyd5Xsm3Y6bpJeEH45GMYffo/BdUilHCNEtrvod70BKB9ONSMumimZdVt3uKyBenEmq9vNmb6ndq52gxIiQ3ajsiMRs0mC2H7KsaH/rdvCoGvz/xhn6l+pcYnDsgjwJnKBiNcStVrrw2OYPv/s+aYJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+UTD/1ZJo5ZJG5uTuQwx6YXJgtLfv3gWf+wozm9Cko=;
 b=WyY2pWN/XXYMiGAgQsqexIfzyI0VbOSmjtKoOwEGG4sD8c35dICi1pl/7PiswGIcMDQ6dXAZ7VOsT53MOCcgvec39v11j/XzoZphkQWho1E57vq7m8nS3VxlUeOQxGAEJuXptXN8KuJIwviu3odL+2JcuXmY78D8o+n1i9hNUNs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by DM6PR12MB4386.namprd12.prod.outlook.com (2603:10b6:5:28f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 22:45:36 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::2709:2c34:f842:ce33]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::2709:2c34:f842:ce33%5]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 22:45:36 +0000
Message-ID: <440ad7c8-35f7-5b15-5de6-f220cae2cde0@amd.com>
Date:   Tue, 12 Sep 2023 15:45:34 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 1/3] PCI: pciehp: Add support for async hotplug with
 native AER and DPC/EDR
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
References: <20230815212043.114913-1-Smita.KoralahalliChannabasappa@amd.com>
 <20230815212043.114913-2-Smita.KoralahalliChannabasappa@amd.com>
 <20230828073542.GA12658@wunner.de>
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <20230828073542.GA12658@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:a03:505::16) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|DM6PR12MB4386:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bd5b1b2-c94e-47c7-3a9c-08dbb3e1fb3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xt2MiAhpRfVc09Ukbd35rNcrRFnAVCgECSnD6wJFYWHqy5b6KvXsqPQqqtsGXk4S8JMeBUax8dz0ZYNjO7O6vWyyGmBkzchPmWRZs60rPcmUkapuoiEIKu6PDtZHySGH0lXYInY1CA/n8L4f5eQiS6OqmeLtm8ve8XO1nVX2M33quiMoKEYkRVK6YB8dxlZ/TP8REQE7T8lL/+dEJ9ltSk4jd/roTNBpGn39Abz6LbCoIcEb2Imu86CFdk14WveX5N0YQvrS8aKD/0lmjRtE9TNcRRas4RzmDfiYGYYwYpgdXmp397JZ1mTLVp/gaYwhG+jtW29LW58wRV2nhw3xrdtWjWmhm51Bg4MpbqUAiNBQX9nqOCmv3PVLvsAjquo9VnE5fnHOsn9NagIs+CfDMkv0v+rT1dBdUl+spvvEljez/yOhu91oHRDQzcQjLSwqSdoJP8+t0nV8u8Kn//nIuABVPGx7V96LYZhfKuagngXPnnCger16uFDrNAAY318vlsvh0dtOjEM+KV38UHq6sUl8w6SEk/Gr9W0KateTFRcegs+hshVBUFSHV3FKNiml7zoJJtBy9KRuLZognlEd20UkW7stSZU4uWXaRGnh+x/iC017rFXXXx7J2ZtmFNNSfhMbGWeLnMmaWIIzwFaFjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(396003)(136003)(39860400002)(451199024)(1800799009)(186009)(31696002)(86362001)(2906002)(38100700002)(478600001)(966005)(53546011)(6486002)(6506007)(6512007)(66476007)(316002)(6916009)(66946007)(54906003)(83380400001)(66556008)(31686004)(26005)(2616005)(4326008)(8676002)(36756003)(5660300002)(8936002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NU5YcHBqcEUyeDN1ZlRNb280b3hlSThRWjFUUmRVNXIxdnRkakJnK2dmTXFm?=
 =?utf-8?B?RldhTFl3cGZhSVVxM3RkVlo0WE1QSXJjWGI4d1pZTUlmV1VzeGhaQjVaZ0I4?=
 =?utf-8?B?M01PcTdWRHlQZTg3LzFGVGoxZjV4SEFNTGJHZmhmVmVoL0xyY3REV1crR3NU?=
 =?utf-8?B?R1UwM2t4SzI4UFpBRFBQdGVRUVRGSGRIMHZxd3p5OHlSVXMyS3JLMTVFNVhX?=
 =?utf-8?B?REFXb1Y3TmRWUTN2NlJCNE5TOFg3aS9TQUo3Y2tOSnlhaEsxVHhzTS9QV2xv?=
 =?utf-8?B?QVphLy9WYytBUUpBYzA3VklzcFM4S21mN0VIeE1hdzVPUFRjbEFBYUk0MVk1?=
 =?utf-8?B?S3JUTTRSMElBWEdTK1RtRngwTE43enBCWUxTMWVtREd4ME5wR1NENnBEdmFt?=
 =?utf-8?B?dWg2NS90MW45dTl3MVFLNXFFOFlEbHZhR1cyOE00aStQWHFvc2RidllxOGYx?=
 =?utf-8?B?ZTlxQXBubnBCdm1iMHkrNlA1czFjdWpPeDV5Uk9lMDFrTmJLbEF5MmtuYk1w?=
 =?utf-8?B?Z1k3TUlNZmZ1VUM4Zk5aL2p1ZCtnZ0hSdEl2OTh1QjU3TElyNGgyVVpleXIx?=
 =?utf-8?B?R2FSVHNIc3dnTUpyNWZlUzdVa29UY3pJdnBtMDlRMStnNUlCNzUrS3lCc0pl?=
 =?utf-8?B?MC9hUFgrYlltR2U5Y0VkMmdrVWR1VGE1bEZhalNQNjJnbkRPT012UjFoU1dz?=
 =?utf-8?B?b0U1ZEdpbC92eGVOREFKUGNjKy9HUmhEYmgyalZxK25pRkk1R0IvS2VNblMw?=
 =?utf-8?B?Y3hVSi9SQ2R1Q01Xek80WDJzVkQ4UUxxYTZtbE9vVTBpOFVJSitmUk4rVW9a?=
 =?utf-8?B?ZVVPbkxoZ216NkhXZzVkcjZFaTB1bVZIVkdSUURhWXNhS3JpQjBiZ2xEZGpu?=
 =?utf-8?B?T0pDd1VuOGZSa1FEdnFCMHdqQUE1bUFVd1BCd2haK1llK2d4SnZsUGM4TzVy?=
 =?utf-8?B?WjFXNHVRWEZJRlM2UUZMa2o3ek9iTjhWTTdXbUkvSktuM2NYeFptREpmT1Nz?=
 =?utf-8?B?S1dvUy85RE9RdGtObUNuRXowTmUwYTAxdTltd1NhV2xYM0VYSDhCTUVMWG5Y?=
 =?utf-8?B?bitFN2c4SVFtK2VLWThoOUVEU3NpZEFjUXVCc0MvcTk3NlpRdTlxaUVaWjdU?=
 =?utf-8?B?bHlwTjZqNUdqYUdLdUYyRVl5MXZMcEduZjIxbUs0Z0t0WFIxNGh2dlZ6ZXEw?=
 =?utf-8?B?cGsxeW5MTC95TlBXYjZ3ZzhvSHNLbGFQc1VZckpIMkx5dmRsZnVXWUZQb2Mw?=
 =?utf-8?B?SWxQTVhhcFZ6eVFDMEtZemo3RURuMFV1VDhWdG4rUGYvekJ6WG1XNU5mUFUx?=
 =?utf-8?B?bW9UdnI1MnV6VmZoNjIwY2ZrVWNHMHAzRWRRSnJueDRRR1dTdkw2OXZGNHVW?=
 =?utf-8?B?bU9DdXRvbHIwZ0xaSE5LOWI2Vy9LUGdWWEdIVXYreXp6QVZNTEZXU1hZb2FR?=
 =?utf-8?B?TUxyTTh4akpZaTZjQmFMMkUrL3cyd2xvTzcrU3BBQ2J6dGFXSlBNS0RsKzkz?=
 =?utf-8?B?VS9PaDR4TlEyMHBiUkIwQ0FkbVpDam4xcVNQRVFCcnhRem40bUlZK0JPcEZq?=
 =?utf-8?B?c09VOUZzV1ljck03bU5obURGaHpKSmlyTlJaNy9hMHZsZVBEcWFoQzlNdm1D?=
 =?utf-8?B?cGRoTmZnRHlRb08yN2NxZUp6MTAyRE9RYlZQaHhYY2IxWDRYQXIzTnVzZXNw?=
 =?utf-8?B?VGM2UUN6N2ZzQjdLUk1RMGJPbldXR2U1a0dBUHJJYTFKMDdLYXZ4VVFIekJL?=
 =?utf-8?B?Qzlyam95NTVybENkSTlHZG0vVm45Q0lxMWRCZkZDRy9wLzlDclBKZHpYcjlS?=
 =?utf-8?B?V0VUWHZxTG42c1BZL1dMYTh6dnB5eWJmK3BuTkxzcUdmVW1pSm5RY0F3dGI3?=
 =?utf-8?B?aThUZERoU3paY0RtajdaVE4ybnZVb2IxU01IeXorZDU1TmRKTFZZNDBvaU1x?=
 =?utf-8?B?UkI3eDJMRVFTdnNrNFlqaDU3YVpoNUVKd3lHOHRmVWJKMU1lc2tKNThqQ3ND?=
 =?utf-8?B?OFdadjlJOWtTUmNrZC8rTU8vTkZXNDhJYmZUT2dEeWl2ZXU0NGQ1VThRTHZk?=
 =?utf-8?B?bmhQWitNWHByWGlVdFplcjVkVEZYVVBFSlcrZG1tWFJBZGNxeFRpd1lPVmhv?=
 =?utf-8?Q?Zx5O2D5vPetNz8WDvAZMuV9Tn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bd5b1b2-c94e-47c7-3a9c-08dbb3e1fb3a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 22:45:36.8620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RJrjkvjzCt2y4AFHQJiz2ruoY1ZFjggY6NHRT0P4K9iW6r62/TI9WoxGHo8tS8WQl+/HL1GDMTiqoo4SREv1WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4386
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/28/2023 12:35 AM, Lukas Wunner wrote:
> On Tue, Aug 15, 2023 at 09:20:41PM +0000, Smita Koralahalli wrote:
>> According to PCIe r6.0 sec 6.7.6 [1], async removal with DPC may result in
>> surprise down error. This error is expected and is just a side-effect of
>> async remove.
>>
>> Add support to handle the surprise down error generated as a side-effect
>> of async remove. Typically, this error is benign as the pciehp handler
>> invoked by PDC or/and DLLSC alongside DPC, de-enumerates and brings down
>> the device appropriately. But the error messages might confuse users. Get
>> rid of these irritating log messages with a 1s delay while pciehp waits
>> for dpc recovery.
> [...]
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> 
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
> 
> The subject is slightly inaccurate as this doesn't touch pciehp source
> files, although it is *related* to pciehp.
> 
> As an example, a perhaps more accurate subject might be something like...
> 
>    PCI/DPC: Ignore Surprise Down errors on hot removal
> 
> ...but I don't think it's necessary to respin just for that as Bjorn is
> probably able to adjust the subject to his liking when applying the patch.
> 
> Thanks a lot for patiently pursuing this issue, good to see it fixed.
> 
> Five years ago there was an attempt to solve it through masking Surprise
> Down errors, which you've verified to not be a viable approach:
> 
> https://patchwork.kernel.org/project/linux-pci/patch/20180818065126.77912-2-okaya@kernel.org/
> 
> Lukas

Thanks for the review. Would it be possible to consider this patch as a 
standalone while I work on 10-bit tags enumeration? I can do v5 for this 
patch with $SUBJECT changes and also include clearing Atomic Ops and 
10-bit tags unconditionally on hot-remove if that works..

Thanks,
Smita
