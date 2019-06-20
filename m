Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD4474D4EA
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2019 19:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732493AbfFTRYp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jun 2019 13:24:45 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:11359 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732433AbfFTRY1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jun 2019 13:24:27 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d0bc1490000>; Thu, 20 Jun 2019 10:24:25 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 20 Jun 2019 10:24:25 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 20 Jun 2019 10:24:25 -0700
Received: from [10.24.70.135] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 20 Jun
 2019 17:24:21 +0000
Subject: Re: [PATCH V6 00/27] Enable Tegra PCIe root port features
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <vidyas@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20190618180206.4908-1-mmaddireddy@nvidia.com>
 <20190620164650.GB18771@e121166-lin.cambridge.arm.com>
X-Nvconfidentiality: public
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <34c8d404-1c2a-c542-4dc0-47fe9b09d331@nvidia.com>
Date:   Thu, 20 Jun 2019 22:53:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190620164650.GB18771@e121166-lin.cambridge.arm.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1561051465; bh=gAx/K89xttoGBxcXW6SxKGS7mW4iDgAhnoqrfnn5jXc=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=E/0kMQp2tU0oDT7cBF1UkIOPtywufxbb1pW1GdlXOAgnP89HXMP6VzoGIrNcsblDW
         A5iSmAAi8tIF270LcaSk0qDe3B9hH6DUDlOZLF4WJk5uaRZQDllq7BGS19PYk7twVV
         wW6Dwm/jg0jxlyoOoFA9X5ADFNbzGAbSfcDjFtkbqNj7Wyhs1D3nCpFbLqvvfm3jBN
         WhWLMxBW2vGzr+DkLkicMJnM1dPU86gmJm8klS9jBQQE3oSKcVJL0fYeHNOumrvmVS
         QKM6XmnVryNL1N7IyLVT7JiroCSg/HifpxPWLJZrxGL9S74SMZCFZIHrjlUJshRHVN
         t0TdNkx0oy4pQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 20-Jun-19 10:16 PM, Lorenzo Pieralisi wrote:
> On Tue, Jun 18, 2019 at 11:31:39PM +0530, Manikanta Maddireddy wrote:
>> This series of patches adds,
>> - Tegra root port features like Gen2, AER, etc
>> - Power and perf optimizations
>> - Fixes like "power up sequence", "dev_err prints", etc
>>
>> This series of patches are tested on Tegra186 based Jetson-TX2, Tegra210
>> based Jetson-TX1, T124 based Jetson-TK1, Tegra20 and Tegra30 platforms.
>>
>> Changes from V5 to V6:
>>   - Patch [V4, 20/27]: Replaced pcie_pme_disable_msi() with no_msi quirk
>>
>> Changes from V4 to V5:
>>  - Patch [V4, 4/28]: Added blank line before block style comment
>>  - Patch [V4, 22/28]: "Access endpoint config only if PCIe link is up"
>> patch is dropped
>>  - Patch [V4, 27/28]:
>> * Updated reset gpio toggle logic to reflect active low usage
>> * Replaced kasprintf() with devm_kasprintf()
>> * Updated commit message with more information.
>>
>> Changes from V3 to V4:
>>  - Patch [V3,27/29] is dropped
>>  - Patch [V3,28/29]: devm_gpiod_get_from_of_node() is directly used in
>>    pci-tegra driver instead of of_get_pci* wrapper function defined in
>>    Patch [V3,27/29].
>>
>> Manikanta Maddireddy (27):
>>   soc/tegra: pmc: Export tegra_powergate_power_on()
>>   PCI: tegra: Handle failure cases in tegra_pcie_power_on()
>>   PCI: tegra: Rearrange Tegra PCIe driver functions
>>   PCI: tegra: Mask AFI_INTR in runtime suspend
>>   PCI: tegra: Fix PCIe host power up sequence
>>   PCI: tegra: Add PCIe Gen2 link speed support
>>   PCI: tegra: Advertise PCIe Advanced Error Reporting (AER) capability
>>   PCI: tegra: Program UPHY electrical settings for Tegra210
>>   PCI: tegra: Enable opportunistic UpdateFC and ACK
>>   PCI: tegra: Disable AFI dynamic clock gating
>>   PCI: tegra: Process pending DLL transactions before entering L1 or L2
>>   PCI: tegra: Enable PCIe xclk clock clamping
>>   PCI: tegra: Increase the deskew retry time
>>   PCI: tegra: Add SW fixup for RAW violations
>>   PCI: tegra: Update flow control timer frequency in Tegra210
>>   PCI: tegra: Set target speed as Gen1 before starting LTSSM
>>   PCI: tegra: Fix PLLE power down issue due to CLKREQ# signal
>>   PCI: tegra: Program AFI_CACHE* registers only for Tegra20
>>   PCI: tegra: Change PRSNT_SENSE IRQ log to debug
>>   PCI: tegra: Disable MSI for Tegra PCIe root port
>>   PCI: tegra: Add AFI_PEX2_CTRL reg offset as part of soc struct
>>   dt-bindings: pci: tegra: Document PCIe DPD pinctrl optional prop
>>   arm64: tegra: Add PEX DPD states as pinctrl properties
>>   PCI: tegra: Put PEX CLK & BIAS pads in DPD mode
>>   PCI: Add DT binding for "reset-gpios" property
>>   PCI: tegra: Add support for GPIO based PERST#
>>   PCI: tegra: Change link retry log level to debug
>>
>>  .../bindings/pci/nvidia,tegra20-pcie.txt      |   8 +
>>  Documentation/devicetree/bindings/pci/pci.txt |   3 +
>>  arch/arm64/boot/dts/nvidia/tegra210.dtsi      |  19 +
>>  drivers/pci/controller/pci-tegra.c            | 578 +++++++++++++++---
>>  drivers/pci/quirks.c                          |  39 ++
>>  drivers/soc/tegra/pmc.c                       |   1 +
>>  6 files changed, 568 insertions(+), 80 deletions(-)
> Applied with exceptions discussed to pci/tegra for v5.3, please
> have a thorough look and report back if I am missing something.
>
> Thanks,
> Lorenzo

All required patches are merged.

Thank you

