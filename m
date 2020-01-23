Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87F4B1464FF
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2020 10:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgAWJxB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jan 2020 04:53:01 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40642 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgAWJxA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jan 2020 04:53:00 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00N9qpqn104688;
        Thu, 23 Jan 2020 03:52:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579773171;
        bh=unRflK1ngAfU5idFLJ2noLbxFExfbABirG8nbGcTCE0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Fa9hI8Q4VIxzY0PjWcmAD4ySmg053bjihz0pKXesuoeBgmEIcLCYEQ5QJASXwz5k0
         w2XANSzvMgI6a32hliEUObFclPtfpxDhBZfvonUQ5vOxZnA2ZCHI9clsshMLG+fFyR
         3zj2tcoR3JYK04JwQKk6q8mWY/fWBp8dNLNCfSmM=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00N9qp0Q024537
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Jan 2020 03:52:51 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 23
 Jan 2020 03:52:50 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 23 Jan 2020 03:52:50 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00N9qiJD128288;
        Thu, 23 Jan 2020 03:52:45 -0600
Subject: Re: [PATCH V2 0/5] Add support to defer core initialization
To:     Vidya Sagar <vidyas@nvidia.com>
CC:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <andrew.murray@arm.com>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <Jisheng.Zhang@synaptics.com>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20200103100736.27627-1-vidyas@nvidia.com>
 <a8678df3-141b-51ab-b0cb-5e88c6ac91b5@nvidia.com>
 <680a58ec-5d09-3e3b-2fd6-544c32732818@nvidia.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <ca911119-da45-4cbd-b173-2ac8397fd79a@ti.com>
Date:   Thu, 23 Jan 2020 15:25:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <680a58ec-5d09-3e3b-2fd6-544c32732818@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Vidya Sagar,

On 23/01/20 2:54 pm, Vidya Sagar wrote:
> Hi Kishon,
> Apologies for pinging again. Could you please review this series?
> 
> Thanks,
> Vidya Sagar
> 
> On 1/11/2020 5:18 PM, Vidya Sagar wrote:
>> Hi Kishon,
>> Could you please review this series?
>>
>> Also, this series depends on the following change of yours
>> http://patchwork.ozlabs.org/patch/1109884/
>> Whats the plan to get this merged?

I've posted the endpoint improvements as a separate series
http://lore.kernel.org/r/20191231100331.6316-1-kishon@ti.com

I'd prefer this series gets tested by others. I'm also planning to test
this series. Sorry for the delay. I'll test review and test this series
early next week.

Thanks
Kishon

>>
>> Thanks,
>> Vidya Sagar
>>
>> On 1/3/20 3:37 PM, Vidya Sagar wrote:
>>> EPC/DesignWare core endpoint subsystems assume that the core
>>> registers are
>>> available always for SW to initialize. But, that may not be the case
>>> always.
>>> For example, Tegra194 hardware has the core running on a clock that
>>> is derived
>>> from reference clock that is coming into the endpoint system from host.
>>> Hence core is made available asynchronously based on when host system
>>> is going
>>> for enumeration of devices. To accommodate this kind of hardwares,
>>> support is
>>> required to defer the core initialization until the respective
>>> platform driver
>>> informs the EPC/DWC endpoint sub-systems that the core is indeed
>>> available for
>>> initiaization. This patch series is attempting to add precisely that.
>>> This series is based on Kishon's patch that adds notification mechanism
>>> support from EPC to EPF @ http://patchwork.ozlabs.org/patch/1109884/
>>>
>>> Vidya Sagar (5):
>>>    PCI: endpoint: Add core init notifying feature
>>>    PCI: dwc: Refactor core initialization code for EP mode
>>>    PCI: endpoint: Add notification for core init completion
>>>    PCI: dwc: Add API to notify core initialization completion
>>>    PCI: pci-epf-test: Add support to defer core initialization
>>>
>>>   .../pci/controller/dwc/pcie-designware-ep.c   |  79 +++++++-----
>>>   drivers/pci/controller/dwc/pcie-designware.h  |  11 ++
>>>   drivers/pci/endpoint/functions/pci-epf-test.c | 118 ++++++++++++------
>>>   drivers/pci/endpoint/pci-epc-core.c           |  19 ++-
>>>   include/linux/pci-epc.h                       |   2 +
>>>   include/linux/pci-epf.h                       |   5 +
>>>   6 files changed, 164 insertions(+), 70 deletions(-)
>>>
