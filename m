Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA47E25859
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2019 21:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfEUTfJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 May 2019 15:35:09 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:14132 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbfEUTfJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 May 2019 15:35:09 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ce452eb0000>; Tue, 21 May 2019 12:35:07 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 21 May 2019 12:35:06 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 21 May 2019 12:35:06 -0700
Received: from [10.25.72.115] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 21 May
 2019 19:35:01 +0000
Subject: Re: [PATCH V7 02/15] PCI: Disable MSI for Tegra194 root port
From:   Vidya Sagar <vidyas@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <kishon@ti.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>, <mperttunen@nvidia.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20190517123846.3708-1-vidyas@nvidia.com>
 <20190517123846.3708-3-vidyas@nvidia.com> <20190521102729.GB29166@ulmo>
 <f63051b0-a220-125b-219e-25156d65ea6d@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <220fcb99-c3b5-58dc-a37a-57cbe9efa072@nvidia.com>
Date:   Wed, 22 May 2019 01:04:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <f63051b0-a220-125b-219e-25156d65ea6d@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558467307; bh=BZ2BIbzj5D7Ss2aLhzoWXgSRs8f/dBCrJl7cBh1DHuw=;
        h=X-PGP-Universal:Subject:From:To:CC:References:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Pr4XuljVobWvPLT6veT/0/GmsErJZdmsGM1t1ifHwtcsEWiKNszVBeFNivXaGp6WG
         /XfrDcL8vAj6aAb63WyGlpAjMEgAFVybAo9eaRma55mRch4OGR7qNNvr1BPO0ktTza
         FJnN6agdqSzG4cMcsZI+che0lf+S/Zw2UYeumX0MXvm2Jaz4Vz8HlY7N4WTyR1nZCP
         /HwUWL4t1SbuCFsfew2zu5pyeABkANCRPx1lKbHAJQt7HtYGgSH0zWsYM47FGlVlOI
         o7MchRfrlBKGhTM2vtQGZ9WlWg1+J5IU/83DRd6iUmv+5tibGVE+ktHnY9+yZYBacZ
         6oE0nozZhIVhg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/21/2019 10:17 PM, Vidya Sagar wrote:
> On 5/21/2019 3:57 PM, Thierry Reding wrote:
>> On Fri, May 17, 2019 at 06:08:33PM +0530, Vidya Sagar wrote:
>>> Tegra194 rootports don't generate MSI interrupts for PME events and hen=
ce
>>> MSI needs to be disabled for them to avoid root ports service drivers
>>> registering their respective ISRs with MSI interrupt.
>>>
>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>>> ---
>>> Changes since [v6]:
>>> * This is a new patch
>>>
>>> =A0 drivers/pci/quirks.c | 14 ++++++++++++++
>>> =A0 1 file changed, 14 insertions(+)
>>>
>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>>> index 0f16acc323c6..28f9a0380df5 100644
>>> --- a/drivers/pci/quirks.c
>>> +++ b/drivers/pci/quirks.c
>>> @@ -2592,6 +2592,20 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA,
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 PCI_DEVICE_ID_NVIDIA_NVENET_15,
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 nvenet_msi_disable);
>>> +/*
>>> + * Tegra194's PCIe root ports don't generate MSI interrupts for PME ev=
ents
>>> + * instead legacy interrupts are generated. Hence, to avoid service dr=
ivers
>>> + * registering their respective ISRs for MSIs, need to disable MSI int=
errupts
>>> + * for root ports.
>>> + */
>>> +static void disable_tegra194_rp_msi(struct pci_dev *dev)
>>> +{
>>> +=A0=A0=A0 dev->no_msi =3D 1;
>>> +}
>>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x1ad0, disable_tegra194=
_rp_msi);
>>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x1ad1, disable_tegra194=
_rp_msi);
>>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x1ad2, disable_tegra194=
_rp_msi);
>>> +
>>
>> Later functions in this file seem to use a more consistent naming
>> pattern, according to which the name for this would become:
>>
>> =A0=A0=A0=A0pci_quirk_nvidia_tegra194_disable_rp_msi
>>
>> Might be worth considering making this consistent.
>>
>> This could also be moved to the DWC driver to restrict this to where it
>> is needed. In either case, this seems like a good solution, so:
>>
>> Reviewed-by: Thierry Reding <treding@nvidia.com>
>>
> Ok. I'll move it to DWC driver along with name change for the quirk API.
>=20
I see that if quirk macros and API are present in pcie-tegra194.c file and =
driver is built
as a module, quirk API is not getting invoked by the system, whereas it get=
s invoked if driver
is built into kernel. Is this behavior expected? I think it is because of q=
uirk API symbol
not available as part of global quirk symbol table when driver is built as =
a module?
for now, I'm going to keep quirk macros and API in pci/quirks.c file itself=
.
