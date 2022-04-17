Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A767F5049B3
	for <lists+linux-pci@lfdr.de>; Mon, 18 Apr 2022 00:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbiDQW0L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 17 Apr 2022 18:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbiDQW0K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 17 Apr 2022 18:26:10 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E318812AA1;
        Sun, 17 Apr 2022 15:23:33 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 297C91F4437C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650234211;
        bh=CcJUP4Ei7n9o+q3O09iFOiRFDYRHYPSFpc7uzXTjwqw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=O+CzWC3I4DC8z3XM2IQbYer0jnYm0GvhGcfZaI0iAs8RYuy8ZZKxmNZRNJlkQw+tR
         mLrSXxk9//8YTKlDK0Uo1hu6/lKZNXJ/9TWeAO2WgI4+CaO55Poz7f7DFpMYm+KMx0
         iqJoffXxpZ3U1RVWadGzX6M9vOvKus1Q6ULwn5UWqV6/pe62H4vuozPJG7rKQIwGcU
         O4k78HU2VqbQkbJuiVVb0IokIf85KaY9RgvVisIDOJJdo9my+Sw5qA4eEj9hOL7rdf
         sPUbEPtEYALhknm3kH+W5YF9V5AUAdlvnu/x5gynv7rGXgyyCNhbzr/ApLUBPX1UYg
         SDJtEV7s2Hl6w==
Message-ID: <a8bb3ef6-8f37-709f-adfe-3608e5c1e11f@collabora.com>
Date:   Mon, 18 Apr 2022 01:23:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v6 3/4] arm64: dts: rockchip: add rk3568 pcie2x1
 controller
Content-Language: en-US
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        PCI <linux-pci@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220416100502.627289-1-pgwipeout@gmail.com>
 <20220416100502.627289-4-pgwipeout@gmail.com>
 <eadc4422-15bb-0b46-8235-db6e160e8d32@collabora.com>
 <CAMdYzYq=nQhwY_4+Y=PM9do_Dcrg1pD-jeD=q36D48ks=WDVgw@mail.gmail.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <CAMdYzYq=nQhwY_4+Y=PM9do_Dcrg1pD-jeD=q36D48ks=WDVgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/16/22 13:17, Peter Geis wrote:
> On Sat, Apr 16, 2022 at 6:08 AM Dmitry Osipenko
> <dmitry.osipenko@collabora.com> wrote:
>>
>> Hi Peter,
>>
>> On 4/16/22 13:05, Peter Geis wrote:
>>> +     pcie2x1: pcie@fe260000 {
>>> +             compatible = "rockchip,rk3568-pcie";
>>> +             #address-cells = <3>;
>>> +             #size-cells = <2>;
>>> +             bus-range = <0x0 0xf>;
>>> +             assigned-clocks = <&cru ACLK_PCIE20_MST>, <&cru ACLK_PCIE20_SLV>,
>>> +                      <&cru ACLK_PCIE20_DBI>, <&cru PCLK_PCIE20>,
>>> +                      <&cru CLK_PCIE20_AUX_NDFT>;
>>
>> Why these assigned-clocks are needed? I don't see anything assigned in
>> this patchset.
> 
> Ah, those are remnants of early bringup when performance wasn't good
> and I was manually setting clock rates.

If it's not needed, should it be removed then? Otherwise it looks like
something is missing in the DT in regards to the assigned clocks.
