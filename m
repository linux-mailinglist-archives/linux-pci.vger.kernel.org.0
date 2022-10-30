Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E467612AFB
	for <lists+linux-pci@lfdr.de>; Sun, 30 Oct 2022 15:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbiJ3O0U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 30 Oct 2022 10:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJ3O0S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 30 Oct 2022 10:26:18 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96A9B7CD
        for <linux-pci@vger.kernel.org>; Sun, 30 Oct 2022 07:26:17 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id x21so12570669ljg.10
        for <linux-pci@vger.kernel.org>; Sun, 30 Oct 2022 07:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=km6wTK9gxRICmw3iQSSF3JcpeR0eL80m2+vYs16O/UQ=;
        b=V1zyLgdo5YBUiVFFhEx4zgY3FiUrLOcOpn+wGpxtoWgS4fkYBeYa/p05+nKo9VEEBp
         v4LQhI0o8sv8o4XYdCIuPTzMr14KfVRf4SNtsIAEyNg9Jd0wjPzVCFWYY3Kk2HVO6nSw
         cgIS6tSmxGWiuXkZTTkLHlpEAVeUmlemYIHu5oP0nunhiPvWih8O43ZG8f2w2hwPd6kX
         1wHpdHkeMTCZKXjZuxf3vvAnzbn4LDUKtzn1CHFBU1ZiH7n5kMww/7khN+EDtD9P9IHq
         oFm1EWAQdBcV7UvNrfK0aShRqJ4sMGeXt1AuN5nnVMI9xfPqLeXrt9cY3It1kqxEhNt0
         bBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=km6wTK9gxRICmw3iQSSF3JcpeR0eL80m2+vYs16O/UQ=;
        b=xEWd62qaLNXNrhK2fTBPhlFqWTqioaiB/fihjNCqkcY8LvCKEmLmXW8CzPrjaHlhWT
         JE5tpxdCCUosffQb+z2g09Qq0QI5e8yRdA0fQCzYWLGa/mNa6Tqd+69xFMJtPTESlhTw
         ISJ6cDbinL2XORMxi0n5IBnCiS69YJeK73a0MgVLSmMxSVaRpEATAwmY1HDqgZgOhSu2
         Bk6hmklX/Fwj+de3is414LUcGkSXjme6Qjjn6UzN4+R75tlVurAXH6Ns22NwMtJgL0lf
         jBGmecuCruweZqOMEmjPFlmIPLM4U5vhznrRGqY3XCFctYS8p/Z9ucheP7qwN9tzvUt1
         9Vyw==
X-Gm-Message-State: ACrzQf1c26HaWY9+09ml1C2lQhZhLFHuuDl3HuqxNkwYLYgFa2xnxnAI
        tjBoZtGVtFN4QCS6/u9PCS2Dsg==
X-Google-Smtp-Source: AMsMyM5cnvx25mpAcD4KhlBDyl+lCQToilLxqqHXKf5AeiIp0KAacgeT10PKwy3Nv+iNARZthnMX3g==
X-Received: by 2002:a05:651c:1038:b0:277:5452:60f6 with SMTP id w24-20020a05651c103800b00277545260f6mr584140ljm.21.1667139975982;
        Sun, 30 Oct 2022 07:26:15 -0700 (PDT)
Received: from [10.27.10.248] ([195.165.23.90])
        by smtp.gmail.com with ESMTPSA id c27-20020a056512239b00b0049487818dd9sm818086lfv.60.2022.10.30.07.26.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Oct 2022 07:26:15 -0700 (PDT)
Message-ID: <ffabb95a-8994-a695-255a-b19c25b9fbfa@linaro.org>
Date:   Sun, 30 Oct 2022 17:26:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v1 0/7] PCI/phy: Add support for PCI on sm8350 platform
Content-Language: en-GB
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org
References: <20221030122301.GA1022001@bhelgaas>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221030122301.GA1022001@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 30/10/2022 15:23, Bjorn Helgaas wrote:
> On Sun, Oct 30, 2022 at 12:13:05AM +0300, Dmitry Baryshkov wrote:
>> SM8350 is one of the recent Qualcomm platforms which lacks PCIe support.
> 
> I guess the "platform" (the hardware) has PCIe, but the current driver
> doesn't support it?

Yes.

> 
>> Use sm8450 PHY tables to add support for the PCIe hosts on Qualcomm SM8350 platform.
>>
>> Note: the PCIe0 table is based on the v2.1 tables, so it might work
>> incorrectly on earlier platforms.
> 
> I'm not sure what this means in terms of applying this series.  It
> sounds like "this series might break earlier platforms".  That
> wouldn't be good, so I assume it's more subtle than that.
> 
> I guess "v2.1 tables" refers to "PHY config tables"?  "PCIe0" appears
> mostly in [6/7] as a 1-lane Gen3 host.  "v2.1" and "v2_1" don't appear
> at all.  I can't quite figure out what symbols in the patches these
> refer to.

Oh, excuse me. There were several revisions of sm8350 SoC (1.0, 2.0, 
2.1), with slight differences in the PHY programming. Usually we support 
only the latest version, which is the version going into 
mass-production. I'll expand the description in the v2.

-- 
With best wishes
Dmitry

