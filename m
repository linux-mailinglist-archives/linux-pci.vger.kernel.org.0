Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032F93F2E5E
	for <lists+linux-pci@lfdr.de>; Fri, 20 Aug 2021 16:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240894AbhHTOsQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Aug 2021 10:48:16 -0400
Received: from lizzard.sbs.de ([194.138.37.39]:58472 "EHLO lizzard.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240935AbhHTOsQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Aug 2021 10:48:16 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 17KElYgX006287
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Aug 2021 16:47:34 +0200
Received: from [167.87.0.29] ([167.87.0.29])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 17KElX7I007803;
        Fri, 20 Aug 2021 16:47:33 +0200
Subject: Re: [PATCH] PCI/portdrv: Do not setup up IRQs if there are no users
To:     Lukas Wunner <lukas@wunner.de>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <43e1591d-51ed-39fa-3bc5-c11777f27b62@siemens.com>
 <20210820144532.GA25391@wunner.de>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <53a826fb-ece9-450d-e5fc-f145c2513688@siemens.com>
Date:   Fri, 20 Aug 2021 16:47:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210820144532.GA25391@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 20.08.21 16:45, Lukas Wunner wrote:
> On Fri, Aug 20, 2021 at 03:52:18PM +0200, Jan Kiszka wrote:
>> --- a/drivers/pci/pcie/portdrv_core.c
>> +++ b/drivers/pci/pcie/portdrv_core.c
>> @@ -312,7 +312,7 @@ static int pcie_device_init(struct pci_dev *pdev, int service, int irq)
>>   */
>>  int pcie_port_device_register(struct pci_dev *dev)
>>  {
>> -	int status, capabilities, i, nr_service;
>> +	int status, capabilities, irq_services, i, nr_service;
>>  	int irqs[PCIE_PORT_DEVICE_MAXSERVICES];
>>  
>>  	/* Enable PCI Express port device */
>> @@ -326,18 +326,32 @@ int pcie_port_device_register(struct pci_dev *dev)
>>  		return 0;
>>  
>>  	pci_set_master(dev);
>> -	/*
>> -	 * Initialize service irqs. Don't use service devices that
>> -	 * require interrupts if there is no way to generate them.
>> -	 * However, some drivers may have a polling mode (e.g. pciehp_poll_mode)
>> -	 * that can be used in the absence of irqs.  Allow them to determine
>> -	 * if that is to be used.
>> -	 */
>> -	status = pcie_init_service_irqs(dev, irqs, capabilities);
>> -	if (status) {
>> -		capabilities &= PCIE_PORT_SERVICE_HP;
>> -		if (!capabilities)
>> -			goto error_disable;
>> +
>> +	irq_services = 0;
>> +	if (IS_ENABLED(CONFIG_PCIE_PME))
>> +		irq_services |= PCIE_PORT_SERVICE_PME;
>> +	if (IS_ENABLED(CONFIG_PCIEAER))
>> +		irq_services |= PCIE_PORT_SERVICE_AER;
>> +	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
>> +		irq_services |= PCIE_PORT_SERVICE_HP;
>> +	if (IS_ENABLED(CONFIG_PCIE_DPC))
>> +		irq_services |= PCIE_PORT_SERVICE_DPC;
>> +	irq_services &= capabilities;
> 
> get_port_device_capability() would seem like a more natural place
> to put these checks.
> 
> Note that your check for CONFIG_PCIEAER is superfluous due to
> the "#ifdef CONFIG_PCIEAER" in get_port_device_capability().
> 

Not all service drivers need IRQs. That's why the test is separate. See
also the comment I shuffled around.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux
