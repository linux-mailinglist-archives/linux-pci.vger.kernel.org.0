Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E914862DEE0
	for <lists+linux-pci@lfdr.de>; Thu, 17 Nov 2022 15:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239654AbiKQO7Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Nov 2022 09:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240104AbiKQO67 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Nov 2022 09:58:59 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3378A748CD
        for <linux-pci@vger.kernel.org>; Thu, 17 Nov 2022 06:58:53 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id a29so3175767lfj.9
        for <linux-pci@vger.kernel.org>; Thu, 17 Nov 2022 06:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VSnIdJlrSu1RqwxbrwymcRNJoSgT34DNNQH025cvo20=;
        b=Ur9szg1DKJvl3ubQjvlChH09oAO12tYaDGESWoJRFs5nbTcgL70iq6Rk6jcbyh2eSV
         5sIr6XHiZbOMcG5vg6LYzpKXTZagjOTTXivxVfplX5GAD0O1/9QIYKFbd0XkOcolglVT
         VrJu0CgFgUecUmcpa3we0bBiZQmSB6sCWxEucrm8wK9mxNNpZRyq2THIgu40f2wTK8zo
         2iE5ibWayllqwdjGN++kkVQdW9OgLgRj0+rBH5OvzcLsoNEByi9LNspb+2B+W5wqkM41
         Rwzp9Tu2wWCQ3oQ9fSXsHYYSxRuw8yfwAEchPTid10LtcwGqSDyeXQdG7IyHwjOChaWM
         86bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VSnIdJlrSu1RqwxbrwymcRNJoSgT34DNNQH025cvo20=;
        b=h/2JxTRlzM1A4/9F2OWEPurR2ZNbStqd4U+H7PTMd9KZzzaj6vEHTVhsyWSzdOWKui
         nfnwqO9ABTDcwDJI6bcGBoJ0srzGolflBYlQN4Lx+Gp8GKDcuQQ5Fk7PbTsXMCiRik8W
         Cr6Xkipd2JBXiPkAMYFcrt1jGb0mcPJ+fe8QJkB3tlYKKsY6EMVNXuIzx9OsltKpQjjr
         JBf1iBN5Tezza/H+Fic0OVEieT5Nf14mG+QTsksI7Fz/lxdI7r0t/QqOS9gbftDHsQnZ
         raO18w98oK3MgpZgaVTwlEgg+9Ei4y3zwuBMDI1mP0Tg4YrVRyrwUEtJ7F2QmJVKgEZp
         AZug==
X-Gm-Message-State: ANoB5pnmCZRDPxfRn/3kUV7eKhidX1irDLgDh30aaFMnwXMJDa6WP9SX
        jX4NmX/7qLT0lrAmFRA2VvlV2w==
X-Google-Smtp-Source: AA0mqf4/hs47bXqsUk4ZLu/jQ1Wna1nuVovn6G3NWi6j/M3148XUWs2V/ZZa76pyYbEsKXo3MQAsvg==
X-Received: by 2002:ac2:4a69:0:b0:4ac:d080:e1bd with SMTP id q9-20020ac24a69000000b004acd080e1bdmr1120397lfp.318.1668697131665;
        Thu, 17 Nov 2022 06:58:51 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id r8-20020ac24d08000000b00492dfcc0e58sm186892lfi.53.2022.11.17.06.58.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 06:58:51 -0800 (PST)
Message-ID: <2f35b9aa-1385-9c2b-ed60-721a835645dc@linaro.org>
Date:   Thu, 17 Nov 2022 15:58:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC PATCH 1/9] dt-bindings: drop redundant part of title of
 shared bindings
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, netdev@vger.kernel.org,
        linux-can@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-serial@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-spi@vger.kernel.org, linux-usb@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-watchdog@vger.kernel.org
References: <20221117123850.368213-1-krzysztof.kozlowski@linaro.org>
 <20221117123850.368213-2-krzysztof.kozlowski@linaro.org>
 <Y3Y1xjOjijBsQLZA@lunn.ch>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y3Y1xjOjijBsQLZA@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 17/11/2022 14:23, Andrew Lunn wrote:
>>  allOf:
>> -  - $ref: "dma-common.yaml#"
>> +  - $ref: dma-common.yaml#
>>  
>>  
>>  allOf:
>> -  - $ref: "dma-common.yaml#"
>> +  - $ref: dma-common.yaml#
> 
> Looks like some other automated change made its way into this patch.

I forgot to mention in commit msg, but maybe better to drop it to reduce
noise.

Best regards,
Krzysztof

