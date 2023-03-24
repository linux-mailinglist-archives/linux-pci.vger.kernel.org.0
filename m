Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23116C8773
	for <lists+linux-pci@lfdr.de>; Fri, 24 Mar 2023 22:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjCXV0r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Mar 2023 17:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjCXV0q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Mar 2023 17:26:46 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE62199D9;
        Fri, 24 Mar 2023 14:26:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXTQlxzOwbrQ9a/8hOTa+dZZsABaC4QKeXgRGaKiElSb9k5VMrUlYQifUcyuqkNvd+OrKvm0BMrcs+mH4U517NrLRnicfbP3K7QjC1U9ZluJ40IX9FPwpQDPnOLC6WgHj/65d7K7N8Aai+TShF63mzuYKR/6rqJYL1sQ+7ELwpYHyCJza4bXxZ4ZGKdQ0NRZBbhsu2NO1iE121oTuvemOb0LBQGbq5x94E6ITkC0OB8TVInAwe5/LEJpH/iiwZ5gYPoEoY8mQUYuIcs3Xzd6CbzraaS4H+UBLnDmVUFNcBlCJcPKAQ9cJbz+QX6xMn0SyDYtrytia0+WE3ND/hIz4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjhOj0XjoZKTFaZp/0jKdWuLmTv6w99VRzAgblkFuV8=;
 b=JSBZwL+++lDr2abolxzHhYBRyzdm06z7lPSa4m2kHmPXIEvSdHt0NFcCNkb1pcYitd5KpcRpqA0Dd/steZheq34NwK/ZoZLPGqkJbe+5TqRH/GmNeo5WmqHHu7DF+r3Goxm7WNGbQlMH94QWEUd3OHXxiQV06R0J8QOtC/C/8P6WnrdJ/vM1ln1QJXo1f2uAqFsVtCc5LhA2Puraoz4EPIRBe91ZmZj/1G6zT+dR7my6CUO53UmXhhc7OGo1Hxovd5Ez3g9GSO6QyQzByUlnmSZlYq1GsMDyD/4vp5hlm2eN1PFOmCuAh9Bu9UAYIIAEnxVB8hKUpC1ZIkXQScj9ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjhOj0XjoZKTFaZp/0jKdWuLmTv6w99VRzAgblkFuV8=;
 b=qepOkdARUhJL7SCM77FWKJqowkQPWhRzA6X+6K4Kf6OeIZVybP6CRbCXSEDINOqlUbO/kRc3DKbLs7Dvxofl5gaDkZNu8OlB1Ru5GkvRX2ypn0uyLx6OJ5+wTf8PRufX8ODtKJZpx5qF613kpRM6+PHbEXq8QWA0NXFDZls9Q3k=
Received: from BN9PR03CA0087.namprd03.prod.outlook.com (2603:10b6:408:fc::32)
 by DS0PR12MB7995.namprd12.prod.outlook.com (2603:10b6:8:14e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 21:26:40 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::96) by BN9PR03CA0087.outlook.office365.com
 (2603:10b6:408:fc::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Fri, 24 Mar 2023 21:26:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Fri, 24 Mar 2023 21:26:40 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 24 Mar
 2023 16:26:40 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 24 Mar
 2023 16:26:39 -0500
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 24 Mar 2023 16:26:39 -0500
Message-ID: <0ac96eb0-908c-f0c6-2ec8-23957f5a7941@amd.com>
Date:   Fri, 24 Mar 2023 14:26:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V7 1/3] of: dynamic: Add interfaces for creating device
 node dynamically
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <frowand.list@gmail.com>,
        <helgaas@kernel.org>, <clement.leger@bootlin.com>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>, <larry.liu@amd.com>,
        <brian.xu@amd.com>, <stefano.stabellini@xilinx.com>,
        <trix@redhat.com>
References: <1674183732-5157-1-git-send-email-lizhi.hou@amd.com>
 <1674183732-5157-2-git-send-email-lizhi.hou@amd.com>
 <CAL_Jsq+FM9P0n7BQZBY1AGJRtjAWw9F6h5DYmLkdPeXZaiYJwA@mail.gmail.com>
 <a13ba751-9350-47ee-1c4d-77bbfbb8ed72@amd.com>
 <CAL_Jsq+5LtUcLTRnywdf7XB3HNtO6j2J=qykVeDN1MYZEEx1Cg@mail.gmail.com>
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <CAL_Jsq+5LtUcLTRnywdf7XB3HNtO6j2J=qykVeDN1MYZEEx1Cg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT056:EE_|DS0PR12MB7995:EE_
X-MS-Office365-Filtering-Correlation-Id: 969e8039-2e98-44e9-93e3-08db2cae7537
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DiCoXr+aZW+Cazo9ZMBBED4Woa28VybyyXnj31QtvNJYZ8Moohb49UTB2OKM1H7uTfwuGQ1Ekxv6KQtmzxBrS6rewfOoIm6BgZcbRPZZbz3cf8sNAbn5CRYIbQ2yeEgvYA8r9kzE/qOF3uUW91aQjfvmawRv0AultK4UiGHIawzlu8pxHyTAVeifbMcfjfj9RB9LPyt6WUiqNHP7W6j9RPutpOQTYwOLQ67nVUS6gxN5x1bQnZeoRFsCN/GQ7ADkiIurLGf3xC/CiCE3nF8e3HRTHHE47RFZ//6SfQjO7QJ0WjUp2hPDfu7EQ5lz2ptcVsYvlAgeVCo+U14DgeV1j/GaTxHJwh2Y4LLKaPdHmCVt+/4+c4RkDjE/BaTfqy97VdiQSoiBV0MC/IkaPygiyoIQm58+X8+Z1NANn/st0G/sDTEgN8uPltf7MO68u94onNAordt8ZOVTzC5m/IJpTKXUTxJ63FHoWQTYAVOoqzvLDUOf/CoW8KtZiq5Ui0TbSjRYbByscD0YS6LUbotqBxm5+e3X1Y5QcvloK5Al17F353XjLrRUFeGSTAbv91trlExNu8obbqkPzSegI2agSxu5/CE/2cIpRdiEtAPm9hqM56jj0ozTcATGyIoE1lv/yVf6GTkm2YoRMPzurUIkrIV4ejTimhErSSyjhZDNxDdfHiIeRljxraNQdBgrfsZO6tY0hic/49/L5SHqS8J5FTRgj8L1KWdHtUqnf1z1IoBjHQ6xEN1FVsMns8c+6hMnABXUcHw7IrgctsZrYq32MQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199021)(46966006)(36840700001)(40470700004)(8936002)(47076005)(26005)(83380400001)(186003)(54906003)(336012)(2616005)(66574015)(40460700003)(478600001)(31696002)(36756003)(86362001)(82310400005)(5660300002)(4326008)(70586007)(6916009)(36860700001)(8676002)(40480700001)(356005)(2906002)(31686004)(70206006)(82740400003)(41300700001)(81166007)(44832011)(16576012)(53546011)(426003)(316002)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 21:26:40.5096
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 969e8039-2e98-44e9-93e3-08db2cae7537
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7995
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 3/24/23 07:14, Rob Herring wrote:
> On Thu, Mar 23, 2023 at 9:12 PM Lizhi Hou <lizhi.hou@amd.com> wrote:
>>
>> On 3/23/23 15:40, Rob Herring wrote:
>>> On Thu, Jan 19, 2023 at 9:02 PM Lizhi Hou <lizhi.hou@amd.com> wrote:
>>>> of_create_node() creates device node dynamically. The parent device node
>>>> and full name are required for creating the node. It optionally creates
>>>> an OF changeset and attaches the newly created node to the changeset. The
>>>> device node pointer and the changeset pointer can be used to add
>>>> properties to the device node and apply the node to the base tree.
>>>>
>>>> of_destroy_node() frees the device node created by of_create_node(). If
>>>> an OF changeset was also created for this node, it will destroy the
>>>> changeset before freeing the device node.
>>>>
>>>> Expand of_changeset APIs to handle specific types of properties.
>>>>       of_changeset_add_prop_string()
>>>>       of_changeset_add_prop_string_array()
>>>>       of_changeset_add_prop_u32_array()
>>>>
>>>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>>> Your Sob should be last because you sent this patch. The order of Sob
>>> is roughly the order of possession of the patch.
>> Got it.
>>>> Signed-off-by: Sonal Santan <sonal.santan@amd.com>
>>>> Signed-off-by: Max Zhen <max.zhen@amd.com>
>>> So Sonal and Max modified this patch?
>> They did not directly modify the code. And we discussed the design
>> together.  They also reviewed the patch before I sent it out. Please let
>> me know if other keyword should be used in this case.
> Reviewed-by or nothing. Some feel that only reviews on public lists
> should get that tag and internal, private reviews don't matter.
>
>>>> Reviewed-by: Brian Xu <brian.xu@amd.com>
>>>> Signed-off-by: Clément Léger <clement.leger@bootlin.com>
>>> Why does this have Clément's Sob?
>> I referenced Clément 's code and used one portion in my first patch
>> series. And I re-implemented it later to address the code review
>> comments/requests.
> Then it goes first or you can use the 'Co-developed-by' tag.
>
>>>> ---
>>>>    drivers/of/dynamic.c | 197 +++++++++++++++++++++++++++++++++++++++++++
>>>>    include/linux/of.h   |  24 ++++++
>>>>    2 files changed, 221 insertions(+)
>>>>
>>>> diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
>>>> index cd3821a6444f..4e211a1d039f 100644
>>>> --- a/drivers/of/dynamic.c
>>>> +++ b/drivers/of/dynamic.c
>>>> @@ -461,6 +461,71 @@ struct device_node *__of_node_dup(const struct device_node *np,
>>>>           return NULL;
>>>>    }
>>>>
>>>> +/**
>>>> + * of_create_node - Dynamically create a device node
>>> For consistency, I think this should be of_changeset_create_node().
>> Sure.
>>>> + *
>>>> + * @parent: Pointer to parent device node
>>>> + * @full_name: Node full name
>>>> + * @cset: Pointer to returning changeset
>>>> + *
>>>> + * Return: Pointer to the created device node or NULL in case of an error.
>>>> + */
>>>> +struct device_node *of_create_node(struct device_node *parent,
>>>> +                                  const char *full_name,
>>>> +                                  struct of_changeset **cset)
>>>> +{
>>>> +       struct of_changeset *ocs;
>>>> +       struct device_node *np;
>>>> +       int ret;
>>>> +
>>>> +       np = __of_node_dup(NULL, full_name);
>>>> +       if (!np)
>>>> +               return NULL;
>>>> +       np->parent = parent;
>>>> +
>>>> +       if (!cset)
>>>> +               return np;
>>>> +
>>>> +       ocs = kmalloc(sizeof(*ocs), GFP_KERNEL);
>>>> +       if (!ocs) {
>>>> +               of_node_put(np);
>>>> +               return NULL;
>>>> +       }
>>>> +
>>>> +       of_changeset_init(ocs);
>>>> +       ret = of_changeset_attach_node(ocs, np);
>>>> +       if (ret) {
>>>> +               of_changeset_destroy(ocs);
>>>> +               of_node_put(np);
>>>> +               kfree(ocs);
>>>> +               return NULL;
>>>> +       }
>>>> +
>>>> +       np->data = ocs;
>>>> +       *cset = ocs;
>>>> +
>>>> +       return np;
>>>> +}
>>>> +EXPORT_SYMBOL(of_create_node);
>>>> +
>>>> +/**
>>>> + * of_destroy_node - Destroy a dynamically created device node
>>>> + *
>>>> + * @np: Pointer to dynamically created device node
>>>> + *
>>>> + */
>>>> +void of_destroy_node(struct device_node *np)
>>>> +{
>>>> +       struct of_changeset *ocs;
>>>> +
>>>> +       if (np->data) {
>>>> +               ocs = (struct of_changeset *)np->data;
>>>> +               of_changeset_destroy(ocs);
>>>> +       }
>>>> +       of_node_put(np);
>>> A sequence like this would be broken:
>>>
>>> np  = of_create_node()
>>> of_node_get(np)
>>> of_destroy_node(np)
>>>
>>> The put here won't free the node because it still has a ref, but we
>>> just freed the changeset. For this to work correctly, we would need
>>> the release function to handle np->data instead. However, all users of
>>> data aren't a changeset.
>>>
>>> I'm failing to remember why we're storing the changeset in 'data', but
>>> there doesn't seem to be a reason now so I think that can just be
>>> dropped. Then if you want to free the node, you'd just do an
>>> of_node_put(). (And maybe after the node is attached you do a put too,
>>> because the attach does a get. Not completely sure.)
>> The question is how to save changeset and free it later. I used global
>> link list to track the changeset been created.
>>
>> Storing the changeset in 'data' can avoid using the global link list.
>>
>> To use of_node_put() to free both node and changeset, I think we can
>>
>>     1) add a new flag, then in of_node_release() we can know np->data is
>> changeset by checking the flag.
>>
>>     2) When creating node, allocate extra memory for changeset and set
>> np->data to a global function of_free_dynamic_node().
>>
>>         In of_node_release(), check if np->data == of_free_dynamic_node,
>> call of_free_dynamic_node(np).
>>
>>         in of_free_dynamic_node(), free changeset by
>> of_changeset_destroy(np+1)
>>
>> Does this make sense to you? If yes, 1) or 2) sounds better?
> Neither works. Changesets and nodes are not 1:1 in general though they
> are in your use. So you can use the data ptr, but the caller has to
> decide that, not the DT core code.

Ok. In of_pci_make_dev_node(), I can do

      ocs = kmalloc(*ocs);

      of_changeset_init(ocs);

      np = of_changeset_create_node(ocs, name);

      np->data = ocs;

Then in of_pci_remove_node(), I can do

      if (!np || !of_node_check_flag(np, OF_DYNAMIC)) return;

     of_changeset_destroy(np->data);

     of_node_put(np);


Does this sound reasonable?


Thanks,

Lizhi

>
> Rob
