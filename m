Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF7A3ADE76
	for <lists+linux-pci@lfdr.de>; Sun, 20 Jun 2021 15:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbhFTNYT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 20 Jun 2021 09:24:19 -0400
Received: from mail-dm6nam12on2074.outbound.protection.outlook.com ([40.107.243.74]:21380
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229593AbhFTNYS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 20 Jun 2021 09:24:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0Glel2EPnGl5sa80PBbNJLF37sJiTIL6eCdRgea2PDztU7sDkxotPwGlCfA6ODW2LRKV/95gEgVPZFwYKuU1b3mXOiYXPwsVq6Y6/5DxZo+a9cxauaVMY3AtOj04N7JL39+euB7z/a6kLRdrP+u/esoHAS+a3HeydX/181yPqQjCfPylq4Qy/eJDeflTFaGKYpEpD56DV9rRK9XG01f9oDjuCXHBdm5P0Cif2/z0ROhPCooFJf2aGRrpvQGg/QiFuJCPdAIL663+31hAHBs/zjNDVyekO5rf/iWQxqmZvqOFkNKydjinSnqbg6kMlAv8WWFGwT3Fvt0NM0SQmu0sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+6FmtstBc3XpTznfvc8cfZITV0/CQxeTENK9BQc2h4=;
 b=SclSStxVGRRVAW9D82TShSOn0t/hW+jI2yygJiqoO7rAHHrszI22Un/1w7qC7B0aIoNNHCfU6jfJcIR5Ge7m3QQbOi2Wt+Uz9qvrNUXAbJbyfmUAmJfAf3R/5vkdFeI+deTHEhCf1U1vnmDRPQO2OWzIYCW7lQ9XeIGw4h4889CfT4uMoIaFO7b2LnvkKYf0xDbFoJetbPTiRA80IyEEHvfW2lnyvOFic1fgEiX/eEmqZ3LbO9A5w/ErKBxfWeSb+Gdf/KOCkQhT3JRsuHrgPKRm3lK3QhijONO8T/HXp5DHAOOZIMoHKyzXV5OrXFgEj4nP049XtirZkQznEUDxGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+6FmtstBc3XpTznfvc8cfZITV0/CQxeTENK9BQc2h4=;
 b=uUV+pMcqtGWFeOxjC+a7Nb0ep2mssz+UKdj/BRyQjS5qEolvU7GZg/iZFOuRVfrA98yyTDVRu51PB5+DFDvQPF9eIssRSylsWxdVwbUSjnIUV0TkKIPWM0uCw+/gzKY+Krj0jvORR8bSdTJKsxjRoFlK+2ypFxzK5NCeV1RaLT7/3aSDtwACaMh3M6Yv/WOQ205FZXg2OXphMW+Rs4doNUbuCM9g8uiNNcehRSQzZiEP1TTVDNK/LI6b1m21T+TOa0q0IMCZ9gmvksiqBc8jR93VK5PV+37NijHFtHErJm/N2jFaEcSFinE1cuk3ybM8DhkjaMEkTFsfkqxQPUVqdw==
Received: from MW4PR04CA0111.namprd04.prod.outlook.com (2603:10b6:303:83::26)
 by DM6PR12MB4651.namprd12.prod.outlook.com (2603:10b6:5:1f6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Sun, 20 Jun
 2021 13:22:04 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::6b) by MW4PR04CA0111.outlook.office365.com
 (2603:10b6:303:83::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21 via Frontend
 Transport; Sun, 20 Jun 2021 13:22:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4242.16 via Frontend Transport; Sun, 20 Jun 2021 13:22:03 +0000
Received: from [10.25.74.204] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 20 Jun
 2021 13:21:55 +0000
Subject: Re: [PATCH v2 2/5] PCI: endpoint: Replace spinlock with mutex
From:   Vidya Sagar <vidyas@nvidia.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Athani Nadeem Ladkhan" <nadeem@cadence.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Om Prakash Singh <omp@nvidia.com>,
        Krishna Thota <kthota@nvidia.com>
References: <20200212112514.2000-1-kishon@ti.com>
 <20200212112514.2000-3-kishon@ti.com>
 <901293cd-e67a-04a4-d61e-37a105c33d15@nvidia.com>
Message-ID: <3a541265-f73d-6e3a-8a04-f0616d8ed961@nvidia.com>
Date:   Sun, 20 Jun 2021 18:51:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <901293cd-e67a-04a4-d61e-37a105c33d15@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e8cfd16-950c-4624-08ac-08d933ee6573
X-MS-TrafficTypeDiagnostic: DM6PR12MB4651:
X-Microsoft-Antispam-PRVS: <DM6PR12MB46517D270ED052EF07746B6EB80B9@DM6PR12MB4651.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q7014PULzjy3dJmj3Ltt+s+1R32gdrt11rAKP4rkH33RpY9dWCu2+RappZ+RiQWrg0iEpZCx10ebodZ35iEwe0aG7rkOkmRJxdPpklvgfNYFMtptw+f30ekJvq6Iy2es5ca+5lnd49RZUuDgjSVhF/6auSD+fvcOOFres+Mo4oaXFMiB03lvwJsfIRXGiM6yU1NGbV1nsy83GgYoHHQ9vCnoris0nWBrLJV6zROwSZtO2xrGSyW1n7gtTHEfwVKpnz5OGbCB5Ruf4PGRT3et+BJY6QyQAYeHz76IJG8JlZIs5KxNUdki+SC+qfKW03FO/4uIIThz+s4fGveLCFaZLL4Edgdf1Kovc90GGEgRVPKJY3eX6kB5/9O3ReA0BuGOnzw+nChx4/oPeRghuosx16XPZPLIGKYfZVa6tJ4Y62HWf+A3ogV2BI3nC+1pNj4R/E5z7ryrmyVhqkfCT8nHfIlID+lfMXayyjzFlkgeuch/a7iD03TQc81MEbbdsgKggsVjm/RoNvsIk887I532Qgzcf4G7R5PLIMphnF86uBrzLCzT13r7EPQakfY1Hc3zfNZwH/+AW5R42RTDALzRpJvoT6bVNtIdP5OpwromYVjmkd4HDUwAiIJmQ9NYl+DudirHpS0bf6EA4adamlTgeJUmdJ76aNihcJ0ndthSFqnJXVjIRoSrERr0bwCpq1jL
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(36840700001)(46966006)(47076005)(4326008)(36906005)(26005)(478600001)(82740400003)(16576012)(316002)(426003)(186003)(8676002)(336012)(16526019)(82310400003)(83380400001)(31696002)(70586007)(5660300002)(36756003)(6916009)(86362001)(356005)(53546011)(2616005)(8936002)(54906003)(2906002)(70206006)(31686004)(36860700001)(107886003)(30864003)(7636003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2021 13:22:03.9950
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e8cfd16-950c-4624-08ac-08d933ee6573
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4651
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kishon,
Did you get time to look into it?

Thanks,
Vidya Sagar

On 6/11/2021 3:22 PM, Vidya Sagar wrote:
> Hi Kishon,
> Apologies for bringup it up this late.
> I'm wondering if there was any issue which this patch tried to address?
> Actually, "The pci_epc_ops is not intended to be invoked from interrupt 
> context" isn't true in case of Tegra194. We do call 
> dw_pcie_ep_init_notify() API from threaded irq service routine and it 
> eventually calls mutext_lock() of pci_epc_get_features() which is 
> reusulting in the following warning log.
> BUG: sleeping function called from invalid context at 
> kernel/locking/mutex.c:
> Would like hear your comments on it.
> 
> Thanks,
> Vidya Sagar
> 
> On 2/12/2020 4:55 PM, Kishon Vijay Abraham I wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> The pci_epc_ops is not intended to be invoked from interrupt context.
>> Hence replace spin_lock_irqsave and spin_unlock_irqrestore with
>> mutex_lock and mutex_unlock respectively.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>   drivers/pci/endpoint/pci-epc-core.c | 82 +++++++++++------------------
>>   include/linux/pci-epc.h             |  6 +--
>>   2 files changed, 34 insertions(+), 54 deletions(-)
>>
>> diff --git a/drivers/pci/endpoint/pci-epc-core.c 
>> b/drivers/pci/endpoint/pci-epc-core.c
>> index 2f6436599fcb..e51a12ed85bb 100644
>> --- a/drivers/pci/endpoint/pci-epc-core.c
>> +++ b/drivers/pci/endpoint/pci-epc-core.c
>> @@ -120,7 +120,6 @@ const struct pci_epc_features 
>> *pci_epc_get_features(struct pci_epc *epc,
>>                                                      u8 func_no)
>>   {
>>          const struct pci_epc_features *epc_features;
>> -       unsigned long flags;
>>
>>          if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
>>                  return NULL;
>> @@ -128,9 +127,9 @@ const struct pci_epc_features 
>> *pci_epc_get_features(struct pci_epc *epc,
>>          if (!epc->ops->get_features)
>>                  return NULL;
>>
>> -       spin_lock_irqsave(&epc->lock, flags);
>> +       mutex_lock(&epc->lock);
>>          epc_features = epc->ops->get_features(epc, func_no);
>> -       spin_unlock_irqrestore(&epc->lock, flags);
>> +       mutex_unlock(&epc->lock);
>>
>>          return epc_features;
>>   }
>> @@ -144,14 +143,12 @@ EXPORT_SYMBOL_GPL(pci_epc_get_features);
>>    */
>>   void pci_epc_stop(struct pci_epc *epc)
>>   {
>> -       unsigned long flags;
>> -
>>          if (IS_ERR(epc) || !epc->ops->stop)
>>                  return;
>>
>> -       spin_lock_irqsave(&epc->lock, flags);
>> +       mutex_lock(&epc->lock);
>>          epc->ops->stop(epc);
>> -       spin_unlock_irqrestore(&epc->lock, flags);
>> +       mutex_unlock(&epc->lock);
>>   }
>>   EXPORT_SYMBOL_GPL(pci_epc_stop);
>>
>> @@ -164,7 +161,6 @@ EXPORT_SYMBOL_GPL(pci_epc_stop);
>>   int pci_epc_start(struct pci_epc *epc)
>>   {
>>          int ret;
>> -       unsigned long flags;
>>
>>          if (IS_ERR(epc))
>>                  return -EINVAL;
>> @@ -172,9 +168,9 @@ int pci_epc_start(struct pci_epc *epc)
>>          if (!epc->ops->start)
>>                  return 0;
>>
>> -       spin_lock_irqsave(&epc->lock, flags);
>> +       mutex_lock(&epc->lock);
>>          ret = epc->ops->start(epc);
>> -       spin_unlock_irqrestore(&epc->lock, flags);
>> +       mutex_unlock(&epc->lock);
>>
>>          return ret;
>>   }
>> @@ -193,7 +189,6 @@ int pci_epc_raise_irq(struct pci_epc *epc, u8 
>> func_no,
>>                        enum pci_epc_irq_type type, u16 interrupt_num)
>>   {
>>          int ret;
>> -       unsigned long flags;
>>
>>          if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
>>                  return -EINVAL;
>> @@ -201,9 +196,9 @@ int pci_epc_raise_irq(struct pci_epc *epc, u8 
>> func_no,
>>          if (!epc->ops->raise_irq)
>>                  return 0;
>>
>> -       spin_lock_irqsave(&epc->lock, flags);
>> +       mutex_lock(&epc->lock);
>>          ret = epc->ops->raise_irq(epc, func_no, type, interrupt_num);
>> -       spin_unlock_irqrestore(&epc->lock, flags);
>> +       mutex_unlock(&epc->lock);
>>
>>          return ret;
>>   }
>> @@ -219,7 +214,6 @@ EXPORT_SYMBOL_GPL(pci_epc_raise_irq);
>>   int pci_epc_get_msi(struct pci_epc *epc, u8 func_no)
>>   {
>>          int interrupt;
>> -       unsigned long flags;
>>
>>          if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
>>                  return 0;
>> @@ -227,9 +221,9 @@ int pci_epc_get_msi(struct pci_epc *epc, u8 func_no)
>>          if (!epc->ops->get_msi)
>>                  return 0;
>>
>> -       spin_lock_irqsave(&epc->lock, flags);
>> +       mutex_lock(&epc->lock);
>>          interrupt = epc->ops->get_msi(epc, func_no);
>> -       spin_unlock_irqrestore(&epc->lock, flags);
>> +       mutex_unlock(&epc->lock);
>>
>>          if (interrupt < 0)
>>                  return 0;
>> @@ -252,7 +246,6 @@ int pci_epc_set_msi(struct pci_epc *epc, u8 
>> func_no, u8 interrupts)
>>   {
>>          int ret;
>>          u8 encode_int;
>> -       unsigned long flags;
>>
>>          if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions ||
>>              interrupts > 32)
>> @@ -263,9 +256,9 @@ int pci_epc_set_msi(struct pci_epc *epc, u8 
>> func_no, u8 interrupts)
>>
>>          encode_int = order_base_2(interrupts);
>>
>> -       spin_lock_irqsave(&epc->lock, flags);
>> +       mutex_lock(&epc->lock);
>>          ret = epc->ops->set_msi(epc, func_no, encode_int);
>> -       spin_unlock_irqrestore(&epc->lock, flags);
>> +       mutex_unlock(&epc->lock);
>>
>>          return ret;
>>   }
>> @@ -281,7 +274,6 @@ EXPORT_SYMBOL_GPL(pci_epc_set_msi);
>>   int pci_epc_get_msix(struct pci_epc *epc, u8 func_no)
>>   {
>>          int interrupt;
>> -       unsigned long flags;
>>
>>          if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
>>                  return 0;
>> @@ -289,9 +281,9 @@ int pci_epc_get_msix(struct pci_epc *epc, u8 func_no)
>>          if (!epc->ops->get_msix)
>>                  return 0;
>>
>> -       spin_lock_irqsave(&epc->lock, flags);
>> +       mutex_lock(&epc->lock);
>>          interrupt = epc->ops->get_msix(epc, func_no);
>> -       spin_unlock_irqrestore(&epc->lock, flags);
>> +       mutex_unlock(&epc->lock);
>>
>>          if (interrupt < 0)
>>                  return 0;
>> @@ -311,7 +303,6 @@ EXPORT_SYMBOL_GPL(pci_epc_get_msix);
>>   int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u16 interrupts)
>>   {
>>          int ret;
>> -       unsigned long flags;
>>
>>          if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions ||
>>              interrupts < 1 || interrupts > 2048)
>> @@ -320,9 +311,9 @@ int pci_epc_set_msix(struct pci_epc *epc, u8 
>> func_no, u16 interrupts)
>>          if (!epc->ops->set_msix)
>>                  return 0;
>>
>> -       spin_lock_irqsave(&epc->lock, flags);
>> +       mutex_lock(&epc->lock);
>>          ret = epc->ops->set_msix(epc, func_no, interrupts - 1);
>> -       spin_unlock_irqrestore(&epc->lock, flags);
>> +       mutex_unlock(&epc->lock);
>>
>>          return ret;
>>   }
>> @@ -339,17 +330,15 @@ EXPORT_SYMBOL_GPL(pci_epc_set_msix);
>>   void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no,
>>                          phys_addr_t phys_addr)
>>   {
>> -       unsigned long flags;
>> -
>>          if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
>>                  return;
>>
>>          if (!epc->ops->unmap_addr)
>>                  return;
>>
>> -       spin_lock_irqsave(&epc->lock, flags);
>> +       mutex_lock(&epc->lock);
>>          epc->ops->unmap_addr(epc, func_no, phys_addr);
>> -       spin_unlock_irqrestore(&epc->lock, flags);
>> +       mutex_unlock(&epc->lock);
>>   }
>>   EXPORT_SYMBOL_GPL(pci_epc_unmap_addr);
>>
>> @@ -367,7 +356,6 @@ int pci_epc_map_addr(struct pci_epc *epc, u8 func_no,
>>                       phys_addr_t phys_addr, u64 pci_addr, size_t size)
>>   {
>>          int ret;
>> -       unsigned long flags;
>>
>>          if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
>>                  return -EINVAL;
>> @@ -375,9 +363,9 @@ int pci_epc_map_addr(struct pci_epc *epc, u8 func_no,
>>          if (!epc->ops->map_addr)
>>                  return 0;
>>
>> -       spin_lock_irqsave(&epc->lock, flags);
>> +       mutex_lock(&epc->lock);
>>          ret = epc->ops->map_addr(epc, func_no, phys_addr, pci_addr, 
>> size);
>> -       spin_unlock_irqrestore(&epc->lock, flags);
>> +       mutex_unlock(&epc->lock);
>>
>>          return ret;
>>   }
>> @@ -394,8 +382,6 @@ EXPORT_SYMBOL_GPL(pci_epc_map_addr);
>>   void pci_epc_clear_bar(struct pci_epc *epc, u8 func_no,
>>                         struct pci_epf_bar *epf_bar)
>>   {
>> -       unsigned long flags;
>> -
>>          if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions ||
>>              (epf_bar->barno == BAR_5 &&
>>               epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64))
>> @@ -404,9 +390,9 @@ void pci_epc_clear_bar(struct pci_epc *epc, u8 
>> func_no,
>>          if (!epc->ops->clear_bar)
>>                  return;
>>
>> -       spin_lock_irqsave(&epc->lock, flags);
>> +       mutex_lock(&epc->lock);
>>          epc->ops->clear_bar(epc, func_no, epf_bar);
>> -       spin_unlock_irqrestore(&epc->lock, flags);
>> +       mutex_unlock(&epc->lock);
>>   }
>>   EXPORT_SYMBOL_GPL(pci_epc_clear_bar);
>>
>> @@ -422,7 +408,6 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_no,
>>                      struct pci_epf_bar *epf_bar)
>>   {
>>          int ret;
>> -       unsigned long irq_flags;
>>          int flags = epf_bar->flags;
>>
>>          if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions ||
>> @@ -437,9 +422,9 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_no,
>>          if (!epc->ops->set_bar)
>>                  return 0;
>>
>> -       spin_lock_irqsave(&epc->lock, irq_flags);
>> +       mutex_lock(&epc->lock);
>>          ret = epc->ops->set_bar(epc, func_no, epf_bar);
>> -       spin_unlock_irqrestore(&epc->lock, irq_flags);
>> +       mutex_unlock(&epc->lock);
>>
>>          return ret;
>>   }
>> @@ -460,7 +445,6 @@ int pci_epc_write_header(struct pci_epc *epc, u8 
>> func_no,
>>                           struct pci_epf_header *header)
>>   {
>>          int ret;
>> -       unsigned long flags;
>>
>>          if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
>>                  return -EINVAL;
>> @@ -468,9 +452,9 @@ int pci_epc_write_header(struct pci_epc *epc, u8 
>> func_no,
>>          if (!epc->ops->write_header)
>>                  return 0;
>>
>> -       spin_lock_irqsave(&epc->lock, flags);
>> +       mutex_lock(&epc->lock);
>>          ret = epc->ops->write_header(epc, func_no, header);
>> -       spin_unlock_irqrestore(&epc->lock, flags);
>> +       mutex_unlock(&epc->lock);
>>
>>          return ret;
>>   }
>> @@ -487,8 +471,6 @@ EXPORT_SYMBOL_GPL(pci_epc_write_header);
>>    */
>>   int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf)
>>   {
>> -       unsigned long flags;
>> -
>>          if (epf->epc)
>>                  return -EBUSY;
>>
>> @@ -500,9 +482,9 @@ int pci_epc_add_epf(struct pci_epc *epc, struct 
>> pci_epf *epf)
>>
>>          epf->epc = epc;
>>
>> -       spin_lock_irqsave(&epc->lock, flags);
>> +       mutex_lock(&epc->lock);
>>          list_add_tail(&epf->list, &epc->pci_epf);
>> -       spin_unlock_irqrestore(&epc->lock, flags);
>> +       mutex_unlock(&epc->lock);
>>
>>          return 0;
>>   }
>> @@ -517,15 +499,13 @@ EXPORT_SYMBOL_GPL(pci_epc_add_epf);
>>    */
>>   void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf)
>>   {
>> -       unsigned long flags;
>> -
>>          if (!epc || IS_ERR(epc) || !epf)
>>                  return;
>>
>> -       spin_lock_irqsave(&epc->lock, flags);
>> +       mutex_lock(&epc->lock);
>>          list_del(&epf->list);
>>          epf->epc = NULL;
>> -       spin_unlock_irqrestore(&epc->lock, flags);
>> +       mutex_unlock(&epc->lock);
>>   }
>>   EXPORT_SYMBOL_GPL(pci_epc_remove_epf);
>>
>> @@ -604,7 +584,7 @@ __pci_epc_create(struct device *dev, const struct 
>> pci_epc_ops *ops,
>>                  goto err_ret;
>>          }
>>
>> -       spin_lock_init(&epc->lock);
>> +       mutex_init(&epc->lock);
>>          INIT_LIST_HEAD(&epc->pci_epf);
>>          ATOMIC_INIT_NOTIFIER_HEAD(&epc->notifier);
>>
>> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
>> index 36644ccd32ac..9dd60f2e9705 100644
>> --- a/include/linux/pci-epc.h
>> +++ b/include/linux/pci-epc.h
>> @@ -88,7 +88,7 @@ struct pci_epc_mem {
>>    * @mem: address space of the endpoint controller
>>    * @max_functions: max number of functions that can be configured in 
>> this EPC
>>    * @group: configfs group representing the PCI EPC device
>> - * @lock: spinlock to protect pci_epc ops
>> + * @lock: mutex to protect pci_epc ops
>>    * @notifier: used to notify EPF of any EPC events (like linkup)
>>    */
>>   struct pci_epc {
>> @@ -98,8 +98,8 @@ struct pci_epc {
>>          struct pci_epc_mem              *mem;
>>          u8                              max_functions;
>>          struct config_group             *group;
>> -       /* spinlock to protect against concurrent access of EP 
>> controller */
>> -       spinlock_t                      lock;
>> +       /* mutex to protect against concurrent access of EP controller */
>> +       struct mutex                    lock;
>>          struct atomic_notifier_head     notifier;
>>   };
>>
>> -- 
>> 2.17.1
>>
