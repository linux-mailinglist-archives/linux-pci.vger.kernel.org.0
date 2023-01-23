Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4AD56782E5
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jan 2023 18:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbjAWRUQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Jan 2023 12:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233586AbjAWRUP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Jan 2023 12:20:15 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265926584
        for <linux-pci@vger.kernel.org>; Mon, 23 Jan 2023 09:20:13 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id fl11-20020a05600c0b8b00b003daf72fc844so11157416wmb.0
        for <linux-pci@vger.kernel.org>; Mon, 23 Jan 2023 09:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V0msOilVBY3pjgMACo3Te8zEGERavlW1uoU0JEDp1xM=;
        b=pah5q2Hj/GvzfjsYuW6mAtlCdeIXaWMAxaTQUuLqDBUXpQT10XeRsLwX0d52wTpeBO
         WvgF9ZkJm7ER3iakvA+Me3DBjferPoGSnV3hT11DUHH96u79pVd1PqT1tiTpYHmU/ytp
         aRDojCASz9NqsQMDmFUOd8KvhXN7WfxKvVEdYm11sWvWYoi3vyHT0vpqEZN4K7ShrpyA
         0Ls93gY3yE7/xvMU49fDBX0WCiISaT1QCsNOI2cVFrq5Ticm/FTAeqjl9CEXnmxaf/34
         Sqer/ZDtQTdIdZ/sJ1nkoBKl952d1+xsNMc+FvvbLmF33oRTKPY5Jz3vMOhDCYIJzz8T
         NUpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V0msOilVBY3pjgMACo3Te8zEGERavlW1uoU0JEDp1xM=;
        b=0+qWciqcmNSIDwrU8LCPDS/U6iWYqVYUgcqxR1lV1LKGIOTDF4Cy4I2hZ7LvnEerDi
         o1DgjNRRhz+mXDKJl5maec+p9TyQsm9wHY1/PQxtNI7HAnBc3jsO2IDOzLUT5v0i3yMN
         3mcLC+UJj1R+FaEg5MX67E038ZZ4xdp2lR3DDPA0/bxdJ0Fatu4ThYlzibdWixrjwjb5
         Q7NydraEaf4Iqcql+JmQKZ9uWx1nD/gn3dBIUv5nvPza+jnAgl9dlTJNJA2/i/GDDqiw
         gt60332foa0SVJnFlGVHMGMRPr4rNDetdfES4JMCZFHarUSaFCgv51Jc8ve8U2uJW7Mr
         JfUA==
X-Gm-Message-State: AFqh2kqraNb25wM4wRVsdDb8G5WuJyIGG4sOuZ9d1YlqJUdViKpY9DfA
        9cyGE0F/uZSqCwnnsIzodz94Tw==
X-Google-Smtp-Source: AMrXdXsOd0W6F4AyRHz94PTRyrytWVwh2ZPNKPOiNOKdtIRejMRkoAOE9QGRdRKQ3WxJBLGOkq0Fpw==
X-Received: by 2002:a05:600c:35d4:b0:3db:3694:b93c with SMTP id r20-20020a05600c35d400b003db3694b93cmr11899304wmq.15.1674494411786;
        Mon, 23 Jan 2023 09:20:11 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c154e00b003daff80f16esm15530766wmg.27.2023.01.23.09.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 09:20:11 -0800 (PST)
Message-ID: <bfe19712-5801-573b-220e-c96494f11393@linaro.org>
Date:   Mon, 23 Jan 2023 18:20:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: qcom: Add SM8550 compatible
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20230119112453.3393911-1-abel.vesa@linaro.org>
 <7befa113-c45a-93d0-2696-17bbf62af711@linaro.org>
 <Y864lFLEQyCwZLef@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y864lFLEQyCwZLef@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 23/01/2023 17:40, Abel Vesa wrote:
> 
>>
>>> +        resets:
>>> +          minItems: 1
>>
>> Why second reset is optional?
> 
> link_down reset is needed only by g4x2 pcie, AFAICT.

OK

Best regards,
Krzysztof

