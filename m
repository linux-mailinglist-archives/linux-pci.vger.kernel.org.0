Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85EE53C75F
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jun 2022 11:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242996AbiFCJVh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Jun 2022 05:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242988AbiFCJVg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Jun 2022 05:21:36 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC6E3A183
        for <linux-pci@vger.kernel.org>; Fri,  3 Jun 2022 02:21:34 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id a15so11673964lfb.9
        for <linux-pci@vger.kernel.org>; Fri, 03 Jun 2022 02:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=znBdlMbfX1GAYndIxEL6L68ey32IXbsATO8ijdQ1BKE=;
        b=QWKb0MgLpF7c9f4d0itaacfFynpTJfZfeuQuQWXxQqzmhuJOuAMJohhYx1adJuNpqP
         tazaCix09UILs6vpCcwRCB+4aEezVw1omzI4U/a81sga1U3DvX0ZmsaBEe31Xt3YLGgB
         7sU9OHqclSw8e1SVMXsSd8C07hzKO1qKlCHZ1peJ41DXE6B8HhKVCurIcIziqSYjGVSC
         RPYlktOWTUgQCDg6qjmMOI9Tq5puknAuu/q1UprW2WrKwtc8IIeNl775zcff2wUMYOXq
         nDSwSB2sMCVnM1s7LTnqLzUKq/vJ03+s3D7VfUAUQWzUOqO4+oWyhHAI0NRPcEvRY//j
         z3ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=znBdlMbfX1GAYndIxEL6L68ey32IXbsATO8ijdQ1BKE=;
        b=yg4/UV+gkYj4gRqHu+8Xil+NKUH82f3Pq5QUJIckb29GEs48XtkclMpN7HhlWEoA/M
         Vm+shKj/Enn1Qx5MDCrtmVcbufqaAQcwSakTFJTDwSvtso7dAIv4lrN5E72esvmLbxgr
         pkvYzPirjXo89rqtbO2Pm+//YylJ36+R2kTxWMiiTKInW1J3B+WcecfRu9CRn00dZJEn
         0Ff+c/87ETfVg/0ne+nfzo1cKjt2ppWnUtGZtAEAlIP76RswgpGKFs5Z0f5hj1DVt784
         Vmp1EAYhynM7gjqM2TMbGQU+POm43ipCDk9KSdDShPQqCUmFZzapeC0WUa9CXDKJVqLv
         656g==
X-Gm-Message-State: AOAM5305ovmsORhnt1C3sRhnq23HYK0QtGVNTFEIeAUNOCBP5VHpkbW4
        XfmJjEDWjGWmhcQzlBd4Qg6J8g==
X-Google-Smtp-Source: ABdhPJxlJqvV5ZadKNB3+UERyT6y2fMzECASgz6J9AcjzN9d5fOeoogHBTEgC6v3SzhXgiO2OOpUJw==
X-Received: by 2002:a05:6512:3b28:b0:478:8355:2c88 with SMTP id f40-20020a0565123b2800b0047883552c88mr37602534lfv.395.1654248092473;
        Fri, 03 Jun 2022 02:21:32 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id o20-20020ac24c54000000b0047917faa676sm353033lfk.33.2022.06.03.02.21.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jun 2022 02:21:31 -0700 (PDT)
Message-ID: <af3212f7-c068-33fe-9c00-707028349ca0@linaro.org>
Date:   Fri, 3 Jun 2022 12:21:31 +0300
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
 <bec5ec2a-b749-21ba-e406-fb5799a3df57@linaro.org>
 <YpnLQS5lvMbxpUVj@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <YpnLQS5lvMbxpUVj@hovoldconsulting.com>
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

On 03/06/2022 11:50, Johan Hovold wrote:
> On Fri, Jun 03, 2022 at 11:42:47AM +0300, Dmitry Baryshkov wrote:
>> On 03/06/2022 11:17, Johan Hovold wrote:
>>> On Fri, Jun 03, 2022 at 10:59:05AM +0300, Dmitry Baryshkov wrote:
>>>> Use newly defined clk_regmap_phy_mux_ops for PCIe pipe clocks to let
>>>> the clock framework automatically park the clock when the clock is
>>>> switched off and restore the parent when the clock is switched on.
>>>>
>>>> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
>>>> Tested-by: Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
>>>
>>> The Tested-by tags you added are malformed throughout the series, please
>>> review and respin (there should be two separate tags for R and T).
>>
>> Hmm, I wonder how did that happen. Probably they came from your message
>> and I didn't notice that they were broken.
> 
> You're right, I messed up when I replied to the v7 cover letter. Sorry
> about that and thanks for fixing it up.

No problem. Thanks a lot for your continuous review and testing!

-- 
With best wishes
Dmitry
