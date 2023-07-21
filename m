Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4759175C2FB
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jul 2023 11:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjGUJXq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jul 2023 05:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbjGUJXe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jul 2023 05:23:34 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87143A87;
        Fri, 21 Jul 2023 02:23:15 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fb863edcb6so2742714e87.0;
        Fri, 21 Jul 2023 02:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689931393; x=1690536193;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M0C4zDryat48OeUNijAsubnvNOIhi4gDTfxngqXQKzY=;
        b=no3r2jgsdvpIbDr/9DhIblU96Yteh/5I+AQyymUhUwu4LoQUKx9J7v2Ol1O8pvcp0w
         TS+sK4E+T7pZ8w8OxeNOo3ic6kbrWRMs6kPBx3Axozl1y61vOLm/nS+kheYhFJJYoSOA
         Jq2/KSw0HhG/DHZdZcqMOKQFAy0kW6n7q6iJpLtVlEGnsM7gSr6aPNG1cj9MNTZamabB
         FCK2/zWC0MyjKR9M45mmzWJO5/uoAJrToXFvEZcAlLXDDTmdJ5KZjravFNSBgxlzpWzB
         V3amk6+lVsN0FNKp3ra7QWyslQNTIoC9nsRU9cQJGfGX0opfoESKKr4UaAYpwWS+ASl0
         4TyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689931393; x=1690536193;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M0C4zDryat48OeUNijAsubnvNOIhi4gDTfxngqXQKzY=;
        b=gKaJ2SeigBLzW6Qwbl2NVsut2QylE7b2uZ1rRsCb0Y8KOWg9h9aPbcf8OlgC2gDVWR
         mfrJqgtUBNQ6AiWwWEtjuTBFwfuOcwPHluHjNhzPc1UL8sxgfga02kX6dSxwxaR+JJF/
         dLSHxmUqC2FmqYY9CFUhauO3aDtTOUepB4AoiTE2INX3ORMvRs5HVRsPLRDsxmOJilJn
         MltSxVTw59bsXzmCPq0oPPD1mq+smDBadGwWhZ/eWEMojef80j+8BsFpvpKmbA/+OYTJ
         3FsUa6BAI04kBmX+84gl2UHtPqjsplM5mPv/JcX1fnHKayagIwoUsBN8WrqYG/x9JtH+
         INwA==
X-Gm-Message-State: ABy/qLb8V4BTOGMoHRadhsNIxZMeqNySPIswR4A9ebMCjID6X0mBCBeI
        Nkyq6mmt4ygzj/QDS8vtSW7WR/q1LDugVA==
X-Google-Smtp-Source: APBJJlGlPTLa2gquXOOWAKAZZ3vkxcBhOsdvlyEajvy4zxY9iZQkDUUaGESJm1qebBWtVsnzrKrWtA==
X-Received: by 2002:a05:6512:3297:b0:4f8:5d2f:902a with SMTP id p23-20020a056512329700b004f85d2f902amr885121lfe.60.1689931393364;
        Fri, 21 Jul 2023 02:23:13 -0700 (PDT)
Received: from [192.168.1.103] ([31.173.87.226])
        by smtp.gmail.com with ESMTPSA id eo14-20020a056512480e00b004fbdeca7b79sm636328lfb.247.2023.07.21.02.23.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 02:23:12 -0700 (PDT)
Subject: Re: [PATCH v18 13/20] PCI: dwc: Introduce .ep_pre_init() and
 .ep_deinit()
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
        kishon@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     marek.vasut+renesas@gmail.com, fancer.lancer@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
References: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
 <20230721074452.65545-14-yoshihiro.shimoda.uh@renesas.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <103865a6-1b8a-e165-dc83-4723b2b0089e@gmail.com>
Date:   Fri, 21 Jul 2023 12:23:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20230721074452.65545-14-yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/21/23 10:44 AM, Yoshihiro Shimoda wrote:

> Renesas R-Car Gen4 PCIe controllers require vender-specific

   It's "vendor". :-)

> initialization before .ep_init(). To use dw->dbi and dw->num-lanes
> in the initialization code, introduce .ep_pre_init() into struct
> dw_pcie_ep_ops. Also introduce .ep_deinit() to disable the controller
> by using vender-specific de-initialization.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
[...]

MBR, Sergey
