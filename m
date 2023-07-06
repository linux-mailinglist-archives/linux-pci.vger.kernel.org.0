Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F3A749B7A
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jul 2023 14:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbjGFMM7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jul 2023 08:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjGFMM5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jul 2023 08:12:57 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA441BC2
        for <linux-pci@vger.kernel.org>; Thu,  6 Jul 2023 05:12:55 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fb9ae4cef6so840269e87.3
        for <linux-pci@vger.kernel.org>; Thu, 06 Jul 2023 05:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688645574; x=1691237574;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eCOVUK9V8z/x1Thad53qnFqqGUkU711ApVBne/oyWeY=;
        b=sNFCebxbR41MtEhtSQUKMTqJjk7ECC7CPb3H7aCiGYe/Y+JdfxK1pDGIYQpdZF5BKQ
         X6QYtXSpFIuXmnh/9WLxf0hnHh8EtGv9sq7aQckriFm8//PtnG8niveRRA/3eMxBhYf0
         mTKKV7ZDSnnbz6dbUk+zJkJzCNAZkiHzQvT0xKHm6z4fSDs7W0vvS7YPb2udwUfmQGJW
         7x190SWDu8mCU6CmXbgA9clKRHBGYtZg2BwyaLH/or4eMQ3Dqigsknc2ReTnRINB31iC
         hBaqJkM7oT9eKIcJ8Ev5o9OLT8642YfXPLTneHl/aALsbroyM5kv0aZSyAZ7EZbMlojW
         k09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688645574; x=1691237574;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eCOVUK9V8z/x1Thad53qnFqqGUkU711ApVBne/oyWeY=;
        b=XgJwb8/9yHsA64Cd2TzyBCVdO8m7M+c2adeMHLPdicNB8WfpoodXGHBD12CL1skZG9
         q2RXQst8RoAlpLIUpT7I2HH7C0AuzBXiMH0TlBA0Mk5+QcGkefs4iUAWGxb0iUljbTuu
         /+GhQu3u4/lub3t9OLam/Vm5Qw0OarqNuw1ReUp0YeUrfU1Bcl8+l2C4z0X0GoMVaK1K
         1+YbSGmsfBgWnfBPoNgABYTb4vhmZrqFGntKeHxrKLl8fzW/hoE29iso3KsvJVMdfV+q
         fS4ew182AHTlfaIRbWcGBsJL3rPJoe18zuJ8NUeKdBgklrPdiiu1JLUI9IiHkjUjecti
         I6qw==
X-Gm-Message-State: ABy/qLZb6tdP1uWCW6djUzvgqLn2+8pydwIJxZF/hStDU3x6Uym0XdBz
        wF6sfODtW7jxT3tw1FzvqgjR2w==
X-Google-Smtp-Source: APBJJlGlb5wLmYtED5PMTrWEhdmg5Zph4EtRP/kgQEPFSN6KS+oRNR4Ei5uxAPG5QgIwUyis8yArfQ==
X-Received: by 2002:a05:6512:3d0d:b0:4f9:7aee:8dc5 with SMTP id d13-20020a0565123d0d00b004f97aee8dc5mr1629293lfv.19.1688645573888;
        Thu, 06 Jul 2023 05:12:53 -0700 (PDT)
Received: from [192.168.1.101] (abyj26.neoplus.adsl.tpnet.pl. [83.9.29.26])
        by smtp.gmail.com with ESMTPSA id k16-20020ac24570000000b004fb81fbeb33sm227379lfm.251.2023.07.06.05.12.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 05:12:53 -0700 (PDT)
Message-ID: <9b93bbad-1299-2afb-eac1-218cf209b293@linaro.org>
Date:   Thu, 6 Jul 2023 14:12:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 0/6] arm64: qcom: sa8775p: add support for PCIe
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     Mrinmay Sarkar <quic_msarkar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, quic_shazhuss@quicinc.com,
        quic_nitegupt@quicinc.com, quic_ramkri@quicinc.com,
        quic_nayiluri@quicinc.com,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
References: <1688545032-17748-1-git-send-email-quic_msarkar@quicinc.com>
 <20230705084606.GF11854@thinkpad>
 <a450e2e8-307d-49e9-d76d-de397b801a96@linaro.org>
 <20230706111218.GA4808@thinkpad>
 <878103c6-0dc3-164b-92ce-17ec4f87bff6@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <878103c6-0dc3-164b-92ce-17ec4f87bff6@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6.07.2023 14:09, Krzysztof Kozlowski wrote:
> On 06/07/2023 13:12, Manivannan Sadhasivam wrote:
>>>> Please note that the dts patches should come before driver patches.
>>>>
>>>
>>> Why? DTS is always independent thus usually put at the end of patchset
>>> or better separate. It is the first time I hear that DTS should be
>>> before driver.
>>>
>>
>> This is what I was suggested by Rob during my initial days and I've been
>> following this pattern since then. If that's not the case, I have no issues.
> 
> I really doubt Rob ever suggested that. He probably suggested that
> bindings must come before user, but not the DTS.
Besides, the flow in this patchset is very logical from the Linux POV

1. describe the hardware in bindings
2. implement the drivers, conforming to the description
3. describe the hardware in the device tree to ensure the (now
   existing) driver probes

Konrad
> 
> Best regards,
> Krzysztof
> 
