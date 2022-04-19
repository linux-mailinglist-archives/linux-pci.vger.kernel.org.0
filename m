Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D797507B2E
	for <lists+linux-pci@lfdr.de>; Tue, 19 Apr 2022 22:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344667AbiDSUvN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Apr 2022 16:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346003AbiDSUvN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Apr 2022 16:51:13 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04704131D
        for <linux-pci@vger.kernel.org>; Tue, 19 Apr 2022 13:48:28 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id y10so17927041ejw.8
        for <linux-pci@vger.kernel.org>; Tue, 19 Apr 2022 13:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=CJf6mwEn+nVa2WZGxE3mxgQWoFOnhgooJvM6BUiZrIU=;
        b=sadS+dg/MUv2FK1jNv4oLA4r90msuWn07eu+YnpcnwBkvjXKjO6ovMpPDB4WX89vRZ
         Zp1LuWysBPu4wG2p3ssLPAi/GQs4kZqU4H1VDgTVidl981CgDIxKMKFQinTJBI4I+yYW
         +0cOWB42lZ8nODDHXFHvfhNqDuWS9vmNUXhpVaaxc+Oc/oCltiOaLTAzHkyq4DtXDwXk
         BzYB9hk0fGEU2BJg6zqmWAJRDRpytwPPLr5LLYQv39gWv2eTN/AY2gr3/BWHrglqfIZG
         r34urJSf9o8CynG4VHbozLBcWTW0S+j6HzQPCeUOhvXYqe+V4somhsvQ6+oG4RPFWDr/
         cxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CJf6mwEn+nVa2WZGxE3mxgQWoFOnhgooJvM6BUiZrIU=;
        b=OEfgpq1XQ31mIMMvWi+3jhOQn66SyW0HHKCEgPyM560BOjgRnZz0+6RhGZk2SYB/7R
         ls0CLXTOUzb4Zvqt/GV5oKA9JLNJP1Tr7TFhgBy7oTfHjH7ssMbE3lobpA6ETVKIvtKW
         kR/8ohmoUEa+R9hxLRNJnwzAUPs3822f/n5jw5GW/Ynhtz3g92ZKZYNTo47HUj117Xya
         Rs0rasYo2OT9dfXzX9oik5ZD43WmizLm/oK23q+5rDGHFyycI2sGTWoKrMlbJgk0IFML
         D6mJJ9V3KZnFH6TNTHjQJtriURpvN2mA5jr34DRCxB5ueXqXxidVsq3H3jcMLqtFRSy6
         JlTw==
X-Gm-Message-State: AOAM533MyQJ2YcBdpdD3k+nHglIym3hGDBE3IV2LxT4OqSqaV+RNLqCt
        /e9qevZXRymUNvDUEIdA0Ln9tA==
X-Google-Smtp-Source: ABdhPJyQtcbsYxBk301NPuwUiPCLtudHHdOKEJcHue01td/XXGeGWYHsjUmYm8cYC0OuP1gllTZtKQ==
X-Received: by 2002:a17:907:9005:b0:6da:81ae:a798 with SMTP id ay5-20020a170907900500b006da81aea798mr4214344ejc.699.1650401307466;
        Tue, 19 Apr 2022 13:48:27 -0700 (PDT)
Received: from [192.168.0.222] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id wi17-20020a170906fd5100b006e8b945ab94sm5905360ejb.216.2022.04.19.13.48.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 13:48:26 -0700 (PDT)
Message-ID: <09339568-8901-991d-a3a4-1061fe5c90fa@linaro.org>
Date:   Tue, 19 Apr 2022 22:48:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Aw: Re: Re: [RFC/RFT 1/6] dt-bindings: phy: rockchip: add pcie3
 phy
Content-Language: en-US
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        linux-rockchip@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20220416135458.104048-1-linux@fw-web.de>
 <20220416135458.104048-2-linux@fw-web.de>
 <38e60bb2-123b-09cf-d6ef-3a07c6984108@linaro.org>
 <trinity-597cf8a3-2ad4-41e6-b3c9-b949f8610533-1650390552136@3c-app-gmx-bap70>
 <fce0337a-0c71-a040-0a01-f20b55eb568b@linaro.org>
 <trinity-a5ae4007-e6e3-4869-80ad-3783109b6d4c-1650400612809@3c-app-gmx-bap70>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <trinity-a5ae4007-e6e3-4869-80ad-3783109b6d4c-1650400612809@3c-app-gmx-bap70>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 19/04/2022 22:36, Frank Wunderlich wrote:
>> Just use default as I wrote above.
> 
> so like this?
> 
>   rockchip,pcie30-phymode:
>     $ref: '/schemas/types.yaml#/definitions/uint32'
>     description: |
>       set the phy-mode for enabling bifurcation
>       bit0: bifurcation for port 0
>       bit1: bifurcation for port 1
>       bit2: aggregation
>       constants are defined in the dt-bindings/phy/phy-rockchip-pcie3.h
>     minimum: 0x0
>     maximum: 0x4
>     default: 0x4

Yes.


Best regards,
Krzysztof
