Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E607215DC8
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2019 08:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfEGGzs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 May 2019 02:55:48 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:7291 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbfEGGzs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 May 2019 02:55:48 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cd12bef0000>; Mon, 06 May 2019 23:55:43 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 06 May 2019 23:55:46 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 06 May 2019 23:55:46 -0700
Received: from [10.25.73.250] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 May
 2019 06:55:42 +0000
Subject: Re: [PATCH V4 1/2] PCI: dwc: Add API support to de-initialize host
From:   Vidya Sagar <vidyas@nvidia.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <bhelgaas@google.com>, <Jisheng.Zhang@synaptics.com>,
        <thierry.reding@gmail.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20190502170426.28688-1-vidyas@nvidia.com>
 <20190503112338.GA25649@e121166-lin.cambridge.arm.com>
 <dec5ecb2-863e-a1db-10c9-2d91f860a2c6@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <37697830-5a94-0f8e-a5cf-3347bc4850cb@nvidia.com>
Date:   Tue, 7 May 2019 12:25:38 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <dec5ecb2-863e-a1db-10c9-2d91f860a2c6@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557212143; bh=H5u/1BKLyxssA+63bikg6ujCCLeHpqFPUgQ9O7l5OC4=;
        h=X-PGP-Universal:Subject:From:To:CC:References:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Ly5IINPQChix81HYPqzLWBMjTtWko+rcENjQVytAELt0g7R1nH0YPf8qFkEU5WXNQ
         5pjESc/9zg2z4Ex2toy1E2QsRTi3JBFtfp8bx5l0ynHc+rIIB/yYP9Cqe5+f+s2nih
         5vSGdPXrv5a4jjsCvN0qiLK3a7UHTKCxJKH8DT0mFeMMCHggbI6dW5vihAMk8w6eN8
         hYHcZV145htKZYNHRvW9wShW5f5HNNZEX+WT0rfSr7UdyU0QQFhadrtQCQ0GUZgDzu
         ZkJClOOI1DcR3+wn2Iks3igoqhK10luCCaE2/p3z3vZKtmawVPhYuJw/jbjmvXoCge
         kkkU70RiPgZiQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/7/2019 11:19 AM, Vidya Sagar wrote:
> On 5/3/2019 4:53 PM, Lorenzo Pieralisi wrote:
>> On Thu, May 02, 2019 at 10:34:25PM +0530, Vidya Sagar wrote:
>>> Add an API to group all the tasks to be done to de-initialize host whic=
h
>>> can then be called by any DesignWare core based driver implementations
>>> while adding .remove() support in their respective drivers.
>>>
>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>>> Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>>> ---
>>> Changes from v3:
>>> * Added check if (pci_msi_enabled() && !pp->ops->msi_host_init) before =
calling
>>> =C2=A0=C2=A0 dw_pcie_free_msi() API to mimic init path
>>>
>>> Changes from v2:
>>> * Rebased on top of linux-next top of the tree branch
>>>
>>> Changes from v1:
>>> * s/Designware/DesignWare
>>>
>>> =C2=A0 drivers/pci/controller/dwc/pcie-designware-host.c | 8 ++++++++
>>> =C2=A0 drivers/pci/controller/dwc/pcie-designware.h=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 5 +++++
>>> =C2=A0 2 files changed, 13 insertions(+)
>>
>> Series doesn't apply to v5.1-rc1, what's based on ? I suspect
>> there is a dependency on pci/keystone, given the tight timeline
>> for the merge window, would you mind postponing it to v5.3 ?
>>
>> I do not think it is urgent, I am happy to create a branch
>> for it as soon as v5.2-rc1 is released.
> I rebased my changes on top of linux-next. I see that they have conflicts
> on top of v5.1-rc1. Do you want me to rebase them on top of v5.1-rc1 inst=
ead
> of linux-next?
> I'm fine with v5.2-rc1 as well.I forgot to mention that these changes are=
 made on top of Jisheng's patches
FWIW, Jisheng's patches are approved and applied to pci/dwc for v5.2
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1968324.html

>=20
>>
>> Thanks,
>> Lorenzo
>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/driver=
s/pci/controller/dwc/pcie-designware-host.c
>>> index 77db32529319..d069e4290180 100644
>>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>>> @@ -496,6 +496,14 @@ int dw_pcie_host_init(struct pcie_port *pp)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>> =C2=A0 }
>>> +void dw_pcie_host_deinit(struct pcie_port *pp)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 pci_stop_root_bus(pp->root_bus);
>>> +=C2=A0=C2=A0=C2=A0 pci_remove_root_bus(pp->root_bus);
>>> +=C2=A0=C2=A0=C2=A0 if (pci_msi_enabled() && !pp->ops->msi_host_init)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dw_pcie_free_msi(pp);
>>> +}
>>> +
>>> =C2=A0 static int dw_pcie_access_other_conf(struct pcie_port *pp, struc=
t pci_bus *bus,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 devfn, =
int where, int size, u32 *val,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool write)
>>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci=
/controller/dwc/pcie-designware.h
>>> index deab426affd3..4f48ec78c7b9 100644
>>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>>> @@ -348,6 +348,7 @@ void dw_pcie_msi_init(struct pcie_port *pp);
>>> =C2=A0 void dw_pcie_free_msi(struct pcie_port *pp);
>>> =C2=A0 void dw_pcie_setup_rc(struct pcie_port *pp);
>>> =C2=A0 int dw_pcie_host_init(struct pcie_port *pp);
>>> +void dw_pcie_host_deinit(struct pcie_port *pp);
>>> =C2=A0 int dw_pcie_allocate_domains(struct pcie_port *pp);
>>> =C2=A0 #else
>>> =C2=A0 static inline irqreturn_t dw_handle_msi_irq(struct pcie_port *pp=
)
>>> @@ -372,6 +373,10 @@ static inline int dw_pcie_host_init(struct pcie_po=
rt *pp)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> =C2=A0 }
>>> +static inline void dw_pcie_host_deinit(struct pcie_port *pp)
>>> +{
>>> +}
>>> +
>>> =C2=A0 static inline int dw_pcie_allocate_domains(struct pcie_port *pp)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> --=20
>>> 2.17.1
>>>
>=20

