Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 088F3138136
	for <lists+linux-pci@lfdr.de>; Sat, 11 Jan 2020 12:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbgAKLsk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Jan 2020 06:48:40 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:17847 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbgAKLsk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 11 Jan 2020 06:48:40 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e19b6010000>; Sat, 11 Jan 2020 03:48:20 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sat, 11 Jan 2020 03:48:39 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sat, 11 Jan 2020 03:48:39 -0800
Received: from [10.24.37.48] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 11 Jan
 2020 11:48:31 +0000
Subject: Re: [PATCH V2 0/5] Add support to defer core initialization
To:     <kishon@ti.com>
CC:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <andrew.murray@arm.com>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <Jisheng.Zhang@synaptics.com>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20200103100736.27627-1-vidyas@nvidia.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <a8678df3-141b-51ab-b0cb-5e88c6ac91b5@nvidia.com>
Date:   Sat, 11 Jan 2020 17:18:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200103100736.27627-1-vidyas@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578743301; bh=RUAOceUmKPprtHg2LFL1+mEXtimOSpp1oJz7N4FcNC0=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=ShxXySZM+CeMDWyMW5bSPL9P45P/J/lj3IDKjmdNZLdfCag35Qr77XXIe6XimHT15
         vfte91S74tgMY4ZwOpMXSspwc2XE9wXwHyShJ5oHBX1BVsx+1PY8Wd7eGv77GIoM1h
         9aK9DPOWPDOueM7j2uG6/CCsprPTQy6yuMmYqKZSLpzZY+fu60xt4oDKcpLygcCECl
         +4d+6A6mCSrjDavhRdbxHzW0H7cI7L4pFvLs/wWUH4E3nFQGpbl52F9IUl7oKKyqBY
         pmL1v9SuHHHV1gHsqyqnunvTqwNbbIRer7Ac/E2Vnt7ZTgWxQZ6Ns/fRl8i0DG2ACT
         jKvyeOu2f+Mcg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kishon,
Could you please review this series?

Also, this series depends on the following change of yours
http://patchwork.ozlabs.org/patch/1109884/
Whats the plan to get this merged?

Thanks,
Vidya Sagar

On 1/3/20 3:37 PM, Vidya Sagar wrote:
> EPC/DesignWare core endpoint subsystems assume that the core registers are
> available always for SW to initialize. But, that may not be the case always.
> For example, Tegra194 hardware has the core running on a clock that is derived
> from reference clock that is coming into the endpoint system from host.
> Hence core is made available asynchronously based on when host system is going
> for enumeration of devices. To accommodate this kind of hardwares, support is
> required to defer the core initialization until the respective platform driver
> informs the EPC/DWC endpoint sub-systems that the core is indeed available for
> initiaization. This patch series is attempting to add precisely that.
> This series is based on Kishon's patch that adds notification mechanism
> support from EPC to EPF @ http://patchwork.ozlabs.org/patch/1109884/
> 
> Vidya Sagar (5):
>    PCI: endpoint: Add core init notifying feature
>    PCI: dwc: Refactor core initialization code for EP mode
>    PCI: endpoint: Add notification for core init completion
>    PCI: dwc: Add API to notify core initialization completion
>    PCI: pci-epf-test: Add support to defer core initialization
> 
>   .../pci/controller/dwc/pcie-designware-ep.c   |  79 +++++++-----
>   drivers/pci/controller/dwc/pcie-designware.h  |  11 ++
>   drivers/pci/endpoint/functions/pci-epf-test.c | 118 ++++++++++++------
>   drivers/pci/endpoint/pci-epc-core.c           |  19 ++-
>   include/linux/pci-epc.h                       |   2 +
>   include/linux/pci-epf.h                       |   5 +
>   6 files changed, 164 insertions(+), 70 deletions(-)
> 
