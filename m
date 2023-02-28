Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372866A5094
	for <lists+linux-pci@lfdr.de>; Tue, 28 Feb 2023 02:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjB1BS3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Feb 2023 20:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjB1BS2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Feb 2023 20:18:28 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F7610404;
        Mon, 27 Feb 2023 17:18:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTRxe5cVf/1XY2yoSR9xjQUFgGye2myFkT1cWvUdUvmQpP7VCsgJ6Vi+ESHKqzMqrHB6THNJVByp+U2tK8U9Xu8lbJNPH+GrFMGUphgLXCQBeVJXrK+MEmztJCYEO8fGsWvgjI8x/sohCiRK+p79Y1BHUpoHOzTeV88RT48EATC7brclJjNDzCDhXD/UHAj9BeyMK9bzO+soulXMl5q+UIGbmGPdkd5A+xwiAIr7XrmapVijiZN1lTnSGFDGBIcEe3NGbV73w7sCA2GLMrKoCagmp2IWKEwebWdWkYXnneJtqeuXCh0J40//OA8+fobnN2v5lSXpjQBl4pb3ivY+Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=577rYzv9u6a6mZu4hlzMQAIqAh+JtgHkxNfWZFzSUL8=;
 b=W80wDDdx21CvIHSmPIfNZKV8gRPSTewQIlw4kbDb5FU3D32wOJEhw/Nl/KvHlPiyAzbMx3msxn+9ScMZ9ljCHFs3BizIovAiqp/kLuylAIe47bQGGFSRiZxhSpehTpoJkjRVQ7I5DsKmK9hvRcRUrv5Xng556AB7uWfg2Z7ALkrzrxDcOSz+2txVkdQQ2i4PSsK4oBomCVjjgUdOwSIzVPcpxKWlhMPbCS/HMFOXW6OJa0JmvfnMrct8mdWMdhkEV7yvPZBSRol9AIs9gycmW/xa66+lF2rgtMTPh6Z/QWxi5nxyCBtHSEMH8u70hJpPRLNo3q4A/2Mq/nJCcTZ8EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=577rYzv9u6a6mZu4hlzMQAIqAh+JtgHkxNfWZFzSUL8=;
 b=APFgAmN/g5GzxrRACepyE/h5ACyVfVObanS+UUjxQbxJ2PWqLlx5AkZODndsM4rUBy4FTeJwhr4FVdva9aXsOiVKQsmI0E4ZgGinhD8dJ2XQbgGs9PvWZgT0LctQ8wYSy4HAhlf36zw/Op2YyUE8n8lFR5tc2qukqI1n5H+P980=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2843.namprd12.prod.outlook.com (2603:10b6:5:48::24) by
 CY8PR12MB7414.namprd12.prod.outlook.com (2603:10b6:930:5e::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.25; Tue, 28 Feb 2023 01:18:23 +0000
Received: from DM6PR12MB2843.namprd12.prod.outlook.com
 ([fe80::1185:1d60:8b6e:89d3]) by DM6PR12MB2843.namprd12.prod.outlook.com
 ([fe80::1185:1d60:8b6e:89d3%7]) with mapi id 15.20.6134.029; Tue, 28 Feb 2023
 01:18:23 +0000
Message-ID: <bc150b29-ee21-b033-7d05-dd28dd7a1af4@amd.com>
Date:   Tue, 28 Feb 2023 12:18:07 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 12/16] PCI/DOE: Create mailboxes on device enumeration
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci@vger.kernel.org
Cc:     Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linuxarm@huawei.com,
        linux-cxl@vger.kernel.org
References: <cover.1676043318.git.lukas@wunner.de>
 <c3f9e24fffa318a045f89664fb9545099cb0d603.1676043318.git.lukas@wunner.de>
From:   Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <c3f9e24fffa318a045f89664fb9545099cb0d603.1676043318.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:3:17::24) To DM6PR12MB2843.namprd12.prod.outlook.com
 (2603:10b6:5:48::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2843:EE_|CY8PR12MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: 5714f17e-3f33-43ad-2c69-08db1929afa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ijpp+XSjvBjOSFP72xRgumDwiXEgOf0XgtiZKuxCl04goU25O0NZsJPHkfdp5+jW4g9OM6NsdK7IRw/X2ieO7gAum7zn8zyHzLV4YgpvUODRqE9De4UDriJa7ClwZDbRokX9dqSuYGkZ7f8kDWFukCbYT5UtfRoL2O5rm69p+eHaJyyOZhpi7MAFZvThbTslJG/USv7LjZl0i5lNGPDJHj0DraiNAeFnWaWrYhhIJCnhqBccL8vIJx+JyHI4u3Ws9JsE9Qa4Jy5jPGrB/xhQmcpsvzTNyKVcWf7XY7moAHb5VqsquHz3MzeRnu5gIhwCD+GvdGL07/G6esjroJv4Z3rCjryGnheumybT/UIiaWxzYWsZQRLh8SsZj2p5KL12lQkztyKEgoHiD+OiVmLsYg6TcgG83+Rcrizixn/xCMFs0kpnZPLsZNSLnq0HplcCE/dJS3HOD/eSPOCEjVscIINXAu/deqVIK2VHdoEaAEyR9MGKe8nlYIs3tBhaZw+Vu/fLNIkxudIchCKib6ckTsJwz/eJP3k+djnqebjGlJvJ6VuW2CtBOwJmCjhqI34Sgz45XHSHTpboZHgz9Tnxgu4IiIIFxcVnTZk8nCkpYBHqOu9qKhSj7q3vY++WE9mB1fETbft86Tu0rOJJw0gCcX/96CYe7rGDzaTAWnbNQkWN60W9F4zX+xDQetpOemCTf6pDvr8/41ojrTVZNjnTp9xR9V2zb5x+fYze2RvTbfU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2843.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(451199018)(8936002)(38100700002)(83380400001)(8676002)(41300700001)(66476007)(186003)(4326008)(66946007)(66556008)(6512007)(2906002)(15650500001)(6506007)(7416002)(2616005)(478600001)(26005)(53546011)(6666004)(110136005)(54906003)(31696002)(316002)(31686004)(5660300002)(36756003)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejJUaUMvT1JoUjFlc3k3QkwxNFRFcDdwd3MrS3hUcUgrVlVLbytFbUZRNzY3?=
 =?utf-8?B?U2pkWDI4dkgrVk9HQjFhY05qRFVHOHZ2MStJZkhlaEFHVmZZS1BaZU1PWkJN?=
 =?utf-8?B?OUNjNFFJODhRM2Rja1BLRGJiYVZKVXNPU2dXaTRFSy9UdWFlNklHQ3Z6bWJ6?=
 =?utf-8?B?VDZEWGFhNEdqVng4UGpGTk80SXBtUkRHSU0xQzcydGVmMFZSaE50c0RJUHJr?=
 =?utf-8?B?RCsxRlBPQlpzZE9jUzMyb0FHSWh2aTdsZ2hkQ2llejVnRFVCVW9Tb0hLOXhB?=
 =?utf-8?B?UFd3VWlGRis4KzFaNTBLdFhVR3FHV1VCbFlobnZXQkRuVzZUcnowWXZGSWlW?=
 =?utf-8?B?OU1pZk8vT09YZDlqQ1YrY1ozeU40b25nQVFPYlU0TDY3ejgxTmV1RHFiT1VK?=
 =?utf-8?B?MHN6bGhkK1dyTTRPVHhKWmdQdkNUU0xwb1VnWUQ3ZDlyVHJvK25OYXVVcHJs?=
 =?utf-8?B?cGh0Nm5nQW9BenVLUkJEUExDWkl2a0tueE1kdUY2TStweDVPcE9JZWVLWkVS?=
 =?utf-8?B?VFZFRkd2Qk9GYWp4aGpYVjFnazFKaE5YL3JqU1pMOTQ5UVNRUnlRQzZuUTdq?=
 =?utf-8?B?c01WcE9uN3NpQ1JoUHRTNmV2SURjdFZwdVoveStWdmkwaFNjWFA5RTQ5UDhN?=
 =?utf-8?B?UGl1VHB5andWVVVGL2xnQ083SHFHdTZ5NFF3QUcvck8zajRWZmo0K3JuWGo4?=
 =?utf-8?B?VFh2TmhxcFBNTk45aHZKSzIwWVJyb0x3Ym9ycG4rSThaQ1d2ODdncnI2NnNJ?=
 =?utf-8?B?YWtzclNrVlVsNllybjVVbVhNR0NwVVBReldLYkV1dGxyWXE2LytZaW94UXU2?=
 =?utf-8?B?elpieERNZlZ2R3pUT24yT2o0K0xiUm1LcS8ybW1LOWxFWDU5OVVuNEhxS01w?=
 =?utf-8?B?TkRucWxyeEx6aFRhOGVMUkhaNUxzSjFQcmxVRHk2UUhYTXdzZm83eSt1ZFh4?=
 =?utf-8?B?bW1pa095Mkd2V3kvS1pKZU9GcG9kWUpudENMWmlReDMvakEvRUorVTVveFRF?=
 =?utf-8?B?b2twZS9oRDVoZHNROU5vNE5qYW53SHZReHloVkJBMkllWGg4YXdpdTlXM1di?=
 =?utf-8?B?S3A3UkY1LzF4bWpVdGpKUDh2dU42UGhSdHBtV2pOUUVnbTFZbWtBTWxkSGFz?=
 =?utf-8?B?SjJTdlA2MDd0RWhaYUVCZ0xlaW56bHVJUll5NnB0UDJoQy9WSjE1SGV5UGE4?=
 =?utf-8?B?M2kyekswd3h3RWRmd01RSm5Td1hGVDlzY00wS3poSW9VUnJMSTEwOWRkNHJD?=
 =?utf-8?B?VFFLOWdGb0RERmhaQWRQYjcvRGk3VFhveThmb2I1dFA4Z1RNZXNSeUFKVzFD?=
 =?utf-8?B?ckM2M21POHhYUkM4MVNzNk9aa2hwQ3ZrQTdTNmZUUVN4MWtVeHZFYXd3aStW?=
 =?utf-8?B?RGs4TVVqK0lZc3ZNSGNTNlhydVg5MVJuekVqVzR4SVdOWE51amowRHFjVDJG?=
 =?utf-8?B?c1hJM1kybW8rMTNmU0Q2YjIyT1d3NW5MZ1FpTU1LRjFQcVNrQmZXOUVDSitE?=
 =?utf-8?B?MUQ2NlN3NUlDVzhyK3ZCbnQwSUVXcC9lZEJaMVNXTzl4NU9lNWpMUUJNMHow?=
 =?utf-8?B?bUUzOFlidjhGTDcyUnF1Zis5Y0w5aFJnVzRlWk9yUGFNSDlJT3hVcWRpbmx4?=
 =?utf-8?B?VFVYRWRjanZQOGUxOFdRRDdmdFZMNGFZSTE2cmV1T0g0R3pzZUhweEpjMEsv?=
 =?utf-8?B?ZSsrbXdxMWFrUXhlZVJiOUtWbDVQdTUyQ1cyT0xYNnVQSm1CT0dHM1RkcWNr?=
 =?utf-8?B?WCtBS25CTzFzVlpkc3A1UzNTMlRFeTZLZGk5eVpiTVpmS2lIS2VEQ2RBMFVl?=
 =?utf-8?B?ODZnWmppZWhxWmVVamxVek43RVRrZ2xwUTJvYlJSUmsvdk9QbkhaQkNjeDBZ?=
 =?utf-8?B?RE1YdjV0aDAxY1pROXhFRTdLR011QnlDb0hxT1JRZU93cG9US21pdzFSUVA1?=
 =?utf-8?B?MjVTaWtET1ZXeGJKK0pFQTBjQnorTE5KdksyU1VnNlNvSWZSaDdxTUJBQVky?=
 =?utf-8?B?YmFsaU1iNVVycEpsVU94c2VKODdaNW5uZ2dkbVJGYkR1N1p0UGZkQ0dXWFBE?=
 =?utf-8?B?aVlXUXArbjgxRG0zeXN1cHQ3RTh2MUJuMEc0ZUc0aUtGUnFpS00xRGNua1p1?=
 =?utf-8?Q?Ql+UxPvdCg76+K618t2XEllCf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5714f17e-3f33-43ad-2c69-08db1929afa4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2843.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 01:18:23.6838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zkXm1DM5CXfnuJcR9g+sssyYXrFfqRvAYEIZcBBf0RtnHceSyw90+F655vOMeLgnN/M3hQGUbFSO28RLuhjpHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7414
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/2/23 07:25, Lukas Wunner wrote:
> Currently a DOE instance cannot be shared by multiple drivers because
> each driver creates its own pci_doe_mb struct for a given DOE instance.

Sorry for my ignorance but why/how/when would a device have multiple 
drivers bound? Or it only one driver at the time but we also want DOE 
MBs to survive switching to another (different or newer) driver?


> For the same reason a DOE instance cannot be shared between the PCI core
> and a driver.

And we want this sharing why? Any example will do. Thanks,

> Overcome this limitation by creating mailboxes in the PCI core on device
> enumeration.
> 
> Provide a pci_find_doe_mailbox() API call to allow drivers to get a
> pci_doe_mb for a given (pci_dev, vendor, protocol) triple. 
 >
> This API is
> modeled after pci_find_capability() and can later be amended with a
> pci_find_next_doe_mailbox() call to iterate over all mailboxes of a
> given pci_dev which support a specific protocol.
> 
> On removal, destroy the mailboxes in pci_destroy_dev(), after the driver
> is unbound.  This allows drivers to use DOE in their ->remove() hook.
> 
> On surprise removal, cancel ongoing DOE exchanges and prevent new ones
> from being scheduled.  Thereby ensure that a hot-removed device doesn't
> needlessly wait for a running exchange to time out.
> 
> Tested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   Changes v2 -> v3:
>   * Don't cancel ongoing DOE exchanges in pci_stop_dev() so that
>     drivers may perform DOE in their ->remove() hooks
>   * Instead cancel ongoing DOE exchanges on surprise removal in
>     pci_dev_set_disconnected()
>   * Emit error message in pci_doe_init() if mailbox creation fails (Ira)
>   * Explain in commit message that pci_find_doe_mailbox() can later
>     be amended with pci_find_next_doe_mailbox() (Jonathan)
> 
>   drivers/pci/doe.c       | 73 +++++++++++++++++++++++++++++++++++++++++
>   drivers/pci/pci.h       | 12 +++++++
>   drivers/pci/probe.c     |  1 +
>   drivers/pci/remove.c    |  1 +
>   include/linux/pci-doe.h |  2 ++
>   include/linux/pci.h     |  3 ++
>   6 files changed, 92 insertions(+)
> 
> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> index 2bc202b64b6a..bf32875d27da 100644
> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c
> @@ -20,6 +20,8 @@
>   #include <linux/pci-doe.h>
>   #include <linux/workqueue.h>
>   
> +#include "pci.h"
> +
>   #define PCI_DOE_PROTOCOL_DISCOVERY 0
>   
>   /* Timeout of 1 second from 6.30.2 Operation, PCI Spec r6.0 */
> @@ -658,3 +660,74 @@ int pci_doe(struct pci_doe_mb *doe_mb, u16 vendor, u8 type,
>   	return task.rv;
>   }
>   EXPORT_SYMBOL_GPL(pci_doe);
> +
> +/**
> + * pci_find_doe_mailbox() - Find Data Object Exchange mailbox
> + *
> + * @pdev: PCI device
> + * @vendor: Vendor ID
> + * @type: Data Object Type
> + *
> + * Find first DOE mailbox of a PCI device which supports the given protocol.
> + *
> + * RETURNS: Pointer to the DOE mailbox or NULL if none was found.
> + */
> +struct pci_doe_mb *pci_find_doe_mailbox(struct pci_dev *pdev, u16 vendor,
> +					u8 type)
> +{
> +	struct pci_doe_mb *doe_mb;
> +	unsigned long index;
> +
> +	xa_for_each(&pdev->doe_mbs, index, doe_mb)
> +		if (pci_doe_supports_prot(doe_mb, vendor, type))
> +			return doe_mb;
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(pci_find_doe_mailbox);
> +
> +void pci_doe_init(struct pci_dev *pdev)
> +{
> +	struct pci_doe_mb *doe_mb;
> +	u16 offset = 0;
> +	int rc;
> +
> +	xa_init(&pdev->doe_mbs);
> +
> +	while ((offset = pci_find_next_ext_capability(pdev, offset,
> +						      PCI_EXT_CAP_ID_DOE))) {
> +		doe_mb = pci_doe_create_mb(pdev, offset);
> +		if (IS_ERR(doe_mb)) {
> +			pci_err(pdev, "[%x] failed to create mailbox: %ld\n",
> +				offset, PTR_ERR(doe_mb));
> +			continue;
> +		}
> +
> +		rc = xa_insert(&pdev->doe_mbs, offset, doe_mb, GFP_KERNEL);
> +		if (rc) {
> +			pci_err(pdev, "[%x] failed to insert mailbox: %d\n",
> +				offset, rc);
> +			pci_doe_destroy_mb(doe_mb);
> +		}
> +	}
> +}
> +
> +void pci_doe_destroy(struct pci_dev *pdev)
> +{
> +	struct pci_doe_mb *doe_mb;
> +	unsigned long index;
> +
> +	xa_for_each(&pdev->doe_mbs, index, doe_mb)
> +		pci_doe_destroy_mb(doe_mb);
> +
> +	xa_destroy(&pdev->doe_mbs);
> +}
> +
> +void pci_doe_disconnected(struct pci_dev *pdev)
> +{
> +	struct pci_doe_mb *doe_mb;
> +	unsigned long index;
> +
> +	xa_for_each(&pdev->doe_mbs, index, doe_mb)
> +		pci_doe_cancel_tasks(doe_mb);
> +}
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 8f5d4bd5b410..065ca9743ec1 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -318,6 +318,16 @@ struct pci_sriov {
>   	bool		drivers_autoprobe; /* Auto probing of VFs by driver */
>   };
>   
> +#ifdef CONFIG_PCI_DOE
> +void pci_doe_init(struct pci_dev *pdev);
> +void pci_doe_destroy(struct pci_dev *pdev);
> +void pci_doe_disconnected(struct pci_dev *pdev);
> +#else
> +static inline void pci_doe_init(struct pci_dev *pdev) { }
> +static inline void pci_doe_destroy(struct pci_dev *pdev) { }
> +static inline void pci_doe_disconnected(struct pci_dev *pdev) { }
> +#endif
> +
>   /**
>    * pci_dev_set_io_state - Set the new error state if possible.
>    *
> @@ -372,6 +382,8 @@ static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
>   	pci_dev_set_io_state(dev, pci_channel_io_perm_failure);
>   	device_unlock(&dev->dev);
>   
> +	pci_doe_disconnected(dev);
> +
>   	return 0;
>   }
>   
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 1779582fb500..65e60ee50489 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2476,6 +2476,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
>   	pci_aer_init(dev);		/* Advanced Error Reporting */
>   	pci_dpc_init(dev);		/* Downstream Port Containment */
>   	pci_rcec_init(dev);		/* Root Complex Event Collector */
> +	pci_doe_init(dev);		/* Data Object Exchange */
>   
>   	pcie_report_downtraining(dev);
>   	pci_init_reset_methods(dev);
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index 0145aef1b930..f25acf50879f 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -39,6 +39,7 @@ static void pci_destroy_dev(struct pci_dev *dev)
>   	list_del(&dev->bus_list);
>   	up_write(&pci_bus_sem);
>   
> +	pci_doe_destroy(dev);
>   	pcie_aspm_exit_link_state(dev);
>   	pci_bridge_d3_update(dev);
>   	pci_free_resources(dev);
> diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
> index 7f16749c6aa3..d6192ee0ac07 100644
> --- a/include/linux/pci-doe.h
> +++ b/include/linux/pci-doe.h
> @@ -29,6 +29,8 @@ struct pci_doe_mb;
>   
>   struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset);
>   bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type);
> +struct pci_doe_mb *pci_find_doe_mailbox(struct pci_dev *pdev, u16 vendor,
> +					u8 type);
>   
>   int pci_doe(struct pci_doe_mb *doe_mb, u16 vendor, u8 type,
>   	    const void *request, size_t request_sz,
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 3c51cac3890b..b19c2965e384 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -511,6 +511,9 @@ struct pci_dev {
>   #endif
>   #ifdef CONFIG_PCI_P2PDMA
>   	struct pci_p2pdma __rcu *p2pdma;
> +#endif
> +#ifdef CONFIG_PCI_DOE
> +	struct xarray	doe_mbs;	/* Data Object Exchange mailboxes */
>   #endif
>   	u16		acs_cap;	/* ACS Capability offset */
>   	phys_addr_t	rom;		/* Physical address if not from BAR */

-- 
Alexey

