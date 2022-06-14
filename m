Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C8154B842
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jun 2022 20:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbiFNSHq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jun 2022 14:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbiFNSHp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jun 2022 14:07:45 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2064.outbound.protection.outlook.com [40.107.95.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9B513D2B
        for <linux-pci@vger.kernel.org>; Tue, 14 Jun 2022 11:07:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gichiAYaqUbSdgqX+oxbgTys6nv2Tnm8pNLq199vWPo0tiBJwkZBACEO2HUevkQkDI6l5LpdYzMDKHl+5k/LRoID3PTbwEaV6SIG/jfy8XdVEAfYOhnJ//aIu5zDHTqZ81azMrKChaWKcoyNjYAL5rDYb+wyoXtEbjqt80egnUeSWfbAFkTO3tD9D7T5VMPMHPPZzeLru0xOgIshPbtKXAOcmUJn5FtEARmj0aVAChhFo60MCVpRoUNgbhn4XRY9LrrGUGhAHtnjU6cprA9ZIBwfT5LZxG6eak43JMsdnbUJim0OZYgh+dvup2gLY/lK5wxdcjtdMNsooqeS/BxUzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zejMlUrt7lLeRq6Ueyl4Bi9AsKRA69wIvu6wA81QLg=;
 b=ivrc5QLunJRZKPNt5DuvDHhTH4LUPPLQZhjWjD8GBwgccqJdjojHgdhvQpkAH2jt7EoK4rQtmxmc6pn8f+UEvzAkxP15SPCG1Y1JEAK+UQQYNvEinx+ZZWs329dioCSnq/3tI/fsydFwi8tmjTKeeDN/SB90HFGgxcqtRZuTPlu3L+WvLRXWVCtB6Xr5NrHn/6UW1YshYDJ9TAIQ8GbUi9C7yYSYooZ0/l3buniNaJr9UVsJhKRzYO4jD5NUSct6JPoR6N5Chsz68/X6B2Cdwtyi1PxIsB4lwqZE2u4jtBkDaJNIV88b3zPYcxBy9yJRqXnGztKEKO7QfMMXymzo7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zejMlUrt7lLeRq6Ueyl4Bi9AsKRA69wIvu6wA81QLg=;
 b=Exi4+ilPeo9UI28srA53OzaZLX5gQeDSzdoiD62RndVjo7NjENcaP1UP6OCfqpfZgyHCMWvs2ssP1ztmDlPfwWeZN//jhVw4AmbCkCRKiQ/9QESYvuX7N5ys+6i/e+s/kTik1mmIdUwejLOYXDm9BCp1+n9ZI4V0c8+EAmZOaWU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.22; Tue, 14 Jun
 2022 18:07:42 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9da9:705a:18ae:5e91]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9da9:705a:18ae:5e91%9]) with mapi id 15.20.5332.022; Tue, 14 Jun 2022
 18:07:41 +0000
Message-ID: <830edffd-edb9-e07a-a87d-21a6f52577e3@amd.com>
Date:   Tue, 14 Jun 2022 14:07:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Question about deadlock between AER and pceihp interrupts during
 resume from S3 with unplugged device
Content-Language: en-US
From:   Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "anatoli.antonovitch@amd.com" <anatoli.antonovitch@amd.com>,
        "Kumar1, Rahul" <Rahul.Kumar1@amd.com>,
        "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>
References: <0fc31d9a-f414-a412-3765-5519cbb9b7ff@amd.com>
 <20220210062308.GB929@wunner.de>
 <f3645499-f9ce-4625-60c7-a4a75384870f@amd.com>
 <952f49bc-81f9-68d3-89a7-b89ea173f6df@amd.com>
In-Reply-To: <952f49bc-81f9-68d3-89a7-b89ea173f6df@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0115.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::24) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4da28ca4-3fc8-4e17-aa68-08da4e30c5b8
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB61012506B348875BE99A8869EAAA9@MN0PR12MB6101.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kq1IjjxrFiRTTyNMfBStevqjcjEwvz3kCu+pDu4n2Dj+7HvxGNwbYwsfeX3lDR6IWJzj84yLEmGWCqQ+fNjTCZv8wolVVaLX7vTvIs0g7dyafnP4bQdQXHVIt243XVrViuO2ySgZsrwMM0ILukTtVanR7UiaVTJmW3o6olIwVu3hMGQlSvJczPp392FHzWFgpkcu2lFXwUA1F46WmwQgsxWfY9AeHG3nCqyo4uUWju55TbJVrwxNGA7hGCfWaJt0u8yNPaZC08k0mqNknFekFozmsQZq8fbXqCTIHjVgjo6aDdh1XFDMyrFufCKtVNIAL2nKkk6ME8o76zY9n3/jHsHFPhCii24FWvPw+RKbUTHuVpSWHI/WR+e5ulx0AKWVkX6g4iU+WeeQcnKHv+wXvGSnhwjce2PNu9nVVv6doybS1prg+yapYa5G8+2/jS9oCudjRRzYZenDi+g4q3MyT2DzNt4OjwXqtbG9DBSE107nOtyO0yZrA7Y/HozUcazereLy/6rcUN0p6RLH3ucJ4Ko1OItiZB4DMhg3UYzh1XPmI3gDTQTbnkQbOY87tXOw4Kcx8EjoTu436Yt/gf3WbPk3gymKIcpwq7KmGASIR7c8YJwfQiZcLdDx0dZtH2z6rjWFghm3KYo2u78bE1ffaITs3kGXcOCcBKzZ8VQlFd1kY2cd27lSuCkqjOU6QgCMulxtDNvK1djftEXyZ8uuCo1cD9UF7DwwrVY+COjwgj2Pvs4+yK9Co9GmPK3eCbxBK5uh6vcTOBjZAbHuvZthxIpZx2FYV4ncpDtsopt/SljvgwQp8EGS7TGUHfNT0Ffy0+ZSzs+rqXki1ZruAs1oOgPVq8WzRxaaw+t8sjEYy7M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1947.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(6666004)(6512007)(38100700002)(2906002)(6506007)(86362001)(31696002)(53546011)(6486002)(966005)(8936002)(508600001)(5660300002)(45080400002)(44832011)(83380400001)(6916009)(186003)(4326008)(66946007)(66556008)(66476007)(36756003)(8676002)(316002)(31686004)(54906003)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2VEVThMTGEvSVJHZzVzQ0VReFNsdXhPd3AxTHZzeHFMaGhKblZON0xDVDl6?=
 =?utf-8?B?VFNiNFRubGFpOFhQZlpReW9WRHBxK0xGaEFseWtYWW5vbys1SEJWeXBrbnFy?=
 =?utf-8?B?RmZFOEpqNUpaTFhXcmtramUwbDAwTUFudmo2MFpSVU5ldzIzcFNBUTRqOGor?=
 =?utf-8?B?QWliSFR3ayt1bVNVaDBlT05lOGlBYUdCUmJ5MXgyRG55TW1iNlBNSjJqakp0?=
 =?utf-8?B?dEJSNXlBQUpPWG1RUVJCUGRhcXVhZitXME9qN0hheEJETjgzVzJ2SEw5cU53?=
 =?utf-8?B?S29YYS9HUXgwMWRSK0p4dXp4TmVDOVRRakJqQW83ZFM3ZGxSVUljc1FIdEV3?=
 =?utf-8?B?NERxbTgvejR6RWJHYlc4THovVmlRM3FhL3dhdlJRbzR6NVFrMHJtdVE1TFQz?=
 =?utf-8?B?TmY2M3BBTEVxRjZpV0VraXBBUHoraEZ5QlExbzZBRTlqclJZVGIrMnNGTTUv?=
 =?utf-8?B?cTRTTC83Wk9FODRwMVRlMmVuTFBzamZyQXZ5YU5VRUFlRnhyYy85V0xlR2lV?=
 =?utf-8?B?M0ZhZmNXMDA5eEhiZVJWNXNHQXluYkJURGlIZVVLdUZxajlqTnBHcVI1bDgv?=
 =?utf-8?B?c2NBREVOMHZ2M0JrQmJTd3BUQVZRcVZmMjNuTjlncHJGWHJiVGkwaWU1bEVF?=
 =?utf-8?B?cmhjYmhRdmJOeTZ1Zlg0RFBGTFJIUVlqanc5T2wwQ29yRHpRNVYzdVpIcGhE?=
 =?utf-8?B?WlB2VEVBejJxcGFZQ0lWVWE3ZUpkTnZWdlIwZG8wNVRDMGZBd0M1S0FRNXhp?=
 =?utf-8?B?dkNkWmZodTFNWjNBWWVjTjRHbjF3SzV3MktITnkvVzFNMXhJQkJ2bXBKTWY3?=
 =?utf-8?B?WlRSdGNpSDdXTkVuWDdLcmxDQ2NFb011QlFyQ05xRFVFc3h3UFhmVmxGNFdy?=
 =?utf-8?B?WW5uVzBKWmhEYzlMV1ZlMDdNb3JVVXBqdFRZS3ZCYzdTazBBTXZHRXU0ZlU1?=
 =?utf-8?B?R1FuMndNVE55b0tKeXlweFJuVWp6YmJiaWNmZ0tTTzV6RytGc0dLVzBNdnpF?=
 =?utf-8?B?MXhSMW8zUTJCRGRaQm56aHN2VnJrWlE0YnBWS1djQ2ZyUFpack1QSXRyWnR3?=
 =?utf-8?B?V092TW5ncjM0VHdJdmFvdVRtMnhsdVMyeUpBVlVUa2hXVVF2bzhTb3JYeTN0?=
 =?utf-8?B?bG9PdlNTb29reHNPYlV6MnU5azBGQ3FVQUVjRjhidVYycFFLZ0xrT3RHZUhL?=
 =?utf-8?B?TGI0RFppZ0pXKzFSUkNTU09BeGpBL2tYaG9tazg0U1E2Ykk2Y2VQa1ZLN0Z3?=
 =?utf-8?B?U2ROelRCSXdjTkFCeWMyRUtEMitEK09weWlrcm93WnlTMmdJOWgvd21Td1R1?=
 =?utf-8?B?Y3RYM0dMRDd3Qmlyei9vd2VGa0lWcWxoVjhQVWRYZllyQ2dGbXhBZ0hCMWNz?=
 =?utf-8?B?TmxXRjlkZFpDNVZNZmozRnhOS2VBQjBaeHNOVk1TZWdSZWNpdXB5ZDk2NVRT?=
 =?utf-8?B?eUs3UEc4YWhVVXRJS1pwek90SlBnemxBOFQ2R09JK3pKRzUxc1l4L3BPNDRP?=
 =?utf-8?B?QVIyUGtkUDAxaGhQelRwaG5RNHFBWjNuWTlyd2RZWVp2NWE4Y1pUbUhFTCtw?=
 =?utf-8?B?NHpEM0NNMGp5MTNackFjNVZKZDRPRkp3djFpSUdHeDJhay9CYXhGWGUyTkx5?=
 =?utf-8?B?MUZ0blRPaHVoVmZEUU94NC9SVmNjQUFWYjF2NEo4bDJCYkk3ZlZsakRSWmNU?=
 =?utf-8?B?OEo2aTl1L0tyT3ZlQVJXR2xRZ0xpNk1SazBBNmVwRXY2MVVwTE9pZk4xa1Jp?=
 =?utf-8?B?cmZ2Ykw2WmlRbiszckNqbkF6TWhLdzlBY29kaGI4U1J6dzV1Z0tUVXByN0Z3?=
 =?utf-8?B?c0E5TW5mSVFKZzFSaklQY0o3MVBwdHR0RENhNUZNWnY2R3Y1U0FlVCt6Q2Q3?=
 =?utf-8?B?bk13Z1lUL0NEdGRIa01BUTU2VWszYWlPcG9iSE1NTnZPL3RWTjVZclEzKzF0?=
 =?utf-8?B?dHlwaWZkT3lQNUlQcjFzNGZRanN5SGhiU3JwRStEckxDZmRuRm4ra2lMTHhy?=
 =?utf-8?B?UEUwMW0xZjhQWXNsQVNjMDBTaUhJVU9zRVdBNlJkN1MzZGZOa3l1SlljNVVQ?=
 =?utf-8?B?RncrakRCZ0dWNzZjOW1TUVhObVptS0pvb2VWdmFYYldtYkZYU2o3VG1FNmZy?=
 =?utf-8?B?ekMxN1p4YTJMUFRiNTVRWUZyUmNpMVJCYXR5SzRic0ozaU56c3NFRm9ib3VW?=
 =?utf-8?B?QlhKUEVBUGtQS243U05kNEtKMy9ZWWFpRmhHb2x3MmNsbnF5cjAybVZrMHVW?=
 =?utf-8?B?eUVZQUFWUGhXMi9vSEltd1NadzluVFRIdmp5U1gzb3Nxdlg2RXM1UndsdVRW?=
 =?utf-8?B?ZjFHalRsdjg3b3dZRFUxUHNRUUdNQzA5cnFVVnhzVkU4cUxxSkMxSlI2Nnc3?=
 =?utf-8?Q?t86t+gGtxw3lcPtw5dzD+450N6xBoLfjMLZSPYaUv3/51?=
X-MS-Exchange-AntiSpam-MessageData-1: FrXKcuStfKFXmg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4da28ca4-3fc8-4e17-aa68-08da4e30c5b8
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 18:07:41.2238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a9GRBawMeFQKJ4APbLxdVS3+ohb373LnDmRUJh2IDo0y1ZCPhJlAqrvDjS8eV03jST4plNmDGJjtJpg2bW70aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6101
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Just a gentle ping, also - I updated the ticket 
https://bugzilla.kernel.org/show_bug.cgi?id=215590

with the workaround we did if this could help you to advise us
what would be a generic solution for this ?

Andrey

On 2022-06-10 17:25, Andrey Grodzovsky wrote:
> 
> 
> On 2022-02-10 09:39, Andrey Grodzovsky wrote:
>> Thanks a lot for quick response, we will give this a try.
>>
>> Andrey
>>
>> On 2022-02-10 01:23, Lukas Wunner wrote:
>>> On Wed, Feb 09, 2022 at 02:54:06PM -0500, Andrey Grodzovsky wrote:
>>>> Hi, on kernel based on 5.4.2 we are observing a deadlock between
>>>> reset_lock semaphore and device_lock (dev->mutex). The scenario
>>>> we do is putting the system to sleep, disconnecting the eGPU
>>>> from the PCIe bus (through a special SBIOS setting) or by simply
>>>> removing power to external PCIe cage and waking the
>>>> system up.
>>>>
>>>> I attached the log. Please advise if you have any idea how
>>>> to work around it ? Since the kernel is old, does anyone
>>>> have an idea if this issue is known and already solved in later 
>>>> kernels ?
>>>> We cannot try with latest since our kernel is custom for that platform.
>>>
>>> It is a known issue.  Here's a fix I submitted during the v5.9 cycle:
>>>
>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinux-pci%2F908047f7699d9de9ec2efd6b79aa752d73dab4b6.1595329748.git.lukas%40wunner.de%2F&amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7Cba698967471548d739c108d9ec5dcf6c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637800710411446272%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&amp;sdata=hrRVL77%2FNRvojfG2WDamDLO5dsqn3Cv6XxNbP0eGum0%3D&amp;reserved=0 
>>>
>>>
>>> The fix hasn't been applied yet.  I think I need to rework the patch,
>>> just haven't found the time.
> 
> Hey Lucas - just checking again if you had a chance to push this change
> through ? It's essential to us in one of our costumer projects so we
> wonder if have any estimate when will it be up-streamed and if we can
> help with this. We would also need backporting this back to 5.11 and 5.4
> kernels after it's upstreamed.
> 
> Another point I want to mention is that this patch has a negative
> side effect on plug back times - it causes a regression point for the 
> delay to light-up display at resume time related to back-ported AER
> 
> Anatoli is working on resolving this and so maybe he can add his
> comment here and maybe you can help him with proper resolution for this.
> 
> Andrey
> 
>>>
>>> Since the trigger in your case are AER-handled errors during a
>>> system sleep transition, you may also want to consider the
>>> following 2-patch series by Kai-Heng Feng which is currently
>>> under discussion:
>>>
>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinux-pci%2F20220127025418.1989642-1-kai.heng.feng%40canonical.com%2F&amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7Cba698967471548d739c108d9ec5dcf6c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637800710411446272%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&amp;sdata=tnLUa6J%2FLqFrlm4CfZ9l26io0bOQ7ip30d26ax05st4%3D&amp;reserved=0 
>>>
>>>
>>> That series disables AER during a system sleep transition and
>>> should thus prevent the flood of AER-handled errors you're seeing.
>>> Once AER is disabled, the reset-induced deadlocks should go away as 
>>> well.
>>>
>>> Thanks,
>>>
>>> Lukas
