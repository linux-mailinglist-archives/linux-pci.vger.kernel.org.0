Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C351D787822
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 20:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbjHXSkm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Aug 2023 14:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243120AbjHXSkJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2023 14:40:09 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5339F19A3;
        Thu, 24 Aug 2023 11:40:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7dbECpc9YUdrIw5ULKG1gvgBmtz3F8Pl9QT8VX5yk7hzalHsHDPR3QdrswaKCCzASSR/6xcCwr5YlC+cw8m0WEX78mg99oagwjs3baFqdV3H178LfVKSmpCMcn8wKXKIU5SwubVXcUxGqwYBgr5wYTIuQUDiFekmXwNe8TVaEYHnNAzmcZr/NyJJ0Dvc15/RsqkEVD89J+N3ntMjGHOE3K/lBCbQm1b5S1TAFZv5WXRqFKfQwPEJroTUmhl/u9vRy1eX0PybCWZTS+K3ewiRQ+RdxingE2KcpMLnI5a4brVdXDwxijtsVng1A8p7pqcjOsEI7mHUvAmd3WwcZWYAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CKUP0Pkcf3Qy7UtuYHdaeWIV9xzCQBmw/9hbUiumlU4=;
 b=JyEK6qgus7c+CGsVUt1IwXAGncF4NULbAQIVBzNNzWmEdzfz10QHiar3z2Vffglu3hl01dAvtQBRFnCy2GGmFpxFfI7pFiyexrLcIgPh5AWOSfzD/oA+9DdnQY47fGqTYjVM2e8rLxSHaJCGBzZjwDVTnbAP6h7lV1gIR4V9qO5j96oWF0TXzhUbjlcJPYdrMTnXKX3Kc0B8FzGby19QENqGh9ia4ot7fPO2PlWBcskTfZJvvh8+r71ewnLO7tWg9PQ3DGiG6oS7gfvlvU7K3QQdWeGMBUc5YyFqGzSwVDnUd8bC/O5DPHnr4n5Zbzu4EoyGdFqMRm+6xXJ47iOszA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-m68k.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKUP0Pkcf3Qy7UtuYHdaeWIV9xzCQBmw/9hbUiumlU4=;
 b=B7UxS8FiNkEvndB4xNbK1/oiec0NM3hYReRHQ19pbEtvzx0IBH5jFkgUaR2rbGk3vU8x5zDKdNQPldnVfmDKf4Ogh+jVuOZq7JF8bLqZR53jhgdDrck04fTOu7eXiZS+y3APfrVTn38Ge0NEP4n9+ViZWRHqY1jHUFBydFvTI80=
Received: from SN7PR04CA0231.namprd04.prod.outlook.com (2603:10b6:806:127::26)
 by DS0PR12MB6656.namprd12.prod.outlook.com (2603:10b6:8:d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Thu, 24 Aug
 2023 18:40:03 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:127:cafe::5) by SN7PR04CA0231.outlook.office365.com
 (2603:10b6:806:127::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Thu, 24 Aug 2023 18:40:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Thu, 24 Aug 2023 18:40:02 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 13:40:01 -0500
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 24 Aug 2023 13:40:01 -0500
Message-ID: <2d2efa50-43b2-242c-028b-76554ed30962@amd.com>
Date:   Thu, 24 Aug 2023 11:40:00 -0700
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
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <2aae84b8-41f9-3c24-bac9-8f882d2211b@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|DS0PR12MB6656:EE_
X-MS-Office365-Filtering-Correlation-Id: 154c9212-04e0-43af-7276-08dba4d18711
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qhImtycGmtlPFCtV4t3v1wA2che4qpQbjzNhutzfr7E+7Osc5zttdUhrSJ5EbM7D1ke6A8aIPgBLeVhmjMdu7+zgQuz4BCVU5YAgGRfftqJiPkx+KRIWq9FoaQLiUUKkE52h12uHJnanugdFwIvaaZnb43E8Bk6M+whSyYfmK+kO0Wpj10jihXrCXiF8TZzw8pIwb04LWm15YlTcXKQYV572kBUYmAK1fm/faX54MBnBO5iBeHgQkHHlBD+b+TPzAhS+Qg3gZNu2uhXtlOD4qX0kqE8UwXbH2W8yUkyVgqmu2IDAzb3A+Nv65Vssk4lBzuesJva6YwCwgakg6+m2kvuQ1Sz57vxsed0hfYBW5Dp8JkgZN1zh2si5orCYXbPFYN+uSvgp1nsH41PLTtu4v10rkTnSwuNjoH27A3rFLuQ57J0inD7gmKRQTp3DKJUZ+wQ5Na19n34S0yI2EV3VtYMhUdzJqtgjPcTECoEwhnGUNMhiMMt9TzJ43EHjsVdgrSmryyz3Qf9jwozDcy6uP3wS9J/myw5RoiW6TvUpChqx8FiwRuPFcjOvg7TvYY7ShNRpO0ipigdA4vUjJSasZSXlfaOYdO2N5+8puqk/0NmvJy4eK6Kbhu3IGeCzSx2ISSD4eIcNkkFmRPs5KpVn/9ooBTAXRWYfMt77YHElP41kgyacRqZbVSTe7p0QeEzf+NJZWpvQxRBB7gI4Srtr50mr67W8VXLsKdekG8nO9LBwNjD/GoBbr2j7vOPthTcyS2RqeMrPAcpHhgKTUqk9LBNZaSFhOVDXyk3hhJhuXOyxIsbbGloI/Gf4k11xFkev
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(1800799009)(186009)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(53546011)(40480700001)(2616005)(40460700003)(86362001)(31696002)(5660300002)(2906002)(44832011)(70206006)(70586007)(54906003)(4326008)(8676002)(6916009)(8936002)(41300700001)(36756003)(16576012)(316002)(81166007)(478600001)(82740400003)(36860700001)(356005)(31686004)(426003)(47076005)(336012)(26005)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 18:40:02.3619
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 154c9212-04e0-43af-7276-08dba4d18711
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6656
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Geert,

Thanks for reviewing the patch. I add my comment in-line.

On 8/24/23 01:31, Geert Uytterhoeven wrote:
>     Hi Lizhi,
>
> On Tue, 15 Aug 2023, Lizhi Hou wrote:
>> Currently, in an overlay fdt fragment, it needs to specify the exact
>> location in base DT. In another word, when the fdt fragment is 
>> generated,
>> the base DT location for the fragment is already known.
>>
>> There is new use case that the base DT location is unknown when fdt
>> fragment is generated. For example, the add-on device provide a fdt
>> overlay with its firmware to describe its downstream devices. Because it
>> is add-on device which can be plugged to different systems, its firmware
>> will not be able to know the overlay location in base DT. Instead, the
>> device driver will load the overlay fdt and apply it to base DT at 
>> runtime.
>> In this case, of_overlay_fdt_apply() needs to be extended to specify
>> the target node for device driver to apply overlay fdt.
>>    int overlay_fdt_apply(..., struct device_node *base);
>>
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>
> Thanks for your patch, which is now commit 47284862bfc7fd56 ("of:
> overlay: Extend of_overlay_fdt_apply() in dt-rh/for-next.
>
>> --- a/drivers/of/overlay.c
>> +++ b/drivers/of/overlay.c
>> @@ -715,6 +730,7 @@ static struct device_node *find_target(struct 
>> device_node *info_node)
>> /**
>>  * init_overlay_changeset() - initialize overlay changeset from 
>> overlay tree
>>  * @ovcs:        Overlay changeset to build
>> + * @target_base:    Point to the target node to apply overlay
>>  *
>>  * Initialize @ovcs.  Populate @ovcs->fragments with node information 
>> from
>>  * the top level of @overlay_root.  The relevant top level nodes are the
>
> As an overlay can contain one or more fragments, this means the
> base (when specified) will be applied to all fragments, and will thus
> override the target-path properties in all fragments.
>
> However, for the use case of an overlay that you can plug into
> a random location (and of which there can be multiple instances),
> there can really be only a single fragment.  Even nodes that typically
> live at the root level (e.g. gpio-leds or gpio-keys) must be inserted
> below the specified location, to avoid conflicts.
>
> Hence:
>   1. Should init_overlay_changeset() return -EINVAL if target_base is
>      specified, and there is more than one fragment?

Maybe allowing more than one fragment make the interface more generic?  
For example, it could support the use case that multiple fragments share 
the same base node.

Currently, the fragment overlay path is "base node path" + "fragment 
target path". Thus, for the structure:

/a/b/c/fragment0

/a/b/d/fagment1

It can be two fragments in one fdt by using

   base node path = /a/b

   fragment0 target path = /c

   fragment1 target path = /d

I am not sure if there will be this kind of use case or not. And I think 
it would not be hurt to allow that.

>
>   2. Should there be a convention about the target-path property's
>      contents in the original overlay?
>      drivers/of/unittest-data/overlay_pci_node.dtso in "[PATCH V13 5/5]
>      of: unittest: Add pci_dt_testdrv pci driver" uses
>
>          target-path="";
>
>      which cannot be represented when using sugar syntax.
>      "/" should work fine, though.

Because the fragment overlay path is "base node path" + "fragment target 
path", I may add code to check if "fragment target patch is '/' and 
ignore it. I think that would support sugar syntax with only '/' specified.


Thanks,

Lizhi

>
> Thanks!
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- 
> geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a 
> hacker. But
> when I'm talking to journalists I just say "programmer" or something 
> like that.
>                                 -- Linus Torvalds
