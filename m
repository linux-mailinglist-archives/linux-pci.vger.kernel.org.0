Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81A3312F633
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2020 10:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbgACJkh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Jan 2020 04:40:37 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:1392 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgACJkg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Jan 2020 04:40:36 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e0f0be70000>; Fri, 03 Jan 2020 01:39:51 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 03 Jan 2020 01:40:35 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 03 Jan 2020 01:40:35 -0800
Received: from [10.25.72.211] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 3 Jan
 2020 09:40:30 +0000
Subject: Re: [PATCH 1/4] PCI: dwc: Add new feature to skip core initialization
To:     Kishon Vijay Abraham I <kishon@ti.com>, <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>, <lorenzo.pieralisi@arm.com>,
        <andrew.murray@arm.com>, <bhelgaas@google.com>,
        <thierry.reding@gmail.com>
CC:     <Jisheng.Zhang@synaptics.com>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20191113090851.26345-1-vidyas@nvidia.com>
 <20191113090851.26345-2-vidyas@nvidia.com>
 <47c801ab-ddec-d436-1f0d-1dd0c4980869@ti.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <0ecb49ba-e40a-f384-2c14-153e4f3ba9bb@nvidia.com>
Date:   Fri, 3 Jan 2020 15:10:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <47c801ab-ddec-d436-1f0d-1dd0c4980869@ti.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578044391; bh=OxagPO2Jgwq13WrPn4kUXTtKpWEMPFp8ZpiTyzeZtlU=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=W2h5t6fryBvkjjpoHqgqhLRhwOeiQu/DuintFtFEkNH+U1hAczaXrTbkXPHud7rKq
         6ChelU19203iWIJXqWVYDGlVAiNzAHtGabO73zi04XRDvVCYCAuObi7bi/Js4dqVt7
         1DE1VTE8qq8CkcKmZr7H/ba1/hoLbgwAsAi12lId7Xd2K7asYiN3tNgKRiwFj1wvm2
         5udEsu6Nt49uNeShqmcK0uEuZmDZnuEkrzPuzqgpplvhRZkJPfuTELpbKUrN2gywrL
         w/GG9yoWq1hI1JHyBeAU7HhPeD8t/OgcY8OVoGT3N8G1BfmrQ+ZAqemyxjCGzp86uO
         MG0dOeXyRtzOQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/5/2019 3:34 PM, Kishon Vijay Abraham I wrote:
>=20
>=20
> On 13/11/19 2:38 pm, Vidya Sagar wrote:
>> Add a new feature 'skip_core_init' that can be set by platform drivers
>> of devices that do not have their core registers available until referen=
ce
>> clock from host is available (Ex:- Tegra194) to indicate DesignWare
>> endpoint mode sub-system to not perform core registers initialization.
>> Existing dw_pcie_ep_init() is refactored and all the code that touches
>> registers is extracted to form a new API dw_pcie_ep_init_complete() that
>> can be called later by platform drivers setting 'skip_core_init' to '1'.
>=20
> No. pci_epc_features should only use constant values. This is used by fun=
ction drivers to know the controller capabilities.
Yes. I'm going to set EPC features as constant values in pcie-tegra194.c dr=
iver.
I'm going to rewrite this commit message in the next patch.
 =20
>=20
> Thanks
> Kishon
>=20
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>> =C2=A0 .../pci/controller/dwc/pcie-designware-ep.c=C2=A0=C2=A0 | 72 ++++=
+++++++--------
>> =C2=A0 drivers/pci/controller/dwc/pcie-designware.h=C2=A0 |=C2=A0 6 ++
>> =C2=A0 include/linux/pci-epc.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 1 +
>> =C2=A0 3 files changed, 51 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/p=
ci/controller/dwc/pcie-designware-ep.c
>> index 3dd2e2697294..06f4379be8a3 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
>> @@ -492,19 +492,53 @@ static unsigned int dw_pcie_ep_find_ext_capability=
(struct dw_pcie *pci, int cap)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>> -int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>> +int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
>> =C2=A0 {
>> +=C2=A0=C2=A0=C2=A0 struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
>> +=C2=A0=C2=A0=C2=A0 unsigned int offset;
>> +=C2=A0=C2=A0=C2=A0 unsigned int nbars;
>> +=C2=A0=C2=A0=C2=A0 u8 hdr_type;
>> +=C2=A0=C2=A0=C2=A0 u32 reg;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i;
>> +
>> +=C2=A0=C2=A0=C2=A0 hdr_type =3D dw_pcie_readb_dbi(pci, PCI_HEADER_TYPE)=
;
>> +=C2=A0=C2=A0=C2=A0 if (hdr_type !=3D PCI_HEADER_TYPE_NORMAL) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(pci->dev,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "PCI=
e controller is not set to EP mode (hdr_type:0x%x)!\n",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hdr_=
type);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EIO;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 ep->msi_cap =3D dw_pcie_find_capability(pci, PCI_CAP=
_ID_MSI);
>> +
>> +=C2=A0=C2=A0=C2=A0 ep->msix_cap =3D dw_pcie_find_capability(pci, PCI_CA=
P_ID_MSIX);
>> +
>> +=C2=A0=C2=A0=C2=A0 offset =3D dw_pcie_ep_find_ext_capability(pci, PCI_E=
XT_CAP_ID_REBAR);
>> +=C2=A0=C2=A0=C2=A0 if (offset) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D dw_pcie_readl_dbi(pc=
i, offset + PCI_REBAR_CTRL);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nbars =3D (reg & PCI_REBAR_C=
TRL_NBAR_MASK) >>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PCI_=
REBAR_CTRL_NBAR_SHIFT;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dw_pcie_dbi_ro_wr_en(pci);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < nbars; i++=
, offset +=3D PCI_REBAR_CTRL)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dw_p=
cie_writel_dbi(pci, offset + PCI_REBAR_CAP, 0x0);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dw_pcie_dbi_ro_wr_dis(pci);
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 dw_pcie_setup(pci);
>> +
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +}
>> +
>> +int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>> +{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>> -=C2=A0=C2=A0=C2=A0 u32 reg;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *addr;
>> -=C2=A0=C2=A0=C2=A0 u8 hdr_type;
>> -=C2=A0=C2=A0=C2=A0 unsigned int nbars;
>> -=C2=A0=C2=A0=C2=A0 unsigned int offset;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct pci_epc *epc;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dw_pcie *pci =3D to_dw_pcie_from_e=
p(ep);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device *dev =3D pci->dev;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device_node *np =3D dev->of_node;
>> +=C2=A0=C2=A0=C2=A0 const struct pci_epc_features *epc_features;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!pci->dbi_base || !pci->dbi_base2) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(dev, "dbi=
_base/dbi_base2 is not populated\n");
>> @@ -563,13 +597,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ep->ops->ep_init)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ep->ops->ep_init(=
ep);
>> -=C2=A0=C2=A0=C2=A0 hdr_type =3D dw_pcie_readb_dbi(pci, PCI_HEADER_TYPE)=
;
>> -=C2=A0=C2=A0=C2=A0 if (hdr_type !=3D PCI_HEADER_TYPE_NORMAL) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(pci->dev, "PCIe cont=
roller is not set to EP mode (hdr_type:0x%x)!\n",
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hdr_=
type);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EIO;
>> -=C2=A0=C2=A0=C2=A0 }
>> -
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D of_property_read_u8(np, "max-func=
tions", &epc->max_functions);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 epc->max_function=
s =3D 1;
>> @@ -587,23 +614,12 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(dev, "Fai=
led to reserve memory for MSI/MSI-X\n");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 ep->msi_cap =3D dw_pcie_find_capability(pci, PCI_CAP=
_ID_MSI);
>> -=C2=A0=C2=A0=C2=A0 ep->msix_cap =3D dw_pcie_find_capability(pci, PCI_CA=
P_ID_MSIX);
>> -
>> -=C2=A0=C2=A0=C2=A0 offset =3D dw_pcie_ep_find_ext_capability(pci, PCI_E=
XT_CAP_ID_REBAR);
>> -=C2=A0=C2=A0=C2=A0 if (offset) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D dw_pcie_readl_dbi(pc=
i, offset + PCI_REBAR_CTRL);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nbars =3D (reg & PCI_REBAR_C=
TRL_NBAR_MASK) >>
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PCI_=
REBAR_CTRL_NBAR_SHIFT;
>> -
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dw_pcie_dbi_ro_wr_en(pci);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < nbars; i++=
, offset +=3D PCI_REBAR_CTRL)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dw_p=
cie_writel_dbi(pci, offset + PCI_REBAR_CAP, 0x0);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dw_pcie_dbi_ro_wr_dis(pci);
>> +=C2=A0=C2=A0=C2=A0 if (ep->ops->get_features) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 epc_features =3D ep->ops->ge=
t_features(ep);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (epc_features->skip_core_=
init)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 dw_pcie_setup(pci);
>> -
>> -=C2=A0=C2=A0=C2=A0 return 0;
>> +=C2=A0=C2=A0=C2=A0 return dw_pcie_ep_init_complete(ep);
>> =C2=A0 }
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/=
controller/dwc/pcie-designware.h
>> index 5accdd6bc388..340783e9032e 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>> @@ -399,6 +399,7 @@ static inline int dw_pcie_allocate_domains(struct pc=
ie_port *pp)
>> =C2=A0 #ifdef CONFIG_PCIE_DW_EP
>> =C2=A0 void dw_pcie_ep_linkup(struct dw_pcie_ep *ep);
>> =C2=A0 int dw_pcie_ep_init(struct dw_pcie_ep *ep);
>> +int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep);
>> =C2=A0 void dw_pcie_ep_exit(struct dw_pcie_ep *ep);
>> =C2=A0 int dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u8 func_no=
);
>> =C2=A0 int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
>> @@ -416,6 +417,11 @@ static inline int dw_pcie_ep_init(struct dw_pcie_ep=
 *ep)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>> +static inline int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
>> +{
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +}
>> +
>> =C2=A0 static inline void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
>> =C2=A0 {
>> =C2=A0 }
>> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
>> index 36644ccd32ac..241e6a6f39fb 100644
>> --- a/include/linux/pci-epc.h
>> +++ b/include/linux/pci-epc.h
>> @@ -121,6 +121,7 @@ struct pci_epc_features {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0=C2=A0 bar_fixed_64bit;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64=C2=A0=C2=A0=C2=A0 bar_fixed_size[PCI_=
STD_NUM_BARS];
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t=C2=A0=C2=A0=C2=A0 align;
>> +=C2=A0=C2=A0=C2=A0 bool=C2=A0=C2=A0=C2=A0 skip_core_init;
>> =C2=A0 };
>> =C2=A0 #define to_pci_epc(device) container_of((device), struct pci_epc,=
 dev)
>>

