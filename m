Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE95761515C
	for <lists+linux-pci@lfdr.de>; Tue,  1 Nov 2022 19:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiKASQp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Nov 2022 14:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiKASQp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Nov 2022 14:16:45 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6711313E17;
        Tue,  1 Nov 2022 11:16:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RxI821PhkRC0Csh2SBtLJY1u/IfIDhnzYf9VoOPik1tVwg/ELRkNLwUiffmhSr4cMxffeaMCtw0ksLvj0wRScbVT84H749ee2GSJSDKyiTNKHPMh2cxdGnHRi+N1Ix9B0Ca8iEicrXi3E8YydMtSzUMIGiyNUCBUbu9mQ+3dcx3V6cnsWA9qz9My+mS9jO5ulOQPBiH79bPwlVypP4vh/Cw1MS1VaZwzoPXdKfTeLKayUKi6qqZoZ82yQljHGQwKzfqqf5jQKxUv+NpUQe1rTiXaV+g3SqKcirH512Saf2B6zMMJ81SB56457xrDTQrMehithmx1X/WEZri+P+EF2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDA25l4+iqucQPcg53zRJjFAsXVQvaLgoC6GkrVDlXA=;
 b=P9ZY17QFcIf9v9TPF+/EOhLpAjHd8ohVYylr1Whjq+tgwxCzFQzRqTuht3KvjLwntSn7thhsOoGhxwaNCirGZtixUQ9WUBL+10YPgL2PZkXo4eZMpTRDykGFveSL3Igq8J1ANLZa4G2gDsNkQ7ZtKr0Aqbq+zNkheIDkMkCrLA9AAGbbI//mAj0EdV9i+Ph6LxzM/2oR7UOYIEhp8+mGtCJ7ga1OqHE6okzx37wMy/7k2XfSdhM7aQwAUDIeHOtDN7tycvaC6uUMcxfdAiGUX5vidViXqZJkg7GvmX5VlOIyV5jDMmi+6s7HD73KJyYa5M1AmdnKHuHGmV6MMmm1OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=wanadoo.fr smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDA25l4+iqucQPcg53zRJjFAsXVQvaLgoC6GkrVDlXA=;
 b=lNq8jBuEqfIOsrSL9PnuF4HyOqYc0xLJVtjbFbVVu0tWb+Q+HRXeLrFeHLGRaXTYUYOkUNjDqNlv9OwkV2pXFwlzoLOr+uyOqlSgLT4nHnuFgEpKK40E0h8I4bZ6CbEO/FoDWn3fpqzUlZHElQEunL6eHJ9bVFDe7p/1BROsVOs=
Received: from BN8PR04CA0031.namprd04.prod.outlook.com (2603:10b6:408:70::44)
 by SJ0PR12MB5456.namprd12.prod.outlook.com (2603:10b6:a03:3ae::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Tue, 1 Nov
 2022 18:16:38 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::33) by BN8PR04CA0031.outlook.office365.com
 (2603:10b6:408:70::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21 via Frontend
 Transport; Tue, 1 Nov 2022 18:16:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.14 via Frontend Transport; Tue, 1 Nov 2022 18:16:37 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 1 Nov
 2022 13:16:37 -0500
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Tue, 1 Nov 2022 13:16:36 -0500
Message-ID: <561c74b9-4e9a-3f1f-093f-618bc468d46f@amd.com>
Date:   Tue, 1 Nov 2022 11:16:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RFC V2 1/3] of: dynamic: Add of_create_node() and
 of_destroy_node()
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>,
        <frowand.list@gmail.com>, <helgaas@kernel.org>
CC:     <clement.leger@bootlin.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <larry.liu@amd.com>, <brian.xu@amd.com>,
        <stefano.stabellini@xilinx.com>, <trix@redhat.com>
References: <1665598440-47410-1-git-send-email-lizhi.hou@amd.com>
 <1665598440-47410-2-git-send-email-lizhi.hou@amd.com>
 <67fdf851-961d-2f4b-591f-4939e1937e68@wanadoo.fr>
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <67fdf851-961d-2f4b-591f-4939e1937e68@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT045:EE_|SJ0PR12MB5456:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c299636-4224-4418-42de-08dabc353786
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5AQiTDMPe7GnppCjTqjcmsXEz9BkEpl+42qw4jdQTgl06evYj+vs5YGggI/SofH2SHorZPqS2mkUIzg6KnlYat+pZw+riQPq3UIOiKzPnc3jKz9bG8s6p5bk/gylihxcK7RMQ75SVkJsTf5vnN4ftt9WRzeTjE6hQsWc1wx2Xmpodm1rrJihgrIb+NlSy0kT/48Ni3VkCkj6qvHTFYxf2EzWcSatVZAViFecTGEw+wWElJkoDgQCJ/+4bdHIZCVvV3PeZYxS6+7/k+E82Muqy9lVYblfSYpLLHZeC+AGdOjTzk9uad+/+dw2FP9klxhldr64kltk7594SkjX7ommTh6FaJ9RRcAyzluCFSWm9VITauBFG7ysaVLNi6agVxYtQoB/WdwdcGpucNohl1qG8TgCJL8IrBhAr01diUq8v5hA5GTC/K+X1ZgM/Cmy6+HOPS1p04c4AQtUbQiyZ36RAq971H0spN/4xkliesoaUuA0KEy1gjT5gNJJzWwHbpG0luS8HXkbltx/VvGoLCHb8lTWq0HfWfTfUu/bwBOuB6n8Ys99nri/pvydFIQWJACIloTk1R8nTJBHrZhywJ0vZXrti0yeq1luPEiIXzqDKoLialnTcmdoobh0cgaa9vzvNK21XyMr3o441pHau15uMP41IsdIknjc3ECIHW2RzFPnD0l6uo00KOWFswzshjiJ/IlRCgElpPEWbK2msvFntegRkvjEeml7EfUqjSO8QXBluSrDAu85zoM6x+U1CIWZJUIjB8MZHe61tHsQR1AnNReRz/STLq37hfWnq7gwRgGvdZTmkLVZDfpgPrbj4xqFwq041oNX8lUVh4YCtiqGoQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(31696002)(426003)(86362001)(336012)(47076005)(36860700001)(82740400003)(81166007)(356005)(5660300002)(44832011)(2906002)(8936002)(4326008)(8676002)(41300700001)(82310400005)(70206006)(53546011)(110136005)(2616005)(16576012)(316002)(186003)(26005)(40460700003)(54906003)(70586007)(478600001)(31686004)(36756003)(40480700001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 18:16:37.6712
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c299636-4224-4418-42de-08dabc353786
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5456
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 11/1/22 00:47, Christophe JAILLET wrote:
> Le 12/10/2022 à 20:13, Lizhi Hou a écrit :
>> of_create_node() creates device node and apply to base tree dynamically.
>> The parent device node and full name are required for creating the node.
>> And the caller can also provide a property array for the node.
>>
>> Inside this function, it creates a changeset. Then the new device node
>> and properties are added to the changeset and applied to base tree. The
>> pointer of this changeset is saved in device node private data.
>>
>> of_destroy_node() removes the node created by of_create_node() from the
>> base tree and free it. It gets the changeset pointer from device node
>> private data and call of_changeset_destroy() to free everything.
>>
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>> Signed-off-by: Sonal Santan <sonal.santan@amd.com>
>> Signed-off-by: Max Zhen <max.zhen@amd.com>
>> Signed-off-by: Brian Xu <brian.xu@amd.com>
>> ---
>>   drivers/of/dynamic.c | 80 ++++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/of.h   |  4 +++
>>   2 files changed, 84 insertions(+)
>>
>> diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
>> index cd3821a6444f..eca28b723706 100644
>> --- a/drivers/of/dynamic.c
>> +++ b/drivers/of/dynamic.c
>> @@ -934,3 +934,83 @@ int of_changeset_action(struct of_changeset 
>> *ocs, unsigned long action,
>>       return 0;
>>   }
>>   EXPORT_SYMBOL_GPL(of_changeset_action);
>> +
>> +/**
>> + * of_create_node - Dynamically create a device node and apply it to 
>> base tree
>> + *
>> + * @parent: Pointer to parent device node
>> + * @full_name: Full name of device node
>> + * @props: Pointer to property array
>> + *
>> + * Return: Pointer to the created device node or NULL in case of an 
>> error.
>> + */
>> +struct device_node *of_create_node(struct device_node *parent,
>> +                   const char *full_name,
>> +                   struct property *props)
>> +{
>> +    struct of_changeset *cset;
>> +    struct property *new_pp;
>> +    struct device_node *np;
>> +    int ret, i;
>> +
>> +    cset = kzalloc(sizeof(*cset), GFP_KERNEL);
>
> Hi,
>
> kmalloc() would be enough. of_changeset_init() below already calls 
> memset().
Ok.
>
>> +    if (!cset)
>> +        return NULL;
>> +
>> +    of_changeset_init(cset);
>> +
>> +    np = __of_node_dup(NULL, full_name);
>> +    if (!np)
>> +        goto failed;
>
> 'cset' seems to be leaking if __of_node_dup() fails.

Will fix this. Thanks.


Lizhi

>
>> +    np->parent = parent;
>> +
>> +    ret = of_changeset_attach_node(cset, np);
>> +    if (ret)
>> +        goto failed;
>> +
>> +    if (props) {
>> +        for (i = 0; props[i].name; i++) {
>> +            new_pp = __of_prop_dup(&props[i], GFP_KERNEL);
>> +            if (!new_pp)
>> +                goto failed;
>> +            ret = of_changeset_add_property(cset, np, new_pp);
>> +            if (ret) {
>> +                kfree(new_pp->name);
>> +                kfree(new_pp->value);
>> +                kfree(new_pp);
>> +                goto failed;
>> +            }
>> +        }
>> +    }
>> +
>> +    ret = of_changeset_apply(cset);
>> +    if (ret)
>> +        goto failed;
>> +
>> +    np->data = cset;
>> +
>> +    return np;
>> +
>> +failed:
>> +    of_changeset_destroy(cset);
>> +    if (np)
>> +        of_node_put(np);
>> +
>> +    return NULL;
>> +}
>> +
>> +/**
>> + * of_destroy_node - Destroy a dynamically created device node
>> + *
>> + * @np: Pointer to dynamically created device node
>> + *
>> + */
>> +void of_destroy_node(struct device_node *np)
>> +{
>> +    struct of_changeset *cset;
>> +
>> +    cset = (struct of_changeset *)np->data;
>> +    of_changeset_destroy(cset);
>> +    of_node_put(np);
>> +    kfree(cset);
>> +}
>> diff --git a/include/linux/of.h b/include/linux/of.h
>> index 766d002bddb9..493ef957c1a8 100644
>> --- a/include/linux/of.h
>> +++ b/include/linux/of.h
>> @@ -1475,6 +1475,10 @@ extern int of_changeset_revert(struct 
>> of_changeset *ocs);
>>   extern int of_changeset_action(struct of_changeset *ocs,
>>           unsigned long action, struct device_node *np,
>>           struct property *prop);
>> +struct device_node *of_create_node(struct device_node *parent,
>> +                   const char *full_name,
>> +                   struct property *props);
>> +void of_destroy_node(struct device_node *np);
>>     static inline int of_changeset_attach_node(struct of_changeset *ocs,
>>           struct device_node *np)
>
