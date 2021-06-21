Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C89F3AE626
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jun 2021 11:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbhFUJkg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Jun 2021 05:40:36 -0400
Received: from mail-bn7nam10on2055.outbound.protection.outlook.com ([40.107.92.55]:22657
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229576AbhFUJkg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Jun 2021 05:40:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CodKOo7OPSiWI5q6tc52zBF2WKuQDbkLqtxtZwFEVdykNAL+ccYEwr434adlI7cLDUQJOWVvdtsQgiHcnJCDwJrCRq7EJi6kvb/87O7UMwMpH0JHlVIjoPSllP1uvlIME0qYsMFu7Er9/8iKTlsKCc1WwGyqUmXEqpRMJiZSTNtHnuhhO70hoK1RdbhdPoabrYYmw2gm1qPgVYmkVlXKCkAu47gskiBpraSmi3ZYRT43ztmUt2YovjOUscGGRHILIU6Z6utS/uEeIPflCjRGos0RwxLEZ8Mn7LEvqOmdERCYFZtArP9T1FrIahU6ijrQRn4f9Fb13Lm6FrdEGrpU2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NcrKRz1sF560RQUydp7Cg7SpEGjXGznlEgIwEvf9kG0=;
 b=NgQVOHkRG4zh0FXZ/Ksnae2OAr+obqR4nHlk5UQNCke+a7THYD6BUtnmYdR9X3d1ekMD2rmiNzYIsedL9c3cUp5doEUX+7yOMJe3AolP+rVXsgFw0YV66Dkf5tK76qr7bEsxNE/pjRU8Qajg3YLKL+UfLg9FyJnFyyMKqbcFx1nqPUqDAKs5UuCfIPsXeremXoBDqbf4hkh8oqcq0SOMjCqJultedJ59g8Ut539iM/7WiT0+GJFY/A+YEDegoB11cyZrtqmMmoUQIBoDiWiiijlAQOFMmB5ys1e53u253j+HAQir2IoD/5YFWv3UsrGJS+BWN6YM/kpolP82E3OY4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NcrKRz1sF560RQUydp7Cg7SpEGjXGznlEgIwEvf9kG0=;
 b=BZhZcMbiGfPPnMC8ww94DytHYE6RjNE71Zn2ZYfACbkc2ElgRF2dVU0xp0VE+XomeIk5k+221g9qVs0RFp0NhHzEVzC8ER5m2QW9tC4eQ+W0+LrG3VGZssj/6+rrsdKmoeAe+huMsndrTnQoCnP9l8dC+ppcc62Uvc661fmGL2yWpG1i//m8nteYT4x0v4MkfkPKhJ+VUfoS/GntNDLjne7DKynLRpwL/3Alv8r4MXoO0dDLaEn7WXHfeoxJ0v1iqunn4KlCoA9qDOtUAqbDIIpofLVNQ9zTcRT71121q0TCc0KuDM2DpDv4aErBq9TtD3ECID2/LTtK2/jsWL6srQ==
Received: from DM5PR07CA0026.namprd07.prod.outlook.com (2603:10b6:3:16::12) by
 BYAPR12MB2758.namprd12.prod.outlook.com (2603:10b6:a03:6f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.22; Mon, 21 Jun 2021 09:38:20 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:16:cafe::b0) by DM5PR07CA0026.outlook.office365.com
 (2603:10b6:3:16::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend
 Transport; Mon, 21 Jun 2021 09:38:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4242.16 via Frontend Transport; Mon, 21 Jun 2021 09:38:20 +0000
Received: from [10.25.73.60] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 21 Jun
 2021 09:38:16 +0000
Subject: Re: [PATCH v2 2/5] PCI: endpoint: Replace spinlock with mutex
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
 <36aa4b00-0b3f-011a-4ade-1f79df983157@ti.com>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <c5e5a847-fd2f-6a52-1587-03ac4f1c7ec4@nvidia.com>
Date:   Mon, 21 Jun 2021 15:08:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <36aa4b00-0b3f-011a-4ade-1f79df983157@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa5e244e-d5d5-4003-ef84-08d934984e4a
X-MS-TrafficTypeDiagnostic: BYAPR12MB2758:
X-Microsoft-Antispam-PRVS: <BYAPR12MB275864558AAF48BEBB1150AEB80A9@BYAPR12MB2758.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H4EW8FKvWW+7QS8tLi0bUkLZKJi2MjJ/uXnsIveTZN0z6T8B4/+++IzDrFqZ3+7IY/LO4X8SyFoAc2ETQPl9ARXDbeVwCaqXPEzHqvnGzfJPiLJH61L3ofEouSPUiAz6gHXJ0IEzrz3KKQDZbU7Z7/Jv54dDlPkdohTjto429ZPNcWO6bm50GDzqHngsaf70b8vsSVFD/TnyQOpZNLlo2O/lQW/V3L4ddwTgapYkynOiaGK9rNDcPsHraRlkYQsTagiOTIHra1pE9iNE2MJSKhLMuh1kfiSdMsPdw9RRqwuFa0NrbfB9vQBDxIbS0Embdi5FqQehXuneUFSfuHsf1aoEXluTz9qskKwTt6/uumPOU3Ok+Bq02a81ORdpqpxk9u9FvM9KqIRbprHRMHLNVOFhnfmyUiY3anpO3w/ESbNVCEa6wzTLNViDlsKs84vqSzWKcpGOwR6IbJE6M3CvJOIIHHUSmLGvRdxQN0YCo5CiIdTfZy+M7fWs7vAP8RLOCZOR7Bkf9V8tsdLyfpdUKFWMjmIuPk6Ywu43JhmhCY2Ry5lbGSn0wcegKOSKqwpxq5qB9CHv0lfPb1g1KkFwp8fBEdfaDJlnuRypNVU+uyJODO2L/czwGMe2HPkW1VBQAB50+HTAA8nNRY2nd4W94IlMYK+4c+DtvSJd16lJIJl2XwFZPOvclBJSUy+NOthE
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(346002)(39860400002)(36840700001)(46966006)(107886003)(54906003)(82310400003)(36906005)(356005)(70586007)(6916009)(316002)(70206006)(31696002)(8936002)(16576012)(30864003)(36860700001)(7636003)(26005)(16526019)(2616005)(8676002)(186003)(86362001)(83380400001)(47076005)(53546011)(36756003)(478600001)(426003)(82740400003)(5660300002)(31686004)(4326008)(2906002)(336012)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 09:38:20.1353
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa5e244e-d5d5-4003-ef84-08d934984e4a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2758
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/21/2021 10:44 AM, Kishon Vijay Abraham I wrote:
> External email: Use caution opening links or attachments
> 
> 
> Hi Vidya Sagar,
> 
> On 11/06/21 3:22 pm, Vidya Sagar wrote:
>> Hi Kishon,
>> Apologies for bringup it up this late.
>> I'm wondering if there was any issue which this patch tried to address?
> 
> There was one function pci_epc_linkup() which was expected to be invoked
> in interrupt context (basically when the LINKUP interrupt is raised).
> But after it was moved to use atomic notifier, all the EPC core APIs
> were replaced to use mutex.
>> Actually, "The pci_epc_ops is not intended to be invoked from interrupt
>> context" isn't true in case of Tegra194. We do call
>> dw_pcie_ep_init_notify() API from threaded irq service routine and it
>> eventually calls mutext_lock() of pci_epc_get_features() which is
>> reusulting in the following warning log.
>> BUG: sleeping function called from invalid context at
>> kernel/locking/mutex.c:
>> Would like hear your comments on it.
After reviewing the logs and code again, I think it was my mistake to 
come to early conclusion that it was because of calling mutex_lock() in 
the atomic context. It is clear now.

I would like to understand the reason behind putting locks in the epc 
core driver before calling ops.
I believe the ops callers should implement lock if they are concurrently 
accessing the ops instead of adding a global lock in the epc core.
This would help in scenarios like the one below.

	We have a performance oriented endpoint function driver which calls 
map, unmap & raise_irq ops from softirq context and because of 
mutex_lock(), we can't do that now. epc core driver should not restrict 
the function drivers to use only non-atomic functions.

Thanks,
Vidya Sagar
> 
> I don't think it is ideal to initialize EPC in interrupt context (unless
> there is a specific reason for it). EPC initialization can be moved to
> bottom half similar to how commands are handled after LINKUP.

> 
> Thanks
> Kishon
> 
>>
>> Thanks,
>> Vidya Sagar
>>
>> On 2/12/2020 4:55 PM, Kishon Vijay Abraham I wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> The pci_epc_ops is not intended to be invoked from interrupt context.
>>> Hence replace spin_lock_irqsave and spin_unlock_irqrestore with
>>> mutex_lock and mutex_unlock respectively.
>>>
>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>> ---
>>>    drivers/pci/endpoint/pci-epc-core.c | 82 +++++++++++------------------
>>>    include/linux/pci-epc.h             |  6 +--
>>>    2 files changed, 34 insertions(+), 54 deletions(-)
>>>
>>> diff --git a/drivers/pci/endpoint/pci-epc-core.c
>>> b/drivers/pci/endpoint/pci-epc-core.c
>>> index 2f6436599fcb..e51a12ed85bb 100644
>>> --- a/drivers/pci/endpoint/pci-epc-core.c
>>> +++ b/drivers/pci/endpoint/pci-epc-core.c
>>> @@ -120,7 +120,6 @@ const struct pci_epc_features
>>> *pci_epc_get_features(struct pci_epc *epc,
>>>                                                       u8 func_no)
>>>    {
>>>           const struct pci_epc_features *epc_features;
>>> -       unsigned long flags;
>>>
>>>           if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
>>>                   return NULL;
>>> @@ -128,9 +127,9 @@ const struct pci_epc_features
>>> *pci_epc_get_features(struct pci_epc *epc,
>>>           if (!epc->ops->get_features)
>>>                   return NULL;
>>>
>>> -       spin_lock_irqsave(&epc->lock, flags);
>>> +       mutex_lock(&epc->lock);
>>>           epc_features = epc->ops->get_features(epc, func_no);
>>> -       spin_unlock_irqrestore(&epc->lock, flags);
>>> +       mutex_unlock(&epc->lock);
>>>
>>>           return epc_features;
>>>    }
>>> @@ -144,14 +143,12 @@ EXPORT_SYMBOL_GPL(pci_epc_get_features);
>>>     */
>>>    void pci_epc_stop(struct pci_epc *epc)
>>>    {
>>> -       unsigned long flags;
>>> -
>>>           if (IS_ERR(epc) || !epc->ops->stop)
>>>                   return;
>>>
>>> -       spin_lock_irqsave(&epc->lock, flags);
>>> +       mutex_lock(&epc->lock);
>>>           epc->ops->stop(epc);
>>> -       spin_unlock_irqrestore(&epc->lock, flags);
>>> +       mutex_unlock(&epc->lock);
>>>    }
>>>    EXPORT_SYMBOL_GPL(pci_epc_stop);
>>>
>>> @@ -164,7 +161,6 @@ EXPORT_SYMBOL_GPL(pci_epc_stop);
>>>    int pci_epc_start(struct pci_epc *epc)
>>>    {
>>>           int ret;
>>> -       unsigned long flags;
>>>
>>>           if (IS_ERR(epc))
>>>                   return -EINVAL;
>>> @@ -172,9 +168,9 @@ int pci_epc_start(struct pci_epc *epc)
>>>           if (!epc->ops->start)
>>>                   return 0;
>>>
>>> -       spin_lock_irqsave(&epc->lock, flags);
>>> +       mutex_lock(&epc->lock);
>>>           ret = epc->ops->start(epc);
>>> -       spin_unlock_irqrestore(&epc->lock, flags);
>>> +       mutex_unlock(&epc->lock);
>>>
>>>           return ret;
>>>    }
>>> @@ -193,7 +189,6 @@ int pci_epc_raise_irq(struct pci_epc *epc, u8
>>> func_no,
>>>                         enum pci_epc_irq_type type, u16 interrupt_num)
>>>    {
>>>           int ret;
>>> -       unsigned long flags;
>>>
>>>           if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
>>>                   return -EINVAL;
>>> @@ -201,9 +196,9 @@ int pci_epc_raise_irq(struct pci_epc *epc, u8
>>> func_no,
>>>           if (!epc->ops->raise_irq)
>>>                   return 0;
>>>
>>> -       spin_lock_irqsave(&epc->lock, flags);
>>> +       mutex_lock(&epc->lock);
>>>           ret = epc->ops->raise_irq(epc, func_no, type, interrupt_num);
>>> -       spin_unlock_irqrestore(&epc->lock, flags);
>>> +       mutex_unlock(&epc->lock);
>>>
>>>           return ret;
>>>    }
>>> @@ -219,7 +214,6 @@ EXPORT_SYMBOL_GPL(pci_epc_raise_irq);
>>>    int pci_epc_get_msi(struct pci_epc *epc, u8 func_no)
>>>    {
>>>           int interrupt;
>>> -       unsigned long flags;
>>>
>>>           if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
>>>                   return 0;
>>> @@ -227,9 +221,9 @@ int pci_epc_get_msi(struct pci_epc *epc, u8 func_no)
>>>           if (!epc->ops->get_msi)
>>>                   return 0;
>>>
>>> -       spin_lock_irqsave(&epc->lock, flags);
>>> +       mutex_lock(&epc->lock);
>>>           interrupt = epc->ops->get_msi(epc, func_no);
>>> -       spin_unlock_irqrestore(&epc->lock, flags);
>>> +       mutex_unlock(&epc->lock);
>>>
>>>           if (interrupt < 0)
>>>                   return 0;
>>> @@ -252,7 +246,6 @@ int pci_epc_set_msi(struct pci_epc *epc, u8
>>> func_no, u8 interrupts)
>>>    {
>>>           int ret;
>>>           u8 encode_int;
>>> -       unsigned long flags;
>>>
>>>           if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions ||
>>>               interrupts > 32)
>>> @@ -263,9 +256,9 @@ int pci_epc_set_msi(struct pci_epc *epc, u8
>>> func_no, u8 interrupts)
>>>
>>>           encode_int = order_base_2(interrupts);
>>>
>>> -       spin_lock_irqsave(&epc->lock, flags);
>>> +       mutex_lock(&epc->lock);
>>>           ret = epc->ops->set_msi(epc, func_no, encode_int);
>>> -       spin_unlock_irqrestore(&epc->lock, flags);
>>> +       mutex_unlock(&epc->lock);
>>>
>>>           return ret;
>>>    }
>>> @@ -281,7 +274,6 @@ EXPORT_SYMBOL_GPL(pci_epc_set_msi);
>>>    int pci_epc_get_msix(struct pci_epc *epc, u8 func_no)
>>>    {
>>>           int interrupt;
>>> -       unsigned long flags;
>>>
>>>           if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
>>>                   return 0;
>>> @@ -289,9 +281,9 @@ int pci_epc_get_msix(struct pci_epc *epc, u8 func_no)
>>>           if (!epc->ops->get_msix)
>>>                   return 0;
>>>
>>> -       spin_lock_irqsave(&epc->lock, flags);
>>> +       mutex_lock(&epc->lock);
>>>           interrupt = epc->ops->get_msix(epc, func_no);
>>> -       spin_unlock_irqrestore(&epc->lock, flags);
>>> +       mutex_unlock(&epc->lock);
>>>
>>>           if (interrupt < 0)
>>>                   return 0;
>>> @@ -311,7 +303,6 @@ EXPORT_SYMBOL_GPL(pci_epc_get_msix);
>>>    int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u16 interrupts)
>>>    {
>>>           int ret;
>>> -       unsigned long flags;
>>>
>>>           if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions ||
>>>               interrupts < 1 || interrupts > 2048)
>>> @@ -320,9 +311,9 @@ int pci_epc_set_msix(struct pci_epc *epc, u8
>>> func_no, u16 interrupts)
>>>           if (!epc->ops->set_msix)
>>>                   return 0;
>>>
>>> -       spin_lock_irqsave(&epc->lock, flags);
>>> +       mutex_lock(&epc->lock);
>>>           ret = epc->ops->set_msix(epc, func_no, interrupts - 1);
>>> -       spin_unlock_irqrestore(&epc->lock, flags);
>>> +       mutex_unlock(&epc->lock);
>>>
>>>           return ret;
>>>    }
>>> @@ -339,17 +330,15 @@ EXPORT_SYMBOL_GPL(pci_epc_set_msix);
>>>    void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no,
>>>                           phys_addr_t phys_addr)
>>>    {
>>> -       unsigned long flags;
>>> -
>>>           if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
>>>                   return;
>>>
>>>           if (!epc->ops->unmap_addr)
>>>                   return;
>>>
>>> -       spin_lock_irqsave(&epc->lock, flags);
>>> +       mutex_lock(&epc->lock);
>>>           epc->ops->unmap_addr(epc, func_no, phys_addr);
>>> -       spin_unlock_irqrestore(&epc->lock, flags);
>>> +       mutex_unlock(&epc->lock);
>>>    }
>>>    EXPORT_SYMBOL_GPL(pci_epc_unmap_addr);
>>>
>>> @@ -367,7 +356,6 @@ int pci_epc_map_addr(struct pci_epc *epc, u8 func_no,
>>>                        phys_addr_t phys_addr, u64 pci_addr, size_t size)
>>>    {
>>>           int ret;
>>> -       unsigned long flags;
>>>
>>>           if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
>>>                   return -EINVAL;
>>> @@ -375,9 +363,9 @@ int pci_epc_map_addr(struct pci_epc *epc, u8 func_no,
>>>           if (!epc->ops->map_addr)
>>>                   return 0;
>>>
>>> -       spin_lock_irqsave(&epc->lock, flags);
>>> +       mutex_lock(&epc->lock);
>>>           ret = epc->ops->map_addr(epc, func_no, phys_addr, pci_addr,
>>> size);
>>> -       spin_unlock_irqrestore(&epc->lock, flags);
>>> +       mutex_unlock(&epc->lock);
>>>
>>>           return ret;
>>>    }
>>> @@ -394,8 +382,6 @@ EXPORT_SYMBOL_GPL(pci_epc_map_addr);
>>>    void pci_epc_clear_bar(struct pci_epc *epc, u8 func_no,
>>>                          struct pci_epf_bar *epf_bar)
>>>    {
>>> -       unsigned long flags;
>>> -
>>>           if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions ||
>>>               (epf_bar->barno == BAR_5 &&
>>>                epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64))
>>> @@ -404,9 +390,9 @@ void pci_epc_clear_bar(struct pci_epc *epc, u8
>>> func_no,
>>>           if (!epc->ops->clear_bar)
>>>                   return;
>>>
>>> -       spin_lock_irqsave(&epc->lock, flags);
>>> +       mutex_lock(&epc->lock);
>>>           epc->ops->clear_bar(epc, func_no, epf_bar);
>>> -       spin_unlock_irqrestore(&epc->lock, flags);
>>> +       mutex_unlock(&epc->lock);
>>>    }
>>>    EXPORT_SYMBOL_GPL(pci_epc_clear_bar);
>>>
>>> @@ -422,7 +408,6 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_no,
>>>                       struct pci_epf_bar *epf_bar)
>>>    {
>>>           int ret;
>>> -       unsigned long irq_flags;
>>>           int flags = epf_bar->flags;
>>>
>>>           if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions ||
>>> @@ -437,9 +422,9 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_no,
>>>           if (!epc->ops->set_bar)
>>>                   return 0;
>>>
>>> -       spin_lock_irqsave(&epc->lock, irq_flags);
>>> +       mutex_lock(&epc->lock);
>>>           ret = epc->ops->set_bar(epc, func_no, epf_bar);
>>> -       spin_unlock_irqrestore(&epc->lock, irq_flags);
>>> +       mutex_unlock(&epc->lock);
>>>
>>>           return ret;
>>>    }
>>> @@ -460,7 +445,6 @@ int pci_epc_write_header(struct pci_epc *epc, u8
>>> func_no,
>>>                            struct pci_epf_header *header)
>>>    {
>>>           int ret;
>>> -       unsigned long flags;
>>>
>>>           if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
>>>                   return -EINVAL;
>>> @@ -468,9 +452,9 @@ int pci_epc_write_header(struct pci_epc *epc, u8
>>> func_no,
>>>           if (!epc->ops->write_header)
>>>                   return 0;
>>>
>>> -       spin_lock_irqsave(&epc->lock, flags);
>>> +       mutex_lock(&epc->lock);
>>>           ret = epc->ops->write_header(epc, func_no, header);
>>> -       spin_unlock_irqrestore(&epc->lock, flags);
>>> +       mutex_unlock(&epc->lock);
>>>
>>>           return ret;
>>>    }
>>> @@ -487,8 +471,6 @@ EXPORT_SYMBOL_GPL(pci_epc_write_header);
>>>     */
>>>    int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf)
>>>    {
>>> -       unsigned long flags;
>>> -
>>>           if (epf->epc)
>>>                   return -EBUSY;
>>>
>>> @@ -500,9 +482,9 @@ int pci_epc_add_epf(struct pci_epc *epc, struct
>>> pci_epf *epf)
>>>
>>>           epf->epc = epc;
>>>
>>> -       spin_lock_irqsave(&epc->lock, flags);
>>> +       mutex_lock(&epc->lock);
>>>           list_add_tail(&epf->list, &epc->pci_epf);
>>> -       spin_unlock_irqrestore(&epc->lock, flags);
>>> +       mutex_unlock(&epc->lock);
>>>
>>>           return 0;
>>>    }
>>> @@ -517,15 +499,13 @@ EXPORT_SYMBOL_GPL(pci_epc_add_epf);
>>>     */
>>>    void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf)
>>>    {
>>> -       unsigned long flags;
>>> -
>>>           if (!epc || IS_ERR(epc) || !epf)
>>>                   return;
>>>
>>> -       spin_lock_irqsave(&epc->lock, flags);
>>> +       mutex_lock(&epc->lock);
>>>           list_del(&epf->list);
>>>           epf->epc = NULL;
>>> -       spin_unlock_irqrestore(&epc->lock, flags);
>>> +       mutex_unlock(&epc->lock);
>>>    }
>>>    EXPORT_SYMBOL_GPL(pci_epc_remove_epf);
>>>
>>> @@ -604,7 +584,7 @@ __pci_epc_create(struct device *dev, const struct
>>> pci_epc_ops *ops,
>>>                   goto err_ret;
>>>           }
>>>
>>> -       spin_lock_init(&epc->lock);
>>> +       mutex_init(&epc->lock);
>>>           INIT_LIST_HEAD(&epc->pci_epf);
>>>           ATOMIC_INIT_NOTIFIER_HEAD(&epc->notifier);
>>>
>>> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
>>> index 36644ccd32ac..9dd60f2e9705 100644
>>> --- a/include/linux/pci-epc.h
>>> +++ b/include/linux/pci-epc.h
>>> @@ -88,7 +88,7 @@ struct pci_epc_mem {
>>>     * @mem: address space of the endpoint controller
>>>     * @max_functions: max number of functions that can be configured in
>>> this EPC
>>>     * @group: configfs group representing the PCI EPC device
>>> - * @lock: spinlock to protect pci_epc ops
>>> + * @lock: mutex to protect pci_epc ops
>>>     * @notifier: used to notify EPF of any EPC events (like linkup)
>>>     */
>>>    struct pci_epc {
>>> @@ -98,8 +98,8 @@ struct pci_epc {
>>>           struct pci_epc_mem              *mem;
>>>           u8                              max_functions;
>>>           struct config_group             *group;
>>> -       /* spinlock to protect against concurrent access of EP
>>> controller */
>>> -       spinlock_t                      lock;
>>> +       /* mutex to protect against concurrent access of EP controller */
>>> +       struct mutex                    lock;
>>>           struct atomic_notifier_head     notifier;
>>>    };
>>>
>>> --
>>> 2.17.1
>>>
