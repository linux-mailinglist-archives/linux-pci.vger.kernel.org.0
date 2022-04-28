Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890DC512BA6
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 08:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244162AbiD1Gho (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Apr 2022 02:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244138AbiD1Ghm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2022 02:37:42 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91502972F0
        for <linux-pci@vger.kernel.org>; Wed, 27 Apr 2022 23:34:27 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id m20so7498556ejj.10
        for <linux-pci@vger.kernel.org>; Wed, 27 Apr 2022 23:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uzuvBG3ySD2q6+EwBDVkcHQZJOKGPkpC5+jeVqG/3co=;
        b=hslMUKE+lJ/AV2mxULrxBj8n9wD1cA7ihbkpDl990VaHaNscheWT3YMDZWHKp/cpG7
         ZFbphFxD0k8J4Hkc2pDWB7wdceFzPpu2AiRMUUeEc8F6WsGxguMtwDEo2lPUNpDuuEiy
         GYXKN69K2YASGzxtO1hTO4zpmXbo1n4mywjj+7D7R6/IMDqTv9s1KdlRRc++gnx98MDw
         lEyYVyJkQJexivMQ2O957UQCz7h2++X4CWJRCVHxNHHeCgWs8ky2QlwziejP5ZBpcK2n
         eYJWFjRwEapB67DNbOPjuRlfUdm01V07eq+BzNVP5RstzjS8Tmz5XIzRfYgP6HVyWl7p
         N+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uzuvBG3ySD2q6+EwBDVkcHQZJOKGPkpC5+jeVqG/3co=;
        b=ujpwdk9Nyn1MOs/W0bjgU/q1Ru+cNZ8nUhpnky3r+qxZNkXaz5i3tYEmLb1Q78bgq5
         P6r4TqJaoAH2id3eMmceo596aMabXt3TFX2PXUb8QV6pKGVGJOP8YFBNvzss3UKbgUrg
         ypArZflR013vFkTM8rlP5mYN3Y1LeEDKSPCUhCdW5Hrl+ddQJ+Y3vPUfiemhwgGRMMJI
         PnnOfdhYkZrxILJpzWpncuBJAonMMgm0/hG19zCqQQKP7Q+euGadEK8roQZ6D1ntZgvf
         XQyKE6uPNB00f+lJVfaaN/aOjxjcxV/ytPDwUAIKJlIfgVCExz1wB+AeiVSU8eoxgRiJ
         Mo5w==
X-Gm-Message-State: AOAM531bEVGz5AYm6P7VdqpiutKTDaUw3Fl14HWQkWTvklspDatvd8GG
        ERH2VvWfdXVtr8fO5sDxfYi31w==
X-Google-Smtp-Source: ABdhPJzY1zrs5I3FVQuz284Iw/XuEBYz3tDW17K26IIlFioWkI1mMejMgLKVMYy1IHPyq9D6n6tqXA==
X-Received: by 2002:a17:907:6e02:b0:6f3:d185:5d25 with SMTP id sd2-20020a1709076e0200b006f3d1855d25mr4921212ejc.14.1651127666184;
        Wed, 27 Apr 2022 23:34:26 -0700 (PDT)
Received: from [192.168.0.159] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id f31-20020a056402329f00b0042617ba6381sm960602eda.11.2022.04.27.23.34.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 23:34:25 -0700 (PDT)
Message-ID: <918f5bc9-77f6-4d65-7432-ab53aadd6734@linaro.org>
Date:   Thu, 28 Apr 2022 08:34:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC/RFT v2 03/11] dt-bindings: phy: rockchip: add PCIe v3
 constants
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-rockchip@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
References: <20220426132139.26761-1-linux@fw-web.de>
 <20220426132139.26761-4-linux@fw-web.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220426132139.26761-4-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 26/04/2022 15:21, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add constants that can be used in devicetree and driver for
> PCIe v3 phy.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> v2:
> - new patch because splitting out this file
> - rename file from snps to rockchip
> ---
>  include/dt-bindings/phy/phy-rockchip-pcie3.h | 21 ++++++++++++++++++++

Naming - vendor,device.

>  1 file changed, 21 insertions(+)
>  create mode 100644 include/dt-bindings/phy/phy-rockchip-pcie3.h
> 
> diff --git a/include/dt-bindings/phy/phy-rockchip-pcie3.h b/include/dt-bindings/phy/phy-rockchip-pcie3.h
> new file mode 100644
> index 000000000000..93e57edd337d
> --- /dev/null
> +++ b/include/dt-bindings/phy/phy-rockchip-pcie3.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */

s/MIT/BSD-2-clause/ just like bindings because it is part of it. Unless
you took it from something and it is already licensed like that?

> +/*
> + * Copyright (c) 2021 Rockchip Electronics Co., Ltd.
> + */
> +
> +#ifndef _DT_BINDINGS_PHY_ROCKCHIP_PCIE3
> +#define _DT_BINDINGS_PHY_ROCKCHIP_PCIE3
> +
> +/*
> + * pcie30_phy_mode[2:0]
> + * bit2: aggregation
> + * bit1: bifurcation for port 1
> + * bit0: bifurcation for port 0
> + */
> +#define PHY_MODE_PCIE_AGGREGATION 4	/* PCIe3x4 */
> +#define PHY_MODE_PCIE_NANBNB	0	/* P1:PCIe3x2  +  P0:PCIe3x2 */
> +#define PHY_MODE_PCIE_NANBBI	1	/* P1:PCIe3x2  +  P0:PCIe3x1*2 */
> +#define PHY_MODE_PCIE_NABINB	2	/* P1:PCIe3x1*2 + P0:PCIe3x2 */
> +#define PHY_MODE_PCIE_NABIBI	3	/* P1:PCIe3x1*2 + P0:PCIe3x1*2 */
> +
> +#endif /* _DT_BINDINGS_PHY_ROCKCHIP_PCIE3 */


Best regards,
Krzysztof
