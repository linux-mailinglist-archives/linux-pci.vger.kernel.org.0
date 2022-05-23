Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D279C531A71
	for <lists+linux-pci@lfdr.de>; Mon, 23 May 2022 22:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242924AbiEWSUv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 May 2022 14:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243923AbiEWSSq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 May 2022 14:18:46 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8B4B82D9
        for <linux-pci@vger.kernel.org>; Mon, 23 May 2022 10:57:30 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id w14so26842075lfl.13
        for <linux-pci@vger.kernel.org>; Mon, 23 May 2022 10:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3JUxPxSVnYumG4wMpN+SiUT7prCdQ8x6bZcRTYUwMTw=;
        b=tT4JXu3U2N5URrBf7XXpDgcDRX6QwnwnGsM+FJYMVrugAn/0ck50LC3Ck7f2WUG+b3
         UdAuio8E4dbFsYHRzMIGnxcdwMDc3zPMNIqIFp4vmTKKJcCdS2XelNJiyduKfqKFOtey
         OdifCeoBGIWr1JVXay928xA6/rHPdCXVpIfDdO6bN2eMsw8zUlQ5bikeBjTAemuM47z7
         rINIIjiw2cqBLXkSjwotSBhrVlCQ6fYlbNAQZolbb2xyi34eioyAjEAJ2vHfWeBjToeq
         NGN00Ps+8W6qR/f7S6Fj3yMemCKVr5XWJeDWzBLex7aXwm1zQkMWFnmWHnyEuOHuDMXt
         zf+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3JUxPxSVnYumG4wMpN+SiUT7prCdQ8x6bZcRTYUwMTw=;
        b=0+NWDcW0rP3tngNnNtHzs+KOJzYW6FMyW1pxs5ov6mG8MYa8DuDy7IiJCHSEZscoIh
         qCe/04asWnLFKeBegPzmvSyjByqJBzgC5/PkyE4TcjRgm7oaG0eFugPBQQgDCCu1rf5I
         YuBuUxCQ5jOH9kY/e6rFH/BLIy/xzmX1lSmlWv5lSo4U9+8nYrWtMqkrcdFDuttnGbkM
         NdThlYTaGXVKT+SaPaoWsejoqE7Nw7pGdq6YxreUdagkmAkvBWwWgR0AX2QmkR7NEACf
         8jmBk+2gtamR247gH9IK+02+B2IWFOoTD01ezqh2E7t0a9/l5BwkCiTp6g1lii3SVtur
         z74A==
X-Gm-Message-State: AOAM530xQMtHxtCUuW3YCQg4PBMmyvgoPCAmExYewnK51huAVfsU+ysK
        XFen6sytxEhA3vOUIF05xRTSFw==
X-Google-Smtp-Source: ABdhPJyb1n/Iwdio+i6AZEAt1gAFenNdwifbYFK0I53gke8ob0YjzFXoB+g2ameOvrxDPWTp6quhOA==
X-Received: by 2002:a05:6512:1188:b0:473:a4b3:8479 with SMTP id g8-20020a056512118800b00473a4b38479mr17300845lfr.247.1653328575928;
        Mon, 23 May 2022 10:56:15 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id j14-20020ac2454e000000b00477cab3374asm1982977lfm.303.2022.05.23.10.56.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 10:56:14 -0700 (PDT)
Message-ID: <2270763e-78f7-9537-c6f3-31c1341f98dc@linaro.org>
Date:   Mon, 23 May 2022 20:56:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v7 0/8] PCI: qcom: Rework pipe_clk/pipe_clk_src handling
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
References: <20220521005343.1429642-1-dmitry.baryshkov@linaro.org>
 <YotL2rqv8N9+jmpV@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <YotL2rqv8N9+jmpV@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 23/05/2022 11:54, Johan Hovold wrote:
> On Sat, May 21, 2022 at 03:53:35AM +0300, Dmitry Baryshkov wrote:
>> PCIe pipe clk (and some other clocks) must be parked to the "safe"
>> source (bi_tcxo) when corresponding GDSC is turned off and on again.
>> Currently this is handcoded in the PCIe driver by reparenting the
>> gcc_pipe_N_clk_src clock.
>>
>> Instead of doing it manually, follow the approach used by
>> clk_rcg2_shared_ops and implement this parking in the enable() and
>> disable() clock operations for respective pipe clocks.
>>
>> Changes since v7:
>>   - Brought back the struct clk_regmap_phy_mux (Johan)
>>   - Fixed includes (Stephen)
> 
> So this is v8, but Subject still reads v7.
> 
> It looks like you also dropped the CLK_SET_RATE_PARENT flags in this
> version.

Yes. It was not there originally. And I don't think we really set the 
rate for the pipe clock (and support setting it for the phy's pipe output).

> 
> For the series:
> 
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> Tested-by: Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> 
> Johan


-- 
With best wishes
Dmitry
