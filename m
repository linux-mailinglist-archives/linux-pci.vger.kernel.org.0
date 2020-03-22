Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D91618EAAC
	for <lists+linux-pci@lfdr.de>; Sun, 22 Mar 2020 18:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgCVRQA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 22 Mar 2020 13:16:00 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:4620 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgCVRP7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 22 Mar 2020 13:15:59 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e779d410000>; Sun, 22 Mar 2020 10:15:45 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 22 Mar 2020 10:15:59 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 22 Mar 2020 10:15:59 -0700
Received: from [10.25.74.3] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 22 Mar
 2020 17:15:53 +0000
Subject: Re: [PATCH V5 5/5] PCI: tegra: Add support for PCIe endpoint mode in
 Tegra194
To:     Guenter Roeck <linux@roeck-us.net>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <andrew.murray@arm.com>, <kishon@ti.com>,
        <gustavo.pimentel@synopsys.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20200303181052.16134-1-vidyas@nvidia.com>
 <20200303181052.16134-6-vidyas@nvidia.com>
 <20200322145020.GA2040@roeck-us.net>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <7e6a9643-fcdb-fd80-8e84-2983975889a9@nvidia.com>
Date:   Sun, 22 Mar 2020 22:45:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200322145020.GA2040@roeck-us.net>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1584897345; bh=81yKHmaHyYQhIkyTLm3XouWH6+1+9Fc4JlQx9GW85L4=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=gFETB48tFJt3O4znt+n+8BergJZyU/hJhpkPWPbWEwB7677kL5v+g4hCX6S+pKQgV
         XmHKtxcoChOqmxXenlsxoShjUOrRnchD2riZJT3MlWURxtx+cUEet9WRbL2ocDweXQ
         8LrAplGao1MB3D8NDqDMkS5c+/hegqiJ6w/qIVczuJ484lwQq0tDK1cnGLDdPMGOa3
         X6zmpemmwLFb3trGY/Y6sGkuINsuHjIu9PJD1X5E7izg0i63z3hAjrRZlG3xXmGxjj
         xOZurhnggZUOXDlYNUwa/tlOCjAKUC1qk1jVEj4rziEWtQx5UrrhEPXBA+eVL2Z71Q
         8GlTBqlqVo46A==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/22/2020 8:20 PM, Guenter Roeck wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Tue, Mar 03, 2020 at 11:40:52PM +0530, Vidya Sagar wrote:
>> Add support for the endpoint mode of Synopsys DesignWare core based
>> dual mode PCIe controllers present in Tegra194 SoC.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> Acked-by: Thierry Reding <treding@nvidia.com>
> 
> ERROR: modpost: "dw_pcie_ep_init" [drivers/pci/controller/dwc/pcie-tegra194.ko] undefined!
> ERROR: modpost: "dw_pcie_ep_linkup" [drivers/pci/controller/dwc/pcie-tegra194.ko] undefined!
> ERROR: modpost: "dw_pcie_ep_init_notify" [drivers/pci/controller/dwc/pcie-tegra194.ko] undefined!
> ERROR: modpost: "dw_pcie_ep_init_complete" [drivers/pci/controller/dwc/pcie-tegra194.ko] undefined!
> 
> Either the symbols must be exported, or the driver's Kconfig entry must be
> bool, not tristate.
Qiujun has already posted a patch to fix it @ 
http://patchwork.ozlabs.org/patch/1258659/

Thanks,
Vidya Sagar
> 
> Guenter
> 
