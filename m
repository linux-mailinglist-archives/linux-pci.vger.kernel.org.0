Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C220C6FCA33
	for <lists+linux-pci@lfdr.de>; Tue,  9 May 2023 17:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235392AbjEIP2F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 May 2023 11:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjEIP2E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 May 2023 11:28:04 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E010244AF;
        Tue,  9 May 2023 08:28:03 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-192cb642f5dso2606707fac.1;
        Tue, 09 May 2023 08:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683646083; x=1686238083;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QQDcgprxE9MPSBXXVK5u5yM5P7rN56F01yO8Fxnmxn0=;
        b=TjW2zlN3aPexj5AjqDOAhgmYVAB8QlOWY6HXbT+DdehjYFUKqDqc3QZ82laozSGcEL
         Td2XRXLapn0Rg8LcFQeFXbierXrdzI+Ptb0FSloMptKJtlQ57eccHFxJitVQDKhG8Cv7
         9v8S2agMtkhgz5t4luheq2yFeiEdYNCvjZjEX6M8Ul9p3GZmwFc1HJ1yxdrz8UzUuIxy
         H5MVqp8Yr7DSlnpXWqc/FtE/CTUoAdbaE3v7wyw5vuaBxmYex/TGviUp5nAZCrGV6edo
         kBc+3eRR4uB8GcXvc2o8+XzibfZVKidD01V7XAMyEDmxVAX19nSI0uWal1ovWJw134TK
         Iixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683646083; x=1686238083;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QQDcgprxE9MPSBXXVK5u5yM5P7rN56F01yO8Fxnmxn0=;
        b=QWdLIjMHhRomyOCbOhjMiCIbonZUnK3CdAlOuaLSIdZNgtSnKviG6/5/wrbbmHNHcX
         qJoq3ipj3SLDq2u5XpWzBnMcbEjYlIdoRMC8B3hpCdRnD/1/MNoMVkWALBsBIs+GygLt
         L945Q74E3Fxf6/H+EOas6GN5NA7kKxWkSqwkNy8Hws/H2a8zlZYg7a8Gd3ehGGZBupQE
         9//Ne0lXwiZFMvNR9Y7upyXTgaiImWGZRyuMcOKLTtTu9KjpkyhOy12ZW7mDMsowbssx
         olFBzKW9fptL+m2HM2iaYduVyX1NCIVwc2y+mZjcLWD9T6Ea1adsutS0RUGjLGSiYGYm
         3L7A==
X-Gm-Message-State: AC+VfDx9ASXWXliQel4QIFtJihk4xBmrHwODHirhtzrQYPmvlYUTkjO7
        rI8/LM+oRImhz09W2AiIgTbcOI+gewroDUaUVpU=
X-Google-Smtp-Source: ACHHUZ4pQF+AGfkYfK7fJeetVQCwhOH08KUenKWJTPDOJfNI9H+6P1QxtNigm/HbUrtx8aK+nY+EJo5/5OOImOKWlRQ=
X-Received: by 2002:a05:6808:290e:b0:35e:9090:2969 with SMTP id
 ev14-20020a056808290e00b0035e90902969mr1433503oib.13.1683646082839; Tue, 09
 May 2023 08:28:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230427055032.85015-1-rath@ibv-augsburg.de> <20230427055032.85015-4-rath@ibv-augsburg.de>
In-Reply-To: <20230427055032.85015-4-rath@ibv-augsburg.de>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Tue, 9 May 2023 17:27:51 +0200
Message-ID: <CAH9NwWdUcu+JdUcd1zaJxka6C8+VerkyWEfANzu9TFKfneybnQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: ti: k3-am64: Add PCIe PHY latency DT binding
To:     Dominic Rath <rath@ibv-augsburg.de>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        tjoseph@cadence.com, bhelgaas@google.com, lpieralisi@kernel.org,
        nm@ti.com, vigneshr@ti.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        bahle@ibv-augsburg.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi

>
> From: Alexander Bahle <bahle@ibv-augsburg.de>
>
> Add DT bindings for the PCIe PHY latencies. Applies to PCIe in host and
> endpoint mode. Setting these improves the PTM timestamp accuracy.
>
> The values are taken from the Link below.
>
> Signed-off-by: Alexander Bahle <bahle@ibv-augsburg.de>
> Signed-off-by: Dominic Rath <rath@ibv-augsburg.de>
> Link: https://e2e.ti.com/support/processors-group/processors/f/processors-forum/998749/am6442-details-regarding-ptm-implementation
> ---

Would it not make sense to add these dts properties to
k3-am64-main.dtsi? At least this is what the commit message says.

>  arch/arm64/boot/dts/ti/k3-am642-evm.dts | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> index 39feea78a084..f448c98f1aa1 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> @@ -552,6 +552,8 @@ serdes0_pcie_link: phy@0 {
>                 #phy-cells = <0>;
>                 cdns,phy-type = <PHY_TYPE_PCIE>;
>                 resets = <&serdes_wiz0 1>;
> +               tx-phy-latency-ps = <138800 69400>;
> +               rx-phy-latency-ps = <185200 92600>;
>         };
>  };
>
> --
> 2.36.0
>

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
