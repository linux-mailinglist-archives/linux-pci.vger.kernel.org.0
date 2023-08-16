Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5353C77E25F
	for <lists+linux-pci@lfdr.de>; Wed, 16 Aug 2023 15:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjHPNTC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Aug 2023 09:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245485AbjHPNS6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Aug 2023 09:18:58 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CEBE52;
        Wed, 16 Aug 2023 06:18:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWUDzcatgQTkPusS3s7FzhQvdexNaQc7AKOEdIwuA6NEOmzBUdrB3iHbymnHFxH5iG5wcg1MhPACq0xzeg3H8kj4lNSKPKDkki1ya7OP2dpW8ogZKlPZ2zsQjhMmS9YP2QSJhlpASUShlTSHsnoGMYGUsDf/CYh8OXGWzovjFEFUvc13ETkROihOye7ddLQY6i2bJ2M1bGsEiClv8L+VOn30n9sXay0nifJnPKtL171pqIlWpK+g/Bej/fmR6K0rvVzVplxETK1UjACCl9wkjjXbGB28uXQ20O6BgSBQ0VrEjIraXF7MquQO/lsU7WvYDb+7cA/18W61yM65cFW/GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ltjUyC+e9fqhTOrrfuPjvD28/nGJu4bPwVKQqLYf6Y=;
 b=maOjuqHU2/3L/uHjwAoBkrhjSpGRfzT4syAi7GwQd0TM8T+m1EzQ7Z1MSe5rEh4V7ESsPh1ESmPML/4z0OWxw6o7htGVtcY+I72e0K6lpjaBBIH0ntxxbqtpcfRFHmQZ5Z7pTkplC8le9ExFyeaJlka/4fcDTsGIRLthBttpLfFSzK4JFJgaBcdrnbUFRfEksGCtO9XD87hbNsCnv2R+TTe7OItqTL/FzAHNPGXFdw3U4sVVadj0V5eMC6Mn4DDbJu+s5sdeXADU2j481cjXQb4DBlqbvAK0rwuNQS51rRE5J6D8juHzqmY1GXWLakyXBn9IibfusQ64VwdXrT9XmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ltjUyC+e9fqhTOrrfuPjvD28/nGJu4bPwVKQqLYf6Y=;
 b=GcWhh2Sdov3fen4GgneDgpGwVA/v40nC/4wrRAco/AnFi+EIorhFQyfBQWm6eBOV6gHJQDLhYPQT5A8YxfmzcbYW9bb8DifjJTW2DRg8KxfI1AxI4+AN/M3RSo5XbDUq0iITmOcb/lw0pbgpDaxjGQLhKeyWTWflYm7p06G9MC8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7016.namprd12.prod.outlook.com (2603:10b6:303:218::14)
 by MN2PR12MB4095.namprd12.prod.outlook.com (2603:10b6:208:1d1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Wed, 16 Aug
 2023 13:18:52 +0000
Received: from MW4PR12MB7016.namprd12.prod.outlook.com
 ([fe80::f26a:5d9c:cace:19aa]) by MW4PR12MB7016.namprd12.prod.outlook.com
 ([fe80::f26a:5d9c:cace:19aa%7]) with mapi id 15.20.6652.029; Wed, 16 Aug 2023
 13:18:52 +0000
Message-ID: <ffd5401b-400b-79e2-51f2-e6866251000f@amd.com>
Date:   Wed, 16 Aug 2023 18:48:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] PCI: Allocate maximum available buses to help extending
 the daisy chain
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, mario.limonciello@amd.com,
        Sanjay R Mehta <sanju.mehta@amd.com>
References: <20230816051923.2287912-1-Sanath.S@amd.com>
Content-Language: en-US
From:   Sanath S <sanaths2@amd.com>
In-Reply-To: <20230816051923.2287912-1-Sanath.S@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0066.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::15) To MW4PR12MB7016.namprd12.prod.outlook.com
 (2603:10b6:303:218::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7016:EE_|MN2PR12MB4095:EE_
X-MS-Office365-Filtering-Correlation-Id: 58a6c661-c1b0-4fc9-fdb0-08db9e5b5570
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KGLVJJGAYq1ogyezeyRaqQHuShaizQXO7F5uhk/GF3BRK4mCsuUm2EXf01MOo/8PVlveMFLpbfFpnvp+y2xh2yYeIbn1zJc2EzY94jElSpbUEfzvQFt0nMIb7/XQ59Fy/mzlVDE/LZlIuNvoOq1WVXRi114C7QUukc5TUHeMDTwJqq8guo/dkfJqyBd/VdtzsG9eZr/OUtR1PdDBCWXpxaixs6mPpuDZ83e8Z8v6BXtUaDoPFNgjhopK+ggPPdc85Rbpb0Zw4n1+7pGzo80kk1UrKWJ0vJg6WNfCIikF1mFmZREzfgaG01eUpGP90ugywDxgb5tJYCGs/4r4ap+ouoFoGEUHS16nAUIwuEowy7wh2B5T1/HnSvInkJ40kApDq8+uJvPmVh4fFSCaTYN14cxFiAIcTHAIAlmJNh3024kNe8o7JPeh8sGj3GQQ7uUyYQJi/ZFBXEikSAddnrn7O1QUzESscCt4093qXfjABP6VJeh+fa9Mx4yDEGWQKwaqghKnQndLO5wbxSWFLTX+TcYW9hbu8XbmObfxM1i9NobI5At8mFmcSwWmD7HtYYCL6tufhwHPuQj8/iO+/QkBqDierZU/REjdokDzr+ObPXY1HBEgZ1QdwwjphJ4OoEA1ycxwHr7r5OhdovKzIongXFJ48p3B00QEU0BMMpxpzew=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7016.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(316002)(6916009)(66946007)(66476007)(66556008)(966005)(41300700001)(5660300002)(38100700002)(31686004)(8676002)(4326008)(8936002)(2906002)(83380400001)(26005)(478600001)(31696002)(6512007)(53546011)(6506007)(36756003)(6666004)(2616005)(6486002)(131093003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWVkbHR6TDVQV0U4SGkwZUxYbWNKOFgxRG9kdlEwMGRFRXk1cjFURUR1YmF6?=
 =?utf-8?B?ZUlUb01RRUMrZXpML2ZrMkNLdTFoN1dRcTZnSytlcjhWZXpFWkQ0ejNYSlRL?=
 =?utf-8?B?czlrRy9WODVDQXdjbTZPK2M5WlViMENzbldZSVNGS2c3N3BzRzRQQjgwYnpw?=
 =?utf-8?B?dmxTU1REV3pvOElLMGZtOGd3MTRJdmF0RXQyRlI0bkM5VUVTZmR1SGY0UFVh?=
 =?utf-8?B?R2QrSXU3M2xNamw2YzZ6MmFORTZJRWt1T0UxVlRycmVyUENhYW9jRGNQTjdF?=
 =?utf-8?B?d3FJa3BvZThIVXVxRzFMQ296T212NzEzNUVabzFlVnUzRUVnZ2tXblNaV1py?=
 =?utf-8?B?ajdFMGdaY1ozZUY4UEFxUXRHdmlhTWNQV1NyN28xcVpJNlE1M2N0NFJnenJv?=
 =?utf-8?B?azBmcnhYeW16N0xTMFFHdXVnd1djMldTa0t3ZUtvVjlkRFZCd3NsWmZxQkFu?=
 =?utf-8?B?c245QWE4S01JYmtTNU45KytzOXpheFBGL2drODFpWW5HZXRZbUJJZWxGeWl6?=
 =?utf-8?B?MDdXSEh1Z3JwZGoyK1UwMVdkdllaZ0U5a2N5Z1E0eUlSbTFDcEJDcEF1Qit6?=
 =?utf-8?B?UXFSZUZ6ZGhEaFFQaDhSYVZKTm9ocE9yc2s3R2wvMkFJQlM1R2o3RzNVaWI5?=
 =?utf-8?B?NHVJeDE4aDVRNHhTaFAycmV5MExDTXBnbnI2Zjh2NjZMbTUzMUlMaUJ5eXRz?=
 =?utf-8?B?WVFJbHVNL05YZXhHQ29PK2c2N09xcWp4Z2JodFRJZzNhMDNuSHRvUm4yQU5B?=
 =?utf-8?B?VGxJaHBqR2VtaDFCZHFYN3M1RVZRTXJPSEJWRm42dk5kb0p2ZUxsQ3FCNFcx?=
 =?utf-8?B?NE8wMkR0VXorbzdYaEhURVJNYjI1SDRTcElObGVmVGtiNUpyeFlCYUxtWVNj?=
 =?utf-8?B?cVNXT0loRUVYMkd1Qm5UQzk1aGdwWlAxUlU0UFZidWc5NW5BMGtKNUMwaXI4?=
 =?utf-8?B?alViVzd0SzhWWEZTN0VwdnRTYjdKQXQ1M3IvWXZnVm5Sd3UrdUpHVEtEQUgz?=
 =?utf-8?B?V2I1ZUtQS0VDd3JHTExkU0JzZzBPakpuaWpDcFVERXI0STBzSGN3UVlYN1Zp?=
 =?utf-8?B?T3IyaFRtSUcwZ1ZlTWpPMDZBZnZod1kvcmxFcGV5cGxVZWR4clRqMFgwU1M2?=
 =?utf-8?B?SVB6c1cydTVSQUhZYmF0K05NNjNobUJNZC9lRllLU2EyclNHSFJVc1c3aUIv?=
 =?utf-8?B?S3VDM1VNRTdtbDBHWWdBcVhDdk9oMFZ4NVlrZ2l3aTNJejVDQzJwazhWZTY2?=
 =?utf-8?B?cXV3MWtFaGRUNUNxUDQ0bmQ4eHZsSXc1VnIyUUpyZ0p5UjdjNGtaeGxnNlMw?=
 =?utf-8?B?ZTQ4RmFaYkdKSUxwSWhZdmozSXYzWjhmcUdhUnd6SHVBaVczNEJTQlNMV0JB?=
 =?utf-8?B?SGIrbGRNRzliWmVnV0FjRkJHeFNlVVJ0djZvY2Z2aVVranhtZnVFbVM5YmhS?=
 =?utf-8?B?N3pUVC9tUWRmWmU4S2RqbExlUXZZZnIxbncwanlhNFd6Q3g4dGxVYnVwRm1X?=
 =?utf-8?B?K0duTmNEOTMwV1dHZitpQ3NjM2ljbVlNMFdwMFhXTnZYeTAweTJxTzRFLzlr?=
 =?utf-8?B?YWM3L1EwSWFsNG5HSUNkbFNYajZvSUgydU9UKzFweHdBcG9Cb1dINEVhNTB0?=
 =?utf-8?B?UkVzOHQ5UkE5bzB5MFQvR1hiaFZRYjE1Z1NYVHRPU01vRW0vZEVYV0I4K3Z2?=
 =?utf-8?B?SklRcmtGU0xmK05idE1ONGFINGQxeXlmUnRkNGRjRjErYnh6RTBJY3IzdXhi?=
 =?utf-8?B?UVRxUms5MXlaRnB4VUQwbzlkZjgvTnZmK0VQOHJISWpUVStTQk5ZS0pObytF?=
 =?utf-8?B?YlRTL0J3OTBIb1pOZGdjQ1ErRGJsc0lSOVY5YUdZNmpVcUJIK3h1M0dxcDdr?=
 =?utf-8?B?SFp0M0w4MExTR0YvMDgrVExvZ2M3c1dMVmpKeVFWL3hvTSt0NkNmWXBMeTVv?=
 =?utf-8?B?ZlBCT3ZjNGdFMzJzeTNJcHNyTlkzMXl0Z0ZWWWZuNnptVHNrdCt1enFmU1Nl?=
 =?utf-8?B?MWNkMXVWNW1oWmg3WnBIQlNncGk4TUY3dmkxSEZ4MWxFcCs4Myt3MVFKamZ1?=
 =?utf-8?B?YTE5a1NrVUhVUWo0SEZQZVphc1A5N0dLM2o5Uk9xenM0b1NhQ2tYZXM3Rnlp?=
 =?utf-8?Q?sSCCFuTOaXxtJreo3jzSHckvi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a6c661-c1b0-4fc9-fdb0-08db9e5b5570
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7016.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 13:18:51.9147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nmTTxiaSydjF444RtOI6UD5/YRmv0pbQOlW8HGTKkygdh+mG8xjT3uftRznwa5s8C7vFXZdTQr3ClUqgLS+kUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4095
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Adding Mika.

On 8/16/2023 10:49 AM, Sanath S wrote:
> In the case of Thunderbolt, it contains a PCIe switch and one or
> more hotplug-capable PCIe downstream ports where the daisy chain
> can be extended.
>
> Currently when a Thunderbolt Dock is plugged in during S5/Reboot,
> System BIOS allocates a very minimal number of buses for bridges and
> hot-plug capable PCIe downstream ports to enumerate the dock during
> boot. Because of this, we run out of bus space pretty quickly when
> more PCIe devices are attached to hotplug downstream ports in order
> to extend the chain.
>
> Before:
>             +-04.0
>             +-04.1-[63-c1]----00.0-[64-69]--+-00.0-[65]--
>             |                               +-01.0-[66]--
>             |                               +-02.0-[67]--
>             |                               +-03.0-[68]--
>             |                               \-04.0-[69]--
>             +-08.0
>
> In case of a thunderbolt capable bridge, reconfigure the buses allocated
> by BIOS to the maximum available buses. So that the hot-plug bridges gets
> maximum buses and chain can be extended to accommodate more PCIe devices.
> This fix is necessary for all the PCIe downstream ports where the daisy
> chain can be extended.
>
> After:
>             +-04.0
>             +-04.1-[63-c1]----00.0-[64-c1]--+-00.0-[65]--
>             |                               +-01.0-[66-84]--
>             |                               +-02.0-[85-a3]--
>             |                               +-03.0-[a4-c0]--
>             |                               \-04.0-[c1]--
>             +-08.0
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216000
> Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
> Signed-off-by: Sanath S <Sanath.S@amd.com>
> ---
>   drivers/pci/probe.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 8bac3ce02609..ab7e90ef2382 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1263,6 +1263,8 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>   	bool fixed_buses;
>   	u8 fixed_sec, fixed_sub;
>   	int next_busnr;
> +	int start = bus->busn_res.start;
> +	int end = bus->busn_res.end;
>   
>   	/*
>   	 * Make sure the bridge is powered on to be able to access config
> @@ -1292,6 +1294,13 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>   		broken = 1;
>   	}
>   
> +	/* Reconfigure, If maximum buses are not allocated */
> +	if (!pass && start != 0 && end != 0xff && subordinate != end) {
> +		pci_info(dev, "Bridge has subordinate 0x%x but max busn 0x%x, reconfiguring\n",
> +			 subordinate, end);
> +		broken = 1;
> +	}
> +
>   	/*
>   	 * Disable Master-Abort Mode during probing to avoid reporting of
>   	 * bus errors in some architectures.
