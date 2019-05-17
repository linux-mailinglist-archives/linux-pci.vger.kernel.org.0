Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 531D921571
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2019 10:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbfEQIjQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 May 2019 04:39:16 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:12616 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbfEQIjP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 May 2019 04:39:15 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cde73380000>; Fri, 17 May 2019 01:39:20 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 17 May 2019 01:39:14 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 17 May 2019 01:39:14 -0700
Received: from [10.24.192.74] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 17 May
 2019 08:39:10 +0000
Subject: Re: [PATCH V4 00/28] Enable Tegra PCIe root port features
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jonathanh@nvidia.com>,
        <lorenzo.pieralisi@arm.com>, <vidyas@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20190516055307.25737-1-mmaddireddy@nvidia.com>
 <20190516131257.GA101793@google.com>
X-Nvconfidentiality: public
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <1d6b0b74-5b66-c936-a374-3a19dc7637e5@nvidia.com>
Date:   Fri, 17 May 2019 14:08:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516131257.GA101793@google.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558082360; bh=/jrQrO///siHbFc4ykM7TVozt7ZVpbBa5aVFmESL/8c=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=eBMrJzFeQwkLrPW6pIhZ3QRoBsjaWiRLFLbLhN85urszZ2rI0RMlin2ed3QAe38Jm
         7UFc01/M99lguZvcA15avzdYYH6SHAekHctZU4YYUVEOxkCuThXh9um/KwBl495FDz
         voURdvCm10KcQmDRd0QSqlFDVPxEmvcKD+/0gudx2+0p4IFWBWwrgCjj02vUhqqncM
         hg3Igw68pdAzG98I31X/2HRsnrKuGqs/SMJAHshhCSU5cRwK/Gf06yg1AxNPlXXesK
         UGu0epPe/QOFjeBlWMgIUqaRv5V/R4TMdj2VvKOm2F8KgMWnl2QxRuAYDAJ0g55mnQ
         g84eq+tD0/hZw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 16-May-19 6:42 PM, Bjorn Helgaas wrote:
> On Thu, May 16, 2019 at 11:22:39AM +0530, Manikanta Maddireddy wrote:
>> This series of patches adds,
>> - Tegra root port features like Gen2, AER, etc
>> - Power and perf optimizations
>> - Fixes like "power up sequence", "dev_err prints", etc
> Please:
>
>   1) Put the brakes on.  You posted v3 of these 30 patches on May 13
>      and v4 on May 16.  There's no hurry; the merge window is still
>      open and nothing will be added to -next until at least next week.
>      If you space these out a little, people will have time to digest
>      them.
>
>   2) Mention in the cover letter what changed between v3 and v4 so
>      people know where to spend their effort.

Reason for sending v4 quickly is because one of the patches deviated from
Rob & Thierry's comments in v2. To address this I published v4 and marked
v3 series as superseded. 

I will follow these two points from next time, meanwhile updating the
changes from v3 to v4 below,

Changes from v3 to v4:
 - Patch [V3,27/29] is dropped
 - Patch [V3,28/29]: devm_gpiod_get_from_of_node() is directly used in
   pci-tegra driver instead of of_get_pci* wrapper function defined in
   Patch [V3,27/29].

Manikanta 

>> This series of patches are tested on Tegra186 based Jetson-TX2, Tegra210
>> based Jetson-TX1, T124 based Jetson-TK1 platforms, Tegra20 and Tegra30
>> platforms.
>>
>> Manikanta Maddireddy (28):
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
>>   PCI: tegra: Use legacy IRQ for port service drivers
>>   PCI: tegra: Add AFI_PEX2_CTRL reg offset as part of soc struct
>>   PCI: tegra: Access endpoint config only if PCIe link is up
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
>>  drivers/pci/controller/pci-tegra.c            | 615 +++++++++++++++---
>>  drivers/soc/tegra/pmc.c                       |   1 +
>>  5 files changed, 566 insertions(+), 80 deletions(-)
>>
>> -- 
>> 2.17.1
>>

