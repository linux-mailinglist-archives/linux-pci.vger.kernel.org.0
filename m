Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7693EA9CB0
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2019 10:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731301AbfIEIOz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Sep 2019 04:14:55 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:4608 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730849AbfIEIOz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Sep 2019 04:14:55 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d70c3ff0000>; Thu, 05 Sep 2019 01:14:55 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 05 Sep 2019 01:14:54 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 05 Sep 2019 01:14:54 -0700
Received: from [10.24.45.110] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 5 Sep
 2019 08:14:49 +0000
Subject: Re: [PATCH V3 0/6] PCI: tegra: Enable PCIe C5 controller of Tegra194
 in p2972-0000 platform
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <andrew.murray@arm.com>
CC:     <kishon@ti.com>, <gustavo.pimentel@synopsys.com>,
        <digetx@gmail.com>, <mperttunen@nvidia.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20190828172850.19871-1-vidyas@nvidia.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <7751a77d-5812-49b7-0c6b-00e6740e209b@nvidia.com>
Date:   Thu, 5 Sep 2019 13:44:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828172850.19871-1-vidyas@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1567671295; bh=PhBJxOMrfevbbVmLua/ziqr5zxQ+sCG62W4DYI/Bgpo=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=faj0pebruq92ZjPws0k6DdY21Mz3rgNGoE0m7xwpk6hVdEl2wk3kMoSovWx/x/o64
         /iM7ABBr57k5e+bIUGoD/aJnbPCJnF9jW0Zhm11eY5bIDiaaCqyi8XFcQYYFK3C+VF
         m6q8GOBWo3D8uP72yBRwDZ4gDP7XlazfiGdbN2WxcnyfKCSwAN7NMDWEFWpZeahdgB
         bRmBFzQlhN9q8iCcYlnrDaYjLPj5rywGSi+DDgWQ1z9M3UVD48TMZYsuYC1zg0EEzA
         9y+e+wQYi/8W7oomavqJzHRtoOY8SzMDL23ry2TiweI5R6ejfHda+tXY3Zw9e/19uD
         T7VpBgRy94rGA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo / Bjorn,
Can you please review this series?
I have Reviewed-by and Acked-by from Rob, Thierry and Andrew already.

Thanks,
Vidya Sagar

On 8/28/2019 10:58 PM, Vidya Sagar wrote:
> This patch series enables Tegra194's C5 controller which owns x16 slot in
> p2972-0000 platform. C5 controller's PERST# and CLKREQ# are not configured as
> output and bi-directional signals by default and hence they need to be
> configured explicitly. Also, x16 slot's 3.3V and 12V supplies are controlled
> through GPIOs and hence they need to be enabled through regulator framework.
> This patch series adds required infrastructural support to address both the
> aforementioned requirements.
> Testing done on p2972-0000 platform
> - Able to enumerate devices connected to x16 slot (owned by C5 controller)
> - Enumerated device's functionality verified
> - Suspend-Resume sequence is verified with device connected to x16 slot
> 
> V3:
> * Addressed some more review comments from Andrew Murray and Thierry Reding
> 
> V2:
> * Changed the order of patches in the series for easy merging
> * Addressed review comments from Thierry Reding and Andrew Murray
> 
> Vidya Sagar (6):
>    dt-bindings: PCI: tegra: Add sideband pins configuration entries
>    dt-bindings: PCI: tegra: Add PCIe slot supplies regulator entries
>    PCI: tegra: Add support to configure sideband pins
>    PCI: tegra: Add support to enable slot regulators
>    arm64: tegra: Add configuration for PCIe C5 sideband signals
>    arm64: tegra: Add PCIe slot supply information in p2972-0000 platform
> 
>   .../bindings/pci/nvidia,tegra194-pcie.txt     | 16 ++++
>   .../arm64/boot/dts/nvidia/tegra194-p2888.dtsi | 24 +++++
>   .../boot/dts/nvidia/tegra194-p2972-0000.dts   |  4 +-
>   arch/arm64/boot/dts/nvidia/tegra194.dtsi      | 38 +++++++-
>   drivers/pci/controller/dwc/pcie-tegra194.c    | 94 ++++++++++++++++++-
>   5 files changed, 172 insertions(+), 4 deletions(-)
> 

