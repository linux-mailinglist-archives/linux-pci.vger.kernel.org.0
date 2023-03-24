Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC6A6C7551
	for <lists+linux-pci@lfdr.de>; Fri, 24 Mar 2023 03:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjCXCMK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Mar 2023 22:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCXCMJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Mar 2023 22:12:09 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA1511666;
        Thu, 23 Mar 2023 19:12:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZqzX7xP+B9zUSj2z7FLju9Z8KvUhN2giULvnFF6IhSoVeGwrA7k0M3WvW7hwxA2HkvlINVVcCmX1Kii1XmC+JuOlhirrhZbHRr0PCUEeN6Y3hdl2Piv4nv+zXRwWb9kjz7fvPdISe59OGhlIM78i6DFTTXH4SM308z8gswWqOcnXDPfeGptDQZXo3nK5KqLj3aWP9W5wkeQWbC2qtIrbX+NXWC5v6PV0hmoQyHJC+R7QzOybFyqPVS4hjpmqdaqyntcMUOT12ABkGSF1rWLW0slL3zGB4d68eHdDmPcTyEc/0DuwgkEUcV1jsFBtsFWjJkqNu2Y7jMAI5rqJX4j+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=upk9ZAYTUYBR9vxtcufMi4dLhP0z4n6+uILbC9r2aY4=;
 b=oJIEhLghN9934wTe5w3snkJAk1gDNMBYQtdRf9mGX2Aqgy6+IFg8LrHRBKR3/bOIs3B1SRTSWMfLlpoLoQo1tSS3p8z6JSfZQPf60nY5bDgxrHcYZIHxF6NC0fUGjdLpCtrhkf0Y6+4SQYCYx60rdc/I3XhI1gY0Lh6Cmg85t6f2hqcJ1/PgF7M0N617w8GVsZkReI53qYVkW0vk5hN4ElWZr8YUnu9kh1YgMhC3Bhfe+kP5E81T+Q8hS3l0Y523Ca15dFdaDU19Fpmu6AlxU/Rr0XYCGQG0Yr2rXkti86KAOOxIi8v/Kp8Quk9f/clsrjqG6tRnsFqOtm6RPg4mwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upk9ZAYTUYBR9vxtcufMi4dLhP0z4n6+uILbC9r2aY4=;
 b=1xXO+81Lq4crcW05sxFDYFDbstRaqVGbKubammxjiNeCsdxE1rkXCzACw1JknzFm8JvM22wKj5k/DqX1l76KuY7FodcXC6Nzp/y9TYxep5d4hJ+cUYu/exWcsLZlNqMSmdV9n/TAxJ/rSopKRgPN7gDqXbx1+SWoCCi4RZ7+Mfk=
Received: from BN1PR13CA0023.namprd13.prod.outlook.com (2603:10b6:408:e2::28)
 by DS0PR12MB8480.namprd12.prod.outlook.com (2603:10b6:8:159::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 02:12:05 +0000
Received: from BN8NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::d7) by BN1PR13CA0023.outlook.office365.com
 (2603:10b6:408:e2::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.7 via Frontend
 Transport; Fri, 24 Mar 2023 02:12:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT095.mail.protection.outlook.com (10.13.176.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Fri, 24 Mar 2023 02:12:04 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 23 Mar
 2023 21:12:04 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 23 Mar
 2023 19:12:04 -0700
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 23 Mar 2023 21:12:03 -0500
Message-ID: <a13ba751-9350-47ee-1c4d-77bbfbb8ed72@amd.com>
Date:   Thu, 23 Mar 2023 19:11:57 -0700
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
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <CAL_Jsq+FM9P0n7BQZBY1AGJRtjAWw9F6h5DYmLkdPeXZaiYJwA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT095:EE_|DS0PR12MB8480:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ca8e76f-5d7f-492e-8b7e-08db2c0d29b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: crOVI8uSO2FmxYeUckSMrC+KaHs+jOUdrfdxz0EMlvU/sRc8nCOZPxDer30W7n9MORGMqna38Hhg854FAVRFIiXB2eBUDMDB1ftGzeBwr43lIs/JBMGEurUi+2UMUN8jwvOy66GRlqWN4Dhw2s+0VF1s056f6Yp56OjgCiSLtTNAXloIA5iIwGDE5aKSrP5TuV1imDFQTjVH7bMmDijyyxdcsvkoPvcGS2MvKlYqrBr1JSW/ZY1zZVp/6xO/A5Gpun1PYBq8LfXVK9aD85rfrr6HbL7nHq6KJ+qAFs2UjVwSpbWX2hzNMvEmKXRwDdVAn8U8K3x7tfCa5+VKkEeiHB1xzs+kp/p2PwHUq29E803aRQIQ/zinbduqw4NkDrlLrqTTIRsebqpRBG9CzvXZJcbBeJrnHY9jqBtAOYx/n5X2nmVWx0+EZxzvnFUT0eu530stlaU//0+twm9kbfvfBSNmnDhltsXRsVga7eJfEYVaoNOBw9+3eLVY7Lt+iMf7tbRgtplW2DF4o2afx5etiaVXRxM4BgLnmNWnynze2Bjo8lx3Avck0+1cagXtJsodJLQ2XNwENlPhA0vByDhjd6XeLiPAf6P6PXM0H9ZSP0bojwJcmtQJqfnRyufLWrTVuJPoAajBjBAQ7Fx19mMdlU8zrS2/4ForCKBIO1Fcf5jUfTNoVxwrpN74j7NyGb/sFYOrS2ZSggWixyrhqoVFUQ4FfXTQKyv/9bFBwEY4X38PsF5uQx3KmppAL13ZhwoUbw4vPaFt2Dh4EPFWneTerg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199018)(36840700001)(40470700004)(46966006)(31686004)(356005)(40480700001)(2906002)(40460700003)(86362001)(83380400001)(336012)(2616005)(186003)(66574015)(36756003)(31696002)(82310400005)(478600001)(54906003)(70586007)(36860700001)(4326008)(8676002)(6916009)(70206006)(47076005)(26005)(8936002)(16576012)(53546011)(316002)(426003)(6666004)(81166007)(44832011)(82740400003)(41300700001)(5660300002)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 02:12:04.8614
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca8e76f-5d7f-492e-8b7e-08db2c0d29b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8480
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 3/23/23 15:40, Rob Herring wrote:
> On Thu, Jan 19, 2023 at 9:02 PM Lizhi Hou <lizhi.hou@amd.com> wrote:
>> of_create_node() creates device node dynamically. The parent device node
>> and full name are required for creating the node. It optionally creates
>> an OF changeset and attaches the newly created node to the changeset. The
>> device node pointer and the changeset pointer can be used to add
>> properties to the device node and apply the node to the base tree.
>>
>> of_destroy_node() frees the device node created by of_create_node(). If
>> an OF changeset was also created for this node, it will destroy the
>> changeset before freeing the device node.
>>
>> Expand of_changeset APIs to handle specific types of properties.
>>      of_changeset_add_prop_string()
>>      of_changeset_add_prop_string_array()
>>      of_changeset_add_prop_u32_array()
>>
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> Your Sob should be last because you sent this patch. The order of Sob
> is roughly the order of possession of the patch.
Got it.
>
>> Signed-off-by: Sonal Santan <sonal.santan@amd.com>
>> Signed-off-by: Max Zhen <max.zhen@amd.com>
> So Sonal and Max modified this patch?
They did not directly modify the code. And we discussed the design 
together.  They also reviewed the patch before I sent it out. Please let 
me know if other keyword should be used in this case.
>
>> Reviewed-by: Brian Xu <brian.xu@amd.com>
>> Signed-off-by: Clément Léger <clement.leger@bootlin.com>
> Why does this have Clément's Sob?
I referenced Clément 's code and used one portion in my first patch 
series. And I re-implemented it later to address the code review 
comments/requests.
>
>> ---
>>   drivers/of/dynamic.c | 197 +++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/of.h   |  24 ++++++
>>   2 files changed, 221 insertions(+)
>>
>> diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
>> index cd3821a6444f..4e211a1d039f 100644
>> --- a/drivers/of/dynamic.c
>> +++ b/drivers/of/dynamic.c
>> @@ -461,6 +461,71 @@ struct device_node *__of_node_dup(const struct device_node *np,
>>          return NULL;
>>   }
>>
>> +/**
>> + * of_create_node - Dynamically create a device node
> For consistency, I think this should be of_changeset_create_node().
Sure.
>
>> + *
>> + * @parent: Pointer to parent device node
>> + * @full_name: Node full name
>> + * @cset: Pointer to returning changeset
>> + *
>> + * Return: Pointer to the created device node or NULL in case of an error.
>> + */
>> +struct device_node *of_create_node(struct device_node *parent,
>> +                                  const char *full_name,
>> +                                  struct of_changeset **cset)
>> +{
>> +       struct of_changeset *ocs;
>> +       struct device_node *np;
>> +       int ret;
>> +
>> +       np = __of_node_dup(NULL, full_name);
>> +       if (!np)
>> +               return NULL;
>> +       np->parent = parent;
>> +
>> +       if (!cset)
>> +               return np;
>> +
>> +       ocs = kmalloc(sizeof(*ocs), GFP_KERNEL);
>> +       if (!ocs) {
>> +               of_node_put(np);
>> +               return NULL;
>> +       }
>> +
>> +       of_changeset_init(ocs);
>> +       ret = of_changeset_attach_node(ocs, np);
>> +       if (ret) {
>> +               of_changeset_destroy(ocs);
>> +               of_node_put(np);
>> +               kfree(ocs);
>> +               return NULL;
>> +       }
>> +
>> +       np->data = ocs;
>> +       *cset = ocs;
>> +
>> +       return np;
>> +}
>> +EXPORT_SYMBOL(of_create_node);
>> +
>> +/**
>> + * of_destroy_node - Destroy a dynamically created device node
>> + *
>> + * @np: Pointer to dynamically created device node
>> + *
>> + */
>> +void of_destroy_node(struct device_node *np)
>> +{
>> +       struct of_changeset *ocs;
>> +
>> +       if (np->data) {
>> +               ocs = (struct of_changeset *)np->data;
>> +               of_changeset_destroy(ocs);
>> +       }
>> +       of_node_put(np);
> A sequence like this would be broken:
>
> np  = of_create_node()
> of_node_get(np)
> of_destroy_node(np)
>
> The put here won't free the node because it still has a ref, but we
> just freed the changeset. For this to work correctly, we would need
> the release function to handle np->data instead. However, all users of
> data aren't a changeset.
>
> I'm failing to remember why we're storing the changeset in 'data', but
> there doesn't seem to be a reason now so I think that can just be
> dropped. Then if you want to free the node, you'd just do an
> of_node_put(). (And maybe after the node is attached you do a put too,
> because the attach does a get. Not completely sure.)

The question is how to save changeset and free it later. I used global 
link list to track the changeset been created.

Storing the changeset in 'data' can avoid using the global link list.

To use of_node_put() to free both node and changeset, I think we can

   1) add a new flag, then in of_node_release() we can know np->data is 
changeset by checking the flag.

   2) When creating node, allocate extra memory for changeset and set 
np->data to a global function of_free_dynamic_node().

       In of_node_release(), check if np->data == of_free_dynamic_node, 
call of_free_dynamic_node(np).

       in of_free_dynamic_node(), free changeset by 
of_changeset_destroy(np+1)

Does this make sense to you? If yes, 1) or 2) sounds better?

>
> A unittest for all these functions would be helpful.

Ok, I will create unittest for the new added functions.


Thanks,

Lizhi

>
> Rob
