Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E904700A3
	for <lists+linux-pci@lfdr.de>; Fri, 10 Dec 2021 13:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240988AbhLJM26 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Dec 2021 07:28:58 -0500
Received: from mail-sn1anam02on2045.outbound.protection.outlook.com ([40.107.96.45]:13494
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237828AbhLJM26 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Dec 2021 07:28:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MkmeGXRIyMhVz6NwRY7dMri7nVdZceVya+eRy2gnUmYa31HH/wP4OkGnWvelXqZPar5PK2eNecUlM+oYOI/54a/WKpm+3RVTsyy3oXTU/PAcZRj8Tja6Bh5KN+QUnjkowiOb0rlG9NOKVkkjKISMxm6er7aNXOSQMiXLVnpWyf8M2wZr0Wig3yWPtb/IGfoM7SSOHnFCfzi53dVvOxstkFJ4ncSJYxONeo6NJDuo8XpRsGUZt8whKoM4hATBGJonsO0/zxEw8cTqwhrf6+QWmEKbTw5WZwt9yzKWOjWBFSQlSKxtyTvD2BNRrHvl5Pwm+QUU2YgGwMzkr1I+iUEvNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fviJw1XPhpbVQsgwiGLToOCuQgN97l7iPbUT1TsXtE=;
 b=KMGRlEowiYgpXkFA2M+Xhw4oJdsQWSgrS6OJeFJDU8rWq9qWdg5Ngni5KVTV1wHQstqF+FYDqcfO2GUWlX9h0rrJmJqloBfVYERgLmfki1KIdF+Z2eYIHHVtizVCkZnU4xwbej6wjKjTuxPT6RyCKmNUpCg37OEUdBtJgj4Oue5OQQVJ0/3F4q2NDC1OZWpao0Inli9YCKLIQcILAnPMSG/tZE8LRur6yKb8nnrF6cPlriIZ/rsZaCAGb00E7Uft44DDj1bRFsgFiz+6p61R5adv35qnEvnPA+Yk69MybVHul8jKsHIqKRCqTm3xvju8fsTTJcCld6JkPz4y8wrN/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fviJw1XPhpbVQsgwiGLToOCuQgN97l7iPbUT1TsXtE=;
 b=fgJinIJGs0nC2YQggQClengAejBOhu4tIYRuHvVTmZz5jXQFreuIzU1Dt0U5fx+ELKIzX9wEAgoRXX2Z1HOSAZ5j6x/s0YtqSlh9Wmka64hfVGgsV2geBIF1mrAyxFhpmYKAQn4ujaSUuYn6SBjT6TvE5X+ywN3d30vI8Svm+E+CdLXK3eVkX1kTxqF1ojMOteW5eNG/AwCR/ZWzdlk34Vnc+CG2PewiNjChbJqZ4o6ML/DBtbA2HRD0rWxNg68Gve/meKGsUeznMKljzFwBLSJHAfyUeZma6+L+FC4u35uQOpzCvx7bFJ38m6xHPk1hG5i7TeXl4gwKvFTg3cb1dQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CO6PR12MB5458.namprd12.prod.outlook.com (2603:10b6:5:35b::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.12; Fri, 10 Dec 2021 12:25:21 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ecac:528f:e36c:39d0]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ecac:528f:e36c:39d0%5]) with mapi id 15.20.4755.022; Fri, 10 Dec 2021
 12:25:21 +0000
Subject: Re: [RFC] PCI/MSI: Warning observed for NVMe with ACPI
To:     Marc Zyngier <maz@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, lorenzo.pieralisi@arm.com,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Vidya Sagar <vidyas@nvidia.com>
References: <47833bde-a89a-988a-6350-6e6ec90048b4@nvidia.com>
 <874k7g1yf2.wl-maz@kernel.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <5b3f3544-b7a5-c338-d53a-c6d7ff3ac8e0@nvidia.com>
Date:   Fri, 10 Dec 2021 12:25:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <874k7g1yf2.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZRAP278CA0010.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::20) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
Received: from [10.26.49.14] (195.110.77.193) by ZRAP278CA0010.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:10::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend Transport; Fri, 10 Dec 2021 12:25:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27260794-d2cf-438f-8e6f-08d9bbd82252
X-MS-TrafficTypeDiagnostic: CO6PR12MB5458:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB5458C58B4D8F69EC502B60D0D9719@CO6PR12MB5458.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bRLTDyjaS1NLKPk0OTCdUsWrKRvgyhHZ7VFLcTDpEUPja0k56CL2dBSZWenu3D4R2rmJ9KvlF1H1E+qFvASAiFREykcXKk9CuwXpPumvq6izFPkFbwWwEdEY1+pa+7hDU++o8ibj+xj6yysUJiMw1YbKwQXbssp1QxDdMG/0ZbruVoQ/F4pMhabRXTcNYrKuzBDYaQbwyBmJm2ptoqI6Xf9F9lFG6yO0dacrIbnyminOdWhXim0zPdMmPZuBB0FSdBA4dIrLq4nYZnJpyx27GgjOPz3gwH7p6HF6AuXfTGscAL7lgW0H7hkBIw8hZEkAbhI9247oXQr6FVp8ZqmLONkHw0oQ6+JJNufXRh/CmCaQ1OfenUKk3MqPamt/4SUSXPd1gabdVJKy3tsyIOa0O+DFk+egJYAYoFVFE3yfSpIAN9Mnp8EMT6Bn/MQqx85i7tpV9mAuYR9q5tvQPeV5wnEnzBkC//k3WQqpfBvh5Kh0Jg0Ef0NFZU6RutEDywnnNWIatW5+HGipEtyvr0aO4UYaUM3eu3Z7rp7SBUB4mHnOwwghOJ7l6Gr1bAuZ6g5f1J2QC3S+p+GIzPBqd/c+RgIh2MF1L6SQpHqbA1AzFFFn8pLKyfOnK+Rdkn/xrgZwcWJTBGyMyMpVyapvAQimcFdYySiIJMomm6KF9Ey53wLNsV7JsD7HCT/f5hKUX61MEFxeUctDh2Q3aFH9KHH79y/ZpNEHKAhF3lH7JlImEtq1lwt9mzYTJUxGR07+jFoN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(53546011)(54906003)(55236004)(31686004)(31696002)(83380400001)(5660300002)(8936002)(6666004)(36756003)(38100700002)(107886003)(26005)(956004)(4326008)(66946007)(508600001)(6916009)(86362001)(2616005)(6486002)(8676002)(316002)(2906002)(66476007)(66556008)(16576012)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzRDa1NNQlZUQm9MVlJyQWhwVSttTExQWitDYnl0TmJ5Q1FJWHRVUWJEZmh2?=
 =?utf-8?B?eGpyb0tCKytlL1g0TmQ2T2puUXc5T3FxODhINFdOYld0cnNadXE0SmpWRmJt?=
 =?utf-8?B?RjJpN0h2UVlYWnI5QkZ6T0VUK3luanFNQk9tUFdDNCtmSGNSN0I0RSs1NTRP?=
 =?utf-8?B?OXBLb0RueGFZdEdjZlBvUUJVQXU0NFRtUzdoWHBoUmdLdklNRnJITXFueFRx?=
 =?utf-8?B?WVh1KzRYRHBuNFBPNytPU3dhKzd4UTZjcWJnSEhNUjFRcHFkVER0ZlNYM3NR?=
 =?utf-8?B?WHlMa2RlaTUrYkhhOG9SS3c1SzNGRlUwT1daaVpCUzdOS2I3TzJUVDRnK3FV?=
 =?utf-8?B?aE1qdHBPbEgzclVxNmd6b2Z4aVNTbVpUTG5RUm03SVJwVVNkNTlpdEt3QXlv?=
 =?utf-8?B?NkZDS3dXclV4M3o0aDY0SnJUdEtRSCtsRDlsSUx0VC83SnA2d0tCUUt5SU5Y?=
 =?utf-8?B?TFN0MWVaRzRVQ3hFdG1Ic0VrcnF0dkNBZlFMdnNOR1poTm1VM3RaMmJjN3RE?=
 =?utf-8?B?Z0Z2ajdZL05mWkFiYnVsNE0wN3JCRW81Qjkwa2I1Vnhlb3Qwdi82OEhKYjZT?=
 =?utf-8?B?TGtabDJxVkZKU3Fwc2U4VU1IYnFiSnBJMmZOQ3dmS3FIdzZvclUreGtoMTZR?=
 =?utf-8?B?Wm5kNFdxS0VBVExsd3dxWEpycWNoSXltVTFldXBybFB3dkpxVlZoRVNpUVI3?=
 =?utf-8?B?U1VlV2YwQUJmL09kQjdFZW44OHh4TiszODZlMVBqUkF3T3NsWU5uN3VIbVJt?=
 =?utf-8?B?dDI1SiswRkFleFlUZEM0NEdQRmUwaDFrS1BwTjk4eEx0cHhRSStsOW95eWh5?=
 =?utf-8?B?Qm9SRFc5QzlOcGthb3JHcnFlRjk5M1luOFlZamZ1ZUFnSFFUQmwzWUNTMHhR?=
 =?utf-8?B?bzNWcmdzb3J1OTJhYjRTdVF0ZTNaQmViTVZSUmFZcktWVTRubmQ5elcxSS9G?=
 =?utf-8?B?ZjQwQ2ZsOHVzRCtHcDNZOGRHa05IdXVadGFOUVJod0I1dXJrVkZLSmh5aVdH?=
 =?utf-8?B?VzBaSGZidEJNdlQ0c1c2MVQzcitsL2Fma3VBU0NNdzBidEtyVSs4MjBCWWdw?=
 =?utf-8?B?ZUpVQ1BKYXBqTFhNTzkzRXJjbklIbW5vTzNqRlNON3lWc2R1TVhpQXJqTitv?=
 =?utf-8?B?QmlMazBJOEI2S2xZSnIwcklidHozQ25BcVlCL2JFTUdRMUJYL2RsUW1VSXdU?=
 =?utf-8?B?TENwVXRJQmhvZFhuQXk1TkJ3VWtlT2xWWkh6UmZYNU1wWCtIS2lRMWNBRTZq?=
 =?utf-8?B?aEZsQ29QVThwZmRQOU9PckFSa3pSMnpMT0tnR2Y0NDAxdTlHNUVldTN4UnNU?=
 =?utf-8?B?N0t3djNMSERBSlZVOUVEMWh4Z0FGS1IyaXc5anlWNWxaMW1Kd0FMVWJ1NG16?=
 =?utf-8?B?c3V3WERSSHoyTHFCamR3MlNrdXdKUHFkeTl4V2pJb1JjTlFmZHBoenREVFlB?=
 =?utf-8?B?YmhHaGFDaG9MckVHWDBZRjVHNWU5VlMrc0lrRzRSdXQyekovWmwyN2cyVXpu?=
 =?utf-8?B?akpTNGQvUXVyRllQYXlnajBPS09LUmtlM20vaXRFcXk2TTFGeFg4azRUbmw0?=
 =?utf-8?B?R0twNGE2blJNSkdhWVNkbDBsa3NSOC9pdHZPUDVUU0RPcVU0MkxaNy93Snc0?=
 =?utf-8?B?R0JtM2I4TXQ1Y0g1WEcwdVMxZVlmNWdheU95Vng2WHlzSVBJK01Fc1ZCYWZU?=
 =?utf-8?B?ekFBREN4a0ptM01iV21KR0RXdHdwYVNKNTBmZW1zSHVkekllUXJ3R3p0VG9V?=
 =?utf-8?B?T3Y3L3JOQmNaamlyLzBJdUsxMlhNd01QaVkrYWxabnBjUmJMQWdXN09qWXph?=
 =?utf-8?B?dGV0aEJCT25FZDVUSGNUaDZxM3o0Q2NGd3RJb0l0WStneERad2tZY1Btc3pO?=
 =?utf-8?B?K3NNT0kxb0V0MDBWVjNiRmIvOEpVYk84bEVJL2ZzM3JlVXRQRDFEUUxCRmF6?=
 =?utf-8?B?dGUzYUZvU1BkT05FNjFXZWdQQ3h3TzVlMkVVRTQrQXlpdlQ1a3FIbXU5UTgv?=
 =?utf-8?B?YXJkTXp2bUs1MHc4dlVmY1NETGxlaDJYanRrMnBjaGlJZTcweHdza0Y1TnMv?=
 =?utf-8?B?MnRmTGJ5UkFsblZZbE5hM2tLOEY5b1Z4N21OYk4vTEgyb1ZwNU50TlZwRXRw?=
 =?utf-8?B?RzdZdGpmTlRlSXA1UFdSZXF6ZGZjNWtHQytNckNLNndkWDNoK29mbDUzWUNx?=
 =?utf-8?Q?ut5pnpNuaPJ27c5wmKSGgIo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27260794-d2cf-438f-8e6f-08d9bbd82252
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 12:25:21.4374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mPQPfq+q2lBbMQuHO9PlLBemmLXUPkjeQX7PBrt7zP9XAQelNWFw85LHe1A5hEcNAAXhQKqiIlbTkiVNz1vTkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5458
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marc,

On 10/12/2021 11:39, Marc Zyngier wrote:

...

>> So the question is, should this be enabled by default for ARM64? I see
>> a lot of other architectures enabling this when PCI_MSI is enabled. So
>> I am wondering if we should be doing something like ...
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 1f212b47a48a..4bbd81bab809 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -202,6 +202,7 @@ config ARM64
>>          select PCI_DOMAINS_GENERIC if PCI
>>          select PCI_ECAM if (ACPI && PCI)
>>          select PCI_SYSCALL if PCI
>> +       select PCI_MSI_ARCH_FALLBACKS if PCI_MSI
>>          select POWER_RESET
>>          select POWER_SUPPLY
>>          select SPARSE_IRQ
> 
> +Thomas, as he's neck-deep in the MSI rework.
> 
> No, this definitely is the wrong solution.
> 
> arm64 doesn't need any arch fallback (I actually went out of my way to
> kill them on this architecture), and requires the individual MSI
> controller drivers to do the right thing by using MSI domains.  Adding
> this config option makes the warning disappear, but the core issue is
> that you have a device that doesn't have a MSI domain associated with
> it.
> 
> So either your device isn't MSI capable (odd), your host bridge
> doesn't make the link with the MSI controller to advertise the MSI
> domain (this should normally be dealt with via IORT), or there is a
> bug of a similar sort somewhere else.
> 
> Getting to the root of this issue would be the right thing to do.


Thanks! I will chat with Sagar about this and see what we are missing.

Jon

-- 
nvpublic
