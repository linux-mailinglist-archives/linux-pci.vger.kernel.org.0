Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD0258E6D6
	for <lists+linux-pci@lfdr.de>; Wed, 10 Aug 2022 07:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiHJFy5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Aug 2022 01:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbiHJFyk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Aug 2022 01:54:40 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC6F85F96
        for <linux-pci@vger.kernel.org>; Tue,  9 Aug 2022 22:54:39 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id z20so15062547ljq.3
        for <linux-pci@vger.kernel.org>; Tue, 09 Aug 2022 22:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=WVbHtZC2AvMLO10Cu7qSYN2iTvF7BVUKT1qBXKTO+AY=;
        b=fs0/W3ItwIJEwfXeFBVjWuxC1NzwoO2sV+EY10CoQ42no0XTM7Cq8DNfuBZuVNIzkv
         /J7Ikm94atRiSDOeau+ahzEtkIL9u+u3WsHlLCU7svS2hHGKmbHxpFhNpqMcxYCyHfv7
         tit2gdUsuz9KkRkFctJP+pp055CGe6kjdajrW+o/A92SaqYowrm8BQT1Jn0k859wQfAO
         umPhUe40bhkF5hYmtW2fGP1ZL8nvIPHpRlgrYh2c5SThqParjn93NSZLAZGKJFsamebp
         QyBngUgpI+z5DPYgsqakl1sz5T4SIEoAL7UQo88iyY36Qir9TKzDWJdwdei04XAkbgjn
         dC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=WVbHtZC2AvMLO10Cu7qSYN2iTvF7BVUKT1qBXKTO+AY=;
        b=gJgbakXb3dnsbgopFFoFhUE+o9F+G47EoOQJUEOnK+wIhfPohNlUHq7sOmca6yWbvp
         +h1byZAlKkxUFeXBa3vqDslACyZ9EzsniCtKo48St4Xx4fG/gvF/LzDur7C+q2ownBqp
         W5CEnsfNUCzCAk4pXRRasHW2QsPKJzGzPkurODVimlzyjm0z5Hv+MgsNyihvKYZLn1VM
         dxcQOKLlFeRy6MkXwkNaPsQBoCxXRV95uwnJOIxgDFix60cMFZ8ZFKoKypvIeIE9Tfiv
         tbjQvhiTxSt9IUFgpF58C75RBzLBw8ND5jY5YhwngOyLgC6b5aw9fDM1a0Qd39X6tnfu
         XXLA==
X-Gm-Message-State: ACgBeo1bPH75AFy4TW3NER5/9s3/PqFyamxAAAWWAAVWWq9Qrml29t1e
        MxQPwmwXqyq6jkbLjkgrP12Re5lCKr+Ce5Ar
X-Google-Smtp-Source: AA6agR5q6g8lF1qNjciIR7gC2E+jmBpmyN3QYLleh7NBp4iK85ouPa6pDPs0v95nVr6IP+6DLEACFg==
X-Received: by 2002:a05:651c:515:b0:25f:dce6:2e95 with SMTP id o21-20020a05651c051500b0025fdce62e95mr4267107ljp.327.1660110877725;
        Tue, 09 Aug 2022 22:54:37 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id m6-20020a056512114600b0048b038c7624sm216040lfg.42.2022.08.09.22.54.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 22:54:37 -0700 (PDT)
Message-ID: <af880c1a-cedd-181f-9b4d-2f1766312fc0@linaro.org>
Date:   Wed, 10 Aug 2022 08:54:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [REGRESSION] changes to driver_override parsing broke DPDK script
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>
Cc:     bhelgaas@google.com, gregkh@linuxfoundation.org,
        linux-pci@vger.kernel.org, regressions@lists.linux.dev
References: <20220809192102.GA1331186@bhelgaas>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220809192102.GA1331186@bhelgaas>
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

On 09/08/2022 22:21, Bjorn Helgaas wrote:
> [+cc regressions list]
> 
> 23d99baf9d72 appeared in v5.19-rc1.
> 
> On Tue, Aug 09, 2022 at 11:29:43AM -0700, Stephen Hemminger wrote:
>> This commit broke the driver override script in DPDK.
>> This is an API/ABI breakage, please revert or fix the commit.
>>
>> Report of problem:
>> http://mails.dpdk.org/archives/dev/2022-August/247794.html

Thanks for the report. I'll take a look.

>>
>>
>> commit 23d99baf9d729ca30b2fb6798a7b403a37bfb800
>> Author: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Date:   Tue Apr 19 13:34:28 2022 +0200
>>
>>     PCI: Use driver_set_override() instead of open-coding
>>     
>>     Use a helper to set driver_override to the reduce amount of duplicated
>>     code.  Make the driver_override field const char, because it is not
>>     modified by the core and it matches other subsystems.
>>     
>>     Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>>     Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>>     Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>     Link: https://lore.kernel.org/r/20220419113435.246203-6-krzysztof.kozlowski@linaro.org
>>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>
>>
>> The script is sending single nul character to remove override
>> and that no longer works.

The sysfs API clearly states:
"and
 may be cleared with an empty string (echo > driver_override)."
Documentation/ABI/testing/sysfs-bus-pci

Sending other data and expecting the same result is not conforming to
API. Therefore we have usual example of some undocumented behavior which
user-space started relying on and instead using API, user-space expect
that undocumented behavior to be back.

Yay! I wonder what is the point to even describe the ABI if user-space
can simply ignore it?

Best regards,
Krzysztof
