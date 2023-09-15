Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF25B7A245B
	for <lists+linux-pci@lfdr.de>; Fri, 15 Sep 2023 19:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjIORME (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Sep 2023 13:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235340AbjIORMB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Sep 2023 13:12:01 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C24110C7;
        Fri, 15 Sep 2023 10:11:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZE2zRdhIIMI/WECYkWMasJtLCstliltcpiHoIXbMt5BQDSh7UP3XspLV/200+RxRCcJDu+GdRP8FSzuwmKOCFc7NmlvQhNkly6VR8rQ23P7U1dKSYfo6x1oaYMNtMVJ8jhSu2R68TTZIuXFbOA6kZStkS4UUQYyxG3qsKlwGKAKE5+cfp08JNj9x16c2Cvfh4cllf4yZOqquNRkQVTOV0ID64+Tbgvrckv52C7geJ0S3+u6s3FvtHYEkHhkYEPfgj+nS/0IO2uUrWT0yGtQjeWzZ/r97J9UmZHPWfLbMaiZxVq+4LbKvMstr5s55NxMCBz1AaQNuXUCAxF/w0KbfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZSmvsNU+vvFApQ0DIuwhDn8loTvkxTJB/UQXk0vJMas=;
 b=PEFfNcgYjAaA3FDGgrL99f3yKJi0tZU+drdwDOPjV63mHwiUWczwk/tDAnKlX6CyPrz2ahuTNzB3YcuJCQDMkaOkJ2pAIxud/OQRaX2ZQCLhArbAP2c7nd/KgFyuAjSaVOEOAwVJT2kMSnWfqSlfQe414ZbRnn7FI57gMF+mYNxtnzZfYVlrtB7KCsQ/Bfw3tmhy2EbIKjHnrKLpof7sSusXEj6qpHWJLPQQIhYhM+PnK1F6BcX0nTQcuEGed0ap4SRaVI1ki1xej+c3bIuZW2r9FL5544EWJ6AgPa/0Sre1UMc6T0bFvbkIbzmVQJhWjeVz1GqUdWT/8idoeEmayw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSmvsNU+vvFApQ0DIuwhDn8loTvkxTJB/UQXk0vJMas=;
 b=PzqQtuDrLmm7lpfOxzAknmQNkJHV45hNfSr/ZQpeNcShhu6u/iISVvmk1RUeuz7Qv67h8KQs/YoNnF5d4mD0Sqqb+ldqoHscAkNht+X5L8vYOpdId99oW1rc3yE7ohawojTSBHdRKhET/GJGQDLUTeo2zYfDKZMzLgdi7jlxres=
Received: from MW4PR04CA0317.namprd04.prod.outlook.com (2603:10b6:303:82::22)
 by PH0PR12MB8775.namprd12.prod.outlook.com (2603:10b6:510:28e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.33; Fri, 15 Sep
 2023 17:11:53 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:303:82:cafe::71) by MW4PR04CA0317.outlook.office365.com
 (2603:10b6:303:82::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 17:11:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Fri, 15 Sep 2023 17:11:53 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Sep
 2023 12:11:52 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Sep
 2023 10:11:51 -0700
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 15 Sep 2023 12:11:51 -0500
Message-ID: <ebdc4295-f9ee-7e5f-2616-10f7567054ec@amd.com>
Date:   Fri, 15 Sep 2023 10:11:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] PCI: of: Fix memory leak when of_changeset_create_node()
 failed
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <herve.codina@bootlin.com>,
        <bhelgaas@google.com>
References: <1694715351-58279-1-git-send-email-lizhi.hou@amd.com>
 <CAL_JsqLLfTONAA4XPsQdYC0XL-F0jmMhaz_mmr_uTCOf6SqOqQ@mail.gmail.com>
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <CAL_JsqLLfTONAA4XPsQdYC0XL-F0jmMhaz_mmr_uTCOf6SqOqQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|PH0PR12MB8775:EE_
X-MS-Office365-Filtering-Correlation-Id: 57ba5076-8548-4c89-dfbf-08dbb60edb82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G8DCmLYS1XgmF8FAC5VyqGvS8uOOKvjNafhwJfD9kC4X16HOnSYNZyl2z3tEABptvDNctY9VFMMlQ1UOH5+IOFqTBisRK6I21idqtekurw9Al6yq8oBv112Hwa9QcGgOkh9KJZPPBzeaPSdjMvMZlkRNIr8dXiARyfQEHi+PvY12UGLYncb1/yw+hISo/D4K4Xg2MQbBhn+DqWpiKlguhXzIsZai1qN0/cioc/ahyjOlCzwTvGVkasidAoB4W6MShVwpzSJ+BK+nBerigGG+7mCj3nVIyRTIfW77SJ8bPnlPVT3sOd1livu6RL3T4xpSHnvZD6rrEQl213rnHg+0LcKznyug1ZC3/hjAEfQxXziODtHQzDtHMnq8kfywJ1Rx/tlRB1r/STR2l/P9uc3PbqjWewNEm+s10jV/mUTjEIqmmL8IgKGV6NfS5lU2GGWg+NkK6sVjEwyrF2CtuEKXYcnmP4rCkzGTJfA9iv7hzkFtXGv/LTN8+0aU03c6qRJI3sXsW25bTkDtlTTKXKeD3p+arkejn1tmi0svXsRvk/JLRvXywjc+WSPAx0geuEiMd/RVacVDm0ACqMlCnH1v5kSw5X+UPvKCQLQW9gE9Rb4iWtOh3O8ytxREWaXOFdRgSvA95+bXRaB5BKa/xqEOFCHbvDUI4DxSto2XXbFQbrjjBxcr9HnWF3ELvoiGUdXPmle5zqKgaLeuNFm/BWFhQgVKtbdtsD0eqdeXqzineyUQg4jlZFz9Qarl3fHpaDiPwWmC2oycON6CkM+mpcuimeNdhFdJXMuYfdoM/hXczp8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(136003)(39860400002)(82310400011)(186009)(451199024)(1800799009)(36840700001)(40470700004)(46966006)(53546011)(6666004)(40460700003)(83380400001)(82740400003)(86362001)(356005)(81166007)(31696002)(47076005)(36756003)(36860700001)(2616005)(336012)(40480700001)(26005)(31686004)(70586007)(6916009)(8936002)(16576012)(41300700001)(316002)(8676002)(70206006)(426003)(54906003)(44832011)(478600001)(4326008)(5660300002)(2906002)(966005)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 17:11:53.0235
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57ba5076-8548-4c89-dfbf-08dbb60edb82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8775
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 9/15/23 09:20, Rob Herring wrote:
> On Thu, Sep 14, 2023 at 1:16 PM Lizhi Hou <lizhi.hou@amd.com> wrote:
>> Destroy and free cset when failure happens.
>>
>> Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
>> Reported-by: Herve Codina <herve.codina@bootlin.com>
>> Closes: https://lore.kernel.org/all/20230911171319.495bb837@bootlin.com/
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>> ---
>>   drivers/pci/of.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>> index 2af64bcb7da3..67bbfa2fca59 100644
>> --- a/drivers/pci/of.c
>> +++ b/drivers/pci/of.c
>> @@ -663,7 +663,6 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
>>          np = of_changeset_create_node(cset, ppnode, name);
>>          if (!np)
>>                  goto failed;
>> -       np->data = cset;
>>
>>          ret = of_pci_add_properties(pdev, cset, np);
>>          if (ret)
>> @@ -673,12 +672,17 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
>>          if (ret)
>>                  goto failed;
>>
>> +       np->data = cset;
>>          pdev->dev.of_node = np;
>>          kfree(name);
>>
>>          return;
>>
>>   failed:
>> +       if (cset) {
> Instead of adding more if's, use multiple goto labels which is the
> normal cleanup style. Note that there's a new cleanup.h thing that can
> do some automatic cleanups. Not sure if that works or helps here.

Ok. I will create another patch to use multiple goto labels.


Lizhi

>
>> +               of_changeset_destroy(cset);
>> +               kfree(cset);
>> +       }
>>          if (np)
>>                  of_node_put(np);
>>          kfree(name);
>> --
>> 2.34.1
>>
