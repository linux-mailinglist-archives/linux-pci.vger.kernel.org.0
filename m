Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55CC13A3F85
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jun 2021 11:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhFKJyh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Jun 2021 05:54:37 -0400
Received: from mail-bn7nam10on2058.outbound.protection.outlook.com ([40.107.92.58]:17120
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229480AbhFKJyg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Jun 2021 05:54:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfniHMb5jeZ4NiCLMlDBK4NB98SjTWUJ3z68bO2JnlvSZvAKf1Vwqs15OzvMgSDtCWPgCl48yPYPvxxYkRtPhaVXbIjZQQNq4uNOuAjV4JmvZoSbzSFYGyD603aRKWGrPbW2tsosImETCOqlbYUswJeD0Jk0PvKH0PNfaeX0DFAtLIR9W77PqsE7D2lXLb7uoxo9+QOXBp72mG4C2ULabdArGbUeWG3x7hVTZc8lRYKY+VTd2vqOequNImPTS88HBBftPVHkX+rn25JA9tFiw1IlZo48S6gv6ixZPZivZa0+qihXiGHRKWIqie25R6JOdxQzJQE7xhaa9Pl8/tCW4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzbKC+yTTcrFLGWou28XnV4aFqdPPbFWmsTUuX+9tiM=;
 b=SnBzOCGfqwSK6KC+flZBl91580zVCyxqYUXbnUJTCCsYkP4bz5GlC3DPJvgI89bn3JyqPJ2BU0tGQyDlFrl4vXYgqoHdvezRTmYjQJSUyQeyS20laZEAlGYwfAbxf7QDx6TpyRPlZTcO2MQyvAOuNnA0Kmu/tzyAqdACP4Dz136wvBc121NoLLysf78ZpGEB+VbSdVO2IQYLSnaDDzBh3fvop/xVnxG2p6BvEZ/rcSP2jWMeKZv2EiL83xuf4Tfy2+zFVMzWj1P3wnyYZiAyKO7UZHY+O/qxFrH+fmHgI2wibQ/qK2pXJyrMOl3XggWYX5VRAlXyVQTjWLMGGyJxfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzbKC+yTTcrFLGWou28XnV4aFqdPPbFWmsTUuX+9tiM=;
 b=HaZnVM+WUrAtpmKVqbw31iH0RSV4pTILwcypVRlP1lugSm9/IxNLeRJKJNmZ0FcPc/O4xcxzLCSNXYWS6c02pdA8EzTqYvi3pSf7whztI3uT6vT2LxtRPaV6POIeZGn3kSY83OmFKWgqAWPS2a7ES8KaBOA5a4vkQrJciwX3k0ahlV7w5zk6/HhWr+Pd00RXhpXraoRuOitjMu4rrF5AOiuIBDYrILZXjj0ltteLdPIK3GBi1VF8+yYVoabjhy3LVX68FaDk413PjA5t4wm50TE1AwKkZ0QVWPpjYOqzDK5YAYBMqpeQ38gqL7UDtcKd1bpag/A8TcZ16kD/9sCiBw==
Received: from DS7PR05CA0015.namprd05.prod.outlook.com (2603:10b6:5:3b9::20)
 by CY4PR1201MB0184.namprd12.prod.outlook.com (2603:10b6:910:1d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.29; Fri, 11 Jun
 2021 09:52:37 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::4a) by DS7PR05CA0015.outlook.office365.com
 (2603:10b6:5:3b9::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.9 via Frontend
 Transport; Fri, 11 Jun 2021 09:52:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4219.21 via Frontend Transport; Fri, 11 Jun 2021 09:52:37 +0000
Received: from [10.25.75.2] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 11 Jun
 2021 09:52:34 +0000
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
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <901293cd-e67a-04a4-d61e-37a105c33d15@nvidia.com>
Date:   Fri, 11 Jun 2021 15:22:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20200212112514.2000-3-kishon@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6df04ad8-197a-42e2-e245-08d92cbea4fd
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0184:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB018496D18D73360C9DACFB6DB8349@CY4PR1201MB0184.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LSKv4cnCtY/BSYRpIAdAIEVxqLpKiJs+LjVIWCLdULckxMJwP80A2k10ZDzZlnPIW12ijD72rs9CFurbGPbyBP7BEjwEFxjKOetTv6DLPQtrQM81lFVeo35NltsTIExKrs/Mf2TRS8g71J5DhbvIa8hXA0rFSnJxkMQhOOfOjBVqSV/UgkCJvTh1QyzDji6ieGzJhqrNk6K04ItfZjQInY/mYQUg5e3q56v1RXbFY6D5AFhjr+9B4mY3THS4rQFbJSBDnhY9NK//ReS54e9SMZDIFlvgAdOh0Kv0OWZr3SYdIzaUa818RKVl+XeQeIpqobIgygK9vgRcQU3T8w8dSsMmbTT4MGFjYZXNUAvjvq9v4IlBJOg9zd2HSGhEXQQpnYfNimPLvuk53UkpGuwZX24XaOGghzHVm/uawLAhtVof4Dhq633CuaBZ0OLiEuIbY2qLeHJ7ZDYIEKFnuYSRQgsygtFRx0nTCnS2owRjm3ihWVUGf1eCFuDqgj+VXftc0720zpQlK1Qlsj6NYHBXXdqzvcasTnR4padPLLO2BQ0squaXBxbfjdR8PONj9N5b5U5IfMf2YBpQ5Xo4f99vmk9GwJ5I9GjJHvG6NkKXIfDEqfO+LV1EXeD/eBfqyDdZyqTj3w+wDnbjZ1jGTPEuWy2778AyqqfCXOHIqcDvrHb4lzANPxsrtoQ23jH0+R8q
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(376002)(136003)(46966006)(36840700001)(7636003)(2616005)(336012)(53546011)(426003)(26005)(5660300002)(107886003)(186003)(31686004)(6666004)(6916009)(82740400003)(2906002)(36860700001)(82310400003)(70206006)(36756003)(31696002)(70586007)(356005)(47076005)(54906003)(83380400001)(16526019)(86362001)(16576012)(8936002)(478600001)(4326008)(316002)(30864003)(8676002)(36906005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 09:52:37.1677
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df04ad8-197a-42e2-e245-08d92cbea4fd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0184
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kishon,
Apologies for bringup it up this late.
I'm wondering if there was any issue which this patch tried to address?
Actually, "The pci_epc_ops is not intended to be invoked from interrupt 
context" isn't true in case of Tegra194. We do call 
dw_pcie_ep_init_notify() API from threaded irq service routine and it 
eventually calls mutext_lock() of pci_epc_get_features() which is 
reusulting in the following warning log.
BUG: sleeping function called from invalid context at 
kernel/locking/mutex.c:
Would like hear your comments on it.

Thanks,
Vidya Sagar

On 2/12/2020 4:55 PM, Kishon Vijay Abraham I wrote:
> External email: Use caution opening links or attachments
> 
> 
> The pci_epc_ops is not intended to be invoked from interrupt context.
> Hence replace spin_lock_irqsave and spin_unlock_irqrestore with
> mutex_lock and mutex_unlock respectively.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>   drivers/pci/endpoint/pci-epc-core.c | 82 +++++++++++------------------
>   include/linux/pci-epc.h             |  6 +--
>   2 files changed, 34 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 2f6436599fcb..e51a12ed85bb 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -120,7 +120,6 @@ const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
>                                                      u8 func_no)
>   {
>          const struct pci_epc_features *epc_features;
> -       unsigned long flags;
> 
>          if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
>                  return NULL;
> @@ -128,9 +127,9 @@ const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
>          if (!epc->ops->get_features)
>                  return NULL;
> 
> -       spin_lock_irqsave(&epc->lock, flags);
> +       mutex_lock(&epc->lock);
>          epc_features = epc->ops->get_features(epc, func_no);
> -       spin_unlock_irqrestore(&epc->lock, flags);
> +       mutex_unlock(&epc->lock);
> 
>          return epc_features;
>   }
> @@ -144,14 +143,12 @@ EXPORT_SYMBOL_GPL(pci_epc_get_features);
>    */
>   void pci_epc_stop(struct pci_epc *epc)
>   {
> -       unsigned long flags;
> -
>          if (IS_ERR(epc) || !epc->ops->stop)
>                  return;
> 
> -       spin_lock_irqsave(&epc->lock, flags);
> +       mutex_lock(&epc->lock);
>          epc->ops->stop(epc);
> -       spin_unlock_irqrestore(&epc->lock, flags);
> +       mutex_unlock(&epc->lock);
>   }
>   EXPORT_SYMBOL_GPL(pci_epc_stop);
> 
> @@ -164,7 +161,6 @@ EXPORT_SYMBOL_GPL(pci_epc_stop);
>   int pci_epc_start(struct pci_epc *epc)
>   {
>          int ret;
> -       unsigned long flags;
> 
>          if (IS_ERR(epc))
>                  return -EINVAL;
> @@ -172,9 +168,9 @@ int pci_epc_start(struct pci_epc *epc)
>          if (!epc->ops->start)
>                  return 0;
> 
> -       spin_lock_irqsave(&epc->lock, flags);
> +       mutex_lock(&epc->lock);
>          ret = epc->ops->start(epc);
> -       spin_unlock_irqrestore(&epc->lock, flags);
> +       mutex_unlock(&epc->lock);
> 
>          return ret;
>   }
> @@ -193,7 +189,6 @@ int pci_epc_raise_irq(struct pci_epc *epc, u8 func_no,
>                        enum pci_epc_irq_type type, u16 interrupt_num)
>   {
>          int ret;
> -       unsigned long flags;
> 
>          if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
>                  return -EINVAL;
> @@ -201,9 +196,9 @@ int pci_epc_raise_irq(struct pci_epc *epc, u8 func_no,
>          if (!epc->ops->raise_irq)
>                  return 0;
> 
> -       spin_lock_irqsave(&epc->lock, flags);
> +       mutex_lock(&epc->lock);
>          ret = epc->ops->raise_irq(epc, func_no, type, interrupt_num);
> -       spin_unlock_irqrestore(&epc->lock, flags);
> +       mutex_unlock(&epc->lock);
> 
>          return ret;
>   }
> @@ -219,7 +214,6 @@ EXPORT_SYMBOL_GPL(pci_epc_raise_irq);
>   int pci_epc_get_msi(struct pci_epc *epc, u8 func_no)
>   {
>          int interrupt;
> -       unsigned long flags;
> 
>          if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
>                  return 0;
> @@ -227,9 +221,9 @@ int pci_epc_get_msi(struct pci_epc *epc, u8 func_no)
>          if (!epc->ops->get_msi)
>                  return 0;
> 
> -       spin_lock_irqsave(&epc->lock, flags);
> +       mutex_lock(&epc->lock);
>          interrupt = epc->ops->get_msi(epc, func_no);
> -       spin_unlock_irqrestore(&epc->lock, flags);
> +       mutex_unlock(&epc->lock);
> 
>          if (interrupt < 0)
>                  return 0;
> @@ -252,7 +246,6 @@ int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 interrupts)
>   {
>          int ret;
>          u8 encode_int;
> -       unsigned long flags;
> 
>          if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions ||
>              interrupts > 32)
> @@ -263,9 +256,9 @@ int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 interrupts)
> 
>          encode_int = order_base_2(interrupts);
> 
> -       spin_lock_irqsave(&epc->lock, flags);
> +       mutex_lock(&epc->lock);
>          ret = epc->ops->set_msi(epc, func_no, encode_int);
> -       spin_unlock_irqrestore(&epc->lock, flags);
> +       mutex_unlock(&epc->lock);
> 
>          return ret;
>   }
> @@ -281,7 +274,6 @@ EXPORT_SYMBOL_GPL(pci_epc_set_msi);
>   int pci_epc_get_msix(struct pci_epc *epc, u8 func_no)
>   {
>          int interrupt;
> -       unsigned long flags;
> 
>          if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
>                  return 0;
> @@ -289,9 +281,9 @@ int pci_epc_get_msix(struct pci_epc *epc, u8 func_no)
>          if (!epc->ops->get_msix)
>                  return 0;
> 
> -       spin_lock_irqsave(&epc->lock, flags);
> +       mutex_lock(&epc->lock);
>          interrupt = epc->ops->get_msix(epc, func_no);
> -       spin_unlock_irqrestore(&epc->lock, flags);
> +       mutex_unlock(&epc->lock);
> 
>          if (interrupt < 0)
>                  return 0;
> @@ -311,7 +303,6 @@ EXPORT_SYMBOL_GPL(pci_epc_get_msix);
>   int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u16 interrupts)
>   {
>          int ret;
> -       unsigned long flags;
> 
>          if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions ||
>              interrupts < 1 || interrupts > 2048)
> @@ -320,9 +311,9 @@ int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u16 interrupts)
>          if (!epc->ops->set_msix)
>                  return 0;
> 
> -       spin_lock_irqsave(&epc->lock, flags);
> +       mutex_lock(&epc->lock);
>          ret = epc->ops->set_msix(epc, func_no, interrupts - 1);
> -       spin_unlock_irqrestore(&epc->lock, flags);
> +       mutex_unlock(&epc->lock);
> 
>          return ret;
>   }
> @@ -339,17 +330,15 @@ EXPORT_SYMBOL_GPL(pci_epc_set_msix);
>   void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no,
>                          phys_addr_t phys_addr)
>   {
> -       unsigned long flags;
> -
>          if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
>                  return;
> 
>          if (!epc->ops->unmap_addr)
>                  return;
> 
> -       spin_lock_irqsave(&epc->lock, flags);
> +       mutex_lock(&epc->lock);
>          epc->ops->unmap_addr(epc, func_no, phys_addr);
> -       spin_unlock_irqrestore(&epc->lock, flags);
> +       mutex_unlock(&epc->lock);
>   }
>   EXPORT_SYMBOL_GPL(pci_epc_unmap_addr);
> 
> @@ -367,7 +356,6 @@ int pci_epc_map_addr(struct pci_epc *epc, u8 func_no,
>                       phys_addr_t phys_addr, u64 pci_addr, size_t size)
>   {
>          int ret;
> -       unsigned long flags;
> 
>          if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
>                  return -EINVAL;
> @@ -375,9 +363,9 @@ int pci_epc_map_addr(struct pci_epc *epc, u8 func_no,
>          if (!epc->ops->map_addr)
>                  return 0;
> 
> -       spin_lock_irqsave(&epc->lock, flags);
> +       mutex_lock(&epc->lock);
>          ret = epc->ops->map_addr(epc, func_no, phys_addr, pci_addr, size);
> -       spin_unlock_irqrestore(&epc->lock, flags);
> +       mutex_unlock(&epc->lock);
> 
>          return ret;
>   }
> @@ -394,8 +382,6 @@ EXPORT_SYMBOL_GPL(pci_epc_map_addr);
>   void pci_epc_clear_bar(struct pci_epc *epc, u8 func_no,
>                         struct pci_epf_bar *epf_bar)
>   {
> -       unsigned long flags;
> -
>          if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions ||
>              (epf_bar->barno == BAR_5 &&
>               epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64))
> @@ -404,9 +390,9 @@ void pci_epc_clear_bar(struct pci_epc *epc, u8 func_no,
>          if (!epc->ops->clear_bar)
>                  return;
> 
> -       spin_lock_irqsave(&epc->lock, flags);
> +       mutex_lock(&epc->lock);
>          epc->ops->clear_bar(epc, func_no, epf_bar);
> -       spin_unlock_irqrestore(&epc->lock, flags);
> +       mutex_unlock(&epc->lock);
>   }
>   EXPORT_SYMBOL_GPL(pci_epc_clear_bar);
> 
> @@ -422,7 +408,6 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_no,
>                      struct pci_epf_bar *epf_bar)
>   {
>          int ret;
> -       unsigned long irq_flags;
>          int flags = epf_bar->flags;
> 
>          if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions ||
> @@ -437,9 +422,9 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_no,
>          if (!epc->ops->set_bar)
>                  return 0;
> 
> -       spin_lock_irqsave(&epc->lock, irq_flags);
> +       mutex_lock(&epc->lock);
>          ret = epc->ops->set_bar(epc, func_no, epf_bar);
> -       spin_unlock_irqrestore(&epc->lock, irq_flags);
> +       mutex_unlock(&epc->lock);
> 
>          return ret;
>   }
> @@ -460,7 +445,6 @@ int pci_epc_write_header(struct pci_epc *epc, u8 func_no,
>                           struct pci_epf_header *header)
>   {
>          int ret;
> -       unsigned long flags;
> 
>          if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
>                  return -EINVAL;
> @@ -468,9 +452,9 @@ int pci_epc_write_header(struct pci_epc *epc, u8 func_no,
>          if (!epc->ops->write_header)
>                  return 0;
> 
> -       spin_lock_irqsave(&epc->lock, flags);
> +       mutex_lock(&epc->lock);
>          ret = epc->ops->write_header(epc, func_no, header);
> -       spin_unlock_irqrestore(&epc->lock, flags);
> +       mutex_unlock(&epc->lock);
> 
>          return ret;
>   }
> @@ -487,8 +471,6 @@ EXPORT_SYMBOL_GPL(pci_epc_write_header);
>    */
>   int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf)
>   {
> -       unsigned long flags;
> -
>          if (epf->epc)
>                  return -EBUSY;
> 
> @@ -500,9 +482,9 @@ int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf)
> 
>          epf->epc = epc;
> 
> -       spin_lock_irqsave(&epc->lock, flags);
> +       mutex_lock(&epc->lock);
>          list_add_tail(&epf->list, &epc->pci_epf);
> -       spin_unlock_irqrestore(&epc->lock, flags);
> +       mutex_unlock(&epc->lock);
> 
>          return 0;
>   }
> @@ -517,15 +499,13 @@ EXPORT_SYMBOL_GPL(pci_epc_add_epf);
>    */
>   void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf)
>   {
> -       unsigned long flags;
> -
>          if (!epc || IS_ERR(epc) || !epf)
>                  return;
> 
> -       spin_lock_irqsave(&epc->lock, flags);
> +       mutex_lock(&epc->lock);
>          list_del(&epf->list);
>          epf->epc = NULL;
> -       spin_unlock_irqrestore(&epc->lock, flags);
> +       mutex_unlock(&epc->lock);
>   }
>   EXPORT_SYMBOL_GPL(pci_epc_remove_epf);
> 
> @@ -604,7 +584,7 @@ __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
>                  goto err_ret;
>          }
> 
> -       spin_lock_init(&epc->lock);
> +       mutex_init(&epc->lock);
>          INIT_LIST_HEAD(&epc->pci_epf);
>          ATOMIC_INIT_NOTIFIER_HEAD(&epc->notifier);
> 
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index 36644ccd32ac..9dd60f2e9705 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -88,7 +88,7 @@ struct pci_epc_mem {
>    * @mem: address space of the endpoint controller
>    * @max_functions: max number of functions that can be configured in this EPC
>    * @group: configfs group representing the PCI EPC device
> - * @lock: spinlock to protect pci_epc ops
> + * @lock: mutex to protect pci_epc ops
>    * @notifier: used to notify EPF of any EPC events (like linkup)
>    */
>   struct pci_epc {
> @@ -98,8 +98,8 @@ struct pci_epc {
>          struct pci_epc_mem              *mem;
>          u8                              max_functions;
>          struct config_group             *group;
> -       /* spinlock to protect against concurrent access of EP controller */
> -       spinlock_t                      lock;
> +       /* mutex to protect against concurrent access of EP controller */
> +       struct mutex                    lock;
>          struct atomic_notifier_head     notifier;
>   };
> 
> --
> 2.17.1
> 
