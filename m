Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1484FFEDE
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2019 07:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfKRGzt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Nov 2019 01:55:49 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:9841 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbfKRGzt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Nov 2019 01:55:49 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dd240750000>; Sun, 17 Nov 2019 22:55:49 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 17 Nov 2019 22:55:48 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 17 Nov 2019 22:55:48 -0800
Received: from [10.25.74.243] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 18 Nov
 2019 06:55:45 +0000
Subject: Re: [PATCH 0/4] Add support to defer core initialization
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <andrew.murray@arm.com>,
        <bhelgaas@google.com>, <kishon@ti.com>, <thierry.reding@gmail.com>
CC:     <Jisheng.Zhang@synaptics.com>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20191113090851.26345-1-vidyas@nvidia.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <108c9f42-a595-515e-5ed6-e745a55efe70@nvidia.com>
Date:   Mon, 18 Nov 2019 12:25:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191113090851.26345-1-vidyas@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1574060149; bh=IJes9iG/B6AHc+jIWOW04FFs9oNl+rLxj6+oJvMhU3A=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=TCf95B17/9wedEdemqTyTcvqMieaA6nyAgQ0eIQLr+blsEQ+VREEF8mH836Fo2Wdb
         43KTqeR4t2XH4v5b7u9LM2d0tc89ULNbOpYOIOwHUKchdUexKU600jOrG9CO1T4HTY
         QMnNpH0z82TN2wkFk9SOsPiceFrtdMcgiTZ6KcLo22eYXlj2bGT8kNh9Vy07tj4ogH
         8r8OYmiDHN/owMopJOtXmDAdUpYlEa8L5KJidyw6Nmhlrb1eFpCAOzOUT1f/SqOMaN
         btQRZ3h9sHo1bTCxx9tfnLNba8Yrm6D3kuNH8Hh7fxi0KtgCGJmBOa5qTmWT9HUpZH
         NkcXa90BsZoww==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/13/2019 2:38 PM, Vidya Sagar wrote:
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
> Vidya Sagar (4):
>    PCI: dwc: Add new feature to skip core initialization
>    PCI: endpoint: Add notification for core init completion
>    PCI: dwc: Add API to notify core initialization completion
>    PCI: pci-epf-test: Add support to defer core initialization
> 
>   .../pci/controller/dwc/pcie-designware-ep.c   |  79 +++++++-----
>   drivers/pci/controller/dwc/pcie-designware.h  |  11 ++
>   drivers/pci/endpoint/functions/pci-epf-test.c | 114 ++++++++++++------
>   drivers/pci/endpoint/pci-epc-core.c           |  19 ++-
>   include/linux/pci-epc.h                       |   2 +
>   include/linux/pci-epf.h                       |   5 +
>   6 files changed, 164 insertions(+), 66 deletions(-)
> 

Hi Kishon / Gustavo / Jingoo,
Could you please take a look at this patch series?

- Vidya Sagar
