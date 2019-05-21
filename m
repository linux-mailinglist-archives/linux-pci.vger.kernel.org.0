Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A002224747
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2019 07:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725798AbfEUFG6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 May 2019 01:06:58 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:10066 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbfEUFG5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 May 2019 01:06:57 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ce3876d0001>; Mon, 20 May 2019 22:06:53 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 20 May 2019 22:06:55 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 20 May 2019 22:06:55 -0700
Received: from [10.24.47.153] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 21 May
 2019 05:06:50 +0000
Subject: Re: [PATCH V6 02/15] PCI/PME: Export pcie_pme_disable_msi() &
 pcie_pme_no_msi() APIs
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Christoph Hellwig <hch@infradead.org>, <lorenzo.pieralisi@arm.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <kishon@ti.com>, <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <mperttunen@nvidia.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20190513050626.14991-1-vidyas@nvidia.com>
 <20190513050626.14991-3-vidyas@nvidia.com>
 <20190513072539.GA27708@infradead.org>
 <3a8cea93-2aeb-e5e2-4d56-f0c6449073c3@nvidia.com>
 <20190516133426.GC101793@google.com>
 <bd08ccaa-c6ee-f966-91e4-bcd5d99d5cf2@nvidia.com>
 <20190517132453.GA30700@google.com>
 <ba611a45-9589-8dce-58e1-d99dd463265d@nvidia.com>
 <20190517185545.GB49425@google.com>
 <bf220eba-f9d7-81f3-6b75-db463c74fbfa@nvidia.com>
 <20190520175729.GC49425@google.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <367cb46a-de04-0611-f298-104ba0e74f21@nvidia.com>
Date:   Tue, 21 May 2019 10:36:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190520175729.GC49425@google.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558415213; bh=knyKhNXdRLP+OvahPZsocBnNng/ZZv1jqKbiH7iolnc=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=ePUVBCrfbSnmQ0+s5fgdpSOvDGyF9pATXeKJQht+ac3/ep9UYk0xc3yK7H82e2GgA
         4h5/NqbSmXP9Za96omNtTEi5wu8FmyEqIKtmrNBKLL7MX7fzYdVgFFcHIwO4kjkj/R
         jJPKB3S6ICvFbzDoqTau5hhimMcwijRSFwXSESd3oZ1lK63tEBHZ2Q8I31oWIueBf5
         filIwOXzWb7qnY6g8qABxLM3eMwq1W+SI3ti2PCAjVhtKeJEHpZSs3BPG4c1mN3N+4
         ts4pmnhpyYXd2mb6ubyX5JwNolFe1LcHsRrFhSew/gd48sYVSoN8EWiWgka7G4bRcQ
         C0TopmIVZJD8A==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/20/2019 11:27 PM, Bjorn Helgaas wrote:
> On Sat, May 18, 2019 at 07:28:29AM +0530, Vidya Sagar wrote:
>> On 5/18/2019 12:25 AM, Bjorn Helgaas wrote:
>>> On Fri, May 17, 2019 at 11:23:36PM +0530, Vidya Sagar wrote:
>>>> On 5/17/2019 6:54 PM, Bjorn Helgaas wrote:
>>>>> Do you have "lspci -vvxxx" output for the root ports handy?
>>>>>
>>>>> If there's some clue in the standard config space that would tell us
>>>>> that MSI works for some events but not others, we could make the PCI
>>>>> core pay attention it.  That would be the best solution because it
>>>>> wouldn't require Tegra-specific code.
>>>>
>>>> Here is the output of 'lspci vvxxx' for one of Tegra194's root ports.
>>>
>>> Thanks!
>>>
>>> This port advertises both MSI and MSI-X, and neither one is enabled.
>>> This particular port doesn't have a slot, so hotplug isn't applicable
>>> to it.
>>>
>>> But if I understand correctly, if MSI or MSI-X were enabled and the
>>> port had a slot, the port would generate MSI/MSI-X hotplug interrupts.
>>> But PME and AER events would still cause INTx interrupts (even with
>>> MSI or MSI-X enabled).
>>>
>>> Do I have that right?  I just want to make sure that the reason for
>>> PME being INTx is a permanent hardware choice and that it's not
>>> related to MSI and MSI-X currently being disabled.
>>
>> Yes. Thats right. Its hardware choice that our hardware engineers made t=
o
>> use INTx for PME instead of MSI irrespective of MSI/MSI-X enabled/disabl=
ed
>> in the root port.
>=20
> Here are more spec references that seem applicable:
>=20
>    - PCIe r4.0, sec 7.7.1.2 (Message Control Register for MSI) says:
>=20
>        MSI Enable =E2=80=93 If Set and the MSI-X Enable bit in the MSI-X
>        Message Control register (see Section 7.9.2) is Clear, the
>        Function is permitted to use MSI to request service and is
>        prohibited from using INTx interrupts.
>=20
>    - PCIe r4.0, sec 7.7.2.2 (Message Control Register for MSI-X) says:
>=20
>        MSI-X Enable =E2=80=93 If Set and the MSI Enable bit in the MSI Me=
ssage
>        Control register (see Section 6.8.1.3) is Clear, the Function is
>        permitted to use MSI-X to request service and is prohibited from
>        using INTx interrupts (if implemented).
>=20
> I read that to mean a device is prohibited from using MSI/MSI-X for
> some interrupts and INTx for others.  Since Tegra194 cannot use
> MSI/MSI-X for PME, it should use INTx for *all* interrupts.  That
> makes the MSI/MSI-X Capabilities superfluous, and they should be
> omitted.
>=20
> If we set pdev->no_msi for Tegra194, we'll avoid MSI/MSI-X completely,
> so we'll assume *all* interrupts including hotplug will be INTx.  Will
> that work?
Yes. We are fine with having all root port originated interrupts getting ge=
nerated
through INTx instead of MSI/MSI-X.

>=20

