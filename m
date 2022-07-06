Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758EC56846C
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jul 2022 11:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbiGFJ6x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Jul 2022 05:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbiGFJ6v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jul 2022 05:58:51 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59AA1DA52
        for <linux-pci@vger.kernel.org>; Wed,  6 Jul 2022 02:58:49 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id l7so17050385ljj.4
        for <linux-pci@vger.kernel.org>; Wed, 06 Jul 2022 02:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GpoFCpZ8O+svTpauDAo3u58PUgHKFYEWbYXLRGlqYoI=;
        b=fQBiNzPcw6khJIZ+MJnKxSLu+xO+uEeNhlVX/9O2EgoZjfKxokGTrBAI639jhnFbss
         Tu5EexKI/sj5GBhoLe/lMSdh/gpRDpmMhOPsqpDYKdbtLpz+Wq6zWykcUg6je1Cc9l4A
         e5xDnh5fN4sDrwjqPstLnQmQ+RZ1iqBSYFYmYlkXRYOg1eDOahK5I6mLFCDE24sMd/qQ
         IEbqgkoQcSz3BA8l6RasVmJHESsATl3g/r31ztbHw3OCPOb8rjdHUdP/jEf7zs8aaCXd
         lrwDnUw15bQa7iqxN7t7jOl/xSizN0VJ3rMc/lnG4QA9yjiUSl7T3gNnN4584rxZ4VY2
         wXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GpoFCpZ8O+svTpauDAo3u58PUgHKFYEWbYXLRGlqYoI=;
        b=BAGnY3D7XP4XLo+n3coZui7NInnlsZWH+7WrFL+Px5jxAFPXAJfQ5yoA93987W8+Y1
         Os1Gyz0ArtvlG6/SfugmRCxAjdtVg8wTck+iIrH3Jx67AvO7bfO/hZ0h1LV5xmlJsodM
         VbHHLH6pG2apdlLw1vfpY+HYSg4lhIWClLg/GpiOWuYBj96zF68sBfltxNlFHQNOUrLP
         HHp7NltfGOdwnbJAnUNcxYbPJyVMS64XjWP3J9C61W4n5j4BdZGVc7B65pkEfYsGbRc4
         ENwrCucVeSgyefwQ1CndqXpsREY/Q8v0GzDvwTri0g6V0+0cFznEVgwGK+ilGJ64H0bR
         1LLA==
X-Gm-Message-State: AJIora+ABXuoBEglPOvTzkQtIjqHvwgfuf/xFtxxKfkrmCse5htq9Q7l
        1L+1nsZkeHkwkD9SRl4kIWjZNA==
X-Google-Smtp-Source: AGRyM1vcERb/TA5ylNvEDQakZ4PfRptsZ/M6Y8Wo3syi8+/XiLTxJb4Yj1R8b80RGJ3L7PBUAGQwvQ==
X-Received: by 2002:a2e:9b89:0:b0:25d:1c51:6c6a with SMTP id z9-20020a2e9b89000000b0025d1c516c6amr10198982lji.158.1657101528176;
        Wed, 06 Jul 2022 02:58:48 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id s1-20020a197701000000b0047f6e84f532sm6194015lfc.38.2022.07.06.02.58.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 02:58:47 -0700 (PDT)
Message-ID: <e7ba92aa-c501-929b-6962-4cb4c6a1dc48@linaro.org>
Date:   Wed, 6 Jul 2022 11:58:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V3 02/11] dt-bindings: pci: tegra: Convert to json-schema
Content-Language: en-US
To:     Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     kishon@ti.com, vkoul@kernel.org, kw@linux.com,
        p.zabel@pengutronix.de, mperttunen@nvidia.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        Thierry Reding <treding@nvidia.com>
References: <20220629060435.25297-1-vidyas@nvidia.com>
 <20220629060435.25297-3-vidyas@nvidia.com>
 <cab66a0d-18d1-77ba-c0ac-06f802874c0a@linaro.org>
 <3e21dbaa-b478-5713-5355-319d2843167f@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3e21dbaa-b478-5713-5355-319d2843167f@nvidia.com>
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

On 06/07/2022 11:51, Vidya Sagar wrote:
>>> +  phy-names:
>>> +    minItems: 1
>>> +    maxItems: 16
>>> +    items:
>>> +      pattern: "^p2u-[0-9]+$"
>>
>> No, because this allows any/unspecified order. Please list the items, so
>> the order is fixed.
> 
> Not all controllers are going to have all of them specified. Number of
> these entries depend on the number of lanes assigned to that particular 
> controller. In this scenario, I thought specifying it using 'pattern' 
> should be fine. Please let me know if there is any other better way to 
> specify this.

As I understood previous bindings and your message above, these are all
incremented by one, so just list them and drop maxItems.

Trim the context, it makes it easier to spot the actual response. You
quoted a lot above and a lot below. I do not know if there is something
more to discuss? Usually quote means there is but I could not find... If
there is, use replying style matching mailing list.

Best regards,
Krzysztof
