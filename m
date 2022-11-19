Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4AFD630E2D
	for <lists+linux-pci@lfdr.de>; Sat, 19 Nov 2022 12:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbiKSLDG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 19 Nov 2022 06:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiKSLDF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 19 Nov 2022 06:03:05 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEE09B3BA;
        Sat, 19 Nov 2022 03:03:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R13TVMZVWBDqe3yWgkJwVccWbSKCCMBS89ULVnN7KcwP2dQAMdbPqF09l8zxcY46Gw2Tq9KjGfkKjPwblxYkXuUwn636V196GUmsWq0QGIvI78muMbvawvz2w20PJ4qT1VTwCF2oyvEcvZncFpfl0kwbJVJ/CZd5SuAVI7SHXdzfk4Gi/1i+dVgm2cf++yP4CrdmiPTOCObDz+/NZMesQ+d1GziNBOxUr8soeB0igSwAcx4wH4veUvFD5lDqP/buiHqWtVkgWUOF4iQEB2yPSoDyGgSOzM5PONdlfVOv1Ir+uz2E2cvvbKLT0I9oZHEwCR6mc8Pkyk4e1IyMWSdnuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6I7WB14+fX3Ma5mDZEdRulsa+sTz4SjhtOWmShexSEU=;
 b=N7Y2+QhZiOZzdYptZIW0Q77KxtG8wnGP/Er6Hv0rZkaYK5PogGOxRXMM5wrMIRyZhKl8IGtBKux2zeIjt664vELOBJxRW8zPj673GQq+PXVfDlIm9HTehE9NjaGa3BDDpGod/BIuqkjHgb0FXVbaIbHWlPSkOyawXt7qWnhU3NgHW7UZp5usdRsZwtGmEALk9KmHU4FPjPnDk+iDRekTyT6zOUqxy2z+1z4nBlzny5oQWeIpx/HcViLSC7WQBIHCRr9xiwufPru/2BEK6jKKzlDDXfw+w3D5+u9CzPJxZ1TDKReRfuH+N/+H7yuzYrxaK7UXoMsU/d/eU69PxWh7xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6I7WB14+fX3Ma5mDZEdRulsa+sTz4SjhtOWmShexSEU=;
 b=0SiXwm2/1kwji73x2yNhb5Eyu3r6EZzUvRaob85+NMgrml+jzeHYo4QhWS54W/IRYtcAiNvv7PVpbOp2arN/ABElIyBFHDucdovV3gegqe+/3SuHK7fHstYOUaxdhBZdYtRXSmREItqf70+7DNJEYcbz+6xpyBlxjqEo5B23ufE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Sat, 19 Nov
 2022 11:03:00 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421%7]) with mapi id 15.20.5834.009; Sat, 19 Nov 2022
 11:03:00 +0000
Message-ID: <fe0e40cb-b982-2aba-b622-8534c174ea39@amd.com>
Date:   Sat, 19 Nov 2022 12:02:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC] Resizable BARs vs bridges with BARs
Content-Language: en-US
To:     Alex Williamson <alex.williamson@redhat.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc:     linux-kernel@vger.kernel.org
References: <20221118160916.7e165306.alex.williamson@redhat.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20221118160916.7e165306.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::18) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|BN9PR12MB5115:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a717ece-1f05-42a6-70d9-08daca1d9f58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PZ059VtmrZuKFx0rHp+jrnEvWtL5AUzGcHe/dMDkPCn+GZ++FurqLbPomjMpQfaTIkwwYL828B9rx4Em/gqmg5XhAFyE1FjI8Blys39+ROeREpN/VE6rTLfZi2lppMQeuE8ZN6+JvYXVytB+6U9vwOtKNcsp11O5aZC5MyIgs8DzYDZzd0UWFWxmI+H2p1fS/C18ufP5aR0wJEvi3eoKhweVbbanUb7GowrSsBsLmbLDz7oxVd49qHHAV+dXAAbHs5/qIKDT8AAGGwKjABxE5+jTJRf9KBBQh/AlOe/a+S6lPmgk4BbkSFgQQ597CiHPZz09BD0o7nqQNWfNl1xOn2Koqf8HATQh3EWy2/l43WUlxifP+tLGNsO0tjTnDt0ac7heX4Ek2WII3B0X2f4RAJQqHckSu8yAydEodPwFj2Nrexcaq0nPBTnmd+D8sEVZdowS4YZ5JjbMQB1lhE9KUVVg7chG4ho+luhk49UJXKlYmKeAzep5Ik25Q8Dp9Gu8Y67hua0Pt8+uQqZ29Et7FTn6wdxYC2sQjYMVoktzbW+2h9uTEP+GR/Ujr9hprA1oiE7w/AfxjRWP7zDDkgTIxXj6xB6yLq3GTdrJrAWNXCrP+y5N/NPkbqO7CQan77Y+e/4/qDFRc7xvxQroc4IROVOuOJUUogSCRu/BSB1RyisfcouZiZlzz8mjVA5Ijbghb+gnzuj6wg9T93tsClFIlxocVhIDK2pG0cmeJUJOeA8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(451199015)(31696002)(36756003)(86362001)(41300700001)(2616005)(66946007)(66556008)(66476007)(4326008)(8676002)(186003)(5660300002)(8936002)(6666004)(6486002)(478600001)(316002)(6512007)(38100700002)(110136005)(6506007)(83380400001)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnNnckpLMDRESGsrUUF6djFaRHpYTkRVV3JJKzdmcWFtYWpCaFVobmVhVEpz?=
 =?utf-8?B?bkNUNDhhZ3ZRWmRUQkVYa085a0pGaEdGeWpyWjZsRlJhWkVjb05uZmhjNVBH?=
 =?utf-8?B?U3dvWDRsSWdVc0VzOGp4Q0hnZWhUY1lnUXl0RVFmZHNpTzByTndjZkE2Z054?=
 =?utf-8?B?d0puS29odGc4MUVDU3ZwVGFzVDN5LytEQ01lZVB1TXRYenN3ZjZjdU8vZkNq?=
 =?utf-8?B?dkphdTUxWmk2S2hMdWJIalNMbk9NZm9XVjlnSFFvbTkyd0p6NW41TysrVzBS?=
 =?utf-8?B?TDZQdWtVbitSTDZTZ3pITEdEdjVaYWR3aGFUNU55Y2ZDMkRkSUV4VGlXNTBE?=
 =?utf-8?B?MEwwSkdlTFl2S3p2aEQ4ZzBTN1BkVzlPeUdOZ1ljUmczUHlnSXV3d3FBRVQ1?=
 =?utf-8?B?TzRxWUdpRmQ3WW95Y0Vzc0Z5V0VDRHljT2orQXhmRStmL1FWeFppaWRLV2E3?=
 =?utf-8?B?cnlXM2N0Um5QSXNkWmJpcEZCakxoa2ZmNkhVWVd1SnlsSXhoZHdUTHZJSnJ6?=
 =?utf-8?B?Qmc3QmVIb1A1aDFHTUVOSUQ1dCtyMlAxS3k2UHNCZzdCWC81VGtKOHRZUThH?=
 =?utf-8?B?MWI2QSsyelczaGFpMUdEVmtIcGUzK1c5T3BmOVRUYlViSDJ1aUh4NEJ1WStX?=
 =?utf-8?B?V2s1NzRYNERvbm5PYkR2cHpRQ3BoRzhJQzYrbGNZbDRaVmM4MC9SSzlUZnVP?=
 =?utf-8?B?MEZSSkw3NVV2cFhjS2IvdG1NWW44UmhqVXoyWnNRdWx1L3ZJellyNngxdEJJ?=
 =?utf-8?B?MnBDZzFxTXJIbllxN2Zsd2xyc0FQcEJLYUczeUttT3lac05sYnRCd1VlVnJG?=
 =?utf-8?B?a2ZDUFZDZVFXdzZCVy9xWU1vSFlBSURDeE0xckNSeUtiUGcwWDNtUEs0TDh6?=
 =?utf-8?B?TzB5MnlHTXdZOHJvM1RMY3lHVmtWalJvZGZDOXcxbUppKzBlWER0bmpRbHRp?=
 =?utf-8?B?MTNyclB1bW02dUxHUzNjdkRSeUxibGtNbm4rM0dkc3VSaldFaTZ0blBzL1pZ?=
 =?utf-8?B?WU1xODNMTlNWUVVRUTJPQk5jSWV6OXNidjFuMWREbFhWVXl4eEk4b1dwVjFP?=
 =?utf-8?B?UjMyUGNGZkJYYksveUE5TjlvUVovQTRqbURCVmlJQzVMandwNDFnYzNybDdW?=
 =?utf-8?B?RUxCUExRVjcxMVBvOVpGdldPcW1xRHFnYnFSTmN6dVBCeW1VazhIbjZJV1hC?=
 =?utf-8?B?ZitJcSthcXA1R3VYVDZaZWdoZno5WHdHVm1jN2JsVjl5NFEvUzhJTURDY3VH?=
 =?utf-8?B?SUtxcStoOHNGVk16YUtEUE1vOCtJVi9uOVFoWk5tMHhYa0puTjBGS0x6MUFB?=
 =?utf-8?B?UC9TTlJCUUh3MlFncFBQU2N0NXgxQjJyOWVTNVZPZis2V25pVlNYV1dZZDF3?=
 =?utf-8?B?U2w0UW1PK0dpU0cySHM3eG5CNHdQQ1RTQURUOTFzY0wzZGJtRzJyMitiZlR2?=
 =?utf-8?B?amhyNlM4N2pyby9NUUVHdGJmclRPcFdibGx5TzBGMys3SVU4OFB1M2h2bWNG?=
 =?utf-8?B?MnA4K2hkQUsxaHhIeUF4VTlBaG16dzExT09TdUt2NnR3c0F3L2JFRmx1ekJa?=
 =?utf-8?B?bUR5c3RLODc4ZFBSaTFMNDZUNVNKRVZacnA4TGV4UGxHVzJuOFBLdVB4Nkl5?=
 =?utf-8?B?U1NhUytjYnRtcGc1cWYwdytFR1IzdXl5MDdGZDE3QjVHa09SNmVpME1uU0to?=
 =?utf-8?B?R01FcVlRcUg3UHk5Y2RseW80RElHeW16eEJZRHNma0VpeTFFTVRlNXMwNGpx?=
 =?utf-8?B?blBWWjlkakMza0h0cS8xeHJnUWIyOTc2M3BMa0R2TjN6akVxZVJSOEs3REp0?=
 =?utf-8?B?ZWJVU2k4b3d1d21LTjd1R3gzbWNpbmcxT0FsK1lMdG5kNDFRL0tBbGRZdzVn?=
 =?utf-8?B?cUNSeDNvdmMzcFZLVzhGQ2hmVjIwT3I3cHVXQlh3OGY0ODRiSktrZEQ5TDZJ?=
 =?utf-8?B?ZUkrQ2NiUHJnZU9uamdZd2JkU0xjbTJ6ZVd2UTlxYjArb2xWUVpSOURWK0dM?=
 =?utf-8?B?TGFKWXVCWng5dTNZNC8zQ1h4dkZsWk9PRFJaUGdRNUY0UWNyNFYyT1FqeTZ6?=
 =?utf-8?B?UUtMRERBbDMrcURHT0JwZE9FR3R3ZFJHSHk3NkZSOXBPTjdYb0FrS1JSdVE3?=
 =?utf-8?B?ZGlWbDBqTW5ScnRGWE1YRndCcjg5RTF5WmprQ0FnL3Z6cmY3cUJ1VG1YUFRM?=
 =?utf-8?Q?cXT3tjmzXPtSFW7mxqW1mxa9r/W0XCQvHlIsZKOMHg5n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a717ece-1f05-42a6-70d9-08daca1d9f58
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2022 11:03:00.4300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6qYPWs74OgVHX1LgfjC0QD1LowdafGYCuwS57llSgZ+QZOCqymr201Ii4DsWRDzi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5115
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Alex,

Am 19.11.22 um 00:09 schrieb Alex Williamson:
> Hi,
>
> I'm trying to get resizable BARs working in a configuration where my
> root bus resources provide plenty of aperture for the BAR:
>
> pci_bus 0000:5d: root bus resource [io  0x8000-0x9fff window]
> pci_bus 0000:5d: root bus resource [mem 0xb8800000-0xc5ffffff window]
> pci_bus 0000:5d: root bus resource [mem 0xb000000000-0xbfffffffff window] <<<
> pci_bus 0000:5d: root bus resource [bus 5d-7f]
>
> But resizing fails with -ENOSPC.  The topology looks like this:
>
>   +-[0000:5d]-+-00.0-[5e-61]----00.0-[5f-61]--+-01.0-[60]----00.0  Intel Corporation DG2 [Arc A380]
>                                               \-04.0-[61]----00.0  Intel Corporation Device 4f92
>
> The BIOS is not fluent in resizable BARs and only programs the root
> port with a small aperture:
>
> 5d:00.0 PCI bridge: Intel Corporation Sky Lake-E PCI Express Root Port A (rev 07) (prog-if 00 [Normal decode])
>          Bus: primary=5d, secondary=5e, subordinate=61, sec-latency=0
>          I/O behind bridge: 0000f000-00000fff [disabled]
>          Memory behind bridge: b9000000-ba0fffff [size=17M]
>          Prefetchable memory behind bridge: 000000bfe0000000-000000bff07fffff [size=264M]
>          Kernel driver in use: pcieport
>
> The trouble comes on the upstream PCIe switch port:
>
> 5e:00.0 PCI bridge: Intel Corporation Device 4fa1 (rev 01) (prog-if 00 [Normal decode])
>     >>>  Region 0: Memory at b010000000 (64-bit, prefetchable)
>          Bus: primary=5e, secondary=5f, subordinate=61, sec-latency=0
>          I/O behind bridge: 0000f000-00000fff [disabled]
>          Memory behind bridge: b9000000-ba0fffff [size=17M]
>          Prefetchable memory behind bridge: 000000bfe0000000-000000bfefffffff [size=256M]
>          Kernel driver in use: pcieport
>
> Note region 0 of this bridge, which is 64-bit, prefetchable and
> therefore conflicts with the same type for the resizable BAR on the GPU:
>
> 60:00.0 VGA compatible controller: Intel Corporation DG2 [Arc A380] (rev 05) (prog-if 00 [VGA controller])
>          Region 0: Memory at b9000000 (64-bit, non-prefetchable) [disabled] [size=16M]
>          Region 2: Memory at bfe0000000 (64-bit, prefetchable) [disabled] [size=256M]
>          Expansion ROM at <ignored> [disabled]
>          Capabilities: [420 v1] Physical Resizable BAR
>                  BAR 2: current size: 256MB, supported: 256MB 512MB 1GB 2GB 4GB 8GB
>
> It's a shame that the hardware designers didn't mark the upstream port
> BAR as non-prefetchable to avoid it living in the same resource
> aperture as the resizable BAR on the downstream device.

This is expected. Bridges always have a 32bit non prefetchable and a 
64bit prefetchable BAR. This is part of the PCI(e) spec.

> In any case, it's my understanding that our bridge drivers don't generally make use
> of bridge BARs.  I think we can test whether a driver has done a
> pci_request_region() or equivalent by looking for the IORESOURCE_BUSY
> flag, but I also suspect this is potentially racy.

That sounds like we have a misunderstanding here how those bridges work. 
The upstream bridges should include all the resources of the downstream 
devices/bridges in their BARs.

> The patch below works for me, allowing the new resourceN_resize sysfs
> attribute to resize the root port window within the provided bus
> window.  Is this the right answer?  How can we make it feel less
> sketchy?  Thanks,

The correct approach is to remove all the drivers (EFI, vesafb etc...) 
which are using the PCI(e) devices under the bridge in question. Then 
release the resources and puzzle everything back together.

See amdgpu_device_resize_fb_bar() how to do this correctly.

Regards,
Christian.

>
> Alex
>
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index b4096598dbcb..8c332a08174d 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -2137,13 +2137,19 @@ int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
>   	next = bridge;
>   	do {
>   		bridge = next;
> -		for (i = PCI_BRIDGE_RESOURCES; i < PCI_BRIDGE_RESOURCE_END;
> +		for (i = PCI_STD_RESOURCES; i < PCI_BRIDGE_RESOURCE_END;
>   		     i++) {
>   			struct resource *res = &bridge->resource[i];
>   
>   			if ((res->flags ^ type) & PCI_RES_TYPE_MASK)
>   				continue;
>   
> +			if (i < PCI_STD_NUM_BARS) {
> +				if (!(res->flags & IORESOURCE_BUSY))
> +					pci_release_resource(bridge, i);
> +				continue;
> +			}
> +
>   			/* Ignore BARs which are still in use */
>   			if (res->child)
>   				continue;
>

