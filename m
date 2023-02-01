Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C6C685ECE
	for <lists+linux-pci@lfdr.de>; Wed,  1 Feb 2023 06:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjBAFSW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Feb 2023 00:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjBAFSV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Feb 2023 00:18:21 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149D126874;
        Tue, 31 Jan 2023 21:18:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YIFrC1AAg3HslxYim3XhdPwBqxmRGG/SVNqIBAB9x4CI7bY8LQ36d76PJ+tbahz/sQtTAlD/1zmuOJ9EOO0oUxpvBXeklkiQfCEYfgbZxANaaaYyLp5g25sT8zfZ0r5zl2WPWxOt2nDPCRLdM0YOhLLL/lt9Z+WA+i0H0+evmnqKz0tAd427wrAGlgq/9Vt3PO/irf9q6l3nMutvw2EasBp8dr7Wsvh54iTdn5cef2l/YzV8/IeBxd3rPpM+1ZF+QFxxGbsLYuWWK/kTGoH5ztxkxMD43cz0ggsygAfWpq0bLqVdSk8hSJ+/tJ++Yj+AdfRVpbcmQiBrxPiyy+P5mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHri8eZYyvxP7FogrSX6Os1eQ2LVvphPiDULW+K44FM=;
 b=UrP6dwOqpkGWtyOrbJZ+kbhaMEGocTFvju1PcyaBToXu011wkLicRM0RQSVNEHvhxaYowTAeEuZt3wnr7vbhBOFSf4VM6nKWs6etZ1tfDLtwROLZHo/WBIpdswFKoF67MCY73dh/OOeJm/U5M/W/xeHT28Rix0fn9qgEECqei/qam4JrY7engmJh/sMRdZHlgjMmZSIfgTcdXkgZQm296posdp1YoBC17pfVDJmUDzaZdf8Tjiex+oPjDo+e5MLnUH5teFmKdBybrwCnwYEqnsb5CrZgUHijOQxzOjzDMATwz386WDsw2iI+LITrm7uleHzP9y0Bz7LNWgMZ44K0qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHri8eZYyvxP7FogrSX6Os1eQ2LVvphPiDULW+K44FM=;
 b=e3Hf3pQtqYPkerQvhia6ddLyTfAdknYNT4ZUgSga67GM37e1DsHM1tn/KLCmM8sjnLTt0n3R9KUKuxXNvtHDZZRlxyKGRUQW3USCojsmTMfB6lSNZWhS+UyAXVvlaCPjRGMzFH3ynJX47sPSqtCmqZnvPEFMI8YUI8Wo/tICO/w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 IA0PR12MB8325.namprd12.prod.outlook.com (2603:10b6:208:407::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Wed, 1 Feb
 2023 05:18:15 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::4014:79ea:392b:b4f6]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::4014:79ea:392b:b4f6%3]) with mapi id 15.20.6043.038; Wed, 1 Feb 2023
 05:18:15 +0000
Message-ID: <bf0f165c-7952-77f5-3759-8487498ed186@amd.com>
Date:   Wed, 1 Feb 2023 10:48:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 1/1] PCI: Add translated request only flag for
 pci_enable_pasid()
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <jroedel@suse.de>,
        Matt Fagnani <matt.fagnani@bell.net>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Tony Zhu <tony.zhu@intel.com>, linux-pci@vger.kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230201001419.GA1776086@bhelgaas>
From:   Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20230201001419.GA1776086@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0227.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::14) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|IA0PR12MB8325:EE_
X-MS-Office365-Filtering-Correlation-Id: d8b8ab4e-35c8-4a81-ade5-08db0413b892
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /v1OZhWCwA6KqaZ6pWS8yA/8NCf7vKE3M1IvUXNBNgVBZ/lTl2ciBiyQYqX2pKzbKw8sIrdluZ9o1YtH/C7L6Gu6H9aMoW5hrSkidDCQwoIPH/ACQwD/a1Xmua0N/42Vsm5USzfNqAuGLU5aNM7UDm8LYkEZmGhpxqfrOHO1Se+abq8SVfnEU7ag2dYfbOoFUywJmr8C4qnp4nO840+0zwf8egPFXoZiuD8ni7M82o6hBxkna1imbFjNhyQ6mVMqQ2G/JCblx/ErTbhU4JEus17EzmpoDk7G4MgzkUNl3XiFci67xXjbeYgi4g4O2BczpAFy/ySFiOz7Dgdn2zQ8Vr6u+HQFbQFOjwFYOsE61pNg3Xb1g75CS4nNMawVIHhKX/pkrf1Hc7SqfYOP4KgYN3e1ZQ5iK0LeU9t0sR3RUHu3pcBAc5FQz19leZZjmR+i0tOqODArVTp+d90IuN4Y69bEJ3fRweZpXUjLlMpwimcwMJErIKzMZPrYtXcvWqb+PQvSmGtZzMrkSa3v25cKVyOSgdfoDHmurY6TZf2sWqQ4b5fjxezfWaEdy0EWgzeLO3lg+y4ojQMlXF1P/P5kkHnkve9zUsrNOAEBIg4RhbsnhfVHQ2c15Uh2C3N3oPxFi1W/u2tcuzsGCsZRhbqcF0p0FILkHjpljmF2GS2hD0fFDksW6uC3eJBsDWtQ5ZGVDbVuB6JTgS0H7zEr75WOL3agdp4QbSbVheQjT5ZUXkQkvrT8UQ8T8rNnoDIg5QI5IOPZ8sm/IWSB0bLztJS9fQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199018)(86362001)(31696002)(38100700002)(478600001)(2906002)(110136005)(54906003)(966005)(7416002)(41300700001)(6666004)(6486002)(26005)(44832011)(2616005)(5660300002)(4326008)(8936002)(66946007)(83380400001)(6512007)(66476007)(66556008)(53546011)(8676002)(186003)(316002)(6506007)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y25TdEtHVmkrUjlYUU9iWUd6NGZ3NklrdVNZc2huZkZKQnNOYW5QVU5oUktP?=
 =?utf-8?B?ZlBFOWtDVk5ESVJZdTFma3JOaW0yMTY3OXpFNGdEY1dRcTcxZWdweFJuZUdo?=
 =?utf-8?B?V1FRRW9CMlBaS2xmTUlFVTJjMVNWbC9lWmFrM1FKUnNsQnQ5cnU5VzlpRzEw?=
 =?utf-8?B?Ly91SGZhYmpaMGo1cE04TlBWVTBJb1N6dnBYMmZ4VmxDMUZVd3E3QzBhYk1H?=
 =?utf-8?B?N0xENmhkenpMdTJzY0g5aGFudUN2OVRNMmVaNzgrbHJ4Z0JBRzkydE5BbUla?=
 =?utf-8?B?TldXSnRnL0ZSQ2UrWi9USFZDN3JiQThUdjBzYnczeWtpODJaTUhrUTZnelBC?=
 =?utf-8?B?UGNVZ05RTWNmamptMDM4eGhreG15Q3lFU2tRa3NsS2VXUjdhMXdFMDArcHcy?=
 =?utf-8?B?TDVDbjhFWGovcWJuQWJ0dTNLRWtORkNxdzZWSmNkQzhzQWpHWG95NXRtVFA4?=
 =?utf-8?B?TWJXbVJRa1IwZ0ZEMkNmeWlLeXlReGRiUUNmalEyVFhDUHVvdm11R0ViZ3pP?=
 =?utf-8?B?YXdFTUtNUEh0OWw0eVhFeXprbStzaStWU3M2QjZ1c3c3UldDZVMrTEQ4SXFa?=
 =?utf-8?B?bkpVNEFuZnFiMnYweGdER1k3TTVqOGYwWklaNTllaHRTYndsWHQwTkxPTDY0?=
 =?utf-8?B?K3cxbjdlYTZDZy80VzVUK3dDZDBFaTI5VkpuSG43TkorODI5ZlZaY2hNdDVa?=
 =?utf-8?B?OGd0dk1Yb09WS3RKejdicU5XeGIvSTBvbElPTUQrV2VDY1BiL2xBZHhFTTBV?=
 =?utf-8?B?QlV1K0Q1K0VmeWk0Qmx3NmJwVm1FejBXK1kwUGpmMytWNVVUQllVUEN3TGJP?=
 =?utf-8?B?MlBkOUtQZ1J4U0hjSW8wQW1lNlN5MnlmTUlhaE9pbGhIV3ZLa2lNbG1heDJI?=
 =?utf-8?B?cjNZazhWUThSVHhoSGhOSWVrRnNBREtkRERvN0M2aGVxdFZzcmU0SytoSkdp?=
 =?utf-8?B?dStoYzhzYzhiOWtkRDNuVWtFMDVlejdhZExBRFRFZ3dhSENjOE9NQXRCTUFZ?=
 =?utf-8?B?dEd6bHpXbWtJYkRiQndaMHNiMk9kUE5pUlU3akFtMkp5YkxGQkFTYjFoZk9W?=
 =?utf-8?B?Y1dBMzZ6OXZCRjl5dDMzeVpBSVg5ODVnaDBZeUNUd3Z5cE9NbVcwbmVGQmd5?=
 =?utf-8?B?K0tsSy9OcDBXbnk2WVVvSXlTd0IxWGVFQ1hVNmxDcUNxclA0emQ2QnRZbnV6?=
 =?utf-8?B?S0xLYUVlbEo4REdWYytTN2pmNXE5eGFZeWthR2hvMUc4TS9hR2wvQ3V2cUlL?=
 =?utf-8?B?T3gxV0hxa0RZQTZQeFZ5ekRncWx2N2hldlB5Qk9tSjh1VllFUkhqOHdaQnpH?=
 =?utf-8?B?WXdoTFk0SllYM21XbWtGV3R2SVk2cldXYitwd3FzbTF4cVY3NFRNTTZFVmhR?=
 =?utf-8?B?WnQ2eG8xN0lJekFTUkpKbFQ1bkl5UVJhbTNrUDBQYzE1emZmdEhtYkFyZlZG?=
 =?utf-8?B?T0xqOTU2Z3ZvbFhmdW1QOHhpbWNob29iY3lTc3dzTU5qOVUzZXBORC9TTGpy?=
 =?utf-8?B?V2JYM1oxUSsxbW9zTndDeFNvQTduOUwyRDkyNlZ1UTFSRFV5Nis4ZEZyWlRm?=
 =?utf-8?B?OGZNYm9TSVZsVndlbjZBNGxKV2l1dFRjTlZpNnlCdUoxRXY3UEtLMFpLTHFZ?=
 =?utf-8?B?d3h1bUxqWStlOEdwMXVMcm1BSmpSWXdVdDN0OWxHY1J0WTRINDUyMGYwZnFY?=
 =?utf-8?B?S3Z5TmJDMVl2b2NibnhkUytaSk8xNlR1bmJnSDlGMWhoYkc1YitMSHZITFFP?=
 =?utf-8?B?TzNWQ0tyN3ZDTk50ek9ibWpOR2hkcEo4RGhiNGc3SGRzVHVueUZMbmtTMjJG?=
 =?utf-8?B?c2NmQnh0dml5bkJCNkhjTlpseFp2NVhYdWJIcDBFcmF4ek1wUzJkckxmL2pE?=
 =?utf-8?B?QTNXejVlNWgrYlhzNGd0THBwUnpqQkYzZ3RBaXFtTDVTUldhYU1wcjB5d3Ux?=
 =?utf-8?B?Z245cEd1ZkZXamdlY0dKdHpuNWxTREYxYTdRdlZNNjc5NkhUR2F1WEtiZFFC?=
 =?utf-8?B?bmNBaWtHanNZbVpSMi82d1prcjVHdEJjd1hIUXFnWEpIMlh0ZktYUG5MUXVp?=
 =?utf-8?B?UUpGTVpQKzIva29zeWsweG9QUTl6WktsL0NDZk5vUmRtdXBKMHE4RUJBaVR4?=
 =?utf-8?Q?XnlXspnahYITqEijitx150kGT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8b8ab4e-35c8-4a81-ade5-08db0413b892
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 05:18:15.4316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iKHCQAz7U69uOPg0Njg+9lqboyPKZxxZJsocgFEdGZ+ebxaWYYG0XDF5l6orPu5E65MCwmIZtPUI/Kv4AwEuGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8325
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn,


On 2/1/2023 5:44 AM, Bjorn Helgaas wrote:
> On Tue, Jan 31, 2023 at 08:56:13PM +0800, Baolu Lu wrote:
>> On 2023/1/31 2:38, Bjorn Helgaas wrote:
>>>> PCI: Add translated request only flag for pci_enable_pasid()
>>>>
>>>> The PCIe fabric routes Memory Requests based on the TLP address, ignoring
>>>> the PASID. In order to ensure system integrity, commit 201007ef707a ("PCI:
>>>> Enable PASID only when ACS RR & UF enabled on upstream path") requires
>>>> some ACS features being supported on device's upstream path when enabling
>>>> PCI/PASID.
> 
> Looking up 201007ef707a to see what ensuring system integrity means,
> it prevents Memory Requests with PASID, which should always be routed
> to the RC, from being mistakenly routed as peer-to-peer requests.
> 
>>>> However, above change causes the Linux kernel boots to black screen on a
>>>> system with below graphic device:
>>>
>>> We need a PCIe concept-level description of the issue first, i.e., in
>>> terms of DMA, PASID, ACS, etc.  Then we can mention the AMD GPU issue
>>> as an instance.
>>
>> How about below description?
> 
> Thanks, this is exactly the sort of thing I'm looking for.  But my
> understanding of ATS/PRI/PASID is weak, so I'm still working through
> this.  Tell me when I say something wrong below...
> 
>> PCIe endpoints can use ATS to request DMA remapping hardware to
>> translate an IOVA to its mapped physical address. If the translation is
>> missing or the permissions are insufficient, the PRI is used to trigger
>> an I/O page fault. The IOMMU driver will fill the mapping with desired
>> permissions and return the translated address to the device.
> 
> In PCIe spec language, I think you're saying that a PCIe Function may
> contain an ATC.  If the ATC Capability Enable bit is set, the Function
> can issue Translation Requests.
> 
> The TA (aka IOMMU) will respond with a Translation Completion.  If the
> Completion is a CplD, it contains the translated address and the
> Function can store the entry in its ATC.  I assume the I/O page fault
> case corresponds to a Cpl (with no data) meaning that the TA could not
> translate the address.
> 
> If the TA doesn't have a mapping with the desired permissions, and the
> Function's Page Request Capability Enable bit is set, it may issue a
> Page Request Message.  It's up to the TA/IOMMU to make this message
> visible to the OS, which can make the page resident, create an IOMMU
> mapping, and enable a PRG Response Message.  After the Function
> receives the PRG Response Message, it would issue another Translation
> Request.
> 
>> The translated address is specified by the IOMMU driver. The IOMMU
>> driver ensures that the address is a DMA buffer address instead of any
>> P2P address in the PCI fabric. Therefore, any translated memory request
>> will eventually be routed to IOMMU regardless of whether there is ACS
>> control in the up-streaming path.
> 
> A Memory Request with an address that is not a P2P address, i.e., it
> is not contained in any bridge aperture, will *always* be routed
> toward the RC, won't it?  Isn't that the case regardless of whether
> the address is translated or untranslated, and even regardless of ACS?
> 
> IIUC, ACS basically causes peer-to-peer requests to be routed upstream
> instead of directly to the peer.
> 
> OK, reading this again, I realize that I just restated exactly what
> you had already written, sorry about that.
> 
>> AMD GPU is one of those devices.
> 
> I guess you mean the AMD GPU has ATS, PRI, and PASID Capabilities?
> And furthermore, that the GPU *always* uses Translated addresses with
> PASID?
> 
> So I guess what's going on here is that if:
> 
>   - A device only uses PASID with Translated addresses, and 
>   - those Translated addresses are never P2P addresses, then
>   - those transactions will always be routed to the RC.  
> 
> And this applies even if there is no ACS or ACS doesn't support
> PCI_ACS_RR and PCI_ACS_UF.
> 
> The black screen happens because ... ?
> 
> What can we include in the commit log to help people find this fix?  I
> see these in the bugzilla:
> 
>   WARNING: CPU: 0 PID: 477 at drivers/pci/ats.c:251 pci_disable_pri+0x75/0x80
>   WARNING: CPU: 0 PID: 477 at drivers/pci/ats.c:419 pci_disable_pasid+0x45/0x50
> 
> (These look like defects in pdev_pri_ats_enable(), so really just
> distractions)

Right. We have fixed error handling path in this function. Joerg has queued the fix.

> 
>   kfd kfd: amdgpu: Failed to resume IOMMU for device 1002:9874
>   kfd kfd: amdgpu: device 1002:9874 NOT added due to errors
>   BUG: kernel NULL pointer dereference, address: 0000000000000058
>   RIP: 0010:report_iommu_fault+0x11/0x90
> 
> I couldn't figure out the NULL pointer dereference.  I expected it to
> be from a BUG() or similar in report_iommu_fault(), but I don't see
> that.

Its coming from below path :
  - During system boot IOMMU allocates default domain
  - AMD IOMMU v2 module (iommu_v2) created another domain and tried to attach
devices to new domain.
  - In device attachment path (amd_iommu_attach_device()) it first detaches
device from current domain and tries to attach device to new domain. Here device
attachment failed as PASID enable check failed.
  - We didn't recover from above failure (I have proposed fix for this [1]).
  - So device to domain attachment is not in consistent state.
  - Device tried to do DMA and hit IO fault. Above NULL pointer derefence is
coming from that path as dev to domain setup is not proper.

[1]
https://lore.kernel.org/linux-iommu/20230113135956.5788-1-vasant.hegde@amd.com/T/#t

-Vasant


