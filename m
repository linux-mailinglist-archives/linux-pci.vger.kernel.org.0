Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70DC59AC5C
	for <lists+linux-pci@lfdr.de>; Sat, 20 Aug 2022 09:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243758AbiHTHxH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 20 Aug 2022 03:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235135AbiHTHxF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 20 Aug 2022 03:53:05 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2051.outbound.protection.outlook.com [40.107.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484C2A8325
        for <linux-pci@vger.kernel.org>; Sat, 20 Aug 2022 00:53:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UuqrQQD7xUUl/smv3eYM7RvV/C92qZPddsJG+lQPgrhhdz4JCiWHACUvy3QmeC3gudSJawdY0qScf3f9d2CJlyH4Fl7ip5G5QAfDZhvz38iDCdhw8CbRCDLhM9JY9HtLRohqUvX4jOrxKa1ENpSEbCMxKzErX9hAv0RBp4QXrqALFQfCpwI6Vrr7EBMy52AmO0UGmGIswBy7wXXDv0cn+ckrvHOc70fSyfFwIJG2CTPHusg/snxxhtaWN6sDDpn0LeIQUI8Q4ak9oqyaKt7JD7UdFrYE3GBxXR8r5h2GaIdxsqIAMW4Lpt/P+1WXA0YTcF7jsGxq2oYoh2mlubFhaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVbbvIuMoc9Llpro/M+t5SLke35456D2cCkHpcSIE7Q=;
 b=XdkwE94q9LirmMXdRtuw2yf158Ser4Gif0jjF8SZ51eBTtga8mefpn+9Z57RK2xRE4Buu38pISwEXKY0cRj/0bKtFhBF0ckpj9LgnhpLJF0szG+PPFEBUgnAvte+lliANMAS+yoQXEzw3Dasw6LJ/K651+Vc//aoD44SBI3N7FXo5hKoxlFc5cKjU0+SadYiu36rSOP1HpofzRSlw4eMtGpmoNMHt3biQ5B3NUaHY5ZywMlenYRiER/hHxETpmMMPwAM6BHaXv2szIBYsJW19OfTLDep071OYIUulJFNr8V8ftDNjit7jq2PB3eX/eCkW7LEGATwOte4RkMxRdTjaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVbbvIuMoc9Llpro/M+t5SLke35456D2cCkHpcSIE7Q=;
 b=2P1CcLDKfrbvWIpITp4J8X8pdAuRwcRhXEATF3qmqU9gRmlDSuvIop2V9jrpydKlrU2xKGsXpe2vQYNciYMv2CDJKV9Aa1x8TiDPN4rJRPUKA4/ljG0ataB9Goc9KgTb1087Np4w5QqmcWG7jzSCiwneK+D/XZB24GgFs3t54Oo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by MW2PR12MB2473.namprd12.prod.outlook.com (2603:10b6:907:4::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Sat, 20 Aug
 2022 07:52:57 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::4195:ca0b:381f:7900]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::4195:ca0b:381f:7900%4]) with mapi id 15.20.5546.016; Sat, 20 Aug 2022
 07:52:57 +0000
Message-ID: <6aad506b-5324-649e-9700-7ceaaf7ef94b@amd.com>
Date:   Sat, 20 Aug 2022 13:22:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [Bug 216373] New: Uncorrected errors reported for AMD GPU
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Tom Seewald <tseewald@gmail.com>
Cc:     regressions@lists.linux.dev, David Airlie <airlied@linux.ie>,
        linux-pci@vger.kernel.org, Xinhui Pan <Xinhui.Pan@amd.com>,
        amd-gfx@lists.freedesktop.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Stefan Roese <sr@denx.de>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20220819190725.GA2499154@bhelgaas>
From:   "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220819190725.GA2499154@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0150.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::35) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2cb282a0-c80f-4860-d53e-08da8280fed9
X-MS-TrafficTypeDiagnostic: MW2PR12MB2473:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Z91fF/2m6KWoRNgN2H+zvSh0bPO24BjosG63rRb3QFBibFwkKqDff36xpJ799tsyuV2AFqEsTkL79oRYAFr7PmKG8WsE0DKC4WVe/mhw185mq3WAeKL8rdyAmQtCXOf1VYQjyUr5Wx7dNF92WGxF3aVOsTZxqm3wV+IvGjrzApTg6wN3aCBvmfBqGB4OsOcRPB1f3iUwlNKwO89XC+yczaNjDCEab2q9iVXTeqvlrE+EGLvNGAkIGa8xsPqKjhy0P9rXpP9CfchGwJBN0R5DUhvcJQkVGvRddiyvl6hgu7wF+R/c4xuhJe7niiKshCv2gYzwRGS5E9ioFp/l7Nl/Di6VwW9rO2c8HyfV9dh6FyUniXat+XryGEwicP5DjDXZHLYqKbH4kMzQmGLUNkITL4ly/k7ER2Y5a7Rd0CRwRZnxb/Wpmmurh1TlA+Z0QNXE1ekXEFkwbMnQty4hWBDe1FcTx1RLgUjh9akUUIDEAxbliLISuR712GiPyMChUGhsrU8MZcXli/F7pVO0xzSQK4vjrorWCX5Bn6JMtGeLh7s+4mbxCgfTQFA8tYr/YTcBnVOXdigDniXW0SxYtNBsSqigqgLJm6HWbY+8sY1ceRUQc6NPCAEFc3JCepoLKuHBRRAd7D76YF5VslBWdqjYXKcuwXLKPR5nA/a1gEqi6tvsPC247bDValhDNI8RiYQFbEwDRIG9rgBgmOEDMpvFIA7tntVDx7HABOh9m/6TnJSpMBL7G1AzMyDO4atU7hh0eTP1wSjPULR3ad2jOv0OVv5C778EgT4+Ozks8I8B1n77XClQX8jVYWYnMkiv8SQmYxeqMIhevr0gkgFRFXHQnEUho6WB5SCe5XMAgM9Jlto8ImLtwhN+VXsfnpbYYPc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4614.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(36756003)(31686004)(26005)(2906002)(6512007)(38100700002)(4326008)(8676002)(66946007)(66556008)(66476007)(6506007)(6666004)(53546011)(41300700001)(2616005)(83380400001)(186003)(45080400002)(8936002)(5660300002)(31696002)(86362001)(966005)(6486002)(478600001)(316002)(54906003)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGtvWkkvZjcva0ZJdUF3YnFVbGV2NTViYTNTdE92Uk1BRmZhVnBqSDlQN0VI?=
 =?utf-8?B?NTlOWk4vanc1Uk5CQUgxVG0zcU5kMm96ZFhibmpyYitwRFhhT1pYcFVOYVN4?=
 =?utf-8?B?QlF0QWpOL3I0Q2JHUDF2MGluSTgvckN2ZW0yUHY2enBMVlI2MFR3VVpLVmNB?=
 =?utf-8?B?U1lJMURnK20xRHdjaG02SXJQM0JZMDRnbFI3TEZQRmFTdUJCb1F6MGhSTG9G?=
 =?utf-8?B?RXZLMnkyYmhSVmFvbnh6TTJSMWpoSGtmNTFUTFVZaHRiV3dNaGwzamh3NkJa?=
 =?utf-8?B?aHRjbzZlcnBHNSs4YnNkaVR1Zlp5M1RrQmprOTFSRll4QzUvQit6ZXBveUN6?=
 =?utf-8?B?N1k0c2M2aTVzUXE5SEtGb1J4WnB5a2tyVXJOTVZsNGhoK1ZYcERXd29IV2JV?=
 =?utf-8?B?UG0yU2N0ekVQa0lzRDVsdmZEaEhIdmRuUE51OHZVdE84NUl5Qk9Jeldac1pj?=
 =?utf-8?B?VWZvd1oyQys1a2hWQXQ2eTFRbmJJa3kyNzc4SzFCTUlEbUJCQlBPYXc5dG84?=
 =?utf-8?B?S2tpUjBOeFozMkxUeXljVGY3aEk2b1p4SzJnUzB5OGlBaVdIYitydDFvNms5?=
 =?utf-8?B?VEpRY01yUENROVQ1dXJyeWhXaUxqeFZvQUlBdXlaTm51eGYvV1ZpS1RqNC9S?=
 =?utf-8?B?dnZhVTBNWGZwOThlT0ErKy90U1R2bTRXWEd6TFdtSFFPcFEvNXdSQk4zdVRK?=
 =?utf-8?B?SFQ3QzdjNTY2STluZTVGZ2dzQ2t2OXFKN0J2L2dkRUtMd3RmTEFISVZEV0NH?=
 =?utf-8?B?SUFhSzdKRExubnd5SEZ1RDJ3VTU1WGxZNzBJZ2xNQlJYb0RLZngzMjcyMzho?=
 =?utf-8?B?WDlVRlNlNlhGbXozWnJPL0RkNElFUHhqd2ZseG9hdlZhZlBTTWxhN2pvc0dp?=
 =?utf-8?B?dVp4Tnpkc2pvQ0ZWbWhBWGxHNmY2SHhhWDNRb09rcEhFeXJHazFxRlJNMUpx?=
 =?utf-8?B?di9wbEt6ZVpUNVM0anZRc2ZpK3pkNk9HZjZWRXVmWG5pR21aLzFnUCtjRGFF?=
 =?utf-8?B?RTIrY2V6UHN6NEJwcTgvTUlwV0J5bWJsT2xXRS85QXlJTHAyWmRBdnpJN25Q?=
 =?utf-8?B?LzluRnVZYndaSmV5MVh6VitkamdyV1VtY2JINk5hcXEzcGpFdzZRMjlhREMz?=
 =?utf-8?B?NmFJZkZUd3k0eU1ET2N6TGhZM1BXeVFLUUovMkJPb2dGNWVaaFU2cFNMMERk?=
 =?utf-8?B?UTBTalcweGN1bFpZODNFNjgxWE1GR2FjTnRUZVEzMjkvNGxBMU9aeWsrZ1dq?=
 =?utf-8?B?T3ZFNkhmbys1YWpSNFpid1ZJZkZ2a0REcnRRcnE4MXJpSXovWEZtUStTWTJv?=
 =?utf-8?B?V25WdGoxZk1xNHJST0Vkd241aEExSG5keVUvYWdpV1VOQ3dsc3hnQ25kZjZP?=
 =?utf-8?B?a0E5b2xCUDJmUG5pQklpUTkwRzc5QWdLOStLL1ZzMStTRkxuanJqS25nMHZ5?=
 =?utf-8?B?M2tGZ0hMbXZWcVFXc0lGVml3aVVSYjQrTmhjeFVGMzgrOVJUWDVxaEw1RUJk?=
 =?utf-8?B?OFpWMlVIYUlEOURPd1htN1czSURmK2VpVlY3WVZ5eWJxNDA1R21PMUhtZk9w?=
 =?utf-8?B?ZU5qVENWbDRiVTVNUGt5RE00eU1Dd1FTYWg1dXZORFlTK3FucmZ6SzdNbkZK?=
 =?utf-8?B?UldQR0tjQk03dmVqUWJVVnpxME9jb2NTeVJKeTNMOVkzanlyaFZtT1JBZHVs?=
 =?utf-8?B?cWpnamE1RXVQQVVIMVlIdW1maW1xenhRY2lmMWRISXUwVE9KMzNaN3VuZEJx?=
 =?utf-8?B?YjdYWkg3T3lUeUo4TVRRdzE1OWFzU2laQkhVNkZPaElya3g1NVZkakdIbVZx?=
 =?utf-8?B?ZHIyYktlcFkyOTlTUHF4MkxIZGZKL3NTTnpXRXlVWWhKKzVqYlRieGhzR0dq?=
 =?utf-8?B?dUdBT28xVnJUYTZ4eUVpM3RHeUdtb3BCdXNuMTRvWHVRYlhheTV4dVBBWk92?=
 =?utf-8?B?aGxHcUZQWVU2b1E4SFJjM1NyUS93RVlESEliaDZNN2NSaE5KaU8yVnZtcXgw?=
 =?utf-8?B?NGZXeldqbjJ2bkZrcnN6NmJaZGhrSVJ4clhoekc5cys5dmJ2NFJVY3hmdEQx?=
 =?utf-8?B?Q2hPUkx2Zm15T2VWeFVNNzI0emlEdS95TkZZZU4vWUloLzdHMkw0SUw3dWR0?=
 =?utf-8?Q?DQIcz3EpGFb9geOZ1onfW8b/F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cb282a0-c80f-4860-d53e-08da8280fed9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2022 07:52:57.2897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +NzaZSTFTZ9iVpBdB6BWEiuZC9+x3gCXl3OzOZ6xp7eqdk0rlhAW3tevigOF/Sj9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2473
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/20/2022 12:37 AM, Bjorn Helgaas wrote:
> On Fri, Aug 19, 2022 at 12:13:03PM -0500, Bjorn Helgaas wrote:
>> On Thu, Aug 18, 2022 at 03:38:12PM -0500, Bjorn Helgaas wrote:
>>> [Adding amdgpu folks]
>>>
>>> On Wed, Aug 17, 2022 at 11:45:15PM +0000, bugzilla-daemon@kernel.org wrote:
>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D216373&amp;data=05%7C01%7Clijo.lazar%40amd.com%7C958674b7d05040ddd93f08da8216107a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637965328525221166%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=otI1jfdKInPamMGrLyhFsVoGnK%2BIgL%2BcyMtBVPsV7bE%3D&amp;reserved=0
>>>>
>>>>              Bug ID: 216373
>>>>             Summary: Uncorrected errors reported for AMD GPU
>>>>      Kernel Version: v6.0-rc1
>>>>          Regression: No
>>
>> Tom, thanks for trying out "pci=noaer".  Hopefully we won't need the
>> workaround for long.
>>
>> Could I trouble you to try the debug patch below and see if we get any
>> stack trace clues in dmesg when the error happens?  I'm sure the
>> experts would have a better approach, but I'm amdgpu-illiterate, so
>> this is all I can do :)
> 
> Thanks for doing this, Tom!  For everybody else, Tom attached a dmesg
> log to the bugzilla: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fattachment.cgi%3Fid%3D301606&amp;data=05%7C01%7Clijo.lazar%40amd.com%7C958674b7d05040ddd93f08da8216107a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637965328525221166%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=pzmtR3daPOimRkX6fohHQTDiEkp8B9aCJX5Z%2BKUcq2c%3D&amp;reserved=0
> 
> Lots of traces of the form:
> 
>    amdgpu_device_wreg.part.0.cold+0xb/0x17 [amdgpu]
>    amdgpu_gart_invalidate_tlb+0x22/0x60 [amdgpu]
>    gmc_v10_0_hw_init+0x44/0x180 [amdgpu]
> 
>    amdgpu_device_wreg.part.0.cold+0xb/0x17 [amdgpu]
>    gmc_v10_0_hw_init+0xa8/0x180 [amdgpu]
> 
>    amdgpu_device_wreg.part.0.cold+0xb/0x17 [amdgpu]
>    gmc_v10_0_flush_gpu_tlb+0x35/0x280 [amdgpu]
>    amdgpu_gart_invalidate_tlb+0x46/0x60 [amdgpu]
>    gmc_v10_0_hw_init+0x44/0x180 [amdgpu]
> 
> I tried connecting the dots but I gave up chasing all the function
> pointers.
> 

Missed the remap part, the offset is here -

https://elixir.bootlin.com/linux/v6.0-rc1/source/drivers/gpu/drm/amd/amdgpu/nv.c#L680 


The trace is coming from *_flush_hdp.

You may also check if *_remap_hdp_registers() is getting called. It is 
done in nbio_vx_y files, most likely this one for your device -
https://elixir.bootlin.com/linux/v6.0-rc1/source/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c#L68

Thanks,
Lijo

