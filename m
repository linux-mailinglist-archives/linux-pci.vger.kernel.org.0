Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1A66A0516
	for <lists+linux-pci@lfdr.de>; Thu, 23 Feb 2023 10:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbjBWJjP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Feb 2023 04:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233984AbjBWJiu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Feb 2023 04:38:50 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A4E31E10
        for <linux-pci@vger.kernel.org>; Thu, 23 Feb 2023 01:38:29 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id ay29-20020a05600c1e1d00b003e9f4c2b623so2920965wmb.3
        for <linux-pci@vger.kernel.org>; Thu, 23 Feb 2023 01:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=43ECDPJkxGSZtfv0nSKE5iF3opRdTLPTugV4CRpGsdY=;
        b=E7EHzC1K/hGYGPyUDEQZpcnzcyNWdQ7APS51XZbIcOdeJf4TycCkXsO8rXCLT793Ri
         I8l19yEf+MZpcUiEWzhqSMEtFDkXVo4jV1YZZt52NzKn0CAaFjAOHF3/SDC2ubBkJV7K
         g24RXIUg1Pn6XJEIqwkb912tb7kF4xNpxP7csZ454strS3r80P81N2X4ZbupCpXGc8lz
         Liob+LgBqO+1uic5BQ7XLyomDGcT7/AXBqGN1vhLz7s0EaLrjqcIdhkVy22JvAeuWtBN
         gRRF9znEBo57Wb6y6BTYLeNQSbAzEn4FJw/TnWq9Tb/QMgoYdhqZ4X6viLcIPUDwnYUD
         jx0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=43ECDPJkxGSZtfv0nSKE5iF3opRdTLPTugV4CRpGsdY=;
        b=Y9ahQiGcFZ706wWua3dYOh5gcVVA1my4MhYFO0uiE8GlVk3TITY6xyh5hjUkkmap9x
         MxG54f7bjgvZhMrIyeUcwdaGdk9glqYDkwK+MFCM9FmiOWMZ7yBRsMHe0e98muab3Y2L
         hJWIsYNGVRw4c4pfKAqdEQvTJa5BGFirE7Nfi/AGW6AV9XWbEW47duqGoIK0Ck5Y6PeP
         Ubz+7yUM6d/PwF85zOCpm/Z56wA3mTev9HlUThp70p6V6mhYOqVLxoKMAQsMagWeS5RL
         RK7UA32cvUSva5zFN+YUoydOTUgfMOKhNAOy9tzzXHBEAdI8sz+ElmgXu0XwdTc3dtDK
         1p6w==
X-Gm-Message-State: AO0yUKVcFiRfTsRrBTsZxo42c2L5ly7ZcD8Am297cfVN8IkOSBcrTxLY
        HTUVKdbVXV9CXqEwva+cPkko8w==
X-Google-Smtp-Source: AK7set/xchjH6Zolh1/n0p/Cu0TJQ2SzqQmuTsOj8c3e5dBjBX6CkXyexLVxKxvdxZU5Sf6U2ns4Dg==
X-Received: by 2002:a05:600c:44d2:b0:3df:f7f1:4faf with SMTP id f18-20020a05600c44d200b003dff7f14fafmr8065985wmo.34.1677145107613;
        Thu, 23 Feb 2023 01:38:27 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id ay14-20020a05600c1e0e00b003e20cf0408esm11869809wmb.40.2023.02.23.01.38.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 01:38:27 -0800 (PST)
Message-ID: <041cfa0a-14fc-714e-54b9-a13a70f67fa0@linaro.org>
Date:   Thu, 23 Feb 2023 10:38:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 03/11] dt-bindings: PCI: qcom: Add SDX55 SoC
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org
Cc:     konrad.dybcio@linaro.org, bhelgaas@google.com, kishon@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230222153251.254492-1-manivannan.sadhasivam@linaro.org>
 <20230222153251.254492-4-manivannan.sadhasivam@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230222153251.254492-4-manivannan.sadhasivam@linaro.org>
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
> Add support for the PCIe controller on the Qcom SDX55 SoC to the binding.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

