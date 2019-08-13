Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC5C8ADD5
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2019 06:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbfHMEiA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Aug 2019 00:38:00 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:51800 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfHMEh7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Aug 2019 00:37:59 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7D4bfUa075008;
        Mon, 12 Aug 2019 23:37:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565671061;
        bh=FwJydpcr667N2/XPMOBcxx0wD/N0E+SUJhtqvw4Uofc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ZXoSPIGRf5bEd9CXF5888bXKA/dJVvEzd12eMCDYSiOBzIJd/NWnMSHge97ZmfqVN
         jA3URMmrInM0u4TPbHr4inRbz1sDP3l5hWoeqXrEouBhjPpUcrcUgWWTRIQ9IomKS4
         Zt2tRMZTzHzVZ8Oi58P4pW6t9AIgx3ylM/vzgs9I=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7D4bflI032016
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Aug 2019 23:37:41 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 12
 Aug 2019 23:37:40 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 12 Aug 2019 23:37:40 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7D4bZp5072921;
        Mon, 12 Aug 2019 23:37:36 -0500
Subject: Re: [PATCH 1/4] dt-bingings: PCI: Remove the num-lanes from Required
 properties
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>,
        Andrew Murray <andrew.murray@arm.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>
References: <20190812042435.25102-1-Zhiqiang.Hou@nxp.com>
 <20190812042435.25102-2-Zhiqiang.Hou@nxp.com>
 <20190812084517.GW56241@e119886-lin.cambridge.arm.com>
 <DB8PR04MB67476309D3F7E30FE35C47DF84D20@DB8PR04MB6747.eurprd04.prod.outlook.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <286ea8d2-5467-6cc2-07cb-7707db13ad1a@ti.com>
Date:   Tue, 13 Aug 2019 10:05:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <DB8PR04MB67476309D3F7E30FE35C47DF84D20@DB8PR04MB6747.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="gbk"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 13/08/19 8:37 AM, Z.q. Hou wrote:
> Hi Andrew,
> 
> Thanks a lot for your comments!
> 
>> -----Original Message-----
>> From: Andrew Murray <andrew.murray@arm.com>
>> Sent: 2019Äê8ÔÂ12ÈÕ 16:45
>> To: Z.q. Hou <zhiqiang.hou@nxp.com>
>> Cc: linux-pci@vger.kernel.org; devicetree@vger.kernel.org;
>> linux-kernel@vger.kernel.org; gustavo.pimentel@synopsys.com;
>> jingoohan1@gmail.com; bhelgaas@google.com; robh+dt@kernel.org;
>> mark.rutland@arm.com; shawnguo@kernel.org; Leo Li
>> <leoyang.li@nxp.com>; lorenzo.pieralisi@arm.com; M.h. Lian
>> <minghuan.lian@nxp.com>; Kishon Vijay Abraham I <kishon@ti.com>;
>> Gabriele Paoloni <gabriele.paoloni@huawei.com>
>> Subject: Re: [PATCH 1/4] dt-bingings: PCI: Remove the num-lanes from
>> Required properties
>>
>> On Mon, Aug 12, 2019 at 04:22:16AM +0000, Z.q. Hou wrote:
>>> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>>>
>>> The num-lanes is not a mandatory property, e.g. on FSL Layerscape
>>> SoCs, the PCIe link training is completed automatically base on the
>>> selected SerDes protocol, it doesn't need the num-lanes to set-up the
>>> link width.
>>>
>>> It has been added in the Optional properties. This patch is to remove
>>> it from the Required properties.
>>
>> For clarity, maybe this paragraph can be reworded to:
>>
>> "It is previously in both Required and Optional properties,  let's remove it
>> from the Required properties".
> 
> Agree and will change in v2.
> 
>>
>> I don't understand why this property is previously in both required and
>> optional...
>>
>> It looks like num-lanes was first made optional back in
>> 2015 and removed from the Required section (907fce090253).
>> But then re-added back into the Required section in 2017 with the adition of
>> bindings for EP mode (b12befecd7de).
>>
>> Is num-lanes actually required for EP mode?
> 
> Kishon, please help to answer this query?

It should be optional for EP too.

Thanks
Kishon
