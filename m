Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619B955F60A
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 08:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbiF2GE5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 02:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiF2GEv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 02:04:51 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EC91056D
        for <linux-pci@vger.kernel.org>; Tue, 28 Jun 2022 23:04:50 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id o9so20657230edt.12
        for <linux-pci@vger.kernel.org>; Tue, 28 Jun 2022 23:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ToylRnAwNq8wVM7oBOF8FSdHcp0ZisBXMar1kr6G3ZY=;
        b=IooOQOwLg32TtR8soIA7Hwq+zRoqSUHLE47vF1Lku0pI2ilI78793Ncg/hhVDcyPVE
         FgwioVXDrnxSPYTgIzQDYI0akLcwwWVx4R/GKVJeNTruIBKXDRtbrGVRZpzFXjsqq00T
         AG7vPY8sc/HTBpDZkuj2CHiRIBNfuyrdLKPeHqunW1fe/nRw2qOAz9OfJ1G/z/NXGP2N
         sof7g2WcmJL8js5RMq0BJORx5vjZSUMeWGn8mB7VWkjoLSzX6KW/Dahw94d4KevsFopt
         9QgKYxGkyVJPV3pg2wpG0ywQqc1p7TweTeu3FuhDTgjS/Evql1Y5UGvcyJJ4tGtNCHe+
         QAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ToylRnAwNq8wVM7oBOF8FSdHcp0ZisBXMar1kr6G3ZY=;
        b=RvtzystLUG9gEmcOEA9SFax9KTHnH18xWPnOPdBjncI51SYVODFElBDIOhgIASf7vC
         nwrZzu1TSyrZEKTZKSG85RIDyF4GcMQJqXfBEEqoHZ3vMull6US7SZhdZi/j+2089Ee5
         k7/w9YhQscZ/Go1gF9yGQjseW2Mp+LR0zhmjLeSG5z4wQQm15JxyhGTNKkshq5+fVjX6
         tRP6IxCEmXNoyX0DzgvOZFehAOaGUAE+pcCTQTaeT0+mbiKaO7yuA+72pDV+DLgd/REP
         l5teQX8McaYDBBYLkDAKzBobWiqAhHlTqz5P+5Ph8sfwacnkKtxPR1DIwScTuPVi4DBc
         2oMQ==
X-Gm-Message-State: AJIora9Ai/Di9dPRT4o35np1IoAPmFvATbmj3u8CbJx/0z6Z53JavIe7
        FMMzol5zxoLu3sQUEkqmJ7+yYA==
X-Google-Smtp-Source: AGRyM1trBlj7Bi/PtGND261JREZXCgiq2OnqUKREFcUgyVP869OpMPdzDh5GdqwElU0njB5gaHa4xQ==
X-Received: by 2002:a05:6402:4385:b0:435:9104:955b with SMTP id o5-20020a056402438500b004359104955bmr2008217edc.45.1656482689358;
        Tue, 28 Jun 2022 23:04:49 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id 21-20020a170906301500b00728f6d4d0d7sm398957ejz.67.2022.06.28.23.04.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 23:04:48 -0700 (PDT)
Message-ID: <1541997e-6dba-8f2f-2eeb-2bcc06decfd2@linaro.org>
Date:   Wed, 29 Jun 2022 08:04:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] phy: samsung: phy-exynos-pcie: sanitize init/power_on
 callbacks
Content-Language: en-US
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-pci@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-phy@lists.infradead.org
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
References: <CGME20220628220437eucas1p2c478751458323f93a71050c4a949f12e@eucas1p2.samsung.com>
 <20220628220409.26545-1-m.szyprowski@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220628220409.26545-1-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 29/06/2022 00:04, Marek Szyprowski wrote:
> The exynos-pcie driver called phy_power_on() and then phy_init() for some
> historical reasons. However the generic PHY framework assumes that the
> proper sequence is to call phy_init() first, then phy_power_on(). The
> operations done by both functions should be considered as one action and
> as such they are called by the exynos-pcie driver (without doing anything
> between them). The initialization is just a sequence of register writes,
> which cannot be altered, without breaking the hardware operation.
> 
> To match the generic PHY framework requirement, simply move all register
> writes to the phy_init()/phy_exit() and drop power_on()/power_off()
> callbacks. This way the driver will also work with the old (incorrect)
> PHY initialization call sequence.
> 
> Reported-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
