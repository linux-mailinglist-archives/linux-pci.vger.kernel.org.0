Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC155E9821
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 05:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbiIZDDk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 25 Sep 2022 23:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbiIZDDj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 25 Sep 2022 23:03:39 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960142C12F;
        Sun, 25 Sep 2022 20:03:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwt2HTYV+qRntwjRl84nfFH/7gUPjQpdsSYY7373fEE/G58VXzbwgpA/hq0jeRX4WXmtPSN2eXi1mALkA9ljb6tOiYBBEdCWPzbmUh+YTK3eux7st0waezvvO+NWu/XDogN8EmwdPqRxWg8YrzJGf2omzy4DeZHqV9731puI5O+RkQnBG3D/ysbECtL844x0yG9gO9xwZVdp7tEGrQi8LWouIbgNz8w3OuDa4mR6a06Y5w//u0dT+oQagCfNdKlse38nqg8RHaDhkMSqb+EosnJljNQcpQnla4Z/zLgEFBQXJ4hQDtxhbzk7YzVeInqMFhRHbtQDZQFufZiWNMf1lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qxLsK8WdASeCxtD7T4nKcedJ8JLppRRTPk5+pr87Vdk=;
 b=VdRn1bOBJYWu1qmXUV5EahDG/IlDLWWgeJF3WtRffTJNQoyS4OL6m8uliQrJkzpsCqy9dyyUMiwBkq7umZoJ2dUEBvSiSZo/B+XiYPegfF8489SHvOJPTifhhzVwbZNlK9qdpsH+0zAf/Rncxe3ZF5VizmtRttLgeQxslRBi3OFrQdTcGRTuN7MwVlUifvP0OAuqRqYVxkgkI3y1fO4VJ559+r6bEs6tQhN/YnlfA/FjZEja2Me0rMfOHxaDj/rvkV6xyVjEfb0PzigrNj0iIEvhCNTYID3JRjT+7iVbojtM5B1GUFGG8PcQtAzBYOGfOb8drVbxvNj4siVn7FD/hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxLsK8WdASeCxtD7T4nKcedJ8JLppRRTPk5+pr87Vdk=;
 b=jfeFUFLp+wgysBu0kYeIz/BEAASWu2o7nOdiAYSZVczJsCDikZwFLnAEAOz9EPow5sh7HGWwo1tWaNA/AWZ2n1VV/vTNCycZkqzv6fI38anf9DxtY0UDxa6ImCEVCympDT2TQkXFjEAcvLyLtP0Qrf+wfq9k/c8VV3o6/2dhsBY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4502.namprd12.prod.outlook.com (2603:10b6:208:263::20)
 by DM4PR12MB5939.namprd12.prod.outlook.com (2603:10b6:8:6a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 03:03:33 +0000
Received: from MN2PR12MB4502.namprd12.prod.outlook.com
 ([fe80::ac92:e220:f51c:895]) by MN2PR12MB4502.namprd12.prod.outlook.com
 ([fe80::ac92:e220:f51c:895%5]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 03:03:31 +0000
Message-ID: <40d45c78-d365-f3b4-43bb-c3b5dd6a11ec@amd.com>
Date:   Sun, 25 Sep 2022 20:03:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Sonal Santan <sonal.santan@amd.com>
Subject: Re: [PATCH RFC 0/2] Generate device tree node for pci devices
To:     Frank Rowand <frowand.list@gmail.com>, Tom Rix <trix@redhat.com>,
        Lizhi Hou <lizhi.hou@amd.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, helgaas@kernel.org
Cc:     clement.leger@bootlin.com, max.zhen@amd.com, larry.liu@amd.com,
        brian.xu@amd.com, stefano.stabellini@xilinx.com
References: <1661809417-11370-1-git-send-email-lizhi.hou@amd.com>
 <1d9faa2e-e3fc-d104-c85f-4035233848d6@gmail.com>
 <ca35a14d-501d-265e-b196-a87e1e994cd0@amd.com>
 <78211af5-171c-ef4f-a8c2-17f63dc479bc@gmail.com>
 <8bee1ddd-0a84-62cd-9beb-3bbb09d83de1@amd.com>
 <f042a8d7-fa2b-3e75-a2f2-6e6ba28a9b38@gmail.com>
 <7393f2f3-3af5-edf9-4afb-8acc0a8db1e7@redhat.com>
 <2c3743cc-f29b-6cc9-d6b8-992cca69b60f@gmail.com>
Content-Language: en-US
In-Reply-To: <2c3743cc-f29b-6cc9-d6b8-992cca69b60f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH0PR07CA0054.namprd07.prod.outlook.com
 (2603:10b6:510:e::29) To MN2PR12MB4502.namprd12.prod.outlook.com
 (2603:10b6:208:263::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4502:EE_|DM4PR12MB5939:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e072fa6-27ca-4263-c17c-08da9f6bb156
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zpcb1gGfXK21kzmCxt4fMZXr3+OzUgibOrqll1jsKdutTfAq9IKZb3sM56oLwbQPyiHRBgFU/sCAiqucFkJBi06FeGHTpiQwg1hri3E/frKJx8IqNvURQWAIsLr2/RNiyNXJD+jzpyYDmJs3PHlap1uA9gb9GkJJLm984H0JNwLBM3J7PglX41q0MqETkxk+uragjMkFjaRHl64FDAnMM1fhvpMB/JSb/c0LMfz582LoF3UHUuVYV/ao0U0mJ0tPXALISBztkQYuK3+BrSCCbS2E7A5DKDuQtba69DM5mvMY10fpXPuzplQe1zgiHlrIBL0MsoppR1PtsEVszxambCG71hFaPttFouBA4lUt5j8qzhjKcce/KmteFIdYRY/GoC7sXuoZhP+SktAxJM0eGp8788QaeJXQF1kSR7S+McsCnTL0/UGmRYVvU6znq9E4EhbP9CC/kucl2OL2kKhax6ALJgCv2sbTnS425ig4q6IJPDOr2cnYGOms2SIqw3RrJsjzkUt6C7/87S0w4udWpox5k3bOs3ikcSuE7qSLmyNTiKfuLsSsU7x/hL0r36xQ8ktorSCJ5/EgmeEt4+scYFXgzG/kdnxL4Tu9Lc6JcurC6ZHhsftkI8YyOVY0/IHxO3h4t0N7UHrVdW7yxn6DDf6kTxDxMwBdUQPMY7dM8dK3j+D7CW+T7X94ZQK6m07EC9KgzHQ5EQhBIke/6ectF9iqVIqDkNJv9y5Xj5ihFoY9AkuvsmsNMPbXyY78cr2oPqXLdo9IJ8agZykh0XmqZOgCu2VO98Q+QxFSiN1Y7QYsxr+htQpTFOjNmbxwIA0SCFsXz9PokQ8CsvBW7a/ENWFKQ4eZoXy0iMZDo15Fl2QVHl/6GnaIHzYYrfvShS4+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4502.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(451199015)(478600001)(53546011)(41300700001)(966005)(6486002)(6506007)(6666004)(107886003)(83380400001)(66574015)(186003)(26005)(2616005)(2906002)(30864003)(44832011)(6512007)(5660300002)(316002)(110136005)(8936002)(66946007)(66476007)(66556008)(4326008)(8676002)(38100700002)(86362001)(31696002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUxRaEp0SGQ4djIxQk9mMjNIVzY4YTZCaWc4TzJvYm10V2hRZmtNZGUwRUdm?=
 =?utf-8?B?NHYyb1h1T3hGYWVFN3ZVS2NnRWY1NGoxY1hxUXdvTzhZNVhkdUhNTEQ0YWxQ?=
 =?utf-8?B?SExVTUVJYVBKT2UyakgvRXdVWGlFQ2hlNk5UbFlXYnRxZUZJUGtuSzkxRE1E?=
 =?utf-8?B?ZVNsMFhVY1BEa25NdWdqVkxpN0VrZGptQU4rRlhabGh2eUlFYUluK2E3emtR?=
 =?utf-8?B?WG1LSnBoZm5vZW1Kc3BaOUM3RWxNVGt5QW1FWUJNd0dKSEJxRklJc0tEczRD?=
 =?utf-8?B?alpWRmFaU1kwaU5WRnJRVVpVZmpwRXF2QWFZZ3lqRW9HK3NQbGhMbHJ5M2lk?=
 =?utf-8?B?RWtGNVUxNytuOXVRMGkvaWo1dlh0U3JjYnBFU1B2MlRMQVNOMEdhTlJmUWZL?=
 =?utf-8?B?c05vdmtCZllFYkNmSGZsd3kwYnlXYXIwM0doc0RtYWs4NjJXUDBTZG0vandL?=
 =?utf-8?B?SGwyTVROSER2dEtkNnVNc05vTXAvbkhoTlcrU3BqZ09Cci91ckdUaGxiNFVo?=
 =?utf-8?B?dVRFVzJlOUVGYmlZM1l6RGdmM1RCMmF3dEtrT3ZKaWFTOEFJOXFacS83bE0r?=
 =?utf-8?B?N1d1MUNkYW8xR1ZPY2ZTZzlhR0pVNE5EdWtRb3BuUURzSmczTTMvck8vcDMv?=
 =?utf-8?B?cm5pRHdMbjAxVE85R08xTVMrRm5BVjBBbGRXelBhWWZJcFM4dk8xcXM5d2ts?=
 =?utf-8?B?U2gyUVBlVGJBaHZzUWJtVjVsNlZhYUF0dzRNU1lkM2JYZ0NlMEg5QmpxRGVk?=
 =?utf-8?B?eENCWEpnL2lLUDVubXlzZUtVZzA5WEFVYjVuVGFUbDJLSkxnR0djcEVIRVdZ?=
 =?utf-8?B?ODhYRFUyYk5yMCtTQXE0Vmc5R1RZQyt5RmN6dWoxbUdXdWVKS1U0OEJ3V2dU?=
 =?utf-8?B?Wnh3Uktnc3lTaElzcXNTRlA3UE1pRlgwdDJxNlFsYlVON2xjTmhMeWRpSDFy?=
 =?utf-8?B?aGdzMHJkQW02RWY5azY1cUltYUdYUm9YSE9ScVB5UzRjSzhnWHBqZVR0ZEk5?=
 =?utf-8?B?QnMzQjZqMUNPVlpITlgrNjRKR01JbTJQc1dhbmRxUnAycVIrUnpwa01yV3Zy?=
 =?utf-8?B?L2t6OGg2U3c1cHl6NjJoajNhUUw0MUtGeWVZZHZaWmhucjJnOHovaWg5Tm15?=
 =?utf-8?B?aHVXYVdyOURyYnpDYmNhVDRLZ3lVdllUV3I2WlJZSDN5RDl3SmptRXV1MTJD?=
 =?utf-8?B?UmNGdGovcmRkdFNuR3FCZlhPQk1zd0ZOYWlrb2FpdHMvWE5mbDVnNzJCZFg3?=
 =?utf-8?B?YkJueElHZUQ5MHBGeFEvMDRSYXZOVGtPWExub1R6Z25wdkFsT3RjbnNCOEhl?=
 =?utf-8?B?elhFdDBSb1pOK0NUa2c2aEZocXFBL2lWdWgyZW9JSWNDYTZ6ZSt3Yy9vdjhO?=
 =?utf-8?B?dWl2UVBoWXNNZUI4RjNwbndFQmVUUU9WWTBiTjkvMXR5RUlNeldUT1B2NnV4?=
 =?utf-8?B?M0VuaFBjQ2p3L1V5cUQ4WXMxRVZFdUthR3k0cUpTS28vZkc0c0ZISnQ3akVl?=
 =?utf-8?B?MUIzVUNpTlMrK29YRXcyNWhKbGhMUDFOSXF3V09PZXVrSStmS3NZZ1BCNk43?=
 =?utf-8?B?OUpvWEsrNnd2V1lpelQ5SDd1UDJPS29XYVJJQ1pVbnBsZ3JvVDNzZWhiWHZy?=
 =?utf-8?B?YkF3aDlIZm4xeFpUMkNGNEc3dGFrenNVNUF5aTRab2Z0S1grY3duV0VGRHAx?=
 =?utf-8?B?WDEycWZQTm9XMW5yYjRnSkpCTTNrZnpyaFVCTXJibjAxY0xHbUZPZFNlRkY4?=
 =?utf-8?B?MFhwR25ISzF0VndzTFk0Q0gzMThkSlJjRkREcDZOd1B3WmRRSWZ3QVYxTVEz?=
 =?utf-8?B?Rys2Wk9NL0IrcVhHVWd4RHlNc010NnRVNFBKb1hPdFVmcURuU3MxRUcvbFBX?=
 =?utf-8?B?T0pBaFZaWi9MV3UzbHFYOUdRZXhCWWQ5TmQ5bHNOYlJBUWFIVTNEZTFZeXRo?=
 =?utf-8?B?VVlwY0pXejkxZmFJQks5UFJ3R2x0dXZWclU0Q1BCSzRReThnR0tSR1JFells?=
 =?utf-8?B?ZlRDdTF0RFBTYXhscGIvdTkyRFp3UHk5T0QyWWhFSkRxME1oRk1OZFpzYytR?=
 =?utf-8?B?RlVZT200NXhlR0o4b3grWDMvbjlxdTlVOTN4bzU3bWkyaDVRaUVUQm56cDJD?=
 =?utf-8?Q?WRgnJNRVY7oFQtYR7gqwdlQqO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e072fa6-27ca-4263-c17c-08da9f6bb156
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4502.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 03:03:31.3946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uWz7LbgWOx6Ms1rq5Y4YkgquPtGXrJawUqpKtNZbOfkT/wqWhzEE8bl4xlK74qFt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5939
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/19/22 20:12, Frank Rowand wrote:
> On 9/17/22 13:36, Tom Rix wrote:
>> Frank,
>>
>> On 9/16/22 7:23 PM, Frank Rowand wrote:
>>> On 9/13/22 16:02, Lizhi Hou wrote:
>>>> On 9/13/22 10:41, Frank Rowand wrote:
>>>>> On 9/13/22 12:10, Lizhi Hou wrote:
>>>>>> On 9/13/22 00:00, Frank Rowand wrote:
>>>>>>> On 8/29/22 16:43, Lizhi Hou wrote:
>>>>>>>> This patch series introduces OF overlay support for PCI devices which
>>>>>>>> primarily addresses two use cases. First, it provides a data driven method
>>>>>>>> to describe hardware peripherals that are present in a PCI endpoint and
>>>>>>>> hence can be accessed by the PCI host. An example device is Xilinx/AMD
>>>>>>>> Alveo PCIe accelerators. Second, it allows reuse of a OF compatible
>>>>>>>> driver -- often used in SoC platforms -- in a PCI host based system. An
>>>>>>>> example device is Microchip LAN9662 Ethernet Controller.
>>>>>>>>
>>>>>>>> This patch series consolidates previous efforts to define such an
>>>>>>>> infrastructure:
>>>>>>>> https://lore.kernel.org/lkml/20220305052304.726050-1-lizhi.hou@xilinx.com/
>>>>>>>> https://lore.kernel.org/lkml/20220427094502.456111-1-clement.leger@bootlin.com/
>>>>>>>>
>>>>>>>> Normally, the PCI core discovers PCI devices and their BARs using the
>>>>>>>> PCI enumeration process. However, the process does not provide a way to
>>>>>>>> discover the hardware peripherals that are present in a PCI device, and
>>>>>>>> which can be accessed through the PCI BARs. Also, the enumeration process
>>>>>>>> does not provide a way to associate MSI-X vectors of a PCI device with the
>>>>>>>> hardware peripherals that are present in the device. PCI device drivers
>>>>>>>> often use header files to describe the hardware peripherals and their
>>>>>>>> resources as there is no standard data driven way to do so. This patch
>>>>>>>> series proposes to use flattened device tree blob to describe the
>>>>>>>> peripherals in a data driven way. Based on previous discussion, using
>>>>>>>> device tree overlay is the best way to unflatten the blob and populate
>>>>>>>> platform devices. To use device tree overlay, there are three obvious
>>>>>>>> problems that need to be resolved.
>>>>>>>>
>>>>>>>> First, we need to create a base tree for non-DT system such as x86_64. A
>>>>>>>> patch series has been submitted for this:
>>>>>>>> https://lore.kernel.org/lkml/20220624034327.2542112-1-frowand.list@gmail.com/
>>>>>>>> https://lore.kernel.org/lkml/20220216050056.311496-1-lizhi.hou@xilinx.com/
>>>>>>>>
>>>>>>>> Second, a device tree node corresponding to the PCI endpoint is required
>>>>>>>> for overlaying the flattened device tree blob for that PCI endpoint.
>>>>>>>> Because PCI is a self-discoverable bus, a device tree node is usually not
>>>>>>>> created for PCI devices. This series adds support to generate a device
>>>>>>>> tree node for a PCI device which advertises itself using PCI quirks
>>>>>>>> infrastructure.
>>>>>>>>
>>>>>>>> Third, we need to generate device tree nodes for PCI bridges since a child
>>>>>>>> PCI endpoint may choose to have a device tree node created.
>>>>>>>>
>>>>>>>> This patch series is made up of two patches.
>>>>>>>>
>>>>>>>> The first patch is adding OF interface to allocate an OF node. It is copied
>>>>>>>> from:
>>>>>>>> https://lore.kernel.org/lkml/20220620104123.341054-5-clement.leger@bootlin.com/
>>>>>>>>
>>>>>>>> The second patch introduces a kernel option, CONFIG_PCI_OF. When the option
>>>>>>>> is turned on, the kernel will generate device tree nodes for all PCI
>>>>>>>> bridges unconditionally. The patch also shows how to use the PCI quirks
>>>>>>>> infrastructure, DECLARE_PCI_FIXUP_FINAL to generate a device tree node for
>>>>>>>> a device. Specifically, the patch generates a device tree node for Xilinx
>>>>>>>> Alveo U50 PCIe accelerator device. The generated device tree nodes do not
>>>>>>>> have any property. Future patches will add the necessary properties.
>>>>>>>>
>>>>>>>> Clément Léger (1):
>>>>>>>>       of: dynamic: add of_node_alloc()
>>>>>>>>
>>>>>>>> Lizhi Hou (1):
>>>>>>>>       pci: create device tree node for selected devices
>>>>>>>>
>>>>>>>>      drivers/of/dynamic.c        |  50 +++++++++++++----
>>>>>>>>      drivers/pci/Kconfig         |  11 ++++
>>>>>>>>      drivers/pci/bus.c           |   2 +
>>>>>>>>      drivers/pci/msi/irqdomain.c |   6 +-
>>>>>>>>      drivers/pci/of.c            | 106 ++++++++++++++++++++++++++++++++++++
>>>>>>>>      drivers/pci/pci-driver.c    |   3 +-
>>>>>>>>      drivers/pci/pci.h           |  16 ++++++
>>>>>>>>      drivers/pci/quirks.c        |  11 ++++
>>>>>>>>      drivers/pci/remove.c        |   1 +
>>>>>>>>      include/linux/of.h          |   7 +++
>>>>>>>>      10 files changed, 200 insertions(+), 13 deletions(-)
>>>>>>>>
>>>>>>> The patch description leaves out the most important piece of information.
>>>>>>>
>>>>>>> The device located at the PCI endpoint is implemented via FPGA
>>>>>>>        - which is programmed after Linux boots (or somewhere late in the boot process)
>>>>>>>           - (A) and thus can not be described by static data available pre-boot because
>>>>>>>                 it is dynamic (and the FPGA program will often change while the Linux
>>>>>>>                 kernel is already booted
>>>>>>>           - (B) can be described by static data available pre-boot because the FPGA
>>>>>>>                 program will always be the same for this device on this system
>>>>>>>
>>>>>>> I am not positive what part of what I wrote above is correct and would appreciate
>>>>>>> some confirmation of what is correct or incorrect.
>>>>>> There are 2 series devices rely on this patch:
>>>>>>
>>>>>>        1) Xilinx Alveo Accelerator cards (FPGA based device)
>>>>>>
>>>>>>        2) lan9662 PCIe card
>>>>>>
>>>>>>              please see: https://lore.kernel.org/lkml/20220427094502.456111-1-clement.leger@bootlin.com/
>>>>> Thanks.  Please include this information in future versions of the patch series.
>>>>>
>>>>> For device 2 I have strongly recommended using pre-boot apply of the overlay to the base
>>>>> device tree.  I realize that this suggestion is only a partial solution if one wants to
>>>>> use hotplug to change system configuration (as opposed to using hotplug only to replace
>>>>> an existing device (eg a broken device) with another instance of the same device).  I
>>>>> also realize that this increased the system administration overhead.  On the other hand
>>>>> an overlay based solution is likely to be fragile and possibly flaky.
>>>> Can you clarify the pre-boot apply approach? How will it work for PCI devices?
>>>>>> For Xilinx Alveo device, it is (A). The FPGA partitions can be programmed dynamically after boot.
>>>>> I looked at the Xilinx Alveo web page, and there are a variety of types of Alveo cards
>>>>> available.  So the answer to my next question may vary by type of card.
>>>>>
>>>>> Is it expected that the fpga program on a given card will change frequently (eg multiple
>>>>> times per day), where the changed program results in a new device that would require a
>>>>> different hardware description in the device tree?
>>>> Different images may be loaded to a FPGA partition several times a
>>>> day. The PCI topology (Device IDs, BARs, MSIx, etc) does not change.
>>>> New IPs may appear (and old IPs may disappear) on the BARs when a new
>>>> image is loaded. We would like to use flattened device tree to
>>>> describe the IPs on the BARs.
>>> That was kind of a non-answer.  I know that images _may_ change at
>>> some frequency.  I was trying to get a sense of whether the images
>>> were _likely_ to be changing on a frequent basis for these types
>>> of boards, or whether frequent image changes are likely to be a
>>> rare edge use case.
>>>
>>> If there is a good design for the 99.999% use case that does not
>>> support the 0.001% use case then it may be better to not create
>>> an inferior design that also supports the 0.001% use case.
>>>
>>> I hope that gives a better idea of the reason why I was asking the
>>> question and how the answer could impact design and implementation
>>> decisions.
>>>
>>> As a point of reference, some other fpga users have indicated a
>>> desire to change images many times per second.  The current driver
>>> and overlay architecture did not seem to me to be a good match to
>>> that use case (depending on the definition of "many").
>>
>> I would rather we cover 99.999% now.
>>
>> My understanding is that the subdevices are flexible but fairly
>> static and the frequency Lizhi mentions would cover development
>> uses.
>>
>> In production I would expect the image to change about once a year
>> with the same order of magnitude as firmware.
> 
> Thanks for this info, it helps a lot.
> 
>>
>> Can you point me to a reference of a user case with high frequency
>> images changing that also depends on pci io device changing?
> 
> I actually don't have references to any previous PCI devices that are
> based on FPGAs, let alone with a high frequency of images changing.
> 
> The Alveo devices are the first such devices that have come to my
> attention.  Note that this is a technology space that I do not
> follow, so my lack of awareness does not mean much.
> 
> I do not remember the specific discussion that was asserting or
> desiring a high frequency of image changes for an FPGA.  The
> current overlay architecture and overall device tree architecture
> would not handle this well and/or robustly because (off the top of
> my head, hopefully I'm getting this correct) the live system device
> tree does not directly contain all of the associated data - some of
> it is contained in the unflattened device tree (FDT) that remains in
> memory after unflattening, both in the case of the base system device
> tree and overlay device trees.  Some of the device tree data APIs return
> pointers to this data in the FDT.  And the API does not provide reference
> counting for the data (just reference counting for nodes - and these
> reference counts are know to be frequently incorrect).
> 
Thanks for pointing out the limitations of the current overlay 
architecture. Can a careful orchestration of overlay creation and tear 
down by each driver address the limitation? I did see another user, 
drivers/pci/hotplug/pnv_php.c, which seems to be using the overlay 
infrastructure in this manner.

What is your suggestion to move forward?

-Sonal

> In general I have very little visibility into the FPGA space so I go
> out of my way to notify them before making changes to the overlay
> implementation, API, etc; listen carefully to their input; and give
> them lots of opportunity to test any resulting changes.
> 
> -Frank
> 
>>
>> Tom
>>
>>> -Frank
>>>
>>>> Thanks,
>>>>
>>>> Lizhi
>>>>
>>>>> Or is the fpga program expected to change on an infrequent basis (eg monthly, quarterly,
>>>>> annually), in the same way as device firmware and operating systems are updated on a regular
>>>>> basis for bug fixes and new functionality?
>>>>>
>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>> Lzhi
>>>>>>
>>>>>>> -Frank
>>
> 

