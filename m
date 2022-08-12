Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B48590D1D
	for <lists+linux-pci@lfdr.de>; Fri, 12 Aug 2022 10:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237413AbiHLIAu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Aug 2022 04:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237931AbiHLIAq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Aug 2022 04:00:46 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21D585AAE
        for <linux-pci@vger.kernel.org>; Fri, 12 Aug 2022 01:00:44 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id u6so198193ljk.8
        for <linux-pci@vger.kernel.org>; Fri, 12 Aug 2022 01:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Yt5ToDvo7PMHl25yjyIOT+s5XGNpgr8e3m9LDdB/3lk=;
        b=nwoVxkWGoQL3ZHL5C6SLyDcKfVZivZQxMzgGtmJrgdnb0U4Te1pVg1rX7NYo71sCQT
         uiWwCrVnTvzkjWRTzw4u4cvXV1JPhHJWooqDclB2I6sYBSz6lQDfu0fA1uqRD8HQ1TZ4
         Zdj9b4KsLYJ1UvpWgueoOUCTk32Z6HfaUJ2QHEGw0J8f6xpC4N3pdkcs9R91rGhmO6DG
         nMHK4bXXg4tTZL8D5fSLxeKN/ZUGnJeir8urTleIswMnqCF9SDrnHHBvv2ouxXjMGC34
         /K15mlGQCaE92kvwlFdsqaKarjkuCy3yrOiLypr9QtiweOQFSTumdBUqR6ZJB2A8oVTy
         eSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Yt5ToDvo7PMHl25yjyIOT+s5XGNpgr8e3m9LDdB/3lk=;
        b=dwFXO01DWhmDmWHaZxtDlfGoA7gL/m1QZgFJpaqb9F4nE4P2dngXRFg5nsur8P9Lz+
         Tms7Vg0nyAe3YQtDBsK0Hnt+DEUI2zziZKXfj65NMCB799wqmYqhmLXQI1VcHwme+mVk
         Jy9i8ow6sbJ8xTqOK4zzvkEAgOdR/l2T+fN8jelF417EWCwVctBN36dRRoMimk92xBCb
         XVVUeDo2JjIztKQ0hRL6c4MpZ8eBTzPkDRlwcSMhmMt9fNe3DHKrk/yANVjhXhCWohhn
         l2BJaR3JnbiaOzD+TtkkOHlNWU3XBR5vvnV/6g4TNta0w7KZbAdI3ui+soFNs2pKB9wO
         CxKQ==
X-Gm-Message-State: ACgBeo1GwHgS1NX2EUsEaayz8XHl/NlbpoUj881fC+MKlBtYebRumnnF
        nWZE3QkmNMDEm5j61YOt+NM8sw==
X-Google-Smtp-Source: AA6agR6kAd9H0uR/o1GgiFb11dAb+i11zZN3vQD+qih0eveFm0mSRk24hl87uKD/Ibxwkx+WyEHgqg==
X-Received: by 2002:a2e:b750:0:b0:25e:71da:5baf with SMTP id k16-20020a2eb750000000b0025e71da5bafmr872173ljo.166.1660291243023;
        Fri, 12 Aug 2022 01:00:43 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id z13-20020a05651c11cd00b0025e4fcadc72sm265386ljo.92.2022.08.12.01.00.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 01:00:42 -0700 (PDT)
Message-ID: <a9dc3a83-faec-71e0-c48e-25e16e18dc29@linaro.org>
Date:   Fri, 12 Aug 2022 11:00:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/4] dt-bindings: PCI: microchip,pcie-host: fix missing
 clocks properties
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Conor Dooley <mail@conchuod.ie>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20220811203306.179744-1-mail@conchuod.ie>
 <20220811203306.179744-3-mail@conchuod.ie>
 <99b5bddb-4a09-a3ac-e01b-d0ae624ad2f8@linaro.org>
In-Reply-To: <99b5bddb-4a09-a3ac-e01b-d0ae624ad2f8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/08/2022 10:35, Krzysztof Kozlowski wrote:
> On 11/08/2022 23:33, Conor Dooley wrote:
>> From: Conor Dooley <conor.dooley@microchip.com>
>>
>> Upgrading dt-schema to v2022.08 reveals unevaluatedProperties issues
>> that were not previously visible, such as the missing clocks and
>> clock-names properties for PolarFire SoC's PCI controller:

I don't think this part of sentence is worth staying in Git. The schema
is released so obviously everyone should upgrade. In two years will it
matter which version brought unevaluatedProperties to a enforced state?

Best regards,
Krzysztof
