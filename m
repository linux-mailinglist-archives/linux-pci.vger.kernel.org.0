Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA726A10B8
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2019 07:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbfH2FN6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Aug 2019 01:13:58 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39562 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfH2FN6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Aug 2019 01:13:58 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7T5DVQ1080368;
        Thu, 29 Aug 2019 00:13:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1567055611;
        bh=LYyFnkusAO06maJIyAoLh4uHHcHnpkVbJ8SCEW6OJlg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=xAvXEf/1vTB129pEHtXkhBGqX8JXqhzbbly6gS1T+vqU0Wn+9Yi+jY+g4E3aPNqVZ
         bs2/RdD9XzUDZalkIWDSNadfyS+dVvioyPCUIQOo99sbAAb86ZifKDpYqA2RMaxQk3
         0uTYPMDWLATmZWbjfLTy8NyNqesUw632YUQfGKm0=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7T5DVgk118886
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Aug 2019 00:13:31 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 29
 Aug 2019 00:13:31 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 29 Aug 2019 00:13:31 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7T5DOv7066185;
        Thu, 29 Aug 2019 00:13:25 -0500
Subject: Re: [PATCH v2 07/10] PCI: layerscape: Modify the MSIX to the doorbell
 way
To:     Andrew Murray <andrew.murray@arm.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.co" <lorenzo.pieralisi@arm.co>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <20190822112242.16309-1-xiaowei.bao@nxp.com>
 <20190822112242.16309-7-xiaowei.bao@nxp.com>
 <20190823135816.GH14582@e119886-lin.cambridge.arm.com>
 <AM5PR04MB3299E50BA5D7579D41B8B4F9F5A70@AM5PR04MB3299.eurprd04.prod.outlook.com>
 <20190827132504.GL14582@e119886-lin.cambridge.arm.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <e64a484c-7cf5-5f65-400c-47128ab45e52@ti.com>
Date:   Thu, 29 Aug 2019 10:43:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827132504.GL14582@e119886-lin.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Gustavo,

On 27/08/19 6:55 PM, Andrew Murray wrote:
> On Sat, Aug 24, 2019 at 12:08:40AM +0000, Xiaowei Bao wrote:
>>
>>
>>> -----Original Message-----
>>> From: Andrew Murray <andrew.murray@arm.com>
>>> Sent: 2019年8月23日 21:58
>>> To: Xiaowei Bao <xiaowei.bao@nxp.com>
>>> Cc: bhelgaas@google.com; robh+dt@kernel.org; mark.rutland@arm.com;
>>> shawnguo@kernel.org; Leo Li <leoyang.li@nxp.com>; kishon@ti.com;
>>> lorenzo.pieralisi@arm.co; arnd@arndb.de; gregkh@linuxfoundation.org; M.h.
>>> Lian <minghuan.lian@nxp.com>; Mingkai Hu <mingkai.hu@nxp.com>; Roy
>>> Zang <roy.zang@nxp.com>; jingoohan1@gmail.com;
>>> gustavo.pimentel@synopsys.com; linux-pci@vger.kernel.org;
>>> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
>>> linux-arm-kernel@lists.infradead.org; linuxppc-dev@lists.ozlabs.org
>>> Subject: Re: [PATCH v2 07/10] PCI: layerscape: Modify the MSIX to the
>>> doorbell way
>>>
>>> On Thu, Aug 22, 2019 at 07:22:39PM +0800, Xiaowei Bao wrote:
>>>> The layerscape platform use the doorbell way to trigger MSIX interrupt
>>>> in EP mode.
>>>>
>>>
>>> I have no problems with this patch, however...
>>>
>>> Are you able to add to this message a reason for why you are making this
>>> change? Did dw_pcie_ep_raise_msix_irq not work when func_no != 0? Or did
>>> it work yet dw_pcie_ep_raise_msix_irq_doorbell is more efficient?
>>
>> The fact is that, this driver is verified in ls1046a platform of NXP before, and ls1046a don't
>> support MSIX feature, so I set the msix_capable of pci_epc_features struct is false,
>> but in other platform, e.g. ls1088a, it support the MSIX feature, I verified the MSIX
>> feature in ls1088a, it is not OK, so I changed to another way. Thanks.
> 
> Right, so the existing pci-layerscape-ep.c driver never supported MSIX yet it
> erroneously had a switch case statement to call dw_pcie_ep_raise_msix_irq which
> would never get used.
> 
> Now that we're adding a platform with MSIX support the existing
> dw_pcie_ep_raise_msix_irq doesn't work (for this platform) so we are adding a
> different method.

Gustavo, can you confirm dw_pcie_ep_raise_msix_irq() works for designware as it
didn't work for both me and Xiaowei?

Thanks
Kishon
