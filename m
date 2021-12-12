Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79D174718EB
	for <lists+linux-pci@lfdr.de>; Sun, 12 Dec 2021 07:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbhLLGoz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 12 Dec 2021 01:44:55 -0500
Received: from mail-db8eur05on2044.outbound.protection.outlook.com ([40.107.20.44]:50561
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229448AbhLLGoz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 12 Dec 2021 01:44:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WNuyxlEWZpftbwbbz3VAjS+eVoqPk7vS0bN2oojghWs/SkVPr1Wy/5KfjN/r/YXQFKin6V3YzXZVeX0M0vANcpVkgNcdTOH7to/bsu6Uhf0g5fOO+dPQ/sYvd/h7f0uUJ90xTJchA4cB8vgHVZKzLqMNECO48ulobOSASIJX2940xAnJS3m6Wk4bxiA8fBGRmuyjAcmgMC+tKx8CstVJ5y4FxGjw7RrN4PedqfJgacRTQIhXlfG+UfTaoVqzsvhAhIVpxM93oG6qCuHCLbLL9ESsdnaMGiBqcEEMKNW8VooHdFR+aHWIqGvFc++T0L7yVOCAybCscFQ7o4jaF2qpIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/kI292VVGwC9YHzx6achs/pLHP4Kp+eYk2JuzwHU+M=;
 b=hjFNg63ab6WBSFoWaks17uFs0qIjbZW8t7jGOAA2V4aUsLgmT2g7CdX9XDBiicszeeom988pAWnnsLdX8jlBw21R6Idyp5Q2micgF9XNIhog3giIDxVUDNN40jdnhCQraFUJ8epqg1WYtKQRaHjMhUykeIHaaofHG9a/NiEXabGkqHBzHFc5cDUAb9NCJ7KjhBYMqH9Nbhbd47TRgJYGv9SPo0S54xLvr2kweDHa4uqRIbBUs1+mDQDoa1g7bCfdY8f11wkz2QG1eSRuwYNKPG2b9n7Q9MMsSHtTwKTbMFZSZpT4CK48yW7IazBzFGKYPtux4792UvwFXY7GAiQX+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nextfour.com; dmarc=pass action=none header.from=nextfour.com;
 dkim=pass header.d=nextfour.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NextfourGroupOy.onmicrosoft.com;
 s=selector2-NextfourGroupOy-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/kI292VVGwC9YHzx6achs/pLHP4Kp+eYk2JuzwHU+M=;
 b=MAhySbBjq42Lr8+2BnaIoW1xCc/4LNjf+1zm5r87Jme+6RzTbK0E7UIE5pah2hGlE+mvZ6lbuhtT2j+c9M8KY/V1Kn7r7UP5ow8WWYRhBAswJ6mU2NbH5qlsVftD4EdRN4CDSWFXqXRR4sZhaxz1BiBosgGzSCEEMPnE7xGMBhs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nextfour.com;
Received: from DBAPR03MB6630.eurprd03.prod.outlook.com (2603:10a6:10:194::6)
 by DB6PR03MB2855.eurprd03.prod.outlook.com (2603:10a6:6:33::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Sun, 12 Dec
 2021 06:44:51 +0000
Received: from DBAPR03MB6630.eurprd03.prod.outlook.com
 ([fe80::39ec:706d:cbfb:8a26]) by DBAPR03MB6630.eurprd03.prod.outlook.com
 ([fe80::39ec:706d:cbfb:8a26%6]) with mapi id 15.20.4755.025; Sun, 12 Dec 2021
 06:44:50 +0000
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     "Jiang, Dave" <dave.jiang@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Dey, Megha" <megha.dey@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>,
        "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "x86@kernel.org" <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
References: <8c2262ba-173e-0007-bc4c-94ec54b2847d@intel.com>
 <87pmqg88xq.ffs@tglx> <df00b87e-00dc-d998-8b64-46b16dba46eb@intel.com>
 <87k0go8432.ffs@tglx> <f4cc305b-a329-6d27-9fca-b74ebc9fa0c1@intel.com>
 <878rx480fk.ffs@tglx>
 <BN9PR11MB52765F2EF8420C60FD5945D18C709@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87sfv2yy19.ffs@tglx> <20211209162129.GS6385@nvidia.com>
 <878rwtzfh1.ffs@tglx> <20211209205835.GZ6385@nvidia.com>
 <BN9PR11MB5276599F467AD5EAC935A79E8C719@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
Message-ID: <3f6d4bd7-8b60-1976-73a4-f5ef7f3dbf27@nextfour.com>
Date:   Sun, 12 Dec 2021 08:44:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <BN9PR11MB5276599F467AD5EAC935A79E8C719@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: HE1PR0901CA0052.eurprd09.prod.outlook.com
 (2603:10a6:3:45::20) To DBAPR03MB6630.eurprd03.prod.outlook.com
 (2603:10a6:10:194::6)
MIME-Version: 1.0
Received: from [192.168.1.121] (91.145.109.188) by HE1PR0901CA0052.eurprd09.prod.outlook.com (2603:10a6:3:45::20) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Sun, 12 Dec 2021 06:44:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a9841ff-3283-4278-9698-08d9bd3ae56b
X-MS-TrafficTypeDiagnostic: DB6PR03MB2855:EE_
X-Microsoft-Antispam-PRVS: <DB6PR03MB2855EECF64352E555D35954D83739@DB6PR03MB2855.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pwa39zJxitZSCq9F7V7guW9o9JoRNqZqqDVFgA34AxkeI21bEos+5QFp8tWWhlNZfoUTHGYrP8RmPFqlJ9JA6RWzOtYHqqlJGNXnorXp08Nw1hCXFKlftdldIFVAdOGV2TEX+B7dF7ENcOY3DYlKhHgovA9IQLvFUTByQDIu77FAIXdRStnOL0cVAs+BmoLbXHtT0I6DC6gcpxAWE6vxqJ11VxbhP73bQ1xod6scfqd2qXCs0vZ3IzEwXAtbB+RwqNFa9rfHfIUd/xwDmN3d75/yrA3e5uYg3t9vOjuOZ1VfatnjiWqZxyPXbBsdBoqaXyCkNPeVvQZ0NH9BS0v1Nxe+Y4Bnqi3ci9uAjM6KJhdhutAbzekS1eyLPGaVjknGpyYnBMWw/TCWlqlunQhW+6lSeqpm/rycb5ZKBvyjEDUKUlx1LZ3tTwWC7UQTlZKeitLzupKVYRE7dZok0upQO7OMW+AIxcn1AMvwMMh7jv7U0xKU5hGKp/pX8jikuIw7iZ4ik/T8XFqmdFuTl7UufxvDUFaLNfxmVlD4krqfwaYq/DRJlGNoaE1fpUtWkXLeUHeDq8kaFVPKe093iiYvpUZwebDD2BfPOTi6XxwVyF52V2CNevnlrUZ7Kb2rI+zcYvRMHGyClnS6I5f96l6gIw34kIs8FuklJQZe+MVnsNWKDrXOyODTSw8qAodqjsfI6zUIaEcg0cn5rdCQU2FtJpkuxUe1e27EJUlqDZJgbRBEiVJkYRmSwhluD35XUk0acvRrpQJoLO4M0/EIkIPimA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR03MB6630.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(39830400003)(376002)(346002)(396003)(31686004)(52116002)(54906003)(38100700002)(36756003)(956004)(8936002)(31696002)(2906002)(186003)(5660300002)(83380400001)(6666004)(16576012)(110136005)(316002)(66946007)(38350700002)(7416002)(86362001)(26005)(8676002)(6486002)(508600001)(66476007)(2616005)(4326008)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFBGWW9PM2thWjcwdjNMOFNwR3lNeUtVRmlLaCtrMWhyZDNBRmpWQ3U2RURo?=
 =?utf-8?B?OHBISG5leFlsK0JWYlNiczQ2ZzMxaHFUeWQveFRQdGxidUN3WnVWNUZGTHF6?=
 =?utf-8?B?NVFCYy9DNC9ZeTR5MzNnNXZUeXVMckZuSkh1NDVVejl5UjJ1WHBic1NWYlhZ?=
 =?utf-8?B?VWRFR090NnA2ejNJSE1xRjB6VUNQSnBNNHNmKzVhajN4N1JDbzArays2QXBo?=
 =?utf-8?B?YmxYT1VnWnBwcVdlbXBsNG9hMWs1T0ZkTUZHVFlnYVpvREN5aVJpRWV0N0JN?=
 =?utf-8?B?ZUsyaU0vTnI2M2kyYkRUM0dXTXBMWnZDUitTZTR5c05LUTdiR0dVMEczSTNZ?=
 =?utf-8?B?SHE5VkNodURzVVNNeHpTV3lSanJEWWlYN0pWKzNaSmVaanRTcFpHcytzR01X?=
 =?utf-8?B?WHZEQ3NmYVhUMFFnSkkyaFJ0c1l5VWdOZE5oL0N6a3JLQ2p2YWJ1alBaUXpa?=
 =?utf-8?B?aFFWaU82ZjB3ZmxUQnU1eEVYTXpMMUY2Zmd3K1Zyb0pOVGZQME9OMjJKeWh2?=
 =?utf-8?B?NEZnZ2wxU1VvQ21nZHp4dDZiTXEycDlRaHY2RCtmVG91Nk1PYnlxTk1KRW0r?=
 =?utf-8?B?Vk00YjlmTHNZYjNRUGIxei9CNzlvK3ZjdGF4bncxTkdIbTIrTUdMN3dxaVNR?=
 =?utf-8?B?SzlnOE5TQjZRVjQ5eHdWdkZZcS92ckk4QTVDa2tYOGJqVXZXdmNYblBYOFFI?=
 =?utf-8?B?Y3UrTStIWXNYUFJiQXVNN2k2UjNXUjQ4dklBbEc2WkpscThwSTZkUGtlZkUy?=
 =?utf-8?B?b0wzdzVCa3QwV1hDb090cXlUQk9USEJNcDZpeGU5MnN0V09zN3lRbmF4ckZB?=
 =?utf-8?B?cG9uaEZ4T1E4V0JxcVJXNVdNaU1sZTViSFJiUVd4U1hjMEdHTUcrakJkSnQ1?=
 =?utf-8?B?VEhkY08ram14KzlNUXdFWEtKekdCa1RoY3ZHdlBEY2NnN1pSRjZFTkoyUzBt?=
 =?utf-8?B?ZnVoNUswemhhRjc4R1gxeGhIUE1ZUDBnZndOQ2JCMWQwY1pNZXM5K3M4Rzho?=
 =?utf-8?B?QzZWY1A4QkthcVVwSG5ieS9VUFhMZE95TlIzNk9PZjQxK1hJUktpRU5Fdk9R?=
 =?utf-8?B?L043QU5qSW5tdGhkTUdQVUxqOVVsTk1Qc1AwRjZoeXZFWHRBamtLSmpHczEy?=
 =?utf-8?B?c2F1dlZwL3E4WHp4ZjZvN2VjLy9MdWVYcmdueE9HQVNaOVdYeUFEQ2NscU1t?=
 =?utf-8?B?eElVK2RIZm1PU1pIU09IZ3hLdTlsdTIvNjhNRlhOQlVUaENVbEo5YndhcG1z?=
 =?utf-8?B?bWIvQnRHcVkrQzMvdC9DdWVRNGQ5enhsYWh6UVJ1cERUMjNqMndHVVdBVk03?=
 =?utf-8?B?MXRwUlZ3b2RhRFJCeDRGNG1TQ3h0Z05yY1lUZ3h2N3owNURwbHZTeklueFdn?=
 =?utf-8?B?c3JTTmFoOGJMR0ovZndYeHVhV25RMzZZUE4xUUdyeHg3R0RBRk5mcXZmeHdt?=
 =?utf-8?B?UGVvNE9uSXlRVU9pTmh4aXpFS3U4SnB4aXhPQmhiOGxpSm4yYWNVQk9TVXlw?=
 =?utf-8?B?SEdEWGsrUm80elk4YmZYV0t2RllvUWFMdEJ5M2JoNFphRHRvM1ZudTNNdlVR?=
 =?utf-8?B?eFlSOVFmekd4TUVyMlljN0tMWXpJTUQ2NjBHSTYwQ0FFUCtvQzh3K2M4bnRw?=
 =?utf-8?B?c2FrYVdzMWRHL1NZaW1BelFCYlZnWTIzMEJWNUVTL1lqMGlFcTVoaFRRVmtG?=
 =?utf-8?B?SHovRVdzai9KWHh6ZkN6N0ZRTXh5T2hrSVZKcVlzcHUrdTcxTGtmRU9BdGlR?=
 =?utf-8?B?MVltKzh3elJ1cmdkNWF3aXptTGZFb3l6aWNkd0NKN2xSRzlGZGFzT21FTVg2?=
 =?utf-8?B?T1lTWlBzQVJ3eno2bVdDaWFSUDRFR0IreThGYXFnZmNnS3hlZzlqV0FBVEQz?=
 =?utf-8?B?WWVraCsvNGp6Q3VoVmZmNDA2eUJPbG0vUFZTbnUrYmVUVVVPcTY2OFc2b1Vk?=
 =?utf-8?B?eFdmL2swdDFYMHhMVHcrNGNMaGRqUjZaYXFxMWdTRWV2dU52c1NkMUZNWTFI?=
 =?utf-8?B?dWFvMy9wL2ZhbmVVbHdXeGJZR0JQdE1vY1V5b09mQnFPcEtrYjRNMDFTZExH?=
 =?utf-8?B?Q3AvMmpTMnBJN0E3dmlNTXlRNEh2dXNOYkVpNmRFeFhtMkI3UDZmSEhNWmhO?=
 =?utf-8?B?WElZWUliUG9udXE5Q2lZd0VBdDZJM0Ywckk0M0ZZdy9BbnJLZmQ5WEZiUUxq?=
 =?utf-8?B?YUx5OVdwcTFsMlQvcUszbXlLYkUzVkxzQTAxczRmRnhVQlNrWFB5d0tNeGRj?=
 =?utf-8?B?dWdrSk90U2VvV1c2cXV5Z1BkQUJnPT0=?=
X-OriginatorOrg: nextfour.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a9841ff-3283-4278-9698-08d9bd3ae56b
X-MS-Exchange-CrossTenant-AuthSource: DBAPR03MB6630.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2021 06:44:50.6373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 972e95c2-9290-4a02-8705-4014700ea294
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M0bGH/jO+ZCoS+pZk1NmA+/GX8GOPnc+9gNhOydkEVkXpJts8x+qkpHL748R4gSg22+uoRHl7X3Rq05clhcBjYa6Etzd39X7lVRgUmB/OeU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR03MB2855
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10.12.2021 9.36, Tian, Kevin wrote:
>> From: Jason Gunthorpe <jgg@nvidia.com>
>> Sent: Friday, December 10, 2021 4:59 AM
>>
>> On Thu, Dec 09, 2021 at 09:32:42PM +0100, Thomas Gleixner wrote:
>>> On Thu, Dec 09 2021 at 12:21, Jason Gunthorpe wrote:
>>>> On Thu, Dec 09, 2021 at 09:37:06AM +0100, Thomas Gleixner wrote:
>>>> If we keep the MSI emulation in the hypervisor then MSI != IMS.  The
>>>> MSI code needs to write a addr/data pair compatible with the emulation
>>>> and the IMS code needs to write an addr/data pair from the
>>>> hypercall. Seems like this scenario is best avoided!
>>>>
>>>>  From this perspective I haven't connected how virtual interrupt
>>>> remapping helps in the guest? Is this a way to provide the hypercall
>>>> I'm imagining above?
>>> That was my thought to avoid having different mechanisms.
>>>
>>> The address/data pair is computed in two places:
>>>
>>>    1) Activation of an interrupt
>>>    2) Affinity setting on an interrupt
>>>
>>> Both configure the IRTE when interrupt remapping is in place.
>>>
>>> In both cases a vector is allocated in the vector domain and based on
>>> the resulting target APIC / vector number pair the IRTE is
>>> (re)configured.
>>>
>>> So putting the hypercall into the vIRTE update is the obvious
>>> place. Both activation and affinity setting can fail and propagate an
>>> error code down to the originating caller.
>>>
>>> Hmm?
>> Okay, I think I get it. Would be nice to have someone from intel
>> familiar with the vIOMMU protocols and qemu code remark what the
>> hypervisor side can look like.
>>
>> There is a bit more work here, we'd have to change VFIO to somehow
>> entirely disconnect the kernel IRQ logic from the MSI table and
>> directly pass control of it to the guest after the hypervisor IOMMU IR
>> secures it. ie directly mmap the msi-x table into the guest
>>
> It's supported already:
>
> /*
>   * The MSIX mappable capability informs that MSIX data of a BAR can be mmapped
>   * which allows direct access to non-MSIX registers which happened to be within
>   * the same system page.
>   *
>   * Even though the userspace gets direct access to the MSIX data, the existing
>   * VFIO_DEVICE_SET_IRQS interface must still be used for MSIX configuration.
>   */
> #define VFIO_REGION_INFO_CAP_MSIX_MAPPABLE      3
>
> IIRC this was introduced for PPC when a device has MSI-X in the same BAR as
> other MMIO registers. Trapping MSI-X leads to performance downgrade on
> accesses to adjacent registers. MSI-X can be mapped by userspace because
> PPC already uses a hypercall mechanism for interrupt. Though unclear about
> the detail it sounds a similar usage as proposed here.
>
> Thanks
> Kevin

I see  VFIO_REGION_INFO_CAP_MSIX_MAPPABLE is always set so if msix table 
is in its own bar, qemu never traps/emulates the access. On the other 
hand, qemu is said to depend on emulating masking. So how is this 
supposed to work, in case the table is not in the config bar?

Thanks,
Mika


