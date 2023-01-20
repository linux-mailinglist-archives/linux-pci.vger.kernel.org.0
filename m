Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B694E67515E
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jan 2023 10:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjATJl2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Jan 2023 04:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjATJl2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Jan 2023 04:41:28 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2042.outbound.protection.outlook.com [40.107.100.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF13A27C
        for <linux-pci@vger.kernel.org>; Fri, 20 Jan 2023 01:41:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Grv5nlCTMA6V2RWAK1GEFlziEKmLbj2nRK31ReLbBIoPTBerDn5o1B4hyM84rBp9Khz01349DJcNqDii4dQEJw/d0QNqCUiQo+uwguGxyVbi/BzVgAjyqFwp0JJTxcI/vmVyMLB/HHYBDwwjDNsVzIAQKywfvqmG6uG6/iofzF1XzG1ojvrW7CHx1CkqGD5sytKEgMeljouhqFGloGts/oeVdtkLwuBSHflXKU67+2zvJtTagKXd/+S7qAmBS4AOvCSgn8eh/JiU7xsoL3Eo52/POJ004TJkd6Pujo4yy5dhK/Fy+zRINmvl+kUCEdp1Eqk+EYwFxF5wt9+lJEYrHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E1HRjAczEI+lcNB9rsj7Y+WDBbC8Gf97V+IH9mZsATc=;
 b=dimgXu+A//Tkyz/dE+PIgVxU3CGn2Hw9RwvIk5OZwXSlhAUk639MRXLo3oUe4QWZ9YhCzKpgUuZzGj8xStnRzYS7xzckJOuvAxccQYleGfJxDb0ra4CWP+D2eOXPif5UuiClWZmSZczFL5PwcG3QV5StAIZkQGMaPG72aHSQnRezLvcmSVCubPeHOUBGzP0miw4/JXSx4KwUqQwxbOZv64TfzT/ChFRIwWbUDkb2rsWWK2vfm77KSNEztIfbwLZlSmv5RGlt97PRMqSILymn274A87Xqk11AsmuN9ZuLcWwwMyD9Q+90T+pj50nHKZhZJd2b0uggcVJdxpaRbWZeeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1HRjAczEI+lcNB9rsj7Y+WDBbC8Gf97V+IH9mZsATc=;
 b=qmHENP8BAn85Q6RCSeRSUWpg/KaLp1GOlUjdFudRbkB68zTcvs+wuDUD6k8eSKD++WuKQImT6nuFfCIkzkGX+Kz3O2gewKBQU4db9VvPpeVtjBzPUGfbvtDsHmNLK0z2zFhKrvNb4i1OAEA5qoQk9WdO/nVZuCxI9qey/Ho0TNA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CH3PR12MB8209.namprd12.prod.outlook.com (2603:10b6:610:123::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Fri, 20 Jan
 2023 09:41:24 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::80d8:934f:caa7:67b0]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::80d8:934f:caa7:67b0%3]) with mapi id 15.20.6002.024; Fri, 20 Jan 2023
 09:41:24 +0000
Message-ID: <4b6fc160-5380-d451-6aca-f3a9d636736f@amd.com>
Date:   Fri, 20 Jan 2023 10:41:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] PCI: hotplug: Allow marking devices as disconnected
 during bind/unbind
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
        Anatoli Antonovitch <anatoli.antonovitch@amd.com>
Cc:     Keith Busch <kbusch@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        linux-pci@vger.kernel.org
References: <3dc88ea82bdc0e37d9000e413d5ebce481cbd629.1674205689.git.lukas@wunner.de>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <3dc88ea82bdc0e37d9000e413d5ebce481cbd629.1674205689.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::28) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|CH3PR12MB8209:EE_
X-MS-Office365-Filtering-Correlation-Id: 22ea13cd-38d5-43ec-9e28-08dafaca7e7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PqP+dETLvDV/w2BHGOvseAt2Eiw0wCTQPlt75ILKfsRdNyQ6OBZcbVbQE3n20d17mIk9RzNwQ+fIig3KHdDp14tPa3j4PSqOrAWSeH3wCbOf+qdn0nvS5lJdfqnegD8oOCXjcv0HHPnRZQMnFvGjEnur4fj5x5WjaBwOYQIORylEprVBKagPg+1iijlIArf7hwtvljEbbVyCukkooL21KONZ4areS8fPJO0ThtJnNrW/ZAH8Ai0M6jgz4b5YL1Mex5Dd0s1w7fERmJNiACnMZhq16KfNNsQiwmczXRhZCyLu4iQ8emV0mliyNgeO+k/WuGUsc4PoX7wBI677rSdZOTaUB+wBCzRFuswpRpaeo1AjAWV8mFNtqffpZU0LkZaEN1myCqR9JAJVcWq5ogshD302QBrGV0bJ1mNRo7tZTqEpuTsAgxSRk0L6yDGyEWClybLy2wn2CvtPKgRxaH/43oTR7O6CYAXd6iYzjXdagOmbKh3k9IRtfC/KFFzNuEXWDgXw6oXDTMofvt8980NMxYVs2ihG6j+jqUXs3ieBjW0wXsR8ozs99QCfA+VM5jCMKr31wORkJRZ4/tr6F2xQbv5SPWzXOqv6HvHWCMlHVGuRBK6iRBqm9D7RKBGWGg9t5xhoK0kUaz33Ioj2z43bW57m7bruekx6SKygQQnuhDY9LQgC1bzZ9A8TN6nb4FGjoPNjlPsVFsKiFmphEa2VnUsebifdvF4T/W69gxE+tgIx3v5XSGoxXtRtPDGppSr8QzVTGzVy+WY/FxlPaaigZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(376002)(366004)(136003)(451199015)(5660300002)(8936002)(31686004)(4326008)(66556008)(66476007)(8676002)(66946007)(31696002)(6666004)(38100700002)(6636002)(6506007)(6512007)(2906002)(110136005)(186003)(54906003)(6486002)(966005)(36756003)(478600001)(316002)(2616005)(83380400001)(41300700001)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGd6QzFXUWd3dk55RXdHdjJRaUZHdVNOUG1vNks3a1AyQWllRnhPeDl3ekdM?=
 =?utf-8?B?S1FGemhuL1c2aUhTQ0lEekM5cENRNG5hZnRpOHJBWlNlUy9IMjE0aXVUNG9C?=
 =?utf-8?B?SWEvZWZoT3NKaXl5N24wY3pVNXFIbU1xV1FzNFBXRVc2TU1nVy81QTJsL1Rt?=
 =?utf-8?B?TDJRVi9ySGFhcm9ydkFEUm8xazhNcFpjZjFhVURGaW9nRnlJRHNGNEtTY3BV?=
 =?utf-8?B?Y29iRzJWVzA5TlJUSm9RQmc4eXVnMjA3Ull3V0N2UDBlV3RyMjl3K1pEVHB6?=
 =?utf-8?B?Q2gvU1dSbHlWMnNjMlpwN3k2YjZ0MkFwMmVROXhNNWdGVis1Ukx4UjdtckhM?=
 =?utf-8?B?dUMvU0wvU1MrM3BUSFo1bDFLdzhwWnVHc1RyaE9ycmlQd1NxQVYyWnlqdndo?=
 =?utf-8?B?Qlo2VTJubXN2WEtMYTh2TGpKV0FlclNYeHZjRk9IYTBDb05yTUhiVXN6cXR0?=
 =?utf-8?B?ejhucDlFdU91M1ErUWMvTzRGM0ZZV1JucFdSTzVqNTF2Ky9ub0VKQmVXRUdx?=
 =?utf-8?B?czVRZ3hrcUM2M1FnK2lRSmxTVWI3cnVFRlVROFo1c3docEpRNmRyRHJoV0Z6?=
 =?utf-8?B?dDdVQ1pYcDRJSGkwOGNFWFV1Ymd6NnVNTkxvTVAwWDZmL1c2dnM0N2JIZ2RH?=
 =?utf-8?B?QXRwY2Q1VTFDanAzKzUwZmQ3cFo2S042M3o4WGdIUjRDRnhPYnRZL3JaRTdn?=
 =?utf-8?B?NTZWUDhGVi9OV2RVRGV2OGhVQXVUK29xeE1MWTNYSkFkQnRadnRva3VGZEFj?=
 =?utf-8?B?amkwRU44RXVoS3pSbWJ4SEhLSm9raEFacVFLV3VZQjVoYzBoSkdObU9QbnhI?=
 =?utf-8?B?Y3FiQ1dHNk1ZS3hnMGh5RU1tSGk3dmkyMmZTdDlzNksrcXMveXRrNDQ0SGhy?=
 =?utf-8?B?WUU1UUlBZ2lNYkdqWFdMQ0phck11UlZwUG04V3JLbXFpK1IyRXdrWnU3Z3NZ?=
 =?utf-8?B?c25OS3JKakdrRFg0ZlFMc1hIV3hQY044ek1JMUluRmVxRlNqVTY3ZUVrOE82?=
 =?utf-8?B?cS9GWTY0OVZzb0RqL1MzYi9DZm5tSkZmeEh3bDdPS2h2eVBZYVlqOGdjZmd0?=
 =?utf-8?B?aDdkOEZTc0FlRCt4d3dUUXkrbUNVdlAvVmx1UStwVFlNKzUrd2RvRGxQdXI4?=
 =?utf-8?B?KzB4Y21BZ2FkYUxhM3NBRVlWTE9va1I1VWJtQ3NYZm80Vm1vUlJNSStxUkpo?=
 =?utf-8?B?ZkVPWlRjalNxUVhvWkM1VWJSYkJGeUgwU3A0Y0plK1ByenAxck9wYjJ5UWZj?=
 =?utf-8?B?Nmx5bzg2Vlh2L0xHRGRYUS9NOUptcmVHVDV3WTYrby9STERpNndZK3BMdDhw?=
 =?utf-8?B?U0RtR09ndGt2LzhqanVyMFZHQ0d2RktKejlrYTFjYzB5TWtYNVNwamNkUldF?=
 =?utf-8?B?TzQ4MlJIQmhqY1RxTGI5VGlWQUxTRmVncFhybE9KckgrSGFWZ2szZlBETHNY?=
 =?utf-8?B?eWRWQ1Z2ck1ZWHhhS01YRTM4ZjE4dm1xT0Jzd0ZJUmY0Vk1UQW5xNEM2Z3pj?=
 =?utf-8?B?UHNGeHdsVFlwcVYrY0hWUVhrN1VtcENjWHc5dlpMV0FXYnhOYmxtUnlFS21K?=
 =?utf-8?B?eHZUb2ZXaFVySk1Bc3ZkMk5VUDBPU2RFWURvNVVmalFtM01rbTNsSjFYN293?=
 =?utf-8?B?eEVQSHVxSDJiakFUbDRSNmZyTVBzU2h0KzFMUVhvYTFrUHRnRTAwcnEvOC9n?=
 =?utf-8?B?a1M4WklvQ043ZzkzcUJ6UXRUQXRnemFtdy9jZVB5ZWFFdUhjVFZZY2J1ajNL?=
 =?utf-8?B?V0Zac1l3RUV6Q0VXNUJMN3luS1NWYUMrN1FRLy9QRUViTE1SOEVDVVZjNVlB?=
 =?utf-8?B?K0hOaFhUTmNIMVpyeFFpb01qTXFkaENwMmZkRGg3YUM4dEgySDJrQ0NGU0Z2?=
 =?utf-8?B?ZEdCbUUyeS9PTFJiVUkydk8yU0VoRTF0VGpDaUVhMVdpWUtkSGJmQS9vQjFv?=
 =?utf-8?B?Ym9kd0RPMXkyMm5UeHk2czZveWUvcXlvRG5Na2p4UEo5Q21KbVdxU3c4U1Ni?=
 =?utf-8?B?dkJiWURRTkFiYmNjbjlENHRLZHdwZEIyU1hsczVSZlVnZU91cGFrbktuc3lN?=
 =?utf-8?B?WC85R0FDK0tEVklFMFpLbWR0clRJV25zZ1N5a3hzTmpEMlBjWVU3cDJHVE1N?=
 =?utf-8?B?THBPYllzbUdQWlZjdnlXcFJVdUdxWVBTbytzdEI4aHorVHBYYVFISmhhdlVs?=
 =?utf-8?Q?TeH3k3qhrURcgkA164Xv3cKYlMjlU6DMJy2dwux9G3nO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22ea13cd-38d5-43ec-9e28-08dafaca7e7b
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 09:41:24.0277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Los3Z14TNgPkGxws9IdwhodQC43HfwEoXvCZ1mCTR4CKUZzayHXI7VU1Oe3GKwrX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8209
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 20.01.23 um 10:19 schrieb Lukas Wunner:
> On surprise removal, pciehp_unconfigure_device() and acpiphp's
> trim_stale_devices() call pci_dev_set_disconnected() to mark removed
> devices as permanently offline.  Thereby, the PCI core and drivers know
> to skip device accesses.
>
> However pci_dev_set_disconnected() takes the device_lock and thus waits
> for a concurrent driver bind or unbind to complete.  As a result, the
> driver's ->probe and ->remove hooks have no chance to learn that the
> device is gone.

Who is reading dev->error_state in this situation and especially do we 
have the necessary read barrier in place?

Alternatively if this is just opportunistically we should document that 
somehow.

> That doesn't make any sense, so drop the device_lock and instead use
> atomic xchg() and cmpxchg() operations to update the device state.

You use xchg() instead of WRITE_ONCE() for the memory barrier here?

> As a byproduct, an AB-BA deadlock reported by Anatoli is fixed which
> occurs on surprise removal with AER concurrently performing a bus reset.

Well this byproduct is probably the main fix in this patch. I'm 
wondering why lockdep didn't complained about that more drastically in 
our testing.

This approach indeed looks much cleaner.

Thanks,
Christian.

>
> AER bus reset:
>
>    INFO: task irq/26-aerdrv:95 blocked for more than 120 seconds.
>    Tainted: G        W          6.2.0-rc3-custom-norework-jan11+
>    schedule
>    rwsem_down_write_slowpath
>    down_write_nested
>    pciehp_reset_slot                      # acquires reset_lock
>    pci_reset_hotplug_slot
>    pci_slot_reset                         # acquires device_lock
>    pci_bus_error_reset
>    aer_root_reset
>    pcie_do_recovery
>    aer_process_err_devices
>    aer_isr
>
> pciehp surprise removal:
>
>    INFO: task irq/26-pciehp:96 blocked for more than 120 seconds.
>    Tainted: G        W          6.2.0-rc3-custom-norework-jan11+
>    schedule_preempt_disabled
>    __mutex_lock
>    mutex_lock_nested
>    pci_dev_set_disconnected               # acquires device_lock
>    pci_walk_bus
>    pciehp_unconfigure_device
>    pciehp_disable_slot
>    pciehp_handle_presence_or_link_change
>    pciehp_ist                             # acquires reset_lock
>
> Fixes: a6bd101b8f84 ("PCI: Unify device inaccessible")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215590
> Reported-by: Anatoli Antonovitch <anatoli.antonovitch@amd.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v4.20+
> Cc: Keith Busch <kbusch@kernel.org>
> ---
>   drivers/pci/pci.h | 43 +++++++++++++------------------------------
>   1 file changed, 13 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 9ed3b55..5d5a44a 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -310,53 +310,36 @@ struct pci_sriov {
>    * @dev: PCI device to set new error_state
>    * @new: the state we want dev to be in
>    *
> - * Must be called with device_lock held.
> + * If the device is experiencing perm_failure, it has to remain in that state.
> + * Any other transition is allowed.
>    *
>    * Returns true if state has been changed to the requested state.
>    */
>   static inline bool pci_dev_set_io_state(struct pci_dev *dev,
>   					pci_channel_state_t new)
>   {
> -	bool changed = false;
> +	pci_channel_state_t old;
>   
> -	device_lock_assert(&dev->dev);
>   	switch (new) {
>   	case pci_channel_io_perm_failure:
> -		switch (dev->error_state) {
> -		case pci_channel_io_frozen:
> -		case pci_channel_io_normal:
> -		case pci_channel_io_perm_failure:
> -			changed = true;
> -			break;
> -		}
> -		break;
> +		xchg(&dev->error_state, pci_channel_io_perm_failure);
> +		return true;
>   	case pci_channel_io_frozen:
> -		switch (dev->error_state) {
> -		case pci_channel_io_frozen:
> -		case pci_channel_io_normal:
> -			changed = true;
> -			break;
> -		}
> -		break;
> +		old = cmpxchg(&dev->error_state, pci_channel_io_normal,
> +			      pci_channel_io_frozen);
> +		return old != pci_channel_io_perm_failure;
>   	case pci_channel_io_normal:
> -		switch (dev->error_state) {
> -		case pci_channel_io_frozen:
> -		case pci_channel_io_normal:
> -			changed = true;
> -			break;
> -		}
> -		break;
> +		old = cmpxchg(&dev->error_state, pci_channel_io_frozen,
> +			      pci_channel_io_normal);
> +		return old != pci_channel_io_perm_failure;
> +	default:
> +		return false;
>   	}
> -	if (changed)
> -		dev->error_state = new;
> -	return changed;
>   }
>   
>   static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
>   {
> -	device_lock(&dev->dev);
>   	pci_dev_set_io_state(dev, pci_channel_io_perm_failure);
> -	device_unlock(&dev->dev);
>   
>   	return 0;
>   }

