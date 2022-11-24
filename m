Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96B2637BAF
	for <lists+linux-pci@lfdr.de>; Thu, 24 Nov 2022 15:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiKXOqR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 09:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiKXOqP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 09:46:15 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5B1F2C0B
        for <linux-pci@vger.kernel.org>; Thu, 24 Nov 2022 06:46:13 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id r8so2210326ljn.8
        for <linux-pci@vger.kernel.org>; Thu, 24 Nov 2022 06:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qwmcpO6fUbn4Yroiwgc+xgdcYz3ZwR3GFESZAS168vk=;
        b=IWLLCkJLO4sW2HKGZg2TY1Oz/ByZwLaBHRHZn1HvFVQxzLxRdxJnBbx7I7ji7+CyPA
         kNxcZ22RtA45mN12iEcX7Wpb3ZK5tfZ93zG8+Tgsrxb1IuwlMlfSZGyjzn6Q9XOOYJqY
         ZMlCvlPVJqQcjL/dS2P8cWWxj5fxrXeB5TxggrKUOAQG+jp+h4p1RbFYr53mfUB2s5Zt
         yXYOTn9MTdM9IOVeBFTvsO8akNsa4TC83KliDSysN9xmp/AQTTA7LKOK1QYhH/21hzyU
         6EGwin+Pyo+cJI3YkTiqe3FOXWQ4yEFSi7R3On8LBdbhZW/i+ro6GKj5WCTvj5rpHZtP
         vc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qwmcpO6fUbn4Yroiwgc+xgdcYz3ZwR3GFESZAS168vk=;
        b=2kzANK/e4UUVjXyc4pnCl9QEIXSymUkBnGTYYe6f+bqQ1dL7lHpX51dWOQ18i8v21n
         t8VfElX7YbV0WwOhqmrKvo9IovEmrMAVCa7yrzCznjY9/upDesIVZWKNe5eN9WdAfQIK
         JRPvLjYXOvs3yH3WLc24TvZg0KYlWxOf9rpP11ovkZKPNPNPtwxelKbMpwqz1Wq95AEI
         vW487yCIB0wswXjaF/J29Nd4t5tfQIO+Bk4wCAicMzQ1ehnajVMehCl7NmPbOV6IaSIG
         +Bpm4A9IOhxRiCS+xfnPJUlIRnaY/tH9UyDTgzt6xbVdvXaDKEbTn+0pqW61BQopMck1
         JB0A==
X-Gm-Message-State: ANoB5pny9oFGUWy3hkKw0CfmHmDNLMOQMPa4+QqmsxpY/fnKiqqfD0Bn
        Z7c5zE4NZZP0sc2ph9YyOU2xuw==
X-Google-Smtp-Source: AA0mqf6jfioPGGeJ3CzVJHyXDecYR3wU+TooN+C9ZD8wNL3c7qfWCgDWljRYY3bvx1PRzS8iQ/4/wg==
X-Received: by 2002:a05:651c:114b:b0:26d:fba9:984c with SMTP id h11-20020a05651c114b00b0026dfba9984cmr10505805ljo.438.1669301172032;
        Thu, 24 Nov 2022 06:46:12 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id f24-20020ac25cd8000000b004a44ffb1050sm139649lfq.171.2022.11.24.06.46.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 06:46:11 -0800 (PST)
Message-ID: <7a02cbea-14ea-4f8e-2910-0ccef0251332@linaro.org>
Date:   Thu, 24 Nov 2022 15:46:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 1/3] dt-bindings: PCI: armada8k: Add compatible string
 for AC5 SoC
Content-Language: en-US
To:     Vadym Kochan <vadym.kochan@plvision.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Elad Nachman <enachman@marvell.com>
References: <20221124135829.2551873-1-vadym.kochan@plvision.eu>
 <20221124135829.2551873-2-vadym.kochan@plvision.eu>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221124135829.2551873-2-vadym.kochan@plvision.eu>
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

On 24/11/2022 14:58, Vadym Kochan wrote:
> AC5 SoC has armada8k PCIe IP so add compatible string for it.
> 
> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> ---
> v2: no changes

Not correct... I wasted some time looking for v1. This is a new patch.


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

