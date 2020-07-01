Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66722210B32
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jul 2020 14:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730603AbgGAMrJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Jul 2020 08:47:09 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7329 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730388AbgGAMrI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Jul 2020 08:47:08 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4AB88B12259715F874FE;
        Wed,  1 Jul 2020 20:47:06 +0800 (CST)
Received: from [10.65.58.147] (10.65.58.147) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Wed, 1 Jul 2020
 20:47:02 +0800
Subject: Re: [PATCH] PCI: Make pcie_find_root_port() work for PCIe root ports
 as well
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
References: <20200630220107.GA3489322@bjorn-Precision-5520>
 <c4282c55-8312-53a0-d9e6-4818b9206c1f@hisilicon.com>
 <20200701101541.GO5180@lahna.fi.intel.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kalle Valo <kvalo@codeaurora.org>, <linux-pci@vger.kernel.org>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <0e6f9741-03a2-816e-d288-f9532b6d0a26@hisilicon.com>
Date:   Wed, 1 Jul 2020 20:47:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20200701101541.GO5180@lahna.fi.intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.58.147]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020/7/1 18:15, Mika Westerberg wrote:
> On Wed, Jul 01, 2020 at 09:53:51AM +0800, Yicong Yang wrote:
>>>  static inline struct pci_dev *pcie_find_root_port(struct pci_dev *dev)
>>>  {
>>> -	struct pci_dev *bridge = pci_upstream_bridge(dev);
>>> -
>>> -	while (bridge) {
>>> -		if (pci_pcie_type(bridge) == PCI_EXP_TYPE_ROOT_PORT)
>>> -			return bridge;
>>> -		bridge = pci_upstream_bridge(bridge);
>>> +	while (dev) {
>>> +		if (pci_is_pcie(dev) &&
>>> +		    pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
>>> +			return dev;
>>> +		dev = pci_upstream_bridge(dev);
>>>  	}
>>>  
>> We may have some problems here, as after pcie_find_root_port() called, *dev will
>> be either root port or NULL but users may want it unchanged. One such usage is
>> in acpi_pci_bridge_d3(), drivers/pci/pci-acpi.c, *dev is used as origin
>> after called this.
>>
>> So we should use a temporary point to *dev rather than directly modify it.
> dev is already a copy of what is passed by the caller so it does not
> matter if it gets changed here. You would need to pass it through struct
> pci_dev **dev in order to modify the passed pointer.

Ah...I must be fuzzy in mind then. Thanks.


> .
>

