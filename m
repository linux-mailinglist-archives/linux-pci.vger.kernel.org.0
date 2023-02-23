Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4116A0502
	for <lists+linux-pci@lfdr.de>; Thu, 23 Feb 2023 10:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbjBWJgk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Feb 2023 04:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233424AbjBWJgj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Feb 2023 04:36:39 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B119F515D7
        for <linux-pci@vger.kernel.org>; Thu, 23 Feb 2023 01:36:15 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id p8so10256909wrt.12
        for <linux-pci@vger.kernel.org>; Thu, 23 Feb 2023 01:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8+c3O+JKb+ygyDEtjXcAkTDQCL5lhMHIdEFdwOPkUzM=;
        b=GJAvOM7vT6y+dpNnUBSXR8Ebltv2bQljUUOjeCVhH+BHrudJbK6t3LP+tnTTJyVur7
         S/W8Iuh4ID/TlBggamOu7aFWsNu2AMd3kK5xLMgYsbr9G/hGMCNh4kAF0htl8p4FtDpc
         kliFUM4kqlARQ+W5qLa649a6zqvToo665hF/E0ErCtfI1V1WSv4OnuuHaxvm/RvVF3BC
         o4gk8RuiYnYyTs4yd0Z8n1BOs2onAiZBqpj3LT1HBFN1vIQOZARwLGmGLToZajHrkgPQ
         B5Kl01grWp/Y1cWhljIkZMdMPpUuABL61kL/hYXukh5zJN6H7NQnzHQ20N8QpSykhAqT
         L5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8+c3O+JKb+ygyDEtjXcAkTDQCL5lhMHIdEFdwOPkUzM=;
        b=rpc5Ct+bek1WG9VG4aseNw6lXddumkrT+dM5/Y/W7JJeKMqM/VxTfOeV5ipnEBTvF+
         TVNx6XEjZuT1I8uR/KqwrJzNOJTqRpRUGT0A81lLELBHR1aKAxuuQ1jzM/cg+G06TSEN
         io1KctuglHqPwjIRozzz/rit/tHR3jFkxitZJ9Hvg7/fNs/s4nBktECPqx+9cgXXsOYJ
         3pX2YZ7RTdoiNMLHqmORMtghnXe5XNg/uVt636O6sEoNUyr1rWm9P7imxtAjtGlheKq9
         TMjIu8PRN7i30XadhI7jlsqnxVin93Rp39OWN9GGwSq9pR3DTVfWNDNjqxlNU/oV7lxt
         mBQw==
X-Gm-Message-State: AO0yUKVcMI6hsBBc6t3MzQyKyiiiC3uLtAzuOHYFNnT15fA0WBgP+8jK
        Mhi+veLdYSpdrYzWZhWvqk5vXg==
X-Google-Smtp-Source: AK7set8QN3z8iyphsQHHkmevnZI5JlReWkBkgbZdtR+/J74U1LMkYhlHUOO2fryJAU1hiUfczkXfHA==
X-Received: by 2002:a5d:6a04:0:b0:2c3:db98:3e87 with SMTP id m4-20020a5d6a04000000b002c3db983e87mr11353074wru.20.1677144965983;
        Thu, 23 Feb 2023 01:36:05 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n10-20020a05600c500a00b003ea57808179sm1577581wmr.38.2023.02.23.01.36.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 01:36:05 -0800 (PST)
Message-ID: <4e2ea3e3-8a5d-0e9f-f16a-acedacc99b95@linaro.org>
Date:   Thu, 23 Feb 2023 10:36:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 01/11] dt-bindings: PCI: qcom: Update maintainers entry
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org
Cc:     konrad.dybcio@linaro.org, bhelgaas@google.com, kishon@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230222153251.254492-1-manivannan.sadhasivam@linaro.org>
 <20230222153251.254492-2-manivannan.sadhasivam@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230222153251.254492-2-manivannan.sadhasivam@linaro.org>
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
> Stan is no longer working with MMSOL and expressed his interest to not
> continue maintaining Qcom PCIe driver. Since I took over the driver
> maintainership, I'm stepping in to maintain the binding also.
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

