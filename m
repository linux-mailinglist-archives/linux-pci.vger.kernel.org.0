Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6C7695F56
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 10:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbjBNJep (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 04:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbjBNJeb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 04:34:31 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE8D768C;
        Tue, 14 Feb 2023 01:34:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3sSNaMi//a7chSkEtH4aMV7XRZmPDH+N146E68W0cfXHLJMbqIC9c5D3MLpSHdh4ZtVTp3uD7rfiNnmYMQQ4+CBmwUzS+mQnlh39C5L1eub10SfJr908tL3F9JVPm4VbL0cDn80ors6KVQoYRThQI9UIB7QBVy11t5AvdqD3rhIq1u2wTK48Qaeb1F+rOwKwLOq+HjW1eBFonpdr8AuFzFJrLOJg/TQHOwBwPViI1rCaRKun2quYm78tozk/Hp05CwGZGYwQoU4GaFvIq7POBSFP9Nwej7sxpiFRf/OPvB5tPEubRWN6TvsrL4Rq//5tTRHc4i/+NTMNHXVUiiE0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=doJqeiau8HQsiKrP/NK6JlTFW2qMYaZjfyXKSAApUHs=;
 b=WpxWk+a+9wsZcnN1UxKu5WoLin5f+PYzSWlMptFv8BnF8QWTeWIgLRIKltNS//w44EkqOs7P1F1dECbJ7ib5V26Mr9BP6g21jClOO5ZmHeK+rAptxGUY5M+mVLrpEN6PHCuRtc+fhsrH8X/Kx02DViTjLEDVPNgw4KUtoBoqMhu6GMuEWEmDHFiEBykfRm+f+C+6g0Fy1tHDoFgitqJuIrJSU4xmj/qASEs2cyeQ3cLfaoyqUGoRO5dOfovdQ3BM2G1kU2grusetGk6a3GFsp71Q/8yJTecVr73A5YDvsHIBHunxIY1FgWVD0FSY0O13OSjPeP03QB6w8liSDHFJ/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=doJqeiau8HQsiKrP/NK6JlTFW2qMYaZjfyXKSAApUHs=;
 b=jozYROCPGO2QyZ7e/rDir6VCkgRWVanfVIWFsJotZZgX4Rqd/CcgjOifhf1kiMkdXqEfpx8i2yXGCoynb40qPyQRhwhsKwWDsMSMyzhfgfYJMcX5XIOlaurremj8POg2K8bK5s5LpObntQLap8kdB1DBS6gj5Q1A5N8uX+tHEeg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by BL0PR12MB4914.namprd12.prod.outlook.com (2603:10b6:208:1c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 09:34:19 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::b9ce:8f83:d620:4151]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::b9ce:8f83:d620:4151%4]) with mapi id 15.20.6086.017; Tue, 14 Feb 2023
 09:34:19 +0000
Message-ID: <c82b057e-014c-5eb1-20c5-9b4522e5c0c2@amd.com>
Date:   Tue, 14 Feb 2023 01:34:17 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] PCI: pciehp: Add support for OS-First Hotplug and
 AER/DPC
Content-Language: en-US
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>, oohall@gmail.com,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Lukas Wunner <lukas@wunner.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Fontenot Nathan <Nathan.Fontenot@amd.com>
References: <20221101000719.36828-1-Smita.KoralahalliChannabasappa@amd.com>
 <20221101000719.36828-2-Smita.KoralahalliChannabasappa@amd.com>
 <cabb5fa2-d1ba-581c-8ccb-79ca8188962a@linux.intel.com>
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <cabb5fa2-d1ba-581c-8ccb-79ca8188962a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0003.namprd10.prod.outlook.com
 (2603:10b6:a03:255::8) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|BL0PR12MB4914:EE_
X-MS-Office365-Filtering-Correlation-Id: 392eecf8-5e0d-4667-bf44-08db0e6ea59b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uoSwvUFlVNDy2RDRZ+SsH6CfTw7fpYKn1B+VucULRCNC8vfwzotpl/kjF5uQ9Dbmb1GM+g9jYMCHUoANJmquHWKPMT/mTlnkY7F6cna9sQd/Rf1POsQ3bAhEgG0rdGDIaL3lRxu73BpB9o8LZ2KAAusk3wR665qiDE6Bkn9p1Z28JYSI4xStiD12jpDPfMx0p5r7cHxkk0sHtsXIpNqQ/rxVW2uBbrt0aeuE6OISQtFgPB+LUHa+v9gAcSY8F0wJ8zdUpogbxcsFgzRe5xuFLfOqxblijsxfITyavf7NLzHpILQZ/OONHA99xF12I1mwUc6BaC/pKiR19MpEhWAM6wtaElogziC6dthmBpe0x69ttZAMz03WUh3Wi/fjLRjYiOEEPIAJnUy72uUIGBjZJt2NhvWBnneHipSBusg3HfkWqcz2dhEDx+g5SSdc7zHBCyMn66IQ5KOPv2BwqGaNKbecAyrCADtA8WmZZnq5GMc6szkLRzHpDzdG5wcOgXjzWmy/p3o5LJ66C/NeWdhgKZQGENSIyuGBdpD2bHtBMdYmuo4dn9IMHWQl/NRFjWDRbnQ3hlgVUK+XssufZdnwVbIh0VVgsO8MBNPfQVJESFrJDfUXQeSME0uxGnr/Zg30+KiYncrpnpa8C+jFOUpxuOUuf56zjcn6YWzjzbHIZAUMgbWwlTd9SL+wVFWl8FllZzDwQFuxAgl4gWcKGCib8lxaAvVnur5Yb7yYXFoybp4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(396003)(346002)(39860400002)(366004)(451199018)(36756003)(2906002)(5660300002)(31696002)(83380400001)(26005)(186003)(2616005)(54906003)(38100700002)(66476007)(4326008)(8676002)(66946007)(66556008)(316002)(8936002)(41300700001)(478600001)(6506007)(6512007)(45080400002)(86362001)(53546011)(6486002)(966005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVplUnF0aGFBa2J6SzZOa3ZsYjlEVHRvMHp2OGdlQW05b1ZHamQ5YW03WW0v?=
 =?utf-8?B?V2tGcVNlUkUxR1RxNmcvYzhDVktJWUpJVDVSRjMwbHFTdzFpS2s0NU9EWGMz?=
 =?utf-8?B?Y01mNHJueHRxYjNhUWZPV0lXV2QvN3NTOXVKWW83ZGhzSi9xTGs3UXFkaC9X?=
 =?utf-8?B?V1RmNlpNUmtwZ0YzMlN3YkxCZndSZXNWdSthbXhvRzVGSy9NMS9GQmpqK3FR?=
 =?utf-8?B?R1VQQ05WVXRDT0Q1NXViSGtiLzUvdDE1RTBHaHZFcUFUNzJObnQ1c1Q4bHZP?=
 =?utf-8?B?UmZHRHp6NFdkdEV0cmRvUWpCa2poTU9hR2paYmRUSEtxSHFaN0Rsc08waTM5?=
 =?utf-8?B?STZwckU0VHNaa3VkRVNIcTd4N1BDMDNpTjhBcTJIM2duVWhQVCtSZzZmaElo?=
 =?utf-8?B?aytaSWRQbjJOVlpDM2pFMnArZ2dZMU5kaGNldG9ZU0l4OEZNVFlmWlg2ZGJ3?=
 =?utf-8?B?K1p2ZE1YOGt0TCsvYVlzMFoxeDEzMzJnNTJCNGNVanJMaFdaWTVkdlAvNDZO?=
 =?utf-8?B?cUU4dUN6WDFNdjRpQ1g0alBmWXo5eTlTMkp0U3VOdDgvUW1NcmdOck9HcG0r?=
 =?utf-8?B?VW9rS1pjSEt4SVRjN25ISkhqRWVmYUdPc0FIRjVydkFZL2V1UmdJRmhUbmhU?=
 =?utf-8?B?T3AzM2NXK3J4bDJ2ektoQVE0QWFOWXdNKzFVZ0xzNnNtMi9hNTdTUDJTZ1Jq?=
 =?utf-8?B?aHlGQUNNRlFDOHB3RnoxR2Y1Z2JWdFVqRE5jUmVHUlFUQ0NUTElxYWR3UEkr?=
 =?utf-8?B?N0kvMlEyWGN0eks2VUhSM1dwa1FGT3pjTjVsYUdDeUh5Y0NpbGtwMXVIZ0dS?=
 =?utf-8?B?bEU2OFlSYldCcnBUK09jdndtekQwalNYeFBEclhvdGJTWDZTVHZFeWdlOU1w?=
 =?utf-8?B?Y1hRdFVNeVVCNXlGWitrdlc3dkV0WU9xUkliUjFxbFV4RlNkNUtySTl3YXNr?=
 =?utf-8?B?ODBRTm1oWG9seVU3akZHVzVGZmEvVDBSd2MzUmUzY0lPQjI2OXMrS3NvWEhY?=
 =?utf-8?B?MSswRzlsaXhjRXczV1d0QVN5NXhKRGVFUjVRWERBVTJDOEY0cEtRT3QxSGNO?=
 =?utf-8?B?Z05JaUx5d05uRUpRMGFKWm50eXFTcnZYSlZKMy9tLytFblF0bUZuWldGeDlq?=
 =?utf-8?B?bGx1SHZ5b3dkVVloWWtBdjdxVGVqZjYxcEJXdUE1UGNiV1BJTktXbnYzemVw?=
 =?utf-8?B?RDlqQk5jTGZEWGZIbm8yQ0YyZ01pU21hQVpXa2J4S3F6b0FRTGI5QWdRcVFQ?=
 =?utf-8?B?d01KV0VIR2hmcFNWakY3NS9GWlBlL1Q2dURtQUJzUHFZWnhZTmtIOThFaEF1?=
 =?utf-8?B?ZXJZS0dYWXlKSjREbVRBZnV0NlA1Y0M1VkxsNlI4YWZEMkdtVjJVTE91K2R2?=
 =?utf-8?B?Y3VpY1FsUlo4QkJGYzdBOXVaUC91bkluK25UTFJtTmRsemd5Y0hzeTZrMitX?=
 =?utf-8?B?dEgxQXhXMEpnVWhaZWtnTnAzcTN4SmkwU0FwaSs5cGgyY09VTlF0cEFuRlhB?=
 =?utf-8?B?cDhyMHZhcGZVMGYvRWQ4VWJqYzBmeW5QQUVpQmlteEtFa0FZMllwcU5TRFdI?=
 =?utf-8?B?eDgrbHE0a1ZSazVtUTZ6Z3haWC9GNlY5OTFzY0dsY203SzRhT2xTNjBTQlRV?=
 =?utf-8?B?Qk5qM3Nqb3p6UkhxTmJud09RV2NPeWg3YVI4aDg4bGc3WHppNmg1YUxNMXlP?=
 =?utf-8?B?Qm4zSW1jS2x1My9kcnlLbExKMkhYdlJ3NndsTlVFNDdVODRZZTFaRVdJYzNT?=
 =?utf-8?B?cWdORzVRQmxybkZ1MWFmbk9PR1preFBtTWVhVE5LWUp2ZWNBNzdGS3preFAx?=
 =?utf-8?B?V0NsQlZVeW1mYkZzc0IyYU15MGlQcXQ2TlFuaXkwaUVKekc0bnRaREFxdHB6?=
 =?utf-8?B?QlNhbmYrT3JON3l3RDBUY3ZGNVJ1Z3UrLzdKbHdaSjRCYVR5UUhpVFoxdjAz?=
 =?utf-8?B?K1VVZDNoMXM2aG93RU1ZZkw1U1RQTXlCM1hCbmtLcUE2YktORXB2aWJsUUt1?=
 =?utf-8?B?RkdQU1lYVFltaUlOMXRrOFJFMUhzWnVEYjNPYUh3dS9Tb2VNbWFqUDBsTmtX?=
 =?utf-8?B?SGR4dDFBUlFYMXlxckY2NjF6NEVScE9SNS9CRE9uTHNueG1KQWNEV2luUi8r?=
 =?utf-8?Q?oFXYBfF869AuaFLL0Ldy4I3E9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 392eecf8-5e0d-4667-bf44-08db0e6ea59b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 09:34:19.2414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +xdN4D4dnr4adMSBg01VLAwhBvqZzwZ9lQYzpLLT3DXOub5ZQ7ECX9EyRTWweY5BnhQbGaG/2mbMMfZe25rdtw==
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

On 11/9/2022 11:12 AM, Sathyanarayanan Kuppuswamy wrote:
> Hi,
>
> On 10/31/22 5:07 PM, Smita Koralahalli wrote:
>> Current systems support Firmware-First model for hot-plug. In this model,
>> firmware holds the responsibilty for executing the HW sequencing actions on
>> an async or surprise add and removal events. Additionally, according to
>> Section 6.7.6 of PCIe Base Specification [1], firmware must also handle
>> the side-effects (DPC/AER events) reported on an async removal and is
>> abstract to the OS.
> I don't see anything about hotplug firmware-first info in the above
> specification reference and I don't think firmware first logic exists for
> hotplug. Are you referring to AER/DPC firmware handling support?

Yes, sorry for the confusion here. Its AER/DPC FW vs OS handling support 
is what the
patch addresses about.
>
>> This model however, poses issues while rolling out updates or fixing bugs
>> as the servers need to be brought down for firmware updates. Hence,
>> introduce support for OS-First hot-plug and AER/DPC. Here, OS is
>> responsible for handling async add and remove along with handling of
>> AER/DPC events which are generated as a side-effect of async remove.
> I think for OS handling we use "native" term. So use it instead of "OS-First".

Will take care.
>
>> The implementation is as follows: On an async remove a DPC is triggered as
>> a side-effect along with an MSI to the OS. Determine it's an async remove
>> by checking for DPC Trigger Status in DPC Status Register and Surprise
>> Down Error Status in AER Uncorrected Error Status to be non-zero. If true,
>> treat the DPC event as a side-effect of async remove, clear the error
>> status registers and continue with hot-plug tear down routines. If not,
>> follow the existing routine to handle AER/DPC errors.
> I am wondering why your recovery fails below? Even if the device is disconnected,
> error report handler will return PCI_ERS_RESULT_NEED_RESET and then attempt to do
> reset using report_slot_reset(). This should work for your case, right?

Not sure, might be because two interrupts are being fired simultaneously 
here (pciehp and dpc).
The device is already brought down by pciehp handler and dpc handler is 
trying to reset the bridge
after the device is brought down?

Thanks,
Smita
>
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
>>
>> [1] PCI Express Base Specification Revision 6.0, Dec 16 2021.
>>      https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fmembers.pcisig.com%2Fwg%2FPCI-SIG%2Fdocument%2F16609&amp;data=05%7C01%7CSmita.KoralahalliChannabasappa%40amd.com%7Cc99c75e249cb44479d5e08dac2866426%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638036179704826384%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=IdqEMcVn5E70P0BW%2F8y6DmwI8ud6HIxWq2uNuwxT2pE%3D&amp;reserved=0
>>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> ---
>>   drivers/pci/pcie/dpc.c | 61 ++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 61 insertions(+)
>>
>> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
>> index f5ffea17c7f8..e422876f51ad 100644
>> --- a/drivers/pci/pcie/dpc.c
>> +++ b/drivers/pci/pcie/dpc.c
>> @@ -293,10 +293,71 @@ void dpc_process_error(struct pci_dev *pdev)
>>   	}
>>   }
>>   
>> +static void pci_clear_surpdn_errors(struct pci_dev *pdev)
>> +{
>> +	u16 reg16;
>> +	u32 reg32;
>> +
>> +	pci_read_config_dword(pdev, pdev->dpc_cap + PCI_EXP_DPC_RP_PIO_STATUS, &reg32);
>> +	pci_write_config_dword(pdev, pdev->dpc_cap + PCI_EXP_DPC_RP_PIO_STATUS, reg32);
>> +
>> +	pci_read_config_word(pdev, PCI_STATUS, &reg16);
>> +	pci_write_config_word(pdev, PCI_STATUS, reg16);
>> +
>> +	pcie_capability_read_word(pdev, PCI_EXP_DEVSTA, &reg16);
>> +	pcie_capability_write_word(pdev, PCI_EXP_DEVSTA, reg16);
>> +}
>> +
>> +static void pciehp_handle_surprise_removal(struct pci_dev *pdev)
>> +{
>> +	if (pdev->dpc_rp_extensions && dpc_wait_rp_inactive(pdev))
>> +		return;
>> +
>> +	/*
>> +	 * According to Section 6.7.6 of the PCIe Base Spec 6.0, since async
>> +	 * removal might be unexpected, errors might be reported as a side
>> +	 * effect of the event and software should handle them as an expected
>> +	 * part of this event.
>> +	 */
>> +	pci_aer_raw_clear_status(pdev);
>> +	pci_clear_surpdn_errors(pdev);
>> +
>> +	/*
>> +	 * According to Section 6.13 and 6.15 of the PCIe Base Spec 6.0,
>> +	 * following a hot-plug event, clear the ARI Forwarding Enable bit
>> +	 * and AtomicOp Requester Enable as its not determined whether the
>> +	 * next device inserted will support these capabilities. AtomicOp
>> +	 * capabilities are not supported on PCI Express to PCI/PCI-X Bridges
>> +	 * and any newly added component may not be an ARI device.
>> +	 */
>> +	pcie_capability_clear_word(pdev, PCI_EXP_DEVCTL2,
>> +				   (PCI_EXP_DEVCTL2_ARI | PCI_EXP_DEVCTL2_ATOMIC_REQ));
>> +
>> +	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_STATUS,
>> +			      PCI_EXP_DPC_STATUS_TRIGGER);
>> +}
>> +
>> +static bool pciehp_is_surprise_removal(struct pci_dev *pdev)
>> +{
>> +	u16 status;
>> +
>> +	pci_read_config_word(pdev, pdev->aer_cap + PCI_ERR_UNCOR_STATUS, &status);
>> +
>> +	if (!(status & PCI_ERR_UNC_SURPDN))
>> +		return false;
>> +
>> +	pciehp_handle_surprise_removal(pdev);
>> +
>> +	return true;
>> +}
>> +
>>   static irqreturn_t dpc_handler(int irq, void *context)
>>   {
>>   	struct pci_dev *pdev = context;
>>   
>> +	if (pciehp_is_surprise_removal(pdev))
>> +		return IRQ_HANDLED;
>> +
>>   	dpc_process_error(pdev);
>>   
>>   	/* We configure DPC so it only triggers on ERR_FATAL */


