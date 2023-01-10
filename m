Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41A666446B
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jan 2023 16:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbjAJPTu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Jan 2023 10:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbjAJPTs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jan 2023 10:19:48 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B53479C4;
        Tue, 10 Jan 2023 07:19:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUoVps0NrMn653v2yxyZiZ9yMX9LY8by98Y0vOc7Gpwx2W+mn4XUsnR7C5PjB5lHg5T1BEMIXtFexshc70sCyKXWvNn/KIX+E/UASGbUmG9YXNBKNuwKG8sordZ/sdQU40HOu4VqoulfUrh0bc0heitToVVyMiGvb1HLRp5zjqAxPtAvb5bmAw/mi2cWZqUYsBMkqfwtyOmtQnA9SCq+etCCFkKggxVPEYGvgzt8PYvsmbri48BLcye2ocCA24Z/zrcnaT0vmRa1QPoizWTqrbMvg1fED4Vd9NisTBirJlGU8s43BjvCok3/R40pS2+f4i35bAEfqS8VfFyjWnNTew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FYwgY6I57GCIzCSTLCU69IeGYbe1uenkd/RkjRZU2eI=;
 b=BcV5WCNaTONpqsKvVf7hlZZGGIkr3ZUneSQwtabGeDkKJsLyz4peslRe10VXhJwABsmnBF7w+JCUe6/bDKj68JpybtmlIOSacVr4MBHwC3zO+ix8b31gWBKbbv8rPx3wGzZqN1SLNfrJOnZL1+/TXLWd1/gsaHyFH1DCIycKsUA8Rb1kt0+FYQHJryhBD2DOJPQuc9cQ9ZgqT+UlJXDmKHdLdqB57pOjyjOaKjlIrF0k+w/wy9WIpFY4mN9NxQwD960hDz1gtIbTovd5Gu4Ya0vLZyDtR/BfnbtXhQs1IauVmeGTjQNxSfA7cYIt7JI8BEeTlBTmHkcIgRSSuYFoJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYwgY6I57GCIzCSTLCU69IeGYbe1uenkd/RkjRZU2eI=;
 b=rZOw8dF5PTjzwkKnqkt1rqQF2bl0C+eTUC0L4ZVcb6C0FXb8CR7/cbjt/9dV+c8mFpcv+a9gZuMbKOwU0TxGVxRRME4I6hWkWOqDY5XaARYmgIlwif1HejGFRfnD1PXAht+QD6FUS8b8SASG51M7V+MeR3pWZhwjp6Kf2XJnojjRqrB+msnXXE7SsAmAD70QXRdvQZYKUT8iHy+gLBj5JzNA0jxG8WEIYdfD7OhajZ2+zSo2nyepALrnZ2e/oETrb0zEFt0CDNFHPkuh0rqND5nKgARlEtQ8QsNhpU0zSUtMlMx7x82Ohob0KfQN733he4P4ATxAjQLG8g6DvlLm5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BY5PR12MB4305.namprd12.prod.outlook.com (2603:10b6:a03:213::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 15:19:42 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%8]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 15:19:42 +0000
Date:   Tue, 10 Jan 2023 11:19:41 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Felix Kuehling <felix.kuehling@amd.com>
Cc:     Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, Joerg Roedel <jroedel@suse.de>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Vasant Hegde <vasant.hegde@amd.com>,
        amd-gfx@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Matt Fagnani <matt.fagnani@bell.net>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [regression, bisected, =?utf-8?Q?pci?=
 =?utf-8?Q?=2Fiommu=5D_Bug=C2=A0216865_-_Black_screen_whe?= =?utf-8?Q?n?=
 amdgpu started during 6.2-rc1 boot with AMD IOMMU enabled
Message-ID: <Y72CDYBjXi813/KY@nvidia.com>
References: <5aa0e698-f715-0481-36e5-46505024ebc1@bell.net>
 <aea57c5f-2d20-c589-ad44-a63f1133a3db@linux.intel.com>
 <157c4ca4-370a-5d7e-fe32-c64d934f6979@amd.com>
 <223ee6d6-70ea-1d53-8bc2-2d22201d8dde@bell.net>
 <6fff9d10-f77f-e55a-9020-8a1bd34cf508@amd.com>
 <Y7gs0zYKp/VXACBi@nvidia.com>
 <f96b1cf3-6865-663d-f1cd-466a71519b08@linux.intel.com>
 <Y71nZuF5wQp3eqmn@nvidia.com>
 <2d1b2183-7e93-f8a5-3c74-8f66824bc8f2@amd.com>
 <fa99d96e-6897-850a-8a46-98b03696e0bb@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa99d96e-6897-850a-8a46-98b03696e0bb@amd.com>
X-ClientProxiedBy: MN2PR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:208:c0::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BY5PR12MB4305:EE_
X-MS-Office365-Filtering-Correlation-Id: dac670f9-4bbe-47fb-40cd-08daf31e194a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dsZQmpoWQQC+olEuOsiyEV3abCO4MJEe0+fFOFRcrrkf8S8+EPIL2bjp1c3pkg4Hl2Bn5mogx3dhqwgXHVrlid3H1KqdvijwT//XPIlWoApAojlMxyOwsYXTMg4BQtw4XR1ZOVHqSskYIdKrtlAW+Sq/U2A+9Q2FDOlorl9jdueSZ9QxA+PTZqcv2bNolLzfNQ7nUdx8PXc0e6M9ewMwhjt67d4ewMksJJLEyLZ0JZUxU6inON8Nsv5o8fUlpOoJYDcWjQZBXojoKI6swwDHOOkBc3k+ewUNLkwb53Gd3XZDRjfk92qSQadAO/vhaactCLSoYzBh54lneEKcc3e6JHhtkb+FEppwiHTR8gWLBwKxLplDo6jAonENLyWgw1VpVDnnld+6XuCqHgNfsZ8er3BytXyX3WAlPSNqTo87eBlgueUEpIvPnOKfGpKehMxHJaWuTVXMxa/bM+x3FQD+feCAEM8G944ihdsHdGAsV9CQPsJivyLJqezsT47+MuI0P59T5TsRNpKyJgMzG+WuM9OlUhzhf6XxGFKVO0728iHPCxOiPBV7SLqmIJK+v8ypj2qcXirj/Px8K/hh83fVkpQW2yN7YOgnzKRXquFkanXnnMySISUatYlBs2ch0ty26lmyMPeWVGaFeNK2vV+Xgv7qwvGcPMHmvG3UsVn+d5f0cYWkdOBkL55I8esx1hLQES5hHdbLBDOSOw+kiO1Hn5Ov+x3w12aNVfBQwjkEU8A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(346002)(396003)(366004)(451199015)(6916009)(66476007)(66946007)(66556008)(316002)(4326008)(54906003)(2906002)(5660300002)(8936002)(7416002)(66574015)(41300700001)(36756003)(966005)(83380400001)(478600001)(6486002)(6506007)(2616005)(38100700002)(6512007)(26005)(186003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXdINjhNNHdRZ2V0ZTV3TjduUDQ1bGJJTGdvM2NtVFpzY0k1czhrMU9yZFBw?=
 =?utf-8?B?QTJYS1Yxb2l4SHM4WWZsNW11dnRhK1BRR3Z5eElQRkZ5OWFTNnBzTm9XRkE1?=
 =?utf-8?B?azIrME5YalhjanRNa3pTd3FqQTNKa1lEQXRLSDFxeVJhOTZOa1c2RVFLOVg4?=
 =?utf-8?B?RXM0OVYwT3JlNm5Td2kwZUx2bjgwb2dzbVZiTWZyazc3bHN1azFtbU1CaXo5?=
 =?utf-8?B?ck1QVWdYamJpOFpnVlRTMXlCTXp3TUhnSzdhOXhkaUEzU3VTcU1xQXJpTmd1?=
 =?utf-8?B?dEVWLzFxd292cFVXZHFsYjRlbklWcSszR3pGd29KbDNQaTYyNG1ZQ3BaRWhX?=
 =?utf-8?B?dXIwbUlDQkM5aHM1R2IzZlFZaC83UzlBSXJhd3ljWjhBSjk5eStxbzlBbTA0?=
 =?utf-8?B?RkQ3aG5kamJYRkgwZzZ2UVc1VTBqTnYrNmkzcnR1STFteVJzT0lrVHlYQjRw?=
 =?utf-8?B?NjJ2a3VPRzVJQzdrWlJCZEhlTkpnRTRtZjNsK0grcUZab1lKOTZyT3BYMFA1?=
 =?utf-8?B?VDNqSzFMRjNXVlBENnFoTE9mODVXdVdrQ05yL1NPVkJvWkI2a2NLUFBYcFUw?=
 =?utf-8?B?ak56eGkydnRuOWtsMXd4ZGh4OWxjM08yOG1WZlh2VnZva1ZlWlJwMFAzNlhH?=
 =?utf-8?B?LzBQbDFjbm96UHZrdml4RzFJOTd4WTFpQU9nNWErQzlTSUV2L1AyeitLUDdr?=
 =?utf-8?B?R3JuT3g5YWQ2TVRDK1I4SzJ3Rzg0aTdXMmNTWmR5QkozV2I1amx1c3NLejFS?=
 =?utf-8?B?UzRvK29Sb0lvSml3UHIwbVRxVm9KRHB0Y3BJQnJoblpMTjd6K0R0VU9oR1RE?=
 =?utf-8?B?UGNiZ2NTVmtUcFl3K25ldjkyZlJsQUJJdy9rTVFXRCtQMHh1eVIvdzJXOFQy?=
 =?utf-8?B?Q29EdEFNUVQ0dUxyQVYrV3NCQzRyNFJ6b2x2Wm5Hc3ZjeElENHdKcWg3ZklO?=
 =?utf-8?B?cUo1cEFWclFsWTFoVlhuNFdZM2FwbFpkSGFiOFhhSUpIRWV4Uk5iK0NxUkdP?=
 =?utf-8?B?RTJpSWlBQkQyZDFCUXZjT1NNU2NKbkVCRVI4QWhSaFBBOTUvR0Y4QkQrL0Zp?=
 =?utf-8?B?emFLd0EwdVRjYUJOdGluMkZzMXA1L1ZMbzZuRU9WSlZPc3BMTE0yb0poaHE2?=
 =?utf-8?B?QzNIallFbWdpK2RtNFFFSi9RN0xTOXN2L1U0SEVOWVRYV0N2UWFoQ29nWnE0?=
 =?utf-8?B?RWtNVURCUE9FS0JzK1VVNjVERjRtMVMwaDhFNUtaYXpWb204c3RLbUdBcnJ4?=
 =?utf-8?B?OTlGdXgyMGJuK1F4QWViZlFuNFNiVEVnVzdkazRSVUVKcndYNmNNTzUzSzdm?=
 =?utf-8?B?L3dtQUNhaDBhNkZvTndqTE9wTzgzdzhBdFV0NzVvQ2krTUszb2x5VGRranVN?=
 =?utf-8?B?S2xkZFVSN3dqZ3BtU1NKVEs1SHQwZXYzUytzSVgxTzI0c3Q3WWhXUWN1c2pP?=
 =?utf-8?B?T01UbWVFNGhxcmdiOHhFUEUyZDdLSjNWdm1pUHJnREZydzBsUjVkbHBHRGpQ?=
 =?utf-8?B?UmgxTTJBa0dPTS82UEk2dWdtWFEyR0VOL1o3bGhKeTRSaWhlanRTS0ZVeEFt?=
 =?utf-8?B?ckhqeHlZelloblFWaWw0dGRSR3BsNStCdkhTeHBmaGg3R1Z5eStPaXo2bUNC?=
 =?utf-8?B?MkYxY3JtZzlDL2I2aWJsL1RwbHFLUUZ2bExqMlBjRU52RklSMlQwb3h3YjVV?=
 =?utf-8?B?a0NYaStpem8wTGJhRUhia1V0bU1GQndUemlLR0JIbU5VbXMzb1RRVVVtVEJa?=
 =?utf-8?B?VmdSNStYLzNBN1ZPbkt6TUd0S2pQV3F4eHBreGdFRng5am9QNUZDS2M4Nkhv?=
 =?utf-8?B?SHlVbFBvVDhWU3ZwY0svSFhIWEFVVjlPeiszQlN4a3JhczNiZzhmdiszdGJa?=
 =?utf-8?B?Q0ZQbUJzN1VWUG92L3Zod2RRSkhLNEcwNk5JOVlLU0Q5TDZvb1djdlVsMzJY?=
 =?utf-8?B?TmJFa21jVDdNNFcvdlRGYVBVeWFBZTYyTFZTdFpKWGN4N0VPd3ppb0ZTMUdD?=
 =?utf-8?B?STZGZ3RkaVppM0ZwRUhESUZMc21rRnI1MUNvT1FqTEJSUWgrcVhjS0JGVUs0?=
 =?utf-8?B?Y0tFdmFmS2d5UnFkam04bWpPVm5TdkFBWVBHNDl5T2VzNXdsSHdxYTc3NUN3?=
 =?utf-8?Q?lWfJh3ZbZpMNPzqM85iuEHk1e?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dac670f9-4bbe-47fb-40cd-08daf31e194a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 15:19:42.6774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R5ZPpAgxIf09XZduiH7Jb1BTjVDGj+S7HWohzt7+tZ/GAHutGTxSfC6AUepBKAFk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4305
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 10, 2023 at 10:05:44AM -0500, Felix Kuehling wrote:
> Am 2023-01-10 um 08:45 schrieb Christian König:
> > And I'm like 99% sure that Kabini/Wani should be identical to that.
> 
> Kabini is not supported by KFD. There should be no calls to amd_iommu_...
> functions on Kabini, at least not from kfd_iommu.c. And I'm not aware of any
> other callers in amdgpu.ko.

The backtrace from the system says otherwise..

>> [   13.515710]  amd_iommu_attach_device+0x2e0/0x300
>> [   13.515719]  __iommu_attach_device+0x1b/0x90
>> [   13.515727]  iommu_attach_group+0x65/0xa0
>> [   13.515735]  amd_iommu_init_device+0x16b/0x250 [iommu_v2]
>> [   13.515747]  kfd_iommu_resume+0x4c/0x1a0 [amdgpu]
>> [   13.517094]  kgd2kfd_resume_iommu+0x12/0x30 [amdgpu]
>> [   13.518419]  kgd2kfd_device_init.cold+0x346/0x49a [amdgpu]
>> [   13.519699]  amdgpu_amdkfd_device_init+0x142/0x1d0 [amdgpu]
>> [   13.520877]  amdgpu_device_init.cold+0x19f5/0x1e21 [amdgpu]
>> [   13.522118]  ? _raw_spin_lock_irqsave+0x23/0x50
>> [   13.522126]  amdgpu_driver_load_kms+0x15/0x110 [amdgpu]
>> [   13.523386]  amdgpu_pci_probe+0x161/0x370 [amdgpu]
>> [   13.524516]  local_pci_probe+0x41/0x80
>> [   13.524525]  pci_device_probe+0xb3/0x220
>> [   13.524533]  really_probe+0xde/0x380
>> [   13.524540]  ? pm_runtime_barrier+0x50/0x90
>> [   13.524546]  __driver_probe_device+0x78/0x170
>> [   13.524555]  driver_probe_device+0x1f/0x90
>> [   13.524560]  __driver_attach+0xce/0x1c0
>> [   13.524565]  ? __pfx___driver_attach+0x10/0x10
>> [   13.524570]  bus_for_each_dev+0x73/0xa0
>> [   13.524575]  bus_add_driver+0x1ae/0x200
>> [   13.524580]  driver_register+0x89/0xe0
>> [   13.524586]  ? __pfx_init_module+0x10/0x10 [amdgpu]
>> [   13.525819]  do_one_initcall+0x59/0x230
>> [   13.525828]  do_init_module+0x4a/0x200
>> [   13.525834]  __do_sys_init_module+0x157/0x180
>> [   13.525839]  do_syscall_64+0x5b/0x80
>> [   13.525845]  ? handle_mm_fault+0xff/0x2f0
>> [   13.525850]  ? do_user_addr_fault+0x1ef/0x690
>> [   13.525856]  ? exc_page_fault+0x70/0x170
>> [   13.525860]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
>> [   13.525867] RIP: 0033:0x7fabd66cde4e

https://lore.kernel.org/all/157c4ca4-370a-5d7e-fe32-c64d934f6979@amd.com/

Jason
