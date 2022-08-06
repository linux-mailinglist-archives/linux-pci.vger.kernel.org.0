Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08F058B51E
	for <lists+linux-pci@lfdr.de>; Sat,  6 Aug 2022 13:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiHFLGV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 Aug 2022 07:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiHFLGV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Aug 2022 07:06:21 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D03EE38
        for <linux-pci@vger.kernel.org>; Sat,  6 Aug 2022 04:06:19 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id h21-20020a17090aa89500b001f31a61b91dso10386858pjq.4
        for <linux-pci@vger.kernel.org>; Sat, 06 Aug 2022 04:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=fa38T9ksSGR2TREkQdLxA+yGv7Nx7Psf6fxdxExdePE=;
        b=en+pNwo0V9Fww00fNxZCkRxHatr3ucuReniAhgZUoktGk4BI9kzgrn9YdQ2kNXC9sI
         LdezOpP2IF4pmk3s2QcLgo3blpP5+zQHPMs7IZEy8OByiPNGlQS++P09HteMkJ2OEXy2
         Qc8XFjBaMGZTwvYOZVX5XruiD0ATQ7qlL1HKMbuDHnDMRUPFAmCUw4GkCiu+zPjP4QgD
         rTdfOfgLZUlKlPJdbfDi8fgzE0a/iAMUQovYvalwJZvoi1KVpNTEMvr58HiOxk2lSseC
         RVn451L3Iq5wCkGp2aehOhd30H6MZ1uN5rbm3lF6sxyRePfVqHPrXM2ETj+Wn2r5Th5w
         UCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fa38T9ksSGR2TREkQdLxA+yGv7Nx7Psf6fxdxExdePE=;
        b=D2Zaj4sGDqy6o2ZxoqTo1PeG3qLzbJ2OJJ1zzj+hHV+UbyFR8LqpPQQ0Cj7RFKR+bq
         Xh7FqN+Ucg3QZd/wTtBggzuYqChs740jhqfOE2wSDm/yoL3UGxOR9qt+n7UNp5h0Ujcg
         Ikx9P4Nqkesv0Bya/KBy/p5Hxt/euwj/TDhRGzzu1r3ImGeHYk80um8EuOYDruIOOKo4
         ZKsJvKVKUc2KA48tTn7RyO7wSXSMjnMpV54NzIvf7UGwq0ez8ffceBfydDCnrH4ysRJN
         RTvgqSWSAygRtrEVcKOPXjSTN8t0ChlhMYex5O+5HGFOrpwDJXcHYvACnnbldWsNCrwP
         SWmQ==
X-Gm-Message-State: ACgBeo0XdXcK0p8HIqbxrKb5kbcX5lIUKxk5rJIuMMvluVYoHh8eUZNb
        DYlSfr4upOk5cXquRWWdlch0
X-Google-Smtp-Source: AA6agR7t7RLVeUjBmMWKSstqQVLtCUzWgS+JJFOUHf1vGNSitBhuOCKjR7ZyVJfyWFvepj33XNufnA==
X-Received: by 2002:a17:903:2309:b0:16f:784:ea5c with SMTP id d9-20020a170903230900b0016f0784ea5cmr10873315plh.100.1659783979039;
        Sat, 06 Aug 2022 04:06:19 -0700 (PDT)
Received: from thinkpad ([117.202.188.20])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ecc900b0016d6c939332sm4710527plh.279.2022.08.06.04.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 04:06:18 -0700 (PDT)
Date:   Sat, 6 Aug 2022 16:36:13 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mauri Sandberg <maukka@ext.kapsi.fi>,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: How to correctly define memory range of PCIe config space
Message-ID: <20220806110613.GB4516@thinkpad>
References: <20220710225108.bgedria6igtqpz5l@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220710225108.bgedria6igtqpz5l@pali>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Pali,

On Mon, Jul 11, 2022 at 12:51:08AM +0200, Pali Rohár wrote:
> Hello!
> 
> Together with Mauri we are working on extending pci-mvebu.c driver to
> support Orion PCIe controllers as these controllers are same as mvebu
> controller.
> 
> There is just one big difference: Config space access on Orion is
> different. mvebu uses classic Intel CFC/CF8 registers for indirect
> config space access but Orion has direct memory mapped config space.
> So Orion DTS files need to have this memory range for config space and
> pci-mvebu.c driver have to read this range from DTS and properly map it.
> 
> So my question is: How to properly define config space range in device
> tree file? In which device tree property and in which format? Please
> note that this memory range of config space is PCIe root port specific
> and it requires its own MBUS_ID() like memory range of PCIe MEM and PCIe
> IO mapping. Please look e.g. at armada-385.dtsi how are MBUS_ID() used:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/armada-385.dtsi
> 

On most of the platforms, the standard "reg" property is used to specify the
config space together with other device specific memory regions. For instance,
on the Qcom platforms based on Designware IP, we have below regions:

      reg = <0xfc520000 0x2000>,
            <0xff000000 0x1000>,
            <0xff001000 0x1000>,
            <0xff002000 0x2000>;
      reg-names = "parf", "dbi", "elbi", "config";

Where "parf" and "elbi" are Qcom controller specific regions, while "dbi" and
"config" (config space) are common to all Designware IPs.

These properties are documented in: Documentation/devicetree/bindings/pci/qcom,pcie.yaml

Hope this helps!

Thanks,
Mani

> Krzysztof, would you be able to help with proper definition of this
> property, so it would be fine also for schema checkers or other
> automatic testing tools?

-- 
மணிவண்ணன் சதாசிவம்
