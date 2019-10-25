Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11584E4CAC
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2019 15:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504949AbfJYNvL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Oct 2019 09:51:11 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:19809 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504947AbfJYNvL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Oct 2019 09:51:11 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5db2fdd10000>; Fri, 25 Oct 2019 06:51:13 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 25 Oct 2019 06:51:08 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 25 Oct 2019 06:51:08 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 25 Oct
 2019 13:51:00 +0000
Received: from [10.25.74.2] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 25 Oct
 2019 13:50:57 +0000
Subject: Re: [PATCH V2] PCI: dwc ep: cache config until DBI regs available
To:     Kishon Vijay Abraham I <kishon@ti.com>
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
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <feaa08b7-8e22-995f-d041-93733e3513ac@nvidia.com>
Date:   Fri, 25 Oct 2019 19:20:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <79710923-1cff-dce8-bd73-326d7921d621@ti.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1572011473; bh=Gn/magS+nok4i1uzjcVsQRTzvOohDK65ksfDca03jPA=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=l1fru8PPQezoJWMWySulz8xQgZanWdjmk2+/nlxhq3vGeqvnE7ZTRbIIVwtJ3YBRP
         Xwv48DzDeSo2IyAyNPHkU5oj3uZi8HDu2RANIsBwBx55+bEytdVgAB85gbT8jNdW7o
         eVgMGWcm+kpljyv05LXG2NR6+hUPYeF3zxDLaNyZK4zAzdEZIWpYDkVMmYoaCCIH38
         ixd4Y1WgzryI8vVfLCGDl3jw1ATxoheeGPxFH051BdgtztIgtTD0GmT/zKrFAgbf8x
         u4UjkFFw6X4wVfPgYXUwIVMx32mFCzW/CychXTJCWSRujop1ucTsSzhHAZfJUsWa32
         PTfmII0lVa6CA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/8/2019 5:35 PM, Kishon Vijay Abraham I wrote:
> Hi Stephen,
>=20
> On 04/01/19 1:32 PM, Kishon Vijay Abraham I wrote:
>> Hi Stephen,
>>
>> On 02/01/19 10:04 PM, Stephen Warren wrote:
>>> On 12/19/18 7:37 AM, Kishon Vijay Abraham I wrote:
>>>> Hi,
>>>>
>>>> On 14/12/18 10:31 PM, Stephen Warren wrote:
>>>>> On 12/11/18 10:23 AM, Stephen Warren wrote:
>>>>>> On 12/10/18 9:36 PM, Kishon Vijay Abraham I wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On 27/11/18 4:39 AM, Stephen Warren wrote:
>>>>>>>> From: Stephen Warren <swarren@nvidia.com>
>>>>>>>>
>>>>>>>> Some implementations of the DWC PCIe endpoint controller do not al=
low
>>>>>>>> access to DBI registers until the attached host has started REFCLK=
,
>>>>>>>> released PERST, and the endpoint driver has initialized clocking o=
f the
>>>>>>>> DBI registers based on that. One such system is NVIDIA's T194 SoC.=
 The
>>>>>>>> PCIe endpoint subsystem and DWC driver currently don't work on suc=
h
>>>>>>>> hardware, since they assume that all endpoint configuration can ha=
ppen
>>>>>>>> at any arbitrary time.
>>>>>>>>
>>>>>>>> Enhance the DWC endpoint driver to support such systems by caching=
 all
>>>>>>>> endpoint configuration in software, and only writing the configura=
tion
>>>>>>>> to hardware once it's been initialized. This is implemented by spl=
itting
>>>>>>>> all endpoint controller ops into two functions; the first which si=
mply
>>>>>>>> records/caches the desired configuration whenever called by the
>>>>>>>> associated function driver and optionally calls the second, and th=
e
>>>>>>>> second which actually programs the configuration into hardware, wh=
ich
>>>>>>>> may be called either by the first function, or later when it's kno=
wn
>>>>>>>> that the DBI registers are available.
>>>>>>
>>>>>>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c
>>>>>>>> b/drivers/pci/controller/dwc/pcie-designware-ep.c
>>>>>>
>>>>>>>> +void dw_pcie_set_regs_available(struct dw_pcie *pci)
>>>>>>>> +{
>>>>>>>
>>>>>>> When will this function be invoked? Does the wrapper get an interru=
pt when
>>>>>>> refclk is enabled where this function will be invoked?
>>>>>>
>>>>>> Yes, there's an IRQ from the HW that indicates when PEXRST is releas=
ed. I
>>>>>> don't recall right now if this IRQ is something that exists for all =
DWC
>>>>>> instantiations, or is Tegra-specific.
>>>>>>
>>>>>>>> +=C2=A0=C2=A0=C2=A0 struct dw_pcie_ep *ep =3D &(pci->ep);
>>>>>>>> +=C2=A0=C2=A0=C2=A0 int i;
>>>>>>>> +
>>>>>>>> +=C2=A0=C2=A0=C2=A0 ep->hw_regs_not_available =3D false;
>>>>>>>
>>>>>>> This can race with epc_ops.
>>>>>>>
>>>>>>>> +
>>>>>>>> +=C2=A0=C2=A0=C2=A0 dw_pcie_ep_write_header_regs(ep);
>>>>>>>> +=C2=A0=C2=A0=C2=A0 for_each_set_bit(i, ep->ib_window_map, ep->num=
_ib_windows) {
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dw_pcie_prog_inbound_a=
tu(pci, i,
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ep->cached_inbound_atus[i].bar,
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ep->cached_inbound_atus[i].cpu_addr,
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ep->cached_inbound_atus[i].as_type);
>>>>>>>
>>>>>>> Depending on the context in which this function is invoked, program=
ming
>>>>>>> inbound/outbound ATU can also race with EPC ops.
>>>>>>  =C2=A0=C2=A0>
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dw_pcie_ep_set_bar_reg=
s(ep, 0, ep->cached_inbound_atus[i].bar);
>>>>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>>>>> +=C2=A0=C2=A0=C2=A0 for_each_set_bit(i, ep->ob_window_map, ep->num=
_ob_windows)
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dw_pcie_prog_outbound_=
atu(pci, i, PCIE_ATU_TYPE_MEM,
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ep->cached_outbound_atus[i].addr,
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ep->cached_outbound_atus[i].pci_addr,
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ep->cached_outbound_atus[i].size);
>>>>>>>> +=C2=A0=C2=A0=C2=A0 dw_pcie_dbi_ro_wr_en(pci);
>>>>>>>> +=C2=A0=C2=A0=C2=A0 dw_pcie_writew_dbi(pci, PCI_MSI_FLAGS, ep->cac=
hed_msi_flags);
>>>>>>>> +=C2=A0=C2=A0=C2=A0 dw_pcie_writew_dbi(pci, PCI_MSIX_FLAGS, ep->ca=
ched_msix_flags);
>>>>>>>> +=C2=A0=C2=A0=C2=A0 dw_pcie_dbi_ro_wr_dis(pci);
>>>>>>>
>>>>>>> IMHO we should add a new epc ops ->epc_init() which indicates if th=
e EPC is
>>>>>>> ready to be initialized or not. Only if the epc_init indicates it's=
 ready
>>>>>>> to be
>>>>>>> initialized, the endpoint function driver should go ahead with furt=
her
>>>>>>> initialization. Or else it should wait for a notification from EPC =
to
>>>>>>> indicate
>>>>>>> when it's ready to be initialized.
>>>>>>
>>>>>> (Did you mean epf op or epc op?)
>>>>>>
>>>>>> I'm not sure how exactly how that would work; do you want the DWC co=
re driver
>>>>>> or the endpoint subsystem to poll that epc op to find out when the H=
W is
>>>>>> ready to be initialized? Or do you envisage the controller driver st=
ill
>>>>>> calling dw_pcie_set_regs_available() (possibly renamed), which in tu=
rn calls
>>>>>> ->epc_init() calls for some reason?
>>>>>>
>>>>>> If you don't want to cache the endpoint configuration, perhaps you w=
ant:
>>>>>>
>>>>>> a) Endpoint function doesn't pro-actively call the endpoint controll=
er
>>>>>> functions to configure the endpoint.
>>>>>>
>>>>>> b) When endpoint HW is ready, the relevant driver calls pci_epc_read=
y() (or
>>>>>> whatever name), which lets the core know the HW can be configured. P=
erhaps
>>>>>> this schedules a work queue item to implement locking to avoid the r=
aces you
>>>>>> mentioned.
>>>>>>
>>>>>> c) Endpoint core calls pci_epf_init() which calls epf op ->init().
>>>>>>
>>>>>> One gotcha with this approach, which the caching approach helps avoi=
d:
>>>>>>
>>>>>> Once PEXRST is released, the system must respond to PCIe enumeration=
 requests
>>>>>> within 50ms. Thus, SW must very quickly respond to the IRQ indicatin=
g PEXRST
>>>>>> release and program the endpoint configuration into HW. By caching t=
he
>>>>>> configuration in the DWC driver and immediately/synchronously applyi=
ng it in
>>>>>> the PEXRST IRQ handler, we reduce the number of steps and amount of =
code
>>>>>> taken to program the HW, so it should get done pretty quickly. If in=
stead we
>>>>>> call back into the endpoint function driver's ->init() op, we run th=
e risk of
>>>>>> that op doing other stuff besides just calling the endpoint HW confi=
guration
>>>>>> APIs (e.g. perhaps the function driver defers memory buffer allocati=
on or
>>>>>> IOVA programming to that ->init function) which in turns makes it mu=
ch less
>>>>>> likely the 50ms requirement will be hit. Perhaps we can solve this b=
y naming
>>>>>> the op well and providing lots of comments, but my guess is that end=
point
>>>>>> function authors won't notice that...
>>>>>
>>>>> Kishon,
>>>>>
>>>>> Do you have any further details exactly how you'd prefer this to work=
? Does the
>>>>> approach I describe in points a/b/c above sound like what you want? T=
hanks.
>>>>
>>>> Agree with your PERST comment.
>>>>
>>>> What I have in mind is we add a new epc_init() ops. I feel there are m=
ore uses
>>>> for it (For e.g I have an internal patch which uses epc_init to initia=
lize DMA.
>>>> Hopefully I'll post it soon).
>>>> If you look at pci_epf_test, pci_epf_test_bind() is where the function=
 actually
>>>> starts to write to HW (i.e using pci_epc_*).
>>>> So before the endpoint function invokes pci_epc_write_header(), it sho=
uld
>>>> invoke epc_init(). Only if that succeeds, it should go ahead with othe=
r
>>>> initialization.
>>>> If epc_init_* fails, we can have a particular error value to indicate =
the
>>>> controller is waiting for clock from host (so that we don't return err=
or from
>>>> ->bind()). Once the controller receives the clock, it can send an atom=
ic
>>>> notification to the endpoint function driver to indicate it is ready t=
o be
>>>> initialized. (Atomic notification makes it easy to handle for multi fu=
nction
>>>> endpoint devices.)
>>>> The endpoint function can then initialize the controller.
>>>> I think except for pci_epf_test_alloc_space() all other functions are
>>>> configuring the HW (in pci_epf_test_bind). pci_epf_test_alloc_space() =
could be
>>>> moved to pci_epf_test_probe() so there are no expensive operations to =
be done
>>>> once the controller is ready to be initialized.
>>>> I have epc_init() and the atomic notification part already implemented=
 and I'm
>>>> planning to post it before next week. Once that is merged, we might ha=
ve to
>>>> reorder function in pci_epf_test driver and you have to return the cor=
rect
>>>> error value for epc_init() if the clock is not there.
>>>
>>> Kishon, did you manage to post the patches that implement epc_init()? I=
f so, a
>>> link would be appreciated. Thanks.
>>
>> I haven't posted the patches yet. Sorry for the delay. Give me some more=
 time
>> please (till next week).
>=20
> I have posted one set of cleanup for EPC features [1] by introducing
> epc_get_features(). Some of the things I initially thought should be in
> epc_init actually fits in epc_get_features. However I still believe for y=
our
> usecase we should introduce ->epc_init().

Hi Kishon,
Do you have a Work-In-Progress patch set for ->epc_init()?
If not, I would like to start working on that.

Thanks,
Vidya Sagar

>=20
> Thanks
> Kishon
>=20
> [1] -> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg18913=
93.html
>>
>> Thanks
>> Kishon
>>

