Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89DDE5035E5
	for <lists+linux-pci@lfdr.de>; Sat, 16 Apr 2022 12:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbiDPKLZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Apr 2022 06:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbiDPKLY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Apr 2022 06:11:24 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A74F1AD8;
        Sat, 16 Apr 2022 03:08:53 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 35F7C1F41452
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650103731;
        bh=sGShg6P3fjsXl1jywOY1QK1SQCDN6GKf+gR0jCl+lmo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KwfXNoeIHcekZpWSXPNzbOVy5ioV6ncDUdlui/CkWBPAUL+aY942WgYo4VH3V7/Hm
         qTfIjR02LXitTCOobt4Q8EkygRec3cdmW3VGZ69v9kOtIOBgPKFuSb+kubpQj9fBi6
         QUaqHuyFq1scrpB77k69lI5znp6HraaV73u54YIO71pReqvV6YCIVMlQjVBD9wdDkh
         FFrekt2vW0h8m5V8RGOs6Sz7AxZ/1VKo+sFmUe/G5E+HqAZzYz+hD+GJliEZ1eRePq
         trN98guEzOARuhdsgLuwj+rMbCOlXKePwCDThGyo5VtE45TFu1i4520ThsR7pJvKOh
         iUPOKgAK7DX5g==
Message-ID: <eadc4422-15bb-0b46-8235-db6e160e8d32@collabora.com>
Date:   Sat, 16 Apr 2022 13:08:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v6 3/4] arm64: dts: rockchip: add rk3568 pcie2x1
 controller
Content-Language: en-US
To:     Peter Geis <pgwipeout@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220416100502.627289-1-pgwipeout@gmail.com>
 <20220416100502.627289-4-pgwipeout@gmail.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220416100502.627289-4-pgwipeout@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Peter,

On 4/16/22 13:05, Peter Geis wrote:
> +	pcie2x1: pcie@fe260000 {
> +		compatible = "rockchip,rk3568-pcie";
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		bus-range = <0x0 0xf>;
> +		assigned-clocks = <&cru ACLK_PCIE20_MST>, <&cru ACLK_PCIE20_SLV>,
> +			 <&cru ACLK_PCIE20_DBI>, <&cru PCLK_PCIE20>,
> +			 <&cru CLK_PCIE20_AUX_NDFT>;

Why these assigned-clocks are needed? I don't see anything assigned in
this patchset.
