Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3ADC293667
	for <lists+linux-pci@lfdr.de>; Tue, 20 Oct 2020 10:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbgJTIIE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Oct 2020 04:08:04 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45778 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728807AbgJTIIE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Oct 2020 04:08:04 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09K87q5W050301;
        Tue, 20 Oct 2020 03:07:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1603181272;
        bh=TS5AoPVV1Gz5Y30jd5xdWJlQjaCcpnodCnfamrTG5IA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Hue27uv5bcWUKWp508j+p0ooMMqNQL4OO2WLEDrPCOggqVXwr8050WkTtHj1XwJKE
         C468UtwZV3B1Z/CTYvlxFjx48xLImJZUfAklHSGbyRxoKSwb28ykWKRDvW4dmV36bp
         gizleSzKCHcs8yKKLiArCTKWxcEerv+x6u7Ze2fY=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09K87qG7080464
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Oct 2020 03:07:52 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 20
 Oct 2020 03:07:51 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 20 Oct 2020 03:07:52 -0500
Received: from [10.250.234.189] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09K87QtZ048612;
        Tue, 20 Oct 2020 03:07:30 -0500
Subject: Re: [PATCH] PCI: dwc: Added link up check in map_bus of
 dw_child_pcie_ops
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
CC:     Rob Herring <robh@kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michael Walle <michael@walle.cc>,
        Ard Biesheuvel <ardb@kernel.org>
References: <CAL_JsqLdQY_DqpduaTv4hMDM_-cvZ_+s8W+HdOuZVVYjTO4yxw@mail.gmail.com>
 <HE1PR0402MB337180458625B05D1529535384390@HE1PR0402MB3371.eurprd04.prod.outlook.com>
 <20200928093911.GB12010@e121166-lin.cambridge.arm.com>
 <HE1PR0402MB33713A623A37D08AE3253DEB84320@HE1PR0402MB3371.eurprd04.prod.outlook.com>
 <DM5PR12MB1276D80424F88F8A9243D5E2DA320@DM5PR12MB1276.namprd12.prod.outlook.com>
 <CAL_JsqJJxq2jZzbzZffsrPxnoLJdWLLS-7bG-vaqyqs5NkQhHQ@mail.gmail.com>
 <9ac53f04-f2e8-c5f9-e1f7-e54270ec55a0@ti.com>
 <CAL_JsqJEp8yyctJYUjHM4Ti6ggPb4ouYM_WDvpj_PiobnAozBw@mail.gmail.com>
 <67ac959f-561e-d1a0-2d89-9a85d5f92c72@ti.com>
 <HE1PR0402MB3371684F1578E953F881CE5484070@HE1PR0402MB3371.eurprd04.prod.outlook.com>
 <20201019161311.GA9813@e121166-lin.cambridge.arm.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <55d655b2-ff61-e721-33de-0d3b2e693291@ti.com>
Date:   Tue, 20 Oct 2020 13:37:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201019161311.GA9813@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On 19/10/20 9:43 pm, Lorenzo Pieralisi wrote:
> On Mon, Oct 12, 2020 at 04:41:11AM +0000, Z.q. Hou wrote:
> 
> [...]
> 
>>>>> Yeah, I don't see any registers in the DRA7x PCIe wrapper for
>>>>> disabling error forwarding.
>>>>
>>>> It's a DWC port logic register AFAICT, but perhaps not present in all
>>> versions.
>>>
>>> Okay. I see there's a register PCIECTRL_PL_AXIS_SLV_ERR_RESP which has a
>>> reset value of 0.
>>>
>>> It has four bit-fields, RESET_TIMEOUT_ERR_MAP, NO_VID_ERR_MAP,
>>> DBI_ERR_MAP and SLAVE_ERR_MAP. I'm not seeing any difference in
>>> behavior if I set all these bits. Maybe it requires platform support too. I'll
>>> check this with our design team.
>>
>> In DWC v4.40a databook, there is a bit AMBA_ERROR_RESPONSE_GLOBAL
>> which controls if enable the error forwarding. The *MAP bits only
>> determine which error (SLVERR or DECERR) will be forwarded to AXI/AHB
>> bus.
> 
> I have not seen a follow-up to this but I would like to, still keen
> on avoiding this patch if possible - if this is port logic it should
> be common across controllers implementations I assume.
> 
> Gustavo, Kishon ?

Atleast in the TI DRA7 TRM, I could see only
PCIECTRL_PL_AXIS_SLV_ERR_RESP and PCIECTRL_PL_AXIS_SLV_TIMEOUT register
but no global error response bit. I'd have expected configuring
SLV_ERR_RESP would have disabled error forwarding, but I don't see any
change in behavior if I modify the value of PCIECTRL_PL_AXIS_SLV_ERR_RESP.

TI PCIe controller in DRA7 is not directly connected to AXI/AHB but
there is an intermediary bridge. So I suspect there is some issue on how
the controller is integrated in TI platform. Since the board hangs, I
couldn't get lot of visibility of controller state.

Thanks
Kishon
