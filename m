Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5CEFACA3
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2019 10:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfKMJMh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Nov 2019 04:12:37 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:18638 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbfKMJMh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Nov 2019 04:12:37 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dcbc8ca0001>; Wed, 13 Nov 2019 01:11:38 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 13 Nov 2019 01:12:34 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 13 Nov 2019 01:12:34 -0800
Received: from [10.24.47.59] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 13 Nov
 2019 09:12:30 +0000
Subject: Re: [PATCH V2] PCI: dwc ep: cache config until DBI regs available
From:   Vidya Sagar <vidyas@nvidia.com>
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
 <3ec0ad68-d6e4-ae12-4247-1c2ebe00ad89@nvidia.com>
Message-ID: <3a5317ce-9c6b-1b07-d439-6b3e8d211e0c@nvidia.com>
Date:   Wed, 13 Nov 2019 14:42:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <3ec0ad68-d6e4-ae12-4247-1c2ebe00ad89@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1573636298; bh=zQ1eGrvnhcCJRGVC8BrpF1V/wZ/TlxXB7XiDyYU6UjQ=;
        h=X-PGP-Universal:Subject:From:To:CC:References:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=CdqS92vQtv7Xwh3dvx6C0cUJ4LnaXe0ryU0qT5jibxoZ3863VpipKjL6ggI7DFJlX
         tiQBwxX01FB2L+ZY2JwedP7wEYAv4ZMVWhsPpWcl8KrcpgF5wYq3qKYjQKYyMhE1gg
         1MKk2vTGrQ6irUPp5oZryhoXYXbt9GYR4ZlFNxqKGhwN9kxTLwlOQaCjYou0aCMGdR
         DR2qay/5YfXHMaMa4cD+FgojptkJxFJ2L7nfxNDm+AsnQaB2mjBESNDRFp10g59/QJ
         rblRG5OmZejMggBcJ6xtJ9nyIhsIkWh6Dgph0rmfQSKV6xqBVgrfwb2e0HoMc1ZlPu
         22tWQvrbI0t2A==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/29/2019 1:27 PM, Vidya Sagar wrote:
> On 10/29/2019 11:25 AM, Kishon Vijay Abraham I wrote:
>> Hi,
>>
>> On 25/10/19 7:20 PM, Vidya Sagar wrote:
>>> On 1/8/2019 5:35 PM, Kishon Vijay Abraham I wrote:
>>>> Hi Stephen,
>>>>
>>>> On 04/01/19 1:32 PM, Kishon Vijay Abraham I wrote:
>>>>> Hi Stephen,
>>>>>
>>>>> On 02/01/19 10:04 PM, Stephen Warren wrote:
>>>>>> On 12/19/18 7:37 AM, Kishon Vijay Abraham I wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On 14/12/18 10:31 PM, Stephen Warren wrote:
>>>>>>>> On 12/11/18 10:23 AM, Stephen Warren wrote:
>>>>>>>>> On 12/10/18 9:36 PM, Kishon Vijay Abraham I wrote:
>>>>>>>>>> Hi,
>>>>>>>>>>
>>>>>>>>>> On 27/11/18 4:39 AM, Stephen Warren wrote:
>>>>>>>>>>> From: Stephen Warren <swarren@nvidia.com>
>>>>>>>>>>>
>>>>>>>>>>> Some implementations of the DWC PCIe endpoint controller do n=
ot allow
>>>>>>>>>>> access to DBI registers until the attached host has started R=
EFCLK,
>>>>>>>>>>> released PERST, and the endpoint driver has initialized clock=
ing of the
>>>>>>>>>>> DBI registers based on that. One such system is NVIDIA's T194=
=20SoC. The
>>>>>>>>>>> PCIe endpoint subsystem and DWC driver currently don't work o=
n such
>>>>>>>>>>> hardware, since they assume that all endpoint configuration c=
an happen
>>>>>>>>>>> at any arbitrary time.
>>>>>>>>>>>
>>>>>>>>>>> Enhance the DWC endpoint driver to support such systems by ca=
ching all
>>>>>>>>>>> endpoint configuration in software, and only writing the conf=
iguration
>>>>>>>>>>> to hardware once it's been initialized. This is implemented b=
y splitting
>>>>>>>>>>> all endpoint controller ops into two functions; the first whi=
ch simply
>>>>>>>>>>> records/caches the desired configuration whenever called by t=
he
>>>>>>>>>>> associated function driver and optionally calls the second, a=
nd the
>>>>>>>>>>> second which actually programs the configuration into hardwar=
e, which
>>>>>>>>>>> may be called either by the first function, or later when it'=
s known
>>>>>>>>>>> that the DBI registers are available.
>>>>>>>>>
>>>>>>>>>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c
>>>>>>>>>>> b/drivers/pci/controller/dwc/pcie-designware-ep.c
>>>>>>>>>
>>>>>>>>>>> +void dw_pcie_set_regs_available(struct dw_pcie *pci)
>>>>>>>>>>> +{
>>>>>>>>>>
>>>>>>>>>> When will this function be invoked? Does the wrapper get an in=
terrupt when
>>>>>>>>>> refclk is enabled where this function will be invoked?
>>>>>>>>>
>>>>>>>>> Yes, there's an IRQ from the HW that indicates when PEXRST is r=
eleased. I
>>>>>>>>> don't recall right now if this IRQ is something that exists for=
=20all DWC
>>>>>>>>> instantiations, or is Tegra-specific.
>>>>>>>>>
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 struct dw_pcie_ep *ep =3D &(pci->ep);
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 int i;
>>>>>>>>>>> +
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 ep->hw_regs_not_available =3D false;
>>>>>>>>>>
>>>>>>>>>> This can race with epc_ops.
>>>>>>>>>>
>>>>>>>>>>> +
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 dw_pcie_ep_write_header_regs(ep);
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 for_each_set_bit(i, ep->ib_window_map, ep=
->num_ib_windows) {
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dw_pcie_prog_inbo=
und_atu(pci, i,
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ep->cached_inbound_atus[i].bar,
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ep->cached_inbound_atus[i].cpu_addr,
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ep->cached_inbound_atus[i].as_type);
>>>>>>>>>>
>>>>>>>>>> Depending on the context in which this function is invoked, pr=
ogramming
>>>>>>>>>> inbound/outbound ATU can also race with EPC ops.
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0>
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dw_pcie_ep_set_ba=
r_regs(ep, 0, ep->cached_inbound_atus[i].bar);
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 for_each_set_bit(i, ep->ob_window_map, ep=
->num_ob_windows)
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dw_pcie_prog_outb=
ound_atu(pci, i, PCIE_ATU_TYPE_MEM,
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ep->cached_outbound_atus[i].addr,
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ep->cached_outbound_atus[i].pci_addr,
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ep->cached_outbound_atus[i].size);
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 dw_pcie_dbi_ro_wr_en(pci);
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 dw_pcie_writew_dbi(pci, PCI_MSI_FLAGS, ep=
->cached_msi_flags);
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 dw_pcie_writew_dbi(pci, PCI_MSIX_FLAGS, e=
p->cached_msix_flags);
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 dw_pcie_dbi_ro_wr_dis(pci);
>>>>>>>>>>
>>>>>>>>>> IMHO we should add a new epc ops ->epc_init() which indicates =
if the
>>>>>>>>>> EPC is
>>>>>>>>>> ready to be initialized or not. Only if the epc_init indicates=
=20it's ready
>>>>>>>>>> to be
>>>>>>>>>> initialized, the endpoint function driver should go ahead with=
=20further
>>>>>>>>>> initialization. Or else it should wait for a notification from=
=20EPC to
>>>>>>>>>> indicate
>>>>>>>>>> when it's ready to be initialized.
>>>>>>>>>
>>>>>>>>> (Did you mean epf op or epc op?)
>>>>>>>>>
>>>>>>>>> I'm not sure how exactly how that would work; do you want the D=
WC core
>>>>>>>>> driver
>>>>>>>>> or the endpoint subsystem to poll that epc op to find out when =
the HW is
>>>>>>>>> ready to be initialized? Or do you envisage the controller driv=
er still
>>>>>>>>> calling dw_pcie_set_regs_available() (possibly renamed), which =
in turn
>>>>>>>>> calls
>>>>>>>>> ->epc_init() calls for some reason?
>>>>>>>>>
>>>>>>>>> If you don't want to cache the endpoint configuration, perhaps =
you want:
>>>>>>>>>
>>>>>>>>> a) Endpoint function doesn't pro-actively call the endpoint con=
troller
>>>>>>>>> functions to configure the endpoint.
>>>>>>>>>
>>>>>>>>> b) When endpoint HW is ready, the relevant driver calls pci_epc=
_ready() (or
>>>>>>>>> whatever name), which lets the core know the HW can be configur=
ed. Perhaps
>>>>>>>>> this schedules a work queue item to implement locking to avoid =
the races
>>>>>>>>> you
>>>>>>>>> mentioned.
>>>>>>>>>
>>>>>>>>> c) Endpoint core calls pci_epf_init() which calls epf op ->init=
().
>>>>>>>>>
>>>>>>>>> One gotcha with this approach, which the caching approach helps=
=20avoid:
>>>>>>>>>
>>>>>>>>> Once PEXRST is released, the system must respond to PCIe enumer=
ation
>>>>>>>>> requests
>>>>>>>>> within 50ms. Thus, SW must very quickly respond to the IRQ indi=
cating
>>>>>>>>> PEXRST
>>>>>>>>> release and program the endpoint configuration into HW. By cach=
ing the
>>>>>>>>> configuration in the DWC driver and immediately/synchronously a=
pplying
>>>>>>>>> it in
>>>>>>>>> the PEXRST IRQ handler, we reduce the number of steps and amoun=
t of code
>>>>>>>>> taken to program the HW, so it should get done pretty quickly. =
If
>>>>>>>>> instead we
>>>>>>>>> call back into the endpoint function driver's ->init() op, we r=
un the
>>>>>>>>> risk of
>>>>>>>>> that op doing other stuff besides just calling the endpoint HW
>>>>>>>>> configuration
>>>>>>>>> APIs (e.g. perhaps the function driver defers memory buffer all=
ocation or
>>>>>>>>> IOVA programming to that ->init function) which in turns makes =
it much less
>>>>>>>>> likely the 50ms requirement will be hit. Perhaps we can solve t=
his by
>>>>>>>>> naming
>>>>>>>>> the op well and providing lots of comments, but my guess is tha=
t endpoint
>>>>>>>>> function authors won't notice that...
>>>>>>>>
>>>>>>>> Kishon,
>>>>>>>>
>>>>>>>> Do you have any further details exactly how you'd prefer this to=
=20work?
>>>>>>>> Does the
>>>>>>>> approach I describe in points a/b/c above sound like what you wa=
nt? Thanks.
>>>>>>>
>>>>>>> Agree with your PERST comment.
>>>>>>>
>>>>>>> What I have in mind is we add a new epc_init() ops. I feel there =
are more
>>>>>>> uses
>>>>>>> for it (For e.g I have an internal patch which uses epc_init to i=
nitialize
>>>>>>> DMA.
>>>>>>> Hopefully I'll post it soon).
>>>>>>> If you look at pci_epf_test, pci_epf_test_bind() is where the fun=
ction
>>>>>>> actually
>>>>>>> starts to write to HW (i.e using pci_epc_*).
>>>>>>> So before the endpoint function invokes pci_epc_write_header(), i=
t should
>>>>>>> invoke epc_init(). Only if that succeeds, it should go ahead with=
=20other
>>>>>>> initialization.
>>>>>>> If epc_init_* fails, we can have a particular error value to indi=
cate the
>>>>>>> controller is waiting for clock from host (so that we don't retur=
n error from
>>>>>>> ->bind()). Once the controller receives the clock, it can send an=
=20atomic
>>>>>>> notification to the endpoint function driver to indicate it is re=
ady to be
>>>>>>> initialized. (Atomic notification makes it easy to handle for mul=
ti function
>>>>>>> endpoint devices.)
>>>>>>> The endpoint function can then initialize the controller.
>>>>>>> I think except for pci_epf_test_alloc_space() all other functions=
=20are
>>>>>>> configuring the HW (in pci_epf_test_bind). pci_epf_test_alloc_spa=
ce()
>>>>>>> could be
>>>>>>> moved to pci_epf_test_probe() so there are no expensive operation=
s to be done
>>>>>>> once the controller is ready to be initialized.
>>>>>>> I have epc_init() and the atomic notification part already implem=
ented and
>>>>>>> I'm
>>>>>>> planning to post it before next week. Once that is merged, we mig=
ht have to
>>>>>>> reorder function in pci_epf_test driver and you have to return th=
e correct
>>>>>>> error value for epc_init() if the clock is not there.
>>>>>>
>>>>>> Kishon, did you manage to post the patches that implement epc_init=
()? If so, a
>>>>>> link would be appreciated. Thanks.
>>>>>
>>>>> I haven't posted the patches yet. Sorry for the delay. Give me some=
=20more time
>>>>> please (till next week).
>>>>
>>>> I have posted one set of cleanup for EPC features [1] by introducing=

>>>> epc_get_features(). Some of the things I initially thought should be=
=20in
>>>> epc_init actually fits in epc_get_features. However I still believe =
for your
>>>> usecase we should introduce ->epc_init().
>>>
>>> Hi Kishon,
>>> Do you have a Work-In-Progress patch set for ->epc_init()?
>>> If not, I would like to start working on that.
>>
>> I only added epc_get_features() as it fitted better for whatever I tho=
ught
>> should be added in epc_init(). I think you can go ahead with implement=
ing
>> ->epc_init() for your usecase.Thanks.
> I'll implement and post the patches soon for review.
Hi Kishon,
I've posted patches @ http://patchwork.ozlabs.org/project/linux-pci/list/=
?series=3D142525
Please review them and provide your feedback.

Thanks,
Vidya Sagar

>=20
> - Vidya Sagar
>=20
>>
>> Thanks
>> Kishon
>>
>=20

-------------------------------------------------------------------------=
----------
This email message is for the sole use of the intended recipient(s) and m=
ay contain
confidential information.  Any unauthorized review, use, disclosure or di=
stribution
is prohibited.  If you are not the intended recipient, please contact the=
=20sender by
reply email and destroy all copies of the original message.
-------------------------------------------------------------------------=
----------
