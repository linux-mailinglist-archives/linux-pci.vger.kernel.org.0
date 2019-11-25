Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7363B108803
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2019 05:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfKYEqG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 24 Nov 2019 23:46:06 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:47696 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbfKYEqG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 24 Nov 2019 23:46:06 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAP4juuR126494;
        Sun, 24 Nov 2019 22:45:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1574657156;
        bh=Wzx1jESaMfi6+oDwa4IY9LrI/AdCk7z8iODViWIr7tk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=O4ezwgD6Wr303rSZXMHkP5aKut8btcoTFDtxsd4ebT9KgDV03PHtQrcckaptEDnVP
         8NwNPgX8im44gJX9olkQVMEonvvo1+oNokC0uJnLos9msuHFb7sYOdWErGxO2jG4RM
         1uBGFLMoOOgDJDhSUFz2bwJXE/+2aID8P+gondi0=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAP4juLS126096;
        Sun, 24 Nov 2019 22:45:56 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Sun, 24
 Nov 2019 22:45:56 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Sun, 24 Nov 2019 22:45:56 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAP4jpB7030847;
        Sun, 24 Nov 2019 22:45:52 -0600
Subject: Re: [PATCH 0/4] Add support to defer core initialization
To:     Vidya Sagar <vidyas@nvidia.com>
CC:     Jingoo Han <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "Jisheng.Zhang@synaptics.com" <Jisheng.Zhang@synaptics.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kthota@nvidia.com" <kthota@nvidia.com>,
        "mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>,
        "sagar.tv@gmail.com" <sagar.tv@gmail.com>
References: <20191113090851.26345-1-vidyas@nvidia.com>
 <108c9f42-a595-515e-5ed6-e745a55efe70@nvidia.com>
 <SL2P216MB0105D49E39194C827D60B032AA4D0@SL2P216MB0105.KORP216.PROD.OUTLOOK.COM>
 <550dd734-acd9-802a-f650-44c32b56b58a@nvidia.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <94d5381c-5c39-b040-00a1-8333b6c73423@ti.com>
Date:   Mon, 25 Nov 2019 10:15:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <550dd734-acd9-802a-f650-44c32b56b58a@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 25/11/19 10:03 AM, Vidya Sagar wrote:
> On 11/18/2019 10:13 PM, Jingoo Han wrote:
>>
>>
>> ﻿On 11/18/19, 1:55 AM, Vidya Sagar wrote:
>>>
>>> On 11/13/2019 2:38 PM, Vidya Sagar wrote:
>>>> EPC/DesignWare core endpoint subsystems assume that the core registers are
>>>> available always for SW to initialize. But, that may not be the case always.
>>>> For example, Tegra194 hardware has the core running on a clock that is derived
>>>> from reference clock that is coming into the endpoint system from host.
>>>> Hence core is made available asynchronously based on when host system is going
>>>> for enumeration of devices. To accommodate this kind of hardwares, support is
>>>> required to defer the core initialization until the respective platform driver
>>>> informs the EPC/DWC endpoint sub-systems that the core is indeed available for
>>>> initiaization. This patch series is attempting to add precisely that.
>>>> This series is based on Kishon's patch that adds notification mechanism
>>>> support from EPC to EPF @ http://patchwork.ozlabs.org/patch/1109884/
>>>>
>>>> Vidya Sagar (4):
>>>>     PCI: dwc: Add new feature to skip core initialization
>>>>     PCI: endpoint: Add notification for core init completion
>>>>     PCI: dwc: Add API to notify core initialization completion
>>>>     PCI: pci-epf-test: Add support to defer core initialization
>>>>
>>>>    .../pci/controller/dwc/pcie-designware-ep.c   |  79 +++++++-----
>>>>    drivers/pci/controller/dwc/pcie-designware.h  |  11 ++
>>>>    drivers/pci/endpoint/functions/pci-epf-test.c | 114 ++++++++++++------
>>>>    drivers/pci/endpoint/pci-epc-core.c           |  19 ++-
>>>>    include/linux/pci-epc.h                       |   2 +
>>>>    include/linux/pci-epf.h                       |   5 +
>>>>    6 files changed, 164 insertions(+), 66 deletions(-)
>>>>
>>>
>>> Hi Kishon / Gustavo / Jingoo,
>>> Could you please take a look at this patch series?
>>
>> You need a Ack from Kishon, because he made EP code.
> Hi Kishon,
> Could you please find time to review this series?

I'll review it this week. Sorry for the delay.

-Kishon
