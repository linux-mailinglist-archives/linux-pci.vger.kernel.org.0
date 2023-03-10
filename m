Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB746B5499
	for <lists+linux-pci@lfdr.de>; Fri, 10 Mar 2023 23:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjCJWjf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Mar 2023 17:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjCJWjd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Mar 2023 17:39:33 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2087.outbound.protection.outlook.com [40.107.100.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B7312C0DE
        for <linux-pci@vger.kernel.org>; Fri, 10 Mar 2023 14:39:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfQy111qRaq7W4QULX3n+aEGqL17dchtwm0WpVQ80aPXu6WUugYPcvS6pwkr6RGavESrK6KQdLwItxKmh7yV0+SUUPYwqurhhvgqf78oJW6KdrTanF1wle9TN8/jOUuZU0sO+8vVUY/x3K/EHuk4Ae/7UvDeDBNpp64v1ZWqjH2GS7NLhH2SHZr7MxpNZBcUNmEgnYyX/qrZsltjKCysb+Fv9/iUYnadi0UiYTpIzAE3X2Y8wgwaDri0xK42jn4OAZEssxAYh1mwqDTKLrI0NSBEUZFEp5mk46/kafZ4LfONeyAF0WxkUJoex6oGLlYHShhYQ/REV9+5cr2Yp9oF0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2U+WFsAKhcIpRKGY6FTterWmvVRpccXek6L+RHWW5So=;
 b=c5iHFuxgAS8nxUPxdpWSWs4/1UuBLqW3Sw423lRs85WmMX9mrdBG0lOqbN9URl2Ucp/oJrfoVjq1BNCH3VRIF3/rUPG/KeW+qMHgZHo6Xm26ss9gxhq7o7Te9gtWqPc9YcCl6mRNdEM1c5wwWYsL2r1y6eywy/jw7Z/mkUBaxBi9dg0ltNm18cHWlNy6SMRpU+s5zB44XKh8Gpnz84xBI/nk2Uh/v2egtjxQHZ5DppxUdeyIZ2PV9UkZ4YvgXjd3ixYmxfkPvCZj9UzymgPHt7V6CDR7i7amZKit3M88v12eeMwOEpfLYKbqSGrHHw237XWJvD+ykdUHXfWWMsaKCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2U+WFsAKhcIpRKGY6FTterWmvVRpccXek6L+RHWW5So=;
 b=CcWWSKAOrTS/JvBQkYdTppjHS2o8liqKK7rPLnsu2a6N5cibKryrtuNw7zDY7HcSPwToCR8OcjfVAY2zJEuAZUl3lEx/4Z6jqdXdWvgU0rgksAEoMnS1h6x/6zIMhVmWUS+qKhb23TR6nIl7Z4lfkVSXnb1PQA1VXgSnWHEKtWThE48Zg7Irp9V67HLAgRtcrLYm4jpu2+8vBFIMpm2nllXvb1Ztyx1IGhCxA4B5A5xyBm6R5GApwkkv3skAgxkwDVGUzjtEku3oxiMUGtxO+v4mIZOReaiCVvRYXbOxJ7zHGtGP2QaijEGiBFXDDo1Ybvu3Hpb+7VyMC/WFHxKmiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3194.namprd12.prod.outlook.com (2603:10b6:5:184::13)
 by PH7PR12MB8795.namprd12.prod.outlook.com (2603:10b6:510:275::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 22:39:23 +0000
Received: from DM6PR12MB3194.namprd12.prod.outlook.com
 ([fe80::4e94:9f56:2d7d:99ae]) by DM6PR12MB3194.namprd12.prod.outlook.com
 ([fe80::4e94:9f56:2d7d:99ae%3]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 22:39:23 +0000
Message-ID: <843e2392-9ff0-2286-5f97-659831013c2e@nvidia.com>
Date:   Fri, 10 Mar 2023 14:39:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: nvme-pci: Disabling device after reset failure: -5 occurs while
 AER recovery
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
        kbusch@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org
References: <20230309175321.GA1151233@bhelgaas>
From:   Tushar Dave <tdave@nvidia.com>
In-Reply-To: <20230309175321.GA1151233@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0180.namprd04.prod.outlook.com
 (2603:10b6:303:85::35) To DM6PR12MB3194.namprd12.prod.outlook.com
 (2603:10b6:5:184::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3194:EE_|PH7PR12MB8795:EE_
X-MS-Office365-Filtering-Correlation-Id: 956d3298-c226-4bbb-e05f-08db21b84b87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4UQWwMOEjlKmYE9O6Yr0vR91bH3VH3YOd5AmAmnh6Z2Dz4EZdWjPRylHLazrmDLntq2Tj4IFZi5++KtmjV88TWDlY0ZrEzX31bIIYjAdKr0TdQ8wEhbY8+pJWRU5uOzUjldFMIXRgJHBc3HCYMTv3VnDzIwSN3YQgxHyVbPpD4w1MZaZBsw2sOOaPexV0WO0YKuG8H7If28acgEkgFaLXnnJO/16lMiPJmbIIPg17YnHy+rDYAW9uOMUhRC9zv1X3JCVyzvSNPSu4cD+//1OxZT+3OU6xgvOhrKERQk3nOu9aq3ljtP/0zDOdjON73F/BL0IhtaeOEuDjzSsRz4qDO6BIW4cPbUSrTdrpPosjjuFurhKDnOnf+KDdD1YoIsec/TiwdR4ZdrnYtjiGi/AU8X1QLweowh4tAejOcG22Y9fseW6mhnhuC43MKj7FItwV4dHHHQFOscOtvXe3mpebL+e9W5Jf7CCMrA9hXeRKcvQlXE2580bvh9t1/KkkLJCjZPgcaQrl0ZDCi2pbyj/tPiNJaGKBDETWcaHlYs2xWbEv2HmoxHpj3v/7R76lo8UweA0YbfUe91ZoiHlAdPuvf0K7j//B9KvZSRDo5GbMY6BqkkyCYlt61588cj/3j/gqX9moUjd5nA4mLNDNgckLLBG0bIwLLp49Ua4yxdY9nEEMYkpFDGKX7AJO9M95hW9l3iBRGzJWDbbbrVLgTX77F/IqHLk9H5ykIn44k9uHhA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199018)(38100700002)(36756003)(478600001)(6916009)(6486002)(316002)(5660300002)(2906002)(30864003)(8936002)(66556008)(66476007)(41300700001)(66946007)(8676002)(4326008)(26005)(6506007)(31696002)(83380400001)(86362001)(6666004)(186003)(2616005)(6512007)(53546011)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmxKZVZxNHJ0NDdiN0lIS2hONTVSWHdiWjhtS0o5QWRzN0pwdjViOHIzUFhp?=
 =?utf-8?B?YU55SkpyLyttNVR1WTFtNHE1NlRaVm9qS3JGVXllZEtWU2ZBT3VBOFlOOEw2?=
 =?utf-8?B?QW9mdVlHZUtLdW9vczd2eFpTSEJsZVV3TU5Hc2xEZDBqWUxlNEVLeE81azBY?=
 =?utf-8?B?UjJ1d1ZyUU90Q3BFeUZDR254RzB1WjlvQjhQUDFoNDRSWGtqdkU5TytBaUdl?=
 =?utf-8?B?blFIUUl3MjZid3dHYmFMZC9XK1h0UDBRMlVuR0p0YU5JeEtGdGE3YWM2ZEh5?=
 =?utf-8?B?cmtrM0tCNHFEbkF1ZFZWekx2MndtVTZVaWx4SEJVRmtNaXF6RzJmcldyK0sr?=
 =?utf-8?B?WHA3aU5yNDh3VCs3SEp6dkNpdUNxZGZEMVJoYmVENWRNYndDMGJqUU4rQXhI?=
 =?utf-8?B?N3pxTEtaZUtNWXlKRG4zTWdHVC9YZGhRNkVnVlNzV3cwUnVQbDJ4T0lmZHRG?=
 =?utf-8?B?cURvTllvY1NlOHVVVmhSMGFDcklDTjVnM0RhSGZUNUl0UkJHaVEyV2k5TTRy?=
 =?utf-8?B?NFBWN2FWMGpJdWozVWFVZWMwdUMyVTRoUTVUdUwxVEJDeHQ1a0VJbURmRGxj?=
 =?utf-8?B?N1JKZWNSaGxyK1g3SlRXbmR5UWpwK21jWXJIN3k3L2tqOGluRmpPMjNjZTFK?=
 =?utf-8?B?NFAxUUUwZGwwWk1LekFSWllEZzNMZ091Zk9RNytHTmZtVjNNU1BYV2VwenRh?=
 =?utf-8?B?MVMzNS9rTEZRRkN3SmdWZzBpUzJaNEIzYm9qQWZNSytzQWFFdHJSZzlUZmNH?=
 =?utf-8?B?QkhvaE4vTW50YjdjVTJDdUxuSit2VmY1eTRodUVyRGNzci81YjZpbGpGMEpo?=
 =?utf-8?B?QVZTR2NyczUwMXE2dnFBMEtHZUFNeEV1ZVdWMVlwWHVwNkNuU0czOEFCdHlp?=
 =?utf-8?B?NlJ6V0l3Q2RSUkxYS2VhWnlkRDFWTHBWeEE2bU5vTEJhNUZNMHVqOENSM2ND?=
 =?utf-8?B?bVVEK2hZbndEeGVlTS9ncHE3L2VzRmFodWhMSWx0S3VkQnBTZml4RnEzTHln?=
 =?utf-8?B?MTNhTWkwa2RBOHljaTdPWFFiZnBVcm5OcXZiZThpaDlhdGJxUUVSQjNzMkF4?=
 =?utf-8?B?bzVqdFZWaU5pMHdPc3NYeEJhdVZuRHUyRGRpblFCMHduV0t6NllsYlJBc3lZ?=
 =?utf-8?B?dWhZcC9SQ0Q5ekFpSzVpYnhxeW5MYnpBWWEvaUZEcGhKUlFmZ2JvVHpOOFZr?=
 =?utf-8?B?algrZElzVTNJVC9xUUpHVkdvS0FKZW1TSHlBOGF3cWJVcHVaNDFGR1YxRGJm?=
 =?utf-8?B?ZHE1d1QvVjM2K2JDQjN2d3ZvLzkrNy9VdEJpQWswdmR3Yi9vYVcrdUorMk94?=
 =?utf-8?B?cE84NXJ6MFJTMWdQd0NSUDRGUTJkd0o5Wi9vRzEvZlpXdEZTRzVIb213OXlU?=
 =?utf-8?B?MEwxbUR6MmNVU0xzSHAwZHEwNjRzR2llYWNhUjVSTTNLR09ETzVJUFRyVVlC?=
 =?utf-8?B?azJwNUJjcVIyQXBSdktMN1RXakNWeUkxNFRpUlZnOHRBMEdtOWxSZWQ1ZitP?=
 =?utf-8?B?ZnpxNGV0Q2pSa29tM2s1WG5VZEtzbDhpektaNW1mN2JFVWtlMUNSVjN1UFcx?=
 =?utf-8?B?R0lXZGJvRmVlMmtHYkRpMmMrRzB3OEVJZ0txV3FKbW1aNVQxTVFWQmZaRUR0?=
 =?utf-8?B?YmNBU2IvYXVvL2Zic05SQXFLT3RLakpYQnJVN1ovV2NiZVhKa0ZjRG9DN29B?=
 =?utf-8?B?cG5KS0RIT0RUOEJRdDRGTy94V09QMjJlaWdRdkpyaEtWUndIL2NrOWE0WW5i?=
 =?utf-8?B?MlIvUGV6L0lhV3RlTG1GcmRER1h2RmdOZjJtUVozQkkyT2hTbll0aEhQdVdt?=
 =?utf-8?B?WlY1NTlFOGo1VzFkM0dQdGZSQ0tlNWF6L1E5LytteTJKYzZhQzFDSzRjQk5k?=
 =?utf-8?B?Wk4xY3VFWDV3dnhQL0ozMWROUmZBUDRoeVc2Qm4wTmFoMWNqL2pUNlZ0Q0k1?=
 =?utf-8?B?QzMxa3JsV1lQWkJQT3RPS2xuWk5VVUo2S3JWWWpIYTI1d29xcFpPZm1nZWkv?=
 =?utf-8?B?MFNnT0d5UmtUM0F6WTYxd0VDVGdCa1pTZnVNa29zQ0ZFTHZTbGQ0ZHl6Rzl0?=
 =?utf-8?B?c1pUWlF4R0dzVHpvUC9WSGVaWGF4cGFMTVlGa1YyUlFRZWhBSWVCYTR3Sjl4?=
 =?utf-8?Q?4FXZFs5XwWcbDGOilGkXc6iaS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 956d3298-c226-4bbb-e05f-08db21b84b87
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 22:39:22.9514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BtPdaV8k/J/TS/CPgyilCrhvQV+TDOi3eECVObOYGHBeOTriTgk4rbqCbYmmMnb8nwS4lhx58wp1LEGi1hPDAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8795
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/9/23 09:53, Bjorn Helgaas wrote:
> [+cc linux-pci]
> 
> On Wed, Mar 08, 2023 at 07:34:58PM -0800, Tushar Dave wrote:
>> On 3/7/23 03:59, Sagi Grimberg wrote:
>>> On 3/2/23 02:09, Tushar Dave wrote:
>>>> We are observing NVMe device disabled due to reset failure after
>>>> injecting Malformed TLP. DPC/AER recovery succeed but NVMe fails.
>>>> I tried this on 2 different system and it is 100% reproducible with 6.2
>>>> kernel.
>>>>
>>>> On my system, Samsung NVMe SSD Controller PM173X is directly behind the
>>>> Broadcom PCIe Switch Downstream Port.
>>>> MalformedTLP is injected by changing MaxPayload Size(MPS) of PCIe switch
>>>> to 128B (keeping NVMe device MPS 512B).
>>>>
>>>> e.g.
>>>> # change MPS of PCIe switch (a9:10.0)
>>>> $ setpci -v -s a9:10.0 cap_exp+0x8.w
>>>> 0000:a9:10.0 (cap 10 @68) @70 = 0857
>>>> $ setpci -v -s a9:10.0 cap_exp+0x8.w=0x0817
>>>> 0000:a9:10.0 (cap 10 @68) @70 0817
>>>> $ lspci -s a9:10.0 -vvv | grep -w DevCtl -A 2
>>>>           DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq-
>>>>               RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
>>>>               MaxPayload 128 bytes, MaxReadReq 128 bytes
>>>>
>>>> # run some traffic on nvme (ab:00.0)
>>>> $ dd if=/dev/nvme0n1 of=/tmp/test bs=4K
>>>> dd: error reading '/dev/nvme0n1': Input/output error
>>>> 2+0 records in
>>>> 2+0 records out
>>>> 8192 bytes (8.2 kB, 8.0 KiB) copied, 0.0115304 s, 710 kB/s
>>>>
>>>> #kernel log:
>>>> [  163.034889] pcieport 0000:a5:01.0: EDR: EDR event received
>>>> [  163.041671] pcieport 0000:a5:01.0: EDR: Reported EDR dev: 0000:a9:10.0
>>>> [  163.049071] pcieport 0000:a9:10.0: DPC: containment event,
>>>> status:0x2009 source:0x0000
>>>> [  163.058014] pcieport 0000:a9:10.0: DPC: unmasked uncorrectable error
>>>> detected
>>>> [  163.066081] pcieport 0000:a9:10.0: PCIe Bus Error:
>>>> severity=Uncorrected (Fatal), type=Transaction Layer, (Receiver ID)
>>>> [  163.078151] pcieport 0000:a9:10.0:   device [1000:c030] error
>>>> status/mask=00040000/00180000
>>>> [  163.087613] pcieport 0000:a9:10.0:    [18] MalfTLP
>>>> (First)
>>>> [  163.095281] pcieport 0000:a9:10.0: AER:   TLP Header: 60000080
>>>> ab0000ff 00000001 d1fd0000
>>>> [  163.104517] pcieport 0000:a9:10.0: AER: broadcast error_detected message
>>>> [  163.112095] nvme nvme0: frozen state error detected, reset controller
>>>> [  163.150716] nvme0c0n1: I/O Cmd(0x2) @ LBA 16, 32 blocks, I/O Error
>>>> (sct 0x3 / sc 0x71)
>>>> [  163.159802] I/O error, dev nvme0c0n1, sector 16 op 0x0:(READ) flags
>>>> 0x4080700 phys_seg 4 prio class 2
>>>> [  163.383661] pcieport 0000:a9:10.0: AER: broadcast slot_reset message
>>>> [  163.390895] nvme nvme0: restart after slot reset
>>>> [  163.396230] nvme 0000:ab:00.0: restoring config space at offset 0x3c
>>>> (was 0x100, writing 0x1ff)
>>>> [  163.406079] nvme 0000:ab:00.0: restoring config space at offset 0x30
>>>> (was 0x0, writing 0xe0600000)
>>>> [  163.416212] nvme 0000:ab:00.0: restoring config space at offset 0x10
>>>> (was 0x4, writing 0xe0710004)
>>>> [  163.426326] nvme 0000:ab:00.0: restoring config space at offset 0xc
>>>> (was 0x0, writing 0x8)
>>>> [  163.435666] nvme 0000:ab:00.0: restoring config space at offset 0x4
>>>> (was 0x100000, writing 0x100546)
>>>> [  163.446026] pcieport 0000:a9:10.0: AER: broadcast resume message
>>>> [  163.468311] nvme 0000:ab:00.0: saving config space at offset 0x0
>>>> (reading 0xa824144d)
>>>> [  163.477209] nvme 0000:ab:00.0: saving config space at offset 0x4
>>>> (reading 0x100546)
>>>> [  163.485876] nvme 0000:ab:00.0: saving config space at offset 0x8
>>>> (reading 0x1080200)
>>>> [  163.495399] nvme 0000:ab:00.0: saving config space at offset 0xc
>>>> (reading 0x8)
>>>> [  163.504149] nvme 0000:ab:00.0: saving config space at offset 0x10
>>>> (reading 0xe0710004)
>>>> [  163.513596] nvme 0000:ab:00.0: saving config space at offset 0x14
>>>> (reading 0x0)
>>>> [  163.522310] nvme 0000:ab:00.0: saving config space at offset 0x18
>>>> (reading 0x0)
>>>> [  163.531013] nvme 0000:ab:00.0: saving config space at offset 0x1c
>>>> (reading 0x0)
>>>> [  163.539704] nvme 0000:ab:00.0: saving config space at offset 0x20
>>>> (reading 0x0)
>>>> [  163.548353] nvme 0000:ab:00.0: saving config space at offset 0x24
>>>> (reading 0x0)
>>>> [  163.556983] nvme 0000:ab:00.0: saving config space at offset 0x28
>>>> (reading 0x0)
>>>> [  163.565615] nvme 0000:ab:00.0: saving config space at offset 0x2c
>>>> (reading 0xa80a144d)
>>>> [  163.574899] nvme 0000:ab:00.0: saving config space at offset 0x30
>>>> (reading 0xe0600000)
>>>> [  163.584215] nvme 0000:ab:00.0: saving config space at offset 0x34
>>>> (reading 0x40)
>>>> [  163.592941] nvme 0000:ab:00.0: saving config space at offset 0x38
>>>> (reading 0x0)
>>>> [  163.601554] nvme 0000:ab:00.0: saving config space at offset 0x3c
>>>> (reading 0x1ff)
>>>> [  210.089132] block nvme0n1: no usable path - requeuing I/O
>>>> [  223.776595] nvme nvme0: I/O 18 QID 0 timeout, disable controller
>>>> [  223.825236] nvme nvme0: Identify Controller failed (-4)
>>>> [  223.832145] nvme nvme0: Disabling device after reset failure: -5
>>>
>>> At this point the device is not going to recover.
>> Yes, I agree.
>>
>> I looked little bit more and found that nvme reset failure and second DPC,
>> both were due to nvme_slot_reset() restoring MPS as part of
>> pci_restore_state().
>>
>> AFAICT, after the first DPC event occurs, nvme device MPS gets changed to
>> _default_ value 128B (this is likely due to DPC link retraining). However as
>> part of software AER recovery, nvme_slot_reset() restores device state, and
>> that brings the nvme device MPS back to 512B. (MPS of PCIe switch a9:10.0
>> still remains at 128B).
>>
>> At this point when nvme_reset_ctrl->nvme_reset_work() tries to enable the
>> device, malformedTLP again getting generated and that causes second DPC,
>> makes NVMe controller reset to fail as well.
> 
> This sounds like the behavior I expect.  IIUC:
> 
>    - Switch and NVMe MPS are 512B
>    - NVMe config space saved (including MPS=512B)
>    - You change Switch MPS to 128B
>    - NVMe does DMA with payload > 128B
>    - Switch reports Malformed TLP because TLP is larger than its MPS
>    - Recovery resets NVMe, which sets MPS to the default of 128B
>    - nvme_slot_reset() restores NVMe config space (MPS is now 512B)
>    - Subsequent NVMe DMA with payload > 128B repeats cycle
> 
> What do you think *should* be happening here?  I don't see a PCI
> problem here.  If you change MPS on the Switch without coordinating
> with NVMe, things aren't going to work.  Or am I missing something?

I agree this is expected but there are instances where I do _not_ see the issue 
occurring. That is due to involvement of pciehp, which add and configure nvme 
device - (coordinates MPS with pcie switch, and the new MPS will get saved too. 
So future tests of this kind won't reproduce this issue and that is understood).

IMO though, the result of the test should be consistent.
Either pciehp/DPC should take care of device recovery 100% all the time;
Or we consider nvme recovery failure as an expected result because MPS of pcie 
switch got changed without coordinating with nvme.

What do you think?


e.g. [ when pciehp takes care of things]

[  216.608538] pcieport 0000:a9:10.0: pciehp: pending interrupts 0x0108 from 
Slot Status
[  216.639954] pcieport 0000:a5:01.0: EDR: EDR event received
[  216.640429] pcieport 0000:a5:01.0: EDR: Reported EDR dev: 0000:a9:10.0
[  216.640438] pcieport 0000:a9:10.0: DPC: containment event, status:0x2009 
source:0x0000
[  216.640442] pcieport 0000:a9:10.0: DPC: unmasked uncorrectable error detected
[  216.640452] pcieport 0000:a9:10.0: PCIe Bus Error: severity=Uncorrected 
(Fatal), type=Transaction Layer, (Receiver ID)
[  216.652549] pcieport 0000:a9:10.0:   device [1000:c030] error 
status/mask=00040000/00180000
[  216.661975] pcieport 0000:a9:10.0:    [18] MalfTLP                (First)
[  216.669647] pcieport 0000:a9:10.0: AER:   TLP Header: 60000080 ab0000ff 
00000102 276fe000
[  216.678890] pcieport 0000:a9:10.0: AER: broadcast error_detected message
[  216.678898] nvme nvme0: frozen state error detected, reset controller
[  216.842570] nvme0c0n1: I/O Cmd(0x2) @ LBA 16, 32 blocks, I/O Error (sct 0x3 / 
sc 0x71)
[  216.851684] I/O error, dev nvme0c0n1, sector 16 op 0x0:(READ) flags 0x4080700 
phys_seg 4 prio class 2
[  217.071200] pcieport 0000:a9:10.0: AER: broadcast slot_reset message
[  217.071217] nvme nvme0: restart after slot reset
[  217.071228] nvme 0000:ab:00.0: nvme_slot_reset: before pci_restore_state 
DEVCTL: 0x2910
[  217.071234] pcieport 0000:a9:10.0: pciehp: Slot(272): Link Down/Up ignored 
(recovered by DPC)
[  217.071250] pcieport 0000:a9:10.0: pciehp: pciehp_check_link_active: 
lnk_status = 2044
[  217.071259] pcieport 0000:a9:10.0: pciehp: Slot(272): Card not present
[  217.071267] pcieport 0000:a9:10.0: pciehp: pciehp_unconfigure_device: 
domain:bus:dev = 0000:ab:00
[  217.071320] nvme 0000:ab:00.0: restoring config space at offset 0x3c (was 
0x100, writing 0x1ff)
[  217.071346] nvme 0000:ab:00.0: restoring config space at offset 0x30 (was 
0x0, writing 0xe0600000)
[  217.071373] nvme 0000:ab:00.0: restoring config space at offset 0x10 (was 
0x4, writing 0xe0710004)
[  217.071383] nvme 0000:ab:00.0: restoring config space at offset 0xc (was 0x0, 
writing 0x8)
[  217.071394] nvme 0000:ab:00.0: restoring config space at offset 0x4 (was 
0x100000, writing 0x100546)
[  217.071451] nvme 0000:ab:00.0: nvme_slot_reset: after pci_restore_state, 
DEVCTL: 0x5957
[  217.071464] pcieport 0000:a9:10.0: AER: broadcast resume message
[  217.071467] nvme 0000:ab:00.0: PME# disabled
[  217.071513] pcieport 0000:a9:10.0: AER: device recovery successful
[  217.071522] pcieport 0000:a9:10.0: EDR: DPC port successfully recovered
[  217.071526] nvme 0000:ab:00.0: vgaarb: pci_notify
[  217.071531] pcieport 0000:a5:01.0: EDR: Status for 0000:a9:10.0: 0x80
[  217.071614] nvme nvme0: ctrl state 6 is not RESETTING
[  217.103486] Buffer I/O error on dev nvme0n1, logical block 2, async page read
[  217.308778] pci 0000:ab:00.0: vgaarb: pci_notify
[  217.308831] pci 0000:ab:00.0: vgaarb: pci_notify
[  217.311299] pci 0000:ab:00.0: vgaarb: pci_notify
[  217.311863] pci 0000:ab:00.0: device released
[  217.311887] pcieport 0000:a9:10.0: pciehp: pciehp_check_link_active: 
lnk_status = 2044
[  217.311892] pcieport 0000:a9:10.0: pciehp: Slot(272): Card present
[  217.311897] pcieport 0000:a9:10.0: pciehp: Slot(272): Link Up
[  217.455159] pcieport 0000:a9:10.0: pciehp: pciehp_check_link_status: 
lnk_status = 2044
[  217.455222] pci 0000:ab:00.0: [144d:a824] type 00 class 0x010802
[  217.455275] pci 0000:ab:00.0: reg 0x10: [mem 0xe0710000-0xe0717fff 64bit]
[  217.455362] pci 0000:ab:00.0: reg 0x30: [mem 0xe0600000-0xe060ffff pref]
[  217.455380] pci 0000:ab:00.0: Max Payload Size set to 128 (was 512, max 512)
[  217.455726] pci 0000:ab:00.0: reg 0x20c: [mem 0xe0610000-0xe0617fff 64bit]
[  217.455732] pci 0000:ab:00.0: VF(n) BAR0 space: [mem 0xe0610000-0xe070ffff 
64bit] (contains BAR0 for 32 VFs)
[  217.456307] pci 0000:ab:00.0: vgaarb: pci_notify
[  217.456404] pcieport 0000:a9:10.0: bridge window [io  0x1000-0x0fff] to [bus 
ab] add_size 1000
[  217.456413] pcieport 0000:a9:10.0: bridge window [mem 0x00100000-0x000fffff 
64bit pref] to [bus ab] add_size 200000 add_align 100000
[  217.456430] pcieport 0000:a9:10.0: BAR 15: no space for [mem size 0x00200000 
64bit pref]
[  217.456436] pcieport 0000:a9:10.0: BAR 15: failed to assign [mem size 
0x00200000 64bit pref]
[  217.456440] pcieport 0000:a9:10.0: BAR 13: no space for [io  size 0x1000]
[  217.456444] pcieport 0000:a9:10.0: BAR 13: failed to assign [io  size 0x1000]
[  217.456451] pcieport 0000:a9:10.0: BAR 15: no space for [mem size 0x00200000 
64bit pref]
[  217.456457] pcieport 0000:a9:10.0: BAR 15: failed to assign [mem size 
0x00200000 64bit pref]
[  217.456464] pcieport 0000:a9:10.0: BAR 13: no space for [io  size 0x1000]
[  217.456470] pcieport 0000:a9:10.0: BAR 13: failed to assign [io  size 0x1000]
[  217.456480] pci 0000:ab:00.0: BAR 6: assigned [mem 0xe0600000-0xe060ffff pref]
[  217.456488] pci 0000:ab:00.0: BAR 0: assigned [mem 0xe0610000-0xe0617fff 64bit]
[  217.456509] pci 0000:ab:00.0: BAR 7: assigned [mem 0xe0618000-0xe0717fff 64bit]
[  217.456517] pcieport 0000:a9:10.0: PCI bridge to [bus ab]
[  217.456526] pcieport 0000:a9:10.0:   bridge window [mem 0xe0600000-0xe07fffff]
[  217.456614] nvme 0000:ab:00.0: vgaarb: pci_notify
[  217.456624] nvme 0000:ab:00.0: runtime IRQ mapping not provided by arch
[  217.457452] nvme nvme10: pci function 0000:ab:00.0
[  217.458154] nvme 0000:ab:00.0: saving config space at offset 0x0 (reading 
0xa824144d)
[  217.458166] nvme 0000:ab:00.0: saving config space at offset 0x4 (reading 
0x100546)
[  217.458173] nvme 0000:ab:00.0: saving config space at offset 0x8 (reading 
0x1080200)
[  217.458179] nvme 0000:ab:00.0: saving config space at offset 0xc (reading 0x8)
[  217.458185] nvme 0000:ab:00.0: saving config space at offset 0x10 (reading 
0xe0610004)
[  217.458192] nvme 0000:ab:00.0: saving config space at offset 0x14 (reading 0x0)
[  217.458198] nvme 0000:ab:00.0: saving config space at offset 0x18 (reading 0x0)
[  217.458202] nvme 0000:ab:00.0: saving config space at offset 0x1c (reading 0x0)
[  217.458207] nvme 0000:ab:00.0: saving config space at offset 0x20 (reading 0x0)
[  217.458212] nvme 0000:ab:00.0: saving config space at offset 0x24 (reading 0x0)
[  217.458217] nvme 0000:ab:00.0: saving config space at offset 0x28 (reading 0x0)
[  217.458222] nvme 0000:ab:00.0: saving config space at offset 0x2c (reading 
0xa80a144d)
[  217.458227] nvme 0000:ab:00.0: saving config space at offset 0x30 (reading 
0xe0600000)
[  217.458237] nvme 0000:ab:00.0: saving config space at offset 0x34 (reading 0x40)
[  217.458242] nvme 0000:ab:00.0: saving config space at offset 0x38 (reading 0x0)
[  217.458247] nvme 0000:ab:00.0: saving config space at offset 0x3c (reading 0x1ff)
[  217.462192] nvme nvme10: Shutdown timeout set to 10 seconds
[  217.520625] nvme nvme10: 63/0/0 default/read/poll queues


-Tushar
> 
> Bjorn
