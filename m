Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A139E7A224C
	for <lists+linux-pci@lfdr.de>; Fri, 15 Sep 2023 17:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235842AbjIOP02 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Sep 2023 11:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236075AbjIOP0J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Sep 2023 11:26:09 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0310BE50;
        Fri, 15 Sep 2023 08:26:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFiOVr3nZXJVnvwyQqfznxxlXV5J1HHNH0js3mmcCNAOPSjf0H+qwUg82wEJdMMYW7pkb259PLKO+O1bhDUh6mYVTr8QTN/jkK/wWKCnPqo9FlXFUrK4KikOirHTnVmQ7vpPW4qoVvBfFfOLx2bn5Q3QXC6YxE8x08MKKL+BLmVEAjKB1c0AGj6gHHdJPVaS9lo05d+QfJ1PNA7r79MsJXMpXaJXFTal+1Hhq/R63d+o5+AN6jSYLEc4qDNJ6DdXlznOZ0tAPQp7HxNMCOXUl0+Za0YH6h6TfBdnJ0OJco0xggyRt+ZWL6qGwP1I2xW6iDYpOWGyjzRoYllaY326WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XH8WE1MLNMZ93s7vDuzYXG0JxOsIepvRuHXCVNyK1dc=;
 b=T7UCqyoK34ISuuyZhU+/kLLXeyxDG/X7qQAFrq9Dj8C3i3iSAZs3uTqRYxKM+sV3ppFD3J9Xy058Lyf/8xz63vdcqqBFd6kiMpHZUz5YgQL5YEuxj3TJRY/KMBfuNkTZ9+ghy30ApU147wppKcXcw8P/dFVvW8E9039aKuWFF3HxcTWauhfQft6idK2Xn7kr1df4KE/2OHKoSipBNAP5n9wx3X0Xcuhv7Ayhhm6rMisHo315fXZpMK8kITzFA+6cxhiLefvSyg8dwWzcPaaQV7sNSkWPml3FxwbDKzlUcjjkGVNUSDJhkDhwYh1r5u+/hnBiSJHJ9HnpLG6CoJUL6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XH8WE1MLNMZ93s7vDuzYXG0JxOsIepvRuHXCVNyK1dc=;
 b=GX7yhp9WJqXubJNWk5arA/a27TB0qkmtnc07T/nR/g+UT411UT+pSuSDWYsnTMqmxKLVhfhZpuCBs2DK8QC4WukpccFGVatA2pqifDgLvVrttVXMOKEsYhB1xVxRUG9eJF6ydHzi/lsPcILvLWoqWHUZF0EbRAAPdtgyc+MII3c=
Received: from CYZPR14CA0031.namprd14.prod.outlook.com (2603:10b6:930:a0::21)
 by BL1PR12MB5380.namprd12.prod.outlook.com (2603:10b6:208:314::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 15:26:01 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:930:a0:cafe::65) by CYZPR14CA0031.outlook.office365.com
 (2603:10b6:930:a0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 15:26:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Fri, 15 Sep 2023 15:26:00 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Sep
 2023 10:25:59 -0500
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 15 Sep 2023 10:25:59 -0500
Message-ID: <3a6e893a-da6b-7ae5-0b15-a6f0e978a045@amd.com>
Date:   Fri, 15 Sep 2023 08:25:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] PCI: of: Fix memory leak when of_changeset_create_node()
 failed
Content-Language: en-US
To:     Herve Codina <herve.codina@bootlin.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>,
        <robh@kernel.org>
References: <1694715351-58279-1-git-send-email-lizhi.hou@amd.com>
 <20230915090450.206657cf@bootlin.com>
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20230915090450.206657cf@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|BL1PR12MB5380:EE_
X-MS-Office365-Filtering-Correlation-Id: 5078e4af-8218-4d6a-5fa4-08dbb6001130
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h/UjeHEeLDr6ZFQBZYkri0SmsbbksyEj8AsuH/hViVqAfVZ5xgoZfbdBhJZaOn3R2kTogS12xALH3RUCqte4aUWlxKvQwmUgLfDdYLe0qMFtbLPZ1/JHmlfGdMYsYXHFqylXCODsTx9zuFLStWCQyCUq3ey/6+nGtTgccSZ2bTJl5fQowQd5/ADYZFwqTceb/uo5yl0Gxkmy4W/5tY8tG+tLKnflhhw5BCGc83BKJtUJ2CGBrxeFq/W4jCJmWvyZXR+WH05TkeqBpbnpTPqUUIjrPKEePO1hXX0SvWH08fMl6Gpgg+m0LQt+Sh1GSd8UNkfwF3EWkLm+62wqjO9RFusgTgEdcZnFDcMXjNpvjNA6NS25972KAQQZfd+r49djD+4qJrTGHdJsFV0N0JvmnswVnJXzwo7nw7gYQE7UM+nIacZUbe9QtYblxIhC21FVgfWJujZ7SEF6ByeXZ3x8GFrTRkbntnIh0+1tmwSq5l0+MfH4tqApltbPpMQMNEFqwM8En/nVQonthnMhty2b1ceihzUaWkI6B7Ig/Jg4CxRwKQswuYkJB75Jf5WB0LRy69m6oCVC0lqHidLRAl/NWFodlkypUShwM+eF/u842SV7Pi+ZgCJONgjDAEnopMg1nXWDWp9VMi0w45zrFWlrEZMd0Z0Y/RbePr9kxkGcESSQ+bfGM+bEKoT/I7z0RrTBrQyAX1QlYz4b9VD3umRErua1zfWYCtJUy4AbxQFJvHrm+ECHE+iw+kHYUZCVUiXyT9gVUS8kjejBrfP9jbcQ86jNmyJnL46Wl/yJbQyHndcsYErIA+WqZ1B5eQH2WDYCkYJSRW4Xith3zPwNKjTg8w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(82310400011)(1800799009)(186009)(451199024)(36840700001)(40470700004)(46966006)(40460700003)(53546011)(83380400001)(86362001)(82740400003)(81166007)(356005)(31696002)(36860700001)(47076005)(36756003)(2616005)(40480700001)(336012)(426003)(26005)(70206006)(70586007)(54906003)(2906002)(16576012)(41300700001)(316002)(6916009)(44832011)(478600001)(5660300002)(31686004)(8676002)(4326008)(8936002)(966005)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 15:26:00.6601
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5078e4af-8218-4d6a-5fa4-08dbb6001130
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5380
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 9/15/23 00:04, Herve Codina wrote:
> Hi Lizhi
>
> On Thu, 14 Sep 2023 11:15:51 -0700
> Lizhi Hou <lizhi.hou@amd.com> wrote:
>
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
> Why this patch alone ?
> The issue fixed by this patch is related to the patch 2 in a series under review
>    https://lore.kernel.org/linux-kernel/ZQGaSr+G5qu%2F8nJZ@smile.fi.intel.com/
> Is the patch 2 in this series already applied by some maintainers ?
Yes.
>
> You have to fix the patch in the series sending a new iteration of the series.
>
> This patch alone does not make sense.
>
> Otherwise, the modifications to fix the issue seem good.
>
> Regards,
> Hervé
>
>> --- a/drivers/pci/of.c
>> +++ b/drivers/pci/of.c
>> @@ -663,7 +663,6 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
>>   	np = of_changeset_create_node(cset, ppnode, name);
>>   	if (!np)
>>   		goto failed;
>> -	np->data = cset;
>>   
>>   	ret = of_pci_add_properties(pdev, cset, np);
>>   	if (ret)
>> @@ -673,12 +672,17 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
>>   	if (ret)
>>   		goto failed;
>>   
>> +	np->data = cset;
>>   	pdev->dev.of_node = np;
>>   	kfree(name);
>>   
>>   	return;
>>   
>>   failed:
>> +	if (cset) {
>> +		of_changeset_destroy(cset);
>> +		kfree(cset);
>> +	}
>>   	if (np)
>>   		of_node_put(np);
>>   	kfree(name);
