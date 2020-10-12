Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD1E528BE06
	for <lists+linux-pci@lfdr.de>; Mon, 12 Oct 2020 18:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390640AbgJLQbi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Oct 2020 12:31:38 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40140 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390442AbgJLQbi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Oct 2020 12:31:38 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09CGVSha023047;
        Mon, 12 Oct 2020 11:31:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602520288;
        bh=JDeU4Uy898wDi4rKfXKDnwhxFvoNjhbCySd0iK6HaAQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=nURJ3RvFVIZchoS5A+rvQZm3r+Z8cmRmK7012Q52zpE4iuKK0WjcroPfrY+Tl2Ze2
         Y66tB6l1KqCrNquI9dK3Cz9/moPOOFh8oNi7I4d3viZNJPmEh98Nt8adR/s5KtEx0M
         mUwpSEYJ6at7az0DFYEaIpNCCv+vgdVA7S8gGQiw=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09CGVSuY095261
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Oct 2020 11:31:28 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 12
 Oct 2020 11:31:28 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 12 Oct 2020 11:31:28 -0500
Received: from [10.250.232.108] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09CGVNCE112483;
        Mon, 12 Oct 2020 11:31:24 -0500
Subject: Re: [PATCH] PCI: dwc: Added link up check in map_bus of
 dw_child_pcie_ops
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Rob Herring <robh@kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michael Walle <michael@walle.cc>,
        Ard Biesheuvel <ardb@kernel.org>
References: <HE1PR0402MB3371F8191538F47E8249F048843F0@HE1PR0402MB3371.eurprd04.prod.outlook.com>
 <CAL_JsqLdQY_DqpduaTv4hMDM_-cvZ_+s8W+HdOuZVVYjTO4yxw@mail.gmail.com>
 <HE1PR0402MB337180458625B05D1529535384390@HE1PR0402MB3371.eurprd04.prod.outlook.com>
 <20200928093911.GB12010@e121166-lin.cambridge.arm.com>
 <HE1PR0402MB33713A623A37D08AE3253DEB84320@HE1PR0402MB3371.eurprd04.prod.outlook.com>
 <DM5PR12MB1276D80424F88F8A9243D5E2DA320@DM5PR12MB1276.namprd12.prod.outlook.com>
 <CAL_JsqJJxq2jZzbzZffsrPxnoLJdWLLS-7bG-vaqyqs5NkQhHQ@mail.gmail.com>
 <9ac53f04-f2e8-c5f9-e1f7-e54270ec55a0@ti.com>
 <CAL_JsqJEp8yyctJYUjHM4Ti6ggPb4ouYM_WDvpj_PiobnAozBw@mail.gmail.com>
 <67ac959f-561e-d1a0-2d89-9a85d5f92c72@ti.com>
 <20201008150819.GA3871@e121166-lin.cambridge.arm.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <c8f2abfc-5860-abf4-d157-38756bd09907@ti.com>
Date:   Mon, 12 Oct 2020 22:01:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201008150819.GA3871@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On 08/10/20 8:38 pm, Lorenzo Pieralisi wrote:
> On Thu, Oct 01, 2020 at 07:02:04PM +0530, Kishon Vijay Abraham I wrote:
> 
> [...]
> 
>>>> Yeah, I don't see any registers in the DRA7x PCIe wrapper for disabling
>>>> error forwarding.
>>>
>>> It's a DWC port logic register AFAICT, but perhaps not present in all versions.
>>
>> Okay. I see there's a register PCIECTRL_PL_AXIS_SLV_ERR_RESP which has a
>> reset value of 0.
>>
>> It has four bit-fields, RESET_TIMEOUT_ERR_MAP, NO_VID_ERR_MAP,
>> DBI_ERR_MAP and SLAVE_ERR_MAP. I'm not seeing any difference in behavior
>> if I set all these bits. Maybe it requires platform support too. I'll
>> check this with our design team.
>>
>> Meanwhile would it be okay to add linkup check atleast for DRA7X so that
>> we could have it booting in linux-next?
> 
> Do you mind sending a patch on top of my pci/dwc please ?

I just tried applying this on your pci/dwc branch and it applied without
any conflicts. Please let me know if you still want me or Hou to resend
the patch.

Thank you,
Kishon
