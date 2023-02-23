Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5516A6A0514
	for <lists+linux-pci@lfdr.de>; Thu, 23 Feb 2023 10:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbjBWJjO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Feb 2023 04:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234080AbjBWJiy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Feb 2023 04:38:54 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF1383EF
        for <linux-pci@vger.kernel.org>; Thu, 23 Feb 2023 01:38:47 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id bo30so9574820wrb.0
        for <linux-pci@vger.kernel.org>; Thu, 23 Feb 2023 01:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OFXeQdu1BvGKoHiJNbU2O9S8icll3hblWadgb7bHD+E=;
        b=vNhXHlS3ApRNSrORLnBIWRdZDd5hAkypiUtxn3mpLUgQvygEP/tfvGa7CLExQVawKr
         PTs1igfsa6+6z9Otq+6qVT3ggfOaeTP6tGt0tCNoHcvXG16JvEZoolw9JYsDpzaAkg0p
         1hwQO2Q+dKE9cMnUAs2cRP77NQuth/ll9hbwA9rMbDyD/IxVmKndz7mZkb5tbTNQt5s7
         +8wc/g7JSXgypH+MV6wXOcnKNadV7IDZuVcT/won3zrhKWuzboHkOMTChASr3sE5PZe6
         pIoqdXsVWM+zUi5eZn6kiiEbTHqVjQTn8m2m7u6E7o8Ak/bDJAOoZslgFLrZusMj6ela
         oAww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OFXeQdu1BvGKoHiJNbU2O9S8icll3hblWadgb7bHD+E=;
        b=2Gz+Pi8SN4zSFsG3dfRNwrButpUEYu+4ayA9bMvinozcRgzwn/X1Zt7p8bjxO37g5d
         o2Gc+ARDo5Y67ciczT1u/LRSLV/8rKf4G+LqCtaWOLI2Xggp+H+qukQp8bG3BlFj7mHe
         r6u+99G+WVTw3XDV6o9jj7uNplrzfNqAy4b1bRCVeK+Aa/gQUMIAlrFse2qcPYn9DO3S
         cnseeaBAH5jiq+TLvdySDrKviZivSy6VAd0yTgFGEhrXbh2DqFIxbuDLiic/jGkrD4Gc
         xYhvpZuZMAssmMRs4iiHfSM472ciCc79no5rPk4YDu+xPW5JziHNk5e7GCPnxbouJEuO
         H/2Q==
X-Gm-Message-State: AO0yUKX4xy5Ll8ZNK2JrYkp6AxmA7JoBIXN/UIUt9FFpfg+jZwnT79QT
        1BkR0kac+ztZBUvv/Iig9HdD8g==
X-Google-Smtp-Source: AK7set9gqaKCjbzALxd2/UWUh75UZxujdvrp5nFe8aSnZ1VtSwx7F06uVkt7o4qK3iqYVmRfIpTrrA==
X-Received: by 2002:a05:6000:1b08:b0:2c6:e682:e55c with SMTP id f8-20020a0560001b0800b002c6e682e55cmr9727638wrz.63.1677145125860;
        Thu, 23 Feb 2023 01:38:45 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id u5-20020a05600c210500b003e00c453447sm10573352wml.48.2023.02.23.01.38.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 01:38:45 -0800 (PST)
Message-ID: <c80a5e56-a123-a894-5d92-58f4cc36ff08@linaro.org>
Date:   Thu, 23 Feb 2023 10:38:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 04/11] dt-bindings: PCI: qcom-ep: Fix the unit address
 used in example
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org
Cc:     konrad.dybcio@linaro.org, bhelgaas@google.com, kishon@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230222153251.254492-1-manivannan.sadhasivam@linaro.org>
 <20230222153251.254492-5-manivannan.sadhasivam@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230222153251.254492-5-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22/02/2023 16:32, Manivannan Sadhasivam wrote:
> Unit address of PCIe EP node should be 0x1c00000 as it has to match the
> first address specified in the reg property.
> 
> Fixes: 31c9ef002580 ("dt-bindings: PCI: Add Qualcomm PCIe Endpoint controller")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

