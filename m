Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134D46949A5
	for <lists+linux-pci@lfdr.de>; Mon, 13 Feb 2023 16:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjBMPAe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Feb 2023 10:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjBMPA3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Feb 2023 10:00:29 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25BC1DB88
        for <linux-pci@vger.kernel.org>; Mon, 13 Feb 2023 07:00:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DpxV8GiRa662jEsN7zJNKnyIgEJt83SZJdJ3EbvaLVZLKQUXbyKmT+0Giq8cyUUWjOzPAXBjKtK31tqxyTgQg0bhvRs9Xe+8/JedHLo+Izr/6llMgqlPX/mSXqFdRZypAi+Ww8H0+WnQTh9NA/Y2F184WoA6eb2IlL7yCbpnSN0NUCXiYlIyFKFzyehD/zsUZcBdJFQKgx4sEbXaikVnJEFGJFXnxd+C9AHSfBd/jD84ofGFoiLfZWg5+v5wdlBEfZOsj+owMxZDY0q6cPS38kr6vDwnFavbV1WTpSsuZkLL0LvUU78xIn3kQ302vRJ4c4VoOIYIqDmWSOpZaw/gqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W9qyDGHC+Nu8XmPVSN04ghEyFtWKOR9b12heed9m2XM=;
 b=GJwClMMRnx1NoOJEnQtAef5A2jpx93zWWposjVCzEDCupGwF6i1ecuRFVJo47OkEfyHN1sMJSoL3vcqXQItiYWnTZ/IytdhXZQZrpdN2SqVfDKl3HH5RS1w6/aYBh0zFrobKWKfwSZ9l/9UvzLK+pf6Li3EeWtQv7KGHduicA9Vaf9mVuu7wM94VK0/eaaM2hFlDMgkrS1aBFhXLU4BdP8xGmoBpXbo+noipcBu7uvVlmj0UioRWbie8YayJpNPTEtWkQZmhGzdVEiCW98fYYhDiyuAj/6tw9Vo0155pN52POEL9VhLFPt3sKCYThpP1TDC3ZdMYMTgkk1Smi0pxaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9qyDGHC+Nu8XmPVSN04ghEyFtWKOR9b12heed9m2XM=;
 b=eaMjhhmC/i9Ey6kHdVNzmYyUAMB+9BpAX0rU9H/fAO8a09Kc9XBRwrV694VWPU6o8R5h2c+ZdS67En2MF4a8PA37XRrRU8jlDIwsznvq8Cw/uieGlO/eluuyhovA+uyAcl9WRywbHjREY8b77j8HLIM8KkNcSKQLSaXiUHQmKSY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB7109.namprd12.prod.outlook.com (2603:10b6:510:22f::16)
 by SN7PR12MB6672.namprd12.prod.outlook.com (2603:10b6:806:26c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 14:59:56 +0000
Received: from PH8PR12MB7109.namprd12.prod.outlook.com
 ([fe80::43b7:f2cf:8827:483d]) by PH8PR12MB7109.namprd12.prod.outlook.com
 ([fe80::43b7:f2cf:8827:483d%9]) with mapi id 15.20.6086.024; Mon, 13 Feb 2023
 14:59:56 +0000
Message-ID: <1d474514-4d28-d41f-52cd-972ca7e3fc1d@amd.com>
Date:   Mon, 13 Feb 2023 09:59:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] PCI/hotplug: Replaced down_write_nested with
 hotplug_slot_rwsem if ctrl->depth > 0 when taking the ctrl->reset_lock.
Content-Language: en-US
From:   Anatoli Antonovitch <anatoli.antonovitch@amd.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Anatoli Antonovitch <a.antonovitch@gmail.com>,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        Alexander.Deucher@amd.com, Christian.Koenig@amd.com
References: <20230113170131.5086-1-a.antonovitch@gmail.com>
 <20230120092824.GA2951@wunner.de>
 <d14fd1b2-41c9-75bd-5b76-d2c396c1ebb7@amd.com>
 <20230121072148.GA13969@wunner.de>
 <22a64441-5eed-8d56-5c5e-80c425cf6967@amd.com>
In-Reply-To: <22a64441-5eed-8d56-5c5e-80c425cf6967@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0005.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::13) To PH8PR12MB7109.namprd12.prod.outlook.com
 (2603:10b6:510:22f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7109:EE_|SN7PR12MB6672:EE_
X-MS-Office365-Filtering-Correlation-Id: 24179477-df32-4a30-ada3-08db0dd2f839
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PhEKb538l0WUuAyOaOaKCKDCRFA7jtoAl58vHTd9Dw7EukZQ1lkWr6NWNl9Uva06GmJEiC+H5oWRoNyln0204NkjT4bMDF4Aiu9AbrN/ghsXcAOR6WhQPdDmjpKEvtBVjDWS86knlC1D8bEUNu7N03PStfrFjh9timMFISfLvgNicw2TpBwfZZt0de4cJVYynZQ42VtHHydVD4W5ChLaCxeviZa1xQ36uK1fTe/+3vAokWiRvICmj97VcGMXqvZvr0YXGtqV2NnGmMdDOlKNuwsQYBD1BcdGNd7YO3z9Ohms0pxlkajs5iNLU4yDdHUPTbmQBrX+ans2Kb2SDMcMvr/JjFKBtNYPxQ439WyEbSD8jt3ldS9nsIO29cBJ+C4pHA2ZWfNvOapqEK3PdU8ak9q9p49QiYJUlKxpNortFHudZld0iV6NTs0uCMRzx4e21slRXMgN1Eu/91vCq/eJkMXV7ZEwpJ5P0d7NMDEJ6sIwGFw6+PDIOrySfKzgDNdbzgDWZVlNnjWaIL5cA6jHHH5gHoo+nu9MICHgZMH3LS+/T2uCDjBBfh0tncNoNcLpneN0CRn8k5aFltoJtZSmurOAOKIos2banrfMhuIz0BH19meSEyrsofIg6Ae2FUlmaauN7oNccoxsSmW2VqjgFWMymq0y/MgmbRs0QoZdtXNiGIpjjkfjgkneNjDMTEBLHnvtrpUkHzO2lhvSxU35vr6RfyD6YGZPQCUKEbCZPC+uMnUDvzhzjlcuT387QdqGEvk/R8FmmsgbiJeZkGJFyoj9EgKbaAm8pgtOBbo0RpCh/Ee6HhLCMIzX40/6mOEO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(451199018)(31696002)(36756003)(86362001)(316002)(66946007)(8676002)(4326008)(966005)(83380400001)(6666004)(6486002)(478600001)(2906002)(6916009)(41300700001)(66556008)(44832011)(8936002)(5660300002)(66476007)(38100700002)(2616005)(26005)(53546011)(186003)(6506007)(6512007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHdON0RlV29hVXU1SndPRnQyUllzbmdDS29ZMTRuMnY1clgrdzB4VS9EQjVk?=
 =?utf-8?B?VUpGeU03a2Frd0NCM01kcVhlM2dFWTJIN2hwaFdnNG9CTzhxR0NvQitoUjlT?=
 =?utf-8?B?R0JLcWIybTZRbVNIQWV2QUZuNGxmZlVWMjlkVHVjOHBCSmhSMUszOE5FUm1r?=
 =?utf-8?B?c2xPbkVBTnJuVVlIQzRubDM3dlJnUTI2MnhOZnNsdURvR2tKMW41cjJvL2lx?=
 =?utf-8?B?MEt5RVVLT1NaT3J5amk4Qjd3SUJES2xZODRqWmVyYXZ0M1FybXdYbmZRWEtn?=
 =?utf-8?B?UXNZTHlzd3VnVjYwSTRtQjBVZzUvbjFHUFl4dUExc0Qxb0cxYm9lNjdSRU5n?=
 =?utf-8?B?cE5qd3pyN3ZqdnMyKzQwb0xMUXhKSmwwdzloV21Ick1BV2QrdlR3cnpqdTJ2?=
 =?utf-8?B?M1h2MEdIUUJJN25nYVNCdXZpWFpidkx1aEViRzdtOGt6WXdXUWVXbGNjYXdW?=
 =?utf-8?B?S3Jxak5wZ3NYdENDaWVuMno5SUhBaml0c05oeXcwV09xZlJmNy9tUUowVDJl?=
 =?utf-8?B?ZXRtUHR2eFMxaHNsNGZ1RGtKUmtQL2FENFkwOWlDVS8xcUZXa3ZBa2Vsa2F3?=
 =?utf-8?B?bVZnRkV6bDZ6Z0dkNzlFRnJsVzhSK1d6bVVxVS9McmhyeUpHVGUzWE40WURl?=
 =?utf-8?B?Z3Zwb1lkQTY2UzhWY0lvTnR4cWVaRDlPN3NldTdMV0o1QnRoaXhUbDhiYzNu?=
 =?utf-8?B?Z3l3MElJdFlsUEpXdzJQZ0xxWklxTXRIdUZsNnAvbDQvWUtkN2oyaFVUVlNo?=
 =?utf-8?B?WjBOZmRwd1pLbk85Mi9KcG1SeU9DeEk1a3lHNThMV3VVeXprcnNUUGN0MTFn?=
 =?utf-8?B?YzFUNjFtUVNycWwrYnFWUDljaDN0R0RacUQrYTB0T2FSRDdjNHdwNjhLeGZy?=
 =?utf-8?B?Sk5KV05EZUh6SEIvd0VYaHROYVMvblUra2tSbHRWRmVEaHFteHhzUVlzVFBQ?=
 =?utf-8?B?ZzdyWDdUYW4vbmpQNHJVYTdzYVc4MW5TTThqMGJqWUxWYWVpcHlIVCtxbXdW?=
 =?utf-8?B?RmdFb2pMTlVDeXUvQ0RTUTl6OTVyZHNmekNsU2xEMGMraUhUSksxT015UWtJ?=
 =?utf-8?B?YlRmMm9JYUN2VjNmNzN0VnlyRmNtU1NxaG5wOWZzQWdKeXkreG1idzdUUTA5?=
 =?utf-8?B?U2NvNUdKdmsrMWY5dUN2OWVHVHhWd2RHM2FPeHBPVTdRRHRVanpQZnFVTmln?=
 =?utf-8?B?MEI3WnpEMjVIR1JqbUhYUzBraWlvQ0pueG1CeWV1am1jNmFEeDBmM1VhTjBp?=
 =?utf-8?B?OWNMbFYrMGU4QUptbmVUTzVjT2VNbmlBOWZTUkJJRnBwV09ScVVBUWt3ZWor?=
 =?utf-8?B?VTk1UVVSb3gyYk1lQ24zNUdtd0ZmVWpqWE9LZ2pvaVZTRWV0UzNrUlNaNmxT?=
 =?utf-8?B?WkY4N01Sa1dzaVM0cU1IdDV4SFNCQ1A1RXFGUDNha3JXemZrQlBFYkJpWGNY?=
 =?utf-8?B?S01NMGpLQ0ZTSGdIVU80UUZJYWtmMHl0dkkwTVZFU1lWZWhLOHBWTzUyczJI?=
 =?utf-8?B?RkpVbFJYOTNpL2E4cmpwdld4akJteWpWMHV1RCtkUE5raEpqblJXNG56bXZW?=
 =?utf-8?B?V0c3TG1XSWxNOW5SRnQrSW1ZYndjdUwxOGtuS2Fmcml3UG1zbTJCaEtiNVEr?=
 =?utf-8?B?NmpPN29heFo1c3M4Y2MxeXdYMVdQbFRvMDdYNXlaWnp5eGxqcVl5dU9zV2tB?=
 =?utf-8?B?K3cveGxVUjVHUXlENzZ1eXBVL2JQR2x6eEdvVnd0S1VHaVplWWtZcEhYL0lu?=
 =?utf-8?B?aktnZERMTjduQUtPMkJKaUVlODdLWmJZM2NvYmc4ZWFUV3BvU3c3RENWc2tq?=
 =?utf-8?B?aCthT0RGZU1JdzllZWMxb1YwTnVCdkVuMG9zZGF5dEdxMjF6L3EySU9LelZi?=
 =?utf-8?B?SndRK0hqTmI3MjUxV1J3OXhXdTBCTVVvVDNhYmEzZzRXV1VYQWFBRi8yY0Vh?=
 =?utf-8?B?QmQ5bjgwQllReGxCZ1JzUE1mK1NHRjJTa3dpbFJ6eG9hc1Rwa29hSUJKSFhH?=
 =?utf-8?B?cVo5cHZiVUZCd0ViSXpITnI1UUM0ZldsODRPcXBKeGdGa2NNdWgyZXc3b1BB?=
 =?utf-8?B?WVcvdWQ5V3Q4NkVnZlpNUU5GUisrYnJtbi9wZnBJeURmS1BwZjhKbFFNOGRk?=
 =?utf-8?Q?mhoveHVUW7XZvc2yc2dE1mNhg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24179477-df32-4a30-ada3-08db0dd2f839
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 14:59:56.4692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uwQZ1FKw+MpaE2Sfe7LOZ45p+RMLDuvJeLg46NGsNaDULaHCByk1JoJ287ca+wpruNB2w0KtPJttdwmgklyvQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6672
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lukas,

Can we revisit the patches again to get a fix?
The issue still reproduce and visible in the kernel 6.2.0-rc8.

Thanks,
Anatoli

On 2023-01-23 14:30, Anatoli Antonovitch wrote:
> I do not see a deadlock, when applying the following old patch:
> https://lore.kernel.org/linux-pci/908047f7699d9de9ec2efd6b79aa752d73dab4b6.1595329748.git.lukas@wunner.de/ 
>
> after merge for the kernel 6.2.0-rc5, and applied the alternative patch:
> https://patchwork.kernel.org/project/linux-pci/patch/3dc88ea82bdc0e37d9000e413d5ebce481cbd629.1674205689.git.lukas@wunner.de/ 
>
>
> I have uploaded the merged patch and the system log for the upstream 
> kernel.
>
> Anatoli
>
>
> On 2023-01-21 02:21, Lukas Wunner wrote:
>> You're now getting a different deadlock. That one is addressed by this
>> old patch (it's already linked from the bugzilla):
>>
>> https://lore.kernel.org/linux-pci/908047f7699d9de9ec2efd6b79aa752d73dab4b6.1595329748.git.lukas@wunner.de/ 
>>
>>
>> If you apply that patch plus the new one, do you still see a deadlock?
