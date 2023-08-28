Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504D578B622
	for <lists+linux-pci@lfdr.de>; Mon, 28 Aug 2023 19:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjH1RMz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Aug 2023 13:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbjH1RM3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Aug 2023 13:12:29 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704FF19B;
        Mon, 28 Aug 2023 10:12:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSTOm0iwyOzkUQquxdD5qZWaAb0FyhY+v779nwTCZq26l4G1IEaqKG/5zBqSVPXkvKk/JapmuRPGLs8AWvDcglVXSm292A+lM5ff8/p+whAaTMPzwl8rNe6HBVn02WloaG2ir2DiRUZsvSbcTHLuNq/HcDj83m6dHBXwDsa5dPKj8UhlmrnjqyO5f5PHIth706xlyjBV1A8FTiX26ZyORq2LKf7ln7L6E+P81e4WH26h8CsV6UfHvAcoOv7SUwW5pagpf/Bx466EltEfIwr2vxchMSQCXcV6wSmu5yPaI0YVIooKRDXq5HD6d2T+Xr2EmBe24jQHjzDk1+xYVX65IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ot4Yjt+Es5mjn0PNhmkqosVabO20D4+rjUyxBcbVLfc=;
 b=WR9MIQQA9YWzUyUlY95Mo6C8eYWZCRE1mjuYo5DmHRpRJrKJRE8LyC4RuTRYeVLCsaB9Kb+PFV5YC7Ac2x66n/fKspia/ZU7MosNfFsxmlSinHyCI315jcGsCWW7fSNyJmklDZfzHZbJUWWzEQyZ0NSKP1Amttf8FFHI7KYoFkP5zKzIYDgjvihyRgUARY/v14WGQhsxr2lnukVKGfDFIE+FVucUnzFsZtrHwd2h+VZWPW8eoYkYs0nEj7QJ5DfSAbLu1vXtsMgcMGsQmECWH015DLdbu6hT4cLKobLWasnFmOwMe+5NP3uW2durSTocNm718RVBewiG1y11wbIXVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-m68k.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ot4Yjt+Es5mjn0PNhmkqosVabO20D4+rjUyxBcbVLfc=;
 b=lVHNm9amdFZNUNGfEBYAlG+6BNnJWyfSV4Z7qKShjEg6RS5WuCk+un9lkxw9xtIaECbxOX1+emA1o1/D9lLRbhk/VbrXRmmIaq9uG53bl05xU43dsZyR9HOCENm5219VIxqE2O3IjDT21ZD5LLA/BVlok3LOUxSWts47paceyVw=
Received: from CY5PR16CA0026.namprd16.prod.outlook.com (2603:10b6:930:10::21)
 by PH7PR12MB5830.namprd12.prod.outlook.com (2603:10b6:510:1d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 17:12:07 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:930:10:cafe::29) by CY5PR16CA0026.outlook.office365.com
 (2603:10b6:930:10::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35 via Frontend
 Transport; Mon, 28 Aug 2023 17:12:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.210) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Mon, 28 Aug 2023 17:12:06 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 28 Aug
 2023 12:12:06 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 28 Aug
 2023 12:12:01 -0500
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 28 Aug 2023 12:12:00 -0500
Message-ID: <0507d220-292f-bac5-b352-f4913d3b9d39@amd.com>
Date:   Mon, 28 Aug 2023 10:12:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V13 4/5] of: overlay: Extend of_overlay_fdt_apply() to
 specify the target node
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>,
        <stefano.stabellini@xilinx.com>
References: <1692120000-46900-1-git-send-email-lizhi.hou@amd.com>
 <1692120000-46900-5-git-send-email-lizhi.hou@amd.com>
 <2aae84b8-41f9-3c24-bac9-8f882d2211b@linux-m68k.org>
 <2d2efa50-43b2-242c-028b-76554ed30962@amd.com>
 <CAMuHMdW_riBrmEThdbaEMO468Hc0oBJKChW=jABUF3T9EhaRew@mail.gmail.com>
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <CAMuHMdW_riBrmEThdbaEMO468Hc0oBJKChW=jABUF3T9EhaRew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|PH7PR12MB5830:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cf530ad-f500-4089-6952-08dba7e9e860
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kvTANWUFt25ZFSs57lLxWGZdpcx5retz3vDoWxVFYOg71kblmq90OO0VlCEA68/tWATNu+h2bxV8IcIQzOJubyHakh6p/hgIXCuI50zZ7kiEVszvuyg3V7IgtYtGo8WWEtG2BT5fwnkKxVtky4teqStL7GqiNQ1VNz49oFwcV5m/BTTNlTvB5a1ds788Wbxo22ir9A8b3eORHi/ftZfqyNBnjJpAvJACfc/UTlknqq23FmLlo+rL1Kf2O2JlLnHMPbyetd0oNH4esf03Bk0YR0iDO70N0U0g5Oz6AYisGVLEhFxsYas2Z8vH/Y2JqAhCsvpRUjS+DUxlXaW3969ZRZ+DRIxXLcuMYto6L7l8rFuUORTzyHvu7cQipzJZ0L0Vq/KU5JfydZgSy7aHqTSZ4QGlwjtrIbTlLVjCD5rNA+6fSBXh+5vHSH71HE+veLgBOFM/1QKO2CYWCxGUFplgoTmWxa4M+MwdFL3fZuNDpy4oBj8rH6REEI0cBkgDLIwjQVAajZ67U4TPq8TfdDsIspUVoVXNCoTPB0AaP4SgAn8MS6bL9f0dVXlku43rLxyo3qSgIZgOWLMwdKuFSImi46cDxKElswcj8yHpxeD1WVNRl+G4RrsLTQvZUm85ARGFOvxyt6kGjjJGG5/gmz3zpELB+tqC+QbDd/PneYLgbY3ZYPXeq3c5aRzfW+8fWH80SZWk8hmiIAQ50bu4aH5ULRQNWBUeTID0i4CfwwzSF2jvfLaXmJBz5KVCNghG9GE0MUCyF7Q6NrFtb4GaPMfWUR7+clzIqFOlkpdTi0Gnw06az11r3tis7fvWmDi54vwx
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(396003)(39860400002)(376002)(186009)(1800799009)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(40460700003)(41300700001)(336012)(356005)(81166007)(82740400003)(86362001)(31696002)(47076005)(83380400001)(478600001)(2616005)(53546011)(26005)(426003)(36860700001)(40480700001)(70586007)(70206006)(54906003)(36756003)(16576012)(2906002)(6916009)(316002)(5660300002)(4326008)(8676002)(8936002)(31686004)(44832011)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 17:12:06.9814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf530ad-f500-4089-6952-08dba7e9e860
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5830
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 8/25/23 00:25, Geert Uytterhoeven wrote:
> Hi Lizhi,
>
> On Thu, Aug 24, 2023 at 8:40 PM Lizhi Hou <lizhi.hou@amd.com> wrote:
>> On 8/24/23 01:31, Geert Uytterhoeven wrote:
>>> On Tue, 15 Aug 2023, Lizhi Hou wrote:
>>>> Currently, in an overlay fdt fragment, it needs to specify the exact
>>>> location in base DT. In another word, when the fdt fragment is
>>>> generated,
>>>> the base DT location for the fragment is already known.
>>>>
>>>> There is new use case that the base DT location is unknown when fdt
>>>> fragment is generated. For example, the add-on device provide a fdt
>>>> overlay with its firmware to describe its downstream devices. Because it
>>>> is add-on device which can be plugged to different systems, its firmware
>>>> will not be able to know the overlay location in base DT. Instead, the
>>>> device driver will load the overlay fdt and apply it to base DT at
>>>> runtime.
>>>> In this case, of_overlay_fdt_apply() needs to be extended to specify
>>>> the target node for device driver to apply overlay fdt.
>>>>     int overlay_fdt_apply(..., struct device_node *base);
>>>>
>>>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>>> Thanks for your patch, which is now commit 47284862bfc7fd56 ("of:
>>> overlay: Extend of_overlay_fdt_apply() in dt-rh/for-next.
>>>
>>>> --- a/drivers/of/overlay.c
>>>> +++ b/drivers/of/overlay.c
>>>> @@ -715,6 +730,7 @@ static struct device_node *find_target(struct
>>>> device_node *info_node)
>>>> /**
>>>>   * init_overlay_changeset() - initialize overlay changeset from
>>>> overlay tree
>>>>   * @ovcs:        Overlay changeset to build
>>>> + * @target_base:    Point to the target node to apply overlay
>>>>   *
>>>>   * Initialize @ovcs.  Populate @ovcs->fragments with node information
>>>> from
>>>>   * the top level of @overlay_root.  The relevant top level nodes are the
>>> As an overlay can contain one or more fragments, this means the
>>> base (when specified) will be applied to all fragments, and will thus
>>> override the target-path properties in all fragments.
>>>
>>> However, for the use case of an overlay that you can plug into
>>> a random location (and of which there can be multiple instances),
>>> there can really be only a single fragment.  Even nodes that typically
>>> live at the root level (e.g. gpio-leds or gpio-keys) must be inserted
>>> below the specified location, to avoid conflicts.
>>>
>>> Hence:
>>>    1. Should init_overlay_changeset() return -EINVAL if target_base is
>>>       specified, and there is more than one fragment?
>> Maybe allowing more than one fragment make the interface more generic?
>> For example, it could support the use case that multiple fragments share
>> the same base node.
>>
>> Currently, the fragment overlay path is "base node path" + "fragment
>> target path". Thus, for the structure:
> Oh, I had missed that the "fragment target path" is appended,
> and thought it was just overridden.
>
>> /a/b/c/fragment0
>>
>> /a/b/d/fagment1
>>
>> It can be two fragments in one fdt by using
>>
>>     base node path = /a/b
>>
>>     fragment0 target path = /c
>>
>>     fragment1 target path = /d
>>
>> I am not sure if there will be this kind of use case or not. And I think
>> it would not be hurt to allow that.
> Is there a need for that? Both c and d can be handled as subnodes
> in a single fragment if the target path is empty (and see below).

In our use case, we do not need that.  I am just not sure if it should be

adding the restriction to limit one fragment here.

Because the fragment target path is appended to the base node path,

each fragment is still applied to a specific location as before. The only

difference is the fragment target path does not need to always start 
with "/".


Thanks,

Lizhi

>
>>>    2. Should there be a convention about the target-path property's
>>>       contents in the original overlay?
>>>       drivers/of/unittest-data/overlay_pci_node.dtso in "[PATCH V13 5/5]
>>>       of: unittest: Add pci_dt_testdrv pci driver" uses
>>>
>>>           target-path="";
>>>
>>>       which cannot be represented when using sugar syntax.
>>>       "/" should work fine, though.
>> Because the fragment overlay path is "base node path" + "fragment target
>> path", I may add code to check if "fragment target patch is '/' and
>> ignore it. I think that would support sugar syntax with only '/' specified.
> That makes sense.
> Thanks!
>
> Gr{oetje,eeting}s,
>
>                          Geert
>
