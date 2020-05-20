Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 911691DBC58
	for <lists+linux-pci@lfdr.de>; Wed, 20 May 2020 20:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgETSJP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 14:09:15 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:8118 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgETSJP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2020 14:09:15 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec571fb0002>; Wed, 20 May 2020 11:07:55 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 20 May 2020 11:09:14 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 20 May 2020 11:09:14 -0700
Received: from [10.25.75.122] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 20 May
 2020 18:09:11 +0000
Subject: Re: [PATCH] PCI: tegra: fix runtime pm imbalance on error
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     Dinghao Liu <dinghao.liu@zju.edu.cn>, <kjlu@umn.edu>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200520163739.GA1100601@bjorn-Precision-5520>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <e7c967a0-c285-450a-bbad-f6456c661d41@nvidia.com>
Date:   Wed, 20 May 2020 23:39:08 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200520163739.GA1100601@bjorn-Precision-5520>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1589998075; bh=EY5HqxwEqKqg5b+Jx1MhOv8T2s5ZKTI22o9MVaqGtdU=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=ThItXi9C4A38MvEvZWl6y1zxcJmFKnsGvjy+afoD88QwZmLHlTiSFnRBX8RSTOymo
         +cNmtEMeZyXZeVrsPAofXCHibv+vmtwq+TXYsF/TCwwlmHgZxXLAZQqOQzQ6YjrI96
         RTf+d7h2UmTepNBcv4kQLelDmAB/qDqrDaUPQMAFRl2f4sR7K8ndeTd8zx0HtabHw6
         EvV4rDAc8PmyJRJnHB5txgZKqirO2F0EVdtqNSLpYA07+tim+a+4JboEyiCIB873Q9
         IVjBEV25coJjCYfNQxj8VlL/I1s/0KnXazcI2uROVCdPo8Hu4arS8NPr9qCZCYd798
         JUfHT02OzScRA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks for pushing a patch to fix it. I've been under the wrong 
assumption that a failing pm_runtime_get_sync() wouldn't increment the 
usage counter.
With Thierry's and Bjorn's comments addressed

Acked-by: Vidya Sagar <vidyas@nvidia.com>

On 20-May-20 10:07 PM, Bjorn Helgaas wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Wed, May 20, 2020 at 11:59:08AM +0200, Thierry Reding wrote:
>> On Wed, May 20, 2020 at 04:52:23PM +0800, Dinghao Liu wrote:
>>> pm_runtime_get_sync() increments the runtime PM usage counter even
>>> it returns an error code. Thus a pairing decrement is needed on
>>
>> s/even it/even when it/
>>
>> Might also be a good idea to use a different subject prefix because I
>> was almost not going to look at the other patch, taking this to be a
>> replacement for it.
> 
> Amen.  This would be a good change to start using "PCI: tegra194" or
> something for pcie-tegra194.c.  Or will there be tegra195, tegra 196,
> etc added to this driver?
> 
> Also, please capitalize the first word and "PM" in the subjects:
> 
>    PCI: tegra194: Fix runtime PM imbalance on error
> 
> Bjorn
> 
