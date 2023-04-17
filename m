Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFF46E5566
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 01:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjDQXuM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Apr 2023 19:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjDQXuL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Apr 2023 19:50:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DCC272C;
        Mon, 17 Apr 2023 16:50:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B07A96284F;
        Mon, 17 Apr 2023 23:50:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E413FC433D2;
        Mon, 17 Apr 2023 23:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681775410;
        bh=2YPJHP8es1VTEo9Fw/ICF+baELeINdHz9GXYi7P1KNc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kvvVI1TsmOLCr5PSAeMEHDt/hwXFIPKIGIfCj9ODzKSSG6//WQ3SKoctUHW2QSVHE
         viK2SGuRbDU/981VKc82JnuEv8INNrfRvuT/dq2cEjjop8YjFnLZv5QLb1aBkyoOEG
         EZJUWmxdZ/Izpuv4URwFf5LbTcZ+qfD4wDz/4MuqI0dA+5ypKPV8Xc3qGWRd6NZgV0
         ZJTp5aToPknv5YSj6ElRA1PGnDWZ0ZVTHmAeKLRQo/iJ82Z4i7tSTlhbcCyuRF8mtT
         pOfMVNAANSStrLDZA1ZmxAZ7hNbO7QWUqw6x+8bgUdHn8c/GvOw/pBi9f6HQdQWdsJ
         PAKh9CWddNsZg==
Message-ID: <7a599324-dc92-0c6a-2411-5e8fa70d5686@kernel.org>
Date:   Tue, 18 Apr 2023 08:50:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 10/11] PCI: rockchip: Don't advertise MSI-X in PCIe
 capabilities
Content-Language: en-US
To:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        alberto.dassatti@heig-vd.ch
Cc:     xxm@rock-chips.com, Shawn Lin <shawn.lin@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Brian Norris <briannorris@chromium.org>,
        Johan Jonker <jbx6244@gmail.com>,
        Caleb Connolly <kc@postmarketos.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        Hugh Cole-Baker <sigmaris@gmail.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230417092631.347976-1-rick.wertenbroek@gmail.com>
 <20230417092631.347976-11-rick.wertenbroek@gmail.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230417092631.347976-11-rick.wertenbroek@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/17/23 18:26, Rick Wertenbroek wrote:
> The RK3399 PCIe endpoint controller cannot generate MSI-X IRQs.
> This is documented in the RK3399 technical reference manual (TRM)
> section 17.5.9 "Interrupt Support".
> 
> MSI-X capability should therefore not be advertised. Remove the
> MSI-X capability by editing the capability linked-list. The
> previous entry is the MSI capability, therefore get the next
> entry from the MSI-X capability entry and set it as next entry
> for the MSI capability. This in effect removes MSI-X from the list.
> 
> Linked list before : MSI cap -> MSI-X cap -> PCIe Device cap -> ...
> Linked list now : MSI cap -> PCIe Device cap -> ...
> 
> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> Tested-by: Damien Le Moal <dlemoal@kernel.org>

Looks good, but I think you need to add also:

Fixes: cf590b078391 ("PCI: rockchip: Add EP driver for Rockchip PCIe controller")
Cc: stable@vger.kernel.org

Otherwise, feel free to add:

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

