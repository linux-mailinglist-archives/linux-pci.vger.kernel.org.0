Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C17C50C8CE
	for <lists+linux-pci@lfdr.de>; Sat, 23 Apr 2022 11:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbiDWJv4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 23 Apr 2022 05:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234671AbiDWJvz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 23 Apr 2022 05:51:55 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E648918B11
        for <linux-pci@vger.kernel.org>; Sat, 23 Apr 2022 02:48:55 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id g18so20624240ejc.10
        for <linux-pci@vger.kernel.org>; Sat, 23 Apr 2022 02:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wb4T4r7ijZ8aF5v+gGnJsoEpDak2ZQKoStYj7X7+5dE=;
        b=HzwVUfxKna/jfA17zVNO2VgKhkAtbWqdpLQfwjOXyrU5C4HSuRhRN/KClOZ8F8NRf4
         mchVDK+HM2Ztiv/XR60wzLA0aAuCXkt/rXYWFcNRS8KFXdyMHrDG40vb4LfQ6lS3GCTO
         ZMw536LedpoHH15Xw3GaeG9e+tQEP5O/Ds2qiPo5vJx3kYqpqEIWmjEBOFYs3kUg7gVi
         4/5c/xhk5x2xdoXLczQ0ZWEsR8gj9OTZeJ3DxMgr0Oe9Vz9sskYjOVAPBQhqAU4+B86V
         yzcpnYJVMbeatMY9LymQlqKgdG+DRXIcBpsjMO6DKJqK5d9u65jF28JaBQjr1laz7ZQp
         JA1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wb4T4r7ijZ8aF5v+gGnJsoEpDak2ZQKoStYj7X7+5dE=;
        b=wM6IqdiLyc4TGmZdk/I+Iv0zYTl55zLlmSiIQHDFYJ9qn2q025itmAyg/Ozf5w1AvX
         GIbg7hWyjwzwKlekBOOG7skWgaof+/l99LKngC95fivXMV3ni4DMbz5DtjPymU6hlyAn
         Gx3yxKfQqzVDmu4bz9HN/O1CvFb5jloNT0+XQ/s98vDT7e7+1Nkf/v34kmcpOQx7UST6
         I/7UcMge4ZEhfgNHMaf9cYCTZ49bDgnp/liaYI7jLy1CHM3iLoP0irPfUYAo1xtdjr9C
         PD3T1WIic1W9p9EK5eWdPVIwMfQ5aDIEiciS/CPzf7VjyOww59/PyPyhfep/9HmZvO1+
         a38A==
X-Gm-Message-State: AOAM533N3qZceUHljmXU0eN1uuZCLvQmXBf5CLawZRx2W5+EAKdsRETo
        ZMfUUg9eXoianw0oNdtBTx9KGg==
X-Google-Smtp-Source: ABdhPJx0zGhnD2FwCyiu8wknNIUij6P/6OEW5Cv4696tE7UxZbdstAV9gp5F/BvsdYI6ddOvcnLEoQ==
X-Received: by 2002:a17:907:3e8b:b0:6ef:a120:4ea6 with SMTP id hs11-20020a1709073e8b00b006efa1204ea6mr7839766ejc.607.1650707334496;
        Sat, 23 Apr 2022 02:48:54 -0700 (PDT)
Received: from [192.168.0.234] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id bq23-20020a056402215700b0041d8fcac53asm2025902edb.23.2022.04.23.02.48.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Apr 2022 02:48:54 -0700 (PDT)
Message-ID: <ec64bb8e-37a5-02bc-5bac-cc051098a89c@linaro.org>
Date:   Sat, 23 Apr 2022 11:48:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 3/6] dt-bindings: pci/qcom-pcie: specify reg-names
 explicitly
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
References: <20220422114841.1854138-1-dmitry.baryshkov@linaro.org>
 <20220422114841.1854138-4-dmitry.baryshkov@linaro.org>
 <fe9c5691-caa1-79b4-666b-daac8913b546@linaro.org>
 <CAA8EJpr=XE-8fo+99+KjTEffS1jmBibQnbN1T4ZcgkhWCDucpg@mail.gmail.com>
 <338344c8-1812-de27-80f2-df4c2dc3c17b@linaro.org>
 <5149ef96-0cdd-64cc-091f-bc97c04e7835@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <5149ef96-0cdd-64cc-091f-bc97c04e7835@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22/04/2022 21:09, Dmitry Baryshkov wrote:
>>
>> Opposite, I wish platforms to be specific, which need atu which not.
>> However I wish the strictly defined, same order for everyone because it
>> looks possible.
> 
> Well, the same order is not possible, since for some devices the first, 
> address-defining reg is "parf", for others it is "dbi". So, there will 
> be two "families" of the devices. Unless we want to change the DT 
> address of the unit.

I missed that, so my feedback is not correct. Better to not change the
unit addresses. You can still leave the "reg" and "reg-names" with
generic constraints in the main properties part, but the rest looks
actually correct.


Best regards,
Krzysztof
