Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8A9249E9F
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2019 12:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbfFRKv2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jun 2019 06:51:28 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14316 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729098AbfFRKv1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jun 2019 06:51:27 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d08c22c0000>; Tue, 18 Jun 2019 03:51:27 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 18 Jun 2019 03:51:26 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 18 Jun 2019 03:51:26 -0700
Received: from [10.24.47.153] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Jun
 2019 10:51:20 +0000
Subject: Re: [PATCH V4 1/2] PCI: dwc: Add API support to de-initialize host
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <bhelgaas@google.com>, <Jisheng.Zhang@synaptics.com>,
        <thierry.reding@gmail.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20190502170426.28688-1-vidyas@nvidia.com>
 <20190503112338.GA25649@e121166-lin.cambridge.arm.com>
 <dec5ecb2-863e-a1db-10c9-2d91f860a2c6@nvidia.com>
 <37697830-5a94-0f8e-a5cf-3347bc4850cb@nvidia.com>
 <b560f3c3-b69e-d9b5-2dae-1ede52af0ea6@nvidia.com>
 <011b52b6-9fcd-8930-1313-6b546226c7b9@nvidia.com>
 <8a6696e0-fc53-2e6b-536b-d1d2668e0f21@nvidia.com>
 <07c3dd04-cfd0-2d52-5917-25d0e40ad00b@nvidia.com>
 <20190618093657.GA30711@e121166-lin.cambridge.arm.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <eb0e5b1e-7e91-4dc6-681f-b497f087c62d@nvidia.com>
Date:   Tue, 18 Jun 2019 16:21:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190618093657.GA30711@e121166-lin.cambridge.arm.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560855087; bh=tG4QOMCAspIJNcVTt0o+6AE2E9v26du6/Osbyzw3Ero=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Do+3w9cmJXI1PPoTM/iqHat60dVQ/xUotKkdurD2eRlRzJ2v3Pw5PjRmzL9wX1BFW
         ueGD9gP38RR9x+aGbYLB+DqoW/dx/LXX6+kNjaTzxqiyvYFr0Ms2XGhPWHaxkxtqcN
         tWc3vb0y/S/iGx8BWE7X0bUN57eKOz5f16BrUhwuGTboqrZfOf8OoQ2um/ZaOuBXXt
         21gSF1XdqYe2BwnyGobRztw56KBcScNYtHnVvPPoUIQjGQAByDfeFFys/4UJGNf1Cw
         nhpFfPa2Yz4ARWBeo5Z9ihMwbNdscOPog0mMIJiKNOBsCnuk0w8gAbGlSMMVEvKxQa
         NoEoaQdWHMZZw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/18/2019 3:06 PM, Lorenzo Pieralisi wrote:
> On Tue, Jun 18, 2019 at 10:19:14AM +0530, Vidya Sagar wrote:
>=20
> [...]
>=20
>> Sorry for pinging again. Please let me know if these patches need to
>> be sent again.
>=20
> No problem. We can merge the code as-is even though I have a couple
> of questions.
>=20
> 1) What about dbi2 interfaces (what an horrible name it is :() ? It
>     is true that it is probably best to export just what we need.
I see that dbi2 API (that too only write) is used by pci-keystone and it
is described as a bool driver currently. I'm not sure if it will ever be
made as a modular driver.

> 2) It is not related to this patch but I fail to see the reasoning
>     behind the __ in __dw_pci_read_dbi(), there is no no-underscore
>     equivalent so its definition is somewhat questionable, maybe
>     we should clean-it up (for dbi2 alike).
Separate no-underscore versions are present in pcie-designware.h for each w=
idth
(i.e. l/w/b) as inline and are calling __ versions passing size as argument=
.

>=20
> Lorenzo
>=20
>> Thanks,
>> Vidya Sagar
>>
>>>
>>>>
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Lorenzo
>>>>>>>>
>>>>>>>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/=
drivers/pci/controller/dwc/pcie-designware-host.c
>>>>>>>>> index 77db32529319..d069e4290180 100644
>>>>>>>>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>>>>>>>>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>>>>>>>>> @@ -496,6 +496,14 @@ int dw_pcie_host_init(struct pcie_port *pp)
>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>>>>>>>>  =C2=A0 }
>>>>>>>>> +void dw_pcie_host_deinit(struct pcie_port *pp)
>>>>>>>>> +{
>>>>>>>>> +=C2=A0=C2=A0=C2=A0 pci_stop_root_bus(pp->root_bus);
>>>>>>>>> +=C2=A0=C2=A0=C2=A0 pci_remove_root_bus(pp->root_bus);
>>>>>>>>> +=C2=A0=C2=A0=C2=A0 if (pci_msi_enabled() && !pp->ops->msi_host_i=
nit)
>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dw_pcie_free_msi(pp);
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>>  =C2=A0 static int dw_pcie_access_other_conf(struct pcie_port *pp=
, struct pci_bus *bus,
>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 d=
evfn, int where, int size, u32 *val,
>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool =
write)
>>>>>>>>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drive=
rs/pci/controller/dwc/pcie-designware.h
>>>>>>>>> index deab426affd3..4f48ec78c7b9 100644
>>>>>>>>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>>>>>>>>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>>>>>>>>> @@ -348,6 +348,7 @@ void dw_pcie_msi_init(struct pcie_port *pp);
>>>>>>>>>  =C2=A0 void dw_pcie_free_msi(struct pcie_port *pp);
>>>>>>>>>  =C2=A0 void dw_pcie_setup_rc(struct pcie_port *pp);
>>>>>>>>>  =C2=A0 int dw_pcie_host_init(struct pcie_port *pp);
>>>>>>>>> +void dw_pcie_host_deinit(struct pcie_port *pp);
>>>>>>>>>  =C2=A0 int dw_pcie_allocate_domains(struct pcie_port *pp);
>>>>>>>>>  =C2=A0 #else
>>>>>>>>>  =C2=A0 static inline irqreturn_t dw_handle_msi_irq(struct pcie_p=
ort *pp)
>>>>>>>>> @@ -372,6 +373,10 @@ static inline int dw_pcie_host_init(struct p=
cie_port *pp)
>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>>>>>>>  =C2=A0 }
>>>>>>>>> +static inline void dw_pcie_host_deinit(struct pcie_port *pp)
>>>>>>>>> +{
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>>  =C2=A0 static inline int dw_pcie_allocate_domains(struct pcie_po=
rt *pp)
>>>>>>>>>  =C2=A0 {
>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>>>>>>> --=20
>>>>>>>>> 2.17.1
>>>>>>>>>
>>>>>>>
>>>>>>
>>>>>
>>>>
>>>
>>

