Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5426EB324
	for <lists+linux-pci@lfdr.de>; Fri, 21 Apr 2023 22:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbjDUUza (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Apr 2023 16:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjDUUz3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Apr 2023 16:55:29 -0400
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFD71FD5;
        Fri, 21 Apr 2023 13:54:53 -0700 (PDT)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-546db536a6bso1271871eaf.1;
        Fri, 21 Apr 2023 13:54:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682110493; x=1684702493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W84o70SFFAn33dQVLvp99vQMoIhhXVO36lCwloIL3Jk=;
        b=dwmimoBj5692sLUqgCCW4PgQMVTOROa5+MboUjCApV9CxCHTMBLzDiBYgh6UkkcXXR
         hYFEw6bEYoFd9O/NB08211YkwpotVln0Wdoi2WHjjDb4aSi6Br/yUPqJLfOgixfxC2tU
         pVkDYAQpl2M5TT+V4ItbwpYt1nEOVaYGRwNyutH6aSRUoPUXSbEUjPK/X1HpyavdIxQw
         u9lC8UJWKLOFOzW3BLt09NzFdiO8WIwsHYjSAXMR+ncnzeOWlabgbpeO2LDN4YcMiQPl
         Qu0Z7R3J0xFWP/sr07zWngI5s1w91OsMDuJJ9NpDkHhvTaiDAEn/V+TMYgEcJqSmy9sd
         Tswg==
X-Gm-Message-State: AAQBX9cqzW0T76MaYsKj/EJKIuvxTvFBgEF5VhlA6GvJrhpqBoVUK4fn
        p3JXyHGf043iTLvlnL5icQ==
X-Google-Smtp-Source: AKy350bAhxx/BDKWjYLTicqHbDU8c5LjsZeqGtx7qDZou8uAl5wb3yZZpJCfX44nckE5zh0R6I27zg==
X-Received: by 2002:a05:6808:209f:b0:386:9720:77da with SMTP id s31-20020a056808209f00b00386972077damr3883015oiw.26.1682110492770;
        Fri, 21 Apr 2023 13:54:52 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p82-20020acad855000000b00383ef567cfdsm1984996oig.21.2023.04.21.13.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 13:54:52 -0700 (PDT)
Received: (nullmailer pid 1750051 invoked by uid 1000);
        Fri, 21 Apr 2023 20:54:51 -0000
Date:   Fri, 21 Apr 2023 15:54:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-rpi-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Phil Elwell <phil@raspberrypi.com>, james.quinlan@broadcom.com,
        Cyril Brulebois <kibi@debian.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v3 1/3] dt-bindings: PCI: brcmstb:
 brcm,{enable-l1ss,completion-timeout-us} props
Message-ID: <168211049118.1749998.10567032742795047284.robh@kernel.org>
References: <20230419165721.29533-1-jim2101024@gmail.com>
 <20230419165721.29533-2-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419165721.29533-2-jim2101024@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Wed, 19 Apr 2023 12:57:18 -0400, Jim Quinlan wrote:
> This commit introduces two new properties:
> 
> brcm,enable-l1ss (bool):
> 
>   The Broadcom STB/CM PCIe HW -- a core that is also used by RPi SOCs --
>   requires the driver probe() to deliberately place the HW one of three
>   CLKREQ# modes:
> 
>   (a) CLKREQ# driven by the RC unconditionally
>   (b) CLKREQ# driven by the EP for ASPM L0s, L1
>   (c) Bidirectional CLKREQ#, as used for L1 Substates (L1SS).
> 
>   The HW+driver can tell the difference between downstream devices that
>   need (a) and (b), but does not know when to configure (c).  All devices
>   should work fine when the driver chooses (a) or (b), but (c) may be
>   desired to realize the extra power savings that L1SS offers.  So we
>   introduce the boolean "brcm,enable-l1ss" property to inform the driver
>   that (c) is desired.  Setting this property only makes sense when the
>   downstream device is L1SS-capable and the OS is configured to activate
>   this mode (e.g. policy==superpowersave).
> 
>   This property is already present in the Raspian version of Linux, but the
>   upstream driver implementaion that follows adds more details and discerns
>   between (a) and (b).
> 
> brcm,completion-timeout-us (u32):
> 
>   Our HW will cause a CPU abort on any PCI transaction completion abort
>   error.  It makes sense then to increase the timeout value for this type
>   of error in hopes that the response is merely delayed.  Further,
>   L1SS-capable devices may have a long L1SS exit time and may require a
>   custom timeout value: we've been asked by our customers to make this
>   configurable for just this reason.
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>  .../devicetree/bindings/pci/brcm,stb-pcie.yaml   | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

