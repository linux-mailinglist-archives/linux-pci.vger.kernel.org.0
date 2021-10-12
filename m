Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8B742AE7A
	for <lists+linux-pci@lfdr.de>; Tue, 12 Oct 2021 23:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbhJLVMY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Oct 2021 17:12:24 -0400
Received: from mail-bn7nam10on2054.outbound.protection.outlook.com ([40.107.92.54]:65025
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232418AbhJLVMX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Oct 2021 17:12:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAx/yK7i9fQaqGE2qgr31cYw9A7ZpsWtlMEKdeqKxic/JCMdg8yYeSO4ei7bVWHszvi4+R5msbjOs/gic8KEgVUVoylINOnI1dagoW7qoCIP1IzOgjU66vWC802pa94VToU/dUTSej1NjA0RazweGeKdT95Dcv/uVtf/UOSOSY7H0aFwctaAIUYExlfRKyBbZ+MuyH8oQ0EpEREu6QfCiPghxGNGyjZ1PWsaTgWiAFZj6UMzY8MXwFXwKfgo3OKy7ePvdG/TKsQVbaBb+z8VsS1xyYlczlhWIXgBcnqfR5gToTKIhXVDavPUksLuygaQM6HCGUg6HI5+vz00Nsq3UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xOUGMVDk+q49fUIiFFl56XgXGghGtTtsEAHuIVQU90w=;
 b=dLAUhgvmqgShd2VUq9Z5+XDM7VSNuQoh3JuAVG8wDFdEu0d5RbZA93E0walzazKBUTuHYRMGskE7k8xRQmfk6GVRfDNubhARTfrShS7GmCuEfEc8wmE3MArKDFe0pgIC+lpqwjQls9IVn4ApLUUhFyWEELDsWr0aWXFlwSl1Rrzs2cJYNVm7g3xQHXkSWRo8/CDKKgSsl+XPV57beD7KW/uqrJJYlNOFhini54tEgkLhkVDiMrwwIHr3Q+kr9ewHEWgak5YCZwLI3jS3qPy+kUSR8Ls73y930BMBTIvJW5PtJmiajSzPsuH9DRTMnRGAtE1XPn+cbblOrKO6/Wb/zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xOUGMVDk+q49fUIiFFl56XgXGghGtTtsEAHuIVQU90w=;
 b=VJlrxyLvxHANGsXwzawDnzzV5XMt2y0I5cifq+1ZyzLTw+rKMsAq0lRIRxqplQH4gcZoXmJHCgHz9BOgZt/YZTwGe++EP4hUGtxxaBe9HujT6Z9EY5G2rjQfWOz1qXK8hSqPjHfeCNWb3O/Dj/yGS8XEWS23Ckjz59+MqmRpy7s=
Authentication-Results: rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SN6PR12MB4670.namprd12.prod.outlook.com (2603:10b6:805:11::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Tue, 12 Oct
 2021 21:10:19 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::f909:b733:33ff:e3b1]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::f909:b733:33ff:e3b1%5]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 21:10:19 +0000
Message-ID: <3e7b5acc-a3f8-09e2-7d83-bd0b58ba031a@amd.com>
Date:   Tue, 12 Oct 2021 16:10:16 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] ACPI: scan: Release PM resources blocked by unused
 objects
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <5507158.DvuYhMxLoT@kreacher>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <5507158.DvuYhMxLoT@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN6PR1701CA0002.namprd17.prod.outlook.com
 (2603:10b6:405:15::12) To SA0PR12MB4510.namprd12.prod.outlook.com
 (2603:10b6:806:94::8)
MIME-Version: 1.0
Received: from [10.254.34.155] (165.204.84.11) by BN6PR1701CA0002.namprd17.prod.outlook.com (2603:10b6:405:15::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19 via Frontend Transport; Tue, 12 Oct 2021 21:10:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f05de9d-1ed7-44fe-60c3-08d98dc4b1ee
X-MS-TrafficTypeDiagnostic: SN6PR12MB4670:
X-Microsoft-Antispam-PRVS: <SN6PR12MB467096D953B0EE36034981E0E2B69@SN6PR12MB4670.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VtV6Kk0FwYlkOkcN4puZgmvKxuk7YYSCvBCt7LY/Q4yTTcNedkaw6tq9Q/Ay0mMOqHgCofNMp+xE/wb71dySJY+ZQHYDYP59TqaZmFF3ZSIFt+C0lelsZNwIFpv1AZ5Eem54FfARcpb6kobXLa7KGjCKgVyMtlpkbt8aYT4bWzfyYPXljQuQemRzP5D2ISRHd+xvfDolfkTlmmz6a4D9eGU60Yortm8PGKB5of8FPCz5WDwqPR/pcn89Bz1lUzceSXWga0QdKrOU04tIQxA936tV4FjCNsAK31x21ic0F0CqAW8ruHUfPgqCUCMGQ1XAPhUzUH0uMlORKMjy0PhMypdaiSdawU93n96Ai2yWYhDdGffGI+cBA1+G4RRgMJ+2Ll5+5CazRm+qlfT+5Mm58iVBLvyuc6W7VT4Z6EoMyTZ2puZ6RXjFRlW5etRnjFu3kUmEe6m4urlwtQYNN7CdG4GXfCzWM0kMYLfCl7f8VQHXAXiKxdZJGLzJMYwOo1iB6y8XLF25UsPZPCAJLr8e3S4Ap/ZB2sT6A0JuApP7Irjtx5Qdlh+vKFecb4gTNs2338srn2thc5p4AXzjP16A9Y8VSxKE98OOFuwip+6pLtQ6d5K3X9IykcVSlgttplWhU1JDvxnCQyNMH+paP332qc3lEi516qJfHygQtOvUYRAKT4UcnOdp0WTzB0o83FGvVzN6jHmBxxL+wpdiqGt0zAfNvEDREA4RBVmxdVeDVvaOlyZ/Lh3VoDxQd0F/DnCkAunsZh+8IF2fraFsCqq3DaV0YLNvTZgPgElx5lprLk1ssqnxSVAW/4e2TYTrEEIzDI7fTwu5/rUl1moaJ9+96Uf0AoAtW/G9ZW5QNHXreuU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4510.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(16576012)(86362001)(31696002)(110136005)(54906003)(316002)(2906002)(15650500001)(38100700002)(5660300002)(31686004)(66556008)(36756003)(8676002)(186003)(966005)(66946007)(4326008)(66476007)(8936002)(956004)(45080400002)(26005)(83380400001)(508600001)(2616005)(6486002)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWdENXBEejM5SHBlRko1RTRIQXdSMzhUU3FYVUFoSlpjai9URjgvZzFhTlBE?=
 =?utf-8?B?SG0yTFFlY0ttazEwYk9mZFNHY0o0SWJma0lyN016RENoazlsUWxOaDBEYm0y?=
 =?utf-8?B?eXAxM2hwVFhxanVpSG0yMCtqakt2QlB2SUVOYWYwcEYxV2ZqRXBwWUtwaElJ?=
 =?utf-8?B?NTA2dGNuWWRncTZMQTE5bWhFOUFFakViNVBzRm5obGZEeWt4TTE5MlYweVZV?=
 =?utf-8?B?OG5KNzNicWlTZUw5V2JVaERnM0ZncVJHdEJhSTdxUVAwanpaUGJBQVNYM0Ry?=
 =?utf-8?B?OHR2SkIwUndUTC9mc0dTVVlRbWZSellUMHFYYUszQ3d0b3lSbVcreTBQUzUz?=
 =?utf-8?B?UjR1YUU2UUhvZ1BvZmpIQnZPQnRwMDkxQ2gzQ1hOWEhiTTg5Nnk1Y0JtcHhG?=
 =?utf-8?B?N1l1eTZqb3RHUGpENFRmWHozSitFWk9nVThyWEpSRWRoVURRWXVvMityWDRQ?=
 =?utf-8?B?Y0tsMkRIbEd4b0xna3BIWTlueEZ6b2R6RGVqOWZDd1ppUDJsOGJKbERoSkcr?=
 =?utf-8?B?dXdxeEVGZFA1Z2UvR2R5emY1UmVZUU1LVFNqbWlRZ1lMMVE2V2Y5N3ZrYmlx?=
 =?utf-8?B?K0FLd0FKaDcyeHB2MCtiZEh3SWdYMGhuM0hJNXZPK2lTNDVFS1BINENCRWdJ?=
 =?utf-8?B?YUc5a0hndXdNNzZldEJuNHFvK3ZOalFjd2JLTTUwMlJ6YmdTL2NYRU1uWGVv?=
 =?utf-8?B?VkZjc2NqZGJiYlpBU2dadXhPS0RsY1YzcTY2dnlQdlFMdzFxVHVzalNsT3pl?=
 =?utf-8?B?UXA5MnpSa1lsbFpDKzArazRHZnM2TnU3RUdyUFI1SzEvbWg4TTBKUlNDMzVE?=
 =?utf-8?B?ZkhMMnpiNExTU0xoWDV2d1dLTTBOWEVJcmxtZy9SZ0tud1dtYzYyR2hGRis2?=
 =?utf-8?B?bC8rRlVodTM3c2JweVBRUE93WXRBMFNpRHRBQmZzSUpJSjBHRVpIQ1BwNElv?=
 =?utf-8?B?UEU5MVFGam1LVDkrOXVEazdNR0I4REZ4bDlsMXdRd1ZFOEJFRHdBcEYyVitU?=
 =?utf-8?B?RlZUVm00ZE9LY1ZFSXErMTRNVGNNNEx4SWhiQXhCV0tOd1VMWXl4MkY2Skpi?=
 =?utf-8?B?VU9qV0lUWFQ0bGJTZWx4L1NFYUFrNTR2NHZOam16cDFYRml3RmIxSVV3dkV6?=
 =?utf-8?B?MllRazZJUnIxb1BFRlBzUGc5R3hYYVcvRy9qTVRLNTcxWEY2Q3VXcytzKzFM?=
 =?utf-8?B?OWxUT1gwYTlJNlVLMWxmZWxKTXBBQm54cHozK0dmQXJzT3dCN21DaW9mOGRN?=
 =?utf-8?B?Z0JXeTVScHcvbTNmWGFaTVhQM3N1R2FnNG4rck9Ca3krYTRibWhFUHN3ZkIy?=
 =?utf-8?B?UWZHR3hYR0xJZ1AxNTRCaXlaMkZBMEU3RFViUitPS05NRnJGSXdsa2VoeE9O?=
 =?utf-8?B?Qy9XRUFGbzZ3M25ML2UraWU0VDduUUpGdTl6WnI1TFp3UkpNM3R0Y3VMTER5?=
 =?utf-8?B?QTV0aVcyTkRtMGFURTJlY1MvTjJPZHJTcTBzYmg5Q3NyQ0FlcEJta1BhZm5L?=
 =?utf-8?B?TVMxMTNhYlZYTFVvYURDUkVjL1dxQkM3Q3E4Ykpub2ZEUzBBdlNHRktrbzh1?=
 =?utf-8?B?cmhrcFlGdGlJQktiOVZsRVErUXQxbC9uWHJtUmhHYjNVVDdQL1V1RkZWV1p0?=
 =?utf-8?B?WHpUNGpoaEVWeUN0bm1HQzVsOGhKZjEramt6dFp6MVIzb1lWaXh0VUk0OEVo?=
 =?utf-8?B?SU5uUDRaTU5NK0RKakVaLy93MFRxaEQzK0lBMGhSbFZ4YjljWERUMmpIa3lx?=
 =?utf-8?Q?1BHXxwS0tt1xU8BBY/YjJxHftu/Y28NWZRyzHx1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f05de9d-1ed7-44fe-60c3-08d98dc4b1ee
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 21:10:19.0490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0fxLKgfq7eKIqARllxLs/1SveMpiegEMSjwCtNse1OD8zAEA9KyGDGu41NVNlCxsvd+TS4QGqWF1W+TmzxAOfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4670
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/9/2021 09:22, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> On some systems the ACPI namespace contains device objects that are
> not used in certain configurations of the system.  If they start off
> in the D0 power state configuration, they will stay in it until the
> system reboots, because of the lack of any mechanism possibly causing
> their configuration to change.  If that happens, they may prevent
> some power resources from being turned off or generally they may
> prevent the platform from getting into the deepest low-power states
> thus causing some energy to be wasted.
> 
> Address this issue by changing the configuration of unused ACPI
> device objects to the D3cold power state one after carrying out
> the ACPI-based enumeration of devices.
> 
> BugLink: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D214091&amp;data=04%7C01%7Cmario.limonciello%40amd.com%7C6e87f8a1465c424d721c08d98b303310%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637693861879301335%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=zCknM%2FyK8unP%2BI0fstH8OoB5UUVfwOKqeERZOVu9lQY%3D&amp;reserved=0
> Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinux-acpi%2F20211007205126.11769-1-mario.limonciello%40amd.com%2F&amp;data=04%7C01%7Cmario.limonciello%40amd.com%7C6e87f8a1465c424d721c08d98b303310%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637693861879301335%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=4yE1GvAineqku3yjQyfXv6nifmx1uqoEAAbf57eDiFY%3D&amp;reserved=0
> Reported-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Tested-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
> 
> Mario,
> 
> I've changed acpi_dev_turn_off_if_unused() to check pnp.type.hardware_id
> instead of pnp.type.bus_address, because on some systems there are objects
> with both _ADR and _HID (which is against the spec) and the former is bogus.
> 
> Please test this one, even though for PCI devices there should be no difference.
> 

Yes, Thanks.  I had a try and this new version is also working correctly 
on the system this was found.

> Thanks!
> 
> ---
>   drivers/acpi/glue.c     |   25 +++++++++++++++++++++++++
>   drivers/acpi/internal.h |    1 +
>   drivers/acpi/scan.c     |    6 ++++++
>   3 files changed, 32 insertions(+)
> 
> Index: linux-pm/drivers/acpi/scan.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/scan.c
> +++ linux-pm/drivers/acpi/scan.c
> @@ -2559,6 +2559,12 @@ int __init acpi_scan_init(void)
>   		}
>   	}
>   
> +	/*
> +	 * Make sure that power management resources are not blocked by ACPI
> +	 * device objects with no users.
> +	 */
> +	bus_for_each_dev(&acpi_bus_type, NULL, NULL, acpi_dev_turn_off_if_unused);
> +
>   	acpi_turn_off_unused_power_resources();
>   
>   	acpi_scan_initialized = true;
> Index: linux-pm/drivers/acpi/glue.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/glue.c
> +++ linux-pm/drivers/acpi/glue.c
> @@ -350,3 +350,28 @@ void acpi_device_notify_remove(struct de
>   
>   	acpi_unbind_one(dev);
>   }
> +
> +int acpi_dev_turn_off_if_unused(struct device *dev, void *not_used)
> +{
> +	struct acpi_device *adev = to_acpi_device(dev);
> +
> +	/*
> +	 * Skip device objects with device IDs, because they may be in use even
> +	 * if they are not companions of any physical device objects.
> +	 */
> +	if (adev->pnp.type.hardware_id)
> +		return 0;
> +
> +	mutex_lock(&adev->physical_node_lock);
> +
> +	/*
> +	 * Device objects without device IDs are not in use if they have no
> +	 * corresponding physical device objects.
> +	 */
> +	if (list_empty(&adev->physical_node_list))
> +		acpi_device_set_power(adev, ACPI_STATE_D3_COLD);
> +
> +	mutex_unlock(&adev->physical_node_lock);
> +
> +	return 0;
> +}
> Index: linux-pm/drivers/acpi/internal.h
> ===================================================================
> --- linux-pm.orig/drivers/acpi/internal.h
> +++ linux-pm/drivers/acpi/internal.h
> @@ -117,6 +117,7 @@ bool acpi_device_is_battery(struct acpi_
>   bool acpi_device_is_first_physical_node(struct acpi_device *adev,
>   					const struct device *dev);
>   int acpi_bus_register_early_device(int type);
> +int acpi_dev_turn_off_if_unused(struct device *dev, void *not_used);
>   
>   /* --------------------------------------------------------------------------
>                        Device Matching and Notification
> 
> 
> 

