Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C8E3D981B
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jul 2021 00:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbhG1WBt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jul 2021 18:01:49 -0400
Received: from mail-dm6nam10on2089.outbound.protection.outlook.com ([40.107.93.89]:31712
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231668AbhG1WBs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Jul 2021 18:01:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRdfD3405GJKrQWtgx3zPFSwanxD3yPkaSmjbSR5pk6HEqhbo4/ngUIsyk9T3if8+kNNsN/ZJMnuE1K019GTSVKx7SHew4Mu4d7rhH868jdhde778Lkpt/VaCm2+O8pCRSpUZpBgi3TOnoTc9fIm36NhdgrbY3ipEeCxRCmSnq9Ri+8mzuHMGlHL8D9pnc9lWxa2BysS8crSV9+qOE6PFv4cL+iY0Kcu8EAMtcKiUsxwK5rfJfR1OD2+nJhFl155oz7YPT63jznWZ7MyezIYeQhcSrtnoZGd/cbPn81Av7hnCYIJ14HV0IZCUn5jclFr1uUwcb3PT6VHE5/dm+TTxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ix+lyizIBOmC4/iaM96Bn44b5MO1n6c0ADhY8nZn+Vc=;
 b=CBkNjCD762e8UHeyr3Hjd9sA/nd8Y86LLw+sTz+pbFnAjXW5guMJvmDrHRO1mzldGb/PKP1dsN65urh+TAoK/gLYuR1AXGePvpix/WwXIZXETqaRPNo+dnRS1sdtR7OnHJAVjcnxS1/x8eY4HWMfSM1aKp9ELMXgtbP7/WV5rgD64BadLU4lM8cyLKp6nsuIcHCxYMV6lzSFAXejuHhwyVYVbHWn9RLnCOsA3t67pngku2G8dOFHfvzYN+bJsLW+GCcC9bjL7+8LJiDJpSRjD6IRugJ5OeqktsxTbTWfVrra07Cofjhg8f1k1TAMmazH1DaMwqcJSnsDxhTlvN+3og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ix+lyizIBOmC4/iaM96Bn44b5MO1n6c0ADhY8nZn+Vc=;
 b=Papq3c3SWr09DSsv2zbSZcHnSK+2HNEk9IyAgW9iKuHdZYjEHN9EiwDFvfcoU2GQwmGC/cr+xErRTnN5rCsjEGiOmaQdHOYYoxPxEk1NADslzHqJfnpp2a5mjKsqADn10qjWxLu/+LVWisa8l2opeSTo4bXI83F0o4bmQuc/83raEHZNzwptI8pahhbZ5wh+4pdPSwgSOAF+IS9C6VWQBC7owXWGdhHM/mVGyt9AfvsWLHuZm9vzATcBgEDwnMPH0/4vXWHKtcLhIcvPR2O+YlqlbNvT5izD17QawwQGYFIqoVbIdAebYBjnut1WSXiI0AosFS7ZwWdzLy2Wruz2hg==
Received: from BN9PR03CA0434.namprd03.prod.outlook.com (2603:10b6:408:113::19)
 by DM6PR12MB2684.namprd12.prod.outlook.com (2603:10b6:5:4a::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17; Wed, 28 Jul
 2021 22:01:45 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::af) by BN9PR03CA0434.outlook.office365.com
 (2603:10b6:408:113::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17 via Frontend
 Transport; Wed, 28 Jul 2021 22:01:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4373.18 via Frontend Transport; Wed, 28 Jul 2021 22:01:45 +0000
Received: from [10.20.23.47] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 28 Jul
 2021 22:01:43 +0000
Subject: Re: [PATCH v10 2/8] PCI: Add new array for keeping track of ordering
 of reset methods
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Amey Narkhede <ameynarkhede03@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <alex.williamson@redhat.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kw@linux.com>, Sinan Kaya <okaya@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
References: <20210728202513.GA848092@bjorn-Precision-5520>
From:   Shanker R Donthineni <sdonthineni@nvidia.com>
Message-ID: <3382bb94-0cf1-52eb-1b97-69b4536f4874@nvidia.com>
Date:   Wed, 28 Jul 2021 17:01:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210728202513.GA848092@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19eecdbc-dbff-41a7-a7d8-08d952134a78
X-MS-TrafficTypeDiagnostic: DM6PR12MB2684:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2684BB41CFF452C53F4D1FC6C7EA9@DM6PR12MB2684.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lq4p8VCmAi9D5vgQxoXA2ucZAuVVxonx/lzod7cKqsCob6zZ+YP69NyOXNVqtEbWSq4QNNDxXtvqp4JSEsHA+cqqprCHzUY803YTH7yGvWlQhI6jwqP3tdsLJxtOq0XYAbpxf5uDuSSw3pmUDacWbNuJDLHBa3nC0LczLFVE6mvRGZI1LEYtn1FoK82mWv7E8uc6XtvM+jk21TqwN0PJrQHRl4zsmouFZBW9RTngkTWvJoMev7bJqMaBheb1Ta0DZXwgI0hZb0W3KsILE7r46vBSlW0hfmSMQGuScR4cp5rMDO5pCWObaeh3iaF2yd4j2UddjGvjfxLTpflxM6CEPOMGIkccPeNSzrxZHYSIwynbWZqXcHIc9FXSTjz4PHMX6C/jUiauzFLbZanp7q8nr1Sbw6sxiAOasoaVVE/LLHrqROpnwt3siuL1JQ8YRBJw3xg1ccip359IiwvI9YVdsHooTlH6Lvs3Skbd/MG1/qMmI/T8poM5xkRv+5joe10weP/d9NA3xVLZvZbU/tiTNkHQ1m1HTizzCbHFxFm/bGPnbDaDYg0Ly/BxQJzA41eoycGrulL4JbAM+WvXVdeCWD3o0AjlBueLi8Gz5dXN0LYCjxaFNXf6PTY1e7zOiYzZl7a5sx03uo2UCgLrXk9VZwcyjsEsmSVIL72z//8zeNiVYj5obmfiTM96w9z5NsnpzyXGU3r0i6CmTRwKdRNKsQsUrEJzphnHV/fpiALdhXG59FLXdGIBCW66LZuVNLRN+J88F7fAxJvQ/2cyaqHLcQ==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(346002)(396003)(46966006)(36840700001)(36860700001)(356005)(426003)(82310400003)(7416002)(47076005)(336012)(316002)(5660300002)(31696002)(186003)(70206006)(2906002)(53546011)(70586007)(36906005)(478600001)(54906003)(16576012)(4326008)(2616005)(8676002)(26005)(8936002)(82740400003)(36756003)(16526019)(31686004)(6916009)(86362001)(7636003)(43740500002)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 22:01:45.5054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19eecdbc-dbff-41a7-a7d8-08d952134a78
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2684
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 7/28/21 3:25 PM, Bjorn Helgaas wrote:
> External email: Use caution opening links or attachments
>
>
> On Wed, Jul 28, 2021 at 01:31:19PM -0500, Shanker R Donthineni wrote:
>> Hi Bjorn,
>>
>> On 7/27/21 5:59 PM, Bjorn Helgaas wrote:
>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>> index fefa6d7b3..42440cb10 100644
>>>> --- a/drivers/pci/pci.c
>>>> +++ b/drivers/pci/pci.c
>>>> @@ -72,6 +72,14 @@ static void pci_dev_d3_sleep(struct pci_dev *dev)
>>>>               msleep(delay);
>>>>  }
>>>>
>>>> +int pci_reset_supported(struct pci_dev *dev)
>>>> +{
>>>> +     u8 null_reset_methods[PCI_NUM_RESET_METHODS] = { 0 };
>>>> +
>>>> +     return memcmp(null_reset_methods,
>>>> +                   dev->reset_methods, sizeof(null_reset_methods));
>>> I think "return dev->reset_methods[0] != 0;" is sufficient, isn't it?
>>>
>> Agree with you, it simplifies code logic and can be moved to
>> "include/linux/pci.h" with inline definition. Can we change return
>> type to 'bool' instead of 'int' ?
> Does it need to be exported to drivers?  Looks like it's only used
> inside drivers/pci/, so it shouldn't be in include/linux/pci.h.

Yes, you're right can be moved to driver/pci/pci.h.

> Making it bool is fine with me.
>
>> static inline bool pci_reset_supported(struct pci_dev *dev)
>> {  
>>     return !!dev->reset_methods[0];
>> }
>>

