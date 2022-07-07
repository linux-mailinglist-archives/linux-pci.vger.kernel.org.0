Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC51A56A504
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jul 2022 16:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235552AbiGGOEK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jul 2022 10:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235580AbiGGOEB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2022 10:04:01 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F892D1FF
        for <linux-pci@vger.kernel.org>; Thu,  7 Jul 2022 07:03:52 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id q7so23398lji.12
        for <linux-pci@vger.kernel.org>; Thu, 07 Jul 2022 07:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WyY1Q+emlyPRZsoTVj1hTX+3CfEO5aLP6G83YP6zFA4=;
        b=jmreL66khRs++ryL8bpgWYJ0T8jScNwki9hp4wFn5ziM2X/T4JmS+hi5s60cKknV25
         T8TFUE3pvxKQK7asjhVefKFUnhIWZrRLIKpZ1ofbsY7ExqUsw3gJ9OfsL5Y198cyVOoX
         rnH2SE8kwvuKl1Sn18XWA9bxVIcm7AIsdr74OGIHWX4a97Am/DNZ9UAhGZ9Gi3J7D2zQ
         At3RCYtwtg8r0/mdw5RdE1w5x602qbBOEsWgqFjACaT3vLzXrbNPnyzYRbpu5Y6Q1l2N
         xjxuJR1B6lrREnPmYlo43NXpDT4h2NL6XNoLk+t0vcCUl8bfl16VcDyfXI/LlTPFgoDu
         gYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WyY1Q+emlyPRZsoTVj1hTX+3CfEO5aLP6G83YP6zFA4=;
        b=mEofjimorh3oJmAovCkplScTk+ocvkg/qDoc70i3vwIxZcAqQHh5s2h4qucNyJKoyZ
         059og1cK7OtkDxIRA+92S0YLjWfxeXgfCT3iHY64H06wiXDPLM5ezzQTrdAAqB4YEJlF
         hggkMcHKWIXQXPLhuuG58XFrWwTkL8K45+BBjxfBYvT373UXY0SEkpoxorDcUSjhC/Ue
         sstJ6lEqEAQBquqSXjyoeA8r8zLNqSFfVoutqOaLAc8SdebPeC3idEo1TByFFh/9g/HW
         e7hjWXXHHfeDDPTr3f6NIMQ8kLgwRAWxdiQ8TrZTxw+uV7Mqak0EYDiMwNzIjDEvEWW0
         a5DQ==
X-Gm-Message-State: AJIora/l0ds/YFBkWuzI33xKcttR3HrgBw8Wzv1+2DozjWgsrHbHSKfl
        tLWcmm1ghqi+ofHyxkLHNlV+6A==
X-Google-Smtp-Source: AGRyM1sQz6Me6qk8+w1E80fUIRqSI3EH65bTOkeMV4IBHIXq23MVKDL3VjLirivWZDsLaTpi2TbUog==
X-Received: by 2002:a2e:b94e:0:b0:25b:b99f:4f58 with SMTP id 14-20020a2eb94e000000b0025bb99f4f58mr25741864ljs.263.1657202630398;
        Thu, 07 Jul 2022 07:03:50 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id i21-20020a2ea235000000b0025d519d0609sm273708ljm.44.2022.07.07.07.03.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 07:03:49 -0700 (PDT)
Message-ID: <e00b1317-9c2e-0b11-8c0b-1fa4a17e4761@linaro.org>
Date:   Thu, 7 Jul 2022 17:03:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v11 0/5] PCI: qcom: Rework pipe_clk/pipe_clk_src handling
Content-Language: en-GB
To:     Bjorn Helgaas <helgaas@kernel.org>
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
        linux-pci@vger.kernel.org, Johan Hovold <johan@kernel.org>
References: <20220616182120.GA1099986@bhelgaas>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220616182120.GA1099986@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 16/06/2022 21:21, Bjorn Helgaas wrote:
> On Wed, Jun 08, 2022 at 01:52:33PM +0300, Dmitry Baryshkov wrote:
>> PCIe pipe clk (and some other clocks) must be parked to the "safe"
>> source (bi_tcxo) when corresponding GDSC is turned off and on again.
>> Currently this is handcoded in the PCIe driver by reparenting the
>> gcc_pipe_N_clk_src clock.
>>
>> Instead of doing it manually, follow the approach used by
>> clk_rcg2_shared_ops and implement this parking in the enable() and
>> disable() clock operations for respective pipe clocks.
>>
>> Changes since v10:
>>   - Added linux/bitfield.h include (lkp)
>>   - Split fw_name/name lines in the gcc-sm8450.c (Johan)
>>
>> Changes since v9:
>>   - Respin fixing Tested-by tags, no code changes
>>
>> Changes since v8:
>>   - Readded .name to changed entries in gcc-sc7280 driver to restore
>>     compatibility with older DTS,
>>   - Rebased on top of linux-next, dropping reverts,
>>   - Verified to include all R-b tags (excuse me, Johan, I missed them
>>     in the previous iteration).
>>
>> Changes since v7:
>>   - Brought back the struct clk_regmap_phy_mux (Johan)
>>   - Fixed includes (Stephen)
>>   - Dropped CLK_SET_RATE_PARENT flags from changed pipe clocks, they are
>>     not set in the current code and they are useless as the PHY's clock
>>     has fixed rate.
>>
>> Changes since v6:
>>   - Switched the ops to use GENMASK/FIELD_GET/FIELD_PUT (Stephen),
>>   - As all pipe/symbol clock source clocks have the same register (and
>>     parents) layout, hardcode all the values. If the need arises, this
>>     can be changed later (Stephen),
>>   - Fixed commit messages and comments (suggested by Johan),
>>   - Added revert for the clk_regmap_mux_safe that have been already
>>     picked up by Bjorn.
>>
>> Changes since v5:
>>   - Rename the clock to clk-regmap-phy-mux and the enable/disable values
>>     to phy_src_val and ref_src_val respectively (as recommended by
>>     Johan).
>>
>> Changes since v4:
>>   - Renamed the clock to clk-regmap-pipe-src,
>>   - Added mention of PCIe2 PHY to the commit message,
>>   - Expanded commit messages to mention additional pipe clock details.
>>
>> Changes since v3:
>>   - Replaced the clock multiplexer implementation with branch-like clock.
>>
>> Changes since v2:
>>   - Added is_enabled() callback
>>   - Added default parent to the pipe clock configuration
>>
>> Changes since v1:
>>   - Rebased on top of [1].
>>   - Removed erroneous Fixes tag from the patch 4.
>>
>> Changes since RFC:
>>   - Rework clk-regmap-mux fields. Specify safe parent as P_* value rather
>>     than specifying the register value directly
>>   - Expand commit message to the first patch to specially mention that
>>     it is required only on newer generations of Qualcomm chipsets.
>>
>> Dmitry Baryshkov (5):
>>    clk: qcom: regmap: add PHY clock source implementation
>>    clk: qcom: gcc-sm8450: use new clk_regmap_phy_mux_ops for PCIe pipe
>>      clocks
>>    clk: qcom: gcc-sc7280: use new clk_regmap_phy_mux_ops for PCIe pipe
>>      clocks
>>    PCI: qcom: Remove unnecessary pipe_clk handling
>>    PCI: qcom: Drop manual pipe_clk_src handling
>>
>>
>> Dmitry Baryshkov (5):
>>    clk: qcom: regmap: add PHY clock source implementation
>>    clk: qcom: gcc-sm8450: use new clk_regmap_phy_mux_ops for PCIe pipe
>>      clocks
>>    clk: qcom: gcc-sc7280: use new clk_regmap_phy_mux_ops for PCIe pipe
>>      clocks
>>    PCI: qcom: Remove unnecessary pipe_clk handling
>>    PCI: qcom: Drop manual pipe_clk_src handling
>>
>>   drivers/clk/qcom/Makefile              |  1 +
>>   drivers/clk/qcom/clk-regmap-phy-mux.c  | 62 ++++++++++++++++++++
>>   drivers/clk/qcom/clk-regmap-phy-mux.h  | 33 +++++++++++
>>   drivers/clk/qcom/gcc-sc7280.c          | 49 +++++-----------
>>   drivers/clk/qcom/gcc-sm8450.c          | 49 +++++-----------
>>   drivers/pci/controller/dwc/pcie-qcom.c | 81 +-------------------------
>>   6 files changed, 127 insertions(+), 148 deletions(-)
>>   create mode 100644 drivers/clk/qcom/clk-regmap-phy-mux.c
>>   create mode 100644 drivers/clk/qcom/clk-regmap-phy-mux.h
> 
> I applied this to pci/ctrl/qcom for v5.20, thanks!
> 
> Clock folks (Bjorn A, Andy, Michael, Stephen), I assume you're OK with
> these being merged via the PCI tree.  Let me know if you prefer
> anything different.

I noticed that this patchset is not a part of linux-next. Is it still 
pending to be merged in 5.20?

-- 
With best wishes
Dmitry
