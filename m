Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7CB6BCF55
	for <lists+linux-pci@lfdr.de>; Thu, 16 Mar 2023 13:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjCPMXg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Mar 2023 08:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjCPMXd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Mar 2023 08:23:33 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2068.outbound.protection.outlook.com [40.107.241.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B444796C36;
        Thu, 16 Mar 2023 05:23:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ckfQ8LqHP/PO+HYsv/eHQaJ+pRDNP+vc87ziZV8Wami5nHIGSnbs1kqf+rzV0m7kIYx2auDjUJZLtT/eLTitZq9EZ0qubPVW+YKPgpagUwjWDfvkxw550lQYAkkGZ4BaxK2w4460Ze41zqw646n6r0Zk+twVahfwlQpjz0Lm9ilLSdAhd0zNNM93orQeZahCWodhscVUOMgIRf90MfXezihbEdo4+P7kQD43A8+AmWLj8de3ERlI4oUpJ9xAv1Gj7GHfWauUAv2s6OPHzQYMEY6ufM5pOCwQVizV7GCt9b0SJawtAwsGfwOrusaq+2uYDuLXRe7mFEwcqWKeZd8QBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7GQUrTyE+X1YfQLdWmDzVFv65YJ98tvCkDZha0Pfs0=;
 b=jHzKKxR+loJ47Mut6hiXcnUC9Pi8YyUrIuJ0NONeQtloI58QbY+BO+veOW609N2zwxfR/z9kYO8CDrC1KBKtD802jGFSaVHVRE2sJfLc7POHIiKv94zO374SzUWxTHLJ0ddAa+55ruFWQr/U1Ud6kc9a0Uo1E93KV1CWAyPdHsAtH/KA9iw3OplFue6kSmvc5SIKSMlS3VQIo1vbNTWqF2qNKuijsVZRuni1KaiI9es/fDu+0tXAuBK3iyYX/aTDM6admVIRbJ8KH5Xqds6r7DVmKkyf8vJkFdpLJD7s1bc3x1Vrh71gXe8tEeoK7nvtE72hSTjcUZEDDijm9U0yNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7GQUrTyE+X1YfQLdWmDzVFv65YJ98tvCkDZha0Pfs0=;
 b=l7S/wtAKenWp/yA2pmucXt2iay6b8o99fxjwy2lwvHjoD2VE2KiBWEJgeVusNTQ2RgtpttZZmBht05e6ZZHrQWfGtN8SJlqZpPEBaVQijyRWGRc00KkoR523OY+LLhdjfnWwlSRq0Vob3XwmWgdqezkc0EnHybVzXejBL602WukfpAA+gX7huyTmT/2RWRxDAKkiToj0+QXMzhrnBEyy4cxtqxwVK+jIKNWIII7xorzlyPiMoRQ5f4rvoYNWEgvHuzfA/5TI9AMKbU7yAXDI1tKkYH+BtOIIEtHzeesIYtfM4Ax6Pl0E/wnSI32XM7WwYUeiK6eB5+DZTbopn3S/4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by PA4PR04MB7631.eurprd04.prod.outlook.com (2603:10a6:102:e1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.31; Thu, 16 Mar
 2023 12:23:27 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com ([fe80::2ea:4a86:9ab7])
 by VI1PR04MB7104.eurprd04.prod.outlook.com ([fe80::2ea:4a86:9ab7%3]) with
 mapi id 15.20.6178.031; Thu, 16 Mar 2023 12:23:27 +0000
Message-ID: <90e97b96-2918-294a-0e71-33a42f28d8a8@suse.com>
Date:   Thu, 16 Mar 2023 13:23:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/1] Guard pci_create_sysfs_dev_files with atomic value
Content-Language: en-US
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Oliver Neukum <oneukum@suse.com>
Cc:     Korneliusz Osmenda <korneliuszo@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230316091540.494366-1-alexander.stein@ew.tq-group.com>
 <6131694.LvFx2qVVIh@steina-w> <612dfdd2-7de1-12a7-c47c-7569c3466224@suse.com>
 <4888964.44csPzL39Z@steina-w>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <4888964.44csPzL39Z@steina-w>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0089.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::15) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|PA4PR04MB7631:EE_
X-MS-Office365-Filtering-Correlation-Id: 49469ebf-d68f-4adf-47e1-08db26193ec0
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2ejd+bvf0WFv1J7YaRqtbZrfQjfcOQK2VhWUmuHcTbvjJrldynLqGS8RMMKfUKac46iuAqPtz7c7vzQGj6oxL41EKu1TGQwI3bBeC7zMDawXKSMA3hScOAIKJz8Hiik9avNpbsXc74S3sKpMv+Ny131l7e0hWP6g2ZqTiHYylLgOfRMo8ATtiVGeFlF3ByoUCdSmwIstXl0RlsUSGTg4b725K7vM0S88jI6e0pEwBYYukGwsq0lQphdXiE1A+WlQuXxSBss9nvqTqnAQHc01vYSzR+msDSoEkEpWz2+EpDm0puAomHJ7pnvmlN3qOAh3ZSnHQ4qFI22M6hWIvKPkd3W+wncw+YAu3livX8ierx3D6BJFYF9XyTdmnFRpEMs+nVXBPEce/C4p0ljcmYsao+pN4N1rhPD3q0iai7uz1fZzkO6uaSUIVE6MyTSvctxNLU9Pywq8Mz6arwsy0Rbx5piZLWDKTwo+MOsjGS6Pmii9dr9KBb8tMDhtHb3Uk3E/OQygx2EG1G3b7xU7HVNIdRji9wsZgU8fyEVqjQBzw4UKaiQ5CBdOQ4wHksEu/VhE8gcLu0pUBU0b7Aw+aZ69LZO4v6lKT8Y7bT6SPOqjSXKVl78MEyiCii/2zmC0gPKdS42841dLNEzKgH6WAoGNG3KPqD3ekdeMQZdFpOJgbqIoms4JoyJ4kxPJQL5KLOh2YFr62259v9rFpsth/v3SHc8EIzozKwguW26FuYL0dWY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(376002)(346002)(39860400002)(136003)(451199018)(53546011)(6506007)(6512007)(316002)(31696002)(110136005)(86362001)(6486002)(478600001)(38100700002)(2906002)(36756003)(41300700001)(4326008)(8676002)(66476007)(66946007)(2616005)(186003)(8936002)(31686004)(5660300002)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTdLS3MwZ0JuUExsbDJzNDduN05kVTNIR29ZNHBKdDhlZWE1ZVhGdzBBaE0z?=
 =?utf-8?B?NUt4b3BKSERVNWlGZm55b0gxME40UFFXVTRicWJ5M29idExEY1N6ZzczczVi?=
 =?utf-8?B?ZUcwZFY3TXk1Sm54Q0h1WDZ2Rk50TFQ3R2ZaSFBHbXh0NDVkZGNoTnE3Vml3?=
 =?utf-8?B?VHBKdXFvS2VVWldEakJDRWJhcWpLNGRYck42ai8zeGNqSHZ6VjZJTGdsenZ3?=
 =?utf-8?B?Q3B4Q3JWakMyZkt6S25WeGhCdFpiZUwwMHJPM2tPSmd0ajZQVEVuS3Ztd3M4?=
 =?utf-8?B?Wmw2L3FKM1ZTNUJ2bGVZMDhmdW9iSkprMDVleVVsQ2JiMGFtMm9leFpPUXJn?=
 =?utf-8?B?V1NrSUpmUGhidmNSbFhLaUx0SG0zMjdNNXFJSDQwUWg2WGVSRk51K21YZ2hh?=
 =?utf-8?B?UG9PR2x1eXNhQ3lwM0xmY2ZNVTB4NzYxaHh0UlpWQWU3OHBNckVVdXR0MGRD?=
 =?utf-8?B?U0tFWTcxV2J6Tis5Vk1rWWZ1NlNuKzlUNzJYTHc1ZnFIZ2lFVFhKanNYQWNT?=
 =?utf-8?B?d3dxVEU4WERJeDJ2eS9udWsxSGFKQkJwQVo5UDd4eVJRSWhsMVZPanNoL283?=
 =?utf-8?B?Wkw3ZUt4REdsVVZVMmhySkJ4VnRkelFZODYrR3NsV2VreWpwTnlJakswV3ha?=
 =?utf-8?B?bEtZV29WU1hveWNSdytEL1h2QjBqOW5DQVJiZ1FRaDBpYUdNQkxQbzFKTCt1?=
 =?utf-8?B?VGhaZzhTZkorUEdiNGVkSHhNU1VOcTcvbmxKejJvSVJoKzMyWlJONmwwYjhx?=
 =?utf-8?B?NS9od2NjT2lNcXlSV2JFSCt4L0w4LzZXZzVPRVFyVVFLRWhFMzhQa2tSemta?=
 =?utf-8?B?SXRjQ2c1bTA5K2hGWTIxSGRKUFhBUG5WV2l0elNmWUVVT1czRkxFS3JaTVIr?=
 =?utf-8?B?UFJlZ2pFRDRLZmFhMTBjbUZzQjlqREpPUk4waERZSWtBM0t4bFdKZWd6bzhL?=
 =?utf-8?B?VW5GcmZ0V3RQeDd0ZVloaGRNeWxlaEVlTlMwVnNVVko5RGFvMERwclpickd4?=
 =?utf-8?B?SFNrcm8zWi9QV2YrUDVJY1hTWnNKT0t0NXg2aGpmemc0b3M5YkhKMXRRVW1s?=
 =?utf-8?B?bHB0OEh4MkhQY3V1djloWFdlamljZUdJL1VNVlI0Qmd4SHZlenY1cWpYQ0ZY?=
 =?utf-8?B?N1pKNHZ2azZUQW16Y2piMFpEMUJKellya2xFaVRwSW54a291aEVRU2FsS3p2?=
 =?utf-8?B?WjJBWUxrYlhJczlGQy9FMDc1MXUxVWxkaWVpSFNyOXllWUZsTmtOM1MzVVdU?=
 =?utf-8?B?UklWQkd2cHZLc3AyNndHZzRNKzFFc2Fkdjk0Q3crYnkyUzN0L0FONUNaT0tv?=
 =?utf-8?B?cHlYM2drYXN0Q2taNDJHRmp5UFkrZTVDbG54akpwV2ZZMVhsbFY1cWdzeVRW?=
 =?utf-8?B?VzhQVTlzWi9Sem5IVndDelJKSElldjR1K2ZES2RYanIzdFlUUEx6eGE3Q1Nz?=
 =?utf-8?B?SUxaRUtzRDRBakJuQjI3N2JQZFY4eWdESHdqdU54YXFQM2ZVcUZkeFE5STk5?=
 =?utf-8?B?UnNqMjFVWFVNME96MDJIUmlnc3NRNTE4MVZIUXdXNUhoekNNb1B5R2YrdE1Z?=
 =?utf-8?B?bzVaZXNpMVpQYU83RkxJSlBJTnZURGxNM2dYNHY1SytJYmdVSDh6SUVmc2tQ?=
 =?utf-8?B?VUJJM2pLSVlPN3NuSC9SdzFyVEg1MCt0K2ljc2NlUHFVaEhXVjNrTUZRaDdm?=
 =?utf-8?B?djF3RlR5dERRbDZaOHFFYVZFYmlWMmY1aUE0Qm82eTNONW9vM2R1eEFlMlJn?=
 =?utf-8?B?T2FSTVZmcUNwbnhmQjRDNGlGTlpHKzFmQUxCbmQvZmRPdlNKelBTcFFGQTlV?=
 =?utf-8?B?WThic3IreitHSFNpOHNOdktPWEVEVm1XN2NsWEdIRVA2djRIL3dXc01md2tL?=
 =?utf-8?B?elpzcmJXR1RmVVN1UVFUV1VpYVE0bTVYZFNmVE5OOU1rT2VEZFlHNlM0MEI5?=
 =?utf-8?B?dFlzVUIrY3FSV05ERHFkd1JSbVRtS3hUNGlEY2oxbWFkdy8zdzVmSU12czJo?=
 =?utf-8?B?WUIyd2dWcEZUeHlOV25oNXdUKzd1WDB2aFhnMWhML1NFT2pHUXd5ZldSNDNz?=
 =?utf-8?B?bXJMSmpZMmlBdHZ0b3hpVlhWVVdEU1EwYTkyOEFBY0czWUpPREdadHViS3Uv?=
 =?utf-8?B?czlieTNyUnhySy9rR1hXNU9BVC9KSVJnMXQwc2oxczVURUR0MHhHWjZTUTd3?=
 =?utf-8?Q?o7wmfJ4UxqQGrRzMPfbpiXBV2uoKcJNkqSwKvum/ocZg?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49469ebf-d68f-4adf-47e1-08db26193ec0
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 12:23:27.3133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y9xemrka0W9ehKcDtqQDIksEAqBwv+c4P0ZzQu1RO+w83JEyMnH2cudrwgNRpI8HKTRwrtcVj4pXLuQEaGGc5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7631
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 16.03.23 12:58, Alexander Stein wrote:
> Hi Oliver,
> 
> Am Donnerstag, 16. März 2023, 12:17:32 CET schrieb Oliver Neukum:

>> It seems to me that you must not add a bridge before
>> pci_create_sysfs_dev_files() has finished. Now you could add a wait_queue
>> and a flag and wait for it to finish. But that is not very elegant.
> 
> Do we need the pci_sysfs_init initcall at all? Or to put it in other words,
> what does this initcall solve?

Fundamentally something has to discover the root bridge.
Secondly your system has to boot. The device right behind
the root bridge will already be up and running when the kernel
takes control. IMHO treating such devices differently from
other devices makes sense.

> See my different approach eliminating this race at all.

Please elaborate
  
>>  From which initcall is your driver probed?
> 
> The callstack looks like this:
>> imx6_pcie_probe from platform_probe+0x5c/0xb8
>> platform_probe from call_driver_probe+0x24/0x118
>> call_driver_probe from really_probe+0xc4/0x31c
>> really_probe from __driver_probe_device+0x8c/0x120
>> __driver_probe_device from driver_probe_device+0x30/0xc0
>> driver_probe_device from __driver_attach_async_helper+0x50/0xd8
>> __driver_attach_async_helper from async_run_entry_fn+0x30/0x144
>> async_run_entry_fn from process_one_work+0x1c4/0x3d0
>> process_one_work from worker_thread+0x50/0x41c
>> worker_thread from kthread+0xec/0x104
>> kthread from ret_from_fork+0x14/0x2c
> 
> So technically the device is not probed from within a initcall but a kthread.
> It is set to be probed asynchronous in imx6_pcie_driver.

That may be the problem, respectively that system is incomplete
You are registering a PCI bridge. The PCI subsystem should be
done setting up when you run. That is just a simple dependency.

	Regards
		Oliver
