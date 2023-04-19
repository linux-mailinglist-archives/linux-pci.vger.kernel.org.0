Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823716E816E
	for <lists+linux-pci@lfdr.de>; Wed, 19 Apr 2023 20:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjDSSsS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Apr 2023 14:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDSSsR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Apr 2023 14:48:17 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD173C1F;
        Wed, 19 Apr 2023 11:48:16 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-63b52ad6311so231433b3a.2;
        Wed, 19 Apr 2023 11:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681930096; x=1684522096;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uPdfMQM+igp57twLAUnBlkRXz47rDYSPWUgNdtjLI0U=;
        b=i/xtk/7WwEVyJ9JMSlY4KHg0+8snK3xFoagZ5fo4m0jkGf7OBUZOpixHy5jmcqHVaw
         BR1ICW8nz/R2zvKS4Mwk0yt5nmqeGIoJ5RZFV2NInhgyyLz1wbqP0nkn10Pj/CtG+Z04
         jX1uUKSnJvilPoz/T8O5b5wKvzaE01cHuLvKJ6/tLgANKRguLciEFhzn08TxFCXLrMrJ
         XrjWiWpNo+27ulKG7D9CKEMil0zhziXsyY1OiCVvpFholOGQR86ejlageWmUSCNieM3x
         mI50GkhzqQuadOOI//xx+Dji4ci9f1D9u47cp0rLY0LSdo7AdnA2Tn1kXWLvX4sCn3e1
         QPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681930096; x=1684522096;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uPdfMQM+igp57twLAUnBlkRXz47rDYSPWUgNdtjLI0U=;
        b=b2qz61DO0J5XowyEfGUciSRoD1BpQh8js898RjtlLjWzCxLLJlUh2cOp4QNT2pzq9k
         lTfWn2bWb4IFJWCfOUDaXC41ub58Dfbfr9JNIBTel9P4uOqXNhNZvVwyShJoZirYReLG
         Vlpn3Jznx3Ucknbp7HUdI/E9Z8L/sfo4DfDzg6NsSdAarfGp14CXiLnILu+2fV5enwmO
         vX0scg65cnBXA6sDEE2qWJuBHYobTVb/cyau7s7ZHgLfUFcB7fZOlcRAfsM2KapqJwD0
         VWCMTkCqVeCebRmbZcO/xe9mPssud2JzsP1Cj3kZPF4dAwhKQCz08IcyFUkJkWU6l6IQ
         T6pg==
X-Gm-Message-State: AAQBX9ffpFHYQO1k1hUO08l+XG+zPs24BzgFQRI2Sj09+VnBoqIY70hB
        Xi0Zb4A9xgiiq0TOl4j20xs=
X-Google-Smtp-Source: AKy350a6qk6kYCdM6r1/OJejXUnaMoExvrlktQCaZ7cSvuTlOjAb4vvDFn/EG2vvwElm+A9ciJTgzg==
X-Received: by 2002:a05:6a00:181c:b0:63b:84a2:6f54 with SMTP id y28-20020a056a00181c00b0063b84a26f54mr5062725pfa.26.1681930095707;
        Wed, 19 Apr 2023 11:48:15 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id fe16-20020a056a002f1000b0063b7bd920b3sm8092449pfb.15.2023.04.19.11.48.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 11:48:15 -0700 (PDT)
Message-ID: <ae80b632-65df-eee9-11d5-03dc957c8a3a@gmail.com>
Date:   Wed, 19 Apr 2023 11:48:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/7] PCI: meson: Add 'Amlogic' to Kconfig prompt
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Yue Wang <yue.wang@Amlogic.com>
References: <20230418184002.GA148053@bhelgaas>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230418184002.GA148053@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/18/23 11:40, Bjorn Helgaas wrote:
> On Tue, Apr 18, 2023 at 11:10:39AM -0700, Florian Fainelli wrote:
>> On 4/18/23 10:43, Bjorn Helgaas wrote:
>>> From: Bjorn Helgaas <bhelgaas@google.com>
>>>
>>> Add the "Amlogic" vendor name to the CONFIG_PCI_MESON Kconfig prompt to
>>> match other PCIe drivers.  Capitalize "Meson" to match other Meson Kconfig
>>> prompts.
>>
>> Did you mean, do not capitalize "Meson" or did you intend to preserve the
>> previous hunk that had "Meson" capitalized?
> 
> I made it match other Meson prompts:
> 
>    arch/arm/mach-meson/Kconfig-    bool "Amlogic Meson6 (8726MX) SoCs support"
>    drivers/char/hw_random/Kconfig- tristate "Amlogic Meson Random Number Generator support"
>    drivers/clk/meson/Kconfig-      bool "Meson8 SoC Clock controller support"
>    drivers/gpu/drm/meson/Kconfig-  tristate "DRM Support for Amlogic Meson Display Controller"
>    drivers/i2c/busses/Kconfig-     tristate "Amlogic Meson I2C controller"
>    drivers/iio/adc/Kconfig-        tristate "Amlogic Meson SAR ADC driver"
>    drivers/media/cec/platform/Kconfig-     tristate "Amlogic Meson AO CEC driver"
> 
> So I guess could have described as "style Meson with initial cap only
> instead of all caps" or something.

This is fine, I was just reading it wrong, as meaning all capital 
letters. Thanks.
-- 
Florian

