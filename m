Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED16482F0D
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jan 2022 09:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbiACIju (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Jan 2022 03:39:50 -0500
Received: from mail-dm6nam12on2047.outbound.protection.outlook.com ([40.107.243.47]:29633
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232169AbiACIjt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 Jan 2022 03:39:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXo7YUjyjhzB9u/TQzmsZGiTfFDB4ptfJ6uLxglskFlHIYQHuumsmKp7mPGG80lRDrFBcFYstZePSv05pEB7T3HobpCBIFAbLDHYyzMDdwch0uep7Gy0lEIYX4IIOgAHMxpvDfQ7/08nqTFP7IE5K/VpHe74qHzOmrWA9SVfgQNDslz4vDshRlG3zL9a3tG7nZZAVbPvmPY13spIcUjArzxZNuJHCpnczaHy8tLxYVA3tSxv/EXMEsyJIdAzpi+bNb0q4V8CyOa9a70cQYEgpVsgO6u/WOooPeLP5d4d4sxsV3dWr6H6Lqxj4reNyE5I4YUdaNdQjEFv+JxvYKM8YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uIFf1dKjXiWnwwwNZKQZa4078RN+IhooUsJkHjPNlP4=;
 b=mwP1MVAbFjqpaWb1sWVHA4sWP0xuvH6lIRK688NP+A1uQWesemxYHD8Q1vNc6AOS2qdFNjFNwq4t3jXlQiHheeAQKp1JnAbRO6h7ViWzkr4Jy5F9rB+GGjFT48beSjVr7aJv7E47HKxhqcZp3coSHmyH9/+CF48ppK/Bsi4BpH+yxnqXoZ3PtY00eUwBEoTTsh+JqVCjfPyY2MZEBsEVgR4g/bJCZervkT0mCagw6h32x9OLF/jVDMrT21+FFVXCOHM3Rxuq0zzhb7xStl+XwkRodDOTktQ/Di9UUX/yhyLpgOSxeNggQDDTdbG8SJLGhjZzZb6woeSw4M4w8LcLNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIFf1dKjXiWnwwwNZKQZa4078RN+IhooUsJkHjPNlP4=;
 b=m2xNE6/6Rx/RiS+rl11+KLsSWG/uwPFD/nw9WVRpr4w77XTZo/DboSjkabkCdG/WWjbedWs+bsUTq4h6D9wS3vpiWpzfMAtlWlm6VcHOTHResrpFMoAIoCBEG0+gK6VdBQOWHzyeybptqTcd+OuBAo8F3vIxJQRrU7lDu5KyNus=
Received: from DM5PR06CA0051.namprd06.prod.outlook.com (2603:10b6:3:37::13) by
 SA0PR02MB7243.namprd02.prod.outlook.com (2603:10b6:806:e8::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4844.14; Mon, 3 Jan 2022 08:39:46 +0000
Received: from DM3NAM02FT014.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:37:cafe::3f) by DM5PR06CA0051.outlook.office365.com
 (2603:10b6:3:37::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15 via Frontend
 Transport; Mon, 3 Jan 2022 08:39:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT014.mail.protection.outlook.com (10.13.5.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4844.14 via Frontend Transport; Mon, 3 Jan 2022 08:39:45 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 3 Jan 2022 00:39:44 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 3 Jan 2022 00:39:44 -0800
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
Received: from [10.254.241.49] (port=41782)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1n4Isa-0007On-0d; Mon, 03 Jan 2022 00:39:44 -0800
Message-ID: <d049cfb1-31e4-b712-cd9a-4566ade8de4c@xilinx.com>
Date:   Mon, 3 Jan 2022 09:39:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 23/23] PCI: xilinx-cpm: Rename xilinx_cpm_pcie_port to
 xilinx_cpm_pcie
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
 <20211223011054.1227810-24-helgaas@kernel.org>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <20211223011054.1227810-24-helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d28e5858-1f18-4020-c465-08d9ce949885
X-MS-TrafficTypeDiagnostic: SA0PR02MB7243:EE_
X-Microsoft-Antispam-PRVS: <SA0PR02MB7243AF68316CBC86D3EA6DA8C6499@SA0PR02MB7243.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:635;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rOLGb5iBk5isR60P2t+Hpt//0uvrs9jbtjlZP6x97+06a+FrrIExUeh+v+AlMJVxMk8dJAubkxJ6dYpx25OO6TtxlfM5LTpQ4iVuKM1ygN/5T6Vorab4wNbFPUAC5/eSZmPPJdcYL3M4DGyWcRFT1aLgL488EhHBz1u5PCAOUB+tQfg9faL1bMjxg5xj7guCqwW/2tDAehrZUcJ0+fY2DJfvBboqPvi1ck9UYZnkGqJiXgV1I6wBLBHht+wB1YK1XjM0jgxNcyiL/2XTPSnPXxjjIMOlneYQMYyveLCEoB9LR8YOAsULQw03rVK2Q/M+kzHoNjvjKyYsWwXRyptBSSq7MegT45pzNS/DSAJmKfFoJixJ18tAR440Zq5DO+7JwTfGZ7O8wLmDcBIc02TPSf8/uDcSDc0+fiaUyreKWCcjynI4xNjMZYnPWc4e96Md2bZqcCfYdmAMCCDzOySB+1/fIVlBnsZVyCbckgo7ROTW0RrIpjfOLMORdVl/zSZMykpjYK4gtRFOXbUKynagWmvOIgVQsbYn1Un8huQVgnbT9hYxnPf+rCXCBPXrA6iHM06hih4KvlZkDVdJIV0wQOuGVzyFgaE1GNrq8D95pN42VBjXPE7GtsV8X7uX1dOFFEu7k5P2wIYHsNl/E9Ki0SvVEubdbDdkYxpVmU+HoiAxk5E96gah8ABN0S96uK7F9lirlzPbdt92Ql2Dr0Sd6Ff7UbZ4N4dkhZdAoMrk3zhANN9fIi3ByAtcG7RBa6JsjiZUoOaotVBJQRxsLL9KGw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(54906003)(110136005)(7416002)(336012)(83380400001)(44832011)(26005)(7636003)(6666004)(9786002)(8676002)(316002)(5660300002)(82310400004)(4326008)(426003)(31696002)(508600001)(186003)(31686004)(70206006)(70586007)(356005)(8936002)(53546011)(47076005)(2616005)(36860700001)(2906002)(36756003)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2022 08:39:45.8083
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d28e5858-1f18-4020-c465-08d9ce949885
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT014.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7243
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 12/23/21 02:10, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Rename struct xilinx_cpm_pcie_port to xilinx_cpm_pcie to match the
> convention of <driver>_pcie. No functional change intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>   drivers/pci/controller/pcie-xilinx-cpm.c | 44 ++++++++++++------------
>   1 file changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
> index 95426df03200..c7cd44ed4dfc 100644
> --- a/drivers/pci/controller/pcie-xilinx-cpm.c
> +++ b/drivers/pci/controller/pcie-xilinx-cpm.c
> @@ -99,10 +99,10 @@
>   #define XILINX_CPM_PCIE_REG_PSCR_LNKUP		BIT(11)
>   
>   /**
> - * struct xilinx_cpm_pcie_port - PCIe port information
> + * struct xilinx_cpm_pcie - PCIe port information
> + * @dev: Device pointer
>    * @reg_base: Bridge Register Base
>    * @cpm_base: CPM System Level Control and Status Register(SLCR) Base
> - * @dev: Device pointer
>    * @intx_domain: Legacy IRQ domain pointer
>    * @cpm_domain: CPM IRQ domain pointer
>    * @cfg: Holds mappings of config space window
> @@ -110,10 +110,10 @@
>    * @irq: Error interrupt number
>    * @lock: lock protecting shared register access
>    */
> -struct xilinx_cpm_pcie_port {
> +struct xilinx_cpm_pcie {
> +	struct device			*dev;
>   	void __iomem			*reg_base;
>   	void __iomem			*cpm_base;
> -	struct device			*dev;
>   	struct irq_domain		*intx_domain;
>   	struct irq_domain		*cpm_domain;
>   	struct pci_config_window	*cfg;
> @@ -122,24 +122,24 @@ struct xilinx_cpm_pcie_port {
>   	raw_spinlock_t			lock;
>   };
>   
> -static u32 pcie_read(struct xilinx_cpm_pcie_port *port, u32 reg)
> +static u32 pcie_read(struct xilinx_cpm_pcie *port, u32 reg)
>   {
>   	return readl_relaxed(port->reg_base + reg);
>   }
>   
> -static void pcie_write(struct xilinx_cpm_pcie_port *port,
> +static void pcie_write(struct xilinx_cpm_pcie *port,
>   		       u32 val, u32 reg)
>   {
>   	writel_relaxed(val, port->reg_base + reg);
>   }
>   
> -static bool cpm_pcie_link_up(struct xilinx_cpm_pcie_port *port)
> +static bool cpm_pcie_link_up(struct xilinx_cpm_pcie *port)
>   {
>   	return (pcie_read(port, XILINX_CPM_PCIE_REG_PSCR) &
>   		XILINX_CPM_PCIE_REG_PSCR_LNKUP);
>   }
>   
> -static void cpm_pcie_clear_err_interrupts(struct xilinx_cpm_pcie_port *port)
> +static void cpm_pcie_clear_err_interrupts(struct xilinx_cpm_pcie *port)
>   {
>   	unsigned long val = pcie_read(port, XILINX_CPM_PCIE_REG_RPEFR);
>   
> @@ -153,7 +153,7 @@ static void cpm_pcie_clear_err_interrupts(struct xilinx_cpm_pcie_port *port)
>   
>   static void xilinx_cpm_mask_leg_irq(struct irq_data *data)
>   {
> -	struct xilinx_cpm_pcie_port *port = irq_data_get_irq_chip_data(data);
> +	struct xilinx_cpm_pcie *port = irq_data_get_irq_chip_data(data);
>   	unsigned long flags;
>   	u32 mask;
>   	u32 val;
> @@ -167,7 +167,7 @@ static void xilinx_cpm_mask_leg_irq(struct irq_data *data)
>   
>   static void xilinx_cpm_unmask_leg_irq(struct irq_data *data)
>   {
> -	struct xilinx_cpm_pcie_port *port = irq_data_get_irq_chip_data(data);
> +	struct xilinx_cpm_pcie *port = irq_data_get_irq_chip_data(data);
>   	unsigned long flags;
>   	u32 mask;
>   	u32 val;
> @@ -211,7 +211,7 @@ static const struct irq_domain_ops intx_domain_ops = {
>   
>   static void xilinx_cpm_pcie_intx_flow(struct irq_desc *desc)
>   {
> -	struct xilinx_cpm_pcie_port *port = irq_desc_get_handler_data(desc);
> +	struct xilinx_cpm_pcie *port = irq_desc_get_handler_data(desc);
>   	struct irq_chip *chip = irq_desc_get_chip(desc);
>   	unsigned long val;
>   	int i;
> @@ -229,7 +229,7 @@ static void xilinx_cpm_pcie_intx_flow(struct irq_desc *desc)
>   
>   static void xilinx_cpm_mask_event_irq(struct irq_data *d)
>   {
> -	struct xilinx_cpm_pcie_port *port = irq_data_get_irq_chip_data(d);
> +	struct xilinx_cpm_pcie *port = irq_data_get_irq_chip_data(d);
>   	u32 val;
>   
>   	raw_spin_lock(&port->lock);
> @@ -241,7 +241,7 @@ static void xilinx_cpm_mask_event_irq(struct irq_data *d)
>   
>   static void xilinx_cpm_unmask_event_irq(struct irq_data *d)
>   {
> -	struct xilinx_cpm_pcie_port *port = irq_data_get_irq_chip_data(d);
> +	struct xilinx_cpm_pcie *port = irq_data_get_irq_chip_data(d);
>   	u32 val;
>   
>   	raw_spin_lock(&port->lock);
> @@ -273,7 +273,7 @@ static const struct irq_domain_ops event_domain_ops = {
>   
>   static void xilinx_cpm_pcie_event_flow(struct irq_desc *desc)
>   {
> -	struct xilinx_cpm_pcie_port *port = irq_desc_get_handler_data(desc);
> +	struct xilinx_cpm_pcie *port = irq_desc_get_handler_data(desc);
>   	struct irq_chip *chip = irq_desc_get_chip(desc);
>   	unsigned long val;
>   	int i;
> @@ -327,7 +327,7 @@ static const struct {
>   
>   static irqreturn_t xilinx_cpm_pcie_intr_handler(int irq, void *dev_id)
>   {
> -	struct xilinx_cpm_pcie_port *port = dev_id;
> +	struct xilinx_cpm_pcie *port = dev_id;
>   	struct device *dev = port->dev;
>   	struct irq_data *d;
>   
> @@ -350,7 +350,7 @@ static irqreturn_t xilinx_cpm_pcie_intr_handler(int irq, void *dev_id)
>   	return IRQ_HANDLED;
>   }
>   
> -static void xilinx_cpm_free_irq_domains(struct xilinx_cpm_pcie_port *port)
> +static void xilinx_cpm_free_irq_domains(struct xilinx_cpm_pcie *port)
>   {
>   	if (port->intx_domain) {
>   		irq_domain_remove(port->intx_domain);
> @@ -369,7 +369,7 @@ static void xilinx_cpm_free_irq_domains(struct xilinx_cpm_pcie_port *port)
>    *
>    * Return: '0' on success and error value on failure
>    */
> -static int xilinx_cpm_pcie_init_irq_domain(struct xilinx_cpm_pcie_port *port)
> +static int xilinx_cpm_pcie_init_irq_domain(struct xilinx_cpm_pcie *port)
>   {
>   	struct device *dev = port->dev;
>   	struct device_node *node = dev->of_node;
> @@ -410,7 +410,7 @@ static int xilinx_cpm_pcie_init_irq_domain(struct xilinx_cpm_pcie_port *port)
>   	return -ENOMEM;
>   }
>   
> -static int xilinx_cpm_setup_irq(struct xilinx_cpm_pcie_port *port)
> +static int xilinx_cpm_setup_irq(struct xilinx_cpm_pcie *port)
>   {
>   	struct device *dev = port->dev;
>   	struct platform_device *pdev = to_platform_device(dev);
> @@ -462,7 +462,7 @@ static int xilinx_cpm_setup_irq(struct xilinx_cpm_pcie_port *port)
>    * xilinx_cpm_pcie_init_port - Initialize hardware
>    * @port: PCIe port information
>    */
> -static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie_port *port)
> +static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
>   {
>   	if (cpm_pcie_link_up(port))
>   		dev_info(port->dev, "PCIe Link is UP\n");
> @@ -497,7 +497,7 @@ static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie_port *port)
>    *
>    * Return: '0' on success and error value on failure
>    */
> -static int xilinx_cpm_pcie_parse_dt(struct xilinx_cpm_pcie_port *port,
> +static int xilinx_cpm_pcie_parse_dt(struct xilinx_cpm_pcie *port,
>   				    struct resource *bus_range)
>   {
>   	struct device *dev = port->dev;
> @@ -523,7 +523,7 @@ static int xilinx_cpm_pcie_parse_dt(struct xilinx_cpm_pcie_port *port,
>   	return 0;
>   }
>   
> -static void xilinx_cpm_free_interrupts(struct xilinx_cpm_pcie_port *port)
> +static void xilinx_cpm_free_interrupts(struct xilinx_cpm_pcie *port)
>   {
>   	irq_set_chained_handler_and_data(port->intx_irq, NULL, NULL);
>   	irq_set_chained_handler_and_data(port->irq, NULL, NULL);
> @@ -537,7 +537,7 @@ static void xilinx_cpm_free_interrupts(struct xilinx_cpm_pcie_port *port)
>    */
>   static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
>   {
> -	struct xilinx_cpm_pcie_port *port;
> +	struct xilinx_cpm_pcie *port;
>   	struct device *dev = &pdev->dev;
>   	struct pci_host_bridge *bridge;
>   	struct resource_entry *bus;



Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
