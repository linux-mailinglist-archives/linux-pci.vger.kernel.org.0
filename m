Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA0C506567
	for <lists+linux-pci@lfdr.de>; Tue, 19 Apr 2022 09:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349200AbiDSHOC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Apr 2022 03:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349195AbiDSHOC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Apr 2022 03:14:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3390531520;
        Tue, 19 Apr 2022 00:11:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1B81B8119F;
        Tue, 19 Apr 2022 07:11:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 934FBC385B4;
        Tue, 19 Apr 2022 07:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650352277;
        bh=cRWiba3oQT1Wyx6PHg08VUtrSYo63vCoz8IqvjSghl8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TDKa+4Z1WMzdK5u/xQ+Vnl31+oUi/2esWVXHnj9mJYhfpZUf3tPdGm2vG7vlCU4Rp
         NMCo5TgfXfIUhOU+LkrywC9d8CCgxc0+E448rG7x8CYyUF6pFEl2XIhUEwF+I2f+oY
         pKzn51uXGuHrTWRnM1ZOBU9yW42hDuV7oXhx4JV5uu/rx/fmBY2iicETFi0vrWpcGE
         /oX+6HjoPOlNiJqmZHEX/53RNnsB6w7V+hu6uy3r5pdbEjgnqv8CAq2ZM82edMowy/
         jW5heVh7FFxyhYzYt0cv1tWhJzRfKdlI6LvUBMKddQKBA758CV6Ny++9496xkjDBNc
         cT8HYCqZIC5YA==
Message-ID: <62bbc2a6-92fb-ff2b-a43f-ecb402e8f90c@kernel.org>
Date:   Tue, 19 Apr 2022 09:11:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 3/5] PCI: axis: Add ARTPEC-8 PCIe controller driver
Content-Language: en-US
To:     wangseok.lee@samsung.com, robh+dt <robh+dt@kernel.org>,
        krzk+dt <krzk+dt@kernel.org>, kishon <kishon@ti.com>,
        vkoul <vkoul@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "jesper.nilsson" <jesper.nilsson@axis.com>,
        "lars.persson" <lars.persson@axis.com>
Cc:     bhelgaas <bhelgaas@google.com>,
        linux-phy <linux-phy@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi" <lorenzo.pieralisi@arm.com>, kw <kw@linux.com>,
        linux-arm-kernel <linux-arm-kernel@axis.com>,
        kernel <kernel@axis.com>, Moon-Ki Jun <moonki.jun@samsung.com>,
        Dongjin Yang <dj76.yang@samsung.com>
References: <CGME20220419000730epcms2p77c94d5e55db13ebf2f88b25d16b6ef7a@epcms2p7>
 <20220419000730epcms2p77c94d5e55db13ebf2f88b25d16b6ef7a@epcms2p7>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220419000730epcms2p77c94d5e55db13ebf2f88b25d16b6ef7a@epcms2p7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 19/04/2022 02:07, Wangseok Lee wrote:
>> On 28/03/2022 04:14, 이왕석 wrote:
>>>  Add support Axis, ARTPEC-8 SoC.
>>>  ARTPEC-8 is the SoC platform of Axis Communications.
>>>  This is based on arm64 and support GEN4 & 2lane.
>>>  This PCIe controller is based on DesignWare Hardware core
>>>  and uses DesignWare core functions to implement the driver.
>>>  This is based on driver/pci/controller/dwc/pci-exynos.c
>>>  
>>>  Signed-off-by: Wangseok Lee 
>>> ---
>>>  drivers/pci/controller/dwc/Kconfig        |  31 +
>>>  drivers/pci/controller/dwc/Makefile       |   1 +
>>>  drivers/pci/controller/dwc/pcie-artpec8.c | 912 ++++++++++++++++++++++++++++++
>>>  3 files changed, 944 insertions(+)
>>>  create mode 100644 drivers/pci/controller/dwc/pcie-artpec8.c
>>>
>>
>> I took a look at the your driver and at existing PCIe Exynos driver.
>> Unfortunately PCIe Exynos driver is in poor shape, really poor. This
>> would explain that maybe it's better to have new driver instead of
>> merging them, especially that hardware is different. Although I am still
>> waiting for some description of these differences...
>>
>> I said that Exynos PCIe looks poor... but what is worse, it looks like
>> you based on it so you copied or some bad patterns it had.
>>
>> Except this the driver has several coding style issues, so please be
>> sure to run checkpatch, sparse and smatch before sending it.
>>
>> Please work on this driver to make it close to Linux coding style, so
>> there will be no need for us, reviewers, focus on basic stuff.
>>
>> Optionally, send all this to staging. :)
>>
>> Best regards,
>> Krzysztof
> Hi,
> 
> Thank you for your kindness review.
> I will re-work again close to the linux coding style.
> Addiltionaly, If you tell me what "bad patterns" you mentioned,
> it will be very helpful for the work.
> Could you please tell me that?

Except the tools I mentioned before, the patterns are:
1. debug messages for probe or other functions (we have ftrace and other
tools for that).
2. Inconsistent coding style (e.g. different indentation in structure
members).
3. Inconsistent code (e.g. artpec8_pcie_get_subsystem_resources() gets
device from pdev and from pci so you have two same pointers; or
artpec8_pcie_get_ep_mem_resources() stores dev as local variable but
uses instead pdev->dev).
4. Not using devm_platform_ioremap_resource().
5. Wrappers over writel() and readl() which do nothing else than wrap
one function.
6. Printing messages in interrupt handlers.
7. Several local/static structures or array are not const. Plus they are
defined all through the code, instead of beginning of a file.

Also - you have four clocks, so use clk bulk API.


Best regards,
Krzysztof
