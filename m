Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14C4889B7C
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2019 12:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfHLK3t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Aug 2019 06:29:49 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:14353 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbfHLK3t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Aug 2019 06:29:49 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d513f9e0000>; Mon, 12 Aug 2019 03:29:50 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 12 Aug 2019 03:29:48 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 12 Aug 2019 03:29:48 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 12 Aug
 2019 10:29:47 +0000
Received: from [10.24.47.35] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 12 Aug
 2019 10:29:41 +0000
Subject: Re: [PATCH V15 00/13] PCI: tegra: Add Tegra194 PCIe support
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <kishon@ti.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>, <digetx@gmail.com>,
        <mperttunen@nvidia.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20190809044609.20401-1-vidyas@nvidia.com>
 <20190812102519.GN8903@ulmo>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <aa666d78-43b3-dbea-dac6-386deaca3e12@nvidia.com>
Date:   Mon, 12 Aug 2019 15:59:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190812102519.GN8903@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565605790; bh=1tG5zYeqXj8gIs6w5lyT32kz+7+NUeIz90VCrmxkBbc=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=FHAqDme4CmBe+T+ICvgSDgfiTDrKnpaWceizTG4rWtUZc3n8VecOch5oN0Grc4LwZ
         53haw51XUeac/Y+r2Mq4SW5WHXTFDonCEWVJ3QpiWzjIvPGvz5gorgr/nqQwiWF6E0
         51MvK0t+bRdcIKQaZiB78sxIRC2DoTq+no9hoZqEMnfTQWCNltW0s45UwDYX1BD3M9
         ddQDztvPDkm39p/8WMZD+H0V+aPPU5645XM+DPb/Um33WDhWZpgU18ElSiEESHZcBe
         MNaZtOjnvQU2IzzBuD+hkJE2TYUgScp5lErVEEoivDQUNbfRweiJOkhT8BQwGsfdx4
         PoivvVBnBXP2Q==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/12/2019 3:55 PM, Thierry Reding wrote:
> On Fri, Aug 09, 2019 at 10:15:56AM +0530, Vidya Sagar wrote:
>> Tegra194 has six PCIe controllers based on Synopsys DesignWare core.
>> There are two Universal PHY (UPHY) blocks with each supporting 12(HSIO:
>> Hisg Speed IO) and 8(NVHS: NVIDIA High Speed) lanes respectively.
>> Controllers:0~4 use UPHY lanes from HSIO brick whereas Controller:5 uses
>> UPHY lanes from NVHS brick. Lane mapping in HSIO UPHY brick to each PCIe
>> controller (0~4) is controlled in XBAR module by BPMP-FW. Since PCIe
>> core has PIPE interface, a glue module called PIPE-to-UPHY (P2U) is used
>> to connect each UPHY lane (applicable to both HSIO and NVHS UPHY bricks)
>> to PCIe controller
>> This patch series
>> - Adds support for P2U PHY driver
>> - Adds support for PCIe host controller
>> - Adds device tree nodes each PCIe controllers
>> - Enables nodes applicable to p2972-0000 platform
>> - Adds helper APIs in Designware core driver to get capability regs offset
>> - Adds defines for new feature registers of PCIe spec revision 4
>> - Makes changes in DesignWare core driver to get Tegra194 PCIe working
>>
>> Testing done on P2972-0000 platform
>> - Able to get PCIe link up with on-board Marvel eSATA controller
>> - Able to get PCIe link up with NVMe cards connected to M.2 Key-M slot
>> - Able to do data transfers with both SATA drives and NVMe cards
>> - Able to perform suspend-resume sequence
> 
> Do you happen to have a patch for P2972-0000 PCI support? I don't see it
> in this series.
It is already merged.
V10 link @ http://patchwork.ozlabs.org/patch/1114445/

- Vidya Sagar
> 
> Thierry
> 

