Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD7A11078C
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2019 13:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfEALnw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 May 2019 07:43:52 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:7099 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfEALnw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 May 2019 07:43:52 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cc9867e0000>; Wed, 01 May 2019 04:43:58 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 01 May 2019 04:43:51 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 01 May 2019 04:43:51 -0700
Received: from [10.24.71.111] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 1 May
 2019 11:43:47 +0000
Subject: Re: [PATCH V2 00/28] Enable Tegra PCIe root port features
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jonathanh@nvidia.com>,
        <vidyas@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20190423092825.759-1-mmaddireddy@nvidia.com>
 <20190426132219.GE16228@ulmo>
 <20190501111345.GB3100@e121166-lin.cambridge.arm.com>
X-Nvconfidentiality: public
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <30378299-cebf-146f-e207-91a2cd58419f@nvidia.com>
Date:   Wed, 1 May 2019 17:13:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190501111345.GB3100@e121166-lin.cambridge.arm.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556711038; bh=Trs7cRcdpLTIKoapd0tLrUGA85+c5Ct0IH0Ox9FXEfs=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=hlKjqUQ6JMlvL1dSQGWEqZW7/yHE1qTpGPSNzg7gHstX7zR4Fvjc9LyzJjRBCZ6r+
         rEZgEjv6+dfA//u9an7LCaLsgOYao2dnx3QrH6QZqMYMBHeQrPN78+vm1GkbMkDo5g
         pgSnaCwnuKU5NEYxHMWihKZoo4h7wj8kK7rn2UKnRWQlU+QOdB/msmYPkSgotfuRdu
         +tTxzy6iln6fqTKZoQ3prqc0jNJptn8ojLx3V0jpgXRUHC9QmfXA/NAhjuE1l6UDzo
         ul62Cm024XD2rfjwGazpVQhLRrdvyp012g/Wu9SHfWjTfyYjr+EjpVF2ZT5CvN9Kkv
         I6/UByMOTNl9A==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 01-May-19 4:43 PM, Lorenzo Pieralisi wrote:
> On Fri, Apr 26, 2019 at 03:22:19PM +0200, Thierry Reding wrote:
>> On Tue, Apr 23, 2019 at 02:57:57PM +0530, Manikanta Maddireddy wrote:
>>> This series of patches adds,
>>> - Tegra root port features like Gen2, AER, etc
>>> - Power and perf optimizations
>>> - Fixes like "power up sequence", "dev_err prints", etc
>>>
>>> This series of patches are tested on Tegra186 based Jetson-TX2, Tegra210
>>> based Jetson-TX1 and T124 based Jetson-TK1 platforms.
>>>
>>> TODO: I don't have T20 and T30 platforms to verify this series.
>>> Thierry has kindly agreed to verify this series on T20 and T30.
>> I tested this on TrimSlice and Beaver. next-20190426 boots via NFS on
>> both of those boards. Applying this series on top of next-20190426 works
>> on Beaver but does not work on TrimSlice. I'll see if I can bisect which
>> exact commit breaks this, but it seems like PCI accesses do work, since
>> I see the RTL8169 device being detected. But when the kernel tries to
>> send out DHCP requests, the packet transmission is never completed using
>> an interrupt, so maybe something interrupt related is broken.
> I have marked this series as "deferred" in patchwork, more testing
> needed from what you are reporting.
>
> Thanks,
> Lorenzo

Hi Lorenzo,

Thierry found out that missing soc flag set in 18/28 patch caused the issue.
He gave the simple patch to squash on top of 18/28.
I am waiting for review on other patches, so please mark them New.
If you prefer new version for the review, I can publish new version with the
fix.

Thanks,
Manikanta

>> Thierry
>>
>>> V2 takes care of comments from Bjorn and Thierry.
>>>
>>> Manikanta Maddireddy (28):
>>>   soc/tegra: pmc: Export tegra_powergate_power_on()
>>>   PCI: tegra: Handle failure cases in tegra_pcie_power_on()
>>>   PCI: tegra: Rearrange Tegra PCIe driver functions
>>>   PCI: tegra: Disable PCIe interrupts in runtime suspend
>>>   PCI: tegra: Fix PCIe host power up sequence
>>>   PCI: tegra: Add PCIe Gen2 link speed support
>>>   PCI: tegra: Advertise PCIe Advanced Error Reporting (AER) capability
>>>   PCI: tegra: Program UPHY electrical settings for Tegra210
>>>   PCI: tegra: Enable opportunistic UpdateFC and ACK
>>>   PCI: tegra: Disable AFI dynamic clock gating
>>>   PCI: tegra: Process pending DLL transactions before entering L1 or L2
>>>   PCI: tegra: Enable PCIe xclk clock clamping
>>>   PCI: tegra: Increase the deskew retry time
>>>   PCI: tegra: Add SW fixup for RAW violations
>>>   PCI: tegra: Update flow control timer frequency in Tegra210
>>>   PCI: tegra: Set target speed as Gen1 before starting LTSSM
>>>   PCI: tegra: Fix PLLE power down issue due to CLKREQ# signal
>>>   PCI: tegra: Program AFI_CACHE* registers only for Tegra20
>>>   PCI: tegra: Change PRSNT_SENSE irq log to debug
>>>   PCI: tegra: Use legacy irq for port service drivers
>>>   PCI: tegra: Add AFI_PEX2_CTRL reg offset as part of soc struct
>>>   PCI: tegra: Access endpoint config only if PCIe link is up
>>>   dt-bindings: pci: tegra: Document PCIe DPD pinctrl optional prop
>>>   arm64: tegra: Add PEX DPD states as pinctrl properties
>>>   PCI: tegra: Put PEX CLK & BIAS pads in DPD mode
>>>   dt-bindings: pci: tegra: Document reset-gpio optional prop
>>>   PCI: tegra: Add support for GPIO based PCIe reset
>>>   PCI: tegra: Change link retry log level to info
>>>
>>>  .../bindings/pci/nvidia,tegra20-pcie.txt      |  13 +
>>>  arch/arm64/boot/dts/nvidia/tegra210.dtsi      |  19 +
>>>  drivers/pci/controller/pci-tegra.c            | 605 +++++++++++++++---
>>>  drivers/soc/tegra/pmc.c                       |   1 +
>>>  4 files changed, 558 insertions(+), 80 deletions(-)
>>>
>>> -- 
>>> 2.17.1
>>>
>

