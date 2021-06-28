Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5233B5807
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jun 2021 06:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhF1EMq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Jun 2021 00:12:46 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51614 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbhF1EMe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jun 2021 00:12:34 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15S49fKm059338;
        Sun, 27 Jun 2021 23:09:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1624853381;
        bh=GNU1vUWoanvJ92XdB4nexwD2JVJqd69WagBGfaf6suA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=mu5a+hQh7vJ9G0ABfC7bLJiQYRwVGkbagBr2vVw6qNOKFlRlurlvSii0+Fes6CvVQ
         OEOpT6s0KS699UN4t0jZp7N7fmUOsNFB+Gl+PUzpKJm5uSlclhBEYN9/NNoCERVURP
         qodihYQZWDOv6WWRlBehZhmP0K9aWQ5VxULnokmQ=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15S49fX1100414
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 27 Jun 2021 23:09:41 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sun, 27
 Jun 2021 23:09:40 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Sun, 27 Jun 2021 23:09:41 -0500
Received: from [10.250.232.148] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15S49XI6013993;
        Sun, 27 Jun 2021 23:09:33 -0500
Subject: Re: [PATCH v6 0/7] Add SR-IOV support in PCIe Endpoint Core
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
References: <20210616211630.GA3007203@bjorn-Precision-5520>
 <0fd19e28-e0a6-fd79-672a-b588fb2763ba@ti.com>
 <20210625161528.GA21595@lpieralisi>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <8bf024da-d35b-80d5-4351-c1c1d68ef59c@ti.com>
Date:   Mon, 28 Jun 2021 09:39:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210625161528.GA21595@lpieralisi>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On 25/06/21 9:45 pm, Lorenzo Pieralisi wrote:
> On Thu, Jun 24, 2021 at 08:30:09PM +0530, Kishon Vijay Abraham I wrote:
>> Hi Lorenzo,
>>
>> On 17/06/21 2:46 am, Bjorn Helgaas wrote:
>>> On Wed, Jun 16, 2021 at 07:35:33PM +0530, Kishon Vijay Abraham I wrote:
>>>> Hi Lorenzo, Bjorn,
>>>>
>>>> On 17/05/21 1:17 pm, Kishon Vijay Abraham I wrote:
>>>>> Patch series
>>>>> *) Adds support to add virtual functions to enable endpoint controller
>>>>>    which supports SR-IOV capability
>>>>> *) Add support in Cadence endpoint driver to configure virtual functions
>>>>> *) Enable pci_endpoint_test driver to create pci_device for virtual
>>>>>    functions
>>>>>
>>>>> v1 of the patch series can be found at [1]
>>>>> v2 of the patch series can be found at [2]
>>>>> v3 of the patch series can be found at [3]
>>>>> v4 of the patch series can be found at [4]
>>>>> v5 of the patch series can be found at [5]
>>>>>
>>>>> Here both physical functions and virtual functions use the same
>>>>> pci_endpoint_test driver and existing pcitest utility can be used
>>>>> to test virtual functions as well.
>>>>>
>>>>> Changes from v5:
>>>>> *) Rebased to 5.13-rc1
>>>>>
>>>>> Changes from v4:
>>>>> *) Added a fix in Cadence driver which was overwriting BAR configuration
>>>>>    of physical function.
>>>>> *) Didn't include Tom's Acked-by since Cadence driver is modified in
>>>>>    this revision.
>>>>>
>>>>> Changes from v3:
>>>>> *) Fixed Rob's comment and added his Reviewed-by as suggested by him.
>>>>>
>>>>> Changes from v2:
>>>>> *) Fixed DT binding documentation comment by Rob
>>>>> *) Fixed the error check in pci-epc-core.c
>>>>>
>>>>> Changes from v1:
>>>>> *) Re-based and Re-worked to latest kernel 5.10.0-rc2+ (now has generic
>>>>>    binding for EP)
>>>>>
>>>>> [1] -> http://lore.kernel.org/r/20191231113534.30405-1-kishon@ti.com
>>>>> [2] -> http://lore.kernel.org/r/20201112175358.2653-1-kishon@ti.com
>>>>> [3] -> https://lore.kernel.org/r/20210305050410.9201-1-kishon@ti.com
>>>>> [4] -> http://lore.kernel.org/r/20210310160943.7606-1-kishon@ti.com
>>>>> [5] -> https://lore.kernel.org/r/20210419083401.31628-1-kishon@ti.com
>>>>
>>>> Can this series be merged for 5.14? It already includes Ack from Rob for
>>>> dt-binding changes and Ack from Tom for Cadence driver changes.
>>>
>>> Sorry, I think this was assigned to me in patchwork, but Lorenzo
>>> usually takes care of the endpoint stuff.  He's away this week, but no
>>> doubt will look at it when he returns.
>>
>> Can you consider merging this series for 5.14?
> 
> I am running late this cycle on reviews and the merge window is about
> to open, I will review it and queue it first thing for the next cycle.

Sure, thanks!

Best Regards,
Kishon
