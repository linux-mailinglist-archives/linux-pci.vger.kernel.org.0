Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C77272FB42
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jun 2023 12:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbjFNKjj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Jun 2023 06:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjFNKjh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Jun 2023 06:39:37 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2046.outbound.protection.outlook.com [40.107.212.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFBBA7;
        Wed, 14 Jun 2023 03:39:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7HSd/JBKHJ1Yb8zYo5BakxInzzmtRst6mBcm2p/dMQfCOJoPkl2WAFvDnPx4JSeoM5kpMJAZIjmdxuE2g2KqpvjisjnhfRWgE8hfLQ/ow98IjFOG76UU8kEI9L006cZQIMTYMu1ybyWj2xe7FZfLs/jD7TwNi65bqoZiAX6aJPan7H9QJd/Guc9NzTkq+h1LMyYEXTFNUE38xJqx6o3CKX6jQsh3OsX190yYE7W2sryCP03B4vjYdM1hPCUJBrL5fDUsb4jde3Xz6CsdSOKEeDgFlguAuTILIDV6Nh6fYZnhLyaUyaUhWvkbI0LlwPLiu/OjQTYQUX4F1w/mwjJDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wkei8I3sECOslxpaqFB9D+qot467O9SfPNR4y8LZJUA=;
 b=Y1vyvDqPrf/j0nUZ7BjsbV8OpVOv56Gk0j9ymNfo86ycBa8CWBuEZddceH0fBUdnWn3H8Ce1OiU4Fa++nZCviue3oPc432YX9o1zJimwVriCykLK4fI7deEmgFkQIR352yag4ZOW3vwtC0oMhGff6SUDD3ZHGyNAfsEta6wcnOuzJ6qu/ReqA/0FXHw9HiJN6kF8ie8wZSoPlyLIEof52Se97q1QOmkY0ARzNQk1DJZsEJjU5GbVoaVMKHbpS3jSmqrz4U7ryq4FEB22MJNUpG34bm8WO04nXnV9s2da26166KEbMq0xzVpM5jjJqhTVkdedEWejpHYIq4OGIVIFWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wkei8I3sECOslxpaqFB9D+qot467O9SfPNR4y8LZJUA=;
 b=QhKgImSzizUNl6NCtKy153UZ1dYIASKvNtGqpNKaXB1e+89ZXmSoDuNEJyXXnZIJ5STtGCWBZIi5dtWKsJajCLO5gWn/JFeagD6UiZ9/AUJGEUNpS0nr7xFbwxFFO0L3npR1ee5Rqstrw6W1nFKCLpi4wXCU+Yr1glJFqyFOPUpxgX8l6JXz2o0HUSwU4MkCOFd3vO0AiZzABHSZaFlEn53vsH8XGxtTjuRIXllCW7bhcG8ZKd2ZKjNa+S1LFgFiZNiTplO8hLySVEjs8WkMFUV4YVxKyMYHINt+orU9aXNobdN/c7VwULdvI+yNsZZVDiiwOWBW+FE+4i9rBGthfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CY8PR12MB8244.namprd12.prod.outlook.com (2603:10b6:930:72::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.46; Wed, 14 Jun 2023 10:39:28 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::21ef:9d59:5b2d:f1e8]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::21ef:9d59:5b2d:f1e8%4]) with mapi id 15.20.6477.037; Wed, 14 Jun 2023
 10:39:28 +0000
Message-ID: <c88ee580-2062-1afd-dab4-967750ef26c5@nvidia.com>
Date:   Wed, 14 Jun 2023 11:39:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V1] Revert "PCI: tegra194: Enable support for 256 Byte
 payload"
Content-Language: en-US
To:     Vidya Sagar <vidyas@nvidia.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, thierry.reding@gmail.com,
        Sergey.Semin@baikalelectronics.ru, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20230608163346.GA1204586@bhelgaas>
 <5bf550a9-146e-ad51-bbeb-c55b48478f62@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <5bf550a9-146e-ad51-bbeb-c55b48478f62@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0090.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::30) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|CY8PR12MB8244:EE_
X-MS-Office365-Filtering-Correlation-Id: 08c30374-e926-42ba-c728-08db6cc3a0ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v9AWcy4KvPkMxONgWWBwU2IoKh3sYXVVwsJaE0lOgaEQ0PTQfGaTMstkTEk59EetblgKAbSXtPROb6IQ2TAmg2y5NBScDB2kVjAPX2TIWxs7+XlR6Yt6/ZDxPAl7BZ48xN1Whj/w2mOVubW26x8Itur3AVJGTM8ET+pN7LAA6xO8ALQi3FWlMlYR4wNOhm60N3h+Adj24lT7lKF+i+cwdiXckT4bzzXyMAlN+PH65/LHVH2sqXQc/f/hTaWc2yBUDXA1ylqqyJVQKSM13LtSE+N5HBV2+X0I1PN94r+dvOgw79zCAHR2kXJUaRbbEfs7axfxCES10v/YbuhIwXQVdwxR+mimrCI4HUXQKICx6wvyQGwDiivnT9ERq5hC8Z8qkMtE9i0uNIeSb0Fhoe3YkeBhxFekcX83Y0Gy5KkAXRR4KEa3KkMqg9vc6jzw/snJc38j/DYvcngMn5T6Hcw6axw7obVyrkm5blu+DnkWHCrhXflo8uHgvc4xUG7JxNPYvOhLGDYwkMqsn6VXMP1g5f1o0F6Js7+pVLkx5MW/lw9uc0s4WIeCtqIMb+gVQpc08+1nnQPymCYXfXwB5TKISpU/cGJ+AlGTlOBFrHmhj1N5IFOLogenokLHueyWnqfGpv3kCzfCQ4BYoVOXBG8/Lw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199021)(8936002)(31686004)(66476007)(4326008)(41300700001)(38100700002)(5660300002)(66556008)(66946007)(8676002)(2906002)(110136005)(7416002)(316002)(478600001)(31696002)(86362001)(6506007)(6486002)(6666004)(186003)(53546011)(6512007)(2616005)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWhlTzhSa094KzIrZXpYRkhXTGRMYVljNWhmdjBwSUFzZHpmVzlJVzVhUmp6?=
 =?utf-8?B?MlYyekM3LzNXY3A2K3JNK2ZOamhZZDgzd2VudE8xNnRua1lPYlByejl3cHh1?=
 =?utf-8?B?TzJOWnRyNGpYVVUrbFNFTzVIMTR3Y29uZWNGRFRSSmVPVnRTTXloNWRaUktx?=
 =?utf-8?B?aHRKaVllaWtBRGkza2lnRHJPOUlNMzFuNERCb28yZC83REpoa0U3U2VZbExY?=
 =?utf-8?B?cHM1M2xKQUZHK1ZJOTFKSWtaUDZiRUdBdzB0K3RtYVJ6dEFmOTFMVVF6eFc3?=
 =?utf-8?B?M3IwSi84b1BDaFlKTkVaZTREQjk1eit3aWRkZjVVS2lKeEFqemxrN3VlY0ln?=
 =?utf-8?B?Z2Nqbm16RzRGMVhhbFhPT2VSakJ5c1ZnQlllS2Z3TVQ4cmkwdWJvSXhERlV0?=
 =?utf-8?B?OUkvQ21hSTVnOU9lTUh6NUN1SmxXU3VtODdXeWJWcUdCcE9HWUhQajBKTkxo?=
 =?utf-8?B?V29KOCtIVVZZdklrbU9mZ1ZnSXFJbklsTEx5aFk2eEJoSkZtOUZYaWlJcGdV?=
 =?utf-8?B?aUo4VjFIdEZjb29BVGdWWmxrZGpVV3kra09FZnU0RWxHRWwxdUlMTTJyeWZn?=
 =?utf-8?B?U2hLZVNOeWdZcjBmVFdtU0QxOGxPSWQ3UnV1NHNvS3ZhN3RlVjZCRjhmODJN?=
 =?utf-8?B?M2QxNXVxZDZlOGx5YzNnS2RKa2kySWVFeGF1VzRaeVdpZkxqSzFZMlR2cExs?=
 =?utf-8?B?YW9xVXgwN0dwd1haZ0V3SWlmSEd2c0VmV0VuaVF4Q1FZZHM4cnhub1crdnR0?=
 =?utf-8?B?d1lMaUp2YmdiNFpLNEdyU2Q1MTR6Y2pQRUwwZSszblNYM3N0Qm51R1FWSVV1?=
 =?utf-8?B?TXhmOXdFOEUzQ3h6VGhZVW1KZkxIalNwZnBqbUg0aG5yR3VJbUdyS1lsSEtQ?=
 =?utf-8?B?L3BXeitKTU0vNHhBYjd1V0p3VFZLdXRZR1EzN1N0OTVGUGlxWVJrYWU0Nzll?=
 =?utf-8?B?dmd6RjdTUnNiOHlHSzRJZklFS1ZlWGE2QVhBYkQxYll5NnkwdG1ST3lmNHRR?=
 =?utf-8?B?OWNvL0VBSjQwbjJnb3lFaVJDcVhpVGtIQ0IxMVN3WmQvbWd1K21CM3lVRDZJ?=
 =?utf-8?B?YnhGZThLMzduWlNKSGlTeHg1UGdmS0VNRFQra0xzZ0k3cm10WitrTDBIVEl4?=
 =?utf-8?B?L05wMHJ2YTR6dTcvL1MyMXNldytqYitqUERwa1REWFNSQmdKekk5emxWbXZr?=
 =?utf-8?B?NkxLVUhjWWNkRWtxWm5scE41K0NFOVdlTElmZW4xamY0RVE5UlJPenFSVnVp?=
 =?utf-8?B?VEx5KzBkN2ovLzBCU1FiZGk2dWJoR2ZNaXFna2hUbGx4QTFYdmdtVTBGY2xa?=
 =?utf-8?B?V2krQkp6VFF3WGg1MitpZklYUTlyMWhzb3ZTdEtlY0hFckNlNkp0UEoxSFdF?=
 =?utf-8?B?b2ppbVJLMG9ZSFZEWHRXTE0rRDE5aGFybWRQS2Y3UTJObFlUTDdkU1lhMytw?=
 =?utf-8?B?bUNCMVZnTVNNbUdUMHNtOHBvVUdBdng3MlVPYmxFNHREdHphd1lRTk4wK2hh?=
 =?utf-8?B?MVZDZ0pMM05PZ2dMamxrQ0UwZzZSYjVNL0NEN0h4N1BUcVN1RktPQlFrK01a?=
 =?utf-8?B?WUNSNmF1dTNieWNBSm5PSjE5RmI4UzlyZlRyUE9LV25TTFpxYWw4SlFkTDhF?=
 =?utf-8?B?NUxjUmd4M0Y3Q3dFSFE3ZCtZeG1id2tkeHI2Y05qM2Q3bzlMUGQweHk0bDFL?=
 =?utf-8?B?amZFWk5XQWZkNEdWdXZ5M1UrSHlLTlFkQUtNRGFsL2dGbTZ4djhRZVZPam9P?=
 =?utf-8?B?WUU3WmlSYWRkeVFPa2xBR3piU01sMWcrYXVrM0VtemgrcDdTcmRMMmJpejFs?=
 =?utf-8?B?TWlLWXIvMGs1S1JSbTFZNHJUNVBkdW1GY29qa0l6dVNhaHdiSDlKUXRpdk1t?=
 =?utf-8?B?WWlqSGswWE9BbGU5RFA4cW9MbmIxOElCOGQ3T0lySWdhcjZNQ2ZOQVVrUmh0?=
 =?utf-8?B?Q2R2My9VbmZ4T1VxamZlZWg2T2xpdStIaUY5NXVyd0M2bGozZHNETjhkL05W?=
 =?utf-8?B?RFoyb0RnRzE4c2hSQ1dHZ3JCZEVWL3g5Mllyb2F5dEhKQmZtQ2U0dHBGUFpU?=
 =?utf-8?B?MjR5SU1ucldMRityQmN4eEFRLzJyb1R1ay96RGthT25ERkUrUWw2ejdaNCtS?=
 =?utf-8?B?dFFLMU1KVHB6eXk4bElKODl2M1IxM1N4eXZoUUtWQ2IrNjMxNm55UVVlSmJz?=
 =?utf-8?B?ZHpGWnZUVXBVRzZ2dngycVBzVkQ5U2FoSHp5SHRabG95M1cxb2xISzJIOWky?=
 =?utf-8?B?VUF3dmJqNUVLR0RCR0ZpWVcvMHR3PT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08c30374-e926-42ba-c728-08db6cc3a0ee
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 10:39:28.0740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dlzXgin5iFkVRkUR+v5AFULgJiVjcQDcTciBxnHDOo/j+xoi4qXdtviCymIzfLBQov4/hcWrnn8XOEZOBonjJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8244
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 09/06/2023 03:23, Vidya Sagar wrote:
> 
> 
> On 6/8/2023 10:03 PM, Bjorn Helgaas wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On Thu, Jun 08, 2023 at 03:06:52PM +0530, Vidya Sagar wrote:
>>> This reverts commit 4fb8e46c1bc4 ("PCI: tegra194: Enable
>>> support for 256 Byte payload")
>>>
>>> Consider a PCIe hierarchy with a PCIe switch and a device connected
>>> downstream of the switch that has support for MPS which is the minimum
>>> in the hierarchy, and root port programmed with an MPS in its DevCtl
>>> register that is greater than the minimum. In this scenario, the default
>>> bus configuration of the kernel i.e. "PCIE_BUS_DEFAULT" doesn't
>>> configure the MPS settings in the hierarchy correctly resulting in the
>>> device with support for minimum MPS in the hierarchy receiving the TLPs
>>> of size more than that. Although this can be addresed by appending
>>> "pci=pcie_bus_safe" to the kernel command line, it doesn't seem to be a
>>> good idea to always have this commandline argument even for the basic
>>> functionality to work.
>>> Reverting commit 4fb8e46c1bc4 ("PCI: tegra194: Enable support for 256
>>> Byte payload") avoids this requirement and ensures that the basic
>>> functionality of the devices irrespective of the hierarchy and the 
>>> MPS of
>>> the devices in the hierarchy.
>>> To reap the benefits of having support for higher MPS, optionally, 
>>> one can
>>> always append the kernel command line with "pci=pcie_bus_perf".
>>
>> Please add blank lines between paragraphs and wrap to fill 75 columns.
>> Also add a period at the end of the very first sentence.
>>
>> s/addresed/addressed/
>>
> I'll address your comments in the next patch.
> 
>> I guess that without 4fb8e46c1bc4, Linux configured everything with
>> 128 byte MPS, and 4fb8e46c1bc4 was intended as an optimization to
>> allow 256 byte MPS.
> Correct.
> 
>>
>> If the Root Port advertises Max_Payload_Size Supported as 256 bytes in
>> DevCap, and the PCI core doesn't configure MPS=256 when possible, I'd
>> argue that should be fixed in the PCI core without a driver change
>> like this.
> Well, kernel does configure MPS=256 but only if the 'perf' configuration
> option is selected. 'perf' configuration option also changes the MRRS,
> to extract the maximum performance. I'm not sure about the reasons for 
> not making 'perf' configuration as the default configuration though.
> (IIUC, this is what you are coming to, right?)
> 
> The current patch which is a revert of an earlier patch is to keep 
> things working for different PCIe hierarchies given the default
> configuration that kernel is using at the moment.


Any more feedback on this? If not, would be great to queue for v6.5. 
Feel free to add my ...

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
