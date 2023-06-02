Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C004720086
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jun 2023 13:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbjFBLkE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Jun 2023 07:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233858AbjFBLkC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Jun 2023 07:40:02 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D7518D;
        Fri,  2 Jun 2023 04:40:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfIgjymjIYSjdP9naK805c+vrOxobFAv9h28BvccxJ0MYgn1O4Wsu7U+XxZgOVwv4ktbr/qrn4B6J3/DmskpYweY35j8OzjtvrIFL5EmEzYgyYO8pGNclPJOVeRJO7jffGNplFiWFqIk/5ApUAMeDG7iBmxRA65NhDpU+kZqy5M1xQHxOh0MS/bZjmp5dOnRukYBd64zR0aOXrrnDt46F73fDM8ck2MLYHzhimHM+7ehD9FAXHJdHEYJKenNu1yvIbGCAEc9BlhOot0dvhHgH6l/w70rKQ9ls/zwMVLdaqA6g8fJ8ACZdR/mZpRXWLhTPoVY/s3xqEjcCH7g0fCfgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqQqPY4p/CzRvviTBQ4gVKqnpsIEALUokAWy0SQrhYA=;
 b=kLNHBpytRdMZeFXm3Ft4lScWGu/ZBQX6JX3mxSLseyF7r22FdO0AHYCLqZm6wB6TuM1SIJcvx2BmNHZ+OuRTUrhdJf7uvsG9uYDH53y/EkPv/Di9cczxFJEPuru3Sf59ugMCQH3HJqtxSIfSSaUowxNnQngcPeY3Yd0zznXPg25fR4Ac7fVkEFx7lI9tk9r/sCgeFsUSWGiri131kyMDlienYStA3Mb9cJiLas+eWMEsQbhhCotwjXM45UaX+LeoNW3HZ3SRnraSQtFl9QcYBR+KwDRAh86V0AEsGzQNrEFs8wcJQ1e1mP79mNqPUXugJsP/nkbLpelpwzfgIenfNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqQqPY4p/CzRvviTBQ4gVKqnpsIEALUokAWy0SQrhYA=;
 b=rk59D8u3XSQlMQTgao0CiZO+flsBlXSzuoZWQJrUyLWiDUzBEZOrw3mXQGeQhO8ivINIFJZah0b5A2UGOUdp77Fgnp0faL+LhG9gKzoXQAvnByPLtZs2q4+6INPLD9B/Byu1vtUfukiRg6bxLsv7iLQqlq1DVWLDyw7kdeNHTyE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5839.namprd12.prod.outlook.com (2603:10b6:8:7a::21) by
 CYYPR12MB8924.namprd12.prod.outlook.com (2603:10b6:930:bd::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.24; Fri, 2 Jun 2023 11:39:58 +0000
Received: from DS7PR12MB5839.namprd12.prod.outlook.com
 ([fe80::5ce6:1e12:bbb5:716f]) by DS7PR12MB5839.namprd12.prod.outlook.com
 ([fe80::5ce6:1e12:bbb5:716f%7]) with mapi id 15.20.6433.024; Fri, 2 Jun 2023
 11:39:57 +0000
Message-ID: <52b8f850-af8c-1971-9729-c5de37875bf9@amd.com>
Date:   Fri, 2 Jun 2023 17:09:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] PCI: endpoint: support an alignment aware
 map/unmaping
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>,
        Kishon Vijay Abraham I <kvijayab@amd.com>,
        Shunsuke Mie <mie@igel.co.jp>,
        Jingoo Han <jingoohan1@gmail.com>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Frank Li <Frank.Li@nxp.com>, Li Chen <lchen@ambarella.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230113090350.1103494-1-mie@igel.co.jp>
 <20230113090350.1103494-2-mie@igel.co.jp>
 <e417f2c9-1fcb-cf57-3524-1408c9aae5fa@amd.com>
 <978b63ac-90b5-b909-d259-0668b77f1cc8@kernel.org>
From:   Kishon Vijay Abraham I <kvijayab@amd.com>
In-Reply-To: <978b63ac-90b5-b909-d259-0668b77f1cc8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0138.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::10) To DS7PR12MB5839.namprd12.prod.outlook.com
 (2603:10b6:8:7a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5839:EE_|CYYPR12MB8924:EE_
X-MS-Office365-Filtering-Correlation-Id: a02afed9-abd7-46e6-c5a4-08db635e1748
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q0HazE6ACU6+CuM0WM6KQIjnn4jNxGbpixFQ7g5qkNsO7r+qw7JxBzvfmjDK2rs1claI2Zx/UkBJ+3GOiwG5jm44BJekd3AS7iXyfTfUb5QTVCczb+d46yMZn7bSDAuh9JM7nnz6BWRII9C6sVL77TMFC+Zyy9lVG0CfFihFZvur3wSD+1WLOB7FWUrQ4Z5BuHrqcWef787kFAY9Pq+DuH10BMA9bc0XeKoun0OpFrcl48X9ip4fmjYXtVsG/vTv7oQA86y3QQLHUXG13mEm4zMKbYvWd/gMP6/vYgpxz2A9gKnspaKDRvBCVpHSTzAb+XGYeUWN2vOe74Bakiwt60c5Ch8b7PsCAqkTcWl1afrSYrMlGe1s6Tg/+k/Dv+DDMypaP5PYpLgq1FkDGnb9ei9wqOox3OBMKPJAwz7mSlISVWd+3W7AAJKVpfzpq2BJtmuMmOpU8Qpx+nXBL+CwJRGi2uuBw/1LcuJxiUYokKQIDJtKl0FPd44pfPPKaebKzgSv7hXryToqUNc3jU1tBjpiat910/955n3DmMWwHeAR6wWNz4Lgtboyvs1cnos3+dl/Ks1lOHhH8/i16W5rmHHvbrVT0SAG3gTlv6dJCH1taW/dnC06PnWn6bmvmxZIaN8oRNnl0EUwpNCPmJniIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5839.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(396003)(346002)(136003)(451199021)(110136005)(54906003)(478600001)(8936002)(8676002)(4326008)(66476007)(41300700001)(316002)(66946007)(38100700002)(2616005)(83380400001)(6666004)(6486002)(186003)(6506007)(26005)(53546011)(6512007)(66556008)(31696002)(7416002)(5660300002)(2906002)(36756003)(66899021)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDV1Q1RTTlhsTmQzMmVxUnd1WDEvejdJV04yd2dkZ1hNL1hES0w4K0xCNXhR?=
 =?utf-8?B?RGhSQzJJWVpsdSs1YXJyT3Y3VjBlU0Z2ajlOSWxnYzFVTXY2V2s0V2ROemFn?=
 =?utf-8?B?SXovRHNPaDNMUHFJbW1Najk4L2ZQNzg3c3BHZ2p1S3lvMjk3cnk0L2tldlhD?=
 =?utf-8?B?V1JFdENqays1aUNIVDF0RHJJS3NRQWpPNTNsakhsV2J3VVFQSWM4NGtXd0x4?=
 =?utf-8?B?TE5XSkZmVXcrZzVMd3ZLR002ekE5QmpvY0tzZ0E4V2tFOFlTb3RFZEpiSGJE?=
 =?utf-8?B?dmRoUFRFSktLODFCK1V2cGlDMzBCdDZpdCs3TXU4SElWdkFLMXlkSUNDbWZo?=
 =?utf-8?B?SnpraW5tdHRBdHJBZ3FYcS9MRUgrZ20yS0xQVEFsc3Zac0cveitBc24vblBJ?=
 =?utf-8?B?WGJNUFhLTXpCcWRMMVNQdUJrODBncDVxK2M5TVd0dlFab1lWbEpDRlM1WTZ4?=
 =?utf-8?B?anNFRHdXQ2xvZm84c0pJbGJuSVlDMWxyZmJ4ajFhTkFhajNteU9lanliNkUz?=
 =?utf-8?B?WGFLUE5VZ3c3ZXE0U0VWamJYa0VrMnUxb2d3SVF0OU1oRUNQaHNpSDF2WDJD?=
 =?utf-8?B?SFBNUjR2alBFT1VsQllSbmlDWldiNjlaNEVMT3RCekx1MHZnYnNPZVl1citp?=
 =?utf-8?B?NzF5S0ZyajBvUThpSUw3SWtXQnMyU2oyWmNudzhXUG91bDFNSVVITU53T1hv?=
 =?utf-8?B?Zk1zYndFY2NUcTM0Rno4MitlVThBYm03VnQ4UmtlWnVoSGFXUGFMMGE5bTds?=
 =?utf-8?B?aUhQWm1qVm56UmxkYjVvYVdYeFVPcWN5QTRxejRGeWtMMDRVems3cmpoV09z?=
 =?utf-8?B?UE96dEFSanJwTi81RjdaSUh6SHdhN3JHRmZRaXdSUU9DY3BOSzZnVEdiL21H?=
 =?utf-8?B?L3dlRzBrMXZIRXVsQ1NYUGJic0dodk12L2w0L3JtcHQvSDBpRXBZT1BIT2FG?=
 =?utf-8?B?TXZjajR1U29ydkUrMTRLdWpRbjVJRkNZSDVBUmRTUUdOLzExYlh6TldRUVV1?=
 =?utf-8?B?M1FPV0VtdUdVdE1aSStxdkx0VzdDejVlZFRHSFdsM283S3o4WVpBYmNRL1Nm?=
 =?utf-8?B?T01aRW1Ba2N1dkNIRDljTWljaXV1c2thcU5ON0hON0hnV3ZqSHJrZlAzUXM4?=
 =?utf-8?B?ak5rM3YvdHJlUWxEemxtbjdQZkhFQS9vVXBhMCthRVoxMXJUdFdjeFNuS3dH?=
 =?utf-8?B?bENFbXlRR3M3b2hjQ2NwMjhyRWtpVHZ1UGhHNXh4dXFDKy9UVUdpZkdjNFJh?=
 =?utf-8?B?U3BzakRuSU4xdER6RXl6SWJBMVpuTE5pYytUTGJuTDNCUUdCajVwbk9FSmg0?=
 =?utf-8?B?ckdHMXcxTlp3dDFvK0JZOC9qY3RHVGFibGhRSWpwT2VLYWtQbnpOVFBaa0Js?=
 =?utf-8?B?OWN1bm5meG9aOHAxTnZwbTloendzWUhESGp4YnpMKytweDZMUzRLTWt4Ymxn?=
 =?utf-8?B?b2tBa3dIT1hJVVJPZ3UxNDdYSW1YT09rL25FdDV5S011ZjQ3MXVQckdxRTY4?=
 =?utf-8?B?Tmk5ZW1lVUJSSFFEdEFFUk4zdnNUU1dtcllzNjhBMDJTK3dnUnY0dWdLamNO?=
 =?utf-8?B?NVdiUVlYa0wyL3pLaHAvMHZBcXJiQ3N5a0xMeVJMRXVMZ3dsZUw4MVFIcTJH?=
 =?utf-8?B?WFZvOWl0OFhWZEZKMHJUWi9xNEtFOXYwU0l2RUk2K0J4WjFuK0pQeDQ4V2ZW?=
 =?utf-8?B?RnNQbVpSRGZGOWpORFZ6WXBQZmNWV0ZTNDN6TXdmNWRzdDVoUGFsZEV6Qzgw?=
 =?utf-8?B?YUZZSTVZaVB1c01NQmVjemRxQi8rbHhqdjJKRHV6eW9Lb0N1SEhiVC9yUEN4?=
 =?utf-8?B?dFpwYjE2bVNCenVxWXZFNWw1OGVTdk9vQW1hWm9ZdkViMTJtVkVaYU5XYXFX?=
 =?utf-8?B?ZzhNQ1Y3MlZqZXVzQ21KcGlqdTlVbk82QitZOVV2Ry9EVTU4N21kR28yRW9q?=
 =?utf-8?B?UkF2TlRCU0hKSTdTSnl4TnQvSUFPd1pzYXIzWDJjYndUYU4zSy8xNk1kVDky?=
 =?utf-8?B?Q2ZkNHBlaWw3Y201L1F2UGJ6emp5N1ZHcUl1RE1IdzI3T0lPZkw1ZUU4cVNj?=
 =?utf-8?B?cmUrV0UrU0pDQmlhcGtiMklRNTVuQUd4TW5mZldsNmdWTW0wNFpWZ2ZXTGs3?=
 =?utf-8?Q?gCpQ1YF5WpNAfeP16P7tz0wzt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a02afed9-abd7-46e6-c5a4-08db635e1748
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5839.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 11:39:57.7727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J0L0oNlP/+bMEknqC8qG/q32sFhMIGUQyI4e+dg/nRDYGUipEmkM9SJk7OCw3AFQmB4XpQrfLpyiF3XYQXVSLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8924
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/2/2023 5:13 AM, Damien Le Moal wrote:
> On 6/2/23 00:06, Kishon Vijay Abraham I wrote:
>> Hi Shunsuke,
>>
>> On 1/13/2023 2:33 PM, Shunsuke Mie wrote:
>>> Add an align_mem operation to the EPC ops, which function is used to
>>> pci_epc_map/unmap_addr(). These change to enable mapping for any alignment
>>> restriction of EPC. The map function maps an aligned memory to include a
>>> requested memory region.
>>
>> I'd prefer all the PCIe address alignment restriction be handled in the
>> endpoint function drivers and not inside the core layer (esp in map and
>> unmap calls).
> 
> That is a really *bad* idea ! Most function drivers should be able to work with
> any EP controller hardware. Asking these drivers to support all the alignment
> peculiarities of every possible EP controller is impossible.

Function drivers already work with various restrictions of EP controller 
hardware. pci_epc_features was added to provide such restrictions to 
function drivers. Not sure why it has to be different here.
> 
>> IMO, get the pci address alignment restriction using pci_epc_features.
>> And use a bigger size (based on alignment restriction) in
>> pci_epc_mem_alloc_addr() and access the allocated window using an offset
>> (based on alignment value). You can add separate helpers if required.
> 
> That is too simplistic and not enough. Example: Rick and I working on an nvme
> function driver are facing a lot of issues with the EPC API for mem & mapping
> management because we have 0 control over the PCI address that the host will
> use. Alignment is all over the place, and the current EPC memory API
> restrictions (window size limitations) make it impossible to transparently
> handle all cases. We endup with NVMe command failures simply because of the API
> limitations.

You mean restrictions w.r.t OB window address and not PCIe address?
> 
> And sure, we can modify that driver to better support the EP controller we are
> using (rockchip). But we need to support other EP controllers as well. So API

Every EP controller can provide it's restrictions in pci_epc_features. 
Unless the alignment is going to change dynamically, don't see a need 
for adding new epc ops.

Not sure why the following cannot be handled from function driver?

From

        A                    A + S
         ┌────────────────────────┐
         │                        │
         │        OB WIN          │
         ├────────────────────────┤
mapping │                        │
         ▼                  B + S ▼
       B ┌────────────────────────┐
         │                        │
         │       PCI Address      │
         └────────────────────────┘

To


      A   A'│              A + S      A+S+alignment
       ┌────┼───────────────────┬──────┐
       │    │                   │      │
       │    │       OB WIN      │      │
       ├────┴───────────────────┴──────┤
       │                               |
       │                               |
    B' ▼   B                     B + S ▼
       ┌────┬──────────────────────────┐
       │    │                          │
       │    │     PCI Address          │
       └────┴──────────────────────────┘

So the changes in function driver will be
1) Get alignment value in epc_features
2) pci_epc_mem_alloc_addr()/pci_epc_map_addr() will take into account 
the alignment value (change in size parameter)
3) Access host memory from an offset in the provided 
pci_epc_mem_alloc_addr().

> changes are definitely needed. Working on that. That is not easy as the mapping
> API and its semantic impacts data transfers (memcpy_from|toio and DMA).
> 
> I do have a patch that does something similar as this one, but at a much higher
> level with a helper function that gives the function driver the offset into the
> allocated memory region to use for mapping a particular PCI address. And then
> this helper is then in turn used into a new pci_epc_map() function which does
> mem alloc + mapping in one go based on the EPC constraints. That hides all

pci_epc_map() was added only to perform mapping functionality. I'd 
prefer it stays that way instead of adding bunch of other things into it.

Thanks,
Kishon

> alignment details to the function drivers, which greatlyu simplyfies the code.
> But that is not enough as alignment also implies that we have to deal with
> boundaries (due to limited window size) and so sometimes endpu failing a mapping
> that is too large because the host used a PCI address close to the boundary.
> More work is needed to have pci_epc_map() also hide that with tricks like
> allowing the allocation and mapping of multiple contiguous windows. So EPC ops
> API changes are also needed.
> 
> 
>>
>> Thanks,
>> Kishon
>>
>>>
>>> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
>>> ---
>>>    drivers/pci/endpoint/pci-epc-core.c | 57 ++++++++++++++++++++++++-----
>>>    include/linux/pci-epc.h             | 10 +++--
>>>    2 files changed, 53 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
>>> index 2542196e8c3d..60d586e05e7d 100644
>>> --- a/drivers/pci/endpoint/pci-epc-core.c
>>> +++ b/drivers/pci/endpoint/pci-epc-core.c
>>> @@ -430,8 +430,12 @@ EXPORT_SYMBOL_GPL(pci_epc_set_msix);
>>>     * Invoke to unmap the CPU address from PCI address.
>>>     */
>>>    void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>>> -			phys_addr_t phys_addr)
>>> +			phys_addr_t phys_addr, void __iomem *virt_addr, size_t size)
>>>    {
>>> +	u64 aligned_phys;
>>> +	void __iomem *aligned_virt;
>>> +	size_t offset;
>>> +
>>>    	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
>>>    		return;
>>>    
>>> @@ -441,9 +445,22 @@ void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>>>    	if (!epc->ops->unmap_addr)
>>>    		return;
>>>    
>>> +	if (epc->ops->align_mem) {
>>> +		mutex_lock(&epc->lock);
>>> +		aligned_phys = epc->ops->align_mem(epc, phys_addr, &size);
>>> +		mutex_unlock(&epc->lock);
>>> +	} else {
>>> +		aligned_phys = phys_addr;
>>> +	}
>>> +
>>> +	offset = phys_addr - aligned_phys;
>>> +	aligned_virt = virt_addr - offset;
>>> +
>>>    	mutex_lock(&epc->lock);
>>> -	epc->ops->unmap_addr(epc, func_no, vfunc_no, phys_addr);
>>> +	epc->ops->unmap_addr(epc, func_no, vfunc_no, aligned_phys);
>>>    	mutex_unlock(&epc->lock);
>>> +
>>> +	pci_epc_mem_free_addr(epc, aligned_phys, aligned_virt, size);
>>>    }
>>>    EXPORT_SYMBOL_GPL(pci_epc_unmap_addr);
>>>    
>>> @@ -458,26 +475,46 @@ EXPORT_SYMBOL_GPL(pci_epc_unmap_addr);
>>>     *
>>>     * Invoke to map CPU address with PCI address.
>>>     */
>>> -int pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>>> -		     phys_addr_t phys_addr, u64 pci_addr, size_t size)
>>> +void __iomem *pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>>> +		u64 pci_addr, phys_addr_t *phys_addr, size_t size)
>>>    {
>>>    	int ret;
>>> +	u64 aligned_addr;
>>> +	size_t offset;
>>> +	void __iomem *virt_addr;
>>>    
>>>    	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
>>> -		return -EINVAL;
>>> +		return ERR_PTR(-EINVAL);
>>>    
>>>    	if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[func_no]))
>>> -		return -EINVAL;
>>> +		return ERR_PTR(-EINVAL);
>>>    
>>>    	if (!epc->ops->map_addr)
>>> -		return 0;
>>> +		return ERR_PTR(-ENOPTSUPP);
>>> +
>>> +	if (epc->ops->align_mem) {
>>> +		mutex_lock(&epc->lock);
>>> +		aligned_addr = epc->ops->align_mem(epc, pci_addr, &size);
>>> +		mutex_unlock(&epc->lock);
>>> +	} else {
>>> +		aligned_addr = pci_addr;
>>> +	}
>>> +
>>> +	offset = pci_addr - aligned_addr;
>>> +
>>> +	virt_addr = pci_epc_mem_alloc_addr(epc, phys_addr, size);
>>> +	if (!virt_addr)
>>> +		return ERR_PTR(-ENOMEM);
>>>    
>>>    	mutex_lock(&epc->lock);
>>> -	ret = epc->ops->map_addr(epc, func_no, vfunc_no, phys_addr, pci_addr,
>>> -				 size);
>>> +	ret = epc->ops->map_addr(epc, func_no, vfunc_no, *phys_addr, aligned_addr, size);
>>>    	mutex_unlock(&epc->lock);
>>> +	if (ret)
>>> +		return ERR_PTR(ret);
>>>    
>>> -	return ret;
>>> +	*phys_addr += offset;
>>> +
>>> +	return virt_addr + offset;
>>>    }
>>>    EXPORT_SYMBOL_GPL(pci_epc_map_addr);
>>>    
>>> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
>>> index a48778e1a4ee..8f29161bce80 100644
>>> --- a/include/linux/pci-epc.h
>>> +++ b/include/linux/pci-epc.h
>>> @@ -84,6 +84,7 @@ struct pci_epc_ops {
>>>    			       phys_addr_t phys_addr, u8 interrupt_num,
>>>    			       u32 entry_size, u32 *msi_data,
>>>    			       u32 *msi_addr_offset);
>>> +	u64	(*align_mem)(struct pci_epc *epc, u64 addr, size_t *size);
>>>    	int	(*start)(struct pci_epc *epc);
>>>    	void	(*stop)(struct pci_epc *epc);
>>>    	const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
>>> @@ -218,11 +219,12 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>>>    		    struct pci_epf_bar *epf_bar);
>>>    void pci_epc_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>>>    		       struct pci_epf_bar *epf_bar);
>>> -int pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>>> -		     phys_addr_t phys_addr,
>>> -		     u64 pci_addr, size_t size);
>>> +void __iomem *pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>>> +			       u64 pci_addr, phys_addr_t *phys_addr,
>>> +			       size_t size);
>>>    void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>>> -			phys_addr_t phys_addr);
>>> +			phys_addr_t phys_addr, void __iomem *virt_addr,
>>> +			size_t size);
>>>    int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>>>    		    u8 interrupts);
>>>    int pci_epc_get_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
> 
