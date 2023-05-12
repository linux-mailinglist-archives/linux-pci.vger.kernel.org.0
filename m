Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607B970015C
	for <lists+linux-pci@lfdr.de>; Fri, 12 May 2023 09:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239999AbjELHX2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 May 2023 03:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239922AbjELHX1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 May 2023 03:23:27 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CE218C
        for <linux-pci@vger.kernel.org>; Fri, 12 May 2023 00:23:26 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50bc3088b7aso17948450a12.3
        for <linux-pci@vger.kernel.org>; Fri, 12 May 2023 00:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683876205; x=1686468205;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i1WcT1EFQll4i945sfdDYYW2fDl+L8KOHaAQMIivfsc=;
        b=KAC9LQke3q2fF50hBttyTjOkrS+lywl7NvQuSLsok1fII5S4DQG8cOSrF/i9nh3dip
         GLl66OcYZyoZ8XOWqRe6DCT+WbQx45T/W3LGGczQ4hS2x01Z4dKM6lvDGk3vKzrACZg1
         yRXK3MwGzUywlNt3jg4c2t57DlIT19w5Wpx1fic6/dyGxOyGMRdlkHl3mjzU1ZPRLT34
         bjLO1VncsK7sfKheOjMiLB/hyBrFiP1F36vsE/NzejFNL+3SK5R+66CjGO8HEFH146T8
         tbTTby/HsqAA7JjmQWzz2pQjRl306zoqJuFfXneuHo48ttZbBe3A0vtP7iCvPdkuzzUf
         Uh0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683876205; x=1686468205;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i1WcT1EFQll4i945sfdDYYW2fDl+L8KOHaAQMIivfsc=;
        b=EuEa1XcqC30KkaAbNToB5NpW1WgRUs2q40yvAL4Mg4YK6+g2NyCafB5hDSyqCwAtYY
         PxS1MsdLOyTRBg0RetEXJ5b6uIygNUjWWQx/AY+E3V5YSbLUFuBrEsqBBo5Enpi5Ghwt
         HIhhuHiGcOl4dr4l+hYAdPdwcb6ruXy2gZSoHu+XElki1odrI8xu6suYqTZZpnOskUlV
         7Md2xfFSMW2mV9EkLnn+L3i57DJrXpz6mp4TvFWew2MjnRM6VPsMHdP9fnG3knfFT7KJ
         m8Sy7ggBPnBv+nPg44tQGY/0t9VpXg4yZ0BxGZXmaFmgnTY1h4pUof4OvoqI7Qgs/g4W
         Zz6A==
X-Gm-Message-State: AC+VfDxlA6fl/uYOm4v8b21I48NZLtEjri03utFRd+TsStIYlP3t/5AU
        vU2Iw3b9IEojo/WRRdGaPcpvPQ==
X-Google-Smtp-Source: ACHHUZ7ZOkCM9WlPxvllsqyiYBd8PiP1ZtLyfXAPuFaYI8O0MFez1OUIqXmuma5y0ETf/q/Ee45uzQ==
X-Received: by 2002:a05:6402:398:b0:50b:c4b7:ee7c with SMTP id o24-20020a056402039800b0050bc4b7ee7cmr18839172edv.36.1683876205338;
        Fri, 12 May 2023 00:23:25 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:7ede:fc7b:2328:3883? ([2a02:810d:15c0:828:7ede:fc7b:2328:3883])
        by smtp.gmail.com with ESMTPSA id b12-20020aa7dc0c000000b0050be1c28a0fsm3750129edu.7.2023.05.12.00.23.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 00:23:24 -0700 (PDT)
Message-ID: <13028434-f68c-cad3-056e-d319c1ec35cf@linaro.org>
Date:   Fri, 12 May 2023 09:23:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/3] arm64: defconfig: enable J721e PCIe controller
Content-Language: en-US
To:     Achal Verma <a-verma1@ti.com>, Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "N_colas F . R . A . Prado" <nfraprado@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        Rafa_ Mi_ecki <rafal@milecki.pl>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, Milind Parab <mparab@cadence.com>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-omap@vger.kernel.org
References: <20230512070510.1873171-1-a-verma1@ti.com>
 <20230512070510.1873171-4-a-verma1@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230512070510.1873171-4-a-verma1@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/05/2023 09:05, Achal Verma wrote:
> Enable Cadence PCIe controller and pci-j721e drivers to be built as
> kernel modules.

Why? IOW, who needs them. Please provide rationale in the commit msg. I
am pretty sure I asked for this...


Best regards,
Krzysztof

