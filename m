Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D87F3BEC78
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jul 2021 18:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbhGGQp6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Jul 2021 12:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbhGGQp5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Jul 2021 12:45:57 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA092C06175F
        for <linux-pci@vger.kernel.org>; Wed,  7 Jul 2021 09:43:16 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u8so3793858wrq.8
        for <linux-pci@vger.kernel.org>; Wed, 07 Jul 2021 09:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iGAqdezK2vHGAQ68dZd/ZC/J1Kp8ZpS6hRcaEAVA45M=;
        b=gjQPOAOhCm7H78f15yDmge4+B3Lml1OZV2BqBTx1bzrBFZarbGDKyvpUXWm00zD6AT
         yYgcN0AH7xQrg1mg9/hi/JePEd5X6zlrY6gwMai6ZKLZ+AjHENeNSjvm2pdmP2UxYqgz
         vAJtwTN+F7O5DRvPv/ch+pY6p6yNXtXealbnxpglX/6bfvhzr3GXGZWJPoJ/iQf3SETs
         9roTlfqsXpizY9pqnN473fCK+4Yt1oDrM+nvotru/AKUwrvBYUi5NjP4azj+1kwIO/8K
         bXi1hEKLXLBNcjU2PUD4jqDdqOfg60nJCFS0krIG8/NYO/UNHBwkaSzXLB1y0uyQm1FV
         mlUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=iGAqdezK2vHGAQ68dZd/ZC/J1Kp8ZpS6hRcaEAVA45M=;
        b=bnxsVqgnBY2zXm2aIbLhzkg3VIMriGA4kjKaSYhFGzr5Io3PsqiQ/uy7nbGagYdW9F
         9htEwnequncxq/IUguQVzj5zicT/aa+WIy895s0+4o8XFu94mtdGC/+y6vZfMAkfP0Eh
         Y1DXrP5bgi84Xs7tPitC2RjcuU0ehOmIAentYZBwBuc7/c0EYkplNj+H/NKNfamZWcDJ
         hY1zg52Vg6z26r5C1zHtfWSVVGyCelCSgDOoo4J5nLtRm7jNd575+Z0PNSoT7X0mWkYr
         W+v5RK19D121gtMc3WGw5g+1JaaJ/AqlcfOETqy5eMH0523g2xh65oOps2vinYRaGJNo
         7cGQ==
X-Gm-Message-State: AOAM530cOfX8V5fRjtTOH7k64yyNRhtuKAb7IqsM3pX4+N/AphdL4NFm
        8rvEwApJ2M576NMvIU5XAwmcBg==
X-Google-Smtp-Source: ABdhPJxeijjxwxWfBuEFBQBDYFnxi3/lFyZFlY15NyHqu1q8O5dEzP3hK206AlbuCAurYbj9ViOigw==
X-Received: by 2002:a5d:4f10:: with SMTP id c16mr28985295wru.3.1625676195470;
        Wed, 07 Jul 2021 09:43:15 -0700 (PDT)
Received: from ?IPv6:2001:861:44c0:66c0:59ba:fed7:14a3:f22f? ([2001:861:44c0:66c0:59ba:fed7:14a3:f22f])
        by smtp.gmail.com with ESMTPSA id t11sm21281369wrz.7.2021.07.07.09.43.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 09:43:14 -0700 (PDT)
Subject: Re: [PATCH 0/4] PCI: replace dublicated MRRS limit quirks
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Art Nikpal <email2tema@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        =?UTF-8?B?6ZmI5Y2O5omN?= <chenhuacai@loongson.cn>,
        Yue Wang <yue.wang@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Artem Lapkin <art@khadas.com>, Nick Xie <nick@khadas.com>,
        Gouwa Wang <gouwa@khadas.com>
References: <20210707155418.GA897940@bjorn-Precision-5520>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <aab7db4a-df1f-280b-73d7-799161528fa2@baylibre.com>
Date:   Wed, 7 Jul 2021 18:43:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210707155418.GA897940@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 07/07/2021 17:54, Bjorn Helgaas wrote:
> On Tue, Jul 06, 2021 at 11:54:05AM +0200, Neil Armstrong wrote:
>> In their Designware PCIe controller driver, amlogic sets the
>> Max_Payload_Size & Max_Read_Request_Size to 256:
>> https://elixir.bootlin.com/linux/latest/source/drivers/pci/controller/dwc/pci-meson.c#L260
>> https://elixir.bootlin.com/linux/latest/source/drivers/pci/controller/dwc/pci-meson.c#L276
>> in their root port PCIe Express Device Control Register.
>>
>> Looking at the Synopsys DW-PCIe Databook, Max_Payload_Size &
>> Max_Read_Request_Size are used to decompose into AXI burst, but it
>> seems the Max_Payload_Size & Max_Read_Request_Size are set by
>> default to 512 but the internal Max_Payload_Size_Supported is set to
>> 256, thus changing these values to 256 at runtime to match and
>> optimize bandwidth.
>>
>> It's said, "Reducing Outbound Decomposition" :
>>  - "Ensure that your application master does not generate bursts of
>>    size greater than or equal to Max_Payload_Size"
>>
>>  - "Program your PCIe system with a larger value of Max_Payload_Size
>>    without exceeding Max_Payload_Size_Supported"
>>
>>  - "Program your PCIe system with a larger value of Max_Read_Request
>>    without exceeding Max_Payload_Size_Supported:
>>
>> So leaving 512 in Max_Payload_Size & Max_Read_Request leads to
>> Outbound Decomposition which decreases PCIe link and degrades the
>> AXI bus by doubling the bursts, leading to this fix to avoid
>> overflowing the AXI bus.
>>
>> So it seems to be still needed, I assume this *should* be handled in
>> the core somehow to propagate these settings to child endpoints to
>> match the root port Max_Payload_Size & Max_Read_Request sizes.
>>
>> Maybe by adding a core function to set these values instead of using
>> the dw_pcie_find_capability() & dw_pcie_write/readl_dbi() helpers
>> and set a state on the root port to propagate the value ?
> 
> I don't have the Synopsys DW-PCIe Databook, so I'm lacking any
> context.  The above *seems* to say that MPS/MRRS settings affect AXI
> bus usage.

It does when the TLPs are directed to the RC.

> 
> The MPS and MRRS registers are defined to affect traffic on *PCIe*.  If
> a platform uses MPS and MRRS values to optimize transfers on non-PCIe
> links, that's a problem because the PCI core code that manages MPS and
> MRRS has no knowledge of those non-PCIe parts of the system.

Yes and no, it only affects PCIe in P2P, in non-P2P is will certainly affect
transfers on the internal SoC/Processor/Chip internal bus/fabric.

> You might be able to deal with this in Synopsys-specific code somehow,
> but it's going to be a bit of a hassle because I don't want it to make
> maintenance of the generic MPS/MRRS code harder.

I understand, but this is why these quirks are currently implemented in the
controller driver and only applies when the controller has been probed
and to each endpoint detected on this particular controller.

So we may continue having separate quirks for each controller if the core
isn't the right place to handle MPS/MRRS.

Neil

> Bjorn
> 

