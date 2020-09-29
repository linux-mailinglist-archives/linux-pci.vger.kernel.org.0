Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C9D27D55C
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 20:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgI2SCk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 14:02:40 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12168 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbgI2SCk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Sep 2020 14:02:40 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f73768a0000>; Tue, 29 Sep 2020 11:01:46 -0700
Received: from [10.26.75.44] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 29 Sep
 2020 18:02:19 +0000
Subject: Re: [PATCH v2 0/5] PCI: dwc: improve msi handling
To:     Marc Zyngier <maz@kernel.org>
CC:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        <linux-pci@vger.kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        <linux-arm-kernel@axis.com>, Vidya Sagar <vidyas@nvidia.com>,
        Fabio Estevam <festevam@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        <linux-tegra@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Kukjin Kim <kgene@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <linux-arm-msm@vger.kernel.org>,
        "Sascha Hauer" <s.hauer@pengutronix.de>,
        Yue Wang <yue.wang@amlogic.com>,
        <linux-samsung-soc@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-amlogic@lists.infradead.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Andy Gross <agross@kernel.org>, <linux-kernel@vger.kernel.org>,
        "Stanimir Varbanov" <svarbanov@mm-sol.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>
References: <20200924190421.549cb8fc@xhacker.debian>
 <de4d9294-4f6d-c7d1-efc7-c8ef6570bd64@nvidia.com>
 <20200929184851.22682ff1@xhacker.debian>
 <8e06a370-a37a-5f33-b43b-2830adb31b3e@nvidia.com>
 <d4a6eea3c5e33a3a4056885419df95a7@kernel.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <6ead62a5-6ad5-bde8-a5df-93c0f8029f65@nvidia.com>
Date:   Tue, 29 Sep 2020 19:02:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d4a6eea3c5e33a3a4056885419df95a7@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601402506; bh=DFFoTBk7ct8iktjKeMDlsj2Utbk2NKyQWxL2aKVjTaM=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=W80lX/ssDGSCkmOHGNX8qfEHRIGTVGbYctuQLU1uEcEjyE0fnkV9wz2g53gstJyUI
         E4spYYHmwagaxJa4TO8sL06dLbzRwQ2r0mAvKv53wUNqKGfxnV3JfaTodLW7VFp50E
         IzpjML0CTcNLrRF0t2KZ6sm6PRKfBBHHCK90MeJ/+oyhR43oJQMRzJKkRWKVKPfhQW
         DwViT05UxhiaQfRiAFkxUNBjLgzRTgqifdmv2KJ8qQd4RmhXR1HisAMmb9APrvJDe6
         fdCnmmZWbJ3ZUiuMA9/5d7ErTB3BYY+MpqowblPmh6cWgZXddyMV73hexYShiBEboJ
         plJvT038Egg7Q==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 29/09/2020 18:25, Marc Zyngier wrote:
> On 2020-09-29 14:22, Jon Hunter wrote:
>> Hi Jisheng,
>>
>> On 29/09/2020 11:48, Jisheng Zhang wrote:
>>> Hi Jon,
>>>
>>> On Fri, 25 Sep 2020 09:53:45 +0100 Jon Hunter wrote:
>>>
>>>>
>>>> On 24/09/2020 12:05, Jisheng Zhang wrote:
>>>>> Improve the msi code:
>>>>> 1. Add proper error handling.
>>>>> 2. Move dw_pcie_msi_init() from each users to designware host to solv=
e
>>>>> msi page leakage in resume path.
>>>>
>>>> Apologies if this is slightly off topic, but I have been meaning to as=
k
>>>> about MSIs and PCI. On Tegra194 which uses the DWC PCI driver,
>>>> whenever we
>>>> hotplug CPUs we see the following warnings ...
>>>>
>>>> =C2=A0[=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 79.068351] WARNING KERN IRQ70: s=
et affinity failed(-22).
>>>> =C2=A0[=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 79.068362] WARNING KERN IRQ71: s=
et affinity failed(-22).
>>>>
>>>
>>> I tried to reproduce this issue on Synaptics SoC, but can't reproduce
>>> it.
>>> Per my understanding of the code in kernel/irq/cpuhotplug.c, this
>>> warning
>>> happened when we migrate irqs away from the offline cpu, this implicitl=
y
>>> implies that before this point the irq has bind to the offline cpu,
>>> but how
>>> could this happen given current dw_pci_msi_set_affinity() implementatio=
n
>>> always return -EINVAL
>>
>> By default the smp_affinity should be set so that all CPUs can be
>> interrupted ...
>>
>> $ cat /proc/irq/70/smp_affinity
>> 0xff
>>
>> In my case there are 8 CPUs and so 0xff implies that the interrupt can
>> be triggered on any of the 8 CPUs.
>>
>> Do you see the set_affinity callback being called for the DWC irqchip in
>> migrate_one_irq()?
>=20
> The problem is common to all MSI implementations that end up muxing
> all the end-point MSIs into a single interrupt. With these systems,
> you cannot set the affinity of individual MSIs (they don't target a
> CPU, they target another interrupt... braindead). Only the mux
> interrupt can have its affinity changed.
>=20
> So returning -EINVAL is the right thing to do.

Right, so if that is the case, then surely there should be some way to
avoid these warnings because they are not relevant?

Cheers
Jon

--=20
nvpublic
