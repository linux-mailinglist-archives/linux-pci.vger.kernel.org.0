Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282C2695F3E
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 10:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjBNJbx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 04:31:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjBNJbw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 04:31:52 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9E23AB8;
        Tue, 14 Feb 2023 01:31:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0dk/Rv7Im/TpTkW7WtYRxq8dV2SBBRrn9SH2Uu76Zk/1OCHP0RZUyPbZpc7SR0iWnLyiiB07HkDMZtBoA3/PnXuZvDEC8DTD4018ERhVw3OSGIRiyoa8xAlxvebqqgGpkyrcj183irni83VdgVYlhDyzrh+8Mtw0Hh8LCgXukdvsUx7gTizCZvXsfc8zHP+Kx0td3niF6Hjq2LqeGBCdAglwTvxIrv1xgfhn5JNciy5Mlkgj7z0QIQdyx7YGKpmRfaS/lDqINF4Qx7ZUhhF1LFC6NF3YazzcKP1zSYfXVhm7GHJfT9NO/cBH+CVdsAT+662rSCSW0aQvk2s5m2yvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2VwDdlvpVII/andloSIxr4Nv8KO1ad9o8XKvajm1P3s=;
 b=Xg6p5CKZbtfT5VslqBAxzULhOt1IFfsbKLuCb9yVAzZSi/JP2Df907YjEYwyjKlrEm2NV48+K53mqeU0/h09xlzexSwWYS9iJYpObyJFKycWTpHibXT9YYn9nMAHtETLzBpZHOn0w8Bpajbh0h//vsajm/AaeuA/NKcGnZnByig8wktZyxXiv74mNoFSlbIsjucUE4dweX3aF1EiRQaHl4GtKVPBtH0dhxXYuzwmKB6LxSSGUvFisPM3POCrotiPRl1E1vqSMgbFcTgUhWrNvdwhIOgYXlQg+Tgxb8iFe6ueBmWYldoAa3Llrhi/1m1jbuLtI4d9H1zKThrnlF/ttA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2VwDdlvpVII/andloSIxr4Nv8KO1ad9o8XKvajm1P3s=;
 b=xN0S/GsfF+Kq+1sFaEmQ9bvKf0BqwEsrz3CFIEOIvVPNtNAc8ibZKrZc0npQIOuIJWZ3c9fvEEBzxx1X3fiP/ukUQwbwzhctiAFW+QdcC36jDmW8jjiSYcraaiixZm07LAukHgzMTUwYibIvxtLtl6hr7ARecnnePio+6UlZii0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by BL0PR12MB4914.namprd12.prod.outlook.com (2603:10b6:208:1c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 09:31:42 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::b9ce:8f83:d620:4151]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::b9ce:8f83:d620:4151%4]) with mapi id 15.20.6086.017; Tue, 14 Feb 2023
 09:31:42 +0000
Message-ID: <600bc678-40ae-5af9-cd65-38dfcf7a4ae8@amd.com>
Date:   Tue, 14 Feb 2023 01:31:39 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] PCI: pciehp: Add support for OS-First Hotplug and
 AER/DPC
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, oohall@gmail.com,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Lukas Wunner <lukas@wunner.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Fontenot Nathan <Nathan.Fontenot@amd.com>
References: <20221102232103.GA7126@bhelgaas>
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <20221102232103.GA7126@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::33) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|BL0PR12MB4914:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ee3bf7e-0ee7-4588-f50d-08db0e6e47e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UGHXGm4bBdbhtffkSHy7KEXFXpSD5Zxv5Dm1H/LMIgGmV4kj1MPaxlL36grAKUvKLZNo27oPHW8VnS3V5mWMtAXpm0czkd24rgtn7BCPVdgdcvbyND+Eod7j0fZelWI2YQUKwXW6CmonPQZ2OiFv3O2SyYTfyRN/tcNbOzR75YR+k/wn1ckgM/H0TllRrDcmUVxhhv7oTrarY5Y6Zhj6/PBLG/lfark+bCaK7QAblpZPWqlbNSbzodZwNUvnN0jClLD6l1Ihu8Fr5b+D3po3XbrSwTfOkupxuvZMZ0Irn/tfJmb+qXJ7k0liwnn5Vlrp/cdD31tdKGtYL/O7ZtjN87BQboTQWOHKVCZWzujlCzp7GKiysAN3KGJpFZj/2sEUpfrpvw5DQpGeYyxnd0O6lc2TQpbm2EHiCiSkc5JXdrzOtTodQ9YCBs19RcFfFDQZ6oPblMayARRepR9JZfEM3PL7C45mirUfTPOyOfCMCGt4W8D0HkKByeLRI6Ek93Jjhr/470M/caDWMfgKh1xlmYlsZ7c1DK9BZritHAFxz6rpIGbw8l7oKYV/IG/h2BCKecgM5QmHV1hfsb5wPcHpiuaD0Lq4yXzYiqTOMo0K2NvFhYedTF2asxTt8iIwzloIHG1FZlzK75YTTW9ZGG6PWzXg1UsRmvruCfbJvbV5tV4zIVT95zbzru7G46to57dDzISPz9FxWg6OsNIQMQfgmRJ+/ktg0q8/csEXap8hAnk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(396003)(346002)(39860400002)(366004)(451199018)(36756003)(2906002)(5660300002)(31696002)(83380400001)(26005)(186003)(2616005)(54906003)(38100700002)(66476007)(4326008)(8676002)(6916009)(66946007)(66556008)(316002)(8936002)(41300700001)(478600001)(6666004)(6506007)(6512007)(86362001)(53546011)(6486002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWJDbCtjS3pqb1dVNGJSS3p6VFJWMmROZTA4N1NBWmdEeTBEZ2V4RlZENDRi?=
 =?utf-8?B?OUIxdTJ5ckpCNVZyc24rbGhUUkV5RFJUK1o0ZkVoaXRJaGtnMFlqUjFjSnFV?=
 =?utf-8?B?Zi9PYWJXTkZtN3hNZmNlS2pKQXc2Sk9iTTJ1QnY2MWFkRmhpOGtrSmhvRzVm?=
 =?utf-8?B?cWxVSWljclFSQzJ6YUpMTWVUcWRQNjQzcTR0V1Q0cFh1Y0VuNkV3VU1lOVRr?=
 =?utf-8?B?Q0kvbkxKUi96eWRGdVVRZTJ3MUJNS0hXT2tSL3EyUEtMNkxjcVZBb0tBa3I1?=
 =?utf-8?B?UW5MYUgxRGtCd0NiN3I1Ti96NUoyZUx6c1JqZllHTS9xZVV3dkFVb08xc2Nw?=
 =?utf-8?B?b1J6UHZYS2N2OGFoT1luTDFUcjFvSEJZWXZNbWwwOEtMNjJKRnVhSVJ5YzRF?=
 =?utf-8?B?UnYzWnBGZVJ6WW5xMHhuaGJJdldWTG1mekkvY2FVOXh6OUIrbThHTnZmOHJO?=
 =?utf-8?B?VHZwamFRUzlWL0F6cWdxTm1aeVlSL0krZzNrbGc5aDJyZmRDUm96TmhBNDBV?=
 =?utf-8?B?YkF1dkFpcHV3N0N3K3VOUWZlQUhjNHdlakl5bndUSjlINmdVVURLcXZvZXdE?=
 =?utf-8?B?SE1FVUFBMVlIOXQwUU01eHBKQWJ1Z1JKWG1pMExPSm9CdEtzYjloM1RoS1hS?=
 =?utf-8?B?ZlcvcGRWOWFrWE42Y1hhMk1HRmRCb3dsTjdHVzBuQnBlaldDV0RjZEpqYnkx?=
 =?utf-8?B?bjFxY1NwaXRER1BDZUlkc2hKMFNXSnVCcEpTSjN6OTNmTjd4dlNWdE9nZG42?=
 =?utf-8?B?RHhLQ2hjc3BhdEZJMGpuejV1ci9TNHVZZ3ZySmJrNk9ma05yUDNiTTd2T1ZL?=
 =?utf-8?B?bkFKa0N5QTAxV1Ewc1dhVkVvZEEvc0hCaFpmVGdBMFh4VU9YOGk3YklNbWdk?=
 =?utf-8?B?cnRyNDRHUkxOejRqdmhIVlVGQVYvRkpCd2JZSFpJUUxCK2c5ZjJZdmNUVHJG?=
 =?utf-8?B?T1ljWXdUSWYwQ2pVaUJNaFVDcVZPdHlNV2hVMTBVN3JDaTlWbW85TjdIdk1V?=
 =?utf-8?B?Nko3ZVRtLy9FUndXRlAxNk9zek1VSXFvV3ljZWRnc0hCQ0tHUDcvMjdOaFVE?=
 =?utf-8?B?eXplSDVScy9Jb05PbHJMQjliamszV1ZNR2lwQUlwZDMvS3ZHdnRiM1FvSjBR?=
 =?utf-8?B?MGFVREtBTXVPNmVEc3cwaURSRE5JMHIzcmk5MTZVcFg1bnozMkx5VUw2U1FF?=
 =?utf-8?B?S2lvVE12UnZQK3AvdUx1VUN5aTM2T3RXY1FYNEdTejFOMkFDMXBOa0NaaHVm?=
 =?utf-8?B?ZUhBOE5uNXFUaVc0Zi9DakRFZDZncUhkWGRiVXFRZ0ZEVUV5SFdZNzN1QXlK?=
 =?utf-8?B?RzJYcW5pU3gxTEY5TUdaMlo4dnRrTHdsampCNzdOekRraE0zT01xaS9uZVM2?=
 =?utf-8?B?MFlhVWRXZHZ0MXpPcnpUUlNQUTl2U09SaWd4WEZMN1EwK0NGdXNxVFZJdVkr?=
 =?utf-8?B?MVMzL3NuSzZ0OU5najdJenpGbWRLSWVXTzNOUjJUY05VbXJUM3lkTFAweVNh?=
 =?utf-8?B?KzBTN2FCQ0I0OXBCTUdXSVhxaUZDT1RsdTBncHVINmltSkRvZDVicHZGb3Zw?=
 =?utf-8?B?ZmFKcC9CQ2xobkdNVXJFTnVEUDZxUUlhaHd5eU1jSE1iVEpNY0NZM25pcTY4?=
 =?utf-8?B?WGdpZm9lRUxmcFhwM3JqbHBxRm1OVkVQNzBONkVWMnVJaEpucDNwRkFRcktD?=
 =?utf-8?B?YWFWY3RDSTBNcUJvK1VHc3lQdmRGRVdha2tRMnRTL2FZZFB3dFBRUWE5SHQz?=
 =?utf-8?B?cFVic1VwZ0xIUlRTRFNLckhqcVBXTjkzME1lYmtBUHkyNVF0YmR3VitqSnlh?=
 =?utf-8?B?dTBPa3NBVncrbi92aUxpNytrdm5YWFBIRWxXWVpmNVFqS3lQZ2JMNGptSDVh?=
 =?utf-8?B?YlFZaTlvWFdOeU1qYW52VWlPT1RXUGM4YmM3d245OWhrcDdITWVyQ3dwbHFx?=
 =?utf-8?B?elZzQTFxVTM5eEV0MmFNdTNxSkl3dnZNVkQrY2R0QUJITmhqRTRxQkNhVjlx?=
 =?utf-8?B?V3g0OFJDOTI0MXB4R0Q2L3hBdFdUalRFQXhXOFdhQSsrRkptYktjaTJCNlJS?=
 =?utf-8?B?T2t1YUFuUmFvL0s4Z2p3L0lOOEJJTnMzWFZoelk3UzltbWxtWWRRb2pUdUZl?=
 =?utf-8?Q?yZBHs2HixbBEeCahK2A4saM9v?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ee3bf7e-0ee7-4588-f50d-08db0e6e47e9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 09:31:42.0638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OPLLmtSEo7yAROu+Bp88TD4KeYpqR4sfE7df2xjE26nR5pQsbn6UvFe+5J6OE6vd9hWo5EOgqspvFWxFopnGrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4914
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Apologies for the delay in reply. Please let me know if I should resend 
the patch.
Responses inline.

On 11/2/2022 4:21 PM, Bjorn Helgaas wrote:
> On Tue, Nov 01, 2022 at 12:07:18AM +0000, Smita Koralahalli wrote:
>> Current systems support Firmware-First model for hot-plug. In this model,
> I'm familiar with "firmware first" in the context of ACPI APEI.
>
> Is there more "firmware first" language in the spec related to
> hotplug?  Or is this just the ACPI hotplug implemented by acpiphp?  Or
> is there something in the PCIe spec that talks about some firmware
> interfaces needed in pciehp?  If so, please cite the specific
> sections.  I see you cite PCIe r6.0, sec 6.7.6, below, but I don't see
> the firmware mention there.

Firmware-first refers to AER/DPC firmware handling support. When FW is 
in full
control of AER/DPC.. The term "FW-First Hotplug/OS-First Hotplug" might look
confusing here as the terms don't exist in Spec. Will rephrase them in 
next revisions.

In simple words, this patch follows the sequencing actions of a hot 
remove when
DPC is enabled and HPS is suppressed and fixes the side effects of 
remove when
OS is in full control of AER/DPC.

Other relevant reference is in PCI Firmware Specification, Revision 3.3, 
"4.6.12.
_DSM for Downstream Port Containment and Hot-Plug Surprise Control", The
PCIe spec allows for this flow: “When the operating system controls DPC, 
this
section describes how the operating system can request the firmware to 
suppress
Hot-Plug Surprise for a given DPC capable root port or a switch port.."
.. The operating system must evaluate this _DSM function when enabling or
disabling DPC regardless of whether the operating system or system firmware
owns DPC. If the operating system owns DPC then evaluating this _DSM 
function
lets the system firmware know when the operating system is ready to 
handle DPC
events and gives the system firmware an opportunity to clear the 
Hot-Plug Surprise
bit, if applicable.

>
>> firmware holds the responsibilty for executing the HW sequencing actions on
>> an async or surprise add and removal events. Additionally, according to
>> Section 6.7.6 of PCIe Base Specification [1], firmware must also handle
>> the side-effects (DPC/AER events) reported on an async removal and is
>> abstract to the OS.
>>
>> This model however, poses issues while rolling out updates or fixing bugs
>> as the servers need to be brought down for firmware updates. Hence,
>> introduce support for OS-First hot-plug and AER/DPC. Here, OS is
>> responsible for handling async add and remove along with handling of
>> AER/DPC events which are generated as a side-effect of async remove.
>>
>> The implementation is as follows: On an async remove a DPC is triggered as
>> a side-effect along with an MSI to the OS. Determine it's an async remove
>> by checking for DPC Trigger Status in DPC Status Register and Surprise
>> Down Error Status in AER Uncorrected Error Status to be non-zero. If true,
>> treat the DPC event as a side-effect of async remove, clear the error
>> status registers and continue with hot-plug tear down routines. If not,
>> follow the existing routine to handle AER/DPC errors.
>>
>> Dmesg before:
>>
>> pcieport 0000:00:01.4: DPC: containment event, status:0x1f01 source:0x0000
>> pcieport 0000:00:01.4: DPC: unmasked uncorrectable error detected
>> pcieport 0000:00:01.4: PCIe Bus Error: severity=Uncorrected (Fatal), type=Transaction Layer, (Receiver ID)
>> pcieport 0000:00:01.4:   device [1022:14ab] error status/mask=00000020/04004000
>> pcieport 0000:00:01.4:    [ 5] SDES (First)
>> nvme nvme2: frozen state error detected, reset controller
>> pcieport 0000:00:01.4: DPC: Data Link Layer Link Active not set in 1000 msec
>> pcieport 0000:00:01.4: AER: subordinate device reset failed
>> pcieport 0000:00:01.4: AER: device recovery failed
>> pcieport 0000:00:01.4: pciehp: Slot(16): Link Down
>> nvme2n1: detected capacity change from 1953525168 to 0
>> pci 0000:04:00.0: Removing from iommu group 49
>>
>> Dmesg after:
>>
>> pcieport 0000:00:01.4: pciehp: Slot(16): Link Down
>> nvme1n1: detected capacity change from 1953525168 to 0
>> pci 0000:04:00.0: Removing from iommu group 37
>> pcieport 0000:00:01.4: pciehp: Slot(16): Card present
>> pci 0000:04:00.0: [8086:0a54] type 00 class 0x010802
>> pci 0000:04:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
>> pci 0000:04:00.0: Max Payload Size set to 512 (was 128, max 512)
>> pci 0000:04:00.0: enabling Extended Tags
>> pci 0000:04:00.0: Adding to iommu group 37
>> pci 0000:04:00.0: BAR 0: assigned [mem 0xf2400000-0xf2403fff 64bit]
>> pcieport 0000:00:01.4: PCI bridge to [bus 04]
>> pcieport 0000:00:01.4:   bridge window [io 0x1000-0x1fff]
>> pcieport 0000:00:01.4:   bridge window [mem 0xf2400000-0xf24fffff]
>> pcieport 0000:00:01.4:   bridge window [mem 0x20080800000-0x200809fffff 64bit pref]
>> nvme nvme1: pci function 0000:04:00.0
>> nvme 0000:04:00.0: enabling device (0000 -> 0002)
>> nvme nvme1: 128/0/0 default/read/poll queues
> Remove any lines that are not specifically relevant, e.g., I'm not
> sure whether the BARs, iommu, MPS, extended tags info is essential.
>
> Please indent the quoted material two spaces so it doesn't look like
> the narrative text.
>
> Thanks for working on this!
>
> Bjorn

Will do in v2. Thanks for reviewing this.

Smita


