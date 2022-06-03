Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA0553C70A
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jun 2022 10:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242795AbiFCImx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Jun 2022 04:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242753AbiFCImv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Jun 2022 04:42:51 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0FF36E0D
        for <linux-pci@vger.kernel.org>; Fri,  3 Jun 2022 01:42:49 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id be31so11532129lfb.10
        for <linux-pci@vger.kernel.org>; Fri, 03 Jun 2022 01:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dg2zft/FFULtW76VzDqDlP6xnV9rQ7/mV7tzPKJr+Vo=;
        b=eSVwN8k4LE7W2/xHFDPPSlx0XmW+cOq/WlT161sSyvReiwolMR5gBO2Fo8UwBcF6St
         /WWRsnIQkPMPZT/g/eQif1sSuQkJyXKt05DPmCbIgMEn+r0+QpY8St2q3hJD5HRycfYA
         dsdrX1W82i4cRGR1soGxAtbf6eltmj6pN63uCK4brEUsTBxk4UiVxI2arsDehmGUGMIG
         kwF+HfBVvpRmZX5r8/t9sZssPrCb/f0jF2lxDXg1CLDyzUSzbrsS1ZaKMBcG3IWLtu02
         20zewvY5xws/vhXXYdpqvJAR6U2DhmuA1iX6sIfdZH/zQTC+uIZnEu83s78dt1z85EJj
         vUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dg2zft/FFULtW76VzDqDlP6xnV9rQ7/mV7tzPKJr+Vo=;
        b=SkL1HHu46RCiv2eDqi4nqN9+sGdF52QlatBrX1y0LAKIKaxE1KIFIcTJJXT+dAe5bo
         0eeYC2iwFHcE9/WvKa8XwrS9Cy3pD5zHzdyi5frqe9uMR8HLY/dh96VB9H0F9xEOUv4v
         19U/9F8oRqoUIvUjbCVxLiAZ4tlzPfP8Uys/nrnHFbVr20J+6LG9z11SyRPOvU2o7XCw
         VJ2LuNF2adzOHjTXch1YSQ803X8trwbPq4mfCg+xBmr25Z3jsZ2SlDV2PKiY4n9gacyH
         wcnnMzLpWSns59nJOiY3Tuz4eOlAzIMu2fEeLJFdmsuuMwN6BoA+CoaqyAsExLHdCKIX
         c/xw==
X-Gm-Message-State: AOAM531AnoIHIWG6jdqLewsIhFKRnl0HZEpXJocJ8yGRm4D5fdtjZ4+P
        NGnZpd/J/frKEHRgsUtjb97shA==
X-Google-Smtp-Source: ABdhPJwwD/c/H7RXiX6UvnT4K1IbT8YlLJNcZpnPdj4fU6oyquKcpHEOGJ6gGP8leFbGBCcYuNIa+w==
X-Received: by 2002:a19:a411:0:b0:478:f29b:e30e with SMTP id q17-20020a19a411000000b00478f29be30emr6154127lfc.334.1654245768345;
        Fri, 03 Jun 2022 01:42:48 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id e25-20020ac25cb9000000b004791b687235sm203420lfq.119.2022.06.03.01.42.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jun 2022 01:42:47 -0700 (PDT)
Message-ID: <bec5ec2a-b749-21ba-e406-fb5799a3df57@linaro.org>
Date:   Fri, 3 Jun 2022 11:42:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v9 2/5] clk: qcom: gcc-sm8450: use new
 clk_regmap_phy_mux_ops for PCIe pipe clocks
Content-Language: en-GB
To:     Johan Hovold <johan@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20220603075908.1853011-1-dmitry.baryshkov@linaro.org>
 <20220603075908.1853011-3-dmitry.baryshkov@linaro.org>
 <YpnDkbuZO3jCbxdF@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <YpnDkbuZO3jCbxdF@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 03/06/2022 11:17, Johan Hovold wrote:
> On Fri, Jun 03, 2022 at 10:59:05AM +0300, Dmitry Baryshkov wrote:
>> Use newly defined clk_regmap_phy_mux_ops for PCIe pipe clocks to let
>> the clock framework automatically park the clock when the clock is
>> switched off and restore the parent when the clock is switched on.
>>
>> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
>> Tested-by: Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> 
> The Tested-by tags you added are malformed throughout the series, please
> review and respin (there should be two separate tags for R and T).

Hmm, I wonder how did that happen. Probably they came from your message 
and I didn't notice that they were broken.

> 
> You can drop the Tested-by tags from the two clock driver since I really
> tested the corresponding changes on a different platform (my fault, I
> replied to the cover in the last round).
> 
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry
