Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6071645A2
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2020 14:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbgBSNg5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Feb 2020 08:36:57 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:11945 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbgBSNg5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Feb 2020 08:36:57 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e4d39b00000>; Wed, 19 Feb 2020 05:35:44 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 19 Feb 2020 05:36:55 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 19 Feb 2020 05:36:55 -0800
Received: from [10.24.47.202] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 19 Feb
 2020 13:36:51 +0000
Subject: Re: [PATCH V2 0/5] Add support to defer core initialization
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        <lorenzo.pieralisi@arm.com>, <andrew.murray@arm.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Milind Parab <mparab@cadence.com>
CC:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <Jisheng.Zhang@synaptics.com>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20200103100736.27627-1-vidyas@nvidia.com>
 <a8678df3-141b-51ab-b0cb-5e88c6ac91b5@nvidia.com>
 <680a58ec-5d09-3e3b-2fd6-544c32732818@nvidia.com>
 <ca911119-da45-4cbd-b173-2ac8397fd79a@ti.com>
 <b4af8353-3a56-fa31-3391-056050c0440a@ti.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <7e8dafcd-bc3f-4acc-7023-85e24bebdd94@nvidia.com>
Date:   Wed, 19 Feb 2020 19:06:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <b4af8353-3a56-fa31-3391-056050c0440a@ti.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1582119344; bh=saeAo+6CA9nP1TJZ3V+aw49+kvyess3aW/RdMbEEWdU=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=jp7782EC/XBpgy64sS1ExDLberT7kmom0+EBPoa/JwCeJ5eBcWoqvElVUL8DW/c4o
         P4iVpEXDd/7Mx4IDFG1joWasBHaG3MOlqSe+9n9FF8DvtPnqOuym4bVylqIvLAM/L+
         f3gI2Vo1PEOJvkCSdq4jsp1uKjD7inZKg7M5UxefeizVWMwXLVNGHHbumwD80AwEbS
         JNl3QToqG1MEzF3FQSdIcigF8fHyudTFK0KtXBjvZfyaCZLPVhwEHyV+jGYJrZCQFI
         PZGFgopOAcJfe0twr3LizdPO+NaTnuVUEcl/Y0ZaGwpsDhwQjDh+ViOW72J/F1hxZP
         3dn1vExWmp9vg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo, Andrew,
Kishon did rebase [1] mentioned below and removed dependencies.
New patch series is available
@ http://patchwork.ozlabs.org/project/linux-pci/list/?series=3D158088

I rebased my patches on top of this and is available for review
@ http://patchwork.ozlabs.org/project/linux-pci/list/?series=3D158959

Please let us know the way forward towards merging these patches.

Thanks,
Vidya Sagar

On 2/5/2020 12:07 PM, Kishon Vijay Abraham I wrote:
> External email: Use caution opening links or attachments
>=20
>=20
> +Tom, Milind
>=20
> Hi,
>=20
> On 23/01/20 3:25 PM, Kishon Vijay Abraham I wrote:
>> Hi Vidya Sagar,
>>
>> On 23/01/20 2:54 pm, Vidya Sagar wrote:
>>> Hi Kishon,
>>> Apologies for pinging again. Could you please review this series?
>>>
>>> Thanks,
>>> Vidya Sagar
>>>
>>> On 1/11/2020 5:18 PM, Vidya Sagar wrote:
>>>> Hi Kishon,
>>>> Could you please review this series?
>>>>
>>>> Also, this series depends on the following change of yours
>>>> http://patchwork.ozlabs.org/patch/1109884/
>>>> Whats the plan to get this merged?
>>
>> I've posted the endpoint improvements as a separate series
>> http://lore.kernel.org/r/20191231100331.6316-1-kishon@ti.com
>>
>> I'd prefer this series gets tested by others. I'm also planning to test
>> this series. Sorry for the delay. I'll test review and test this series
>> early next week.
>=20
> I tested this series with DRA7 configured in EP mode. So for the series
> itself
>=20
> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
>=20
> Tom, Can you test this series in Cadence platform?
>=20
> Lorenzo, Andrew,
>=20
> How do you want to go about merging this series? This series depends on
> [1] which in turn is dependent on two other series. If required, I can
> rebase [1] on mainline kernel and remove it's dependencies with the
> other series. That way this series and [1] could be merged. And the
> other series could be worked later. Kindly let me know.
>=20
> Thanks
> Kishon
>=20
> [1] ->
> https://lore.kernel.org/linux-pci/20191231100331.6316-1-kishon@ti.com/
>>
>> Thanks
>> Kishon
>>
>>>>
>>>> Thanks,
>>>> Vidya Sagar
>>>>
>>>> On 1/3/20 3:37 PM, Vidya Sagar wrote:
>>>>> EPC/DesignWare core endpoint subsystems assume that the core
>>>>> registers are
>>>>> available always for SW to initialize. But, that may not be the case
>>>>> always.
>>>>> For example, Tegra194 hardware has the core running on a clock that
>>>>> is derived
>>>>> from reference clock that is coming into the endpoint system from hos=
t.
>>>>> Hence core is made available asynchronously based on when host system
>>>>> is going
>>>>> for enumeration of devices. To accommodate this kind of hardwares,
>>>>> support is
>>>>> required to defer the core initialization until the respective
>>>>> platform driver
>>>>> informs the EPC/DWC endpoint sub-systems that the core is indeed
>>>>> available for
>>>>> initiaization. This patch series is attempting to add precisely that.
>>>>> This series is based on Kishon's patch that adds notification mechani=
sm
>>>>> support from EPC to EPF @ http://patchwork.ozlabs.org/patch/1109884/
>>>>>
>>>>> Vidya Sagar (5):
>>>>>     PCI: endpoint: Add core init notifying feature
>>>>>     PCI: dwc: Refactor core initialization code for EP mode
>>>>>     PCI: endpoint: Add notification for core init completion
>>>>>     PCI: dwc: Add API to notify core initialization completion
>>>>>     PCI: pci-epf-test: Add support to defer core initialization
>>>>>
>>>>>    .../pci/controller/dwc/pcie-designware-ep.c   |=C2=A0 79 +++++++--=
---
>>>>>    drivers/pci/controller/dwc/pcie-designware.h  |=C2=A0 11 ++
>>>>>    drivers/pci/endpoint/functions/pci-epf-test.c | 118 ++++++++++++--=
----
>>>>>    drivers/pci/endpoint/pci-epc-core.c           |=C2=A0 19 ++-
>>>>>    include/linux/pci-epc.h                       |=C2=A0=C2=A0 2 +
>>>>>    include/linux/pci-epf.h                       |=C2=A0=C2=A0 5 +
>>>>>    6 files changed, 164 insertions(+), 70 deletions(-)
>>>>>
