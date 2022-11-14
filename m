Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5796285B2
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 17:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237637AbiKNQmA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 11:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237963AbiKNQlq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 11:41:46 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B29E82
        for <linux-pci@vger.kernel.org>; Mon, 14 Nov 2022 08:41:25 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id u2so13947713ljl.3
        for <linux-pci@vger.kernel.org>; Mon, 14 Nov 2022 08:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ckpr1zIdfaHcDHAzBaLxDeSxN1ch2sLK9yfwgktpgD0=;
        b=wUa7boTvVogUWDulScbMaVL9bbJPlTuUJ7CTIz68pvL/ww8/4oNH2CLmXkrcbwnvqg
         /qmxK3UbKAi7U7NCymsOcIstFBiyd8oLbdZKCALWUfqkj6bM/9BSmBfoTA1RH2buHjCR
         91z3Y0f0RQyiYd90aodd+2wgUR2kd2o6Nl3/FMGxWooMv3iwr/jXh/F3j0lANFIwiFYj
         8RVpyA9hzokLghKxdIPzSpNxAKlOYhlY3+QZ8iwKWH0xtK/+otCBfS9jM/QhZBZ2UiGz
         /fYM+WP4VUHVC0ZsM5orfon2JKSZdkcIx9qTecXXz4WCAUvve5v7IuTpUXQndPbaQOd1
         M7Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ckpr1zIdfaHcDHAzBaLxDeSxN1ch2sLK9yfwgktpgD0=;
        b=IyXdNtUuX+FCJUWHvyEPUQ31UWp31NAoe5N9plNZ4usZ8GDR9itk2E6R0OeDIQu7Vt
         OFe04qJ+t4u1+/WfXMOs2RXf9XKXiO68UyHTnDIb20AJJi/PTH1OG2bWy1xbJvy5085P
         xRwP8bl5l+YMQaQY4VMxq6NYxY/NB0MrTLTu/2uyuggyUrdybptzVcLQNPOneRSsNc/y
         ReLA219HjFwP+6UXHlFHl3xFCf4ZPGDhV5ngj0eyL4XWkFH92NbVqaAZeCkWjWC/2WIt
         MtEEfU0gInKwF5zy3MwA4wGUUHFinGEOGUo0DkI+8iZuLUfho0trsh8WEn2DonG6dYZ+
         6DVA==
X-Gm-Message-State: ANoB5pk2ygGtubR+jW9eBm6P1A6x13yrQKXm5aOGfT+5IODcPPQIBQ/R
        YR0dPYakml6BbuVbR7jpp6KXIA==
X-Google-Smtp-Source: AA0mqf5W3LL6ZDN0b0oOznLDRnCAUA9BSG7kLzwPHID/x1s6hx4if26bX2PQh5F0TzciC0SVV9Kxcg==
X-Received: by 2002:a2e:7a08:0:b0:277:34a:f656 with SMTP id v8-20020a2e7a08000000b00277034af656mr4843139ljc.78.1668444083381;
        Mon, 14 Nov 2022 08:41:23 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c8-20020a056512324800b004afc1607130sm1881668lfr.8.2022.11.14.08.41.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 08:41:22 -0800 (PST)
Message-ID: <7c213370-c6c0-4432-0415-b3a91841ced3@linaro.org>
Date:   Mon, 14 Nov 2022 17:41:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH V3 1/2] dt-bindings: PCI: tegra234: Add ECAM support
Content-Language: en-US
To:     Jon Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, vidyas@nvidia.com,
        mmaddireddy@nvidia.com
References: <20221114155333.234496-1-jonathanh@nvidia.com>
 <20221114155333.234496-2-jonathanh@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221114155333.234496-2-jonathanh@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 14/11/2022 16:53, Jon Hunter wrote:
> From: Vidya Sagar <vidyas@nvidia.com>
> 
> Add support for ECAM aperture that is only supported for Tegra234
> devices.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Co-developed-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

