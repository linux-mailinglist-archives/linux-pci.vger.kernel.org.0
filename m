Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45377BA98C
	for <lists+linux-pci@lfdr.de>; Thu,  5 Oct 2023 20:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjJES4g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Oct 2023 14:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjJES4e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Oct 2023 14:56:34 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07569E;
        Thu,  5 Oct 2023 11:56:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjNNgxoyNi6tbJcchsRYjEpSrtZ/ebIBmn5awI8HcBkU2uWWRfQ9eHtQR4f3PMb3GH9UDjeQGCxRbUUrdTibAQEP8aSuHO6dYXeoEfCWbtHrO3I4RryNbxLYBrJEINqWygnStI1KB604RQgXwvHnSpvheHMTU12DTzf6Q/sdqm9FGZ+nS0GVcHcItNraMis5TJIdHwtO8sDB7tKB7+etEcuE123g4VSPHemM4mWE9fevjP1T4Zjf8AN8u/f3JCJmyE13CZ/oSyJrIoovIFclJj0/MnS0kU4LYmvjBI9lOiD+sWSzdzdzNVFcTvO0sfY18lYrR+lLOhyXC8k6Pz1Jtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yhedt/g4gPsW0NY6AoCSkkLlHYWweq1BZPrdjCC3z9Q=;
 b=e4CRZlpv3TKD5hUX2d+pGRs/TCXS8sKYdMFV2r2tEoERw0MGY8mFl3i69974V3LEgwYLxI5fx4w9xNMWQwZ0pxkSRfpo7cJq8ZgNjlaYJPDHFAm3lFxBYMkw6qQv1LoyBqvYyPC69MQenzyj/9dkApPXglCFTtiH8zaAMjJW6+OoCbQXEqetcsDkAdbNWsjuVXBRaNMffwTM7r8Qq4jaUq+m0l4s3rr3dSUkfzuUNBxTVYfpC8pcF4o+qdIvkxv+oAfmfIiDLbLF9Q4ovHYVfvV/8j0RqLnJKdjdvYdtyswZ5fI7KQT5Ki8V8DpKhubsqNCf3vVl1MCOUxpE3kpXjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yhedt/g4gPsW0NY6AoCSkkLlHYWweq1BZPrdjCC3z9Q=;
 b=ycXNL4hqk/z5KybbF7uj5irjTtOPAktY1SDa6yhgYDR9QZd/q2Nl4mU7Zo0uAmpcAbAiJCN7f6VN5SYiq9fMiDmhpZBh/pAPAeMzKbOJYTVyVD6K10D784jzObs1PfpQ0LI6moLSLRfR9eh1JkaJ6o/2x0+JtemdXdny+/qxhro=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Thu, 5 Oct
 2023 18:56:30 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4%3]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 18:56:30 +0000
Message-ID: <6a7b4b03-0bb4-492f-bcac-d4e9fd1a81ac@amd.com>
Date:   Thu, 5 Oct 2023 13:56:27 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: Make d3cold_allowed sysfs attribute read only
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, lukas@wunner.de, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, mika.westerberg@linux.intel.com
References: <20231005185315.GA785324@bhelgaas>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231005185315.GA785324@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0054.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::29) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ1PR12MB6363:EE_
X-MS-Office365-Filtering-Correlation-Id: 776c3078-f48a-41d4-670c-08dbc5d4c917
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ao7o9NTxGbMM+E28Z1GEWsEHKUAHEeH2j0mso99wVYwC33e0RptOz+jV6WQnoDsIZyTdKFT9Yuf46F1xZJ0eqYzgNXibSvTfioX6LptOgaKdWho5SrzBmAlsPp0OSqqPQw/6z1yxSbutVUc93xUxQOk3kVEI1Z9+yanzdYidl8ZCo23H/pYsT91NZlXg11imPjJtixBt2h9HXYgDTqAFHhTbBBjtyngr2MGzkSz5p5GKYSeBhVcQwwrHMEs7L0ZH0orHpB6joFGTF5HhOiR3hRoxqWmXL0IwLGIRk9TKgaB0ZpZXpKhRAkio+hmXc1xq6B7q15e6Zk1qoWA/CoQ+AJ3Z1bwYIMsq883GShOIlsYdCo6uLuD4W5P7BjxIl/XJPHW0K0+gAa21GMMwpqduGR/1cDBehXMDqwMELmy/cx5EvOdlWDcGZ7aeslFa7djEcU2dSUZlDT5sZ4fAR+qOyVFh5HKfiG2OB5E3OarvVwrwPClhT8uWAA6hsRkI6uGePADH99jYH3zgESfNOdCOG9jgPnsd8JmMedQr+D2G5wnu70HRac9d96GI9eAyyyWUIqkhw0yib/dv/IMXc8I9lLyQ4QWhHqCy/+OSoRQiRHGY9X9ryrNsKQjnnMOEt6A4ACmk7Rsni47DKpoJwF7lfMjIH730vgE/rmUT/B5ZiBQFaX76TKQsMt8FyewYpW11uZU3Sto0+rngHKMibd3bQ9ay9LXKSB8n5gRzBk1A/+I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(346002)(366004)(136003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(2906002)(31686004)(44832011)(8676002)(8936002)(5660300002)(4326008)(41300700001)(66946007)(6916009)(316002)(66556008)(2616005)(66476007)(26005)(36756003)(6506007)(6666004)(53546011)(6512007)(83380400001)(86362001)(31696002)(6486002)(478600001)(38100700002)(43740500002)(45980500001)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2pmbko1cXVQWEovQkdvZHd3bWZ3MVVxUWk0dENzRDRteGNJWitWM01MblZV?=
 =?utf-8?B?aFEwYVBCS1dEUVE3K05lQjJIS0Zkb2hWS0NHQmlnWWlVOTRhYThhSDN0N3A5?=
 =?utf-8?B?RHRYT1l2NkE1TzZtcFE3M2hHd3JCVHVGckN5dHF0UEN6bllHSVBBN2ljWXd4?=
 =?utf-8?B?VzZBQ0xJUk5ZQlYwai9GaGszZ3BWTUd2ZWxzTTNxT1lDdXg5R3N4ckRjMFhk?=
 =?utf-8?B?akplVTdLbzhCc0tmeStET2lrSzhtcUVQRG9ST2JTYlpYWXNhMjBPSTgrQ0Fu?=
 =?utf-8?B?Zm1uT3hONHVTWnduRXZOM3pJUWdacE1KTzlaVm1wRTlKSFdubDIwb2hZVG0z?=
 =?utf-8?B?b2tPNW9rcVN2YlA4SCtMSmVYZERnMSswK0t4aG9wTlgzSUJvaFdjZmVZcXNJ?=
 =?utf-8?B?R05pQ3FQbGw4WUxWc3ZIOEhsYjJkVUpvK08yTUJSY3lCMG1OZCtrS2pEYnhJ?=
 =?utf-8?B?RXczejcvQmFQRm0wRXU5a2VLNVhGbm5oVjFQRWVmOWs3aGRwMlN3NkdMVHhq?=
 =?utf-8?B?NENaQllyQlAwcGQxN2tCZVREQ2I4K1ZCUzVJa2JrRTIyMDkvVUoyb3RrYXcr?=
 =?utf-8?B?bHJtN3kxU1pHb1gzVUFMT2VpWGZtMWh0TGdJME8yL2syT080OEVPcmkwUEZj?=
 =?utf-8?B?VG5qUUE1SjhpTU9IamU5U2VLMlNZZENrN0FMclhHbFk2KzJSWDh0ekFyVmVS?=
 =?utf-8?B?SUNjVGNKSGUyMzhrMEJ0RDdCUVdnaE1MdWEwdyszc3VkSDRmV25zMEhnMUY0?=
 =?utf-8?B?ektXb2h0OTA3SzJ5STNBSmc0ZlFOZXRKUlg4dWxYVUtYWWRFak1xaWxsN1dk?=
 =?utf-8?B?NXpkbGs3U2dUTy9RcHFkeW9pdHh1a0g5M1RBZ2lLQ0l3VVBtYjF0WWpaWHlw?=
 =?utf-8?B?NGdyVXUvQXhXWENpTUxOYU9WQXYzWVNER1pmUXVQMEJGMTc5T3pzcWRjb29i?=
 =?utf-8?B?bXZMSFBSRm1SMnRjb2hPYitCS0xGVGpTVElBQldKWDQ5bWZ5b2V0eWlacjJL?=
 =?utf-8?B?OHh1K0oxSnZYUHB2V1RYdVhIWXl2OUJtdU1uTU1GcE1CZTJXQW9GbjlIUzJQ?=
 =?utf-8?B?bSs0M2hSYkV3d21JZi9iZ2U1d3RSK1Y1ZmtNNnpzeWNYRUtmcWJtZGhGNElh?=
 =?utf-8?B?Um1DYjNaUklVWGxnelFuQUFzMml0Y1JOV2JQQ1cycG1IaFVhZFBDS2F0NmFX?=
 =?utf-8?B?Mmo2RFBJaUhObk85SjhycThUNTQ0eC8rbHltZk42UmFDQ25CaWNabFJlSDNZ?=
 =?utf-8?B?blNOS3RIVCtXdlBPTXVhZzZZVWh6TTFIbTJoUlQvZk1JV3ZDdkRNNXBQck4v?=
 =?utf-8?B?QnU4d2QvMXJ5aHRCRWVKNUNjanJNTTNydEFRclFPNFZxNmRaRHhyeGQ1Mk8w?=
 =?utf-8?B?cm5rZmVUc3hTOWVvRjhNTm5ScWVyVGh2ZFlkejN3aE0vZTZsTlh0ZlgrNnhD?=
 =?utf-8?B?cTlHTGNvVXVJb3Fvam92aHFnMGlXVUxyeGk3NzNhQVpYUEplNTF5RGtrUFVQ?=
 =?utf-8?B?WVpVZGFZZ1pWNXN6a2F6UHFtdEdSbDNmaXdUZUkwRTk3ZDErVUM3Um9SS3FI?=
 =?utf-8?B?N0dsMkJwZFVxM2JESEIyUGllcS8wTkttQUtNOVpKM0tzUHdxUHUzNFhIK0la?=
 =?utf-8?B?bmdrVjlSZE1MYkVjUEdEU05mS2x4dlZ1OVBYMW41N2tydGdBVkFjdHB4cjh0?=
 =?utf-8?B?R05LczZ4Y0ZsTmFVdGlzRENQem9iVHMrbDI1OUtUZWYycmhGY0tBbkdyM1Y3?=
 =?utf-8?B?N0lPVnlxN0dCSFhLaytBYzJXOVN5bjJHcEFjZFRXL0V0QmZqQ3FQOTZLelI1?=
 =?utf-8?B?d3dYTDIyNGZqS3Q4VS9LMWRSNkI4dkNjbEkzRW02RmRMcS9wa1FjQnZPZDFy?=
 =?utf-8?B?RlBXWTE5YXNidzJNV3FraCt4U2ZZV3l4b29SdTBsWElZS01NR2RzRzhwNHlv?=
 =?utf-8?B?TzFaa2NXOE8xb2RNbk84SnFVNk90SHFJUDFnbTg5MVV4U1pQY0VBYnJGeEJt?=
 =?utf-8?B?QmlONk9VRFNaQUsrUmZXOWQ5QzI4UmhrYkR6Y0F0QW5sN29JU3hlNi90UkV4?=
 =?utf-8?B?VUJQS3R4NlRRbXVBL2xaa09mdmx0QlJaK21nTGZEcDM2K2psSEx3TEM0Z3BD?=
 =?utf-8?Q?//f7TUsUKc1xEbXaZWHkjbkkL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 776c3078-f48a-41d4-670c-08dbc5d4c917
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 18:56:30.1903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9+WyCf58BcZmb0cSlWWEYUQwKRZXwY4rY8lRy37kTc6jkf4Ke+Tw3tWXUiB2IFRB6Pidsxu1mgQpzXpOqBi2Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6363
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/5/2023 13:53, Bjorn Helgaas wrote:
> On Wed, Oct 04, 2023 at 09:47:31AM -0500, Mario Limonciello wrote:
>> Before d3cold was stable userspace was allowed to influence the kernel's
>> decision of whether to enable d3cold for a device by a sysfs file
>> `d3cold_allowed`.  This potentially allows userspace to break the suspend
>> for the system.
> 
> Is "Before d3cold was stable" referring to a "d3cold" read-only
> variable, or to Linux functionality of using D3cold, or ...?

I was referring to the previous thread's comments when I asked about the 
history on it.

> 
> In what sense does the `d3cold_allowed` sysfs file break suspend?

SoCs might not be able to get into their deepest sleep state if 
userspace messes with it.

> 
>> For debugging purposes `pci_port_pm=` can be used to control whether
>> a PCI port will go into D3cold and runtime PM can be turned off by
>> sysfs on PCI end points.
> 
> I guess this should be "pcie_port_pm=", which affects *all* PCIe
> ports?

Yes.

> 
> Which sysfs file turns off runtime PM for endpoints?

/sys/bus/pci/devices/*/power/control

> 
>> Change the sysfs attribute to a noop that ignores the input when written
>> and shows a warning. Simplify the internal kernel logic to drop
>> `d3cold_allowed`.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v1->v2:
>>   * Leave R/W and show a warning instead
>>   * Mark deprecated in sysfs file
>> ---
>>   Documentation/ABI/testing/sysfs-bus-pci |  4 ++--
>>   drivers/pci/pci-acpi.c                  |  2 +-
>>   drivers/pci/pci-sysfs.c                 | 14 ++------------
>>   drivers/pci/pci.c                       |  3 +--
>>   include/linux/pci.h                     |  1 -
>>   5 files changed, 6 insertions(+), 18 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
>> index ecf47559f495..b5db141dfee6 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-pci
>> +++ b/Documentation/ABI/testing/sysfs-bus-pci
>> @@ -283,8 +283,8 @@ Description:
>>   		device will never be put into D3Cold state.  If it is set, the
>>   		device may be put into D3Cold state if other requirements are
>>   		satisfied too.  Reading this attribute will show the current
>> -		value of d3cold_allowed bit.  Writing this attribute will set
>> -		the value of d3cold_allowed bit.
>> +		value of no_d3cold bit.
>> +		Writing to this attribute is deprecated and will do nothing.
>>   
>>   What:		/sys/bus/pci/devices/.../sriov_totalvfs
>>   Date:		November 2012
>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>> index 05b7357bd258..a05350a4e49c 100644
>> --- a/drivers/pci/pci-acpi.c
>> +++ b/drivers/pci/pci-acpi.c
>> @@ -911,7 +911,7 @@ pci_power_t acpi_pci_choose_state(struct pci_dev *pdev)
>>   {
>>   	int acpi_state, d_max;
>>   
>> -	if (pdev->no_d3cold || !pdev->d3cold_allowed)
>> +	if (pdev->no_d3cold)
>>   		d_max = ACPI_STATE_D3_HOT;
>>   	else
>>   		d_max = ACPI_STATE_D3_COLD;
>> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
>> index 5e741a05cf2c..52ed5a55a371 100644
>> --- a/drivers/pci/pci-sysfs.c
>> +++ b/drivers/pci/pci-sysfs.c
>> @@ -523,17 +523,7 @@ static ssize_t d3cold_allowed_store(struct device *dev,
>>   				    struct device_attribute *attr,
>>   				    const char *buf, size_t count)
>>   {
>> -	struct pci_dev *pdev = to_pci_dev(dev);
>> -	unsigned long val;
>> -
>> -	if (kstrtoul(buf, 0, &val) < 0)
>> -		return -EINVAL;
>> -
>> -	pdev->d3cold_allowed = !!val;
>> -	pci_bridge_d3_update(pdev);
>> -
>> -	pm_runtime_resume(dev);
>> -
>> +	dev_warn_once(dev, "pci: writing to d3cold_allowed is deprecated\n");
>>   	return count;
>>   }
>>   
>> @@ -541,7 +531,7 @@ static ssize_t d3cold_allowed_show(struct device *dev,
>>   				   struct device_attribute *attr, char *buf)
>>   {
>>   	struct pci_dev *pdev = to_pci_dev(dev);
>> -	return sysfs_emit(buf, "%u\n", pdev->d3cold_allowed);
>> +	return sysfs_emit(buf, "%u\n", !pdev->no_d3cold);
>>   }
>>   static DEVICE_ATTR_RW(d3cold_allowed);
>>   #endif
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 59c01d68c6d5..8c5a6f68f63d 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -3067,7 +3067,7 @@ static int pci_dev_check_d3cold(struct pci_dev *dev, void *data)
>>   	bool *d3cold_ok = data;
>>   
>>   	if (/* The device needs to be allowed to go D3cold ... */
>> -	    dev->no_d3cold || !dev->d3cold_allowed ||
>> +	    dev->no_d3cold ||
>>   
>>   	    /* ... and if it is wakeup capable to do so from D3cold. */
>>   	    (device_may_wakeup(&dev->dev) &&
>> @@ -3204,7 +3204,6 @@ void pci_pm_init(struct pci_dev *dev)
>>   	dev->d3hot_delay = PCI_PM_D3HOT_WAIT;
>>   	dev->d3cold_delay = PCI_PM_D3COLD_WAIT;
>>   	dev->bridge_d3 = pci_bridge_d3_possible(dev);
>> -	dev->d3cold_allowed = true;
>>   
>>   	dev->d1_support = false;
>>   	dev->d2_support = false;
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 8c7c2c3c6c65..5f4ed71d31f5 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -376,7 +376,6 @@ struct pci_dev {
>>   	unsigned int	no_d1d2:1;	/* D1 and D2 are forbidden */
>>   	unsigned int	no_d3cold:1;	/* D3cold is forbidden */
>>   	unsigned int	bridge_d3:1;	/* Allow D3 for bridge */
>> -	unsigned int	d3cold_allowed:1;	/* D3cold is allowed by user */
>>   	unsigned int	mmio_always_on:1;	/* Disallow turning off io/mem
>>   						   decoding during BAR sizing */
>>   	unsigned int	wakeup_prepared:1;
>> -- 
>> 2.34.1
>>

