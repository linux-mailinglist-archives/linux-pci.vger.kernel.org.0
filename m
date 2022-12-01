Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B81563E978
	for <lists+linux-pci@lfdr.de>; Thu,  1 Dec 2022 06:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiLAFvG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Dec 2022 00:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiLAFvF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Dec 2022 00:51:05 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2061f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e83::61f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D724AA6041;
        Wed, 30 Nov 2022 21:51:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cGYbwsiYPFwBRABaEyVN/ZzsSnnWL4qGQshys+le28oZpfyxFpDnKBHSXJZX2svUE6IrTKB50Jd4P26fHNWRIIrV7tH/8I635sENoWxZ9vrWQg1V+69J0jUtF1abHvKdHzxN2J2sqKcTn9J+YESXEfNuh/0wa+LG8aP+571IxCczZV9a5D22cStT/c1BMF3Sg36ugeTmJFXGThmHQHnS/V+9ZC8BOXyoTwvKseauqaedN2cW6US6UmxSXk1IYOxgNg3JKcuKORSX6nJ6pcXXT+yPnadlbrU1cSCmeHhWl4ntR2/tmwWLwJMp3JggnlHSi2bpJ/OqjyZEohUUolu4oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ooCWVvQJOnvj9VqxzyE9ME/LgXi+C7UZ2SWcBv94K2g=;
 b=nLXJN0Bkey5HYK5DULtx7ncSZrJt2jvV3a7wsvAjK9AgKSWqPkcAVKoU083e/dVwcChvinoSSfV3TUgL5vi+LtGRpFLxTeTf6u/afSAcN61jcTFg4vMqHOni6SOY2hru+NXin6eyCZK36TTNRHE3JZ3etKoM9uftME4mJ7E1RBzGberW5s0EhVl1srBWyJAw9mMHqvzi7eIul4uKE9yfvz3IgMq5xbmELVwlX/VahdgFd1B6uOns5ue5ZPwaVJe5cW/eP3EVvEEahX8DhC5UnI8DWJKHM0b313IuIEzF1QTFGUVhArEeIcOjA8nWLu2Qm7Ndd2Of9omaikZlYiPQGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ooCWVvQJOnvj9VqxzyE9ME/LgXi+C7UZ2SWcBv94K2g=;
 b=FKZHbV5/icLyHTTyow5bQgNq8YdZCYLeBCm6pDrEtlEWFF3ffOdN2UuvSOJSkLKJfyGhOnDuJcjjrIgjajpW/yufKQ8p/7R9DNPKpR0xVDGHqbnEtaQTZH51N0RbryxPsQwVwhpKPxP9Fe5DqheVjgodD89TE45NhhB14dUlSKQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4502.namprd12.prod.outlook.com (2603:10b6:208:263::20)
 by IA1PR12MB6307.namprd12.prod.outlook.com (2603:10b6:208:3e5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 05:51:00 +0000
Received: from MN2PR12MB4502.namprd12.prod.outlook.com
 ([fe80::54ad:ad7f:5fcc:5607]) by MN2PR12MB4502.namprd12.prod.outlook.com
 ([fe80::54ad:ad7f:5fcc:5607%4]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 05:51:00 +0000
Message-ID: <9d21aa8f-6581-a4bf-644a-6e273373afc4@amd.com>
Date:   Wed, 30 Nov 2022 21:50:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RESEND PATCH RFC V4 0/3] Generate device tree node for pci
 devices
Content-Language: en-US
To:     Lizhi Hou <lizhi.hou@amd.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, frowand.list@gmail.com, helgaas@kernel.org
Cc:     clement.leger@bootlin.com, max.zhen@amd.com, larry.liu@amd.com,
        brian.xu@amd.com, stefano.stabellini@xilinx.com, trix@redhat.com
References: <1669048984-56394-1-git-send-email-lizhi.hou@amd.com>
From:   Sonal Santan <sonal.santan@amd.com>
In-Reply-To: <1669048984-56394-1-git-send-email-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::8) To MN2PR12MB4502.namprd12.prod.outlook.com
 (2603:10b6:208:263::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4502:EE_|IA1PR12MB6307:EE_
X-MS-Office365-Filtering-Correlation-Id: 80077780-1686-4a1c-1c65-08dad3600644
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nt6ZDjJDmEF4pbMZF5stcyWy1DgzUBjLGcY7YtlgFJPahkHwREgEhWARaX1wMaoFMQNxO6PkU5ARYv0xJzfzvFyptcu1CoPcz6SgMZp+ng87fbt++TzEvGlBNgIqvrVqStjL+HCIMi16beaU3f/nZoFDA6ZW3lTf/E7/1B8LtwsiYNpLLdsqBS+M5Bw/VLVVa6Ja4RaSJxRuvBKS2WH1UPagL3t6rbarf1OnDxV45o+s0ZTeXiFzXXKW6gsaKdkifM3zO7UWjAbGc5UTJLAgXfhZjfhsERc0EflyaykQtefKzehpv9jTYOJ0rUMJBIdiXCJVeON9za+Ak+VI6mClB1Ridk+g9+cnQ4kJ39tb78lqzcK7avEPb/aZAiPY5Heq8Zwq6D3zKjK+2+KGySIzK0ki0WJYBNcTu8vlcS7H1n/nzE2cGY0LiHh/8jefTiQdhKqoPacwm2lZ/KsanDu/u8vqeby0T2mWWAtHpIajIcNHpFv+wFg664jdm9196DFO1o8Eq/GTyyU6VL1e9UGvzlWmdjNknWRylxvPyeHXQhB7ng/060YrfEMhQxhT7bBXPLNFE1gyjhENWiMgND5z3yPxFhNPR+OVknGIaRTA94IiTJdVtk9HLiBJu21m6Q4hdPsc1O79Iu3U1WNRqr5MJWIpoGpbwQUXth6FZAeDwdk8zHKsO38t2jZif7a3GB2/kyPdU8ASYSTTKtxjCdsAmU7mfTTr+XXXbfWZu6JJWwMUY4+GzrIDqndb/yUlr7VOyxwxI3TLY+C1KNcy04l1yKYh6cj6yNazx8V6DXzbr7i8thYotFPLto4E4ti1zLBd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4502.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199015)(31696002)(86362001)(8676002)(6512007)(6506007)(31686004)(6666004)(4326008)(66556008)(26005)(2616005)(478600001)(6486002)(66946007)(966005)(44832011)(316002)(5660300002)(38100700002)(2906002)(83380400001)(66476007)(53546011)(8936002)(186003)(41300700001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUNjd0lEdEZ4dmdSSCs4N3czUWM5VUJIOHdOR0VKbEc0Wi9idmZjTWdZOFYv?=
 =?utf-8?B?bTFqVjRGL0tyT2JHYmI2YmJOYldOTFAydE5aMkc5dkk0a2h6TldwaXJ2WE5E?=
 =?utf-8?B?bmR2M1RrOGx4NlNXTGFNcG8yMW4rRkFLUHpDS2lUalA1dGtQYXNEZHh3amZa?=
 =?utf-8?B?MllIeTI0aVZ3YnR2ZmVmdnIyNkN4U2ErSVE4NnVtRVNIVnVTcE1OOWNWcTZV?=
 =?utf-8?B?Wk10Zi9iY1ZITDBhd2ZvR2l2M0tlQ3lnMUlrbktvdFFQL3lhWjI5ejlkK1Q1?=
 =?utf-8?B?N3hSLzNNS3N5QnUvZC9DUUJvSnRtMnFOazcrWVZaNDRaTmxzdUY2WXdIUld6?=
 =?utf-8?B?VitTYWh0U29MVGVKMVc4VHVmR3FvWXJ0NzdKL21hakYvTklVWll0cWdUdjBB?=
 =?utf-8?B?YWQ0Uk1Xd3lGcTMrVUpRNXMwZ1d3YVpMbjlsdHJNOWNabVVpeGZFbnBhRjdj?=
 =?utf-8?B?dUJpL3duT3FlQnZlTUVRcGMvMXRvaHNsSG5DOUV2VmgzZmhxcUQxeGxWZE91?=
 =?utf-8?B?R2RtQ1ZibFZlTnRpNnhhTm1zL2toOGtLSjdiaS8zc1ZvMXJ0RWlML2RRS05Q?=
 =?utf-8?B?SzIvV3E2Q2hZRUx4RUVpR2dlM2V6bFJKNC9qWHU1bW5OVnJxOXlmRmxrSDFF?=
 =?utf-8?B?bFhOMGMwUVNETVJ0dlBGTW42WTVRZUhHQXRna25OdEgrbzlJRzR0YWhqQzZX?=
 =?utf-8?B?RXhXTFExS0JsV1lURVh3cEJWMklnV1lwdTMxblpVcllDeEtXelNMdlhRT09U?=
 =?utf-8?B?U3V5N2E2a0xZN0tTZHdjZ0I3bGRnaCs2SENUd1RzQVRkemdJM2NRRExFalR0?=
 =?utf-8?B?bkJJMllOQ25URmNwdFlYTXQrSW9ZWXIyRnhIdE1XMVdrclFpYTFhaS9qRlhL?=
 =?utf-8?B?Wmo0M1BkSTVIQUZZT1l0MGFvQmdJb2dmVS9GQ3VYS2NIR2tvTjFtZW03aXBY?=
 =?utf-8?B?NHBoQzZYSkNrdHVBcGhjTVRUeEJVMUxIb0R1YXkrekk3eGtKL3hvZldvVTZy?=
 =?utf-8?B?QlRFTGRmQ1JRVWdxaWIvVXdHY1YrR0RXQjhhQlRVc3ZzdC83MGdaS1hHSmVq?=
 =?utf-8?B?bmg2TlMwU29DOUp6R2x3WUoweUh3SVZJaHgwbDVaM2FUZWpsZmUzdXh2RUdW?=
 =?utf-8?B?VmFvV3pLZnozZ3J2UldCamtiK1FHZEFWdlZMS1JrWFJGRkczVE05RHVXeWJL?=
 =?utf-8?B?a0Y4TUNTZ2Y0MmFmOHNubmRpL0FTOHpRY0RwNnRFSGYvUW13WldhRVBvWW5I?=
 =?utf-8?B?eHYvMThJZmx1S3lCVjBRbU0rMXNpemExQVpSN2pyTGNCZWs2TTNCR2ZTMlY5?=
 =?utf-8?B?NGRzbXRVWHhrekZGNGFnU1ZGTkNNWEI5OEh6c1l6QWJxc29IUVN2UTBBUW1K?=
 =?utf-8?B?cXlOWlVCZzk4dE5YMFVPV2RUSytjYTMwdnNkVVhueWxFRjF1eXNlZ00zN1Ix?=
 =?utf-8?B?ZEVWY2JCZ3dYelRBWG5mRlJKOExRdldBY29aWjRSUXVKVDBDZWxZbnhCWGh4?=
 =?utf-8?B?cVJBQ2NtU3piMWZza1FiNUJOOTRHcEFWRld6M1JSZWZUQk4wdHRxZXZyN1py?=
 =?utf-8?B?UWhGTlVNSlducXE1cHNhRXlCMTF1YTFVS2hha3N5K05hWHBOb0prZWNjK1li?=
 =?utf-8?B?TExvT3dxSkZDc2dmZldSN3BEK2RaNm5GcXdVYmZlV3J6OTJneUMzNklQRE1x?=
 =?utf-8?B?RWliMWljN2xYc3NrdEpuSS94bncyS2VaVHRwS3djZHRodERzN2wzN1g2Z3JL?=
 =?utf-8?B?V1FwQ1dLZ01ybUIyUzE2U25FNG16UEhyVDk2ZDdHeGMybGN5b0pLYUZhZ2Ja?=
 =?utf-8?B?a2VMU2tSNWM4YmFvWStjQ2dqWW9jUVlPSitDZHBDN0x4dmRaeWdnVHdGUjJP?=
 =?utf-8?B?VlRmdWp6ZCttekxRRHdSKzVEU1V3MkRiSmZnd1lsQnRrVzcvWkM1Q1NIQ1Ra?=
 =?utf-8?B?b3k1SHNDRHB6VVpmWXJkWXp0QkcwYXQrQnp1VjcxWkRjbkdhaitYS05QRmVG?=
 =?utf-8?B?cUh0M0xtdEhibjZMMUlKMHovUXFLcGRYRWl4REloR2EvYlJNQ3d0NlM0ZmdI?=
 =?utf-8?B?NnBRTGpTNTgzTEZnbTk5d0N0QWxHL3ozNFlVSGxKakIxN0FCS0Y1VmxTSE5s?=
 =?utf-8?Q?qwwKmKFa0bTDQd974ATraM/tT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80077780-1686-4a1c-1c65-08dad3600644
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4502.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 05:51:00.3199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OGzDAlaScPavtcIZ+1QdyYbI2leKXTxiK8NXmgrQnEAcsJf5biAQZOJ1GmloavGg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6307
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/21/22 08:43, Lizhi Hou wrote:
> This patch series introduces OF overlay support for PCI devices which
> primarily addresses two use cases. First, it provides a data driven method
> to describe hardware peripherals that are present in a PCI endpoint and
> hence can be accessed by the PCI host. Second, it allows reuse of a OF
> compatible driver -- often used in SoC platforms -- in a PCI host based
> system.
> 
> There are 2 series devices rely on this patch:
> 
>   1) Xilinx Alveo Accelerator cards (FPGA based device)
>   2) Microchip LAN9662 Ethernet Controller
> 
>      Please see: https://lore.kernel.org/lkml/20220427094502.456111-1-clement.leger@bootlin.com/
> 
> Normally, the PCI core discovers PCI devices and their BARs using the
> PCI enumeration process. However, the process does not provide a way to
> discover the hardware peripherals that are present in a PCI device, and
> which can be accessed through the PCI BARs. Also, the enumeration process
> does not provide a way to associate MSI-X vectors of a PCI device with the
> hardware peripherals that are present in the device. PCI device drivers
> often use header files to describe the hardware peripherals and their
> resources as there is no standard data driven way to do so. This patch
> series proposes to use flattened device tree blob to describe the
> peripherals in a data driven way. Based on previous discussion, using
> device tree overlay is the best way to unflatten the blob and populate
> platform devices. To use device tree overlay, there are three obvious
> problems that need to be resolved.
> 
> First, we need to create a base tree for non-DT system such as x86_64. A
> patch series has been submitted for this:
> https://lore.kernel.org/lkml/20220624034327.2542112-1-frowand.list@gmail.com/
> https://lore.kernel.org/lkml/20220216050056.311496-1-lizhi.hou@xilinx.com/
> 
> Second, a device tree node corresponding to the PCI endpoint is required
> for overlaying the flattened device tree blob for that PCI endpoint.
> Because PCI is a self-discoverable bus, a device tree node is usually not
> created for PCI devices. This series adds support to generate a device
> tree node for a PCI device which advertises itself using PCI quirks
> infrastructure.
> 
> Third, we need to generate device tree nodes for PCI bridges since a child
> PCI endpoint may choose to have a device tree node created.
> 
> This patch series is made up of three patches.
> 
> The first patch is adding OF interface to create or destroy OF node
> dynamically.
> 
> The second patch introduces a kernel option, CONFIG_DYNAMIC_PCI_OF_NODEX.
> When the option is turned on, the kernel will generate device tree nodes
> for all PCI bridges unconditionally. The patch also shows how to use the
> PCI quirks infrastructure, DECLARE_PCI_FIXUP_FINAL to generate a device
> tree node for a device. Specifically, the patch generates a device tree
> node for Xilinx Alveo U50 PCIe accelerator device. The generated device
> tree nodes do not have any property.
> 
> The third patch adds basic properties ('reg', 'compatible' and
> 'device_type') to the dynamically generated device tree nodes. More
> properties can be added in the future.
> 
> Here is the example of device tree nodes generated within the ARM64 QEMU.
> # lspci -t    
> -[0000:00]-+-00.0
>            +-01.0-[01]--
>            +-01.1-[02]----00.0
>            +-01.2-[03]----00.0
>            +-01.3-[04]----00.0
>            +-01.4-[05]----00.0
>            +-01.5-[06]--
>            +-01.6-[07]--
>            +-01.7-[08]--
>            +-02.0-[09-0b]----00.0-[0a-0b]----00.0-[0b]--+-00.0
>            |                                            \-00.1
>            +-02.1-[0c]--
>            \-03.0-[0d-0e]----00.0-[0e]----01.0
> 
> # tree /sys/firmware/devicetree/base/pcie\@10000000
> /sys/firmware/devicetree/base/pcie@10000000
> |-- #address-cells
> |-- #interrupt-cells
> |-- #size-cells
> |-- bus-range
> |-- compatible
> |-- device_type
> |-- dma-coherent
> |-- interrupt-map
> |-- interrupt-map-mask
> |-- linux,pci-domain
> |-- msi-parent
> |-- name
> |-- pci@1,0
> |   |-- #address_cells
> |   |-- #size_cells
> |   |-- compatible
> |   |-- device_type
> |   |-- ranges
> |   `-- reg
> |-- pci@1,1
> |   |-- #address_cells
> |   |-- #size_cells
> |   |-- compatible
> |   |-- device_type
> |   |-- ranges
> |   `-- reg
> |-- pci@1,2
> |   |-- #address_cells
> |   |-- #size_cells
> |   |-- compatible
> |   |-- device_type
> |   |-- ranges
> |   `-- reg
> |-- pci@1,3
> |   |-- #address_cells
> |   |-- #size_cells
> |   |-- compatible
> |   |-- device_type
> |   |-- ranges
> |   `-- reg
> |-- pci@1,4
> |   |-- #address_cells
> |   |-- #size_cells
> |   |-- compatible
> |   |-- device_type
> |   |-- ranges
> |   `-- reg
> |-- pci@1,5
> |   |-- #address_cells
> |   |-- #size_cells
> |   |-- compatible
> |   |-- device_type
> |   |-- ranges
> |   `-- reg
> |-- pci@1,6
> |   |-- #address_cells
> |   |-- #size_cells
> |   |-- compatible
> |   |-- device_type
> |   |-- ranges
> |   `-- reg
> |-- pci@1,7
> |   |-- #address_cells
> |   |-- #size_cells
> |   |-- compatible
> |   |-- device_type
> |   |-- ranges
> |   `-- reg
> |-- pci@2,0
> |   |-- #address_cells
> |   |-- #size_cells
> |   |-- compatible
> |   |-- device_type
> |   |-- pci@0,0
> |   |   |-- #address_cells
> |   |   |-- #size_cells
> |   |   |-- compatible
> |   |   |-- device_type
> |   |   |-- pci@0,0
> |   |   |   |-- #address_cells
> |   |   |   |-- #size_cells
> |   |   |   |-- compatible
> |   |   |   |-- dev@0,0
> |   |   |   |   |-- compatible
> |   |   |   |   `-- reg
> |   |   |   |-- dev@0,1
> |   |   |   |   |-- compatible
> |   |   |   |   `-- reg
> |   |   |   |-- device_type
> |   |   |   |-- ranges
> |   |   |   `-- reg
> |   |   |-- ranges
> |   |   `-- reg
> |   |-- ranges
> |   `-- reg
> |-- pci@2,1
> |   |-- #address_cells
> |   |-- #size_cells
> |   |-- compatible
> |   |-- device_type
> |   |-- ranges
> |   `-- reg
> |-- pci@3,0
> |   |-- #address_cells
> |   |-- #size_cells
> |   |-- compatible
> |   |-- device_type
> |   |-- pci@0,0
> |   |   |-- #address_cells
> |   |   |-- #size_cells
> |   |   |-- compatible
> |   |   |-- device_type
> |   |   |-- ranges
> |   |   `-- reg
> |   |-- ranges
> |   `-- reg
> |-- ranges
> `-- reg
> 
> Changes since RFC v3:
> - Split the Xilinx Alveo U50 PCI quirk to a separate patch
> - Minor changes in commit description and code comment
> 
> Changes since RFC v2:
> - Merged patch 3 with patch 2
> - Added OF interfaces of_changeset_add_prop_* and use them to create
>   properties.
> - Added '#address-cells', '#size-cells' and 'ranges' properties.
> 
> Changes since RFC v1:
> - Added one patch to create basic properties.
> - To move DT related code out of PCI subsystem, replaced of_node_alloc()
>   with of_create_node()/of_destroy_node()
> 
> Lizhi Hou (3):
>   of: dynamic: Add interfaces for creating device node dynamically
>   PCI: Create device tree node for selected devices
>   PCI: Add PCI quirks to generate device tree node for Xilinx Alveo U50
> 
>  drivers/of/dynamic.c        | 187 ++++++++++++++++++++++++++
>  drivers/pci/Kconfig         |  12 ++
>  drivers/pci/Makefile        |   1 +
>  drivers/pci/bus.c           |   2 +
>  drivers/pci/msi/irqdomain.c |   6 +-
>  drivers/pci/of.c            |  71 ++++++++++
>  drivers/pci/of_property.c   | 256 ++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci-driver.c    |   3 +-
>  drivers/pci/pci.h           |  19 +++
>  drivers/pci/quirks.c        |  11 ++
>  drivers/pci/remove.c        |   1 +
>  include/linux/of.h          |  24 ++++
>  12 files changed, 590 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/pci/of_property.c
> 
Hello,

This RFC patch set has been patiently waiting for attention. If there
are no additional comments can it move forward?

-Sonal
