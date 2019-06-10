Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53BC13AE4C
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2019 06:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387471AbfFJEpi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Jun 2019 00:45:38 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:15394 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387457AbfFJEpi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Jun 2019 00:45:38 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cfde0720000>; Sun, 09 Jun 2019 21:45:38 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 09 Jun 2019 21:45:37 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 09 Jun 2019 21:45:37 -0700
Received: from [10.24.192.30] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 10 Jun
 2019 04:45:34 +0000
Subject: Re: [PATCH V4 00/28] Enable Tegra PCIe root port features
To:     <lorenzo.pieralisi@arm.com>
CC:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <vidyas@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20190516055307.25737-1-mmaddireddy@nvidia.com>
X-Nvconfidentiality: public
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <b7d09498-b97e-3428-02bd-ecd7c7f3e733@nvidia.com>
Date:   Mon, 10 Jun 2019 10:15:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190516055307.25737-1-mmaddireddy@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560141938; bh=FeQxk6Y7Q3iWQDKE8GqrWcSd5AwpIOFyggnY35Qf2UQ=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=W2r9PBki5XORQUfhgA6GCXTX68SweSJjbiuEzpd75Ra843jXMrP5yNqRY96mFrY91
         e/zP8FHP1DMfSgO5Toey3orz73d2KBXCYwU1l1W+1cS7yWcOd+RbmjOARjHkL1GdIW
         uZjZRyvzpwDIDW1qPZloySDaz75sntBqwlCCAtW2d+Ny3znybZqQSKtSAb48S8q6ta
         tlkAleCJWtUF63/Ttnk5n33zoMYohQ99vfrJ96uoMLyWmh/iTskEjbMZQWXUzhQfUV
         32JOuBXpSuop+KquP/hq//N/cs3SLppa78qR5UsL5leP63xsgnIy+SnqP5YhpgbPSF
         NY32mmTGkT/tg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

Thierry Ack'ed most of the patches, I am planning to address the review
comments for remaining two patches and publish V5. If you can review the
series, I will consolidate both the comments and address in V5.

Manikanta


On 16-May-19 11:22 AM, Manikanta Maddireddy wrote:
> This series of patches adds,
> - Tegra root port features like Gen2, AER, etc
> - Power and perf optimizations
> - Fixes like "power up sequence", "dev_err prints", etc
>
> This series of patches are tested on Tegra186 based Jetson-TX2, Tegra210
> based Jetson-TX1, T124 based Jetson-TK1 platforms, Tegra20 and Tegra30
> platforms.
>
> Manikanta Maddireddy (28):
>   soc/tegra: pmc: Export tegra_powergate_power_on()
>   PCI: tegra: Handle failure cases in tegra_pcie_power_on()
>   PCI: tegra: Rearrange Tegra PCIe driver functions
>   PCI: tegra: Mask AFI_INTR in runtime suspend
>   PCI: tegra: Fix PCIe host power up sequence
>   PCI: tegra: Add PCIe Gen2 link speed support
>   PCI: tegra: Advertise PCIe Advanced Error Reporting (AER) capability
>   PCI: tegra: Program UPHY electrical settings for Tegra210
>   PCI: tegra: Enable opportunistic UpdateFC and ACK
>   PCI: tegra: Disable AFI dynamic clock gating
>   PCI: tegra: Process pending DLL transactions before entering L1 or L2
>   PCI: tegra: Enable PCIe xclk clock clamping
>   PCI: tegra: Increase the deskew retry time
>   PCI: tegra: Add SW fixup for RAW violations
>   PCI: tegra: Update flow control timer frequency in Tegra210
>   PCI: tegra: Set target speed as Gen1 before starting LTSSM
>   PCI: tegra: Fix PLLE power down issue due to CLKREQ# signal
>   PCI: tegra: Program AFI_CACHE* registers only for Tegra20
>   PCI: tegra: Change PRSNT_SENSE IRQ log to debug
>   PCI: tegra: Use legacy IRQ for port service drivers
>   PCI: tegra: Add AFI_PEX2_CTRL reg offset as part of soc struct
>   PCI: tegra: Access endpoint config only if PCIe link is up
>   dt-bindings: pci: tegra: Document PCIe DPD pinctrl optional prop
>   arm64: tegra: Add PEX DPD states as pinctrl properties
>   PCI: tegra: Put PEX CLK & BIAS pads in DPD mode
>   PCI: Add DT binding for "reset-gpios" property
>   PCI: tegra: Add support for GPIO based PERST#
>   PCI: tegra: Change link retry log level to debug
>
>  .../bindings/pci/nvidia,tegra20-pcie.txt      |   8 +
>  Documentation/devicetree/bindings/pci/pci.txt |   3 +
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi      |  19 +
>  drivers/pci/controller/pci-tegra.c            | 615 +++++++++++++++---
>  drivers/soc/tegra/pmc.c                       |   1 +
>  5 files changed, 566 insertions(+), 80 deletions(-)
>

