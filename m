Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDE9198A36
	for <lists+linux-pci@lfdr.de>; Tue, 31 Mar 2020 04:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbgCaCzR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Mar 2020 22:55:17 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:16129 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbgCaCzR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Mar 2020 22:55:17 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e82b1070000>; Mon, 30 Mar 2020 19:55:03 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 30 Mar 2020 19:55:16 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 30 Mar 2020 19:55:16 -0700
Received: from [10.25.76.105] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 31 Mar
 2020 02:55:11 +0000
Subject: Re: [PATCH V5 5/5] PCI: tegra: Add support for PCIe endpoint mode in
 Tegra194
To:     Bjorn Helgaas <helgaas@kernel.org>, <lorenzo.pieralisi@arm.com>
CC:     <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <andrew.murray@arm.com>, <kishon@ti.com>,
        <gustavo.pimentel@synopsys.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20200330214721.GA128269@google.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <bba72560-85cc-b59b-b0e8-bfc7c7408736@nvidia.com>
Date:   Tue, 31 Mar 2020 08:25:08 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200330214721.GA128269@google.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1585623303; bh=3ahKFXsLD6s6zihW7Lrcb4QHzaeo3c4wt/u7RD8Off8=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=AXkyKXnb8indhkbOroXPMP4WQtUfPJRj34vliLWkwdB295fSHutztOclP4xtwlFIL
         VUwgXUoRhEpOTHDQsvwIfChY17yF7+xfu8J1u63hVIJm2GbtQITCYFmBe2ZGUWb0pB
         uOZ7HACkHdbHrenA5JBlytWRzMzlt91oq0+ShC6KAe2xnEHPtuNC/35wA8L07ywvh3
         uk+cm/n538EUcnSvTJREeblguG7+R12wAaSP/JNEDESPrhRK/YVS3RoKL4bKhDJOCL
         pKE18gpS5YJF5KgA7axDuGGih/TEkk3yquDARTo0LqkXG66ISy2QNblc91BhLEHEWj
         cvMTmJrwHnl/g==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/31/2020 3:17 AM, Bjorn Helgaas wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Tue, Mar 03, 2020 at 11:40:52PM +0530, Vidya Sagar wrote:
>> Add support for the endpoint mode of Synopsys DesignWare core based
>> dual mode PCIe controllers present in Tegra194 SoC.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> Acked-by: Thierry Reding <treding@nvidia.com>
>> ---
>> V5:
>> * Added Acked-by: Thierry Reding <treding@nvidia.com>
>> * Removed unwanted header file inclusion
>>
>> V4:
>> * Addressed Lorenzo's review comments
>> * Started using threaded irqs instead of kthreads
>>
>> V3:
>> * Addressed Thierry's review comments
>>
>> V2:
>> * Addressed Bjorn's review comments
>> * Made changes as part of addressing review comments for other patches
>>
>>   drivers/pci/controller/dwc/Kconfig         |  30 +-
>>   drivers/pci/controller/dwc/pcie-tegra194.c | 679 ++++++++++++++++++++-
>>   2 files changed, 691 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
>> index 0830dfcfa43a..169cde58dd92 100644
>> --- a/drivers/pci/controller/dwc/Kconfig
>> +++ b/drivers/pci/controller/dwc/Kconfig
>> @@ -248,14 +248,38 @@ config PCI_MESON
>>          implement the driver.
>>
>>   config PCIE_TEGRA194
>> -     tristate "NVIDIA Tegra194 (and later) PCIe controller"
>> +     tristate
>> +
>> +config PCIE_TEGRA194_HOST
>> +     tristate "NVIDIA Tegra194 (and later) PCIe controller - Host Mode"
>>        depends on ARCH_TEGRA_194_SOC || COMPILE_TEST
>>        depends on PCI_MSI_IRQ_DOMAIN
>>        select PCIE_DW_HOST
>>        select PHY_TEGRA194_P2U
>> +     select PCIE_TEGRA194
>> +     default y
> 
> Sorry I missed this before, but why is this "default y"?  From
> Documentation/kbuild/kconfig-language.rst:
> 
>    The default value deliberately defaults to 'n' in order to avoid
>    bloating the build. With few exceptions, new config options should
>    not change this. The intent is for "make oldconfig" to add as little
>    as possible to the config from release to release.
> 
> I do see that several other things in other drivers/pci/ Kconfig files
> are also "default y", and we should probably change some of them.  But
> I don't want to add even more unless there's a good reason.
> 
> I'm not looking for more reactions like these:
> 
> https://lore.kernel.org/r/CAHk-=wiZ24JuVehJ5sEC0UG1Gk2nvB363wO02RRsR1oEht6R9Q@mail.gmail.com
> https://lore.kernel.org/r/CA+55aFzPpuHU1Nqd595SEQS=F+kXMzPs0Rba9FUgTodGxmXsgg@mail.gmail.com
> 
> Can you please update this patch to either remove the "default y" or
> add the rationale for keeping it?
I'm fine with removing 'default y' line.
Should I send a patch only with this change?

Thanks,
Vidya Sagar
> 
>> +     help
>> +       Enables support for the PCIe controller in the NVIDIA Tegra194 SoC to
>> +       work in host mode. There are two instances of PCIe controllers in
>> +       Tegra194. This controller can work either as EP or RC. In order to
>> +       enable host-specific features PCIE_TEGRA194_HOST must be selected and
>> +       in order to enable device-specific features PCIE_TEGRA194_EP must be
>> +       selected. This uses the DesignWare core.
