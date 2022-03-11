Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0B24D68BF
	for <lists+linux-pci@lfdr.de>; Fri, 11 Mar 2022 19:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243182AbiCKSw7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Mar 2022 13:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243689AbiCKSw6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Mar 2022 13:52:58 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEF71C60C9;
        Fri, 11 Mar 2022 10:51:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=POIeZAGFFBvbyCJ7IMPLWy/b7pLzqHGFzu3MPeRkPH/SP3lzH0I0ZXbtdR7nhjSfUxBlhiRw5I7WgWUoRtHbJCbRgRaJ/MgYoWVNgorafd9RE2seUWLdK3++oHqNiPwbDFjr4MpLaCncof317vNml28Lr4sCm1pveIflhiOc8LTqXq77lAk5NU3jg1x67pWIafdWY5Awk4X/PnA0CNvCM8hERVWl7A12p11RwQwGQwdoTFqPX6l7GKmTlXEegmhqtfQMRIqEu7HCFT9uJLB7eG/vJHrACkMFSI3XQYo6KPqH8IdmE2iPxJqTnUqpDMdTpRE9OQxfLDu9JYUfPCJYQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pi2LyeKl+5vn7MCTTOmyHRP3mnili9WnozYcr7nn6Xg=;
 b=kqrKy9vqqLBFom01d9Oz5Mwx+g3pc3ZOGHW+UE4cDm65Jxotn1kgK8kIYKAP6a8nafks/w1v73MEEZQNWVnH7d1iuK5PQVduSQFYnBkdDI/F0Jn956hPZWoSv9xa0NSxf5iK5YUpkp7/jrOnpgKWJHvz1eU5Lq5kznkbzj4tf5cf12TKdfquHhvbe6d9DDAxd5pbhawBLfJd05+J6zMq9nQM9fmsewirarAV/BahqMFJxOryDcsjErMYHKZJfovZj2+7jUZ26Dh34tw1vJvSQVGmR74Lib9q/+1IXissf+PANkBuF2RVmOPAM7Nx4H+3N+yfsbzPcYFBydjTEmLKGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pi2LyeKl+5vn7MCTTOmyHRP3mnili9WnozYcr7nn6Xg=;
 b=tA9Fg93SvInSqbpVdHFSZarqaey9ONbxowZUyDuJn7xs2XpW/yNalZXxVbDYmKXv22yWYplOmXo8iSUbL81wpXXc3e+COG2xPqSm69guO+cih/5iiiGGx2rr5O/f4AWyjvNDmGOVnCGcC8//cEeXffVwdnSSwRwby+dsZO9Ta+8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by MWHPR1201MB2526.namprd12.prod.outlook.com (2603:10b6:300:ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Fri, 11 Mar
 2022 18:51:51 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%5]) with mapi id 15.20.5061.022; Fri, 11 Mar 2022
 18:51:51 +0000
Message-ID: <adcd2748-effb-25da-8021-cc1532308983@amd.com>
Date:   Fri, 11 Mar 2022 12:51:45 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2] PCI: ACPI: Don't blindly trust `HotPlugSupportInD3`
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        linux-pm@vger.kernel.org, Sanju.Mehta@amd.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20220311182305.GA311200@bhelgaas>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20220311182305.GA311200@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0019.namprd05.prod.outlook.com
 (2603:10b6:803:40::32) To BL1PR12MB5157.namprd12.prod.outlook.com
 (2603:10b6:208:308::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21238d7a-0ddd-4bc7-b56d-08da03903460
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2526:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB2526FBA379A8F31F32954AC4E20C9@MWHPR1201MB2526.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HfD6NgH2RzOtgI+1RQnTPylE8OmQmA8d7aZ8+eZbk1DzlZZNbSn8jLfzpQ6AmLu66lxHho8LBHp3kSc529ttD4/VNDnWPRAnAGABkrBCZQWe93GIpDyzIzS09x7BkWZveKiCm+FL63hjhDe7K8yuH7MQAz4p+MymP00rk7Ya0MEsYXJX37b9BHHdivkGXcIHcYszUBke6kPorzF1hVBYyB4PKn50NaHmx7oXWaZrSIxpzjimxyUhUdNKFxeJuG722/BT98+9FQBg57SmzszUjq/DPAN4VAcU3SUdiZZ0T9P8pGEVFazK9/Q4D/anZ6Thqb4P2JAtXAhcCYc+Pb8PeKcn0zAiVVnjtUzr+BJyHsMRgB6ATUazxiwFdPAVZnEcQiQC43UtRHtccIF/Sm6yyLhF5fCkGRQnkjsbOMx502uAKa7yAdpYH2diun4sCbZAfJQuGd5T0U8cfrWrESW3IO1iH69gBNRQpxL8Os/NaL6rTrJQHnkYaUDGzM1sDFibvmKHAMZLNMpKch7NalNS86KXwqHTFfq+OpcwVzizTf3SNpbfnag43A58x06RvpcTCCjDtDXXn7Hc7DdFOotJ0f/YDE0PbUy670PA8XOfAh9G63NMJD3W5qTD7wWrp/dZY1blm3DPFNwQ6n3Mm39jIygTnql7Ls9/pNugWyC9lWutD7hrXMc2CXuzu58Uxu1j02ZMr6FOr4HkVd6skqaLBcB4RUDbjnT814nHFyRTmahcV1OKrFrNmg1uvOguivIq1kh3kyNI5T+JVX3OP/WbmeCCbwMdG3h44AQkmp1ZL9xzPOZLNMyVujx3Rrst6+FDQBB1eb12wh86v4ign5Wz8IcqvaMocrn+eTAe6hRhqEd5OS2QGnWqB+F9tm2nUyES
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(6029001)(4636009)(366004)(66556008)(86362001)(6666004)(66946007)(66476007)(186003)(6506007)(6512007)(54906003)(31696002)(4326008)(83380400001)(45080400002)(966005)(508600001)(53546011)(6486002)(31686004)(8676002)(38100700002)(6916009)(316002)(2906002)(19627235002)(2616005)(36756003)(8936002)(5660300002)(81973001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFVseG8wbFRNaExtOXlOMVdVdDhWSjEzVUphM2NueGJ2K3Jza0ZLNitsOHN3?=
 =?utf-8?B?bmdxNFB5KzkxbWtsVXlHc01LS0krSHhqa3RYZCtYQjN5S0ZEVkFoRUJHYmpU?=
 =?utf-8?B?aG5CYmxhWlhIN281VUFjQ29YLzRLR0tuWFVLS1lJa2p5aVd6eCtBbDNoSklv?=
 =?utf-8?B?VUhsckNRUWZENnJNYkMwL1NWcnptQnZnVFAwelE2eGFtb00rcGlkamI0WlA2?=
 =?utf-8?B?L1ZCbTBYdGo5TUFTcWgwc1RpVzZwb3FUQlVQbTFxTXN6dHN6d2Z1QnVIK2RP?=
 =?utf-8?B?VnNjL1JDaHBrNWxKbkd5a1NTNTBSb1M4MytZWlprcEoyeTIzOWdpQUtjN0lq?=
 =?utf-8?B?Sm9ZNHNFamR0OGx2ckE2NXVEQlpXTURINzdmblFUMDQzQ0o1MHNKNVEzRjBs?=
 =?utf-8?B?VGFVVXVUeFhQcXp5aWkvdHZkL0ZzNEFPOWhkcStCYitBVklOOGVlUzEyNzBY?=
 =?utf-8?B?bjVFU1JpVTJ4aFlDSnUxR3N4QUV1NFpnMGZ5c2RkdjhuU0RZditCdTZXamlV?=
 =?utf-8?B?TElsOHNMN0tLWnY3WlRRalBDVGhqV0g3V3VpeXpidUFDNFJzOUVnZkhST2xw?=
 =?utf-8?B?akJja2cyWWFmU0pHZlVsMjliU2prRGt6cS84RVpxanpCeWd1ZURjaGN6RzFi?=
 =?utf-8?B?TEFYbElFdG5TUENDaHlWWEt5bFBBZ3dhWHpLTkFJaFhwTHRYaXpiR25LUEJD?=
 =?utf-8?B?aFZ1aXcvZlFCdExoNkdqUk15U3hBMEphMXJOV1FaSTNCSXZBNHRuc3pYcXFI?=
 =?utf-8?B?YXNRNUZoazU4YklkWGJ4WXM4Z3JLbnREaHJPdVVMRzc1N2ZGNkJXZENLeVVK?=
 =?utf-8?B?VzdteGYxakc3eVh5cTJCY0tQMURKaVY4QnpsT2NKckpWaTY4Snh0TGhrSDVy?=
 =?utf-8?B?cFNtQTFleXE5MmpNY3VZeUUzNFJQblgybFJlM0Q0QmtLN3JNTzBZdjhFUFVO?=
 =?utf-8?B?TFptR3REOXg2NHBldWExeEMwMjFKeDh2NTJUY0x6UWZEbFZSeG9NdUtnVnN1?=
 =?utf-8?B?UEFqNjZmSERQSFhOOGZnZUJwRDZWTHUwU0cycDc2dFJmVXlwWVFqN2ZEZ2M4?=
 =?utf-8?B?dlloaGZTS2pxeExOdTJTNFNiVU1CRFM3Z3JLNTU5VmpYMEZDTm9vTHJKcHlR?=
 =?utf-8?B?WUY5VnhoNWMyOUtGT1VoVXdieVk4WmxsU0lzT0todjVMUTFxMlk2ZlUyeEtp?=
 =?utf-8?B?eHZFSVpXc0FSRy92NXNFUktYUllWL0lITDIwTjBPR1hiVm1ZbEt1UkpOM0Rq?=
 =?utf-8?B?Q0VUR0FOeHdKMTBEVU9hakE1TlBCNlZkenZlRm90dlhlY1BYR2k1ZEVxUnFE?=
 =?utf-8?B?WDRhQk0zY2RheHFFK1ZSNlVpMzhMWnZacnE1S0o0UVh0U3BGa21idjBBb25y?=
 =?utf-8?B?dTZnK3l1d2hTb2VNMzdJUVdTcjZxRnVjNytWajZQRzYxcXBnVjNvN1V1U0M5?=
 =?utf-8?B?TnR1eXMvMmV3MXpVYU9scWxrQ0kwRmVzcVNrckc2UHVtRys5K1Z2eEFMRWd0?=
 =?utf-8?B?VG1XVUdNNWRxdXo5UzZpeGlVS0VKOXUySUVoSUlubUMzMDBBZ0U0OVdvbllp?=
 =?utf-8?B?a2MvMEVZQTBmS3FxdnVsRVAyNlljM0ozUkI0NURPMlpvaDlZdWN3dTlHUmVL?=
 =?utf-8?B?ZitibnIvTC9TcEE5Q3ZWWlpBSXNISVBXMlV0M3VBTHE5UFNBUmtxenZWY2xm?=
 =?utf-8?B?bitXYnNOZWZNSURMekl3NEhXVzRONzFCeXFNRUFuUkxuZ3Q1ZVBGL29yUk11?=
 =?utf-8?B?SVJuemxrTDc1VFFIakZFOXlMa29TVm1wVnBPbS9ZVGlUOHBMN002R05udC84?=
 =?utf-8?B?SjBRM2ZGVjhGVUNzYUNIdXJPT3RmUnhKdjluOUR4dDVhM0hHYXhLQTF3RHdq?=
 =?utf-8?B?ZDRlbUk4TlVLOGFHZ2c1QmdIR2hub0hGVERlMUFaYS9TUE42MUVYTThmUXdo?=
 =?utf-8?B?b2ZLQWc4SjZJK05ya2JKTjFjcURqV0hxRWZkVlEraU01SkdMVG1oL2RMaXRi?=
 =?utf-8?B?QXAwSFZ4UG55M2o4MmlnUm0zTmsra05iUmt6ejkrU3hlOFFoTjhwKzBqSVRw?=
 =?utf-8?B?S0tHRllqWmdvbVFUdmIxNTgrZld3S2pic01SN3Z5ZHN6RVdxMGlOUjZTcVUw?=
 =?utf-8?B?ZUkvZkdQelQ5aGJucTFwU1grOGVCVkcyajFDb0IrdFBqdEZkdXZrWGhGYTl4?=
 =?utf-8?B?ZUVvNFFZMld4S2xRMzQ2d1hNL240bTNhS3RjNE84Um10Q0M0a2FadklIcVRB?=
 =?utf-8?Q?ThBYmswyJP6zBpyet/CYpGQk/HyOwakIMVX9on6rbY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21238d7a-0ddd-4bc7-b56d-08da03903460
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 18:51:51.7752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rgvEXxxEJNnq2/oxwX1qYOKpGMV1VKV8HYZbWErAj6UYCrbJ3ZgvIyBRHCozWj1Y47N8gFbhUr9+lauLKQzXtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2526
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Bjorn,

On 3/11/2022 12:23, Bjorn Helgaas wrote:
> The subject convention in drivers/pci would be "PCI/ACPI:"
> 
> But more importantly, please turn the subject from a non-specific
> negative ("Don't blindly trust") into a more specific *positive*,
> e.g.,
> 
>    PCI/ACPI: Assume HotPlugSupportInD3 only if device can wake from D3
> 
> On Thu, Mar 10, 2022 at 11:58:32AM -0600, Mario Limonciello wrote:
>> The `_DSD` `HotPlugSupportInD3` is supposed to indicate the ability for a
>> bridge to be able to wakeup from D3.
> 
> Thanks for the Microsoft URL.  To make this commit log self-contained
> and guard against the link becoming stale, can you quote the relevant
> text here, since it's not long:
> 
>    This ACPI object [HotPlugSupportInD3] enables the operating system
>    to identify and power manage PCIe Root Ports that are capable of
>    handling hot plug events while in D3 state.
> 
>> This however is static information in the ACPI table at BIOS compilation
>> time and on some platforms it's possible to configure the firmware at boot
>> up such that `_S0W` will not return "0" indicating the inability to wake
>> up the device from D3.
> 
> Please include the spec reference (ACPI v6.4, sec 7.3.20) in case the
> URL below becomes stale, and again, the relevant text is barely longer
> than the URL and could be included:
> 
>    7.3.20 _S0W (S0 Device Wake State)
> 
>    This object evaluates to an integer that conveys to OSPM the deepest
>    D-state supported by this device in the S0 system sleeping state
>    where the device can wake itself.
> 
> I guess the argument is that we can put a Root Port into D3 only if
> _S0W indicates that it can wake from D3 *and* it has the
> HotPlugSupportInD3 property?
> 
> I'm naive about ACPI sleep/wake, but that does sound plausible.

Yes, thanks I will clarify the commit message to your suggestions in v3.

> 
> But the patch doesn't say anything about _S0W, so we need to somehow
> connect the dots there.

Yes, per Rafael's suggestions I will be adding a comment about this 
situation inline with the code for v3.

> 
>> To fix these situations explicitly check that the ACPI device has a GPE
>> allowing the device to generate wakeup signals handled by the platform
>> in `acpi_pci_bridge_d3`.
> 
> acpi_pci_bridge_d3()
> 
> Would be good to say what "these situations" are.  I guess this fixes
> a bug, so let's outline what that bug is, what the symptoms are, who
> reported and tested it, etc.
> 
>> This changes aligns the handling of the situation the same as Windows 10
>> and Windows 11 both do as well.
> 
> s/changes/change/
> 
> Sentence also needs a little polishing: "aligns ... both do as well"
> doesn't quite flow.

OK
> 
> Does this make things work like Windows 10/11 from a user's point of
> view, or have you somehow confirmed that Windows actually checks _S0W
> and HotPlugSupportInD3 in the same way?

We checked with BIOS debug logs and Windows does evaluate _S0W during 
startup and specifically modifying _S0W return value alone will cause 
Windows to not let the port into D3.

> 
>> Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fuefi.org%2Fhtmlspecs%2FACPI_Spec_6_4_html%2F07_Power_and_Performance_Mgmt%2Fdevice-power-management-objects.html%3Fhighlight%3Ds0w%23s0w-s0-device-wake-state&amp;data=04%7C01%7Cmario.limonciello%40amd.com%7C94e638619b754591688b08da038c323e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637826197941955260%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=sKq3X70W1mmKprMKD6oueDQVET2OMNosWmSddjS1Cho%3D&amp;reserved=0
>> Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdocs.microsoft.com%2Fen-us%2Fwindows-hardware%2Fdrivers%2Fpci%2Fdsd-for-pcie-root-ports%23identifying-pcie-root-ports-supporting-hot-plug-in-d3&amp;data=04%7C01%7Cmario.limonciello%40amd.com%7C94e638619b754591688b08da038c323e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637826197941955260%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=oKvNC3MOVNehzpR0O7Jg2bTfJeYHu5GX2v%2FQ%2B0dvKlg%3D&amp;reserved=0
>> Fixes: 26ad34d510a87 ("PCI / ACPI: Whitelist D3 for more PCIe hotplug ports")
>> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v1->v2:
>>   * Add Mika's tag
>>   * Update commit message for Rafael's suggestions
>>   drivers/pci/pci-acpi.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>> index a42dbf448860..9f8f55ed09d9 100644
>> --- a/drivers/pci/pci-acpi.c
>> +++ b/drivers/pci/pci-acpi.c
>> @@ -999,6 +999,9 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
>>   	if (!adev)
>>   		return false;
>>   
>> +	if (!adev->wakeup.flags.valid)
>> +		return false;
>> +
>>   	if (acpi_dev_get_property(adev, "HotPlugSupportInD3",
>>   				   ACPI_TYPE_INTEGER, &obj) < 0)
>>   		return false;
>> -- 
>> 2.34.1
>>

