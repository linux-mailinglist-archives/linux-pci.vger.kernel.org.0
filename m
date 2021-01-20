Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60FB72FC784
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jan 2021 03:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbhATCJo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jan 2021 21:09:44 -0500
Received: from regular1.263xmail.com ([211.150.70.200]:58634 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbhATCJl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jan 2021 21:09:41 -0500
X-Greylist: delayed 604 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Jan 2021 21:09:39 EST
Received: from localhost (unknown [192.168.167.13])
        by regular1.263xmail.com (Postfix) with ESMTP id 7F7DA1DC1;
        Wed, 20 Jan 2021 09:53:45 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [192.168.31.83] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P11934T140583756891904S1611107624645924_;
        Wed, 20 Jan 2021 09:53:45 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <49e71bb9943766a8ef228fe03093d29a>
X-RL-SENDER: xxm@rock-chips.com
X-SENDER: xxm@rock-chips.com
X-LOGIN-NAME: xxm@rock-chips.com
X-FST-TO: linux-rockchip@lists.infradead.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Subject: Re: [PATCH 1/3] PCI: dwc: Skip allocating own MSI domain if using
 external MSI domain
To:     Robin Murphy <robin.murphy@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
        linux-rockchip@lists.infradead.org
References: <20210118091739.247040-1-xxm@rock-chips.com>
 <e17fcf83-18f1-c2c4-3a0c-a68e74138e15@arm.com>
From:   xxm <xxm@rock-chips.com>
Message-ID: <c6e2d613-c398-2ed1-a9b9-bdc31d3a5c20@rock-chips.com>
Date:   Wed, 20 Jan 2021 09:53:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <e17fcf83-18f1-c2c4-3a0c-a68e74138e15@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Robin,

在 2021/1/20 3:47, Robin Murphy 写道:
> On 2021-01-18 09:17, Simon Xue wrote:
>> From: Shawn Lin <shawn.lin@rock-chips.com>
>>
>> On some platform, external MSI domain is using instead of the one
>> created by designware driver. For instance, if using GIC-V3-ITS
>> as a MSI domain, we only need set msi-map in the devicetree but
>> never need any bit in the designware driver to handle MSI stuff.
>> So skip allocating its own MSI domain for that case.
>
> How is this different from the existing pp->has_msi_ctrl? AFAICS, 
> dw_pcie_host_init() won't call dw_pcie_allocate_domains() anyway if an 
> external MSI controller is present.

Thanks for your review, I didn't notice pp->has_msi_ctrl already exist, 
will abandon this patch.

Simon Xue.

>
> Robin.
>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> Signed-off-by: Simon Xue <xxm@rock-chips.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-designware-host.c | 10 +++++++++-
>>   drivers/pci/controller/dwc/pcie-designware.h      |  1 +
>>   2 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c 
>> b/drivers/pci/controller/dwc/pcie-designware-host.c
>> index 8a84c005f32b..d9d93cab970a 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>> @@ -235,6 +235,10 @@ int dw_pcie_allocate_domains(struct pcie_port *pp)
>>       struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>       struct fwnode_handle *fwnode = 
>> of_node_to_fwnode(pci->dev->of_node);
>>   +    /* Rely on the external MSI domain */
>> +    if (pp->msi_ext)
>> +        return 0;
>> +
>>       pp->irq_domain = irq_domain_create_linear(fwnode, pp->num_vectors,
>>                              &dw_pcie_msi_domain_ops, pp);
>>       if (!pp->irq_domain) {
>> @@ -258,6 +262,9 @@ int dw_pcie_allocate_domains(struct pcie_port *pp)
>>     static void dw_pcie_free_msi(struct pcie_port *pp)
>>   {
>> +    if (pp->msi_ext)
>> +        return;
>> +
>>       if (pp->msi_irq) {
>>           irq_set_chained_handler(pp->msi_irq, NULL);
>>           irq_set_handler_data(pp->msi_irq, NULL);
>> @@ -359,7 +366,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
>>       if (pci->link_gen < 1)
>>           pci->link_gen = of_pci_get_max_link_speed(np);
>>   -    if (pci_msi_enabled()) {
>> +    if (pci_msi_enabled() &&
>> +        !pp->msi_ext) {
>>           pp->has_msi_ctrl = !(pp->ops->msi_host_init ||
>>                        of_property_read_bool(np, "msi-parent") ||
>>                        of_property_read_bool(np, "msi-map"));
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h 
>> b/drivers/pci/controller/dwc/pcie-designware.h
>> index 0207840756c4..cf3b0664302a 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>> @@ -195,6 +195,7 @@ struct pcie_port {
>>       u32            irq_mask[MAX_MSI_CTRLS];
>>       struct pci_host_bridge  *bridge;
>>       raw_spinlock_t        lock;
>> +    int            msi_ext;
>>       DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
>>   };
>>
>
>


