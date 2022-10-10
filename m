Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B285FA322
	for <lists+linux-pci@lfdr.de>; Mon, 10 Oct 2022 20:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbiJJSEp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Oct 2022 14:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiJJSEo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Oct 2022 14:04:44 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4307F10DF;
        Mon, 10 Oct 2022 11:04:37 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id ay9so6963581qtb.0;
        Mon, 10 Oct 2022 11:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zT+O0QTiUdGcu5fC+oP0NDvqRtFHHQvCkGaAkhwWHIM=;
        b=GdZBzNO9coWATiNpMORqlPjFNSVS00siS5c2OuQdIL5h5Lzd99tUhyLRBgwZZ/p3nt
         Pzw/JP73aQieySMQD1rKUL+50jUX+TH4yj/MFwa4f+zuEDbQ6l1y2oGTJ/q4NgDou4CF
         +912Xd507HpARq5RxYw+BUUCrr082Ns0+38pzTO5ftkxauvz4WCCPImyU1RU1JuJqKS7
         GaCCXiCJAB6iF3bc4NjlX3TaLHXkf42nQ6IXuDVV0dE2ilxcm3TRCPugoFPtOslvD0Nz
         iKQkGmqKVTEtqthP0tA2MqJc/A6ihfCZ/VbkhWILIo5AJ/4LUkhcN+1VvlH5OodSkcJ1
         FG5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zT+O0QTiUdGcu5fC+oP0NDvqRtFHHQvCkGaAkhwWHIM=;
        b=Fgdv41opPW5behuWUspAVBkMXtJvHJ8hOYoSRL5MWoHW2zC3nMqYJymcZyFk0Pb6E0
         HuVAHkDcrz1qQxMVcrXk697YvksAV3fG0VRFBciifnFheQ4qT/vZlREH5SSlwfCZR8Zd
         OiLzGiK9mAvvSoY6J2YY1tIF61X1+/Lk9NBvh2doaqEx+9a8C/rO8//dYN+b/jGCyddD
         OTftEF66mN84OUho800/WAxjEyM3Yq5EuKZGH1FmGja5ZIOm9Wl282AEa7QZXENk7Gff
         E9McNg0kq2rCpAYsmGzpg6YcpFjNBezK69NMMS06dxs8tSIBLYXUc8/ObwH66taRVSmY
         hN7Q==
X-Gm-Message-State: ACrzQf2xAo90vvaSh4xmx7gAIafUQW0jVOLkuC01Nll3qH/iRq6e1h9V
        s70NT5R5NHQ+hcmjHgYFMrA=
X-Google-Smtp-Source: AMsMyM7U10Zt5KrGByAcd3avPitCTOuNkxnMcfu2d1yEpdPJjJxtlsL1/ERafssAfe71kRkCHy2jcw==
X-Received: by 2002:ac8:5cc8:0:b0:398:de8d:2a0b with SMTP id s8-20020ac85cc8000000b00398de8d2a0bmr8266176qta.242.1665425075965;
        Mon, 10 Oct 2022 11:04:35 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id l7-20020ac84a87000000b003996aa171b9sm3927191qtq.97.2022.10.10.11.04.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 11:04:35 -0700 (PDT)
Message-ID: <f7e2499c-dfd8-afb0-07c4-e4e38391ba28@gmail.com>
Date:   Mon, 10 Oct 2022 11:04:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 1/5] PCI: brcmstb: Enable Multi-MSI
Content-Language: en-US
To:     Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20221006220322.33000-1-jim2101024@gmail.com>
 <20221006220322.33000-2-jim2101024@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20221006220322.33000-2-jim2101024@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/6/22 15:03, Jim Quinlan wrote:
> We always wanted to enable Multi-MSI but didn't have a test device until
> recently.  In addition, there are some devices out there that will ask for
> multiple MSI but refuse to work if they are only granted one.
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
