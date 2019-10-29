Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4EBE82D1
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2019 08:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfJ2H5M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Oct 2019 03:57:12 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:1623 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfJ2H5M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Oct 2019 03:57:12 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5db7f0db0002>; Tue, 29 Oct 2019 00:57:15 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 29 Oct 2019 00:57:09 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 29 Oct 2019 00:57:09 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 29 Oct
 2019 07:57:09 +0000
Received: from [10.25.74.204] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 29 Oct
 2019 07:57:05 +0000
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
 <feaa08b7-8e22-995f-d041-93733e3513ac@nvidia.com>
 <772533c5-e661-8e77-afd1-d96cc5e78e25@ti.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <3ec0ad68-d6e4-ae12-4247-1c2ebe00ad89@nvidia.com>
Date:   Tue, 29 Oct 2019 13:27:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <772533c5-e661-8e77-afd1-d96cc5e78e25@ti.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1572335835; bh=c8zrY3pwjCF09ZeS+YDs+6w0ZyWrFW+uPbcv0eaL9V4=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=E2vcOfoZ7WoCBtEJ8YC0AUIL6nh5FlmoXMYR7fDGyUMDDPcZ2WTwtCcU2q9n7cdjM
         gp5OqC8u7nsA1KZRo/ojr2KrE14QVuzG92UGk5a3FauyP68Cgvt3rTcDf6g8c0cSSJ
         uta+9/1Oq9zPi0QhLdC/nx3JZGrnkRc82SNt+HFN+c/NSRVqp+gAsbU3EMrr9m9WbY
         Lq9f9Ger0FpOEXP5BMa8aFklH4CSKgbCghagVjRblLblMVh8/Q2Tugj3u50QkE2tFQ
         Cg4hZJs/WqU72sZ4oDwLmpjWnXPkOvEG+lsCApXNHIwMPgvf/NAbHUkkodtkKtjbyH
         li+/ZK92iAUeQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/29/2019 11:25 AM, Kishon Vijay Abraham I wrote:
> Hi,
>=20
> On 25/10/19 7:20 PM, Vidya Sagar wrote:
>> On 1/8/2019 5:35 PM, Kishon Vijay Abraham I wrote:
>>> Hi Stephen,
>>>
>>> On 04/01/19 1:32 PM, Kishon Vijay Abraham I wrote:
>>>> Hi Stephen,
>>>>
>>>> On 02/01/19 10:04 PM, Stephen Warren wrote:
>>>>> On 12/19/18 7:37 AM, Kishon Vijay Abraham I wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On 14/12/18 10:31 PM, Stephen Warren wrote:
>>>>>>> On 12/11/18 10:23 AM, Stephen Warren wrote:
>>>>>>>> On 12/10/18 9:36 PM, Kishon Vijay Abraham I wrote:
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> On 27/11/18 4:39 AM, Stephen Warren wrote:
>>>>>>>>>> From: Stephen Warren <swarren@nvidia.com>
>>>>>>>>>>
>>>>>>>>>> Some implementations of the DWC PCIe endpoint controller do not =
allow
>>>>>>>>>> access to DBI registers until the attached host has started REFC=
LK,
>>>>>>>>>> released PERST, and the endpoint driver has initialized clocking=
 of the
>>>>>>>>>> DBI registers based on that. One such system is NVIDIA's T194 So=
C. The
>>>>>>>>>> PCIe endpoint subsystem and DWC driver currently don't work on s=
uch
>>>>>>>>>> hardware, since they assume that all endpoint configuration can =
happen
>>>>>>>>>> at any arbitrary time.
>>>>>>>>>>
>>>>>>>>>> Enhance the DWC endpoint driver to support such systems by cachi=
ng all
>>>>>>>>>> endpoint configuration in software, and only writing the configu=
ration
>>>>>>>>>> to hardware once it's been initialized. This is implemented by s=
plitting
>>>>>>>>>> all endpoint controller ops into two functions; the first which =
simply
>>>>>>>>>> records/caches the desired configuration whenever called by the
>>>>>>>>>> associated function driver and optionally calls the second, and =
the
>>>>>>>>>> second which actually programs the configuration into hardware, =
which
>>>>>>>>>> may be called either by the first function, or later when it's k=
nown
>>>>>>>>>> that the DBI registers are available.
>>>>>>>>
>>>>>>>>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c
>>>>>>>>>> b/drivers/pci/controller/dwc/pcie-designware-ep.c
>>>>>>>>
>>>>>>>>>> +void dw_pcie_set_regs_available(struct dw_pcie *pci)
>>>>>>>>>> +{
>>>>>>>>>
>>>>>>>>> When will this function be invoked? Does the wrapper get an inter=
rupt when
>>>>>>>>> refclk is enabled where this function will be invoked?
>>>>>>>>
>>>>>>>> Yes, there's an IRQ from the HW that indicates when PEXRST is rele=
ased. I
>>>>>>>> don't recall right now if this IRQ is something that exists for al=
l DWC
>>>>>>>> instantiations, or is Tegra-specific.
>>>>>>>>
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 struct dw_pcie_ep *ep =3D &(pci->ep);
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 int i;
>>>>>>>>>> +
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 ep->hw_regs_not_available =3D false;
>>>>>>>>>
>>>>>>>>> This can race with epc_ops.
>>>>>>>>>
>>>>>>>>>> +
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 dw_pcie_ep_write_header_regs(ep);
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 for_each_set_bit(i, ep->ib_window_map, ep->n=
um_ib_windows) {
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dw_pcie_prog_inbound=
_atu(pci, i,
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ep->cached_inbound_atus[i].bar,
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ep->cached_inbound_atus[i].cpu_addr,
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ep->cached_inbound_atus[i].as_type);
>>>>>>>>>
>>>>>>>>> Depending on the context in which this function is invoked, progr=
amming
>>>>>>>>> inbound/outbound ATU can also race with EPC ops.
>>>>>>>>  =C2=A0=C2=A0=C2=A0>
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dw_pcie_ep_set_bar_r=
egs(ep, 0, ep->cached_inbound_atus[i].bar);
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 for_each_set_bit(i, ep->ob_window_map, ep->n=
um_ob_windows)
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dw_pcie_prog_outboun=
d_atu(pci, i, PCIE_ATU_TYPE_MEM,
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ep->cached_outbound_atus[i].addr,
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ep->cached_outbound_atus[i].pci_addr,
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ep->cached_outbound_atus[i].size);
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 dw_pcie_dbi_ro_wr_en(pci);
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 dw_pcie_writew_dbi(pci, PCI_MSI_FLAGS, ep->c=
ached_msi_flags);
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 dw_pcie_writew_dbi(pci, PCI_MSIX_FLAGS, ep->=
cached_msix_flags);
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 dw_pcie_dbi_ro_wr_dis(pci);
>>>>>>>>>
>>>>>>>>> IMHO we should add a new epc ops ->epc_init() which indicates if =
the
>>>>>>>>> EPC is
>>>>>>>>> ready to be initialized or not. Only if the epc_init indicates it=
's ready
>>>>>>>>> to be
>>>>>>>>> initialized, the endpoint function driver should go ahead with fu=
rther
>>>>>>>>> initialization. Or else it should wait for a notification from EP=
C to
>>>>>>>>> indicate
>>>>>>>>> when it's ready to be initialized.
>>>>>>>>
>>>>>>>> (Did you mean epf op or epc op?)
>>>>>>>>
>>>>>>>> I'm not sure how exactly how that would work; do you want the DWC =
core
>>>>>>>> driver
>>>>>>>> or the endpoint subsystem to poll that epc op to find out when the=
 HW is
>>>>>>>> ready to be initialized? Or do you envisage the controller driver =
still
>>>>>>>> calling dw_pcie_set_regs_available() (possibly renamed), which in =
turn
>>>>>>>> calls
>>>>>>>> ->epc_init() calls for some reason?
>>>>>>>>
>>>>>>>> If you don't want to cache the endpoint configuration, perhaps you=
 want:
>>>>>>>>
>>>>>>>> a) Endpoint function doesn't pro-actively call the endpoint contro=
ller
>>>>>>>> functions to configure the endpoint.
>>>>>>>>
>>>>>>>> b) When endpoint HW is ready, the relevant driver calls pci_epc_re=
ady() (or
>>>>>>>> whatever name), which lets the core know the HW can be configured.=
 Perhaps
>>>>>>>> this schedules a work queue item to implement locking to avoid the=
 races
>>>>>>>> you
>>>>>>>> mentioned.
>>>>>>>>
>>>>>>>> c) Endpoint core calls pci_epf_init() which calls epf op ->init().
>>>>>>>>
>>>>>>>> One gotcha with this approach, which the caching approach helps av=
oid:
>>>>>>>>
>>>>>>>> Once PEXRST is released, the system must respond to PCIe enumerati=
on
>>>>>>>> requests
>>>>>>>> within 50ms. Thus, SW must very quickly respond to the IRQ indicat=
ing
>>>>>>>> PEXRST
>>>>>>>> release and program the endpoint configuration into HW. By caching=
 the
>>>>>>>> configuration in the DWC driver and immediately/synchronously appl=
ying
>>>>>>>> it in
>>>>>>>> the PEXRST IRQ handler, we reduce the number of steps and amount o=
f code
>>>>>>>> taken to program the HW, so it should get done pretty quickly. If
>>>>>>>> instead we
>>>>>>>> call back into the endpoint function driver's ->init() op, we run =
the
>>>>>>>> risk of
>>>>>>>> that op doing other stuff besides just calling the endpoint HW
>>>>>>>> configuration
>>>>>>>> APIs (e.g. perhaps the function driver defers memory buffer alloca=
tion or
>>>>>>>> IOVA programming to that ->init function) which in turns makes it =
much less
>>>>>>>> likely the 50ms requirement will be hit. Perhaps we can solve this=
 by
>>>>>>>> naming
>>>>>>>> the op well and providing lots of comments, but my guess is that e=
ndpoint
>>>>>>>> function authors won't notice that...
>>>>>>>
>>>>>>> Kishon,
>>>>>>>
>>>>>>> Do you have any further details exactly how you'd prefer this to wo=
rk?
>>>>>>> Does the
>>>>>>> approach I describe in points a/b/c above sound like what you want?=
 Thanks.
>>>>>>
>>>>>> Agree with your PERST comment.
>>>>>>
>>>>>> What I have in mind is we add a new epc_init() ops. I feel there are=
 more
>>>>>> uses
>>>>>> for it (For e.g I have an internal patch which uses epc_init to init=
ialize
>>>>>> DMA.
>>>>>> Hopefully I'll post it soon).
>>>>>> If you look at pci_epf_test, pci_epf_test_bind() is where the functi=
on
>>>>>> actually
>>>>>> starts to write to HW (i.e using pci_epc_*).
>>>>>> So before the endpoint function invokes pci_epc_write_header(), it s=
hould
>>>>>> invoke epc_init(). Only if that succeeds, it should go ahead with ot=
her
>>>>>> initialization.
>>>>>> If epc_init_* fails, we can have a particular error value to indicat=
e the
>>>>>> controller is waiting for clock from host (so that we don't return e=
rror from
>>>>>> ->bind()). Once the controller receives the clock, it can send an at=
omic
>>>>>> notification to the endpoint function driver to indicate it is ready=
 to be
>>>>>> initialized. (Atomic notification makes it easy to handle for multi =
function
>>>>>> endpoint devices.)
>>>>>> The endpoint function can then initialize the controller.
>>>>>> I think except for pci_epf_test_alloc_space() all other functions ar=
e
>>>>>> configuring the HW (in pci_epf_test_bind). pci_epf_test_alloc_space(=
)
>>>>>> could be
>>>>>> moved to pci_epf_test_probe() so there are no expensive operations t=
o be done
>>>>>> once the controller is ready to be initialized.
>>>>>> I have epc_init() and the atomic notification part already implement=
ed and
>>>>>> I'm
>>>>>> planning to post it before next week. Once that is merged, we might =
have to
>>>>>> reorder function in pci_epf_test driver and you have to return the c=
orrect
>>>>>> error value for epc_init() if the clock is not there.
>>>>>
>>>>> Kishon, did you manage to post the patches that implement epc_init()?=
 If so, a
>>>>> link would be appreciated. Thanks.
>>>>
>>>> I haven't posted the patches yet. Sorry for the delay. Give me some mo=
re time
>>>> please (till next week).
>>>
>>> I have posted one set of cleanup for EPC features [1] by introducing
>>> epc_get_features(). Some of the things I initially thought should be in
>>> epc_init actually fits in epc_get_features. However I still believe for=
 your
>>> usecase we should introduce ->epc_init().
>>
>> Hi Kishon,
>> Do you have a Work-In-Progress patch set for ->epc_init()?
>> If not, I would like to start working on that.
>=20
> I only added epc_get_features() as it fitted better for whatever I though=
t
> should be added in epc_init(). I think you can go ahead with implementing
> ->epc_init() for your usecase.Thanks.
I'll implement and post the patches soon for review.

- Vidya Sagar

>=20
> Thanks
> Kishon
>=20

