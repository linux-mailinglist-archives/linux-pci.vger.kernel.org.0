Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B03482F0B
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jan 2022 09:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbiACIjo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Jan 2022 03:39:44 -0500
Received: from mail-bn7nam10on2075.outbound.protection.outlook.com ([40.107.92.75]:32705
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232169AbiACIjo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 Jan 2022 03:39:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KVoPudfBPllohYnP22Skj+RiZOOALa2tGeI4pVAi+8gE6Ov6FtV/OdePi72JdQwLLWpFoXCYG9Kg2hYkq9XQ7iAjOJGoFOsjgZHx+rpxRY8ujKw76d8z4kgPhVMvDSANU2N0EurKajGje8sqCTfn4JCjuqZ8o1IjXBA9RUrlWHDk2Ieb36VI3Sl7HyEXo6GG6NQhncLruzt+HRevmXBjikKS6rGXpv/zbdtvpxZZN+qyE5Kn+lpLvYB2YjbFHS+11HFiV2Mkau5v/RrtjxAI1F+31WWm3obflmz2uLIbNLE9Y61Ehqc13oRLudcbZyzzJ7G6Hszvq8V0VCPb3sttlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=opdxY9Cxq3yye6ZpH+gO3Wi67aCGrq+UHgpJkyS/mr4=;
 b=HD/DODeawUFAm+x8EyxT38CTLMNbgyRY11Fd/uhWG6qx6DwdGvtj9nHMvIxTV6j/dp5Yi8zUfKrQJpT25y1Hl5Tq0mOMCUylcg/hINE5pSNVLGz45VPt/WBxcw0nCGxxqt+zyj2xXeHldD+ycvgHUVV6S42Rhm2b8Sx6nbb7P+9UKfMw67nP3kQBjdujnZQj5F8pQfmveOaPYWtX8e5Z+LfQ5/IE5WaRRDs5+tjHyxeKRmslrCS4ZB+an8bjnGBqFcjCPOlR25HSFNUBIaSwxE/Ue7VAAkdziPYIQuixSo8lhk2ohRbB9GJKhMjoJaO3S0iQW6KEvF1/x6beTyJnIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opdxY9Cxq3yye6ZpH+gO3Wi67aCGrq+UHgpJkyS/mr4=;
 b=i6bETh+kL2mUFMa5opne/kecMgTmK+Nu4+dVyZ6u0xuQOHkZY3ilgYLkyNLlWmcJfpWbrDctPj0r+ipkaNOAbNAgPXrSECRQ6WeLBG2pir3165qz1+Ju7TTuUQjv+lAIQJrFei8OV/khcv47l+0eS0J+eeBDGe6r7cBpXmPqYcE=
Received: from BN0PR04CA0106.namprd04.prod.outlook.com (2603:10b6:408:ec::21)
 by BL0PR02MB3652.namprd02.prod.outlook.com (2603:10b6:207:4a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Mon, 3 Jan
 2022 08:39:41 +0000
Received: from BN1NAM02FT046.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::29) by BN0PR04CA0106.outlook.office365.com
 (2603:10b6:408:ec::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.13 via Frontend
 Transport; Mon, 3 Jan 2022 08:39:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT046.mail.protection.outlook.com (10.13.3.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4844.14 via Frontend Transport; Mon, 3 Jan 2022 08:39:40 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 3 Jan 2022 00:39:38 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 3 Jan 2022 00:39:38 -0800
Envelope-to: helgaas@kernel.org,
 linux-pci@vger.kernel.org,
 ffclaire1224@gmail.com,
 lorenzo.pieralisi@arm.com,
 robh@kernel.org,
 linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org,
 skhan@linuxfoundation.org,
 bhelgaas@google.com,
 linux-arm-kernel@lists.infradead.org
Received: from [10.254.241.49] (port=41770)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1n4IsT-0007Ob-Rq; Mon, 03 Jan 2022 00:39:38 -0800
Message-ID: <51acdf9e-94a8-6cd0-0265-b96af35712a5@xilinx.com>
Date:   Mon, 3 Jan 2022 09:39:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 22/23] PCI: xilinx: Rename xilinx_pcie_port to
 xilinx_pcie
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        Fan Fei <ffclaire1224@gmail.com>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20211223011054.1227810-1-helgaas@kernel.org>
 <20211223011054.1227810-23-helgaas@kernel.org>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <20211223011054.1227810-23-helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9d6b767-0972-423a-7396-08d9ce94958d
X-MS-TrafficTypeDiagnostic: BL0PR02MB3652:EE_
X-Microsoft-Antispam-PRVS: <BL0PR02MB3652D6500A1079A419EF6F52C6499@BL0PR02MB3652.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:176;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8uxx5h/zmDRoju8D00Eq6aO11V/zQW2SyVjWsOD+keDltGjGiwNat5s6Z+j8anMBwJGNygoglfEThyIy7FVbp6GaLs5pdhz1P6o2G9/fxfJG59gsCtGKfIJ2gAfXB7iyYB04uO8NK0arodYc/fSbtouF5NxMLGK8eUdP1LnFdZAxuFXx9PlQVnwIpK2tQO46nKqdoowsV/qT/Ub+tF7uibvSTmggjGXNRjiUQsH1zJ0MDTJwHc7ri/a/L4AiTXB/CYpzTbdFR3RsQ9LqfcfQqSPJj1ysZFWxhYkmClu9D+7b/CofS+/QjWapK3CMbwzGqArN/b72fgzybSmE/RVXDulpV6Un+OqIamzOhtzaEp7WhtDX9A/dBQlXb+/sEFN7RAJRQRqDVTcY0CA9vkcP1R1FJ7TxoL/EIhbhz2tmuaqqRsaxGHnKL4BfsR9AVUwwpKQN92z31pTZj7WnAQPaXZ5PYfRKJir7BPGbpno8bUejE4+fRJa5zVuc9cX/A3tQu2VUzRnQtKFq1fK/wDedjIJCGXTx88mL4H6vI6Q0/DDjstybtG+LlUwbAaU5wSnjEG+fBgI5/XTmLD+BXQyco0qYTRAsmZ7i1FvFK0n7cJ8uy5qcAy9Vaq6eoa4tzXza9xuHfJbMyIHoFcG2dzgPwLVHUulF0vHYVMTHs4Ystg3qzNEk/2wMLnKFrBqd3FopBpZkIvFq2Qi/AtF3mTiiiUPv3Na/o71KL76IaijMSFbW3Ljmy4ejvlPZi2vt9Td6J/0VA9UoFvLauLEI/zRiEw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(7416002)(82310400004)(70586007)(356005)(5660300002)(8676002)(6666004)(508600001)(47076005)(53546011)(70206006)(186003)(36756003)(336012)(426003)(2906002)(30864003)(2616005)(4326008)(26005)(8936002)(110136005)(54906003)(316002)(31696002)(83380400001)(44832011)(31686004)(9786002)(7636003)(36860700001)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2022 08:39:40.7630
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9d6b767-0972-423a-7396-08d9ce94958d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT046.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB3652
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 12/23/21 02:10, Bjorn Helgaas wrote:
> From: Fan Fei <ffclaire1224@gmail.com>
> 
> Rename struct xilinx_pcie_port to xilinx_pcie to match the convention of
> <driver>_pcie. No functional change intended.
> 
> Signed-off-by: Fan Fei <ffclaire1224@gmail.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>   drivers/pci/controller/pcie-xilinx.c | 158 +++++++++++++--------------
>   1 file changed, 79 insertions(+), 79 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/pcie-xilinx.c
> index aa9bdcebc838..cb6e9f7b0152 100644
> --- a/drivers/pci/controller/pcie-xilinx.c
> +++ b/drivers/pci/controller/pcie-xilinx.c
> @@ -91,18 +91,18 @@
>   #define XILINX_NUM_MSI_IRQS		128
>   
>   /**
> - * struct xilinx_pcie_port - PCIe port information
> - * @reg_base: IO Mapped Register Base
> + * struct xilinx_pcie - PCIe port information
>    * @dev: Device pointer
> + * @reg_base: IO Mapped Register Base
>    * @msi_map: Bitmap of allocated MSIs
>    * @map_lock: Mutex protecting the MSI allocation
>    * @msi_domain: MSI IRQ domain pointer
>    * @leg_domain: Legacy IRQ domain pointer
>    * @resources: Bus Resources
>    */
> -struct xilinx_pcie_port {
> -	void __iomem *reg_base;
> +struct xilinx_pcie {
>   	struct device *dev;
> +	void __iomem *reg_base;
>   	unsigned long msi_map[BITS_TO_LONGS(XILINX_NUM_MSI_IRQS)];
>   	struct mutex map_lock;
>   	struct irq_domain *msi_domain;
> @@ -110,35 +110,35 @@ struct xilinx_pcie_port {
>   	struct list_head resources;
>   };
>   
> -static inline u32 pcie_read(struct xilinx_pcie_port *port, u32 reg)
> +static inline u32 pcie_read(struct xilinx_pcie *pcie, u32 reg)
>   {
> -	return readl(port->reg_base + reg);
> +	return readl(pcie->reg_base + reg);
>   }
>   
> -static inline void pcie_write(struct xilinx_pcie_port *port, u32 val, u32 reg)
> +static inline void pcie_write(struct xilinx_pcie *pcie, u32 val, u32 reg)
>   {
> -	writel(val, port->reg_base + reg);
> +	writel(val, pcie->reg_base + reg);
>   }
>   
> -static inline bool xilinx_pcie_link_up(struct xilinx_pcie_port *port)
> +static inline bool xilinx_pcie_link_up(struct xilinx_pcie *pcie)
>   {
> -	return (pcie_read(port, XILINX_PCIE_REG_PSCR) &
> +	return (pcie_read(pcie, XILINX_PCIE_REG_PSCR) &
>   		XILINX_PCIE_REG_PSCR_LNKUP) ? 1 : 0;
>   }
>   
>   /**
>    * xilinx_pcie_clear_err_interrupts - Clear Error Interrupts
> - * @port: PCIe port information
> + * @pcie: PCIe port information
>    */
> -static void xilinx_pcie_clear_err_interrupts(struct xilinx_pcie_port *port)
> +static void xilinx_pcie_clear_err_interrupts(struct xilinx_pcie *pcie)
>   {
> -	struct device *dev = port->dev;
> -	unsigned long val = pcie_read(port, XILINX_PCIE_REG_RPEFR);
> +	struct device *dev = pcie->dev;
> +	unsigned long val = pcie_read(pcie, XILINX_PCIE_REG_RPEFR);
>   
>   	if (val & XILINX_PCIE_RPEFR_ERR_VALID) {
>   		dev_dbg(dev, "Requester ID %lu\n",
>   			val & XILINX_PCIE_RPEFR_REQ_ID);
> -		pcie_write(port, XILINX_PCIE_RPEFR_ALL_MASK,
> +		pcie_write(pcie, XILINX_PCIE_RPEFR_ALL_MASK,
>   			   XILINX_PCIE_REG_RPEFR);
>   	}
>   }
> @@ -152,11 +152,11 @@ static void xilinx_pcie_clear_err_interrupts(struct xilinx_pcie_port *port)
>    */
>   static bool xilinx_pcie_valid_device(struct pci_bus *bus, unsigned int devfn)
>   {
> -	struct xilinx_pcie_port *port = bus->sysdata;
> +	struct xilinx_pcie *pcie = bus->sysdata;
>   
> -	/* Check if link is up when trying to access downstream ports */
> +	/* Check if link is up when trying to access downstream pcie ports */
>   	if (!pci_is_root_bus(bus)) {
> -		if (!xilinx_pcie_link_up(port))
> +		if (!xilinx_pcie_link_up(pcie))
>   			return false;
>   	} else if (devfn > 0) {
>   		/* Only one device down on each root port */
> @@ -177,12 +177,12 @@ static bool xilinx_pcie_valid_device(struct pci_bus *bus, unsigned int devfn)
>   static void __iomem *xilinx_pcie_map_bus(struct pci_bus *bus,
>   					 unsigned int devfn, int where)
>   {
> -	struct xilinx_pcie_port *port = bus->sysdata;
> +	struct xilinx_pcie *pcie = bus->sysdata;
>   
>   	if (!xilinx_pcie_valid_device(bus, devfn))
>   		return NULL;
>   
> -	return port->reg_base + PCIE_ECAM_OFFSET(bus->number, devfn, where);
> +	return pcie->reg_base + PCIE_ECAM_OFFSET(bus->number, devfn, where);
>   }
>   
>   /* PCIe operations */
> @@ -215,7 +215,7 @@ static int xilinx_msi_set_affinity(struct irq_data *d, const struct cpumask *mas
>   
>   static void xilinx_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>   {
> -	struct xilinx_pcie_port *pcie = irq_data_get_irq_chip_data(data);
> +	struct xilinx_pcie *pcie = irq_data_get_irq_chip_data(data);
>   	phys_addr_t pa = ALIGN_DOWN(virt_to_phys(pcie), SZ_4K);
>   
>   	msg->address_lo = lower_32_bits(pa);
> @@ -232,14 +232,14 @@ static struct irq_chip xilinx_msi_bottom_chip = {
>   static int xilinx_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
>   				  unsigned int nr_irqs, void *args)
>   {
> -	struct xilinx_pcie_port *port = domain->host_data;
> +	struct xilinx_pcie *pcie = domain->host_data;
>   	int hwirq, i;
>   
> -	mutex_lock(&port->map_lock);
> +	mutex_lock(&pcie->map_lock);
>   
> -	hwirq = bitmap_find_free_region(port->msi_map, XILINX_NUM_MSI_IRQS, order_base_2(nr_irqs));
> +	hwirq = bitmap_find_free_region(pcie->msi_map, XILINX_NUM_MSI_IRQS, order_base_2(nr_irqs));
>   
> -	mutex_unlock(&port->map_lock);
> +	mutex_unlock(&pcie->map_lock);
>   
>   	if (hwirq < 0)
>   		return -ENOSPC;
> @@ -256,13 +256,13 @@ static void xilinx_msi_domain_free(struct irq_domain *domain, unsigned int virq,
>   				  unsigned int nr_irqs)
>   {
>   	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
> -	struct xilinx_pcie_port *port = domain->host_data;
> +	struct xilinx_pcie *pcie = domain->host_data;
>   
> -	mutex_lock(&port->map_lock);
> +	mutex_lock(&pcie->map_lock);
>   
> -	bitmap_release_region(port->msi_map, d->hwirq, order_base_2(nr_irqs));
> +	bitmap_release_region(pcie->msi_map, d->hwirq, order_base_2(nr_irqs));
>   
> -	mutex_unlock(&port->map_lock);
> +	mutex_unlock(&pcie->map_lock);
>   }
>   
>   static const struct irq_domain_ops xilinx_msi_domain_ops = {
> @@ -275,7 +275,7 @@ static struct msi_domain_info xilinx_msi_info = {
>   	.chip	= &xilinx_msi_top_chip,
>   };
>   
> -static int xilinx_allocate_msi_domains(struct xilinx_pcie_port *pcie)
> +static int xilinx_allocate_msi_domains(struct xilinx_pcie *pcie)
>   {
>   	struct fwnode_handle *fwnode = dev_fwnode(pcie->dev);
>   	struct irq_domain *parent;
> @@ -298,7 +298,7 @@ static int xilinx_allocate_msi_domains(struct xilinx_pcie_port *pcie)
>   	return 0;
>   }
>   
> -static void xilinx_free_msi_domains(struct xilinx_pcie_port *pcie)
> +static void xilinx_free_msi_domains(struct xilinx_pcie *pcie)
>   {
>   	struct irq_domain *parent = pcie->msi_domain->parent;
>   
> @@ -342,13 +342,13 @@ static const struct irq_domain_ops intx_domain_ops = {
>    */
>   static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
>   {
> -	struct xilinx_pcie_port *port = (struct xilinx_pcie_port *)data;
> -	struct device *dev = port->dev;
> +	struct xilinx_pcie *pcie = (struct xilinx_pcie *)data;
> +	struct device *dev = pcie->dev;
>   	u32 val, mask, status;
>   
>   	/* Read interrupt decode and mask registers */
> -	val = pcie_read(port, XILINX_PCIE_REG_IDR);
> -	mask = pcie_read(port, XILINX_PCIE_REG_IMR);
> +	val = pcie_read(pcie, XILINX_PCIE_REG_IDR);
> +	mask = pcie_read(pcie, XILINX_PCIE_REG_IMR);
>   
>   	status = val & mask;
>   	if (!status)
> @@ -371,23 +371,23 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
>   
>   	if (status & XILINX_PCIE_INTR_CORRECTABLE) {
>   		dev_warn(dev, "Correctable error message\n");
> -		xilinx_pcie_clear_err_interrupts(port);
> +		xilinx_pcie_clear_err_interrupts(pcie);
>   	}
>   
>   	if (status & XILINX_PCIE_INTR_NONFATAL) {
>   		dev_warn(dev, "Non fatal error message\n");
> -		xilinx_pcie_clear_err_interrupts(port);
> +		xilinx_pcie_clear_err_interrupts(pcie);
>   	}
>   
>   	if (status & XILINX_PCIE_INTR_FATAL) {
>   		dev_warn(dev, "Fatal error message\n");
> -		xilinx_pcie_clear_err_interrupts(port);
> +		xilinx_pcie_clear_err_interrupts(pcie);
>   	}
>   
>   	if (status & (XILINX_PCIE_INTR_INTX | XILINX_PCIE_INTR_MSI)) {
>   		struct irq_domain *domain;
>   
> -		val = pcie_read(port, XILINX_PCIE_REG_RPIFR1);
> +		val = pcie_read(pcie, XILINX_PCIE_REG_RPIFR1);
>   
>   		/* Check whether interrupt valid */
>   		if (!(val & XILINX_PCIE_RPIFR1_INTR_VALID)) {
> @@ -397,17 +397,17 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
>   
>   		/* Decode the IRQ number */
>   		if (val & XILINX_PCIE_RPIFR1_MSI_INTR) {
> -			val = pcie_read(port, XILINX_PCIE_REG_RPIFR2) &
> +			val = pcie_read(pcie, XILINX_PCIE_REG_RPIFR2) &
>   				XILINX_PCIE_RPIFR2_MSG_DATA;
> -			domain = port->msi_domain->parent;
> +			domain = pcie->msi_domain->parent;
>   		} else {
>   			val = (val & XILINX_PCIE_RPIFR1_INTR_MASK) >>
>   				XILINX_PCIE_RPIFR1_INTR_SHIFT;
> -			domain = port->leg_domain;
> +			domain = pcie->leg_domain;
>   		}
>   
>   		/* Clear interrupt FIFO register 1 */
> -		pcie_write(port, XILINX_PCIE_RPIFR1_ALL_MASK,
> +		pcie_write(pcie, XILINX_PCIE_RPIFR1_ALL_MASK,
>   			   XILINX_PCIE_REG_RPIFR1);
>   
>   		generic_handle_domain_irq(domain, val);
> @@ -442,20 +442,20 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
>   
>   error:
>   	/* Clear the Interrupt Decode register */
> -	pcie_write(port, status, XILINX_PCIE_REG_IDR);
> +	pcie_write(pcie, status, XILINX_PCIE_REG_IDR);
>   
>   	return IRQ_HANDLED;
>   }
>   
>   /**
>    * xilinx_pcie_init_irq_domain - Initialize IRQ domain
> - * @port: PCIe port information
> + * @pcie: PCIe port information
>    *
>    * Return: '0' on success and error value on failure
>    */
> -static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
> +static int xilinx_pcie_init_irq_domain(struct xilinx_pcie *pcie)
>   {
> -	struct device *dev = port->dev;
> +	struct device *dev = pcie->dev;
>   	struct device_node *pcie_intc_node;
>   	int ret;
>   
> @@ -466,25 +466,25 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
>   		return -ENODEV;
>   	}
>   
> -	port->leg_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
> +	pcie->leg_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
>   						 &intx_domain_ops,
> -						 port);
> +						 pcie);
>   	of_node_put(pcie_intc_node);
> -	if (!port->leg_domain) {
> +	if (!pcie->leg_domain) {
>   		dev_err(dev, "Failed to get a INTx IRQ domain\n");
>   		return -ENODEV;
>   	}
>   
>   	/* Setup MSI */
>   	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> -		phys_addr_t pa = ALIGN_DOWN(virt_to_phys(port), SZ_4K);
> +		phys_addr_t pa = ALIGN_DOWN(virt_to_phys(pcie), SZ_4K);
>   
> -		ret = xilinx_allocate_msi_domains(port);
> +		ret = xilinx_allocate_msi_domains(pcie);
>   		if (ret)
>   			return ret;
>   
> -		pcie_write(port, upper_32_bits(pa), XILINX_PCIE_REG_MSIBASE1);
> -		pcie_write(port, lower_32_bits(pa), XILINX_PCIE_REG_MSIBASE2);
> +		pcie_write(pcie, upper_32_bits(pa), XILINX_PCIE_REG_MSIBASE1);
> +		pcie_write(pcie, lower_32_bits(pa), XILINX_PCIE_REG_MSIBASE2);
>   	}
>   
>   	return 0;
> @@ -492,44 +492,44 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
>   
>   /**
>    * xilinx_pcie_init_port - Initialize hardware
> - * @port: PCIe port information
> + * @pcie: PCIe port information
>    */
> -static void xilinx_pcie_init_port(struct xilinx_pcie_port *port)
> +static void xilinx_pcie_init_port(struct xilinx_pcie *pcie)
>   {
> -	struct device *dev = port->dev;
> +	struct device *dev = pcie->dev;
>   
> -	if (xilinx_pcie_link_up(port))
> +	if (xilinx_pcie_link_up(pcie))
>   		dev_info(dev, "PCIe Link is UP\n");
>   	else
>   		dev_info(dev, "PCIe Link is DOWN\n");
>   
>   	/* Disable all interrupts */
> -	pcie_write(port, ~XILINX_PCIE_IDR_ALL_MASK,
> +	pcie_write(pcie, ~XILINX_PCIE_IDR_ALL_MASK,
>   		   XILINX_PCIE_REG_IMR);
>   
>   	/* Clear pending interrupts */
> -	pcie_write(port, pcie_read(port, XILINX_PCIE_REG_IDR) &
> +	pcie_write(pcie, pcie_read(pcie, XILINX_PCIE_REG_IDR) &
>   			 XILINX_PCIE_IMR_ALL_MASK,
>   		   XILINX_PCIE_REG_IDR);
>   
>   	/* Enable all interrupts we handle */
> -	pcie_write(port, XILINX_PCIE_IMR_ENABLE_MASK, XILINX_PCIE_REG_IMR);
> +	pcie_write(pcie, XILINX_PCIE_IMR_ENABLE_MASK, XILINX_PCIE_REG_IMR);
>   
>   	/* Enable the Bridge enable bit */
> -	pcie_write(port, pcie_read(port, XILINX_PCIE_REG_RPSC) |
> +	pcie_write(pcie, pcie_read(pcie, XILINX_PCIE_REG_RPSC) |
>   			 XILINX_PCIE_REG_RPSC_BEN,
>   		   XILINX_PCIE_REG_RPSC);
>   }
>   
>   /**
>    * xilinx_pcie_parse_dt - Parse Device tree
> - * @port: PCIe port information
> + * @pcie: PCIe port information
>    *
>    * Return: '0' on success and error value on failure
>    */
> -static int xilinx_pcie_parse_dt(struct xilinx_pcie_port *port)
> +static int xilinx_pcie_parse_dt(struct xilinx_pcie *pcie)
>   {
> -	struct device *dev = port->dev;
> +	struct device *dev = pcie->dev;
>   	struct device_node *node = dev->of_node;
>   	struct resource regs;
>   	unsigned int irq;
> @@ -541,14 +541,14 @@ static int xilinx_pcie_parse_dt(struct xilinx_pcie_port *port)
>   		return err;
>   	}
>   
> -	port->reg_base = devm_pci_remap_cfg_resource(dev, &regs);
> -	if (IS_ERR(port->reg_base))
> -		return PTR_ERR(port->reg_base);
> +	pcie->reg_base = devm_pci_remap_cfg_resource(dev, &regs);
> +	if (IS_ERR(pcie->reg_base))
> +		return PTR_ERR(pcie->reg_base);
>   
>   	irq = irq_of_parse_and_map(node, 0);
>   	err = devm_request_irq(dev, irq, xilinx_pcie_intr_handler,
>   			       IRQF_SHARED | IRQF_NO_THREAD,
> -			       "xilinx-pcie", port);
> +			       "xilinx-pcie", pcie);
>   	if (err) {
>   		dev_err(dev, "unable to request irq %d\n", irq);
>   		return err;
> @@ -566,41 +566,41 @@ static int xilinx_pcie_parse_dt(struct xilinx_pcie_port *port)
>   static int xilinx_pcie_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
> -	struct xilinx_pcie_port *port;
> +	struct xilinx_pcie *pcie;
>   	struct pci_host_bridge *bridge;
>   	int err;
>   
>   	if (!dev->of_node)
>   		return -ENODEV;
>   
> -	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*port));
> +	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
>   	if (!bridge)
>   		return -ENODEV;
>   
> -	port = pci_host_bridge_priv(bridge);
> -	mutex_init(&port->map_lock);
> -	port->dev = dev;
> +	pcie = pci_host_bridge_priv(bridge);
> +	mutex_init(&pcie->map_lock);
> +	pcie->dev = dev;
>   
> -	err = xilinx_pcie_parse_dt(port);
> +	err = xilinx_pcie_parse_dt(pcie);
>   	if (err) {
>   		dev_err(dev, "Parsing DT failed\n");
>   		return err;
>   	}
>   
> -	xilinx_pcie_init_port(port);
> +	xilinx_pcie_init_port(pcie);
>   
> -	err = xilinx_pcie_init_irq_domain(port);
> +	err = xilinx_pcie_init_irq_domain(pcie);
>   	if (err) {
>   		dev_err(dev, "Failed creating IRQ Domain\n");
>   		return err;
>   	}
>   
> -	bridge->sysdata = port;
> +	bridge->sysdata = pcie;
>   	bridge->ops = &xilinx_pcie_ops;
>   
>   	err = pci_host_probe(bridge);
>   	if (err)
> -		xilinx_free_msi_domains(port);
> +		xilinx_free_msi_domains(pcie);
>   
>   	return err;
>   }

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
