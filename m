Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4723F759387
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jul 2023 12:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjGSK4o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jul 2023 06:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGSK4m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2023 06:56:42 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E47E123
        for <linux-pci@vger.kernel.org>; Wed, 19 Jul 2023 03:56:40 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51cff235226so1474180a12.0
        for <linux-pci@vger.kernel.org>; Wed, 19 Jul 2023 03:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689764199; x=1692356199;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0cb3uJKvOt8I5jmhbZsvlqVNSIoteu3SKnCcD96px/Q=;
        b=RRfaLI7MLZQZSoqDtZvBm0x8SmP9gMXxNavOUPcBWUSCXzw/PEIJdLgWjxGAB29uYK
         0oJEtpZog0gAnag+9XxZvXjJB2mZTl6uZMXBkOwscERdcquWRhPom4plOqskCWGBi1f7
         Nb+RXexS29zn7rr2zJSUuHpEJVWL/CIUPryAdMc6pBelMNlB10wC5fYbt6WyoUMl8uXF
         gclttPhgn+GE84qw6LOcv4fA0aDGFt/7KK5zv0DgjRLEyvJdQ63vp5DkKwhmlvSOBjoQ
         H+j62SVP9u5+ho7R/xtr+qTDmD9A3SG41iZTzt6EPpmHgw/bMtB3aGvi1dqLRD6xMly2
         sohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689764199; x=1692356199;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0cb3uJKvOt8I5jmhbZsvlqVNSIoteu3SKnCcD96px/Q=;
        b=MeTAX/8B9UZ1LHF80xjzoTWqjy7UiohaaPBbJciwiIJ2GzZ0D2aUkRRT9n8MGN6EB+
         cycEItlbr9j4zZNRVJNFRu8GRObYCrE2bwsDiCZZBMKB2H/B+6AmkoJpI/G0OTGRnXNO
         pN6pRtZEQDmsRFs6TbyFwe1hno0xmw3Lp0fV3/OIp6SY1tPpcXNnGZ3x8K8XbIk8jacC
         IpRiQ5H71ISTw+AtgVmflMzXSX7ink/NkbAEWNLi/5CdGj32jCaALGRpUgShZcX0xDmg
         tQLe12ZaBi2sVTWQqRNJRkMIlOKUTzpS3p/KX1QILJpTxSlw9v25lau0tD5MINq1MIc4
         v/cA==
X-Gm-Message-State: ABy/qLZgxXpwH7yeK+XrFCM6Sjm6ODLQBzSCYzg0w/vLxmZgf6v8tmSu
        AWMM5+7YxCzxBjyrIWfKeJYfRA==
X-Google-Smtp-Source: APBJJlGQ3ePNgBtFehdx88Nyu/l+QC7MVDygtSlJZdbG1gOoT3v8ggTbM5uC2DFHqNgNaZbRUyNFUg==
X-Received: by 2002:a05:6402:654:b0:521:ad49:8493 with SMTP id u20-20020a056402065400b00521ad498493mr2196390edx.6.1689764198806;
        Wed, 19 Jul 2023 03:56:38 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id d15-20020a50fe8f000000b0051df6c2bb7asm2520009edt.38.2023.07.19.03.56.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 03:56:38 -0700 (PDT)
Message-ID: <d08ff946-5b9c-8887-0445-e49a0c76618b@linaro.org>
Date:   Wed, 19 Jul 2023 12:56:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 7/9] dt-bindings: PCI: Add StarFive JH7110 PCIe
 controller
Content-Language: en-US
To:     Minda Chen <minda.chen@starfivetech.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
References: <20230719102057.22329-1-minda.chen@starfivetech.com>
 <20230719102057.22329-8-minda.chen@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230719102057.22329-8-minda.chen@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 19/07/2023 12:20, Minda Chen wrote:
> Add StarFive JH7110 SoC PCIe controller dt-bindings.
> JH7110 using PLDA XpressRICH PCIe host controller IP.
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> ---


...

> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - "#interrupt-cells"
> +  - interrupts
> +  - interrupt-map-mask
> +  - interrupt-map
> +  - clocks
> +  - resets
> +  - starfive,stg-syscon
> +  - msi-controller
> +  - reset-gpios

Same concern as previous binding patch.

Best regards,
Krzysztof

