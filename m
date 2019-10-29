Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A11AE7FF4
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2019 06:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730584AbfJ2Fzy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Oct 2019 01:55:54 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:58364 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730384AbfJ2Fzy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Oct 2019 01:55:54 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9T5thHD030668;
        Tue, 29 Oct 2019 00:55:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1572328543;
        bh=3d6H77Gx0SuP9FEUJCwqHrnlVeBvTkFH+Xp1wT+PnWI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=YJMhidBIorGLnLIeQNbxzZLlphu1z+WGhrp3rjL+/EtRBdpd7DLU6GpKKIhCCAJub
         G9tOV3dgqDIVo6wCM0CYAQHoXRRU0/AJZ534uu6ioPMNf6ADfAMyhLLxrpxr7ipz4y
         y626SatGdLYxdyuEpj7KVydlhe8KfduV4h6KhnyQ=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9T5thf8022030
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 29 Oct 2019 00:55:43 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 29
 Oct 2019 00:55:31 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 29 Oct 2019 00:55:43 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9T5tbw3028457;
        Tue, 29 Oct 2019 00:55:39 -0500
Subject: Re: [PATCH V2] PCI: dwc ep: cache config until DBI regs available
To:     Vidya Sagar <vidyas@nvidia.com>
CC:     Stephen Warren <swarren@wwwdotorg.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Trent Piepho <tpiepho@impinj.com>,
        Stephen Warren <swarren@nvidia.com>
References: <20181126230958.8175-1-swarren@wwwdotorg.org>
 <340ed2c5-cb11-0aea-5430-5da5b509d805@ti.com>
 <b4a19329-3fd0-6242-5e31-8270d2c0a3e4@wwwdotorg.org>
 <27179f56-c7be-a55e-46ef-8ebc144e8547@wwwdotorg.org>
 <f86f4b8e-6b62-e921-eee2-1cf7ff0266ff@ti.com>
 <8982f057-881d-ffe7-6c26-e6a9844cbc0a@wwwdotorg.org>
 <ced15b0c-7dd8-0969-39bb-f4891012ce45@ti.com>
 <79710923-1cff-dce8-bd73-326d7921d621@ti.com>
 <feaa08b7-8e22-995f-d041-93733e3513ac@nvidia.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <772533c5-e661-8e77-afd1-d96cc5e78e25@ti.com>
Date:   Tue, 29 Oct 2019 11:25:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <feaa08b7-8e22-995f-d041-93733e3513ac@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 25/10/19 7:20 PM, Vidya Sagar wrote:
> On 1/8/2019 5:35 PM, Kishon Vijay Abraham I wrote:
>> Hi Stephen,
>>
>> On 04/01/19 1:32 PM, Kishon Vijay Abraham I wrote:
>>> Hi Stephen,
>>>
>>> On 02/01/19 10:04 PM, Stephen Warren wrote:
>>>> On 12/19/18 7:37 AM, Kishon Vijay Abraham I wrote:
>>>>> Hi,
>>>>>
>>>>> On 14/12/18 10:31 PM, Stephen Warren wrote:
>>>>>> On 12/11/18 10:23 AM, Stephen Warren wrote:
>>>>>>> On 12/10/18 9:36 PM, Kishon Vijay Abraham I wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> On 27/11/18 4:39 AM, Stephen Warren wrote:
>>>>>>>>> From: Stephen Warren <swarren@nvidia.com>
>>>>>>>>>
>>>>>>>>> Some implementations of the DWC PCIe endpoint controller do not allow
>>>>>>>>> access to DBI registers until the attached host has started REFCLK,
>>>>>>>>> released PERST, and the endpoint driver has initialized clocking of the
>>>>>>>>> DBI registers based on that. One such system is NVIDIA's T194 SoC. The
>>>>>>>>> PCIe endpoint subsystem and DWC driver currently don't work on such
>>>>>>>>> hardware, since they assume that all endpoint configuration can happen
>>>>>>>>> at any arbitrary time.
>>>>>>>>>
>>>>>>>>> Enhance the DWC endpoint driver to support such systems by caching all
>>>>>>>>> endpoint configuration in software, and only writing the configuration
>>>>>>>>> to hardware once it's been initialized. This is implemented by splitting
>>>>>>>>> all endpoint controller ops into two functions; the first which simply
>>>>>>>>> records/caches the desired configuration whenever called by the
>>>>>>>>> associated function driver and optionally calls the second, and the
>>>>>>>>> second which actually programs the configuration into hardware, which
>>>>>>>>> may be called either by the first function, or later when it's known
>>>>>>>>> that the DBI registers are available.
>>>>>>>
>>>>>>>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c
>>>>>>>>> b/drivers/pci/controller/dwc/pcie-designware-ep.c
>>>>>>>
>>>>>>>>> +void dw_pcie_set_regs_available(struct dw_pcie *pci)
>>>>>>>>> +{
>>>>>>>>
>>>>>>>> When will this function be invoked? Does the wrapper get an interrupt when
>>>>>>>> refclk is enabled where this function will be invoked?
>>>>>>>
>>>>>>> Yes, there's an IRQ from the HW that indicates when PEXRST is released. I
>>>>>>> don't recall right now if this IRQ is something that exists for all DWC
>>>>>>> instantiations, or is Tegra-specific.
>>>>>>>
>>>>>>>>> +    struct dw_pcie_ep *ep = &(pci->ep);
>>>>>>>>> +    int i;
>>>>>>>>> +
>>>>>>>>> +    ep->hw_regs_not_available = false;
>>>>>>>>
>>>>>>>> This can race with epc_ops.
>>>>>>>>
>>>>>>>>> +
>>>>>>>>> +    dw_pcie_ep_write_header_regs(ep);
>>>>>>>>> +    for_each_set_bit(i, ep->ib_window_map, ep->num_ib_windows) {
>>>>>>>>> +        dw_pcie_prog_inbound_atu(pci, i,
>>>>>>>>> +            ep->cached_inbound_atus[i].bar,
>>>>>>>>> +            ep->cached_inbound_atus[i].cpu_addr,
>>>>>>>>> +            ep->cached_inbound_atus[i].as_type);
>>>>>>>>
>>>>>>>> Depending on the context in which this function is invoked, programming
>>>>>>>> inbound/outbound ATU can also race with EPC ops.
>>>>>>>    >
>>>>>>>>> +        dw_pcie_ep_set_bar_regs(ep, 0, ep->cached_inbound_atus[i].bar);
>>>>>>>>> +    }
>>>>>>>>> +    for_each_set_bit(i, ep->ob_window_map, ep->num_ob_windows)
>>>>>>>>> +        dw_pcie_prog_outbound_atu(pci, i, PCIE_ATU_TYPE_MEM,
>>>>>>>>> +            ep->cached_outbound_atus[i].addr,
>>>>>>>>> +            ep->cached_outbound_atus[i].pci_addr,
>>>>>>>>> +            ep->cached_outbound_atus[i].size);
>>>>>>>>> +    dw_pcie_dbi_ro_wr_en(pci);
>>>>>>>>> +    dw_pcie_writew_dbi(pci, PCI_MSI_FLAGS, ep->cached_msi_flags);
>>>>>>>>> +    dw_pcie_writew_dbi(pci, PCI_MSIX_FLAGS, ep->cached_msix_flags);
>>>>>>>>> +    dw_pcie_dbi_ro_wr_dis(pci);
>>>>>>>>
>>>>>>>> IMHO we should add a new epc ops ->epc_init() which indicates if the
>>>>>>>> EPC is
>>>>>>>> ready to be initialized or not. Only if the epc_init indicates it's ready
>>>>>>>> to be
>>>>>>>> initialized, the endpoint function driver should go ahead with further
>>>>>>>> initialization. Or else it should wait for a notification from EPC to
>>>>>>>> indicate
>>>>>>>> when it's ready to be initialized.
>>>>>>>
>>>>>>> (Did you mean epf op or epc op?)
>>>>>>>
>>>>>>> I'm not sure how exactly how that would work; do you want the DWC core
>>>>>>> driver
>>>>>>> or the endpoint subsystem to poll that epc op to find out when the HW is
>>>>>>> ready to be initialized? Or do you envisage the controller driver still
>>>>>>> calling dw_pcie_set_regs_available() (possibly renamed), which in turn
>>>>>>> calls
>>>>>>> ->epc_init() calls for some reason?
>>>>>>>
>>>>>>> If you don't want to cache the endpoint configuration, perhaps you want:
>>>>>>>
>>>>>>> a) Endpoint function doesn't pro-actively call the endpoint controller
>>>>>>> functions to configure the endpoint.
>>>>>>>
>>>>>>> b) When endpoint HW is ready, the relevant driver calls pci_epc_ready() (or
>>>>>>> whatever name), which lets the core know the HW can be configured. Perhaps
>>>>>>> this schedules a work queue item to implement locking to avoid the races
>>>>>>> you
>>>>>>> mentioned.
>>>>>>>
>>>>>>> c) Endpoint core calls pci_epf_init() which calls epf op ->init().
>>>>>>>
>>>>>>> One gotcha with this approach, which the caching approach helps avoid:
>>>>>>>
>>>>>>> Once PEXRST is released, the system must respond to PCIe enumeration
>>>>>>> requests
>>>>>>> within 50ms. Thus, SW must very quickly respond to the IRQ indicating
>>>>>>> PEXRST
>>>>>>> release and program the endpoint configuration into HW. By caching the
>>>>>>> configuration in the DWC driver and immediately/synchronously applying
>>>>>>> it in
>>>>>>> the PEXRST IRQ handler, we reduce the number of steps and amount of code
>>>>>>> taken to program the HW, so it should get done pretty quickly. If
>>>>>>> instead we
>>>>>>> call back into the endpoint function driver's ->init() op, we run the
>>>>>>> risk of
>>>>>>> that op doing other stuff besides just calling the endpoint HW
>>>>>>> configuration
>>>>>>> APIs (e.g. perhaps the function driver defers memory buffer allocation or
>>>>>>> IOVA programming to that ->init function) which in turns makes it much less
>>>>>>> likely the 50ms requirement will be hit. Perhaps we can solve this by
>>>>>>> naming
>>>>>>> the op well and providing lots of comments, but my guess is that endpoint
>>>>>>> function authors won't notice that...
>>>>>>
>>>>>> Kishon,
>>>>>>
>>>>>> Do you have any further details exactly how you'd prefer this to work?
>>>>>> Does the
>>>>>> approach I describe in points a/b/c above sound like what you want? Thanks.
>>>>>
>>>>> Agree with your PERST comment.
>>>>>
>>>>> What I have in mind is we add a new epc_init() ops. I feel there are more
>>>>> uses
>>>>> for it (For e.g I have an internal patch which uses epc_init to initialize
>>>>> DMA.
>>>>> Hopefully I'll post it soon).
>>>>> If you look at pci_epf_test, pci_epf_test_bind() is where the function
>>>>> actually
>>>>> starts to write to HW (i.e using pci_epc_*).
>>>>> So before the endpoint function invokes pci_epc_write_header(), it should
>>>>> invoke epc_init(). Only if that succeeds, it should go ahead with other
>>>>> initialization.
>>>>> If epc_init_* fails, we can have a particular error value to indicate the
>>>>> controller is waiting for clock from host (so that we don't return error from
>>>>> ->bind()). Once the controller receives the clock, it can send an atomic
>>>>> notification to the endpoint function driver to indicate it is ready to be
>>>>> initialized. (Atomic notification makes it easy to handle for multi function
>>>>> endpoint devices.)
>>>>> The endpoint function can then initialize the controller.
>>>>> I think except for pci_epf_test_alloc_space() all other functions are
>>>>> configuring the HW (in pci_epf_test_bind). pci_epf_test_alloc_space()
>>>>> could be
>>>>> moved to pci_epf_test_probe() so there are no expensive operations to be done
>>>>> once the controller is ready to be initialized.
>>>>> I have epc_init() and the atomic notification part already implemented and
>>>>> I'm
>>>>> planning to post it before next week. Once that is merged, we might have to
>>>>> reorder function in pci_epf_test driver and you have to return the correct
>>>>> error value for epc_init() if the clock is not there.
>>>>
>>>> Kishon, did you manage to post the patches that implement epc_init()? If so, a
>>>> link would be appreciated. Thanks.
>>>
>>> I haven't posted the patches yet. Sorry for the delay. Give me some more time
>>> please (till next week).
>>
>> I have posted one set of cleanup for EPC features [1] by introducing
>> epc_get_features(). Some of the things I initially thought should be in
>> epc_init actually fits in epc_get_features. However I still believe for your
>> usecase we should introduce ->epc_init().
> 
> Hi Kishon,
> Do you have a Work-In-Progress patch set for ->epc_init()?
> If not, I would like to start working on that.

I only added epc_get_features() as it fitted better for whatever I thought
should be added in epc_init(). I think you can go ahead with implementing
->epc_init() for your usecase.

Thanks
Kishon
