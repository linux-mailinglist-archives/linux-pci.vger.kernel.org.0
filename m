Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F25652D1AD
	for <lists+linux-pci@lfdr.de>; Thu, 19 May 2022 13:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237501AbiESLoL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 May 2022 07:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237507AbiESLoI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 May 2022 07:44:08 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A7BB41D2
        for <linux-pci@vger.kernel.org>; Thu, 19 May 2022 04:44:06 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id b32so5927250ljf.1
        for <linux-pci@vger.kernel.org>; Thu, 19 May 2022 04:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IYmL6dQH/QpkV/dg7FbG8d6+fzH8Ngy5GLGM2DwQbvY=;
        b=nCf/woJ3G3cja5kfD1C2aOtthsXTRdetx2BypJr0AdoP1+EOvoeT9iigd7dc30Aq1+
         VGss7SiBjlFGHih+///eZBMdAeUyo+muNJOR7rxglxZ/Nela2Rh047IRK6+aUe/cPsHt
         mO279Kia1cxrjFw+69JrCiHwy3U4y6D6UGeAJ8ry3pAHFEV1K0uV9+ETeCIA4jEYAyb/
         JwV4p9CFuzDLL16wkXlCSAAelj4/vlwUxmmSJWY1L5OkMI8q9qgnQI1wFDDDt3jl7YXC
         a0soUO1X8XPJL4PUo+r4aivMy57yZJuFzkcjCBtFmwEhmV4Ga2jmm/9tBEyyKCM2Ocen
         H12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IYmL6dQH/QpkV/dg7FbG8d6+fzH8Ngy5GLGM2DwQbvY=;
        b=VtiDx5mVmBo00TfH8ZjYqejxgz6MHeN8sOA756udc6OPlqP3v6x0LP667iUpImCqYd
         OKcE0uM0tpC1Zz9AHeuJs2jMK8YG6ggwPSc4D2DK/gt4SvsqK/FUYHR8GmNecmeDmQs1
         tygPK1tBpykCm44pqjYgUjjH/CdvzhvCTwMzdoygHCYtvvL/Oo5OwhDaY1lhEyt0VWeb
         OA8cgk4mlhTcCwOn/rWIFFANYX/4dz8bsBAbYAecQ88lQWw6UGF7AG45iRrVUqdQz2BP
         H6WawSpAee3c6FJ0zPPibX5maBBEXPSFaGH35LWJsVkV2bkDdsa2Khrq+VnYhfmtMSN4
         8uFA==
X-Gm-Message-State: AOAM532lOmTZyYKUS0s7OvGnTK8GR1m9LmZOnGqKgYqnMxRdM6KyQmP3
        YSUBAAhsH8x+3UukjnUcURsPTQ==
X-Google-Smtp-Source: ABdhPJyswJAQj7bSsDiRxhVta7mphaBUwYrWcW/mlylni/THFVGZEPnzja834BWmYxSnpaPDHLxvow==
X-Received: by 2002:a2e:9097:0:b0:253:c84e:e4a6 with SMTP id l23-20020a2e9097000000b00253c84ee4a6mr2369051ljg.529.1652960644667;
        Thu, 19 May 2022 04:44:04 -0700 (PDT)
Received: from ?IPV6:2001:470:dd84:abc0::8a5? ([2001:470:dd84:abc0::8a5])
        by smtp.gmail.com with ESMTPSA id n22-20020a05651203f600b00477b223ab3fsm264171lfq.167.2022.05.19.04.44.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 04:44:04 -0700 (PDT)
Message-ID: <b0742ac1-f04a-8594-0662-e4cc194c72a3@linaro.org>
Date:   Thu, 19 May 2022 14:44:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v6 2/5] clk: qcom: regmap: add PHY clock source
 implementation
Content-Language: en-GB
To:     Johan Hovold <johan@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-clk@vger.kernel.org
References: <20220513175339.2981959-1-dmitry.baryshkov@linaro.org>
 <20220513175339.2981959-3-dmitry.baryshkov@linaro.org>
 <YoShe/rWXVq78+As@hovoldconsulting.com>
 <YoSk3i00b02bRThU@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <YoSk3i00b02bRThU@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 18/05/2022 10:48, Johan Hovold wrote:
> On Wed, May 18, 2022 at 09:34:19AM +0200, Johan Hovold wrote:
>> On Fri, May 13, 2022 at 08:53:36PM +0300, Dmitry Baryshkov wrote:
> 
>>> +/*
>>> + * A special clock implementation for PHY pipe and symbols clock sources.
>>
>> s/sources/muxes/
>>
>>> + *
>>> + * If the clock is running off the from-PHY source, report it as enabled.
>>> + * Report it as disabled otherwise (if it uses reference source).
>>> + *
>>> + * This way the PHY will disable the pipe clock before turning off the GDSC,
>>
>> s|pipe|pipe/symbol|
>>
>>> + * which in turn would lead to disabling corresponding pipe_clk_src (and thus
>>> + * it being parked to a safe, reference clock source). And vice versa, after
>>> + * enabling the GDSC the PHY will enable the pipe clock, which would cause
>>
>> s|pipe|pipe/symbol|
>>
>>> + * pipe_clk_src to be switched from a safe source to the working one.
>>> + */
>>
>> You're still referring to the old pipe_clk_src name in two places in
>> this comment.
> 
> Just remembered that the PCIe/USB mux is also referred to as
> pipe_clk_src and that your not referring to the clock implementation.
> 
> I guess the comment works as-is even if the example refers to just
> USB/PCIe.

I will add a phrase mentioning UFS symbol clocks.

> 
>> Should this be reflected in Subject as well (e.g. "PHY mux
>> implementation")?
> 
> Johan


-- 
With best wishes
Dmitry
