Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB58938C40
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2019 16:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbfFGOKt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jun 2019 10:10:49 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:1800 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727840AbfFGOKt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jun 2019 10:10:49 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cfa70640000>; Fri, 07 Jun 2019 07:10:44 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 07 Jun 2019 07:10:46 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 07 Jun 2019 07:10:46 -0700
Received: from [10.25.74.159] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 7 Jun
 2019 14:10:40 +0000
Subject: Re: [PATCH V8 14/15] PCI: tegra: Add Tegra194 PCIe support
To:     Dmitry Osipenko <digetx@gmail.com>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <kishon@ti.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>
CC:     <mperttunen@nvidia.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20190526043751.12729-1-vidyas@nvidia.com>
 <20190526043751.12729-15-vidyas@nvidia.com>
 <f30e7fc6-3f64-d321-c32c-5e273115a869@gmail.com>
 <cbdac43f-32f7-c992-832b-ed40bef2375b@gmail.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <06f2f74e-d618-8688-14ae-beb4920bcbf6@nvidia.com>
Date:   Fri, 7 Jun 2019 19:40:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <cbdac43f-32f7-c992-832b-ed40bef2375b@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559916644; bh=kCVs7s3ql5eXfQ55yWGJage7yhSr4zC1epcNDEDiQoA=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=iFEBpn0KD8A+Ae9ZNga92KTXdb4eRIXGYSolKJ129/Ih0D1VroYuNzwTITR4m0AJB
         1r+6arN8Ukdw/epqAKK07/e42nCmH11KLtIC+51rgz6DmxeQ1dTBExseCXKFJIEBA6
         uAur9CD7FEeYayB+wmanCY8ksw08o4OQB78/VE23vi0QIrdUDQi/bjQkjTvulbCHsB
         aKLyXU8kv5fS8lDWRSvru8XKx+qmRfYVD3XWiK6mLx4+oa3+bTIXQXR4H8pbF3eVbd
         WHLImrSDuG6C3CVREjsuPbYC5pG530GYSWCdinsboCchx2TI+pbAmxcF767bW+Wr87
         iHohkMdb9oy+g==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/7/2019 12:22 AM, Dmitry Osipenko wrote:
> 06.06.2019 19:35, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> 26.05.2019 7:37, Vidya Sagar =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>> Add support for Synopsys DesignWare core IP based PCIe host controller
>>> present in Tegra194 SoC.
>>>
>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>>> ---
>>> Changes since [v7]:
>>> * Addressed review comments from Thierry
>>>
>>> Changes since [v6]:
>>> * Removed code around "nvidia,disable-aspm-states" DT property
>>> * Refactored code to remove code duplication
>>>
>>> Changes since [v5]:
>>> * Addressed review comments from Thierry
>>>
>>> Changes since [v4]:
>>> * None
>>>
>>> Changes since [v3]:
>>> * None
>>>
>>> Changes since [v2]:
>>> * Changed 'nvidia,init-speed' to 'nvidia,init-link-speed'
>>> * Changed 'nvidia,pex-wake' to 'nvidia,wake-gpios'
>>> * Removed .runtime_suspend() & .runtime_resume() implementations
>>>
>>> Changes since [v1]:
>>> * Made CONFIG_PCIE_TEGRA194 as 'm' by default from its previous 'y' sta=
te
>>> * Modified code as per changes made to DT documentation
>>> * Refactored code to address Bjorn & Thierry's review comments
>>> * Added goto to avoid recursion in tegra_pcie_dw_host_init() API
>>> * Merged .scan_bus() of dw_pcie_host_ops implementation to tegra_pcie_d=
w_host_init() API
>>>
>>>   drivers/pci/controller/dwc/Kconfig         |   10 +
>>>   drivers/pci/controller/dwc/Makefile        |    1 +
>>>   drivers/pci/controller/dwc/pcie-tegra194.c | 1621 +++++++++++++++++++=
+
>>>   3 files changed, 1632 insertions(+)
>>>   create mode 100644 drivers/pci/controller/dwc/pcie-tegra194.c
>>>
>>> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controlle=
r/dwc/Kconfig
>>> index a6ce1ee51b4c..884112afc11b 100644
>>> --- a/drivers/pci/controller/dwc/Kconfig
>>> +++ b/drivers/pci/controller/dwc/Kconfig
>>> @@ -220,6 +220,16 @@ config PCI_MESON
>>>   	  and therefore the driver re-uses the DesignWare core functions to
>>>   	  implement the driver.
>>>  =20
>>> +config PCIE_TEGRA194
>>> +	tristate "NVIDIA Tegra194 (and later) PCIe controller"
>>> +	depends on (TEGRA_BPMP && ARCH_TEGRA) || COMPILE_TEST
>>
>> TEGRA_BPMP will be enough here as it depends on other relevant options.
>>
>> Hence I mean:
>>
>> 	depends on TEGRA_BPMP || COMPILE_TEST
>=20
> Maybe it's worth to even change TEGRA_BPMP to ARCH_TEGRA_194_SOC.
> Although then you'll have to extend it with other platforms later on,
> but probably that's fine.
I received an explicit comment previously to make this dependent on TEGRA_B=
PMP
as the driver is using APIs to get certain jobs done by BPMP-FW. But, since
we can't boot kernel in the first place without having BPMP-FW in place, I =
think
it should be fine to make it dependent on ARCH_TEGRA_194_SOC directly.

>=20
>>
>>> +	depends on PCI_MSI_IRQ_DOMAIN
>>
>> You probably want to s/depends on/select/ PCI_MSI_IRQ_DOMAIN, don't you?
>>
>=20
> I actually looked up the PCI_MSI_IRQ_DOMAIN and it is correct in your
> case, my bad.
>=20

