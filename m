Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3936C28AD
	for <lists+linux-pci@lfdr.de>; Tue, 21 Mar 2023 04:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjCUDm1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Mar 2023 23:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjCUDmY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Mar 2023 23:42:24 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE8C35EEF;
        Mon, 20 Mar 2023 20:42:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJ3KYPXWfxsJWrpjECrFvgVdT36ZV0tazn2h89UIDrlqmDIjeqN1MHSYcuUKVLHWfj6+olKUD1zPymPuVdBUoeRidWCOonMwMHO2urApN03bKtow5dIEOsCBJew4M3AsbUq0f6fKhX9e65lY3g0aqXvDeSshZ+ClJPrlCwKZHvkRrks9YnsCdHBL7Nc0u14I2o+j3TAkoA0ivVujge/q9LpiE3omm8svOGsMt0a8iJjK0NBUKxDR9EEFHxuPthxpSgaqOCteoeUpxzOvPiQkoLkXJFoClGjrm9hffpox64Mx2huu47LpIfo+jvergQX2rXY7AlcvYGcnjskY613fXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zz4FiQTj3uNdayPu+fcTYxEwyHp79LKhBySWHWZpjbw=;
 b=I9ApEevToMpkapnPEIdXC2FKJs7yl0gA8FDkoZ9x7r8uxkkc/KH7MBbF/qfiZZRr0a7NQfUQFXf0UOyawyrMBnFmdrE4w59p42r7eoKWPKPcEpeg9niOOgQLCBPNtG59g4eETFomCl+Q0YAGs4RMkIJFbkfQRmKOfYNSmikceOi7PwuKyUYOscXKtAnSJiLTMQvjuLyXsdNGV2EN+Q6o4Itzs/IQ1K3+vQIhAdypxbWzrVW8qlFyVwXoOGceQgizmU0p8IOYZHQ7rnqPYuknMYLowx/J8H2u6/mn0Wd4OxEM/9ATlYGHbFkcvGvR24CaUaQnk7eQrbHPBFEpuAcvHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zz4FiQTj3uNdayPu+fcTYxEwyHp79LKhBySWHWZpjbw=;
 b=UtYjdl/2T+ti+AslTAj161izRNxcgKtTaDkxufY0qUA6VjRVTEv7m0lgTS5ERcIYEpzcNbulLK7/LC67E31CVbPWusGctJIPUWdEoJXW2cYAy61LHIFjtZDKFzB9dUquoSWrO8EIA3krIWT0v6kb8FnxYVbsu14QPA6O8QAAv58=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2843.namprd12.prod.outlook.com (2603:10b6:5:48::24) by
 SN7PR12MB6766.namprd12.prod.outlook.com (2603:10b6:806:26a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 03:42:12 +0000
Received: from DM6PR12MB2843.namprd12.prod.outlook.com
 ([fe80::1185:1d60:8b6e:89d3]) by DM6PR12MB2843.namprd12.prod.outlook.com
 ([fe80::1185:1d60:8b6e:89d3%7]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 03:42:12 +0000
Message-ID: <b3d2d326-8736-09e4-0886-68c6d69aa404@amd.com>
Date:   Tue, 21 Mar 2023 14:42:01 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 05/17] PCI/DOE: Silence WARN splat with
 CONFIG_DEBUG_OBJECTS=y
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
Cc:     Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>, linuxarm@huawei.com
References: <cover.1678543498.git.lukas@wunner.de>
 <67a9117f463ecdb38a2dbca6a20391ce2f1e7a06.1678543498.git.lukas@wunner.de>
From:   Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <67a9117f463ecdb38a2dbca6a20391ce2f1e7a06.1678543498.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYBPR01CA0146.ausprd01.prod.outlook.com
 (2603:10c6:10:d::14) To DM6PR12MB2843.namprd12.prod.outlook.com
 (2603:10b6:5:48::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2843:EE_|SN7PR12MB6766:EE_
X-MS-Office365-Filtering-Correlation-Id: 654650ab-b095-4713-1591-08db29be414a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9jyQM7cU4AmRJibxoiTfquvA5FWOdX8H8QpsmCiVCjA0peVawzswcuhdY8wKHOEQoLpQ6lFRhVSuvxPIHjNY3OmbMD1XZOE1joYgqnRhjSPm52xUOxvl8YWPQ33n8iz73KmVhut85AZBTevni2ZT14Rk8wqCXUQrlk2CV+o0YBmGkXTYyaQYJ40tFXVUROjfd33iN4DyYRJrFPsrQnaoKL+FhNrqO3PMCaa+FHAyxovmh9vJz3yCoz7tXgfyj4PaL4SDKqnWmflND9CIIEbuGEwSYWaflqLesQEQa1qC+X6baA1vCGZnA2sQjgwztf2YAzuIDLZC/g8ETczbzwaS7t7XXHwERuJWxq3ossXScPWEUxbc+kOGRjOG0B2ayXBk2imzRoyX/w08BusGtOiu0XrjrLgkYTw5SFWWqG9oeyy9VcXa/wxrqbd0IFhaAVB78msepQ9TbjXJGruayrjErHfQe34n15xkQq6GDTaC1ozp7wLveSwcSVAXMug0v4igbmdFuj1TMtiYTdB+FZ7D1IIpGOU+TechS1uTOg/sePsxWLFUFF7jwQZNMexZLkL35k1l7U09AK4fa8F9Jt3RhSrFZ59wMdmyZvX43fM3aTOFE9VhhFBR2yyM97+g4J7gfSME3dclgUrI5zjf0WtTObF2WSSoi2c48R2ZSqsnkQoNWExLrjk+Tg4D4rCx/M1a3TCQmuYePfET8Jy1/AJOWC0fF23wzUZgIN/KtmWFEzM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2843.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(451199018)(41300700001)(8936002)(4326008)(66946007)(8676002)(66476007)(66556008)(38100700002)(2906002)(31696002)(36756003)(5660300002)(7416002)(31686004)(6486002)(966005)(186003)(6506007)(6512007)(26005)(53546011)(6666004)(316002)(478600001)(54906003)(2616005)(83380400001)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ulh3RkljSVRsbU4vNUEwKzh1ekxOdkhiQmVZQlYrdDNWNG1nWjkyeWJMNHRu?=
 =?utf-8?B?UTBKbVBoZld5YnEvWFh2REFmT1hJNUk4Z3ZlbmMxM1R4R0dGRncwSTJEeG1C?=
 =?utf-8?B?aDV2TU5rTXVlYjF4OWdLT2NXeVRwMFlJNjZzVUZvZzR1ZUFVc0VyZE9SaUVw?=
 =?utf-8?B?dnBoaGNPNm1PYU9qc1lYamlOY2orU3pENmg1cWhucG1YRXptbFEvd3NkQnNV?=
 =?utf-8?B?REkzYURlT0xQQ2NGYUxKNUszNjJYbWRjZU0rMFBCTEd1K0NBM0IwVGgwMEJP?=
 =?utf-8?B?cElhV09jcHpUSEdaSGd4V0VwNGhkNGFGRnBFeVA2K3VYeGUzMmZ4WWNxN3hj?=
 =?utf-8?B?b1lhVis2clBDN0s4Z2tTYkVKcnpUSy9mVHFJV3N5M0x0WU02S1B3RkZ1dFJY?=
 =?utf-8?B?K1crN3dlVWpkOEhQUVQrOE1CdzlsYVV3T1I5V3hBc1hXdnVCZzBkUlRvcWFv?=
 =?utf-8?B?dE5YMEZYcG9XSURSK1BwZWNjbXpucUFVTW8va2l6OXdZK0U0aXJrYW80Wk56?=
 =?utf-8?B?Z2hYRmFlUnI5YmQ0VktoWGZsc1o0TFFZY1lRUnZ3clBlelpLVy85c2V6dGFB?=
 =?utf-8?B?VVk4cXA1N0Fsczh4S1NwMDNBQ2ZQUjg3NnpwQ1FQV0lFaWtmUHNmQlZvMyt1?=
 =?utf-8?B?Mm5VaGkrZWltczRjZy9Hb0RRRVpCWEtGZC9DejdkaThZRDVVRVRFa3UzbHN1?=
 =?utf-8?B?Q1NHczVLM3l5VlNTOURTMUpLR0Jiby9PT3JZSzJGUzJ6bEFXano1THh3TTF2?=
 =?utf-8?B?eFI3ZjFHKzJyck50NXd4cmxjeS9OY1IrODJpazJxT29GVHMvL2xtWkNteTJy?=
 =?utf-8?B?WEZPV0dxbFY5bEVRL0VjS1pDVGVQVU9vbzB5WjVlWEJyQllXcGxtUjFBdy8w?=
 =?utf-8?B?d2FYTTJ1TTdPME9yOGc0dWY1RTR3SFcyN2txd1pEN1p6NzdxbFY2Ky9VVkpK?=
 =?utf-8?B?R0RuK1k2L1lXdnNxTVpwenJxY1I3QzJ5clg2M2l6NVl0MnkxZHVuNUlhNi9B?=
 =?utf-8?B?dFlzY0ZhOFdOby9ZQlpzYW9LUXVtMThwakxoWHBYbW94STFaaWh3UjNaaTVq?=
 =?utf-8?B?QVhXdlVWODlzc2ZqZnhwUVEyWE13YlNBNnZUNEk5cEMwbDh6K1pDR0NoUmRS?=
 =?utf-8?B?dmdCSFlrVHdGRndsUWhnOXI3THk3U2Q4YkdnWnBVTTRzQWZJeXJpeWZzT0dR?=
 =?utf-8?B?YUhjeGdkbllxTjdvRGlqMlloV2ErTk9zVWgxd2thcEFWVEpnTXFUT2JBMXUr?=
 =?utf-8?B?d0Z2YUYzVEpDRWVyaEkrRjhVZkJFQ2RIYkVGZDY3aEhEVlBXd2hzWmVxd3VW?=
 =?utf-8?B?NlhtRkpzWkZrM1V3M3B0ZGpYVVJkQVczN1JGbnJlVS9hYmdSQUsyaVJKdWsx?=
 =?utf-8?B?L0tZaFNVWmprdnlEZFR5eHpMUjdaK1Y1OHVSSVpmcWtLRFEzZW1CQUdNazRy?=
 =?utf-8?B?ZXpzeGFhRHFxUURjaGNDaDRpckpjV2M4Z0JYQnZZWUN3TFlvZHQ2cTBDdmIx?=
 =?utf-8?B?OGE5dmVCcFJramFML3dCR3VnSTZlMmVJVW9CT3JBWE1kcHhXMjRhV3RBS2dE?=
 =?utf-8?B?RnhrK3NUSktBeFEycjJiVnhjQnRNckxVWnhkTGVrMUxJLzJ5VW1ZdEgyWExY?=
 =?utf-8?B?cVNETno3V0lneisxVmNIcVVIeXJsQjdkNWJxcXBMVlIvc3g3c29qSnFnZmhO?=
 =?utf-8?B?OEZUTVJMUkpiQkZsOW1pbGt1RkhmQUhzQ1QwSStRelhDNXhtR01Bd1VOaDNz?=
 =?utf-8?B?ZnlLc3ozM2ExVkNDRWFyejFSdG1yblRhdGcvRXREOG5RNjBhZk91UEtGaXc0?=
 =?utf-8?B?dG9INEpmRDBWWDlidmFhblRMQXg1TEcyVjVvSXBoRGY1cUdPeVg4Z3Q0UUZF?=
 =?utf-8?B?cWpjNGRXSWNMZjMvQ01zQmlrTndlMmNDdXJGVm9kaTZQZDdDQlc5UUhZRXFk?=
 =?utf-8?B?emthemw5aHBldGdBUjNicGJHYmcwRTBnamNiNDNZbzF5RndCM1daV3Zna2V6?=
 =?utf-8?B?QmNEaXJPL01MdW9mMHU3UFp3RW1Db096aytwb2VVNXljbW5tMlFLczIyYURo?=
 =?utf-8?B?dWgxYzZlN3IycG0yT2swVldNdGJNUUtMekR1cE02SXI4ZVNVOFpuVG1Jckhh?=
 =?utf-8?Q?rTEfDT0+MNxmuoL08BYNUCvZf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 654650ab-b095-4713-1591-08db29be414a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2843.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 03:42:12.3174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zF9n1RUfZ4GEGUezFiX5FE5uv/MO3wD2/ZNlvqJRItERmp6dSCZUBWXd/mADcE9S787Eqh1zEHMi2M+DDkrHKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6766
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/3/23 01:40, Lukas Wunner wrote:
> Gregory Price reports a WARN splat with CONFIG_DEBUG_OBJECTS=y upon CXL
> probing because pci_doe_submit_task() invokes INIT_WORK() instead of
> INIT_WORK_ONSTACK() for a work_struct that was allocated on the stack.
> 
> All callers of pci_doe_submit_task() allocate the work_struct on the
> stack, so replace INIT_WORK() with INIT_WORK_ONSTACK() as a backportable
> short-term fix.
> 
> The long-term fix implemented by a subsequent commit is to move to a
> synchronous API which allocates the work_struct internally in the DOE
> library.
> 
> Stacktrace for posterity:
> 
> WARNING: CPU: 0 PID: 23 at lib/debugobjects.c:545 __debug_object_init.cold+0x18/0x183
> CPU: 0 PID: 23 Comm: kworker/u2:1 Not tainted 6.1.0-0.rc1.20221019gitaae703b02f92.17.fc38.x86_64 #1
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> Call Trace:
>   pci_doe_submit_task+0x5d/0xd0
>   pci_doe_discovery+0xb4/0x100
>   pcim_doe_create_mb+0x219/0x290
>   cxl_pci_probe+0x192/0x430
>   local_pci_probe+0x41/0x80
>   pci_device_probe+0xb3/0x220
>   really_probe+0xde/0x380
>   __driver_probe_device+0x78/0x170
>   driver_probe_device+0x1f/0x90
>   __driver_attach_async_helper+0x5c/0xe0
>   async_run_entry_fn+0x30/0x130
>   process_one_work+0x294/0x5b0
> 
> Fixes: 9d24322e887b ("PCI/DOE: Add DOE mailbox support functions")
> Link: https://lore.kernel.org/linux-cxl/Y1bOniJliOFszvIK@memverge.com/
> Reported-by: Gregory Price <gregory.price@memverge.com>
> Tested-by: Ira Weiny <ira.weiny@intel.com>
> Tested-by: Gregory Price <gregory.price@memverge.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Gregory Price <gregory.price@memverge.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huwei.com>
                                                   ^^^^^

huwei? :)


-- 
Alexey

