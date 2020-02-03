Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 564F115036E
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2020 10:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbgBCJiF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Feb 2020 04:38:05 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:9364 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbgBCJiF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Feb 2020 04:38:05 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e37e9e50001>; Mon, 03 Feb 2020 01:37:41 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 03 Feb 2020 01:38:04 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 03 Feb 2020 01:38:04 -0800
Received: from [10.25.73.244] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 3 Feb
 2020 09:38:00 +0000
Subject: Re: [PATCH V2 0/5] Add support to defer core initialization
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <andrew.murray@arm.com>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <Jisheng.Zhang@synaptics.com>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20200103100736.27627-1-vidyas@nvidia.com>
 <a8678df3-141b-51ab-b0cb-5e88c6ac91b5@nvidia.com>
 <680a58ec-5d09-3e3b-2fd6-544c32732818@nvidia.com>
 <ca911119-da45-4cbd-b173-2ac8397fd79a@ti.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <ebd5fe6b-0713-a4bf-8eff-600c088d2667@nvidia.com>
Date:   Mon, 3 Feb 2020 15:07:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <ca911119-da45-4cbd-b173-2ac8397fd79a@ti.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580722661; bh=rMCJ2AUZQbRi9iswPSyGqc1LNxDxGbkp9R6e0a3YQiw=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Nj93hjhqUG9qxwhUp9zj8rDHbC8d/ESjEbYiB6by7JT+1i0/alc/tmc9LCpKHlq/y
         G8tM+4DNLygeljLsUvucqb+S45L0+U7VfXhhikcuoTKYhxrBNTtXzzdHG4fw+sN4zY
         kJWKDxn8alOFYL/uqzfd86NU0MmCNhUOfd3YaDQGWEbXNslIAECyFk/2z3mE9KNza1
         mnW91B/oHH4vqNDmI/k5sJe+EGmqiCsjCDKNBtKGXrgOzSvDbfegPPhib8ANy9BUUk
         G5iEkxLCo/hZPgpiNZw09j5iLxCu/Bp7BYeOdcURsjyqP9j9sjoSSxjTbLyo09oT+3
         IGHh6OHr/UiMA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 1/23/2020 3:25 PM, Kishon Vijay Abraham I wrote:
> External email: Use caution opening links or attachments
>=20
>=20
> Hi Vidya Sagar,
>=20
> On 23/01/20 2:54 pm, Vidya Sagar wrote:
>> Hi Kishon,
>> Apologies for pinging again. Could you please review this series?
>>
>> Thanks,
>> Vidya Sagar
>>
>> On 1/11/2020 5:18 PM, Vidya Sagar wrote:
>>> Hi Kishon,
>>> Could you please review this series?
>>>
>>> Also, this series depends on the following change of yours
>>> http://patchwork.ozlabs.org/patch/1109884/
>>> Whats the plan to get this merged?
>=20
> I've posted the endpoint improvements as a separate series
> http://lore.kernel.org/r/20191231100331.6316-1-kishon@ti.com
>=20
> I'd prefer this series gets tested by others. I'm also planning to test
> this series. Sorry for the delay. I'll test review and test this series
> early next week.
Hi Kishon,
Just wanted to know if you got time to test review my patches.

Thanks,
Vidya Sagar

>=20
> Thanks
> Kishon
>=20
>>>
>>> Thanks,
>>> Vidya Sagar
>>>
>>> On 1/3/20 3:37 PM, Vidya Sagar wrote:
>>>> EPC/DesignWare core endpoint subsystems assume that the core
>>>> registers are
>>>> available always for SW to initialize. But, that may not be the case
>>>> always.
>>>> For example, Tegra194 hardware has the core running on a clock that
>>>> is derived
>>>> from reference clock that is coming into the endpoint system from host=
.
>>>> Hence core is made available asynchronously based on when host system
>>>> is going
>>>> for enumeration of devices. To accommodate this kind of hardwares,
>>>> support is
>>>> required to defer the core initialization until the respective
>>>> platform driver
>>>> informs the EPC/DWC endpoint sub-systems that the core is indeed
>>>> available for
>>>> initiaization. This patch series is attempting to add precisely that.
>>>> This series is based on Kishon's patch that adds notification mechanis=
m
>>>> support from EPC to EPF @ http://patchwork.ozlabs.org/patch/1109884/
>>>>
>>>> Vidya Sagar (5):
>>>>     PCI: endpoint: Add core init notifying feature
>>>>     PCI: dwc: Refactor core initialization code for EP mode
>>>>     PCI: endpoint: Add notification for core init completion
>>>>     PCI: dwc: Add API to notify core initialization completion
>>>>     PCI: pci-epf-test: Add support to defer core initialization
>>>>
>>>>    .../pci/controller/dwc/pcie-designware-ep.c   |=C2=A0 79 +++++++---=
--
>>>>    drivers/pci/controller/dwc/pcie-designware.h  |=C2=A0 11 ++
>>>>    drivers/pci/endpoint/functions/pci-epf-test.c | 118 ++++++++++++---=
---
>>>>    drivers/pci/endpoint/pci-epc-core.c           |=C2=A0 19 ++-
>>>>    include/linux/pci-epc.h                       |=C2=A0=C2=A0 2 +
>>>>    include/linux/pci-epf.h                       |=C2=A0=C2=A0 5 +
>>>>    6 files changed, 164 insertions(+), 70 deletions(-)
>>>>
