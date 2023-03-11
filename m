Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF3B6B5798
	for <lists+linux-pci@lfdr.de>; Sat, 11 Mar 2023 02:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbjCKBp6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Mar 2023 20:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCKBp5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Mar 2023 20:45:57 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F62111B03
        for <linux-pci@vger.kernel.org>; Fri, 10 Mar 2023 17:45:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jyPc2Lp2/Oo0P/aUAbovZCTcwLp1XYFXXzw0TEBe/X0PdvLXAWPaflhWs1IoPgZ49GJJiFmEfh8MwZPhP2nzhYY7uEt0qCxzEU7+GtUOOijG2Y8qk+n2DgOgmKgK5A0eu6OfI1dGx1o6vIFnpa63wSUIfsQR3X9NRMG50HbJ3WjQ+n9eIE62aTc9cA1ERy8C5dRdfPgXdtOiFw2WM5Lm+Ar5SpoOVzwE5HB/waZtpZglKCaj4JV7g0CzDLWsnL8FAVyFB1v5Fbf3YS0a6tlnrqSGXlcX5iwMWOUwz0v938YnKQ/dSxSDv8N8lztcpiuYU9G14b96ufzlQUYpXSZy8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QcsCGg7pyz9y+D4RvB3zLYD3Ui8MSXEMjbG+kySde+4=;
 b=hDU/cqLvPvLMJXxQznbcq9hap3wNkzYbOoqB18NQxMDE7h+TKVgpfMuXxPkBqMC0GqfYL6HPV5fzB9wwX9NSjEI7T9lPTzt1meLVHs5l1VE2pGHzwgJto8ts1E+OhxKj/I5RfRbK2V8+9Z5r13kt9gJ3Z9a7NKGsa8wGldcvc4dqOKJH22DcmUkxeLSYYCfpcI3V9XWfZtGfduNWMWCfoPWm/pPszafGuTCXjs/mY+oFdLxEN2vNo2Og/+AHAZDiv+XLRCfRce9EJqHsWyoiyhPOF5atd0XPwbf4rqu0kAIad5vjm9DIAyCNf+IAnuKuGvoU46PExuo5XCG5mlfImQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QcsCGg7pyz9y+D4RvB3zLYD3Ui8MSXEMjbG+kySde+4=;
 b=cwggKaJW+y9OfXWvCpyx3nOwmD5OLQA/Mgh0OEjtXuz9MYiLfsBQ0wZayJoJHEDglOx2wkasknZtzlD+mQfusxFaWRUteNtNnA+UjIlQ8WJ86XI6Cn5hEVu2pq+4bQwKEhvrfEZw+TFWyfmw7DTlFsFd4dn/yzq+i4B3mRT7WAczSzlIoWhY7cz29V7n3ZXQgb5eyueulaQ/J0Rhv3Xk7NcOsmaY34lxwZDm8XTgfy3FTiktgOg2L0d28yY3t2V1JivEaZLpF6FPHB5bRTgsjO6B4ZSHcQTBWS1QawWjFcXIqpC99A7b6+bKenkiQ5nxPyhuwiEiEO8IZrMgUKeP1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3189.namprd12.prod.outlook.com (2603:10b6:a03:134::11)
 by DM6PR12MB4579.namprd12.prod.outlook.com (2603:10b6:5:2ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.22; Sat, 11 Mar
 2023 01:45:51 +0000
Received: from BYAPR12MB3189.namprd12.prod.outlook.com
 ([fe80::c4b1:77a1:8e6b:841d]) by BYAPR12MB3189.namprd12.prod.outlook.com
 ([fe80::c4b1:77a1:8e6b:841d%5]) with mapi id 15.20.6178.022; Sat, 11 Mar 2023
 01:45:51 +0000
Message-ID: <4922cec7-ecc1-4971-75af-cdbaeaa6434f@nvidia.com>
Date:   Fri, 10 Mar 2023 17:45:48 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: nvme-pci: Disabling device after reset failure: -5 occurs while
 AER recovery
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
        kbusch@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>
References: <20230310235306.GA1290793@bhelgaas>
From:   Tushar Dave <tdave@nvidia.com>
In-Reply-To: <20230310235306.GA1290793@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0183.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::8) To BYAPR12MB3189.namprd12.prod.outlook.com
 (2603:10b6:a03:134::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3189:EE_|DM6PR12MB4579:EE_
X-MS-Office365-Filtering-Correlation-Id: f92c036d-8df9-4702-897e-08db21d2581a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1L2GDfg6aXTPyMsGq2aPv3k1GX3S+44L9qrUHG4JdHktQydt0LFQWWlrmHKWM2wSlwaIg+bmt0+X3IWsW4NP/DnLxjMjIsM9NP6QcBHyxl11RSetCLBOMi6/YxLOxxxkAoytKlbICs7N0M3747HYDHLkWaA+S1rxCdpl/q2wR8+cQabhacBoNNmcfYaPYuR/HGQAszq6bPHKxItvBJrSQs1louw74qWroXvoEVjhT/Df+wUFaVp8UP2FRm01YairKYVTPH12bDidfxC5Yjxj3yxyE45RmHkgYC+Rhso+NGNBpebUnta5CwuosBKsFvxMZsmFLA+9TK4VFWlgh9GiJ8dVikSPUlTvWNXpnc5y+2/519cF4LUD2ocy7VZazEqs4ik9lQcVCXSieJ911BpefZMzzA3cnaahYyFbc0x8gW1SCkRHT5ZWEe+dortQ9FwlJx+RWn8/USKAujj/7A22pZubK5IFa7xs0QYc5x4/L9xWQcsGs9jTZmsRegjzqnLIKK4cDMN9zRvsT3Ql3DOc/5coNkyxsvB3v1Q5ms7eOMraD/YhmWC556c0jCFNHdKGCphLPmY8Kz8DeKMF9PyBpKdO+o2SN10SXHEgeocr4qmE3PtewtH9+473QZFiZfnu1cLDKBjU8yTqIyac3xb0p5LQX+kHMS1KvKq48gZr9PNw8dlI8A9Ds0Ol08vVtXDGqOF1unSYinZrFaaX5ZGw0X+R3HTqt0idkZhDA6HSbMZJo/Mf1hSVmqx9R+2RFTDZVbJkPQfAzqtdyaSM8q56uQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(451199018)(5660300002)(30864003)(36756003)(83380400001)(478600001)(6666004)(6512007)(6506007)(26005)(966005)(6486002)(2616005)(53546011)(186003)(4326008)(6916009)(8676002)(66476007)(66556008)(66946007)(8936002)(41300700001)(86362001)(31696002)(54906003)(316002)(38100700002)(31686004)(2906002)(66899018)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHJWSUt2NmRjTXdWYXIybGhZd2w3a2Z3Q2xvcDNyd25XNmo0NWZCWE1FZ05E?=
 =?utf-8?B?aUNBbnZ1V3Z6ajBjbVZqRU9yOXhjdnlqbU9nN0hjZ29yN1RUUFRpZzFTNmpj?=
 =?utf-8?B?RTdzMGgzNURKRk5mMm1vUmlmTUFUNElRUFFZZG5zN1ladzkzUFNteWNYelg0?=
 =?utf-8?B?UElDekFVcHNQMHE2aS9KN0pwa0VtaFJVeUY4c2ZQOFRPa0xUeWJMUDlzS3Ix?=
 =?utf-8?B?K1E0M2QyeEpuTmtIaHJnSDNwUkZsNjA0ZGkrdVJ6UkxyVFp1L29VcDZjSktN?=
 =?utf-8?B?VS9kV3l1VjVCblgrTm5KblVIQlptZUFvc0owREtzUlNVdlExM1J6WEZZL3Fo?=
 =?utf-8?B?bTdLWUQ4TDNNam8xc29abGxoYVJWTklTK0x2bExzT3Y3NW1sTkNod3lBU28w?=
 =?utf-8?B?ZGUra2NNWGZBYi9NYmthMWc3VFRSb09NNWkrNmRlamlRaDVoRnlwY1NHNUw0?=
 =?utf-8?B?VlAzUnoyKzFJbnJSOHdCTHNGVGR5YmRaaEdqYWl3TGJld1RkbWdCQ3R3bnMy?=
 =?utf-8?B?OVNSTkxaRTdnOGs1RTRyamNXd0dOOEwvRDFZanJFVXdFdGMrT2s4U3FhWGVs?=
 =?utf-8?B?YTY5Q1ZuU0lKQlcvWjFVSXNtM1EvcGphMzFjM3NhSmtlL3kxYm5uK0VrSWYr?=
 =?utf-8?B?RXN5Z3lmK0FVSjZ5U3ZDZW9KbHhWamhNNE41YUw3MW0wVS9ET3VveVVoWGkx?=
 =?utf-8?B?R2tlYTY4ZExtUXIxck92Znd2aXoza1k4aHpINlpjT3l3aXdvRENRcE1kN3hF?=
 =?utf-8?B?WDJOM1R5M1BRa3M3RS9jcjByQXZIRitvUFZBUTV6U1ZoSnUxSkxqeFZxbElC?=
 =?utf-8?B?OXVLRGpXRGJoTlZNZUdXYnpFRy8vZ3lRZjQyM1NzRzN2bFkrMFFVMkE5azhC?=
 =?utf-8?B?OUNIL29SVCtxZkoxblh3OEJaNHNwaHdYdTRsejhCVGJUYjBYckl0TCtGcEE0?=
 =?utf-8?B?N0hHbW1YSElEekFSMit3Rmd4NjZacUkraFEwQy9pZUYwTGpreDA3SGhZOXE0?=
 =?utf-8?B?WnVCaStMdUhUeEQvOXF2a0RBUURxbjFld2daR0dYM1AweWxqVzA4WGVPT3F1?=
 =?utf-8?B?RGZKWVZ2Nk1raGppYzliMTBlVmMxYm8xUzRtbFdXOFhiSTEwUmxLRG9RbXRQ?=
 =?utf-8?B?dlB6S0Y4UU04U21WWTBEYkduL1JoQVIza0NTOUp4dEZ5elVWUlFrUkVtRFV1?=
 =?utf-8?B?dHRsZmx6Z0Jydkc0YzhTVkgvSXJNb3UvRGtKNlNVczJDUS9YSTJvV1B4alVB?=
 =?utf-8?B?eWF0QnNPb1RVUzN1czFpYmJGYTUrUXdSQ00xQUpybVhObVE4cjZkRitWY1pq?=
 =?utf-8?B?TVFHREJqRWxOdG5NeXBaeG1JWCtRUDdZSWhhTG0wYUx1NDkyRllvSUxjaTBl?=
 =?utf-8?B?WU9GbjQ1cy9CNjMwWXl5WEJZeTZidUQ4WkExYW9YaXR4UXpxbDNJYlFKTGpK?=
 =?utf-8?B?NGx6UHJQVHUyMWdMWlI1ZlAwMklXVW1BdVhUR1pHUC9oK3NQVVpUaHlQNVcv?=
 =?utf-8?B?U1AxUXNpT01YRi9FaXowNG9mQkdWYlRBR1lDeklrQkFlcHhxZTUwRC9HdXdX?=
 =?utf-8?B?VmQvb1R6SjJ1M1JLcmwyQ1JIWFdrZFVoNy8yeGg5UnAwZmhtc2tZWmYyWUJZ?=
 =?utf-8?B?R2o1VTlvMXRRSXppbHFVYnFHSTVTZkQ1OVdnbitTM2xTZ1ltaDR3TU1sbTA1?=
 =?utf-8?B?VHkyU2JBcGozTktrRHpTZDdCVG5iQ3dGcS9qd01LaXZJNHlHV3RSZlpXVTk3?=
 =?utf-8?B?ZWk1SDNES0NCd3hMOVB2VWlhU3JteDdvYTNDY3dkNTNwS1VCNENqRGRPTk82?=
 =?utf-8?B?R0t5RW45WExnTWtJVXl6Qjh2YUk2b0lKTHdTVVVWK0o0MWNhUkpDeXF5bXBT?=
 =?utf-8?B?eXk0cFJBZ1QzMi9tUVdzcWtoVHc5eTdRWTVOREpjZEI2MndheG00MXNmVWl0?=
 =?utf-8?B?UXpENTV3Uk9ZS0lNOHpNV3F3cHl4bEJvU0xhTm54TUMrdkpGU3hvcCtpVXk1?=
 =?utf-8?B?TktZclpzM1dmT1N6T0wyV2pMQ1gvZ2xLSWlBUlZBZ3JCSGxHWVNkRjM5UDBS?=
 =?utf-8?B?NFF6S2Z6WmJOaGJGdTlpdFh3cjdSL2RzVzBnVFlreEhNUURzRFVoS2VUbHlt?=
 =?utf-8?Q?tK9biLspwtC9y+k6/qbtBruBQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f92c036d-8df9-4702-897e-08db21d2581a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2023 01:45:50.9602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tJ2tVhwfs1D7vEGvRlDhBqjZZBqNssbcoWdm7skW7eAGwmcyBgcd7Dcfjrv6hM8gMHA3bVNroQ4nO8twSBf3DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4579
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/10/2023 3:53 PM, Bjorn Helgaas wrote:
> [+cc Lukas, beginning of thread:
> https://lore.kernel.org/all/de1b20e5-ded1-0aae-2221-f5d470d91015@nvidia.com/]
> 
> On Fri, Mar 10, 2023 at 02:39:19PM -0800, Tushar Dave wrote:
>> On 3/9/23 09:53, Bjorn Helgaas wrote:
>>> On Wed, Mar 08, 2023 at 07:34:58PM -0800, Tushar Dave wrote:
>>>> On 3/7/23 03:59, Sagi Grimberg wrote:
>>>>> On 3/2/23 02:09, Tushar Dave wrote:
>>>>>> We are observing NVMe device disabled due to reset failure after
>>>>>> injecting Malformed TLP. DPC/AER recovery succeed but NVMe fails.
>>>>>> I tried this on 2 different system and it is 100% reproducible with 6.2
>>>>>> kernel.
>>>>>>
>>>>>> On my system, Samsung NVMe SSD Controller PM173X is directly behind the
>>>>>> Broadcom PCIe Switch Downstream Port.
>>>>>> MalformedTLP is injected by changing MaxPayload Size(MPS) of PCIe switch
>>>>>> to 128B (keeping NVMe device MPS 512B).
>>>>>>
>>>>>> e.g.
>>>>>> # change MPS of PCIe switch (a9:10.0)
>>>>>> $ setpci -v -s a9:10.0 cap_exp+0x8.w
>>>>>> 0000:a9:10.0 (cap 10 @68) @70 = 0857
>>>>>> $ setpci -v -s a9:10.0 cap_exp+0x8.w=0x0817
>>>>>> 0000:a9:10.0 (cap 10 @68) @70 0817
>>>>>> $ lspci -s a9:10.0 -vvv | grep -w DevCtl -A 2
>>>>>>            DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq-
>>>>>>                RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
>>>>>>                MaxPayload 128 bytes, MaxReadReq 128 bytes
>>>>>>
>>>>>> # run some traffic on nvme (ab:00.0)
>>>>>> $ dd if=/dev/nvme0n1 of=/tmp/test bs=4K
>>>>>> dd: error reading '/dev/nvme0n1': Input/output error
>>>>>> 2+0 records in
>>>>>> 2+0 records out
>>>>>> 8192 bytes (8.2 kB, 8.0 KiB) copied, 0.0115304 s, 710 kB/s
>>>>>>
>>>>>> #kernel log:
>>>>>> [  163.034889] pcieport 0000:a5:01.0: EDR: EDR event received
>>>>>> [  163.041671] pcieport 0000:a5:01.0: EDR: Reported EDR dev: 0000:a9:10.0
>>>>>> [  163.049071] pcieport 0000:a9:10.0: DPC: containment event,
>>>>>> status:0x2009 source:0x0000
>>>>>> [  163.058014] pcieport 0000:a9:10.0: DPC: unmasked uncorrectable error
>>>>>> detected
>>>>>> [  163.066081] pcieport 0000:a9:10.0: PCIe Bus Error:
>>>>>> severity=Uncorrected (Fatal), type=Transaction Layer, (Receiver ID)
>>>>>> [  163.078151] pcieport 0000:a9:10.0:   device [1000:c030] error
>>>>>> status/mask=00040000/00180000
>>>>>> [  163.087613] pcieport 0000:a9:10.0:    [18] MalfTLP
>>>>>> (First)
>>>>>> [  163.095281] pcieport 0000:a9:10.0: AER:   TLP Header: 60000080
>>>>>> ab0000ff 00000001 d1fd0000
>>>>>> [  163.104517] pcieport 0000:a9:10.0: AER: broadcast error_detected message
>>>>>> [  163.112095] nvme nvme0: frozen state error detected, reset controller
>>>>>> [  163.150716] nvme0c0n1: I/O Cmd(0x2) @ LBA 16, 32 blocks, I/O Error
>>>>>> (sct 0x3 / sc 0x71)
>>>>>> [  163.159802] I/O error, dev nvme0c0n1, sector 16 op 0x0:(READ) flags
>>>>>> 0x4080700 phys_seg 4 prio class 2
>>>>>> [  163.383661] pcieport 0000:a9:10.0: AER: broadcast slot_reset message
>>>>>> [  163.390895] nvme nvme0: restart after slot reset
>>>>>> [  163.396230] nvme 0000:ab:00.0: restoring config space at offset 0x3c
>>>>>> (was 0x100, writing 0x1ff)
>>>>>> [  163.406079] nvme 0000:ab:00.0: restoring config space at offset 0x30
>>>>>> (was 0x0, writing 0xe0600000)
>>>>>> [  163.416212] nvme 0000:ab:00.0: restoring config space at offset 0x10
>>>>>> (was 0x4, writing 0xe0710004)
>>>>>> [  163.426326] nvme 0000:ab:00.0: restoring config space at offset 0xc
>>>>>> (was 0x0, writing 0x8)
>>>>>> [  163.435666] nvme 0000:ab:00.0: restoring config space at offset 0x4
>>>>>> (was 0x100000, writing 0x100546)
>>>>>> [  163.446026] pcieport 0000:a9:10.0: AER: broadcast resume message
>>>>>> [  163.468311] nvme 0000:ab:00.0: saving config space at offset 0x0
>>>>>> (reading 0xa824144d)
>>>>>> [  163.477209] nvme 0000:ab:00.0: saving config space at offset 0x4
>>>>>> (reading 0x100546)
>>>>>> [  163.485876] nvme 0000:ab:00.0: saving config space at offset 0x8
>>>>>> (reading 0x1080200)
>>>>>> [  163.495399] nvme 0000:ab:00.0: saving config space at offset 0xc
>>>>>> (reading 0x8)
>>>>>> [  163.504149] nvme 0000:ab:00.0: saving config space at offset 0x10
>>>>>> (reading 0xe0710004)
>>>>>> [  163.513596] nvme 0000:ab:00.0: saving config space at offset 0x14
>>>>>> (reading 0x0)
>>>>>> [  163.522310] nvme 0000:ab:00.0: saving config space at offset 0x18
>>>>>> (reading 0x0)
>>>>>> [  163.531013] nvme 0000:ab:00.0: saving config space at offset 0x1c
>>>>>> (reading 0x0)
>>>>>> [  163.539704] nvme 0000:ab:00.0: saving config space at offset 0x20
>>>>>> (reading 0x0)
>>>>>> [  163.548353] nvme 0000:ab:00.0: saving config space at offset 0x24
>>>>>> (reading 0x0)
>>>>>> [  163.556983] nvme 0000:ab:00.0: saving config space at offset 0x28
>>>>>> (reading 0x0)
>>>>>> [  163.565615] nvme 0000:ab:00.0: saving config space at offset 0x2c
>>>>>> (reading 0xa80a144d)
>>>>>> [  163.574899] nvme 0000:ab:00.0: saving config space at offset 0x30
>>>>>> (reading 0xe0600000)
>>>>>> [  163.584215] nvme 0000:ab:00.0: saving config space at offset 0x34
>>>>>> (reading 0x40)
>>>>>> [  163.592941] nvme 0000:ab:00.0: saving config space at offset 0x38
>>>>>> (reading 0x0)
>>>>>> [  163.601554] nvme 0000:ab:00.0: saving config space at offset 0x3c
>>>>>> (reading 0x1ff)
>>>>>> [  210.089132] block nvme0n1: no usable path - requeuing I/O
>>>>>> [  223.776595] nvme nvme0: I/O 18 QID 0 timeout, disable controller
>>>>>> [  223.825236] nvme nvme0: Identify Controller failed (-4)
>>>>>> [  223.832145] nvme nvme0: Disabling device after reset failure: -5
>>>>>
>>>>> At this point the device is not going to recover.
>>>>
>>>> Yes, I agree.
>>>>
>>>> I looked little bit more and found that nvme reset failure and second DPC,
>>>> both were due to nvme_slot_reset() restoring MPS as part of
>>>> pci_restore_state().
>>>>
>>>> AFAICT, after the first DPC event occurs, nvme device MPS gets changed to
>>>> _default_ value 128B (this is likely due to DPC link retraining). However as
>>>> part of software AER recovery, nvme_slot_reset() restores device state, and
>>>> that brings the nvme device MPS back to 512B. (MPS of PCIe switch a9:10.0
>>>> still remains at 128B).
>>>>
>>>> At this point when nvme_reset_ctrl->nvme_reset_work() tries to enable the
>>>> device, malformedTLP again getting generated and that causes second DPC,
>>>> makes NVMe controller reset to fail as well.
>>>
>>> This sounds like the behavior I expect.  IIUC:
>>>
>>>     - Switch and NVMe MPS are 512B
>>>     - NVMe config space saved (including MPS=512B)
>>>     - You change Switch MPS to 128B
>>>     - NVMe does DMA with payload > 128B
>>>     - Switch reports Malformed TLP because TLP is larger than its MPS
>>>     - Recovery resets NVMe, which sets MPS to the default of 128B
>>>     - nvme_slot_reset() restores NVMe config space (MPS is now 512B)
>>>     - Subsequent NVMe DMA with payload > 128B repeats cycle
>>>
>>> What do you think *should* be happening here?  I don't see a PCI
>>> problem here.  If you change MPS on the Switch without coordinating
>>> with NVMe, things aren't going to work.  Or am I missing something?
>>
>> I agree this is expected but there are instances where I do _not_ see the
>> issue occurring. That is due to involvement of pciehp, which add and
>> configure nvme device - (coordinates MPS with pcie switch, and the new MPS
>> will get saved too. So future tests of this kind won't reproduce this issue
>> and that is understood).
>>
>> IMO though, the result of the test should be consistent.
>> Either pciehp/DPC should take care of device recovery 100% all the time;
>> Or we consider nvme recovery failure as an expected result because MPS of
>> pcie switch got changed without coordinating with nvme.
>>
>> What do you think?
> 
> In the log below, pciehp obviously is enabled; should I infer that in
> the log above, it is not?

pciehp is enabled all the time. In the log above and below.
I do not have answer yet why pciehp shows-up only in some tests (due to DPC link 
down/up) and not in others like you noticed in both the logs.


> 
> Generally we've avoided handling a device reset as a remove/add event
> because upper layers can't deal well with that.  But in the log below
> it looks like pciehp *did* treat the DPC containment as a remove/add,
> which of course involves configuring the "new" device and its MPS
> settings.

yes and that puzzled me why? especially when"Link Down/Up ignored (recovered by 
DPC)". Do we still have race somewhere, I am not sure.

> 
>    [  217.071200] pcieport 0000:a9:10.0: AER: broadcast slot_reset message
>    [  217.071217] nvme nvme0: restart after slot reset
>    [  217.071234] pcieport 0000:a9:10.0: pciehp: Slot(272): Link Down/Up ignored (recovered by DPC)
>    [  217.071250] pcieport 0000:a9:10.0: pciehp: pciehp_check_link_active: lnk_status = 2044
>    [  217.071259] pcieport 0000:a9:10.0: pciehp: Slot(272): Card not present
>    [  217.071267] pcieport 0000:a9:10.0: pciehp: pciehp_unconfigure_device: domain:bus:dev = 0000:ab:00
>    [  217.071320] nvme 0000:ab:00.0: restoring config space at offset 0x3c (was 0x100, writing 0x1ff)
>    [  217.071451] nvme 0000:ab:00.0: nvme_slot_reset: after pci_restore_state, DEVCTL: 0x5957
> 
> The .slot_reset() method (nvme_slot_reset()) is called *after* the
> device has been reset, and the device is supposed to be ready for the
> driver to use it.  But here it looks like pciehp thinks ab:00.0 is not
> present, so it removes it.  Later ab:00.0 is present again, so we
> re-enumerate it:

that is correct.

> 
>    [  217.311892] pcieport 0000:a9:10.0: pciehp: Slot(272): Card present
>    [  217.311897] pcieport 0000:a9:10.0: pciehp: Slot(272): Link Up
>    [  217.455159] pcieport 0000:a9:10.0: pciehp: pciehp_check_link_status: lnk_status = 2044
>    [  217.455222] pci 0000:ab:00.0: [144d:a824] type 00 class 0x010802
> 
> What kernel are you testing?  53b54ad074de ("PCI/DPC: Await readiness
> of secondary bus after reset") looks like it could be related, but
> you'd have to be using v6.3-rc1 or later to get it.

I am on v6.2 but I will give a try to v6.3-rc1 and get back.

> 
>> e.g. [ when pciehp takes care of things]
>>
>> [  216.608538] pcieport 0000:a9:10.0: pciehp: pending interrupts 0x0108 from
>> Slot Status
>> [  216.639954] pcieport 0000:a5:01.0: EDR: EDR event received
>> [  216.640429] pcieport 0000:a5:01.0: EDR: Reported EDR dev: 0000:a9:10.0
>> [  216.640438] pcieport 0000:a9:10.0: DPC: containment event, status:0x2009
>> source:0x0000
>> [  216.640442] pcieport 0000:a9:10.0: DPC: unmasked uncorrectable error detected
>> [  216.640452] pcieport 0000:a9:10.0: PCIe Bus Error: severity=Uncorrected
>> (Fatal), type=Transaction Layer, (Receiver ID)
>> [  216.652549] pcieport 0000:a9:10.0:   device [1000:c030] error
>> status/mask=00040000/00180000
>> [  216.661975] pcieport 0000:a9:10.0:    [18] MalfTLP                (First)
>> [  216.669647] pcieport 0000:a9:10.0: AER:   TLP Header: 60000080 ab0000ff
>> 00000102 276fe000
>> [  216.678890] pcieport 0000:a9:10.0: AER: broadcast error_detected message
>> [  216.678898] nvme nvme0: frozen state error detected, reset controller
>> [  216.842570] nvme0c0n1: I/O Cmd(0x2) @ LBA 16, 32 blocks, I/O Error (sct
>> 0x3 / sc 0x71)
>> [  216.851684] I/O error, dev nvme0c0n1, sector 16 op 0x0:(READ) flags
>> 0x4080700 phys_seg 4 prio class 2
>> [  217.071200] pcieport 0000:a9:10.0: AER: broadcast slot_reset message
>> [  217.071217] nvme nvme0: restart after slot reset
>> [  217.071228] nvme 0000:ab:00.0: nvme_slot_reset: before pci_restore_state
>> DEVCTL: 0x2910
>> [  217.071234] pcieport 0000:a9:10.0: pciehp: Slot(272): Link Down/Up
>> ignored (recovered by DPC)
>> [  217.071250] pcieport 0000:a9:10.0: pciehp: pciehp_check_link_active:
>> lnk_status = 2044
>> [  217.071259] pcieport 0000:a9:10.0: pciehp: Slot(272): Card not present
>> [  217.071267] pcieport 0000:a9:10.0: pciehp: pciehp_unconfigure_device:
>> domain:bus:dev = 0000:ab:00
>> [  217.071320] nvme 0000:ab:00.0: restoring config space at offset 0x3c (was
>> 0x100, writing 0x1ff)
>> [  217.071346] nvme 0000:ab:00.0: restoring config space at offset 0x30 (was
>> 0x0, writing 0xe0600000)
>> [  217.071373] nvme 0000:ab:00.0: restoring config space at offset 0x10 (was
>> 0x4, writing 0xe0710004)
>> [  217.071383] nvme 0000:ab:00.0: restoring config space at offset 0xc (was
>> 0x0, writing 0x8)
>> [  217.071394] nvme 0000:ab:00.0: restoring config space at offset 0x4 (was
>> 0x100000, writing 0x100546)
>> [  217.071451] nvme 0000:ab:00.0: nvme_slot_reset: after pci_restore_state,
>> DEVCTL: 0x5957
>> [  217.071464] pcieport 0000:a9:10.0: AER: broadcast resume message
>> [  217.071467] nvme 0000:ab:00.0: PME# disabled
>> [  217.071513] pcieport 0000:a9:10.0: AER: device recovery successful
>> [  217.071522] pcieport 0000:a9:10.0: EDR: DPC port successfully recovered
>> [  217.071526] nvme 0000:ab:00.0: vgaarb: pci_notify
>> [  217.071531] pcieport 0000:a5:01.0: EDR: Status for 0000:a9:10.0: 0x80
>> [  217.071614] nvme nvme0: ctrl state 6 is not RESETTING
>> [  217.103486] Buffer I/O error on dev nvme0n1, logical block 2, async page read
>> [  217.308778] pci 0000:ab:00.0: vgaarb: pci_notify
>> [  217.308831] pci 0000:ab:00.0: vgaarb: pci_notify
>> [  217.311299] pci 0000:ab:00.0: vgaarb: pci_notify
>> [  217.311863] pci 0000:ab:00.0: device released
>> [  217.311887] pcieport 0000:a9:10.0: pciehp: pciehp_check_link_active:
>> lnk_status = 2044
>> [  217.311892] pcieport 0000:a9:10.0: pciehp: Slot(272): Card present
>> [  217.311897] pcieport 0000:a9:10.0: pciehp: Slot(272): Link Up
>> [  217.455159] pcieport 0000:a9:10.0: pciehp: pciehp_check_link_status:
>> lnk_status = 2044
>> [  217.455222] pci 0000:ab:00.0: [144d:a824] type 00 class 0x010802
>> [  217.455275] pci 0000:ab:00.0: reg 0x10: [mem 0xe0710000-0xe0717fff 64bit]
>> [  217.455362] pci 0000:ab:00.0: reg 0x30: [mem 0xe0600000-0xe060ffff pref]
>> [  217.455380] pci 0000:ab:00.0: Max Payload Size set to 128 (was 512, max 512)
>> [  217.455726] pci 0000:ab:00.0: reg 0x20c: [mem 0xe0610000-0xe0617fff 64bit]
>> [  217.455732] pci 0000:ab:00.0: VF(n) BAR0 space: [mem
>> 0xe0610000-0xe070ffff 64bit] (contains BAR0 for 32 VFs)
>> [  217.456307] pci 0000:ab:00.0: vgaarb: pci_notify
>> [  217.456404] pcieport 0000:a9:10.0: bridge window [io  0x1000-0x0fff] to
>> [bus ab] add_size 1000
>> [  217.456413] pcieport 0000:a9:10.0: bridge window [mem
>> 0x00100000-0x000fffff 64bit pref] to [bus ab] add_size 200000 add_align
>> 100000
>> [  217.456430] pcieport 0000:a9:10.0: BAR 15: no space for [mem size
>> 0x00200000 64bit pref]
>> [  217.456436] pcieport 0000:a9:10.0: BAR 15: failed to assign [mem size
>> 0x00200000 64bit pref]
>> [  217.456440] pcieport 0000:a9:10.0: BAR 13: no space for [io  size 0x1000]
>> [  217.456444] pcieport 0000:a9:10.0: BAR 13: failed to assign [io  size 0x1000]
>> [  217.456451] pcieport 0000:a9:10.0: BAR 15: no space for [mem size
>> 0x00200000 64bit pref]
>> [  217.456457] pcieport 0000:a9:10.0: BAR 15: failed to assign [mem size
>> 0x00200000 64bit pref]
>> [  217.456464] pcieport 0000:a9:10.0: BAR 13: no space for [io  size 0x1000]
>> [  217.456470] pcieport 0000:a9:10.0: BAR 13: failed to assign [io  size 0x1000]
>> [  217.456480] pci 0000:ab:00.0: BAR 6: assigned [mem 0xe0600000-0xe060ffff pref]
>> [  217.456488] pci 0000:ab:00.0: BAR 0: assigned [mem 0xe0610000-0xe0617fff 64bit]
>> [  217.456509] pci 0000:ab:00.0: BAR 7: assigned [mem 0xe0618000-0xe0717fff 64bit]
>> [  217.456517] pcieport 0000:a9:10.0: PCI bridge to [bus ab]
>> [  217.456526] pcieport 0000:a9:10.0:   bridge window [mem 0xe0600000-0xe07fffff]
>> [  217.456614] nvme 0000:ab:00.0: vgaarb: pci_notify
>> [  217.456624] nvme 0000:ab:00.0: runtime IRQ mapping not provided by arch
>> [  217.457452] nvme nvme10: pci function 0000:ab:00.0
>> [  217.458154] nvme 0000:ab:00.0: saving config space at offset 0x0 (reading
>> 0xa824144d)
>> [  217.458166] nvme 0000:ab:00.0: saving config space at offset 0x4 (reading
>> 0x100546)
>> [  217.458173] nvme 0000:ab:00.0: saving config space at offset 0x8 (reading
>> 0x1080200)
>> [  217.458179] nvme 0000:ab:00.0: saving config space at offset 0xc (reading 0x8)
>> [  217.458185] nvme 0000:ab:00.0: saving config space at offset 0x10
>> (reading 0xe0610004)
>> [  217.458192] nvme 0000:ab:00.0: saving config space at offset 0x14 (reading 0x0)
>> [  217.458198] nvme 0000:ab:00.0: saving config space at offset 0x18 (reading 0x0)
>> [  217.458202] nvme 0000:ab:00.0: saving config space at offset 0x1c (reading 0x0)
>> [  217.458207] nvme 0000:ab:00.0: saving config space at offset 0x20 (reading 0x0)
>> [  217.458212] nvme 0000:ab:00.0: saving config space at offset 0x24 (reading 0x0)
>> [  217.458217] nvme 0000:ab:00.0: saving config space at offset 0x28 (reading 0x0)
>> [  217.458222] nvme 0000:ab:00.0: saving config space at offset 0x2c
>> (reading 0xa80a144d)
>> [  217.458227] nvme 0000:ab:00.0: saving config space at offset 0x30
>> (reading 0xe0600000)
>> [  217.458237] nvme 0000:ab:00.0: saving config space at offset 0x34 (reading 0x40)
>> [  217.458242] nvme 0000:ab:00.0: saving config space at offset 0x38 (reading 0x0)
>> [  217.458247] nvme 0000:ab:00.0: saving config space at offset 0x3c (reading 0x1ff)
>> [  217.462192] nvme nvme10: Shutdown timeout set to 10 seconds
>> [  217.520625] nvme nvme10: 63/0/0 default/read/poll queues
